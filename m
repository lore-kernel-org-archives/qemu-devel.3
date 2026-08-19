Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F722C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVc-0000xw-S6; Wed, 19 Aug 2026 09:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVQ-0000qD-Uf; Wed, 19 Aug 2026 09:39:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVN-0000jy-4E; Wed, 19 Aug 2026 09:38:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmJc9358436; Wed, 19 Aug 2026 06:38:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zgW6cltfCKz5bz9D90cyFUgeNF06UqWUwVNttfNle
 c0=; b=vMkPL1siWR6Htumcrx9Uj7fPUZzA6B7YXp72lEVZnex8hv2EgeTcfyt29
 VigoJkZXr4DdQNEXlDGgGNr8Amh48wTeqsLewr/gnSWzeGcxHzkLhb46NJi/qctY
 WGx0JyrFUYFOn5kPJ6blgvR2LSs8uylLk6aGr/U7o40+TxIVE9BDaNiYVQa7SNyQ
 YK6Brp2YNpv6mZRdvYPOna9boMAUwKL5fhcD+iVrGVodI5BOeDGKMndyGSL9z7wi
 G69TNpg2R8d8lB8IhJ+hNX++NluYmbwZUBrj9aVAq2uS+imo+WcQWuc1GvEWBbl+
 6zFLQLlFVitEpggHm7kWD6GGiLxYA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021142.outbound.protection.outlook.com
 [40.93.194.142])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4up4ts6r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCnqJq1AupkWpoDWkGrwzsUX7P+udJE+foj5A76Tv/CjmCEhD3QW0wKV/hhpAIZjlyBcPp2sOxJJd3LSlM1aUP6pysh+MxPfo4Pc60pzRhQXnAtvWjG/qRaXAuoDaXLALDD+Kr2VUnLPnC57OnQWod7l6IYl89CV39p0jsB8kDBdgz7yjt7YSIxdaKtDiJiez7laUXAgezchx0+/pOuTNbi7GU/cNM0DU+9M/FUSk4aeNDo6u8da1MphZVXiFSdaaCa432UGmI9NzZOTZ5IEML3n7sNnSRoaN/x77nuNxFUQW7mYkDvlbF4u6/J3c/dafxQ1Y6q2a616tsl7nW+gTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgW6cltfCKz5bz9D90cyFUgeNF06UqWUwVNttfNlec0=;
 b=Oh1e/u3Yf/M1TSnwghTH0vKuYOqvBhBPWdJj8Zi3npF7LnKNM+mWOKeSPR1WR/PAAYIOiZc38TBpop1rIeqjQMxdFJyRo4ES64EPHUMnQ72ZJKfB9YgN/60K2BUFXKpy07O1rjFD/D/9kUsw+h1t886xz4Hkz2UhJN86qBd2rJDcZxSUbigIKMYDw+Th9pjhrc6qU24qFfi1GoZ7RVX9+RzNdUuyGunsmmDVCpZoRPkfMW1ylIIJkkYNNMuyIL9OdYKKKc3wm9IY3VhteNP6UuPeZCy5P0T33ywS4NpuYRJKIrBkJ7c2nHCWmPcgIq4948Wwi/pPSMqGVEXoPgCZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgW6cltfCKz5bz9D90cyFUgeNF06UqWUwVNttfNlec0=;
 b=XEGc570uvOa6was7R68LwS4RmpK84i1Q5VOT8tQzktjQRuLEsTcZ+UucllAKL5k93bfwOpkdI38qs1VoGeh8bd+UFE7o2xPXyzuGN870YSZ4SCng6+AKyeSvHSxd3t5SMBCm8lzVUoSFqVeHaFJam5P0rjjrCBoJNeWHryOb50AiAHXFcyHCUjsDhwtNsx1dSEETnsw3ogSs4NTCgZgzG3O2yB8oMUuZqtLD9dbPlFRkm+I8X3uoM127gAhJvH/yLME3Idjw3Pt4uIRzo+8G+l7aG+A0YOMxUxpsGHnZRRjuzGb6dHN+XP72U1KFBkjqGQerCMOFxjQoi1c+lNCkkg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:46 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 07/15] qom/object.c: add
 object_class_property_add_uint32_ptr()
Date: Wed, 19 Aug 2026 14:35:46 +0100
Message-ID: <20260819133816.3497033-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4eb42b-2f36-4941-5f77-08defdf7314b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: D+VQCMz2XdQ1ASqX8MlA6RThmsXCdGo4TYsqmjSkXfCbKRiY99QqCqXYZ7HjEHXFyhmW+iSrwSXGKWEw46NfSMpc6EZHJnIVHJBv17bT05K5UMS8xcGNhvCVHYqIqfiKIZOUvVH1tV9eG+yQcwVXMgHjIZ45/7+kh1M4jrNZ98f+xdvOW7AXpaayRXCIupPmQUa9UF81ZgSHDBxU9WDUOMcxXiCEj/mkGjyXrVFCOXIJLdzUL+gFP4gFXJFNg4rLqe65GgbjBRZFN/x2f2AckN/H81vNg00G7hhHSBFR9ekPgtuN2odzzTGPbuzTI+cg/iHuh/mZp12GlRhBs1CE9DaMtcJnIRT7klmJpD38vZrH8KwG1RPES4vnsARrb5h6OpG/6AjL+zq7/DBE8PUoDbysgmRVW+8kjUIys8srYUc33q8wpLQDQDMH1K2zBI9F/r5cUawDkjNIGc9QfhBbL3RhP22L7A63DEY1PNy9yqqoqRfB1zOdMPJEtyyu9I3dQZDa67hqjcLbEZerSt0e5UKFeATfIiqDfmckfLtssdN62M2TbkNPSr0oay5PqZL7iLF7DtJmUgH0EK8majmYJmcmp6B1z6dbik4DzC2OzhX1Ib80jp0r6GXLVkrg0NIuoCqvqJels1l5k9nasZdEw6+69V8A5pjOaiVJVkn352GLOGKaKmm4w690dvuGcq+BKuGTEGKMrKwWMlpMkwjs8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MOzjmedJCi3heRA6A35dnFAWlmv4luUEvxw2kjP6klZWeRVGo74kyDP8eGY?=
 =?us-ascii?Q?WvvN4d4/JYTtj1frTcEQ/fxlrUP6gJlwa1TUYaZj1IvpDcwmPixaNFkic3gA?=
 =?us-ascii?Q?+tsqNABqAAaaEj6RugovC081/A2HaZlZ09IjQoow82sy5t7Q7sCGnEeTNxLd?=
 =?us-ascii?Q?EO6eTOJCzlRM3rIT5vsuepK8YaZmKQYgS4DHlmpDRAhO454ceyqpmUvpAIf5?=
 =?us-ascii?Q?Hn0mqKTbZ2VoCUCgfYWKdPqiD2MTZ9FI16D3OjIXzdKRS/6MNCpTQZQLozmv?=
 =?us-ascii?Q?8JanFrSWx/1No+LB1tWkFftducJgIrcguNIp8Ry8mZQQ5lGYd6csPyzFjuqX?=
 =?us-ascii?Q?OP8pkXIGO+sLyHRjLugr0jSpRJd2JLNf/HoJb15AJ8hy/C3voLs/LZsBubSZ?=
 =?us-ascii?Q?7Y8Ifl92uzYJtg+2rEczEX2VatRiJy3oVMElVwWZtLLw5W9oyhYiHaw8gYqG?=
 =?us-ascii?Q?Nhj7XHIYGJd2VVQZennPDAK1QWtGHKpzro6Me+eUBmb1CV9/yEDUKiGL/DsD?=
 =?us-ascii?Q?MZYUOldIA08ZW+8aiedYAFcJqGfXJrezKglfdJUUJzKO1AWycpKrhEu7xNaz?=
 =?us-ascii?Q?8MSo1Hc7tdJzcfS/I0JF908fFLaZbgg8ngiBGbJwvKAFD0LKSo7sxJP/gkpz?=
 =?us-ascii?Q?+Yi1gsgtbNo6yPMK9AIKmKmBm5ilB0ewjfR3yIR2wZUJ6r7tj51WN7idF62z?=
 =?us-ascii?Q?1DZAAQA9xnSDdqN+EM8ajRG6XNqCnhC/o7dNICavzsbFq0fDcI6V7DSjoUEG?=
 =?us-ascii?Q?4BtO81HO5B6jFizKexKRoHNS+XVuX/88Cq7nyPxr9wMDSpbcr+BYFljqjPwZ?=
 =?us-ascii?Q?AAkyyNMTJys/qkZQeXFlwsfjAIcmCWEys8UVT+4FmwW3ducxSQwnJBEkeHij?=
 =?us-ascii?Q?wi+AlPmDQ2Wji+cPw7kSpf2kAFvbqQwVyKfUoqHMR9uX2CDInT7K07hVsKuE?=
 =?us-ascii?Q?OiAAsM9AnuvrVw5SqntexbgbJqs7YDgINHqhhZjq46MnlL36VyWz06vBf0fQ?=
 =?us-ascii?Q?wzZ7KQOIp4kJcG/Wd/VVBFusgm/HVDmDh13ChbYSQ0xF9B0aWhrhYNHchUMY?=
 =?us-ascii?Q?sOy6i4sjNR5WX6/xiuzQgmCoe/2uRL39PIsKyzbzNIm8AF17s8VB0HYQZ/nx?=
 =?us-ascii?Q?b/9U5npKQIn16ujoa1K4ZOCZgBfBaaXhTcntAXWp/0YNp8SSmihBtHmMc3pd?=
 =?us-ascii?Q?fpl6O/IYR5xiMfLhb/EPUu6w6gnw9RG40FRmYyXjVNfdVaJ0368o7HrO9mfM?=
 =?us-ascii?Q?yzMO7/98DHKLMMqo7oe6pGM2t1dXGzIu7THZt6tzfb3ueSgUDDrZz+y5A+S0?=
 =?us-ascii?Q?HDZ5c2Q9ZYWKkO2m48Dk/oXHfpJ5b1smuH+YpUa4LrpzrlcRS7ZfnUIDri/c?=
 =?us-ascii?Q?9gDY/pY8Q3FWbpQY8u6G9AGNYtIR4MspyEKPQ+z/xcy+BhZusvJOfrX2X4Ff?=
 =?us-ascii?Q?3nIhdLIucSdGblEFmc5UwaMjXcq4pyIMK9KAxRlFnSLz79JKc7dy/jaSXieS?=
 =?us-ascii?Q?yZaakzT74VXN4bvjxezyn591Tq/e+QMWRJ9RF5VyBKOXvCl4nfvMfH0S/Q8g?=
 =?us-ascii?Q?77b2Kkqxsiqqi0cRFRzGX+l3nbKqLKtb3GOGfdk/JtkDTPwQH8hjrvIlg+D4?=
 =?us-ascii?Q?z5XjazR7Pwg22fLh4ufGL63AgfcDEHHvfNYRbq/CwVBRIq0WfEnEqRXV2D39?=
 =?us-ascii?Q?QsLg339/A13PvP4Flhcn4NTWMTJ1e4owRT+WhOA5mrJMRy1yXh6VDN/QYpQP?=
 =?us-ascii?Q?ElhqcSvPTruV1p9yD07XBfFsfk/p2P0=3D?=
X-Exchange-RoutingPolicyChecked: MqdKAe5sJ0I/9GbruvvYW7IkTk4b91q3kv0QiEw7f181wbQl9uvqVuKmzAgRiaZ/DcYIdYdAsFWy7Zv9mnGzw0qsegHIbFCyF0Yq3Rjwq9Ptb/j+1VV9+fz6bdcnza8mwScZWQ1M/MplLIWcWDKS6EaDqqzx1xhVxYDjrK2QDvLku1JFvKBVuyQ4npKpFhs8xtxsGZguzjTu0ccXzn7YWAYuq/PaUbrzDABWCmYnvPBSFKktL7HH6BmrF/iM0xZvOTuGpeprxC1ONmK9xbixOxvDE9Aut0HOutnd5lldUZftF7jDElSbev/3UxBjHe9sFtMaB3j4X80l2aj6gPNdAQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4eb42b-2f36-4941-5f77-08defdf7314b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:46.0893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W01x//VRGaY/VbM/KhEC5FRVqpJlgKRAVxa2OVBLJSx/MVsgD9He9lGTqrGzNnmyBXQ8BjCQuBIrFFp1NS1HWjtoVxZ2aLiNENaJ5yoU3UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-ORIG-GUID: wiNRyukKaiThHXKTmoVemRLuTlkfEtM1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXwd4HWc1bw4Td
 20o9cRIqQbLuU57RuUtZK2EYz/i26eJCDXdElls6hiQkfEgzvz2q3B/pTM79yFGncnoNs42+ayV
 8yNKLWJ+70TgfRzvMsyqPZ/JpsqgArE=
X-Proofpoint-GUID: wiNRyukKaiThHXKTmoVemRLuTlkfEtM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXxQd6L3eDN9fF
 rZC2GL+unjqEkEyj9DpYjLhXoTsOjwELPNutiRCEm8fDhbzVyUFVgeGof/A5kWxecOeg2Ids0QM
 KUw1cEvVMSc4WhUEWj94wkOClzvfrUqt1P36sMJ8/EMFXb+8b8BGLCy9LmPt30sohdCQN+nqD+F
 GBVy3b2kgKzgoy01ylaQU1KadlRwwwn/XxLfbrXc51zfRsB8pSOyww9KCXzrzGDhFuDXVpxXzGn
 nw41idB4tEduGFzirUfRGXCazs05oP6aJXPGsRUDeDVCgrq71OFY5ARJ/6dFT3zFQVDVs36judl
 QaHMMo+llYhKRN11FwggrbOqNZT1Sgp+4LfSfmTrTA79UaKkukzAQz0NjwkxD22gtk/wQeg/Cti
 u1Y5Sa/xg6aegZB6IVbvSkZBzo38wV4xWAYty6d3gAZLiKzR4sSprstucQfCYwCZ/wyaiUEeSwh
 eReIOWBu6uh8Zqw3/Dw==
X-Authority-Analysis: v=2.4 cv=JpDBas4C c=1 sm=1 tr=0 ts=6a85b1e7 cx=c_pps
 a=0LNrXYcIMabMz0p9jkIKmA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=WPE7CPV7d1-5cZeD-4AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds a class property that references a uint32_t within the object instance
and is intended to be a replacement for object_property_add_uint32_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index eba675d218..e0c88453b1 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2129,6 +2129,24 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint32_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint8 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+                                    const char *name,
+                                    ptrdiff_t offset,
+                                    ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint32_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index a480fdd400..fe032c9619 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
 
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
@@ -2870,6 +2871,26 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint32_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint32_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint32",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


