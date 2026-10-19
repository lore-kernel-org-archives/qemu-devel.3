Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EC6CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8A-0000T8-5U; Mon, 19 Oct 2026 08:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7v-0000Ar-NA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7n-000446-P1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:00 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Oqxu1634764; Mon, 19 Oct 2026 05:05:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=drx0lsfaYXto4fur9J5UEnuEWZKokyx4yjlzBKisi
 t8=; b=sJmOHSAPXGyf8aQFmmJMhm2vbZ5+4dGgTRml2i2DqEfyJvixALKBzjerr
 K6CWHp+wkMlIUxhzQs1Vbg4gJft3VjInLCXHZ6VlqcaQBGsBxV/AHW25avWFvDRz
 OrvMqYawzaBpObco11UIuKszTc7IdCvKKkhg+6EZQdYbU6fAwmSzmw2pjjkeFuBb
 g1ftF6LS96cF+svYvcTy8nkUl0GNheD9zSRYW16MQ3SETMyPUAC/1YwfuhEyr4GZ
 rV/XIxBvQL0CgzRRmnI7Ht+10e/L/Zf7Z+6qIjjVeOmbFGtx7pygnpsdOMSTzKy8
 1nuBTLQqA14A+Ve2nTxgU+GXxtt7Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021095.outbound.protection.outlook.com
 [40.93.194.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8bckg9m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6zBofYKi3dPp6X70gY6Qgw7B4IsSLZAVPDPBQ6VFRYh+auWCH3CzxjhS02YxG3iTilctrocoCkNmsSYhwQZS4AcnZF6lmURQzKTJciUtW0AcYPWpegyUYcJLrycmVxWv1iEwEDbm68CHOhzUWoV35y4PRKWkfki4OFs3yJZCqPqJZz5X616cdVR9ZvMR7TSFkeUbOzIlsZkCh/YpBFcB2FviUz0q23sfI7B9wWuxrA5OugJrAT91loPsjdETvjlPLz1BBtizhbWnwJ6dKmS7tJk1Kx47BHtyje8fDO3OQ3Amm7kNaHYdfedZ6LQPJMcPVh8WKoMJV2C3FF/vNttRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drx0lsfaYXto4fur9J5UEnuEWZKokyx4yjlzBKisit8=;
 b=MRqkEWPfeSkJKYWq503Tl39CR0JQiU0sH21saAiAJAQ1AlWwZHXLnQBeZszjO5zWeNi/JKg4zg65A+oZDFWvJbXM7Mvw1qk4235ODvqShuKTd6Xs5aQ5gvwQp5v4qlQFopT3uLkMuuBPKCID8+M7gD//XqgNgUYZUKVvsG8ay9t4CUpVUBmyvzfo1eCyAZfnbVYI6s5+s5y0kE2J5qy59uwocXtRR0XJVl7e07tnu5TUkzXaUn0sYjeunuoYXmC39C3P03gwp5MbUSsm8/PIgA1GaUYl9391ZMf3kBekQnHD8u903bA7+Q1SmHa5V/O4pvgQTEakJm+fBnKQErPdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drx0lsfaYXto4fur9J5UEnuEWZKokyx4yjlzBKisit8=;
 b=L7UYfFSOSDhSP/tDSPJdHKq3YkcIlKX4c8bOPYIwJzJgx8squBo0gCaPIZgrRPE63gse36GEpPGudBREZraYnTyaibDEf8fR3kS2PUZM7zANfbicTH/BLhChDeJclyQjXHBXUfxmVVl6aIDJq85BYw+HjdHj4ppRT23CDsQl6LbBGNwx7nb0c1tSDx8sABA7AsxhLxVylpX9F7FE7ERB11Kn4lsYuwEWncz19qTYxGWW48sK6sMpYwFGTW2EfYPBshjQ4JOxtSXSjWg1zMf7x0ljDbSksy9xOXSXmqTdc1s857kReRWtdhc5Zss68Gtqjb8JhDmPMHK77qUm8rNzxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:46 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 08/28] kvm/i8259.c: rename KVMPICClass to KVMI8259Class
Date: Mon, 19 Oct 2026 13:04:40 +0100
Message-ID: <20261019120517.1448687-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7cc0b4-95d3-4151-2fd7-08df2dd94eae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: rAkcBHcpKFjvAbDUEiZF6ymGHrR/0oPd3ZsqwUkX9yQScvcXQ+19quMsparrZaz/dQft8AMaMHLxJLSjJj+CM4mCns1ivDENab5HAaV39HLMsi3Rht5FZLF1cWqizlM90Vsm+007aR8idphnbkglHOdXsyBtpnfN8JDC7//CM0i9bOEpm5MB+DHlL3EyP2Snx/ATo8b+1cA7VyMoy1mgmQt9DXryqZAYcJS+jAVLzqVuhX9A/C1ZjC2AMurJIZCO5cArzhnPjKe5XmQ43EF0sMIvl0XsIb1+LZcP/5zqTGTHd+ISxwz/2fSdLEhZ7wACooChrhVxp1Y+spK6tkylu9m8r1mZKI1aJb586afO7jG9ebQTbIb71AXDHGS+Z2y+mQHaDq1qbxLX9GateP9zqtRFxeVkD4s0pHVzfwvbjL0axqyzfiUooAWdOXaXciHEgUmFtRAn3wGdT8DksQTlyS/B9SqXq5/JUCVpCJMaCiJNbBuDRUxncK7jDbM4LiFCIhxy0lBnTq6+B3wHB2OFjShXF4uPnbGi84Qs5iqFTj/oGtMgZ5XfAa/ZGPHeqWq6k/LXy/1uR0o6OoVHAs0vZQuj2wjVG60Nof5bD61s3S6zYS+AKYIEAn+QkFKZScmGc/8wP2+Hpo2/aJJXxSUzFqD6aBlFIcAvh0anzAXROHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?idnnE6SPfbqqkUd/FAFT1rOWZRM0sTOEKM+5lrUTZ40FyWn+bohrEy7pmmwa?=
 =?us-ascii?Q?vEfj9VSH8GU29QT1a3A1dl+oAZs/8f+HlZw0V033kEaL8rZh0c/zIbF1ji6e?=
 =?us-ascii?Q?4yO18mD+tD5RJFR2fT6mG3Cl68L3XeiLhDxat6eQZV3Uj1YzpbH7Yekti2pS?=
 =?us-ascii?Q?77zZN/NE0JPt2l0D0NrD5Eh6LvOvxSuq83+KB+a7jCXhDAwFvQGbR1GaEiiK?=
 =?us-ascii?Q?PRL8FBuiL/rj1HIdQxMJ17aD2CbvniWWrwDbA4aknM8C6Io281zbQWsRYU0t?=
 =?us-ascii?Q?EHH9tTLY+cX1WQpf9wjX6HnRvoTKa7UjwFgb7b6f0PVUPTpaqYaTwbgCWTzb?=
 =?us-ascii?Q?oA91WU/Kd47pRw1rZi9crYsIC2ErU9TaxyiSLeIulCifRZ03Fx/LtcH8G0RU?=
 =?us-ascii?Q?NgA0is0Hln/drrv88sNUqUI/pSGNUzpnU/Xz8gzUizvsan5Byhg7vLDRuS87?=
 =?us-ascii?Q?j63N6nQ9kuW/J2xI6rPzWzYhJ7/u/wvb/GddZrFSZULNsvb6wUdX7fUasgKR?=
 =?us-ascii?Q?bMI4w35HF5q3QaPfsWRpqiiMQ3OuCxKAQbuFjT8cKwv3WwVPzGPZvNRghese?=
 =?us-ascii?Q?G0pHR6Xuw6hKRTeLlP+qGzO8iJTtLbYHAX4jUXu4RBpeqp/te+UtRiEU5IZr?=
 =?us-ascii?Q?T5NeOTGkEnnowd+/r3G984WMiqEIyHQyO3V9/JZ6ZWRQdZLuEHEJJhA6h/60?=
 =?us-ascii?Q?LX+Ak1M68dxn0vRa3RYVcZmdU28t1JXOZC6lCzt+k9IAh9g2ZY/S+cRK/cIT?=
 =?us-ascii?Q?cAsykxbVUFiXzdaeZNqaiCuwzePjOPIsnRXFvzUFeXWRICNY8IVNAEUCLMFW?=
 =?us-ascii?Q?d14yeq0zTqWI1JoY4uMvdMeu5HUCe1gU9mm12JG4/fuo5BLQEfP4Oq2dBbPC?=
 =?us-ascii?Q?OT4sueRcYG2GUELx5oBUECgIe80O5TpMmy5VT+ou0KcUSbuIazIbsSh0sGlR?=
 =?us-ascii?Q?T5Qd1bvWvsgCqHysSqwiX6SqWluekAkbxSMd4oQc3NTZ00tRLe7krofCIx7h?=
 =?us-ascii?Q?Yep+9oEv4Zl80ZeW5pW/jQzgvObqyC+OdDKqQRoqBgldgHbvxjoDP3vs8kQQ?=
 =?us-ascii?Q?8Q+m6RhXboW3UQAbbNophPfKWdpOq92v3MZn7Cn4hX/AA5rWneGYkBuDl6L3?=
 =?us-ascii?Q?CnNnowU2BNAlnFXAjKb+INbUz4lBlpGzltZ71bRxQPo1WL7Qz3NotTLlQtwO?=
 =?us-ascii?Q?Lr8Cz6TUzWX+jULy70OAAIjviZnL0+m+E+wtwpkwJpApG9cC8HHe3XA4gzk2?=
 =?us-ascii?Q?C2+Z4ivvjZDHMnZSg+D8EWuzvdUpnuj4VD6mTdVn0nNKYSPhe5oIqmDgdRDq?=
 =?us-ascii?Q?thlexRroW5SytE4zRTJJJAFRcUU8Og5dfZ8ZSA9BQY3eWC7ql5cnWRRGkqTt?=
 =?us-ascii?Q?Wgy7y7i5VmdfC6nVBj9NYHs6xEo+swtVUkZGYkYlm3BDDEXz4BWKf6+ZuD0o?=
 =?us-ascii?Q?dCP657DMS1KpVMExGbn55oGYwsGq/V/GlNAo6ncE77RXaSCwHb2JrL5o09Vd?=
 =?us-ascii?Q?A1E4f8hSSTZwHDa+mEkhHkalVpCI0NT13z6+f/7vGXnG1X0lgSDAx6c4dGaf?=
 =?us-ascii?Q?p90+qZp01y//HQlF0TpSP9ZF5NVGrBleRQNhtiYZA58G1PsV+TwYdIdaxCYL?=
 =?us-ascii?Q?VuqWc5ovmyCnFC6NVgkjrKehWc4DQIVS3niBfkcDCwnA3LTNkFZNaNNXd5JK?=
 =?us-ascii?Q?Jpwiwqzfkonlx9CFwOI/9NWw+srhid91zIzwJnKZqHXjo2RG8E59uawSznvh?=
 =?us-ascii?Q?xJ1NVcNw4bbUJStbmeSbD9X01LRqiCU=3D?=
X-Exchange-RoutingPolicyChecked: gdG1vpSCGuu1COSNy1RKZ5qHpLPFhDDn2K8G+KNWEpHNt53tqtVX+Df/knCDYDQpZxK3L6rYAGZzNG2TecS+nZj3jQI2eoUMGIapBOoQ3sWh23UHWb+wKGdpY6yhdQb+BIiJnF9c2seJ/CKWqO6isPZxxeQHgSMjB7YcwWDM9lDGkQkg+09Vnc7x7ugPATqqGLzFkmaJqjAVuLgii/tOnIuqlK6Tk7+gALwSevu+Z+sLAilxM5mk8ZFXrc2HxJNg9/TZtfUynZBQiGIr5p0tz+6fUPkvKrUG4f6BGKuXaP7Xy4wQptToyhCAk/meKlkUPwy3YJCPh0BSH+/QeSKTGw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7cc0b4-95d3-4151-2fd7-08df2dd94eae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:46.3475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kX63DMntPG+1+dfZTTdmfablt+CTcgL6iDRqMFWrXMU7SXvUVVSfTQW4yn2fbjE68LVSqp3eSCp/L4EjTfXviAsM+6gQJ0WktABk7vLZJbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXwu/UWJZXPQ1j
 NIT2wIL5d1sIvsPSwwAfGOSWr9NbvfzZDZ3vKqJG0jJdyUGfz4G+h52oeSVUL33NCpTy/D4XTfP
 1ua1255p1J0U81dvNhLfednB9k/yPzY=
X-Proofpoint-GUID: 1NL8JWMdS3tyls2_Ymwo6JXZS_lYFP7C
X-Authority-Analysis: v=2.4 cv=V8joQuni c=1 sm=1 tr=0 ts=6ad6079b cx=c_pps
 a=KKEi/m33+wCRTXJOHCufbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=7JMAGyXtUfIWgoDCk_YA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1NL8JWMdS3tyls2_Ymwo6JXZS_lYFP7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXyTUTINSyfUp1
 WZ+bjReQq0pS6EAyPNBaV3F4KSMKKmcoSnPVU/3Bb5Y5YIG7ad+l72meBsJCxazO7d+FIRy03Tl
 402ZdviACRXTq2hsw5rvgKYY9NeE4RwDKeIy+oOOG0YFgVHTAiuRkr2kZ/Y+7I9Zw1NWKbhHd5/
 E9hR0tJPXsSFT+5iiDNNW6YOlxcKD+2ulUkvDPwngKMC2LzPcno8MGADwI6myZt5/DoS3QrH7sV
 T6C6to32x5sTXusTXjGloKg6FdxxAZApdf+AK6iZoo96r2E4HdubB0UKVJ2ptd1vWu/o3Ylck5Q
 ekQHetB/XVo8OPhI7VHFwPag8MCKykCRrZD/hCkT74tI+Vu/pV1JQ5u33cbTfOXA2dj6IaDU7ra
 AvWG6PKjM10yDFvJHyr2TKPc2ecthiSzljFq45WeQxFWa0ASoav55N11W9TT1dL1CzC0ysfftLR
 Goqhjfiroo2LO3elmGg==
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

This is in preparation for its use within a QOM type presenting a single
KVM 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/kvm/i8259.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 68607d721d..85176dcf80 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -20,15 +20,15 @@
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
-typedef struct KVMPICClass KVMPICClass;
-DECLARE_CLASS_CHECKERS(KVMPICClass, KVM_PIC,
+typedef struct KVMI8259Class KVMI8259Class;
+DECLARE_CLASS_CHECKERS(KVMI8259Class, KVM_I8259,
                        TYPE_KVM_I8259)
 
 /**
- * KVMPICClass:
+ * KVMI8259Class:
  * @parent_realize: The parent's realizefn.
  */
-struct KVMPICClass {
+struct KVMI8259Class {
     I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
@@ -123,7 +123,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
-    KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
+    KVMI8259Class *kpc = KVM_I8259_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
     memory_region_init_io(&s->elcr_io, OBJECT(dev), NULL, NULL, "kvm-elcr", 1);
@@ -141,7 +141,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
-    KVMPICClass *kpc = KVM_PIC_CLASS(klass);
+    KVMI8259Class *kpc = KVM_I8259_CLASS(klass);
     I8259CommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -156,7 +156,7 @@ static const TypeInfo kvm_i8259_info = {
     .parent = TYPE_I8259_COMMON,
     .instance_size = sizeof(I8259CommonState),
     .class_init = kvm_i8259_class_init,
-    .class_size = sizeof(KVMPICClass),
+    .class_size = sizeof(KVMI8259Class),
 };
 
 static void kvm_pic_register_types(void)
-- 
2.43.0


