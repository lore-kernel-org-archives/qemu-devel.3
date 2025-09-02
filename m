Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6464CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUMx-0000x2-Pw; Tue, 02 Sep 2025 13:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1utUMn-0000py-Js
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:00:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1utUMl-0006XD-OC
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:00:21 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 582FLq5j985391; Tue, 2 Sep 2025 10:00:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=N7ziwNP2pspRG8XQsAytjzphrdrMaHWnnRMXRDI3v
 8k=; b=E1qQB1ce37gGdjEJ6CbxJnj/Osyq05leWNzNAi7G1NpUFXUSYv5KDe1sS
 OJJU4TeeNbWkVul0zaKit8eycRw7tUJaMhiPdaC7rvXuUJUEn02wLJTcvFijm9ub
 mMoNy6p9lMc0xrUMLDNd3zweyZvUE3W140VUJ10rKGxFmBf1RCyAsuAAyMkf3cB+
 dZbjLRF1PeAGJiYX/vgGIPSUGQdFQXHseHDucnUt2o2G1CQJhPxjMkS0vAuWtAhG
 jltoNz754W7esfSv7hDxpSN4Yolxj1RCx1U7AHrB2tZnF9skhxN1t57m2eywVjm1
 qRdXDcSNjQQmv+ZvvU3TtkZK9CF2g==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48wew4jman-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Sep 2025 10:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVSsqMpRMRY97Y/LY/8DdZ3fNNk56/+63VRinyk5b7tJ17M1iVhaK85p3pcRDlIYukD+thSHh239A9CLLE5fcLm2o1x/mEb8VCO5WgPHg+k2YJ2fDVVwZx9udSVq8NItuaWv0YPdGF+UIszTozLBzktRSfdsqnC9RwdOy/6BM5eAwosoUJE31Ax6yPul69o9IuK1aQ9HG0hbAN6+dvmnHxCmSfUV7vOGfz7mSdf9lJwpu6i0Ea/gjsJz4S7x51DNUiigA1vIitPqDqnadMmIRz8lJDNQj6EPNrExe928JJCSJf3wTs6gEqSBaFOF3uWxDvISkYSe+LOk2woKH25HEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBdcsU8LdLUQ6bsQD9fFTQ6/ZAdFx/n6ljoVsyANuMQ=;
 b=mQFtG+KzftlKBBj5Ojp+/A2Gig3BvfePOjK7FdWt7JUbL+DZxhbIZpXjsDMyjdc6hjuzKV+lgONCl3dtiiNCLatGbqvUWs2TrS3mywqAVBc9QtdLcT2LnQaCpF77RSkOTYaUW9pWP7HopdEZmhnr0BV60yBdqE3x8/nys4seh1LrsMQQ5iD292q3f543PSC3Ob295bOZlaGb3NHd5WXh3XUsvt72iH+6zmtiLEXssHZeW0MREV6Tx94LDa9wUqnH4UKulKbWTqRkfINKqnMeH0L4V+eLTujPZYWYBvHAAX6wvucPOA1fR+CkmlHqCj3vscczmAqLiMMRpq7sjqWQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBdcsU8LdLUQ6bsQD9fFTQ6/ZAdFx/n6ljoVsyANuMQ=;
 b=s2vRH4oCi3LsTaknzR5D6fyGtCopYuP6xHG66wlAwuS2I3IU+0sBXmB61CTL4/969p0WkNRyqpvw8L9vDWKeZ7IWkH4k/cQrHD6cENRAxs/o6meLwNwPJUlcNf1XKS22SNm1TyDT7L48Fu8rmsi07a2nr+n1pwj/NLYfElsD8JTXK+x8QdWr248dLpKBENUWZLvq1gAR7o16YgB/0z2BSnShdcTlOshEn5JdXcJiH7pvEVMY6pKLtIqXx6tJGzHIfOhoBfIQr6hGxXNfBhHmwyQ3OQLtcfsowtH08abjvPpbKFzewLuMoHImewPnoA9Me0HmMSfEzEYFRLIhuWIqag==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV4PR02MB11050.namprd02.prod.outlook.com (2603:10b6:408:2d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 17:00:12 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.027; Tue, 2 Sep 2025
 17:00:12 +0000
Date: Tue, 2 Sep 2025 18:00:05 +0100
From: John Levon <john.levon@nutanix.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH 1/4] docs/system: split VirtIO devices from the rest
Message-ID: <aLcileMLBQjkFZ8s@lent>
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
 <20250902165048.1653323-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902165048.1653323-2-alex.bennee@linaro.org>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV4PR02MB11050:EE_
X-MS-Office365-Filtering-Correlation-Id: 49dbc074-15e3-44b9-419f-08ddea422e37
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4F/LMKo6ZorphAbiWVPvYGj35zvEHkpvXgIDdVCKPPEMtEEeoZbrHT3h0A?=
 =?iso-8859-1?Q?xmBhNS6CnTIsvXbk0CYkQGOVMFPwCfa9IFDYINAP+0CVkk/V5mo3t1j/Pm?=
 =?iso-8859-1?Q?6iul5S/Q7/IQE58qUS2/py5G57CjcAfrBOYxWLdu55XcC6syEh9YQKoSEp?=
 =?iso-8859-1?Q?V+AlK0j+N2S2r57fkNKu4eM9pyfuRMWufz6u4U6rgIMGWuzlOtqPe6zvvP?=
 =?iso-8859-1?Q?H9fUnFYJiKppQulmilOelQxLGQX7rWwYyPwmynoEoqfwQ8qwUawU6ehNkB?=
 =?iso-8859-1?Q?/jivb6Tv6pYM/r3G0xq15VnG9ljSgwyivnOrxA4nDJ3S9GmKl2/7VTYDrq?=
 =?iso-8859-1?Q?hey3Ejqai9RAxQz+l2z8jFKPvXH0DeD6+7bZjt+Bf1zvLyVYQAukYB3vKQ?=
 =?iso-8859-1?Q?tUJLTjuWQNkn+LfkMXy6XQFJajXtlm3JpRvdGGxI4O9poluAr5bmPLZMS7?=
 =?iso-8859-1?Q?J2+dnSaWPQ5b7Xj5C0ooupkhtoiR9zuve6h6qX4OWroQ6Z94wBo9UKcSZW?=
 =?iso-8859-1?Q?ZwqyozvZ1SZO3t/cTTkQfHuVfnlrebsZh8FGJWe7MzDzILILegzsAsjiHR?=
 =?iso-8859-1?Q?yripVWDT5nZRi11zyhD3HRyMAHsxjQbF+3TKwsf2y6I3lEMn/dMDgnS8Cd?=
 =?iso-8859-1?Q?z/XVjcI2UU7NAGO230wqPdYDM/BpEkHNd2//Kh9gzTCdiwO3Otyp30HT4y?=
 =?iso-8859-1?Q?wYEKKrK9XlimNv0+mcdDMwLiEGodBCtYkgy8xYDwXMjlCSoeQSufGZxolV?=
 =?iso-8859-1?Q?+4TnZu4eeupEf8YLO6peXCV7Q4yLME5DLlfUntuGm7ZInXGLXc5pbCTFwt?=
 =?iso-8859-1?Q?YaYvsfRGGOgNoH7ByHeKUvVV/f0y/Vozt4zf/lwPM4rXX1SS5TmdrW48h9?=
 =?iso-8859-1?Q?BWGTuW6JohP7Pc3u4s1OVzGAG95fGrA0kE6mgNy1EVhHxWMSCuT88XvzL4?=
 =?iso-8859-1?Q?NODXOFIlpECTRvGs5AnjoEulwtMGnrB5whiHF7f7nERawQOGWLEVD0mxLh?=
 =?iso-8859-1?Q?94mX6PJ7dzPdwt+bap8kuDrz+5J7eLg7zSZhsMvA6/aRSNrLVXQ8vF22xB?=
 =?iso-8859-1?Q?NpeUE1JfP+6uj62y99dq1w1livXxYqXDODeoGxY12KNBCdHhhxFh1kvX6P?=
 =?iso-8859-1?Q?RgQVhVQo7rakqfqP8EViOUn+bg7tfft4OdVEc5WHrrFxEQb3tJVwnKmING?=
 =?iso-8859-1?Q?q/j49rM0+biWldjKQ0j7j7/lLYtCL+ROref3mirKe8GGOHTbjoq/AJOGGf?=
 =?iso-8859-1?Q?lpDYmW0YIYUjIbRszylh01BwuezCpnt46kAxaLuYyw2CEAEM/aOGTpBjuO?=
 =?iso-8859-1?Q?nRNv4GkO0jUtQ1rFUhPc70QoT1HoraXCO4G20u3NH83KqiOcMc0L8MJB+K?=
 =?iso-8859-1?Q?RAhAsUbRoXIcRIKRjM/Dk4hiaJUVC7H7juYwduO8fxKHZq47efY1S955sS?=
 =?iso-8859-1?Q?pqbAtvMWrrMrOidS+5jLdqXJZzLCen0vG9iryL11zU0D29nzx4yLlSik5X?=
 =?iso-8859-1?Q?8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZjIWgpC/lEFWGrfNbT9qz7BPTA7iqRETYZ1wnjeOlIpYmr+f9TTfZBicVk?=
 =?iso-8859-1?Q?GYnZQmQ98CmETYTEsOT0oYe0B1WAN0TsIKpCLHlo4FURHhgCadJPE7QSxX?=
 =?iso-8859-1?Q?rEAMaKHTWjEb7rb1uKOYEVTpaNgfIdRxTVaXrqvUPNmpOSORNIhesF7/um?=
 =?iso-8859-1?Q?7R/b6lATQ6Ys1roMT1Spy0mgknY+xWzCdXB17kSj4ojpUxHlHI+D05gNYE?=
 =?iso-8859-1?Q?ymk7BJWLDcRB/JAM5Q3s27Yh4R6rrIv1aGjKct6rzMOUgorA3OJPMCoBLh?=
 =?iso-8859-1?Q?VSIem86Uc76s8loQGfOGQMVG3sgfOWcoY/qc21IG4DXw9z4B1rQLvL3Xzi?=
 =?iso-8859-1?Q?Y5rYSKEZL9RziPM0SqOZRi3SI8xNMHBYIFEY4hM2TUowWGu3D8y9czyipB?=
 =?iso-8859-1?Q?49oHplIDSm6rhDW0yGntNVyrMMuJKCWr79wXB7NRj5PQV9L+NMG4McEbrm?=
 =?iso-8859-1?Q?cAxJQkiG8fYI/opcf9WYcbLWACjtYPG3mPaalVpeauuUJPoIC72otPMG2X?=
 =?iso-8859-1?Q?sTc9IupFJ0L8APQMiVpOs18MzeaTPlGGGaQ+lN5H9aVW8b/KlhatROKl33?=
 =?iso-8859-1?Q?jMHrQqhfKyMgDZqdVCmkzAaGcL4UWYOP+GahOAia0GCFjKEro7ynGIfoqq?=
 =?iso-8859-1?Q?yd2B+32T9DIkiqt1HH7fMxI+VGEtz6zK9eaZR4YWuroqH+H/68+48Kg+WN?=
 =?iso-8859-1?Q?/XF7g9O6QWwIoedSvZYxLDP7oeJZ8iZxySh7/igM8dWLM2CgJNSFXeDoxC?=
 =?iso-8859-1?Q?B+7o1uIHCSqE4c/71hhvK6Cvo6Lou+nnVONBXlFy9cvB951qVDP/1iSaHV?=
 =?iso-8859-1?Q?c8VUpqS5zaQF2kF9tDef938Mabln5N/HyMfGa7f/NBHRX8xOnbC/sZO//n?=
 =?iso-8859-1?Q?7fTRz993mjwBeHKsu7Qua0YqlmUXIm07oNoGFmF3Ezo5A1z12Y12xQgmTX?=
 =?iso-8859-1?Q?lqBLVc5fIay8AevplAf/cZIQ/Y1njpuUcBG1lkHVi5WNsUu/HSortUznp+?=
 =?iso-8859-1?Q?eQksaWEDXinlZdgF+8OE61HSypzpJUJLtGNL7uDawwmVbtgIaK+Jz+7FaM?=
 =?iso-8859-1?Q?OdKrySy14gV/Jzv4gYXfnMhkqjyp5gz6r+kZQsUXNbIuCBzX9ZTkkJueee?=
 =?iso-8859-1?Q?+0PwObgmTsHL0kA4de2sQdlTRZ2gB9SYMtrSGYUsU6+DOMapDsFfo7LXtM?=
 =?iso-8859-1?Q?AO75zQ/ED5TfBP/whlp+QAiTXIZN5EMWJ3h/3j5y8QV44bTNbTmIA3+Fv0?=
 =?iso-8859-1?Q?6PeETHsnWTlfDLiIpBBfR7Hk4AekoTAftuMvrzcNFpfYhVjvuJ0CZUvISx?=
 =?iso-8859-1?Q?pv8FSq1rlqO1WIlNXEp5A/JryLrr60mpJsmZ8kF4JYPIG12qXIC/PXFYSJ?=
 =?iso-8859-1?Q?eFOpxPeqdW2lkHYnBA7WrmMYNvx0RQ/lJpYAt4RedFpUTdixBUJXxOwQYj?=
 =?iso-8859-1?Q?V4WLbXkEjKDOLGQW7kzGr15HFskqmY2D6u1pM3BVqXJfrfTx/pwTf6WIS5?=
 =?iso-8859-1?Q?K/3mMkvTHMl+qFaJvx/XeKRJg/eOABX6y2BeCVnxpvSPL2s9RG3bgI8bHj?=
 =?iso-8859-1?Q?MFOLAOT5EIV4710M3Qf9n3YoVgEFPCmibbAPFSTxRD4SNHUTbUu+GC9Cez?=
 =?iso-8859-1?Q?whm7EhgULA/lSq7W4daNnHGci8CHZ0579K?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dbc074-15e3-44b9-419f-08ddea422e37
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:00:12.3841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQrHM3ZzQwLH8w88bmC2OaaRmMl5xmqqVJqB7W6HTUlbbSnIflRY1aN0KGGVrMk82bFE3Gubj5mpFODVtP8oPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB11050
X-Authority-Analysis: v=2.4 cv=LeQ86ifi c=1 sm=1 tr=0 ts=68b7229f cx=c_pps
 a=PuycMPbAwArgayjkkQxHog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=vYx1NZrNwJsMaOGXpkoA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xXoIdnwf0bER8LKMrKbSAzGim__Yv-cz
X-Proofpoint-ORIG-GUID: xXoIdnwf0bER8LKMrKbSAzGim__Yv-cz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDE2OCBTYWx0ZWRfXx9YeT60WRA3D
 mG4FhIJ4zzmKm3YcLzuAOKCA5F7V/dSdqqn1ne6hjAvUVL36g5wPIdmK3OsfBtrHu5LVquymKj3
 JEmhz4yLHkhG7AVxvyhqpLEmWbgXAXIBGyb+A1DVowH0YXm2wjIhpdveMPiO7r0z3GSxLx2XdxT
 i4+9zSUQhHjDB0I8PSmCEutkUSe9tLz8ex3RJnyWR6N/rqW8asScnx4RcUqJH69hg05u3H7M8Z8
 cSB6JpPCcRvHi1ZY0wFgqupnkbw96e7Gq+hnTULVUDV3JKbLH+nGEnDsIaQ0pDTXpwFnhz9lQNH
 7oHsa11Ut0nmyVUaFshS29YO0wetsoK2Ot2NG5T+d/hybc56ovQUcR6bZfmZ9k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Sep 02, 2025 at 05:50:45PM +0100, Alex Bennée wrote:

> In an effort to tidy up our device documentation split the VirtIO docs
> from the rest of the index and put the index to them at the front of
> the list. Sort the remaining entries alphabetically and tweak the
> references appropriately.
> 
> Add a short preface to the VirtIO section nudging users to use VirtIO
> unless they specifically want a particular piece of hardware
> emulation.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

