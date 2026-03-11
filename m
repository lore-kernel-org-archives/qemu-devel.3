Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3A01125852
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MOB-00027L-U0; Wed, 11 Mar 2026 12:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MO9-00025n-TZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MO3-0004DS-FN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:23 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BFNkr12669297; Wed, 11 Mar 2026 09:26:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYv
 aY=; b=hLGfkVEKdU4o2zNxaX5ilopHyRJzn81l6DE0GDAi/Xi+ELYs63y2GxZic
 a5uVSBQUfEbKCGOVpIDIe/KFaTo6wGL0sOhHKw8W225db0wvKMWhCxqk4cGEiBoX
 /bQkQWra27bOZiL7Fqc6yITOPAqdpfTipqeRXsY3S498QRQY18l8HyNiQvAFYCEN
 4gRp8ZctulRL7r9iDKFYErywRZIlnzOYsxsgHJxX2H5x3SBghk5A+ThN3cXw16aq
 Ync6NQ2K8Wi5WBp680plnwWXxmGsMhWQi6IWJOCv3WBFbut7bsBdhOcmFTHgTExd
 BM5ea0MeaE+xp7HM5Kx1oM40jHyQQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022075.outbound.protection.outlook.com
 [40.107.200.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ctu4gterf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 09:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrpIb2NfU+u7Ro6NDiabA3s8kjS84V/sST6O3+2gRqjfyeGK6eUM6AmqpkebjBnmlSQh5s/uYa9jQyHusYCUhJIZl4MNrGUdxptVHDPJ6Q1OEGZ1Czm0CVd0I+OyfSGWI7r/DD56v7icxtMNaAiQd3BdVop3/d2jigCh2VPo/qipVmdkypzSlmU82q6L+U7CZm3EXwlZtN/h9fy/Sh1d34j7VdsCTq14uzxsgxPHSdw571owKkIPOFb4NpfiYPNWyu+/ytsKySkSSxhNv2TceekJwd5QhSPsxk6lZqv2enUER5FiFVxLQF718MwcHVg/YvcZlnoftfWHYIDG2Itejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYvaY=;
 b=Kq59ndxy8kjg66w4l7CvxGUW1GehK3RTYNdAbErvkLb5knFymStL+5hYARmn9kcdN4D+ZI9G1grTI/HDdjj5VAxLMbgJsmKFTzqApvXbyAmNr0gE6/QjrtRvT1nxpWDYN0Qtc55uKU8g9nCqo1m24hUw2wri03aeN/vSUcEdrGIZKOHQ9qdawklbmWfVACfVNnEqZK6WmK/8knxRbS6OJjPuxE/avm1+1eeoTbjNzSONQk49LiJuykJO+kBnftJHpbVPyhX30jfo0YcvKLFeL9lManYI7YfWcjjrmvQpVPWqcgUshPE3jK+6ol7R5Ot50z2wth2NMn9Ve7vhzQK8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1qTga7IC1eRYfRQrV0AcwdzkiIyAzny+rF9YWNYvaY=;
 b=eexGO7HkFqhwo7FOvN8NhnG/AyOLFHvLpS+qnBalHOMU2vAvWiRe/x6jsH23bf4KgxS2MqNrrlupU7T2H1SK+AEGUwzuKOfWgP+D9Pje6LkAHx7xlgh80yv8wsMBDO2NX05fl5XpV+MXoPVAst4b4eENZTJp+kg3JUaRS6m9RaPAQUSL4gCH4ogCcpzoYP6nrL8keEVzY9CggRgaxgwCfSRlcB09zdnCudgIpaxnQCwadGYX0IztNUi5hM5WtNlN5mKpoHAMddKS1xNN3X3HR0VRrrfiOC9XZPjXkeLJQHZZ30PO5EZOUUr/s9JkDUuv5zhuWoVQ5Zi/zWLVZmU5Cg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV0PR02MB11111.namprd02.prod.outlook.com (2603:10b6:408:334::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 16:26:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:26:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] tests/acpi: allow DSDT acpi table changes
Date: Wed, 11 Mar 2026 16:24:27 +0000
Message-ID: <20260311162605.2976339-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
References: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV0PR02MB11111:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a40e72-9209-41b9-1b2f-08de7f8aea68
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: CVsiijvH6lYvySGPQH2KpKYiaYvoFFZV+uVS1qvvUZHEWje/DpYfW8KPqHWzjYm00V/q/CUMYA5Y6ZykVPgFtZXdU4D/Kt98mrtFOJKkOqx+S6+hvhDJugsYj86RvuWgzu/s/XIB/XMSW5vZy2FAzlWiCJXzky1TtK1rXT+0pAlXrMXjRUZYyfU9N9lFdUuhid1XuxREuZW20w8fL+MpsOIgiJRIAcm8A0dZ1iaf+F0HsOaqwXHr004gM4LXojf4Gb+6P+4t4Xu/7CoOZP9S/06KaNsK6gt48ygb/l9cgXMKZlAc1eEEuHrxlb76O8eW8atzJE+bdw54D7Vx8Q3GPUrEWG8trE8ZebRLRbiJ6lgMKvM2UKiSuIOn7OML+6zOz1Fs3Tg2MwVk0Ar4ww33jWt7hZ+Uv/4TCPBQdF5RHYewKgqONM3Cna8ZVbU5qkDp8gvzCdHzl1jhQW3HnOI8VRnEYSmipFZVlAN52ENknA+NfFK4/CKxtLnC14NXTxrnartkgA8ijr+8+rc3k9bVqZX6PR8RHiyfBl5rsKIRGXbntMh+jpDIBNpe+wDr2uXstlR0z5TEA89YAFOxzL2YBQxOipOJ+960XOU1wUIrzGGiJvWbC7u8uEG2vJewnVn9m8PrcUbMDAHbFWP14fe5J1nFVdSE/A/h9p6+bfWLbnEyiMt5ij8jmRDYDdxcBGxiZiirVtu9YnJT4YImWbsd+sOK+B42tib5jv7Q+Ix/TLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?achKPVvwXtlEZY7fn/z1IJiU/6aKe/A2gZNbBeK54mOQOygwc31gv4HxoKz9?=
 =?us-ascii?Q?RGfgSBnGD5j7DaLX42nKM0Swdpfky36yj92BYHlVGYpIHcshwnywPgDfCeVD?=
 =?us-ascii?Q?Mp4Wbi096rIJw48R+ZxQK7ANgSU3lEVE8h4XPfp72hfeYYp3KMDoVFml/9DO?=
 =?us-ascii?Q?/hUVUmKbgdqYhvGod/OpTcsS2B7OVZeUuOqaUS8l7UmTQMIX8bD3P0gn1FAM?=
 =?us-ascii?Q?nrrLc0FO97Iqh7aV6MGDP0Dk5eLZEVj8G1FwOslSP/k76kuoywTfl4Cx5V9f?=
 =?us-ascii?Q?uk8MQnffbtNo7k4CsHLIGnYFiOD1IQpNQeAoRT98lgUjC+fZpQ3ER4xFmulT?=
 =?us-ascii?Q?Unx6X0GMDG2zCnG0v2K3lDEqPIsdtDngQlXfDWvoEa2ykOYBZvNIS/HXexId?=
 =?us-ascii?Q?IJt0kpe5Dqw6T4taU5MQaP97+4k7fZCg6Lb7Gv+SMrFjRTBGLpST+/fnaf2A?=
 =?us-ascii?Q?mooTla/gGKmvAAC95XZgpLu/NoSJnQ4NG8NJlutg6K25PV1Oi0G5aAPeD3kY?=
 =?us-ascii?Q?f1+MXwwYWRkD3loFwcCaY1n/ZlyRzXYkRCCwtJqSZLcwczL9gtVbNKsShcAt?=
 =?us-ascii?Q?OkMh7rWZ8z6e38Q42oQ2tLneJWobuYF8Njx2Z8TmkynuHsf2yaayBo/51h8n?=
 =?us-ascii?Q?Tra7XgQ1atk1Arsw35BStcmT121vUG0SkYRtWBD8EhaJxOMHkHaycBbKDP0k?=
 =?us-ascii?Q?rcu3Nrmv6H4Lxpi+u55ktTzvxNAIKkgV8pd4zM6dHNpA0MzdVbcG2yOBNJiZ?=
 =?us-ascii?Q?AXbyIGzFDmqwUU1IX80XWOIMGFEVfPIE44ZzVWXKYOasW3+LtfUIIlP0bR+v?=
 =?us-ascii?Q?84a/bH38HOFk3oxE2UuG3b2WP61wnYipefjzQLr+fXGVYV5ENk00uLMBbArG?=
 =?us-ascii?Q?gDIzZ5nyi77keCHm6F4OfSBOwzDngeultD95lt52sx2yln92ySkHs8PH3xoO?=
 =?us-ascii?Q?jak+zpIo2fQs7mxoai6diw1RA0zO+FXEMaxyDOasy+sGluRWiFLcHYZ4qfGJ?=
 =?us-ascii?Q?YhzkQWzA/WcBGzshy0W52QXyKMbKBgZ9OJdTO3dOvsD23/3VHbtlxwg26+vm?=
 =?us-ascii?Q?cU8yYmESACKYe7s5qNS+K3kTY7QBmvzB2QfL6j3s/S8twjvFFzsu7/Ce9nHW?=
 =?us-ascii?Q?Bg+k1kG81UnYolpi0rNdQJNCNV6Hd2K8PietuRZvBLo1v9dt02sHVra4w+oL?=
 =?us-ascii?Q?8BSqdcECClw516kE3CGOZX9+HX6EdATtVwMHbc3+sfdePAehapT/c/NEm5Ft?=
 =?us-ascii?Q?zlwS6whqELuTFmNrj1ishks1J1o51iTztneMVS6n8RsCjy+oyNZXvU/TD7iK?=
 =?us-ascii?Q?yge25hs0pS76quxX59/s5MKzHrjc3XDX1YE/dlhKb73yCYvcDPEUEQDJYu90?=
 =?us-ascii?Q?zhIRyt6bwenwKuiIZampa72suUBZsF1R/j/cIUPVDax/68PdBsV27keQQvn/?=
 =?us-ascii?Q?TOw+N3i0fKuFSADSmaYmtnRihSrUJ4gY/GhM/uEyPC8bNHfIGLBZq2XG5xlT?=
 =?us-ascii?Q?vqZuJ37IoZDLJyKDgcth6CjB4h37FLjJREzeE7ojc51AlvJ2M2MnRj6P6cDp?=
 =?us-ascii?Q?sFExnJ/hVm8b6UijMz5GHBYARvwNwlySlN1d54SC2nc1XZRJ9QcIAGMd67eu?=
 =?us-ascii?Q?xK82Q0xbpIMqVyIEA5GTWfenw8dMi8DC3reJAhn0t7cL6kMDTTz1IpzqAiEI?=
 =?us-ascii?Q?/JpiHIOIDWWkBa8bpt0a4Y8Bc230ncue6wGyXIo0LT0pIkzOzt0lcCKiUY0C?=
 =?us-ascii?Q?+W3IgGzCW3On4pYjdB/NzIp3pmMy5lU=3D?=
X-Exchange-RoutingPolicyChecked: TKlk/bf9f06AEtzLFciU9elXIQ7vqaWtiFbusU2ZnXVc71A/LGMpKmHBIFufquCQKKD0pWDMQtUPzzqUyJAKyDXZZFzXpH4u52aW6jTf7/F9AAAq/M4bB2Rt/KibshosAHTcy/sMGoDsuOinU+mZAWRYDP2Nq1G0oVCOIWG+nLTio5+zRXVYdRa0LZYZuvWZt6efa5zzQZj8BbocQHNNCi4pRlnThD0BIq+vQqItQuE/hEdlqJ7T/Aqt4teSODc5CTzC3P+XGyjjBSGUMDeKKrKSDdLwmTgMAhj2PtCPfAKL3cmQXZk7sKFgQkABWc4BTzeGZOzl5qXo/kLF80DS2Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a40e72-9209-41b9-1b2f-08de7f8aea68
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:26:14.8820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGB3X0qzLQ0aUFThKGkQ8n9HXKRU8VIxqrU8wMkcSCUPJhJ/IaVPwn5locTP5U2P2ETm0/DS3PwTQT//B0lCKAYKuRYml8eOMPEV4kXFV/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11111
X-Authority-Analysis: v=2.4 cv=AZ+83nXG c=1 sm=1 tr=0 ts=69b197a9 cx=c_pps
 a=5czeKszRpWsvzRcawb/TzA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=w1bZv0MCpcxBmq4Jr4kA:9
X-Proofpoint-ORIG-GUID: CYAvPzfFsXt6QJNTMr-KHbFR4t5XdTGr
X-Proofpoint-GUID: CYAvPzfFsXt6QJNTMr-KHbFR4t5XdTGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzOSBTYWx0ZWRfXyrSdQ0ErJdYP
 EyVk+MnnUWdQmFXHevP7gbLtzELLeqI6PKyHExH5orpqyZcxGfLgxDCHSDDusZzQB6CziVZliAu
 cYb69GbXApZwOCdB9F0JyV1zO32+9vEoeJyEEN4U+szqzK+M676rBHGo/cUqWhgltNYmEVmHLhh
 J5gBgu18mbAdUx6bH0/S9kHfG/FiKYwbm6UlS6Kw8mB9UlPpfOVHZdlexmqdsQPQCkKsq321kLo
 P+cwiVrGCtzjDIRsTf62Ua8CgtneuVPWNHm9hCoQnpdc5FxrfQTwkpMUKBQNClahbPbvTX4+3uh
 5z6S1iosM3VmC/9Zp0TptJPsh+5dYJvRaThMYxPBqEtxCkr/K55o8JrHeTwo7Lt5YlIdIAelxjN
 +RMprrFnQEt00x0cQUUz1XRMLzc7U/JbzIQxQD9w9Cu4vIdk2sN05orjJMPHvF6tNeNfhCJPZwo
 GLFBQnW5AUj5EkDczfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..cef44135bc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,48 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.xapic",
+"tests/data/acpi/x86/microvm/DSDT",
+"tests/data/acpi/x86/microvm/DSDT.usb",
+"tests/data/acpi/x86/microvm/DSDT.rtc",
+"tests/data/acpi/x86/microvm/DSDT.ioapic2",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


