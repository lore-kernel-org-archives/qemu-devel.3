Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCC2C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2h-0000Ll-Sx; Thu, 10 Jul 2025 04:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2e-00009Y-6D
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2c-0003a2-8u
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:07 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569MA3c5020442;
 Thu, 10 Jul 2025 01:54:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MVy9IpMFLSy/6XGWecXsvRF9RMpmklOgXe5V2tWFb
 t0=; b=C5FtN5pFesgk1bYfahl6tCiB7SwR68ceEyduVofo14sd8aTAZPO443KIj
 k+6PxViyQ76vo27b/6BCl44M78TKBq1LAKbXIjhn6ML4iDRyF5NWmrjgnTZ3qVwK
 0LJypqjc+lW6awycBUC83d5yzSiTg0Vx72fVJLg6/KfI6YIw9HLdGGqsIkhJ3qKU
 8S1JFgRVDMe+b7D76PPkhV1tRTfzZ/HYC0TwX/Ywvkr6TbdJ2ClJ/HtGfA+okdGS
 6VvPHnYCtAiVuhC9vgJOWfOm4T3lE+KFh42IuRs/zbxqj4c2zhzj1bYjh2KgTzyQ
 KSp91wfiOikEF8V+nCgFXE9q7+9Xw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11022097.outbound.protection.outlook.com
 [40.93.200.97])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q0cvn298-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwsKn7GCCkhUryhX9ZBj1AewEReokGlWPpn2q5tgOb2edIKSj+Q1c27CM0Nspwb5y+tDAYFaiqCcWdh3XDb+PnDhSQdsCfRrhrKu5Io6QTd9UZQ31+JaUfuhoIrDOKbgQNtSBYnybK+00HMsdONdKOIUGl+GX59uCH0cV0tVV4RYOWMPRFvEWJyKFJ9PIBgbbRwD1fZZMUhNy8cfKNMkGWkb6cMkCkZ6BmwDm57q7O8J1Oo7Hy7WaotFk1OvIO0fAizDDlUCo3oUkOipqPn0SSoWXBEnb5PCyHi4O55caF9IKvnlV1W3JQszA6N+8WjaIzio7u2N5ONDUc1Jqqki/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVy9IpMFLSy/6XGWecXsvRF9RMpmklOgXe5V2tWFbt0=;
 b=Jq2hH1IUUvM+tK5zNXE80jg7hiJISHk81VMXJ2lhCv8UyYdHHTAl1vWoS/Kj66zge+TAFvdVDudKiCQ+VWmNF3fo2O1yYr9a3vMCmOmffhXSdbknUZzYlajmrUiiOft4/UysDeALDoDCGbc9VrxRi5CHvL67iWXu4dxOOAEROOWUK1jhJE5IuLJsduhXke+EfNaD/ktbRw5p6wQkBuMP34+8bRf68tiKni4hdEAiUEMyPGBt8qx1IFPTEFpmRl6CYeWGYTAyqgdn+sLR3rYTV+Yvuf8CQecyr830E4EeTJHmAZU0Gm80j85nozJbKAWIeKp/sy6bKWbWso82LvjQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVy9IpMFLSy/6XGWecXsvRF9RMpmklOgXe5V2tWFbt0=;
 b=tXCg1oxsaZFuvcGG5C/QAvNlPEQu2HTIZzKJYgNrSf5x1ARdyODGc4FY2v1pHcYiKgO3T1O5dKKNMIQkXweMoT/CEHoYAQckVvwHLbRUa4M5hPVOwc/htPxgpbT4EPE++4V3Uf09vk4rh6Sv2xC3Q6rCjDYMA2cWb18nyEEZjn8QIzznmvqH5y0MMXDa9af4Ah6a7gzUvXu5ieHzJfJPaJcEdSXuHeuIwRlsmNt3C+z/Fu+5mY7M9EHMyKT4IUU3g7pRBtzAwRpPU1/L2VpbyXcV4CKH5yP78EUw8y5fA+liZjp7sBY0SOM3v3N//ml8ZY7uY4jz99m6e7I17idj6w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:53:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:59 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 13/18] hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in
 pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:28 +0100
Message-ID: <20250710085308.420774-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0134.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::39) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 8198f342-2bc5-4114-9a35-08ddbf8f4fc0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUVwa2prcElSNFVQSlVKdmdRTmRLQ3JOa1NXRFlPb0Z5a1JHeXowbHZqZ2J0?=
 =?utf-8?B?UzBqZTdhMVl4MzBOSHpPZ1ZHUFhrNlJRTnEreFRob3VEa21icUU3Y2N3RjNz?=
 =?utf-8?B?OXFJVXFNUHRuRUNuVmhBSS95TWVMQklCNzR3aDcyQ1RMLzVWL0F1S3g1N1dQ?=
 =?utf-8?B?UnFYdm5tYTJIWFA3ZGVOSU5WS3M0eFdmMW5UamJrNEhiOE1RN1VTVnRyajZs?=
 =?utf-8?B?bHNhMk5kUkdQWGFuT29Zd3RJdnp0c3Z5Qng3T2pIT3psUmhKc0p4eko2c0JT?=
 =?utf-8?B?dFNwY2VReVE5L0FDUGJYTEVHZFFpdE1TWXlHZmEySmR6OHBVbFpVOHlrcHdB?=
 =?utf-8?B?NzZIMXYxcGE0RE5DMjlwK2RuR1VpMUROL0xsSWFFWTNCTWlSVzlVRkFrVVNP?=
 =?utf-8?B?ZDNicUF1ZjZWSUlJSWFCa09CV015VHVWYXFIaTU1YXF3akpQalcxSEtJSnd0?=
 =?utf-8?B?QzFRM1ppd2N2Zng5cUYzSXZNNk5jYWVSS3NhdjBldXFwblFoajVRUVY3OThM?=
 =?utf-8?B?bDVFZUhja1pKd3Y3YzBMNEhhUTZmc0lyWEEvTmRiQ2REMkEwVUp4TnhybEFE?=
 =?utf-8?B?aDUxVGZHTFlQRlFybTAxL2c4ajRra3pPeFUxTkIvOXVJT09NNFo1MDFZOHpi?=
 =?utf-8?B?dzUyY3lJV3BTL2d5aE5PZERwUHZPNnBLTkhPSFZVVjE2c0x0VDlRRjIyb09Q?=
 =?utf-8?B?bjRLb3J1STh3UGhQNHJnTlVLWkthS3l5UldOdjhJcTY3MGJHcWU5Z1FMQlZ1?=
 =?utf-8?B?RkljQmZTY2ZhQnJZVjlKWWVZTUxFTkMvYWk4NWgreVliR2NNQ0xiNXE2STRZ?=
 =?utf-8?B?VzdrWlFYMG5kNUc1enRiV2xLUnpRaGJ1NTNnTlV4WGJ2Skg1Wk1aQ3crOWkw?=
 =?utf-8?B?T1dZd3g2T1F6QklVMFkrY3BLeEJxKzJxUFg0NUNTNlFiUzVYSE1PdnY3aVVJ?=
 =?utf-8?B?R3lML1UyNTd5S3BlOTVFWVU1T2VBTTFHZkdNOXY4MWdoU3gzVkZQaElQY1Mx?=
 =?utf-8?B?WjNLWXNLUGg2SXNWSnhZWVR3WGcxaHpGMERNeURsWTdOdjl5UHNWR1NEbTJw?=
 =?utf-8?B?THkyTFEwMHlGbExIS3doSkcwMEo5MTdidXBLN25jajdYSUIrVXVuelhPb090?=
 =?utf-8?B?TlNCZXM5R25raGdpbmNyUjVncEFIa29VSE5ORW5jNS93S0hIMjVvci9PejlN?=
 =?utf-8?B?a21SR2dnVzJVUGtOU3haNUJMSnRxS1RlUUlaS0pJOWlXN0xoSW9oVWV6d012?=
 =?utf-8?B?ZmV5NWlSNzdJUXEwRW9kem9PNW9HaUhUMVV3ejlKRVJQZ0pUazAzaTFVOEsw?=
 =?utf-8?B?REhJZUNTQlExNkRlYUY5MnI5d1UrSE40SzEraGg5ZHNNZHNpMXl0WG0rM3Zx?=
 =?utf-8?B?b0JkeSsrVnJWUUM3NzJ0b0pSaWR5a29MNmd6dDFmZHUxRnRJQjNEU0RwYUk0?=
 =?utf-8?B?WllPdEJiTVU3WWl4NlIrYTV0ck1DcVVaVmdBZlZIRnJTN1MrUldWTkR4MEwx?=
 =?utf-8?B?NitySjlOc0UxdHE4Zy9RTHhjRmNhVEFUdTFiMGJYU2J3aXhaZ3hRaTZMUXdN?=
 =?utf-8?B?RkZZK3Y1NEgvMnQ4TzJ4UGlHN2lWWkpRa3VKaG5VUlNhM3I5elBCdS9IMmQx?=
 =?utf-8?B?TEpQNXZRY1NZQ0JYckJGV0x6d0pydnBxZUorM2pTcGFvQTRZcHMvaWZQcEs3?=
 =?utf-8?B?aVFLcXJzVDRoVjNTL0RCQ2tIaFBYWFNhL2RaSk42QWJZS09OZC8ybW9ndWRJ?=
 =?utf-8?B?ZnVpajZoTS9BQUlUTXBVay93Q2hxQmRKckpnMWdxeVZHNFpuVXBUczVqS3RD?=
 =?utf-8?B?b0NBMjF4UHc2d29pb1VzSEVNMlJJeHJsWHhOVU1icG5Ed1pEWHhoS2JNRnda?=
 =?utf-8?B?UHoxYjNRcExPWXVhcW5UdU1EeER0dWMvdEtkSDJMMDhjbk03SG5aWWU2YnBP?=
 =?utf-8?Q?5XgrDQVyEsY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFpjSUJVVGpzYldkeGNXc3NadCtOdEZHbEF5d1RjQmtKT1VSQ1ZQZVB6YUtU?=
 =?utf-8?B?ZUU2KzR3akZlbGpydlFvSUVxSE1ha3hwYnYwTE1UY1haMFM4SmtMb2tOdG1G?=
 =?utf-8?B?US9yVUNZcnVQMlRUbXdzaTBzcXdET3R0eHhhb2ZKckRqRkQ3ZTZqbzAvbGpm?=
 =?utf-8?B?VjBRZzlMYk5QVURJNGdab3lLZGJlcHVuRGRLQXBxYVR5cER1ejNIcjJFeW8y?=
 =?utf-8?B?NHNodzNnYmtEUUFEODF6VVBOSG5SRXVycEtXeFFlSmpnZHRHaC8zMlZlUHFu?=
 =?utf-8?B?YzUrWnhxODhwZFBQVnp1Q0UwSnNXR3hMbm1tNzhxUVNvV3RuVXM4cnNmV0pv?=
 =?utf-8?B?Wk92TVhkODJqSS9DenNwSHZuSk9iTEs5Wm9xQnp2OVJPbU83cHEvNjZWSU9Z?=
 =?utf-8?B?clROWkhac3VacVNwRnMrOTR0UHFVTTArOEVJRHd6NmJ0VlBTV1VvWXYwbURr?=
 =?utf-8?B?MXhFYzVENU02Vk1aa0lvcS96ZS9BbWlzdXRlUW82dlJWczErQy9uWHptZE5P?=
 =?utf-8?B?M3VuTFpHUkUzalFtQXVTOGVHYXV2RWV2aUh6ZVV2SGFMMmxQZVpiTG4xZjZP?=
 =?utf-8?B?S3R5ZVkvRXQyc2RCRjM0ZWZmZ2JwdjI2NTJ3MXc2QXIxeHRHMnNPUDZWb0pV?=
 =?utf-8?B?SHZzbnEveXJ2eHVFdzNGZjhqWDNOciszd0hjTlNOcU4zZ2JVeGR0Q3FQQWtL?=
 =?utf-8?B?M2c1UjlUMnVndFJGRjZWeXFvREZBQ2FaZW5tck9JRzgxMXZGdUlHbWhDTVVr?=
 =?utf-8?B?a09ESE9KN2RhMTJEYTdLMmE0NTNUQTBtTkkwL1gwcVQ1OC96dVY4VnVEM25V?=
 =?utf-8?B?SGRRbm9UemZQMHM5aTdQMFpLc012dkNsUDY5aFVKQlBTOFA3Q3V0OGtkTCtt?=
 =?utf-8?B?blllM1djT1FjakFSZVFrbWM5eG9malNhRFY3bEdiZmRCc2I3MC95ZFdmdmpQ?=
 =?utf-8?B?T1U1Y2JtdWY4WWJpSjNOUE11VFg4S0FtK0tzRXFXTk9NNWpIQmx4eWQ2M010?=
 =?utf-8?B?N1pRclJMR1A3MzEzUkYxaG1VK0hDbHYyUlhiOXpVUzVESzN3c0ZZOXNMc1VE?=
 =?utf-8?B?cUd0NGJub3lMWUp0enRmeDAxbFVWZ2cwSlJoSEg3NWtndVlOMTBuZGt6OHBi?=
 =?utf-8?B?VFNBSGc0OHJSVVpPbysrWjhSbGFxSFlJUUFDNytmZ1FGMXNaSThXS1JwRE1L?=
 =?utf-8?B?WnlWLzZGTXBINkRiaEhsOFVlRHYxNWlTMGJneUQwVFhHelI2Nm4xaHlFeVBM?=
 =?utf-8?B?NWRUMTZQOG5idW9BS3lIaXFPTHhtbWx1UktIMzh0VGgxL1dPdzV6OWNkREJ0?=
 =?utf-8?B?U0VrY1gvcEJVdzRQbFkvK1FRUTNyazNXQ3Uwek04MXUyb0gweEZ2VFZLam5w?=
 =?utf-8?B?VTBaYVI2dWxYbHZpN2VlWll4WjhkMjEvbmZwL0lKNlJxUHNVV1g2QVBjMWd1?=
 =?utf-8?B?Zks2bnlidkR1OHJBOUlWSk1Zak9SWnhRa3ZzdXdtY2lQbU1hY2xnTHZQV0hE?=
 =?utf-8?B?NVFRNHd5b2J2MjRvL01rRmtURTJMdXZRaVpmT2xockVjZCtqcG8zd0JkTE9r?=
 =?utf-8?B?dzhNankvNlNsYzk3SjljVkVqWUpYTi90VXpZRSt4MVZxb0dKb3BHS0diZUJY?=
 =?utf-8?B?MnVPeFBuRWJpQnJJbGRLbmhpbHloYjhUajVGbTZmVjZ4UXRwRXBKNGVJYjlw?=
 =?utf-8?B?VnBDOEN3L2hXVXRUSnp2dDJ3YkxmSk5TdGJvN0hvYnBXTDFUTThXRnVQVE9v?=
 =?utf-8?B?enN4cVMrY0xuWkpmKzNJL09UU21JQUs2c2hYWjJCMnVxeFJQWjJnVEM5T09r?=
 =?utf-8?B?c1Z0NlNYVjB0U1JsMDBLLzM2L3FmTWxpNllrM3k2V2ZNdTE2RUw1VXZ4YzZT?=
 =?utf-8?B?V0RlYVBIYlNSVVh5RVFkNHNRUG5zSHNXVnBMUmVxb2xKUjJjQkh4TUYwV3BP?=
 =?utf-8?B?V2hDT3FhZ0pwQWJDVkFVbC9IRXdNeGxrdjhONmdkVWJHZXBReDhHWENvV2E5?=
 =?utf-8?B?Q0ZzU0VLNGZFWnZKdE9qbm9xd1FjZlpqNGsxbWVraTJNSE5XVDR1RHNJeEJ3?=
 =?utf-8?B?S0YySzJMOEo2N2h3WUlDcWg0cmNJQjIrNEJGNmFhZExwdWU1TXJKY2g3SlA4?=
 =?utf-8?B?YVJ4U3dpZnl1bnhRN0lUUEJqd0hJL1lDTkVuaXBuYjMyMGttYmlFV0ZocEsw?=
 =?utf-8?B?M2FIYW9zNk5kbjZSTmNqcFNvTUp1Tll2R1RJMllyVm1adm01MkwwU1ZYRzVV?=
 =?utf-8?B?SkhKQU1wVmVDN3VnWjMwNnpBSU1nPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8198f342-2bc5-4114-9a35-08ddbf8f4fc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:59.6539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4GpX7fu24THLgUHe6PQ1Orn5tBQFTjPcnj+ukOM+0bM/21P7/Rec9hTQVy1K0EOUsR6A5HfGIlnYLgvQxt3Ha/VhYaL/23+puf4uJLgJVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Proofpoint-ORIG-GUID: 6ek0-VumRybRkUyrem4dqog8tIlovS87
X-Authority-Analysis: v=2.4 cv=ccXSrmDM c=1 sm=1 tr=0 ts=686f7fa9 cx=c_pps
 a=gsriAIW9IgONcNjeu7BG8g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=m4-MuDShih0a2sssyXkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6ek0-VumRybRkUyrem4dqog8tIlovS87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfXyg97jzyLMyUY
 sShml2hzLMjcbpGhVwwL2aTDxrl+ed8ilcVSbrTOhTy8cIbEHSUUTawS6fRtV/51f0M1MTJnAFy
 O4+eniLJJJeRJLoTbgr27chVA5QsuGOsjp2GINLjoP/ltJm5qYebqCaPKU3I6xNijb1i4D0WpHZ
 4TBrjnjJj3JSv16x5DBwCYu5sXgYheZlxYYe73SDM132A/q2cctA5zfeRri1ELKFJULFqKqOujD
 fMFNEYMufr3SQ/Ykgh4lwrEKfqHkZHBE12UztMKm/soQkFWTCoZz1ZDdc6noaj4sxCf9osXKo+m
 c80IwRwjjRWvIqE2cCeIWGXe6dHTtu6gNtqO7/s9fU5FnlgaGVmiOlhT+tV/JCrYq96v8mMAKed
 YtFD1IEpQnOM8YSdnyyD/q8Ic9rEbT5Z0CS8XeyrLMRTljmPu2SLUejKADqSkZLkJVJyjEUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

By definition PCI can never be enabled on an isapc machine so hardcode the PCIBus argument
of pc_nic_init() to NULL.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7b38e37d7b..70eaf5ed48 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -500,7 +500,7 @@ static void pc_init_isa(MachineState *machine)
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, NULL);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     for (i = 0; i < MAX_IDE_BUS; i++) {
-- 
2.43.0


