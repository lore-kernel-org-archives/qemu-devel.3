Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1BAC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8HdN-0008LA-8d; Fri, 25 Apr 2025 07:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdK-0008KC-Ak
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdG-0000O0-TQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:17 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PBGe3d002622;
 Fri, 25 Apr 2025 04:54:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8m3B9jIRTTcjpTS2XC4kRAqYoPgxy50lmvX3ocq8X
 b8=; b=d2I4X4RXOIZJs33bF+ccb2ouLhtSMmf0SvSIMpxoCPP2g6fLwJxkXWVDA
 8w3Tt1O7Vr/0Y0cuxlzrGwkLVtfXUX8oKZHiHJCbxCkC6eeXn0Pul+75stl5eq+X
 LF9sOAhomL91+IY86EMJnEaHtMhoae7Th4p8Xhr8uDAUfMPkfKcg/daMsz1RjCZA
 s1XFwVF3n0mLjQI/+u3oRVmmnPbEgt9bYddRjwv4obTpipOuQ3TnBnR10IeEVjaN
 wYty9LC2DVdBN6l9M4vpIejoS/6yV9BG8DF5KQFpN7aHgdAZOKYFyTTaqSdbLtx2
 jJPsmWXvUfRkpFjq0U36QowzN2ogw==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww49b1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ameDAQ9ddarV6bNYJXpFjYDP6j3gkDGK9kDz/ByM1/nW8ZkO73nyev6Wx0tkVCsvqsIfV5PU+yLBLsDPGwH1DWdw2r7ODR6weFN0SPLyPIv+uSEBWEuA1G8RbmjLJNm0LhBYNKNURaVTG9pIFMgEmCmYaSW+7cqUL/FrLe9uYijOQgntwkywzEP8fgB/x5YsX5wWJ4/vcD8m//XCBSx63WCmCxjTlGQ8qfdUv5czwBx0M7I89NoWhRkjZ337Syx+/zASCvgWcYjiWmyyecl02yRKxJV29StdVH52e9y+Pg8lDFTyt4xB+pgJXNW4hLSEo2R6Ykv6cwt112pRgs522Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m3B9jIRTTcjpTS2XC4kRAqYoPgxy50lmvX3ocq8Xb8=;
 b=qABO4SVfore/SrNWT5tzwh8gXzBuUzMkqUwjxIdgjLH+61+Wu+D4zhDrVp/knECtRA4v4J/v61Lm6pLoA3Y9ehgS21tuuoUAeME+kZugoEFH28VcvB5bXo4rygshFk/bSVfp4nc+iteoUcqk8n4HxnRdKn6NfTeXUQButzIX4LdnDaKUmPtZoI6CMevCQel/wonccDp5wA1QYvVJbsmKAvy5sJVRqS5M/qZPzYv9bS1ETQDfdcGAGW1ORaUj2Mv/CFNWjyGlJz8Aml2CuPVqLuBrd9L+/ZS97To1uM19NXa43jdskabdgMVc5gNpZSo6r6CJmReL4FtcCtLi8D7asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m3B9jIRTTcjpTS2XC4kRAqYoPgxy50lmvX3ocq8Xb8=;
 b=qKu/OO3rBZXqtFwWhpKFbOnWDxqoSrIq6yn1bEU1GuUzEIfTF3euoivAnFj3V9zC0beLGvx6MJCpii7Vuziqur10vfFM22I58fxGSIElSERndorsZ2xeN0pqriZA/8ZqzPZrBug0VXYv6mw6HTia7uP3OWgqaXWNmPqGCACvfSH+IYo+PJuZx0W/J0A9Pip3iDwYZZwJgtMUFdXRdv14IchHBmmBC5Stz6ua+ARR23nG72JAY6fHQX7izh0Xp9PWysaxIOQRgtaSYPpwj5C9E8V2Hln4mYYGs7Z7yb7lPwzADKVwikyZ+TqfEnyqio55cUB9Ienmj+OHfh5Yry8wvg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:10 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 02/12] hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent
 initialisation from pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:49 +0100
Message-ID: <20250425115401.59417-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::12) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e08e0a-6b4f-4e1c-f117-08dd83efe3cd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vijpbj4h3z5lRzf2xW3hqd9XRTcQWlt9IVnh3iNMoFDlNYRV7EOoDHPdkE0D?=
 =?us-ascii?Q?HEiaAOmWpmP1SHRR5cHenH56sFdddILdhIyMXdHlHAaVjUTno0m7nyG/LMvD?=
 =?us-ascii?Q?bzST4rvaOMJm+55zSyOSl+UCzQgh/FRJgGIvOCPhx93EcHyxAteJCeccrHsD?=
 =?us-ascii?Q?HfbrOa77tz9l1i8b0Mes3ywMngqCpVUjKthgQiJpULR+mdAInN8PuR+iu+fw?=
 =?us-ascii?Q?Im+mnAaaiZuqjMgSewdBiQnxIksQC4vD8awXWQ5XF9jrFo4LBUSEuk7vcz08?=
 =?us-ascii?Q?Pth3PHHSsaBg8xCl3HoUQv60uNrDPk5J7DXqznhAq6FNadjSaKdBZDMYWMyz?=
 =?us-ascii?Q?txx21uMVIFBqEp2+mj7wSisWbAsbgyxAzG9NhEA6XU6nP46wi+PS2YAh+EWd?=
 =?us-ascii?Q?MicVk7TdYGGceOovS9kQeXjGNb4gS0YeAzDv2sie8GUdnVYNIX5IRizomGmO?=
 =?us-ascii?Q?nzUzdwG3Nson6w7HHM89x31Ai8M9npKTKVOiktseolXhneUg4MfvEaz2OqgW?=
 =?us-ascii?Q?9zl1JNRQm4FZ/4IzwL9SX0n4VR2ThUAH3zy8VZtAuM0j109Hb1moMOWxE9mL?=
 =?us-ascii?Q?dzRLSX2fI34VTqHnkswXzRF/9li/4eo1OIPVyFtNhhnm6sJStVDFpYCndCMY?=
 =?us-ascii?Q?I67WPcFYMdKhboYYxb/mSLEJHURG+205mAHqNWTjflbwiH0BktnpG1D4PpuX?=
 =?us-ascii?Q?ipBDlEJyEHK/yHgEq7G/Bxf9tiItkNbl9YqaM90j55ukkc1CB08QKir9CDh4?=
 =?us-ascii?Q?gmuGhwXg0qLBz2+owubp+bI9tYWOQ/MsuDXx5ogDcMyE86B+Itn1GO9jj6R6?=
 =?us-ascii?Q?sM7GLqtkUNy2EfYWmNoJL2LaWE2Za9IIeUIiAZZRQpfK9QN7TTNoT6Mwi1mt?=
 =?us-ascii?Q?DtpPkymDTEV6dyfBaFNVbGqMrgtzvi5s1+G0KAlOdMwIzXAiQ1hpsUZ5m+or?=
 =?us-ascii?Q?xjA1Z4hmM1McGaOXNbV/N03n7Y4VLkFo9N/d60K8je9r8iC3t9CnSW/KwobJ?=
 =?us-ascii?Q?SOdZQdrCtyHHIDlqhIbHc463iHnCMXGicr3L+aYVhQ8jgqDlVtcC2OckGNFR?=
 =?us-ascii?Q?xLl4AGKzUFvU6NT3DkUJ0+OP2YmB9YJUukw+2OzAd63vjoshVdTnsXoc8ppN?=
 =?us-ascii?Q?sIN29gJjW7UGEIQABYlUfCep/9SA25xFui7z8j1LHNAp740D7RZjqBxp8Hjq?=
 =?us-ascii?Q?9bjJM8+58USPyyn1GgeQNI6mMCKmtV8YMbNRuJ1A33n0F9/TgiWTRurvtuft?=
 =?us-ascii?Q?51e7ZpwXEUUHcWW0kzCGmH9rKlhRSb9icRA/P9/fSaPthsPwXmYZXw3X+QEL?=
 =?us-ascii?Q?JSs45f49QrRCN9V7Qbjp6rdfcVuR4dn3lA1spMPxx2EmzH7agjuBtJNPo3BK?=
 =?us-ascii?Q?3GteVncOYXJW4bS15+5D2D+1WvxNJn722pAn/m3NPsSu8ltbAz9TvKCDprHu?=
 =?us-ascii?Q?9qq+Zy9UDMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C58uK5EQ0SxOJYoLksM7TE7fDCga1qDrMzptvTRrWNG+H0SOzCb9I0g6+PNv?=
 =?us-ascii?Q?kwR06ki02x6pClBp3onsDma85QnFpdFm2k5GMQgCJ6vv6hXbHP+BVSC8G1a0?=
 =?us-ascii?Q?kSd9rhCAgLVN1XMFiAisoQPlvaAlL9avmWURtV+s3kezSKPUcMrnh/ZqPJgb?=
 =?us-ascii?Q?Nqr50p2EwYqqRioXYW4yUgAm8BJ0+CM2yTNw9M6NhoLiH9n+NIPBSLLW42Pc?=
 =?us-ascii?Q?UYptVuMc8uhKhTJQBBcdvz1Dfy/uM4lSb9boWYG907xUwzZCHkXc1Hu5vgp7?=
 =?us-ascii?Q?KoYjl92kUQjx5yzTDQKYv41QVl+08MQRrk++cIGPA7s+zAzO4Di4jUrpDCjh?=
 =?us-ascii?Q?RR9djNzKB2RL9vKcNC+t2iaiJ7FcVF1b08KM6/lqkZ/ZJbtpBFM1Uh3Yttaz?=
 =?us-ascii?Q?kk9bJgM7qMSzbbVfhb/0SkjRGJJ2yrbvSrJy9p63aAIZbw9sReKpXxzkUHeF?=
 =?us-ascii?Q?xsVlD1I5qkAQ0q0oaaPxWZ53rIywr/9jz6vSRjPX6JWEK6RaIhGq1jC/5XPC?=
 =?us-ascii?Q?FthL+e/dMK4jFbPZ1BJlwhH3ITu/wfmyNigZox00T7j4LZX9qD3fubrDBuj/?=
 =?us-ascii?Q?eCZg9xwFewEREAh/YM9x2kODYh3wt9sAZk/jJLbqfbrSiyXtfuTNzkx/QuIR?=
 =?us-ascii?Q?Jh/fuhI6XxCyIflsSzfG0B0j88d8mC1/TdRqK2WUnK36hKBRrkQSOUuqDeVr?=
 =?us-ascii?Q?0jXIFmbE56U4vgo3HCK2LxJ8xmIVXfhcvmh8W1wEpRuljXtrRH/Bjfp8Hgvp?=
 =?us-ascii?Q?MELZK3hey7bRGXtScuVRLXsrkHdPwXNeZRR7B4ZcyHneV+ZiVp+TG3sWqwAr?=
 =?us-ascii?Q?1Ey9eP8XjvUk7aboaUXoLWVrL7d38Bt7DjaYLBZ3rCosyA5YOsmL3IKSmtFq?=
 =?us-ascii?Q?7vKVIPFu1OwSBgQ3j8wqKm6BgpX2s7T3MRgqyWSr0lqkyrmD0Mnt/EnmhNLH?=
 =?us-ascii?Q?9WpB09ayvC+tdaoeeEb3+6Z8LV9mLH+9gIMlQvoWBv74waNZN2sfIfTHBAFR?=
 =?us-ascii?Q?m8brGzJpQNr3yJxBIQao7OvyC1SFz/Ab6URvf2d0WoQa/K6vKQo0un3Id5H3?=
 =?us-ascii?Q?LFUVqNgZLY2NSruDxrhTi7IWbs6K89vh/xtWNesPgeELbdyEw5+hpROynN49?=
 =?us-ascii?Q?lPY0P6v0q8Q1H6y9h0IUap9RNzDnr/3apWn7ulM4l1MIAnLmNasYVesWQFwo?=
 =?us-ascii?Q?8rpvTbf7IcO20EbDkbsfyLAVTNoCgS6hIp0iycTCq/Mq+5fMxA16JFS8JSMU?=
 =?us-ascii?Q?1I5Ujnx09pB/asV/nAlldc9PK3FfforB6WNzKYrA3XW+w8HdAFHwivcvV5wD?=
 =?us-ascii?Q?Hk/CGve8VprD1XwD1sy7/wreB7wlNO2iPDTyy9usjrycRGWScMfg5Fe7bLh3?=
 =?us-ascii?Q?TMkFbPNst2uE+stAErnhppRWUGKkb81UiM0KFzOlpDJB9G6mWoMfIg5S44gu?=
 =?us-ascii?Q?dalw9YFiALesHFscygjRa31xDh7U7USI2N1ftt9zQJNIzV01Wq6oue3HimpA?=
 =?us-ascii?Q?2IKwqNPyvZnSUQ9KWtPChEFnqfqh7jz2RYqrY/ERfi4J72pjxIVXya1Faq46?=
 =?us-ascii?Q?GjoR5C6NCikqVOy/ROl70Anw+V1e4D6B3NW9r1NgnUxm9cbWbXrUQiVIxDDi?=
 =?us-ascii?Q?05ol1nuzyRh7JMfbpntG/OPIFe8+xS0c9nyXoTCtOKUY9O48fvY2NuBNt2B3?=
 =?us-ascii?Q?ukP0SQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e08e0a-6b4f-4e1c-f117-08dd83efe3cd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:10.0822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8brodgA6ECEI6OlWxisFM6TJkxtH/qH/4Kf8IuZNViMSIpOgYnDRRvb1DbG81z+X0PhXYAZ/t/Fp4qJO1Ir17a1pWbiS/w+bNTZiu2XCjo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Proofpoint-GUID: KRafq2IED0TWiO0pbwX5XJStT89ykuAe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX+E5RPGfzzbgE
 wifyy4d07YsB4tpGhUyb2m2FBv3QGpdRJHxwQFoBaWNROPLAbCVjELaKwvS4dLVxGP9vpPARu5G
 GrVXFCKS4LQ4WDTOEZJgfaqEtsElLlA+Cv6bto7HtErTcHVS0o6gfaE/pPQ8pb2ADI3Ncf2nTSo
 o6QgPiY8OKU/FxRtJCyP5mEWysjMHlVfjR0gf41IiIzHfx8s0m6DB7g5P/vhEqW867R+QASq0Zn
 khAcc5N2ARyX/9x6PmpT03+RHf7y0UWHNbPfkbeRnUu5FXveI6K71Df8VGw8gXQjbQPtMyr7J4z
 U4caaYYbo0ygjnOzWC0aP6+cOblurqWHht0vs0vvlfQbVtwzYA/Ijvsc2fXdIz40FvxuFQecmvH
 /panFajw4kQzhiC33Moa08yWqPssWpg/oxKJIoGUAknX5LzzlqWv132g0hEfoNclHfa0fgxS
X-Proofpoint-ORIG-GUID: KRafq2IED0TWiO0pbwX5XJStT89ykuAe
X-Authority-Analysis: v=2.4 cv=C7npyRP+ c=1 sm=1 tr=0 ts=680b77e3 cx=c_pps
 a=yZcDG7BW7OBBh6O1hU8nvQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=WPMpiUD6sP5E2puXUuMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

This code will never be used for an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 105 ++++------------------------------------------
 1 file changed, 8 insertions(+), 97 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 79e5d75e97..0c71d16192 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -413,19 +413,16 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    const char *pci_type = NULL;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
@@ -499,39 +496,6 @@ static void pc_init_isa(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
@@ -548,74 +512,21 @@ static void pc_init_isa(MachineState *machine)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
-
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
-
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
-- 
2.43.0


