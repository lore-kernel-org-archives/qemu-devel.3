Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BE1EDF165
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 13:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqtfW-0003C2-FS; Fri, 13 Feb 2026 08:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqtfT-0003Ay-NQ; Fri, 13 Feb 2026 08:57:12 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqtfR-0005Zd-QL; Fri, 13 Feb 2026 08:57:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8ERCYtMNeXHCcxGiSCIVLFV9wDHTfrgYQAxsgKTLAiQkN4he4lekCBgpc5fRsAFTPjt681P5qoaqy/JEPZjXoBItAMKEt9C7OREjsg0VuvXIKp/YiJPYWZ3y6CIoTb2y8vTfC/Ui3Vt0wKg8HPTlYBUdwqL0+6ujBbSMUymUxDpwmZ66M3YSJZoCAbx+MvXrEPprxtn60J8TRWDLGJmMB3P6y01N9rrMLu66Of1BCGfcnsu3Ol87pHEVvMQlZW30A778VW8voZF77bq9Kqt4hL5TxlWcOknKifkY76DhmmG5pXkaviHmOpAM3AHpYsq3RhfiR+2dxn6rtAGA3BrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFhA87PJhGpa4e9wGptgrY9hhHwi2pV4naDbmIa1glw=;
 b=eEYA9ZLc7g2k7OolHE3vEadfBd4RRTDGV7MjsgWrDKWbCtBqEUmum1cSvedYLIt1hRD91j0Mko4Ld3AwYy/TgzbK8+gQ4ciYxDfkSNdm+BjhlG44HKLYM87bwTCrYa6Wy2zhdYd5b5Zc0kSpOzniBgvbRhvZDL0kg3oymL/djnJAktaEtt8CGN6iWWxEYUe3CHmN1bZ7g53XJDh9nDEcMhzOX+X1TMxN+MbtUPYJys16B6/POBzJbR7UY8LcURappu0ifC7bNk5JBjuEJUFpGIWHy2ofGTW8kaFCzhL1n27StWiNIIwqtl0Y4wV+pbFphfbUvbpsTHNcGC/x+XAM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFhA87PJhGpa4e9wGptgrY9hhHwi2pV4naDbmIa1glw=;
 b=RG547yrMCufAT4C0+E7JvSthrrgruTshWfJVZMSRWsa0ngfPq6+uuxMRW1hIC+IOGIFvtLgr8K1g9qokpaLI+PKyBUPQ0WgeBhcM8a+eOrDgQnDpLmnUuTpAXZqGUK/KEms+C6LzACousvBCoEPtg3tkmtqj+DAqFHsYbOfYZ02v4HQUlLP2D6QIcW5sFFIDZC11CznKHuW45/AnXGG9CDMxS0MCsxbWKAm56KEy4fWSQxGLfxwt3Oa22C/mMrh9W/sChJa1wQNssyGs3aeEQyzFP4/N+58x7O7YkLMivm6b/RgrQY2J6ndMZRZI7FOygZ4T2PCHxnjCNCibzyoauQ==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 13:57:04 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 13:57:04 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 09/24] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Thread-Topic: [PATCH v2 09/24] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for
 CMDQV
Thread-Index: AQHcl3fk3gebwCijtEGRB3oLbakC1bWAexuAgAAzNCA=
Date: Fri, 13 Feb 2026 13:57:04 +0000
Message-ID: <IA0PR12MB7555BCE050B23ADE07C9DAB5AB61A@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-10-skolothumtho@nvidia.com>
 <dac416bc-a55c-439d-a374-63572d9d58ea@redhat.com>
In-Reply-To: <dac416bc-a55c-439d-a374-63572d9d58ea@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|SA0PR12MB4477:EE_
x-ms-office365-filtering-correlation-id: d591e6b5-ad75-474a-d8ff-08de6b07c506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Wi91WkVGMFpVbHZTZ3JON2xwZEZGak55T3VmUlltb1o2elpjN0w4T2ZWMjdH?=
 =?utf-8?B?aDlYSXQrNDdoM1hzWnBPL0ZoakU1V1JYNkl5SVNkRG9rcXFwcW5VMGxpVWIz?=
 =?utf-8?B?VHBJZUhXNW91a0dJU1hPNS9lV1dvWGttRzhoWCtuM2ZFOXhnSkdoQ0owWDJr?=
 =?utf-8?B?Mk9UaW1xRkhaTzNqZW5OaWJlYk05MXYvbnRxOW9mMDQwSWl0VTBVUktYZHUy?=
 =?utf-8?B?RG9oL1RBb1BKQ1Y0NnFudEp4Y3dQZDcwOUs3b0poc1FvKzdYbDRyZzE2OUQ5?=
 =?utf-8?B?NnBTYXVobFV1Skk3YkttRWc1L1dST3FvRFFTQmZBUGk0aWE3RVpBTkpFSWdF?=
 =?utf-8?B?Vi9RKy9OOGtoV01ldFc3RUVZNkd3cHVZRDRQRm9yc3UxWmxPQWYrNXFKNExN?=
 =?utf-8?B?UHZJK3d3TjVSY0FCWXBxb1k0SkY2Nm53ZEc5RnhhVVRSZVJEYzlJQ0dnZko5?=
 =?utf-8?B?c2l3ZjBPSkdNWVljYXJ1enBVZHlxb3dDODAwS0syUVhkUHF3MU5pZCtPLzdn?=
 =?utf-8?B?OERkcER5Y2NBMkR0T05vM0kyWmdVcmNYUVJXaW8xRk8vZjgveFJtaFZJbExs?=
 =?utf-8?B?aHhHcTA2VkdadXloU1BTS1F3Syt2ek03Z2R5RzVaemM3SXJ6ckRFVXZoRG45?=
 =?utf-8?B?My9SM1pPQTYvdENQMUVvNGUvNE4xNkVEeXNYM3k2UldpZ25wNmFRS0ZyblVt?=
 =?utf-8?B?d1dvY0RPUW9pUmhPeTFLSERJZ1JudUt4Nng0L1BrL2JodkxXZTY4NElwcWEv?=
 =?utf-8?B?VlRYNUltODNXcW9WV3NlcTIwakJsSzBQNEJROFNIYUZrbXBkaFd3VitiQWxK?=
 =?utf-8?B?Qzd4cDQ3enBudTQyeFFreWVkNFBiZis5eUdhYWxXMlJheU1Bd01CeWNwNUhm?=
 =?utf-8?B?VWhLNm1JcTRKTFp2ZE92ZVlZZmpmVWQvVmtOR0JzcVRubm5jQms4S2J2NFIy?=
 =?utf-8?B?bUZBOVFwbFFOaldBS1c2bStDTVJqYU9SaUpjWHpva3piMDh4cldPTmJ2K21M?=
 =?utf-8?B?YktaaVBJaU4xMGRyRWVjV0pWM3YwcDhEblJJYmxySXVyMzFuSnh5WFRHVHVD?=
 =?utf-8?B?NUhNWk5hYU5xMW5FQ0N0eFBCWENWUnlrUnNUYTVzditYMXNYdGQ4ZmhOTkl0?=
 =?utf-8?B?YVpOa1hwYmJTbnAwN2g1VGVjTHRZQTVsejVLMVlOaUVrN2YwWTJmdFlLeHlj?=
 =?utf-8?B?QVdtV0dYKzllUm5ESUNtVzJsSnpKYnArM0MwVzM5RHBpM3NSdjRYZkYvQmxV?=
 =?utf-8?B?NXVHZnZrU1Q2Wm9QbTY5STdFTnhZc1hlemRhODdvRFI3bUdYT2NVL1cxSUk3?=
 =?utf-8?B?UUNuek4vMmN1cUM3UEl3enpaSXBoWWUyOGtySzFNNHcvalpaR0Q4SHMvcFlQ?=
 =?utf-8?B?UENhOENCUjFISmJyRWNlbnNZODV3SkcwOGxUbUVJSHNBeFVqV0lHM1J0d2xK?=
 =?utf-8?B?YTdwVGtsSnJHaUhveFJXSnM5RjM2QTdGN2ZqUWdjU0laaEkwWUV0Wlp2ZldZ?=
 =?utf-8?B?VVZ5czJ3MzE0TUwrVllGQVFjWFJIS0ZCOE1paDJlRXZDWk5NbWduY1JpdTZw?=
 =?utf-8?B?MTFveGU1Qjh1SVlZWlUxb1hBVG51Uy9qSkEyMll2Y0YvWTdOb0U0WVdGNDBE?=
 =?utf-8?B?MlhUTkRPMEFPMVNoT0h0NzBET3VnKzcrUnh4TWhna2JERTJLT0w2dVRnQWpM?=
 =?utf-8?B?L2ZEdWxWaWNwZFBsajltSCtWV1NFc1dodTNrNXlZTE83cFJXZ0Mvb1RaclNt?=
 =?utf-8?B?VXFnNzNZTTEyek1WT2ZWaU4wcldLSy9qeTQ0SXBLajlvdUxBU0Z5bFV0emZT?=
 =?utf-8?B?QkZIWHp0cmUrQVhNRnhuZHRSNDM2TUJTdE03M2xWWXpUanFTeGRPalo2eGl4?=
 =?utf-8?B?WUo2aW5yRHRucHhVUzB2RCtlNW1QS0dGVlZHNlc2dVFQKzMxL1h2QWRSVFJS?=
 =?utf-8?B?OE12NzcrandXSmZvLzQ1OEZaMFhaZ2daanVrYlNOZ3orSnpoQWN3aURpQllk?=
 =?utf-8?B?SENWSVFWKzcxMlZVbTdMMDk1TVV2OHZnU1l6ZmhhZFV3UzBNLzA2Sk1zbkFw?=
 =?utf-8?B?ZGNncThiN0k1MUoxbFNVektqQVJKZXdkY2VITW41cXYxUVEzR1dvSnBXODZy?=
 =?utf-8?B?d3NkQUMxbmd1Y2s1akFhcEgxYjg2K3h3VVNWWU9PaVhlTFJocjBCYjhVZGo4?=
 =?utf-8?Q?sBBsMN0tggyXVStEqjeZxW8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1RFUEYxS0dsamMxenNnQ2tNdmxnWmQvc1FlRGZ4a2QvYXY3azBkTlYvRzJS?=
 =?utf-8?B?YU1Bb1pwY0loN2xJT09heUxlSExhQVFWYXhFSjYwUm1lZ0tMZGJhK0o1VEdO?=
 =?utf-8?B?dnZaZS8wSURPRHJZcFZKaDUvbE9kektRTFF0aVNEaCtza2xxR0xYeGVxL1lW?=
 =?utf-8?B?QTFNbUR2N3g1VllBNkRqK0o4eXFraTZtUUxaMFVrUHV6V2FYZ3VVVmtON1VD?=
 =?utf-8?B?M296SXRtekpEOHF4cUMreXVrK3B3NkRmUy9qZUxIMDFGVXZHQWhxZDMvS1gr?=
 =?utf-8?B?VnN6cW1rR3JsVm0rNVFZVjRSVFRpUGlLdGg4RW04ZXZHYXJuSUUrSWFSYmlT?=
 =?utf-8?B?L3pKOVdYN2s5TmxZK3RNdkdHZHQvSys4N0x4VDd5RU84dGY3dUlCdTRhRFRs?=
 =?utf-8?B?bTQrdmh6NzY1Zm12LzV6Ukd4cm1oZGNWUUZTMXpDQTFhMEJIZ1FBNVlUUFdQ?=
 =?utf-8?B?Z1ZIK1g3dFppamNNSW9HZE5XZVdWTnpPZjR1MDlkSXhNekpoZHlpYjlTMS9B?=
 =?utf-8?B?em9CeFRvbHE2clBxTWFKcVl5SVNZZnBGWld2NGI3TXEva3Nkd0Q4bllyaG1N?=
 =?utf-8?B?L29zT2g4aDF4dzlSZ284NENUdXNWQVB6RXJvMXRIUTNOYTNzOTRsazdwby9Q?=
 =?utf-8?B?S21CamRsY0ZVUDhOWnBZNnVFSWNmUmVNK0ZpOC9sMFo2cW0za0lvTmE3UkxX?=
 =?utf-8?B?OTE4ZjFUYkRJZkM2SG1LRWRUcEdBeEtOMVhwei9peGVxaCt2OWdqZFFyQnFR?=
 =?utf-8?B?Lzl6MmhpMWltWmJ3emNiczA3cU84NkFEV3U0NmdPM2lTbEhNNVdVaVN6a1k1?=
 =?utf-8?B?WXJNc29LckRNNWVlMVF0RXJ4YTZZcS9hbi9NV3hBM1J2UUhVTWh4elVyWEZi?=
 =?utf-8?B?UFE4ZXhWSXlneFdNK0g3L1oxTjVkNmlBMWlJQWpNd0k0ZHluY3UyQlVZeEN4?=
 =?utf-8?B?U2FtK2QrZzZrYzYydC9SV0FoZ2cxTVpOQUVUOXpoZit3V2RSOU9OSkxscXYy?=
 =?utf-8?B?MUE2OWRETWNFU3BadGVXMTlLN21kMTZkeHRwVC9RUHdVTmp5TXU1OXVkeVZt?=
 =?utf-8?B?VkRDN0FjQ0ljbUQwblRoV0Nlc3hPdHRXelQvMkpYRkxWbStEZ1I5YmM3cUtN?=
 =?utf-8?B?V1kwYkFrNnZMbEVtV3dLQ0RtK3J6Z2g0ZUtGaG13QzAxRWFLM0VPK0hxNHFv?=
 =?utf-8?B?c2ZQYU0ydndWTzUxRHJSK3Rhc0ErWTlLNG5IOTYvVlgrTXM0ZzlCb0pBTFhU?=
 =?utf-8?B?c2h4YjhmazFZWFJ0cmhteWQrK0ZZa1RvbUkxWVNGaUtSYVJ2cjY5eWhjeXBl?=
 =?utf-8?B?VE9tMm5HdmFvUDNMZUUwYWwxVEppOERGWTFxcERVbmpjWFRMS2E5ZFdZRVVD?=
 =?utf-8?B?V2VLL0M5UTg2STZOWDBvRWlhZ1Z0QlhxWGUyUmFvNEVxVHk2dHNwV1F0TDdB?=
 =?utf-8?B?NWlNdms3dldYR0s5SW1uRlFxS1BVVDZ2K3BFc0JGMDAvQ00vSzF2dVVNSUhN?=
 =?utf-8?B?TnhPcHdDa1BYMVI3QUovTVdSaUxjQmcrKy9ydGUxTFBVRVVLV1FFZ0ZySDRC?=
 =?utf-8?B?TmZ3bWFnQjJrVk5WcC82UC9HakNHMFpjU1JvaElzd0FoRDBmZ3kreXJEMWJE?=
 =?utf-8?B?eXhHU0YwY0Jjc1JoNW9zZ0Jma1IvdWtFREVHVEZRVUYrc0JtaTYrODBRUzNk?=
 =?utf-8?B?VEEyM2FQbzIrOEFrNy9PelJDRE1IaEdpRzRMdWRFTGRyVHBxQ0llL1RvV0Rj?=
 =?utf-8?B?clpqNWlHczE0VTFnSjQ1WldMOGl1aXllN2JsYWZtMmRjbGEvYmREY1o3Sm9h?=
 =?utf-8?B?V0ZGVlN2WFRiVVRjNnRIbS8zWWN4UkdEWHZJNlpxRWtkd3VFdmx0Uk1NY1oz?=
 =?utf-8?B?dFBZb1NqUjNKSmpiejdtczZkTVlRTzZPdVZDbks0VlB3T3pQL0VnOGsxRlRJ?=
 =?utf-8?B?RHk0cGdsUmw3RVlOdXdIQUw5dWE1V2l2VXVySk1BR2FjVXJPWU5EVWFSbHFP?=
 =?utf-8?B?ZFpSZWRHbGdXRUR3V0daK0dwc0YzWndJTm1QV0RYNWJWOVRBbWtLYlA5ZCtX?=
 =?utf-8?B?N09nWHBsOG9LRTMwMDIycld3Y3Y0Uml4UEd6Ni9wcUdsZG1yVTZUUXo0OVdt?=
 =?utf-8?B?MXFyalIrSEJaeHlLQjdMUzNQN1Q5eDRXck9OejJ4SVZHbG0zdG9HZGFBcEhN?=
 =?utf-8?B?bjkydmRlbTJtY0FSNFdEVE9WcHVLei81L1cvMStsczE5bWt5S0RuNjJ4eHZN?=
 =?utf-8?B?a0xqWGF1VWdVRlBDUzBqeWNPOGk1SmJUWGYwU21GOVFSV2owQ051NENrNTZE?=
 =?utf-8?B?bXNkaHVTMDdFQ0ZPaTdHN0NkaUczVm9INzBsQ2M4TVlpaWhLRzd3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d591e6b5-ad75-474a-d8ff-08de6b07c506
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 13:57:04.7653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zOhW4lzyti9Rso3qUabF00XT0H/pWupFGins/B0z+qvmO+Gcrlc2neuAde2I5K44T/K4yb3L0Pjyuuv+xXSyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMyBGZWJydWFyeSAyMDI2IDEwOjM5DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29s
aW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52
aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGph
bkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOS8yNF0gaHcvYXJtL3RlZ3JhMjQxLWNtZHF2
OiBtbWFwIFZJTlRGIFBhZ2UwDQo+IGZvciBDTURRVg0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFt
ZWVyLA0KPiANCj4gT24gMi82LzI2IDM6NDggUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+
ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+DQo+ID4gVGVn
cmEyNDEgQ01EUVYgZXh0ZW5kcyBTTU1VdjMgd2l0aCBzdXBwb3J0IGZvciB2aXJ0dWFsIGNvbW1h
bmQNCj4gcXVldWVzDQo+ID4gKFZDTURRcykgZXhwb3NlZCB2aWEgYSBDTURRViBNTUlPIHJlZ2lv
bi4gVGhlIENNRFFWIE1NSU8gc3BhY2UgaXMNCj4gc3BsaXQNCj4gPiBpbnRvIDY0S0IgcGFnZXMg
YXMgZm9sbG93czoNCj4gPg0KPiA+ICAgMHgwMDAwMDogR2xvYmFsIENNRFFWIHJlZ2lzdGVycw0K
PiA+ICAgMHgxMDAwMDogR2xvYmFsIFZDTURRIHJlZ2lzdGVycywgUGFnZTAgKGNvbnRyb2wvc3Rh
dHVzKQ0KPiA+ICAgMHgyMDAwMDogR2xvYmFsIFZDTURRIHJlZ2lzdGVycywgUGFnZTEgKGNvbmZp
Z3VyYXRpb24pDQo+ID4gICAweDMwMDAwOiBWSU5URjAgbG9naWNhbCBWQ01EUSByZWdpc3RlcnMs
IFBhZ2UwIChjb250cm9sL3N0YXR1cykNCj4gPiAgIDB4NDAwMDA6IFZJTlRGMCBsb2dpY2FsIFZD
TURRIHJlZ2lzdGVycywgUGFnZTEgKGNvbmZpZ3VyYXRpb24pDQo+IHRoaXMgc2hhbGwgcmF0aGVy
IGJlIGludHJvZHVjZWQgYWxvbmcgd2l0aCB0aGUgd2hvbGUgbW1pbyByZWdpb24uIEluDQo+IHRo
aXMgcGF0Y2ggeW91IGZvY3VzIG9uIHJhdGhlciBWSU5URjAgcGFnZTANCg0KT2suDQoNCj4gPg0K
PiA+IEdsb2JhbCBWQ01EUSBwYWdlcyBwcm92aWRlIGEgVk0gd2lkZSB2aWV3IG9mIGFsbCBWQ01E
UXMsIHdoaWxlIHRoZQ0KPiA+IFZJTlRGIHBhZ2VzIGV4cG9zZSBhIGxvZ2ljYWwgdmlldyBsb2Nh
bCB0byBhIGdpdmVuIFZJTlRGLiBBbHRob3VnaCByZWFsDQo+ID4gaGFyZHdhcmUgbWF5IHN1cHBv
cnQgbXVsdGlwbGUgVklOVEZzLCB0aGUga2VybmVsIGN1cnJlbnRseSBleHBvc2VzIGENCj4gPiBz
aW5nbGUgVklOVEYgcGVyIFZNLg0KPiBNYXliZSB5b3Ugc2hhbGwgc2ltcGx5IG5hbWUgaXQgVklO
VEYNCj4gPg0KPiA+IFRoZSBrZXJuZWwgcHJvdmlkZXMgYW4gbW1hcCBvZmZzZXQgZm9yIHRoZSBW
SU5URiBQYWdlMCByZWdpb24gZHVyaW5nDQo+ID4gdklPTU1VIGFsbG9jYXRpb24uIEhvd2V2ZXIs
IHRoZSBsb2dpY2FsLXRvLXBoeXNpY2FsIGFzc29jaWF0aW9uIGJldHdlZW4NCj4gPiBWQ01EUXMg
YW5kIGEgVklOVEYgaXMgb25seSBlc3RhYmxpc2hlZCBhZnRlciBIV19RVUVVRSBhbGxvY2F0aW9u
LiBQcmlvcg0KPiA+IHRvIHRoYXQsIHRoZSBtYXBwZWQgUGFnZTAgZG9lcyBub3QgYmFjayBhbnkg
cmVhbCBWQ01EUSBzdGF0ZS4NCj4gPg0KPiA+IFByZXBhcmUgdGhlIFZJTlRGMCBQYWdlMCBtYXBw
aW5nIGJ5IG1tYXBwaW5nIHRoZSBrZXJuZWwgcHJvdmlkZWQgcmVnaW9uDQo+ID4gd2hlbiBDTURR
ViBpcyBhY2Nlc3NlZCwgd2hpbGUga2VlcGluZyBhbGwgQ01EUVYgTU1JTyBhY2Nlc3NlcyB0cmFw
cGVkDQo+ID4gaW4gUUVNVS4gVGhlIG1hcHBpbmcgaXMgbm90IHlldCBleHBvc2VkIHRvIHRoZSBn
dWVzdCBhZGRyZXNzIHNwYWNlLg0KPiA+IEEgc3Vic2VxdWVudCBwYXRjaCB3aWxsIGluc3RhbGwg
dGhlIFJBTSBiYWNrZWQgTU1JTyBzdWJyZWdpb24gZm9yIFZJTlRGDQo+ID4gcGFnZTAgb25jZSBI
V19RVUVVRSBhbGxvY2F0aW9uIGNvbXBsZXRlcy4NCj4gDQo+IFNvIHdlIGFyZSBsaWtlbHkgdG8g
bW1hcCBhIHBhZ2Ugd2hvc2UgY29udGVudCBpcyB1bmRlZmluZWQgdW50aWwNCj4gSFdfUVVFVUUg
YWxsb2MsIGlzIHRoYXQgY29ycmVjdD8gSW4gdGhhdCBjYXNlLCB3aHkgZG9uJ3Qgd2UgZG8gdGhh
dCBvbmx5DQo+IGFmdGVyIEhXX1FVRVVFIGFsbG9jPyBQbGVhc2UgY2FuIHlvdSBjbGFyaWZ5Pw0K
DQpDb3JyZWN0LiBUaG91Z2ggd2UgbW1hcCBpdCBoZXJlLCBhcyBtZW50aW9uZWQgaW4gY29tbWl0
IG1zZywgaXQgaXMNCm5vdCBhY2Nlc3NlZCB1bnRpbCB3ZSBkbyBIV19RVUVVRSBhbGxvYyhwYXRj
aCAjMTYpLiAgQ291bGQgZGVsYXkgdGhpcw0KYXMgd2VsbCBJIHN1cHBvc2UuDQoNCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgfCAzOA0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBody9hcm0vdGVncmEyNDEtY21kcXYu
aCB8ICAzICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdGVncmEyNDEtY21kcXYuYyBiL2h3L2FybS90ZWdyYTI0
MS1jbWRxdi5jDQo+ID4gaW5kZXggNTk2YjFjNTU5NS4uOTdjOWI5YzhkYyAxMDA2NDQNCj4gPiAt
LS0gYS9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+ICsrKyBiL2h3L2FybS90ZWdyYTI0MS1j
bWRxdi5jDQo+ID4gQEAgLTEzLDE0ICsxMyw1MiBAQA0KPiA+ICAjaW5jbHVkZSAic21tdXYzLWFj
Y2VsLmgiDQo+ID4gICNpbmNsdWRlICJ0ZWdyYTI0MS1jbWRxdi5oIg0KPiA+DQo+ID4gK3N0YXRp
YyBib29sIHRlZ3JhMjQxX2NtZHF2X21tYXBfdmludGZfcGFnZTAoVGVncmEyNDFDTURRVg0KPiAq
Y21kcXYsIEVycm9yICoqZXJycCkNCj4gPiArew0KPiA+ICsgICAgSU9NTVVGRFZpb21tdSAqdmlv
bW11ID0gY21kcXYtPnNfYWNjZWwtPnZpb21tdTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXZpb21t
dSkgew0KPiA+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAr
ICAgIGdfYXNzZXJ0KCFjbWRxdi0+dmludGZfcGFnZTApOw0KPiA+ICsgICAgaWYgKCFpb21tdWZk
X2JhY2tlbmRfdmlvbW11X21tYXAodmlvbW11LT5pb21tdWZkLCB2aW9tbXUtDQo+ID52aW9tbXVf
aWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSU5URl9SRUdf
UEFHRV9TSVpFLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY21k
cXYtPmNtZHF2X2RhdGEub3V0X3ZpbnRmX21tYXBfb2Zmc2V0LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmNtZHF2LT52aW50Zl9wYWdlMCwgZXJycCkpIHsNCj4g
U28gSSB3b3VsZCByYXRoZXIgZGlyZWN0bHkgaW1wbGVtZW50IGlvbW11ZmRfYmFja2VuZF92aW9t
bXVfbW1hcCgpDQo+IGhlcmUuDQoNCkkgaGF2ZSBleHBsYWluZWQgdGhlIHJhdGlvbmFsZSBmb3Ig
bWFraW5nIHRoaXMgYSBjb21tb24gaGVscGVyIGluIHRoZSB0aHJlYWQNCndoZXJlIHdlIGludHJv
ZHVjZSBpdC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoYXQgcmVhc29uaW5nIG1ha2VzIHNlbnNl
IG9yDQpub3QuDQoNCj4gPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB1aW50
NjRfdCB0ZWdyYTI0MV9jbWRxdl9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwNCj4g
dW5zaWduZWQgc2l6ZSkNCj4gPiAgew0KPiA+ICsgICAgVGVncmEyNDFDTURRViAqY21kcXYgPSAo
VGVncmEyNDFDTURRViAqKW9wYXF1ZTsNCj4gPiArICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxM
Ow0KPiBpbml0IGlzIG5vdCBuZWVkZWQgc2luY2UgeW91IGRvbid0IHRlc3QgaXQuDQo+ID4gKw0K
PiA+ICsgICAgaWYgKCFjbWRxdi0+dmludGZfcGFnZTApIHsNCj4gPiArICAgICAgICBpZiAoIXRl
Z3JhMjQxX2NtZHF2X21tYXBfdmludGZfcGFnZTAoY21kcXYsICZsb2NhbF9lcnIpKSB7DQo+ID4g
KyAgICAgICAgICAgIGVycm9yX3JlcG9ydF9lcnIobG9jYWxfZXJyKTsNCj4gPiArICAgICAgICAg
ICAgbG9jYWxfZXJyID0gTlVMTDsNCj4gbm90IG5lZWRlZCBlaXRoZXINCj4gPiArICAgICAgICB9
DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+
ICBzdGF0aWMgdm9pZCB0ZWdyYTI0MV9jbWRxdl93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBv
ZmZzZXQsIHVpbnQ2NF90DQo+IHZhbHVlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBzaXplKQ0KPiA+ICB7DQo+ID4gKyAgICBUZWdyYTI0MUNNRFFWICpj
bWRxdiA9IChUZWdyYTI0MUNNRFFWICopb3BhcXVlOw0KPiA+ICsgICAgRXJyb3IgKmxvY2FsX2Vy
ciA9IE5VTEw7DQo+IHNhbWUgaGVyZQ0KPiA+ICsNCj4gPiArICAgIGlmICghY21kcXYtPnZpbnRm
X3BhZ2UwKSB7DQo+ID4gKyAgICAgICAgaWYgKCF0ZWdyYTI0MV9jbWRxdl9tbWFwX3ZpbnRmX3Bh
Z2UwKGNtZHF2LCAmbG9jYWxfZXJyKSkgew0KPiA+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnRf
ZXJyKGxvY2FsX2Vycik7DQo+ID4gKyAgICAgICAgICAgIGxvY2FsX2VyciA9IE5VTEw7DQo+ID4g
KyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgdGVn
cmEyNDFfY21kcXZfZnJlZV92ZXZlbnRxKFNNTVV2M1N0YXRlICpzKQ0KPiA+IGRpZmYgLS1naXQg
YS9ody9hcm0vdGVncmEyNDEtY21kcXYuaCBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5oDQo+ID4g
aW5kZXggNmVhMDA4N2Y2MS4uOTRiZWY4Yzk3OCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdGVn
cmEyNDEtY21kcXYuaA0KPiA+ICsrKyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5oDQo+ID4gQEAg
LTI5LDggKzI5LDExIEBAIHR5cGVkZWYgc3RydWN0IFRlZ3JhMjQxQ01EUVYgew0KPiA+ICAgICAg
U01NVXYzQWNjZWxTdGF0ZSAqc19hY2NlbDsNCj4gPiAgICAgIE1lbW9yeVJlZ2lvbiBtbWlvX2Nt
ZHF2Ow0KPiA+ICAgICAgcWVtdV9pcnEgaXJxOw0KPiA+ICsgICAgdm9pZCAqdmludGZfcGFnZTA7
DQo+ID4gIH0gVGVncmEyNDFDTURRVjsNCj4gPg0KPiA+ICsjZGVmaW5lIFZJTlRGX1JFR19QQUdF
X1NJWkUgMHgxMDAwMA0KPiBjYW4ndCB3ZSByZW5hbWUgdGhhdCBpbnRvIFZJTlRGX1NJWkUuIFJF
RyBkb2VzIG5vdCBtZWFuIG11Y2guIEJlZm9yZSB5b3UNCj4gdGFsa2VkIGFib3V0IENvbnRyb2wv
U3RhdHVzIHZzIENvbmZpZ3VyYXRpb24uIEJlc2lkZXMsIEkgYW0gbm90IHN1cmUNCj4gaGF2aW5n
IGEgZGVmaW5lIGJyaW5ncyBtdWNoIGluIHRoYXQgY2FzZS4NCg0KT2suDQoNClRoYW5rcywNClNo
YW1lZXINCg==

