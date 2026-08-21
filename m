Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79731C5DF91
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNES-0006eh-4c; Fri, 21 Aug 2026 07:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEP-0006cw-Ut; Fri, 21 Aug 2026 07:16:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEO-0002Bc-5K; Fri, 21 Aug 2026 07:16:17 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Ml4X238202; Fri, 21 Aug 2026 04:16:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5HbV3KQePB9i/RRIFZWNAqPK7yEFnWBFXhI/80Jm+
 n0=; b=FdqoAdeufgXEZ58vtaoKfZM3hHWmmsVWVxaefZJ47ZQ+OBDlt8DZ+I+cY
 ZVzr/uznR/dv7mapPY/xPxkSaobJ6eJP3rlN1wp3jXsW9dqU0cF+VkG35OyusiRM
 ElDu5JxpenlRaRmKuKyYleCinWMrbqiB5Ac+ykmSahXhZ+tBNH55f0iloA0XqEBh
 cx9shL9MonwVVrCMOJCc+1MBWy+35T3wetA7Yo4YZFjEu3JUrWG2vyMzXyP06Znu
 HGxPxFMzbDP74AQPxbsqpZfKOJgfeQNbMZ6gQc0DUnALBIqILHg8gO9y+HwkS3r7
 XZDZr+cCY7autxMFVoJv7Tq1ExZAw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020073.outbound.protection.outlook.com [52.101.85.73])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g658ua18a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrI6Pes0VhuwTuwCR79lQ7THp42UUs5BwLH46ndSVlkThje1y0mtWUiPz+aDONQ3RPj1X9gH54ulcoLoGU066bE7n2o24GMaWbBAIQD+xA14GnTCN/5jmVmBl9Lzb9p4/8EKbUL+rvk/untKSkeoGeKyHZjfpKOMFofRZnGxYwqTQ5Z6OzuBL6c0nKF0gaiUClYKigiXhPqNuGj1JEpxcfXkpXC5pW+NHCGRpPI2R3xbxj1pRJ0/gpboBuS3atAWYPVC0QevDDyCqS+XBQuSOSnXwNayjAu+QqPICAYPVqdL0aHIjOqd6WQZYPMs2lKfkAvJp8AYBH6kQtYyxM4caA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HbV3KQePB9i/RRIFZWNAqPK7yEFnWBFXhI/80Jm+n0=;
 b=tmtXgCZR2nbTt+PHGTPczDCdJahpzjelFmwAfsAIR5/wnPoofNFciXF3kczuNvjzRAXDPgY6CftIO19zwsRZzK0nVy+W87Uf62scET9NoLnaz9SW5EnEUb+e6RUZ9se0gPoYc8PCdCjp1O2WY4HcP5yykdhsdpnT8DnD7QxpzLy8MmdA7FxjgxjFGINsnuHEib6ofJ8IbneDIYFUKs/czEJPCM3AU8km7KuRhCqNMHf17SKWuR9bCtLEYvgWoBLPfYFRil0m+sUmR2uZU2Rwg/d/3KpzhlLEtxmHiUkgmdYVvx+4q7j+r+B6anHRfGsR3lClBPPQUEstjSyZgOLWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HbV3KQePB9i/RRIFZWNAqPK7yEFnWBFXhI/80Jm+n0=;
 b=A8Ahz9ab2tNLQAlrfXb3M8ylXePf939gR+4fe2bP4M+MAGN4EtY8mveyvfsP6taUI+LqK4TL/Tc+YVNcSRnB1pEmL+LD1AKZVGWO/ePKcZ/lhkY2lvJTJ9GwlXWpi1Y6MnGbWuGn0z0MLwHxooDwL4itxEggt8fQTkhqpobK6t1it9Moo6VF3avL8PJsn3sANEFQoJHo9UPaSsAMeYeeZHuIzHigyeC8zV7TViPjWFumq2lmx8VYRCl8O3p/+1nP8rtzhY+obP0OhNz2fRYVSBH/eRG27djZQks0TlAEBkMq5hyflt63AVpwh1A1A4AHKxJcL2mg/4E8xcmo7R1Nbw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 02/16] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro
Date: Fri, 21 Aug 2026 12:14:14 +0100
Message-ID: <20260821111550.276011-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:805:106::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 3200db6e-b5d1-40d7-4c64-08deff75946a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: YOk9KovVQsaHeGDutDamojHYAJclHonh2T2gk+mUQvDrWdFjebzNVAlEKsPejP5IqSCJWnnVmtbB93Thiqbyg1Cox9jv9vsnuvsDSVfcJ4yMydqgV+ZpWAX7dSE8BitHC8TA1s7uC+rTW0YUOQTJbjEfAW21YYiuhRHkiP8aWW5uWV3LoWQDOHYCpLM8Ye5GyNHJDVZPBhVSfykr8L0fkOytkMVeqKvG+CKLWRS3ow07fPA670lx28OUxDTNJH+RyXqhTNk/ibQLXUkQEnqfd/MNJ+sip6sg9AdGz+d1D5Rg9pEob4XejhrB0b9hAnLrtivgbnhBw/ySN8Vgt3W3aAFKdhzPtsLyIfUSKa/AHu7XqLdyIrHsKwHIDhV3261QK2wcjwPdwwUy2jNSRjvzCaOLCX99XN4FpCQcSl4qcPfLMFJWxs8mRtmxcbx0xaSequ68H/EKv+lNAwWi2sqbSzxs5QEtCTbu12tJbmwwnasGqdbe/DbV4gT1y1nx7POjCSVsYmawsitaqsnyymVPYcuks1Yphe0FUGf2pzsmh8Sca0i4rsVau4KLGMWFqim4v9hdG5TtwRsVfttGkp0soSX8dMyeSNInyM1n97RIrIQJPPNOKlaq1yDvzIZ3vEDpqYZHc0TVqGpKF0OGgkFmTVMyu31Zb1Jb/9XUkYaMm4rWt7h6pTQwlU+onZ1LbQycYjnjMF83gvbBVpPAt7s0jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGVYZWhQaE5yNytrTmYyQzZLUTdmblQ2TGtKMEZYRUxUY21wRmM1MXJibVA0?=
 =?utf-8?B?QzZCZy9RYUliRmVQcm9DNkEydHMwWWp5T0o3aDIrWmNWQUZvMmVjQmlTVnNO?=
 =?utf-8?B?NzZhMG9RQjhyUEc1eWNlcHJ4R0VWdGVQdXE1TmJKMDZYUHlOb0VpVmwzRUlq?=
 =?utf-8?B?R0d4UXhJbGRLdXlvcnlBL3BHQU8yUjFzS1VNenhFekFGRnpTVmJkL3JzWTIz?=
 =?utf-8?B?bGRaalE4ajVYZU5CY3FLSEMrdGlJYW5HcTRVQmJzVjlYcVg0azVGekdYdVhC?=
 =?utf-8?B?QXhyNC92ZGFEaTVRcDJLWXc0MlhpZFE4L1JZYWFlMk1yNGlTdXFxQXRuZDlZ?=
 =?utf-8?B?QjJYTXV2VUs4NzZCRVZsL21HMU9VelVsait5eHdXd3U0QjhSbHNSVVplSlBY?=
 =?utf-8?B?TStiNkRTL2l0SGdweEh0RG9iUjVDQmJiY0MyRHFUQzJmYTB1dzMzZHErTHRp?=
 =?utf-8?B?a1dSdnU4TzZBN0VaTFJXeGFVSjhlYUpiQnVzczFUOHpYcXhFK0NRZ3gyQVdk?=
 =?utf-8?B?a1Y2VDI0R1d5QjJmWGFkUkI3VEI3V3I5SHRpcmZpcWMzY1RMZ1VoV0h4OURQ?=
 =?utf-8?B?QjFyUExKZ2FZVFRrQnJ1eEF1dEhseE5lVHNpaHMwWFl3L0dEa2pOODBta2pt?=
 =?utf-8?B?OThYZTNRTU9Qb1daa0lBaVVpQi8rdWc3N29tWWc4Zi9ORGVENTZXNnoxT2RI?=
 =?utf-8?B?cTdBMmpTRng1RmFwNnBBelloQTUvcUwwY3J6OEtzSjRlMzZkM2FUaHBKaHow?=
 =?utf-8?B?ZjZ1bGF5bEpLRWNYTEM0SWRjMWRINzU5WmpFSUlZdk1iZEF4VjhyY094U1Bn?=
 =?utf-8?B?TndGblRUMFE4a0FSOVdvZFVlZ0o2a3lsczh4Q2wzUUhOckdQMXNsbmdoSkdw?=
 =?utf-8?B?NWVYd3prK1JjbW5MMzFxaytkTmJWcUVubTFnSXZIb3p1bllNQy9tc0RVQkJP?=
 =?utf-8?B?ZEtKNG44RmtZN3JYUkU4Sjh0NnMxek9pV0RaaHROcFFtN2poVjBVaENZdHpO?=
 =?utf-8?B?TTVyN3FwSHpHZjJUZUR5bW5zdmNDRDBrWFRYVGIrby9MK3dSbkdwL3FLTUVE?=
 =?utf-8?B?T04vN0dhTmlkQ0N4UThIdTU0eW1uZnVZNEE0bkVjS2VBcksyT0tyWncwa0ZE?=
 =?utf-8?B?QzJxdkFFZTFyQkN6MWloRDVXMVNGSjk4NzQ4MjNQMG9JM21lRkZzS2hzSDV3?=
 =?utf-8?B?TmRtdFRRU1JQblpNakQxVTdCUXFNVURTUmhJN2o0Yy9GdkR3OGFRRVJjdHgv?=
 =?utf-8?B?aFlvbDQ1Tmx3NUdxaWZVdDBzZXNsTmNGNWpQd01wdGFiRkZqbkF0L0FpWFpi?=
 =?utf-8?B?bjhndkVjeCswM242MCtBRmpkWXJDU1ZKWURLYlY2bmNZc2hqZ09uU2tzWjVO?=
 =?utf-8?B?Y28vcG9vUklPRVd6WjZySzZVckpOcmJGSENoYkt6cE9aM0IzbGUwVU0zVU80?=
 =?utf-8?B?U0Zsa2NXSFhqSTVyVWtDVFV6UGo0clVSb3ZXdDBwSVJqVXdWUGd5MDdqL2hz?=
 =?utf-8?B?RGZmRm8vbmRDS1hlOFhoRDE5Mk1EWkwydFlKcmpzNFJrTXRDb0xzYy9KOFpN?=
 =?utf-8?B?MXNKdGVFbm9waHRENjcxZVpmVXB1U29DVlFmTEpQaVFBbkJNVEh0WkEyaU5q?=
 =?utf-8?B?ZUNtd1BmRDNsakNVTEtMTW5KOTJzTno5VnBoa2QwaHZLTmhkMU5vM0R1N3Bn?=
 =?utf-8?B?anp1SzRycFErbWhDNHBoZlpUN3JSYnpLOGJUcnU0U2NGKy85MzFhUkZmQjM0?=
 =?utf-8?B?TTVTUzhtYkJGTHZXVzFJdjlGREFvVWhYdWF1NEtkejZ0VjdXZFVIQUJrSldQ?=
 =?utf-8?B?NThxVTJEMGE4enVDa2JBSVdySkJpSHltZ0Mrb0F0WXhWRFdJOHpuRjdWalNk?=
 =?utf-8?B?L0xLNy9JYzdsTUZvcXhPOGNLT2NIR0NubzJPN1BESzBmeXdiQldxdkhXQTRF?=
 =?utf-8?B?SWNZY2FpTERYNHZtYmlRUVVjbmpOdEZ5QXZCRUs1OERwa01CUU1XWHdCRU9W?=
 =?utf-8?B?UHhLSStHTmo2T3dLS0E3cWRQRURoRmFHcnJ4K0hLYkZxSVp3N1VvVEZtSW9r?=
 =?utf-8?B?ZW9qdlowbnFJWitQeS9MK3pvMlNpNkJha092RzNmT2VNZjNOVU02VVRzMy92?=
 =?utf-8?B?S1diYUVrckt2RzhuNmR1ZkxXOFo2dFBBQlVRTGpzNUNoMXI5YS9tamYxc3BS?=
 =?utf-8?B?SVdTYS9zL1NsR2RZUDdKaVBtcFVtd2xzMU94K2dQai8wUk5LQk9iZVViUnYy?=
 =?utf-8?B?L2pGNCtaV1VaUUV6enZSRnBlRlJSVlo4enpqc3g1TFRWeitpcWtDVGwySFg2?=
 =?utf-8?B?ekpldUR6NWxRK29Fb2FmSHM1WlM5cVBNT0d4ejZrTmJaZmdGa2s0clY2Znhl?=
 =?utf-8?Q?jhJcIjlw/LGcTf30=3D?=
X-Exchange-RoutingPolicyChecked: MX8EQiUtx1FKvM/9R649PgWSsUzH2ecxRMlymdg08nC6uzBmfmFA5gT4f4X21z1pNrAhsFIZ0SpgOnqDfkkmKvT945T1k/TX2OEU4AyYaBx+p0a9ym15LgD3qpN+zweX7pPliGm/n+n0ktP9+8QR3K1K/8maxsQjxbPk3LzTz6uoKCijqyVoIihebg/Omq0L6Hf+oxfN2vsWKH2Nh+a2K3V6/YSJNsialTC9Ajz1HupMk/8zrm1hwchdLI8X+raZhoO5bE8aZ1BgDWQzR2ybPPfRWJcZNKaf0TN29CpAV9/3xjoM/jzqO0a5euhRIWjOBW4U7Ht7Re4yfJukZfN5zQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3200db6e-b5d1-40d7-4c64-08deff75946a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:00.1309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55RU6yq/LOJFWLZxseHliZ2A9FSxJwYajphPx9T2A3Sg2YXnMcVTqfsDlNOA0I05vUCK1ISwybkHFh1w+IaYvJYhN6BOsVqB6PjbAH9zRg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-ORIG-GUID: I9I7mGAYDi4b_vfKToR8lKE2GBFMR3E8
X-Authority-Analysis: v=2.4 cv=GeMnWwXL c=1 sm=1 tr=0 ts=6a883371 cx=c_pps
 a=n24abkD4YvNTwWi8vj4pqw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=E6TFMrRtq5HUZ5UNn9YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I9I7mGAYDi4b_vfKToR8lKE2GBFMR3E8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfXxCuLFOYcoCAm
 QYdDwwTa0EsVvW2cplR6zIoF+9oOV3XhQZpmhbzw7DUfS08+J354eKWHopUjhb1f2q6X1tHqbYe
 wGVpgocxuZqZRhu1I1cnPbbKqightVA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX71XQTTrOYdpl
 HxSB9mXD8jJO+85S8TLWmQcm9Pkkl71szPLR/F975oQsmjcML9NGJYb7/w2a08eGkdLXj8i/XRX
 AaGyZyND4Mja2UVWiGE5fG4ls0lqnpNHLPnAlOblkM/mRHKYgN/j/s8qXu7KGKnoRG3fYeNeM/X
 UlGpOqaQ0rpLEI5Pb1dcJar9ZyM9Ni06Xp7wuylWDvP6FTiIDWjM+CaMtVPbPGyX81epMkglJfp
 yI3QMfBmHdq2UxTsfRPHNXW+vYV5v5+UHvD4cBJ9GmcXLc18fNNxOcrM//tZFwqOAedE3A24kXO
 eQN7vwGj+E4gjmVFposNDh5uyNxhrfGa77/G8QO6S7IvfPXlw50y7iKpojEpCpdVhUsrBuI33sc
 7cj6fxFoljPjzmoInEgG3Ex/Sj5dPhhBUcfm280Xrpf/GoPf1wsaY7ZN6nxWRcKsSRm+mEDv+A4
 R1AG+THvjJNnu20CIYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
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

This macro will be used to generate the boilerplate property_class_set_type_ptr()
QOM set function for the specified scalar type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index e32ae30bd5..fe4e552928 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2722,7 +2722,24 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
         visit_type_##type(v, name, &value, errp); \
     }
 
+#define OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) \
+    static void property_class_set_##type##_ptr(Object *obj, Visitor *v, \
+                                                const char *name, \
+                                                void *opaque, Error **errp) \
+    { \
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \
+                                                        (ptrdiff_t)opaque); \
+        type##_t value; \
+        \
+        if (!visit_type_##type(v, name, &value, errp)) { \
+            return; \
+        } \
+        \
+        *field = value; \
+    }
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
+#undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
 
 
 ObjectProperty *
-- 
2.43.0


