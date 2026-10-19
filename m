Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAFACCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm7b-00006Z-6Z; Mon, 19 Oct 2026 08:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7U-000060-T2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7S-00041b-Ea
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:05:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OmWv1634637; Mon, 19 Oct 2026 05:05:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=LWqo4vu2Fg3/F
 WqYAXVyT0K7RwagwASf7xvte1oCHLw=; b=1PRPyTpkJWzcLIZhxVLc5NUeXh44y
 16UwZFfYPqHbZdlivEdxo6ACaDmFee7NScf+ExbKQoIRiPCq/6Yd1CumEYnH5yeq
 2UYk3CrKhxRVoSpkR5qqatBTfm9sCQHzwmJW0CHfCraPKem9p44/6I9lN+3pi7FA
 irY01k79+d5WybaVXI7KixE9bbbes/2V6xUmgoYqqlJpSgjrT80/Ae8ByvugsKU0
 h755lYRdFOoVRslq0MeLY6AnEI4lZBNKPRZNcChoxR5oAA95tId2xEVh/wqa8FEe
 e2LVSr3NOdq5yLJUR4SPQJ0HeJFuLM/D3mm7D+GR5PaMqb+DKDnRgCRZg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020079.outbound.protection.outlook.com [52.101.46.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8bckg8u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6HvTu7yxQdCQtlNjujuU3McjYVKVQlJH9xlxe8A2rh/46M8VV2QpMPcLHm2mClu1CG+9ImOlkoSUt6vV3m+6D8FrV3T50gH7lKahLAORtHudQ0NcHZ4+AHaR9Z5imkY7u7vsYQ+OlRa/3KQe+6oXR2aoOxO3mbRMv9wOIgjTx+kfwZXR8pGsoGrTIagH/jVM0165ADqnVLLZ5kYNRdxzDusVC5oMcGnUd0djDU7mrqIh7FIEO01hEzzwwHajFfPmX+WmLLjuHDejcatBFEvL/kNkLWIl4lBNBKlkfvi4CoyOx97xdHLxzjinWg00kdZJUrU+SAD3nxNeuKQjwcB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWqo4vu2Fg3/FWqYAXVyT0K7RwagwASf7xvte1oCHLw=;
 b=W92iidrwes70gVoTtTWXoeMUbIbL3K1UqJ+njIZruTrkOclEgA0VR68x6AVVQNt1oxfZzk9a0wLsyyf2EZIy7nLirPAz0ELU5gAp/qoF0Pd8tX8hoSA3oPstHHQE6r5t9nsKPDBQUhB/xLtnIgfmAqLXsTp2QZ5Szj5ZPaAE9reaXb6+nYds4btcVW6ycoYgv+/eJ3QS+Uyp4V3gckGdyBEMHqe5/dzV22KOn8o7dJ4GBecjVAHzF74C2/s4y3t3m13UmcQtC2Eo6xZ/iKgM/IWiEwjhQUMvNqLSkICiGbcbNCEi/AVZXLgJMYilrh6h5kEWjXL1n9X1pEPeNA1ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWqo4vu2Fg3/FWqYAXVyT0K7RwagwASf7xvte1oCHLw=;
 b=iGjY5S7VCGpUw1jeTbcZj9cANAVQ3qFk9mo1oPqXFJAEAZZMYqKMnIKc1rfSsJnWEzNqLOjAKZeewULVWANs6ehoMmMta5wLHa9mAeJ3zltGzh5VBo7+jA9sWQvFpDzf1DE6xal1/sEEMMOqZm22o4TRt6uxJFO4z8VXvNPeUK9mESG/jF5sFA9fjzr00l5WuWekLOU/0qCMZ/Mlj+bOxO+oMQF8C0H66nLMCZ23fgiZBXk3Mp2/F9Q/wqaLxjJ14P4YwlkZCyayoA4ImDH0YhXQTU4CDDQvkPiyqDkqPKuZEhK3zihEVIMtuuwm7TUDtSnPj6YLcLJ6DRL4JwEFqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 00/28] i8259: improve qdev PIC modelling (and misc fixes)
Date: Mon, 19 Oct 2026 13:04:32 +0100
Message-ID: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:a03:114::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9cea2e-1818-49d3-c2cc-08df2dd93ffe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|3023799007|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: /d193rn4EWwLdOPl6e1VsvnGeQQT9UB0xwQFxicPQOw+8BIWuZM7y4ZMdTLyarZKDX1eQ+coBKKiu9TIVrHo3TR0kvOCOa2L16BMOZZU3/ZIquaUUAiw1YDxloFZ6Z14TDVcp+3aVjkRruui/SjSkiF0Cm32aNmM/hKXZG31i66CMybHYbGpDTg55RKCHMstQrkG8NbIyFN/j2PPrzYaz2eyQX7xYmLEf4NzQDOPYS01eHnzJckHuYWdwk+IP1FDZn8GZZv8UcOb3pd0cRE6XAoQ24dwzkWZyFaD0RryUO08pWsTdi6B4p6lLx+VM5eQ4+kUYj1322MOopaoHeAPGl6nTmi4OYY0WQgKcTyNLYePXTZBzoWGDjDH2GNNC0oQfPwMQCHmNV+Iu+iD6xI2euIzTQ2OFrQTxKZHAvlJI0K90lSUSeoTDeu3ML640gU/TBrjff+loJqJ85nlJhKF71yHYM8E4dThwVYO5V2wSxNd5ejX+uyUwgwLlXakJCxDvb/AGnk+vltcXwCja9n9Wa+vs9EK1F3afTK1t45iSQ5OTab52KsnTdoMacJ31bd/oCqWlfuGIDrAodOSe73Vxea/QzET64GX+lphmkRbM297U4HgfjoNrcZ60qSFX4nBQrZBDyUMDgLjR1guP9imWvMHaGI3p1AFbBC2JcgBnbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(3023799007)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sffL8BzqfDEGw6j+6OMironjqIPVZvnLlfFzhCz2idfrDtzmtyaOxF9bTver?=
 =?us-ascii?Q?nzWJWDPtOkNnCAhrW+xBhaz8ErAbWIisNCFS7PFHiurKQD1JUvi+Cb8Mypt+?=
 =?us-ascii?Q?31hGtXgAV+jfc+M77ybI7iUdhi5b2dVYEkAMfFL3tLjny8goERaKz6cVOs+m?=
 =?us-ascii?Q?8b9taABXpoCE0WZUeQhpgltNecEZuavdiA2vb+9CzjnevQLlpfTGmufWi9mg?=
 =?us-ascii?Q?4xRqKmp3zTQ7yhisPY/6nyhPsnCbsnRxGSYpeO5ZeJLPzpuCSXADhWRXD9XI?=
 =?us-ascii?Q?y1gb5CfTQJnkzMVVKZUUp2leZ9SFX/uVjkm7t8bxvf4tZ/ZcBWadPKpfviH4?=
 =?us-ascii?Q?8Q9yiokucLqzzUFDiRHJBzJqPRnwS5UIGcMMrbhzH+/YPsFHhWLAzzgD2scx?=
 =?us-ascii?Q?RSQ8/MYyd0+RRujkRFLNEPi2evYklG3xFGO/dz9/1S65JvFRTOLkz29j3REL?=
 =?us-ascii?Q?wBD43JhLeZaTDB2F3+xD4LWb6RHlMkGF8Yw3WVhRYv82TEpDszn5vf7bBnJs?=
 =?us-ascii?Q?jFIwSMCln+Z+gB6F/l/AecV00LG1zCLh4pFekHV7wFOaAIOgN2HJ+7kIHNNt?=
 =?us-ascii?Q?fRuLM6sdjq+kcaeiNtqLIs64SjWC6m4hFWHXrCAkzrQ/zkhFyHzKGw8wxCgH?=
 =?us-ascii?Q?MpsO8FfI6EdK9Rb6mqQJ45xBFnem6t31ltFsopR3gbsdG+qzGYY5kk0ZxOxn?=
 =?us-ascii?Q?Y8TIiCm/9mvRFg7n8+W1Wc2ScrM7fHPlaZM8Kn5+0YFHVRrD7XCr0GqNLUQW?=
 =?us-ascii?Q?vOss9armeR+Ke27tYjqolnceOLB2yILiYzIZ8hQzoVMnOs2tQX0wK/YEbWgh?=
 =?us-ascii?Q?XReFIWGkeY4+o/t5B+13OXJNkbcyf249kQXhonR8IN1YgYKuQmR36VvPGhQ4?=
 =?us-ascii?Q?LNaBwBcUQeG2jUM9Pzf1p8dwO019ZOZ+qtWP5KnVJ+LwFegupjwatDzMfUg6?=
 =?us-ascii?Q?VXLcRlZLk5uaemZ0g+5dk0zBbdFCjeqDskeZoQRjYNa2Yh9c7Qv6S7b//4oH?=
 =?us-ascii?Q?8gfuiE4W1onAOTKvqR1RUqPZffbVMW0BB3DMNyM1JoBFMyv+Ssv8MRhG87qD?=
 =?us-ascii?Q?pbJbYlny6qs98sGQVVjrZEnc1aV0hWNEvlHtStHjL9WTbQVhb7wBuaDfy/al?=
 =?us-ascii?Q?aJBnIoXoWrzYJvXZfezssnww3FHKC6DC7PxRDYUBho2FP9HhcFhzCX/9hvKV?=
 =?us-ascii?Q?kP8hfi/3H2qIToPeHydiE8uFXSsr7AVrClW4aCJPdee+rnyb8V8+o7cA3+Fc?=
 =?us-ascii?Q?4Ae+Po7AyP0qErCBDqmNLHAk/NI1KZiIm/Uifwbd7oo7vxceWDspn/qz3zto?=
 =?us-ascii?Q?8+lQaHk1OQEHJv0qIoj/KxrOxLOdoyHouSmbZoCbuQ3tsdRYmoC/74t9C/Ve?=
 =?us-ascii?Q?1YZtl4QQruKA8EfW+y3XMloZemDqIYMDqsa3Py1vUyarz5D8N5WgrLYgXKSN?=
 =?us-ascii?Q?tW8RZ8cb552LBaliJljWLEeY/KxE5CqJXmc6pd4s9oBqi2Gj1c9cXvbTDOb+?=
 =?us-ascii?Q?WGJvBvPSjgTc28IATr1P69f9OLt5JVz2+EAD/LuKU+8kNveRhRVWGd+voj54?=
 =?us-ascii?Q?kXz62S4KQJtyDfRwsKEVr1UMQpBiM1mxY5ns4NKMcefEF1SK16wI1V1Ig3k0?=
 =?us-ascii?Q?gH30CmjhlCvMpTcG2HKBmjbNCQT0pPTfJFFcpZwNUF6RTUFuCgghmcXbcM5L?=
 =?us-ascii?Q?hZaTfEC4+oDeavQF9kqGXlmGN0DEQMVopSAkdF9tTLpPpZaYJRhnsweB8h1o?=
 =?us-ascii?Q?irxeUCcirKToPLEDF++HPKLhPEJN478=3D?=
X-Exchange-RoutingPolicyChecked: QJ7reNk0AabXDQBZLW8iKVe2wybcFgQOlNrwBPOd20uH75sPpD6cFLNNBHraJ4lMK0LbUy6tnJA0SaKzPyuK/lQ2+zlW3mRa+3eyDlym8MmD6IkSxQx3EOin+8FhnXHEiijR+s2WzmZbtuGCpOPyW0BfgvaJIPAasjSL8jLdOGJZrIWK7Cyl/8SN9eKw7lL/HxXmI+SdIRfJMOUa2jHlfIvwwiEQcjRE1BNJMwMtABO6zACllgFO1eDeDQQzXv60CY+Jvs+lq6hrLd26g4nMeLA+0nx/iM95gyAsZ6IHj3vwjC7EM72GzAljrepL3+u4cC0Jp5C1de1EorMqWEx4WA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9cea2e-1818-49d3-c2cc-08df2dd93ffe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:21.6975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZZS46j0PzGGKM7A+V3um/Pu1A8SX7f4SQb6L9odgcJorz00OhJBl3qBxIA/EfHtOwtpkS+a7J3sBOAxpWDJH111CqShc7BJQCgxo9XnpCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX13VxlJNhKCr9
 JtmFtXWzclgoAEGL1XfGIVqmnP571j1noJ5BOtw+Gs6pWfCZskd2y8l77oPgW3qjHiGstzEwtr7
 3JHDlGzxv4+iViGG1qhc3CdAnL718Go=
X-Proofpoint-GUID: Hei_VvocpQe0tWp3NZPFWYJDaGRDJ8ch
X-Authority-Analysis: v=2.4 cv=V8joQuni c=1 sm=1 tr=0 ts=6ad60784 cx=c_pps
 a=8R92SGvJzS8WgIKP7Y8NHg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=BA409LxbDWUx7DgykJgA:9
X-Proofpoint-ORIG-GUID: Hei_VvocpQe0tWp3NZPFWYJDaGRDJ8ch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX+KSpNfX0Hhof
 e9//AHXB4GJoebOXBhEq4Wm8zWFcVBEYrJiDlLdUprduycSl6iN56hdaLI1WQzunWAydAiis1Qn
 VEczVrkgEKTfWBmpRW04ghKrBkJ9C5opM9M1EjdMlATkEdlHTFjmkRAqFXWOx4LYwumfOrZ6glc
 lgixbvk4TYBGgcafbvkE8y1WL08UuZiTnLNCbKmjR1UulibFTLqgtFhaxEu1Lmp/HCb9VhFwfmc
 OkXXla373pxbUZTVXGzlsXeaHoB3rXJS2YXa1yTcxk+TPvsrO4dNILC0oE8nHnR232jIZ+WqNy3
 GZyMoWpEFllHRcx3NewMvTsg3YOkIl01lAqNG1NIx5zjl8uSOAf6cYnfB1CrPRmd+Mh2fQcBi+c
 cnXZNtvvjauUkOmYPETC2V72iQj1Hx6gwke+j+LGzKjfUJ9w70ABV6I7Sri2DsE8rR/UqwPlAjv
 p3qHFNkOXvNKNogByIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

This series attempts to improve the modelling of legacy x86 PICs within
QEMU. The initial aim was to have a qdev device with one output gpio, and
16 input gpios representing the legacy IRQ lines, however as I went about
trying to model this, I found a number of other inconsistencies/bugs: in
particular there seemed to be some fuzziness around the functionality that
belongs to an individual i8259 chip, and a cascaded i8259 configuration.

For the purposes of this patch an i8259 device is considered to be a single
i8259 chip whilst a PIC device is considered to be either a cascaded i8259
configuration (emulated/KVM) or standalone device (Xen) representing the set
of 16 legacy IRQs and a single output IRQ.

Due to the updated device names, there is currently one visible change in
the HMP monitor output for "info irq" where the isa-i8259 device now appears
as isa-i8259-pic and the kvm-i8259 device appears as kvm-i8259-pic (see
patch 25).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[Patches still requiring review: 18-21, 23]

v3:
- Rebase onto master

- Add R-B tags from Peter

- Introduce isa_realize() function in patch 18 and use it in patches 19 and
  21 to fix refcounting for ISA devices within the PIC container device

- Don't pass input IRQ 2 from the primary PIC when implementing the cascaded
  PIC configuration in patch 20

v2:
- Rebase onto master

- Add R-B tags from Peter

- Remove FIXME from commit message and rename trace event in patch 13

- Introduce a separate I8259State for TYPE_I8259 and KVMI8259State for
  TYPE_KVM_I8259 as suggested by Peter

- Keep but rename the associated classes for TYPE_I8259 and TYPE_KVM_I8259
  and move the DeviceRealize function into each one, instead of keeping it
  in the parent class

- Add patches to make variable names consistent when accessing
  I8259CommonState from child objects

- Update the comment on patch 19 to reflect that implementing the
  cascaded secondary is actually a bugfix


Mark Cave-Ayland (28):
  i8259_internal.h: rename PIC_COMMON to I8259_COMMON
  i8259_internal.h: rename TYPE_I8259_COMMON to i8259-common
  i8259_internal.h: rename PICCommonState to I8259CommonState
  i8259_internal.h: rename PICCommonClass to I8259CommonClass
  i8259.c: rename PICClass to I8259Class
  i8259.c: introduce TYPE_I8259 device
  i8259.c: always use cs for I8259CommonState variables
  kvm/i8259.c: rename KVMPICClass to KVMI8259Class
  kvm/i8259.c: introduce TYPE_KVM_I8259 device
  kvm/i8259.c: always use cs for I8259CommonState variables
  i8259_common.c: always use cs for I8259CommonState variables
  i8259_common.c: use i8259/i8259_common prefix for functions
  i8259.c: use i8259 prefix for functions
  kvm/i8259.c: use kvm_i8259 prefix for functions
  i8259_common.c: convert to use DEFINE_TYPES() macro
  i8259.c: convert to use DEFINE_TYPES() macro
  kvm/i8259.c: convert to use DEFINE_TYPES() macro
  isa-bus.c: introduce isa_realize() function
  i8259.c: introduce TYPE_I8259_PIC device
  i8259.c: properly cascade secondary i8259 from primary i8259
  kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
  xen-hvm.c: rename xen_interrupt_controller_init() to xen_i8259_init()
  xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
  i8259_common.c: remove unused i8259_init_chip() function
  i8259: move InterruptStatsProviderClass get_statistics() from i8259 to
    PIC
  i8259.c: switch isa_pic from I8259State to I8259PICState
  i8259_common.c: remove static irq_count and irq_level variables
  i8259_common.c: add missing 0x prefixes to "info pic" output

 include/hw/intc/i8259.h         |  11 +-
 include/hw/isa/i8259_internal.h |  19 +-
 include/hw/isa/isa.h            |   1 +
 include/hw/xen/xen.h            |   2 +-
 hw/i386/kvm/i8259.c             | 250 ++++++++++++-----
 hw/i386/pc.c                    |   2 +-
 hw/i386/xen/xen-hvm.c           |  40 ++-
 hw/intc/i8259.c                 | 470 ++++++++++++++++++++------------
 hw/intc/i8259_common.c          | 225 +++++++--------
 hw/isa/isa-bus.c                |   5 +
 stubs/xen-hw-stub.c             |   2 +-
 hw/intc/trace-events            |   8 +-
 12 files changed, 648 insertions(+), 387 deletions(-)

-- 
2.43.0


