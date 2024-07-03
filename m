Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCD3C3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOphY-0005SI-Mh; Tue, 02 Jul 2024 22:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOphW-0005S0-NY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:26:30 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOphU-0007Ty-7h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 22:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719973588; x=1751509588;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lSxnYK5HAQ8wp7C4Mzjwt7qV7gpbAv8C2FBXUDCU5hY=;
 b=i51E30rbTfRMYgDMrFL9JN9tbTcHgjk2/d9tXOOL57qQGH28x1a1tlyH
 aD8F1yjHBm388DsmOrYqNYgZsykF5DBqa7J2OtZMSEUh0LFZyr1qyfcaX
 Pdjg5qmOUjoOhlhU6yXZc6gpEijeaZFk+9vWJ7+HJdBRGI2pJ4Dj2Qf2C
 rvMkNxvyJ86xuRCPrkeg8u1zFuM+o1xyA6ch5pYX5ri07CFWvzBmhC3eu
 U+Plv9UyOInOKIkmIXLmIbExCea+DpsSBbvQcnDBOa933jhw+V/qKOoFR
 uKgNM3E/3h3Gjlkt0T1RUYCXj0K13xKndmSvA5rvV1B8u6yuePgCSg4Hc A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="124150049"
X-IronPort-AV: E=Sophos;i="6.09,180,1716217200"; d="scan'208";a="124150049"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 11:26:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6bUxXW8N6eydPk6w6exkYJ/SFw2NvkEaDwn04fKRvBJnOwlymc6cr8o52NS4eZmFjac1Ai149MdbDytMP09cFojqvqBReLbDUd22OtGluPYKySqZNvcoFMQZF4/cGrBNiy54Hzvp4PpRtgsZt9yKWsvZDiXSbpeFRHY2v2NeQPpto2FMKHGrApKzyXi13jdP98Wcvo0Wy/YnxTv1zOZpoex5/+a6enokLjiCcbObQFFSqkGhTTGwetjOHBTxfwQj/0qWMes4sJ7QVuVRtwcw4zMObpEg74ueeKOS6KxQnBAy2lj5+HtSZVbT3vyQkYRovxPd1ePWvAra4QtWKNDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSxnYK5HAQ8wp7C4Mzjwt7qV7gpbAv8C2FBXUDCU5hY=;
 b=lILbJNZ5REww58fkh8qGr6qR9q8JynE1F7UvYiVX8uM+b532Gmw371oNjhDQw2m3HJW/Hg2V7Xa+wTbTVkLCVxKk1Q5LdzYM4dbWW76xmqwgdo5MC70oYkS5apo4d0rO9BvN4yOHix7ShXbatJ3MsZkGQWAzZIKvi1CQ47nywdxAbnP4MFOvqtAZjmyljJshrwZH6HXHGBAP9QtFDOrT/59EhLvrz49MHpUiHJEE5yP13PrJIjZve0E99vr00GTHenE7AdZ38F2sCvq8vIYhEWzMX83uJOkrrcpyW1gGPcVulpxx/15bdmJZBg1rO5znOz6nceCjr0wecIrG7W3PVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB7109.jpnprd01.prod.outlook.com (2603:1096:604:127::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 02:26:17 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 02:26:17 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v4 4/7] tests/tcg: add mechanism to run specific tests
 with plugins
Thread-Topic: [PATCH v4 4/7] tests/tcg: add mechanism to run specific tests
 with plugins
Thread-Index: AQHazLAn/kUGvRE9UECaw4ahRqeDtLHkR0FA
Date: Wed, 3 Jul 2024 02:26:16 +0000
Message-ID: <OSZPR01MB64534F19FE30F18BB525E75D8DDD2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-5-pierrick.bouvier@linaro.org>
In-Reply-To: <20240702184448.551705-5-pierrick.bouvier@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NjA1YWM1YmMtM2RkOS00NTExLTk2MDMtYTU0MzQ0NDM1?=
 =?utf-8?B?ZjMzO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTAzVDAyOjI1OjU1WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB7109:EE_
x-ms-office365-filtering-correlation-id: da5a552f-9851-4978-72a0-08dc9b07848b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?VWNjamI5Ym40b1FLdGdXamFMUWtZeGY4SVViUHNsa012bFlXTzNvOUNsM0lL?=
 =?utf-8?B?UFQ0eE9idWh4VjlHL1BCYlR5c2daNkY0WFhaSTBvdllPYThvQithYjI4bEJY?=
 =?utf-8?B?QWd4enF0YkFQTFFPdE9zSlNkVmo4QTZlZFlPdUJ6YktzdmNZNGIwb082WEpV?=
 =?utf-8?B?cjVablYwamNMMzZScEJLK1AwWEovVm9QVjAxM2E0bks3OVFZU1I5ek9DZlJj?=
 =?utf-8?B?dmNwSGlKTCtXZmJ6L3h5b1lBM0dqRXZvN3lsU1MxNGtIRjhCVDljWmxya1Nj?=
 =?utf-8?B?RmJtbUxONFZ3ZUE0a1BSdmdxVk80UExkQWk3WlpYN0RxT1RBeWV4eDQ2aU9Y?=
 =?utf-8?B?OTlhMWN4WXZ4YzdLYUN5OHNBb0xCQ1VTNG5McFNIQmtRRmVaNWlWdHJ6bGxS?=
 =?utf-8?B?ZUtFaVN3Qlo0dU9NbTRTU01MRGxpY29WWEVVREQ2cmpNYzJyZU9rZlJXUE94?=
 =?utf-8?B?bXNaQXB5OHR6Q1VvYW1NRitLd25UcXRIajQ0SzNPbFdJUGVZRHJFblRmK3E4?=
 =?utf-8?B?S1d0RVRKemFtclJWdm1aZzExVmU1aDJFZDM1bE5WaHcvbXFQdmxLa2pMeTZu?=
 =?utf-8?B?bjhUUnZKVjF3dmhMdkFxYkYyb3M0enQvam5MTWEwTzFZazhSaFljYTFGUVJi?=
 =?utf-8?B?UG4xK1hxMW92dTBreE5DNlN1cU9RRkc2Q3JVclNzTXNoVnRVMXAvSEVuRmJp?=
 =?utf-8?B?aFFURFRndnBMVVhORGhmQWpBb25YV0o1aUs0emhua1lCaVlBZnI1NE8wTmlS?=
 =?utf-8?B?R29OVThOZS9BcG5ScmlUaGRHUTNtUWhrcXBQQmVwcW5QNFhiVldweGZrWFZh?=
 =?utf-8?B?MTdsOXo0cTExQjJwQ1FIY25QaFdrRkdoMmZCZXJ4RkdLd2VtNTFhc21LYjlo?=
 =?utf-8?B?TGhNMHA4clg0VGVKZlYzQVMzZ1M4azFaeVR6Ui9yVjcrSVZnclVxUXJMNFZr?=
 =?utf-8?B?LzhEUDgvVVZadFk4S0Myc1lOZm5BcEVxcFlIa2VhSWpOS21BZExqUDBjYThQ?=
 =?utf-8?B?ZWhnOStEMDlwOEJFbG5QNGM1RmE3WnpScHFnQ2pJRHViSFhFQnRUOFR3QTcw?=
 =?utf-8?B?UjllMWNHUTRsUWNCT3lGM0M0RWExUFBLTExTU0JFTmVBdjdWbE1peVlOdDNZ?=
 =?utf-8?B?M3dub1cyZndVZ1N1cHBHdldwSVZYQ2sxWlZ1eVJTYmxYM1V1cXpuZHpnS2lF?=
 =?utf-8?B?MXJtWEJNUGtIMUh1dzA0QTNRbFFLZk9nQmc1dkNVTW1tVUtnUEVEWnNkNW1v?=
 =?utf-8?B?eFB6Vkp4dzRCZTVpUXN2QzVxZUlCb0lOL3JTa21IQjhQdFp0MGJ5U2NmaFN1?=
 =?utf-8?B?VEhKSHh2V0F5SkliSkM0RFQ2VHJSRFRDM2JIYTVucUtwbUxWN3ZRcTVQSXd5?=
 =?utf-8?B?UHVkVFd0ZjhsNmtTVDNQSU9vYnJDSXMycVQrU3Q5eFZRMERzQUV2bldZV25p?=
 =?utf-8?B?MGYzajlXbUJsR3dMV2VaMDRhK0dTRkpDOGpTMkNhL1BoL1JxYThHQmNLWk11?=
 =?utf-8?B?VmppUzVZL1d3dnJ2NC90MVVYZUk5TnNydHJoeCtGQWxUWmloZC9ZejhNY2ds?=
 =?utf-8?B?cmZIRTU5d09WN3pCMERxVERtQ1pnLytadlcwTkRUSWJraXpkWHVkeUM0cnor?=
 =?utf-8?B?NXJBcmZFTUlyaS9QOUVLai8yUjlabmJWa3dxM0gzVG5yNFg1bXByNnV1TmI0?=
 =?utf-8?B?Z3laMERhMldXYUFzdEh4OXR1ajNRWGRxeExsczZnZ3lDSjJac1lSaCtsRjlP?=
 =?utf-8?B?ZnVDczNqa1YvSzkyNnJoRzZKRjREbWFmbTBaeVpHdmhoaWNleTdxL0pya01a?=
 =?utf-8?B?L2RLaWFCa1FOay9FQjEzbUh6cEUwdW1GTTZLR3NtRVd5c1hJNmhTc0w2YXNU?=
 =?utf-8?B?UnVuWUlKY1hjajd1VWVmRXlFUjI5Z1RhT3BHSURRN2pjQlRrUGZhcjVWb3Mw?=
 =?utf-8?Q?XIcDKQiU/wo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHBqd2JwK0p2Vy8rSmdka3BqbWpoWUZyQ29FUVA0ZmpPMjFOR2xjV2tPZHNT?=
 =?utf-8?B?amxQNGErQlNKWXZlS2N2Ri9HbDVxeXp1bjBKYWRNSVVrUmdmSnpzcTJRU3M0?=
 =?utf-8?B?SDVLSUJiQW4ybkhjYVRrRFJ2cDBtVTdZZGQrNE9nbk1TVWNXSktsNUhHcnV4?=
 =?utf-8?B?N0pIcnJzU1EvNDlSY2h3bG0xS2FJRGhqTmZPK1h5NUZCNzhHTWhFRkdPTjIw?=
 =?utf-8?B?RytYOUlJNUZyZVVvMWxpV25yNmhMbWd4Vk1WeXFQQlJIQ2dlbmc4c01qdVdv?=
 =?utf-8?B?bjdGRG1URlowcjN3UUs3WUNFSkpmbXJOc3V1Y1JYZ05TNlZhamJuU3BXVnk1?=
 =?utf-8?B?eTN1UVdibUNtK2U0ZzdIdXllMCtFZzVES1R5MHpLQWcxdUdLRGp6cWxIUGZk?=
 =?utf-8?B?VjV6ZXFhUFkwZ3dmekVwNWJja1V6WUQyWkRWeXNDTEt2T1FaZTBvaURHWGV5?=
 =?utf-8?B?Mys1NDI5ODh5OEVmOUJKZm9YNGdDRXF3RXNrNVdlQ0xhcXRrVXUxbmZlVXVn?=
 =?utf-8?B?bkVWTEhNT1ljMFVodVhCaEQ1d0UvNHVMM0ZqOGFkeDBZWEtkSTJNczk1VHVV?=
 =?utf-8?B?cDZJSHVhZlFvS3VLUG5jcUx6YmpOTmpjbTROSTRZQUd6cWtKY3E3WVRlNnlv?=
 =?utf-8?B?a05oVTg5bzRjUk1TU3Jua2l0MU0rVnBGR29RdCtCS3VMWDFOSHg3NSs5L3ds?=
 =?utf-8?B?cUU4Y3g4MThtZFZacmxRb0JWdFBDTUttWVV6SHVNQ1I4TVN0T0RTMFdZUStB?=
 =?utf-8?B?aWQxN1B5U3VpYUQzRG5OZWNnMnlRZ040NkZuaVZWSEhmWkltbEMrRG9hZUg4?=
 =?utf-8?B?THV6Y1ZhV21vOEtkcnprS2lMKzA2bVN2WExlUDZFeW4zM1lEMUQ3dWo4elVZ?=
 =?utf-8?B?T1dXVUVUMGtMaWN4YXhsT2JXdjlQL21FNWJDc1cwcFlZUXNQVlh4SVlBb2Jo?=
 =?utf-8?B?bFl3aDdPZncvSW1JbmYvbUgxT3dwVGR5YXFOOTJTMUcyd1dBMGM0eTZHV05I?=
 =?utf-8?B?dUkwdmlFZTVjemxZOGVlTTFudTZPZ0RBTTlDcUluMDByWXFXQTR1enFGL2g5?=
 =?utf-8?B?bGtocVpWc0xYUXpCVHpxdEd4RzNSSnBOU1JMNGRac1FQZTJMMDIxemhQYTNP?=
 =?utf-8?B?SUJBVVFpOG1tTDk4Ym5xbFRxYS9MQ2pUOGxSSHhLUFU0THRJYVh6VUw4NWR3?=
 =?utf-8?B?Q3RKTTRQSmthK3pzaWNPTEpva3dNRlF1UzdXRlNMRjYxY3FZL0ZudEVBaFlE?=
 =?utf-8?B?blRiQkVXc05XM1JyWmFaQ2RxMzVrdWNtdStvZUsxaXVaZXdaMTV5bGttMWF3?=
 =?utf-8?B?RTZGOFUyeEdWeWc2cVJVbUdlYTE5SHprMFIvMXdtT0FHalVKdm95Z1hqT0Ny?=
 =?utf-8?B?UUIraW0wOGd3WE1sN1hta29FZW15clNJMS9OV2NhbERGNW9RaXM5dnF5elJH?=
 =?utf-8?B?VUFwc2dDbGZiU2JyZUhhYUFpMGx5RVBGSVJWSzcxZTFPRVJWczVneTdWRzll?=
 =?utf-8?B?RGxQNU9KT2ZJbDVPTVl5dE1QTHFSdk5nd3FXQ2ltZUdjQm9heXlJSlN1ZGhp?=
 =?utf-8?B?UE90VnlVb3lwbVBTNVNubk51R3pBVGw4bmhyMytmV3NZei9kOWNjbDRTRGpa?=
 =?utf-8?B?UUdVa1RtS3E0YVkyRGx4Sy9ZRzNBNXhWRTg5eWhqVmFzOTVERnJUOFJIVXBI?=
 =?utf-8?B?S0s5TmJHWTEvMlhldTY5elVOQlV4WmJtWnphK2pRblBSUVJtMldqaEVxZW1X?=
 =?utf-8?B?VlU1dmFGaldvc3NiZyt2b0pDNEJHamRLSTE3L3FGdUpDOVViZ09PM3BZMU9P?=
 =?utf-8?B?cmV0amNCdjY3SGNQZzA3ck4xeGhicWZIRW1RS05Eb2N0NjNVRW95YXFNTTIr?=
 =?utf-8?B?bUtBSTlyM3NIRDhOZkc1dDlPYTBBYmFoSEh0am1zWWxrU1dEZEs2cU45WlVV?=
 =?utf-8?B?Y05nTlRMLzVPcTdGU2l5aitiaER5bjNnRFE5Q0xIVG5OMlZZNis0c2FUcDIy?=
 =?utf-8?B?bHcwcTJndndVVFdUdmVRQ3JjWDQzeGpvOUQvQ2JDeXJGNWFRcDUrcTRTbnhV?=
 =?utf-8?B?VFlqQmp4RjlKb2hWZ0wxZ21DT3ZHbS9WREExMjA4Zm5BTDRLNUt2SDhSMEZx?=
 =?utf-8?Q?9FIJeak/uLeTNUii4MJlgT2zP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0bCi/YS6Mocpq9uLa8lKtrYuaciZesBGyzA3eNiV3m0iWW+ilDBnRrunofrghZgQWvrLv/gjDe3/JngzOmJgu1SPahMNQG8RbXbZNendKp55OJXbkq6AVE8xIQZKQKdsWCy57btNyImxXEmwGLmxlNrqn2UNsTtRK/5wMBis0Dawbs/lwRzH5Yx07KOsRAVkd0w2Tg8IzqmGAp8TuaO130INA1v09TLlz2KzcpMAfw7mxNdtiZNSCNvm/Ng+61VD0naKl38Wukm5GMs2xKqQD1LgEFhNPdc0NsESkQoWGeZaHi1n0tyA3zGg9SPaYOlgUax64HPmqQJG/ewbcZ/0e7q3vl2QWSS3X1Clhzs3h0psZodZK25XeAbkrxNrI6+3KWRpkSuYFPYEkfgGWJco0h3hShRCSZM/NATEWo/VLS9tbgMmbLFLFj7cgOiOHfF1jWW0rxppqW9swJ+wWOjcWH22VhpOPHBPyCrBSd5GQA+BAtDHCcidyXobvFUuvl4aBtq5iH+j+XwrowvH9RIlYWnDX+ZtG3lZpl/bS+hqiuJXgZhHPoBIS0ieNXYt0CUeb92AYUvVAXaKNaN+ncCXXiGShhRN/sHazQ+cYUEEolzewI8amY/LPeDwoP6VKfgW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5a552f-9851-4978-72a0-08dc9b07848b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 02:26:17.0021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eByeIAoLoYgbRiYM3GLnOCNGV1vijZuVFccP2tNlPNS9CfyficHEowiyt0t8hzP4UXSYfP/RirALroN7r8lbUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7109
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGVzdGVkLWJ5OiBYaW5ndGFvIFlhbyA8eWFveHQuZm5zdEBmdWppdHN1LmNvbT4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMreWFveHQu
Zm5zdD1mdWppdHN1LmNvbUBub25nbnUub3JnDQo+IDxxZW11LWRldmVsLWJvdW5jZXMreWFveHQu
Zm5zdD1mdWppdHN1LmNvbUBub25nbnUub3JnPiBPbiBCZWhhbGYgT2YNCj4gUGllcnJpY2sgQm91
dmllcg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMywgMjAyNCAyOjQ1IEFNDQo+IFRvOiBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJv
Lm9yZz47IE1haG1vdWQgTWFuZG91cg0KPiA8bWEubWFuZG91cnJAZ21haWwuY29tPjsgUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPjsNCj4gQWxleGFuZHJlIElv
b3NzIDxlcmRuYXhlQGNyYW5zLm9yZz47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGls
bWRAbGluYXJvLm9yZz47IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBSaWNo
YXJkIEhlbmRlcnNvbg0KPiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IEVkdWFyZG8g
SGFia29zdCA8ZWR1YXJkb0BoYWJrb3N0Lm5ldD4NCj4gU3ViamVjdDogW1BBVENIIHY0IDQvN10g
dGVzdHMvdGNnOiBhZGQgbWVjaGFuaXNtIHRvIHJ1biBzcGVjaWZpYyB0ZXN0cyB3aXRoDQo+IHBs
dWdpbnMNCj4gDQo+IE9ubHkgbXVsdGlhcmNoIHRlc3RzIGFyZSBydW4gd2l0aCBwbHVnaW5zLCBh
bmQgd2Ugd2FudCB0byBiZSBhYmxlIHRvIHJ1bg0KPiBwZXItYXJjaCB0ZXN0IHdpdGggcGx1Z2lu
cyB0b28uDQo+IA0KPiBSZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICB0ZXN0cy90Y2cvTWFrZWZpbGUu
dGFyZ2V0IHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvTWFrZWZpbGUudGFyZ2V0IGIv
dGVzdHMvdGNnL01ha2VmaWxlLnRhcmdldA0KPiBpbmRleCBmMjFiZTUwZDNiMi4uZGM1YzhiN2Ez
YjQgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQNCj4gKysrIGIvdGVz
dHMvdGNnL01ha2VmaWxlLnRhcmdldA0KPiBAQCAtMTUyLDEwICsxNTIsMTEgQEAgUExVR0lOUz0k
KHBhdHN1YnN0ICUuYywgbGliJS5zbywgJChub3RkaXIgJCh3aWxkY2FyZA0KPiAkKFBMVUdJTl9T
UkMpLyouYykpKQ0KPiAgIyBvbmx5IGV4cGFuZCBNVUxUSUFSQ0hfVEVTVFMgd2hpY2ggYXJlIGNv
bW1vbiBvbiBtb3N0IG9mIG91ciB0YXJnZXRzDQo+ICAjIHRvIGF2b2lkIGFuIGV4cG9uZW50aWFs
IGV4cGxvc2lvbiBhcyBuZXcgdGVzdHMgYXJlIGFkZGVkLiBXZSBhbHNvDQo+ICAjIGFkZCBzb21l
IHNwZWNpYWwgaGVscGVycyB0aGUgcnVuLXBsdWdpbi0gcnVsZXMgY2FuIHVzZSBiZWxvdy4NCj4g
KyMgSW4gbW9yZSwgZXh0cmEgdGVzdHMgY2FuIGJlIGFkZGVkIHVzaW5nIFBMVUdJTlNfVEVTVFMg
dmFyaWFibGUuDQo+IA0KPiAgaWZuZXEgKCQoTVVMVElBUkNIX1RFU1RTKSwpDQo+ICAkKGZvcmVh
Y2ggcCwkKFBMVUdJTlMpLCBcDQo+IC0JJChmb3JlYWNoIHQsJChNVUxUSUFSQ0hfVEVTVFMpLFwN
Cj4gKwkkKGZvcmVhY2ggdCwkKE1VTFRJQVJDSF9URVNUUykgJChQTFVHSU5TX1RFU1RTKSxcDQo+
ICAJCSQoZXZhbCBydW4tcGx1Z2luLSQodCktd2l0aC0kKHApOiAkdCAkcCkgXA0KPiAgCQkkKGV2
YWwgUlVOX1RFU1RTKz1ydW4tcGx1Z2luLSQodCktd2l0aC0kKHApKSkpDQo+ICBlbmRpZiAjIE1V
TFRJQVJDSF9URVNUUw0KPiAtLQ0KPiAyLjM5LjINCj4gDQoNCg==

