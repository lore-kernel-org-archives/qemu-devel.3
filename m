Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3B7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qv-0004hA-CM; Wed, 15 May 2024 03:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qb-0004c9-QA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:47 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qM-0000oJ-SN
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757270; x=1747293270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8grq/D3/2ZZYyfmF7krWIJodD2cmB/YeOpbkvdktkRQ=;
 b=hd2izDj7c1Xj+fyw8ZNgP0BC/IGpXBgBg8Q8qgWNhcx4wDm/5/noEFkU
 mbaePuuJrURnEYPJQXi1oU1pOOJ2LV8wK2E8gzoMzK+VHlbjL3E7Kidna
 Y4zbmDGFu2coiEtu0krMmGMlW+7q+RrJQlm8ZCg8yZulzyymgjkjYaK2D
 1EvR1VfX50nH2KBrpjtFheS5JRkcq0UC5ZKi1UnTgW2YRNnXefibn4vzZ
 CKuZoMPP2tM3W9ka7wiKMGcaD49Q05Xy+UvJNxqka0EI4kNqk4wkOWjC8
 SUMQ396WLZfhKIsoKCGRLO7XQmXC+u7cm4KDakaWJkYog+mIm3y+j3tLG Q==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581804"
X-MGA-submission: =?us-ascii?q?MDG1y+UdqLLOfxbozO9ycBp4QTb2hQajx5VORd?=
 =?us-ascii?q?R9B3hSgSEHLXLcnPplE32UbQGKix3Fosjf4YkMGXzac/GGz4fc8VnnhO?=
 =?us-ascii?q?Vv8Z0BPK2WcgJ4CQFYhJl1IfdF2IpXaLqPsJQb20rjgUkBcdK18CmpEv?=
 =?us-ascii?q?IJM2HcnCUjIzwoxtklv/P3Ng=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 outbound.mail.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEdTi/xeZFyAG1eupNrSiXSC6Zw+YYjszvUeoQ1GY1hEJx+kPbCxoApmB7sOgajPxhMoCqrOPgwDPyCzfZsDVZWmXko0UgzgsSrS7AO1rzit697ig9ANbBYfMaOvC7VpotNoRTtY6I3dU/zLVxBmzrTHHQhoo1BkbSsoW5U2EFZDvlR7fUgvDRECYbSZRI9W1bjT9r/VHErZbyYItdyqTG7i6EtjaZN/YpWzCVTsIMIeeDANdDPKIcPyuP/pRSHyBTT3SFdGYvLHGtEfHmWHp3OpeQQcp4JLHCmT7L3qbbaU1Ul2siIhOaxjxqQ/Eh3NzF7Kw03Wst/HEaCzBBCWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8grq/D3/2ZZYyfmF7krWIJodD2cmB/YeOpbkvdktkRQ=;
 b=O2DgQkYvkwpp9S5EcY19CbQPzucsCpxCoNAu50difO1cJWso15lwM0nwTvxUTi8KBN6gRYN9BDa3NSm+w8bugkOqpM4S4D1cUE4OadzVN7Ah21Gv5JhC0N0lbihO2g/xlSpJcZHLUJx2SzsGxud8S+RhAQ0lUOi+Ik4JQEND8se/h36ylnTKticuiW2GNOd42H7tHleqi3HCi8Tg//BEmMGeNW9V5LsNsuEpnF13bEiUrQtAhkKEOG5liSy51aPdKiiakzh6v5pZLLarJ3Kq2QE1nfxQkR+4/v5o5hHB7f3NJJYTG79PaKjpMOruP5Vx6Jy1ladyPGhpYvsoWQPAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 16/25] pci: add a pci-level initialization function
 for iommu notifiers
Thread-Topic: [PATCH ats_vtd v2 16/25] pci: add a pci-level initialization
 function for iommu notifiers
Thread-Index: AQHappeANlzl0qOEI0mcoeWbkElSrw==
Date: Wed, 15 May 2024 07:14:17 +0000
Message-ID: <20240515071057.33990-17-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: 05d07f11-dcb5-4d88-6cdc-08dc74aea2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WW1BbmgrTnZnMFoyMzdkMjk0MmVINEkrNUI2WlF1cjZUZEYwc1FHek9maU1K?=
 =?utf-8?B?em1sZHgwTjUrUEVGWk1FVjRSN2dmeHo2R3NtcjgwZ0hCNW1RY3dYbHNZRmN3?=
 =?utf-8?B?eStIUHhVZ1ZuTFBNdnFtTVFWM2V3WXE4UTEvYUtGRDhlaUJCTEVhNmJtRmE0?=
 =?utf-8?B?anhLL3pYTWJ0elkrdy9EYW52UjNxQ21taGlKQkdWc2tGNHlIOGJxRS9Fei94?=
 =?utf-8?B?dC9RMTk5Yys4WlZKVXpPN0ZTNGd2T3hEaFF0T1p3Zm5VemxneXNEMnVGTUJJ?=
 =?utf-8?B?bGpMQ0h5d0ZpYlVzbHU4czVueEZFWVdqNjhiSllnTXl0ZXJUM015UmFUQldT?=
 =?utf-8?B?L1FhZUxUN01nL0E3SVMyd0FkZlVWNlE5d1FjM1lubXMxRzlpQWVQM3lVMXBF?=
 =?utf-8?B?d3FRU3B5eWI3aU5WdkYrMS9oNGVCNlkrZlFxVStQQkpNZ2tkL1NYVldwWDFx?=
 =?utf-8?B?eHVBa0c3OXlQaFdEZXNJRGNhcDdlUDU4bjJ6M2NFR0xiMHJFSU0rRWZTNjJs?=
 =?utf-8?B?T3JPNjBUSHIvVkhBdFp1cXM3N1NjaXUyMGY1Q0N4TFNYbDlpeC8vM1M0Kys4?=
 =?utf-8?B?M1lybFFZOStEK2ZhTkhUQWtZZFRyQ0djRXJKRnY3K2NKaFpDY0ZyMlJQQzcz?=
 =?utf-8?B?d3BFQll0R1dFYk4vbkRZNHFQYjc0My9vQUJKM0xQYjRhamlTWkVSdjZaQldk?=
 =?utf-8?B?QnAzVGVBa2QzVEk4LzcwQjI3ZFlaRWxKR0h1RzJocm8yMDIyRVlCN0NoTWk2?=
 =?utf-8?B?OHRuNDJjeDJEb3BJcGxFTncvSEdtMFVBeGxyR3NJQ0p6QU4vMWh2N1gvZ1JG?=
 =?utf-8?B?TjRNR0g4cVRIYnJKQmtqaTRQY1hPVDU0bE1tMGZTdVV3TVNpMnRwajFUbklH?=
 =?utf-8?B?cDBIZGwxamZNQmttYmp0bjZtWUJXc2xZR3kzcEJheXV0Q2w4Y2IrNFhMUC94?=
 =?utf-8?B?OWhvNU1waE5NVUNlOHVtOVRQZ2diRFk1NzdxOXd2ZjJkZnF0VnN6UWlRV1Jo?=
 =?utf-8?B?akplUWE4aEYyZXJSbjFQRnRvTWtaVzl5T1RRYWdWZDJQVUJ4S2paWStJUU82?=
 =?utf-8?B?bGtZRGpaOU9DbXNuNTUwK1JmWStjWHZjZm81Uyt2czY2bnJnb2ZTOUR5S0hp?=
 =?utf-8?B?VW44dUFQNUFzR1FJcjV3aS9USUVmQ25tOGtWVVZJS1RmU3MzMGZ0V1RKa1F6?=
 =?utf-8?B?V0xIQlI2WDJQMUN0U090NGxlek9LbzhzM3ZpQVY4WWErei9STTMyTHdadGE0?=
 =?utf-8?B?TGgrWGtUTGlnZXNBVlQ5QUVDWkEwR2d1L25UUk1UZXlBYmh3R0orREM2UWNx?=
 =?utf-8?B?TEFPWUxQdlBtMHhyWGhvWVBvVlBNdXY1ZkZidUxzTFdSd0J3OFhrVTduelFn?=
 =?utf-8?B?cWszdDZyR1orRnhjOGpicDdXNjhLQnNXQlJPOFExZGg4TkRDNXVMWHJsQURl?=
 =?utf-8?B?Rk1mMnVwR05FOXMxbGd1djhxZHYreWl3cldnZGdKZURHNW5VeGxlZmR0MVhC?=
 =?utf-8?B?K0hkWmZ4d25SUGE2aTlLUjdkeStqM25mdGowYTRxT1RUMmVOTzN0QnB1bW9T?=
 =?utf-8?B?dEZrY3Z5eDhCYkZSK1hML2FqaFBoYWx3Q0hrRWgrQXNEOFcvQSt3dm5VNUlJ?=
 =?utf-8?B?QVh4TVB0WkQ1VnpwT0JydWxnVVRkQ0w4SEgvR2NhK1RRY3pPa0w4T2dzdFJZ?=
 =?utf-8?B?cWwwbXY0WERmN1Irenlnb2JIa3pkamJFT3h3VHo1bHNFMHhqak9kdmJQNnBU?=
 =?utf-8?B?bFRvSlBCd1B2eUloMCtxY21OdHZmTU9PeXFaa3U1bnhQSXhwZW0rbTJsc1JM?=
 =?utf-8?B?bzB1SUliOHZNc1YreVNkZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDBObFBpazN5clhIa01OSWQ1Q3poaVR6eUpGc2dsdDB1ZzZmU0tidmF2SlB0?=
 =?utf-8?B?dEsrSERjMktPWVhNb1lBTWdYSFFqRGk1a1lYMjBxU0JJZmVQQ0M5T0Uzd0R1?=
 =?utf-8?B?TVpjU1R5a3hMam05a0pCVXpkaHU1ZTVhNU56ZkFOZGJkV1Y4c05UWENDekpH?=
 =?utf-8?B?WHJNSDdEcEc4MHhMbDE0ekdNaUZKdkRaQkRGK3FVZkhxRG1LLzBBUnFHVlJl?=
 =?utf-8?B?NjBjcnJ6NlVNVkFiQlM1MUx2Y3d1SXhmVFF3aVh6bWNudFladStLM1BEVjdz?=
 =?utf-8?B?S1RyazBSeEFLWmpnL0NNYnRzTWlvazRIUzYrUXRLbVIwSlMrdGV3dmhFSnh5?=
 =?utf-8?B?VHRLRXdMN2M5TkFjWWZGaUdsTmRuOWQrUDFNekFxSTlHcnNuMjBrWDVOSHpV?=
 =?utf-8?B?LzFkZTdhR3lWZEVkY1AxWVh4emcrQ1MyaUMxOHo4RXNORTBjSGE2aVlQd1Qv?=
 =?utf-8?B?WHJmZkY0RkkwTDFCWWNvRzJEVUpGUWxZaHJwLzR0RWRWT3UzM1E1cnhITmdp?=
 =?utf-8?B?dmJOUS9WUmYwZE5RTnliUW9kVjdTWUNWeVd4cy9ZdFRLTlhXWFVFbUl6cmRO?=
 =?utf-8?B?cXhWUFZqaTVTaE15a0VxMWNOK2VWVUhuOUoxa3pHTWVQSXZBOC9idzQzVFUr?=
 =?utf-8?B?RHZ3UHQyN2lhNTI3NzdFNjF4U0hXM3dqYjd3Z3VxaGdPODUrbHV0YkxTdWhI?=
 =?utf-8?B?VHFBd1BzZmJYYTBIaHdFU0Y2bmVnNXg3elc0Zk1FTlVzbzNWU1hRb2Q1aUpW?=
 =?utf-8?B?VEpxZDJjbDdDUzA5YW5JVjg5aGN5Rk5UYTd0dmVGOG5ac0ZKOFZTa1NQYmxD?=
 =?utf-8?B?RHpHYU80QjZRcGdiaE13YmpvSWwwYTcwTmtDM0lNMTB3OElpVGU3VkZuaTF6?=
 =?utf-8?B?WEVHTEVUOUxTQnpBUDJEVFlMaVlJaGx2dGdYVE05eEN4azh5NWc4NitrVWIr?=
 =?utf-8?B?M3pjcDJwQ09NNmJMVjNnZDJUblNyQWNtRzNSaUpHNEZSYitGc1pNU0ROMStr?=
 =?utf-8?B?M0VRckJUN2ZPNDlzUWRDVGhLUCtkMGJYRFV0eDlGNXYvMGtxZldBSzR0REdL?=
 =?utf-8?B?ZkJSbzFraW93NjRHR1lNMUtVSHJnb2prc0RXVXVLYUs1M05aKzJBRU9teUJw?=
 =?utf-8?B?dTA3bktkb29JNkcxMmErdUEyNEoxVTAzaENXTmdRQ2YwNGxORllsWWpxSzBr?=
 =?utf-8?B?WERDS0pGZW00b0UwUGZiQlp3aG85Um9DVURPQUpYcGVUcDB1WmpnVUlwanJk?=
 =?utf-8?B?SGlWTHRTejBGQ2xHRlhqSkN0Z2k2aVA2Yk5BRzJtTlFzWXYwVWFudEt5UGJY?=
 =?utf-8?B?OTdyQlJnV2x2QkErR2ZvZlJQa3NMNjV0VVFuRDRZRkVScmJJVXVXVHVnK3RD?=
 =?utf-8?B?SzlCaDNPeGhLdlN4WWFuQSsxWjdiMUcwU3BPRmV6SHBPbE5hTHFjbzRRQTYw?=
 =?utf-8?B?V2FJZ1p0RzhpcEhCVTRBTzZrRVlDNTNMSjVPSDljcUZ1ZngwNnR4Uk9WUm9O?=
 =?utf-8?B?TmozRGN0Tk5Ob3lZSHpHTktXM2VQT2NlRGM0UWpSV3dzMEg3S1I3N01yV0Rj?=
 =?utf-8?B?VEQrSUM5KzI5a2tGNFhmc2U5aWRRdXN3WkF5N255VGtzMUpYdWNGU0c3NHJN?=
 =?utf-8?B?ZDQxblNxUkVXVXJyYUtaeTU4U3V3ajU5eEg4SGhldDVVd2RlUmNkUnp1WnVF?=
 =?utf-8?B?NVpoZHU2V3NGQkxEZWdlTTBibmVFT2doeWRrNGZ0bFJQVlFNZCt2V2dOYmIy?=
 =?utf-8?B?eU41c1FhTXliNFptblVSaHhFNDVWTXlGc1JLVndndGEvSWdzdWdOdllnOTFN?=
 =?utf-8?B?VU1XMWFqVUx5Um1sWW1yOFpwMHo4c1dtcXJseHA3L2ZOenIrTzFWYWlWRUlR?=
 =?utf-8?B?MlRvSVVCU3I3OUVrblppc25mSlU3b0U0czMzakhUMnVTejJCWUt2d3VNeU1H?=
 =?utf-8?B?L0ZoaE9jYzBPemw2Q3JYaFRyNnNqVGxrR3B5dE1nQTMvajlvTGRoYW5tOGUz?=
 =?utf-8?B?SDdmUU5KdGM0SlpYRG0wVThGTkxhQmdnbVFKS2hqZzVmL05nTU8vaFVNVVAy?=
 =?utf-8?B?YXBqeVZycWVzNlpiNS9OcGlzdDhGSGx1UGY3NHF4T2Z5RU56TmxobU85U3lJ?=
 =?utf-8?B?d0JBTHI3Rk85MXgybGxNcmIxa3ZYS0RWNXlaQW5jdm9NazZSOXJrZDdPZTMz?=
 =?utf-8?Q?qI8ByeqqriTl4k4y/QDDl6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C159D325145D624E8CC0043D16A97022@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d07f11-dcb5-4d88-6cdc-08dc74aea2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:17.9150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cheS968gWWZ1lkkxbNkZ+O1H5QnDNMyd5TiJCVfoJw6L73VPnhwRHE2vu7a2gt/kY5QK/VI1zwvAWxW3BgEKWeK2sPIBB36y9xhyvk5QuXcq5EAqFPSFE5Hjxm77c6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

V2UgYWRkIGEgY29udmVuaWVudCB3YXkgdG8gaW5pdGlhbGl6ZSBhbiBkZXZpY2UtaW90bGIgbm90
aWZpZXIuDQpUaGlzIGlzIG1lYW50IHRvIGJlIHVzZWQgYnkgQVRTLWNhcGFibGUgZGV2aWNlcy4N
Cg0KcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkIGlzIGludHJvZHVjZXMgaW4g
dGhpcyBjb21taXQgYW5kDQp3aWxsIGJlIHVzZWQgaW4gc2V2ZXJhbCBvdGhlciBTVk0tcmVsYXRl
ZCBmdW5jdGlvbnMgZXhwb3NlZCBpbg0KdGhlIFBDSSBBUEkuDQoNClNpZ25lZC1vZmYtYnk6IENs
w6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0K
LS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwgMTMgKysrKysrKysrKysrKw0K
IDIgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNp
L3BjaS5jIGIvaHcvcGNpL3BjaS5jDQppbmRleCAyYjQyYjRlNGNjLi5mOTBlYjA0ZmRhIDEwMDY0
NA0KLS0tIGEvaHcvcGNpL3BjaS5jDQorKysgYi9ody9wY2kvcGNpLmMNCkBAIC0yNzQ3LDYgKzI3
NDcsNDQgQEAgQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UoUENJ
RGV2aWNlICpkZXYpDQogICAgIHJldHVybiAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQogfQ0KIA0K
K3N0YXRpYyBJT01NVU1lbW9yeVJlZ2lvbiAqcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9u
X3Bhc2lkKFBDSURldmljZSAqZGV2LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKQ0KK3sNCisgICAg
UENJQnVzICpidXM7DQorICAgIFBDSUJ1cyAqaW9tbXVfYnVzOw0KKyAgICBpbnQgZGV2Zm47DQor
DQorICAgIC8qDQorICAgICAqIFRoaXMgZnVuY3Rpb24gaXMgZm9yIGludGVybmFsIHVzZSBpbiB0
aGUgbW9kdWxlLA0KKyAgICAgKiB3ZSBjYW4gY2FsbCBpdCB3aXRoIFBDSV9OT19QQVNJRA0KKyAg
ICAgKi8NCisgICAgaWYgKCFkZXYtPmlzX21hc3RlciB8fA0KKyAgICAgICAgICAgICgocGFzaWQg
IT0gUENJX05PX1BBU0lEKSAmJiAhcGNpZV9wYXNpZF9lbmFibGVkKGRldikpKSB7DQorICAgICAg
ICByZXR1cm4gTlVMTDsNCisgICAgfQ0KKw0KKyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNf
ZGV2Zm4oZGV2LCAmYnVzLCAmaW9tbXVfYnVzLCAmZGV2Zm4pOw0KKyAgICBpZiAoaW9tbXVfYnVz
ICYmIGlvbW11X2J1cy0+aW9tbXVfb3BzLT5nZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZCkgew0KKyAg
ICAgICAgcmV0dXJuIGlvbW11X2J1cy0+aW9tbXVfb3BzLT5nZXRfbWVtb3J5X3JlZ2lvbl9wYXNp
ZChidXMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVfYnVzLT5pb21t
dV9vcGFxdWUsIGRldmZuLCBwYXNpZCk7DQorICAgIH0NCisgICAgcmV0dXJuIE5VTEw7DQorfQ0K
Kw0KK2Jvb2wgcGNpX2lvbW11X2luaXRfaW90bGJfbm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVp
bnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVO
b3RpZmllciAqbiwgSU9NTVVOb3RpZnkgZm4pDQorew0KKyAgICBJT01NVU1lbW9yeVJlZ2lvbiAq
aW9tbXVfbXIgPSBwY2lfZGV2aWNlX2lvbW11X21lbW9yeV9yZWdpb25fcGFzaWQoZGV2LA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBhc2lkKTsNCisgICAgaWYgKCFpb21tdV9tcikgew0KKyAgICAgICAgcmV0
dXJuIGZhbHNlOw0KKyAgICB9DQorICAgIGlvbW11X25vdGlmaWVyX2luaXQobiwgZm4sIElPTU1V
X05PVElGSUVSX0RFVklPVExCX0VWRU5UUywgMCwgSFdBRERSX01BWCwNCisgICAgICAgICAgICAg
ICAgICAgICAgICBtZW1vcnlfcmVnaW9uX2lvbW11X2F0dHJzX3RvX2luZGV4KGlvbW11X21yLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBN
RU1UWEFUVFJTX1VOU1BFQ0lGSUVEKSk7DQorICAgIHJldHVybiB0cnVlOw0KK30NCisNCiBBZGRy
ZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZV9wYXNpZChQQ0lEZXZpY2Ug
KmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1aW50MzJfdCBwYXNpZCkNCiB7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpLmgg
Yi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KaW5kZXggMGM1MzJjNTYzYy4uMTU4N2MxOGNkOSAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQorKysgYi9pbmNsdWRlL2h3L3BjaS9wY2ku
aA0KQEAgLTQ1OCw2ICs0NTgsMTkgQEAgaW50IHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShQ
Q0lEZXZpY2UgKmRldiwgSG9zdElPTU1VRGV2aWNlICpoaW9kLA0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCiB2b2lkIHBjaV9kZXZpY2VfdW5zZXRfaW9t
bXVfZGV2aWNlKFBDSURldmljZSAqZGV2KTsNCiANCisvKioNCisgKiBwY2lfaW9tbXVfaW5pdF9p
b3RsYl9ub3RpZmllcjogaW5pdGlhbGl6ZSBhbiBJT01NVSBub3RpZmllcg0KKyAqDQorICogVGhp
cyBmdW5jdGlvbiBpcyB1c2VkIGJ5IGRldmljZXMgYmVmb3JlIHJlZ2lzdGVyaW5nIGFuIElPVExC
IG5vdGlmaWVyDQorICoNCisgKiBAZGV2OiB0aGUgZGV2aWNlDQorICogQHBhc2lkOiB0aGUgcGFz
aWQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UgdG8gd2F0Y2gNCisgKiBAbjogdGhlIG5vdGlmaWVyIHRv
IGluaXRpYWxpemUNCisgKiBAZm46IHRoZSBjYWxsYmFjayB0byBiZSBpbnN0YWxsZWQNCisgKi8N
Citib29sIHBjaV9pb21tdV9pbml0X2lvdGxiX25vdGlmaWVyKFBDSURldmljZSAqZGV2LCB1aW50
MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VTm90
aWZpZXIgKm4sIElPTU1VTm90aWZ5IGZuKTsNCisNCiAvKioNCiAgKiBwY2lfc2V0dXBfaW9tbXU6
IEluaXRpYWxpemUgc3BlY2lmaWMgSU9NTVUgaGFuZGxlcnMgZm9yIGEgUENJQnVzDQogICoNCi0t
IA0KMi40NC4wDQo=

