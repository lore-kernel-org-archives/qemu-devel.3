Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EE0CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkIP-0001qo-OX; Tue, 28 Oct 2025 10:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDkIK-0001pk-Ei; Tue, 28 Oct 2025 10:03:29 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDkIF-0008HG-RC; Tue, 28 Oct 2025 10:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro+y1pg3d7QyIkQmq8/EAG/K6l1iU80TRj+l8rOMasT6N2n9oXqiIvHQFBIwelPVwY9BvV8SPe+jGkBJ7MsTJqjIjlypZEU/51Av5cmwifaBO1fv9pw+CGhgAQYMZU89GylUyf/dxAoRga22yh4LDwYWHrgrL+Pp0nAr7YJRdwwrebE3g6uRm5ildF+aqBUL/20Fkw120fYTNzAea5PPYApFYVrv3rE7mh8/zCTozcEIMFQnPNt3s1Z8ykuKq0HkC936DsDHls1tsYjWsuOl9CcMUC+hz41/ooeEm7FTX7LGF6nF22OLjRrClcFKAqoxopG8N1X95jTery4fW33sLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcuD4KLOVXJxb6I7SKWYoJuzlkJuhuGm8N99Oyi74Gw=;
 b=j37RkZ+nMNkNJTSUq2aP8EPbKpiU/q8PHs1KWdsn8Ymdq/dJNvWsXdRYDZoPxt28l4RGRNZTTLhmGVd8NulmAuEA6RLwnWiw/h/wWCLSIfa++8W6hu5pwQqNwVG8oEbDqqgn+HNemAPFJNdVGttPi7UM+DY5ku0dceMMlPI9OfqzFQ7N/G0NYdaqhzUgxeXCXvWEK8aIW2BuFeBskI5UdIiW/GmJvw7I4iHZrYPQbOIKNbsT9KDRW2CYrriYkKyL2mKZyHj50uQiBMiLVABlboggRSBVnnKBTNEjozf3ty+IVO8OghK5prTIaqGZizdMa7kuBmu4ytw1w54s9UA9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcuD4KLOVXJxb6I7SKWYoJuzlkJuhuGm8N99Oyi74Gw=;
 b=s/gM04Y+EuQEPtxond69HeLcIzYSHsHff3pwQtBA0hYM0KyyasP4p2uicwKopCkXoSrGUyzhfr9tZQXvVdVrz5K+hPeZzXDyH3LYxkNMQH0VgETZICCp+mOt1l+xqp4S8YmdlxXtDclAwE67icG2x8HPA6mgzdKIybwbwDSmfqQXrpQDmqIH8/8AYB6mVrXH130aYJd0cMdQ1P/WM0hXbLjS/NoBWD7cyrDQAxOMsB0E4Rm/SZknSaHTDAMWHmeMphsdpcEOS9z4ui////p0ysoXB96UNE0qgJa/qdX25bFikWZMIwQgDh5i65kYOSZdC0lkDB4vI1ChqztDZVIl/w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 14:03:07 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 14:03:06 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Thread-Topic: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Thread-Index: AQHcR2MFngFyUDoiY02aRyWaAGA96rTWO04AgAAG1gCAAAA/wIAABqcAgAFMrwA=
Date: Tue, 28 Oct 2025 14:03:06 +0000
Message-ID: <CH3PR12MB75488DAE17F657C024933593ABFDA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <CH3PR12MB754817705781C75530974DB1ABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <017783c8-0866-4d59-b94a-431041714176@redhat.com>
In-Reply-To: <017783c8-0866-4d59-b94a-431041714176@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB8995:EE_
x-ms-office365-filtering-correlation-id: b1226f72-17cb-4551-5f5a-08de162ab83a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?S3VubEY3UFpsLzdSQnpLUGdJalZ4NThDODRVeFBjTERaWWNuWWh5K0gwWVNH?=
 =?utf-8?B?U3prampLb2drUHQ3Y094NXVLVW1BRUFRdDFNRkV3RGJETW82bXRNZnFMelNw?=
 =?utf-8?B?QkE1Rm85R3o4dnFzSWcrZG5TRDFJN21ibGx4c3pEamUyVjNzTE1ScmlLdWMv?=
 =?utf-8?B?cjNyVTRpM2U1MERxNUg3bm5mMFZGQzJOT25JK0lsWXZIWlVBaEJOZG55S1Zr?=
 =?utf-8?B?YXZYTjFranN3M0lCckNrZlNLVkQ1U0xTUlp4ZlBjZEdZQ2R4Yjg3Ly9RY3RX?=
 =?utf-8?B?akhISnBEMG9IYWp5ZFRISGc4bTUvUWhXMHVQaDVINjRHZmthd1RvRlBYVStR?=
 =?utf-8?B?aGJtdWdKYUg2Z3paWGpvZGE3ZE83OEs3N0x4Q3dpNGNhZWhmV05XdW9sVUE3?=
 =?utf-8?B?N2txWjMzTW5uRy82R1BNeGJiRGVLaUMrQThMZ01mUVpadWNqdFIzZkVKc2Rl?=
 =?utf-8?B?NWE4SStWMlNKekhRQ0tqUXlySU1vVFBOMUpYc09UdVN5cmFoWVU4UlZEcDhY?=
 =?utf-8?B?VWpIUFJiTGkzeTJmMjlUSDBMWm9oaDd4cS93aCtjTTZ6eUw0bnk1QzZHZ2Rs?=
 =?utf-8?B?L2JWbCtlWk5GNEFaclRzdkpFd0lhV3Qyc3NRLzR0ckMvL1dUUWYwYzB4NFhK?=
 =?utf-8?B?NVM4TnRvNWd4RWZUTm1qWXFYSldNMkNMMER6NjkrWFljN0tscUIrVFZ5enh5?=
 =?utf-8?B?ZkpuNjZ5VVRzUmdFc2tncDkvcnVtWmd4ODcveW1HWTVsVEJyTERZa3krYmth?=
 =?utf-8?B?aU9oYVNxK2crMUFVYkY1MEVkN1Q3WkIrQ1VzSG1WM1lhS0dWTm4yVGFFNWds?=
 =?utf-8?B?ZEpvdnN0ZnZEbmowQ2pOZzFLckVPTDdoQy9QZzNPbklaSElIZE03OXZhUEdp?=
 =?utf-8?B?djVMZnlNZ2NJUy90Q0w4Qm8zdG5OeXdTQ0hqL0dDUGxoMUVRU1I3TS82aUlG?=
 =?utf-8?B?bDdaOFM1enJad1UrTVRmRHEzSHVUMWFjdzlzUDV4eGZsZkErWnlmQmRhWElR?=
 =?utf-8?B?RlAwdHBtTjhrbVppN0lLRlJ2WmE1RlpqVndvZDJyRWIxYmZEV2txYXo2Q1lE?=
 =?utf-8?B?TE1pM3lwTlRFeGFtOVI0b3NmcHB4elN4KzZWVmdnKzUrbW5mWmFrSHk1MXFw?=
 =?utf-8?B?ZEtwckVId29COHRQYzNONm8zUURpSlpwS3JucnJtR09vU1hwRGRwNjV6THRt?=
 =?utf-8?B?b24wUUFrVWl1RjhSWWc2clJMZFJwaG9uSE9UeVZKOU4vVHNDMmJMbi9mNlhj?=
 =?utf-8?B?YVltdW5LSDlyMkFPb3lSM2VpcFVlaFowWWF2NXI2Y0tCSVlFVmE1aVBxNVhr?=
 =?utf-8?B?WWs1U3lDZmtuZDdTSFUvL0JxYnZCWkJFUVFRb05DdFgxMGNReHA1NXZhOGJN?=
 =?utf-8?B?cDZXWFhKenliUG9PUExKd3NwOG5EWGdkQUtlMncvOGdPczl1aUliTnMzZGxZ?=
 =?utf-8?B?a1A5SmhvbnI5U05JNlBPOHhsODludUNISVhwTlY0S28yQ3N4M0VzMUVDK2hW?=
 =?utf-8?B?cHRFaUxMRFVaOWxZRTlSZDYvSVZPb1p4TURsc0pDZWhSS0dpdUZQVFlHc2RH?=
 =?utf-8?B?Q2x6T1JFcGRDTGxTYmhidHMzYUNQMUIrQkdKSHBaQlVZRzREdzVxZ2l2YzRI?=
 =?utf-8?B?UjBSNlg1QTkra2Jkeml4UEpLMzFsdXNtSDh1M3NDZTg4bE9jNnFjNWc3by9o?=
 =?utf-8?B?WENTdHlPbWdGWU9iRXNjaGVVdUtEQWVEVU1uVzYyNUp5RlVJVEVZWVFQVnVC?=
 =?utf-8?B?Z25KUDIrYUVUaUM4Ym8wYkpsQUt6Y2hKWDRNZWJYaTd5dzNnMEMyNHNiQTN5?=
 =?utf-8?B?VDFZZHprWVFLZE9PMktJdnNSazNhNmNKRHNVRHhpS1pNZkRvZVlUWWRkRE9U?=
 =?utf-8?B?Y29yczVaUXJ5azRvcUU0dEJuR2huOXZScGtlc2l5aXNCWEpOQmNOa3VoeWZM?=
 =?utf-8?B?NWNSRzRMV2pvN2dTTDM4c3hFZWhmc0JNZVhMdHdQbDlHUTRCSFJVWEdmaEFX?=
 =?utf-8?B?QWErTE9NeVIwK0VrYzRBeEovc3J3TVZkV2pJaTg2bWNkaE1IN1pnOXliQ3lJ?=
 =?utf-8?Q?y2kjP1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkFMK1VRMkRxcm9tRWdrZkJzcENjRlFWT0ZtMTNNZm1sVDdqN0JBTlc5K0VM?=
 =?utf-8?B?L3J1U1l6SGRRSTJWL2RhSXBiclFpMDhIaWY2cnh1MG5NZlMvOFd5ckxpcDVB?=
 =?utf-8?B?VTR0U2taQ2J1eEJiYXhtRW9weUJvMDJjc2tKS1pYeEd1ZkR0cC9LVGlNSlpt?=
 =?utf-8?B?cXdSM1MzQ0x6NC9RTWtiVnNtUENNT24raXN5N0Ivd1c2azI2d3BrbHhUOEF1?=
 =?utf-8?B?eklXcmFBem5mOUxBZmx4c05XTUdYZyt1U09GU3prNUhORzZhcmtVa1JxWUFy?=
 =?utf-8?B?U3J5Nlo0V0l2TmI1VXNlY2F0V29ma3U1NnBVZFZTSFUzWERxZWlieTJndDho?=
 =?utf-8?B?cGFhU0daYWdYUGRrd0M4dnA4b2ViNEZubmwyUFNLbkZKRGxteUZIMDlUSHND?=
 =?utf-8?B?S3F5WWpVaE9pendNeEVpMStjc1hjaGNXREI3ek5sQjJFemJ6MEhHYS9EU0VX?=
 =?utf-8?B?ajduRzJqbnVFc1Y5bW5ReFA1OHdNdERuMVgvVHlyZGErejJFVytKU1Q2TXpx?=
 =?utf-8?B?bGp3c1FRcitqdnhEbktwb0VpRExDVU81REpDRTJ3YUlxaFl2cGJ1YUtjQjkw?=
 =?utf-8?B?aVA1NTVnUW1IdHV0S1hWdkpyZkU3a1NmUS9KVlNIVGxwOVdUb2lsVllZQ3FK?=
 =?utf-8?B?UURZUmJMNktPMjh3dkFEdDFNOVRvZXFXdTZDNVRRMXZOeG96aGprQytSMFVF?=
 =?utf-8?B?ZnZHcEJ0bkJBMk1acEFZMjhFeUhzNUYzWGZPbUttK0dUUENLd1lmQ0xOMHd5?=
 =?utf-8?B?V1pWZ2orRlB0aE0wNkc5cndyaTExSnErbTlCVFpKeGFCZy80Q1cxby9KM05q?=
 =?utf-8?B?dlVmVktHNFBQMlZOdnVZdGdHRVd3dThZYWVxV3JIWDVHQjF0eTVHMkdWZzRt?=
 =?utf-8?B?OC91M0l6bWRzNG1Kd2pVSng1ZnNuTEhIQmN0L0VidndiL1dxOC9MbUd3WDBN?=
 =?utf-8?B?dVNHM0NUZXNSYkJ0cHNIU1ZCWUo4QTQ2RHY3c3BFUDFrWkZhb0hIQ3BGWnZC?=
 =?utf-8?B?eVJVOStMVHBwUVI1UnR4TnlaWVNMdHJ3VVRuU0x1dHFRbHQxbmk0dzVaOUNM?=
 =?utf-8?B?bkJic3dPQit4bG9aaUkyMXBhRGJzZ0lqcnNRTWN2SWhsSmRhYnVwRlZkZXBi?=
 =?utf-8?B?Zzg4QkZ5UFBONFBQSWNXbW9HcUs3RDNHN0pKaVA0b0tWMWY5QXVucTVvTEdy?=
 =?utf-8?B?eFBWbW4zQ09lRWowM0RwZHZ4c29GaHFOeCtKTGRhRlFQeFpkR0hYRlhVYytX?=
 =?utf-8?B?SHlUS0ZDZGY4OXFNaVhGRzlTMkM4SC9yUm04QjVvVG5lcG1NQlhsZ0U1SFNj?=
 =?utf-8?B?Z0U4TXA0bGVkeGpSeC9YdU85a1lQS0I2eG1MdFp0L3lnaU9sQmhKOGNlRmp2?=
 =?utf-8?B?ekxGMlRmRFE2K1JUU1l4SzR6dzZOMURvRVFxQ3MxN3d5RndyeW53dVRkWTRJ?=
 =?utf-8?B?cGQydVE4SWNVRUk5Z1FqRStzMERkVjNzK0hUN2VrRGhOMS8rOWt0cnlacTlo?=
 =?utf-8?B?V1BlRHdFOC9EbWkvNXZJcHdkaHhYK1V2czlXWHpFWEd5Y0dQN0lTZjNud3Vn?=
 =?utf-8?B?U1VzTDBTdGdGUVFGNlByOGd3cWI2RlVmQ3ZSTHZiTjljZndzN1BMbmswNURK?=
 =?utf-8?B?RW1XSTlwYm5uOERiWFkzVDBQaVJuRGV4ak5YbUR5Z1V2OXJBZHBaTk5EUDk5?=
 =?utf-8?B?R1lxK0pvbFBtNVdKbFk3dC9QVW9Gd0tWTHIrdERsV0kzcmIyeWIrelpDeURl?=
 =?utf-8?B?bVJoQ1c5bDF1QVgvTlhzdFlCTjFyVUlNU3JKT0srZ2JwSUFNNW10bHJzZENG?=
 =?utf-8?B?cFhNdVpJQU1vRFhyK3hSblBjTHJ4QWh6djBMbkd4OWI4SVBrVUdhbWlscnlY?=
 =?utf-8?B?RmoyQ0VLbTlST2gyVzY3c2cvTjNsMWF2eFkyc1V4OUs5OEFlcUV4dnBhcTVI?=
 =?utf-8?B?K3NmTUlhNkNlUTNyL3Rid2k4czkyRVFDVHBTY0N5RnRjcHN6YUJsc2VyKytL?=
 =?utf-8?B?djZpQUExMGpNQXgweG5uenZWUlRmK0h0QnhjbUVHRXNTVTNIZmM5bFRBY2pt?=
 =?utf-8?B?d2JkNVV3N0Z5OXVqaHVTakhxb0VKWFcyU1N1SGZJcWcrZ1FEU2J1YXBONTBP?=
 =?utf-8?Q?ooRr+w58Wl8zK6axGJSUnl3XL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1226f72-17cb-4551-5f5a-08de162ab83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 14:03:06.7905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHgUm8srsuopSITrnKR+vChaeGevhBctk15dKvMUpSYpilXJvgP+kDtbsVR42/rlleHtfNjDind/VO2e+cQL1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDI3IE9jdG9iZXIgMjAyNSAxODow
Mw0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBOaWNv
bGluIENoZW4NCj4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IENjOiBxZW11LWFybUBub25nbnUu
b3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsg
SmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsg
YmVycmFuZ2VAcmVkaGF0LmNvbTsgTmF0aGFuIENoZW4NCj4gPG5hdGhhbmNAbnZpZGlhLmNvbT47
IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IHdh
bmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWkuY29tOyBqb25hdGhh
bi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gc2hhbWVlcmtvbG90aHVt
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIyLzI3XSBody9hcm0vc21tdXYz
LWFjY2VsOiBBZGQgc3VwcG9ydCBmb3IgQVRTDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDEwLzI3LzI1
IDY6NTQgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQu
Y29tPg0KPiA+PiBTZW50OiAyNyBPY3RvYmVyIDIwMjUgMTc6MzgNCj4gPj4gVG86IE5pY29saW4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPj4gQ2M6IFNoYW1lZXIgS29sb3RodW0gPHNr
b2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gPj4gYXJtQG5vbmdudS5vcmc7IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOw0KPiA+PiBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOw0KPiA+PiBiZXJy
YW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBP
Y2hzDQo+ID4+IDxtb2Noc0BudmlkaWEuY29tPjsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3po
b3UxQGhpc2lsaWNvbi5jb207DQo+ID4+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gPj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiA+PiBzaGFtZWVya29s
b3RodW1AZ21haWwuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjIvMjddIGh3L2Fy
bS9zbW11djMtYWNjZWw6IEFkZCBzdXBwb3J0IGZvciBBVFMNCj4gPj4NCg0KWy4uLl0NCg0KPiA+
PiBJIHJlbWVtYmVyIHNvbWUgZGlzY3Vzc2lvbnMgd2l0aCBQZXRlciB3aG8gd2FzIGFsc28gcmVs
dWN0YW50IGluIGdlbmVyYWwNCj4gPj4gdG8gaW50cm9kdWNlIHNvbWUgcGFydGlhbCBmZWF0dXJl
IHN1cHBvcnQuIEkgdGhpbmsgaW4gZ2VuZXJhbCB0aGlzIGlzIGENCj4gPj4gZ29vZCBwb2xpY3kg
dG8gaGF2ZSBmZWF0dXJlcyBlbXVsYXRlZCBhbmQgdGhlbiBhY2NlbGVyYXRlZC4gVGhhdCdzIGFs
c28NCj4gPj4gZ29vZCBmb3IgdGVzdGluZyBpbiBjYXNlIHdlIGNhbiBicmluZyB1cCBzb21lIHRl
c3QgZW52Lg0KPiA+IFVuZGVyc3Rvb2QuIEhvd2V2ZXIsIEFUUyBhbmQgUEFTSUQgYXJlIHRoZSB0
d28ga2V5IGZlYXR1cmVzIHJlcXVpcmVkIHRvDQo+IG1ha2UNCj4gPiBhbnkgbWVhbmluZ2Z1bCB1
c2Ugb2YgdGhlIGFjY2VsZXJhdGVkIHN1cHBvcnQuIEnigJltIG5vdCBzdWdnZXN0aW5nIHdlIHNr
aXANCj4gPiBlbXVsYXRpb24gZm9yIEFUUyBvciBQQVNJRCBlbnRpcmVseSwganVzdCB0aGF0IHdl
IHByaW9yaXRpemUgdGhlIGFjY2VsZXJhdGlvbg0KPiA+IHBhdGggZmlyc3QuIPCfmIoNCj4gSSB1
bmRlcnN0YW5kIHRoaXMgaXMgbmVlZGVkIGZvciB2U1ZBLiBOZXZlcnRoZWxlc3MgYWNjZWwgU01N
VSBjYW4NCj4gYWxyZWFkeSB3b3JrIGFuZCBiZSB0ZXN0ZWQgaW4gYSBzdGRhbG9uZSBtYW5uZXIg
d2l0aG91dCBBVFMgYW5kIFBBU0lELg0KPiBUaG9zZSAyIGZlYXR1cmVzIGFkZCBhIHNpZ25pZmlj
YW50IGNvbXBsZXhpdHkgb24gdG9wIG9mIHRoZSBjb3JlIHNlcmllcw0KPiBpbmNsdWRpbmcgZnJv
bSB0aGUgcmV2aWV3IHBvdi4gVGhpcyBwYXJ0aWFsIHN1cHBvcnQgc3VwcG9ydCBpcyBub3QNCj4g
bmVjZXNzYXJpbHkgZ3JlYXQuIEFsc28gSSBoYXZlIG5vdCBjbG9zZWx5IGZvbGxvd2VkIHRoZSB0
aHJlYWQgcmVsYXRlZA0KPiB0byAiW1BBVENIIHY0IDI2LzI3XSB2ZmlvOiBTeW50aGVzaXplIHZQ
QVNJRCBjYXBhYmlsaXR5IHRvIFZNIiB0b3VjaGluZw0KPiBwY2kuYy4gSSBkb24ndCBrbm93IGhv
dyBtdWNoIHRoaXMgaXMgY29udHJldmVyc2lhbC4ganVzdCByZWFkaW5nIHRoZQ0KPiBjb21taXQg
bXNnIGZyaWdodGVucyBtZSBhIGxpdHRsZSBiaXQ6ICJUaGlzIGlzIGEgY2hvaWNlIGluIHRoZSBn
b29kIGhvcGUNCj4gb2Ygbm8gY29uZmxpY3Qgd2l0aCBhbnkgZXhpc3RpbmcgY2FwIG9yIGhpZGRl
biByZWdpc3RlcnMiIDsNCg0KUmVnYXJkaW5nIFBBU0lELCB0aGF0IGNvbmNlcm4gb25seSBhcHBs
aWVzIGlmIHdlIHdlcmUgdG8gYmxpbmRseSB1c2UgdGhlIGxhc3QNCjggYnl0ZXMgb2YgdGhlIHZp
cnR1YWwgY29uZmlnIHNwYWNlIHRvIHBsYWNlIHRoZSBQQVNJRCBjYXBhYmlsaXR5LiBJbiB0aGlz
DQppbXBsZW1lbnRhdGlvbiwgd2Ugb25seSBzeW50aGVzaXplIHRoZSBQQVNJRCBjYXBhYmlsaXR5
IHdoZW4gdGhlIGRldmljZSBpcw0KYmVoaW5kIGEgdlNNTVV2MyB3aXRoIGFjY2VsPW9uLiBUaGUg
dXNlciBleHBsaWNpdGx5IGNvbnRyb2xzIHdoaWNoIGRldmljZXMNCmhhdmUgdGhpcyBjYXBhYmls
aXR5IHN5bnRoZXNpemVkLg0KDQpJIGRvbuKAmXQgdGhpbmsgdGhpcyBwb3NlcyBhIG1ham9yIHJp
c2suDQoNClRoYW5rcywNClNoYW1lZXINCg0K

