Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECBDC54E65
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWt-0003Oq-EM; Tue, 20 May 2025 11:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWr-0003Oc-On
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWp-0002iA-SI
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:17 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDvnuU022299;
 Tue, 20 May 2025 08:05:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWH
 H4=; b=kb/FeNoo1CcotQp57T0MvGvySwM+CqdA3EZTS+5Qz2g+Ke/egtV3o+l+F
 hPfksQsEXefwXf8zr0PdO/737j31MIkgD3/q7+Ff+uBIQHQePtoCg1F5nkyGp0Z5
 /ZtSokT1s5yafMDNkuofctEVuzexB8Mk66BP1z9bnUNwZvmZ7FiYuGD25wJaAwKB
 K3TepFupVxbZ1HFGvPNxIJDm9oJdewEjsYUYfWgGxFDxQaN19rVcA6uQzW5gjcP3
 OgYIT2JxL4H+jo8FUVGTGYGrWWJBM/wtFmRCroM8JgnQpeubqyRQblHEOe9mXQMz
 Ab5HUCGm1QvZ986ItavboMWeSxtUQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46r0e2ursv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUE98L2nt3H7jQdpiK+x8IGUoDj2CJSpOK4RbqbcEMHEULIStHB0TiMNVA6Wlky7rr2OSdOkkW0By81bAHjdnhkNg9XfS8nGioOFP0y0oAJcP17lvCL/3b14GxOxDCxdS6euqe81BLcgiHoJNtwvgnhcSViTptBeR/ClMEA4A7K11D/l4rlFcQxf3riIsu0tmqZwEqd0ZtGywd31K8d7PGPGM0xk6r2f38ophxIkuLbBew5IYJaE8zHUAS8+vjfivwOiuRWzrVEXG7ND0dS+x0j1Rld6/hzBFJrFEH7QcheauGUByYQ0B+hckS/Vz/KCHeKtL8UTO0OOWPx0yKF6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWHH4=;
 b=moAqZTMswJ/O7Q2a9Jvs4p0SyjcWWly8E+OANqFyve4/eSaiXiesHq0BN5rYiC4UKoUfSeHqjek7yxWSmPgz6EDm0dNUxF+dmT9M21JCRwN/QAn9i3zfY6OZqJBvkLJ8KlobkpdB12NYzlG4/m0tb+ppjxYMWUGEkWzzmEnD4lXtbTjimd8ApgFwZj2asVBTwOCOhgxQG/NVvPK8vhG9yrt7gwmNkX5PUdfsIEzP4Lzy/jVN/gy2ZoF9AiaVfpluE3BVI2KfeyBnuOxytYl/OC5YCXrYx0wFbEeJNVi9yDj0jXVZK+XIIhMemScyO3OQvvXThqaZMiPYKzQ4kO8nPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxCsFErulNbPOxCKbF3UavilB4wcwM+IwtZ/BHwWHH4=;
 b=yBW9R0uWxIHkvM2NDVr+sEQVW8i7yg1opq06lYcex5cncMIoDzlglEi5Xe9bhcCjTSIPtzQnlEg5vPFW/NcPdgchTTRro9/txCbBdGpu5bPJJh8/gb8c5eqXCRhBAj5y5+geMeIi6mAVYKPPgWU+t5BfpOw3N/BlmJfA6tesMgyv2DQhRWoK4oLKfBDNv9SlmhJP5OWM0ral4EfZYF9AoieprRRdVausvlkjMb2RPZjCRKWtWwaS4aupyMLLqcYY73+niNs2gBGiEzVpwroaXytO8cW5IRpMGYHUjXKNqz0+4ss3EgXINs06GcnMOpALZPEplr+lUUUZilkaeQeZHQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:10 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:10 +0000
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
Subject: [PATCH v2 18/29] vfio-user: implement VFIO_USER_REGION_READ/WRITE
Date: Tue, 20 May 2025 16:04:07 +0100
Message-ID: <20250520150419.2172078-19-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77cf9e9a-3ad0-4225-555d-08dd97afb6e8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KIVH+t9PCcuFH3zjmY4ssmpW0G4Tgqej8ckeDNc8g9Ok9/uoYWkg8uP3LBbs?=
 =?us-ascii?Q?RKi6kWJMLEmr2N4NvKO8zzhKE2FydrhQLqi7sjSsd5++Atf3/P5WPqRvjxcD?=
 =?us-ascii?Q?ncvWiXkyOn5r8c+XbwQeWJDQPP4vDBbw5CFR3KVB3yBfxtV9A/mewO5xT8kL?=
 =?us-ascii?Q?c2Tn5YG4dYEtlM7qUqHzMRTTryWWG2Zpta5CS+dBkiHz8hc9WFtxlTma3jNf?=
 =?us-ascii?Q?Va85MdNBwuUW7Q8M+dHBdkY2JFZA2NkvOwi+RuO8KENLLsx6K/mclUOXzQ5u?=
 =?us-ascii?Q?b4L9/AcV6CPMAYdiZlktbOzZSIwuofQvXK/CHTgZ0pSnHpx5Rq4UloOvzeRf?=
 =?us-ascii?Q?++CLXsRsU6+ISuEgNDuhEWh7yIKxQLhqnuKVSMY5sgrRkEqA470vKoyB50Mn?=
 =?us-ascii?Q?TKmu84PBwcJ4fIpqAU3JQO43BpFb356ex8XqoVhHDJWDRqNXptqdjwuYd47K?=
 =?us-ascii?Q?jmGXf2Do6QKXpKF7+JpWLABv6eOBSy1vdDRyBdK0UdNStqEqqIpl4m/yU3lm?=
 =?us-ascii?Q?olkNVruEOgHfNDke3TDwGFoKiWQ3fFHKrkxPDBmJCqdmML6AFT2NCG2KwN2j?=
 =?us-ascii?Q?29BV/f1IktGsXVvzVuM5b+OQ21V+ujpz4Ii94hqCcm8Cqo6LY3JZz/N+BkEX?=
 =?us-ascii?Q?2i9HobJa7rgmCeXGbiY+FXLLyztAhHlMw49m+T0wWHqNcadcIEj2URBy+sJM?=
 =?us-ascii?Q?Kjj6x7Cdp8swymiSDnDrNjSe9bqDBMIe08I02UIH7NtsqW2W9R4dNZCDYAjh?=
 =?us-ascii?Q?08b7iv+DRQ26+k3sWjm4Xqf076oGsbHz3qwPxZXSBjFXygaPLSUeLt/I6/D2?=
 =?us-ascii?Q?I7+THFdbv1ZVd0rXjqn8Vwrg2YvRBYCgtIIiRqJfR2UIL9x8TTRAzaMO+ntc?=
 =?us-ascii?Q?Jq9hPGaoizy+7C6Y6R4F0JzWci5H0rNVAmcv3dyZuprsQKskbjvs2FhKhtpX?=
 =?us-ascii?Q?gbhxgVpozkgMjRbjIzCAGaIeRpSq7SF040JFaUEzrxufvumdm8XgLoemhYwA?=
 =?us-ascii?Q?1o5x+TuKO0vuXrqatj7C+DzKeM8I7DJrDLcUUNMeybxicg0i4hxrlLS1g4V6?=
 =?us-ascii?Q?n6S1PmANJVEttWY93b3HBzXciy5gS+ToPhICZ9XZQHhXoHdFINlc6tJyuUhF?=
 =?us-ascii?Q?brptdiiDQs+CtO6K2zrGY9FlXS9GcWXHn2FSlUBhZyDWrEJAhT/cHzLF9LNN?=
 =?us-ascii?Q?o2rOEY5gwb/ZB1/VMTQ+ZIkmOu3mAbGi7Ys1d/C8WmQrKaknlhoSfh/BOouU?=
 =?us-ascii?Q?azVgz8lJFjdbFbXpOHJKqdHFZjYIP6nB+Zjo5FNtPSRTgBxPFFE386SV/hmN?=
 =?us-ascii?Q?1bVYrGs2foEgiBJaPLt1xQDfoMAPpNiMaThK9ULDXGhdSscyb4jg36zmB7Z1?=
 =?us-ascii?Q?Vy0d59l/9AzUCX6kNqt8a2hzJ5OIQ21dQfVlqdzVqnnLhDVUDcgGn9N3cUe6?=
 =?us-ascii?Q?2wsGE6xMwRw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bR7r/o3znMrjTVJMF7lJ9m2p1QZ+ps9Qx8NPN2q9fZEAbcic3VOWTM2uARLU?=
 =?us-ascii?Q?fn5/2cFZI/2wef66JG5qQ8vj5IJsFxlzM7zLH42ElhTmGhczL1yAMG4Vz2e7?=
 =?us-ascii?Q?oyVo3AvW5mxY3xjcbD9HPrzrPA6ejBhc+rqtb9jNSJW0SaC8sa7yG4PSMNvk?=
 =?us-ascii?Q?HB+xxCbr5fyGoZQAw1QTmVpjAbiEdlsueiGBqP/QEPsX0SsphBcvN6TN4njf?=
 =?us-ascii?Q?ORP2diKoNatlMtgqTqMfEvjpGmlabtkWeMJd1OUp4sED6YnR/E/PjwJVA1wc?=
 =?us-ascii?Q?k1dDjkxFS4ISwltekyAGTjVxp/04uQZec+XPfYbmNdG/j8gj3HKzJ6rMTU4n?=
 =?us-ascii?Q?GFYJ5rzFIB/7uhbaQdrZfUJWt4jeXYs5fd0aZK7gLEQxgyEB1Vl/TySsYwfm?=
 =?us-ascii?Q?q66v2PxUS60Ggbno7FSwSwmPFmschzqiwmAwBdctrIjdpDLCDzm4TeRSPXwv?=
 =?us-ascii?Q?SY5QPYo3CsBfObJre39kkpeNWs5Z7RHIF8k4PojoR0+yf1zN/N7GsGkURDte?=
 =?us-ascii?Q?Ivo01x7t2Op2zsMqW/e9ouYLHPTOaezhS8wk0nDilDLURejlxYrqJBDp8LNA?=
 =?us-ascii?Q?CPYt0etGwsQdKZ1x1fC3GIax4pY4PlubeTGVJqm9JmGETVsxtDujtpvhxrfl?=
 =?us-ascii?Q?Poqg8HGcCrxOFdcrip/sCMokXHsyCEZVeo46eOQgHmhLJW3CLcHBSNanIlsC?=
 =?us-ascii?Q?t6N50COUFcrz2jlWZl0ytZQtPYXoYwac7LkxjGAaBoAfU99oMDKY8RzZr7Hr?=
 =?us-ascii?Q?5WYjWqkyqowRrKmzjkB+2exLvu/DMnf8JVi9CeQK4KucoXhtKt1C6d3p7DOU?=
 =?us-ascii?Q?iPWqm/euN2j/bT+WKj3+fd6QDyYpVZ2ZZF/NDfFC4mp3SP6bOAUPsQLGScbz?=
 =?us-ascii?Q?TYb54PlI42WQsEKT6KnaR/p+QxbUiJj5v0rk5Xi8H6/VjJE16to+i+EGUm7u?=
 =?us-ascii?Q?vbjR6zvXiRwG6Q4Gu/a0+vHQerLGRZVP0Drm1k6MXQbA24V2xf7+DFAekiEx?=
 =?us-ascii?Q?cHtcJHT2bAbYyPaX9rbV4rGDzH65wwbZ41Bj9yzD216EpuaHQX1nUHBNugAR?=
 =?us-ascii?Q?PGeA+wRwZejoy6po87wyToRo9M6HjobE594uqMoPzGqg4UYRhmg4SzXKDb09?=
 =?us-ascii?Q?bQDYx0CIGHoa7AldbL6/lUH2xKpi3w7F9gS//Q0y7SxN5jbnQWs6DmDQ03RZ?=
 =?us-ascii?Q?IiL/TcnBcSG5n5Tk0z71npaMqTK8CrEYCH7m82n+Yg08HO5lvTntnDSB6er7?=
 =?us-ascii?Q?wReDX40cm9Y6GvEwVitqAXM66QOU70qWav4oXgRmvsxmMeXFgVEvEDR+S7z5?=
 =?us-ascii?Q?ned/85os0fbjQo3iXpp2CNQeHv5Ymm4Q7MDsRuHSzzp889ke0kD6ws7ugNhJ?=
 =?us-ascii?Q?Fb6jgymcuyQZB/cQqmKP0V0Qb0SQqjj1Qcu874OMBkL6ZeWKRP1i0ENqch4r?=
 =?us-ascii?Q?WvFrqhTX+33vJd4rzWwbNqOgA77opO63qto0+sMqZvHMLyiMp9rRI+pKKpPF?=
 =?us-ascii?Q?xUg6iYO314YCMKakPkq8Q/w+kCUpCt1ehqPLjK18qhBOWfVlHXUywHs49Nr2?=
 =?us-ascii?Q?Wrtp72qukU6QIAr8HHsVW+SJK25i2BpYXKuozxM+?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cf9e9a-3ad0-4225-555d-08dd97afb6e8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:10.1560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leI4muhZehWUV5N421VsvwG36RE2mNWAiVHPRf3jjlqcpxv/9wODXZTkK9jxcPF+suyrRVm2iNdV6CKSobeRrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-ORIG-GUID: HGij1N11dFG6mgs2LBdvOzzUiyju557Q
X-Authority-Analysis: v=2.4 cv=deyA3WXe c=1 sm=1 tr=0 ts=682c9a2a cx=c_pps
 a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=lEmlVuBv_BsZ2DPd9E8A:9
X-Proofpoint-GUID: HGij1N11dFG6mgs2LBdvOzzUiyju557Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX73ymiUdL7l9n
 qeqw78yvjKkIaTICIfeeldjeN372uM3g8d2hHm4+uYf0gybzPoe6N6Ng2Awl5G0jmAg/oS/XJX8
 QaYlQWt4BUPIGbpMcII0XVfT5GHSKoucoxokwHOGLzczSQnOkYQwaUkdalRexZ9GK86oweB1wtu
 2+N8buXldlQKN0tpBVNi4b/Yv+pviAh9GLk6V+5UKHsdU3J9qtRpnfCafb98LPw1PCvgQOefrYc
 2s7nACEwdkd0pA/G6jKYdxQevgKUGfyZeThXlIi8MG9a4f713nfSaArMrZGCslFlqXkm2zp2BFi
 cVX9UbPB9CGHEyb4/xyPcTVsJiuUva2lGBmzksG/o4I/qYKNjZ/lEeFiDrpgiNqrLsOOxhOSfRX
 mv9e9uOewrf+9LDkXouNrIdSQEpc8IpjOve/cXVdBuVk3xg8FL1Ot1g/69lhoWRAzO58HcLz
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

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 12 +++++++
 hw/vfio-user/device.c     | 67 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |  1 +
 3 files changed, 80 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 1878d44c51..8e6ccbe9e8 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -141,4 +141,16 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_REGION_READ
+ * VFIO_USER_REGION_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t region;
+    uint32_t count;
+    char data[];
+} VFIOUserRegionRW;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 57793e6b2b..a767e4fb01 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -110,9 +110,76 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                           off_t off, uint32_t count,
+                                           void *data)
+{
+    g_autofree VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_READ, sizeof(*msgp), 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    } else if (msgp->count > count) {
+        return -E2BIG;
+    } else {
+        memcpy(data, &msgp->data, msgp->count);
+    }
+
+    return msgp->count;
+}
+
+static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                            off_t off, unsigned count,
+                                            void *data, bool post)
+{
+    VFIOUserRegionRW *msgp = NULL;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    int size = sizeof(*msgp) + count;
+    int ret;
+
+    if (count > proxy->max_xfer_size) {
+        return -EINVAL;
+    }
+
+    msgp = g_malloc0(size);
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_REGION_WRITE, size, 0);
+    msgp->offset = off;
+    msgp->region = index;
+    msgp->count = count;
+    memcpy(&msgp->data, data, count);
+    trace_vfio_user_region_rw(msgp->region, msgp->offset, msgp->count);
+
+    /* Ignore post: all writes are synchronous/non-posted. */
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        ret = -msgp->hdr.error_reply;
+    } else {
+        ret = count;
+    }
+
+    g_free(msgp);
+    return ret;
+}
+
 /*
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .region_read = vfio_user_device_io_region_read,
+    .region_write = vfio_user_device_io_region_write,
+
 };
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 1860430301..3f5aebe7ac 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -8,3 +8,4 @@ vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
-- 
2.43.0


