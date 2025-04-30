Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5ACC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIR-0007rU-Jp; Wed, 30 Apr 2025 15:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIC-0007l0-QY; Wed, 30 Apr 2025 15:40:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIB-0006Ac-4M; Wed, 30 Apr 2025 15:40:28 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFsDcE012615;
 Wed, 30 Apr 2025 12:40:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7G/+no6VwIjsBnW2vj7MtseocxnotOTd1I9Cnqfim
 5g=; b=qmDAsmMvcqyT/Yv6ERrqT319XsBEZ6Gl82SJs2uLkxgeWsY7YD2HUv7Oc
 5Td5PtyMi+8923HE+8AZfN3/wli+DOKGeKoiY5XYxWzBSw47/umOTKMrFWPYCpIb
 xOiz+DEoVMEWH2qIBdWyKFvxIcG6DipP3aeFkBVEgYIKnwsN2aSaB+M8NroBCX68
 xYlsgYbi6OqfZuqNx3VvrvNpt2NmE3XuE7L+7/UubCBwPYw2SbLbcgUbErm+ZH53
 9jSiRH2zbY4FJ5zYVSh/kqFEhmIUlqefyoihg0T0F6aDYq5h0Ahp489fa4zUf8re
 EXRzsubbhoeydzkUrA2/frnBtIKCg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468w18246x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8KSmW0XDcg+/7tMo4TGup5KmMdbEJehno4n9ow0Sz5BsuvwdrKOhZuUUq7yehULd0xgYcOWDdj3Fp2IPqYkVeQCtCA6ITl3dK2fAzcZd/1bbJOdhGGeP4+cIYdI4Cj8sCLXSPjrlzITxY9KiSi5lviZgWmvs4wAEyC/KNCCAnPbNtmyX+wnZy8NhDmgY8tyztnbos9nRx1W40uZS7XlkDcN9TmiWdL2KitSZjg0gGHRgg6x+3HSn7HTXFR77hLuaU6nvT33kJkplq5aa1KUliBqi5W8kaOPPOgBuSbD0onRaMJicx1Y5xPrMJekBfXwrml69QtEXYxe/y5HHhD3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7G/+no6VwIjsBnW2vj7MtseocxnotOTd1I9Cnqfim5g=;
 b=x4zFEcPR+zg48pGNs0BpDf/7CiZoGlvs7uN2jBE7H8EEmirLgOyvX3CFq2fb/hN2T3AFvzlqXqsA96+mAZBWLSAVpvNrhQWWYmkb5jjLB55VBEJ9pJBesh6nTbt8KRVAG6wN7ZyLASJ5gnhq8sVQTymZIRv1JlbgEpNbk/J/oyRaNtCo5O9B3BOTQ3iEhzJG2xHpJYLoNkxKgGZiuo+IgsRHAy5tbmHzZ8KCIRyfZlP+h0WEkLwA2pBRaC7jzEnovaZc7vBSP4/A99E1YcuX8bkYux/r7HJyx13QSxSM2J5GFj+lkB1/d0MOdT+f9C/V70p4d+aehgahZXN1h2Zsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G/+no6VwIjsBnW2vj7MtseocxnotOTd1I9Cnqfim5g=;
 b=vJcP22NdhybLatCPb/nmNhOvGq69QlD+w+k/yGuMPAFCmv+eczJc462uBibW/IYQcy76ru+9FLUn8aQcLmEJnE5ozmcmGRnVEGwtyFzw7j6Gk8DT1Xz2oCMrmorMcQVdbDXFhqxXOhPXHoykoVEIa/NZ7SZ00twK6QKSA4Bptpv2z8SY8mWTIE2ZG4EI5SyfUtFd6i1qzaADjTwQeE6E6chKFZ4HjAq6VjjsQ2c0HSBIeTBKcB4vl3jkIj2Pue9zA00I0vba8+D6IvbTLTp2wEeyyEdGtIuP99UkXQ/XtdMoLkcBTJXUc9Spn72N1RMFfVq6hsS4AbxZq7hwZhwMhg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV3PR02MB10054.namprd02.prod.outlook.com (2603:10b6:408:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.11; Wed, 30 Apr
 2025 19:40:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:19 +0000
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
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 03/15] vfio: add vfio_attach_device_by_iommu_type()
Date: Wed, 30 Apr 2025 20:39:51 +0100
Message-ID: <20250430194003.2793823-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV3PR02MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: ad90ff7f-fc7f-4194-ab7e-08dd881ed701
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE56OFJvSnEwL1VQancxTmtqQnZFRnRVa1NzQURlelhnY3VYYmVJK0tSNWp4?=
 =?utf-8?B?TzMzN3NiK2d4a1VUeHJHblBYNTRkY0xVbE1FdStCK3pud1k3L1VEM2UzcjFs?=
 =?utf-8?B?YzhDZGNEL2lDVUdPaExld1N2THg2OUhsYmVMd2praFdVK3FaNkxpZExxY3VG?=
 =?utf-8?B?Y3ZESUxndWxGRHZjSWZYYllvbElTL1E3Myt0RmxhRjNrZ3hwei9YUEF5Tk9V?=
 =?utf-8?B?cGNYZG1zYmV2aWcvRHBaZjhrMHRvZU90NTJUNzgxU21RNWkxQVV1SHFzWXhw?=
 =?utf-8?B?Mjdka3dRTDdxWEFQd1BTdkhUb3g2VDhLa042ZVhUL3NETWJsV0ZSWGNrOWhW?=
 =?utf-8?B?bkNwTUtKV0lzL0Nla3RmNHZYVEdUQVpyc0F4dzdjVVo0cXBYK0JXQVZLSGhl?=
 =?utf-8?B?ZGh2K1dTcVJWY25CeWI1UVZhUDUvcEdXcVF2cmd2NlpoN3RjOUdQc0k1d2ZP?=
 =?utf-8?B?MHlKcUVUQ0NrVk8zRkdDUFNxNXYvR3p4NjkrMXl1L0FPY2lmcjhFc2xwaGg5?=
 =?utf-8?B?RGkzRzZKWmlXTkt6MVdLNEdaYytnbStRTEIwcmlwdGJ2L0dLaVAyTEtKWUNu?=
 =?utf-8?B?NjA4SmEvd2RMNFl0QUxvUGhmcFpySGc3MFhBWlJtdHZHWEdpVVV2ZFVHbmlG?=
 =?utf-8?B?WStSV2Y5amRWV3VoVjFmajF4K0dTcUpIQmNBNklJVGRLWHlMSExSZWM4Si8r?=
 =?utf-8?B?T3R5SVB2ZnFGVjZMNzE1OTd2NnNIdmN0bHkxbzJKRTkxdjFHekMzVWJ0THpu?=
 =?utf-8?B?amxhYWVkd2tlcmd3RzJjaEtqQ3c2Zkd5aDczN1BsYVd0M1dNMU9pVFlwQmNh?=
 =?utf-8?B?dmdHN2FSNno1RjlYRDVSUmNmanQxZ0V3dGdvekpGcWdCKy8zaDNJZjNNY3Rn?=
 =?utf-8?B?SEYzN3Vqc01EUHFzUjNBSkNTNE5DQmhZd2p1VnVGZTFaUWZOVEJQSkVJeWR3?=
 =?utf-8?B?UFh0RUZrcFA5VUxNUStTcHVXZlE1SEp5WFdXVEdRNWoxK3Fha045aU5sRk91?=
 =?utf-8?B?YzRoQUo3M0lZYkRrR3l6Yndyd3Y0akdidFM2a0tVRlR0L0RpK2VpSzZqd2cv?=
 =?utf-8?B?Z3drMk9WYnFlLzZzNlROaStoZHV0OGUwaWdPZkFxaC9aVjNoVzFLb0xtd0Vt?=
 =?utf-8?B?elcxdGk1QVY3eGlCb3hpRlJtWkhXakpSVzkyZEZRL1BUak8zdnlTN2x4Unl5?=
 =?utf-8?B?VkMrUFZGSkl6bnlzRWszbEVxSFlGTlRjN3ZwZlk4VFZXemFrNmd4eFI0Yndu?=
 =?utf-8?B?Nmw3N1hpY2Jna29MYiszenIwR3dNb3Nzc3ZzZEVsZHRXc2ltNzI4YlpzZjhN?=
 =?utf-8?B?aEdFczAzZDRPM1pnd1NjVGlqc3ppMkRLUFlLVDZpcjJwQnV6aEdqUDYwZFBv?=
 =?utf-8?B?WWFyUmdETGtVL1lFMitpOGI1UGIyZnpMTG1rdFEwOG1pK1hKZXdiS0kzMXMx?=
 =?utf-8?B?elZMSnhVUjlSVHQ4RXZRaEZWbXNkdWM5R2Q3dDZ4WkkzT0ZmdHpjMkNuMVZw?=
 =?utf-8?B?dWMxWkYySU1WeVNqK3V6d3Fjd2x0NjZCNTFaSE5RSDZZYkoxMUh5eENiTDdT?=
 =?utf-8?B?d2JoVHB0NDhYbGZNSjhxc2xzWGtOZ2picGZJZzJtUHpoeGNiSW85dDNlVkNK?=
 =?utf-8?B?VSt3OGJYTitMRjcyaGgrYVhKbnozZFJNTTdLdDhPRCtiT1NWVkgzQTgrRHA2?=
 =?utf-8?B?SU1ERkg4dER3MFhKNmpDay9aWEh3dnpWSjh6NDBadTN6cnk5azhYTG9EazF4?=
 =?utf-8?B?eTZWakRNa0hYL2w5bFBya1lkOHZFayt5S0VZT0xLWU9LeWRnVzF5ZjEybmlI?=
 =?utf-8?B?eGNLdytFQllJa0VkN213RXZGbnd2K2JQYUU2VEtyUk1MUlRTdGYwUUlJVW9T?=
 =?utf-8?B?eTlqOHhETGFPUzR1RjlzTHFCS0FMRUhDVTVTTUxxVlFBcUtXRzlRQTZxa3py?=
 =?utf-8?Q?yQY6+Wjdd08=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTN0L0NOajYxU2czZ0dzVWdhSW44ZlduUXUzbE9PZHRNeGVsK28rM3JXN3lu?=
 =?utf-8?B?c0JMK09TbFNtYjRVV0ZyUDA4dSs5SURGOTBBa2lXR05LSStWejJSeDVCSGhC?=
 =?utf-8?B?NlNBUUQzbmRDcURjc0dmM1QvNUU0dG9HVVp3WGpEazhXR0xRMjJtYmJoWVRm?=
 =?utf-8?B?N0RPZDY2YmVsZzBYQU5XV3pnMlI2am1yY0Z4SzhzeXlHblBnV0N5dXdvZ2FC?=
 =?utf-8?B?d0tidFZuNndRcXJYU21IM2NYTHVWUWl5WVE4QkNDZEZSYUxEZDJBNDhmbkJH?=
 =?utf-8?B?a1NTOE5vYU9NZ0p1aDJ4eExnNHp0RnIvY2MrVTluUnlJcVRkbFJYc0xLNlhF?=
 =?utf-8?B?QTcrNUFpMWIrZnFFNE5qTTNobXJsMnZCWW9LQVBwYWNDK2w1WlZQUm11WTJv?=
 =?utf-8?B?S2RiNU9zckZabjdoaVh4U0lHUUdJaTZaUFliSFRGTllJOVF2Nk5qNW5Nem1L?=
 =?utf-8?B?VlVVMlhtSjdIbnFWMzF1TmxjMjZkM0pRUmZSdzBpaXFxaFYvQ0V5ZUFhazQr?=
 =?utf-8?B?Y0tHeHdpcS9sQW9KTXFpVlFPOWVZc1pTdlRNaGNqQy91ZHo3WWx6aVlLNlJO?=
 =?utf-8?B?RlJVdjNjK2N1UnptQlJMNllEcjhSRkx1OEpuRzRzY2o2UlF2alBML0VEbHBw?=
 =?utf-8?B?d1BKWHFMYjlEUWw0MXVRbnBvcytVS09YeVltdE1IQkQvRFFBWW9BbitWZFdr?=
 =?utf-8?B?dG9YS2FlM1lWWEJrRmxqcGRZWnIxNk1TS1pRTEZaSzROUklkby8vemlxWWw1?=
 =?utf-8?B?dE51bVJwQkVwK2ZjMDMwbXc5VUZ5c2o5QzlzelFQdVNpSzNBbTljOGZJSUhI?=
 =?utf-8?B?TkdudDRBb2U2T0tpUVgzUVR1eXc5d1ZoTmpJMDRWUkx2Wk9TQzkyWTFEVlZG?=
 =?utf-8?B?TDJuMTFmbWE3UTUxSnZPT0gzNEUveHFzbXkzY3RQVisveXZFVlZWalJCU00w?=
 =?utf-8?B?TXEra2Y2eWxkZ3dIV25BYm8rbzhueVlnb0p5UHkwZDR2cUhrVVRidFpGWVJp?=
 =?utf-8?B?dU1MMm8zVmhYVW91dVpxdk1keEVIbXZJWDdmaUhpYXg5M0V2a0JqR0U4RkhK?=
 =?utf-8?B?RnBuUDgzOXZoSnM2NVV1bmplS0ZUYVVoeUtSWFp0dmtzQUl6YTNsVmd3dy9O?=
 =?utf-8?B?N2I5YVAxVUlYUkcrY3hpMFhFUlNLZ2ZjTk9xcnJXdU5UenF4MFFWVzU1eDJ5?=
 =?utf-8?B?UU93ODVlZGhuYzNoMjJwdlZwbG96RDZ3ZGNYVkZIMGpPbHZUelBmVHZXYWtG?=
 =?utf-8?B?UmgrVzZ0ZEVJOGl4bndJcHNuc0UzNXE2MXRsZEpROUxIMXVqR2RzU211eWZ2?=
 =?utf-8?B?eW9nVUpvbnl2KytpVGhCdERSUGxQRmR3dlVwVThnV1hGbWRlS0tkV2hBeG5J?=
 =?utf-8?B?b1lhWEU4SVpWc3lubHN3Smt0dFV5S0wxem5hL0JXbGJPY29EdHJEb3AyL0Yy?=
 =?utf-8?B?c1htMUtBMU4xWXA4MEdTS3UxNTNSaTVhbW1Hem9YQXhHTHFFUXR2RnU1Wis2?=
 =?utf-8?B?cmkyMzkxZmVZY05UU2Zyc2pYcDZoa1RRUEcxMlFReExEb1BaRTJuZndlRVJJ?=
 =?utf-8?B?UEw0Y2tFSFpTeDI5WFY2V3VPUnJqRkJxd05CSlJXYWRreWw0ZW1pOVgzZ3o5?=
 =?utf-8?B?eWtSU255NkdVU3hUNTJheVhaNHpLRWdrYkgxVTZobXdybWFWcWUxRkl6K3R3?=
 =?utf-8?B?eVBGbVdJY2UrMk9nMmhreGtKTjFrMFJNL1VneWdiNWhQYkxkSlVtR1lmZlFs?=
 =?utf-8?B?cUxFaEpWT0xrQWhHTSswcVFLdU9hcnhuWDllb2Y2Q3VxZVowWWxoWjN2c2FG?=
 =?utf-8?B?aS9yL3d1bmltMWdmUnd5K0tGMTlaNnNQM1NXNjlCZjI3dTgrc1hiSm1taE1n?=
 =?utf-8?B?T0xnK2N4Z0lyd0Nzb2VDMXhJUVlPTk9QRGVGSm5qT25ZaGZDMUVFTzNoYlB5?=
 =?utf-8?B?Y2QrODJzTjA4RFRHamdTKzkySUJuTEhJMkhDMEpGdWxHTVhxY1F1akhnU1NY?=
 =?utf-8?B?TDMrejFTRzUycURiOUYwZDU0MFM3SHQrVU9VUnA0enFnQlNpSXlVMUhydlN0?=
 =?utf-8?B?RVlxTzQvNk40U1NuaVd5T1k4WTNsK2VuUFVFRFlVVjZaUDExRVg4UjlyMFVR?=
 =?utf-8?Q?J0j+hcDWFcKjg/aoSrwBanmon?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad90ff7f-fc7f-4194-ab7e-08dd881ed701
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:19.5954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRsJRRfvAsfUhJRIZCGCZtVfmvR9D742bFnIdFFnllReV8IZi4uzMIIyTiZpCYQWiir83NuXxWwMJQcHNy0E7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10054
X-Proofpoint-ORIG-GUID: mZ6adnwp1GzBE6OEvbYMkkhIie9kXz1d
X-Proofpoint-GUID: mZ6adnwp1GzBE6OEvbYMkkhIie9kXz1d
X-Authority-Analysis: v=2.4 cv=VITdn8PX c=1 sm=1 tr=0 ts=68127ca6 cx=c_pps
 a=hHPfuxNGWHHq0fQgDGst2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=QBjBLJMD6KpLvVksgCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfXy/fu+IOh2wlC
 M35YaVZitEVu1ipi679CDH+8CiUUwe5wsSZnWcfPFtPe/2Z5INGp08LwbasXCj/FCq2j/90dJ8I
 NPXi1qdtBOQwFW4OHtUJwafZ2M+RKFkiz6nxSssPwuCmUBtRUVdRzqFQthmvXwktbGWtaQOL6wz
 njLTdH1qQWzhPdo3PTLmIif6IKhL/oQGQeDqKHwGyvy8v6gx3r4E1t3yehRmuXzXkSvi+jVbXk9
 pJLPhZB/R0vXf+T25L7Sk+ZxNwALOXwARfGtXZL2HiPgGsxlk8cPT60KVeMQfwlm9UFZi1vv5xR
 /W4S5U5vCHweK+I/gs7umZsDLSJ+UuXGnz74WP7y82URcANCdJfTlyn9IFr+ONTApLm++nAP2d/
 3Jc0XQ8TZfW9DDwgWaXieYeFV7Xt4of+eCLunIqIGXvhv3lFekk4jpofV0IqqDIeNz5dDsmt
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

Allow attachment by explicitly passing a TYPE_VFIO_IOMMU_* string;
vfio-user will use this later.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/device.c              | 22 +++++++++++++++-------
 include/hw/vfio/vfio-device.h |  3 +++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 31c441a3df..9673b0717e 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -376,21 +376,29 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
     }
 }
 
-bool vfio_device_attach(char *name, VFIODevice *vbasedev,
-                        AddressSpace *as, Error **errp)
+bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp)
 {
     const VFIOIOMMUClass *ops =
-        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-
-    if (vbasedev->iommufd) {
-        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
-    }
+        VFIO_IOMMU_CLASS(object_class_by_name(iommu_type));
 
     assert(ops);
 
     return ops->attach_device(name, vbasedev, as, errp);
 }
 
+bool vfio_device_attach(char *name, VFIODevice *vbasedev,
+                        AddressSpace *as, Error **errp)
+{
+    const char *iommu_type = vbasedev->iommufd ?
+                             TYPE_VFIO_IOMMU_IOMMUFD :
+                             TYPE_VFIO_IOMMU_LEGACY;
+
+    return vfio_device_attach_by_iommu_type(iommu_type, name, vbasedev,
+                                            as, errp);
+}
+
 void vfio_device_detach(VFIODevice *vbasedev)
 {
     if (!vbasedev->bcontainer) {
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 6d2a112734..666a0b50b4 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -127,6 +127,9 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
                                          const char *typename, Error **errp);
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
+bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
-- 
2.43.0


