Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E094BC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWs-00064c-Jv; Fri, 11 Jul 2025 05:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWq-000619-Ja
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWo-0004q6-7w
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:52 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B2np2Y005261;
 Fri, 11 Jul 2025 02:58:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ShKUPlA/XJzEqFPtg+j2rtiHW62XO9UgBfyYcIjb6
 Ig=; b=q8izpIJbyT4GyLKxQij0YN/VZYbWY/DRF4MUDvKZnh2XAO3TXpk9qmkPE
 zcyzpCMVmExhz2B1VSG34eW5V6tXSX3L8f1LVTHqaAf/z9EI/6WSfYgmsPfHn1lF
 GF7wHPzsKwTvQ8J1aEo2gXy1HXbZWHrAA1JtSVEDTZYHLixR0P0EqHyZlvFo33nj
 sk19Tn1fB6Ikj9tpK4+URLBC9XTeYzqzXB8rejk8VSLzEQ1ow7HwvsTH3JaZ0TeF
 UV70R8hU6g8knqLmm6FvmRImy5wWnEYJ/7UY8sLjh2j+QdG5Bu73GohxsGdzqKDt
 TtawDCpA0VYaaNeookNLoswIEBV9Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022093.outbound.protection.outlook.com
 [40.107.200.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47rkc5v48f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua9XaP8bwT/lV/Cv75t4pTzost9x2wV2bctQZIiY92kPZEx1/x8vbSd7HDpltdY65TLta9PgqfnpdzdND8wJSH6Cju4gMRRQJ9oHi8LFw76XXWLtfv6zYKdLuy6x9aOkAWQK3KIWb+mdW5GE4hkFO+n1xOKVylcUy7q5bN36X7s+Q1tvs4jf+GDTFabeDo5xBqh47K2DwUZeYWJ7RiAYDZlyI7Rx2g0oAKhC4d1ARPnfs2fUNciwVZMtfMEzS4/G58kGyIIh89P7vCfd+UMBgceNJXXWcxc4PyfkrYtPH05UWiPrasPgSerp8uRZ5Du2DlDDW4FKESFQWkg3V5/ICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShKUPlA/XJzEqFPtg+j2rtiHW62XO9UgBfyYcIjb6Ig=;
 b=glz+QXXIwY5qE6nTcrSkxeoDhTa6kUrqo7aR1QXVXwV5ItWfYTs4R55RI/rJoSV9MaBbuJXSyssS5qWfPyD6NTQTF8lgvoIen04KMtH9yW7Wl9bAqQpJbvYYuo096FR6UTCafB1hUAEcAQ8SXkspZEorGHHDY1w/48TQvhdyk1QDoA1IPsEyyjMuHczsYTTjo42tNVCeBHZDp8e1Kx3S1/lKopYKU6p72P4uaA9oWMJk98NALzc2pZUxshcNZZgeSDgbz7Hff8ESB1L7GE03bjx4Z+iGiAHq/lo1Kvfp00A8k1i47Jbxbn1Od7RO5J1U7vO+wbGWf0QEP1GC3D9p2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShKUPlA/XJzEqFPtg+j2rtiHW62XO9UgBfyYcIjb6Ig=;
 b=NwEnrNEPxQGs008NmSTiv14vqzZWustqUC9pTEig/+6oXT4Jablk8IllfQUPgOatSqFoh0+byMO6xhSGgTW1Qk7HvFBSsGu85/EoLdZoOoMLAUs+tv2EGToDGyHlmZBanOzJJoCPfBks70o4VZ514+QKLxiSFVtLH/hONrRHjxzgNmx7cq5UVke4OELuWqm1Y/jvFZmiAEz90n2NLf3qLzbLYGNpn0D5KeoTmUc6M0yHC7Q5M49gPUJ+IiDcr49RsKcVSlLXlDg4lZvKOogBeoUBVr7m93vlkuuKd2145t1tlCAQ0NP/AnAX68gTaCjY2kK7vOs6kBF5rsG/sCUkSw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 08/19] hw/i386/pc_piix.c: remove nvdimm initialisation from
 pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:10 +0100
Message-ID: <20250711095812.543857-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 843f1bdb-600e-4ce1-b4da-08ddc0618641
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUtiMDZCN0FML0NSNEYvS29TQlFvalpESzBVWHhkTVpqUG5IZ1BhdTBuZDRQ?=
 =?utf-8?B?Z3JLYm1oRzltNDUwWDRtMFN4Q2poTGNoa29aRlBqS3RCSFR5NCtkRE1aSVoy?=
 =?utf-8?B?dE85MG1Ob2tMSmJLUE8ybzlsZVFyRXMrK0E3Nk5LTVAwQXM2RkZCYzM2c3Ay?=
 =?utf-8?B?RTFoS1FUNHA5OHI1V2NxNUkrYW90SlVsdG9uWVRHbUpBOGx0SG5ITWFvU3BK?=
 =?utf-8?B?RktZMFExVWp6NS9iSGRTNHhEYzI3RUhad1hoSGdPZFY5akdjL0pySGQ5TlJQ?=
 =?utf-8?B?bmxiai9iSGdGMjVDMXgyT0JaYjYrdXk2UmRoSTZNTjF1cmgvZTBlSXFNZzBN?=
 =?utf-8?B?OVQvSWJRYi9ySVFENSs5Y2dtNUJnVGV4L0hCSlh4WkZraGlQVEJBODFyT2Nm?=
 =?utf-8?B?WXRnbDRMRzltSkhsMGp1Y0dnVDFqSUQ1cmpsd0grL25aOEx0QUUvODYvTzAr?=
 =?utf-8?B?cElHQXRoRmJBMmFMMDRwWUF6N2c0ZVR6Y2MvRU85bHo3bVR4b3hzVllrWkRS?=
 =?utf-8?B?bEUxMURUbVJBR2RhWXhhZWtEb0ZyT3ZkZE00dzd2NjcweUp6V0VpdURXa3RC?=
 =?utf-8?B?NDBDNEdIWkZ5Z2F6WXNvY1liRW91WVJEMDlIZ2N4c3RwZWgwanIvWHFiUHBs?=
 =?utf-8?B?Q1VrK0x3Z2txbXRmWUtDN3pRWlV4cEJSQmN1b0lTVEdRR2xrWmphdDJweVVk?=
 =?utf-8?B?QjBNazIyOWM1U2FsdzNRWmVVdGg3cEIyaHJ0SDRpVkxiQXdHZWV1aERJQTB4?=
 =?utf-8?B?RWREM3lETE91cnc4QWs3cEVkZ3dBaDc5Zy8vT1hKNVRuR0gvZWJXMTdJSHl2?=
 =?utf-8?B?VkkvUnZkejFpZ3Ira0JkL2oxZUd0eEVHS1VXb2lvc01LR1NIcmc2R3pmblEr?=
 =?utf-8?B?TmdSRUNma3haSm5qQkQ3c3o2R1lsbEFKZURkQWlRR2ZsV0U3NG5qZjQyVkFt?=
 =?utf-8?B?WERiWnhRRVFBd002TUdKQ2tCVC9kNzRhZ3ZENitCZ1dkYXpHV044VHRuQ2lo?=
 =?utf-8?B?eURNZGlaQlk2TkVMWjVZclJCcjE1V2xlOXFBRkdJSmNFMlVzMTNvV28xWW85?=
 =?utf-8?B?QjgxbHJiZWh5UGNQOXdISkZhSFpDcU1EMEZFT09XcTB0eWVyeFZHemc2OFhB?=
 =?utf-8?B?MEpFV1J1SFdXYjU0UnBxZTVpWmpQU0gvUkpBRVJ6bUlwdWg3S3VsU3QwK0E1?=
 =?utf-8?B?dlpqUms5TGYvTW9iYnZ1d1UvZDh3dGo4QkU4T1FhRFB6UjRJOThOOE9CY2t1?=
 =?utf-8?B?L2RncDdVV2ZSdzQ4WnQzb3l4WlVnS1RtM21JQ3Nic2Ftb0l3MXZ6RzZzSTJ1?=
 =?utf-8?B?VHpCQ1RIT2RFOEtqSzhIR1NiZUxPWnVDeVZTWEhxQ1BOeWdvVDlBZk9GT3RW?=
 =?utf-8?B?eTNrV2dZeUxxcElrZENpNmhnQUljb1NoMzZPVzl6LzFDYWVlUVpjeUhyc3Nh?=
 =?utf-8?B?TVlXNHhPZXljMmwzUjRVempXRkRJOXY2YlVZbU5ZQ1lnSFA0eFJndGpVaHhs?=
 =?utf-8?B?WkdyeUJ3bXFXQzdWRUpxRUNYNGJ4WDFndkdlYXBwVWF1UU9taXpPaWpEeEc2?=
 =?utf-8?B?QmJqYU90Z3NtS1ZMZkVZaDk4a0N5WHhXUU1XRnUzSGlKb3AvOVp6bjJ1REJr?=
 =?utf-8?B?SmZ4cWF5bk1TZHRwTjY1UEVHN3lYVzI1Z2QwNDRPYWZjT0RrVlRERDd4UUh1?=
 =?utf-8?B?L0hLNGVmNzdsMFdtWGwxZklSUFJiU0JPdk1FNXJ2Rlo1RzhiaHViSWtHZS90?=
 =?utf-8?B?enNOMk9xVXdwK1lhS0dxWm1UbkI5TzlPSnlxaDc0NkFMY21Ha3JsaDdtWDlo?=
 =?utf-8?B?Uy9iR0FDMTI3aDdBOUtzVGhDVC9VWG5INjFDNjVFN2xnUmJJVUNwOXVpY3FY?=
 =?utf-8?B?MGZ0SlJNZVkzalJwL2VGSDNMYnR0dlFzNWxKZ2NBbnRKQ3VDc3BtWklHNjVr?=
 =?utf-8?Q?QUxn9GATUkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THpjTXJNYkx1SE4rbWhFUVJYbi95WXV5T21PQ0dNd2RVUUxLSmlzVVQ3K3RS?=
 =?utf-8?B?VUd2V1BOaUlRZnB2bEorTHV6OWJieGVsc1JkdGgyNzFMZkd6dHd0czA0TGRX?=
 =?utf-8?B?NVE0MHRid1lWZ1o5VnFzcThzNkpjUWJjb3VVcTMzQS9NLzhSVWpHbEtINHVO?=
 =?utf-8?B?VlpCdVR3QlRzcEVDSmFBS0I2V2tlV1lBSCtObzFINDFOV0JaZDhTOW9hWlFa?=
 =?utf-8?B?TmF5bnkvMVBFODNYZUJoOVRMRlhwSnYwTUJJQ2lSRE5tZys1RkpNandDZVJX?=
 =?utf-8?B?SEMvK2p1NTlIdWxTNFR3cDVMRnhIRFJyOW8xTDJZSDE1MTZYZDZrQ1gxOGNG?=
 =?utf-8?B?bHZKeXFwaGh6MUtFd1BRSmQ2NllVK3c2YVh6citGdlA5TkFYNUEzWFRIcEEr?=
 =?utf-8?B?bmNhc1FvUDNNZUgzM1FrVWxDbTY2RVRoQUxZYVJGSVA4YUw0a1JFclRtNEZq?=
 =?utf-8?B?eGZmaklJazlCdnJHcklqa09DZ21xclRmT0V1Y3ZSeTNwR1JOdjZpNVhVM3FU?=
 =?utf-8?B?QjhtNUI5RDBlM2NTSUhsR2dLdThJMzdUNEFmby9ST05WbEwvUVZOTzFEVk9l?=
 =?utf-8?B?R2x4ZW1kYWZPK0p5MjhUTG94LzNEZ3pTVGk2K0tjMHVaMys5eTZ2QW5yOXI1?=
 =?utf-8?B?WjgvNEhQZ2xPcUFUT1JtYisvWU11cmJzOFNFc29neGRUZ1pPSjM3UEdYclFJ?=
 =?utf-8?B?d2NMR2tUQUZJaWNzUXpEZVJGWUFjanpYUGNNTUdNMnpWdE5MSmpIaVdTLzIr?=
 =?utf-8?B?OHZudjh1WmtSRXZJNkIrMG5qRCtsUlhKUytWSlAzUU5OTE1CZUlMcHR4S3hB?=
 =?utf-8?B?VnBWNWpweE1MTnlsenU1OW1nQVJrN290Zm53eWQ1L2FUZ0tPd0E1cmQrWVZt?=
 =?utf-8?B?dWhhRk9tMlV1cTZXUElGSGdsNmxxMmJQeWsrWlQzWC8ySVVNV1FBWmtzN0pP?=
 =?utf-8?B?UzBzazJBb095T1Fqa2Q0djBSQ2JXRmxmL2Qvd1h0bDlVZnI1K0tzS1VqcThV?=
 =?utf-8?B?dWJsQThoUEIrQm5rWHpDWEl0RGY4eDY3cGh0T29nTFVidDcxWWlKdzdzMCtz?=
 =?utf-8?B?RWFTZlc0QU1GSyt2U29jQUlXMkVxWTUraGZpekxCZzVlRWVycU5OckF4R3gz?=
 =?utf-8?B?MmVoQnl0eFpZMHZTZUx6RXZlbnl2cUV4bXphOUdLTnlvNFc0M1dhV1VGRlFx?=
 =?utf-8?B?a1k3WnBTcTJjWHU1MG0vYTRiSDNqdWQyWnhwOCtSZVdMMzQxTUliTWpBa3FT?=
 =?utf-8?B?a3pWbjVmQnZkaVNpb2xYRUxhK3RabTVKekhzNVV1TzdCVUpKbXF2S0tsK3dG?=
 =?utf-8?B?QkJGWmJkSXlSOVpvdDJoc01kamU1UkxwUHNMdjkzRkptMU4wdTM1SzRTOUxn?=
 =?utf-8?B?U1FOU1FaeStMSmorMHZIRXZaMENCTHVCVnlwbWxQZHkxWDdTWUN5RVd3NTZD?=
 =?utf-8?B?WUVZelFzUWlrSXd6NXJ6YUVUREl5YkRoazZDYjQ5MmpCcjcyQk5URDdxdGJC?=
 =?utf-8?B?ZTArdkJmcDFER3cxSS91Y0NkeXJRaUxEUWUwa3dPUFpqeExxcEZqQ3BpT3Vl?=
 =?utf-8?B?RlJMVHd0aFFxOFZlTXlDeTlRS0h4eUJYcTgzZHN1dHh3K3hxM244OEYzUEx1?=
 =?utf-8?B?SCswQW5Ic0YxNUlrY2dpQ1ZtYm1xUlY0aURmNzhlK2NESnRvRmxDNXlYVUhx?=
 =?utf-8?B?WjkzKzVNZzdjUW5WTWs0RC9MT2JiVWFadXl3WDVBYzBwdmxTL1p5MHNEWlRu?=
 =?utf-8?B?d3NjZFlscjZPZ1JIR21pY2t6cUZweHgxcWo0M1lPNzJJSmdwdVVWcDZkSTJa?=
 =?utf-8?B?c2VhVi8rYnJIcThQd1JvRHU1MGNZYUgraHNBeW5yaUVZMmRreFNBNk9kREdD?=
 =?utf-8?B?ZUc2UVdpWmhXUk5oQjJQSFJxTGpqaWl2UVkzZm9YSkdpTnJhdk1meEZIdDVD?=
 =?utf-8?B?ZDVsc2R3eko1SmlxRW9mcE11VjhyTGlIWU5tMWFZSktBdGVWTmh3a1NNTjA5?=
 =?utf-8?B?TnZWNllDcXhXQVQ1TmI0NmcrUk9kVXA0OFlraEoyOGF2OXdoanhSa1dMUUdT?=
 =?utf-8?B?SzJ4cXFrakxWOU9Ob01DSWZnTFNWTEFMd0liVlNZNURqTkZtMzQ5a25KaVlu?=
 =?utf-8?B?UWpSMGR5TDlMQ2tZNGdVUE1SbFR3Z2JRdTQ3K3NaOUdkOFZxMkRhRDh0eUdH?=
 =?utf-8?B?Tm1HUUt3dnVNWm1UU0NUQVBVOThGQ2JIaGxZOWRjYWpQaTdaK29qWmJXZXFC?=
 =?utf-8?B?SXFBVjhYWStJVGdhR2VRQ1lPUnp3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843f1bdb-600e-4ce1-b4da-08ddc0618641
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:45.4311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tj8qESD+ytJD5gmgKKIZ221h41pB9t1AHee1g9YxL7Spbfzy2GhuTgnNMB/JO9yMYYzbz1qiOSRu8QBICTOpRavkoxim9z/LXxKcCwlySzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Proofpoint-GUID: wWMGn-ciIR_yEZdSAuSpdG3ngJXhful1
X-Authority-Analysis: v=2.4 cv=EdbIQOmC c=1 sm=1 tr=0 ts=6870e057 cx=c_pps
 a=eRn1cRo1khMZ7TFbvRZV6Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XL6wrB0Zc_gxRR1ig4QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX7Vq8vpNRA4HZ
 bZyAz+FPCxN0LWfF/8l+PfNRNBeSxxsngaJDQRunW3e8LtANMlqn8N8bM/cVrxvT0qr5QQ/ouP/
 x+uQNs9b1hoo8ht5ncvpC9IkMp8zNXjq14ELrsrzvJwXXr1ne8I752bWZ6QSe4CHOErHI56P4fD
 lS/iQXuFrDuM1phvWv+j8tgy89e3eTEGBva41Yd8cZ4FzIffCWKEeftZTDBU6OcH3Pv05+/Jqnl
 ZJfAvWrr2PxIbM8swV17PZlchRJe6wxAVAFQezZRL1I4CsdV19zGZbJRggAJpQiuim2MepDHiq7
 YjET1LWI5L92IZQn3FefqGvFb212/jOPfv2uDlA0M21bocwiTJpmz4okM515dqSJEaa9bpyBkEb
 T5vcdo2rXzm1jUjyHH+07lx9gUdY3/87iBEMMRBoE7JqQGQ8lANvYVJxQEBVRiBnx6gVi2ZP
X-Proofpoint-ORIG-GUID: wWMGn-ciIR_yEZdSAuSpdG3ngJXhful1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
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

NVDIMMs cannot be used by PCs from a pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c49be1d799..78f50a7893 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -574,12 +574,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 #endif
-
-    if (machine->nvdimms_state->is_enabled) {
-        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               x86_nvdimm_acpi_dsmio,
-                               x86ms->fw_cfg, OBJECT(pcms));
-    }
 }
 #endif
 
-- 
2.43.0


