Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBCFC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOX1-0003R6-Cl; Tue, 20 May 2025 11:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWz-0003QJ-47
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWw-0002jR-SL
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:24 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6iN79005330;
 Tue, 20 May 2025 08:05:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lGV+Q473x/KSUpOMLlAkqadRsVA0gvMfbeDG2gYo0
 Ag=; b=2Do6t88jAwU3AFI3x8ierAQB4UedxvYayhdtJJwqnAL2Kv8lWyOpu185E
 u8M4EKi3Mp9OJ9BJOcPXlW+/Jt4thTI5poXFM3RpP1F6ejEaOJF2r7oEZfYCZQhk
 8lwMZMpO86kcLT/V6NgW80JnFiNMdNa6fzLbK56lBap8C3Y24m1MHqKvGOvmjVTg
 kWYQFHFPtDXcnaxGEtQJ8sPDfVj0tAuW0n3cNOymdNlFqe9RjBp/xpjnV75Ozvoc
 0QMCzdzJCdvFdjpM4ewxgQ7jbTQqIcz23UwOC0Xia/e+qnwoYDyvthoZ4BbOu2bw
 39hJ+zSWt4IWySxyyPeAZ0KNXzTFg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46qhuncujw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpnFVt0toegI1fEJLoD1ccd5r5L4fyg6MFB5R31Xccf9EDW2Fk1cEunFyBd46mPEwOtWng0l1DJgVeVF/YaslPrqtU5dCxNLLvSeOgFdYnRMKHyYNqrkyQmoJIlCUijMlU4Y3T2Mm7hYJibKHWqDDtIacAI/bqq4IHnN4EchIn/2/6RbK+gZ+cDbkBt8IPlwoeguzTnJei22mrndJ0zYBFMq+rslk17zuj+hBfLJWH+LPcGPiXkEqQGRlbZ3sI1izfTJz+DckGrzXmPGlPSvlCHa3bVUvYoEHo6RFSU/zU45MzigPoDEjDWqvxuCzNxj1TvHOt55jVU7zzOS/jZmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGV+Q473x/KSUpOMLlAkqadRsVA0gvMfbeDG2gYo0Ag=;
 b=g9Do0GWqVCL+pH3PkDmV1A1v4vJa+NI1qVfOlRPDdbYat0bD0E83IcNnI7vsSaESHW1YNkWCc74WcPATNsub6PjtcfVbHyamIlVhlvtmqO0AWiOJBW491b04/cL0J+onTl6lXIMoOhOSq5KkLCw0OHFb+j1q6Y7SBylWqiN6sTdidKxMl4manMOTGSE1pbGY1XaQfSN6yQafj8CIz4jK/POhbpBLxRanzJQTgUyYD8v+iaj29ccAgM5fqodnm832ukvdNCnYx+iFP7ANsNdYbaJ1rl/44rUOPX1OoZ+XS83/PTte44S0pWmk8LBCWJP2wiomivkmsHRgYvveIxfrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGV+Q473x/KSUpOMLlAkqadRsVA0gvMfbeDG2gYo0Ag=;
 b=eGzZRe8H7DZTkq6fNmbqZR6+VmpoLcmD6FTeRGc4zrMZtEO1tTvxlZjTLWMitRFUcjy15cIfMv5DvIR97BtA9rcjx/b9z9eLzvEevxGNPCwTnXS764HOgtgUCJL3eiekXTCEpIoeACRcn2+3fTFBPgwrdXQNZr1bRnOrjpDwHQZXRUcFjIFBKHXwCVsHQMcmT8dyl0G4QJTkgVQEriaOQyJ45Hdnm1MMGI4wbGEHXcOgstMoKXaCjgEi4pRkw5XUXwerec/lzCL0p+5sHEeGUDSsG2IBIpQu+3/GdJRXvRylH2UsQzpyAFQ5pjqJ6Cx+hAvDFwf2XUgBP54YspJo7Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:18 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:17 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 21/29] vfio-user: forward MSI-X PBA BAR accesses to server
Date: Tue, 20 May 2025 16:04:10 +0100
Message-ID: <20250520150419.2172078-22-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: b258a65a-96c0-4d02-f7cb-08dd97afbb79
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y24+vwstwyzZzYGmOgzm6DSsgyB62qv1jXXvyDzdaJpJCCoQnbErxfDRuNlr?=
 =?us-ascii?Q?BCzCI5kvGj6kDuAnzjTcNF1BBZBfSoYSvOomPz2LFr+X1J1uH9dNP7MC8a4F?=
 =?us-ascii?Q?/zCrjBZliZmny6TiRLj4wiSMQLOCgevf7XV1Y/bO3afHW9IEZVvglkVG+nYv?=
 =?us-ascii?Q?U5azEBYiwYBJJP45waoTDyF3BapQ3Ap2uJ19yF8WRuqb/f2Q6Gg/+sCsHGP3?=
 =?us-ascii?Q?u6DPzhPvaMlTCA94ZrH632EZhzQZ3uTIljOCltX7ZKp6ElbQwUrDi62rCGVP?=
 =?us-ascii?Q?SmHX8RgssjeENxchDRdc2HUTBrYE56vHDK7LmnqKeueDQN0UwMe7LSNguPDm?=
 =?us-ascii?Q?ikxAAEjXITev4KM6v40Q1iIHzCtMGDekm4Sql0fogTNYdoIN+DkiKSHZ5zf3?=
 =?us-ascii?Q?6/jQYSO5IhpDa+4QR+o08Z5UeTUE81X9qviPTCLrjQZLUYtMHsIaCylHdPRd?=
 =?us-ascii?Q?ARlsjkllRJ7w6n3R2dubNUvuPO9wjL2NP3QIpTqP4J6/LIdLi+S4l00NAQhp?=
 =?us-ascii?Q?tNaQJjxPYtX6hOF44RS0AD+eZO4esh7d/nNHQTm22fVY9H1fNoXTJQI7YwAq?=
 =?us-ascii?Q?gh57hMlDaJPFOmr5dcLuKavERsesRUKybNr9o8L6tloPar1sOGl/+wnTbFCi?=
 =?us-ascii?Q?blWDFSnsVqdU9xh9da9z9gNhILb6FMfPIyOHayInoseyTw2PPRn44mp6V+MW?=
 =?us-ascii?Q?9ZayaKrHYMs+NasF2Dad2bkUa4zll8dcypTLJ3wq5U+C8sPXhQ5gfzIWMKmA?=
 =?us-ascii?Q?dwlasnmY1H9Y5WFIE9k8ApAjCXnMHSKa6PznG4NqhwoEuX5buOzwrsY8EWkO?=
 =?us-ascii?Q?oKoD6J17XPDj6MclB9vtWnrIdg4T3/vpEeD2KFYYZVvJudfbk+sG3VoQwNJK?=
 =?us-ascii?Q?0FVs1ynKszNOmHv5xcfOTsXXp6mfsi48XIS8dJILQaW9IU7RY2jUXkMYUss0?=
 =?us-ascii?Q?dem+fa2QJGZlLKm1sy3yeX/ilMoKZl39opUZGsQprva1ixVfQKEu6loXefMK?=
 =?us-ascii?Q?8d4fAaHWyFue10GPUvKrCsKiGHctasbhBYBhH4QUJsbCgDxk8JjQ6uTE0/XQ?=
 =?us-ascii?Q?ZoUsjY2YdTRu2ufz21DEY2Q0UUZPtXUZ2g77atEpQcivOc4stCmOgxagKy8O?=
 =?us-ascii?Q?8dD2h1v9/zTV2UNFSVwOIb6n8BaBF93ox7mxd4Ozwm8LmVdCS4llISWMcpgo?=
 =?us-ascii?Q?QnlAykUwI7YcWjKXT/tSnjsXR/DWQlOSL+NXBQqR9JQ2XukfVWrVpYz+OpG7?=
 =?us-ascii?Q?SgaERKbBEhtRwXMFEfM4xabs11ewsKrHJOhy22a1EAsMxYM62MmUCRplRUE8?=
 =?us-ascii?Q?9JsDI7LfPqk/Vjk7tnB23w49j5ijSLkzNhleC/x/eDWasUnfvWzKOywrbNO6?=
 =?us-ascii?Q?mQy4L7X3QKpy/RXpuN5bK3w1dVKWYUvK2mySeA0am/Oox+VcQ225K/Bg9VDU?=
 =?us-ascii?Q?qfp/Y4sCTBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tidUPTrleo0pB2bfeD8s82uvXsiOxChSi9XVztbLA/tofMSNNznAZfDzYXXv?=
 =?us-ascii?Q?iAmyzthZhnLPlhyVhaRYlW6bPYFDrz4R2+ee9Hw3skY1fCMaczqUmiAChiTF?=
 =?us-ascii?Q?G6Ta7RiITdKqYCcnhzfFGPCmxJTkVxYPQ8bjaNS/4I4RyrpONu6FDlAGg/jv?=
 =?us-ascii?Q?QjPCMtew5yUItkoVz8iaddo2hVNPbgm6kcJpCZLhAXGlTK55rYzRRU/sY5GP?=
 =?us-ascii?Q?WaIrEIhDvuEucKGbUopBp43ENGiBYeVM+ck5TNYq698+k4NqnUQtZEy/9XJ5?=
 =?us-ascii?Q?2u3ECnmZrnza8XVqa4+WGR/L/jUC3IcgxJlDb6NIUxEgMDpB/my38/Bm5kff?=
 =?us-ascii?Q?Vm8kSJLk4KpkWSkfU0+7l7+oGQ9H11CSi9HtTeJnOQAb1VyZb0mKRhfhRQBt?=
 =?us-ascii?Q?OU3xKQhS2sZpUi00RATtt6srpNuC0rW4Fgs+J89Ut5uZxbSUQ6a6LEw1WfRx?=
 =?us-ascii?Q?BKDvkXC55lciRTIIa14xVCbrBL8Z5yzSKxR0FJur4PWNZG8W9G16EJBvd6Tq?=
 =?us-ascii?Q?0pWs6W2096U9i6UO+2goZojsLnpy1B/lSmy5hJn1y8t0gUsdFsWDG3vWrGkL?=
 =?us-ascii?Q?Gl0iRz6hh9kw6UQJEH2X7/WnyaB2Q/1fSMdEabeACTU9vxjZ5aia2mgSsFB0?=
 =?us-ascii?Q?e+sQZGxHijXfZSfcgxM4CEuInnAfECwtXSDovLl4f+j2yTDIID0EN3WryqxM?=
 =?us-ascii?Q?IwjQforemwe9clDmwecQ6JQdxtWyOWbcHcwJ6cfZaYa4Vc5/OvfuH7gNrqaZ?=
 =?us-ascii?Q?/TlAD5mQFjPAFv9qOw75cGZijoe4NBHF+TgqrpeWeDj6hLx1BzoyoB4n/tiQ?=
 =?us-ascii?Q?1fjxXZMgLDmuvmZwE5AvW6YEje+a2pet49/Dl1Ik20/86RL6vQmxUMY9u6kU?=
 =?us-ascii?Q?aHH8PCkEANVtyrcvlGHk1dHp3K4KVv46SErEsox8I495yYSwYRQr8PBFRCp1?=
 =?us-ascii?Q?UnJyo67viQZGYT817l7E8aGsacvUqHa43YmMtCZMHIPUrFS4fs4KUh5OgdJc?=
 =?us-ascii?Q?otnyDZIeTAo2oOzXYO2JVknYLM0jw5yIM40ATnyCQRKIgqABFL7Xe7uW+gnQ?=
 =?us-ascii?Q?+gtO0GiIiE44ZsptdKZDyAOVYShob5vezsvqo+byZTvdis6j3rV17e9FqOvs?=
 =?us-ascii?Q?/FoYW4u894HWI0zZhaUTpcp/ejAQBdlZ2gXlMgrKIEZLCnIO/bEzYPDGO1Zx?=
 =?us-ascii?Q?QzCOJClRjxFjW37mknX6woWko6LtL8cMi4X9GsVMoTdi3/F5g3GSC2tE9/eR?=
 =?us-ascii?Q?zTy48Ko1XbWPQI8YKYVlF06M8l8e22xgjC9UwgKMvS+1Xa3QUSiyfNT6n3vc?=
 =?us-ascii?Q?xH6QR+Q/mPlAeOTAGsz933uE7J9b1ZKvtUQesijXyV45fdW+tbMiMCCLJdXl?=
 =?us-ascii?Q?4wpdyho78TNrJ8FDwnsKSGrE/JE+3Ma6jilNoii48hpyc51370RXPOBt/G4d?=
 =?us-ascii?Q?OV1zHqrfTjldLP5pOfQCXa6rn/wTbFlJT3obqGBtrlzZs+eaKWJCHRQdwKAf?=
 =?us-ascii?Q?4O5Qsv3tb7iR21TGragk3DYN1OE0IXboTkslFUIKJlwZTx6dnwflREJCS6MI?=
 =?us-ascii?Q?3qz6SMV2jL/oFqxUhg7cvDPv19RbK+7SznC9INzu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b258a65a-96c0-4d02-f7cb-08dd97afbb79
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:17.8928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzOizcQd8r+5H4OY+EsJMGvgjhH5Qgu9GUQhH8woxxbAvF2U/XRJlTEHrk/IgTrovntgZguIYisqpcl3FufoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-ORIG-GUID: 0_5vI-ThSWwzb07u8wKPFdIZl4m6WJ-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX0SXQTcMR8rcK
 CPkM82RzrLKbG7CTloklVYBySbQbQRfbxVMfFOLhFnVZaqJ/fxHt0wA0s6lg10ReERtsaAwA2bK
 OpXb99H37aGxGzc0js3RGQQq5Nx226amQmvpehe1ARQyATtSaQPnu4FLJmTz5GHmaM+tNcoBBKo
 NNVGzxTT67Y93jsMrca+B6HfXNwwqWUKFvrsdGbfT9p/8HV9le0YNPG6KGueVirYmsvpGJDH/Re
 9CCAfr9o0899+Fv/2eJuAmF+UYaIRsZ4vBrHeRODKP4tbW4+dzFdrVqBAyCnvFVU5voZlSVYaOf
 PJDdk/Q8yZjAivBySYcTemJOq5prXvaWd0ioGmzUArYDwC8xY9V2iMbQr0gJOWYd69IL3A8KUel
 XqAXMlkQbgT2r1jNp4sR9uOqZMyGKOUs9mZetrWdWWNm8m21ruBzIfCtJJ+sj5HIQnGUAaYk
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=682c9a30 cx=c_pps
 a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=P96-NN1LHiVJMZ2xip4A:9
X-Proofpoint-GUID: 0_5vI-ThSWwzb07u8wKPFdIZl4m6WJ-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

For vfio-user, the server holds the pending IRQ state; set up an I/O
region for the MSI-X PBA so we can ask the server for this state on a
PBA read.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h      |  1 +
 hw/vfio-user/pci.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c2d72b84..434d73a1ab 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,6 +116,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 481c6cdef7..5904e7ebc5 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -26,6 +26,62 @@ struct VFIOUserPCIDevice {
     bool send_queued;   /* all sends are queued */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these accesses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -133,6 +189,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
+
     if (!vfio_pci_interrupt_setup(vdev, errp)) {
         goto out_teardown;
     }
@@ -180,6 +240,10 @@ static void vfio_user_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
-- 
2.43.0


