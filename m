Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502BFCF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 18:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swnM6-0006CU-J5; Fri, 04 Oct 2024 14:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1swnM4-0006CK-K4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:48:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1swnM1-0005Dh-DV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:48:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfbuT030396;
 Fri, 4 Oct 2024 18:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=HaIlmHLxD4Cs85S5BtyfstLNP/PxR/lcQG8KGBbmQj8=; b=
 cn2qicTvFCfw22QreDJbbdY5TvTV346HUi4/mXCFLXR/tWS6xF4XolhXaonga0/u
 xYbynqzE/5t1Frc/NGlrK/FxH55AouysasVQEIsHmE0TAxfG5eKdPdrUbrjQR4uI
 Aj/oPVYI3uvC7sqP5NWth2iqwM8unmhdn0f66lEw/MvVN2pAN/YCAW1GCYaiM6Z6
 Yr8dCzBj6TrPHf4DJqG+Iwk9H2RShG9sxoaiIVEbS/IGOkQa7Ir1+pYDI/4Hlmbi
 V2ai/jQX90pUiEdBt/cE6QGYf1LN9zXHL2clf8X29qTUHquSZxSJvsSxNowp7nLH
 dBZxOkIEC+f502JkT61HKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b29r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Oct 2024 18:48:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 494IWADR037338; Fri, 4 Oct 2024 18:48:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422055ewvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Oct 2024 18:48:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0u+E1JTrFRLgeRQhIHFAz1klZ4gs/5znn+BgftGdxK3Rklhvf13kc1J1IfVs7WshMuUiSaeeqUObKSik8s585y6SM8MUd3jDm9wRLVAgVdRXuwPuxNS+vTnMEvjkWEHJEZLuwxrdA29CAoh86tW10jBy7boktayvrE1h1+FKQ4USzzYUvtmfvraa7p3ZtGUQjNtXT37UGY9TFdl+xScBW7GA2TCLke4t5jZnO244pVp8Lp2iF8JH3nH7/6FEOor5+oUuQQhug4/2tTKoAv6g/MY1enMMXrgrYYSw6GPBt9hH7VO4ag84ov3xv1xbOpJKy1hVsLhoZ2oTjixWvS8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaIlmHLxD4Cs85S5BtyfstLNP/PxR/lcQG8KGBbmQj8=;
 b=LC867bcRSkGQN2JTHxJeRYw0B5hpYVrXqIn4Jr6sMfs+MQ8SyOCRkbZwiSV9xjHq212DLQcsIJKDwATxraWx3YVUjhK3KR60z2lFpMHJ5PiLPyCq0gcHpnGzTXVcpKUaT6BqVkVP7alO2SRgjC8/14J/u7qyjq+KdbKeufCLT+dAmBYsahrRrXuxmN22FBoApk1Dobtzct5/5pLTMLAukchHl1E2HHB9AcI6Pw/l8kI2TfsOL8/7XsNkg2JdUFA1+gWDrS6wmTFndcF3B/Hu98VIerjXlZ+n+WITKDUF7i0MF727A43MBuIT2HHRgNPbkO+30XJ0kgA8WO1vNV+Pyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaIlmHLxD4Cs85S5BtyfstLNP/PxR/lcQG8KGBbmQj8=;
 b=EyOXJtIoJJS0Mezd3Jk/WhGiOBvetj4w2Hjl33O5620GAOXGA2AyMf0riocXZE8H18ExHwzheNcEgDUscSSHIfRkwyBrk9chOkA3C26IfIY6VL1yyiAlOOyZZUbtCO1NaWbrwaMo6djK2tjhAl1xyPfAw/D0xnhwPMSXRC1hRKQ=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:48:35 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%5]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 18:48:35 +0000
Message-ID: <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
Date: Fri, 4 Oct 2024 14:48:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::11) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 2929f83b-de64-495f-b3f4-08dce4a5270d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clJtUjZZSXNVeTlxQVVTYlpYU1o1RnNhT2JqeEY5SkZBZ0hYczhhN2VuN2lj?=
 =?utf-8?B?bDRSYkV2WlJVSnZuRFhXb1E5YWZ2enpXbWRheU8yUm0zNTNrc0RzQzF1S2Mv?=
 =?utf-8?B?ZUZHeXdVVzYxNjJ4bUVzNXVnVmQ0UnVETkx3VGdZTFZERlZlZ1N3MlA4MU44?=
 =?utf-8?B?RWdOeXc3U3F3ZWl1MFJSZ0ZZN01GZHlXOEhqTjAwcCs1ek0vOGJ3b2NGcUgx?=
 =?utf-8?B?NGthWEZISVZORGtCSzZJaUdKclg0ZkZ3c2ZLZ2NxZEVqNHJ1OTgxNEJhT0VX?=
 =?utf-8?B?bmJMcW16ZHBLbWVjZHVSM3RjMTZ3MmFwdGNFRWVVMmlTTlpWdEtZZ2oxb3J5?=
 =?utf-8?B?TVBUclBYclVidDF6Y0NQYS9EMUY3Y1JIaDV5cnlCT0NobGRERHBnem0wa0pW?=
 =?utf-8?B?UFg3Q3Nrenc2VGFLMlBOMVc0cmpLWlVTWHhBclFNSWV2MTZaUWtid1BpbTYw?=
 =?utf-8?B?dXMzMEVTb0pndXNjeGZXL2pETGkrZ251TnJLa3FlNFJiWDBnSFE3a1poVFU0?=
 =?utf-8?B?WWMvYVBYeHBDTVVSR0RBRS82NnR1b1EvYVk2WWwxOXpSM1hpdGhTN1lEVGNN?=
 =?utf-8?B?TjdhL3hwTnkxbXBzb0xSMEQvMVdvakIwR1RnWUdoQzg3WExISmg4ZFR3d3FD?=
 =?utf-8?B?N3hHOVRRdy9UNS9RNCtOdDk0S0hBWGYxdEczL3RnUG11bmFZc0UweXlVYTlV?=
 =?utf-8?B?WUVZUEovd3FJKy9sYnk2YW9MQ1Z6Vk5DTmo2SmlMVi9UYW5sZEFWcjQxWGRX?=
 =?utf-8?B?aWdsMlNyaDJEWW5lRGZycTEyaUdKUUlWWlUzMjhKT0U1RWI3RHNTbVZvMlp2?=
 =?utf-8?B?bW9tUElnM0NKVkk4ckxUVzZvUExXb0FHR1cvUk1KNlp1bk1oKzZzdTZ2dHpj?=
 =?utf-8?B?dHJRT25IN003eUFUM1EveWVOZi9ja0NoM3R5MGVoVTdSV2t0SWJER0wzZmpp?=
 =?utf-8?B?UVJ3RXBhOFROaDgwcm9PRm51ZWRHOG8ySTlIRGFTSW81cWg1YWZJQzlnOVRC?=
 =?utf-8?B?bEc1ZFJuUDViNWdNbkNjLzUxdzdJRnZYWFR1QzJUdnM5SXB0dm1wRDZ5YjAr?=
 =?utf-8?B?WHlhNEZQdnVNWkN3RmpUcEN6QU5TWGYzcTFPYWVLYjFBSkswTmF5VXBicnBM?=
 =?utf-8?B?U3kza2V5NVNHUitFSlNnNisvMlhrVmtIRzhLQklyNXJLR1BacGlNQysxUVVq?=
 =?utf-8?B?K1lLUzAxQTUrS1ZLdEU5ajlxUU1kMFRjRnRtSXVyOXluWTExcFhOb3ppUmt6?=
 =?utf-8?B?d0JYOTVnY3FvZ3EzckVTMXphQ2wyZUVOQmEzeldrYzFzak5LSFZ5NUNEdDZP?=
 =?utf-8?B?NnF6cWNqcGNtVGMyZ0lmTHZSYmRKa0VLbkRta3hzeDNoNjBDV3hJdUZjemQx?=
 =?utf-8?B?MXBkUm5mQzVnQ2Y1SWhqZmRnVHR1d1N2ckttcFJ0UC9XOUpaMnpTTnRLSEN6?=
 =?utf-8?B?VW5pVVRUZWwrNDA4aG51RnJRQjRRd1Rsd3g5ZGIwc0dUQk5iUzZhZXRSVnRn?=
 =?utf-8?B?SHcvY2NtYkJKdXFlTFRGZEEvMEhONXFVTkJlbVEzNlFTakQwaWlLMFZMYUI2?=
 =?utf-8?B?MkhRTWRUM3FRbStXN2h6cCt1UmJGcDI5VEZlaXdxZE4ydGJkODlSMXF1WkN6?=
 =?utf-8?B?dWVyNzVzU2lhSTVza0RrTlhScGlqTDBqVGh5YmhVaTI4OGwwUFFRcnI5KzhQ?=
 =?utf-8?B?NXVuM1dNYzdoeTRiRzc1TDZUcW1VNTQ5TzZXUktUR0MvWFFSdElBakF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhQNzZrSXhlamE4WU0xNXFNeVlxVWp4T1lPN2hTZEhZdlhFREY2K2FCUytj?=
 =?utf-8?B?eTRBTm5qZVlzZXFYeXZYRVprb1pWL0tHWHlOR0J3NjNJZkk5VEoxUjlKS2d4?=
 =?utf-8?B?QzdOQmtvZE0wS3owV3dnQ0JGUHR0djFrSFJIVTdjKzJGT2VKNDBTRWtJeUl0?=
 =?utf-8?B?S24rUzVFZmQyUzVxOFdIQ1A1M3N6V0hPYkJJcVAxNzNKbUNVdXdScTlFSmJy?=
 =?utf-8?B?WmNSUnFCMkh6UE8vcDNsY2cwakxNemdNcEZiLzV3YXFpTEY4NjZ6N2g3cFZU?=
 =?utf-8?B?UDFka2U4QzNmc3Z0aFpGcUlmZy9MZ3pGcjNER3doa1JEcUFSNHdmendmM3Rt?=
 =?utf-8?B?aGZNVFJtTkhuS3Y3ZjZyMzNnN3J2dnBLVzA0R3FCZEYyUHhlRnJGSDgvSXk1?=
 =?utf-8?B?SFFQQjdlU2hadFRZaDJXYjA2aldLbFpielJWQWR5eE9JZW83dWRwRStLanZx?=
 =?utf-8?B?dUN1VUpxT0NQN3Bzd0g2clVwdDN6RmE3dy9yS09RR0l2Ry8xYVlVNFRGLzdS?=
 =?utf-8?B?RVNmV3I3bENkRmFrS3E5NWtmVDZqelBYL3JDQkJiTjQwaGtZRGNUWG9zY0xD?=
 =?utf-8?B?Vlp2UEpySkcxU1ZyZ25XNVExUm9abTF1RHB3amszTFZUZDlsVkxKdGttTGtY?=
 =?utf-8?B?UlFTaDdKUlVxS3NLRGRIV0IyS1Y1KzJLTE83RUEvanQzeXdiaEVHNkNkajQy?=
 =?utf-8?B?aFJRV1E5TWpNcTgzMmlrdjNCeHoxQ3VHYnN5cUhuQU5Kcm5TMDJjZEZYRjAz?=
 =?utf-8?B?dkdLVTVkRFFIUHdGTGNkYjhhOFYvd0hrQ2xJanBOK0hNLzg3NFJCb0NYWEk2?=
 =?utf-8?B?ZzN5QzdNVzBMNHpWU2Q5akpRMGNESU9WSE5EMHMrNENISzZEZGVzcXdSUk9t?=
 =?utf-8?B?UktRTTlsLzZSQ1Q3MnJ1UWtOWFVKT1BPeGZBRnVoTld6QUQ2WGtBb3poVU5C?=
 =?utf-8?B?SEQvc3dUaXZCMC92ZXg0YWdKYTErTTQ4dWFhaWZCaFdoaXZPUkJqY0cxYTV0?=
 =?utf-8?B?eVdIVXUveFhKQWVVQ0J1aXIwR1NMem5MTkJ2b1FSN2lpT1BRZUlQN0dJYVVl?=
 =?utf-8?B?dFdrbytrMnhxL3pLMEhZcVZENkVqQzNBSCtaM3lXS21ONjloUFlxRjlBdVJJ?=
 =?utf-8?B?US9oeHBpR1pTS1Bmakx2OEYzSzlJRTY5ZXFQRmZOdU9LUmpNSTUvQUJZYXEy?=
 =?utf-8?B?UEY0QVUxenBFbEIvd1NMSEZIbi9ibGxiUnlweGxnOEtCdkFyd2VnUjVwMUxm?=
 =?utf-8?B?bytIRjdDNFN6aGJnNUlWdlBYTlZDQWlvRVZvelk2THZWbnZPR1l2UkI5d1Q3?=
 =?utf-8?B?WmhmWjIzMmViMTdyR2tnNWlpTTFETVVwSWhuQ0diWllMK05hUVJOVy85Y2Rw?=
 =?utf-8?B?dENDa2hhcTY4NVAyQmlXZ3JYdU15bUwrOTdYV20wRVlmeUZxMERRZUNUaDRS?=
 =?utf-8?B?UnQ3VDYycU9pQisxckdBaVNYM203MGx2OW05bW5wZnI5M3NBNjVpTlRweWJn?=
 =?utf-8?B?amRIOFI0NEQvK1huMGFDWk5naWdpZzBBdHhqVk5welozZTk1elpPbTBPNUhO?=
 =?utf-8?B?TTFUaENOL1cybEdSaTRKUjNGZU16c003OEFjY3N2TEx0TWp5K0tNNitEb3Jt?=
 =?utf-8?B?UW1meHhFdm56MzhXUjJOdm1PaG1NMldHd2JnZHMyMDF2b0VmZjRGRWRXVWda?=
 =?utf-8?B?LzdvL3BvK21DSitTUTBZVmhKWDN4OTJZNUU0V0h1V0xTeUZYV09vN2JHY2pr?=
 =?utf-8?B?VGlJUVNHQk1wRjhnWjBKODQ0SU0zbUJOZVdsR0RmNjNLODh3eWovRGN1L2s0?=
 =?utf-8?B?VDNnMWNpOWo4dERkbFF0MnFPRDlXNzlRcHRralhCUFRheGZtRXliZ3lDRWxk?=
 =?utf-8?B?WWc1dU1ldnpjU1BRdTl4QUhtcWhaWVlMellWcVl2QmRWNHBHN01YbHJ4enhP?=
 =?utf-8?B?TkNoaml4MWx0Lzh0eXMraVlUK2xpWnJmV0w1dTBZcjdSTWNLbFF5UVM3c0d0?=
 =?utf-8?B?U1JhU3ArV2NHNzlJVFdnSG52a1N2aDNFWHJhNHkyQ1psdWVwVFVGWitoNUdY?=
 =?utf-8?B?dTViOGJYcldIcy9CYVZVdS9DcXEvbWFHcDZYSC92OFpoczFyVmtYRlYyY3Va?=
 =?utf-8?B?MVd1MEJQdWRmY2pVQ1pkbTR4UENET0kvM1lkN0lPWm53MFhrNm1uTjdDUXJp?=
 =?utf-8?Q?X+0beQIii2tExfo6GOp3orU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4AxX+eOTyt1n6BFqOXhgPcq0OSPtBQm1lKlT9bDIShtsz/xpIPhuD/w/y99niVemqgE76yVdH5ZpwRGIwgIFlCmA3uBsg2dYPyHEPqyiA15mTEbT4cGl2q7AG4yzTCTigHlGrSptOjtVaSO8lX3ceoL3ziKeVYHDDfB0YFTiYjP6GbId8YQM9x2NdT+LzAhAhcQW7L5U3lnQErtIJS/+DdKWL6q5EfzGDUV/UO/qvy2m1Rf+guAokB1eVIyR2tWBGwkvVqJzWTAsKPiKvHAWZudtwOgBpI4EqyGqfDoB+02S9g610fsJUEnaOQI7ds9Davn1jHOk+Ig2Z5a3TiItRIrCJEsMeVarfE/unOrd7FzQJ9Iiglxct+I0MXmj88yTBTQcYhzxSjatQMzN8ogrmpDpaY3O6U2ryhFZhaWzsxDysTKw/5UiLqA7rAjJysKOWWSrBO6OlarlxLdbXPCdgDzDCECvXI1J9UdGql/5Kv+7LGs9sb/xsDQTCVBnDDrCVIdNmu7j1SRko9/+SoJErX/MuIwFdjU84YcbD2fAPESTcdIfgPvLOqjXj+zi/en4jNJ6tBtxfSH594nvV+HRSNdJ/IlNVdV6TaUUsK3E5cU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2929f83b-de64-495f-b3f4-08dce4a5270d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:48:35.7254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDTDJoSmYoJWr8zxj3JUnNq6AyFgXiKmvSv/00EI4GfCGbE0zJnIi9zTinbqAYUtItX3OqI6tukvA3807/Dqow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040129
X-Proofpoint-ORIG-GUID: ZPm-Z942mGdbTPNUdezIRYVa-XcreCQz
X-Proofpoint-GUID: ZPm-Z942mGdbTPNUdezIRYVa-XcreCQz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
> On Fri, Oct 4, 2024 at 2:45 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Implements the IOVA->GPA tree for handling mapping, unmapping, and
>> translations for guest memory regions.
>>
>> When the guest has overlapping memory regions, an HVA to IOVA translation
>> may return an incorrect IOVA when searching the IOVA->HVA tree. This is
>> due to one HVA range being contained (overlapping) in another HVA range
>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPAs to
>> translate and find the correct IOVA for guest memory regions.
>>
> 
> Yes, this first patch is super close to what I meant, just one issue
> and a pair of nits here and there.
> 
> I'd leave the second patch as an optimization on top, if the numbers
> prove that adding the code is worth it.
> 

Ah okay, gotcha. I also wasn't sure if what you mentioned below on the 
previous series you also wanted implemented or if these would also be 
optimizations on top.

[Adding code to the vhost_iova_tree layer for handling multiple buffers 
returned from translation for the memory area where each iovec covers]:
-----------------------------------------------------------------------
"Let's say that SVQ wants to translate the HVA range
0xfeda0000-0xfedd0000. So it makes available for the device two
chained buffers: One with addr=0x1000 len=0x20000 and the other one
with addr=(0x20000c1000 len=0x10000).

The VirtIO device should be able to translate these two buffers in
isolation and chain them. Not optimal but it helps to keep QEMU source
clean, as the device already must support it."

[Adding a permission check to iova_tree_find_address_iterator and match 
the range by permissions]:
-----------------------------------------------------------------------
"About the permissions, maybe we can make the permissions to be part of
the lookup? Instead of returning them at iova_tree_find_iova, make
them match at iova_tree_find_address_iterator."

But I understand that the problems with this is that we're assuming the 
SVQ translation will always be done in a transient manner.

>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/vhost-iova-tree.c | 78 +++++++++++++++++++++++++++++++++++--
>>   hw/virtio/vhost-iova-tree.h |  5 +++
>>   hw/virtio/vhost-vdpa.c      | 20 ++++++----
>>   3 files changed, 92 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>> index 3d03395a77..e33fd56225 100644
>> --- a/hw/virtio/vhost-iova-tree.c
>> +++ b/hw/virtio/vhost-iova-tree.c
>> @@ -28,12 +28,15 @@ struct VhostIOVATree {
>>
>>       /* IOVA address to qemu memory maps. */
>>       IOVATree *iova_taddr_map;
>> +
>> +    /* IOVA address to guest memory maps. */
>> +    IOVATree *iova_gpa_map;
>>   };
>>
>>   /**
>> - * Create a new IOVA tree
>> + * Create a new VhostIOVATree
>>    *
>> - * Returns the new IOVA tree
>> + * Returns the new VhostIOVATree
>>    */
>>   VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>   {
>> @@ -44,6 +47,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>       tree->iova_last = iova_last;
>>
>>       tree->iova_taddr_map = iova_tree_new();
>> +    tree->iova_gpa_map = iova_tree_new();
>>       return tree;
>>   }
>>
>> @@ -53,6 +57,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>   void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>   {
>>       iova_tree_destroy(iova_tree->iova_taddr_map);
>> +    iova_tree_destroy(iova_tree->iova_gpa_map);
>>       g_free(iova_tree);
>>   }
>>
>> @@ -71,7 +76,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
>>   }
>>
>>   /**
>> - * Allocate a new mapping
>> + * Allocate a new mapping in the IOVA->HVA tree
>>    *
>>    * @tree: The iova tree
>>    * @map: The iova map
>> @@ -108,3 +113,70 @@ void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>   {
>>       iova_tree_remove(iova_tree->iova_taddr_map, map);
>>   }
>> +
>> +/**
>> + * Find the IOVA address stored from a guest memory address
>> + *
>> + * @tree: The VhostIOVATree
>> + * @map: The map with the guest memory address
>> + *
>> + * Return the stored mapping, or NULL if not found.
>> + */
>> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *tree,
>> +                                            const DMAMap *map)
> 
> Nit: Not an english native, but I find vhost_iova_tree should not be
> broken for coherency with the rest of the functions. What about
> vhost_iova_tree_find_iova_gpa, like _gpa variant?
> 

Yea, I totally understand what you mean here and I have *no problem* 
making it into vhost_iova_tree_find_iova_gpa.

Just to add my two cents on this, for what it's worth, now that we have 
both an IOVA->HVA tree and a IOVA->GPA tree, coming up with function 
names that operate on this new tree while conforming to the 
vhost_iova_tree convention and being descriptive in the naming is a bit 
difficult.

For example, to me, vhost_iova_tree_find_iova_gpa would seem a bit 
misleading to me if I didn't know about it beforehand (or was just 
seeing it for the first time). Like, are we finding the IOVA or GPA or 
both? And what tree are we operating on?

If this was some personal code I was writing and I had free reign over 
it, I personally would go with a format like:

vhost_<tree this function concerns>_tree_<action>

So a name like vhost_iova_gpa_tree_find_iova communicates to me that 
we're operating on the iova_gpa (IOVA->GPA) tree and our action is to 
find_iova (find the IOVA).

Similarly for something like vhost_iova_gpa_tree_remove or 
vhost_iova_hva_tree_remove, etc.

But obviously this is the complete opposite of personal code and 
certainly not something that's needed so I'm totally okay with renaming 
it to vhost_iova_tree_find_iova_gpa :)

>> +{
>> +    return iova_tree_find_iova(tree->iova_gpa_map, map);
>> +}
>> +
>> +/**
>> + * Allocate new mappings in the IOVA->HVA & IOVA->GPA trees
>> + *
>> + * @tree: The VhostIOVATree
>> + * @map: The iova map
>> + * @gpa: The guest physical address (GPA)
>> + *
>> + * Returns:
>> + * - IOVA_OK if the map fits both containers
>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>> + * - IOVA_ERR_NOMEM if the IOVA->HVA tree cannot allocate more space
>> + *
>> + * It returns an assigned iova in map->iova if return value is IOVA_OK.
>> + */
>> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *tree, DMAMap *map, hwaddr gpa)
>> +{
>> +    int ret;
>> +
>> +    /* Some vhost devices don't like addr 0. Skip first page */
>> +    hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>> +
>> +    if (map->translated_addr + map->size < map->translated_addr ||
>> +        map->perm == IOMMU_NONE) {
>> +        return IOVA_ERR_INVALID;
>> +    }
>> +
>> +    /* Allocate a node in the IOVA->HVA tree */
>> +    ret = iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>> +                              tree->iova_last);
> 
> Why not call vhost_iova_tree_map_alloc instead of duplicating it here?
> 

Great question with no good answer! For some reason I thought against 
putting it in there but will do that in the next series.

>> +    if (unlikely(ret != IOVA_OK)) {
>> +        return ret;
>> +    }
>> +
>> +    /* Insert a node in the IOVA->GPA tree */
>> +    map->translated_addr = gpa;
>> +    return iova_tree_insert(tree->iova_gpa_map, map);
>> +}
>> +
>> +/**
>> + * Remove existing mappings from the IOVA->HVA & IOVA->GPA trees
>> + *
>> + * @iova_tree: The VhostIOVATree
>> + * @map: The map to remove
>> + */
>> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
>> +{
>> +    /* Remove the existing mapping from the IOVA->GPA tree */
>> +    iova_tree_remove(iova_tree->iova_gpa_map, map);
>> +
>> +    /* Remove the corresponding mapping from the IOVA->HVA tree */
>> +    iova_tree_remove(iova_tree->iova_taddr_map, map);
> 
> If we remove it blindly from both trees, we are keeping the bug, isn't it?
> 
> I think the remove should receive the "gpa" as a parameter, same as
> alloc_gpa. After that, vhost_iova_tree_remove_gpa looks the right iova
> into iova_gpa_map. And only after that, it removes that iova from
> iova_tree_remove.
> 
> If it makes things easier it could receive (hwaddr gpa, size_t len) or
> all of the info in a DMAMap. What do you think?
> 

Initially that was my plan but this only gets called in 
vhost_vdpa_listener_region_add/del and in both functions, by the time 
this removal function is called, we already have the correct IOVA.

In vhost_vdpa_listener_region_add, we just allocated that IOVA and saved 
it in mem_region. In vhost_vdpa_listener_region_del, we already found 
the IOVA via vhost_iova_gpa_tree_find_iova prior to calling the removal 
function.

But I could be misunderstanding something here. Let me know if I am.

>> +}
>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>> index 4adfd79ff0..511c6d18ae 100644
>> --- a/hw/virtio/vhost-iova-tree.h
>> +++ b/hw/virtio/vhost-iova-tree.h
>> @@ -23,5 +23,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>                                           const DMAMap *map);
>>   int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *iova_tree,
>> +                                            const DMAMap *map);
>> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *map,
>> +                                  hwaddr gpa);
>> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
>>
>>   #endif
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 3cdaa12ed5..591ff426e7 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -365,9 +365,16 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>           mem_region.size = int128_get64(llsize) - 1,
>>           mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>
>> -        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>> +        r = vhost_iova_tree_map_alloc_gpa(s->iova_tree, &mem_region,
>> +                                          section->offset_within_address_space);
>>           if (unlikely(r != IOVA_OK)) {
>>               error_report("Can't allocate a mapping (%d)", r);
>> +
>> +            /* Insertion to IOVA->GPA tree failed */
>> +            if (mem_region.translated_addr ==
>> +                section->offset_within_address_space) {
>> +                goto fail_map;
>> +            }
> 
> We can move this cleanup code into vhost_iova_tree_map_alloc_gpa, isn't it?
> 

Sure can. We'd still need to check if vhost_iova_tree_map_alloc_gpa 
returned IOVA_OK though and goto the fail label.

>>               goto fail;
>>           }
>>
>> @@ -386,7 +393,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>
>>   fail_map:
>>       if (s->shadow_data) {
>> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
>> +        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
>>       }
>>
>>   fail:
>> @@ -440,21 +447,18 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>
>>       if (s->shadow_data) {
>>           const DMAMap *result;
>> -        const void *vaddr = memory_region_get_ram_ptr(section->mr) +
>> -            section->offset_within_region +
>> -            (iova - section->offset_within_address_space);
>>           DMAMap mem_region = {
>> -            .translated_addr = (hwaddr)(uintptr_t)vaddr,
>> +            .translated_addr = section->offset_within_address_space,
>>               .size = int128_get64(llsize) - 1,
>>           };
>>
>> -        result = vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
>> +        result = vhost_iova_gpa_tree_find_iova(s->iova_tree, &mem_region);
>>           if (!result) {
>>               /* The memory listener map wasn't mapped */
>>               return;
>>           }
>>           iova = result->iova;
>> -        vhost_iova_tree_remove(s->iova_tree, *result);
>> +        vhost_iova_tree_remove_gpa(s->iova_tree, *result);
>>       }
>>       vhost_vdpa_iotlb_batch_begin_once(s);
>>       /*
>> --
>> 2.43.5
>>
> 


