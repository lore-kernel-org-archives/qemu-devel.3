Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1152CC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIl-000889-Rt; Wed, 30 Apr 2025 15:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIg-000848-Bp; Wed, 30 Apr 2025 15:40:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIe-0006F7-6Q; Wed, 30 Apr 2025 15:40:58 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UGnnZi026909;
 Wed, 30 Apr 2025 12:40:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3cWts/br90n3r72SmkLiuwTzLZ/FmKG/8K8ZfIZr1
 tg=; b=abEvlBIR16dtDipZTmRXT903FC+dDxuTSUHbw7hOLphfgSwcBD3E29bMn
 fMKxqVLB/DdEK8Kfc4nRrzaofEu+1t5lOCyY//EWBBhFZ540bjM2Qj4yfSK+yb7e
 w5sU1fe2UF7xusqXUQ/x+Pwrhug5B//kLfK1Exx/3oBRbcPEP2LNJthoIAEYHWLB
 Ix0LoKanHgrFixzwjeG8KEjkNc/z+HL1DFcOd/iNeg0DIKNi8T5JtgxCNc8cfMRN
 mSNcNQ7imYoJIme/bO92idOwlwrq+peSbrDtZr0i8zArNnA8nG8lNaB9cgABreXR
 UgVBKVLmrSfrV4nr9hF4/4MgxNvpg==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46b4m1jxpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD9lgKC93r/L26376ciUXfJec3a9z9Uokz+YkykCauCbrdq997xgDMCInbQyQTM3uzL0KDmCSmkWvxDAgx3VYu8w9U5+nFIhcX9W36O92TS5oRY0sW+Nc1RVh/MgPbc2JRgo6kZGT0yaP4OC/tm6KJno+m6HnJZaS1LsV3prNaShL2e3qDl1A7m4pnx6jxEUooqpOGteKeQMi1XvuXMN57NVYzSH06WMhzZCNGxTL057wJfjmE/u0wyeXENAXCr++rIQCP2GoAzQB5FpXy6bMriZGjmJxZ0+W6ESNOmqcKzAT2OZoHSRiBYBtKbSNu0bxD+FlGulyx8Eu9tbvjY1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cWts/br90n3r72SmkLiuwTzLZ/FmKG/8K8ZfIZr1tg=;
 b=b1I0OyhKTv2IWm5MsJ0sf/rH2vRk6INvt3ZiWv6rtKlocbH+/NG58AoHxEALfItr0ySOHJS2wT25Ts5PeCWEf50B77gwCdeqE1uM+0TGG63yQjMQ0FHomYHOq0OayF4uZg3i3ZUvkQ2ylnic/3y6pStTqdHkkJOzpMKu/YJ03pP93admklKFbsLZGlz5VuVjZ44jx37fy348fwX3X3lk8PWq7+r5UdqwbvL5urQDrbwH9Rv4zzc+0Bdx1hr9t+JaLiGzNfbcH5Gv9EMLcEtJMGLd9RoEc/g3QEC0NsM7ByCo+NDS2nFpRAt+NzhlqPVm6WaKopnupXaxOBAr4j51aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cWts/br90n3r72SmkLiuwTzLZ/FmKG/8K8ZfIZr1tg=;
 b=gwz5MIQGKOqxoosHtzTMv/Wh9nTINLRd0YN6DHB0+zn50FsTYentag5B9Gfe9GDQEQIfLRxfGa2mND133chxX3ufUeC7PIXwxd533UzSxh3AXhR/aX8WagGOB58pspoINLd8Q6USx1X0Mk86/vz1triKuZxJWnlKUEA+MoSDt9chsDoBQ0Pw2rMwN5XyHH9i9N6t6bZd1mmVgv7W3KrPxkWo5hxLElmSWucSrMI9Ox5XMcEwPXTlr6XzytlJOgIRz6qiJtC+DhXBn1CxP9qTnbCV4AxjseF4Q+EWG2Blda3gp6FJMLrAhWYL69K2iiUvnEf/InmslkjFVmkUCpB+0Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:51 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:51 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 13/15] vfio: add vfio-pci-base class
Date: Wed, 30 Apr 2025 20:40:01 +0100
Message-ID: <20250430194003.2793823-14-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d7e5e2-879c-4504-c6e0-08dd881eea11
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0QFByOseXQZG2Kblsf908ai5n8gjL3L4wmba8UoQ2r2lPixHf0c2LfbGFTrP?=
 =?us-ascii?Q?yFdPuYzPQ1TS5KfpVfAUl+MBPNFkH/rLQ9f5MCZOdcRRGK4bbQkq0J/tKfHT?=
 =?us-ascii?Q?CkF1E+CUCbJQ6cqabzeLTaO4H8+SVftywHcoi1DyRbyo5lx0OhamBvMph0XP?=
 =?us-ascii?Q?spMp9bBWcH5UtkEgn1Jpk6BEk0GzL6ikao8LonrLbEa10qKEHdGJHq8CBQpd?=
 =?us-ascii?Q?tPob0taRvZv619CPfdfwrWh/+/5aSkChsLU9iiqXlXcVhF1k4H3jLywWmChM?=
 =?us-ascii?Q?pzX0Jd3O+L22vOF0rnyO8L0HVZK8/8VrhR8KIhhEt1kxKqCyq4HLCemSN0ja?=
 =?us-ascii?Q?2T925LUpDzFFAXLOeJabfvL5rlPSHt3jv3SgBKB0uoxG9RvYUmTr9YQHtT+3?=
 =?us-ascii?Q?tJSq+Q8sfjoOOEq/Y/18TBULcc9pcAWW7wT8YNstEat2S01VsbglptQ/HX4H?=
 =?us-ascii?Q?8/nGEG08GkofVi98Pc09GZJvtuRcvE5A3ugVkfmENfGwY9U3grOZErU+TV4p?=
 =?us-ascii?Q?jyJLC+t0RBTEXDA7XKK6R6FG291dVsjIrnsVXm6fWg67bRZDBtuy11yuX7Ib?=
 =?us-ascii?Q?I8kFD3iw/vXsSy6s7s/0euerCuySuVGH929ybA5gOzCtItWp+5Ot/ANu42ga?=
 =?us-ascii?Q?vGpVV7vWq3rIqQChuRMiyyVUEPKUvIylIcK5Kw5UrSgx0kQwf4Nd6i4smcYZ?=
 =?us-ascii?Q?Qqw5oj7ndeWFTrosHeZAHzo8CaVpYVJurd3BOnLW9+uPRM1nUxUJRTtjZyqw?=
 =?us-ascii?Q?B/Mwi/a69ju5XHJEHIs43diLmhWQQ+B9Da30qOR2m6gV7KNlY6CVfiy4cobl?=
 =?us-ascii?Q?TT1IlpqCMSAz6BRpmlltll4e4FdYYArEz6dEz7ErhUNpFm1/aglGqu378tKo?=
 =?us-ascii?Q?9prOz76twaUBof30evqJwwStBhIJ8oU7chIAbOiZYaM1c4HBdSfTOAFsWim5?=
 =?us-ascii?Q?7yzUIJY9gNnRWthGRKTJml7hFn36//CEtqQyF7i2kAialYXKdWSI567fa+9w?=
 =?us-ascii?Q?b46GLCBu8O9PlOxVR8dzVDuTYI0HhMNJxj8EnTazqn1pLQISgEy+6x1X/zk9?=
 =?us-ascii?Q?Qqwg2uSzTdhNjoDwgvm5zPMNG+Qa7So3KrboN8cfVc2fA3j+t5Vcg4NUJ7y9?=
 =?us-ascii?Q?6Sea6F1paxhqzPFjUp8L+vSfXgPTJOmvUd14ly8OGX4GOk3sbpWxfGThcOM2?=
 =?us-ascii?Q?vjJ7IMch0g+b6ENRHBn21tN53Vd5CekvaFJnY8/S9gLtdyaouytdNZL7aDjl?=
 =?us-ascii?Q?gvyh+KsLbJFGt/CSzxP+hsgmNMrez2HXF3ab9TJ1j3A0eJ2q7ZX0vKCC/It6?=
 =?us-ascii?Q?142sPMkZoUZf/lWtsFzSJVWn7jxSdzPP6Dr/uIQtNVzYGUjDnGTk4E1ClC8R?=
 =?us-ascii?Q?CuqgGwkKEqBEceEKRQW0ErKRho3hZrzs8QJbRN5yf6DgBk2TID5Et/QppnmJ?=
 =?us-ascii?Q?zqIWjoQ4DaM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09IPius7LIic6tWXFeblWcI6cZTZ0dyaA/l6YR6CdDc+JENEzVYa9ij/qm1r?=
 =?us-ascii?Q?Wg9XGYg+QKrtYsVQQPtnADs06/ZGmzIbZIJS/VMHslF14KfsPAzzfp5Mg0o3?=
 =?us-ascii?Q?n5fg71gTPHxCILSHwiAw5mJx/l7UoFJFCNNE242jgUp79blMDNEZSFWT1tXH?=
 =?us-ascii?Q?mYxA+uGY4Xq/G0T4b6X9bDOAr9kBeeoLAD+AoLhIFI3ebYhqyDse2H7ajark?=
 =?us-ascii?Q?uJ59I1h2zVIsGgLCFGyOWo1FZjCINLTzbmsQKnA3sxw8cWuTHVKYTkOXijiG?=
 =?us-ascii?Q?GyjDBpHCv5uQY0/5BRTEmsskxA/UZbQV+vxzrHegG+N8u5owLvhJn2GRYRxH?=
 =?us-ascii?Q?LR/un8eG85XpzMb1Eff2PA1/HFd9SDV4vVGpctgzmnlSDG4eRTpPcxPhj1/k?=
 =?us-ascii?Q?5uae0ljG606XwC1CCnimMqlhNj1FHwk6Hq+bUEEh2k9qVgoDFDQwu47szNbF?=
 =?us-ascii?Q?zW40gYdrqxIEpr02niZ2EYEGkTSIos5yhZokT4njtgdF3BZ4JFoZKuWn+mOQ?=
 =?us-ascii?Q?8YF24XPtEygm163ba3HIfX9aNPyLDWYCkM5ua3sLKwoUiTZ338D0ozSD2NX9?=
 =?us-ascii?Q?hv/taKCWxW0lzxqDKdQHhJFw71jUXHNrNdZgBd7Xeii1V/a1ivAImKA9GNyc?=
 =?us-ascii?Q?4XWgq7MIXIl7iLdZvpi2TPwiuLCMDEJ1x6JvYEleI1zylYh3r1V8x0EidkKw?=
 =?us-ascii?Q?XsIGGCvy2vhGlcrZBgukA+epVwHEG8Fb6LBtgoOsJnJXDHKiOvs5F5qmPM36?=
 =?us-ascii?Q?oFDI8iSSgBy4qrQ0KGePcGV85dAC9JnCjqpOtLaaaNXBdrTsiZcKRqvVMWFD?=
 =?us-ascii?Q?nSiTgYATKxvtciqgvboyC9K6TZ6GnCrdoSPf5nseh/JftqHlgIhlTIE+d9xv?=
 =?us-ascii?Q?9ABeyTZqPGXadPuae5sUlTFw20mMuI/2h4cRgdpalLUHcClvXUWQ3gXBNog5?=
 =?us-ascii?Q?mAzCJ5/hyzZieG4HkK+Fekx8FF2ppBQcG/4vwr9YQBQ2VdfVvhKGaunVfdQP?=
 =?us-ascii?Q?bWHWl4FAX4wL6jukORhk021146abKHypa1ZJH+lKNiCeaskb4ad/86mZ6IYh?=
 =?us-ascii?Q?tEWK95MQMjVK9oXBS2YmXD9Rfu7STp1a3AuN3SgqR2Tp8yntwCgSsxEvUhHc?=
 =?us-ascii?Q?U48G97OQJD24hzX9I+jxmaX5XW+1MHLN4FXzI3Cd9Cxnd+qqUKxUukO4HQ6+?=
 =?us-ascii?Q?Q5QyHxE+L2vb8EUCH7tzGA2omGFenYnSSYekm33nVMntv+rh0Z4uGmtedQLd?=
 =?us-ascii?Q?v3Z4LGBzxk0o/5OgYIrDgF1tCGsLYl5JALCrOSEUj1QnBje5FP3RtnwNYjHN?=
 =?us-ascii?Q?LxCXfM42gnrrd92jJHhEaKXgYEHhsszLj13DyzK8j82N8Ay+GWdF2uBaTliu?=
 =?us-ascii?Q?3cP5jYbViiytbsdmxUXZe9s/28yexrjMMrq5YUB253DmwN2COZYWBrX2v0oT?=
 =?us-ascii?Q?JR80bzkF4OlZ4M4Sj/aM8xAKeFgBJU64FFB41bAfjVt/jN3wQJT62Cnwlp4a?=
 =?us-ascii?Q?kNGJbednhqzSY87IpOnIq8ZtwH60QB0uTcHfSL+Y4hcMEx5qcHBzU7GDiNQv?=
 =?us-ascii?Q?cnJVQpZhcQLv/W9oz3zdv0QHb+gDatISwAIPrLLS?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d7e5e2-879c-4504-c6e0-08dd881eea11
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:51.5345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sxFc+s6bYVTMI1KxfDdRbhxjGtJ2ByU52xr8TQzaNf/wl5dTb2QL/HNwDM1y20Eaa1Ggy6Z5EpzX5z/6RiQ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Authority-Analysis: v=2.4 cv=Y9n4sgeN c=1 sm=1 tr=0 ts=68127cc5 cx=c_pps
 a=MGIL9jhmtb3Hqg0nl2vIzw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=4KTYh4CsxjRY1Y8snwgA:9
X-Proofpoint-GUID: OzytvnbApeDNlFdfYhYoxrgMGx5Pch_t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfXzfyafYgGGV2X
 UiUiuxv/dVou88Qt1+7LVYKWWadORYKpDBfvfNrXq6VFpohcHQ25z9BwhvynKfCgH2wbjE0XWRj
 5+sSlavNMyTVjGWmMHtvbrGJXFt9Up0LXTxD34viz1DmohN1bF+vLqdWUOh8V6d0gGBxUUtRU69
 LMK0cGx5oDhZlIEqieB292bQkIGzvWuhSOYXtGKQr3ytbJ8XlCCRxLYsKp5F3nyOTBYI8Trmfsm
 P965cu/tRT3zWYcMHBE5Ejq/ytVNimvcaBthhDvfPLTg2uZveSlt9oskZdb1tCAFYu3rJ2Q5INn
 P+w7JaK72ZcAM46e5Wl3BiED3zXC2/7Q+N5vG2ZBCWkh5LCO6ZmzTrQoCM0AawNuN/LvZkoExFo
 dwwjBworA0Mps1cWUHTSmdogHfe3V9ab+5vQxA1OpuGs1H33vDK833gDYydGq0cqU4L6w0i0
X-Proofpoint-ORIG-GUID: OzytvnbApeDNlFdfYhYoxrgMGx5Pch_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Split out parts of TYPE_VFIO_PCI into a base TYPE_VFIO_PCI_BASE,
although we have not yet introduced another subclass, so all the
properties have remained in TYPE_VFIO_PCI.

Note that currently there is no need for additional data for
TYPE_VFIO_PCI, so it shares the same C struct type as
TYPE_VFIO_PCI_BASE, VFIOPCIDevice.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/device.c |  2 +-
 hw/vfio/pci.c    | 62 +++++++++++++++++++++++++++++++-----------------
 hw/vfio/pci.h    | 12 ++++++++--
 3 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index ceb7bbebda..70d75b271f 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -395,7 +395,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
-        return &VFIO_PCI(obj)->vbasedev;
+        return &VFIO_PCI_BASE(obj)->vbasedev;
     } else {
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5e811d5d6a..8d29b4552f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -241,7 +241,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -514,7 +514,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
@@ -620,7 +620,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1196,7 +1196,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1242,7 +1242,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
@@ -1276,7 +1276,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
     int ret;
@@ -3129,7 +3129,7 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i, ret;
     char uuid[UUID_STR_LEN];
@@ -3300,7 +3300,7 @@ error:
 
 static void vfio_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -3318,7 +3318,7 @@ static void vfio_instance_finalize(Object *obj)
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
@@ -3342,7 +3342,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
@@ -3382,7 +3382,7 @@ post_reset:
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -3403,6 +3403,31 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
+static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    dc->desc = "VFIO PCI base device";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pdc->exit = vfio_exitfn;
+    pdc->config_read = vfio_pci_read_config;
+    pdc->config_write = vfio_pci_write_config;
+}
+
+static const TypeInfo vfio_pci_base_dev_info = {
+    .name = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = 0,
+    .abstract = true,
+    .class_init = vfio_pci_base_dev_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
+};
+
 static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
 
 static const Property vfio_pci_dev_properties[] = {
@@ -3473,7 +3498,8 @@ static const Property vfio_pci_dev_properties[] = {
 #ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
-    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
 #endif
 
@@ -3488,11 +3514,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
     dc->desc = "VFIO-based PCI device assignment";
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
-    pdc->exit = vfio_exitfn;
-    pdc->config_read = vfio_pci_read_config;
-    pdc->config_write = vfio_pci_write_config;
 
     object_class_property_set_description(klass, /* 1.3 */
                                           "host",
@@ -3617,16 +3639,11 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
-    .parent = TYPE_PCI_DEVICE,
+    .parent = TYPE_VFIO_PCI_BASE,
     .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
-    .interfaces = (const InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { }
-    },
 };
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
@@ -3673,6 +3690,7 @@ static void register_vfio_pci_dev_type(void)
     vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
     vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
 
+    type_register_static(&vfio_pci_base_dev_info);
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f835b1dbc2..32a65cc1ae 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -118,8 +118,13 @@ typedef struct VFIOMSIXInfo {
     bool noresize;
 } VFIOMSIXInfo;
 
-#define TYPE_VFIO_PCI "vfio-pci"
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
+/*
+ * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * between VFIO implementations that use a kernel driver
+ * with those that use user sockets.
+ */
+#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 
 struct VFIOPCIDevice {
     PCIDevice pdev;
@@ -187,6 +192,9 @@ struct VFIOPCIDevice {
     Notifier irqchip_change_notifier;
 };
 
+#define TYPE_VFIO_PCI "vfio-pci"
+/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
+
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
 static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
 {
-- 
2.43.0


