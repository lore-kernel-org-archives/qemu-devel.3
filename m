Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684FCC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 10:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7CLS-0005eq-JD; Wed, 15 May 2024 06:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s7CLP-0005eP-SY
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:58:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s7CLN-0000XA-Dj
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:58:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44F7nGAc024820; Wed, 15 May 2024 10:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BilY5uU9lr/LxapDdEW6XPf4qpQ2wEOKq9a1OazMYy0=;
 b=Z2tIXMmCJLrrSC8nyrc0MHfxMrcyIVNhao0ISaoOYKQHQfH4Gt30KOvXjELvqcFq6+vb
 1ecvx47Lj+V7Fa8Oc5l2UKSc6xAUYMc2qF+iwkuOd+B8d7gIgL7wV63wzD4QaKxssNEr
 Q0IsrE5nFkb05HVOMEEwu2KlSbaUP+JUNmy/9uLKtzoVpLr59aloNFDW6UisSaZad2AW
 vN13rBFlyAEZpJJ+cFxsqOjpA8h1MGbCHnxHn+DdK9rZfireTt+9EHER6t5CbjHrDaQD
 tANTPlEL8KYloID5ZN/mdxpQ66qw6e/HfRTInwjPlwVGCQvqqhUHRo0X0Xq2x4sdmckA aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3srrtwmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 10:58:38 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44F8udDN018175; Wed, 15 May 2024 10:58:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3y1y4eu7m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 10:58:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ/474m8XOdD3L+OQIl8D1dj0WP+K5eJYSt01I9+wJ4XLyTFVQHm2BPa4iHVD4miF7SszU4PKPu02vMLlVsqwA4Tb55CEvI+77WO5FShneEA8RiAsNHW4EbXnR1vpfcHfLH+8zw71H4e5Nbd5nMrUGHiwS3gLlFqWbwqEX133b6+vTXm1qDCfSNuvOfCgaInL6vk8eDjH9HL04S8Cl7QErJ0miRKAkXK+AkGjUvFcGVzRSN19IsykeTHtRk/m1ZP2ygtM07pTF+wAZU4VW2i06zZNCJam+txe2bxN+Mc4/EeMOB3skTdK9TQALzv/eww2CV7lSqsekvmb+TfI0EH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BilY5uU9lr/LxapDdEW6XPf4qpQ2wEOKq9a1OazMYy0=;
 b=Yi39iXMqKJMtGR1k3D4iVGYsQcp07z6pRqSYrUNMpH8LHiJcUWBr2Cm3+INk6bcyNaprzKVHOM+l0q6lrqvDqx6xnvXykCZ/RIopK0NnhwSVUqQPC4wtUw5a+h5E7bXtwxsb+NnUdckjTEwVNV1rOb0dN4xfE/Yd+foV4Zt80VRzeP8cVcF+nHlhKDwNzuKbP0yAHu81LNNxz3Lv83fzLoXP3q+K9sNlX7UHUXYQSkWSoWK8xRHWnAZr4vqPpNTxhv095aSTIDjgCvaMtQeHNTleLrjJljDZOODI86c+NQUUqAIHSwaBYuxdjiVejaxO50Z5grL0AMbtN7saQ4ab/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BilY5uU9lr/LxapDdEW6XPf4qpQ2wEOKq9a1OazMYy0=;
 b=XEGhjQ0VeF7G59t/kb9VT0cYr+vXw7XXvG7KvrHfMeQXW6GXMM4qsJPyoturyERXjx3nyxbXUvlLci4jH4LDR5lbczKFHBa7Pc/q7h60CxWmjVFG1ODMVhz+hKEecR8fcMLZTO7MxLb7U2qAN3EEPwDj6w9kav8G+S0C9iOnZi4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS0PR10MB6996.namprd10.prod.outlook.com (2603:10b6:8:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 10:58:34 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 10:58:33 +0000
Message-ID: <c2cc96ca-990a-461a-9875-cd801dd8a52e@oracle.com>
Date: Wed, 15 May 2024 06:58:28 -0400
User-Agent: Mozilla Thunderbird
From: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: CPR/liveupdate: test results using prior bug fix
To: Michael Tokarev <mjt@tls.msk.ru>, Michael Galaxy <mgalaxy@akamai.com>,
 peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Hunt, Joshua" <johunt@akamai.com>
References: <20240228051315.400759-1-peterx@redhat.com>
 <20240228051315.400759-21-peterx@redhat.com>
 <f855963e-b7dd-4ce8-89dc-dfaa87e896c4@akamai.com>
 <82c69792-061d-460f-9db6-88fc8f9df5af@oracle.com>
 <d6176480-d87c-492b-8a0c-04bf81a4f59a@akamai.com>
 <59ad1f18-682b-46fc-a902-884ca6150c7d@akamai.com>
 <fadc022e-7cfd-4201-90e5-0193ce6220bc@tls.msk.ru>
 <cf21f54f-e090-4441-86df-6304c469333c@tls.msk.ru>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <cf21f54f-e090-4441-86df-6304c469333c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS0PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7b003b-8cd0-4406-a2d4-08dc74cdf6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVdHVC9FSE9xZTZBYXY0Vmt4UkIwMjFKZ044RjhqNmFxU2tFRTg5T1pPLzhl?=
 =?utf-8?B?Q3VPaURGWkdEbTBiZUNBWVB0dTJGL0ZCNHlMc1lvNWlyWjVRTWErMGZJZTJw?=
 =?utf-8?B?MnNPaWhpVXJlbmQ0NHdLc2g2eDljU1MrazU1eHBSVFV2M1RETS9IUUp4eVZh?=
 =?utf-8?B?WGJma3RqakI1Q0pibFFIMTBBNDRBT0hTb1VzTDZEYTF1M3k5ejNPOWRzZFFW?=
 =?utf-8?B?RU5ubzdiV1k0cmRXQVJIS0phOTN0WWFLY2ZEVW9Za3BCS2tqbTFSSUdMQVJL?=
 =?utf-8?B?aVlmTi9DeW82SSs4RUhKSHZEVDJ3Yy9jUlF0YWhEMEQzVDdRNzAxQmwxUFdo?=
 =?utf-8?B?bVdOVUpLMkhXakE4WXhONDFYOVVDZFpXeXBjOENMYk5zWlBVWmh5NU0vV1lU?=
 =?utf-8?B?K0RTQjd0SzFsTFNJMEdzV1FFcTd1YVZWUWc0bUtIZ0EvOHZUY2x4U3ZtY1NM?=
 =?utf-8?B?VGdWSFBjd2I3aU1wNnkyRWRHYndNSkdWdGkzYUhnc3Y5bWJZb3B4RTNLSng5?=
 =?utf-8?B?WTBQOEhkWER5YXBoWGdjOW11anp5SUlRclNFNVlBSjNnQXFQeEZ0SWo5ZWRG?=
 =?utf-8?B?aXVQaTBYaUdibkVCZ0FlKzRPWHp1UHlzczhaMmZDanI4Vm9aYUpEKytySkV2?=
 =?utf-8?B?S3VMTWJrZzliK2hpdUhnOXhpZG9iT2t0dllORU96WHJudE5kOFpMZVkyZFhJ?=
 =?utf-8?B?bUlJaGM3VVZYa0VOME45eUZIem5aZnJ4RUhBOXMxbGpMRlpGdjBxQTcwVGxG?=
 =?utf-8?B?d1loYzg1MGZyaUxqTElDR0NIL0lJdjJWc3hxUUVMb2MwQUVGL3Nyd0x3T3N6?=
 =?utf-8?B?dml5OXNMVHRjT1lXVEJGRTJGWldjcUUyWnhIMVVGRHFLLzU3NnB3bXVadjBW?=
 =?utf-8?B?OGQvMmFtMEc0RnQyN1hpRUpLWkZJblUvK01pYWc4bG1YdDZEOXRPczg1UEpX?=
 =?utf-8?B?QjYxZk5YbXlNY2hqRytCWUlsekcwWUwxbEhxY3ViUzIvMVZVNDArczZzK3Jk?=
 =?utf-8?B?NzFTZ2hia0ZmTE90MnZEL2JZczhzQjExSFRWZlI4ejlLZ2pqOFh2eS9nSmNE?=
 =?utf-8?B?ZERFT2toYmpIZ0k3KzVoYWsrU00ra0JCcERuajY5Q0x5NjNBc09mZFM0L2tY?=
 =?utf-8?B?b0xNR1dTMGJaVUZGc3Q3VENsa3dESUp0ZkdmaVlMTk1ibE54MHpVWFBNcnRo?=
 =?utf-8?B?NVJLN3oyNDFsRnFkZktZSDN3QTZqWGsrL3oxTXJPVllldVhkajdKTnRqTFpM?=
 =?utf-8?B?RjFLc3hNcnUzVVV4VGt5NnBPa1hvd0djNDZaK3ZRTWN3dHh4MXdjdnhYVG8w?=
 =?utf-8?B?ejZoWXRMZE5OeXhFdGQrZExRMmJOejZwTnFNbUVER25BNDd3Q1BhcHRjSkVj?=
 =?utf-8?B?TCtYbW5DQVI5QmlSSk16VmpLS0Z4U2EvQjdoVSttaHFjY0ttdnVJVmpsME1v?=
 =?utf-8?B?WTJzMzhVcER3Q1Y3UGVlaTVpNGt3T3FmN01tekQwMkVZTE1TSlljU1FmaWlj?=
 =?utf-8?B?WGNRSUF5ajAva1MwTmcwQW4wQTNsWURweXBLQXRwN1BBVUFvd2FjWnZXSHRT?=
 =?utf-8?B?bHp3aHp2K2ZQSitsYnMyYjFtOGc3bTRlcjEva3EyS3VSVDE2ME5qaE5ib3lu?=
 =?utf-8?B?Uk02eTJyZk1QZE1aZVhoY0lrM0pKT1NRQnl2SmgwR2dkQWl3OFFoNEplRUt2?=
 =?utf-8?B?N0Y0MDBuU3pqTEMzR096alk0WW9yejhtOWtlVEluT2RERHFqZG56RkZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkhFRjJOVXI5eGFYdVNpRTVuekRoaHdJZUZBbVpuOHFQenBqTFA0aldreWZw?=
 =?utf-8?B?a2xsVkpXYjJwQkYzU3hJVnVHbStUVCtLa1pSb0l2TDJ3R0xtUVNGZ3AxWVkr?=
 =?utf-8?B?Ym9EcEZneGNNdWRPTFdhSmhCUkFvWlc3MGFkZ2E3ZEE2SUZlREoweVhyalpQ?=
 =?utf-8?B?eFM5SUkwQitYaDJVL3hRcXRLNXpva1gycDlKWnpTMjFHdnJ0T1R3dytPaUhX?=
 =?utf-8?B?ckUwZWNRZUdDRllLWmNZdE9icDlzVnNLNUoxdnhCSGp0RmNrS3BJcDNPNDIw?=
 =?utf-8?B?cDJ4cnJOV3NjWGdSQkZvQ0RVMFh4WlhnUE5ReTF1enJaWEdiMnk3OHdNdVpM?=
 =?utf-8?B?RGVndkl0NkY2QzhKN2xCOGZEZXFRYUVDVXJ5MVFXVW5FWjg3cVBIdGxpRnla?=
 =?utf-8?B?KzQ5bk9UQjc1SWt0N1E1SjVYZnFYNXI1b0dwMHJwV1N1OEE3NkVwU0RNUGNh?=
 =?utf-8?B?TXhsMXJoL3JQbzNQaG5ENWpnSHRYY3pKYzZGWkVybVR6R1Fra0c0V2picnB0?=
 =?utf-8?B?cVFvM0xLbHYwMWRkbllieWVueFlOQU9kcFdibUFrNkFJK0ljNE9wNHJQV2VT?=
 =?utf-8?B?T0YxLzFzOGxma0sybUl6YUJRdGNvZFc2WDZLKzFRQ28wTVhudzhuUFBKMVFa?=
 =?utf-8?B?Rkt3L0dtSmU5VXZ1bklxT2M5c243WkphMngrWmtUWUpZcStDSWZUMWE3VnJ1?=
 =?utf-8?B?c1l2VzdrRm0zZ0pjUEIwUkRSZzVRbUJzR01ZdW1RZlhRWU03UmhjYXFGenJo?=
 =?utf-8?B?dUg1VUMzTWYzR3VwWWdMajA3MmlaTVcyelA4TFlrU2ZGVUVTL3RMVGgrOTJP?=
 =?utf-8?B?bzlpZWd4VjVVVFJLR3VCdnQzNlB1L0N3UlRrQXBlYUE0OHg0TUlKMFlOVlg0?=
 =?utf-8?B?aU9uNEVZQ3ArTUFjN2U4b1kveG9EQ1h1OExNTWFhd0ZKeC9aelp3bythbVF6?=
 =?utf-8?B?cnR4WS85d3JrRjJ0V01xY3o0d3o1OENTRC9KNDBBamwxZ2VSZHk2dXJhdkJw?=
 =?utf-8?B?d0xkemhlSXJBQ056LzZndGp2N3hyQlZqTE00UDBNV0dUdktvdU5wSHNIaUQ3?=
 =?utf-8?B?Y2VjMVZRN1l5eXdyQzBNNGxqZ1RMZU0yVEc0K0JiZEU0UXFFdFVNbjJmU3RP?=
 =?utf-8?B?NmFPYzdlZWw5NG55TDVRZFM0d2s4ejAwaVFtenRJNWhUTGdiQUV4VW4vd2pL?=
 =?utf-8?B?eFQ2THN4K3JIb1NTTGpmTXJUK0M2NEkxZHpuRHg0ZUk2VkR4cXF5Rk1HNG1H?=
 =?utf-8?B?bUxRakQ2TFlWdEQrSGUxTndEdThGTlBqeDZ2WWkxTEtZa3F2cE1MTzNGNWxk?=
 =?utf-8?B?YjdCKzVrN3BGT1BrOXpHdmo0bTA2cy9EaVBFVHVmWUR5TU44WTFxTG85S0du?=
 =?utf-8?B?VElEQ3M0VysydGRtY2k2N1NvbTlIOXl3aElxOUFjZFlIaWp3cnJuUkFqWnN0?=
 =?utf-8?B?RnQzZk5TRXVrK2VxYUk3V1FuYnJ6Tjc2QmFNUUEzblR3Vm81UVpQVEdXRnpw?=
 =?utf-8?B?eEdUYi9icm54MElJU2hwUk9Xd3JHL2NQWUd4SDBDQVZhTVVaUDFPTGpMdGE4?=
 =?utf-8?B?M3pNQUV6dTJMYk44dzNTYklIdVRCTXQxNXJDZVBWYVQ1KzB0V2ZiNHVyMEha?=
 =?utf-8?B?WExROG84dTdLYjQwUnFGcDNPYnEyOE9kb2MzZnNlQnEyMW43ai9DdXFsWmYz?=
 =?utf-8?B?dTZMdFdPU1lsZE95SFNkL0JsazZQeUFuZE9RN0FvLzV3enovdmtNRENWRFNC?=
 =?utf-8?B?YXUrQTFjSXZoa0dqWGY4anNFTDZXUU9qbTZma2g4YTd4UUF1N1ZpZVhZRkVH?=
 =?utf-8?B?cjdkWlRYdEF6cDVrb0UvNmNGdm81SnJBRnIrblhBOW80T09hbG9UZFZLWlVN?=
 =?utf-8?B?UHdUR1ZOeEI0cDZzNU1TcEtTKzM3YS81cDlJTnNIMVp3ZTg2cVpjOGcrVUlQ?=
 =?utf-8?B?R0U5OHdYU2UzYURaM1liVk9PMXZjSnovaTlha3lUd2FiRmZBU3orZHdmeVor?=
 =?utf-8?B?M21mMVVwWjFib1E3OHJWejA2aEJmQmNCSktXdGlHVDE5WlYzREd0SlowREdl?=
 =?utf-8?B?VkxuQ3o5SmF3WTd4TGVFdjZmVEpTcm03c0d4UlM3bHp1cCtiZ2tsV1BkbTBw?=
 =?utf-8?B?U1RISFUyWFhPemI3Y3U4aVFTWVhiY3k2WnppbXJSL2tuZ0JCRVk0NjNXbW83?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9BXT4r/cEZE/nOLU4vfTxXj/tCInLiMqJXBj2lZvqOyxwQBXJJGunM9MUGmoWfdHJtoutUwqgIT+em2siu6FYeKNtjlSDfc+skDsb9+pGE7SFkIPldBYDB7e7Ub8oEVV4Mej+V9eOJm2ZP2jWt9wOb6ONddF1k3RFVtyy86AZnQByOaPEXpeFrvp3JUixYNUi+u84I2c+n+a8Mz+8yP92LElgyI704P756LjEVX1PcwHyAq3Mg8XXYNgvEvt9DOQJhMlqJvPM2YICq6ENxg01MSB6PX1u+4OkkoBXN6R3pJnY8EhXGKhpnDejlDu4a1i0nHK8fP5KBPBaIE/Kosmg4TeS6f0RFwUXK/UhPjil2gvyMVtgtdwNvYhawth8p8oKVv+gSMlpq7N9poYD453C2j29XLOXBBW+jQeSS0cMiPrgWIFTyHUi2xCQfWu1oRXRmTCekob+ZML/zwuormhfA4yvp5kBJ/BGoQS6VcQX9EahXgZCuTWI4pILsOcFhPcO02X3tClJsWp09eueAheOrfy2VeOV3nRRlMihNV2gvsNRzTA6Jb5KcpvDBCztET1ljoXr3HmFHhAI99dN7GsMhQw9ccYz7t2aHLYUM6K53o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7b003b-8cd0-4406-a2d4-08dc74cdf6b1
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 10:58:33.8010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbYAAfyXG5JlrrCWDHIxwZ57dKb6J96Anb3BtaNzVXAdkfY/FaPQ+nziM870blO2p+VOTP8wPsxfqe5+6iBCF+iW8ipX/su+GssRpmNEVKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_06,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150074
X-Proofpoint-ORIG-GUID: LFEzGN6Mel-RRTRJxW3rrmN2DLFrqiuc
X-Proofpoint-GUID: LFEzGN6Mel-RRTRJxW3rrmN2DLFrqiuc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 5/14/2024 11:33 AM, Michael Tokarev wrote:
> 14.05.2024 16:54, Michael Tokarev пишет:
>> On 5/14/24 16:39, Michael Galaxy wrote:
>>> Steve,
>>>
>>> OK, so it does not look like this bugfix you wrote was included in 8.2.4 
>>> (which was released yesterday). Unfortunately, that means that anyone using 
>>> CPR in that release will still (eventually) encounter the bug like I did.
>>
>> 8.2.4 is basically a "bugfix" release for 8.2.3 which I somewhat
>> screwed up (in a minor way), plus a few currently (at the time)
>> queued up changes.   8.2.3 was a big release though.
>>
>>> I would recommend that y'all consider cherry-picking, perhaps, the relevant 
>>> commits for a possible 8.2.5 ?
>>
>> Please Cc changes which are relevant for -stable to, well,
>> qemu-stable@nongnu.org :)
>>
>> Which changes needs to be picked up?
> Please also note this particular change does not apply cleanly to
> stable-8.2 branch due to other changes in this area between 8.2
> and 9.0, in particular, in postcopy_start().  So if this is to be
> picked up for stable-8.2, I need help from someone who better
> understands this code to select changes to pick.
> 
> Thanks,
> 
> /mjt

Michael Galaxy, I'm afraid you are out of luck with respect to qemu 8.2.
It has some of the cpr reboot commits, but is missing the following:

87a2848 migration: massage cpr-reboot documentation
cbdafc1 migration: options incompatible with cpr
ce5db1c migration: update cpr-reboot description
9867d4d migration: stop vm for cpr
4af667f migration: notifier error checking
bf78a04 migration: refactor migrate_fd_connect failures
6835f5a migration: per-mode notifiers
5663dd3 migration: MigrationNotifyFunc
c763a23e migration: remove postcopy_after_devices
9d9babf migration: MigrationEvent for notifiers
3e77573 migration: convert to NotifierWithReturn
d91f33c migration: remove error from notifier data
be19d83 notify: pass error to notifier with return
b12635f migration: fix coverity migrate_mode finding
2b58a8b tests/qtest: postcopy migration with suspend
b1fdd21 tests/qtest: precopy migration with suspend
5014478 tests/qtest: option to suspend during migration
f064975 tests/qtest: migration events
49a5020 migration: preserve suspended for bg_migration
58b1057 migration: preserve suspended for snapshot
b4e9ddc migration: preserve suspended runstate
d3c86c99 migration: propagate suspended runstate
9ff5e79 cpus: vm_resume
0f1db06 cpus: check running not RUN_STATE_RUNNING
b9ae473 cpus: stop vm in suspended runstate
f06f316 cpus: vm_was_suspended

All of those landed in qemu 9.0.

- Steve

