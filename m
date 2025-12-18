Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9382CD6ACE2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 11:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWBr4-00078X-Ql; Thu, 18 Dec 2025 06:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vWBqx-00077h-70
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 06:07:28 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vWBqv-0007ms-6f
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 06:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766056045; x=1797592045;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jUak8ZON17AdgMzm2OUrzIZjUuxiQ5/q8+oK520EQ1I=;
 b=lEIxybWCFxAIZFhRE9sTVwnRGyNDHAZ6EaZTdz/Ak7kHoyzwYz9kuPJq
 couBpqj+M3+wSOckvwDSagPrxVufWod+zD4xeDp5TkYPcWOikVA85EKv2
 HBX/qBPBSOz+pSpUbF5AZFbfeFHXtpKGZfl3xd0mGSt5wJk3bFps98RqN
 2CoE0SjqM4PDSgx999a3inNVHpb00mgsdTxCcCMejedJecEA4Cqx6zwDj
 fWa/xeZ7flZP4/rqeb+PXn2ocxSL4GVcA9CJbF7zbJ+Bip78b5JlylWIu
 IiCZ2TMqs6OsjrPNMQh28/KEiObf3F0cch2xHNk7+lqAl3ztI4pkyOuMB g==;
X-CSE-ConnectionGUID: AfrHmofLTr2fzJ0zshEnyw==
X-CSE-MsgGUID: xLt3PjmwRs2XLS81YCALXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="68161025"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="68161025"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 03:07:20 -0800
X-CSE-ConnectionGUID: NcG0F52IQOO0QTk7TuIaVQ==
X-CSE-MsgGUID: vHHnvxWzQ0qjO2EnyfiQwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="197819368"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 03:07:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 03:07:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 03:07:19 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 03:07:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeLpi5TErwg3vjMTn/mribJIfYwxfeUAWMAsy3qIxBhuieluXpZ4D9DaqZVGIACmGNFGCbxC679aB5KtkG13ToZnt6a6Zq2n51VAveH/4BRapkTN6eF0P8Z1Am4b86UGaxtXbcfvUuWVMu905fdciXhzbF0NNT8K3ZmcqAMMZGaw2ehP647FU+wAynR0Vf93fh6u7FUaRbx6ao1nsQfnAXa4wMZ2zNYnAf3JRxUnffmglQsEMRv1cfUWMeQCsjdNlHMYIdW7F10LT6ZAh5ihgbXvzdvySXK9CNiIHWRMUAAPX9YSxOihezpaI6tUq45NF9AkomkrnNFp5l3jd73nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUak8ZON17AdgMzm2OUrzIZjUuxiQ5/q8+oK520EQ1I=;
 b=qNvHD7XZS9cfmZyi0KVqBsxdOZDKqn2uPVjsityAMBM6jf7jUOyy2QP2leNVjK7HaoNXkWW5wA+bEms5Vzg/6lEY4ad/VbnWU2C9wNKepHbRIRQnBZ09LwiQpaGa/jNDZebm78405UF6ZDp5vIZT7IDRgZuKpY37rY9+QXbcy1RCN6NL0LCbAYwdKm3GoUU8JrngaCJjKZwcbIJ1jAQz0FVE6Mg+D1BZI1Xm3aOcvVuiegLbqMYhQE76692l2Bw45K3hfdleAFyweI5IVlm1DHyfshJxO7ruo0MS1WYaPwruT6NI3IPsKmfdAlB6gGRpm9X5lqpZQp1rgb1Lzgq0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY5PR11MB6464.namprd11.prod.outlook.com (2603:10b6:930:30::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 11:07:17 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 11:07:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: RE: [PATCH] docs/devel: Remove stale comments related to iommufd
 dirty tracking
Thread-Topic: [PATCH] docs/devel: Remove stale comments related to iommufd
 dirty tracking
Thread-Index: AQHcb+qqPNpA1WXAZEmmInxT6TZAarUnB9iAgAA0vYA=
Date: Thu, 18 Dec 2025 11:07:17 +0000
Message-ID: <IA3PR11MB9136FEFC7DD10A5AECEEF40292A8A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251218065042.639777-1-zhenzhong.duan@intel.com>
 <80397b14-160b-4a87-a0cf-d828f2974c85@linaro.org>
In-Reply-To: <80397b14-160b-4a87-a0cf-d828f2974c85@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY5PR11MB6464:EE_
x-ms-office365-filtering-correlation-id: 37835801-1257-43da-b447-08de3e259b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ckkwWHhIcVNXbVVON3hxNWkvZTJ5RXBOSStXSGkrS0RGM2p5ZVRSVTVUa2I4?=
 =?utf-8?B?Z3JRTURENE0wTjRTcDNRbXJ2NUpSUVJFZEFDaWlISmZsWWZkRzJMQ2g1Q1VV?=
 =?utf-8?B?bVE2QlJsdHlhcmo0RTNqZEZpZzBPL2ZIR21vNXZieXEzR0dwWERSeFVHV0VO?=
 =?utf-8?B?djVJVHBDUzFEeFZZNTI3YkZZT3N4eitacXdQeStkb2tOcWdjcmk3bVRTcjBi?=
 =?utf-8?B?VzFmT3lUNnlIM0JJTGVuNnZTS0k4TFI4dFVRTUM1QWc1VkF6L3I4TmRpRDFS?=
 =?utf-8?B?bHNHT2Y4aHVhM1g5Z2lObG9CYW4waUtsTDRYeG9IbUxBMkx5ZVllUE5vWUhz?=
 =?utf-8?B?eVI4MkpHT1dNUWFjSktpZU5LeTVMbjBSaW5XbUNqazVLaG5aN3FHTG5URDRG?=
 =?utf-8?B?SUp1cTZ3dlJRbmUrOVozNzF1UDJva1hWMWllZytaUHk4bTFaN2RzYTRtRHMy?=
 =?utf-8?B?ZG9KVnlyWld5aHlZZVExbGtZM1lnWTJkVXVyV2d4WUwyeGt1SXR4ditoTlJ0?=
 =?utf-8?B?M0t2TS9FcHJ0ZGpTekQ3aTJSVkIyNW5DQXlKVFFOYmNqeUYwR1ZSS01walVE?=
 =?utf-8?B?Zk1BWkhSbGFEdVc5T1hPcFRLZis3U3loQm81cDB0Z2xkQURnSHY5Wi93Tmw1?=
 =?utf-8?B?OG9oQmoxS3VoenM3bmZzbnVMR0RhQllYMHdFRkl2bW42dTl2UDdlaFd0bytD?=
 =?utf-8?B?bGkvNCsrSVFXNUYvV3cvVXVYaXJQSHF1MExiNEVuR0tmQlQ4bE1UMHN5TE5y?=
 =?utf-8?B?SUJwVHRrc01KRXpZWW1OYW13V3BZUjQ1VTB3SVhHWkhQTTMxbGxLaEJzeXQ5?=
 =?utf-8?B?aDMzL2M0UjY2R3JRQWN3ZktQUnNlcWlHVDdQeHJYRGVCeXJhOGUzS0UvYklN?=
 =?utf-8?B?Tlk2c2Y1MlA5TXVEQkxNc1ZhL2NoOGhyVDJuMzgzS1RQUGpVTDZURlcveHJM?=
 =?utf-8?B?NVRETlpvZzVmbmlkVkh5cDRrMVlhV0lqQUlFY1FnSmE2d1RNUDVma2t2c0pi?=
 =?utf-8?B?VjVMQ0YrbmkvZnhnSEczbW9mOGJrNWE1cWRxd2hLeFNZUk1TaFprYUd5QVhr?=
 =?utf-8?B?K2RoK3JQaEtzb3B4cENVQzFRK3liNk80anp2aUdDR2FLZDlXSzRPNW5GYW1D?=
 =?utf-8?B?SllEOTJkNjh4Y1F6WTFLQ2Z5MFdiRkN4Uy9aRHgyallPbTR4TmhqTEJUcEI3?=
 =?utf-8?B?dFh5dmZiOXFZZXJ2eGZ5eW9CM2U2eWhMdTMzaHpER21jVkY3dmhsZGgxVzhB?=
 =?utf-8?B?N0Q0Y08yK0pZRGF6UHpYOUo4dnhhMDZpNjM3MzZGb2M5T3ZzVGJMcWtrU3NZ?=
 =?utf-8?B?aThQTC9uM2M4dnRSbFJlTGViTGxoem9OOTkyM3hCeWZjcVNYSFRJZUs3UHk4?=
 =?utf-8?B?VkZvRlYvdUpwOVBCMytkbmhGNWZPclVFd0d4dzdtZVlaR3I5OWRPQ1lONmtt?=
 =?utf-8?B?Y2RSeEVoN2hmcmpCdzdVRlc4QjJBbFRWZlU5dWhoY2dieUZsMitIWjVYVVpH?=
 =?utf-8?B?a3k4TTV5bFZQSks3d0lhSXdheDZzOXZQVGczZUt6OTk1ZndOYnk1ZnpSckxY?=
 =?utf-8?B?ZzNwYU9pWmZ1cjNtbEFYcEJnY0dxMTk4dW1BemhYT1VpU0YwR28rbVVwdXFP?=
 =?utf-8?B?a3p2M0l5UjhUQ01zakJlUE9pKy9TUGxxSnNCNEtLR00wZ2pRTG9udUw0L25L?=
 =?utf-8?B?TjJjS1V5UGVjcjYwU1NCMld1V25Iend6OGxML3MvbW4rejJIN1VUa2h4Y254?=
 =?utf-8?B?T2dmZ2t4TlJTTCtaMERtSW5HcERxbkhSb1pTcktGbHVwdjR2TTNSQkt1cjVW?=
 =?utf-8?B?RXFWRVRpTlYwbFpNNks5VVZsNzJuQklnaXpJMWkxdUpWdUdjN01FUCs3ajcv?=
 =?utf-8?B?N09IZXczbm9zRUgvYUVGTFRGcFdOM2FuRzdrMTFUVVJFZ29QTllEQXczcnRP?=
 =?utf-8?B?d3k2eEZncE42UWhyMTcwbmpDeU5sdnViL2h4cG1TUE5WdVk5a21jNzZsN005?=
 =?utf-8?B?Qkd6WUdTb1dSZGRobTBEOGx1REZXOURNbGtFU2Vna05QeStDVGovSnhCcWEy?=
 =?utf-8?Q?8w/003?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1FELzR4UVYzUUlUNG5mSzg5S2VkMEdsQjJkWXZsejM2em9oTUUvanp3ODdI?=
 =?utf-8?B?T1d3elpNMzRxRE9IN3NFQnd5TDdnc1Q4ZGptSU5sdW1lNlJpV0FyNS92WU8r?=
 =?utf-8?B?TkhxTnl2T2xpcUFQd1YzTlRzNm4zdXFxM3ZBc3REek5zTHhtaGZtL01GT2hq?=
 =?utf-8?B?VnAzQWhSZTNodTB6R290N0pYRm4xUE9DbXI0aU0weFoxZlg1MEtaV2x0REdq?=
 =?utf-8?B?eGxoaE5kL3I3T1p0Sml6WFNXZUFTZ1BYMXlDRTFpRGo5R29GN1RVeENWK1px?=
 =?utf-8?B?cHhHTXVNYW94OUtMRnBJUTNKRTFoK3ZuUlZ4bHRUdVlWdFRGdVVFbjZsL1N0?=
 =?utf-8?B?YmFZSWZUeVlKKzVOSWhweUdNdndsL2xOL1lSZFVIUWxPZmdzZEdNYzlVcnBV?=
 =?utf-8?B?bDJRL21NaDVxdkNxL1FtREdYdFJOTDJMOGxkb2JOU3NoNGlzZ3lNQnZKNmpR?=
 =?utf-8?B?UWRnYWJnUjNLUnhDam9BdUR1RHRiRTFuVEZsbVNCZ3Zqd0tTTHpHbmpiMERj?=
 =?utf-8?B?ajlFbVM3T0lrbkg2OFlsWFFZa2pFZ0RFbks2ZkVPVW1xSWN5TEZURlFqQnZP?=
 =?utf-8?B?a0ZyN05wQXZXbFFQSTVYalZGc2FJRHRsV05XSm41VFhWcEZXRHk2RytXa25R?=
 =?utf-8?B?a0E1NEF4V0VJdUdRTXVvaEYybGxtQXI4T0tNWDNpSlliVSswUHM3Wjl4K0VR?=
 =?utf-8?B?aHYxU3pHUElMMC91a09FR2hKaUFTUzloQUwxMkd3LzdpOUhZWGhFTGk3Z00v?=
 =?utf-8?B?amUrNkdkdnA2dEZManQ2MENzQU9HS040ZDhOZ2NsWms0alVoQm5uY1FzTXJp?=
 =?utf-8?B?dDRLQ1JsaWI3cm1uMUZ2cTNOcmt0UlF4aDJmOXhaNDlBdmYrcURFdnZCNUhy?=
 =?utf-8?B?d08zcklaRTBaRlVwZUxkYStiTi8vNUdPTW1CRFhIVjlGaFdUMVpJb3dzV1V5?=
 =?utf-8?B?dmg3NHg3TThWVVF0NU9WMmJoY1duN1RSVkpRRnMyTXZvWTlJemY0VjJieUJh?=
 =?utf-8?B?eUoxbndWSldrdUpRT0lGYnFkMWFMcmJSak84Mnh3cEg4VXM3Y0NyTmxQQ1gr?=
 =?utf-8?B?WFpJSU1meHNUQjA5S3hSS0E3WFYzZWdxS1hUTDhGVXZCRzhrYnUydU53VjEy?=
 =?utf-8?B?ZDRIbklMMnRReWphb1crNGw2VHFRRXpZcWRRSmhYZ2JFQmJ6L1I1a2htYW5Q?=
 =?utf-8?B?U3d2WFBBVmYzQThRYkRZYndNaUhGc1NsYzFnVW1SM0NvS3hEV280RGI1VUZU?=
 =?utf-8?B?Nk8vcGVtYXpvSkFndjVnZ0ppZDY1UThzRW9YdER5QVgvdlVUSW1SYXh4MFk5?=
 =?utf-8?B?T1k4d05sb0FGRm95T3doVkxpdk5lVHNrNStMUVpacXlhYysra25OZ00rc2xH?=
 =?utf-8?B?TTFvT051UnpQNnE3R3RjYzlsa3ZsRFdCdU56NktONEtWREI2eTRRTTZaZE1X?=
 =?utf-8?B?N2dINzlyZXJGQnNZYUl4Y1lsaGFrb1dzaTZwZ29jU0NZSkJwOUV4NkJaTFlp?=
 =?utf-8?B?eHlSa2xrdGhiN1lzZHFvYlY5SVE0K1ozYUh3UCtjTWNCR0VMUkoyK08yT09L?=
 =?utf-8?B?b0JjYTM2bittYmNJYzNXSTd0ZzMrOFpCSzUzVWxGZUtOeXVacDVnK2lHWlVY?=
 =?utf-8?B?dk1ydk0xbk1XYkFISTZKYnJ5bmM4dEpmSDVMemNMTm5iaDFWQ281aStSOW5G?=
 =?utf-8?B?bUFIdXVSakFadVVabHpPVUJ6cGl3VE9UdDFLSHVpYzZHbGp5K0pnTExXZWor?=
 =?utf-8?B?Q0JZeXdYMkhPOVBCckM1SXcyRnpoWUNoR3pmSk1aSjNEaFNQVHRMUFlHRlFw?=
 =?utf-8?B?NnNZdVkzdnRqbEQ2YzRlVUVmRUpZMUpNVG9vY212RlpzS0FjaXpOL3FkYmJE?=
 =?utf-8?B?S0FDOFg0Qnlqa2hlOVUxRTE3cGtoaXlPM2I1UHpRdzN4bEMrYkQ1Y21VeUtQ?=
 =?utf-8?B?ZjAyMTlQbUxWUVpIeDhlUG4wY0VYK1RiNVJGWmp3Uy9WbW5WM3hDZkxYQ25N?=
 =?utf-8?B?TTdTNXdyeFY1aHJnNVMraHN5TGtQM3V0NmxicFQzS3djcUtoRXBGdExmTktR?=
 =?utf-8?B?UXVHM3hxcW8zM3BTQkZOSGl6aTJyNEltMmVvTGFOSW03MjRzbFdpQzNwdlBh?=
 =?utf-8?Q?/e2TFgsVT/m6QUfP6gO0+90y6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37835801-1257-43da-b447-08de3e259b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 11:07:17.1008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VniSDx8ffRcbz4wv06f5AmpobAT/gC2ciVB4N2Ekh7YY1dKmcZfWdlOVoV8QI6g1cdXROZ31yrg8t343QrkLLf5smBkeaDTqLoavZbjZSN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6464
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkb2NzL2Rl
dmVsOiBSZW1vdmUgc3RhbGUgY29tbWVudHMgcmVsYXRlZCB0bw0KPmlvbW11ZmQgZGlydHkgdHJh
Y2tpbmcNCj4NCj5PbiAxOC8xMi8yNSAwNzo1MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJ
T01NVUZEIGRpcnR5IHRyYWNraW5nIHN1cHBvcnQgaGFkIGJlIG1lcmdlZA0KPg0KPltpbiBtZXJn
ZSBjb21taXQgZGQ0YmM1ZjFjZmU/XQ0KDQpZZXMsIG9yIHlvdSB3YW50IG1lIHRvIGFkZCBbaW4g
bWVyZ2UgY29tbWl0IGRkNGJjNWYxY2ZlXSB0byBjb21taXQgbG9nPw0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+DQo+LCB0aGUgc3RhbGUgY29tbWVudHMgY291bGQNCj4+IGJlIGRyb3BwZWQuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT4NCj4+IC0tLQ0KPj4gICBkb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QgfCAxMiAtLS0t
LS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QgYi9kb2NzL2RldmVsL3ZmaW8t
aW9tbXVmZC5yc3QNCj4+IGluZGV4IDNkMWMxMWYxNzUuLmIzNzA5OGUxYjYgMTAwNjQ0DQo+PiAt
LS0gYS9kb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QNCj4+ICsrKyBiL2RvY3MvZGV2ZWwvdmZp
by1pb21tdWZkLnJzdA0KPj4gQEAgLTEyNywxOCArMTI3LDYgQEAgU3VwcG9ydHMgeDg2LCBBUk0g
YW5kIHMzOTB4IGN1cnJlbnRseS4NCj4+ICAgQ2F2ZWF0cw0KPj4gICA9PT09PT09DQo+Pg0KPj4g
LURpcnR5IHBhZ2Ugc3luYw0KPj4gLS0tLS0tLS0tLS0tLS0tLQ0KPj4gLQ0KPj4gLURpcnR5IHBh
Z2Ugc3luYyB3aXRoIGlvbW11ZmQgYmFja2VuZCBpcyB1bnN1cHBvcnRlZCB5ZXQsIGxpdmUgbWln
cmF0aW9uIGlzDQo+PiAtZGlzYWJsZWQgYnkgZGVmYXVsdC4gQnV0IGl0IGNhbiBiZSBmb3JjZSBl
bmFibGVkIGxpa2UgYmVsb3csIGxvdyBlZmZpY2llbnQNCj4+IC10aG91Z2guDQo+PiAtDQo+PiAt
Li4gY29kZS1ibG9jazo6IGJhc2gNCj4+IC0NCj4+IC0gICAgLW9iamVjdCBpb21tdWZkLGlkPWlv
bW11ZmQwDQo+PiAtICAgIC1kZXZpY2UNCj52ZmlvLXBjaSxob3N0PTAwMDA6MDI6MDAuMCxpb21t
dWZkPWlvbW11ZmQwLGVuYWJsZS1taWdyYXRpb249b24NCj4+IC0NCj4+ICAgUDJQIERNQQ0KPj4g
ICAtLS0tLS0tDQo+Pg0KDQo=

