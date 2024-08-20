Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840E1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 03:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgFJd-0005Kd-1V; Mon, 19 Aug 2024 23:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sgFJa-0005JK-NL
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 23:13:46 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sgFJQ-0008RK-R1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 23:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1724123617; x=1755659617;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=PNrfzXpa37kE7yC+8hwiWdc3wpHqf00ZSQ8rSn9gt7w=;
 b=eQhBXQQcv8Xo60q5Ll4SNUfn7g5147hBxJMX5gNZqYFLAT96mKc4FLls
 82LynSLOSpo/BbTc2Y+dMtAZ8rqB2EktxXX0ythZ2EJRhDMLpE1Ms15eX
 Z56vBx3t6Xo6zylxoFbZZnS0Ms6ngB62gZp7KBtLyHkksUZi9AEwSZ5JQ
 VcPTI3SF1LzVbZWVO2Pcdp1Wn/apUbfbHZmofvBa2+58cLakC6kHktQmv
 4AzR1Pjc0gwJhWJvkRiHiVJPxcZjpsnaDKWPvG3pxZ/6voXcoApXCopg1
 RI4Zzzvf3yV669rgCvq4ggXmrO6m9WXqR/6cYDZgnrg1o6hWKlav9+PY9 Q==;
X-CSE-ConnectionGUID: nmsER4VPSjGf7ml6svUWCg==
X-CSE-MsgGUID: gOqLHK86Ql6VLtT/eP2IaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="127930014"
X-IronPort-AV: E=Sophos;i="6.10,160,1719846000"; d="scan'208";a="127930014"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2024 12:13:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Igf6tRwSJLljNW0k2J+dZghRtGRW3ay87xBEkKpbW3i53NJmNIHq/uCbH0f7s2fV0RJv1kD0+cme0IeLfSqfzUNSMtGBVkDZNrmivZaghRJ6vDp+8ld+bseZ83ch5XGU4TZRECF8QBAnJMfmEjJfX43YyQ10EyDJi8qDYmZ2kxg3jv1+XCbOsKrt9IRnTnEOrkD/lWHU3L+HhwpgS0ehhYXckMhgMLUCL7UAuNRyLHNG0FIj7jgFJPMt5MPyuNJK48O0ttrcSRoGCu2Qjj7aBwiJwkv0//W7L4QDEM8e3AqwCBLqcoHYbHlZynXb2G9RZjcPqVxZFpFM5v5z9xjiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKCunmz594OKkSaod2Zagmi5vkFrtFbh4UDW8Ktw4iw=;
 b=Cy4xCRyeGozsvRWsPsepTp4LtZT4MgCC12hCyIYl9zhaKJkCaYOz1vsWEcB2FiIIKGDQKpQa5SBhM1IKcn019i7StMBsAh280sjvwhXi2BT8moN+6f1raG0p7n6HdEo0MLOK/9EWOsWmcUGWfOZCuRa4T3gukwBcswHJrYDvg0SIOeA3QrOCFErl8X+GwKj99tR7uLXTmtt1RwyCWC0ohtifhb+aoXBXoiL1GUOfY720T9KmFd4iiAf5SYa6iKTv3Ph5M7cetatvLI3bZfzmNyWzK8s6z8d1QNwNUzfxBq45OfHaEh4eTTvTtb22K93Uwo+SatYf698f+kZn7o8Rpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB8684.jpnprd01.prod.outlook.com (2603:1096:604:154::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 03:13:26 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 03:13:26 +0000
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] scripts/coccinelle: New range.cocci
Thread-Topic: [PATCH] scripts/coccinelle: New range.cocci
Thread-Index: AQHa3lc8QI384GS8n0q91FxxwsLfebIvoRVg
Date: Tue, 20 Aug 2024 03:13:26 +0000
Message-ID: <OSZPR01MB6453DB2B3BEBBDAFC0AB88E28D8D2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240725055447.14512-1-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240725055447.14512-1-yaoxt.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=a2cf5d64-a1cb-4ebd-a86f-d11343c21c5e;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-08-20T03:13:15Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB8684:EE_
x-ms-office365-filtering-correlation-id: e0c3a13a-3e31-4c2e-acaa-08dcc0c60f11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?RmlDSjRLVVdoSlQvZjZHSjBKa1FRODZoNERJWmVEVGMrQnJ4U2JUdCtV?=
 =?iso-2022-jp?B?TXdJZlZrbFJJMmUvSWhaSTlsOVdtd3FkM1BheGhkdWJCOFFpbmxuWWNC?=
 =?iso-2022-jp?B?MXJlaDBod2U4NUR5aEpQUW9wMWpXb283Umwwa002SFBBaGszZU81M0Z6?=
 =?iso-2022-jp?B?WllleWxCQ0VQZG5ONVBIUVVjRWJ3OS80TFN1QS9kRXNvTEI0QTJob1Ar?=
 =?iso-2022-jp?B?am9JN1JhL2lvQzVGTGpzWnJ2cVNoZG4xUDE0QU5HeDBYWmQrZEREMm5S?=
 =?iso-2022-jp?B?VThiVk8yWElnc1YrY0h2MDY5eXVwNGFOQ25BTWNGdmJkbHAvZmpiMzE0?=
 =?iso-2022-jp?B?cE5ZOEpROUtreGZPemJPL1YrODVVV3RJSmRjYUJWWENjeFV3dzBaRmJR?=
 =?iso-2022-jp?B?Ky9SMDZyeGttN1hYT2JEOTlZSU1TQjBLRzJCRG1CWXpGY3dtTzk2VEUz?=
 =?iso-2022-jp?B?MkVxV2cwbHE5R084bktmb3RkMFd0dFVrUEx6emNHRnA3QVQ3QTIxVDFP?=
 =?iso-2022-jp?B?OVVVZ3JWUitJaTVYaDdVMUw3akpxUDA5OC9NOEovb2tCWlVPL0dNSU01?=
 =?iso-2022-jp?B?TE10V0NkalJsZCsraCtkLy9pRTZPVzNHSjZuWUNnTFpXSDFIdUxVLy9r?=
 =?iso-2022-jp?B?WEV5Y3c5dWZEQzk2ejlnanZJZzVIY2Y2Rkw4QWJKZzA3RktZQW9qaW82?=
 =?iso-2022-jp?B?TSt1S3lFN1o4RVpzNy92OTgxdlhMZnBSQTVHM1JqYUNUSzJDNG10K0Fr?=
 =?iso-2022-jp?B?RklvWE44YnFTOGJvTTlPL2xxTHZ0VmpsY2NWZzl0ek1tdG1YamcrQWNo?=
 =?iso-2022-jp?B?N2I1MVFXYzI4Z0ZYVFd4MGdCNGtobWY5MGdJZGlPZUtEKzErcDFrbGtH?=
 =?iso-2022-jp?B?c0xxNmRBTXlPU2pIT3BXV1Vmd0dKU0lUb2hGQkxjOXFIaExyU1FXaW9D?=
 =?iso-2022-jp?B?VTFxOW4wZkdzajQ0Q2duTHFhWTAzR0dGY1drdXVvcThrNDU2ZW9ndGJj?=
 =?iso-2022-jp?B?TXNwdEttQTRKVStxbkEyL2tJUWJoRmMweXo3eDNuTlFaYXBHYnorS2ti?=
 =?iso-2022-jp?B?bkhRRGxWN3dHaU5Hcm5Zc09uUTFzeWtKNS9WQkFqSnZ6am5qSEl1Lyts?=
 =?iso-2022-jp?B?YnJETW9GR3dzVXQrc0Z6RUJreDliTE1zdGY3NUc0aEhXc0hmLzlqWFhR?=
 =?iso-2022-jp?B?S0xCOEJ6UDY5Unp1dnFLdUg0R3U5cytUSUZTNXJuU25oZ0tkblROVCtw?=
 =?iso-2022-jp?B?Q0dTK3ZYZEF1WFFpeVhCZkJHM2JsbTUrdE5EbmJ2dy9veG5TbE41b3lI?=
 =?iso-2022-jp?B?TWJWUlFiRC9IZlAwQ2VlR2Vldjg0SFBCd1RuTXJJcnJHYnN2amIybGJ3?=
 =?iso-2022-jp?B?L1I3K3J3L3Fibzc0cUxrTXZvekxMNFlwcnFlVGZaZktxUmhkSDhOQUty?=
 =?iso-2022-jp?B?T0hubnVWTE1vY0liVlFPb1JOd1pFNkxTV3NjOUFzOUQ3elpjWUJQaCt5?=
 =?iso-2022-jp?B?MkxDMkt3TmJQUno3Z3k0UDRnMHBzOEl1TXd2UzlJVUtqWDJtYXdXdHQw?=
 =?iso-2022-jp?B?K0VpbUZvdDJucFo4U2hKR1ZTVmRqaFVtclZla1NKNkoxUzRiYWxlYU13?=
 =?iso-2022-jp?B?UGtmYXZmMFRSdnNlYVRZSGh4OERxTFUyZkk0NWJ2NDJSOTBBWHlSRnpy?=
 =?iso-2022-jp?B?THlPdkNsNkNzY0ZtRG5Bc1F5OUZUMzV1WE1qbTNtUzVPdDhlN0UvNUEx?=
 =?iso-2022-jp?B?Z3RlVm9DSWJ2WUtoMStBS1RPZXBJVmlxQVoxZ3ZrekludU9xOGJqaDg5?=
 =?iso-2022-jp?B?eTh5K2hHMXViMElXLy9RTHNQVXNBQWxEVW8rQVhVWlJVcFgrRTZScW95?=
 =?iso-2022-jp?B?bFBaL0pmZ0FPa1NwZnprY0VwbGhHRkRrMWhaZzVVaTJNU2NpYUk1SzhD?=
 =?iso-2022-jp?B?QVUvM1VzSGRxeXpLOGd2QjBGb29KeWpwVXRRclhQL2R3OGV4Tnh3bzNV?=
 =?iso-2022-jp?B?aU5wRXZuZU1uREhwM1h3Z2psNDB6K1dVQkRIblhxM1h3bWxSOHJpSUx1?=
 =?iso-2022-jp?B?UHpLQ1MyeEZ2M1JXZ2R1N1FMSXI5NVU9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RlROUUVyVzVMMi82SkVGN2ZFbWE5MGI1VFI4ODZMdTcvazNKT2FuZVkv?=
 =?iso-2022-jp?B?N0JERDQ3YVVydittS3dlaDBwZW5heXE2Qkk1S1VVR2IvN3dEVTRrUy9s?=
 =?iso-2022-jp?B?bW1nZUZMdTVMVDhjNEVtd2p0NWVVTVM5U2N3THAweC9DZ0ZFZ3V4SjRm?=
 =?iso-2022-jp?B?ZkpGODdyc1Y3Ykl1R291blJwZUVyemVNUGtJQWM1WUM3MzA0ako4djBj?=
 =?iso-2022-jp?B?WUJVL083TmxqdDhqaDlyRWQ1YjVqT2N6VFd4dFNmckluekpVNHlaczh3?=
 =?iso-2022-jp?B?N1YzTDg2aVVWQW9XUWVVeExxeGlORXdod3pSRytPOFJ5a0tKV3dzamdJ?=
 =?iso-2022-jp?B?Nzk1aTJIc0dhSTB1L2VqWUMwSnl2T2J5MGNhT1BBOWdIcWJmUlE4cEpv?=
 =?iso-2022-jp?B?NDVxSk9aQ2gvekNqOTEzR0syNGJyZElybGxoSHBQdVNJczh1Rm9RUWt4?=
 =?iso-2022-jp?B?czE5bzRldnFleVg3RVdrQVQ3dWdjeXVCUXNmcXFmcUVRdmdQb25kWEhO?=
 =?iso-2022-jp?B?NFErSHVXbUkyUXJGNnlLb2ljUkVyZUN3UmFlbFg4YmpabGhxSTFmZmJE?=
 =?iso-2022-jp?B?a1NuL2FJeE9jc2lHeEpkYXc3UEo4WmRhOGw3MjdWaTVocE9zTGRhVGVm?=
 =?iso-2022-jp?B?SUtZU0ZhNEdyNjJIdmozWG4yK2U0QUlLSitrdUViYi9TYXBLRGpBMmV5?=
 =?iso-2022-jp?B?bEwvckVKUGRHTHA3M1FrZHhScDg2d2M3WU9EbWpQL25YM1VIVWg4WnlT?=
 =?iso-2022-jp?B?OGhjR0txd1VNNlpTc29jYlJwSlgxak5Sbi9ESDNIdy81UHF2aVU1TW9W?=
 =?iso-2022-jp?B?SkZ0d1pVaENEdVRFV3BMZG56MWEzTnpqTFlRMjdLMlFwVkhlcEQ0bHRB?=
 =?iso-2022-jp?B?WFdtTnlHcWNydjB5RGc5R3JYVi9ZMFowczVjMVdxNVZreFovaWlYWDlW?=
 =?iso-2022-jp?B?TmliS0k1dW5JcTZ6QmViYzQxQVdRUFdncWFhZWovYlRlc0pTYm04VUda?=
 =?iso-2022-jp?B?alZTZDhicm5Uc2ZWT1hIWTRkTVljVGJLUXFKRzF6ZGJyK3QwT05SblB5?=
 =?iso-2022-jp?B?WmRBMFRKZlhXeDlzQkh1RE9zV1JiSk5sMXNMcGRBVGt5VmFPMDlzVUM0?=
 =?iso-2022-jp?B?OWhZaDE2Njhzc0laMmkrMmZVMzEwS0lvWUkvK3kwalUrZ2xsOGwvRG1W?=
 =?iso-2022-jp?B?em13cDJWVWJPV2IxOVhYYzRLUHFhc2xSLzFIMG5hd09lRWVaU1lMY3NN?=
 =?iso-2022-jp?B?dnQyQkZsajNYbGttREx4YmpoT0pDdkE0OFZRNWNjSGNOS1ppSTlhSjBG?=
 =?iso-2022-jp?B?bWFCVVBoalBFbTZtTnIyZUh1V2tWVjc5Q3FWTXpBVlVPUTN1UWFiU2U5?=
 =?iso-2022-jp?B?REFUMTBlY3RwZGVzOEdKeG45M29UTStWUWEzZnBCazFUY3NvQjMyZ2ZM?=
 =?iso-2022-jp?B?dHIrR1VwK2N3Tk5VbHR4d0ZOKzRISEhWcjh5OE8rczRjTlZkbm96aS9F?=
 =?iso-2022-jp?B?TDBtamozOUgvT3lJZDMvVWxVbktpa0FKWUR6TU02MXRQeXN1c1E0bkRs?=
 =?iso-2022-jp?B?OEQ1VXF6VVp5elc3N0JDcTkxWHQ5TTdDbU5ITlhDS0xNREtIRlNWanpw?=
 =?iso-2022-jp?B?YUpFTUMrZnkxTEdKN0JDcnMzWjRNQmM2cTdUTE9xcE1FNnlmWk5tMEF2?=
 =?iso-2022-jp?B?Q3YxeUcyTXByNjNaMkkrcHN6aUdXSEo4Rk93MU51YkhMaUQ2UVh0a0ZV?=
 =?iso-2022-jp?B?Y2pTamtxM0NJdTJua0dQa1FnK3R5ODVNd2c4YUhGQjNsSkZHOEJ4OW5D?=
 =?iso-2022-jp?B?ZXg2RFpYTS8xcnZmVkxxUXFuRSt2Kzl3VkVsWDdSZVhydWxCVzIxajFt?=
 =?iso-2022-jp?B?bkRwTzZHZytaSmRNdkg4R0RFMWxvUUttQ3o1WWszS3BDRHZIakUvdlRt?=
 =?iso-2022-jp?B?RWlNTk1sdEVhT2YwdzRoNkFDTC80Si9hQjNOSkVxTFhhZEJNdTJhUFhW?=
 =?iso-2022-jp?B?cksxRWsvYlQzM1pRY2ZUVndqTGE3Y3JUZjNUc3lvMzRHY09RckZkZGNm?=
 =?iso-2022-jp?B?aVRyVTVBTDkwS1IvUVM3RWs3QWJobkoyTkF0SElFU0hSM0RWeVRPaXh5?=
 =?iso-2022-jp?B?YWhqdEF0UzdsTXVmV3NKZzZGbGVCcUc1cVlESVBWak4wS2VzalBwZERI?=
 =?iso-2022-jp?B?cUdoam1JVHZRWjQ1U1V0RlVWY1BWaGg5RGJtUVk1cHRjY3loYkFvN3BL?=
 =?iso-2022-jp?B?L2U3NFVxWmhXbXFxaTk1V1ZETkMxcytsWnhZQkZMWTVNQjZET0FXVytS?=
 =?iso-2022-jp?B?Sjg3eA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LXe+/9emLt55MoRuEnjfcEE6oTz9VmKD/QPspXI89q2qMAqH77hPIRTSAE8WAaDfGMorTY9f6ask6Ywzb7BwrwY9ptdMm3LFGNCyoLo1s+cXuXd2LJZQL9ky4j9c/g1l1+ACyNuyGma7qHn7p1zYQmrNFD6QZM+sJI8AbpKrU6LrGLNi5tuDmE6O2TX7HIjjL3dnaCptIHs5lWM3LASXNpNg8mJfPtsktM/Q+MrfQCVTcoFXv6ux+hb3/E9UD7v79G7I3zlK/URKMuhrXVrR7cOd8bxjXpBVksSOSc6b+Vf+qbsGkq2zg8ksg80tH8r/W306O7K/NSdzJ8s5NrSBWm47zKsEtQ0lwFS9kvJSr7DdRZkbLXhFWTIT9A04yGjM56Jk8MJ7F/QnIrqYMAsNxcReCZKq5j6nNxdep/43sKfLzqBlc+c+AD90Gm2RrNftOT+mG4Dfyph8M2AA/ASdp5Cht3m4ncLitEnmr4UWzJ+vN6SAmDMPYHia9QaipCq7c4G2Xs8XXITRaYguR8knYOAtPdTXL7pilzcXG2/alVHHF6YwthhrHKZ5ewYEpPBKwp3pYnMeRoM8ssMf0D0znJPq8AxpEgqhrDEz2Vh/KJ5AMVpMT9qEizYoVuafQz5o
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c3a13a-3e31-4c2e-acaa-08dcc0c60f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 03:13:26.8579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DH6mTUCBOdG0Vux1aURVYyjMDw3V6V4NKjXku8AJ/dzSRea5WhN8X226XhF4PP6gFC21FoBovVcAAvqgmbmnPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8684
Received-SPF: pass client-ip=68.232.156.96;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa13.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ping.

> -----Original Message-----
> From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Sent: Thursday, July 25, 2024 1:55 PM
> To: qemu-devel@nongnu.org
> Cc: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Subject: [PATCH] scripts/coccinelle: New range.cocci
>=20
> This is the semantic patch from commit 7b3e371526 "cxl/mailbox: make
> range overlap check more readable"
>=20
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  scripts/coccinelle/range.cocci | 49
> ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 scripts/coccinelle/range.cocci
>=20
> diff --git a/scripts/coccinelle/range.cocci b/scripts/coccinelle/range.co=
cci
> new file mode 100644
> index 000000000000..21b07945ccb2
> --- /dev/null
> +++ b/scripts/coccinelle/range.cocci
> @@ -0,0 +1,49 @@
> +/*
> +  Usage:
> +
> +    spatch \
> +           --macro-file scripts/cocci-macro-file.h \
> +           --sp-file scripts/coccinelle/range.cocci \
> +           --keep-comments \
> +           --in-place \
> +           --dir .
> +
> +  Description:
> +    Find out the range overlap check and use ranges_overlap() instead.
> +
> +  Note:
> +    This pattern cannot accurately match the region overlap check, and y=
ou
> +    need to manually delete the use cases that do not meet the condition=
s.
> +
> +    In addition, the parameters of ranges_overlap() may be filled incorr=
ectly,
> +    and some use cases may be better to use range_overlaps_range().
> +*/
> +
> +@@
> +expression E1, E2, E3, E4;
> +@@
> +(
> +- E2 <=3D E3 || E1 >=3D E4
> ++ !ranges_overlap(E1, E2, E3, E4)
> +|
> +
> +- (E2 <=3D E3) || (E1 >=3D E4)
> ++ !ranges_overlap(E1, E2, E3, E4)
> +|
> +
> +- E1 < E4 && E2 > E3
> ++ ranges_overlap(E1, E2, E3, E4)
> +|
> +
> +- (E1 < E4) && (E2 > E3)
> ++ ranges_overlap(E1, E2, E3, E4)
> +|
> +
> +- (E1 >=3D E3 && E1 < E4) || (E2 > E3 && E2 <=3D E4)
> ++ ranges_overlap(E1, E2, E3, E4)
> +
> +|
> +- ((E1 >=3D E3) && (E1 < E4)) || ((E2 > E3) && (E2 <=3D E4))
> ++ ranges_overlap(E1, E2, E3, E4)
> +)
> +
> --
> 2.41.0


