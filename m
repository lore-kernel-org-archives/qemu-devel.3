Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E149BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kE1-0006at-32; Thu, 25 Sep 2025 07:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDE-0006R5-6P; Thu, 25 Sep 2025 07:32:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDA-0008JX-14; Thu, 25 Sep 2025 07:32:35 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PAE9Ov1851287; Thu, 25 Sep 2025 04:32:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rx9ZWy8U+8fAs58ooYTLzz9F+VvEYePldHNDa7Xfz
 WU=; b=ZQJEwjdqAFJn+WbgBR9Eg1m57NXmiY5AXPP+gcM0mXlAXvGXAwGs4lzlI
 aAGekewxxR4iEfIw84qJyliiC3F8mOZITV88QnE04bS5ixTsshnIaFqCypWU8ZHf
 SbawOrX7SVtoe1hAyOvmEZHs2pjO7Puf/nrFDEamiEv2l/55upnsR++UpLoK2Q/Z
 uLXqisb17HXfUKYlMB+taUXl6clgCHHEu3ZM6zDKuxSk7Mv8fX9xOS1XEMUgTURp
 7RbJIIdEY6bUyyJ+K2Nf7yaBQrwUM6uEO8aA/d9O8oqfC1jVzSVIp3h+kbGQi9yY
 E1errf+RfZWWqK6bi1ckmToAIWJOg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021124.outbound.protection.outlook.com [52.101.62.124])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgsjave3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQCgadgK12hIz9rc7Y9t0NAFgjv3jzedGFQStC82lT0XPxJS6u9k/dUA6W4iXCVEIFNQfVODMdyGQtAaD77bMssaJj0G8DxymFXW1jdCitqZl8vRlRIuvWYzlErQhWfeuMVrwu9nG5StQtK08W5Dq9y+JuM/n/bBYfF/E0ZlDV9UBPiQw9Ifr6fmFerUYVuusSVOyJHdTBPzZK0BFsBIvSFUWUs3S+Q17WLDaDDIdCcyzjW5WQbaSxLm787x4obn6kx83DTSnGxpkZaeJGdG3P3tWcDyWICNGX9/cJDYC8BH//104lyt5jsMIYTPDdIG3IBfrHSvD4xurXoxvCKUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx9ZWy8U+8fAs58ooYTLzz9F+VvEYePldHNDa7XfzWU=;
 b=lCRx6ABeVoc0ON5bfscm7ATPE0qpC9zN3QlxA6bw1M6IVYv08l22EKrJScSklbz3kDQgRuLK9kfhJ8TBiWDSzZzmmucTw2h8Su+bmWAacogeM7Fc5WRN064YGioKyvg1b46ObDskwgWgStJXIdX3y8YTumO8KvvVMcv8HujRbNpChU9X/TbStW04hbgPmv2EMf+I7ssSAqP5u4QWFiBrxJViBs6Ulhxp6BzZ7TEjagSz36U/GbUS/JVK0vEqqywwH8pQtm30TG7hhlAd3BEmGnXvlJAk6YXZIi8wi1Gp+YL7ltjHrN6h9DyEwTEFOSASkluY8aGURo+SqTqx5KVSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx9ZWy8U+8fAs58ooYTLzz9F+VvEYePldHNDa7XfzWU=;
 b=Qtsryrf2lZdfFudco5HC/ItBejfA2z3HJG3uzXGs6ba8wV3PU38iu6xYi/wta8dSsx9Vxp6JfBS0tb6gBZisg//t72U+YnUZ4vz3QwqQTubJmZcycOHqXgBvr8pA/rSjx4Bt2B1IHgMn94YpFTWH/wIZezbHykO73nNeiozX98GGGy0AH63ptzoqffX+bJf7APn6TSJ87Axl9qDGYGrU07w2Qw5nCsBeeFNUzNc2rIufRMyplyNo8IRcdyKCaVc2DPYzrjVm01agDpgqf/OHUw/hbR8SuQm7HL1vY0xTdMs1bNsX+4VQkQw0UrXD91eJQLSBxZLlSiv/sNVJw2k+pQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 06/28] hw/vfio/container-base.c: rename file to container.c
Date: Thu, 25 Sep 2025 12:31:14 +0100
Message-ID: <20250925113159.1760317-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0022.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 2822d022-c721-430c-e128-08ddfc27320a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTlkSkR5RkMvT2gxU2Ewa242b3MvR2d1SzRpd1h1eFNPbzZNQkdVK3BiMk0r?=
 =?utf-8?B?a0tNNEJRQlRENUZpNzROa1Z2c0ZmYlNKc2lTUTNJRTk1SXNHaklvYmhpZ0x0?=
 =?utf-8?B?SVFNbkdQZzJuK25JbytrWktROEg2SStkcXV3MVFoRHhjQ2VNOHpUbEJLTWpI?=
 =?utf-8?B?R1RBL3dFbVE2eXVzM0UwcXBacFZNZlByWVRCVWFYeEd3Sy9DRzhtU3gwVHBO?=
 =?utf-8?B?MXdMOUVyZ0FqdDdQK0h1cFY3cmc1R1dFREN2M3NJUlBLcGNKSURJV0NHaWVP?=
 =?utf-8?B?WnZjMU96TzMxU3BpdXZZb0ZQbTRZTE9VYWVWLzB3Y3psS2FveEw2bFQzMGpk?=
 =?utf-8?B?cHpQT1NDNXhhclpXZXJyYjlMNUswRnhaRS85bFlKRFlMWTFWWENHU0djU0tr?=
 =?utf-8?B?aDJhZDY5VGtIMTFSTUFKSURvbS9mTTVLZ0REVmZQaU1GeHc5WklKUG1sYS9n?=
 =?utf-8?B?L0xYRlhRNEY3NjhPQXBGeUR0ODBKejFqSWlhTlJsU0p1SGJOWW5ZaWh5b0JL?=
 =?utf-8?B?R1BCdDRaYnFtWmZyMmgvUHlsKzZWT0ZOU2xGRjRKaTAwck8rUmtvM3N3eHVK?=
 =?utf-8?B?cWM1MURUR2NJVkZ3RThFaUtpTWpzMWxsRnR3RzZ3VVpJZFIzY21aVHU5UGd5?=
 =?utf-8?B?OTl6bjQvZDBqNzk4bmg2SVl4ajBPbnZHL05qWlNwN2NzWjhKd1k5Sk41VTdj?=
 =?utf-8?B?dElWQkV6a2NnYjkzQ1BVZmc4VFhEMzVqL2M3WWsxck5BQ1RPeTZGSE1GRDZN?=
 =?utf-8?B?RjRaRTBIMEozYVdPanh6OFd4OXE3eHFvbGpLK016UDVOSlVaN2RqYjdxazI5?=
 =?utf-8?B?VjlvYzJLQ3JMR1k3WEd2MjAySVRSbks3RC9vdjZnMTdQVVdxamN6K3N5RGN2?=
 =?utf-8?B?Q1Y5ZUlPaGZINmJrQ3BGSzQwN0lyN1QxVlR2UXJDRDArNGtWSkZKS05xS1hx?=
 =?utf-8?B?N0tFanoxanYwMVBJNDVTTWtGdkZSbEZBeGVycis2anFFYjVuaGQ4VnpDWTRD?=
 =?utf-8?B?NEVBcXpjQWg0ckFGeGpmcFhaNEU2bmNzTUl2QVVNekFZWHRyWDZVRWQ1aS9E?=
 =?utf-8?B?NElnOCsrZjBCTE43dU9IZVhIQW1LSEc0UFBQWXNQcVczYnJ3blhNN2NudExI?=
 =?utf-8?B?K3p6UkJuNE5uWGFvOGxRT2FPL1ZiR3RTQkROQmFvcTIydStwSm9FMm1UdUI2?=
 =?utf-8?B?UDB4SU5RY2MzR0NHK3VuUWdhcEFIaVRESzBhSExyOTh0eWJPTnU5RUFOOE5F?=
 =?utf-8?B?RUVGZjRDWUxsYkZhQVNTU1phcUF1bFNtMjlKZHdMNDRXSFR1OWhGRUM2cDhB?=
 =?utf-8?B?ajNKU1VlYnlBckRoNnp0cVBjTGRpV2VVemtNR2FJUU0yOVg4Z0pWWnFGSWFJ?=
 =?utf-8?B?c0s4aHZNci9DMG9EbXJvMHJqSy9sOXo2RE1RVzMyOEFxZ0RuQUVxc094WHp5?=
 =?utf-8?B?K0hVN2t6d0p3MjREYUtFbkFOUUVRcUllTVNVMS80OWJydlJXcFR0TU1WbW95?=
 =?utf-8?B?VG80WWRITzJha2x2Vkw4dDUxN2VWZTQ4RjdoaWJGeDl3cDQ5RGR0VEdFTVhT?=
 =?utf-8?B?ckF0Y2YyNFVGZW1hRTRCS3d2UXphRWZqYnJIOWNDTmkzdndha1JkR3R6b0gz?=
 =?utf-8?B?VVY4VjZvbEN0NHd2Q0dMWjN3bmx6dVNrSVVMcW05b2FhWmdJd29VbmdEY09R?=
 =?utf-8?B?R2F6S1ByZDdBNzltUlBwbmpGQ3lESTFjZUNmUlVQak9WVnNOUlprcHFVRVd5?=
 =?utf-8?B?MVZxSmNIRlRENnFGOVRsL1dBRjR6Q1duWE9XVytVemtKd1Fpa3BWMnlhZE5M?=
 =?utf-8?B?anQ5ckVURWdKZmVCZ1R6R21vbVVQckNZNHlXbHI0RG5XR2tRL1E0NWNRSmgr?=
 =?utf-8?B?OFNmOWtXMTFhWkpXM2pUTDlpRkZCQWRGMWpzNFh0NlVUaDdyYlpiZC9OSkwz?=
 =?utf-8?B?azQxYjR4ckdMNnJQTWlrQ1E0TFV2Yk1NRVBpYWRLTDV0YzQ5QmVrV0FFK05z?=
 =?utf-8?B?WkVQZmM3bnpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9wdFcwWUpsZE1LNXZxaktvdmN3Mmx4MFBORDFEemFNb25nMThIc0VSOTll?=
 =?utf-8?B?L0N6MGxZUUFvRW1XK3dOVTRqT29BL0N3K3BhRUNxZW92Y21JU01RR2ZqTUFD?=
 =?utf-8?B?UTkyZEY0ZHI5MFJGRGYwcTY0ZzZBcVZjZnZFbFdrTmI3SzhjdC9zN3FteUto?=
 =?utf-8?B?Rmo2ZXEydW1CZUlWZ2VlSlN2d0VZRG5nWForWEZrODZKQ0JPekJtcUdlM3NK?=
 =?utf-8?B?U1hmN3pPSjZkYnVBUGdmK0ZLNHJyUmJWZ3Vub3RsOWRRT0w1Wm1CNGhyWXI5?=
 =?utf-8?B?VUh4Qit2WXJ5VXpScnF1L0VJMWhhNDVpbjd0OTZqV3BrRkJQT3B0SnVWYXFP?=
 =?utf-8?B?WGZXaTVLZzZLNGtZemdyUEUyK0d4OG5LTlN1REhmM2dlVEhFM2VNdFZxeGpP?=
 =?utf-8?B?VW9vbzE5QVdXT2hrMEIvV3hYL3ZCeDBhM3RBZVA3bkd2VEM5VmhtME9abnE0?=
 =?utf-8?B?YXVONjJUWDFsVFR6a2FaTVRIVE1haUFzbjFwUVBEcEpwY0FkaUxaS3pZcmx4?=
 =?utf-8?B?ZkY3QStIc25MaUhuU1pieXBnTGREQkJQQ0RQa2V1T09WeDF2b3RNbU9OVnp0?=
 =?utf-8?B?MkN6cXBkUWJ5QnR1UUY4MEVYMnhyNVMwU1hmUnFOUzAzeGFWd0xNWEVQNHNC?=
 =?utf-8?B?SjhQS1pkMUx2QlBzQkQ4WWx3bWpPSkxaaU9GRG9DYTZZaTROenVON0xmdGwv?=
 =?utf-8?B?bzhFcDdkcE9RbGkxV2E4UFlhbEpyNTVuSlV0VXpVQmZMakhEL1dBWFhxM1Qw?=
 =?utf-8?B?TkhOTHJ6TExKTDJaR01kbTdWbDhZb0hDNTVBUGRhcjZTR2ZzSGQxK2ZYbGli?=
 =?utf-8?B?dDFhdUg1Nm5BUjQzb1lHWGZFNFg3S1NHTVlnSEhKMEMvSG9pSWIwUUpySFlr?=
 =?utf-8?B?dEg5WWZxSTFkbEQwMjNXcnJnK1htcFhsckpEdXZNSks2RzRmK0M2cnpsOW1q?=
 =?utf-8?B?R0VLaldVYmRad29xYkE0Yk8xZlVBb0NpRmo0cThlYUNTU0h3SHd0c0pFSFk3?=
 =?utf-8?B?WGJiQkdydXRBbUFBaWV4djlha0JDL1hxZ3kxV1N6ck9xblcrbzVaRGdXd1Jh?=
 =?utf-8?B?WU9CTFNPWWxZcmpEcm5DcVBzbnF4bHFUYXRuUkpBOUx6dWRSRmcvZnlIWmFl?=
 =?utf-8?B?VlRLVGsrMFdndUZnWElFdWVMRDZyWGoxOXk5S1NqVTVndWR2SExqZ3Z0MEdX?=
 =?utf-8?B?OCttM011N0RVNUh6RHI3eXRic01NOXRGWGRjR1JCb2RHeUNCemlpVXZQQ0pn?=
 =?utf-8?B?Q3JHS280Q0xiK1hDdEV4SFJSSzRueEtVSElXMHZUWVYwNEp1aG5uY3c4Y1da?=
 =?utf-8?B?OGEzUGNTcHBmU1FSWmpRaG14aGNlMjFzamhJWXVQSE5ES0hrVlBremNBS3dX?=
 =?utf-8?B?ZXVpUHNSYWh4U1NWR29BMlhiU1VqSG5OVjd1TDJOWS8xaUpINitpUEdHMDc2?=
 =?utf-8?B?engzL0xXNUZkdGFocU9JOGJhNXBoUVFmaWlValZHUDg0U1M1VVFCSlFWd3px?=
 =?utf-8?B?WjVBRG9sdXVUdm1NQXh2Tm5SUTZoWWwxM2laM1ViYXhkWjRjckZpTnFKR1Ra?=
 =?utf-8?B?SisrVW9UOGl0RUJ4RnlTSjlweXZzQWdnVVpITjlnL1I4NHZNVFFuTUlNV3FU?=
 =?utf-8?B?UGs2Zjl2bzRUQml1bHhvWEx4VkRFZTV3R08rSmtaU3RMWVJLbjJrZkhtYnYx?=
 =?utf-8?B?RW80M1VWR0dmeW5qYWhnYm5Rb05ic0lLeFFFb2V3L2JDWFltOXNNNWd6bCty?=
 =?utf-8?B?aE5lRzh3dkJxT09pdnlXbTROSlg4ditYeTA2TW51T3pGSVFNeWxSK3pmbnhD?=
 =?utf-8?B?S0UyZ0FlbUF3aDdndGRWTHhmcHhManRkOFBkQVllcnFOUzBBTXRnR0o3NVN6?=
 =?utf-8?B?UUtFRG9USmYzWXlaL3FHYlB4bGNSN01SY01QbkNZOExDTVJZNzI4cWcxMHAw?=
 =?utf-8?B?YXQrMHNVNmN6SVdidzNXUTZtSmlYZU90NlQrYlJJQXdublBXQ2ViSENPMHpR?=
 =?utf-8?B?QzhNeDB0cm1oZGZjRzZtV2JOeHErN0lCTEhra0pVeFNBSlFRNTk5VWM2MXpI?=
 =?utf-8?B?azVvdmg5TWg1UDJjQlpqS2pCRlhhcjRRSkFlZ1NydnlybndRa1dwbU5XejFv?=
 =?utf-8?B?RWd0WWRlSk1HNVQ5MXZ4USs1L0lFVkxPeWE3MURrd2UwRDF3d3A3YXE3eDVT?=
 =?utf-8?B?c3RJTG5ublFCYUgzZmo5QzdWSGdYV1AyOHcwQ1BsRzJpcmxQMXdoQWJCV0s2?=
 =?utf-8?B?ZVNTc0tjWlQrOFduekZVQ2pIc1VnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2822d022-c721-430c-e128-08ddfc27320a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:23.1729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjOaxqH+rFxdhy/3c6tW3g5z2tRmO3dsPWyEk0PTtoT1Jak3tgAI6ZNxGAMlhIwt/JcUoEoZENAOnYtOd2eEembO1mSb8UWASOJn13mS1FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfXxBI0vkHyQII9
 Anaw1iGPoo5GhyUo3U+CiqcDZ4hq0fYfY8LfQVMjXi0x45fIzAdZYEdPQs62x1hQ6f8sX3rC+e2
 8SGeH4CdhQ1ewFxHH6FWHXpmMjNIqn85xldYjcCZtR0i/PudTafWc02T74rTthl+TASHgZu1roV
 rdDJRhzBkLLwMphGHWNRPhkJXOUBoK8lUvqPdWgnSzPR5y4Z2N0VY/5bEMrjGa9Tg2Yvl4RwfuA
 poJ0A9JEU0+7pZ2qJAnCZCPxbpm6mLdVtJK5+JlRudejvj20LEc85evN1RnnC4jVKtpFejPHP2g
 KHeUcV85nnn/gedTT89584+oGKiZN65gT78vr1yU2C5ZZhRW+rx5rPDZm9g2vA=
X-Proofpoint-ORIG-GUID: JW4vij2Y_3r3g0wUEDX9mhEEVykcGg33
X-Proofpoint-GUID: JW4vij2Y_3r3g0wUEDX9mhEEVykcGg33
X-Authority-Analysis: v=2.4 cv=aYdhnQot c=1 sm=1 tr=0 ts=68d52848 cx=c_pps
 a=xVCXbABICjn79FXy6fcvAA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=LUkFdQWdq7mprEPiGlcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Rename the file to reflect the previous rename of VFIOContainerBase to
VFIOContainer.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/{container-base.c => container.c} | 0
 hw/vfio/meson.build                       | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/vfio/{container-base.c => container.c} (100%)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container.c
similarity index 100%
rename from hw/vfio/container-base.c
rename to hw/vfio/container.c
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 62b7a7eaac..82f68698fb 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -3,7 +3,7 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'listener.c',
-  'container-base.c',
+  'container.c',
   'container-legacy.c',
   'helpers.c',
 ))
-- 
2.43.0


