Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523C9E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdb-0006Ub-Ec; Wed, 08 Jan 2025 06:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd7-0006PW-9L
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUd1-0002Cn-0T
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:53:42 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50885pFC021537;
 Wed, 8 Jan 2025 03:53:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sTEjbMLlPVEgYrFpP6gnfLqwrQNlSwLWipaDa0jU3
 fE=; b=oVUZ/6TOLFOYi4PJtaJ3RdYGd2G60QfYppgZNd43D/Dh7MKkxzgVN+cC+
 dvFOmhZry0MbHaeur4FhYY4LuhGwY3BVsh4TtQUluwKTKnZv1v8m180k7guFkfeV
 Q4duoT21mbTGmfkGmooavta2iP84tFD0vAEU+N/FQ64NOXMEkO2QHD2aQh19yyp3
 Gd2x+j/EXpzYHYkmIIyGOTk4G0rcGADge584xRmii1w34A0BUU+r4BJtmGNmRO6y
 ApGsmFYxI+y1S6vYq9qQT4VGEbu2YTSzXqRH/PieE9zVxMwRhFsCAgfW1CABy48e
 NHgNFQSz2HasMNme4I+BAnuTjih0g==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 43y5d3rs7x-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:53:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN+q2f8b7wujg4nmJSe9s2EroHO4K6b7pLS0k/ak5ZNH7k+CBg817YBw8QYgZ2JJi5ZlrZf5uEpfzmzVFRd8x3pt6NVMEBagHznAP3jTbbtITo39Qyo84bYS33RWv5bkLp+JxtSezghLD7rmIokuutXNBZsux/j15RMNyrWYOB6VCvPNnMGZ3s4eFX6UbOivxMp0wkR39fGkNIYXetKCHVWbwT/LWrYkvZrF8CzmMR+BhyGwT6g7PWUE5TRDmhoYmG6RO0aV6kM3gMsAJdLFA4cUOQH2UGbq0ECQL2eGKxkjIWH9ARzbNnH3FxhQZ/NclrwOX7aBdWzYn5cKiahb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTEjbMLlPVEgYrFpP6gnfLqwrQNlSwLWipaDa0jU3fE=;
 b=j2zQhupiMQgiJz4nXdC5GSFn6nXoeH0byd28x69zTOU4a9Ai1+O7iVHohMjlLFBazBbtDAAGwXhlIfyIOAgIebInURikkJv0b/fmECh/da1vCxHogx4fw5ct8C30yR4n6LbmMHMXYEPkmGpw9O9xx6RtBnhyH/NN6jAkqlXCDvcDsoxOWcyzkQ+t9wE8bYnWbD2e83VDqtQXREhBwSQBGudvpQgPVZv+CY//D07JBrk/R+k5u1HZnce1y9rB/n7/J0e7+psAU88YONObfKUzVKYN+XaE2vUnZPao/OOTVdpIxDeyRjaA/eiZY6shYpkLjLrUQD17owLXA1TO/5WtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTEjbMLlPVEgYrFpP6gnfLqwrQNlSwLWipaDa0jU3fE=;
 b=if0QatfJ8YQFXRw4iuRpzBiheamMavcSyR69RWw5LcKxPCyAcQoOMdazENkvU2ER0CbxGYOvl3gMhrPpiHjTwwf07pQJcdup5Rx5o019BDdP69snEYysUZx7Fd+0I4oBzIQAaqWYUE1ISb4ahKE4nRJk9C0WlcPmP0Zy7uSv6ws7MMruJytFdfRzbyswkVnl+Kx3rO+13WrxRrd20Bskf9OlqgU41bSW4yTIhKr7W/8iWt30/ADz9/eADw8E6mLMKcI1JRtGaaHeCbHWYs+RhixO+CT65eRk8MTcxM+HWXVScq8lU8scg3mvE6CpdN/5c3XH8YepoTwl/P9ftIf+QQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7502.namprd02.prod.outlook.com (2603:10b6:a03:2a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 11:53:31 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:31 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 01/26] vfio/container: pass MemoryRegion to DMA operations
Date: Wed,  8 Jan 2025 11:50:07 +0000
Message-Id: <20250108115032.1677686-2-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6375515-69b2-4fcd-ea0b-08dd2fdb1256
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/qBN692iq2ZieFzAZACMQhgrj38/lFv9elNUEETFf1fdUjoIwZM04/0d23TJ?=
 =?us-ascii?Q?n4sbFfRZQIozdjTJeS5Gcee/Q8D2YUJLTnoaKDu76Bn/XopG0FDZGnfv87/M?=
 =?us-ascii?Q?IMj40YufwUS2pua1X1FUqTg7oMdpnNAEF/rYRB0QgjQ74yKkCfGAnKQ1+I/J?=
 =?us-ascii?Q?cT9fjdTygQ0bxYLjlFw0Yik48XBVqVYUz7FpeU+NFN9nPq9M3hbU0Y9T+8yz?=
 =?us-ascii?Q?AL0EXSSf5YtYWqL6xF4kHMkxTDPLt4TOM33WezRFDfS95iX7cuOartvjR6Qs?=
 =?us-ascii?Q?opQMxdSCvxnnfJ8I06fU/c+ZWDr6HNPv5ZmadKT+uTBf92brxiogsRGIaJJW?=
 =?us-ascii?Q?8ktwfXmouipL0x/1enmIgCpRok9Hd/d+Z4a+VhZ+0VIx/OX8pDUdEUzDVoiw?=
 =?us-ascii?Q?tbE0pvauIEF3oMNHuKChBGa00zBmZPBmBjpjyLMwA0E2EWrYEVcbup3ChUuw?=
 =?us-ascii?Q?hAc2tdkdR+fY9U490sKEtYcrnRwbQATsahMEFvhxmnPFsmBZ3PonQfIt2mGd?=
 =?us-ascii?Q?OFlD6Kl+0HYokN7YIRb31NuZSaK3NxaYadTYHAPZYM5Zeu20ogvt2wnsa2Uu?=
 =?us-ascii?Q?WkFk8HVq7dYPOxXqBLK8+KypBBkouqmJnMP1fophiG++jqc2RmUYkz7N4wgY?=
 =?us-ascii?Q?m7SlQTZ5H5v1WKhrWl406F/R8luBFO++fHDRkHxEd6x3UIsOipG7PJ78+Zb5?=
 =?us-ascii?Q?rML6o18yz6361oco6EpS4l7sLErk9LGZVZ1PBKeMYuWjwzEjfLCm9EvRN6d6?=
 =?us-ascii?Q?fkW2vxRrLyOyGtLEl1AgADNydJIb84EYAW8uR7IWBW7coQCjZXs5xeDXfdRb?=
 =?us-ascii?Q?XBXh/yU+b0ewPLbNprwsxxdykMI8pk/gbkRHK7KRjTZB8yvH+tiHSqD8UPrH?=
 =?us-ascii?Q?vSk49hvOQQjLXLPX1g9cR+ErqELsOstOCjzBMAjLDZ6a9WUcpfj6cWOrRyJ1?=
 =?us-ascii?Q?abyh+2zfUA/6Pxy09GwhlU1TDAVfaiZHpxqCbzepxDBllmXDpBzgf9m7+tgm?=
 =?us-ascii?Q?8tUWKiiNQOc/5qLhVI9/swJaHQ+cB/rPOBuAQA2l7Ga4SWrtfj9mQywwZYw4?=
 =?us-ascii?Q?Hc193TaN2zH79JRrxqnAw078StMYt3XutT4lh1dew/Es3MakkvE2ZIky/NHK?=
 =?us-ascii?Q?Ebb+l/CdEZMO/6wkB05ITxHGmUMcAHFZgpCkS+xQvCCcAWjttwag5ukYnC7H?=
 =?us-ascii?Q?yLHFzBkcYqBxNcdgNdJgdBE2aS2qqTLVXrJCXeipZvaqbTyD5iKdTLDdNXmo?=
 =?us-ascii?Q?Y8v6RDEdjLwBP1679PyKFQrX20vE9WoBGdWGMKLJRNAegzqaaip+3lLPKuEd?=
 =?us-ascii?Q?7+FW0d+nR3BTi5To+9+Zz9m+jflLH7sz2JALG12MOqv9LhHyngTYSN6c1lTM?=
 =?us-ascii?Q?AHmntO/Hhj8eSIJCw9UDiGrRJFE6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3V+/RrNMPiwjdlgvjXe08fT+RmK6bvhRB5r1QEK1ca6t/tomHzUiQCWtHg0m?=
 =?us-ascii?Q?Va/QmGL0kAwO1FqwqlL26v81pBDzNVwfZhIue7J6aU5mGdaXVn9LrFoKlBiD?=
 =?us-ascii?Q?olpupkeH2qtXEVh+EExS/a1Bd82HWxOUsigSTq5nO0OwIa55Grx6aP/z/X+L?=
 =?us-ascii?Q?ss26ZAQn1PbeSgk6HePzV6m9slPcXX/dNMW4KSkLHXKpshTaLQpeu+6+it+t?=
 =?us-ascii?Q?kv3k+RP0cUQ8ylLbx4UvtYoWqmqqOPc+EDSqgJLEhr7lgAg5SfflQeOLGz1G?=
 =?us-ascii?Q?IjDRwA977rN8omGdBkCpvF+0LGPUt1s5jyLBENXmyRP2mEzGfe9hNdA0v38Y?=
 =?us-ascii?Q?gnemOYhfjxvhJa3GxkG2NxbKN8O0p+infA2IRcf3vsPtUZirA8VGEz7HI3lp?=
 =?us-ascii?Q?lfDNAoRSNadM3+ylwbyUbkOgEg5bhQu68NEi9Ru7xViD1Wmtx+Z5KCgzxG5k?=
 =?us-ascii?Q?1CT8qHs0pTxcYC5d55CtyhXymory8IMVbSZdyfuPEAviWf6MS5tTNTal8qXV?=
 =?us-ascii?Q?f/ZJxQOy/AMq6JDEcGfG8r+MtUp9zwNE/HaCGJ/KMqJW8e4K2yTxhcuYLt3I?=
 =?us-ascii?Q?z0N9Yfs0IYDffIOhgDIkvlO8CwGe3SKHNlyoj/9L4tPnRLnczV647rSXP4Dz?=
 =?us-ascii?Q?rGrAvjSVaiqI758COXNtung32Sy2eQITTdfP4dY+l6fvhB2bteJ1XpAMZLO2?=
 =?us-ascii?Q?/gz9XwQ0okpuB18KCgUha18B3pkeMS6r+inB45HC0pkoEbNpLKSh8bTO0t93?=
 =?us-ascii?Q?qoeUt6fRNk4gV/Ag2A4PJ2LPBGDRfn3ZWZxKrENkCRgnllKbKMegVp+47KsQ?=
 =?us-ascii?Q?H9KGgl/4hunuffi7LCqOQaiXYeU1o+Krr3Tkow6SnlVysZSBylh1nRPxQ1Si?=
 =?us-ascii?Q?zw/TARReqabbA/IMbygJrRbwm9v9ubHSunebpEqt8WZCch01H3T6c1RwoJI6?=
 =?us-ascii?Q?XZMWikg6N6T7Jl/uwZvpOBdd4UFIpVw430imGo2mbtKJcrLz1SBORtTbiKX+?=
 =?us-ascii?Q?THypCu5cNZq9fsNQJh6I40+K0vNgJyY35Bkp9jxOdTcV07y0C7VecaJzFUm6?=
 =?us-ascii?Q?q8Qh6s21LCqtDOK6xXSTvaGu1Lxx5+Qqnys5vboA7ixCH4kqqJs863zRSKE+?=
 =?us-ascii?Q?shP+MYO68EpXeuM2fFAUi7V5KWZm14SR9+8QZjCKSAhOz2vwfqYMYLok1oKt?=
 =?us-ascii?Q?9WOzZjwd8gjEPdtnd59tXbqJXWpGbmBpjrDa7Hf9R9wVksIAX/InGdt3D+LS?=
 =?us-ascii?Q?Jp1E6Gam0pr4Sb7YQidGtiU3tl7/oDwAQDbIMh7NxFFVaEoPZ8HN/49LQ3fq?=
 =?us-ascii?Q?owHWiAs35sdZk8r3513y/hAaFtAM5ia8M9KZeJHzif3goWMlzsz1X5imH63D?=
 =?us-ascii?Q?lJS7upfo18v/POK0G8ZNmQU7fWMXuFIwMXBtMS3TcVXbT+P4cC/0Il54SxdE?=
 =?us-ascii?Q?7GLVPx8ShntiaTwhqJIRfSASbwFFtYRNxRxu5b/GnTdOhnWF91ka83f1iecH?=
 =?us-ascii?Q?olviQ012uFELHsbjZ/PsfGqVrbhtd0PInd0PGfY+FsDzzK5ckB7v2HqkivUk?=
 =?us-ascii?Q?dowgnUmsCJf8uZfklu76V3dYbMfOhfoaHWG+eWwI?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6375515-69b2-4fcd-ea0b-08dd2fdb1256
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:31.0084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAVVp0DUPMsHAzBUEM/9tuslAHAg0w10cQz/dmY2YWdSl+crO2ZhnGwLIgqxdtt+4aKZSQUlyRQ3gOaFwq81cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7502
X-Proofpoint-ORIG-GUID: QzKfUsO_Shj78O_T7NrbVWijaWFRDoLW
X-Proofpoint-GUID: QzKfUsO_Shj78O_T7NrbVWijaWFRDoLW
X-Authority-Analysis: v=2.4 cv=YLtlyQGx c=1 sm=1 tr=0 ts=677e673e cx=c_pps
 a=ZeveGGZnxkNpWlA7A6AaFA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=DMMBb2U3yOgPCP8cz6YA:9
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

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c                      | 17 ++++++++++-------
 hw/vfio/container-base.c              |  4 ++--
 hw/vfio/container.c                   |  3 ++-
 hw/vfio/iommufd.c                     |  3 ++-
 hw/virtio/vhost-vdpa.c                |  2 +-
 include/exec/memory.h                 |  4 +++-
 include/hw/vfio/vfio-container-base.h |  4 ++--
 system/memory.c                       |  7 ++++++-
 8 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f7499a9b74..0e3ea71aae 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -248,12 +248,12 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 /* Called with rcu_read_lock held.  */
 static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                                ram_addr_t *ram_addr, bool *read_only,
-                               Error **errp)
+                               MemoryRegion **mrp, Error **errp)
 {
     bool ret, mr_has_discard_manager;
 
     ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
+                               &mr_has_discard_manager, mrp, errp);
     if (ret && mr_has_discard_manager) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
@@ -281,6 +281,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mrp;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -300,7 +301,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &mrp,
+                                &local_err)) {
             error_report_err(local_err);
             goto out;
         }
@@ -313,7 +315,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     read_only, mrp);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -378,7 +380,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, section->readonly, section->mr);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -662,7 +664,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, section->readonly, section->mr);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -1214,7 +1216,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
+                            &local_err)) {
         error_report_err(local_err);
         goto out_unlock;
     }
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 749a3fd29d..5e0c9700d9 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -17,12 +17,12 @@
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, bool readonly, MemoryRegion *mrp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 4ebb526808..fe193ac7da 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -176,7 +176,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mrp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3490a8f1eb..f541b00785 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -28,7 +28,8 @@
 #include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, bool readonly,
+                            MemoryRegion *mrp)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..a1866bb396 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -228,7 +228,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
+        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL, NULL,
                                   &local_err)) {
             error_report_err(local_err);
             return;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d..50e7b7be30 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -737,13 +737,15 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
  * @read_only: indicates if writes are allowed
  * @mr_has_discard_manager: indicates memory is controlled by a
  *                          RamDiscardManager
+ * @mrp: if non-NULL, fill in with MemoryRegion
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Return: true on success, else false setting @errp with error.
  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 4cff9943ab..c9d339383e 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -73,7 +73,7 @@ typedef struct VFIORamDiscardListener {
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
@@ -113,7 +113,7 @@ struct VFIOIOMMUClass {
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
+                   void *vaddr, bool readonly, MemoryRegion *mrp);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb);
diff --git a/system/memory.c b/system/memory.c
index 78e17e0efa..82ac19d473 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2185,7 +2185,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -2250,6 +2251,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
         *read_only = !writable || mr->readonly;
     }
 
+    if (mrp != NULL) {
+        *mrp = mr;
+    }
+
     return true;
 }
 
-- 
2.34.1


