Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048B1CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UD-00079G-Ut; Tue, 23 Sep 2025 09:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tu-0006Zy-Sd; Tue, 23 Sep 2025 09:55:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tr-000439-Rd; Tue, 23 Sep 2025 09:54:57 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N6wA1n4104506; Tue, 23 Sep 2025 06:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AC9+Mqgvn9rz/R7aNilIc5XA6RBS+oyWFc7XNzWEU
 Rs=; b=On68WKH8bAanGk65N5+bk6Uz2cI+D7u1M3x+CbRqAoclI/Zhv4NCeqxOH
 x760oEb6qFNWBqy/njDi0kMbe1lFBL75Xh7SXsN4IFA3Rqpl3OZLqBmSeiIne8+I
 +nOe8OpkzV/oZrd2TN2cOuB1Rmagb7VNk7NunF4lI0v8LckKljZS5Us9xJAN+zYb
 d8RejzLjnXGm9IxIYhONDD2UvqJaI9s44VK5QTsXT5mGcon9eTID7XPGI6Kz0SrX
 V23k9ITX4WArdiIC7liHqQbDu0du8BzbY/g5faG5nuZw6Am4qM314Oiru6lNfnZ7
 qYFj9s8KEUnu2MNDLHibwlChuhnDg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020120.outbound.protection.outlook.com [52.101.201.120])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49bb1fa89q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKSQJZcUJ3cT4oy8LFAjyAPxC5ZiA1MCkNTOTZXcRclVT+zWSbn2JV09YCxNxVtWuS/Sekkhifsc/bXoE89FX+KmQQFzRzXxyWEsbAhrX7UkYWXqlv6zKnlPC+SHxN6gHt0VCAgULv4RReKdGxzpQHZrrjUEzpg/Es3LqJWF+FFIHV/zuifUXee9wBAnXW98L5/7FGqq+m7xOAcjLwnQ19cySXxPquD30nDRuZKDdeNNO9N83TimPNU3QUzmxv2NTr0oQXbGS0e41cUAgZja3ssf5H1GznYFcn0/58mq3bF9QY++UZNbt+FPNxIdcx7kAAQsbMJ23EkE2AWuyQnShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC9+Mqgvn9rz/R7aNilIc5XA6RBS+oyWFc7XNzWEURs=;
 b=K53X6Iak2sOuomFax87BpzvdgKNdv3RHfvbP2Uxf66N7PYpp0A3XfewvnC5xoi2e9sGF9lmJC2awh1ho1DA4OddQGEra/pF+g53m306maA1hR+gMMiNziwqOrsz6kDE3Mh7NCW+WL6Kpk7RaTLHMcOBY+0umM8jn3r7lTK6dQuq41/Qf41ipCOEZsYJZxI3C16g+q3symc4xdmRFIFKqWE16YsZDxaq18hFqHVJZVg7XyuaJ3N0+PN7N9RcT/mHPBNrECW61ljzsWHbdmVNKig4avoIwqgInD92FuLSfWtAYJfpJUQXo51dOpRlZUIG/ii3hLJXLXLxkQVISa4GPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC9+Mqgvn9rz/R7aNilIc5XA6RBS+oyWFc7XNzWEURs=;
 b=p1eMoRzZbDqIoUcOF45rmPZXVmevx3GQKPpjnD3nftBaFsKk4JKWnSq74YcGw2Qe6B0/zhoAPhDrHByi97G/cCZtI+jqH5Ui2kM2trBn3BSJKjHxyMFnvA1ZglXKS1vSmxa7id0eCsg72HEJBAg7Puq5X00H9oISZi790n2mdXyTgF3MOl6uhhxLuNdzM98Yw8Vsz/c2DvSmscgGodCypfFGQGsW9GpPgILLY56llJzI5Pb1/Xa6bLZ9fd37mmBRPefFFqoHCD8Ml8iBvG4wikrnvaW0C/WtTrTnUCtcKavCYmu9vE0zLDMYzftH8H+dRZCAbrm206LhhTGiilZvmg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:54:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:47 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 14/27] vfio/pci.c: rename vfio_pci_dev_class_init() to
 vfio_pci_class_init()
Date: Tue, 23 Sep 2025 14:53:20 +0100
Message-ID: <20250923135352.1157250-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:208:55::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaee707-8099-499b-b65e-08ddfaa8c231
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VW54RVm+eOwLjMCiq5+ZfvyZenbVaS3fDHZ0U71P5VZjCr88GcrH0kb3qNqX?=
 =?us-ascii?Q?VwRLX19z5FjCzWcMnYXhbqJwgK26REsI2T5/Qy0vdRifZgTpOVP9rs446Ufk?=
 =?us-ascii?Q?6o4IEGhsitrTGbBISqIP4kIUxj5EZNS+x7x5IsvAbm4nhmLSFUn7d/DOhJbF?=
 =?us-ascii?Q?AR2rzRb1YYrmlqz02WlDN6WyNrxJEN3l2Mk5Ap3U/ewqox3hxH7FNoisf7+Y?=
 =?us-ascii?Q?IOwH4bc6ZPCDFQkqsvsz7Qud2PWM5B5JOYRtBXplFjeTnw/rQR6OhcxwTdaC?=
 =?us-ascii?Q?Of0ULQ8v7cK+qivXD309SVte4ma/Wv1lxHG1Ww/nGYG/jihd4B43n4ZHa13g?=
 =?us-ascii?Q?F5ol5hzl7kBUhyIx1wHclSIn1adNVCWnBgvII+akl9ubys7XIblusrnnjNZl?=
 =?us-ascii?Q?RfOXxeRDN2Ki+pUJN0KGDY3U6aLCBCjZOQl93oLz+EITv1Ttwe/0uv0QUbu8?=
 =?us-ascii?Q?y5uJ+miBkZW6hOo6u8cFbQBdh9z0Op344gxTy08dX3uEbXlPH4TmC+rtOX21?=
 =?us-ascii?Q?d7Rf+aOT70s4hwW7Se2Kvy1GoMTBm0eXinTbhp6XNqUiRy3VSsM/xDaHRQcO?=
 =?us-ascii?Q?Zm6dBpzZhdfGgOzWYh1R59rIdn+kz5OQUkSyh8sVnCpJZTz7rBDIgL1PtOcK?=
 =?us-ascii?Q?L9waSEap2cr6BObd+nSEMdzubX0gslgZ9Zj/sWuUzTwXDiyLq8miqiDR1mYD?=
 =?us-ascii?Q?6mIGF14IhiqGHDW0XYZ7ltZvQ70rz1qcFRxEuPURChNe/AKhxBOaSHo2WTEs?=
 =?us-ascii?Q?C5p+QSkJSULz3YkDyImEgutuJ12zXZqR/V5TOut+qVKwoZ1IM0FE7ZYKYjyc?=
 =?us-ascii?Q?oNtRvP0i/v2YdYOMvDAagblwsv2qvCkun54EpRqevgYG72YV2C97fvZXIqwn?=
 =?us-ascii?Q?4puYuasE6Kt7XIVGTAh7G1u7d7AxXabvVpc54K/UK2B0xdCLoDtuu2MbaT4R?=
 =?us-ascii?Q?eGgDsxKEr7QOiJOVWd/hCk5sTD0xv65CtRI0VLQsvcyh3d49rcMkiF82ANpw?=
 =?us-ascii?Q?0nz9F1YcugnLdYO/pzPeW36ImRQBpMtCICAR1rdTwivNjP9SQGggbn7EIU30?=
 =?us-ascii?Q?J+gEQmvNYbI/COHRgnaguqBt315vyfPMnJl0NdSvxwlq4H7CNhu9We+JtJy4?=
 =?us-ascii?Q?p0VKWzJtyfatlK9k27OImaWRSmSSYy+EDtA/VBaCADyIrxyL9xfO480fTV5m?=
 =?us-ascii?Q?Y4fGSF+DAPlfYuEK7MJk7uS9WHzvz2xojTp8Tjq1FWqXtthAiFwulyepm1Kg?=
 =?us-ascii?Q?ZOYHuTxepE12gSoNu5Eu3CJtoG4LHtDlsLYcKilK/oc/z0HxGREwVCL7CTiA?=
 =?us-ascii?Q?Ov12uk1ZZl1cBdA4iSBFe4v8CaEJoO0+9tP/wros71S3iwRD9LbqKeeM+MRs?=
 =?us-ascii?Q?zBlnjuEgWoHc+v4V41V/qwpertuqoj0v1d2Hfuih8HuI/h2xAFR1npZeHmTR?=
 =?us-ascii?Q?3uuxRZUWPCUyOyswEiRr5OrINs8vnmHv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drgu8PwHiUkzXDGX6Rra79qX4gcFr7A1KUMBJJjXME/nHLAb0Qc8l3t/khN/?=
 =?us-ascii?Q?Wx3Qhn7N34iImH3LJ6nXHlCXeV4yVNIiiXUwWidoFMmAAMuDf98IVbxrtTAW?=
 =?us-ascii?Q?B3SVMx25CO4xlH73wmgkm8H6fCAoMMHGU/9e1i3DZK9z+CseZkpm+ZeYchEv?=
 =?us-ascii?Q?fBxOV/xLEjxGcseY0AmcizsuIZh3t/5B0EsDqpfa5NOF8CNbEt68jncbmjlr?=
 =?us-ascii?Q?sE7LY8aF/99MQsOhkXnewFmiM1+2dqN7IE5DlZGZOwpVdLQtQHa9pdqrM5WO?=
 =?us-ascii?Q?N4bvYdYorFn/TcIqjzPEmpEIRWdMExXQHJlIH/PymKEo7PP1XOd0vqMTWLq8?=
 =?us-ascii?Q?I3JOoq6BJE6d+YcFRKD++VYLs0OFRGi73n9OGaKAEVZYijB+zpzVkTSJAyXs?=
 =?us-ascii?Q?Vp2NmRqeMlWrDdUAP65VUhLrM/3S7bQpZgxAa8pFxcgqjYf5tOIGculZ4rCu?=
 =?us-ascii?Q?iVSRu5y/EoRTUzVHoGUT5BGmpmec1rWvK8KrxjOhFqfq8R/MuN7AyOLCK50L?=
 =?us-ascii?Q?Z4OBO4nYgJtq4PzVzSpr++NDwWMeRBRN+xWy81FZ2h+nBtGRNOBHs3LFhnUA?=
 =?us-ascii?Q?LNxOWVOO8Ht84ZSlpd5y1cfY+9Cbxemtszw7wglViZQgK/VmtBLbPcyfxNkp?=
 =?us-ascii?Q?XfVsiIhgcFVOvpkmKmIOxXWxHO1cKHpBP0I92u/5879IzLn2U1rrqTddmhKB?=
 =?us-ascii?Q?DmIcu78r0h2X2bb0EHh8gLIFUblBRORxYMO8AwB/5dg+LUPl12LRo38byr3l?=
 =?us-ascii?Q?qCsujeMRWlTJrDAF1iFnVxfuRX1nKwAyg5A3IcaxKSg0iNe2oRzCp241U+2x?=
 =?us-ascii?Q?UxKiSaOndMIJMGNTd+htcH7p6ilzyoovWauuFSqN373j5X9OPCpodrCNkcza?=
 =?us-ascii?Q?nl5jGVEDevlQHunCiZWd2SRLJuvXtQi4pxVYB2U1tdYGkdwpzJeZSZ2LnA8C?=
 =?us-ascii?Q?Z1Jzv+OXceam+Fztl+gbc39V08JcFMwRIR8UKQhzeijL87k9D2pOIHhmG5Ut?=
 =?us-ascii?Q?MK0IAk6aP+4iOGRbb/1wfDRxYkpmhgGg76cmLA9fbnjoNt+Beus88FTqm3ap?=
 =?us-ascii?Q?AlGmZ5SY+f+0e7oPbxhojOLcTDFdr6271mE27ZzWM+MtZSDb6isLx2Tm0KL6?=
 =?us-ascii?Q?73ofisPbXNjIQZ8Tkmw7Nhg4pzUq+00Ci86YwhXCIyPF1osGYnYMcRCM1Zcd?=
 =?us-ascii?Q?LjSC2sDKhWb3PFOdEK/bCgl3j4Pxp8MZ8s4Pdnybr6vzKQbFe4pBXICPs4Su?=
 =?us-ascii?Q?UMgR+yunPPW0bBDFVhTdd/TV0QsUNJ+GcJIEGmYK2rD1C0RCkjQ2hIzN5U6Z?=
 =?us-ascii?Q?oOCvZYXxaRkHjiJETouUv8pY/jIFhENUn3Xj0AzJAzfe4D+rlKLIknFsDTxy?=
 =?us-ascii?Q?CmotI9EdVKSoOLYdePxbIMZo/Bj8N0ScdO4uvNrG6z84yIiNT8ePuqUbHLE3?=
 =?us-ascii?Q?kFrZXSCDg8/qHKzi/WgRDfGlsCMWrEf0nEANJzBeJiwQp90PdnIhF6y3kvVc?=
 =?us-ascii?Q?V6HrNqEfocEKiBmDf18jhUNBHYiVosRauA23fWt/O6Hrcs3kY1n2G97GvvgN?=
 =?us-ascii?Q?gmov+ZOkctxAwda6jow4wU8D1SJhmXVce0EkvpAuXzKTO5xzsWynK5IHub13?=
 =?us-ascii?Q?TwmJZWOq/pEsYh8TXNRSVndSVRQBswW4UxNvaUKbB6afHZPEdByltBvDb813?=
 =?us-ascii?Q?R2KFHg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaee707-8099-499b-b65e-08ddfaa8c231
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:47.6800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcAfGvWt2U8M3ZRS4x8Ll1XDJXpnWN86NqM+3NeXVfHXYcFONs01833O+WGfFceWeTUpnRJbZptPkeN104GLR5qBZIEU28xuEzlhX4z0j/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Authority-Analysis: v=2.4 cv=C5PpyRP+ c=1 sm=1 tr=0 ts=68d2a6a9 cx=c_pps
 a=LMmQvGl5nJXnC0QjJfdYag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=udP_5BOVWkZL6ct6w7QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX7XryNajEZmvO
 u7M0xFP2Vmfm7Pd01W6WUAQ1wUSrLehWbegQeHDyU/6f1GCAxEjIT8qhSLhAqF3qeLg6s/P4kc+
 Be3nXoxWLay6HuZrChOju0ho9RG+U8HyhJvCOFN/7m003QALKxwhYMihDIsiARTqxxvibnb33Sg
 B2Fbxfkc2leV4DbMZH/YIr4evszNxiK4TxbQD9TVfsiNFpnWpYdVXluwv0Q+1ojciJrAk24IQAs
 YxilXxzXAtAV3K6lQCw9sueXBlGSuN3fHIl2VLBs18Q75VqK3g4OQKvCUTrjLitStOQcT6MfJHB
 YL+s2p/fho8tRRnsBn8Hsutp2ii+IGmVIzI+E227faTCPtoRfQm3onUN8B0BvM=
X-Proofpoint-GUID: pZQ5bh8BBz1Q29Qb1B_E8TmYPNgBB_i3
X-Proofpoint-ORIG-GUID: pZQ5bh8BBz1Q29Qb1B_E8TmYPNgBB_i3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This changes the function prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 020e611748..3c0e678723 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3767,7 +3767,7 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 }
 #endif
 
-static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
+static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
@@ -3919,7 +3919,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
     .parent = TYPE_VFIO_PCI_BASE,
-    .class_init = vfio_pci_dev_class_init,
+    .class_init = vfio_pci_class_init,
     .instance_init = vfio_pci_init,
     .instance_finalize = vfio_pci_finalize,
 };
-- 
2.43.0


