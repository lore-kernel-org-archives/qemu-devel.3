Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C17E87844
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIwL-0006l7-Ev; Tue, 03 Feb 2026 11:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIwF-0006iZ-92
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:07:39 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIwD-0002Js-JJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:07:39 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613FHKlR2929017; Tue, 3 Feb 2026 08:07:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=yy616LJfi4j9TiCN6x0Prh4lJv1jaPZZyQunQ+XMM
 R4=; b=vrpNL41Ts1kjcrLe/xJeztfvAm/qdwiNmyDAct0TeNw+sBQVLOZ9WelcJ
 FLiqyyIDISR4PLzWSRBKxPvFvAvkldP2CUd0KNyLRrnr0QDWbNtQnuOZwJ4ayjV0
 pHvRVYJQzTNM4mKBA53z61oeZDM7zhA+m51RiPN6QlitfHqRLamPu3c2fXnhcI6p
 o9Oy0fdLAYTe0p+WC82kEcdh0bV7psIJqfVn+jLeWFgJRN6MCCI7MAIULlxrf/mI
 S4a7+U6JM5cLi3su3veUxH+6BdG7UCU3OUWC58nln5heZjbmWfd+IxJB81QvPfPu
 YYqye2qHP+fsrB4DggmJQ8ITC9TLg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023127.outbound.protection.outlook.com
 [40.107.201.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3kh684ce-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 08:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaGMlO4bes8Tj4fp3TReueqBhT0fyXTxuMIyIM5NNCHpdnKqkdCY1S4f4n0hzqUuuRERSoPR9WLhdVwZDYZmVhWf3kpVZfjhMdcFyI0F7qGz3UYrU7kr1sHhPiXv78BmblaGgvL9ekfMypjlX/P5UA8bgHc0pgxeIDYWBmfYL2f5xXAgClksOGaoQQAT7n2qTDHiBAPQPICVXJc84p4Vuev9Ry24wlCsWolbaNftNLR5K+/4KIr2Y0jyOMkQv+7zeLVAyNyUodocWAJb4Qwxk9TQ7rKuAf2ryIStIAaMn/yqZcST+bMSjwRYB6XKp77MlySJ4YYm3kgrJzJ2K48Liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy616LJfi4j9TiCN6x0Prh4lJv1jaPZZyQunQ+XMMR4=;
 b=xnEyZ1Gwou2jicsmMGxKHA/81iKFY6gU8cocMN7jC9bNJwU3yLUT1ksOXL4cw9uz8hGlDRIGPwRTvg0OWaHvNYUWq0+ALA+DDkTVlfVDJ2g930fQzVlJG2Bz+wYwPnN38be3w/cY9ubT5qZrW3xFAS5d6mDxn6ZuyOQGzYWfQKcaSp66V+MvpXwnfWzeu98J+Yfy7UYO64iHdxJ487fRg9OghWF6BKvIinJuoJKp948hIUxypTo0h+nbd/rg3IflkLdryVK69nh8os31ThXrNk18s4dTueBGkpTPLwTbuGZ37zppPQgAkmnRgAo9Rk/CSBM26hRgHHakh8TWxlBRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy616LJfi4j9TiCN6x0Prh4lJv1jaPZZyQunQ+XMMR4=;
 b=X7YSO9hcW0v6SC8RUsMORHv+BBMH3z9/z7w1J+MisZZW5dQLhwt2geG0H7Nj/6xmpGZ+6d2Ui8bkb2Ydd6xExaNjUl4+7y1szh9LAw0K+3iWA5yzZqxN5it1kRZ6Lk9vHC6RxRfQGBym6jih/bVgvMbHMe9E5ayRokDOH3XVgt9mgn85gYXUabxnuW/u1dseG4jXf5sD03gQrwALkljyodQPNnDSOp8c0tM/QnMyEY39iVGUJttazTgg3wXXF9hHOmEuOyYHeK2leBL5jKoibEf/bVtCVEyhoGutytzBfzVoPcWWnRomyVdq+C0C0Ll7MHD2s6mw/wKUqFn6l6p0Bw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM4PR02MB8957.namprd02.prod.outlook.com (2603:10b6:8:be::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Tue, 3 Feb 2026 16:07:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:07:31 +0000
Message-ID: <38c8a481-6277-4ce0-8a43-6f2bd25a02e6@nutanix.com>
Date: Tue, 3 Feb 2026 16:07:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/37] scripts/modinfo: add type annotations
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-10-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:d3::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM4PR02MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb271c5-63fa-46c2-e9ca-08de633e5579
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFBzWUt2Mmt2dU51YlFQbWdHREJHYTFxODkwSHplQm5yNlBLdThmeUJpaTlz?=
 =?utf-8?B?M0xDak1XTzcxWk9wVGtDNlBrUENPWVZwSWhZY2J3N1V1TEF2U25UV21PZDF4?=
 =?utf-8?B?ai94anhtV0I0K2t1ZnhJZDBNTGh0M0dWUXRoZ1hTNmhVVlArNGxEY2tYb2FM?=
 =?utf-8?B?YU43b1gwME5hT2MzNXBhUTk4M2ovOG1xYlFINjF3UTJoVSt4UkZFMFJBSjN1?=
 =?utf-8?B?d29iQmZNMm05OTVKRXFGeTZQYk9PMWU2cmd5OStpbVA0VzRJNkFxS2ovZ2N0?=
 =?utf-8?B?VDFmdnlDSWp5bWpGd0Rqd3R2R3ZVOHR6SVpCYUYyejVLckxqZEtsdWNxWVNP?=
 =?utf-8?B?ZTBGMTBLTlhHTlJ0YTNPNUFXY3BjWEloSlZQZTRHRmRHMzhJYk1lMzVGd1dE?=
 =?utf-8?B?OGlpeW8xR3RjajhGUVdUK1pBWmYzOFVERHp3aXFqM2pTR0xBREpQOXFpU3E3?=
 =?utf-8?B?THl1TGczTndaTTAyY25hMHFmSG83NGRmV09FckViZDFhellrQjFLRW9COHcr?=
 =?utf-8?B?ZVhhT1BjcFc1c3dKeDEyY3NERWJhZElKYnB6NzlXNHJicElYdUxianZPOG1T?=
 =?utf-8?B?aFpHKzk4cjhYcFZOVEo1TStCdmZmUkNNeVpPaHVnektRR01OZHhxYTRqcFBW?=
 =?utf-8?B?VFl2b1hCTmV4bDVMYW4xR3oya2RpQ2FYRVc4d3NoNG5BTHVIQ2JpaUZrWUVW?=
 =?utf-8?B?RG1VSzZZYzh6bnVBWGNHNWFWeTRWZHJwTVpSU29Xa3MrSzFsU3UyMUNLbG9E?=
 =?utf-8?B?b1lGZTU5ZG9LL0VLOFg5bFhoTWNpNXc3bmlYcWlXN3NERHBPM1I4QmZ0T2Js?=
 =?utf-8?B?ZUQ0NnlQMC9aNW9oUFdpdWNnU3piOU9LanREdlBlZTBxd2ZnbXJRV0FmQXlP?=
 =?utf-8?B?M3RlZVdBL04rd2sxWkx6WXExUnA2SzJZRHlKTVpnOHNyMVRwZWNPdzJQZ1hU?=
 =?utf-8?B?QlpKTEpTc1c4ZFFaU1preVloNlFLalEyVEJlaWw5WHFIMzZGODNyZzBIWmZm?=
 =?utf-8?B?UWk3UmYxZ3ZwaXlneFhuZDZqdW1KRFFkV3hnbENsV1k1YVJTUlJWQzJoN3Y1?=
 =?utf-8?B?elNTWHFLcmI0VFlneW4rV1ZpZzBJaUUwUUxUYUErVkF5SVFxdG0wMjFxZW45?=
 =?utf-8?B?bmY2b094dmdwTGpaYzR6TGtaYzJ0bVhwcUJ4T1FIanlZRGxmM3JXM2NmS3lr?=
 =?utf-8?B?Y1hKdklJTm56Ym42T1cyZElXSmVUVWpoWDhaSTVjcDN5NnpXQy9VZ2ZNSVJP?=
 =?utf-8?B?aU1JN1YyTkZwbVV5U0p0ZHdYS2wzL0g1VzExc2ZjNUUzR1JGaVo2aEpnOWNH?=
 =?utf-8?B?aE1BNWxxVVZaaWJnOHEzZm0xWXpjQjlGZkhzWFhnamV2a2Zhdk1pMG1wYXFW?=
 =?utf-8?B?bWdLNjNpZzNEclg3eVE4VUR0bGk1bTkwYWQyemZadmxMWjUzWG1DRU9KL0xk?=
 =?utf-8?B?dUtnOEgreWxqZjBqQVhsWXhnVkZvd201WEZsNm4rUkIxcU5GeHIrOTl2VTZq?=
 =?utf-8?B?bm8yeitMb0QxOFFkd0xpOGYwRWYvYnJDRS9SRHhxVjJHWWdrSi95OGl1YXo0?=
 =?utf-8?B?RUowb3JUeTcvRlhQVnpMVnF4ckZpVjJSd3MwQ0pZd2N3ZUpQMVJxSEtQQ09O?=
 =?utf-8?B?aS9qRm1SSGViSXRBVVZYall3NXpxVGFIVDkzbkJXQWFQTkR0aFI2eFZzQW04?=
 =?utf-8?B?MkJCcjJnWVlZYkc5djdzbUpMWXVvNTFieUh0a2EvUGNzRURxYXc0QUVWQTh5?=
 =?utf-8?B?VHRHOEsvTi9MRis3bU5qRUNxd2ppNlU2K0krZVUwUVRHb2Vwdm8veFNESWVD?=
 =?utf-8?B?b2FpazZmaFZTREVvcG9rV3QyampwN2N6YzdwQjZtUU1NbkVUMGVlN3FJVDdh?=
 =?utf-8?B?emlvOTdBekZIU0RnZWdwQ2J5Nnpxc3dzZ0hxWXJuWCtQTlZJZ3lIeDhKRFN3?=
 =?utf-8?B?VkRhc216MEhURHAzNGFRSFhlYVNpeE8zMDBDUjdZek5FR0EzK1JYU25xQUZD?=
 =?utf-8?B?STBTQVRnRnhjOWtWbVJaaVpwMFR0c1FCVkxHckJ5aUd0TWhzQURIN2QxelVh?=
 =?utf-8?B?a2dJVWFvWGZCUE45S2ZmR1FGajVGTTg4NStyYWgrTFlEejVkMVVpZUluSmt6?=
 =?utf-8?Q?Mqkk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RscVRpd3lyWnZmRFR6UXpjUVU0MGFZRHpFQ1lFeWdDaE51YmJ5eXVtaCtK?=
 =?utf-8?B?bkZTVDRubFBZZXlLNjErekRzbGxkTHdOUE83dGVJdVRQL3JSZ09kK2p1VG5h?=
 =?utf-8?B?QTJ4bGhPV3lWaktaV1Nvbzg2Sk1VaWlMall4UGZCVXMrMlY1ZXkzNHo3c09U?=
 =?utf-8?B?SnBVdlNXTldMczZLT0I4bkJzV1dwOTdqQU52YnYzWU9seE85a0R2U0dGYmJx?=
 =?utf-8?B?MWc0bzF5d2FFWEVKRDJmVXdTQ3lkZUhzcXhJcGdIbEdobFFBM25SaFdYL3Np?=
 =?utf-8?B?SnI5czg2T2Z5OEc3dDJHRzNqU3BrM2M1aGVJZWhJN2dUOXRUNGFSSGltLzAr?=
 =?utf-8?B?dC9oQzZkWHZTNHJ5WG12S0RvdFF6RmU2Z3ZOWm5HTGdQdkhLTUxNVE96Yit4?=
 =?utf-8?B?aFBDV0ZydXRBaWZzMUJXQ0puTm45OVNkMmxURlkxMXpiWXFUYTVzV1hNWTVt?=
 =?utf-8?B?OXRqWHpUM3Y2MzZ0VG9OL1BLelpGd0xnZjIvNlJzOWorUEFPaHM1TkRuMFRu?=
 =?utf-8?B?LzU5RUVoS1NoMENuZUF2RjgzQ1J1cUxRUmZuUWptS1hHdi9WTjhGa042MUZh?=
 =?utf-8?B?bzBmck1OYUlnYXZobTFJdWVScUxTbFE4STBPSm5Ld1ZOZ25uQ0pwck1FZ01a?=
 =?utf-8?B?MjFvZnRGTWRBNEkwMlZwUTNyYmUrT0tlL25xMTJHV1RJUmxoMWNaa1d0UFZw?=
 =?utf-8?B?MXduTFIrdGlUeUNKKzI1WTkyN0VEUlg3dDhwRU1sVHUvdm9iSnBtaXc2bUVP?=
 =?utf-8?B?dTRsVHQ2SlIrVy9VMHNSeXR2UURNQU0wcXF6aEtxRU5FZlhpdUxpZlFiZ01j?=
 =?utf-8?B?UjUrdVB6WGE0RFoxY2lqbzdGVkpMb1RCb2tBOW96T3Vzd2tWUDdFZ0w1WWI2?=
 =?utf-8?B?c0RsSFV1T1hVbExoODl2bkdhb042NldXNXhFTGQ5ZFJPYlZXbEpMQ3B4a3BP?=
 =?utf-8?B?QWNlTVRqVEwrbUdKM2dXT3ZEZ0Zqb2E4QkdoYmw1L2VWdEVHQVRNeWZlZFdl?=
 =?utf-8?B?RWJXU1JWMzdNRUFVRWVnNWlJU29mVFAraUFEUnA4Nm1zT0VFVHhTYUQ3VkRL?=
 =?utf-8?B?am5oK2gxaUY1UCtOa2sxZGg3UTJzWHFpTGlDVzNSaCtXcGxsVDZ3UDlPVUNl?=
 =?utf-8?B?NkdZeTVrS3hpOXlCZ1kxVUFnbG9IcGtuNzNvblRwUFVnQzBOMFREckNlcDFI?=
 =?utf-8?B?OVF6bWdCQ0k3VytrMzVPdkpGbS9YWkpoSU5ncU9Oa3puSlNrRnpEaVhrdXFG?=
 =?utf-8?B?SDFsUDZQOXVLQlZ3MTBXdEFFZmNsRlFvK2N5RldsK1hoOTFKakYxcVBxZFdr?=
 =?utf-8?B?YnByMklrSDJiT3owcWo0UFRiQkpBOVBxZnpEbnppeGVDZjVPdVM5V2xyZlh6?=
 =?utf-8?B?V3NJakM3aHdhWWpVL05DNm5zUU9GRUdObE9SUjJTRVFjdzk2ZndwMUc4M05R?=
 =?utf-8?B?a3VzNi82OG95VHd1L2lpMlhLbFRjQVdMUFFuNFhQWkdaa3RRQ3JVLzFaYWZK?=
 =?utf-8?B?ajAxK2xjMVdnYmNjMFNJVVhlSHg4c0lNNnE5RWloN2I2Sm01TjNHSW1Id1Bm?=
 =?utf-8?B?bHhCM0psTXQvUTdTamJBTkFkMyszRUlnTzZQZ0tJYjRUQkc5SkVNcThvZ2dE?=
 =?utf-8?B?THlOZktIZW4rOHV1bVF0bEhkVk1FaUw4N1o3a0MvajFrcUx6VDM3Wk9PMC9z?=
 =?utf-8?B?OGk3YTlKdkFJWmltaXRLWXQrVjduY00zQlVpcU5INXU3cVY5c3JWa09DcGdH?=
 =?utf-8?B?eUxIazM2TUo4TkF4MGRGSlFYazQwbG1OcGFqeHBNTjRkWGZVNjF1eVdVeFo1?=
 =?utf-8?B?OWF3a1BpU3gzaEFvbmV4b0tnTmVGdVFVY2xqQUlVdG1OblVpU2R3eVRxTDVL?=
 =?utf-8?B?MHVNcFhtbm1sY0Q1VUJqNnYzcXdHbDhGRnpBbHpvM3pDQWZSUzhwN01iczl4?=
 =?utf-8?B?YjA5dWdBcXJ4eG5hNi9QME9Say9BaDJub0R3ZkdHTVhqRHRGZlBLMkdEM1cz?=
 =?utf-8?B?UHdNQ3dCMjRMTG5XeTNwOWpiTTVrdVlRVFRyT1dvemk1dDY2ZmtIV2FDYWdB?=
 =?utf-8?B?ZzRvOWRCQWxqK0laWHk5ZlgzT2dSRWVSb0VIdEFFRisweFFhQWlNSU9DbjZY?=
 =?utf-8?B?TlpseXpLRCt6NFppMEJNa3lzanZhQnh0cis0d1Y3eHZweEI5UU1xZm51b0xw?=
 =?utf-8?B?UjZDSUNQbGlpRVZtYXlhR1l2Q0dKSkpnampVSHBDRjV6R1pIc3FyeFlUekkw?=
 =?utf-8?B?R1dLZmhzYUFqbTdtbWlJYitZTGhxOFJkWnJpTDNYeUdJN1dSejhzTjlGSjh4?=
 =?utf-8?B?VTh5TysyREdyRG9nMFhNZUJMb25jeW5HZ2FaR1VnOUlZSVpNeDYwWHh0VUhO?=
 =?utf-8?Q?HHeOCYMtBin7i5Oo=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb271c5-63fa-46c2-e9ca-08de633e5579
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:07:30.9530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFvjg3SVpxWgpMAmAZcNYkJSJ8b2cbgGYmiq0aOoCVvcxNvSnxuYKUUhtRgSEm7mBeRr6GLTXCkBNELRaopWhe48mtKXSd3Fm3/T6JXS4KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8957
X-Proofpoint-GUID: XG2Pgv7pwstzMJvs2Dl2m2nFwME92pGI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyOCBTYWx0ZWRfX56v5HN7jyYFk
 CKf4fDeprtPopBafDNnZdb8XUvb/7qBUrR02/ulnYptmcm7sI3fCBrSKceXqhvAFoU62GEZUVyj
 jXOZJPLkq0b7vPMzjSpcmCEKi8T7mIpezobxsNpnkqTCL+k02XaUNhvtzJLs4RKQfFKa2tpqF2U
 1sSsGVwsCN4bhF+hnnZuDpVi4e+oQcgQaUOZ+bOg+fDvFxaFKZDEvDDm3koxi8DpH4MBDOKyXVt
 YIHf80QPsJdyxU9sjPjQnFkzHjyKy94gxCoUxNzJ0x9Naa45SqE9z6Kw7gQIUHEO0gmzIEpBp0L
 nYvAmdwVmH0ocIAG+MpF6+mfNMPaDNFPA2DlgX5+oghu6QbLQnumwyIr1JL357bJaSeZ5iK6Hph
 g8dBByKo4sjKhcX4aI90HCguyZ6HUP2BXlGp4BVB/ImtytVe8WeL4T04EGzVjdiZaL/E7j30uE6
 qqHo2YWIbuumQQLm8Hg==
X-Authority-Analysis: v=2.4 cv=TI1Iilla c=1 sm=1 tr=0 ts=69821d45 cx=c_pps
 a=MP9y2KnavyzKo3MGO/hTew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=FLTJhDWunU3Yu_8Vi6MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XG2Pgv7pwstzMJvs2Dl2m2nFwME92pGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/modinfo-generate.py | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
> index aaf23544c46..5a8abcae5d3 100644
> --- a/scripts/modinfo-generate.py
> +++ b/scripts/modinfo-generate.py
> @@ -2,14 +2,16 @@
>   
>   import os
>   import sys
> +from typing import Optional
>   
> -def print_array(name, values):
> +
> +def print_array(name: str, values: list[str]) -> None:
>       if len(values) == 0:
>           return
>       list = ", ".join(values)
>       print("    .%s = ((const char*[]){ %s, NULL })," % (name, list))
>   
> -def parse_line(line):
> +def parse_line(line: str) -> tuple[str, str]:
>       kind = ""
>       data = ""
>       get_kind = False
> @@ -31,7 +33,7 @@ def parse_line(line):
>               continue
>       return (kind, data)
>   
> -def generate(name, lines, enabled):
> +def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str]]:
>       arch = ""
>       objs = []
>       deps = []
> @@ -68,17 +70,17 @@ def generate(name, lines, enabled):
>       print("},{")
>       return {dep.strip('" ') for dep in deps}
>   
> -def print_pre():
> +def print_pre() -> None:
>       print("/* generated by scripts/modinfo-generate.py */")
>       print("#include \"qemu/osdep.h\"")
>       print("#include \"qemu/module.h\"")
>       print("const QemuModinfo qemu_modinfo[] = {{")
>   
> -def print_post():
> +def print_post() -> None:
>       print("    /* end of list */")
>       print("}};")
>   
> -def main(args):
> +def main(args: list[str]) -> None:
>       if len(args) < 3 or args[0] != '--devices':
>           print('Expected: modinfo-generate.py --devices '
>                 'config-device.mak [modinfo files]', file=sys.stderr)

This looks okay, however as python isn't my strongest area:

Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


