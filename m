Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6804EE7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdX-0006UR-0K; Wed, 08 Jan 2025 06:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd7-0006PY-Fx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd1-0002DL-LL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:43 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885pFH021537;
 Wed, 8 Jan 2025 03:53:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kN0ixm/yOIeHZmtYT4GwTKVGIhlQbWPPkE+BqxBpp
 z4=; b=zS3VV02oz7Af6fy17z5LfkpZVeiAHvhero9Wj13NWUopeO+BtKTu3bO8V
 HfdYpk6f8ho+9QhkWWRE2XBi+V/8WcxE4VoRpAgbznpWTaDHjrq942U1MaBcf1XT
 oCqKxR8FUXh5hRuKyjaAluei/QVdeC2dESMdPcT/sX+kk8wiODSp0cV1t3B9aiy1
 /TOfd5fEEFpMb59HJ4zSqhG8bI4CcyTzgYaILZLbBoY1joJFzahzj1lhmLHLUsox
 8tB8ywEo2LSY7J5WduSe2tORhqNlM45i1ju20wl2x9Lw1NqsM6RjFsyNVNo2jM6a
 CT7xwSIZzGlaC5radoOhnjhBmW93w==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y5d3rs7x-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3iYr5tec7me94TAndoM9Cf96zHO0ftal7ANMKlqzzC16Pgar+1KkJdQ7yyflu5AavRyCbgUssSQYwYuQdSqFzj3mQG2LvHFBfTVe1W3K/hQ9xed05kwJCMBH02Rm9ovrpEkL5u/8LF9rCBvtjzkdrotahmlgHruOQaYCrt2RSOR3LUoC2A9kAe0qdNwTwkw/IME9WCGlgo0alZw88qqEeH8eaCa2vTMI8nAkkshFn1iTBbcc5jsvEYDQ9WCMFcQe/QcyIpFv8fn8R/Gi4X1Wy4ye0eUmiF1DEfn+R73zjJaD+v/cOKxNqOjiBo7AkVFxM/gKbAfVmEamktZASvFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN0ixm/yOIeHZmtYT4GwTKVGIhlQbWPPkE+BqxBppz4=;
 b=lAmLq1mi7z1uv1mD2cDAIU/a0tejB2JzkaoXJKYzlg9sX7syAXbHVsL5enf+NWgpgTblxip3jXBJt4whhOCgBflV9JrlTZtvzTjaGEczuYgE9vbQdlBBZyEmZ158M9MxX7JgG0CtyLina2wPmpML6WQ/RbVWDKhYz0C/d2F8uUvMPTBxyr+N9FlqNwrW4tXvf50A0xgcitBN5aT3GKYXT36Sz5g4WOrORbvQqbyqGvFJIDARxB2NvE747sTLqm2x7Fh/0vpjpmuIh4pc+4EemQ526rGVoDR+8LAP8bKaioSceVtQ2F0gntpK81CoVUTqenfNClTEHJaS2KknY5ihKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN0ixm/yOIeHZmtYT4GwTKVGIhlQbWPPkE+BqxBppz4=;
 b=f7iB8GqZlPgq65SPhs6knhbryIzLBDF32WSiFnIDo6T6COlQ+cpRGt88Wp0oB3O7wSbJxRTW1wGK4O3djNmYhnpaQ2NuYCMo1cn9ziWfooQybN4uQaRv/EdncgCKxyJxwNsNXqkPQtaJ+tcLDJ6IYDM9LhltT46f2O3gTbfJCdqGlUwmCjzkW0db6MWxeDGEOBLMGRRV2xV0Q9qolzy58Io2YbI9hsZqx6KAkGuMRKNq0kvDHSDbF5Xn1+LcAduQZI3yVU4u9js/7W2KzMRTOxWqe199ZlZtUhrMmgoS1mKawsRakyxUEGeE/cjiUK+vC2wmFu+RFfU3+BYGw94hQA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:37 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:37 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 06/26] vfio: add region cache
Date: Wed,  8 Jan 2025 11:50:12 +0000
Message-Id: <20250108115032.1677686-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bad6733-e019-454d-d533-08dd2fdb161a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mYpb3b1VU1++G6HMDUKy3NAEclLHdPoYvoGJhDPkcRlVz+tge2wEjDIaG9cx?=
 =?us-ascii?Q?rJu9qsp0N+d9021PS1X0LIWrMg069OnZb6Q7ZIEr+B5LPUGJICZ2WYtBK6/d?=
 =?us-ascii?Q?oAOx5Dpdpd3MwowzgrKBysd9EQ+GcShNVhcOWKmAESzpZOeS2qj/XauplcI2?=
 =?us-ascii?Q?5hE8Wwz8G4AJme4Y1z4SJVFVJ/y9oBJVgPtT2dC11r8U6Yj4tLdFXlSsZBVJ?=
 =?us-ascii?Q?Zo4KGA5fwxAgTMZZiWk+A2T0RVCrZa3F2/wP2hKfRq2iiCBdolUWDrlTbFpe?=
 =?us-ascii?Q?yVKIMcFSHmtfOfuIT2nX5pLtucZXBIhPTfNkw0PIf15UkBdfJKmVEn1jVwc0?=
 =?us-ascii?Q?LrHxa6YUA8vImfJkm8h5E+QAiBF5ZIzv7TCvlj4LfsvlU9rpO5M1i9+zk7+D?=
 =?us-ascii?Q?8yj1GsbDnV5+keBVgSyg53yleLZyF7Qrwf6E6KXQAQRSe5S4+vnLHy2m1Zo5?=
 =?us-ascii?Q?DVovw5KVy3rcHO+4So9Sbm+U2qokmp16xqGD0HtAid71CuZvnWQjlmQN3/qi?=
 =?us-ascii?Q?GD2ewOgGxIBwiDZJKwm5zaHSd16DQ5E6ZgMNLor8LVaLXjh+4wJJaSEVHXt8?=
 =?us-ascii?Q?aYsNDOVCTzvbFdcSFaN2xu9ReoHHXT8KI0XwxWXLTJAv7zlKjjmxsIICPuYF?=
 =?us-ascii?Q?s2ra5dLvDp/Tz7l6SkHaiqWF+a01x6hOfnypbPUfBuZ9KE47UT7EuWS+XkCR?=
 =?us-ascii?Q?kNDGh0hVEJ0nQlpZv/yTUh5AtUjaGT0zjxYGWl+zLLmvPiJpZVeT1laIQh4B?=
 =?us-ascii?Q?7qpl3OoYcBPYCutxBw4HOF6y3IxOxjdM1k5atHt2q5y8e8WDatOmCrtj2Usx?=
 =?us-ascii?Q?0/yTG8tza5xoxsMaHm3C2M/F62ejCPAQpzMU0INJlbgjB60YCijgMzTpjBjj?=
 =?us-ascii?Q?iI+4r1VKAfLpfy1JfBwrh4TAxF1ojqq7XLsCBScVPup7UU4VjT9Wlpq9s+HM?=
 =?us-ascii?Q?Roa72BfGvSxVEVRYwzRC2EdTAurK0NbrJlejo2TZmKWTqHmOIXckF5PNH3y4?=
 =?us-ascii?Q?aSIwEmBPg43deb7Fj0RI3PRQFNmuFMiF93rcETVuGcOhqu7ZenLChCfvel1R?=
 =?us-ascii?Q?wj1HmDQPmCb38C7NWG6+ajRbFYYwdRPZtCYjAZ0LEqP5m+k7tiqEUal9Ejvu?=
 =?us-ascii?Q?WlxdKQcpduscSb3scHdLTls2iA5FaNwUhzOVRMuNdGcDuQfpyXAtcNQ8VZlz?=
 =?us-ascii?Q?IXhJ2My4dNpR6FeNR3Z7s6+nfbQ/6kqKoIm8p5tAOs8n5M498POieLAHhvff?=
 =?us-ascii?Q?L6sNNUHtAk+maCcM8Tk8mEnHKMklYrKTD9ZtuSxU7lW5L+cEW/d4Xpf4UyIT?=
 =?us-ascii?Q?dFJonvesmBocVxesP2JdVj2Wn073ebXOY8gRM2fZs8ymU9ly94daFu9z/qND?=
 =?us-ascii?Q?M2wPhkK4UEDI4E8vrgDE2UVa1meK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVsWUVevDQaF0QE7aU9ECdwOeT9dG4yvjigbs/vjZt4x3X/1l5x89YdOahuk?=
 =?us-ascii?Q?uPVR68Ry1OgNI2rVI+c0au2T1fGWcJsuE8ub9JIcbS3urs+lcX7JHyi0YWPi?=
 =?us-ascii?Q?S2dSOC+I714+g327SoLnjsEHwp29SW1bJD/H8Y6G/oPN0Bw8WbVxHYsVmh5E?=
 =?us-ascii?Q?il9blcx07hnSUAAjEGUuHVrphsRERtVY4570MNrO8VY8KCEchtimbT0sZ9jU?=
 =?us-ascii?Q?KuxFvYHNTGC5nxdnuRiMkKBQ8V45gctn6g7aUP7MVPQNKqybJaAdc8bInt0l?=
 =?us-ascii?Q?pVeIzpu559iHDZ7MMd2zyswJmkSUxQb21KeSjZAB7WVj7zXKtbrHnifXrBHQ?=
 =?us-ascii?Q?o9WfgcZZYCe9D45eYQlFzBZAyxXUBGl+5agy4XmYoUYtkIotrV2ThST79h7L?=
 =?us-ascii?Q?N87O/XGhOK9XFkDIu/6B9Yf48wPMHjPbkaFs3ETg7+NSJIVg87DOHtVTTUYm?=
 =?us-ascii?Q?S8qGWbDQNSkHiBJ/MjQTKRVMw6vvHyIBUXfynuFeNMH31x7jYwVGNO/8Yh0m?=
 =?us-ascii?Q?IRK2xWdm/5r5qcKsSgq8YYLc/xgdt0ph3wvOlEOBxzJPTuTxleAbTgFMovFm?=
 =?us-ascii?Q?nW3CXlRfsk6ac01RbJfwD4nvxwsdKqQyDMS6vjLTPNv/bffWdLg8EVDqcLhN?=
 =?us-ascii?Q?WqnFxNS9sBO83SlR9yGAvQ+G/MTcpebLenQcHdpjtILh/NNkNhiT5Sv9CxFw?=
 =?us-ascii?Q?+CEAt2l2P+05dLZ0zyXQAUWvEMoaIPBSzrpXmtURMdkjA2CQO6aSyOjZbSLl?=
 =?us-ascii?Q?+YnYec9PL7AIwv4UBYUIkQzpDZWqTl6IN+D5T6dsg9moodggLprBrfTunmjg?=
 =?us-ascii?Q?dfMrTprEyoOlI8NEXSzPBGDjmi4JQSDQTRcMqbjIq8cScNtpYjK3qsfR7m/f?=
 =?us-ascii?Q?Eb+qCwvcpLHC0xba8zXqLrqzBicdyJCUJ5BYswHygATdsJADxS41nzktvOnO?=
 =?us-ascii?Q?d51aa2Y/CuYWY9E0B3fImsZPcxVtqZLOoGmT26H7WyB382DedrO1jAJR66BC?=
 =?us-ascii?Q?6WVFRwftWvB6KZF5RgsT45nzxylzkOPcl9PxgLot/DZoQ5ngabTSfj4yaLn5?=
 =?us-ascii?Q?RndkRTmKcPHPnhyGfxDgMpRQmp1cNs79xewoBIsF2OvOFOdpaZs6YUiE9Tx8?=
 =?us-ascii?Q?rHrA50hKtAbYNu06g28bg8cvlymJKN5YFYDB8/l3FA8FIVDHv0r5QiNdz0MP?=
 =?us-ascii?Q?HkEkPmRJbkuBjNJQr9RYKD4rqJREOITI52D2JUl0nWP+V7qynqxD6CRYRvVf?=
 =?us-ascii?Q?dFhv5thO8nt24GaiptMh4qFC8g008GZK62L/sT1jIyx0iL9/nL76wvXSXiaB?=
 =?us-ascii?Q?5kfA3FgbPJaOczK8CTKCf3CT8qgni6CBTQfQVGMXzb2PK4q9g/jgkTtzc4Br?=
 =?us-ascii?Q?+tAzNQPZT5w2IMcLjR/Q7VrsQ3isw0ODJenZ8qEgGR/AOIxDxu/AD/7MmM9x?=
 =?us-ascii?Q?c8v1oaM9oDcWZdoQoxVDMOMOnJQ8gR/rwK3blFtSQuEcPg7cSxviRwy1aRl/?=
 =?us-ascii?Q?3NaEG/KMOU+lq38wf3v3vYIPcACfTBgz86HNzz8/i430/wTpfA7OsLZIOtXX?=
 =?us-ascii?Q?jqDMxhz4HHEMZOoCGds9zWzJR/E+fJllpp2EuJiJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bad6733-e019-454d-d533-08dd2fdb161a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:37.2790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLYvTcXJ3CcxnyBa5fxKh9zHTwbC7HCbWnHOU7AReFyvPMGfgKIGXttXQQ/nbNl9z7SIdFqWOX8AKNxbqD4Jgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-ORIG-GUID: yxi4PcqsKG0K1wbJaPezkV6qgFzvCIpx
X-Proofpoint-GUID: yxi4PcqsKG0K1wbJaPezkV6qgFzvCIpx
X-Authority-Analysis: v=2.4 cv=YLtlyQGx c=1 sm=1 tr=0 ts=677e6742 cx=c_pps
 a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=FNYyX2e1CiGw8cD_ergA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jagannathan Raman <jag.raman@oracle.com>

cache VFIO_DEVICE_GET_REGION_INFO results to reduce
memory alloc/free cycles and as prep work for vfio-user

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ccw.c                 |  5 -----
 hw/vfio/common.c              | 12 ++++++++++++
 hw/vfio/container.c           | 10 ++++++++++
 hw/vfio/helpers.c             | 21 ++++++++++++++++-----
 hw/vfio/igd.c                 |  8 ++++----
 hw/vfio/pci.c                 |  8 ++++----
 include/hw/vfio/vfio-common.h |  1 +
 7 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 67bc137f9b..22378d50bc 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -510,7 +510,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
-    g_free(info);
 
     /* check for the optional async command region */
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -523,7 +522,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->async_cmd_region_offset = info->offset;
         vcdev->async_cmd_region = g_malloc0(info->size);
-        g_free(info);
     }
 
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -536,7 +534,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->schib_region_offset = info->offset;
         vcdev->schib_region = g_malloc(info->size);
-        g_free(info);
     }
 
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -550,7 +547,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->crw_region_offset = info->offset;
         vcdev->crw_region = g_malloc(info->size);
-        g_free(info);
     }
 
     return true;
@@ -560,7 +556,6 @@ out_err:
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
-    g_free(info);
     return false;
 }
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a8243c0c58..c0a6263678 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1551,6 +1551,16 @@ retry:
     return info;
 }
 
+static void vfio_get_all_regions(VFIODevice *vbasedev)
+{
+    struct vfio_region_info *info;
+    int i;
+
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        vfio_get_region_info(vbasedev, i, &info);
+    }
+}
+
 void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          VFIOGroup *group, struct vfio_device_info *info)
 {
@@ -1568,6 +1578,8 @@ void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     }
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
+    vfio_get_all_regions(vbasedev);
 }
 
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index b1a58b0579..e0fd5a153b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -888,6 +888,16 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
 
 static void vfio_put_base_device(VFIODevice *vbasedev)
 {
+    if (vbasedev->regions != NULL) {
+        int i;
+
+        for (i = 0; i < vbasedev->num_regions; i++) {
+            g_free(vbasedev->regions[i]);
+        }
+        g_free(vbasedev->regions);
+        vbasedev->regions = NULL;
+    }
+
     if (!vbasedev->group) {
         return;
     }
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 913796f437..a8951176b8 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -344,7 +344,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, index, &info);
@@ -561,6 +561,17 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 {
     size_t argsz = sizeof(struct vfio_region_info);
 
+    /* create region cache */
+    if (vbasedev->regions == NULL) {
+        vbasedev->regions = g_new0(struct vfio_region_info *,
+                                   vbasedev->num_regions);
+    }
+    /* check cache */
+    if (vbasedev->regions[index] != NULL) {
+        *info = vbasedev->regions[index];
+        return 0;
+    }
+
     *info = g_malloc0(argsz);
 
     (*info)->index = index;
@@ -580,6 +591,9 @@ retry:
         goto retry;
     }
 
+    /* fill cache */
+    vbasedev->regions[index] = *info;
+
     return 0;
 }
 
@@ -598,7 +612,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
         hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
         if (!hdr) {
-            g_free(*info);
             continue;
         }
 
@@ -610,8 +623,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
         if (cap_type->type == type && cap_type->subtype == subtype) {
             return 0;
         }
-
-        g_free(*info);
     }
 
     *info = NULL;
@@ -620,7 +631,7 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_get_region_info(vbasedev, region, &info)) {
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0740a5dd8c..d2f9300e9a 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -553,10 +553,10 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    g_autofree struct vfio_region_info *rom = NULL;
-    g_autofree struct vfio_region_info *opregion = NULL;
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
+    struct vfio_region_info *rom = NULL;
+    struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *host = NULL;
+    struct vfio_region_info *lpc = NULL;
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 17080b9dc0..8e6f20b3ad 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -879,7 +879,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
@@ -2666,7 +2666,7 @@ static VFIODeviceOps vfio_pci_ops = {
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
@@ -2731,7 +2731,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
     int i, ret = -1;
 
@@ -3135,7 +3135,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     if (!vdev->igd_opregion &&
         vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        g_autofree struct vfio_region_info *opregion = NULL;
+        struct vfio_region_info *opregion = NULL;
 
         if (vdev->pdev.qdev.hotplugged) {
             error_setg(errp,
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index da2c5947c4..59348b81aa 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -151,6 +151,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
+    struct vfio_region_info **regions;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.34.1


