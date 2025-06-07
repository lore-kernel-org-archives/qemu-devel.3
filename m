Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24185C5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9Z-0002wZ-AD; Fri, 06 Jun 2025 20:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9X-0002vx-GZ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9S-0006Nx-DL
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:15 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Kvtis017734;
 Fri, 6 Jun 2025 17:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Pxk0pmyQRnF1FFetlAKUuAq+ITTwv2bTb91xXUYCu
 UI=; b=H1VVm4kz1PywNwxjUGKGJSHV6UtHhAlZQIt+NBV0O8mEjimpQbGvoY6X6
 1mL635UrR0196GAlNTyOmkkTwRs9hTsl1nFtW8Pwg8/XzPOa3JwstaSufOo7rF6J
 BuzfKIEn8nFQAvHoZ5OhVtYgTH5mqo+qdOFhdO+9W0CBqlaOEsr4dF0vV2SawtVv
 16VmjS8jfa1qkosZ+/yFMtgorAMZbTsWEolE5YrM7/anhzgM4jpCOLHBwfo1H4KX
 6mGommuzyxGiev1O4Y0vPiklOaLrMoQIfLpZloJVqNBER+8CvVLMMGVf4lEUC7tY
 XdJGHkPlNFD36otqa8ibsIssBujlA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2138.outbound.protection.outlook.com [40.107.243.138])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4747u3r8f8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhJlvaKsuhs0RclTdlW4JNwj7aOpCafsOsrvy7SqyFxCtxdBMU67hxSVWOPSW0YXzI4JlGZVpXmeCOyJw02E8cwjdAjSpNHnIkwObiOvfNSMZNyIcNfdG8f9e+QkPnga7UKAROous9SYZOPC2mBlAYJ8knjkEq8YzyOSTh9aQOIeA5U2hniV9QMACkOeClf/nYMg5MFKFrTTl3ICEqous/Eo3U4CukKbvfKFU8GNBuIs9w9j0Jmtj6e8xk7jutkK4geEY8TE05sac5kSWWZt74lPtlO8RqCCnPge4YbPUKE8HHfpBjnSQF6Qsctw4OmJL5p3jLtE+s15m3XNXdP6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pxk0pmyQRnF1FFetlAKUuAq+ITTwv2bTb91xXUYCuUI=;
 b=xPDISPnZRXddB/ATFl72M1YKWDwOdUL/SfW2pRiIi4yooqLpXqBDPmAC31TiAnPgTmb3BUdyM4q6jNEpksH674rLwkJ+dWwJ1/rV4Uce8MlSPu5Sibq6Mnkbb9u+U0jANBzBCRNLwQIoq8r/sRvUtgPBpadUo7lrZFDMqYodTeuGk/5k6KoChVBzxClDuQeFNZX3+oo+jpj89u1cEBcZKJpHH5uoxJ5nJRxnXqlhfUHjEkKSNJoCBD3spGYSq88nYGQEGLKu+wE3IK+TFqxiDEkV6LGfdZdEutzMQvyTOHB+REFPBSHlxorwz7oH8RgyvWz1PQZfhbTicvKJHBbpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pxk0pmyQRnF1FFetlAKUuAq+ITTwv2bTb91xXUYCuUI=;
 b=WrTsaJvw/zPf38QC+ckt3RoByj3eivstwCeSlsTrqFg7Vpu86spahKihhNDPyDaEYBDkXIRS/e3ksBMQlamONlJSunfflzYoTKsSLFdH1DT3ISW8v0dQK819F5t67Y23TXCzMVVVzfBB0B/tx1CFNLSGP5QCcqdIyVG857BezxMKVhTMHGSig/XM6q1C27n0u/6aZxBPYXVA1A8zaFR5PmIx/GF1QgR9wWqYJ42os6ipwGfahmjyi4qnRlxZaijAe3+bGlwbiC+OZn5vk6eiCshdduoHMWlA+Wjio9qADOblU6xrONkzuobd/IKefU91lQAv+dEp96D+DRI+wLcveQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:07 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:07 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 06/23] vfio-user: add vfio-user class and container
Date: Fri,  6 Jun 2025 17:10:38 -0700
Message-ID: <20250607001056.335310-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: c41a4a17-2524-43ba-80ed-08dda557cca4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWtCZmdqdG90aW4rcFFlWmhodUlsbXpXRHdPTTNCQkxaZVBMTDJGZThPL0Zi?=
 =?utf-8?B?QzhSNVZxaDR6MGFGRGlKNFByaVFjRmtHUGtJUUhDajZhM2dudlpNSHBWVWE1?=
 =?utf-8?B?cEY5ODdVQjdsenlCOWFqN3liOEhrSUFvRFg5eHhzdEVJWktGdm85VkdKdDg3?=
 =?utf-8?B?U0tDRkJ4ejZScFdzYXhVa3F3TXFUMk13MmJtdTZnQ0Z6OFhhcGVvaXhveWo3?=
 =?utf-8?B?RzlJU2d4Tndia3FJTjBxdkpWckRzWldhVmxrOENGU2tXQXFNaytIQXBuWmZL?=
 =?utf-8?B?VHBzR1JZYjZ6V2JaRE5KbU16cmxsT3MzUFNvQ1lPMVV1MHB4SjU4bWErL0Nv?=
 =?utf-8?B?djBVaExrWmhWNVJySkRlaG1FYnZIZTdnUjFpS3g5WDlQL2RDYy9uWmV0L0Nj?=
 =?utf-8?B?di9ZV2xlc0Q0dnphTUw0U29TUThWNlZzcVRXQ1U2UWZIUHpJYTJhNFB4SWtG?=
 =?utf-8?B?T0tSRnNTelNDTmQwbGxDMzJwZ25jcitGNFJZK2lMMVVibzNuRWxFeVVTU2hZ?=
 =?utf-8?B?MHQ2TVZvTGZzMWtaeUhEUUNwQ1hqMG5uSFZSYTkwallTSzhqN0xmNTFwcTR5?=
 =?utf-8?B?TkNFeFExTUZqV0dUeWdCT215UzhjVVBUOE1pOTlxT2pnNlRWY3lNVCsxRThM?=
 =?utf-8?B?dEFLaURpMVZHVXZPWktzMzJwOXR6QmEwWExBeVFlbEtMY1gwTytEMGVFaEJa?=
 =?utf-8?B?OExzKzdlQmpxY3pHUnZJc2hnN1R6QktNdEEySHhiR2NXOXlVSDRWcGFibmo3?=
 =?utf-8?B?TFdaYmtpN1U1OHRxS21seGliRHR2SkpIZXdOUDkvNmVWbWpRSHNUYVh2UUUv?=
 =?utf-8?B?aWtSVGp0U2ZWYnJzeDBxaGxIYUcxZjJLSGxXWTRQa01IRzhLTzlJcGJsa0JB?=
 =?utf-8?B?YStiSnBkTEY4eWVWNHFnTGpmdlg5clpQb2VJTU1MOEJCak5mbzE0UDAxN2Z5?=
 =?utf-8?B?NkRxcjc5RUxrNzJqZ1RNY3hGNlU2OUNDb3Y4VkR5TjdpV3ZRU0lLZHJ3Kzd0?=
 =?utf-8?B?MWJ1and2S3hjTkNCY0dkaTVNTXlzQVVGNE9mV3hzQytBWVByUDBnRkRhaXkr?=
 =?utf-8?B?dEdjemcxSFNrZis2MWszZGtZbU1KQWlxdHc3U1pleFM1bVQzdTVMT2RsTTc0?=
 =?utf-8?B?UmpVQVByRnBwSmNvd1dZbmIvYVlKYU1aOXZURG5uem4rODNHYTJQTUw3RG1j?=
 =?utf-8?B?d2FHekx3RzJONWI4Mi9Ua2JZSnpjTFZqUHlseE11cWNNWEZXS2hXZTBpbnRk?=
 =?utf-8?B?THo2bE9yanNBbXlhL2F6TnBpSXVmdzhQTlFhT0Uvd1hFWEw1ZGdCdDFrNDVV?=
 =?utf-8?B?M0orbzlxamRQblRTZTk2dXRRU2RtUWRBTytYUXpsZmtKYm53clFDOFhnMUhI?=
 =?utf-8?B?UkVobml2RHVtb1FRRUl0V0tRTzdKMEh2YWNPczdhb1NVMzlWejBuY2ptT0xL?=
 =?utf-8?B?Wk4rK0YzTjE0a1hTUUtybkRkVnBlamxRYSswVklzb2FlcTJWSldmUE51OGxK?=
 =?utf-8?B?MncwLzlWOTRDOURjR01KWExiZW1pWVk4SSsvY3VFbUhUYXQ5ODZOamUyZkc5?=
 =?utf-8?B?NmlKODUrbm5mYzlqbjQ1MVZidEdtRWJTbCtXSmM2MlRCbG5tMmdwUC9vajM4?=
 =?utf-8?B?UGpEV2pRaDdJTFhhUklxc0orcHBhU0k0RDAyZlY2bmJCZFo3V1djRFhTRTRj?=
 =?utf-8?B?bGs2QTNMVzAwdTBjU2VzOTVkdzU5M2JuSkxSd3NESC93bWdCZ0x5L1FGU3hY?=
 =?utf-8?B?b1M0bmNvdmx4N0FqamhQSkRjY0xPQzRDcnp1ZU9TanBrWXZzTkwrMEhxRHhU?=
 =?utf-8?B?NEVhbCs3Tyt3MFZ3cXBlT2RJSURLOExVeTk0WU1rZkxlUlkvZm8zS05xYU1J?=
 =?utf-8?B?WG9hbVBrNkxaL2QvU0YxcjBMZDRDamU5QlphejlPTFBWblF2TU9ubWV5YmE5?=
 =?utf-8?Q?R14yCT2r3yk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODBPRktXS2FWOUFNbEpsVjN4T1JZL3N5bDR2R3pvQkVYRVJySUdhS09FMmVx?=
 =?utf-8?B?TDdNRUh6NmtXeEFjOEpZTVMrNVMvS0h1OEc1RDdhNDdTa3pqclFTT3FaOGYy?=
 =?utf-8?B?WFJYRkNQRzBSNG5UT0dDdU9OcFVoTGpxQTQvYnVnLzJqdmFQem1VUU9PTEhs?=
 =?utf-8?B?ZTl4NHFuL1A4MmkrSVlvVnV3ZTZ4b00ydE1Ud2xublEwc0xGYXVwOUVPWjFQ?=
 =?utf-8?B?QnF0ZzNPUkgzT0l4c2dtNVN3U2k5TjF0czduR0hJOU1CL0s4cHpsUnVHVyti?=
 =?utf-8?B?UHNpQzZONzErTDdxS0diN0dkTXVZNjA2MmJ4cGVpeG92elpRMVNiZzJjQmQz?=
 =?utf-8?B?U1VKaGg2ZTM4QXBGYkpZZWl5bnRLemFmV1lyZkZ5V3o4WkJ6UENFb1VRWkxU?=
 =?utf-8?B?NmQzdEhVU0ozejNYMENxUGxNeTlHY2lndXpxUW5mb0NuUDVrdGxmOUlDWm5K?=
 =?utf-8?B?M25CemVxMzIrci9meTRRRERVbVZRZk1uR21aYmZsNzFGZkhhTUpJMlFFUWVi?=
 =?utf-8?B?M2FOY0pPRkY5aWdoTEsra3c3MTBUL0c0Zm9CNy93VzdYNFVGUVJ3TEhiWWNX?=
 =?utf-8?B?M1p1VWh5MlNEcEIyNjVYU1NGbDdyc3d6Z2wyWXRjR2plWjhiN0l4dG03QlRY?=
 =?utf-8?B?Ui92Ty96NEZ5WkR4Z1ZDZXNxQ1BDOGc3QlpXdEZMVG4wOHpkdWlOcXNYYm56?=
 =?utf-8?B?TlNQUXlGTm8reGNVZHRwaHY2TUYra0d5L2hIR3hvVkFWaWYzNmZMNThONHdt?=
 =?utf-8?B?NThQaWI1MFU3eEJZWHp0MEVoTVBuWlNDd0swelVSSktQNDVoM3NuamFUS0h4?=
 =?utf-8?B?YTV2Qks3aFNNN1NIdDdPdzErOUFWTGVMY0Z6ZnhEOTI5OWNEV1dEeEVFNUlV?=
 =?utf-8?B?clY4SUZoblRBTklHd3JadzBiOCtJNGJLZDFMTWhZNm5CcjU4ZkluLzNhWEVD?=
 =?utf-8?B?Vlp5RFIybWxRdGkwaFBPcXZoSkJkZ2s4bXVPdW52NWxlcHN1aE1QZjBycDhi?=
 =?utf-8?B?ZldGMlp0OXAyMVg3OGkvbTNwV0hjNG5iWlJwRC9YMlFLMm0xZUV1S05ualR3?=
 =?utf-8?B?eUc1OVRkakVmK1BES1pPNGJ2bGxmZlRlMGRvMGFhTlJva3ZWMEdxcWVpSUlO?=
 =?utf-8?B?cGZEYXZBOUp4TkFSandNdm00REZ4YXo3TFJZTHlpWUg5RldLYStvTVowQUJi?=
 =?utf-8?B?SGFhaFltRm9jRkt3eTdsSnJuRHIycUQ4eDhtaUhtYlNnZXpBZjZGUEdoY1lN?=
 =?utf-8?B?cEV0V01TOG13c2E0blVpYXZET2F6VVdmaklEbVl1dWtid2NFRURHRDI3eVR0?=
 =?utf-8?B?TWFpS1dpOXUycDhuZGlmODV4UmtkR0MyQnI4Qjg5ZzN0SkVDdWNmQzhQOGR2?=
 =?utf-8?B?WGRPeWRoaHBRQWx2aG5pOFdGeWRnRFNJWVhQMTM1RmFreE5taFB2ZEpXQVBs?=
 =?utf-8?B?TEgwZ2ttcEFXclJQKzB4Q2dLa2RkOWt3bHB3dmxTZ3RTeHJFc0RvYzIrWE9N?=
 =?utf-8?B?TzhYSXloK3Zxbm5KN2xBOVQ5a05TdkJ3RjR6R04zejZyY3BaaEQwZFljcmpL?=
 =?utf-8?B?SHhJeTd0T1QrbGh3aWM0TW00UmxUeVdNdExGNEhMTkxKZnowS05VU1IwMWpS?=
 =?utf-8?B?Rm52RnMrU1FqVkZJeGtBSU5waUZ2WFVleWN3di9kQ0xHQ2xpczRFaXFtR0Uw?=
 =?utf-8?B?Qzg5NGZVMjkvRmNKMC9UckgwbUUxd25zRXdoWHVVcTgyTkxqSXMra21lRDJz?=
 =?utf-8?B?R2EyQkNmYW1jSERNQ2FNNzBFZXl3R1prTmJtMkpSQ050RU05UjFOLytMNmxs?=
 =?utf-8?B?N1FiUUZEVk9wdmpVVkVqR0lsRlExUVZwQkZTRjRUS0pWK1RhNkErNnZrYUQw?=
 =?utf-8?B?aC9HbDRTbmFidko5SkVHY1hhR0wvMkpsUkVOdFdJQk1XZUlxV0dWaUpWWE1L?=
 =?utf-8?B?c1pCbFZyQUJuaEppcGRRbWQ5N3V0bGZqZGZzY3JmcUlUYzNrR3doYXloSVYr?=
 =?utf-8?B?Rk53cXkyWVpQODFmSWU3WHJ5NEkzWGNBY3RPSGZHdUlFMWY1TnU3ZEVhN2Zq?=
 =?utf-8?B?RDBQZno5amZtZmwyTGNlMzNmM0JCWXpnU0N3WmROY1REMG5Gb25DRk82Wldo?=
 =?utf-8?Q?YY12QJHIan8R0ymufLv/15a+9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41a4a17-2524-43ba-80ed-08dda557cca4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:07.2795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB1qgxE0eLNRArPxzVkMXT7zEofGmQ9k8hvTlwgm3j0KeWDblZaz8OGpJ/ty+XqVi2LcbBR2uKwmW91LsYRvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=cpSbk04i c=1 sm=1 tr=0 ts=6843839c cx=c_pps
 a=j6Q7tV1r71QiW8XCak6Opg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Zlyvcu6OI-jkaoIL6xgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NSskSD858M_sJJe4QbbVIOQOwkvrLs1y
X-Proofpoint-GUID: NSskSD858M_sJJe4QbbVIOQOwkvrLs1y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX1mtmTytb7Po9
 6BupjQZtVNVu10X6JDUyru/vhMbhB6Yo5Mg1HX7IooUisjRZRR8MzvyzFrrvYYj030cl0tboFCo
 yYFRRAExGK/vuSubRUWz+3kqiQVojEV7+7rw4V10hoYFGTKh37yrNzrmKYHnuN1Urs25uCTX12l
 g9DtOZHwjq79m87vyE4jKR1wJbpx6vhkDdPARNAOh1BPoZ7/gd6ZsDRvMC8JFVBHpPqRbxP4J1e
 14euwHg4g0Vqiyi3HywQJUvr6QTGOdGI+WB2mXFoQcVJ1Uok2Mdqjc3cGXX54JH7rV0S5gjrpRp
 mqvv7IqN806OY7M/5rr8NLehVpyoL4Qe8PnTJ+E+DbnZOTaaQgtON1XRgucpJIiM5cVWE91dM/x
 eerAyT4fCTMlmOIBrR6AU/48jLkP6L6/ho3hn0AyLn4JZVU8cdvMD4XgaIZ6ml8fEtx3Qvj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Introduce basic plumbing for vfio-user behind a new
--enable-vfio-user-client option.

We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
container type for the "IOMMU" type "vfio-iommu-user", and share some
common container code from hw/vfio/container.c.

Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
sharing some common code from hw/vfio/pci.c.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                           |   2 +
 hw/vfio-user/container.h              |  25 +++
 include/hw/vfio/vfio-container-base.h |   1 +
 hw/vfio-user/container.c              | 212 ++++++++++++++++++++++++++
 hw/vfio-user/pci.c                    | 155 +++++++++++++++++++
 hw/meson.build                        |   1 +
 hw/vfio-user/meson.build              |   9 ++
 meson_options.txt                     |   2 +
 scripts/meson-buildoptions.sh         |   4 +
 9 files changed, 411 insertions(+)
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index dbc393989a..328bab8d19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4252,6 +4252,8 @@ M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
 S: Supported
 F: docs/devel/vfio-user.rst
+F: hw/vfio-user/*
+F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
 
 EBPF:
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
new file mode 100644
index 0000000000..3cd3303e68
--- /dev/null
+++ b/hw/vfio-user/container.h
@@ -0,0 +1,25 @@
+/*
+ * vfio-user specific definitions.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_USER_CONTAINER_H
+#define HW_VFIO_USER_CONTAINER_H
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include "hw/vfio/vfio-container-base.h"
+
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
+
+#endif /* HW_VFIO_USER_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9d37f86115..28899ca0a6 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
new file mode 100644
index 0000000000..2892845b4f
--- /dev/null
+++ b/hw/vfio-user/container.c
@@ -0,0 +1,212 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+
+#include "hw/vfio-user/container.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    return -ENOTSUP;
+}
+
+static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                             ram_addr_t size, void *vaddr, bool readonly,
+                             MemoryRegion *mrp)
+{
+    return -ENOTSUP;
+}
+
+static int
+vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static VFIOUserContainer *vfio_user_create_container(Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    return container;
+}
+
+/*
+ * Try to mirror vfio_container_connect() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_user_container_connect(AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_address_space_get(as);
+
+    container = vfio_user_create_container(errp);
+    if (!container) {
+        goto put_space_exit;
+    }
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    if (!vfio_listener_register(bcontainer, errp)) {
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    object_unref(container);
+
+put_space_exit:
+    vfio_address_space_put(space);
+
+    return NULL;
+}
+
+static void vfio_user_container_disconnect(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_cpr_unregister_container(bcontainer);
+    object_unref(container);
+
+    vfio_address_space_put(space);
+}
+
+static bool vfio_user_device_get(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_device_attach: attach a device to a new container.
+ */
+static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_user_container_connect(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_device_get(container, vbasedev, errp);
+}
+
+static void vfio_user_device_detach(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    vfio_device_unprepare(vbasedev);
+
+    vfio_user_container_disconnect(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_device_attach;
+    vioc->detach_device = vfio_user_device_detach;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOUserContainer),
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
new file mode 100644
index 0000000000..74b0c61f9b
--- /dev/null
+++ b/hw/vfio-user/pci.c
@@ -0,0 +1,155 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/vfio/pci.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    char *sock_name;
+};
+
+/*
+ * Emulated devices don't use host hot reset
+ */
+static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
+{
+    vbasedev->needs_reset = false;
+}
+
+static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
+{
+    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
+                                           device.vbasedev);
+
+    return OBJECT(vdev);
+}
+
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_pci_intx_eoi,
+    .vfio_get_object = vfio_user_pci_get_object,
+    /* No live migration support yet. */
+    .vfio_save_config = NULL,
+    .vfio_load_config = NULL,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    AddressSpace *as;
+
+    /*
+     * TODO: make option parser understand SocketAddress
+     * and use that instead of having scalar options
+     * for each socket type.
+     */
+    if (!udev->sock_name) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "Use -device vfio-user-pci,socket=<name>\n");
+        return;
+    }
+
+    vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
+
+    /*
+     * vfio-user devices are effectively mdevs (don't use a host iommu).
+     */
+    vbasedev->mdev = true;
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
+                                          vbasedev->name, vbasedev,
+                                          as, errp)) {
+        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+        return;
+    }
+}
+
+static void vfio_user_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    device_add_bootindex_property(obj, &vdev->bootindex,
+                                  "bootindex", NULL,
+                                  &pci_dev->qdev);
+    vdev->host.domain = ~0U;
+    vdev->host.bus = ~0U;
+    vdev->host.slot = ~0U;
+    vdev->host.function = ~0U;
+
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
+                     DEVICE(vdev), false);
+
+    vdev->nv_gpudirect_clique = 0xFF;
+
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices.
+     */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
+static void vfio_user_instance_finalize(Object *obj)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+
+    vfio_pci_put_device(vdev);
+}
+
+static const Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
+                       vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
+                       device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
+                       sub_vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
+                       sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+};
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
+    dc->desc = "VFIO over socket PCI device assignment";
+    pdc->realize = vfio_user_pci_realize;
+}
+
+static const TypeInfo vfio_user_pci_dev_info = {
+    .name = TYPE_VFIO_USER_PCI,
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOUserPCIDevice),
+    .class_init = vfio_user_pci_dev_class_init,
+    .instance_init = vfio_user_instance_init,
+    .instance_finalize = vfio_user_instance_finalize,
+};
+
+static void register_vfio_user_dev_type(void)
+{
+    type_register_static(&vfio_user_pci_dev_info);
+}
+
+ type_init(register_vfio_user_dev_type)
diff --git a/hw/meson.build b/hw/meson.build
index b91f761fe0..791ce21ab4 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,6 +39,7 @@ subdir('uefi')
 subdir('ufs')
 subdir('usb')
 subdir('vfio')
+subdir('vfio-user')
 subdir('virtio')
 subdir('vmapple')
 subdir('watchdog')
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
new file mode 100644
index 0000000000..f1fee70c85
--- /dev/null
+++ b/hw/vfio-user/meson.build
@@ -0,0 +1,9 @@
+vfio_user_ss = ss.source_set()
+vfio_user_ss.add(files(
+  'container.c',
+  'pci.c',
+))
+
+if get_option('vfio_user_client').enabled()
+  specific_ss.add_all(vfio_user_ss)
+endif
diff --git a/meson_options.txt b/meson_options.txt
index a442be2995..97d3db44cd 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -109,6 +109,8 @@ option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
 option('relocatable', type : 'boolean', value : true,
        description: 'toggle relocatable install')
+option('vfio_user_client', type: 'feature', value: 'disabled',
+       description: 'vfio-user client support')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index f09ef9604f..2c5673769a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -201,6 +201,8 @@ meson_options_help() {
   printf "%s\n" '  vdi             vdi image format support'
   printf "%s\n" '  vduse-blk-export'
   printf "%s\n" '                  VDUSE block export support'
+  printf "%s\n" '  vfio-user-client'
+  printf "%s\n" '                  vfio-user client support'
   printf "%s\n" '  vfio-user-server'
   printf "%s\n" '                  vfio-user server support'
   printf "%s\n" '  vhdx            vhdx image format support'
@@ -529,6 +531,8 @@ _meson_option_parse() {
     --disable-vdi) printf "%s" -Dvdi=disabled ;;
     --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
     --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
+    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
+    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
     --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
     --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
     --enable-vhdx) printf "%s" -Dvhdx=enabled ;;
-- 
2.43.0


