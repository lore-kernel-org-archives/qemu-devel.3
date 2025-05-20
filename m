Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD9EC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWL-00034o-56; Tue, 20 May 2025 11:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWH-0002zM-5l
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWE-0002MH-L6
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:40 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7Libb032060;
 Tue, 20 May 2025 08:04:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=URMg/JTDKgSVu9CaS09GshwwqVeUo3seolEV/0rUd
 7Q=; b=LseE85JNmqgBWAYJ9oYdPVjhJxCykdD7xuJLisIvwbvBsyDBHOAYSYvuR
 tXgKwuKDKq/mTogrIUtJ6ag/mAIsaHzH1xmNRzvEWLfNNV/5VQmlVK7FWV2+FEQU
 eUw40AksetdJsV1stoc1ARNUGE7GEsp9+xudQsHycUrOq3UcMQMaxwXOeVHLmySa
 xRVXxclo+R51VeJQZOpxhlsnVUNTKynjFvzObk0aN85KGY1szJ2EBdUpLBANWAjQ
 WsabcgL9KaKz1VPvhTIk61wU3Ams2k/h/DYQJU7LYtCDPSdm5C+8aISv8W12//ry
 gMf3dduo9lpnk/KOxhOgbcowLgEdA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheabp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrv3QP5EbOZ+bKcGjYvXmYyASowtSicinfLuD+mSAQgBgLPCaHN73wLdcNwFSFTbS2BcoTkk1Jp9q04sAdtpDokEyH6WG6HBkH/cThjRKn/PclSLZ0LgaOfx4TiJpFUOaaPt7r5jy/SPxFOs3YSp0tN2NYVoIURBGvCqP/GopVnCQSLWc6TujqoMLIA6n8oc1MxslRNI7E6Vc9bc14ni2oLmccxf19+BGnqvEvrLy+NIeYb0XrLMXy2bkqgq5qwmRrfWctmpjvdaI8AcJLyJJm9uWIF4qSAAKVBLielI4kcXJPaVIORCKaEMNASWQmZVBnnMryeOZw8BQFcU13Q3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URMg/JTDKgSVu9CaS09GshwwqVeUo3seolEV/0rUd7Q=;
 b=PMpcWzNwrpJPhddpKWLELTKcppfgW/3vmDmJV/02+gkmnBLV83eFnfqfRGYBPMsDuTC/Kaz7z6py864HSQzLScd3AlPUmrfycGwRIwAivEg1z7ssCNWffVoOvm0pNYdlOPxsnRLcwO015w0mg3k7V9C2+4CAqXEkG+CYtx4Wz6Gw8Iz6bRzWbiALiWMvxmx1A07ZTQtUdtQaVO6dCpveLFlSwQvXUClVrotsq3cV57C4GnBvE4UE05cTK21MivhE+azZY/cA/WbCDVSCMjAhZUQxiBNt+ZixCovIoFOXEyY1HwlGQYLV9QUhka6Eei4VZOxED+LB3pJ93uSoYN8EUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URMg/JTDKgSVu9CaS09GshwwqVeUo3seolEV/0rUd7Q=;
 b=v/rxSpqGS3+hNLh0tZa6TGhpkyVeM9HSg5KpQt8QkxE5gKK1kSVYv9YOQvGhjsMCsdYuoTxnjViiUmQgLESk5d1wJmwz6Ffjfg4eqAYoaMkP1s135rbYVcAYW2HpT06zrR9jhHHhag/wG4Q3NuzdoFNIjwaYC8ArpU8TB1jOViLtH7SK+a94D/CeiRayE2kbhR474BKm6eBcAEL0PgcqnuUIIiPw0xbmDofm0k/TG8An1TunOeBY5yvWHutGUQvv93Ex9j6a9/VPL+eh3Zq2lPR72hatV0RrjXH+Ly3+ya2+JtVzKV/mbuz7QCsxhpokd+2GkK3Xcfqp6J7laArzog==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:35 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:35 +0000
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 04/29] vfio: refactor out IRQ signalling setup
Date: Tue, 20 May 2025 16:03:53 +0100
Message-ID: <20250520150419.2172078-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db6e579-3044-4026-9068-08dd97afa1f7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGpWV0pOMlIzSHBRMHF0WHd0Q1FycFlHYlRJWEhOZGFuaWJFK3FUOCtmV0NG?=
 =?utf-8?B?TWNYUjgxVTZsRHZyb1FpSWZPNE5rVFN2RHNZV2c0QXRHektkaDRzVlZMbnpj?=
 =?utf-8?B?MUROUUJXWEdhd3NSK2xKSFFLcy9WM1dKekN2dDJ6aXN1YVM2MitIZEt3WDdU?=
 =?utf-8?B?VllRNC8zeW9tbGo5VGpXb1lWMUgyYTY5NlZBSUtlMjlBeTFJOCtGeldXMGpT?=
 =?utf-8?B?MDZFSmxaLzdPd2pPNmVKVUpKdW5aUktMclUrbVcwWFpoTFJDUHl1RHBQYm9V?=
 =?utf-8?B?MFJYOFBKZ2ZDVC9MeGkxSkpwa2p3WE5FZFhIVVMyUU13blg0T0NHVzFFRjN3?=
 =?utf-8?B?NlNveDhKTVp4bUJ2ZUhYV0xtT2l1RGdsU3pVRGs3OWRpOHRJdnJRbUh6bVYz?=
 =?utf-8?B?VmlGYWFsMHlZd3duOWtwWXVJUzE3cnlxV2hoM1UyVU1uanBjWHUxRXhlVmhM?=
 =?utf-8?B?eDIwa0hFbzN2VUJ0amNmSngwc09YVHZYRHJyL1VwdFovY1AwUGRncFBnUFFq?=
 =?utf-8?B?c2RJazQ2RlZFdU9WODdxSkFPNEl0cG8xc1lFdDYrOGNkZnkwOGlyMjNUT2Fl?=
 =?utf-8?B?bFJKdTRZbUZhVGNiWTV1SGcyZnlkNCtwRUJpN0Z5OERyaFVlWjd6U2RVdXk3?=
 =?utf-8?B?czdaTW8rZWZMYjhZbS9zT21hemdEUDl2TWp1alBjVEF1NjBlRU9ady9pdE9u?=
 =?utf-8?B?Ym5oUnUrZVdsaWhRUFlKNkk1cVcwU0ZPM3JGUnArdWpmSUNFeXlteDM1VzFq?=
 =?utf-8?B?YmtwR2w5aTZ3ZTJUQmxUa1E4NEVIdXdHK3hQV2hhaG9oZzlDOHFMZmtobkRS?=
 =?utf-8?B?cGsvYVo3ZlVHWVJxODcxSnU5R1RQdzFzUTBWOEpROHA2Qnl0UllWT0JGU2tQ?=
 =?utf-8?B?bS96eGxiOHNNSzRFVkdQOWtZOTJaaTB2NjVZSk9ZdTBQTThiSnhwSVgwK3B4?=
 =?utf-8?B?ZSs5T2VGcU5jb1BQbjFEN2VCaVpYV1VzM3FvcnA3M0YzVW5iaGUzbXMveEFt?=
 =?utf-8?B?V3EwTDdoU3dJOFdaR3oxT0VsRnRNdU9uRHJybTdLZlVBRmhRMHFKdldoR1pk?=
 =?utf-8?B?dGVXS212ZFlXWXMxQlBucHNSQWtuU1RnL3JrcUxHUFcrV1QwMk9OeHNadEdT?=
 =?utf-8?B?NUFtNkR6dXg2bVVabmR6SU5BRVRtS3dIZ2lURk1ieFlhamlZYVJadTBnSnZG?=
 =?utf-8?B?QXhrV295cjZHQjJBVHIxSndOdE10VGE0WGlGTlRYN0NlQ21VekdNN0wvSjdz?=
 =?utf-8?B?WU1GSEZZbENOa0IzTlA4K05wenFjM3NVSVVEQnVpZEdtMGNzSWJ2NEg1RmRj?=
 =?utf-8?B?c0k4ZnpTU0o1SXV0YzgzSEFRZ01uNGFiMUUzV2MvMjBSdEZLNlJtMGZHWURN?=
 =?utf-8?B?cWdhQmFFall0aTg5YURjSDVObXQwTjBQb3NTVlNnNkJLL1BkODNzRUgzTjYx?=
 =?utf-8?B?eXlkZkxGYjJGSjgwQ3F2blcvNWh4RUUxbUNOL3g3T1NHVlcyendGZVBiaGF0?=
 =?utf-8?B?TWRENHF1dFYwV09DUVNNNFZGSUdORVJnRjY2OXdacFBVZFpFWmppbU91ODZS?=
 =?utf-8?B?bkhjTHBIVHFzbXVJMUh4c2IxVVpVQ1ZoMnZ3YzdvdXFsMmpDdjJyNm5ZZU9o?=
 =?utf-8?B?d1lMb0RLbHZ3UkFCZm9KUVp6RmtLMGV6ZmdsSzNpeUd2dXl6aU1sTnd5ZnVN?=
 =?utf-8?B?Tkc5ZzlKNnNjV3lXVnF1MVJHYjF4UU10WG9Za0xvakVvOFg2eDZsYzkvcy8w?=
 =?utf-8?B?L1ZoeUdWRU9KWDJqWkUzYi9KU1RUYUR5YWcxcksxQkFVMzJIQVhGUFd6cDNr?=
 =?utf-8?B?aHNPL09XKy9GSTF1eTBmOHZwZUwyL21abEdLOTdvUkVDUll4cGY5b25zdjBR?=
 =?utf-8?B?dmo1S1VOOXozRlRCa3U0Vi9Cdmg1bnVDNVRSbWFKRG9neVFXcVJMUHMyRy9S?=
 =?utf-8?Q?HpuK0HN4kt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a04zUE9JUmZ0RmxXbFByVUI1OTg4Wk1kSXlLSHFKWXFyNUhJTTBKaHkzOHBI?=
 =?utf-8?B?TFhnVUwrNSs1Nys4Z2VBVm1RNEFCQ2tXcXNhZGdQYWFMK2szY1lLK3ZMckNU?=
 =?utf-8?B?TjNQcjNONXB3eThvZjZQeHkrYW4zbDZyajZRVTQyajRNZnZhTWlZTnlaS0hB?=
 =?utf-8?B?MzJXM1NvSWZxTlYyYkFzcU1LOWF6N1FmRXBPUCtDKzdGT3g5eHJrN2NYemUv?=
 =?utf-8?B?d1UxYjN5MEFiV0lOa24yVHB0ejNnMWFpdnNacjZOUUxZNjNrM3B3dDRIMEtu?=
 =?utf-8?B?RVYrbThhWFJKd21ueFExcVFaYk43U3YwOUdOMHQxTWFnenR4NlJBZ1dZMlBu?=
 =?utf-8?B?SUR5Wi9GWS9rcnpaTlV0TjQvSlRDREd1SldDWE96S0IrL0F5Tkh0d1hQWHp5?=
 =?utf-8?B?UzBtYU5OeU5sV0VFOEtIQStFNHAxN3VUU1VXc3d0WFBmYlMzNEwvaERoakFC?=
 =?utf-8?B?OFRkMXZyRU95eWZtTWZoSVRIMEphVnJ1Nmt0S1pPZXZ4YXArYVdacDVROGVS?=
 =?utf-8?B?cC9qbitCNkZzQ2FBUHBScE9tVmhZQjFha3V5SkV5T2QydmFORXR5aldBY1NL?=
 =?utf-8?B?MEZ2ZkNYMENKOTRBRDBlT2Q4RXNoVnR2UThhSFlPVXlHTkw1RDB2WFVCaXhu?=
 =?utf-8?B?Sk9BUU0vZFZwU1BlQ1pNWkM4OHRQVFZMV3h5ZW9ZdktWeDdFOHdRS3dPeXRB?=
 =?utf-8?B?MHZmWnNDL0EyeGVFczFNbnRYUkZUQVI3ZVlVM29PaFFLYXN3UGRaeDdHYXUw?=
 =?utf-8?B?RHNoWFhEV0RhdEFiMndzZXBFR3RxWDNFZUQ4Q3pxRlNacU1IZXZZTTErY2I1?=
 =?utf-8?B?enRURkM0NGY3T0dmU2FlSjhVT01Dd0p0amZOR0ZZRFJIT2dDUEx5MG5ZSU1m?=
 =?utf-8?B?WHZCelhjbDVZb2JBWFhGNlptTklRWnFXUnU2UmVGcm83L2FjUjZueXR0RW1P?=
 =?utf-8?B?UjMvS2JYNEpTUjdLa3IrWGMvMlFTWXF4SzNiN2czSlM1UXBCM0l5SExPQjFu?=
 =?utf-8?B?eXVING50SndZYXZWTEJnM3hSK3hnQXdEZzRSS0lDSnhnUzA5WEZadzJNc0hJ?=
 =?utf-8?B?MlZ6Y1dhOElCdFhOWU5xM0REMTgyVTRaQkFQdFZmdkJBczA0b1E4NzhvcVBX?=
 =?utf-8?B?UytORlhJTDhVNm44MDd0dWYwcEdTbmkxNzJyMFdHNlNDOXgyZDZBTUs4Ykhw?=
 =?utf-8?B?bWh0NzcwR2tjZUI3bkpickMrVjhFSFdOdUFzWGdQclluR2thM0ZyQTlpdEpu?=
 =?utf-8?B?RUJieGVsTU9KQ2kxcXNGa00yMVdrY3l1aUIrdDhsUXV0N1I1eTFxTWQ4WVpx?=
 =?utf-8?B?NFhUbERsTXFRc1J6Uit0MWd0UlAremcyV1NpNEdKUGxwN25ETUFlUUhhb2xW?=
 =?utf-8?B?TGtFSWp2RGI1Qk5RNDZiYy9DSGZGcmluRGU4cEJWdWpoTzR4ZnBTVXlKOFdN?=
 =?utf-8?B?RHVjWlFmczVRVCtwZ1dqMG9zWGthRmdvNlh5U1NFM29lSVBZTVhzU1RrTzhy?=
 =?utf-8?B?WUdBSDF2d0hvUnFDQ3dFSjYrd1RiSnJ0c2wzTjJnN2pGb3hIdXlILzNQMWJH?=
 =?utf-8?B?a3Jlci9adE82YkFNM2hrRjI1OU1jUmRjWk15emdjNjlMVmVNcUNocUFNTDNB?=
 =?utf-8?B?VnlrM3ZMam9UY0s4Rkx1UUtCTWpnT2ZleXR2ZnMyellOSHFjUEd1eTB0ZXM3?=
 =?utf-8?B?OGZMTVN2U2xLS1VqeVBCZzdCUmJYSThXQUZMc1F4WU5OZzlyd2VFNEdSSXNj?=
 =?utf-8?B?UEc0R0U4aVJEWk8wKzBDTlZXbjNRRllQT0hGenA3eW1BUHFBVVVVMk5iVG52?=
 =?utf-8?B?aTZ2UWFkMU93Vkc1WWFVc1BVbDUwUlZPTU80L1RBM0xEeC9JcEw5bDloR0hD?=
 =?utf-8?B?b2tZVUlwQUxuQ2x1dy9kT0JrVG1wVzRNODFjcFhBeERiM3c0dTlTMU9Da3FT?=
 =?utf-8?B?Q2ZMUEZUcTIzaG9yMWtTSXM0NlAzeGt1T21VVFRxU29OZTJtQmJ4OVZBN1N2?=
 =?utf-8?B?cVcvandzMGdoZmJnelh5WU5tQTZMZDdoell2SDFhN29CblFiUFJFTmJpbkZx?=
 =?utf-8?B?eXZ6ci9rKy9tbytXQzIzNGJ4T3ExNVFSdTZpWmxSTmFKUFlhTkhkNzMyVEs0?=
 =?utf-8?Q?ygyqoiUSFXJkkqrZ6R0dcpDuy?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db6e579-3044-4026-9068-08dd97afa1f7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:35.0440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgR8DLFLzunKIWxcTIe2X6zuamM/pcajs9VuNfPujaOVafnm+uTlziiQLOyGHRQN6G9wIcHgDDaCSjvpIHTLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX/5dEVYxlqSLs
 0G7JwfUGmLAhp+Zip7OIHtC1ZzGWtD+wPgfP9TbqAEWcXA9LalF5cPEpMDGoYMDxeJeTGffAgIG
 Y4J/4huMdgxQuFqDrM4n783sAvZubz1629Zb+P8b9EM1x0yOKWTPbiWlWa5V7hVifSTnUzAiBLc
 2A03caIAAA1svD3RvasHnbGe7ULmVxuXPeMjpvXFyIDLYcpOUDnAnMzBE1jA7Hd0Evdy0xRCUJD
 0qHpF9bNdYeEWPEIk0a4LCgvaIRK059alBPb+/NSxngfyvm6m47PIx/Qg6S3Nb4t1LNYowdSZwF
 JL4R5pRd/valR92EGa30hVY/CyYjeAMLP5iVnIXCx4DRSB0MBiPAQaxvMiaSbJzfAXT5pmjJrm5
 NfAfHu6LXS1SZyTvYeWQOVAj9Vc/QKRV1wKsov539ii8zklGh9DAPgDsJCHikPlTWOTmkleF
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c9a04 cx=c_pps
 a=b6GhQBMDPEYsGtK7UrBDFg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=Cuy1blySaGDMMkobshQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7SNO8Kjm298CgIYaRvdGSwUCAOupdO6H
X-Proofpoint-ORIG-GUID: 7SNO8Kjm298CgIYaRvdGSwUCAOupdO6H
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

This makes for a slightly more readable vfio_msix_vector_do_use()
implementation, and we will rely on this shortly.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a873f82aeb..b1250d85bf 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -511,6 +511,25 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
     kvm_irqchip_commit_routes(kvm_state);
 }
 
+static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
+                               unsigned int nr)
+{
+    Error *err = NULL;
+    int32_t fd;
+
+    if (vector->virq >= 0) {
+        fd = event_notifier_get_fd(&vector->kvm_interrupt);
+    } else {
+        fd = event_notifier_get_fd(&vector->interrupt);
+    }
+
+    if (!vfio_device_irq_set_signaling(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER,
+                                       fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
+    }
+}
+
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
@@ -583,21 +602,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                              strerror(-ret));
             }
         } else {
-            Error *err = NULL;
-            int32_t fd;
-
-            if (vector->virq >= 0) {
-                fd = event_notifier_get_fd(&vector->kvm_interrupt);
-            } else {
-                fd = event_notifier_get_fd(&vector->interrupt);
-            }
-
-            if (!vfio_device_irq_set_signaling(&vdev->vbasedev,
-                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
-                                        &err)) {
-                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-            }
+            set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
     }
 
-- 
2.43.0


