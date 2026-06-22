Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC61CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbclv-0004QA-F7; Mon, 22 Jun 2026 07:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclm-0004JR-PK; Mon, 22 Jun 2026 07:24:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclj-0001Rb-TE; Mon, 22 Jun 2026 07:24:50 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAp1Sk4151181; Mon, 22 Jun 2026 04:24:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+Lu2SXO9UuDdhfIkmsloi4TsiyWy621OrD3f1EcI7
 ME=; b=Cw3se2L6RnOA7SAXcHizCUj8SdZvtyVRzaYRgD6UwWmIGylyyNW5C+++9
 hjLmDJRTeRTSn287SS81jT9jmGKSNeLQ1R1QGHiqw3mWuzSIRINN2GKQjSUPUG8s
 hX+d4+zJKaTTyp6lcSX9Pu7jhCzq6yAJu6er4dh94wBDGrYWBs7HhWjQCQUgnN2r
 y1q79SeOVIQJ0apQfKQmsZrr3WV+hEL3/eJLaGC3/moiugL20p9zNQwwdewa1T//
 vbp2PA6jEEgPoj1EPilGkVLMPOn5UQJ4lmEgvELgIvBiN6s4/Yf9nWNrOJs3KLfw
 42CvuXjDTbQqAt9U5bg0sM4ZF692A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021078.outbound.protection.outlook.com
 [40.93.194.78])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewtdukeg3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb+EEQ8jfSduK0jnxw/SoaaIedYEObfNGFIOmKs4Wg0Q+31LefZoxB4NhsDzuBsiu9YlcHchH/UcDk6pRk8fvp57HXcBoh3YJfR/zwESP+5hsIsCHCdn1NUloaWohmh9LqG30r+udzsPaBHkqbkFAup3U7Qm52A4hbnoTm6UMnClGhaFlv8SVuZftsxSEIfw2ATwsYnkUhqRIn5lGNqrBCFb4kRNKOCE72tSbGS1Mc/tnlj0HlBucHdwwQtkz3cH51zC5vTCtw+j8scfHZAf2ND9UQ5CazOXVi29eKt/+V4pxnv459L9AHHkvMn7LqmFsMrQVtpJ1n806LM8NpPOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Lu2SXO9UuDdhfIkmsloi4TsiyWy621OrD3f1EcI7ME=;
 b=fpa6u2vGz1Wbk5It7X3VOl13sPUkGEvau6dOQAu6faXriFtBg326GSMVUYqGDFbIaDmA5vKq+qk8r6uKLxM3pw/yV1hJftzX1c2h+MzQnoR1ATt2kFxD7z1enR8sRWLm//ZvC71dkCHHe35Bt6G515uoYG/wvY+4vHCfi9F1mrJQRemyycyc6DTqmQEXnYBlTrWsp2hKIFA5WXXbb9JcRDu6OfhBT8v+50gyNa7bHJX1HO0unrFm54qNVmIi0w81XwGlQjq4gxwQXsOksoZ5CLTdxW11K1QObTO8K5CwGRTpm1B/+S3a2L49dv3odlk6FsAKP8y7XQ6gtciYkKYbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Lu2SXO9UuDdhfIkmsloi4TsiyWy621OrD3f1EcI7ME=;
 b=Clc882ixV9+sPLaodQjeweWi+lbuWstn64pK/HgKPgD8Erh8OFW6frLABJUeKpFS0ADxC+4SYWfBaIim9RzPYyQy+BI7UhBH8B+L1nofhDUvrU7XS+ehoZ5HZ2wf1SC2FjPmP7j4TfaJAxhKTGoITnizOAFAPiUZN0EN8x9ZRLe+p/ZddApnQQOcpfunOXtQ0W9K5/YCOHMeLsBtxAi2O/m6h1mjPfSL1/8tvreg8EHrGULPLQC0Cfe9Go8ja9CTZS/dEkw4hh9FoXtH8BLksw3jwdFekfGzjgI32VW3Vr2K4QTZQa926OrHDrGGE6uAYYjETqlnlXSF2W8r+anzPg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:24:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:24:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 5/7] hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
 ACPI_PCIHP_IO_BASE_PROP to class props
Date: Mon, 22 Jun 2026 12:22:37 +0100
Message-ID: <20260622112403.928954-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622112403.928954-1-mark.caveayland@nutanix.com>
References: <20260622112403.928954-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:930:8f::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: ff35078a-7dc5-4f45-2818-08ded050d15e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: /NQu3r6CZzRy15+HlSnX6C1DExkcn7ednyx0mQgS4ksEYAi/fY9i7VXAAUwg5qBZam4GdEgPzp7bUj+KTHtuX5B5oKm/wRAeFiJB0+rptr69gvHbxgh7JFB6G+Z0RVdL1Fy5tBrq51TBfD7PuDB82Zjo63B/6BBlZfutCO+CJjesG517IsSepAxZvTkRzbHtV+6+s+tobnz6onM6HrVvGoMV3OZklyRJNBhb9icB75gOaj2PRFRijXp59J/P2A+VAzW3X7cpvyMEXaR9FezFBd1lxtMQ2v+iAjtitbv1/6I3gvm/9WKBOsg8G+0U1NjSJKY1kuaZRRc3w+LgO9Ad43kmGrikA6sZo5HRBcqv8lL6ZceYmGE4/VO+XLH9R/0oWkYb1rsAt8zZtrgpsPzM6WEyoagu3VOkXGIrIMamGoTHEGzU7BR1MtUE6w+7/XEL97MARAXpTtEivW44DeYA2XqjhOYmsj9T++OUmWygsZbvsh6DLnNoqEEJmLk5iCKkiD4vZXDU55/EaKvGZvGavZUrDjOZ2SCUS4cXozbieeV6OeXIex0qPq4nsZl8ziYAQghikyjVPzxhRhAf01xKazJRHnaxJD+cnn3vdniNcpGauZ24oVkrz+6etn6MS716CIvCgi7/pN3Wvafd8AFs1QhbWd2+EjsIyCDYzqNMFeyoanUYY90RxKSSn4VDX4SjF8BJx4evDCSPn+rINGndpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?luvGpgtxg+b6KtI3MthC9VEh1sI4OuZijWudoSWGnXdbVZ5fmJxq3V7h5l91?=
 =?us-ascii?Q?M1IjHE4cdSfMM5NTT1iePMS3WtuE5fgl3zo4iJXLaF833N5EQXaGnGB3TrYD?=
 =?us-ascii?Q?th+xlHu8EGgPVadDyGDra+NF8hBYr99bxgf/Fk0QQRBkRyC/raUYwjkbavbw?=
 =?us-ascii?Q?cjjsV1IapBbM5L1m1dOVRwY2GVbWtSEmsuAq8/e1wTzO3Mx9ibwof0rZXG0q?=
 =?us-ascii?Q?4CezDKxElQGd89Fmh+KZvH0Kl4yNOrJEme+D3r1FbqnZxWdDwZt9q6IALwDU?=
 =?us-ascii?Q?agdFU2hutlvTRw0/RMgtdSSUcCzGr1STatMTt5+l9OJqMt/CNT7p58LH4H10?=
 =?us-ascii?Q?fmPHgA2bK+kZb1o53KuvSR7WqayRBxKS7d9YfTcvslrafj1mBg3nLVUIAJU2?=
 =?us-ascii?Q?jNfGrMntLvwWOC8wvjnug2/mzi7QdkH5HdJ0JKOiImrEaD1tMzsfudJJvOZ/?=
 =?us-ascii?Q?0R3z8D3n2/NO71GNDawQjvyU3rtvKXCiSDnQgBr/2v9xv2AbK2Y7lEmSjzjV?=
 =?us-ascii?Q?KPNpVL8hCUPRsxrHPTBMqauGOesi0BAFW6qGFlD+f9RCUtsfr7l0FefAPOwl?=
 =?us-ascii?Q?Wa6+b1P3Fc+CgoxM5sUEVTdfFDLhh5LS92jPAk+uUP++6tt6wahhrImdT8CF?=
 =?us-ascii?Q?kYD7gmNDc0E2c6Lh0wfkQqzc+H+6UP/vw/i3ed977/7jJWXF8Pd5GyZd46LU?=
 =?us-ascii?Q?bwQIpir06zbz4Bqvw4MT0OEW0cLbYdNIZB5eYlnXM2jIp7mRwOalH3AO5Bpf?=
 =?us-ascii?Q?ucwHoLx6FBrCQ3CbquCXunYrhwkGjTIq+s1olK+AEYot9tI7sMJ/szS6VFCY?=
 =?us-ascii?Q?nQF7rewFyHI/Ryt8Xi0KWozMZpxvF3Uo5zm9PdSs57zuKcAZFdulXliiGudG?=
 =?us-ascii?Q?UoY96SsOm4+4aan1TBN6nIBZeYoI1K0fVO8NvXPNsgwuCjjs2bQjLHp3HYTK?=
 =?us-ascii?Q?D+fx+Peao2c6Bcf2+pzARNEW/Zg+q85EP7iE/UewaObalyxk3JYC3qnHLSaj?=
 =?us-ascii?Q?ewUA9YTnr1rW4ohQqFCHErIVn0YhLNeltgxDUzminpIfzrxKmFLffSQjvuRC?=
 =?us-ascii?Q?KyzKq4W9x9k1PSGl9L2tMiaaYkKFpPJYwWle85o3y3QvX3i3mGkfNOIajw0I?=
 =?us-ascii?Q?qowoquSOwtAGZSHy1OiaZRT9RjeG/Qvz8hokZNxT+IIEpmW1A6cTqlNZ+cnH?=
 =?us-ascii?Q?37BzBKSk0hHpISvEq3F/44Fdfv8xrHEM/TBczvRX9/o5WD974IJB5f4NxpQy?=
 =?us-ascii?Q?XScZLATwI0U4Cq7IfCLbpstPpSGlaGlF6dd+Rkt1RB752v99O77I3f3dklCJ?=
 =?us-ascii?Q?uzBuwmOTjoFSTO/RfxM77ztE0Px9RnElYr9ja/9DB98Jp+afxXSywIL+SVRa?=
 =?us-ascii?Q?Nuw6NbOPp3JXjpu2Oy9U8Sm7xEcJQpZoThbCYGEppBReISAKMICPjbiSwEu6?=
 =?us-ascii?Q?f8TzjVYTw/xphi7MXmIl3ouLZH7nu89EHlvSQ2T41C2/SCFuLWCJetmKH6tK?=
 =?us-ascii?Q?ybeaD9xbpp9Yi4I0f3e34wFF7Kkhb09kULCBRhwj5U5wR+I4YWzoSaXeK2gZ?=
 =?us-ascii?Q?V2Sq5JQXTBx20ZB80CXrJwofCmASu6TcZCiwaVgS3KcvUwsQq6NT/daelWKF?=
 =?us-ascii?Q?JO1zwDkomrqH9agc4Fi21tsXgnETDqj0SF+pc6xPx2AYTBJs4DgMu0XjOSWh?=
 =?us-ascii?Q?tG6Gk6JoxonCFRtdUfaKedEIyn7X9Ks/PrVUkgoqZfvHuLvCEY8sncUDBxXD?=
 =?us-ascii?Q?DNCpFEiM0tPMxjb+RFoL6Bx0cClnVUw=3D?=
X-Exchange-RoutingPolicyChecked: RjyeEN6E2LcgdPRsitJwooU05xix12ju1QM/+ETtftDVetNDiI8fTHD1Gq0sU70bceO1yPnISwU3RjDanUztJ90C1q6+SxwvLPmNb03+JXjway4nwHFXNMSy++gzReBhSV/56TU/cx8l5TxqkMWghYdOAK1S4uUtnW/zJhoQ2yF+9scMX0RfuYCWjZ7VwT3vqADS046LtPWxGabwKLd+LdVt8VozRHc88UPu7ln2ZBKuP7mWZCwcE4fkd1w6V9f6ZQvUHJCJ+4CBeUzYiZ8wnh7/w6YYp48I8qrowba+3dSVA7/P+y8CqLHMfj0xFy1LiEGNEanWfWYLSBHdkRWfvQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff35078a-7dc5-4f45-2818-08ded050d15e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:24:26.5014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SK5a4TmHIqRJyneiV4+lACmW0pjXuGuLQzdj/E3bXc7jWY8vMChjpyj8hy2KlBIDCLmJuhHsbS7jkpL1bYVsxzH0d4chOYnzjNzCjlnhuHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Proofpoint-GUID: FFeqwErc_ux_eRtzZgSonFi8eTw9EwBO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX3EVEpk9kkpVj
 7mNcKX+pgl24tNgOVquWtVFU5Acrk2S02nZALjsodvAmFWNo3Bg9rywd08Tf1nUPS55tznlamsL
 8HPe+NaJndcEotyRQHa5Kp74CtqZU04=
X-Proofpoint-ORIG-GUID: FFeqwErc_ux_eRtzZgSonFi8eTw9EwBO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfXww1gsbmhV0Yn
 rww/+zbuOdBahEcCKRKzi5/if1HYKbCaOf/A5KBFWXx0JBgTYLz5OQeSjIJYXt6kx/hbBOfm26I
 Ps0p6DcmpNG7H5erDL3AtL30qa3LklFaWcxBSKH2Q1x43Aco7Ra7aWnzXcyBZdlQWSR11/EZ5cV
 OhF4lBBoAz2X2DlFLs0BXVgEvvGDnBq0d6fUgM/4FlW0DnLaITSuZHZdFaanuGPPm65rtsD7FVl
 V3GwZVAbKGFyaaXtFAi7FYoN1bW2W/FFXFO8CutFNHAbQLtC90xy88w0IZfUwrXUuT+UU+JhDyl
 bJkuAbZuWMy5HqFhNY+lc7IPr6MxmTnocv8O5J2+eRnt8oPGmMaq/+fGf9ot5q89WXDJhr7bTmR
 Cexg24ZankAa+oBETRI3uYq/Qv2mx0ni2amsU21BLnP18GgzgyHwmA4ip52biGmE7CxWb5Lc89k
 WNK7+OcZhQck1Ci2l9w==
X-Authority-Analysis: v=2.4 cv=VpITxe2n c=1 sm=1 tr=0 ts=6a391b6c cx=c_pps
 a=XqXlOjMxTw5Mth5+b1Cu5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=JIIPeFsblN8ZPbdJE3EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Since the objects referenced by acpi_pcihp_init() do not inherit from a common
class, add ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP class properties
to each referenced object and remove the object properties manually added in
acpi_pcihp_init().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/generic_event_device.c | 30 ++++++++++++++++++++++++++++++
 hw/acpi/ich9.c                 | 30 ++++++++++++++++++++++++++++++
 hw/acpi/pcihp.c                |  5 -----
 hw/acpi/piix4.c                | 30 ++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 9e9416d406..1fc2798d53 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/cpu.h"
@@ -357,6 +358,26 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
     qemu_irq_pulse(s->irq);
 }
 
+static void acpi_ged_get_pcihp_io_base(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(obj);
+    uint16_t io_base = s->pcihp_state.io_base;
+
+    visit_type_uint16(v, name, &io_base, errp);
+}
+
+static void acpi_ged_get_pcihp_io_len(Object *obj, Visitor *v,
+                                      const char *name, void *opaque,
+                                      Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(obj);
+    uint16_t io_len = s->pcihp_state.io_len;
+
+    visit_type_uint16(v, name, &io_len, errp);
+}
+
 static const Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
     DEFINE_PROP_BOOL(ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, AcpiGedState,
@@ -608,6 +629,15 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
 
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
+
+    object_class_property_add(class, ACPI_PCIHP_IO_BASE_PROP, "uint16",
+                              acpi_ged_get_pcihp_io_base,
+                              NULL,
+                              NULL, NULL);
+    object_class_property_add(class, ACPI_PCIHP_IO_LEN_PROP, "uint16",
+                              acpi_ged_get_pcihp_io_len,
+                              NULL,
+                              NULL, NULL);
 }
 
 static const TypeInfo acpi_ged_info = {
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 723a87e6f3..71c3735eec 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -477,6 +477,28 @@ static void ich9_pm_set_keep_pci_slot_hpc(Object *obj, bool value, Error **errp)
     s->pm.keep_pci_slot_hpc = value;
 }
 
+static void ich9_pm_get_pcihp_io_base(Object *obj, Visitor *v,
+                                      const char *name, void *opaque,
+                                      Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
+    uint16_t io_base = pm->acpi_pci_hotplug.io_base;
+
+    visit_type_uint16(v, name, &io_base, errp);
+}
+
+static void ich9_pm_get_pcihp_io_len(Object *obj, Visitor *v,
+                                     const char *name, void *opaque,
+                                     Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
+    uint16_t io_len = pm->acpi_pci_hotplug.io_len;
+
+    visit_type_uint16(v, name, &io_len, errp);
+}
+
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 {
     pm->acpi_memory_hotplug.is_enabled = true;
@@ -529,6 +551,14 @@ void ich9_pm_add_class_properties(ObjectClass *oc)
     object_class_property_add_bool(oc, "x-keep-pci-slot-hpc",
                                    ich9_pm_get_keep_pci_slot_hpc,
                                    ich9_pm_set_keep_pci_slot_hpc);
+    object_class_property_add(oc, ACPI_PCIHP_IO_BASE_PROP, "uint16",
+                              ich9_pm_get_pcihp_io_base,
+                              NULL,
+                              NULL, NULL);
+    object_class_property_add(oc, ACPI_PCIHP_IO_LEN_PROP, "uint16",
+                              ich9_pm_get_pcihp_io_len,
+                              NULL,
+                              NULL, NULL);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 87162ff2c0..a91f523c93 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -502,11 +502,6 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
     memory_region_add_subregion(io, s->io_base, &s->io);
-
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
-                                   OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_len,
-                                   OBJ_PROP_FLAG_READ);
 }
 
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9b7f50c7af..4bfe3caa0d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -32,6 +32,7 @@
 #include "system/system.h"
 #include "system/xen.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "qemu/range.h"
 #include "hw/acpi/cpu.h"
 #include "hw/core/hotplug.h"
@@ -405,6 +406,26 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 }
 
+static void piix4_pm_get_pcihp_io_base(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    PIIX4PMState *s = PIIX4_PM(obj);
+    uint16_t io_base = s->acpi_pci_hotplug.io_base;
+
+    visit_type_uint16(v, name, &io_base, errp);
+}
+
+static void piix4_pm_get_pcihp_io_len(Object *obj, Visitor *v,
+                                      const char *name, void *opaque,
+                                      Error **errp)
+{
+    PIIX4PMState *s = PIIX4_PM(obj);
+    uint16_t io_len = s->acpi_pci_hotplug.io_len;
+
+    visit_type_uint16(v, name, &io_len, errp);
+}
+
 static void piix4_pm_add_properties(PIIX4PMState *s)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
@@ -607,6 +628,15 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+
+    object_class_property_add(klass, ACPI_PCIHP_IO_BASE_PROP, "uint16",
+                              piix4_pm_get_pcihp_io_base,
+                              NULL,
+                              NULL, NULL);
+    object_class_property_add(klass, ACPI_PCIHP_IO_LEN_PROP, "uint16",
+                              piix4_pm_get_pcihp_io_len,
+                              NULL,
+                              NULL, NULL);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


