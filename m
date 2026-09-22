Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5DFC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y72-0004D9-TE; Tue, 22 Sep 2026 06:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y70-0004Cb-JG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y6y-0004Us-8M
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:34 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03sRm2606566
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=VziehuungsKb5
 5iKukInnJH7qJ4ArfTCQmFnQr5+8Ks=; b=KU7yM3EhLsYlUklECUTqU3n2xGY2H
 /N9vv74ha0thThO5yBluP+H6rPCTckVzhibOsgt1W+AlP8BfqNBZf9eYU+00UDJ3
 4vExfjhZOyligmDddSQaqPawPJE2iJQGU6CKJCjzlwkLQqDUZK0xphy+lYZBQLkx
 bVCAKHlOCcpCmiZiM0lTX4jHZsBnghqlCYgr782oa1otBdLA6SOrjTQ2InvUoUQe
 HIN6IdCdrdIg3cJYqiimQr9QMnGKkVgAiOKM7qtsriLRDIZu8AYUnD10uG6LMSrU
 wrJ7V1mHpJk4BPZszEwytYmQ8WAVVf8lsM/rqgrJZOQ1z39UoSHY9zqJA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021078.outbound.protection.outlook.com [52.101.57.78])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gspa76eb1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbhGSxP4who5xxTyfzlzSlLdsAy8+C9uQFs0XjjF38M9rStZSEt0lpHyGiSpPD8K1Tsi0JN1YdQT6Fas+bQyXCtIYPyceyKX99RknAiDWQOqxCliebyVYaQO2mIF9Ihz1dXyr3r6zIYd1jvBKtHkLkaNIoggI+1LVhUny30qLuQLziryh7/5GZTNGIJ/deioHOHXhcL3hFz0xfBrpAsbJovNAuFnnXObbjMhlMc7zWAyb7PZAuncHRKaLfEaD5zx+aJOaTuGl4ifOcPpKlZOJUGPjoOJ41aPdnMfk4lERH67DDwkmWHTdN/YkuxOTJWLJYb9ey55CvetJpae+VCs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VziehuungsKb55iKukInnJH7qJ4ArfTCQmFnQr5+8Ks=;
 b=UBMgUrkSZQPEFohARFZVOmtDGKVhRBcnWwnK5JWf0VeceuMxCSsZMs3PHdJhZQMQPkPzxrhrqX9icI+Q1Objo/h3yUEZWkfoOzNbqrdSOiE9zWP3829NWmCz1thaM5mFimDz8eYbgAbPZ3G8yuzeuJBM977ejtw13QaWyBgLlOunqRY4xA0TWfCRR6AOfFmRoNjPZKV4/sVMaW8PEfz7G12KQ5ETwD5pSGX+aizbsPKNV3taK36G4eOcLKyP8hMSpDSsS/3GGtDYuop8C79GgLHvA5Jwdv1SHFlcpYvmRJ32hDNjI0Mzhw42TkFrsgJ+puhDEOCSRpBObgdE2j59Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VziehuungsKb55iKukInnJH7qJ4ArfTCQmFnQr5+8Ks=;
 b=ppR/qZnpwNBcTnRo5k78nd51QKgvMRIiQIDmeQeZ5iDLy/MfEIaZl52z80jTL62SIjI/mOQgIJ59ey2wQ4iX0mfwL8kepPADWeg8YSInmTFuD/6g0owqvvcqMi0iiIjovccHnCJAeyfqkx7eOfihDLRzLCXhM7Fgmh2jgkEXOYpt2d3lUfOgvoluETQayOjyZCuk2jZ7r1QwtO99iJLTqVQQYFh1QroKIhM1aX1oywJXRNipFgstBFM8PurKPTk2Cm9pzp/MAliyRZMLl1Z7A3dwC2FIgnOmgt6Qje2n02hZmmYe7An3trmIkzG3zfTqcwmJqZmCqP8Ssy3y88krcg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] qom-qdev queue 20260922
Date: Tue, 22 Sep 2026 11:51:28 +0100
Message-ID: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: c49e4a8f-356d-47d1-78ed-08df1897976d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: zx8WKgQ74d7imFKYvPtmQdwa7SKv81VrDLuVmuRRfUImgVrcCvCEkSSON3FVHLMr0Xda//11uKiloNIybozhOqTeVEkxSKqNup1Xvp4KRvQF22oj4lkV7y2sEm5IeFjINgagzBTuWPN3dEfCnx2DyYLf5y4n7hIpVWz3bFtRWlcKvdoJhnZi5xRGeKJ6C0nhiC88nSg2oYyXddniwffYq6ndf9sMCr+mduQAhZrzg8HueftF0e5ikksEKVwmGGWvIxyMyaNYAapuyw7MdmxH0W6N8c2Q5arsQzMA84iAzos9YoqOaewBV+WppyWrzjIvYu9vGq7KS/1JGWh3WPfFGdXUXZtcjmsVgCMR2GUTHkVXjSyqFx6Ze/8BVDcP6NUUZ6XT5is/aMn/l13difqnBs/L8GW19mS4QZSDeE66HaVd9UKBe1IvRuLzv+VJKv1Qy5XtSpbJkRU8w0q8mUEygU+EWM0a/kKm40TNsc5p28yTSb1wjC3IstVZVcVn4zmGcXrUfztAV60bu9lxVNdkGpm5A7G9Zl/xr6Wl302b+iqAKhQgM2CjFbt8/qdhRyosR0VewwkW4BwToecSI7HrYdlp3ySwpxrCGXovoSC3ELoQbxcJEXSJm8bCcMQqkmySvRxtt172zWI6dlJiJfb8FBwcSpbXaxjPvHR+YuWJfmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9ROXBsUzNYMWxrb01RcFkyZDd3QXVLN2gzOHF0U1BaQzEwSWhjdWE2ZGxa?=
 =?utf-8?B?ZEt4eFpSbEVHVXFCOHRrTVVpRzRLSFQyYTVEellMNUdpL2c0R0lOU2I5OGNJ?=
 =?utf-8?B?c3VGSWViZk1iYXNJb01RUkt3UHkxVm5Ib2xjblMzNHhFRjhsejRGeGkvL21S?=
 =?utf-8?B?MHZEaDFBRFNBTkN5eVNFb3Z2amtWcE1BblJFd0YvcE5RRWU3WmZOYXpHbkpn?=
 =?utf-8?B?K2NTLytENm4rYjBuY3FLUkErOEJ0UkpFZzQrN2pyaC9PODhhb2xNWGNkbkhC?=
 =?utf-8?B?dFhna0dXZExyOWxhYUhqaUxjeDBQSVlicDR4RU1yck45VDE0MUl1L3FCN2NW?=
 =?utf-8?B?VlBXRUI4eGZIdFhLeVhDMEIyNUd2Z09UVkZLcGVoZ1FUVm1hQmZrSFJoSUda?=
 =?utf-8?B?eERCbXBnYk40RU56VDVyMnRkb09ScWdJZHRxakJYcFdnS3V5U2YvNmlvSERj?=
 =?utf-8?B?OXJ2cTNFMHVrRS9pRFlQeWxpKzBXbVMvWnRacmR2dmgzTUx5Yi9TVnIvaEx0?=
 =?utf-8?B?UFZWcGEwOUhsYmE4Tk1NbGwxRG83eEdINHdqR1U0eEQ2SjdFUWJMaVhqSlJH?=
 =?utf-8?B?bjlhbnJhUWlEOWNVOXRwazVGL010MzFENTN0bGlBa3ArblkwTkIzQjU2cmZo?=
 =?utf-8?B?SFh2ZUp6U3JGWVhrRVVobEVXamd6eDBmbmwyZm43ZWtZUDBEZUhKS0NMeElP?=
 =?utf-8?B?YTFNNUwwQTB5Z3BEM2lXSkFPTkdhOWhqVG9rbExvb2JTeEdDY2dSTitORXFw?=
 =?utf-8?B?aFpBc2phOVVSbS9Pa2x0QURUM2NmQ1FXOFh1cStURzVQdHdVTjA3ZkkyTVdN?=
 =?utf-8?B?SU9WMnZyTTlVcE0wMUV6NmxvWW5jUWRvL2NvenlIMGV3NXRRdTVidTFmY1F4?=
 =?utf-8?B?RWZGekNOT244blQzOXZJMHQrUllVNEZsOUF0amxRdzRDSk1xS0IzaTBJdTFY?=
 =?utf-8?B?dWtpUmU0Q0pJZEJQM2JxOVZxTDFqeDdzUXVqaEwwWXRFRkI0Q2U5Z3lOZGNw?=
 =?utf-8?B?QWpqRk83bGZEdXBlOFhFd2RMMDVYbGUya0g5NGl5SGFUV0tDbFVlN2JzOUZj?=
 =?utf-8?B?S1J3U0c3M2FnV2oybXdCNFVPdWpVSDRwdEVNYlFiQXdvOFd2TTVhMEd3Tndx?=
 =?utf-8?B?VlU0QUtqMUwzTS9LdU9xQzBrTmFuYzc5dkpORVJVQjJDRDZtRkEvOGJISWxt?=
 =?utf-8?B?ZDhEOFZlSXg5bWxXRzN1SkNvR1p4cEhkd1VIRkkvbkxzbjJlYUlFVDhUOEVS?=
 =?utf-8?B?b0gyWVBZeDQvaHhETXpwekpPYXg3ZkNWc1JBeFRrQlkra1lhSTZ0M29XdWxR?=
 =?utf-8?B?ZXpoUHhFQ2xaSFRoWUF2M3h3VzJiYmk5YlA3Sjd0U2V0WnNGT0NFNzBYWWFR?=
 =?utf-8?B?ZXBkc215Z2ZaNWdUMk1Mbi9ERDBtK0lYTUpoZXNXSkNNVlNsRFgzS1hLdUFO?=
 =?utf-8?B?R3NFd1ZXV2ZBRW1HR2dnVy9paDdkaEpwMFZiRGZCQXNDNFhSdHNBQStjeGU3?=
 =?utf-8?B?VitvdnA4dkFRbXNUSXpUbTMyV29wOWtFd1Q4MTJoaTYvekNyQURRUUg5aWlt?=
 =?utf-8?B?ZkpFdUpMSFk3d1o4MVFnS0liR1JSZ2tVSjIwd2cvaUJJMVR1RjhJcUFWV3Va?=
 =?utf-8?B?NEJZM3NYT2hIL0t5a0tUMitjcG5VYjhhUUNQU2tBdWlTSWRCbW1MRDBkOGpP?=
 =?utf-8?B?VW9iNTNjcjZneERjWXFGcnRPdHFRSDE2aGREMG9yYy9USTk1KzRrbUpibmFz?=
 =?utf-8?B?bTg0OW5hVUYwZEJaTGJRNnliSVRBK0dJT2p3RVkrUUlydHpMamxIWnBKMGVZ?=
 =?utf-8?B?YWFaV2M3Q0RFRnpZaFNoeFNNeGcrbEhROE8yL1VTWjI5SXJ4RmlEWldwSS96?=
 =?utf-8?B?UjJEVFNQMnlXV1BBOG9ranBZWWVndTZpMzFhbHhRdlpscklvaUg0MnBBMmh5?=
 =?utf-8?B?THAvTEYxY1I1cWVPMlpYVVNxaEpleVRqblB6UkdtUDRIeVhrbHpnS0xRbHk5?=
 =?utf-8?B?b1U4UHpYd25yMG1NUkhLdjVraWk5TkFxOE1zVU9GT2grZWJFbXlvbENhNG9n?=
 =?utf-8?B?VEdYM1N5S1RGNS96MlFVTVFOeTh0bTFIWlh6dHIvSU4rOUFLTXR6TlI4eWl6?=
 =?utf-8?B?SnFTN1I5U0lXS2FWaVFkMW5OSDY5OGNRM0NFZWxJQzhkSWM4a3FLSmcwSUVi?=
 =?utf-8?B?L0UzNDJLQ3ZSVkpnTEFaYnd3cWZyMEZuMTZGeUk4dnhVOGVCb2hXNHRXejE3?=
 =?utf-8?B?R2JnejJNSVFaWSt1M1FjM0lLNm1USjlDRHozR3RYRmZRYzd5eFdpZzZnRGMx?=
 =?utf-8?B?UkdpNDB4My9NREUvUUNQdXM1VU9BOFJCcnBkWm9Nd0NZMGYzdmlqNjN5QXRi?=
 =?utf-8?Q?4G4RuQSbkNcoKoBU=3D?=
X-Exchange-RoutingPolicyChecked: nw6XeWb6Nz9zYjssn6L3yg/50cMLZvG814/ITr/vF2Y5g4WLqZxZffK9DMCX8U5NsB1OYWyiRO1gXB+k4fJ/CiIBPXYibGRrR8VfJZUi0H2NVaRZfapZcSSatLQP6gsdPnBp8BaupRe1TsU0z2fqzPc8Vsu07HVYwtgBDcED9V3TcsOaeC56YxTkRRVr5Cmvc3cgfOgedn1nXjqjmjyxrecg7vTxiGl6TD7qB0Kv5pGcSEWktKJn9Z7JAzV9TGgxv/IohIGaU2zuWL0jIso8a/QR9W+odKrhxh8XRoBgVe7GAN8tWY3CF8+9kze1FU7wWqDnVcYNWs2Qrk7eOtP7qQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49e4a8f-356d-47d1-78ed-08df1897976d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:27.0141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfxHVJvpbsxnOViY270cmVXtcxqz8QdK10WjJnaI+BPHrvSPnEP4PEfpTUYSPeX7U0UrFV8RlYQfenMy2MQwhsmyIlq2XUUJaXMMp2oSw/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Authority-Analysis: v=2.4 cv=fPWsTpae c=1 sm=1 tr=0 ts=6ab25dec cx=c_pps
 a=sajROsZvL5DJSFuOmYePsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=p0WdMEafAAAA:8 a=HefdGQujqfxLRulFyJcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX6whU8hIXW/mL
 D3LHUhSfWoZEPzfzJWtcG7uGeNDwDSHX9QjR517Fr4IccOnGRR4Ciis7xRhAhMikCRA0uPWnBzB
 ovBhXLgOnPAzWme1p0E0wLxOGL3gBWc=
X-Proofpoint-GUID: 7IS4GN3dUOVVcm81xuDvDrs4ofxob9Tp
X-Proofpoint-ORIG-GUID: 7IS4GN3dUOVVcm81xuDvDrs4ofxob9Tp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX4VuWmGD3heKC
 wtc5FWNE/SZN8FTQ31nK6QgB60WWaCL4ELetZP4wiitOB3XVMQu7Cx6ls3rIxUs6bc4dYiSSw7u
 ZjZOj+fziIIqJv5qvGbR73LW8AVYP2DIE1Y9/GS91gkZGHULyXuv2HUALQIKSUwjkqYEv6+gaT1
 ZmpEXyubdYS6j7GfqQBZrMUmR+X3NzsteANUqK/HOQh1QkIqnDaL1XVL+vJr/7i29vxVUDS6U/C
 gChf9Tj7Ic6QxUVWMDWpaTjBNW3yhd58hwPdy6idzN3KXT6NomyRVRGWww8V5U4Wcv0lZalMLNp
 xoDjQJgW6f4ogREUQUu0DEOA7w20LwRg2SG3qlmEzWxDUdjEPPYzTm/ipqphFZbDcduOe9/MhvJ
 wOevZ5b97Rtcg4KjGML9fQNqEeGVXrI53ja8G0hso0wqzNILtaWGjGtZtymQZHYRCb99JKcc/R9
 Sdk2nV0dpXODuxRgyiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 67166d97a3269285aa68c489f85c9ccdf78495e1:

  Merge tag 's390x-20260921' of https://gitlab.com/efarman/qemu into staging (2026-09-21 20:53:03 -0700)

are available in the Git repository at:

  https://gitlab.com/mcayland-ntx/qemu.git tags/qom-qdev-20260922

for you to fetch changes up to 3e4027a5c0ffc6afb3c1d298a2d88d433cac5f7c:

  hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop to class prop (2026-09-22 10:52:29 +0100)

----------------------------------------------------------------
qom-qdev queue
- The next set of conversions from object props to class props

----------------------------------------------------------------
Mark Cave-Ayland (10):
      hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object props to class props
      qom/object.c: improve duplicate class property detection assert()
      qom/object.c: introduce object_alias_get_targetp() lookup function
      qom/object.c: introduce object_class_property_add_alias()
      qom/object.c: introduce object_property_set_alias() function
      hw/i386/pc.c: convert pcspk-audiodev object prop to a class prop
      hw/i386/pc.c: convert rtc-time object prop to a class prop
      hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from object prop to class prop
      hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object props to class props
      hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop to class prop

 include/hw/i386/pc.h |   5 ++
 include/qom/object.h |  42 +++++++++++++++
 hw/adc/npcm7xx_adc.c |  19 ++++---
 hw/i386/pc.c         |  29 ++++++++--
 hw/i386/pc_piix.c    |   5 --
 hw/i386/pc_q35.c     |   5 --
 hw/i386/pc_sysfw.c   |   7 +--
 hw/i386/sgx-epc.c    |  12 ++---
 qom/object.c         | 146 +++++++++++++++++++++++++++++++++++++++++++++++----
 9 files changed, 224 insertions(+), 46 deletions(-)

