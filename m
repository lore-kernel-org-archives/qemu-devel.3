Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB70C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAXn-0007J1-33; Fri, 11 Jul 2025 05:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXa-0006qX-8G
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXX-0004wC-0C
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:37 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8McKu016805;
 Fri, 11 Jul 2025 02:59:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=la+0nnoAWZ183b5WEyboqRbwURPx8+4PFuLLE19wE
 zM=; b=h+1nL9onTXebzLyRU0TDQJp4gEWNomkTBVVcJJ3YXAtHgD9FaUW+4wOTe
 Z1PGx3vBWNbJmfkPd8NdygEsbBF5cw//YAi4L9pyzCeaEWXlPYv6kNiiXnrEh/B5
 lA8yT83HH2lnzhRLhf1pyq7kBqihD980XiLS+391zSPE4wYinr8DwW411Yn6oCVq
 H0MUKKz8RpNqykanmsEnv25V9GeRSc0NCphVoQKnnUJSpVF+tIL9N9LqhHfT+BE2
 Fxl7XLYYklbrnd39YsqM9FXya5SNRFtrHEvP1m1FrXyUFl2GZXCNfccEio18FJSG
 Pt9EcK4q+lz73rd2MY2Tr03PmW5tQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2127.outbound.protection.outlook.com [40.107.223.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47ta49k6fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKHNijtOHbcEjg28hyfwmyvVMwiEcRZzDSIu1UwgqXvii2DDsCTeYorchUfFkIM62QpTmbRsl3O1gULKwsg8ALxKQ8ISdjn1MFE34sKQU4dkRmAFQkRu9mRZ2mzPtjvH3FUJ2oeyRr/w12EnZZCgTPz8JpFIWmMYfp/yVKeH/tDdvKiGex4n2n2jaelQP5tBMrDs1MXRzVJct1KBGuC66C2ww9suHViaSmj0Bqw8nSj6sRaLodiLqAx6ljNpw4FUJf/YHChRwH26znHTU8xpXLAXHZgDItg3PqyUaVuF4UFfVgKShOZDeGoZLhEImUt+9ZWO2HU5eEtnWrYGYF5z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la+0nnoAWZ183b5WEyboqRbwURPx8+4PFuLLE19wEzM=;
 b=CdFcvU7X/kFB3i00/vbVfvwHjU8HmxgAiDO3/3AGiy3I/7Wj6LYlcKbVWagFyEK6BxKl0pOq7vLlbwUZoft7gx1VAugzxjkRqTpSqrqsQKwlAfyD+BnASP+wm1p5ovSHFTkgURM4rJhTV9oDBwHuX8IFbWsuZzeUwlyVEOt7iIMYCPnbG713aoEvQT7fZI5vnxzpSifhmu5Ztpi08+cB2KPVNYGpVkel5arIG8r3Wo/CjwBHC6hNlQj/zHkSKluM91x69H5CNeKeTz+NnAJ2Qmv5DpSI7TJoAD93ciRzp3k7vmHxdpm+uwdGeNx9jB+aEIDZi1gscg1+1YzpByOXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la+0nnoAWZ183b5WEyboqRbwURPx8+4PFuLLE19wEzM=;
 b=tNrridEyqcnNdY89EawW1HGl+McTsC+dQIA4eYol3lywyJmJcn5aSFsOLUSmKNbHQWbyQuRcFv5vJ+YAjNXoT+rs0WmjWoExhPAmFHFZrYpozwdakRUJYTQnqjCTPycpZPxAYppdAnGCz88vr7F6LoTFgvYHv7aUoORYY0A/K1dLR9VJvcl7Zkijros1OXZyZMN7CUW3jPKR7HtO5H4GBCxkootSvq9lVLqwYN1cuqMOBKv/f1xGDe3/lt1fMEB1ItE3pQZUFn4L+zP5xixIYV9XO5vSJrjnkxYT6AGgRTwWwu4usMTRy0n0NoBugWgKqlVNx34kNrVbELX5Jhs0xQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:59:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:59:18 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 18/19] hw/i386/pc_piix.c: replace rom_memory with pci_memory
Date: Fri, 11 Jul 2025 10:57:20 +0100
Message-ID: <20250711095812.543857-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0580.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b264ed5-4ab3-4127-7230-08ddc06199ad
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3hZY1lSaFc1bGRVOVh6cndnQk8xb01EVWhRb2R4QjBvOEVkU0d6SFF2b3FU?=
 =?utf-8?B?bHF4bzJjcjc1YndKejJucms3S0pOdGJVWmFrVjR6SzJRbktRZWFyeWNnOE0y?=
 =?utf-8?B?cFdLTUxRdFVQQ0JTUkRGWDR6Z3ZDTUlISEVSR3RYYk1BRHFxVWQ5cHpLSFFa?=
 =?utf-8?B?U1VPd1ZrbUdINm15OGVPNkJwSVZ5REdXQTU0VDcwZFl6TUdwQzdud3RRQ2hB?=
 =?utf-8?B?ZFZmUHhadW9MZ1V3UnZtTTdoOFNqcmVQbDhBcHplZ0NXSzNVcW1yb2lWcUpE?=
 =?utf-8?B?VS9UbnJHVVI3UHhJUVlZc09tR1ZSL1I3cWxNVzN0Q3MveG8yay9UTVZWWEtr?=
 =?utf-8?B?UUgvUHE3L3M5VlloR2FGRjN6NWxZNXVwbEx4MHduUC9oZ2I0aGpYNEh2VnZV?=
 =?utf-8?B?aWt3TWZKOHVDek05ejdKLzNwRTY3OWhWMmZsWHZHSDIxcE9hVUNENHVFcFV0?=
 =?utf-8?B?N0NHSlhyZFF2VW14Y2UwNTNEcTh3TmRIQjE1cjJwUndRS2I4NURMUzdid1lB?=
 =?utf-8?B?S1NYYUNGanN6NmdQMkFGQStvc1I5ZHJYcjZiVTJCTlM3aXVSU2Y4ZHlTaXZQ?=
 =?utf-8?B?Mlcwcy91QmpsQ0h5bnNXY1VtamJidUh4d1puOEE1NWxrOFVkeThjbVg2OEJu?=
 =?utf-8?B?bGlqWnJDejRkTWtwbkJWemlvaThxOVUyRzdsRDZadzNId3A4YlgrbmVDUEJM?=
 =?utf-8?B?Y2t1NFNEMy9Wa1J6MFo4YThpUWkrdFlEUjE4enMyZjFzRDM5VVR3Y0xDM1Nk?=
 =?utf-8?B?SDJ5K0RYdEQ0RnUwZ1BoUUVnNy9WcWRrUmhaNytyaFgwSmlwRTQwOFQwY2ZT?=
 =?utf-8?B?L0hON0tRNFc5Z0hPUDlFNHFCN2IzSmw5N0piTitxRlRDcG5EVVRIQnFnVW1I?=
 =?utf-8?B?WHlLa1k3bXVacS9HMXlaclBLOGZ3L0ZCQWFyM0pvZVI2K3E4ZEZHWURGVEZi?=
 =?utf-8?B?TzBqVHNycEFyMFpEUlBSRTRFcHp1QUNNUWtMRG9KTmc0akFuVG1FT09hWUh0?=
 =?utf-8?B?em9laVQ2ZXNvemdFR21hc2RKMUtLVVBqZENiVmZudHZlVVNzZHVnUitjVlk0?=
 =?utf-8?B?MUN4S2ZpbmhuQ3ZaMFUyR0Q1Sk9pWUZtRWVKajJ5UWtMRnhaNHBIQTNhbVBT?=
 =?utf-8?B?S2RVTUsrV3NvV1N1YVpNWlo5YURFUTFDRk1qcDJXSDJTNHE1UnY0RTk0Q2xy?=
 =?utf-8?B?ZVdOUzhFM1dGNWpnbktPMlZFK2E0NkhyNkQ2RkZTQjZKb05jb0R3YkllWEhW?=
 =?utf-8?B?Z3A5d0J0L1FIS2Ewb1NPcGkvaXhOdGhjbUU3dGoxWkVqaHIvMlhMRDdzcFFN?=
 =?utf-8?B?b2hnSXBHT1ZiZENaU0VRcjZmYVh4b2F3WEhiaE52Tnd2NmVoRmMwQlByeGZH?=
 =?utf-8?B?d0Z2L2xEVHZQTWgvUGdhdGtTSGZsajlYc2ZSY21YYitvaWQvVWxyaFd2TEFw?=
 =?utf-8?B?M2V3L0JQR3dqNW43M2czUnh1eXpweWZrelI5VFo3YjhZMDloK29OZlMrcldy?=
 =?utf-8?B?RElNU3IzNmhESE9LWVJyZkhmSXVxWUhtRGlUdmZYNHNMWmRGSHFmbWxLbnkv?=
 =?utf-8?B?S1p0UFN2aHhLWWJDQktCU1h6R1IyZUl4TXJsaXpPRTVVeWJ3ZHc2QzdxSFNi?=
 =?utf-8?B?SFg4bCsvZXV3WW1JY1d3bUJCSGtDQ0R0MXpIWGkxNWMreGV3cDVYYnZTNFJz?=
 =?utf-8?B?dGphaVora0w4cDNNZjNRLzJ3L2xzRUg1ZXZHdWJuY1ZMaGc2WmVzZXo3YVFP?=
 =?utf-8?B?S3h0ZS9id1BGQU5PNnovUlB2N0NUdlpVZ29aa1hyZ3B0Y0xUN0FuaTBYc2lh?=
 =?utf-8?B?NTFhblpMOFdhK1piME82MVNxanJhVmhWbHdCVEJTMlY1UU42aUxVMlRKc29N?=
 =?utf-8?B?RTduY1VFQjcvNjZHZWJWYWZucWkzRmxVK0Z5TzZSMFRTWHcvc1d2aUJ4K1Ix?=
 =?utf-8?Q?KlCn65hYH14=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhYK3pDV3BHWWlvaHkzUUlON1huLzlTVmZ0aVdnN2NFQ1pzQVZNelo0MEpR?=
 =?utf-8?B?NTcwQ0htTVlUaUc0aWUwd2QwWmJsclZOMDk0TDJZdTVGZ0gxbnZwQldMNDVa?=
 =?utf-8?B?c2t1b3FabkFRRUw3ZnpaTGFEcUV6c2dLMkhsVnBtWk92eWpxc1dGUFNJNExC?=
 =?utf-8?B?Y2czT3NINnQvbC9wendCMWR5cml4Z3NVR21qbFJHbHM3UjdnRkdPcldLZytV?=
 =?utf-8?B?V3ovMVlKTmtXRFk5d3RQZXlTY1cweFNiYUxiQitZVENLcVd5bjFzTEtESDAx?=
 =?utf-8?B?WmM2TlJUSTZocWFhLzFwa2Z0dDJBTDRKRnpJREVCZjJrRWsvYjVNYTRLckJk?=
 =?utf-8?B?b1RVOURscjl1TlVkdDlWcC82NXJERGZ2c1dieTVPSDZHQzU0NFU5SXBNeURX?=
 =?utf-8?B?eTNidndzeGF4KzJuQ2Y0NHJqSm5OQTE0RVc1aERpY1FlSUZGd0lUSWh3MzZK?=
 =?utf-8?B?UjE0TW10MGIrTXYxM0t5dlZ2dTR0ZldCNzFhMk9OTk05cjVaa0xNakZ1eEs3?=
 =?utf-8?B?RkxscjliSFRZSVdpZWNJRkpuanFObEx2YjMyc3FQSEVZbktCSEdveU9DdHJq?=
 =?utf-8?B?ZnBVWDBvdllKdXBsbGlhUHJuZTZhMTEwWG5RVXFId0RVeVhleG5ac3BRajVv?=
 =?utf-8?B?NXlpZktYanViMWNRRDVDRE5qRGppNnN2QjgvQnRzNk92Znk1UndSeldETTM2?=
 =?utf-8?B?azRtbi9mUEpsY1NTQ3gxc2ZWYXo3cEI2eGw4cVFhdmRxUzZYZ0dzT3pjNEti?=
 =?utf-8?B?ZGZ1NmI3WHB4V2k5cVJianpNaFVuZTJETkduNFBibEFRVVFYUlNmNDNabE56?=
 =?utf-8?B?NjlqU1Q4T0g0dnhick96cnlITW1hVVYrY1R0T1hONUh6RUlKZTYzMElsQ1dV?=
 =?utf-8?B?d3pjM0VUK0lVVGJCZ25CcTkxNnRDR1pBdzk4Q3Q2K2pRZUhYZ0F1eDBxblYz?=
 =?utf-8?B?VHo1bHhLeXVwQVh5cEpHa0tOTVhRbStudlAvNlE3eWFpQVRHVm5FL2ZWeEIz?=
 =?utf-8?B?bXM5eTJ5Nk0vYm9KN2Y2R2FjZ0xSWjFyMXpuWFRwWGZobmpFNjlObjJ2ZDRu?=
 =?utf-8?B?U1pIOWwzTmtIcEt0K0VDVTFSL2dEalVMN2t1Qll6Ujh0THNpMDhiL0dCUlkz?=
 =?utf-8?B?NkVjaFA2M1d1Umc1Z2h2bTdsSUkvbWlQOWFvS09ydXBxbSs1bUsyV1hMRHpy?=
 =?utf-8?B?aDZvVFB6aFBiT1hTUTlMWWdEMFh1L2MwcEVQdW5HOEZvNnNWVEFPdUZMQVFt?=
 =?utf-8?B?Q1ppbjhmY1gzUC9lWUl4Q1BKTjJHdlprTzRLWDh1WXVlSzdCOFNwRGU1alIw?=
 =?utf-8?B?aGpuRldhdlN2RzZZMExRWUxBdXJFUWZPc0hiVjZKRXVyMUNlMnJWNkpQd3I5?=
 =?utf-8?B?K1Q1NjE4eEhLZTJqSXRJV1RSUSt5NEI2dG54cmlUUmNYaWJZT2NERTVxbzh0?=
 =?utf-8?B?WkNaQ3RFNXFTOHBubUMySlRDSDVjNm5yZCtjTE1jdjN5NEZqZGVNNCt2YzFZ?=
 =?utf-8?B?UVVqSFYvb0xyeDBINjduTVdPWWV1N083akxsSDVTaFMzdXp6QVowRHhBRUl5?=
 =?utf-8?B?UnZ2Q2ZGYkt2bjU0RGRsbUQzYllsb0swK3F4aWt5WlEwQzlMUWtxamx6dEdK?=
 =?utf-8?B?ZCsrRVo0T1ZMZ2RlM1o3K3VITHhCalYrYzlZVGxWYisxQ2ZYbnZFUEp2Q0Nv?=
 =?utf-8?B?aW5DbW1la3doOHd6Ny8wNjVvaEVuR1RPcmZRbitYT1Rra3hNUnc1ZFh6TlFW?=
 =?utf-8?B?b2J0dnIwMGNuOXVpdFptU2VSbUdLMnJUVGZTRW1JdVk0am12WlNnc3M5WEZQ?=
 =?utf-8?B?Y3hySm1Dak1JNjB4SW5ldzNEM04yRE5XRC9JWFJHSkpRWmZzcTVYdG9tajFR?=
 =?utf-8?B?WHphdnI1bkYwdnNCcFpyMEhoYlZmMEVxK1NibUJoRytkRE9IaldkTVFjZzdU?=
 =?utf-8?B?VzBWaTkwK2F6NFpHaXdrS1hieGwvMU1XZmF5MFNUQ1EwRWIxNGRSeFBqaW4z?=
 =?utf-8?B?cmUxc21VUjMzVytFbmdWZ1pIeFJiZUZrbXdLS0IrcXlQRHJOMGlnaS9ubFpn?=
 =?utf-8?B?MWxnU00xRTBSVm9ENWxCYTVMRCs1VU9nYkpyb3I2K3N3dWNVSkZ4SUJBV2dx?=
 =?utf-8?B?VUZ3NExVQkh5SUl2dWd3aU9rWjg5NmRkWnJkSlZyRHVsWituMEM2SU5LSUJC?=
 =?utf-8?B?M05STks4RnVyVlJ5QXJDZUl5ZldUc21rQjZVK3ZTRG12TEJqeUcwd0pCUXkz?=
 =?utf-8?B?b25KU3VqTitwTXVmQS9LOUYxaGlnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b264ed5-4ab3-4127-7230-08ddc06199ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:59:17.9884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKdcag9exZrf5yx7myDrVlmPHEoGlliN3f8Oba4u77kK5k8M07fxGMmwVmolnXiTxlRrKxIkJLQo/MBlCTflDtk+6pTL8QsYbjFnMGktjc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Proofpoint-ORIG-GUID: CdngY8_MQf_HWTRNQlcEaYka5tCufvwv
X-Proofpoint-GUID: CdngY8_MQf_HWTRNQlcEaYka5tCufvwv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX9O1d/F8nhVsI
 6x6ureaTv1m43Be5WEmzfoNF8ZQyriJBf4SBo4+sKlHH4iHT9i42v9MVjYhBtZNQ8cbVeH//zBE
 bWPNT7cfj57Rg1I4fEkIJI5+bJywNh2/vlR5rO0JKjDlVoXgkLtvQWO3aMFBTGWM5HDX4xb3k2n
 nOIQqGXlJ6dKH1lXura0DXmcaXZ485B4b77e1U6j/8uWAnIwj8PHJk2WoUMDqflj0I1Bgr//fPC
 gBKOje5XyaxH0zcsSUZpb3/A9F9sZKka0TjEanjjyh7q+4MZvTEijlJNXTF8JQiU++qJxvTde74
 CJJ4WvFwYnPlWpx+k5pWWqy7rp7tNwOq1JxZjDGbRDwlGypVFeoo7gic352ESgrlHbDT5wj5NAf
 6cdLPx5dUTSh0rmn+qq6qG3gVud/H7MNB/w3qSYtSQDC7BjAsN9cbJDcAV7S1OtGv8r6n7WH
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=6870e077 cx=c_pps
 a=Az903AZYGncP8juWkLdPyg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=9K-6XCuZSqnjzfDIaq0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Now that we can guarantee the i440fx-pc machine will always have a PCI bus, any
instances of rom_memory can be replaced by pci_memory and rom_memory removed
completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 17975ba0c4..7d2f6abef3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -105,7 +105,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
-    MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
     PCIDevice *pci_dev;
@@ -183,7 +182,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pci_memory = g_new(MemoryRegion, 1);
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-    rom_memory = pci_memory;
 
     phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
     object_property_add_child(OBJECT(machine), "i440fx", phb);
@@ -214,7 +212,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, pci_memory, hole64_size);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


