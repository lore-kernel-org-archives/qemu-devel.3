Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C0FE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnINC-0005lz-2d; Tue, 03 Feb 2026 10:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIMa-0005Xq-Q1
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:07 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIMU-0004UI-Uj
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:30:46 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6139wA2w2237761; Tue, 3 Feb 2026 07:30:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jlS4pvfgR+rew7Cod7ZY4l6hfu7Qmjdhxkse57Hqe
 Mc=; b=SVYHXahZf1OxnuwwzmoJtJQWSmkEKMH913nCbUFyeFWTAsdtbhLw58czC
 c2ffH5R3eDLjz6FV/UC7o8X22Hxg77IZvuJfuF25L1Y8YTUjIwG6w7jqfsgR9eKM
 SWOFU4eUf+X8E98r0e0x5ml5brxJsk5bshR1YyX/GWXEH83GIcx4sk0DIyMT0vPd
 C3+27WAOf8chIMXtY20y1biTOlbhp3t4AG+obTxHjN5ntzkB8KgJvht1T+ka33hV
 TSAG+lDlBeoQtwNlOXuuuz1cbIyYfCpoEcP53ye9k3V3TLYB5u/lYSInnxpRhFuq
 dlkTWZz/ijS3XryRDzdU+ahUY4rGA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021083.outbound.protection.outlook.com [52.101.52.83])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1hxdf0sc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 07:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAJT6xgDxrLYOL54ojzQWraf9ek/MjgyO+Y7A+VHnF7ktqxUuQ0iGPlKRzETdEGvbr/Q1m+p+lXcmNA6/SdbAQ3mpnbT9WOuXAx83DbPPa4P1KxMmS4Mzugwygwc0NQ5fEZs5p5DZeJ0r0Ilbshofd+xQVnaRZyTqFMSo//daUpz96ReMLMHXn8tRZC83DcAjQD2EBmtElDwwpvkwDmXXJ0A1rnufcieMJpVFcbhJaO3++hXAkWFPy3vDpV5oZ0MBnyAFXqoLyMbhkd9aFBEDbtzWq9s9qeLkVl8gQQ0bZwTjplSlsu4RdDdIX9tHDujnphhARFDXIR3akNKDDgQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlS4pvfgR+rew7Cod7ZY4l6hfu7Qmjdhxkse57HqeMc=;
 b=DEM9dy7OHl5dzu2AHK2if1+1upXLOlwoB7NbEPThglG1Y+99W9rC0wyMcuaU6mlBXvqxbdoEc9VsxsHNkNChiGQkvFQFv/4e316M6c/v0Qs8+A2aWHAfrTMuWTxKlfDNJ90bYE2QTmrNcu+rYANW+pPul09fBQtx30oNuxljkG1GUGGdLDGOO+KNp/cj6voZLPhZyENA9OVMtxfTEwIOBWm7xUsdQ2qzJ9qOUnlLbhm7VJYJPIhCB6IMpTaNGwRtVoTHO18EMoUBh4uUckLyXxtZO+e5JHeQnSUcPIZOBv8euFk7shHSKljLe6LvFioVQNK69EVoqctqMfVTDiasKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlS4pvfgR+rew7Cod7ZY4l6hfu7Qmjdhxkse57HqeMc=;
 b=P95l5Rjl0pfw1/tAk1O243lRuObDpxcyx5FTe/lDM6xEjuUga1BFS8xqY53p2m26fH3NNkxK9gaTdlg5pitaUZVqQoA8Q4+np99C/A2qwCnSUlWIMi7GBT+8iLY/Ne3eoAmgKfp98tpNeicBPVH8XGrDWDv3NFAELZ1cd1ExXWOqRSCkfSklLbY1+52IJKElbJCVhZpDMmszD8ZYNj6b5GHlwR9jnpLWRW8X6O+DBtVqNP4ixys06VoPMHLdl+tqnoLH2cbDUddt4W9I8M3EoohuSYyWOKI1QOBELOQXoWa2C3xY7UK9I2VluIcNNxMUKNi60XR1I5XAMui2eWuK2Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10289.namprd02.prod.outlook.com (2603:10b6:8:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:30:36 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:30:36 +0000
Message-ID: <12a1f773-3d64-4468-991b-f45b42f996ab@nutanix.com>
Date: Tue, 3 Feb 2026 15:30:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/37] audio/adlib: drop ts_helper HWVoice field
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-4-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0069.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a18302e-e87d-490a-1b0b-08de63392d9c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG5ZY1MzeWNyclFWZkVSZ1Y2THlzYy9NSzg5OEplVlo3ay9FdjZDeDBMRmVk?=
 =?utf-8?B?Uks5Ui80eElKdWlmS2hiK3gwVnUzMVpJS01zSTFwYW82cVBoMjgvV2NvZmlz?=
 =?utf-8?B?dlN6ck5DeFQ3OExpRVFtOEJPZXZJLzJKQUs2amp4MHhZQ3JIVTBzUldKNjMw?=
 =?utf-8?B?WFFJT0U1YWhhVXJlNS8xblZleXpWUFJTbjdjNHBJb1RweUErdE1yWnJCcmpY?=
 =?utf-8?B?VVZvRHBDMlNSclA1dVIyY3dQbHVKRU1td1UxNVpZRXp0WDhVRGx4QnI0UzhN?=
 =?utf-8?B?N0RXQlN0eFltalpqaU1KT2lCL3EyTjEwV3o4MGJlbDFVZE5MRzRNSlJjb0pZ?=
 =?utf-8?B?MnVSdW54RmxCL1hGU1ZCU3NUU01Gc0g2R0djeGIwbFFnN1NqclJYdGZadlV6?=
 =?utf-8?B?ZEFaRlNueW1DcFVoYk05OC9VZ3NmK2NlanNnMm8zVDhmL0QvZW1TQnJ1UUx4?=
 =?utf-8?B?SlJtcUxkWDVlR1hZSnQ0cXlXUHlxRDY0UW5RL3lOSzZkSzlrUTVaTEROSGN4?=
 =?utf-8?B?QW8vWjFjYmFnRE5qRTMrR1VmSzdHK2wxVXBubkRWR2hSSGRrU2I0a2pqMXlt?=
 =?utf-8?B?YWtCYlJYWkNhMkJLNlJCN2NPTlRaaUQ2Yjh1QmgxOXBTUDJFZDZXRUJhWHg4?=
 =?utf-8?B?NXo0OHpMTTF3QzFlbHJBTGkzR0xRTUJsamZVOWxyL1o5OWErM3dRNm1mUWsz?=
 =?utf-8?B?bWdFcStjMis1c3V6akRMVnJMWFBhTWw3azdUVWdjNVA5WlJ4dDZzeDJkU0Z3?=
 =?utf-8?B?TjlYWUpMaWFZSU1GQklaL3ZUaC9qbmVZaTlRRTB0K1RzcDRvL3RqRlpscjlO?=
 =?utf-8?B?Y0hNTm9ZMTVxUmFvSk5RQ09rQ2N1N01ScUhwSW4xM0o5TFFsTHVKRmRNa3NN?=
 =?utf-8?B?OVBURXdsOS93MGR2WjB2K2Y4QnJwVWNwZ2RLcHRYVndxOVc4M2VRM29lUUdU?=
 =?utf-8?B?dmlIMXVsRGFWNnJVOE91QjgyT3hxUVFiUnJOb01MdHgrZlhLamp2a2c3dnN1?=
 =?utf-8?B?WXo2bzFBZHVyeTkxZXZoZjRTeGtYa29ZNEd4bGljOTlpRmhGZG5Ta05YWFVv?=
 =?utf-8?B?dnlSd3lDb0wrQkVHQWlvQzFUczdVcHJkdzdNQWJjUlMydUxrcDh4VkoycDkr?=
 =?utf-8?B?MEhISDNkNExuajRQSXlabzdGbWhHWGkxSEtQMWRWSTQ0RWxYbHd4UFBXRjhV?=
 =?utf-8?B?TkZ3WDNLb3R2TmhodUJYVlF3RFpXekU1VW8xSUp1MnlJQ0EwdVlmZnQ2RU5C?=
 =?utf-8?B?NXhOSmdRQzkrTThDekZLNFhucUNLNTBUbWFaY09TUER3VG9iQ1pERUR0TURk?=
 =?utf-8?B?bThlblNCSWxzWmdQUElPMWR5YUQrZ3paL0ZiRTBjYW14am8zcWIzYnJkckZl?=
 =?utf-8?B?ZHlUa0s1ZG9IV2RvMEE3eXprOXIrWXBTYWEyZzRYeUNoM0dIRC9lQmNGNzMw?=
 =?utf-8?B?NWRoZFZBNDRwZWwvckoyNnVjME9OUEU1R3paTVErYkU2VUtWMjRPcUM2K2p1?=
 =?utf-8?B?YW9HWlVSTzZPaklPZFplRnpLelV0cEVTU3laWGtiakVHREtjd0VjODlzdWV3?=
 =?utf-8?B?VjlYZ0VaYWRMTlVpQTBFRkNNTWQrZWVTNElLMlJVTlUvVXZFNk1XT2Rmd04v?=
 =?utf-8?B?R1F5WUpjdG1kaXFxaXBmL2tCUGt3Ty9qaGRya1k5OGppcGpmcC9yYUZlQWdW?=
 =?utf-8?B?VzF1NkdFdzVidTUxWDU2VjNYem5tR2FjSHgxcW0vSk5mb2lIZVhlL00wZ2pH?=
 =?utf-8?B?enc0c2J3TzdpaDB0L0hjdUtVZkNBRUZxQ3Rkc2tOVUpCOXpINnQzNElGcHV1?=
 =?utf-8?B?aU8yL0JMZjgxTkQxakJPZGppMzBUVTJqYUJ2SUNEUTdCYW5zUWVMb0I5K0dZ?=
 =?utf-8?B?R0dnWGo0bjU5WjB2VlZUd3d3aCtYUDk1NjRWb0FmR0hPQ1BvVGQxWWJRUyt5?=
 =?utf-8?B?cUxXWGgyUzlBVkR4d0V6Q09kM25BL2N0c3ZVRGRWRmRlT3BMWmVmMjd0MlF0?=
 =?utf-8?B?U2JHUmt2VDRRb004cVNEVUNTYUk3YmNKSkZyK3pSTjVCbmhmM3lzc3dZa2tC?=
 =?utf-8?B?RlRSQWVFSlJnZWY1M2J5Q2VNNFhiQ2Zud1ZjVWYvYTk0YmhoMDdlWUR2dXNE?=
 =?utf-8?Q?EjOY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hCTXZBa05PVzIwVnF6N3lqanVHcENZaUhOZUVaVHhka1dKdU80VEdvZE1t?=
 =?utf-8?B?YWlVemZBNmY5bkFnY0lJVWRvNEhURHhFWnljUVNsL3Q1eUtkRldRd3FubHlj?=
 =?utf-8?B?L3lQbERtNko1dmorYjhnWlVPajkrd0UvcWRONmJlcnc0cExJd1AzbElCZ0xm?=
 =?utf-8?B?RG5rRE96bVdWTHI2NWxHZ1N2MGJaZlRJY1ZLTXNZV01heXBVdEdTcTBZdmxT?=
 =?utf-8?B?VVhLTEUzMmZ6ZWFqOUJiaEJLRVVveDZXUS8zZmVIZ0FVT0Y0RXQ0VXlrM3pY?=
 =?utf-8?B?RFQxV29JbUpUUkZPY2hMemNpRGt2ZWNVaXU2VzNidFVYazZneE9vVWVzMzJE?=
 =?utf-8?B?U3JOekQ0S3JxMmZRUWJMYlYzb0o0czZrdlo1c1BSVXB3a0pjcTRVWWNuaGto?=
 =?utf-8?B?czlUREM1SkFzM2E5aHMyNVF0RTU3OXU3OVdKcmpKUUZqTXdqSVpFQXRjQ21Z?=
 =?utf-8?B?ZmFaUEh1akJhSEFiQVdxTWU3MnlxNzd5d013L1JFQy9LWVVTMFVNclJhMG5P?=
 =?utf-8?B?QXdaR0pEdDE1cWZ1Tm1XV3FaMlBMQnJ3c3NIdmQrdzdiK2I5ZTZoczFDZzBz?=
 =?utf-8?B?NmltT3ZST0hBL2hyUXYyejRRdGlzOUg0NHNNMzUwdVRuMlJqdEdIWWM2NkhO?=
 =?utf-8?B?R0hCbEpBaXRCd0hxenhXQnIrUUZ5bkh2eDVlUWdIQ0l1Vk42NWE3ZWJOUFBT?=
 =?utf-8?B?dXN5ZWhHbHBjbDZ0RUNWUWRxSDdRbkpkUjZHYU0zVkYzMytMOGtUcWtsQ1JP?=
 =?utf-8?B?UTVFVlpRRTFrWEJZYmtoS2JIWjR4dklacGluN3lVSkE5SHNSYkVVUnZWcmZJ?=
 =?utf-8?B?SE9VVDltV0k5Q2x2MlJXMmRDVForRTlNOXp3L3duSitMcUpPUnVOZmlGa0NO?=
 =?utf-8?B?MHMyQTlMZGRPMmt2V3h2cC9CRW1uaGp1UmsvWEgra21vV2UrcVZQbjRZQWM2?=
 =?utf-8?B?RW5OVmNvRW1zVjNneXNUMjVHNXFHM0lOb1VDdXI2S2ZFZ1VEYlJteEZYblFK?=
 =?utf-8?B?RThLSkNmMVgycFQraUlLbmpxSXl4c3dtOWpCZ2hRa1pNRy9iMVRwOGpqSkRH?=
 =?utf-8?B?b281TFVDMW9FUDEzOHJURXRsakVkN1dSZnRKaGI3RDNwREJDTDFlNnp5SnJK?=
 =?utf-8?B?bno5clA4cmU4SFhiUkJJdEFpdDJlNGgwMXZKUlpQRWpuNUE0K0ZCVEtSeHRu?=
 =?utf-8?B?eU15QUlvdlYzOXNoVXNGdEdIckRBc3lzRGxkcWdzQm5wRit4TVZXc3NwRW4z?=
 =?utf-8?B?cFIxTUlIOWg0bHFTbkk1aDZIMWt6cDBpVCtYbTlaTFpLQzd3dG9aWmV0a3RQ?=
 =?utf-8?B?dEpxa2NnUWVtVGJrRlpsalBsbmlCVWdPMzRIc0lURUx4OUpxUHRMeXY4WDFI?=
 =?utf-8?B?LzFObjhBd2hpQXkrM2krNURMdjRQRXpkQnRSWklPRkZ4LzNtR0svNEZZcFk0?=
 =?utf-8?B?OUtMS2dzMlowcGwvSEpuSVRIV05YK1lLNmk4bFp6Q2ZLNkZ5ZWJQODR3Zngy?=
 =?utf-8?B?dXRudmo5MkdkVGZOdWQyUm9ieWRwcTdEaU5NS01rV092RVFOUkRIakVraEh2?=
 =?utf-8?B?R2Nab1U2UDZ6eHN2WHM5UVFJVjl0blp1RW02elpXbTlJMHpCcEhEK3pCcW9s?=
 =?utf-8?B?OXFpdzZ6T3JHbVZzVHpQSkhYVjcySlFWY3FCTzhmbWVTKzVjdm52dGhKN21q?=
 =?utf-8?B?aG1TTTdtWkRzRnJJWHQ1YVk1RjYwRjM0QWlwV2JzT3RLcHNJNVF5M0FEa2k1?=
 =?utf-8?B?VHFmL1RmbGV6Y29wMzhkY1dwbUZTOUZnM3UycVhpSk9tN0lLRGdYcG5neXBW?=
 =?utf-8?B?UWtJTHVPZGhzT3F3eGV0R3d2OXpReEx6cisxM2FoaGF1N1JtbnB4VHdCVHJq?=
 =?utf-8?B?VjJka2NDOEJYK0h2R3IyWVV1YkdzMmQ3dVFiaDE3ZWJEMUh5L0JFTGFOWmhR?=
 =?utf-8?B?OHU0VTVzVDFES1YrL1g3bFdvQmpTQzhGMkNBUUVkZWZLT2cyOVNwTWc0MjhN?=
 =?utf-8?B?T2RmMktleFpLekI3QktMWjRBR1JwZkdDZHVYa09BNWtzc2E0cEg0NWFLajh6?=
 =?utf-8?B?YkZFZVJsT3BBRlFwOU41UHBXL2ZDNk9UTHcwOXV0RjBNN2Jreld4UUpPZkZq?=
 =?utf-8?B?cTZ5TnJlS2RFaXhDNC9Kcjd5VlFibFF2clhMdk9OSTVmM01sQkpWVFZKWlp0?=
 =?utf-8?B?eXZoZFdkaGdmNm91b2ZQVS9FbGNtcDFwVWFQR2RzdmNlcUY5dk0wL292NEdR?=
 =?utf-8?B?WHZyODlTOWhlSEUrcFoyTDUvR3ZCbE5WbkJJa3ZBQkxJNUJnTm9yVEh0NGU0?=
 =?utf-8?B?cEppaWtTV1ZtZVhvT1pHYkNLckdUZUFFYjdTeUlYdVcvcUxFT2ZiVmZxVkFK?=
 =?utf-8?Q?8cVH6yCivTxEIm2k=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a18302e-e87d-490a-1b0b-08de63392d9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:30:36.4478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJ1az1KTD/rb+jKU7OGD0Nj+yTaCO/YTcTWOWAl8es9wCKyQCilD5JUQNjWzHxrNIzJ+lsv2ry0XK4JByQcbpsUDL/fZzPot4PoE98aZvdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10289
X-Authority-Analysis: v=2.4 cv=J4inLQnS c=1 sm=1 tr=0 ts=698214a0 cx=c_pps
 a=X+j8kQviiGxwf3Sz5eWiEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=2OvEAWqYw-nUgHqp_G0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e3iaKIU8XoIKU2DIdSpQ2jK6Kb46MMnO
X-Proofpoint-GUID: e3iaKIU8XoIKU2DIdSpQ2jK6Kb46MMnO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyMyBTYWx0ZWRfX7tWTsyXn8Kl3
 ry/0Ms/XThu4koodyp9qK9jZngRNmXgB8cSSRgu4qY/8VetvQZW8D3Lp4BR/F8XHxaxag2uiw32
 Aj+ASAVuiCMBY3e85ZCW5GUnEBBhR7kuuTMufkTGuKjanu643UtY/vO699wdN075DiPpPNMTOjO
 cOA3bEQrYpWhu548BWV+pMBbXUxwzniyB+1q103nxAnu9HfRrBI/u5Wg5x39RdWY+87Rrsc0zNW
 fa9UPKHyW71guPKSDjmjfcebQ5fAac3Whi9Pme34zRCW5DgI4uyEqZtaeDk97td0i4EumSfk/Oj
 YzA06QVo1tjYiERqTx9zsl28+t7roQoCl+Kyeh13ChI/vACfIB+wQh764p9nVupxY+PJOBytuYq
 GFOnHa1g0Z1KniduxEnofpq6V8g7ZsbyNgSPkFXmA0DM6WbhHIqX4wZMcn6YrTotiSwxGUHQxpw
 OmjuHc53igHYEazJQQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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
> Previous commits made this dead code.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h | 2 --
>   audio/audio.c     | 2 --
>   2 files changed, 4 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index b2b8002477c..20b4c87b0b6 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -77,7 +77,6 @@ typedef struct HWVoiceOut {
>       struct audio_pcm_info info;
>   
>       f_sample *clip;
> -    uint64_t ts_helper;
>   
>       STSampleBuffer mix_buf;
>       void *buf_emul;
> @@ -99,7 +98,6 @@ typedef struct HWVoiceIn {
>       t_sample *conv;
>   
>       size_t total_samples_captured;
> -    uint64_t ts_helper;
>   
>       STSampleBuffer conv_buf;
>       void *buf_emul;
> diff --git a/audio/audio.c b/audio/audio.c
> index 86e674410ab..e5841d7f0e6 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1239,7 +1239,6 @@ static void audio_run_out(AudioBackend *s)
>   #endif
>   
>           if (played) {
> -            hw->ts_helper += played;
>               audio_capture_mix_and_clear (hw, prev_rpos, played);
>           }
>   
> @@ -1319,7 +1318,6 @@ static void audio_run_in(AudioBackend *s)
>   
>           min = audio_pcm_hw_find_min_in (hw);
>           hw->total_samples_captured += captured - min;
> -        hw->ts_helper += captured;
>   
>           for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
>               sw->total_hw_samples_acquired -= min;

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


