Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21E0C83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 12:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubeKW-0004gp-M5; Tue, 15 Jul 2025 08:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKR-0004dV-8B
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubeKK-0005ke-0q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:00:10 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8DDiO014462;
 Tue, 15 Jul 2025 05:00:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=f+3MK4asVpbLd
 dkRg3JSgZ0oEUXxWx7w9eK69eEotds=; b=MMOY/uGbkg35RBvGGhvgUlx0Sa6ft
 98gcclYeXmmPNBHubIu0/nL2f1Bpqc1njyOZ0SYWdPlgf4CtmG1lHHpg01KNmuMU
 09x2kMYecTVPGI/HBQ6T8F/nqaZ++EeBsVGjUj5XQBkih7OKxejzCJjQZF3lvS6M
 /Jyv6T/5wwGuA9JGxNooJy6e+SjdLhAMkhbf5+WX/DAd0M8mQtnYlk16nqQAelu3
 6j2B/HFyPBgDeSZ3VDbHInphLBvLZ1xJp13UqZD0t9TU++/746fXtElFmIBiMXsZ
 Sl3lfLW+8ujEvuYs7bA6nFTjcoYhtUW5LWrrKR8OXg+ZJX5U6CNa9Xmew==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2090.outbound.protection.outlook.com [40.107.95.90])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47un8fe9q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 05:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMzGmO1aK/F7wAylqzEylqJliBSrycWt1tHt2ZVLrANVxXJpLnsm7JUefFAgoRlmOz5dN6iyWKXMQwZsCnDGHItiauRV2H8dYYm3RMoCjOkOGgjU3f08S0ROtNPAma8pq/Vyorul6eRaFSMhDRSKv9w+5Av/7ibiOVG1B4Ixx5RHyLHLz84T1S01NOCtOMzK6HzkHOyMi5VqAPPSruWZOhRYfd9VLESqnNA0x6U1yN4PiDD8KAF1hi5osjawi4VAgv9Gsjw9LicekdEttIrqaQW5iH1LHXBDQm9/H6CHWGfYGn2Pg+pFIQB4K4Qd0huioqpIMCyma7l9wZ8X3MyJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+3MK4asVpbLddkRg3JSgZ0oEUXxWx7w9eK69eEotds=;
 b=IDf90ZZx+Ma24Cd7Jbh/eCQ272iEL8b4vaQ1X063dmqd+gzZLK2bG4yhpFbOA1yq0FP3ASlwcMQlMvNX9WTbuerqzEhcyG9E7DznGq+6bVAA1SwFTqz3ZyB0V19GkSvIV7sVVWOZp580XfOPD7Tot+eOC/D4QhoJAcP949DVTZH1z9CYqKQw5nUSA7ttEojEMnnYeVAi7Ja1IRqZbsrWRMa8746yymk+PLvBImaiBdIO8PUOilHCNNBnegS+kj1UpV1GoChp6LxabBjkyMtIJj6L0TZaymsajuVereCypl4zztIYLyUTC2JqyJlIN3TtSujpwLRBCMECEP7U5d+Skg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+3MK4asVpbLddkRg3JSgZ0oEUXxWx7w9eK69eEotds=;
 b=vyA2MTLb+9OyHVHDRERV0HXSOTTt2ErQRE2QweHlfcqix6U5I+Mi2nhYOeUvWICGSBoRFvuRMbvG3JvfwdiJIc9sAI3EIDugoQWC0a6hcIV8h8bu20XY1x67yzfD4iZmu4bDAoz/QM5aDRAEl3ANln+M8LVrVnC3oTrzo38JiG1+XXU573/12CoY8MsfiX/V2I1HwUJ8ygyZT7lHekwT6CpeCUwbmUvKjBuilg8lnB4okHeZ6ZMehgL6SU/j2icTBuPdrUrnCgGuVnaDbMARIikww1qwx5XPKbGZGW67nTag+Wc3JbggKW3Uer1+i22yWtPFIMQWvITF4aLcdIXd1A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10710.namprd02.prod.outlook.com (2603:10b6:8:1fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 15 Jul
 2025 11:59:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 11:59:58 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 0/4] vfio-user fixes
Date: Tue, 15 Jul 2025 13:59:50 +0200
Message-ID: <20250715115954.515819-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: da0de33c-faad-4e38-af0f-08ddc3971eb4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3RlYzlvaU45blVmU3ZNMWpIWlplQUpubmk2Tk44Ym5IeFM4eWU4ZkRMYkdV?=
 =?utf-8?B?U2J4T2FyMFMzV3ZyQmZGWnlGbVhCUEtLOCtaVStoa1pTcHB4SHNVSEN2RzJ5?=
 =?utf-8?B?MXRVQVM0NFBBdXRaR215WlhtWEhtbnVkZGU4NTc4SDlUcU1ITmx0QzFGb3Vh?=
 =?utf-8?B?VjF5TGY5Yk9UbmtHaXRCVGhFT3k3ajAwd1FZRlB0VCtRVGtsVUM0aCtjQ1JO?=
 =?utf-8?B?YzRFNzh6SStnUmRoUEFyd2hEUXp0a1NwZW9yRzVaUXovbUZxSDBQSzlwOVo4?=
 =?utf-8?B?N1I4ZTdGb2tRaDFXYzB0U1cxaDR5UksyMlBNYXhvOTQvSnJLazlqcVhoQ0Jh?=
 =?utf-8?B?M095UGNVcVRQNkx6TnVqczkvYStNSEI3MlFYOHVZM04zL25mNTV0b0RJT2ZF?=
 =?utf-8?B?VlM0bjRFajdRTFU1a1BwdUV6Q2F0QmNaS1JzVCtteWhaTlVJQUgrZW9IeDhq?=
 =?utf-8?B?aFVTNTZQRzJQY2JQbk5PT3ozdXRIbEw0SWd0YWd1dkJiSG14cVZKUEdiM3Ry?=
 =?utf-8?B?bWFsRVJHRXVIU3VZenk3R1BBRkIySjZwK0RCZUFsYldXdmZHKytZbldaTThD?=
 =?utf-8?B?UTVLMmdoeTlPMXRSR0RRa05qclNnTzVBL3hCbG9IQ0JHWXVQM1VlSEJVOTQx?=
 =?utf-8?B?LzFkZjVDbU92ZDE4V0p1dDlYRHlITHplK1h4RkN6dUhCYXZoU2dkWk5iUEEy?=
 =?utf-8?B?eGgrOEN5TXBYV1VSVXU4UWw5NkJLUVMzQ2VITUlITGZ6Q1pXMmV3b3hYc016?=
 =?utf-8?B?SkNlZXRLWktMUFVQMVROZjVua2J6N2NwWmtMSDNhVngydmxYRE5TbGdlYStS?=
 =?utf-8?B?b2YwU0tTbTBFZEhCZkVFN1V1Q0haSE9PcVViV2NkMWs4SUlQaGF3R1czYmcr?=
 =?utf-8?B?UkhBYjJiREdnU1JvMDNHL2RpdnRRYUlXZ2ZIb0l5ZHFNakpnWDRBODNML29a?=
 =?utf-8?B?WlVFdlRRSk5JdUlCWnJScDhlekllMEpaM2poTDFGOW5DTzExY3Exa09lclFo?=
 =?utf-8?B?M0VNUVhpdGx5RllveHdFZ2ltSnhnd29US3J0ZHNWT1dPMWgzdjc5ZnFzeXFj?=
 =?utf-8?B?ei9HVjQ5eHZkaXpjUXVDZVdvOGZoL2tnay9Kck9GS1lhRlpmZGp1Nm5meXdS?=
 =?utf-8?B?Y3lIdzB0SzlBd1FZU1pNR1JCVGZsRndJNUxHR0JncU1QS2NIbmcxaTc3M1l3?=
 =?utf-8?B?S2tkZ2M5MlArb2VjL2N6NlRpaXlzRzVrelQzYU0rbE0zTkk1czJvMFJwUUVx?=
 =?utf-8?B?aW5kM3E4cG5SRnMzT2pRYVpzaVprWnFOa0dPaER1bzBwbW9PZFFCRE5uTDBJ?=
 =?utf-8?B?aFlPNDlsRGQxcUdveC9oSW5LSkhKQkh0RzdaOHBBL2tDbjY3QnZld0M0MG9i?=
 =?utf-8?B?WXRPRXFnUlIvVUpnVGlKekV1YW1maTFQMEFHa2dMd0pibFAwZ2ViclFWbFFl?=
 =?utf-8?B?TkdRYVRvL2xac2xkVlc0cU9CSHlXSjV2SHZ4V2pSRG9OeTBtT0Y0a2djelgx?=
 =?utf-8?B?K014bXBlWEJ5QzNDNndnNmE1UjBqWisyUEVQQzlmSUlIdERVbVFYZWN6dUFL?=
 =?utf-8?B?L2thOURHNmF5V2JYeW96bEl1c2JmTm11SEtXdmNQNVBEaXZQdW5aekg0VndJ?=
 =?utf-8?B?VGNyWnRVZW9SKzRRcENZS09LOHhSQXB3Q09XNTZKRTA1V05kOXNvVGFHc3VT?=
 =?utf-8?B?MHExUG50QTlVK0VBaDZmTEMxK25sUTk4UVNzN0pZRm9tejNXeWdSQzJMUTRr?=
 =?utf-8?B?eHErRnRYRy95UEsyeXNCQXFYclBlVHVKS3RWNSs1Z01tcEsrSkRnRmxtb2dz?=
 =?utf-8?B?WEJOMDBjM1djOHJjbTRaYjk4YjB2ZW41RzJSa0c2TVViemNtaFJJdnZsRjJt?=
 =?utf-8?B?d0xOVVZLR1VtNzRnOWZ6TXRtb01YalBkZTcvNERLZjlUQjB2VDIrOW9Idkg2?=
 =?utf-8?Q?8HwrWvFv65k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1MUUVoK3hEcklWYlZ3SjBpM3BMS1JEUSt4VnJNM2tTN3R0akJveE1VUVZW?=
 =?utf-8?B?SWVJTlhSSkJLL1NJNjNKeC9SckRPRE8yTFV1MHFuVE9WQi9rU0hKK2NEeTRJ?=
 =?utf-8?B?U0U3VnJwY01CaDlnRy9leThYSThWN1gzeTE0ZHh6MVNqWlNoTFVBbllkUith?=
 =?utf-8?B?eGtFNlZaY3B0MnkwZ2NLZG5nREYzbUY0QXMvZm44WDkxSVBJVkdVN2JteGVB?=
 =?utf-8?B?d2VBY1cvNlFQbEJtdllwdHIxN3hMZDR0aDN4R2U4VEgySFg4bTgzc2JqMUhI?=
 =?utf-8?B?MklLSUtBaWkvL1U5SEl6dHBFOWZzVVZ3OWtVVGVXWDV5dlo1VDhrL3pEcjFs?=
 =?utf-8?B?YnZLWjhZUkt6SWZlYlFYTHJjTnl6NnRqcWk1VmlGeEdlNDFiRzFFYzhQalVW?=
 =?utf-8?B?MW4vU1JIdmwxb2dqeWZpQ3owbEdQdy9sWmtCMWhkNDg4R3YzRjlQRjlHMllU?=
 =?utf-8?B?ZUl2VUoreXlTekt6TTQzRjBuZHlkM05pSW9KYWFnMXQzUzdqRHBEdnQxeU5r?=
 =?utf-8?B?Tm1CODcxTkp5d0h6Yk4xdzkxZTYwNnowUEVGbDQwNzJUS09SSXFkODNEUlYy?=
 =?utf-8?B?dHRNdVRvekdtL1B6dk5hZjFHWkNpaHNTQ3pLMHZnSCtoejZaQm9pQ0o5L3dX?=
 =?utf-8?B?ZmR4T0dWV1owZWRsK1VRSmZzWjBmR2ViUWtMbkZJKy92OUd2MlFuQzMxMWNj?=
 =?utf-8?B?OVYxZXVRVHpKR2d1TWRFYkwwa2Z6RzZTYWM3NmRTMmpzVERDZU50djFaZWdR?=
 =?utf-8?B?elZQWmJUN0NSLzRibmk5YkQxTEFnUHZJRm96ME9HZUt2emE1Y09MZHIyY0Fv?=
 =?utf-8?B?Rkk1U044K1NyblJvb3g0N2NTeTRYbXZ2UlFkU3NHZmQ4bU5TSlVOMk96cXBn?=
 =?utf-8?B?VHArVjVaY0lzaVhrMUJ2OHZ3Y1pxaTZvRGhxZEExWHByK3l4c09nYzIvZ0Yw?=
 =?utf-8?B?Vk9WR1RCbDZzNmlmenMyMGl3K1BsQUVQTFZhclQ2MDBqckpTYllzcTgzWFhM?=
 =?utf-8?B?N2EzSmpVSW5ROUxCc3B6UUkwTWpwM3A3MHBIZXNJaDBOREJ4dWZpZkhBZGxo?=
 =?utf-8?B?TmdKbXUvRndFSXZPN05PbUYwRUphbmNxbzJremR3ZXN3RXhnaFdPa1pxREcv?=
 =?utf-8?B?eFJzZUh5bVpjSloxN1ZQZGgvekJnNHkrS2s3ZUR6RlFrblh4R1c4VjJzazkr?=
 =?utf-8?B?RGNtUEw0TVNwd3BjUUM0MjJxdmI3N2xxbTdZUUM5NEt5YUo3dFRHaFBaSFZF?=
 =?utf-8?B?U3pWWnJ2TmZ4cjd6UnU2NjBXcWVRcTdHQ3VRQy9LZ2pzamhsV2hiNDlrNTRx?=
 =?utf-8?B?eHQwbEl2OFg3MlNrRnpnaitPSklKT0VsOFFKYWxhMzNZR1liWFVab1FCMXhR?=
 =?utf-8?B?K0NLNFo2UklyRHVSdzExSlU5L3p5eFhJV3E4d3ZsWFRDaTd6WXplbXorWTg1?=
 =?utf-8?B?Tm5GK2RJOG44SEFYUDZMdFQzZmhodEFiTUdJVGJOSEEwdUhOMWd1aG5Cdkdu?=
 =?utf-8?B?bEZYNDNVbGNxbDNhVWc5WS9ybTdxZS8xUEtXV0VDcWpDcFpYVjVZZnc0Q1BU?=
 =?utf-8?B?SDYrVDVtMWFXNzR2ZE5nM2VGODNvNmFFc3JSM0lLQnRmQ2NhK3ZEaEVUWDJv?=
 =?utf-8?B?T0p0Z2tmZ0FIVHhKdW5yaXVFNFRDVzdhNVVudkpIRndTK0R1bm1yT3lEQU9t?=
 =?utf-8?B?SHB0UkZ2Q0E2SlhaSVJkN1piRS9NTEwrbldkNU1WTnNSQ0kzY21NTmVBaGoy?=
 =?utf-8?B?eVZuMFk2Z0IvYVNyK1lPcDl0Vzh4SFI2OVdxbkV1WmZtNWd4UnF2K1JzSWhP?=
 =?utf-8?B?MDlYTm9OTGhQdWo1UFVZYllFY1U5V2wrVlBmd2RWQ2l3WU1LOVJvSzlrY1ZM?=
 =?utf-8?B?T1Z3Y3daczlnVlRwN3hOYWI5bDFxZjZ1cmZ1aURUeldSclF0eHh3bWNueHVJ?=
 =?utf-8?B?Nk4ybWNGSUpxcWhCeXFDZGFOa0J1R0FHSjVNVHhNaUZPK1FURkFJTThlRkZx?=
 =?utf-8?B?NmRwT2xKa0VSemJuaXdzNU9MV1ZpaEdseEZSSGtLRVcwWVg4c0ZUb1NPNEtT?=
 =?utf-8?B?ZVhTRUliVkFuMFA1UmtGeGVNNnF5Qm00a0xvWHNYQWFHcE5RaEhhdVZrWWN5?=
 =?utf-8?B?dHNnOEpvVTFUSStiYjRUVkFycEI3RVlGeGVrYlNmek90STJ6bzlYVExHU3dX?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0de33c-faad-4e38-af0f-08ddc3971eb4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:59:58.2514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbOYM+CeAwIr9r5Fr3VSfyG1VLZ8RmqWypYtuhhXHHRowH4b4lc+Ioaamv/fWHryyCfA9amom+QuhW9FT9sPug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10710
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEwOSBTYWx0ZWRfX6bdFeX3LaOU+
 fFBdorgwDYBC2/FS2NAPpeeFQLr54Y4ze2SltELM8RpSYICVuLmPwtUcK9Gb/GUTLMkPj+KNSoS
 kT8IvUAX9m5D8exEKepPBBlAtYfk+6qBwybAb9rNjFiYnlexoXNnAGQ7t0GMflgVWlsTwLqyEKq
 Xt79YtSvfQg8ybyuuWBdwKwoKDFKjWedVzD+MhsL0AytpTXkS0EnQGK/fy3rADdPkVGbhL1CN+t
 B24FEWwqyOqnCyPXKABJY/JYkQdg0ujoDtbdpM2eizbOyV+6XT0yWq0vz6QLtsH60Gn13pj3uYz
 rekYLcfWd5aMS22mwnVDVJynBjz0c+6fOyYdl3MUrX1eoRnnT8+clZmAWYlreDCB+H2qRImv0rM
 wkPORlmJkyCofglamUcD3gHcrOAssbNiemXbvmByulObXTFH0MazZ6RoaSOUGQZmiBEm95Pt
X-Proofpoint-GUID: WEtWKGPpNhoxR8dBQbGGKXykWFUTX0EL
X-Proofpoint-ORIG-GUID: WEtWKGPpNhoxR8dBQbGGKXykWFUTX0EL
X-Authority-Analysis: v=2.4 cv=QpRe3Uyd c=1 sm=1 tr=0 ts=687642c0 cx=c_pps
 a=QU9TlMWntzO3MSUYNyn/cA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=ahWBuGF6cRnHq8EVzWgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Some small Coverity and related fixes for the recently merged vfio-user series.

thanks
john

John Levon (4):
  hw/vfio-user: add Cédric Le Goater as a maintainer
  hw/vfio: fix region fd initialization
  hw/vfio-user: wait for proxy close correctly
  hw/vfio-user: fix use of uninitialized variable

 MAINTAINERS              |  1 +
 hw/vfio-user/container.c |  6 +-----
 hw/vfio-user/proxy.c     | 10 ++++++----
 hw/vfio/device.c         |  6 +++++-
 4 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.43.0


