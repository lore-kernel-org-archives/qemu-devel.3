Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB4CC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 01:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPXOJ-0008E5-4J; Thu, 04 Jul 2024 21:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sPXOA-0008Cx-Cx
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:05:27 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sPXO6-0003YS-Dv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1720141522; x=1751677522;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=csOSihBO6LXATsOQQux5/vBTmH1KoeMnhsJWwppUxtg=;
 b=SW/ZEHnNqXoVHLxSPiHUp/nyT4+LhutfL7diOqLtYW1FPHEXm52pMAi8
 czgzMXnZghwxuwRHqRGFaUWr0ryAX/VGxVOm+VM6WCpALib1GEPBc8Px1
 oKx/vg/Oi69FSWpn5iOHG7plPn0UX4imuZ03kDxrRshTPOuI6Aihxqhqb
 4HHONLMjh5J0c45SY8DNgBABOTuQvHdru0eAFB1SgFgHjx8ChPvEL+0Tx
 X37+zo2n/NoQweQlsZrn2NefRafcDeKuy647nVKpsNn5p260bAA5qwCBB
 nEMlEtfbBTi6r4gD4GXxQFsILrPQte0F21L8HqUY/bDb2gEmqfECghVeO A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="124349007"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; d="scan'208";a="124349007"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 10:04:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8YPnNk5UZoZNbnDvH4Wxs+vjB7INvOr6a4jVr4N4WICQyIR192OisgHorjk5gtZPFAsM/BvcfrX+v1uDhFM2y6WpH/+20N3BJyF+q9UhJBSDX+IH2DJMp/6tGv07FmRAQDaiSNFi63SWjUHFN3KaaYeK0qOlGDXaG+dMkhgR55P8qbCVxgdrgCdTShT81zpWoJrE7dxRRXugz068DEVijgi9GgwF4baXDr5ify57rTpMBwgk4btyyimQPhs3Yl/PbZgQfMEX2erbJRWZERc6zppmXVv/3AIjdcHN7gdkaztbrmGkoGG0hi+bctLh4Uxr95BpMfItJLCNqSPVnGeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csOSihBO6LXATsOQQux5/vBTmH1KoeMnhsJWwppUxtg=;
 b=VXcM/vvsqZJcAFLaLxFllCW+kMv4GTxZ2mHvVnJyhfBTFCICDGx1FIQWi+xk11qFETnRy4jPT53G9veNSU3WX5l/hFLB4E9fF2NQSnD9woH7Yzb/H3ghRQL3af4Qrx0oesEIT6K3E98o0tISkhA0V75HDHVLseX4NSefXxeVXQxdaueBWyIIFRyPD52GM5Rlljfiu3x0fIz3064RXWAiznc6TUj0LiGhXOI9a9I9ZpOfAt+knIuRA711r+NjxxCiJ0spJP43c8/XLdVWuQaDwvLkihrj+IPm5dHYdyUZufUvCOr74/GuVaP5OWBK/iVyjFDCndcWaJFmbKdkDU82bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYRPR01MB12332.jpnprd01.prod.outlook.com (2603:1096:405:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Fri, 5 Jul
 2024 01:04:52 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 01:04:52 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "mst@redhat.com"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>, Zhao Liu
 <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Thread-Topic: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Thread-Index: AQHazI0G7GHzvpfI4kaBYAMfHI2F4LHnVZEA
Date: Fri, 5 Jul 2024 01:04:51 +0000
Message-ID: <5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
 <20240702143425.717452-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240702143425.717452-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYRPR01MB12332:EE_
x-ms-office365-filtering-correlation-id: 9b210105-27a6-4868-dc8a-08dc9c8e79a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?cjNNd1ZXTWtwNWxCeU1kclJVVFFFdkxuSEZTcmZtenJQNUVPNG4xU2VzNVlJ?=
 =?utf-8?B?NEhEV3NhdWUxV2IvZ0Yzdjl6OGl2SmVtN0lYQU5xdy9TY1UzZlNUWTJ3VVlZ?=
 =?utf-8?B?OTNQWFVPK1JXVEVqbGRxSTlZQVl3dG9QUUhVYkFuZ1dhaWVJdXRYby9ac2ph?=
 =?utf-8?B?YXhCajI2UVpvREdHMnYxSmJQS0NuNUh0S3dkN1l2clpRZDNWN05neFp2NnQ5?=
 =?utf-8?B?VE9JZ2k4cTQxS2ZkbFNCcWpqenA5c1FoV280eXM4WGE3bjRIVjllMDBaM0FS?=
 =?utf-8?B?RHlUcUZTU2ppcmxHM2FJTi80ZzBSa0I0ZnQxOTAyRWxFblhFc3lzbUVhU1Yw?=
 =?utf-8?B?V3FIdnZFRGFOVVBIR3ZwYkpZZXAwTzBza01jeERnSDFtNlpUelVHWWxnTjI3?=
 =?utf-8?B?V29uYTJZR0o1d3dpck1mUGg2dlNDN2dWTWwwcHhES0RjZHpKeVJqaTBHS1Bh?=
 =?utf-8?B?NjhLbDhFdTdhaWhIOUJuWVJjbTU0dzhFRW15Y2loNldLRzJoN1NZaUFZR1hq?=
 =?utf-8?B?ZTFLZ0tHaS9XQTlGL25FWkxHMGlTZ3I0QUUxbDNDUFUrbjNLZFAvZ1RRbFpt?=
 =?utf-8?B?WCtuSmdWcXJLNmY5VmdyaUJqSlUrajMzTFljZ00zMlRqTTNodjZlalNUVktZ?=
 =?utf-8?B?OWJmcHJLbmR5bmlIZGs4alRYN2d2aUFDTjQxL0dmQWZLbys5YUNNSGs3bFNu?=
 =?utf-8?B?RE5GUElCQjhBVlVsZEFnWG1hZDhhMnVWU09YcUlKOXc0NFNDSWNlVFowZENM?=
 =?utf-8?B?cG53Sk41Y3JCRmxnL2dMaGh0Sy9aTmZiTC8yRlpoVGpWRms2WW9HMlo0WnZw?=
 =?utf-8?B?TEN1eUkvVUozTFllUE1sNnhEejZUMEU1SHhGNThQK1B3RXlScGJJYTVNelEv?=
 =?utf-8?B?NFhST255WlZORGd6TVFQa25zYXFmR0MwNWxMQytxR1VDTHBZaWZMdDdlNHgx?=
 =?utf-8?B?Vmc4SE9XVFNaZnpDczd5UHRLSVZNZEFRakxERmZJZ1JjWkpmRFRqbUw2MmJs?=
 =?utf-8?B?Z3g2bkY2TGRaZlRQeGFTOWlzWTRmYmFsbTRtNkVwSXlHM2swOW5yUHptTUp6?=
 =?utf-8?B?U2M3WjdxMU1PVHVxR1lkYVFzZ0QzcE54ZWV3OTdHazhUWC9ZdkZUTlZlOTdV?=
 =?utf-8?B?VUJMMVhJUTZabEludWtCZW5ubGlzYzFTZHA1UVVkTHJuMXJEbjF3Z0lVVUNz?=
 =?utf-8?B?N1A2T1crdGRFdlVTcE9YWnpQcE9pN1pUTGV3RE9KQVcwaVp2WW4xSFVGaCtD?=
 =?utf-8?B?OHlqK2tnL1Z3NkFpdW4xT051enN3T3puWTZHMVM3dVQ0cmYxZ1hZSTMwZTJz?=
 =?utf-8?B?UERQeWxpd1pkNDdaY3N5b3I4UjNKYVh0MmlHWnMrUi94QTZMK2VzSnpEaE5F?=
 =?utf-8?B?RlRwRUp6Si9uUXVJYTAzVjJNNDNoQ2ZKU01VaC9jVE1WZi93d1dCMjFJamox?=
 =?utf-8?B?ZnNrbUZCbno3cE1LanhHNTN5eU1JN0RuMnZhRlNzSldTcWtTVVZGSGhaUlJE?=
 =?utf-8?B?VmtFMjd3THhsbEJMamlZdUE1blRMVG1mdXU2WWpNeHNsejFMbUk2Sjl6ZHpW?=
 =?utf-8?B?SHp6M01PSU44eE1uNlJ1dng2UGZDR2RzbCtEa0I2N3MrTmRVWHR2d2RuV293?=
 =?utf-8?B?dVZYREdyNXZkM1FVSUZYbExsd2VPdUFVOUcxY0FJaERPT1R0WGEwQkp4V3F1?=
 =?utf-8?B?eTRQM0JCVzk5ZjAxK1ZONDFFUUx0WktyMENYWVhwMXErNjBKZ0tyTlZNNElm?=
 =?utf-8?B?dldhYVBsM0JGTWMwSjZaYkRqVnllRkt3QTgrV0V2QjlVUFZmZnJHWjBTNUFR?=
 =?utf-8?B?cHdkRkNveHdkQWZkUkFhZEZmY2xhMFhKd2pOQTloOUJ4Y2txRWdEVURnL3BM?=
 =?utf-8?Q?s84ouTItmFHGM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHZmT1B4U25seXp5WG5nWHZCeTI0aE9CSGtsT1FGSjlCbU5xOWcranJ6ZzRZ?=
 =?utf-8?B?cUs5OHNmd0ZpRHUvYU1hWk1FTnp0S1cxakhLTU5JU2hPbStmOFpocEUveXZE?=
 =?utf-8?B?QVJwWVNpTzFmWlF1VThnY3VwcGNxaHR3UFdVc1Z1c1Y0aFlVNUd4MDV1SUNT?=
 =?utf-8?B?UXk3eHpoVzN2am5OcG9zZUNZZVNWR2Z3K1FidTVveHhBSlVoRFdyKzFTZStS?=
 =?utf-8?B?VGZCRmdzM0tXb1VqTmw3NXQzWUF6cWRRSjFzaEtDWkZPZmZMbUN0MWRNT0or?=
 =?utf-8?B?V3hrUytLYzBPM2o1dldlKzJjSVRINHBRdTRaTzd4cXZaZlBla1krSEw0eWtZ?=
 =?utf-8?B?c1Z3dDZZVFgwM1pIc1JlYUpMNGx5U3dzTStEaU42MjIzL3pjYkRsZ0NNWjVn?=
 =?utf-8?B?WTJEWEhaaVZobVB0L2ZoWmdPKzZxZ01aVHJuUFBub0RjLzJhTHZuaThOS1dD?=
 =?utf-8?B?dGRvNWVqTEFGY3hyTnZ6bmY1WVh5RXEwVUVUbmVkZk43VmRLMm5MTzJCWXh5?=
 =?utf-8?B?NWJLaWg1U09nM0V4cktNV3N3eTRKWkxzQ3dCRklhR1BFUUJjcjFuYTlYUmww?=
 =?utf-8?B?UU9HYkFjTURwaVE3NEFLdFZ6QStRSUVpbjAzNmNEYkVDSWtOampSM3VIc0F6?=
 =?utf-8?B?aXEvY2pvdUl2aElGY2hLN0U3TlpZWWQ1Y1NWZnpBTEk1T3ZUeExLZmM1eVVL?=
 =?utf-8?B?MWErMmpjbExUd1J5OVR0c3hhOWF3T0pmKzYzTUFMZlM2RzBxWVJaUTVGR3NV?=
 =?utf-8?B?N0hNWVluVVI0emYvNS9MNXhuMTM4Uk4vTDVHM1pxcWVpNUpOczFXd05OYVN0?=
 =?utf-8?B?MVpiZDk5TE96VzhISFNOYzY5azhOZGpUTW5vS2lONnU1UEdlMG82U2VTWmIw?=
 =?utf-8?B?c0ZUWk5Hckw1WmtMTUxEUktCQWFZQm0yaWpsbUF3NzZ0Nk1pNGFxeDRXQ0hM?=
 =?utf-8?B?M25XamVrRGw2TTRuZENHSUpqY1lDSkhvdm1EbkI5OXljMGkyc00wRmtrSVd1?=
 =?utf-8?B?TTZicFAvT0ZtbHlxSEF0djFsZGlidEpvY0hFMmQrU3BRemdLZ2w0dFhmOUZZ?=
 =?utf-8?B?eDBqNjlHS1NwSWZZMXluUUVXSm02dC9rYUlzamkvR0MwbWJxNXpsZ0oySi9m?=
 =?utf-8?B?MFROa0pkTGxUemNrVzhZKzF6TXdVMUdFV1F3clA5THdVSml1TU1iSXZaQ0hy?=
 =?utf-8?B?MGE2eThnSSt3c1o2MmIyU3BFd05CN3dTWlJMakZEdXAzMG9IZStTYStQT0VK?=
 =?utf-8?B?dmFRQ0FvQXBkM1pDR0d5RHRvelVTa0ordmZ1VEpDb25xZjE5aGlVWlBmU1I5?=
 =?utf-8?B?a2JnUERXczM1N3VLa0lLSldtKzlHbTVYR3dUMW0wWWloS2w5VlRqeGw0cDVq?=
 =?utf-8?B?V3ZPM2R4bHpiYi8xbEU3Y0dWYkFkUnJuVjNiRmQrRVZlZGRkeDJZUWlpSUty?=
 =?utf-8?B?eFZMRm1qTHNQcGR0T3Rkc0MyTk5NMS9wREpsZ09YQy83ZVJuMld2bWJGRzlS?=
 =?utf-8?B?d1hudFlvUUVydXRtdmJFM05HWkkwdlFKZU5mQVVSSXpLYnZkcmpHVlhsNTFF?=
 =?utf-8?B?c0xlZTZDd3N1WjZ6ZWJwb1VlZE5jTDBSa0FQdUFzQSt6M3ovallSTjg2aUV3?=
 =?utf-8?B?bjlSMmE4ZVdSS2oxa0JQQ1l1azhyRTNLMm1ZOGY3WDdlWjBtb04rM21qQkI4?=
 =?utf-8?B?TXlkV0xXdWw0ZXpFSWdZMmpnZkFTaWxra3BEN0tYbFRtQXoxUlRXZ0IrVTNv?=
 =?utf-8?B?eEgzTFY2MHRaMFpVQjlSWDBEV3JDa05iZUdzd3hnQ2RoNXdTOXo4Smx4eXNz?=
 =?utf-8?B?bHhYK0txVFRIMDRoaFZqRUlxTktHeFBVbWltQkdVcWFWdFVJMS9TTGQvcS9k?=
 =?utf-8?B?Ym9UcGRqVURxTXBmRDY4Q1E5ZnE2SEwrVmpzc2RkaGdVSW0yNEVXeE16ek1O?=
 =?utf-8?B?cjg1bzJZb3dRNzJjVFRKcWVVUEVEWUx5b3Y3WkdzZVdURGtqQ29PUUdyK2M4?=
 =?utf-8?B?Q0pORFBoT3I4d25PZDhQNnJuTVM4Y2ZmZ2tUU1hFQkVrcTVqME5KVkI4ZjFN?=
 =?utf-8?B?WGJ5WUlqSTdCTGo4b0ViZEhVelQyTXcvSzFMajFDa1h5K09VOUVsZ3NmSWlG?=
 =?utf-8?B?NngzVE90WE9kd1hHTVA1OS9IY3ladGV6Ny93clNvRExHVVdFTWZsU2dPOWxC?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFA97CAE596DF948B0868E289AF73FF2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 29I0xZxedDefyO7g4as+PUs+31+orKJUYc5drBU/fkSbVUsZkwjUxfumImukM8jHnRltXM8c/KNvGCoYxQzwSr0HIu3H1ekaumkANGOgTZUQDuzIv41SSWda87yGtOehbsYLTJRI40oHYxRjO7C82M+HnMatK7zOmoV33j/1SnLM8WEfat2m/eiBwBW27Hi5l+Bno+8gkkIKvyuAHoOvN2UD2cuOhrNfAhm/GTJ5RkJaCiPNoZmrE/1AfVcJM1CaEMm1z9wrOb8f3SUE7eXUBEVMtki038ClqC8gzEVzvXYy+tHxHbqq5fTi3wNNbzIf3XKxgMkSTTLZBGzC7EyeCrBOP6pWP0PADfhBxXNEEfVG6Jjf2Jb5zTvJkmV/ZfIir45v3sVSBRfqtbLpHIyyHhLfGP3AgK8LiYLZkF2DOFoIIBI0qk0VbY6IlmuktH81O1kZwNPJSMRqH8PnoMQ+MuO77//nyNxmXkOJhQItEDDVOBnQcRvsQOAcJsLd9hn1DY8YJ5biTqOJD/foIl1u65KXHvhB8l2h+NgMCFmd95jCY8VeJrxi5g1JSSpqwKS3x9sQqOVBheY46+29MLdpmXgPKfkn6xQza8KCkk+s97l0B8eKfKR7V86Cep9LDh+F
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b210105-27a6-4868-dc8a-08dc9c8e79a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 01:04:51.9117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxpjE80KivIJwveoH6/zUVPpBay6nKjEsHCJfpdXV98x7fuxY12NlQt5Tj3Vm+1z57NJwxBxkmZmlJaOwkIvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12332
Received-SPF: pass client-ip=68.232.159.88; envelope-from=lizhijian@fujitsu.com;
 helo=esa8.fujitsucc.c3s2.iphmx.com
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

Sm9uYXRoYW4sDQoNCg0KVGhlcmUgaXMgYSBuZXcgdXNlciBmb3IgY2Ztd19saXN0IG5vdw0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDcwNDA5MzQwNC4xODQ4MTMyLTEt
emhhbzEubGl1QGxpbnV4LmludGVsLmNvbS8NCg0KU28gSSB0aGluayB3ZSBzaG91bGQgZHJvcCB0
aGlzIHBhdGNoLg0KDQoNCk9uIDAyLzA3LzIwMjQgMjI6MzQsIEpvbmF0aGFuIENhbWVyb24gd3Jv
dGU6DQo+IEZyb206IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gDQo+IFRo
ZXJlIGlzIG5vIHVzZXIgZm9yIHRoaXMgbWVtYmVyLiBBbGwgJy1NIGN4bC1mbXcuTicgb3B0aW9u
cyBoYXZlDQo+IGJlZW4gcGFyc2VkIGFuZCBzYXZlZCB0byBDWExTdGF0ZS5maXhlZF93aW5kb3dz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1
YXdlaS5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvaHcvY3hsL2N4bC5oIHwgMSAtDQo+ICAgaHcv
Y3hsL2N4bC1ob3N0LmMgICAgfCAxIC0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9jeGwvY3hsLmggYi9pbmNsdWRlL2h3
L2N4bC9jeGwuaA0KPiBpbmRleCA3NWU0N2I2ODY0Li5lM2VjYmVmMDM4IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2h3L2N4bC9jeGwuaA0KPiArKysgYi9pbmNsdWRlL2h3L2N4bC9jeGwuaA0KPiBA
QCAtNDMsNyArNDMsNiBAQCB0eXBlZGVmIHN0cnVjdCBDWExTdGF0ZSB7DQo+ICAgICAgIE1lbW9y
eVJlZ2lvbiBob3N0X21yOw0KPiAgICAgICB1bnNpZ25lZCBpbnQgbmV4dF9tcl9pZHg7DQo+ICAg
ICAgIEdMaXN0ICpmaXhlZF93aW5kb3dzOw0KPiAtICAgIENYTEZpeGVkTWVtb3J5V2luZG93T3B0
aW9uc0xpc3QgKmNmbXdfbGlzdDsNCj4gICB9IENYTFN0YXRlOw0KPiAgIA0KPiAgIHN0cnVjdCBD
WExIb3N0IHsNCj4gZGlmZiAtLWdpdCBhL2h3L2N4bC9jeGwtaG9zdC5jIGIvaHcvY3hsL2N4bC1o
b3N0LmMNCj4gaW5kZXggYzVmNWZjZmQ2NC4uOTI2ZDNkM2RhNyAxMDA2NDQNCj4gLS0tIGEvaHcv
Y3hsL2N4bC1ob3N0LmMNCj4gKysrIGIvaHcvY3hsL2N4bC1ob3N0LmMNCj4gQEAgLTMzNSw3ICsz
MzUsNiBAQCBzdGF0aWMgdm9pZCBtYWNoaW5lX3NldF9jZm13KE9iamVjdCAqb2JqLCBWaXNpdG9y
ICp2LCBjb25zdCBjaGFyICpuYW1lLA0KPiAgICAgICBmb3IgKGl0ID0gY2Ztd19saXN0OyBpdDsg
aXQgPSBpdC0+bmV4dCkgew0KPiAgICAgICAgICAgY3hsX2ZpeGVkX21lbW9yeV93aW5kb3dfY29u
ZmlnKHN0YXRlLCBpdC0+dmFsdWUsIGVycnApOw0KPiAgICAgICB9DQo+IC0gICAgc3RhdGUtPmNm
bXdfbGlzdCA9IGNmbXdfbGlzdDsNCj4gICB9DQo+ICAgDQo+ICAgdm9pZCBjeGxfbWFjaGluZV9p
bml0KE9iamVjdCAqb2JqLCBDWExTdGF0ZSAqc3RhdGUp

