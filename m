Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DC8E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaHM-00009l-Iy; Wed, 04 Feb 2026 05:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnaHD-0008Mz-Cd
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:38:28 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnaH9-0005Ic-VY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:38:27 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145rmtJ3266349; Wed, 4 Feb 2026 02:38:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=P9HTWaq4linaSDlkngZc+XxHhs0E/K9c3ALkTv3ag
 0c=; b=o8WQaH+KKiF8iPPffdG5/mqp6b8KjCM5FPx6WRNkmdoaqB/yHF8CaZdRs
 t7xqv2VJPte6uxvbXY2MkxlJoWtXh1mmf+LBsXGHEWfG80Vn5b3h9RNxSnEpdQGF
 SbvSBVH7AjAA/DiJ3D4QQPFl5YXgriGZhzj+M6HEk9jw0bxdWDVIfRIc9LyNSza1
 vkUYvDReiCaHHu4dXwUnETjRpCglFS1p7YknAcvENnChe8Pb0USu/ufUy8hgao9x
 Wk3By5u7aiIgb2tZaGWBLwGlpEl65+GpxAHlKdAQoqWOLH2vwP0JkKtLgotM6XOL
 1xcl98/owziDQBkgsej68F01B8yzg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020107.outbound.protection.outlook.com [52.101.85.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3kh6ads5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 02:38:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdiXma+r8Rywacclpx8UHi/8OdwWBUI/tLXEGB93vpz0Kk5FqMCWxFryaWhhc0cVf8zB2lziQX9O6t4Rx3sl9+5MrkmB3hBcIu8ZXB+YQSMnIj2lFOeKaO96qC/5JZ12Ex4IDfkJXQ2vTDkHsn11sW/ty4uiPiumawk4L0BmxLhS6FlG8RpP4rDPW/QstGioqCKOShumaWd+qQmrf1ZIRmaaNPqNcS0EuR7qbEnw7JKerQLnctZZBKzSF+hrOZEIxNhwVItUVbn+cb/Ce95PieMhyrDlMzl31RFlGNhv13nwbzQ835I9Z+a9jKr8fg4i4sZZhZq/Lx3Z9xUAHI+YTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9HTWaq4linaSDlkngZc+XxHhs0E/K9c3ALkTv3ag0c=;
 b=Oh/Za+0j8/6+Y9lkbldXMxbeVVMaG3/NBEFCzqZry/4VD4gwiUQiZAeYE7g/p2VUgrqXRpN4O3bDObggOjvu9PzfYTAhCqtrr0M7/E0FoCom3cSvSt0VmgFvQWJsBoMz4Ieueu2iZ4zUaB9gVYx/dKWJyPqV06cBrIYGOv3ZI2GiKG/rGH09F01ez3ERqqDC1la4BDTpIVqgihmDdkVpQNdxKY5RG0VzLHbSvm6aiW2F/NB472JnLDyiKsceRHWvOujx9MF6ijh1WdZJQkqYoGeVzMC83d8MKOXgejTxgVcOzs+V22y93sMtmQQkkyQby1JvFCy4Km7TBYUDiBEHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9HTWaq4linaSDlkngZc+XxHhs0E/K9c3ALkTv3ag0c=;
 b=mShwZaJwgJYjRI72KqaY9C7AqNbgb16vx/PAaT80cGjaY+1vj804Qb0qpefuTdRYjGkneUYRa3cDEO98Cpysfx7dvpPU9LBz0apy2z2WY54uwx8DJM63+EWj6JtHGvZseQKzkvR2K1Uso/sCfbl6AIZRPc6LhF39pPa05Yqmkwc8JqrIu/qJfd0bHsCXwDMvmqhSBFYHh60Gtj1gTEI7zXm81I1Hgi49OcFb5lLVg8JEw0Rb1oew6U8FixOm9sI/JSEMM+wU/zyUHr4wpRyt7vIKOmpYfiRsw1ebp8bnzgYnGEOoK5lBb5jlWZnjxJ9ogjBCScZQG0zte/l1zCeNxw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV5PR02MB10850.namprd02.prod.outlook.com (2603:10b6:408:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 10:38:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:38:18 +0000
Message-ID: <f660298d-6a92-4b6f-a113-e0bd239818d5@nutanix.com>
Date: Wed, 4 Feb 2026 10:38:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/37] tests: start manual audio backend test
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-17-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:806:21::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV5PR02MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8a08f1-c91c-4be4-ee51-08de63d98298
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkYzbGJxa3NRdDZvR2ZkY0lWWXRMckRXUjdxdkM4RUZoWE9TQm1OWmJyOW1u?=
 =?utf-8?B?MWs2T1k2U25pRVZ6bDVoRDZIMXFCRjRubjdtWU5FeVpOTURaeGhLemhFcVVi?=
 =?utf-8?B?QnBLeGNQRk8xdHpkRlNibkFrQkNrVm1Ua3NGbjRpMHZNQVN1cWNqRTU1WFZZ?=
 =?utf-8?B?cmFNdGtWbWVhOVhsc2h4dWN6QzJyaW5ITzR3QlVNYTFKVWZrN1hwbWJuRTF5?=
 =?utf-8?B?QzhPdUdTb3pRdDgxRGw3R0xzbWE4SGF3Uk5teUROcmJmcTIyamwvNGkzaUNu?=
 =?utf-8?B?MXluSzRrVzV4aEdGSm9ERW9KbnIveWM1WElpWVpNRWhBL2Z5TnNhL0s5M0xl?=
 =?utf-8?B?bjhtSWF5ZmkwWmpQNnZhRTc4VU5BQ0hQTjNGeWFQSlFUdlhlcVJtOHZTc0tO?=
 =?utf-8?B?V1ovbVZScnRYZEhQdHk1aFovZS9qOCtOVllUaFNUQS8zdnZoZ1lScEljQnpL?=
 =?utf-8?B?bUJib21OUk5lUnJHczBxZ2ttZ3FBeGl2K1VtM0RkTHhsTEVFNXBGcmFQdkV4?=
 =?utf-8?B?MmUvNis2YXdyaVRpN3VsdWtDTVp4ZkI0a3V4U3dqUmJDL2h4VGlrVEQxKzdT?=
 =?utf-8?B?N201REF0UWlxSXpVTjdaeWhtNnR1a010SzRHelBTWFI1R09DU2hURFV6Z2x5?=
 =?utf-8?B?OXNkRFQzSzNDRS9uWWM2bDhjZE1QWmdOMXhJakIwakhkSUhKNXBTRHRNaytZ?=
 =?utf-8?B?cmxTUUl0T3RNaDI0MmVBcys0SkxYV3lER2ZpTnlJMEtTbitWYUcwRk5QUElw?=
 =?utf-8?B?b2t5Qmw5VzFWUkZrSUxmVU5YaFNmeW9LTEZ6ZVFpWmFjMW5WL0pvQ3l4bWVE?=
 =?utf-8?B?d1AvMTBKZU5sZ29SSWJTOE1PNE13UDVjRE9KYlBSSnNObDAreEhOaVJIcDlB?=
 =?utf-8?B?SkczT05kTy95KzgvdEE0SUNJSjdLclFVczRCaEpQMERXNG1kVFM5WHJqdk0y?=
 =?utf-8?B?NHBqSmZDTm54VWlyeTZjOFZtdUZtYmpFYTRqNlo4VStsOU1IeW9jQVlubUtK?=
 =?utf-8?B?cTljdUF6cmFYQ1drL01QMUhHTFBtNk1Mcjh4Q3lpNmxZSWZkNllpWGcrVkpr?=
 =?utf-8?B?Y0o5U3IzVHVqd2ZidndQZ3lYRlFYRU44TktWVnlTYit6RHRVdHlHQ2I5TFli?=
 =?utf-8?B?akNFMDFBc2xXb1lyeXo0T056ZHU0aW8xR0NmdkJNYWVSYWZST1VIZzF0TWh0?=
 =?utf-8?B?TUQzVHQrY091U1hvR1VKbTAyMGVGdmxWb0FPWCszTjhITkl0MDF0MHR1L0Rp?=
 =?utf-8?B?WDVUUzFpTWxkQVVZZGFkT3dwakJ0SEQ3T29BQk9hTHh0TnJacUwxMGgzSmFW?=
 =?utf-8?B?WWtaSXNOdG9uYiswcm5UTFdRb2kyTTdtMUtoQjhuZzIxZ2xhSkNSOE1xZm9x?=
 =?utf-8?B?UUJXaXRwQVBuUGVSalArWTYxTlk0OGRPVjZjRERha0RpMXhDR0o3ZU5qMEZH?=
 =?utf-8?B?R3BpV3BsMTJsK0FiTXpENzZsSU1WUUlVcXc0VEFYZDZoRzVFeW00NDdWakc2?=
 =?utf-8?B?N0lQUHJmajdoZXd6YStiWEZOeisrYk5NQ21pM0pBUHpDYTdWUTFKakdqZm0x?=
 =?utf-8?B?Q3JiYzBveWpCakVSdEpvQ095dTMwNjFKQ1lvcVRJZGZueUpMY3RQUXFvSXZv?=
 =?utf-8?B?eVI4dDdycWFEUzN4enZJVk5yVFdQZ2trekw2ejZzTG1DVjNmaU5pUHVkcHhl?=
 =?utf-8?B?VXd2NmFFUHR1SjNXY2Fnc0pxMnl4Vm5MUTlSc3BMWnczQnpaRDBqN3V4VXJ6?=
 =?utf-8?B?VW1EeVRGVlp3OVVHTkxTbkcwTUlqUFpqYWU1NUNwclYvMllLcjNQNzNleks4?=
 =?utf-8?B?dDFKVFBnRER2L2c3SnVDWVBGRmhBZStUOEpBWlZBT0QwU1BmY2VPRy95V3VH?=
 =?utf-8?B?S0xEVVdJSTFDUXNGb2tMV3RNaE5wcXZ5ZlZLMUFteVRkUllzRDFuUnlOZ2JV?=
 =?utf-8?B?Sm5oLzBIY2VqdCtVaWdxSkwxV2FMeWIzSkdXb1JrTWtpZkIyeTJ5aGNYbVFC?=
 =?utf-8?B?bkhqQUVlcWRMTnZ3U1h4TzVqNFBZUllEY1hTaGZOUVlNMElhWXZSSGdSeXNP?=
 =?utf-8?B?eFBqZjRtZDZPcVJrRG5kZmV2QVo3UVdnRERoOHpoaElINWdlSXZkalVndkRQ?=
 =?utf-8?Q?tt9s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRpc0d0SVRBam5LbmtrUzV3dElkZmJIdmpkYVZ3aXNWTXlZaThGeXRablNQ?=
 =?utf-8?B?ajVYWkFrMmdtb2cxUExxV3ZSODJldGZsVXZ1NUZrRTMzWFpHWjJxR20vVzNy?=
 =?utf-8?B?akJJYmRQbjk4empHUzM0WmN3QnJLT1FSMElvQ1pFdklGckdMdVBVQ1VQTFRw?=
 =?utf-8?B?YzZVbm5ySDNmRXhpSVBFNklGNWNXQ1h5SmJqQUdYTllNcmliRUh6a01ySFhr?=
 =?utf-8?B?djRGS2JqTkkxUG5JL0NNNmRyZGJuNkpxUlpLVXFJNkJSQU1iRG5vVHM3dVZs?=
 =?utf-8?B?ZDQ1NVlCemtSNnFZQVJPTkl5NTZ4RGFMNGk4ZndGaE5ycVdkL3BON0FjOTZC?=
 =?utf-8?B?QkRPVHZRVWhPdDYzOUNjc2xRdVFGNlM1QTdIcFd4MXBVcDhQbXg0WXUxM2U2?=
 =?utf-8?B?Tkw1TXUvcThoczBUL0hJcit5bTlyQXY0NFBUOU9zRGVWNW1rUUJGa1cxek81?=
 =?utf-8?B?Wk5QUEJEVytxVjZOT2xoQ1paVkRhclFQUkpFR0ZBMHhRTVNwVlAxTk94eVIr?=
 =?utf-8?B?YVFQaFVYanRLMjM1ZHR0bkJ6VGp0bkZ6aDBNMDBuYlpvaUhBc1V2allZSmpa?=
 =?utf-8?B?WVlvOHRncXYrenptUlpYRmRIL1RKbmVldHl0dEdnQVdQOEFNMkdpSFhsay9z?=
 =?utf-8?B?ako2L200SzZzeXpHa05ZeWNQeWowUmNxVzg3MUthY1FKWlpEQjlyN2pENFda?=
 =?utf-8?B?TjZvRnp3UG9acEZzek9zUnBwUTRWbFRTMVNoNERSQmMzak9OL3Y4Y1hVNFVi?=
 =?utf-8?B?MUYxM2xINzBtczNadXNNdHNzOHhzTG1Yd2sxbWZhOE13MkxNem5VOXFKZzhV?=
 =?utf-8?B?eFZoT3dFeHVIMGVudmxFZlduY1dSL3lxRjFRV1QyY1lCVFE3TUdzU25WM1Zi?=
 =?utf-8?B?VnJPTkVXemlzcXRHZUgxQS9abWFGTUgyOVhQSGpnbEdvZjFNL3A1c2lUTDZZ?=
 =?utf-8?B?eDJ4M1djVGJFYmpub3RmellVTTdJVG9VRGlGRzRPVmpUdXJpYXZQWXErVVll?=
 =?utf-8?B?NDMraEY4SDFnQTlvUFpQL0YvT2IzUHRIdUNDUHduajR4Wk5kdkg3RzRxd1hx?=
 =?utf-8?B?MFN5cGwwamd5eVBkdnNOV1hiMFVoa0NaNENrOXdKMXdGb2xjeWlKS3drdnhC?=
 =?utf-8?B?Y254OFlaejNCOWFYdXEycjFOUElIVjUzOXY3RVViWlFNZDduQ1BBaW9aV0pJ?=
 =?utf-8?B?bU9iRFFwc0t0dEEvMjZTWENwOHlrK2U5WXh6dXRvUGovZ2VGcVFmQ2tOQTgw?=
 =?utf-8?B?RzUzUy9lSTBLb21jNUdIS0xzRjU1Q3oyOGZ4Ullsa3dxV2hZS2hsU2NhZkQ5?=
 =?utf-8?B?dnp2RWdHN0V4aUVXcnhxMFJ3ZDcveUtMb0srSm05ZFZkbEZBN3FVL1lZa0Rk?=
 =?utf-8?B?ZDZsemN3U1R3djlnSVcyWUFURFoxbEpPbnVQdnY2QmFPWk1mSFgvSCttU3Z2?=
 =?utf-8?B?M0hDYkZxTEFEMXpxd3BIanhJbEVOUHN0cFo0Z1pYM1RqOXlPTnFPOXp6aVg0?=
 =?utf-8?B?VEZWN2QxZk1jOFBNbWtDNGYxSktXUE96VDFGOWp1bTRuZC8yT3NjUm9jVlNB?=
 =?utf-8?B?cEFLNFJ0cyttSmZpTFhSTjhzZkx6dHUzMFlJZVNHWlMyVUVBekQ0dGpSM1dk?=
 =?utf-8?B?OFFmNlBubHV4M3Nmb21NazhRd3FDM3lCc0VUNGJhSXk4L0JXejdSQWR5Z0wr?=
 =?utf-8?B?cDN0ckVCdVVYbUZYTW1UWGc4YmF6UzNUVW0wR3RuQXpNOUw1Nm1oM09ITTlh?=
 =?utf-8?B?NFU5UWFxSUE5enZ3VXdYWXhHMEdqb2hoY0RVcXZXMGxZVmxCRmk5SkM5VjRR?=
 =?utf-8?B?dXg2RzZyMjJwLy84T2IrdzhIWEdoditxblpVR2pSSWU3ZkdBOEpvc2F1c1NO?=
 =?utf-8?B?RlpmUTl2T0xxbmpvUThLcmlFK0d0OE4vSCt6TDVCNlFhdVBHcVZROUpvemdK?=
 =?utf-8?B?aUl5aFEvQTd0WmhqZkl4YVRMNmNhQXJjVkN5bFd2aUFvSnF0Um5WOWIrV0pV?=
 =?utf-8?B?M01FMTZydTVpNTRScDlXWEpVc2NOb2dOUTlKb29hcm1mTU11WGVHRnhvMzBS?=
 =?utf-8?B?aUVrTTNHclAzbVJWSEYyMHhQRDJ2UHA4RHZLR0h4OFBNcVFXMXByVW9oSXls?=
 =?utf-8?B?NWlnUDhFOE9UZk0rZ1N3TWhOS2RyY2VocGppUzdoVWtDS01xUVAvMmZiR1lC?=
 =?utf-8?B?alBrWW1LVE81WmdGUHd6amc4dytpSElCMCtPVkRsZDJKRGVLSzFuT2xhYm5l?=
 =?utf-8?B?YzhRYjAyZ2c4Z1FCcHBFV05UQkVDa0FNRmlDUTNWRTJjeFdFSCtPeG5oUk5I?=
 =?utf-8?B?WUN3RWYvYmhBQ1ZVaks5ZllzV09ZOC81N3RYZkRreEV4cmI0dWdCY2ptdWVE?=
 =?utf-8?Q?RQ7EELJiqpdh9lRE=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8a08f1-c91c-4be4-ee51-08de63d98298
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:38:18.4326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVOTHOb4DbXcnwvHxv6eBo0MTeRZmZaAr14GU0KfoTzz3gQf4pWQLuv8qrQSIuOkeMMzV4xvc5i5DP6pmTuCq/wNaKSYtH9nbdMvX8F2rq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR02MB10850
X-Proofpoint-GUID: OeAIqGOocgnB1Nskyk_nVd_zndcKnKvQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4MCBTYWx0ZWRfX78yIsVxqdy9L
 N9zaXJ+t6iS5UFk4CmPkujg6YOH2f1e6ba38IRr8S8R08HIkOfEr4NG+40bXqvGmmVlG2Oqnsdp
 U/O3OQ/ofIchTVTTyF3HFAc7XxWlBsCLBZUQV0Hac7FNlrnryhUgcQ4Yubc2XpySHFAVBhA7n9W
 TwhlJ2ufkEBE8LI49eLcr+E4Sxg/K5mLvyOhANrVrHZuKaNIeZpv3NIHgV3y/znVrb8xTUP+uJG
 iYohJGmeW1ZcY7NQg1Ct+D899R4MphXCYWaLVPu545D+W5+ssoXb8FdGsL+LYCiCC3rHVarcFrD
 UG7giwi2YomJOmeAzj16HqfL6X29OJdCM2kzXGSEUg9zGm9cp7bivJ8i0x944Q52mxp03O5qpeT
 dZynUGECe7m+imLQm69ZGb2bYl+nLmHZRQTONj4CAkFWT1TeribOJNDE8lKpopb44xZQGrk4Xa4
 fLipgwXdv4EVFHdLBEw==
X-Authority-Analysis: v=2.4 cv=TI1Iilla c=1 sm=1 tr=0 ts=6983219c cx=c_pps
 a=YibUBhyYyO2Pp3CK5Oblqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=2r4znsDKvgVYavMTytcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OeAIqGOocgnB1Nskyk_nVd_zndcKnKvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
> Start a simple test program that will exercise the QEMU audio APIs.
> 
> It is meant to run manually for now, as it accesses the sound system and
> produces sound by default, and also runs for a few seconds. We may want
> to make it silent or use the "none" (noaudio) backend by default though,
> so it can run as part of the automated test suite.

I wonder if it makes sense to have some kind of qtest audio backend that 
can write the resulting data to a file for tests like this without 
generating audio?

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   meson.build               |  15 +-
>   tests/audio/audio-stubs.c |  46 +++
>   tests/audio/test-audio.c  | 583 ++++++++++++++++++++++++++++++++++++++
>   tests/audio/meson.build   |  18 ++
>   tests/meson.build         |   1 +
>   5 files changed, 658 insertions(+), 5 deletions(-)
>   create mode 100644 tests/audio/audio-stubs.c
>   create mode 100644 tests/audio/test-audio.c
>   create mode 100644 tests/audio/meson.build
> 
> diff --git a/meson.build b/meson.build
> index d9e2834f6e8..240a2a0473a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3869,6 +3869,7 @@ target_modules += { 'accel' : { 'qtest': qtest_module_ss }}
>   modinfo_collect = find_program('scripts/modinfo-collect.py')
>   modinfo_generate = find_program('scripts/modinfo-generate.py')
>   modinfo_files = []
> +audio_modinfo_files = []
>   
>   block_mods = []
>   system_mods = []
> @@ -3896,11 +3897,15 @@ foreach d, list : modules
>                       install: true,
>                       install_dir: qemu_moddir)
>         if module_ss.sources() != []
> -        modinfo_files += custom_target(d + '-' + m + '.modinfo',
> -                                       output: d + '-' + m + '.modinfo',
> -                                       input: sl.extract_all_objects(recursive: true),
> -                                       capture: true,
> -                                       command: [modinfo_collect, '@INPUT@'])
> +        modinfo = custom_target(d + '-' + m + '.modinfo',
> +                                output: d + '-' + m + '.modinfo',
> +                                input: sl.extract_all_objects(recursive: true),
> +                                capture: true,
> +                                command: [modinfo_collect, '@INPUT@'])
> +        modinfo_files += modinfo
> +        if d == 'audio'
> +          audio_modinfo_files += modinfo
> +        endif
>         endif
>       else
>         if d == 'block'
> diff --git a/tests/audio/audio-stubs.c b/tests/audio/audio-stubs.c
> new file mode 100644
> index 00000000000..0bcdb6ce7a3
> --- /dev/null
> +++ b/tests/audio/audio-stubs.c
> @@ -0,0 +1,46 @@
> +/*
> + * Stubs for audio test - provides missing functions for standalone audio test
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/dbus.h"
> +#include "ui/qemu-spice-module.h"
> +#include "ui/dbus-module.h"
> +#include "system/replay.h"
> +#include "system/runstate.h"
> +
> +int using_spice;
> +int using_dbus_display;
> +
> +struct QemuSpiceOps qemu_spice;
> +
> +GQuark dbus_display_error_quark(void)
> +{
> +    return g_quark_from_static_string("dbus-display-error-quark");
> +}
> +
> +void replay_audio_in(size_t *recorded, st_sample *samples,
> +                     size_t *wpos, size_t size)
> +{
> +}
> +
> +void replay_audio_out(size_t *played)
> +{
> +}
> +
> +static int dummy_vmse;
> +
> +VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
> +                                                     void *opaque)
> +{
> +    return (VMChangeStateEntry *)&dummy_vmse;
> +}
> +
> +void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
> +{
> +}
> +
> +bool runstate_is_running(void)
> +{
> +    return true;
> +}
> diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
> new file mode 100644
> index 00000000000..38e30f47f89
> --- /dev/null
> +++ b/tests/audio/test-audio.c
> @@ -0,0 +1,583 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/config-file.h"
> +#include "qemu/cutils.h"
> +#include "qemu/help_option.h"
> +#include "qemu/module.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/audio.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "trace/control.h"
> +#include "glib.h"
> +
> +#include "audio/audio_int.h"
> +
> +#include <math.h>
> +
> +#define SAMPLE_RATE     44100
> +#define CHANNELS        2
> +#define DURATION_SECS   2
> +#define FREQUENCY       440.0
> +#define BUFFER_FRAMES   1024
> +#define TIMEOUT_SECS    (DURATION_SECS + 1)
> +
> +/* Command-line options */
> +static gchar *opt_audiodev;
> +static gchar *opt_trace;
> +
> +static GOptionEntry test_options[] = {
> +    { "audiodev", 'a', 0, G_OPTION_ARG_STRING, &opt_audiodev,
> +      "Audio device spec (e.g., none or pa,out.buffer-length=50000)", "DEV" },
> +    { "trace", 'T', 0, G_OPTION_ARG_STRING, &opt_trace,
> +      "Trace options (e.g., 'pw_*')", "TRACE" },
> +    { NULL }
> +};
> +
> +#define TEST_AUDIODEV_ID "test"
> +
> +typedef struct TestSineState {
> +    AudioBackend *be;
> +    SWVoiceOut *voice;
> +    int64_t total_frames;
> +    int64_t frames_written;
> +} TestSineState;
> +
> +/* Default audio settings for tests */
> +static const struct audsettings default_test_settings = {
> +    .freq = SAMPLE_RATE,
> +    .nchannels = CHANNELS,
> +    .fmt = AUDIO_FORMAT_S16,
> +    .endianness = 0,
> +};
> +
> +static void dummy_audio_callback(void *opaque, int avail)
> +{
> +}
> +
> +static AudioBackend *get_test_audio_backend(void)
> +{
> +    AudioBackend *be;
> +    Error *err = NULL;
> +
> +    if (opt_audiodev) {
> +        be = audio_be_by_name(TEST_AUDIODEV_ID, &err);
> +    } else {
> +        be = audio_get_default_audio_be(&err);
> +    }
> +
> +    if (err) {
> +        g_error("%s", error_get_pretty(err));
> +        error_free(err);
> +        exit(1);
> +    }
> +    g_assert_nonnull(be);
> +    return be;
> +}
> +
> +/*
> + * Helper functions for opening test voices with default settings.
> + * These reduce boilerplate in test functions.
> + */
> +static SWVoiceOut *open_test_voice_out(AudioBackend *be, const char *name,
> +                                       void *opaque, audio_callback_fn cb)
> +{
> +    struct audsettings as = default_test_settings;
> +    SWVoiceOut *voice;
> +
> +    voice = AUD_open_out(be, NULL, name, opaque, cb, &as);
> +    g_assert_nonnull(voice);
> +    return voice;
> +}
> +
> +static SWVoiceIn *open_test_voice_in(AudioBackend *be, const char *name,
> +                                     void *opaque, audio_callback_fn cb)
> +{
> +    struct audsettings as = default_test_settings;
> +    SWVoiceIn *voice;
> +
> +    voice = AUD_open_in(be, NULL, name, opaque, cb, &as);
> +    g_assert_nonnull(voice);
> +    return voice;
> +}
> +
> +/*
> + * Generate 440Hz sine wave samples into buffer.
> + */
> +static void generate_sine_samples(int16_t *buffer, int frames,
> +                                  int64_t start_frame)
> +{
> +    for (int i = 0; i < frames; i++) {
> +        double t = (double)(start_frame + i) / SAMPLE_RATE;
> +        double sample = sin(2.0 * M_PI * FREQUENCY * t);
> +        int16_t s = (int16_t)(sample * 32767.0);
> +
> +        buffer[i * 2] = s;       /* left channel */
> +        buffer[i * 2 + 1] = s;   /* right channel */
> +    }
> +}
> +
> +static void test_sine_callback(void *opaque, int avail)
> +{
> +    TestSineState *s = opaque;
> +    int16_t buffer[BUFFER_FRAMES * CHANNELS];
> +    int frames_remaining;
> +    int frames_to_write;
> +    size_t bytes_written;
> +
> +    frames_remaining = s->total_frames - s->frames_written;
> +    if (frames_remaining <= 0) {
> +        return;
> +    }
> +
> +    frames_to_write = avail / (sizeof(int16_t) * CHANNELS);
> +    frames_to_write = MIN(frames_to_write, BUFFER_FRAMES);
> +    frames_to_write = MIN(frames_to_write, frames_remaining);
> +
> +    generate_sine_samples(buffer, frames_to_write, s->frames_written);
> +
> +    bytes_written = AUD_write(s->voice, buffer,
> +                              frames_to_write * sizeof(int16_t) * CHANNELS);
> +    s->frames_written += bytes_written / (sizeof(int16_t) * CHANNELS);
> +}
> +
> +
> +static void test_audio_out_sine_wave(void)
> +{
> +    TestSineState state = {0};
> +    int64_t start_time;
> +    int64_t elapsed_ms;
> +
> +    state.be = get_test_audio_backend();
> +    state.total_frames = SAMPLE_RATE * DURATION_SECS;
> +    state.frames_written = 0;
> +
> +    g_test_message("Opening audio output...");
> +    state.voice = open_test_voice_out(state.be, "test-sine",
> +                                      &state, test_sine_callback);
> +
> +    g_test_message("Playing 440Hz sine wave for %d seconds...", DURATION_SECS);
> +    AUD_set_active_out(state.voice, true);
> +
> +    /*
> +     * Run the audio subsystem until all frames are written or timeout.
> +     */
> +    start_time = g_get_monotonic_time();
> +    while (state.frames_written < state.total_frames) {
> +        audio_run(state.be, "test");
> +        main_loop_wait(true);
> +
> +        elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
> +        if (elapsed_ms > TIMEOUT_SECS * 1000) {
> +            g_test_message("Timeout waiting for audio to complete");
> +            break;
> +        }
> +
> +        g_usleep(G_USEC_PER_SEC / 100);  /* 10ms */
> +    }
> +
> +    g_test_message("Wrote %" PRId64 " frames (%.2f seconds)",
> +                   state.frames_written,
> +                   (double)state.frames_written / SAMPLE_RATE);
> +
> +    g_assert_cmpint(state.frames_written, ==, state.total_frames);
> +
> +    AUD_set_active_out(state.voice, false);
> +    AUD_close_out(state.be, state.voice);
> +}
> +
> +static void test_audio_prio_list(void)
> +{
> +    g_autofree gchar *backends = NULL;
> +    GString *str = g_string_new(NULL);
> +    bool has_none = false;
> +
> +    for (int i = 0; audio_prio_list[i]; i++) {
> +        if (i > 0) {
> +            g_string_append_c(str, ' ');
> +        }
> +        g_string_append(str, audio_prio_list[i]);
> +
> +        if (g_strcmp0(audio_prio_list[i], "none") == 0) {
> +            has_none = true;
> +        }
> +    }
> +
> +    backends = g_string_free(str, FALSE);
> +    g_test_message("Available backends: %s", backends);
> +
> +    /* The 'none' backend should always be available */
> +    g_assert_true(has_none);
> +}
> +
> +static void test_audio_out_active_state(void)
> +{
> +    AudioBackend *be;
> +    SWVoiceOut *voice;
> +
> +    be = get_test_audio_backend();
> +    voice = open_test_voice_out(be, "test-active", NULL, dummy_audio_callback);
> +
> +    g_assert_false(AUD_is_active_out(voice));
> +
> +    AUD_set_active_out(voice, true);
> +    g_assert_true(AUD_is_active_out(voice));
> +
> +    AUD_set_active_out(voice, false);
> +    g_assert_false(AUD_is_active_out(voice));
> +
> +    AUD_close_out(be, voice);
> +}
> +
> +static void test_audio_out_buffer_size(void)
> +{
> +    AudioBackend *be;
> +    SWVoiceOut *voice;
> +    int buffer_size;
> +
> +    be = get_test_audio_backend();
> +    voice = open_test_voice_out(be, "test-buffer", NULL, dummy_audio_callback);
> +
> +    buffer_size = AUD_get_buffer_size_out(voice);
> +    g_test_message("Buffer size: %d bytes", buffer_size);
> +    g_assert_cmpint(buffer_size, >, 0);
> +
> +    AUD_close_out(be, voice);
> +
> +    g_assert_cmpint(AUD_get_buffer_size_out(NULL), ==, 0);
> +}
> +
> +static void test_audio_out_volume(void)
> +{
> +    AudioBackend *be;
> +    SWVoiceOut *voice;
> +    Volume vol;
> +
> +    be = get_test_audio_backend();
> +    voice = open_test_voice_out(be, "test-volume", NULL, dummy_audio_callback);
> +
> +    vol = (Volume){.mute = false, .channels = 2, .vol = {255, 255}};
> +    AUD_set_volume_out(voice, &vol);
> +
> +    vol = (Volume){.mute = true, .channels = 2, .vol = {255, 255}};
> +    AUD_set_volume_out(voice, &vol);
> +
> +    vol = (Volume){.mute = false, .channels = 2, .vol = {128, 128}};
> +    AUD_set_volume_out(voice, &vol);
> +
> +    AUD_close_out(be, voice);
> +}
> +
> +static void test_audio_in_active_state(void)
> +{
> +    AudioBackend *be;
> +    SWVoiceIn *voice;
> +
> +    be = get_test_audio_backend();
> +    voice = open_test_voice_in(be, "test-in-active", NULL, dummy_audio_callback);
> +
> +    g_assert_false(AUD_is_active_in(voice));
> +
> +    AUD_set_active_in(voice, true);
> +    g_assert_true(AUD_is_active_in(voice));
> +
> +    AUD_set_active_in(voice, false);
> +    g_assert_false(AUD_is_active_in(voice));
> +
> +    AUD_close_in(be, voice);
> +}
> +
> +static void test_audio_in_volume(void)
> +{
> +    AudioBackend *be;
> +    SWVoiceIn *voice;
> +    Volume vol;
> +
> +    be = get_test_audio_backend();
> +    voice = open_test_voice_in(be, "test-in-volume", NULL, dummy_audio_callback);
> +
> +    vol = (Volume){.mute = false, .channels = 2, .vol = {255, 255}};
> +    AUD_set_volume_in(voice, &vol);
> +
> +    vol = (Volume){.mute = true, .channels = 2, .vol = {255, 255}};
> +    AUD_set_volume_in(voice, &vol);
> +
> +    AUD_close_in(be, voice);
> +}
> +
> +
> +/* Capture test state */
> +#define CAPTURE_BUFFER_FRAMES (SAMPLE_RATE / 10)  /* 100ms of audio */
> +#define CAPTURE_BUFFER_SIZE   (CAPTURE_BUFFER_FRAMES * CHANNELS * sizeof(int16_t))
> +
> +typedef struct TestCaptureState {
> +    bool notify_called;
> +    bool capture_called;
> +    bool destroy_called;
> +    audcnotification_e last_notify;
> +    int16_t *captured_samples;
> +    size_t captured_bytes;
> +    size_t capture_buffer_size;
> +} TestCaptureState;
> +
> +static void test_capture_notify(void *opaque, audcnotification_e cmd)
> +{
> +    TestCaptureState *s = opaque;
> +    s->notify_called = true;
> +    s->last_notify = cmd;
> +}
> +
> +static void test_capture_capture(void *opaque, const void *buf, int size)
> +{
> +    TestCaptureState *s = opaque;
> +    size_t bytes_to_copy;
> +
> +    s->capture_called = true;
> +
> +    if (!s->captured_samples || s->captured_bytes >= s->capture_buffer_size) {
> +        return;
> +    }
> +
> +    bytes_to_copy = MIN(size, s->capture_buffer_size - s->captured_bytes);
> +    memcpy((uint8_t *)s->captured_samples + s->captured_bytes, buf, bytes_to_copy);
> +    s->captured_bytes += bytes_to_copy;
> +}
> +
> +static void test_capture_destroy(void *opaque)
> +{
> +    TestCaptureState *s = opaque;
> +    s->destroy_called = true;
> +}
> +
> +/*
> + * Compare captured audio with expected sine wave.
> + * Returns the number of matching samples (within tolerance).
> + */
> +static int compare_sine_samples(const int16_t *captured, int frames,
> +                                int64_t start_frame, int tolerance)
> +{
> +    int matching = 0;
> +
> +    for (int i = 0; i < frames; i++) {
> +        double t = (double)(start_frame + i) / SAMPLE_RATE;
> +        double sample = sin(2.0 * M_PI * FREQUENCY * t);
> +        int16_t expected = (int16_t)(sample * 32767.0);
> +
> +        /* Check left channel */
> +        if (abs(captured[i * 2] - expected) <= tolerance) {
> +            matching++;
> +        }
> +        /* Check right channel */
> +        if (abs(captured[i * 2 + 1] - expected) <= tolerance) {
> +            matching++;
> +        }
> +    }
> +
> +    return matching;
> +}
> +
> +static void test_audio_capture(void)
> +{
> +    AudioBackend *be;
> +    CaptureVoiceOut *cap;
> +    SWVoiceOut *voice;
> +    TestCaptureState state = {0};
> +    TestSineState sine_state = {0};
> +    struct audsettings as = default_test_settings;
> +    struct audio_capture_ops ops = {
> +        .notify = test_capture_notify,
> +        .capture = test_capture_capture,
> +        .destroy = test_capture_destroy,
> +    };
> +    int64_t start_time;
> +    int64_t elapsed_ms;
> +    int captured_frames;
> +    int matching_samples;
> +    int total_samples;
> +    double match_ratio;
> +
> +    be = get_test_audio_backend();
> +
> +    state.captured_samples = g_malloc0(CAPTURE_BUFFER_SIZE);
> +    state.captured_bytes = 0;
> +    state.capture_buffer_size = CAPTURE_BUFFER_SIZE;
> +
> +    cap = AUD_add_capture(be, &as, &ops, &state);
> +    g_assert_nonnull(cap);
> +
> +    sine_state.be = be;
> +    sine_state.total_frames = CAPTURE_BUFFER_FRAMES;
> +    sine_state.frames_written = 0;
> +
> +    voice = open_test_voice_out(be, "test-capture-sine",
> +                                &sine_state, test_sine_callback);
> +    sine_state.voice = voice;
> +
> +    AUD_set_active_out(voice, true);
> +
> +    start_time = g_get_monotonic_time();
> +    while (sine_state.frames_written < sine_state.total_frames ||
> +           state.captured_bytes < CAPTURE_BUFFER_SIZE) {
> +        audio_run(be, "test-capture");
> +        main_loop_wait(true);
> +
> +        elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
> +        if (elapsed_ms > 1000) {  /* 1 second timeout */
> +            break;
> +        }
> +
> +        g_usleep(G_USEC_PER_SEC / 1000);  /* 1ms */
> +    }
> +
> +    g_test_message("Wrote %" PRId64 " frames, captured %zu bytes",
> +                   sine_state.frames_written, state.captured_bytes);
> +
> +    g_assert_true(state.capture_called);
> +    g_assert_cmpuint(state.captured_bytes, >, 0);
> +
> +    /* Compare captured data with expected sine wave */
> +    captured_frames = state.captured_bytes / (CHANNELS * sizeof(int16_t));
> +    if (captured_frames > 0) {
> +        /*
> +         * Allow some tolerance due to mixing/conversion.
> +         * The tolerance accounts for potential rounding differences.
> +         */
> +        matching_samples = compare_sine_samples(state.captured_samples,
> +                                                captured_frames, 0, 100);
> +        total_samples = captured_frames * CHANNELS;
> +        match_ratio = (double)matching_samples / total_samples;
> +
> +        g_test_message("Captured %d frames, %d/%d samples match (%.1f%%)",
> +                       captured_frames, matching_samples, total_samples,
> +                       match_ratio * 100.0);
> +
> +        /*
> +         * Expect at least 90% of samples to match within tolerance.
> +         * Some variation is expected due to mixing engine processing.
> +         */
> +        g_assert_cmpfloat(match_ratio, >=, 0.9);
> +    }
> +
> +    AUD_set_active_out(voice, false);
> +    AUD_close_out(be, voice);
> +
> +    AUD_del_capture(cap, &state);
> +    g_assert_true(state.destroy_called);
> +
> +    g_free(state.captured_samples);
> +}
> +
> +static void test_audio_null_handling(void)
> +{
> +    uint8_t buffer[64];
> +
> +    /* AUD_is_active_out/in(NULL) should return false */
> +    g_assert_false(AUD_is_active_out(NULL));
> +    g_assert_false(AUD_is_active_in(NULL));
> +
> +    /* AUD_get_buffer_size_out(NULL) should return 0 */
> +    g_assert_cmpint(AUD_get_buffer_size_out(NULL), ==, 0);
> +
> +    /* AUD_write/read(NULL, ...) should return size (no-op) */
> +    g_assert_cmpuint(AUD_write(NULL, buffer, sizeof(buffer)), ==,
> +                     sizeof(buffer));
> +    g_assert_cmpuint(AUD_read(NULL, buffer, sizeof(buffer)), ==,
> +                     sizeof(buffer));
> +
> +    /* These should not crash */
> +    AUD_set_active_out(NULL, true);
> +    AUD_set_active_out(NULL, false);
> +    AUD_set_active_in(NULL, true);
> +    AUD_set_active_in(NULL, false);
> +}
> +
> +static void test_audio_multiple_voices(void)
> +{
> +    AudioBackend *be;
> +    SWVoiceOut *out1, *out2;
> +    SWVoiceIn *in1;
> +
> +    be = get_test_audio_backend();
> +    out1 = open_test_voice_out(be, "test-multi-out1", NULL, dummy_audio_callback);
> +    out2 = open_test_voice_out(be, "test-multi-out2", NULL, dummy_audio_callback);
> +    in1 = open_test_voice_in(be, "test-multi-in1", NULL, dummy_audio_callback);
> +
> +    AUD_set_active_out(out1, true);
> +    AUD_set_active_out(out2, true);
> +    AUD_set_active_in(in1, true);
> +
> +    g_assert_true(AUD_is_active_out(out1));
> +    g_assert_true(AUD_is_active_out(out2));
> +    g_assert_true(AUD_is_active_in(in1));
> +
> +    AUD_set_active_out(out1, false);
> +    AUD_set_active_out(out2, false);
> +    AUD_set_active_in(in1, false);
> +
> +    AUD_close_in(be, in1);
> +    AUD_close_out(be, out2);
> +    AUD_close_out(be, out1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    GOptionContext *context;
> +    g_autoptr(GError) error = NULL;
> +    g_autofree gchar *dir = NULL;
> +    int ret;
> +
> +    context = g_option_context_new("- QEMU audio test");
> +    g_option_context_add_main_entries(context, test_options, NULL);
> +
> +    if (!g_option_context_parse(context, &argc, &argv, &error)) {
> +        g_printerr("Option parsing failed: %s\n", error->message);
> +        return 1;
> +    }
> +    g_option_context_free(context);
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    module_call_init(MODULE_INIT_TRACE);
> +    qemu_add_opts(&qemu_trace_opts);
> +    if (opt_trace) {
> +        trace_opt_parse(opt_trace);
> +    }
> +    trace_init_file();
> +    qemu_set_log(LOG_TRACE, &error_fatal);
> +
> +    dir = g_test_build_filename(G_TEST_BUILT, "..", "..", NULL);
> +    g_setenv("QEMU_MODULE_DIR", dir, true);
> +    qemu_init_exec_dir(argv[0]);
> +    module_call_init(MODULE_INIT_QOM);
> +    module_init_info(qemu_modinfo);
> +
> +    qemu_init_main_loop(&error_abort);
> +    if (opt_audiodev) {
> +        g_autofree gchar *spec = is_help_option(opt_audiodev) ?
> +            opt_audiodev : g_strdup_printf("%s,id=%s", opt_audiodev, TEST_AUDIODEV_ID);
> +        audio_parse_option(spec);
> +    }
> +    audio_create_default_audiodevs();
> +    audio_init_audiodevs();
> +
> +    g_test_add_func("/audio/prio-list", test_audio_prio_list);
> +
> +    g_test_add_func("/audio/out/active-state", test_audio_out_active_state);
> +    g_test_add_func("/audio/out/sine-wave", test_audio_out_sine_wave);
> +    g_test_add_func("/audio/out/buffer-size", test_audio_out_buffer_size);
> +    g_test_add_func("/audio/out/volume", test_audio_out_volume);
> +    g_test_add_func("/audio/out/capture", test_audio_capture);
> +
> +    g_test_add_func("/audio/in/active-state", test_audio_in_active_state);
> +    g_test_add_func("/audio/in/volume", test_audio_in_volume);
> +
> +    g_test_add_func("/audio/null-handling", test_audio_null_handling);
> +    g_test_add_func("/audio/multiple-voices", test_audio_multiple_voices);
> +
> +    ret = g_test_run();
> +
> +    audio_cleanup();
> +
> +    return ret;
> +}
> diff --git a/tests/audio/meson.build b/tests/audio/meson.build
> new file mode 100644
> index 00000000000..611b5749a5b
> --- /dev/null
> +++ b/tests/audio/meson.build
> @@ -0,0 +1,18 @@
> +modinfo_dep = not_found
> +if enable_modules
> +    modinfo_src = custom_target('modinfo.c',
> +                                output: 'modinfo.c',
> +                                input: audio_modinfo_files,
> +                                command: [modinfo_generate, '--skip-missing-deps', '@INPUT@'],
> +                                capture: true)
> +
> +    modinfo_lib = static_library('modinfo.c', modinfo_src)
> +    modinfo_dep = declare_dependency(link_with: modinfo_lib)
> +endif
> +
> +# manual audio test - not part of automated test suite
> +# as it relies on audio system
> +executable('test-audio',
> +    sources: files('test-audio.c', 'audio-stubs.c'),
> +    dependencies: [audio, qemuutil, spice, modinfo_dep],

Does this test really need spice to function?

> +    build_by_default: false)

It took me a few seconds to see why the test-audio executable wasn't 
being produced, even if it has to be run manually. Is there any reason 
it shouldn't be built by default?

> diff --git a/tests/meson.build b/tests/meson.build
> index cbe79162411..cb766e49ca4 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -83,6 +83,7 @@ if 'CONFIG_TCG' in config_all_accel
>     subdir('tcg/plugins')
>   endif
>   
> +subdir('audio')
>   subdir('unit')
>   subdir('qapi-schema')
>   subdir('qtest')


ATB,

Mark.


