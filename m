Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FDEC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgZo-0004VQ-QN; Wed, 07 May 2025 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZm-0004UR-Id; Wed, 07 May 2025 11:20:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZk-0005p9-NN; Wed, 07 May 2025 11:20:50 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5479Of0k003984;
 Wed, 7 May 2025 08:20:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Wb36Up2A8wmisqyWv+D92GKhPsBJMEedMJfFDcwXg
 AI=; b=O11RHI+a50MeJHaV6SZDIOQR7dy1bx9zOreqtgZ36g6zwccmXDT6wKZvX
 8eGJBYGBSjwpq8/0rAqJypBAHFMYW5Ts9kFeQxtcCD9lLo5zE3ED30D4k/jQlT+T
 rX13QMeV33Imb2OipPoIHmiljcDPFsS79QF/BvDC6MG8BDPDIVFxwCwZaJEIhXQe
 ly+Zg9xhBybbnW970zvsiy1wnS7HlxeJbKOYUBYnUwddaGGqLenTb5Fh2Kv7/T54
 xtxFL5FUlCZwFGU5K0gqLpsMyAdYwhpZTpnyNK8sEsqnCWbX/wiwM8K8ysRzdROG
 auo1K2yqWbi9YCb3ybdER//GbZ6cQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46djpygyx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbgKU4k5+n3f4xqg1oGrkNjCJ7LhYB9ppVQjGeaQbBrtaJLGzbReB26Zf7F+LwyKzzrW2hU+40y7kN9M6Ib41MDamWQR7QwjX2UqjGXctG5fGl59J4wV8YJ4+BjJQ/f2n7JfqeHCJZyD8KpIFHnyi+Sh6zkEoyecwNzKc17Ym81tixXmwSexzvRNTymyz4ZYQv13s6Jn+/7218m3TEXbr/9nCIOiQPFMkQc1i7KIteV6laUDJONqmzWghPQb1c5s6PTECkDWKRidRMd5I+JSBqZKkwEtFCoWhFa2a7JlJ1qEn9/i37wk4UMt4kziXB2pxui49QbWM+Eymu6ImHd/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb36Up2A8wmisqyWv+D92GKhPsBJMEedMJfFDcwXgAI=;
 b=mVVX1OtsihAjQY73bNMQroP+ncCgGA/6NJyUIPG7gFTdlec1GYKADqeZQ41sHWqAM/rKX7WNEUHY3ZGWTZbR7M5t5JRRmLRv0IW3R40JEutasGSNzd8ogd4ghlb/BijvilDRIKsBkWzNShwiD4h1MQvJATVyFHLYR4TeNNrwt0gjwKyfq2/ShX6eYiR22UVOkDSVnyLWhmS8+d8pNlgDAxmsxiEL8SGkX3FpdSXFl84oyjBhF+56EO9Tp9FJh65nchuUB7MrQvZA1UTHUwKFbCFKTmlgzLSRnDJprvOOzXgf2QMlpqmkvv7VaFNIRIYXs0It32JWUGr/jPr8XeNevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb36Up2A8wmisqyWv+D92GKhPsBJMEedMJfFDcwXgAI=;
 b=m+bmOhe/DgJ6wBDzrdnX0riKUs+vc/HR2AN68X2j5OczximwFb1jOC2+73UVCDx96OrVD5Y5m1TL+BBTDLicnlWICPJ83U2F94n+hPFiQmu5DX4GMO7CkXHAaue18RSWHHLBJZ529zOa3Gq1oYRMkTTRhvWE58NK1Du1sVb9ORwZngo1volwPnMGvbXYiR5ZK4qnlE/2l4CNfvy2h4hIUJv4EGqF8lsfScr6K6/K+vDvqOyzbaTG+X5hyBnrxyh0FgbuyGmv3tnlrCYbwtMBVLq0gOYANU7lzNz4OL98v1AJ1nARDj5dCtbj2V/OdQobsEdiQHvw6lpffIpMCA9png==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB7970.namprd02.prod.outlook.com (2603:10b6:208:355::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 15:20:35 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:35 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 03/15] vfio: add vfio_attach_device_by_iommu_type()
Date: Wed,  7 May 2025 16:20:08 +0100
Message-ID: <20250507152020.1254632-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 413eea9d-2566-4c51-60e0-08dd8d7ab72e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eU5TdHBtR0Z2UmpGcW5Rb2VjaXRLdllIUVBOSWp5QkFSalBkRE1WaGl3d29r?=
 =?utf-8?B?L0c4SUtxMTB0Tjc1S0w5WjVOb3NQdmorSE5BYzM2TnBtcmM5UUJLa3NYMElp?=
 =?utf-8?B?NDVyQXBUU21IVWZTVnJuWG9JNzFFWXE5R2M4amZCWDBTR1puRFA5WnJUS2hB?=
 =?utf-8?B?TXJPcGJscWsrcUZ0WHpaYWRFQUZmeFFJM0pTRkNBQUdXd0hTdlNTZTZ3eEF1?=
 =?utf-8?B?SGhxK0ZpMlFoWVJJY25Sd0lrRnRlUE1NU1p3QldGQkdxakRUdUd4aEZSU0R3?=
 =?utf-8?B?Z1NtU25VRVFHRks1MWFicU5nWnZUV0ZuTDFDRGRHL1dzakc0bDk2U0JuSWt0?=
 =?utf-8?B?eWo4Qk9oZW5Fczk0M2ZSa1lyRVE5UEpVMmQySC9ycjRTTXVvS2kxVlN4N0J1?=
 =?utf-8?B?R1cvRGpKTXN1SXZhUVZqT1hkUVRxYkJMd3RlK0p0ZHZjdWRzWmZDMDZmcTc0?=
 =?utf-8?B?dGh2MDlRWkdFVDg5Q2ZiQ0ZsZnlrVjNUdlpjcVpUcjFNeTVNdzF5TGdhOTVT?=
 =?utf-8?B?Z1RuSGxMcjIvVzkyeWhFZUs3M2U4bHBwb0d3ejZZNWtNOUxKam92Wnk2QzV1?=
 =?utf-8?B?T2gzdXNSS1VobFNOWFgyMUk0YUg1L2NieWU4TE5Ud3VaWUJYanM2Rm9KTTRF?=
 =?utf-8?B?L1E1R3pIbFJiMmFQQUluWnZXNmtjTEtZSU5CUFVhM09XclhsNjdKa3NwWmoy?=
 =?utf-8?B?WUIrZEF4Sk5xTzErTTY1MFBMUVNHejdicnZWTmVSM2d1RFVCQS83MU52dG9I?=
 =?utf-8?B?RHcyWjFIa3FVRFMxT3h6SXZQMElUREt3bmMwZDE5dERXU29Za2hmT2xSMmZ6?=
 =?utf-8?B?TEtUOEhydlE2QjB1VzlVazlwUmw5QzB4R3ZCTk1vNndEYWZnNTVKRHZEaXJI?=
 =?utf-8?B?MVZEUFYxL01hczJqMnpuV1hoU2NBVkd0azlpcG9vbFZyV0J6dGQ5Zm1RbDdV?=
 =?utf-8?B?WVUxNUNJMHM0anZCOVpueXl0OWxaamlSRkJxM3BZUnl2SUVueVd3cjRLVmQ1?=
 =?utf-8?B?M2ZRY1FWMmtWSnFXWHpvVTVzUUw3NUxZZzFUMHU3YXdvN09ZYXBac3g4T1I4?=
 =?utf-8?B?MXBaS1dONHFkeklHN1czZFNWWStqUWpHcVM5d2d4VDVteXBRUW9nR2pmS0pO?=
 =?utf-8?B?SjJ1M3hoZHp5M0J6b1VsdEJ6OTdhVlJ5Y0hJY250MkVYcnZaV2FuVlp6RU40?=
 =?utf-8?B?VTUraFpGMUkzTkUraUN6bDNmd25ObTdnalVjY295ZnMvRVdBNkRLVjdOdXZY?=
 =?utf-8?B?bmNqekRVbkVyZ05OQWxvSzZqTjlxUHJkV1MwUDE2aGkzZjBzMXl4Qkp5Z1p2?=
 =?utf-8?B?VGxDY2tRTXRPR0p1c0Fka21LVFVsbjdJa2dlaHp5bFdNMGw1b2xuNGNLc2FU?=
 =?utf-8?B?VlFybktINlJUMko4cGRGelFvQThMbmhna21xT3JpZG1JRTRJanpkTmllMVc3?=
 =?utf-8?B?eTcxUGVEczZrT2hOMTJ6dERCa2lNWkRjaHlhaXpkUG5zRU83NktjRGhXbmxy?=
 =?utf-8?B?Z1dzcEt0WDlkT0RILzlJL2RwbXZ5VVpGRTRMd2txeG9pV2JIN1diclBoNGgv?=
 =?utf-8?B?b3JoRmVkSldzUDZFaDZCOCtMNThSUmt3a0FpeHRxUFQ3UmFwS2xzSG5vRU5R?=
 =?utf-8?B?MWkybnJmWjlabzlIalE3bnN4Z0hxWXl6amNUY3VRMEJENkwxYVVmL1FPTDJZ?=
 =?utf-8?B?emN4V2h1MlNaNXdURU42a0RpdWpsN3JSYmY0QlRBb0VyYk1teTBNMEdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dCMTEzeFpuZUtad3ZGendUSlovUEpGSGlqckZYRG9iSFRYVWRrcFRhSkwz?=
 =?utf-8?B?VVM5S2xFVmFmY09obzU1ZkRMZXhHeUtOTnBPV1hRTGd3c05ZNXVYVldCUzRs?=
 =?utf-8?B?UndlbE1qZVpRbG4yL2xuUHZBRURRUEpMdXp2Y2dFcmhJVE1UWFF5OE9sd1pt?=
 =?utf-8?B?Z3I5QjMyYlZoTlFmbFQvTFlkNVhaaFE3VnlmRTMrVDkxRkNnNHJ5Vlc1Y3Av?=
 =?utf-8?B?MVJEc2EyR095Vk9kdTVWalhqSlErYkRJQmVzL09pVCs4VWlhY1AzRy96WU1F?=
 =?utf-8?B?WWxIZi8wdDB4aUN3dXJQQUF0b1JILzlYZzBqL3dnMHdLdDNPL2tjUW0zY1Bu?=
 =?utf-8?B?L3Z4RWJZdWxoaGNnc2d0RnpZQkEzeVdSc0U4Z1VIaXlvM21CU21pRjJaRWFO?=
 =?utf-8?B?bVRLVDlYYXZ2dzJoYmdPN1NLY2h4cGdmQ0VrbnZpVDl4dWRmTGxNV1lhWmh0?=
 =?utf-8?B?Uzd0bFRwQnhYS0FIbEgxQ1NZdkdaWEptSTM0OEF2TGxSR21EZnVTYVBQSXdm?=
 =?utf-8?B?QU5BNlBwUnZPVmFIbjN0WExqQUE3YW8zTG1YQ0V0YUh0WHBTdTlJb0ZTUFU2?=
 =?utf-8?B?VHNlL0NVRmducDU4US90cjRGaGVUVSsxV2FKS3hJTkdHeXVBVjVobjFwbWF3?=
 =?utf-8?B?RTNUTVJwbk5iR29HSkthY25LdUxwNEpnQW5GMGFtMGc4U3B5UWJmSURiK1hM?=
 =?utf-8?B?TUF2azBWbTQ4T0IzMGUvKzROUWdHd1ZOTytnZndhbWJ2YkpLaVA3c0UxY0k2?=
 =?utf-8?B?RDhlV2Vucm5ocjM4cTRhVHYzTVBxOWdmdzcrYnkwVXBqT0tmTkJReEczaTBE?=
 =?utf-8?B?RnBMZVpvUTZmSnRmODJsbjV6ODEwNmxVWHd1ZlNjL3VmNUNnc2JTMHVNdUNa?=
 =?utf-8?B?TzZscmpFUmo3bzZVOWduK0JqcmRpU2lHRnplUjR0eE92UkFhcFEzZmtXMjls?=
 =?utf-8?B?R2ExVTgybzgyWTc2dG1aSDZVTkpySnNxdHk2WU5JRjRSYlQ0emJRaStwZnRy?=
 =?utf-8?B?bG1kTTRlQVVIU2RtenVBdVEzNUt5SW11UFVkOForTEdrU0prcXpNT0dpZGE3?=
 =?utf-8?B?SGl4WUhva0JDenlUSTRDcWRVZ1dzWENKMTdaLzZJOGF5d3VjMVoxbWd2QkVL?=
 =?utf-8?B?UUx4VFNBMUpiY09EaUFXUFNsSnRxTHVMQUxCZlBrMGdGa3dKbGtsWnFHcUNT?=
 =?utf-8?B?SDB1bi83U0dhSzJaQ0VER2NodENyRGNET2d2V1pDQlc0U2gxOW5HcUNEc2pK?=
 =?utf-8?B?d2l4NE1qb2RaTnBNM1lhbkNYY2NlbVNmTmFKN0t4R085eDRCTC85L3dFRm5Z?=
 =?utf-8?B?c2czOTBjUGc1SlYyZ2lRdlVaWXAyNlZmNnpEcEthdGJ5WGtTOXA1by9wa25h?=
 =?utf-8?B?ZVkwQng5YmF4S2drNGczUHlCYTU2Q003RFdlbCtwUnkvRXJsMUd2a2g5ZG1i?=
 =?utf-8?B?T0ZXYys5SWM0WUpHVjRHV0VyWlNOelI5RHFWckptaVBzSkVpVU8xRWxpTTJu?=
 =?utf-8?B?Smh5cUQrV3JmcDBaQlE5bURobXFpMzFvelBUbHVtSFhSSkY1NUhPTTZmMnFZ?=
 =?utf-8?B?U1dMdHJ3U0R6MEZMZ0tXYzhVbzRZQ2U0ZTZpQ0FrT0M0YjVMSDZBaDhYQmZ4?=
 =?utf-8?B?eEhUK2E2a2JBWURBQVlYWHFiYTV2U0pYTmZ0eFZIVFpFU0ZUSjFtckRya21j?=
 =?utf-8?B?cEFDNXZaNjVNQ0FBUTh5NVY0MTZQUmNMcnBaWW95cDZkbWo1MEhPSlFENTEz?=
 =?utf-8?B?dGw3elhWTjZYdGhPQWdmK0d5SDVkU1AzaWh1cFprL3M1VGMrR0VWNTJXMXZ1?=
 =?utf-8?B?T0VKVHFHZU91SWpvODFTUjliRzdTWG82YllIUHM0dUpaZ1ZzcWZNWWthYzdi?=
 =?utf-8?B?b1NHU2hzNGd4QTg0bVRuc0JYWmtPb2ZkT05IV1RkU296aFVFZ2M1dm5MR041?=
 =?utf-8?B?c09rK01YQ25nWXlBcXVVQmROZXFYcGNNUCthWGFndVpHNkVPOGJVcS96cHRQ?=
 =?utf-8?B?UHo3dEdxNGVrL0RtN0tZdWlQZjY2Y0tkeUE0VmRpWk9WS0NQT1o5ODNFSmdp?=
 =?utf-8?B?V0NZZXZpODI4aDJ5SEZ3WG05dU16UnVzYjhCYWhXaldIQURsNWc1ZFo2ekRC?=
 =?utf-8?Q?qSP409DXFItaOwn+61HRXyitk?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413eea9d-2566-4c51-60e0-08dd8d7ab72e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:35.6889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kvoyhtXs6vIx17Sbia28wVI7wTrB1Xnykq8QmG66Nv+SOWNJchMjzLEhhO+bBm7Ol/0cJoDCyQAFh2UdDMajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7970
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX/vWBvfMgyVOg
 wBVKvDgh4opKZRAufc6t2eMnu5maU0pkLyQCqOKrHnVNNmg/Ll0oNF4HayihYCNBBxZsnCd1x+k
 DV2fFnGAp1MJ5ulXp071EhFRCb+ZHTEll73znIfjvNPmLoKcZGScqx0ZTTF7b5HvmQCviSrFXP2
 0jP8HE3o2UFLNv0bETxAjU7+8Lg7rFH2fEn2InpXMnfSNnoZoHJyAGxYjzPWEa0O5gZ75Zot6j7
 LSdU7H52MjG7n+cYKDaYdEtfp1da8PNQOiXk8n7uwDKxOOiCqWDxoCZXxwT/fUQfMA4belARhOv
 PA7B4avZwXPkerz4lVFmx11UjfEOOlIhCamec7dEeavixq3Ojt0yaYuBNXGZv8ehdOKAEM1WUAB
 93fySkCdC4aRh5YQOBr8bHG53QgvckZqKCojGq5iocdl3vPQPcDR3ggWs0/Jct4GgWdZKQss
X-Proofpoint-GUID: Nj0fOgj2gu-yxTj1RSWOLV1C2a3Y-m-d
X-Authority-Analysis: v=2.4 cv=NMHV+16g c=1 sm=1 tr=0 ts=681b7a4b cx=c_pps
 a=WxcSnoYPg5jl6yrDmkeCeg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=QBjBLJMD6KpLvVksgCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Nj0fOgj2gu-yxTj1RSWOLV1C2a3Y-m-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Allow attachment by explicitly passing a TYPE_VFIO_IOMMU_* string;
vfio-user will use this later.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h |  3 +++
 hw/vfio/device.c              | 22 +++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 342c4ba3bf..8b1437ba66 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -127,6 +127,9 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
                                          const char *typename, Error **errp);
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
+bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 31c441a3df..9673b0717e 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -376,21 +376,29 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
     }
 }
 
-bool vfio_device_attach(char *name, VFIODevice *vbasedev,
-                        AddressSpace *as, Error **errp)
+bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp)
 {
     const VFIOIOMMUClass *ops =
-        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-
-    if (vbasedev->iommufd) {
-        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
-    }
+        VFIO_IOMMU_CLASS(object_class_by_name(iommu_type));
 
     assert(ops);
 
     return ops->attach_device(name, vbasedev, as, errp);
 }
 
+bool vfio_device_attach(char *name, VFIODevice *vbasedev,
+                        AddressSpace *as, Error **errp)
+{
+    const char *iommu_type = vbasedev->iommufd ?
+                             TYPE_VFIO_IOMMU_IOMMUFD :
+                             TYPE_VFIO_IOMMU_LEGACY;
+
+    return vfio_device_attach_by_iommu_type(iommu_type, name, vbasedev,
+                                            as, errp);
+}
+
 void vfio_device_detach(VFIODevice *vbasedev)
 {
     if (!vbasedev->bcontainer) {
-- 
2.43.0


