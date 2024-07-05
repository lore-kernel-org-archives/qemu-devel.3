Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA62C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 02:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPYhz-0005Du-3D; Thu, 04 Jul 2024 22:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sPYhx-0005DS-2A
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:29:57 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sPYhv-0005za-5f
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1720146594; x=1751682594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=t67PDfJKJrBor2QSyHYULxq4rrn04YgKegMdwVIy9kA=;
 b=fWholDdVcSynVbzm5hfj3Mcxg43VUHIxpEF0GU+JBnAC7ymIIbDU+Xu8
 n7w/XaWXXGxhHagX3k98lEiEcvVBcmoVdWp0uCkMPqTqXN3OUqBVXnhcR
 agKTBEnHU90YqxMiuN+J+4R9lqlXyQbqTfXtEP6iqI46CjIHoKWGGfV70
 JflaT01UN8fXYiTQllzONDrz0J4zPrr/XzIeRxbTGoSl8Jy2cOcTlL4St
 LSJJZMm9qffpGtkX0wjS9cGXvJ2fSq2xdCwMsFLYM3wlp/hHd87APNkVu
 ZPv+g1kepmcua/HIbn876VDrruPnt3dhCEAgCVshblI6mYo6OoRwVsgZ/ g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="125106064"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; d="scan'208";a="125106064"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 11:29:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NstM6JEYOYn/zP0NnpD6YYHStdpR+eeLfvzNbwfH8d5UBx9UTu4onLFBlBOg0TXotvtU8m1AkCrslJI8iIm0749vt2xUo0lzDJUnQiM+kvpnswlOwElKnULEv5/tbBNDG5sFu0use2ydqRUwEpGKTFuTutQtGiklSKbPrDTCsWU4NBHE0CB4YWlM+xyLTnOTwjiUbq7vYsB7xqOdLrW4eCTdFgB3azARxCR5VyO+QY3EN5k4EITH1wZp/k5Ah9wu6OE8dQhtEK16uCdJSsOaTmZVkisX5WH3VqfYPWeay5mZ1CDQE0OA35hV2kkSJC4SfTsjVwXbeh6HpIRUa3BZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t67PDfJKJrBor2QSyHYULxq4rrn04YgKegMdwVIy9kA=;
 b=PnM+eII2V6B536lNvi1U3iO+KpW05tntpeLhhoq1G7/Na4lNv+5Qb71oTo1iPn7A+hKvzAZEw2lffDllNA1Hxq5uAocHhsGKq/DVc0JA0Ve80yETQiaaA4p0X/ZT9m5+L2PUu0YE2d3rDiJRuUhQpbYn8BAFp38njq2n1n68IPKgu/3q3gJGOGpq4suEU0yerZWjNFPiG1WkkoQb/IygRFwUjKKQ5i6la0rlxTC0iC5BH98sRpqJNS68cXtPZVfolHb0lnkoeMjW3DiNTyDk1MJCvYR32Mz0SrpSeGZCpvajXaIUqcm7v8REpFOjnomBDzj4+4/P/xKjmqB9z00xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB8778.jpnprd01.prod.outlook.com (2603:1096:604:17f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Fri, 5 Jul
 2024 02:29:35 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 02:29:34 +0000
To: Zhao Liu <zhao1.liu@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "mst@redhat.com"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Thread-Topic: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Thread-Index: AQHazI0G7GHzvpfI4kaBYAMfHI2F4LHnVZEAgAATqQCAAAQCAA==
Date: Fri, 5 Jul 2024 02:29:34 +0000
Message-ID: <eb397f41-9a81-4b1f-a1ed-7f0b99b42b30@fujitsu.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
 <20240702143425.717452-2-Jonathan.Cameron@huawei.com>
 <5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>
 <ZodXMPef9bIROG5u@intel.com>
In-Reply-To: <ZodXMPef9bIROG5u@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB8778:EE_
x-ms-office365-filtering-correlation-id: 987c9400-5ff6-4520-b3e6-08dc9c9a4f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?MEVWQ2luNWJudVQzc1BBNTN1MnFtcEVSZVp1am5NaGZpV2F4dEpEa0xkeUhn?=
 =?utf-8?B?bGhuVzJyem9adlVlckhHQzNESUozNEhKby96WUpjbWh0R3EvWlZaWlk2UzRG?=
 =?utf-8?B?NDJySnZEYzZnMytNZU9idEYza0dseGJTbGYwc0htM1BTSGpwTnNNd3k5RHBw?=
 =?utf-8?B?MXpjdTg1WS9NTnNnTGxWZ0xHbHJCbkVyYTIyZWVFVzhCbE1LRklpT0g1VFJD?=
 =?utf-8?B?akFaYUpBMDJCUms0MUlGazRqbmNpK2xXV0IvNWNROE1hbmV6cjdYUmgycWxo?=
 =?utf-8?B?a012eWRWa2gxVXYvZDdSODBnV0QrY3BUaHBkSXUza1F3dFhDNll0dzE0RHVZ?=
 =?utf-8?B?b1ZDM3M0SzhlcDRBblVCYTRRZEYraUg0UlprVndXamhKNVR5V2NzUWVSeTcy?=
 =?utf-8?B?OWFoU2R6VG8wOHBLWk1OWG5lTXlKbXpOVENHeFRHT0lhYURza0ZGRWkzQ3Vp?=
 =?utf-8?B?VVpVSkNsblZtY2lPdVREc3E5UWkxdlFmUkcvdER0dVo1WXFOc2JkckpodU5F?=
 =?utf-8?B?TWtJdSswRGhrM2pscVVVaFhkTldPNUp0Zm5XS2txaW85NHBCbzNTeklaZStw?=
 =?utf-8?B?NXlxU3p4U1E2Rmgva2t5QytMRmdYeGNNdTRPc2FhNXRyS2hsODIrcnNQKzF5?=
 =?utf-8?B?eGpVcGVmbE1ka3ZQdS9hT2pzWnduNXBFQnRkVnNoczE4b2ZZQWpsQmtaNnlx?=
 =?utf-8?B?WlY5V3E1MVAwdGx3ZS9nVnIwZVkzVnVyOGxXcWNsRHY3TEIrb1FLK3J2ZklK?=
 =?utf-8?B?SFFoYnMrMUx5QVJwcy9iclVsbEg0c0p0MFkxZlV6OC9iczk2VTdnNm1MSXlu?=
 =?utf-8?B?aysyV0V6YjFBZW1rbDBpQ01hUW9YeStOL1djWFVMMElieWE0QlNxa2JJQmNn?=
 =?utf-8?B?VXM0OXhKMHVEVWVleTZKNVVsUldsWWhvWkJIbitscGdGaEhHN0ErMzBMbzAr?=
 =?utf-8?B?bnJ3Y21HM21qU0szZW03c2luTmpGS1l6bkk4ME9ZRWptVkljTDJFanMrRnZW?=
 =?utf-8?B?NjNuTm53aTF2UTVwaGVIS2p0Wk05U1drdU1RNlBRZVlxUXRUei9Mb3Q3Y0Iz?=
 =?utf-8?B?d2ZJVVBBVmV0WjFvSUdMaG1xOE1zTjdBeTNqOXdRQXY2ZXRvclFySjh3WGxa?=
 =?utf-8?B?WDdSQXZ3c0h6cWNzNGQ1NVhsU2lGOGFsV3ZOWUVRRGVrUUpwODVRdzk5U3dB?=
 =?utf-8?B?ZVIwQnZjUlR4dmh4OUxxV1hsb1NwOFpHbDhNdEYvaW9USkQzK2NjRVJpc3Bk?=
 =?utf-8?B?Y1dpR09iMGVoNGJ4OEdwTXBwOUdHek5Vc0REdzZOOHpVYllidkJ5ZXJZSXJt?=
 =?utf-8?B?UmRHSE5WSWFlaC9Ea2lndVlrRlkzRHIrMTQ3ekNGL0VCZlBoYTlqSk9qSlFx?=
 =?utf-8?B?ZUFhNGhTTUdrb0ZtdmRienRtaDhkRzlNQnY3T3B0R2dJUGlvNFBLd2VwMDAr?=
 =?utf-8?B?RmErTStBRGp4Wm1PeTZQUGh4Q3B0a2UzYjFlWjBsbHE3cDRCczM1dXh2ODJh?=
 =?utf-8?B?OWF5SFQzTjdPRDZlc1dwZHRFZ2VOWWRiWHFHc0tsbE5EL0YwQ2o2VnpHSHRY?=
 =?utf-8?B?NjgzU2NjR3lSdkozMWNCZU05WGdjTDhZNll3SmFXNzN3U0FhTmloM2xIbDh5?=
 =?utf-8?B?UUtJVWF2ZlBobXc4b2hUNkU4WVdLQTlEbEhPTGZlWjNkS3p2ZXBiUngxeklv?=
 =?utf-8?B?U3h0OWRpVWtoRFd1dlJZSzNmVFhqVktmckJ2dW5xeGkrNVNKM000YjhrMHQ1?=
 =?utf-8?B?YkpEbVVZZThZN2Z0OW9wUXo3VXN6VnhQaXpzNDFURGphSlYxYmhGbzZJUFl1?=
 =?utf-8?B?a3Q3cHdrSkhJN2wwZlJwRUIyWlZtQWZWdXNrb085WEtKUHQzelpHbGVEdGpR?=
 =?utf-8?Q?egWVnLwo/rSy4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGtCbVhTc0dCTlBIM0JaYS8xOGhDY0VKRXFZN2kzNWJSdTIzS1F0NGd2TVRi?=
 =?utf-8?B?aHg5UXdPbllmRyt0RU56SU1aZ1J3cXV3VEQ5TTVuRURObUlib2hVZWFYVGMx?=
 =?utf-8?B?cC9IbmFwL1ZXL1dxeE94Z21ObkRHNlhGS2VaSHV3Vjl3K1dTZDdGd2pxUU5u?=
 =?utf-8?B?UjBYWEFtSTc1L3Z3TWcvQ3dxdCtNYUJ2UlIxaUpkUEhTNFFWbS9icUEzbE8w?=
 =?utf-8?B?STMyNXdXVWlXKzhiblRvZXBnWElUMzlXNXJlanVrRzNpVUlkbGx6RUtzZi9G?=
 =?utf-8?B?a2E0ZHBnV3RsalFrQVVrL2NyMUlQYXBDdzBkd1dkTWNScDVubmUxZnZtZjcx?=
 =?utf-8?B?M0RGc2RtdzhtNzZKT05qUjhGWEY5ZVRSSUNPc1RDbW9VV2VuZDcxcElaZHB5?=
 =?utf-8?B?SjFKUy9JMW9iOXh2QkJZWTNuZ3lUWnd4cyt4SUVLeldCaTlhUEt1Q2ZCMUY4?=
 =?utf-8?B?Z0ltTXZ5TlRwVURHMDE3cTd5TXl2bjY0VGE2a0MrYkJ6dXhROVpJZ0pyZEtP?=
 =?utf-8?B?V1BhdmNIbXB4ZTZoTWlFN1pzZ1FnNFQ3SVg0bDJzRE8xV25FUlFFTEIwVksr?=
 =?utf-8?B?ZFhOUFF1bHBvS3IxNFFXdjRHWXFBQ05jWitjRVBha1poMWlEdEszUnNsSUdW?=
 =?utf-8?B?a3RGUGZBWlMrSENZWEhSZGJhaXcxQUM5RnFua3piK0RBdDlNZjQ3a2NPVklY?=
 =?utf-8?B?RFJzM1lhRU5TUDIwblpHTlFESjZVRWVBN3l3ZHpuTlBmOW5rai93STU4b0NP?=
 =?utf-8?B?eUVZVWFWM24wdDhaMVhsdEthdnVsQndXM2RGT1V2WFlTVWRJS3grTEZZR09B?=
 =?utf-8?B?V0VieHdmVVBIemowcnRkOXVveXZQRk01TE9QWFlLNTBScGJFN0E4OTl2UHBL?=
 =?utf-8?B?eXNpYVEzTkN0OHFWVXBjeHNHZFBiTDRKQjNvanBkWktoemdqdlQ5NE9Bb1dH?=
 =?utf-8?B?d3RUYUxsZEhvYlBMTHJwUm1BNDY4amcvY3ZWalFsN1Z5K1RWS2ZWamlVeUFq?=
 =?utf-8?B?c3UraWtyTys0YTVXeHNMZmU0NVlCbWtqOHJYWDZ2ZXpBOFlZT3JBRTJFdFIv?=
 =?utf-8?B?QTkxRFZHM3ZDOVJJWmp2eEs1c1dqbHB4ZXFiVzU2YjFYN2txTWJPRjlvaGgz?=
 =?utf-8?B?eXNtb00wa0s5MTViR0VFU1FMbE1qd0ZURmthc1ZCSkh1ZmZVcGtNWXI5VkJO?=
 =?utf-8?B?RzNlOWwvNWVJVmVtUkxneCtsK3JNSnRrMWlROHh5czVreTRsUXB1M0hMbjZT?=
 =?utf-8?B?eThjQkF2TDltQkh5QWVHQmRHUzBBeCtpQUd2eHhPa1BNam45ZkFFNHJzajhV?=
 =?utf-8?B?eDJydTJRQXhNVUlZb01ISUtIQ2ZYT0JHdU9zVzlhVWJtbGhkazhQa0pMQlZz?=
 =?utf-8?B?L0VLNElLTUNiSTdHMERlNnJLZTZ1ZHZTWC80eFRQdkYxOUlvVDNYYjY2MzRW?=
 =?utf-8?B?N1ZLdWRhT3RncDk4aWRjTUZBNU1YM21BQjdwZW56Lzh2V3Rudys1ZWpRRHhq?=
 =?utf-8?B?dkI4b1BOV1IvMHVueW93aVA5aEFNaXhlRlJWQVhFNXNkNXd6MUg2Ym1xRmNo?=
 =?utf-8?B?SlN0cUdQNnc3aUYrNFpXV2NXNWZZaG1BTzJqeUlRcGhSMDhabVFrVHp5K2lU?=
 =?utf-8?B?VGRnemFXZVl5R2hrd2Y4VzBFOW1OOElia0FmSWc0M09XaTA0SUIzUzZRYWpR?=
 =?utf-8?B?akdjbXVmcnh1dXZSUXpzamZOYlJKUEc0aEt6b21hdUlzMDVjMWdYTmtBdlUy?=
 =?utf-8?B?cGdnczQ0dXlwMDBQNFBCdlFydWI1VXdyc3ZmR3lybGJwUkpxMDRxaFQ5WUZY?=
 =?utf-8?B?SzNERWhyR0p2Ukk3dnFJY0RQVTJlZHlpakpvbWNkSVBjdnlnOXZzQW11UXpH?=
 =?utf-8?B?SnJaU0NiWXlrTTMzRkFRRG9vcjdIYWZMRmswenNaOXRYM00ydHdJbUc4WXoy?=
 =?utf-8?B?OWFiZ0t3NnM3NGQvTTU4SGR3UjlFS2d5ZWN3aXhLTHAzZ0xIdFFiZnlwR1ZF?=
 =?utf-8?B?WkwrRmVYK3pETTJHaGY4SHM0ZVRVNU4vTzdGRS96SUhjMjBZU0pqTlBUVUxG?=
 =?utf-8?B?bk80cS9kaGhGUVVRT1RwYWVyb2NoWW5tTG85WVpsK3A3V0tXdzRISWFKTFVZ?=
 =?utf-8?B?MjNGcm5NL1ZnZGI5bUdCNGxlbS9CRXVYWmIrS3lUa0E0eGNsTVY5cHFDaFhs?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EF55B03C40B2747820582BE7915D01F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BYpEI35LOGd3ipoiTvf9dunjbR7GOujvtgWWKilMXXgixYYXmcbNCEXTkDr30jfRgdRDl8Q7Ix9Ce63XPS0QCRp84xfppKdPlanaHiFbjRAzQijLoJHG+mKog8OfBKSPHQHH8e+l2EdMhbl3FZiskYY1yZ2EpeX8UwWcwRBoEq53cuEPNqGBHoAWVTKuiksT5ZNUulo8RIghYnGAz0iGuPEmKu4BETTcdFg8DRWqcL8uH8FCQJ22x5fN9z8VF31WXI3zz0mURgs1q5AIXNEnxoREFqSkyIsXFWs11YlPRECB7qpgM/VuqS89fN1wwAXgvwKdI2/KIDG/xnfEzI6Eq5WDWs8pjIIrXi71F8AaCRzdNmbu1tjuJ2JeRTcqJHiNoJAnwIjrkf1iGi6lsMqJH5H0UOBTVJILqD6f0oxDRHY5ANNKgDUGrhsxJqyhvQ66Cy0uzGvyjvQqBYaLV8FZT4kofxuyKEH9iR91psTPclH83Vzu3dHViLOBTID2NsTXcmgV/Q6dbQX1vAsnwIKK+PmQUJhERd/pzF0MjwNzACOWAePGJfCd8KbBHTZfLUB9yaivp+tGdL4E3z77xY16l09i5R34jN4XWf5vff2naW5X9jeSIWIV5obovK6Dm0jg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987c9400-5ff6-4520-b3e6-08dc9c9a4f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 02:29:34.8457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MUpdR8ZIHrPex+sa1XuihRkXVOctygEowVme3lWZhER3yZMl0yLSENURWQMIETItqeXxx4ZXhRKYmTOjPIWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8778
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDA1LzA3LzIwMjQgMTA6MTUsIFpoYW8gTGl1IHdyb3RlOg0KPj4gVGhlcmUgaXMgYSBu
ZXcgdXNlciBmb3IgY2Ztd19saXN0IG5vdw0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC8yMDI0MDcwNDA5MzQwNC4xODQ4MTMyLTEtemhhbzEubGl1QGxpbnV4LmludGVsLmNv
bS8NCj4+DQo+PiBTbyBJIHRoaW5rIHdlIHNob3VsZCBkcm9wIHRoaXMgcGF0Y2guDQoNCj4gSGkg
WmhpamlhbiwNCj4gDQo+IEknbSBub3QgYSAicmVhbCIgdXNlciBhbmQgdGhhdCBidWcgd2FzIG9y
aWdpbmFsbHkgZm91bmQgYnkgY29kZSByZWFkaW5nLg0KPiANCj4gU28gdGhhdCBmaXggd29uJ3Qg
YmxvY2sgeW91ciBkcm9wLiDwn5mCDQoNCg0KImh3L2N4bDogR2V0IHJpZCBvZiB1bnVzZWQgY2Zt
d19saXN0IiBpcyBubyBsb25nZXIgbmVlZGVkLg0KDQoNCg0KPiANCj4gQW5kIEkgdGhpbmsgdGhl
IGZpeCBpcyB3b3J0aCBiZWluZyBsYW5lZCBiZWZvcmUgY2Ztd19saXN0IGdldHMgZHJvcHBlZCwN
Cj4gZm9yIGJlaW5nIGFibGUgdG8gcG9ydCBiYWNrd2FyZHMgdG8gc3RhYmxlIFFFTVUuDQoNCllv
dXIgZml4WzBdIHJlcXVpcmVzIENYTFN0YXRlLmNmbXdfbGlzdCwgYW5kIEkgdGhpbmsgQ1hMU3Rh
dGUuY2Ztd19saXN0IHdhcyBkZXNpZ25lZCBmb3IgKmdldCogcHVycG9zZQ0KYnV0IGdvdCBtaXN0
YWtlIGF0IHRoYXQgdGltZS4NCg0KWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNDA3MDQwOTM0MDQuMTg0ODEzMi0xLXpoYW8xLmxpdUBsaW51eC5pbnRlbC5jb20vDQoN
Cg0KPiAgIA0KPj4gT24gMDIvMDcvMjAyNCAyMjozNCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToN
Cj4+PiBGcm9tOiBMaSBaaGlqaWFuPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+Pg0KPj4+IFRo
ZXJlIGlzIG5vIHVzZXIgZm9yIHRoaXMgbWVtYmVyLiBBbGwgJy1NIGN4bC1mbXcuTicgb3B0aW9u
cyBoYXZlDQo+Pj4gYmVlbiBwYXJzZWQgYW5kIHNhdmVkIHRvIENYTFN0YXRlLmZpeGVkX3dpbmRv
d3MuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuPGxpemhpamlhbkBmdWppdHN1
LmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uPEpvbmF0aGFuLkNhbWVy
b25AaHVhd2VpLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBpbmNsdWRlL2h3L2N4bC9jeGwuaCB8IDEg
LQ0KPj4+ICAgIGh3L2N4bC9jeGwtaG9zdC5jICAgIHwgMSAtDQo+Pj4gICAgMiBmaWxlcyBjaGFu
Z2VkLCAyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvY3hs
L2N4bC5oIGIvaW5jbHVkZS9ody9jeGwvY3hsLmgNCj4+PiBpbmRleCA3NWU0N2I2ODY0Li5lM2Vj
YmVmMDM4IDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvaHcvY3hsL2N4bC5oDQo+Pj4gKysrIGIv
aW5jbHVkZS9ody9jeGwvY3hsLmgNCj4+PiBAQCAtNDMsNyArNDMsNiBAQCB0eXBlZGVmIHN0cnVj
dCBDWExTdGF0ZSB7DQo+Pj4gICAgICAgIE1lbW9yeVJlZ2lvbiBob3N0X21yOw0KPj4+ICAgICAg
ICB1bnNpZ25lZCBpbnQgbmV4dF9tcl9pZHg7DQo+Pj4gICAgICAgIEdMaXN0ICpmaXhlZF93aW5k
b3dzOw0KPj4+IC0gICAgQ1hMRml4ZWRNZW1vcnlXaW5kb3dPcHRpb25zTGlzdCAqY2Ztd19saXN0
Ow0KPj4+ICAgIH0gQ1hMU3RhdGU7DQo+Pj4gICAg

