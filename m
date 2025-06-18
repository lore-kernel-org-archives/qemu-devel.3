Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE72C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyd-0001HF-1x; Wed, 18 Jun 2025 07:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqya-0001GN-EN
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyY-0002XH-Lz
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:08 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7qwBQ012989;
 Wed, 18 Jun 2025 04:29:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hWA3QP2lYEsyPRPmUhW879dwu4I2vMjxpMVHNC+Vt
 C0=; b=Ayp82s3++G+/QuR3YDOl2yxES3kwuFSFyeE6/rT6kn1wYldGLPHQ+Lsml
 VIIVLL0DzXtaLyoYtnbA4TPGvOZ7qWRxFAOmQxRteSQK0d6NpKI9VNoQJjs6ORat
 EaXeOmu/3nZD33D+HzyC7+ys9y+ybhVjNzewsQGB1Jkho5SjbFMRkscJDO2KsqSZ
 qvHpqnwqlV+w15hXtpIRhfNtsdGJxEZ52Fm6WFngLfCCDB9CDHZAqhboJLRwt2cw
 w3MBW7aSYoQDZ+D3HCT0602yei15qZVYnzjoIAVFy9DZsBJPz2O1vK3LnAMJWPj7
 Q3lhjkvM/6uH6QtBAA5X/y4IXd0yA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mygsub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJPKr40EVnxFLtaZcjE7noP501WvXFtykzCbJue2IWBFB5xx6T9mAhXJ/aVpMGcxAbginEa4Tp8oChn8314QsBau4UKyEaBSTMUL22vCBPHhvp+Iyd8t6OQ7FhL5F72/zpx2JqgaBr+erN6M1FF24aTrnrn07edqUJlHR5RXYRxKxn/JVV2tVqa9SuiQAP4MucUUx02HkdgqNbRddo1TLwsweSTPDz2SXDUk9zJnRlJD3jz09qItp5UzFV/8KvKEH24JXjDCk2HWX+COSIHp/906KCvLnf+GN12jn5PO6pFxU1rvt2FBWzQwwCyzxYUIrW6I7XLUS61qwydGgu1CTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWA3QP2lYEsyPRPmUhW879dwu4I2vMjxpMVHNC+VtC0=;
 b=SgtPK7e/QlrExt5+faPFxXZJ/iLcLM3uWV4wmMdJeoDL1uAODAyO3MDltxiMDzQ12Qrl6GLpnqE2B6iyQph9fJjsCW/nVcZ2t4BKZOWkofZTJt4hfK8j22m/85Sb1dZHETDdi1SJf+VQ+VsHDktU9KeuI3VDrPFjkcLUTmTcsCRwhJrkTGiMMqnF//PCQRE7ybbPXQcNsX5wDEJjZQrEJACcfT0dyrz6kKQNNmky5MtsLrdh4LYhWdhVhizZnPzHVZ5ooTlBJQqXRb00EBE0ss3r0rUOFtYiCfgPu9O7SWqw1lVz9CEHoPW62T1Babc9QUYh0LdmpSMegkkTWdIh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWA3QP2lYEsyPRPmUhW879dwu4I2vMjxpMVHNC+VtC0=;
 b=jtWlPBGpGS5tNgyzPXHBFRCl9IZ8l3kz3fDdtLZCRZSJeXcJm1EMohKMfI0U4rEqPUQWrNGd9AV5nhoh2PCgR4rMqG+6BhRd+CUr9KyIM/4Pla8HGi0llmHvlenIneNeyd+n6JUtas2zWzoM4gsCX69KdkH9jAzkfTnmJ39wl9grJnmSLqDNWRh6NsMrb7FgXLu1Ll9/x3TTatKCT5k2TgASX4NZkYov8QL83q3vIZRZv52aaEOcrZzhtsIVvNljd0SPOUr+ECFWu5Sh4tmp5Oswik3CHDE6cczx4QVlBicHRX5O8jeUlnZta8w9yfnxh+jdmsIpYA51n9IXdMNKRA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7295.namprd02.prod.outlook.com (2603:10b6:a03:292::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:29:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:29:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 08/12] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:13 +0100
Message-ID: <20250618112828.235087-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f6a9b7-e054-4096-04bb-08ddae5b52a6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n06RSiOEOgm1XiPn4249MCLr75VKeMc3GtIg8f1V5o9C9YOaeUDGQ/AxlA7d?=
 =?us-ascii?Q?txuIS+3Ti/fMv+8/8ZCQkZExFX+6wyJd5ErFakkUy51q5ht891oJYodaTqBd?=
 =?us-ascii?Q?sgNrhaBPRPorUL75at3OqPUQtV30GrnXV88x1HTDjs2wo+uUrycqz2vRQz7p?=
 =?us-ascii?Q?y4pOgdSaumQJdGyrAxzqU1C3D1ioWni0ZD0wQ+n0295s1p7ia6Yy6zs+BpRL?=
 =?us-ascii?Q?Sm1fqYY49QCqyal8JjWsWDFY0dFgR4fxBT9v8Eg7DkwD0LebybQjUDWrt7g7?=
 =?us-ascii?Q?Z1CpkqL2z9jxFbbE49eqFJWP3uMMR9zm9ziHDW4Ov+WR72hUnSalHq0PPscQ?=
 =?us-ascii?Q?HnrT4unPtk3LHimT2Z37e/UIs5pDG8OcixreXXaXBF3cAckIISz7HBYAnK3K?=
 =?us-ascii?Q?IxceJ+k7Xy5koU1WglH9XhNTUe2/GCffaZgwRM3VgcpOB8LJjeB2tc8W2bSb?=
 =?us-ascii?Q?M7w7xCZ+NADXjZTGR+wQKUHMFmEWITyA+IBzor/51eqKG8zY6Irt2FgvVNKh?=
 =?us-ascii?Q?CQ9nXI/NA9H1PQNCurAlZwPpibifIUPZNdKKFEQnezkA3z/0gQWewBcFyVeU?=
 =?us-ascii?Q?yQdf5okTa3w95SjpPSxDsKTzD8H03SnfwGg3zoct4q3QpGbTDXv8LcgMbO7R?=
 =?us-ascii?Q?k6cNJ4Tdd0FslhNoar4cLf69/bdMxNT5IaWrYPYcFgjNTyR284oYPdK7K1QF?=
 =?us-ascii?Q?bgF9BY+T2/LLRzryVSfBmeh72wmcuIY31Ix9E/D4sR+cNPEKt7A3BHIA6Izx?=
 =?us-ascii?Q?06KLbTJahX+qV88pBVdwg61ZzNX7qcRkR5EyLx5XwXqlm3V5r945rHu/673n?=
 =?us-ascii?Q?CgLAIuKhOM2GdXX6CgjXX336EdLEz9mpSB81BBsTPHAOLvSHmjhs2m2II3EY?=
 =?us-ascii?Q?hpOi0S0l4gF44yjVwRwD5ilV0vTDexbE03/CvkTERBBYalge617VSLDpSoih?=
 =?us-ascii?Q?RspuMsl52Y2PaqozmsaTat7rFygKKfinIl3phGBiH5YpEKjAzYvR/ZOv4O+R?=
 =?us-ascii?Q?ml6D6hntbzx/bQznpf72o8A8f8H/Lg4Z8j+r6KsCypZifFGET95QnU7tJ8L3?=
 =?us-ascii?Q?My1UTkosYyDh3LaS4Hep0+LR4JSFvC1J0KnMQ2xf9nSc7KobAaK4x9+n0sw+?=
 =?us-ascii?Q?GlJglzWY8iaZQToHI0gMgUELc0FagRzZgzaQbfkValanXLcqi+TZ4xl5PQT1?=
 =?us-ascii?Q?CPQ9MIjbNocwNERUVLp+WMuooT4xd/zFeCft8aDncAdzlhGoDc9sxFZVP6E1?=
 =?us-ascii?Q?Q0HzxdD4izZdpZ45jYRAtMSRsWycjWPh/6JHVXeRn6ZScn8gj5Q0aAiJ3ee2?=
 =?us-ascii?Q?HgLjypDsQUzg00kS3r/wAcpb4VRFFXeJ3QcEi4s5Z8Oyvtue/C404AzHMcc7?=
 =?us-ascii?Q?2ADirGHiPjg4r3xLMOFF/zDROzmGQXffXjKA3/ZnsSTYytJFwy5yRdjwK+J+?=
 =?us-ascii?Q?6uA50Sajk8o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/9St6hvHNKoGzWlhwd8EIF5qJr20AupL9JSQZXGpIb1Tg9EpbA/xim0l7tj/?=
 =?us-ascii?Q?vEEUbayiYX2gsOXXP+p6BeWjCBBdtUBh6TReAMnOfoBoSivrWKFh1aOf1y22?=
 =?us-ascii?Q?fBn/RjiljtvryBX4Jnt4WMkr36GaeQ6zJ4xFoElndDIGqh5Iz3LvFyBpLZs+?=
 =?us-ascii?Q?UegldbQhdW/HoEbd99hbNn4T1+QYXXg11QrOIvU2daTMCHMUEX+LJi/arVQk?=
 =?us-ascii?Q?wwIbjmP3JU0ctwQvZ6zvXY+GFYj+LaJU7ZyAptfwyKyK55T2rOcLvwBMqy0/?=
 =?us-ascii?Q?cZ0C6vHK6mo6wzkLpomRPbvoHH6GNYpuF5vHP3A8QJRgM3W3CzWDd6npFyFS?=
 =?us-ascii?Q?wbrRxwEK+QOWLN+LG5vu4IaqgL3RZGPCcJDDLu9K8eUuYfAU4FKO+K+Ywq50?=
 =?us-ascii?Q?KaDjkEg3UKvAcByVruXF6N3XjgSap3otTpGOJ7BD9xtwB2o3lcZ19lvnqE6E?=
 =?us-ascii?Q?ChuL1SaWDpjnEF3XyDqi7OnrlciaM0uHgwx073T30PZKqdd8078bQiN2X3U0?=
 =?us-ascii?Q?ouOmEw6W9bMzfP6bM2jSkhuVbc1R2hx7c94oEcuD87n9oajspt5ciO85iati?=
 =?us-ascii?Q?Iqzb894lWp5E0qzGiifLXSjALc8WF71nxhHBYvzVEUn9kX7fM12ZmRQ6FBkV?=
 =?us-ascii?Q?mgGfuyiALHefcAfnuAGXQ2KxgxM6RAckxazpqI8UV8N/5HggTYalPESxsqmf?=
 =?us-ascii?Q?CmZnCVugE7sAMa7DZgYDpsiijGMvYEGon85/WwAsrJsxwepmACdnyk4PN/GQ?=
 =?us-ascii?Q?ocdr1vecRdHpjI58IhSCk34sckRWMdHZNIs2rx/JDdZYnUHANzhi07NyUA94?=
 =?us-ascii?Q?npV/6YxTHWXsHHymH08t3H4gk6srfFvbkiUJ+BaY3uetswuJdFGSyv0ohiEh?=
 =?us-ascii?Q?Ykv3zXBs9Mm2PWbZH15Y4vU89LlEGfv1T6P3HP5q7WdcTVrZvfEYEUMAAINr?=
 =?us-ascii?Q?ye8GVJ43pZHyGuQQUfV8ygLFUkXczt5kTHNnlYd+HzbV68bb7SEsr56UE+Dh?=
 =?us-ascii?Q?skSkw8BgmzQEazC4u+qHMXeoj4c6LP//2/xk/Phru9JDGmyDBgAP2FPI2e9Z?=
 =?us-ascii?Q?0/xaQp+baZOM1q+iSFnE0/SLI+9ZL5WD2JwZ3mw25hiBAgLvpCsFb7SXOJ1d?=
 =?us-ascii?Q?Pr11rgdHLyS3qZAir+EKO6MdH48LbFhNmeJkkMLOdlpz8dHZ4WWE4449NGLW?=
 =?us-ascii?Q?34zGIUtH2hV07PNnusE1rlmEttq9pY0JeA7yBqIpZkjN3fodDrriqEiQEGPA?=
 =?us-ascii?Q?Uo20IP8Se84pHVOYLrIDj7Fxx4kl+UK7nED91COqThmzyoijV2gp8oxNPBjW?=
 =?us-ascii?Q?V8Aw34rcsdGOTMd23jUHinaJW4074h1IbwKH2Hp+7lIk6FhMt2ktj1HVFyeN?=
 =?us-ascii?Q?U/tPudYOJNPa6u3mLdQ3K2VCBAG5jq+DQFPBH/BOlsqiAWCztnsjqut4c4V4?=
 =?us-ascii?Q?7v1G74LBFNrG45h6BZvAp58ILSluaawsidVS5pFHylsMbQeoLsAeK9CrOqpg?=
 =?us-ascii?Q?GMZOwmPjQWSuTtpyB9+yXbGO08g1ebcPTHu0vDRWcl2m2FAGbJspPWmsWTab?=
 =?us-ascii?Q?00ChmMlRwZMAxkwUnwHGTWBGdwPg019QLQ6KUmWAOkKZ280VN6Tw4b+SiTYA?=
 =?us-ascii?Q?70/5XiIqn0YRCiJUMS+RQSa74+A1rzQ3fCORGCY4qzMVeSZHMYvi9Wc5nw9e?=
 =?us-ascii?Q?88ibqg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f6a9b7-e054-4096-04bb-08ddae5b52a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:29:00.9207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBDfIz3VcyJAZNbmakKy8f1wMV2PHfe3cO1c3POHJh1gYeGDnfL/sFZJmozx0NIVyRqZCr0Ccd5M74sOlugBzwcxdSb6euGd6TFdIiRdYtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7295
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfXx705SggNx7Sh
 jBrFjC039d7HtOlUkF17qYcuRFWWFe577BZQ35MrnarHb77gv6VEOjCY0qfw1BtvSTA0jkYCOAO
 CFCljr/96ayJN85yW2fMkAjMT/Y8ouRrOrdMwzUQr5L3eK5f1CbFzh/DqhUuUe2lRGV/dIw3rnK
 yGkHUgYKN5R6ZE13ttEi+Lso1MPaiV4BNPqF5pSF9V8c9B3NVLNnRI9Uo1S1mUBKndxcKxBe8br
 cPJqXlbCDD6TBzXGGeMx2fWLX4vI9AMdbYOHZk3qQE8FAaqXSjLr1fbQ3jJqLF3EWlQg2VHTtLC
 ThND/a60p06+8gncUXWdw6wwCTXptyAtQNXB9fBoLqYtKCAqa3dR44dbgViPw1vmW5thg0svBSm
 Jhj77OhFc0sVt4n3OuVUaKd9CC6YnIZbM2IN+pawEUjmTEdQINAHhvJXUbSLb9lZZayzJYWl
X-Proofpoint-ORIG-GUID: MRybgD8qiffmBrf4WRsMlu2zclvI1H3M
X-Proofpoint-GUID: MRybgD8qiffmBrf4WRsMlu2zclvI1H3M
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6852a2ff cx=c_pps
 a=uYP7OY3RDfiCMgYFf1WVkw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=mnHwG4yJ6Weg6gPWIr4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
safely assume that it should never be used for the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index cd9a89f7ff..69c4c001cf 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -454,7 +454,6 @@ static void pc_init_isa(MachineState *machine)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
-- 
2.43.0


