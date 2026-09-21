Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF7CC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cK6-0005eU-1j; Mon, 21 Sep 2026 07:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK3-0005d7-Bx
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cJz-0007tS-1j
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:34 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAhW6t932598; Mon, 21 Sep 2026 04:36:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3mKhQppZii1/VSwx97gX7q5sRGdIIFDaI688NzbXV
 g8=; b=WKEV+oqEPoKrE7VT9DD/GvBn9WS0oGH9U0bXHu56VtFw7Kn3f6UXcSjdl
 TGhB652NfQZb4HuaVvm8eP1lAV36asvwKT+24eEMXGhIZIrJBNMdk1u+FZC7I9T6
 yik1qsd6vmaqgSJG0pX4My1E8UTlcTf4hw5i1BPvZfDtODD3usWL3WP0etWX0r00
 6lOJTYBL4Mmj91RbLKSP2E9zgHqF7tV2wrkC5PG1YKHEcuzCHj3LyDgq2TKh3GEa
 EJnr5n4pBW6hVa7cwGalYA/5wIZLuUzWf2QQGRMu849DqtwdSxO1E6I2QIh2NYhu
 KBwyR2DB2LBY0VB8mNsqLIp9hXHtQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022122.outbound.protection.outlook.com
 [40.93.195.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gssxwk7t9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8q+5rMi+JcWhgh1MxmTK2XhGybpzjG+M6GfjT/CSP9P5tZlKikr2A2v5ALY04kOIhxbPT/to6tpXSARxJ97UFxE2mlak0+Zi2cmHqWv5BDPcoK96yFgs1pFXsbE4Iohlneq5HMULx1gSUcwws1SXfYu/GtgrHYPY/P2PL6Y18DmzoFKGXCLeejtcVn2r0+bbbjo+U4KDPoIkEAb9jIAqZ+picy+gOJDixzvmq3xybcBQXl//h0SHk33FXFGwW7sHPXdQd3yd7g9yYGV/tWt8+ohvo593alfP0DW6gVeArAf9gN/INnn7pw/4aYrGnTg52kQ0UbGAE0qAnxbBV5/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mKhQppZii1/VSwx97gX7q5sRGdIIFDaI688NzbXVg8=;
 b=pD4NS5KnL5NRvToGfFzftltVCa41jc722Dbd7UJifUR1vApMXxqpEUkw0RKOuHjonl8hMuK01ck4qLu113YwLHthZ70kqAAwHDsFYjFgtESsWEN+kC+3KaJBkI/v/mrRGQ0c4u3mgQQO4UKqp+PhNV2WL4ZjsgJK9bjvgJH6PDPT8at/KKtzIf+c1ZbP0UVaVIGoTN3Cgjf71jYkwpaNs1zzgneQAoSs1KBHi6zCWVyu1R46OFU8R+nDAJNuZshuBsnuHRob2UB/HSghbj4j4axVUehv1ZNP0w8MNL+jziNko+xwicr1/LdxnLDsDMqNb0tzwtBEnsRTEu4SGNNaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mKhQppZii1/VSwx97gX7q5sRGdIIFDaI688NzbXVg8=;
 b=K16/edQQxReDr/88Vrxsmagipx+BJNVkQS/nxFBVAccqyvI079VQng3Di9RWgp2y+1txJ+xwC9EYKOuhGNzZDP0XmgAmc0dgYcZCIPTQhELGlZTclwdovnG5p+18xXQgqJ7N8KTxBUEyrYlhXiZF2Gj2papnyvRFzkwD1B2za7TGj2w9esZD1zK9LdzJtbzgJUVQMVlAFZgw4vvbWUOtWaZ9QBAhPGHhFo7VUrLY74gESF72WagmVrnfk1qgLwwSL4ZZbpBugHLnuqMjoRinXrshm6av2XbhqM9SxL3U6vRAJ8r8QtDqb34s1lY8zuN9Ovkoe9M0bxg6ZSk1fe7m0w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 1/9] qom/object.c: improve duplicate class property
 detection assert()
Date: Mon, 21 Sep 2026 12:35:07 +0100
Message-ID: <20260921113559.1299740-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 1080abc0-9b67-4d13-9a00-08df17d4864c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: M0vE0zZNRAHVh/xaGaqk6DXiuTnPiSn+fW1HVH2WkBEge+8DFVW9ROzxY39j2O7w8GIwMxwSi/0gj7/Y6Vy8PPidy3U3b7gFIFURg5PDHpRKUPEUOcEsA2Q4irDw+menDO2Iz+zTZeEcTFjnPmZSRk6X8VbBz7IMRFzd07+zqAkChW27Scw07oEMC7NpuL31IPKuuGb9NRyhTfnxx+hWEPQ8i7L1A07uJ5JZbZe0wO818TxxPrAjF6eLGu/BC3dXaOJMRyTUYs/0QEjUjftNtQvs9pNoemUlTKisNyYCnnA2hvDKMpjBFBnPEBeBzoBAM7ukjUBWnFnvtAx4cczaadDwqoh1tNlSfPf//jtHPJNQt88oy2Vo+owSuoJ17cZVO6NuX6iUUBegd1tnZFXanwSjjGjd1pwy6+7AaKu2qqSpklyJN4qZxK/3Ox8kMG5rhjWlMI0XKz0YacsVJDDO9KZl5PBWrvS6DuKdizgJswiLyUdMaMrjXpAA6uy/qhdekWzMIGEpNhVH47H4reBzdYe3L92lkQI1QzDFWEWMJ0L5tLD/m5QrxdDk4fFNIXXy5gSR/k+jMPups6HL9CzeVH+N6FQFBnCjmXFlJF6FRD8gZt3ewRHmb3Bi0EzyjBdaiIJdj+q3wPlnZJhvkmX2xPsz9biDGNrHL4RvBqeObZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YP2ZszmJkuLQmbb5QQP1aU+PBGyNJqiELCyYPUxiMhBzCGxkqwzkc6WPGegR?=
 =?us-ascii?Q?FyKkvEysr/I7TNI7pswjSOIKx9G7dmSHwK8/sz3rxO267e/WNywp4G9lnS3S?=
 =?us-ascii?Q?RcAdLXAc7k9aX3ndqyva6eWTzbkFumvU0qgmOGJBtr2SeQfDESUmAQLOyJIQ?=
 =?us-ascii?Q?b4zsSpOy1q5M35Pw3+lrm0V9rSzgJK/KWz3SZOxHOd0NR2mY62G44OxcHzU3?=
 =?us-ascii?Q?PemZx7bfBt0ResfWoaqi6iBaqLFz2dhQoUZN3SLk5AUUgMmxOUrM2vSdtS7Y?=
 =?us-ascii?Q?Hc58FqU90zL5aKFB/nSOCQS7IoW698A3DA8imiKnOZkBeT5Nhi26dWOQ8s2k?=
 =?us-ascii?Q?XYzjiXwY6yNZq27YH2vwd3pLrXpL6X9euxHcLjm0pS1W6SySSnhtH6kQMwBd?=
 =?us-ascii?Q?4EZI83A4y2MeKaBlSc6UVLpfRw6l+H2H/+VzNqXlNt27SJqgUZz1Sfria++7?=
 =?us-ascii?Q?SkSyFQb36LYY6ZUz7oNm4ebcfozYCYvo80xK9kyhPXihAG2tSgQQNLakGRU1?=
 =?us-ascii?Q?lD/4lNqySQDCn/ix1PHwMl6N4AntJgIMlui8x7zW0n4lWakIbGzz8I3TwYcI?=
 =?us-ascii?Q?2opGXMB/aawJXN62LvF0r1iuwFT7rPvql6Qqt7Y36d8ijHYymx1lIkCG83dO?=
 =?us-ascii?Q?Q/PAjN8La7g8Hu5TOW6V2pOj41b5aFuvKiTZlm+SB/DsfyG9MA9VmJ8y2Ml6?=
 =?us-ascii?Q?Jg0HGdfS1fQ0/miOm9veKst+3VakVwOxX382DUYsNnn9qrCk87KAN02eCV+Y?=
 =?us-ascii?Q?WdfuRV3cnm9qxim6ggt8EJfwU+pMApwC8LwQhSCY556CmEP4Zef7SDsbzQS/?=
 =?us-ascii?Q?npdzEPwswdpFt0coLYOrK8r0BcNm7hMtCOITjX9VITPJcLsgsQ9RWo4uhKAI?=
 =?us-ascii?Q?BoVT11zc0T6qanq0hZXxQ/kJDGIAw74Vcj7boVJWV8hJL2uMDZJTIJ1HIOSp?=
 =?us-ascii?Q?i0veAh8oqZ+TlePe8B7pmFl+EfC0QPrCdJN1f4xGr4uAtZwIFlAHGHGVGoBJ?=
 =?us-ascii?Q?BGPFJ40QvUnzse0bKMiROOtU6qUnQXCfj/INwVJqq1burxEop7EyY5jZGu16?=
 =?us-ascii?Q?w8VmcKTdSfVL/MdB3wraLZDXWfEBTxueGZxp0FYBNyfMYs0pUSoRhkLKJd0F?=
 =?us-ascii?Q?Iu7h3CGM4n1bWVKiF5WPfPs/amSwEScT3xUeWF6M8LNUq/g1eqDtmz/NR/Q8?=
 =?us-ascii?Q?UiJEnn4o2/c3R6Q5qeFrpwspASX6diTC/h1N3IuFm90BXEce8Xv1oXQwYEEV?=
 =?us-ascii?Q?fWDlYxGUMhD+U/tZw3kxZlJIKECF1d4RRZOVl8L45iELQ8+KgksCnngQ3QE3?=
 =?us-ascii?Q?Ven6Vzta0BHJmrJLMIRgVyJeazDcz/U5cJCugEBgNk0dUtZewM2KUoQjWJ/W?=
 =?us-ascii?Q?jH5MaZnMcOCst6/bnXI5/dMrnZ9MFpUoyQQpjFJabQ+rvxHHwNFSseK2vpKR?=
 =?us-ascii?Q?nsq8OOGX3tZ5YwWAmmw9FgL2RQm6DmKLZcpwWYKNuuxPvXA+4E4QrypZrXZU?=
 =?us-ascii?Q?b+XechEUopR9aAe8s22lFli7NNSIc0Tf5gaa67p5Lws9gnjKDKPuHzUSLBJB?=
 =?us-ascii?Q?MKVheX5QVX66gGDguVDewvy+ilHMLrGWCV5BE7zHsyJG9YEqY6zbR5CS3Ktv?=
 =?us-ascii?Q?yu3gWsTty3HEC9NDXnOcKd57d3JyaRNaSq2/uSh4OFnmNQfRGGefKdrQOBww?=
 =?us-ascii?Q?WojScYy2MADkpAlw6hhBjVVkQwuvkhdOh3Fy/0BJ67GQxnG8viYSWeSelCEW?=
 =?us-ascii?Q?YyJX5bVvopiKIEM1jjIRv07FP6bSbNM=3D?=
X-Exchange-RoutingPolicyChecked: 1Hqp+dA41FqIv9E6cpCb1EvZXSfjCF4jc/HVjm/oULT030hnWP/W6y+meUYoFaW9GyaBLV7RLBrr7GjoehO/ul7L7GFCUm3jZn85aGixbY87CT/z462gCLesKyg4TrlBvCKXl1aCeQf3RjQFUUrUuRA6FwXDnABAWTjMTCHGpcuH93QRmWxlpzj8rGE0wOJk+Oxld4vV0YQCke1bg32pTgkcRqw5TRQIZKFzrN/CaRTTlQDal56SH0+oZJhOdmawq8+vs1nSd2gipG1h/PcZ+F7LcZComg2NUV0ebTWfDCR2gs/MxCz0sqBi7xgKgr73jFO6bvWkV7CxQQOQvzvGPQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1080abc0-9b67-4d13-9a00-08df17d4864c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:06.5842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pe2Q4yxe9w5WCPcV5Hf2YxMHGpOAgpn+AjdPZJIAsaR7rZZv8U+fmfjH7rLNT3LoZ/iRE2HuzHTHQq3YVEeLuwVkIdLT0cayIicEA0FX4u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfXxvpiAVdv+2vf
 rApzUQqwsihlHtU5pe43K81sMjXm/jl/9i5sn5shp1qGgQ7YX99Ynws3LiJeb0LyKc/O+lVhKlv
 gTpkmKTHfmtbSixp7i2HN8FmtiGlY7s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX/ULopu0Zq6LL
 BC6QiCSxeLQIPY0XpA4Ora8efVmF7qkuje/sp/+v3Pms8pbJ5OhYC6feas1Obx435enFdGQV4cb
 xSRn6KkR7QIW95jmZUrmrwUtkq/I7yyrt2H+QKkrCNs+x6Y1OZky3nZOTvgUdtSL/CQ/yWffVQo
 RmvIhnOrqFag+qGU6JB13BYScquhmENWRJgAPjqFRigsHEpa4K385f7Z5mizcI2BPjh3ZRkAGEZ
 2O0uhqPs3zjrKxyZfIvwruf76ws5TyouKlzqc2kCs2pX9GCAqlGRf8tLG1WuHj5MoWenxbg8mr0
 gT0P+gIrljUMDMWeem6qJ+k/QgDsPwLM6ARNroftk19GSKwcLV3NzDGy39pc+NkJ4TFETd8IK2C
 Uu9lQ1PCIws6Tw6/jbaFwpzSjloS5cLRTeNJ6e85qCodw3m+0Ekd9KZIZFXFp0aNqX6ZVjRpv66
 yXNYBMpDnzKKeSysoFg==
X-Proofpoint-ORIG-GUID: Ju_yfk3MGMNL8pQZ9nhrEaoEYlDw5M1b
X-Proofpoint-GUID: Ju_yfk3MGMNL8pQZ9nhrEaoEYlDw5M1b
X-Authority-Analysis: v=2.4 cv=fphJ914f c=1 sm=1 tr=0 ts=6ab116a9 cx=c_pps
 a=Gvitfrn81X/13pqoc+dbVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=VSpayEaEruTAxCbBNBEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce an intermediary boolean prop_already_exists into object_class_property_add()
so that it is obvious to a developer if they inadvertantly introduce a duplicate
class property:

qemu-system-x86_64: ../qom/object.c:1417: object_class_property_add:
  Assertion `!prop_already_exists' failed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 41b1ec81d4..914d1228ca 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1410,9 +1410,10 @@ object_class_property_add(ObjectClass *klass,
                           ObjectPropertyRelease *release,
                           void *opaque)
 {
+    bool prop_already_exists = object_class_property_find(klass, name);
     ObjectProperty *prop;
 
-    assert(!object_class_property_find(klass, name));
+    assert(!prop_already_exists);
 
     prop = g_malloc0(sizeof(*prop));
 
-- 
2.43.0


