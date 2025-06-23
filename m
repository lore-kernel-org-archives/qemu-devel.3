Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC35C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjjk-0005cN-5E; Mon, 23 Jun 2025 12:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uTjji-0005bS-Ao
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:09:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uTjjg-0001A3-8u
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:09:34 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NEKC21028867;
 Mon, 23 Jun 2025 09:09:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=J1tHYDqEBxsX/LAhpU6nCGSzMlXvyVDHTyehx8plq
 Vg=; b=FxWd2LAW0nsAbVmYEoY/djGtcPEJ27eCdrDz41n8mfD/k0r1eF7bBfkZ+
 Kn4lGiU9XJDDjvqEGLJMiJEI6/OhzetLfqXZLscXuerKRa+nyDPyDr7oX4YVx0yR
 Tdtjn8NibIU/EpQEtXeT4ny8CoKM+t5T0Knwj7dCxvCBu4x0R/QTKqfTjc2ljFJV
 7R0p+DVMoq7KPvLrxDEG69gPKdCG57006PimknkhuADTYoERprruJnDIxygL+kXh
 sWGsQwrCdiNz/9DOwLal1QFxXQYwO/7A/N/NZxQyKfC9bPrIRkLDPpOdXphHELLq
 +tK9yAFnfOSDPTK64/rQNRjFyb3WA==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2096.outbound.protection.outlook.com [40.107.96.96])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47dva0be7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 09:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvo3OpqFe9bq0Zsyaz0K8FL8GWUr/EVapZkoW593aY4ivmak3K9KmkFs6lBJeXYGElwJOOzbPGUqmfzvKROSvrtXB+d+KDYLWcmN5iheI0LqwpTwNxCZkyFvLf+FP5PyA0yFU03GN+iME5D4PeFJ8FHC28E38LFeQaC3Qkeh3Azh6PGpJIUNRi001c95KH2ig9irxKPWlbUHfscp9JCPXrWq/LVHjdkIW9zWX5qVltg3ZdeiygpVOSzQZX2G1HQePm58PsP346a7FxGIt9Ql1s/bX/AdVuPo6+F1+JqTZ1eIhneS/cq12Gtieyp6ia28RIa4v19GDH9/rEPfJ67sQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1tHYDqEBxsX/LAhpU6nCGSzMlXvyVDHTyehx8plqVg=;
 b=VAPCgtSHHb+//CAU9gqhATvsqlyc3Qv80bWDmA0CQJ6363b5bX8NsVJ2LDx2qd86Y5/3rZjuYk0wfMFazTqfLlGRL5HM0EXTyGeU3uO/blD90Vqsdvm9CdTyK4AdjCGYhGMkL2C4Tic8TyzZ107WH3BsxsXUUIDeYoRv6pa4syXlAevH2isDU1TFcP/HAvlOU3ke4cM477vZ/cV7WqzlArb+8t8jyuD37sVTpOqT1qlNctUV0pswlyRZAzeH5gjSi1sH9Ahd1UTjI1xFZBOsCinPcK3AY4ApcpGT9vMq0AtDwysv/PNdPaarDIeV0K2KkIXu/5MThIF18Q4GH9qdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1tHYDqEBxsX/LAhpU6nCGSzMlXvyVDHTyehx8plqVg=;
 b=qhZtTl5HFj0qeMpO7Bd/ynW6orfzzlhEI+VTJhE3e/+0JewAanuAXxVrXaRorgTN9ls4v1EvSRRzaNms/N2U1eBUraHUlAXOo0tz096FH69Yn+hCwwAzxj7n29kH9oPWcArDrfQitBneVaU4P9c86J5kyIqEaP8cVCzkRU5+BqVy4DcFleclke3bDjmQisjIEn5tOF6k94krL+zxZ1+gX1K5smwOUpC5PSFkBtPeTJ8XLXvNzjBtO/FF4Y19hDSj18mVGfLCtPFbCm9EZwelhDDnlN7YtwZlAZ+tdlgZ7RWAyJwbg8vRt/kbuuAb+hLgDtcTdihZleqhC+EVBv8MsA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB9289.namprd02.prod.outlook.com (2603:10b6:510:270::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 16:09:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8857.021; Mon, 23 Jun 2025
 16:09:22 +0000
Message-ID: <993cbd0f-fad8-4d27-bb52-b5d198ae5f2b@nutanix.com>
Date: Mon, 23 Jun 2025 17:09:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] vfio-user client
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com> <aErh-v3SfFo-2Br0@lent>
 <c18de4a2-63d0-4ad2-9547-fe8bc221a887@redhat.com>
 <3b311f79-fc87-4b1b-8ba5-728d696a14b3@nutanix.com>
 <65274f7d-59ee-407e-a57f-dbf9e47890b5@redhat.com> <aFakD1PqE6Ew8whG@lent>
 <e27a3a2f-9277-490b-a8ba-22202bb57c70@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <e27a3a2f-9277-490b-a8ba-22202bb57c70@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB9289:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d66ac26-aa15-4321-a0f3-08ddb2705135
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0dQREN0aDRxWTN0dGZlNTJjQzhBMzRvQnRVWXFlcnRTY0hob2cxaDVoYm1h?=
 =?utf-8?B?WnYxai9oSWNFeTl4Q0t0QXNCdXR4Mmx2bmpqOU1mSUVsZWhTUHpPMzFveUlD?=
 =?utf-8?B?azVVRXU4NVVicHBkdnNMcmgxNG1XUFZBUFlKS044QjFmUVpoTVFtTjF5TTNl?=
 =?utf-8?B?QWZNK3drQm1aSnRDMjVCejhINjhBYW9URFhzR01kc2tPZFR1Z1BUT3FZUTNh?=
 =?utf-8?B?bjlQY2xqWUVpZTNEczNTZCtkbUtCTnNRek1JVVpRZjRiU3VPejNONDZ4alU1?=
 =?utf-8?B?MFVMbCtUR3JQdkVhTXM5TGF2RUZUd2o0NjBCREkvWXgyYVdjS3hLektBSWJk?=
 =?utf-8?B?enQyMk1pbWRybm5EQnJDTVpQSk1RUzZNTmVKclgxL0lFTHQrbHp1dGV6QXpJ?=
 =?utf-8?B?US9iY1pnS3dRckx5WXJpcGpZanpYNFU1VDhick5qa2h0REZZaTh6UFI1azNS?=
 =?utf-8?B?Y2VIU0c5TWRGK3VtSlNnaWFWL3ZUZW5RQ0hYM3A0ZnU3OUNydGVIdTBZQ2ZX?=
 =?utf-8?B?R0lFRjZ0L3NGci9mYTcwZS9BT1R0Vm10MUlhSUVDRUp6QWozK2QrNWlWeGNk?=
 =?utf-8?B?RkdMcWJicFVPOFc5d1UrT2xFNmM3dXZFVmxmMmlCYnpNOSs3N0xLZ1pQanNw?=
 =?utf-8?B?cjRuU0o2RnRWZlJoRHVFOVFXZSt4RGZwK1NCZVJLbE04MnIrZi84OGVLendz?=
 =?utf-8?B?TGF2SENodUpmdXR6M3dkU1dBdTZJWnhqUUpOY0dubWNqbi9XYjBwbVJZbisw?=
 =?utf-8?B?QkN2ekNhSVNHZXhpTHFWZHhScExGYjYwSVNSa1ZKK3FHQWVFUVR1ajVFa09t?=
 =?utf-8?B?RFl0M3dDWU1wd1NwQVc0Y3VaUmZiSmpjeEpQZ2h4K3A1OHNOL2daYU8zUWR1?=
 =?utf-8?B?TEdaR0Y4ekU4ZlQ0UjZlUERyUFdvNXBLeU1raXRsUUtMTHEwMjRtYXRENlhi?=
 =?utf-8?B?VEFpWllYWGdWaTFLcjMwa3FodGNrV2hXMitmVkNNNVhTYlEyTy83ekoya0RD?=
 =?utf-8?B?MXA3NE5PSzlVQUhYeXYxWm9MOUU4aG03M2paMzgvaTFNbTFvcC8wYlk2NGZD?=
 =?utf-8?B?VitwVUtCTnhtYXlVd1dBVmlTTGx1dkg1WC9QQlFnVGx2TFdkbVNXc2FhOWRw?=
 =?utf-8?B?QTMvRmtRVWVoMmhxSXdtdWZLRUJuMUN5TXc5cTg2RE5IaFk4VElSSVNGMWpj?=
 =?utf-8?B?V29oTkFsQVZTdHN0c09ueElJQXdHTzcwakRNL0orVllKTG9SYWYvVmJaK29O?=
 =?utf-8?B?SnFZT1o4L05oRFNKVHFrYldUZGZJSDJGYWVzNEpGYnVHZHBOam54RUxBRVhw?=
 =?utf-8?B?VzlMa0xkQ1ZEeEIwWVhkOURtbXVEK0Y0ZEozRFlvQTJ5eTZ6dUJDUmswMzF0?=
 =?utf-8?B?c01pdmdWUjMwNDJBKzJsbGpKOWlHWWVGM1UxVUMyVVlaUHdkRVh5eXVSd2RC?=
 =?utf-8?B?L25sT1hlbVhia1prdFVCNkdSTkdsa2ZyWVFJTmRkTnVUOFZHVjN6djNEMDV0?=
 =?utf-8?B?YmNJWE41U0c4NDRmNUl3QjlzWHZ4dDJsbnFSOElGT3Y5ZXZyOFV5NXppNlZV?=
 =?utf-8?B?MGtydVZGSTgzUFJ5S2xNOFJlS3JhRGplekFqVitHdUp2djJHTVdOaW5VczJL?=
 =?utf-8?B?U1NxeFNPWnd4d2NJQm8rU1NQdG54bkV5dUlBVUdzS0ZKek93OTRaNUdsVzdC?=
 =?utf-8?B?aDBWdWkxaUZBZHpQMXR4ZEcwT0Y5VjEyWTZJUzY3cGtwQ0tUU0hwb1JobnZV?=
 =?utf-8?B?ZllpS1lLd2t6TzhBUTdTd0hNcGdxektOQ1RyMlZPYkloeUN5QjhoZ1k4d2pW?=
 =?utf-8?Q?I5RAfWrp9N4NxgERwtQtb6+692YCCdKMyz3Ko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG44YjU4NU1nenJmclNUUTc2NjJxeXFiclNla3I1V1dPQTFLOG01RVp4U1VD?=
 =?utf-8?B?UVhvZEhIMTFIdUJua2RrVGtiZ0VCbkZnc3NJSCtaMmZGdTQ4YTFzVHFrZE1l?=
 =?utf-8?B?YTVBRVROKy9QaGZpb2t0MGZ4ZU01OXlJMEpNT1psbVZkc3JzeWNBNTAyTEg1?=
 =?utf-8?B?UEF6K1phazNmVi9JOWxuRXFPT1hvTWRDZ2R3R3BoaSsyN3VPWEVySTRxQ0tw?=
 =?utf-8?B?SjZvMmdSVVJkR0lmSGhaUHhPTkFzS0xpd2UyK09WUVYxazNuRVIyWStPcDRK?=
 =?utf-8?B?WXp5S2RrZGlESWxDNkNOaUpMNDFkckNxVlVDei9XVVBId2ZJbUg5UWZ4c0VR?=
 =?utf-8?B?VDZzQWlrMDlrclhueWhQdVRXV3VvQnVsdFRBTFNtZlBOSm85UW5kM0w0LzFK?=
 =?utf-8?B?S0Urdy9Wb3hzNjI1SllaRWgxeDc5cUpqeDA3bm5qdEZXV3FpbkRPaGhIMUc0?=
 =?utf-8?B?U29hUUJlZ2MvUy9rZm1UNmJqMUNRRWtScjFEN2prSmVKc3Q2M05nVzk3QTJ6?=
 =?utf-8?B?SW9EOE0ya292c1E5ZEd6YlhDUFBSZzFxcDNIT3owQVZsTnI2TjFleWZEZnhO?=
 =?utf-8?B?VGZiRzI2MzU2R2tpKzZRUEdDL3VHL1NEcGZYaGt5VHR0eWY4QjY4ditqT0lQ?=
 =?utf-8?B?NkhRb2hFYkJGbHFEYlI2alJLOWVoQ1FzSUc2a3l0ZlBKQWM0K3ZtNTJuellY?=
 =?utf-8?B?UmIzR2RxL2VkSnU4QnB0Z3BKSlpsNDVZSkxyR3JoWThOSFZ1QXVSK25ZY0NI?=
 =?utf-8?B?anI0Tk5lb2toSTZNUHlscTd1REFoajVSNkE0NFFUVmlmMjFEaEtvVzBmNGNp?=
 =?utf-8?B?ZlFPQStadTI4OWZ4THk4TVdvS0o0UUxwSkJlMGtna1RWMGwvME9sQ3p4elhV?=
 =?utf-8?B?TmwxVWJma25YWCtjMm1tR0YyRVpoVk5FWVZ3ZkhKM2N2UktRSnVNSmtrcGNu?=
 =?utf-8?B?TjV6OG1OKzBsQkhnTFZXb1VHY3lhY29mSkdEUGhsTFFpekFHR3pUNG5SQXJ2?=
 =?utf-8?B?Ni9CN0NBMWY5Z0FUQlpjWFVWMHhyVUxmQS9aYXVwT2RjdzFnVDZncEp3VEZw?=
 =?utf-8?B?UGUvU2tEeHpvbkphY3p4bjJZeHBlM0R5U2VRaEVwSWVvU2Y4cUs5RE5TN2FC?=
 =?utf-8?B?bVRJcVZZQUxrN2tZWWs4dHdYWUJhNk9DbVJON0F0NDRSOUFzZWRESUlETi9R?=
 =?utf-8?B?K2NNQ3ozYVE0bW5PSUdtM0liMkd2OGtNTVIycmV2ZzNMSzFDaHFUeDV4WVNK?=
 =?utf-8?B?THJnbk1xT2laUGxKSVVKSlBOU2lDNjNGa2YzWmUrR0pRYjY0K3lKSk1TMndQ?=
 =?utf-8?B?NFhPUmlETVlVcXFkRml6MS9saTFZRVVzQUYrc0F6eTdLSTVwRHRKNWZGUXpv?=
 =?utf-8?B?Mk9RSkZaa2xpd0VvY3FKWWFkNEpDQ2RURU9kRnZFMVVIeFRuTnhpblVFVVNN?=
 =?utf-8?B?VDFUY1Nja2hsOU44dUZvTmIzdmgyUjBMSG5FeU1XbStuT0RNOXJtMHRwMGtM?=
 =?utf-8?B?RVNSS29sMU9MRjZiMHpON2NrNW9HTjFQdG9YOVl6RFZvekpnQ2JJUlZpakkw?=
 =?utf-8?B?ZnNMNSt5RVJHaS81dHFmM0k5R3l1SDduMldkUDBpeTNSVWtiazQwOXVUTmZx?=
 =?utf-8?B?UWJiUExvb01UUFhtYlRUOG5MNWJaTVRIQ1NtNlJyNDc0S3haZGt0b2tBYzND?=
 =?utf-8?B?MDJNd3JoTCtRZVZtSFljcEM3VTNFOGt1cG9xMUNwTHdkbEExeEJMZmtrS2cx?=
 =?utf-8?B?b3h3REozQ203bGd4Uk1sNWZlOHFvcytOWjgzZWNObVBzelZsTEtWWjJnMDV4?=
 =?utf-8?B?YzFoV2x4bi9aTXBOcmxKOEtIb2FlS3kwSC8vcnBSUmJHYlNNWkNtL29xMXNX?=
 =?utf-8?B?ak83VFpJcWZTVEI2UHVUcFhIRzJPOWVjWW41UEtQbE8xUi9OelV6aGhuZmFn?=
 =?utf-8?B?OHN5TVFwZit3eXVhc0lkcVJOZk1RRDUycHhpSGRYUmpla0lmUHlmNzMwVXJ6?=
 =?utf-8?B?czcrU1ppc2xlaTFBWjNNSGhuRG1xQzZFNFJwcTJwbG0xQTRpTTVWb256Z1Bo?=
 =?utf-8?B?ZzgvUzVEYWZBRUdndEkyMUpJK08ycW05Ym8vVkNneS9sVi9vekVScFZqNnhW?=
 =?utf-8?B?cmpGUUo3dU9Gekc5QmRkQVBycDFyVHpKYS9UVmpiUTlnbDJQdkQzZHpHN3FK?=
 =?utf-8?B?Z0EvQ0l3dGcxTjVqSGRnYkl0dE4vdXFGWkZycGZSY0lkUUZsUEVObGlHb0xy?=
 =?utf-8?B?bWtiSUhQaTd4QlZDaDhFQ0lFd3B3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d66ac26-aa15-4321-a0f3-08ddb2705135
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:09:22.7598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fBpvP1zTcZf94Vv7Px+IKsPP2rj2bfaw8gQVcdwTmdE1Kz6b9SDFjy3JI/g1HlUHFSq6IFv4nwULE6DSecZN5dREyrw2VnD9tDVf/VccVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5NyBTYWx0ZWRfXxMziNPYrPqyz
 d79ap/+AWy1E0KKF7Jlxb7VOLBYZufoQJS8qLI8mSqQ7L1pwoTH3qL3Jj+uWOUFKvBkbuA5KptW
 Ta0iwFOtfUS2cTvstu1jj/kzQn9XKv0gP9T0DGWyrPbK3TZEP70m+c2aXCIWrxj5pQu1ZZ9KeZ+
 Ggu38NmLqVqAyEWU+BPC77NafEGjasZy0ZoVL25SnOUBx7UVxR1IMBTpqbTok5k2Yufk4uaSJ/P
 /0FfnuMpEJDaREbq4FILg9HQfcSeZ+F0NtTNGKscEX5khDy8vSTqJht90Ky8Zjci4CPHFum0SCN
 r72k+NubXQPl/ifm4cxm29rBQkfLn3WlRdSBI83SeX3NOO2vzwUuhI4G8Yi0rqPXJ7ePgYnnrod
 JCm+NZW7u+ugTUFeMlOdsXTsfZDhPEKLvRSjBgs0ucgCDdNBCwY/dIhjRq0GZDmVkB2lwaSw
X-Proofpoint-GUID: CVCSqRAD5XInb1vGpSAJP6IYizFhvArt
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=68597c36 cx=c_pps
 a=PlaVE61AgoT+3c1ANYaDEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=RpNjiQI2AAAA:8 a=QuiX8RmCngfBOC8bqJ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CVCSqRAD5XInb1vGpSAJP6IYizFhvArt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
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

On 22/06/2025 13:57, Cédric Le Goater wrote:

> Hello,
> 
> On 6/21/25 14:22, John Levon wrote:
>> On Fri, Jun 20, 2025 at 10:32:10AM +0200, Cédric Le Goater wrote:
>>
>>> Before merging, I would like to be able to experiment a minimum.
>>>
>>> Does a dummy device (server side) implementation exist ? and a
>>> GH repo I could pull the code from.
>>>
>>> John,
>>>
>>> How do you test ?
>>
>> I use these scripts for smoke-testing:
>>
>> https://urldefense.proofpoint.com/v2/url? 
>> u=https-3A__github.com_jlevon_grot_blob_master_tests_vfio-2Duser_run.sh&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=V-sTFYIBuNsRDS6PAkkLHCjd5V2lvtIYfbhCV4BsWHxVWzLB_Dj21kOCZ_00B8wZ&s=ZZtYgH13tGNzKPUfKumHJno3qZjfUTg5z6GMJ_9o5so&e= is easiest - you just need to compile libvfio-user and qemu
>> and you should be good if you have a suitable Linux image.
> 
> PCI enumeration work but the kernel module won't load on ubuntu 24.04
> and 25.04 :
> 
> root@ubuntu:~# lspci -s 00:0d.0 -k -vv
> 00:0d.0 Non-VGA unclassified device: ACCES I/O Products, Inc. PCI- 
> IDIO-16 Isolated Digital Input / FET Output Card
>      Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>      Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>      Interrupt: pin A routed to IRQ 21
>      Region 2: I/O ports at 6000 [size=256]
>      Kernel modules: gpio_pci_idio_16
> 
> root@ubuntu:~# dmesg | grep 0000:00:0d.0
> [    0.381550] pci 0000:00:0d.0: [494f:0dc8] type 00 class 0x000000 
> conventional PCI endpoint
> [    0.382696] pci 0000:00:0d.0: BAR 2 [io  0x6000-0x60ff]
> [    4.017654] pci-idio-16 0000:00:0d.0: error -EINVAL: Unable to 
> initialize register map
> [    4.027063] pci-idio-16 0000:00:0d.0: probe with driver pci-idio-16 
> failed with error -22
> 
> Any idea why ?

Annoyingly this is because the gpio_pci_idio_16 module is currently 
broken upstream :(  The last LTS I was able to able to successfully test 
here was 6.1, and so that's what I've used to generate my functional 
test images.


ATB,

Mark.


