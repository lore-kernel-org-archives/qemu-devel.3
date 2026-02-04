Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF7AE9537B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbQl-0005on-9F; Wed, 04 Feb 2026 06:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbQj-0005oS-D3
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:52:21 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbQh-0006h7-TR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:52:21 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145o6dO2992496; Wed, 4 Feb 2026 03:52:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2CLFzqmwD9tp821Jne9PnUOM0+AvaxRwHjvmRb+iM
 Dw=; b=RWA8RmdzJIxgyXT0O4L7WKOZiYsEN5MmlNos5iUn1AKnBMDi7SFMQLu1E
 GX7MGcLQVS7pX28Y18VFBmEF1R9ji3ig1+F0Bo0APxwqm8nzrbLJu0AHLhuFqNkq
 LaRdca7cW5RYawrOMCiuLEctwhXKTXwL573We/tzxFFE0PCjqTRAkVZOqEfWeUjc
 E+YrElZ8FTQuIPlWJOTU3pjtvgFIs1UqAu6Tqc6L0xh/kmGFgB1ndmYvfhhB7yFz
 WIr7RSP4x3yAJLdoQ9syw9rPat2ObSgXbNTMnpHv8S7Afcj2PGqtgT7IstRiYblh
 7vYZVsHjrYdwHIF8D603alFCrAL5g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021129.outbound.protection.outlook.com
 [40.93.194.129])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3ntja6vu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:52:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhakLh1cjJggLeP+H+Jy5qcMBAWm5gG+qpsBLRc08VYBfwWTk3iLXDLROMKRV5ARZS8lwYBLtoM62VWLNTWSeY19b6bA1L2D7MQCDC2LKNqX5AdEXIdEyv335WE2r0NIVPy3D5OwJ9GYIph6OVo01JIHisBDrjfds0mMTbxFf8UAqY5HkMNJ8a54oR83HPDw/rfLa5zn8AGGRPZ3xpAvvmi4Rojx8gQClMIc9p24lPmGVnorZk9eb34+Nwg4XJYhnA5uWT60v24Y5gRbBOlvNR/LOWy0p6zoD3B/1HX+LwKMRoUQjGvQS/04O70sHaFr656uv86y863GvhLNaZllCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CLFzqmwD9tp821Jne9PnUOM0+AvaxRwHjvmRb+iMDw=;
 b=WIO5VsaDtmddN3JvRz7/WQ+w4o/pG9CO+kulHJnf+om/ctIYIlqqJVegX+3xtwOjnaWW8s+GVvnUJEbe3kBquLvutFLnQhTvFL4zLsbr+zTVRn806uxUzHXT6E30aniRCyW43Yg/lZmCmGv2kbZ6GYOGuEWcXS9mZGLloTTdCzp600qgep+oY8dYYIDVjq8wID8GhvDP6GxKNnCO/QQhZVO8uUuRAgk9pYhLtsj59cYjdeS3sDXWdRR/4bPMAjvfA0GOKYFc/lolDpSQFpPGOPu+FElWT1t3XTY0QF58pTW/7NwqrjSbS2r+CduPMF3OtAUfhQKYJIpaA62Wj7Zzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CLFzqmwD9tp821Jne9PnUOM0+AvaxRwHjvmRb+iMDw=;
 b=u5WOkL7ter79NmoRN/liJXOSXlD18ACWebKO1SuCs+v28+V2+Rfr/3OHssjFZMtNuO1qsYGPMqJ7EgH5EpSAx8K1/3EWY6t0vXZ2HxWGqCG4wDE1kcFtFA4BBt4gCnQdxosFlSQ1gMQd6GfH6tJ2CqJGEahZy8EqKLQYINMGjslURZY32P1cMtP4Xeb2zBV7LXhbKK2dVkoZ5jMp0/uayxRwA3v1+toneXCjGV+55uckFy5WRf83EIBgqUO1VzBLL/SrCc7HIXMBALKoYNIG+Bxv6h7tzeH86ltTHBwzpQ1MtnS8zSC5hX771dXCN2Nr3ofXEvikRWL9T3GFixu86Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8096.namprd02.prod.outlook.com (2603:10b6:408:167::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 11:52:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:52:16 +0000
Message-ID: <e4a90543-ba37-4897-bcaa-6331809b30c7@nutanix.com>
Date: Wed, 4 Feb 2026 11:52:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/37] audio: make audio_driver init() & fini() optional
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-38-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-38-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:805:66::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: bae3268e-caae-4601-93c4-08de63e3d7f9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjBZNjlocG9IUEJIZG5aZkZ3b2pCNzJSYklNUUd2Sm9EVVdWb0xTYThOaEFu?=
 =?utf-8?B?eFI5dHlHYVBJRkUrMWxVRUZWempqUmZnVzhMWlpld2pqbVpvdWR0K0VNTVlW?=
 =?utf-8?B?MjV4WnBmY0hNdUhVQW5EUkExWElnK2Z1MklLM3B5cWlnLzBUb0hiQjh0RTMz?=
 =?utf-8?B?YURxOFh1WFN1d3V4cVFnMlNXWlRnSXF1V2ZWUWMzaVd4UXd4THB1UjcwamhZ?=
 =?utf-8?B?eW9tNm05dXAvWWhBcFltc05zL245eWZ5dlc5ZHd6RkpQaHB1ZWVBejR2TjNn?=
 =?utf-8?B?bWw4U0xqM0lxQWtlaVpFc2VJZ3J6QjNGcFgyb0F0bDkrOGhKcGZYQ3hHbU9C?=
 =?utf-8?B?WHlvdTZTcnlid0Q3Y0hvanZweDI0SDhGZUF4WVRQdHlGeGhsaWs4blZxZFdn?=
 =?utf-8?B?MVQ1dFR0Zy9QV1pyTHVzUHBESFQ3V3ZJQ3lycXVoLzl2QjhoMjFkS3hpbmVH?=
 =?utf-8?B?RlcwbzB3amxSanZ0VEdLRC9mMEpoQkk3bUVUakVNRU9XOE9uOUdwRUZENmJ4?=
 =?utf-8?B?aHJZcGhnZ0FZN2lSajg4dEkzQVNHTkZHSUIyMjI5NHlXUDJvTklMbk0xV3c4?=
 =?utf-8?B?SmJmZWF3M0tGb0lsMk5qZ3hjdG1MVUc4MnJTeTVQMlN3NmhLcHp4RVIwYlhs?=
 =?utf-8?B?OWVrcm9SdzVXR0w1dHExTDVOampQSFdzSDU4K2lKOTFyYngvcjdNZmpRKzJV?=
 =?utf-8?B?R0Q0Yk13K2pSY29aWEd2OXdqNENOVjVnYnVUUE5ZTjFCeUNUT3NTWDN2NjJF?=
 =?utf-8?B?QkJqRW5SS3dFUUJOZ25RU3E1dXcrWjBSQjdVemN1bGlZMHRVQ2Z6VXE5YWho?=
 =?utf-8?B?ckdKZzZEOUVOcjhWdW5MUXJxSnF2NDc3VWhZRXU5UWsvWmcxNzBXWVVzaVEw?=
 =?utf-8?B?TCtNandEb0VDWXJqdEpFbnZpVmFWUFI0dWIvWVJQRm9TVGVHQmFBYmltWmxr?=
 =?utf-8?B?UlRJOERaenpnS1Q2eHV5Y1orYWZMVmlzZk1vcjVYOWYwVUUwdm81YmxOS25P?=
 =?utf-8?B?cWk4R2xsb3pjdDNKWmI2MDYzaXNaSFhicm1udUNVSWlWdStHaHBLRE84Kysy?=
 =?utf-8?B?TVZyYkw5T1RWNnJsdElreHJ1cTdnd1VWMmIvS2N6Qk1qT3RlSGRuZGVWcjRi?=
 =?utf-8?B?VTRFMG1kSWlRdGdBNFo4Y05wYlhXRVJQRTdudGkyM0R2dVhkWjNYZnduRFlZ?=
 =?utf-8?B?SGw0eDlIWnozOGF4TWJWeUlCcC9TNkJJYmdBbFAyMTdWMzF6MStKSWVkM2Vw?=
 =?utf-8?B?MFp1a1NISC9RU1hjUXlMTk8rSnoyZk9ocmx4RDJ4V1QwVTNDQjB3M2lGSlVx?=
 =?utf-8?B?em0yMVp3cFVnaVpJMUlPZm9ndlhxeGhXdzlWY1p0U1pkanpaaGExWjg2dGFL?=
 =?utf-8?B?T0ptRTFjejg1TVVKRWdoaEcvQTV1Wmw5VndPS1k3ZXdHNXdESzJiTXd1akJN?=
 =?utf-8?B?U3c4SFpKVzQ3M0U2dHNZbmhubTg3RUt4WUtBbzR4VTdLOFZpWTdZTzVEL0lH?=
 =?utf-8?B?eGNGUWNkcmtTanJhK2g1YmxXWm5IY0RzYkE3ZkY4QkJNRnVFby9jV2dKWGtn?=
 =?utf-8?B?cWJiSUg1M0tLeWc2cUcxaGRoeDlnb2MzMjFDdXVWQWpzdnlEb2ZRWjZ1SEVo?=
 =?utf-8?B?anovdkNlM3Z3Szh4Y2FWNkVkSlBJRU5VdDVZK04xd0M1NXUySzFJZHROcUw1?=
 =?utf-8?B?S2tXSi8yNzMrdUd0eXU3LzlPTW1lYXlKb0xsMCtJK3M0OVZ6ckZvZ3hCUnhm?=
 =?utf-8?B?Z2dSSzF1dmtScUp6NTg1WC9IY2RHeFA0b1B6Q3AzZHFKMDdnN1B5RnhacnNX?=
 =?utf-8?B?QW5COThoaFIxQmJrV1lKdWkvYnc2d2dTaWVDcVMyZnBINHl3dk1TemFtMWtv?=
 =?utf-8?B?bnhDVjhKejM3b0pxRVBYNXNrQmk0WWZ4di9lUFROYUVxSzVDZis1cGpaWk5K?=
 =?utf-8?B?NjY2ZGgvcXExbmJyelNRYnhhSFhwSkxjZDVMOUFzRFQrWU1iTllxQ2R1bURY?=
 =?utf-8?B?SGdxTkVzRk81VVA0UTN5L2ZzbGZBRlk2UXVaMVB5OFRGNzZ2T0JFNmxVVGVW?=
 =?utf-8?B?T014UGR0OXdlL3VPbmlYTEpGTDhZb0w0Tmk1QkJQamR0MFB4WkJmcUxsendD?=
 =?utf-8?Q?tw7M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1pya3lnZ2dFTXdxd3dqUU40OHkwMUp4TlVnREs0Snd4WVIxSG9GS0JBTHRX?=
 =?utf-8?B?WUxNUldHQ2JYYlFoeEVNeCtWM0NMaWNwakZhTUpFUER3MGNvcy96b01oeS9i?=
 =?utf-8?B?TUFjRDdkSER4TFl2QzRRd3RKVGEzTW5ESjlHZlhxUkNHOTNWeXM3eDBheDM4?=
 =?utf-8?B?VkdnM3d1RGVKdTJ6RDllZ3QvSXdxYjhiQzlBWkx4ekd6TkhKenFLaGYzR3ky?=
 =?utf-8?B?UUxvNnliVXBjT3YxdWljU09TMWo0SUlDNnpDZ0NGRXMybkM0ZlRBaFVkTmpS?=
 =?utf-8?B?V3cvUGhBMnM3SDJwaXFnU0ppdmZqai9helhsbTRHbjZrSWlhNEFudE5LQXV0?=
 =?utf-8?B?dDdRM3c4dVBUdld1RDNHemt2UGtnTVlPdzczTE9zRVp5L251VGVIWEJLOFhy?=
 =?utf-8?B?bi8vQzh5MER4R08xNXpQbFpvbUVyZUhvaHF6T2hicGFrT3hZanVpZ2NLcmVF?=
 =?utf-8?B?bUoxTStabFkvTmxpUU1sNUJiWlNXZWt6dG5CNnJUbWVISS9MV2YzS0NLZnhO?=
 =?utf-8?B?TXh6YjU3S3ZhRWpIVXRGeE55VC9QeUFqL0xBbHlrL2V0WEdBWWhqV3hDTnpQ?=
 =?utf-8?B?WWNJVnZuSU1HYjhLN3BYSGdIbURxSlhZVDUxU3hiTVNUMVZ5K0xobUhSZTBq?=
 =?utf-8?B?dnI1RER2cDhSK2RmZ0pIK3E5MEdQQmQwbmxoVktHQ05jZDlrbEpmbENEWkdM?=
 =?utf-8?B?UnhuVExENDlpZWhlQWRyYmxqckdDQ1ZwL3BWWXRBVUJ2MGJITzVkQUhKZUZ2?=
 =?utf-8?B?UUkzNlRqViszMWpPTFIyYkQrcGJHWGM0em93TXBKT1lkSWk5V1RQc0lraldh?=
 =?utf-8?B?OFB6NCtkVXpNcVFGNUFvbmlDemsxdUlLdTVmTnNSNFVhUTlvQzVQOFErMVMv?=
 =?utf-8?B?cnNvR3NlQjJHYnJBaVQrWkF4bTRsZHlYK0hZUjFYR0J2UmRvREJ5R1ZpdUll?=
 =?utf-8?B?eXNwRVJXazVpMUpURjdtb1g5WjRtVGFvRXBlVVF4akc0bHBxYU9nNGw4a1Rm?=
 =?utf-8?B?ZmU4eTFLdytlYXJ0RWJQaWVZTXFNK01NM3c4MkpoMHI1NUR1MU9ocjVBSXRB?=
 =?utf-8?B?ekh4OWVuYzcvdnlZY3o5OVNJS1hGcS96T1BIZVdBNXRJN3M0QVJwclBIUC9a?=
 =?utf-8?B?bDhHajRqdmpic3M4MTc3YXc4dFFncDNyZXRyUy8zWG4rMXFxMndHRTNFUHpu?=
 =?utf-8?B?b2pwMnJ5Q3ROVGsrYkYwbFk1Ylorbjg4ekVCS0VsWnJQa2ZyVXB6Q1RDeWlG?=
 =?utf-8?B?SWNzOFZhLzZReEZRbkRrdGxpanBOeldDdTRrbUJXY2ZBdFpMR05uUHVSMDNi?=
 =?utf-8?B?RmdsZnA2eGxudnhuZmtPM0dQTHI4SzRvZXN0UjhYU0lTQm9VQmRvL01KWnJt?=
 =?utf-8?B?angxT2Vjd0ZqK3B4RFdoaTBiRER6UXh1MUlTTDZMZFB1eTFaY2FzSTFVT21v?=
 =?utf-8?B?Ym1SeWJYQ3NJbXYzWEdEZGtlUmhFTytja2tUbWtVVFIvamFmYm1DZ3pwR3oy?=
 =?utf-8?B?dTlONWY1VEd3dDdIQ0FsRWFqeC8yM1g5R3ZNRmFiUlNwdmZ6YXN1K2dCR1V6?=
 =?utf-8?B?cHdOYXIxdkozN213dWpWOGZwS2taOFd4V3RGdWtGMjJUeGRXWGI0NmRwYlVw?=
 =?utf-8?B?emtCb3AwSGdGU1hEYlI4Mm42VEV0MUtqMGd4TzQyalFDdks1dXNCVW5Ya1Rs?=
 =?utf-8?B?bGo4Rzl4Q0xqQWJlVjN4RzdoL2pIS0hDWU1LekJSSGZZRE85S3pwSlBBUUJ4?=
 =?utf-8?B?YnRKS3ZXRjZ0SzVJUFhNT1FlTjYvRHpFS3hVOEN5WHN4cXhFK2JjcUNQbWYv?=
 =?utf-8?B?R1Bpb1VZLzgvY09pU3hwd2p4bVIvVkZVYmNkRmQ2SHdkaFN1MCttQVVxMVR1?=
 =?utf-8?B?REpkcW9XSitZUVE5S0JxanlSUWQ2YmtvMVg1RnJ2UEMrbm00U293WkY3V3N0?=
 =?utf-8?B?RTRTNXhDbFpNV0tWak01WlJ4bDBxNUlkVVN4UmhzaTdzaVpaQ0JibnQ5Z2M0?=
 =?utf-8?B?azFqM2FoYUs3Q1d4K0daWXJNV2lrSlk3blFMN0pxNTdSYmF6SnNhdmNuLzZT?=
 =?utf-8?B?UUd1STJxS1pkTzkveTl3SkN0M094MUFHT05Rem1JNEFHWGdnaEZqeC9zYW4z?=
 =?utf-8?B?bDJaVU15MExsZklmUlpkS1ZFck9pTHN4d0JobFRhYkVYVTB2ai83b3JORG9t?=
 =?utf-8?B?S1RwcHFlR2tvNm9lUUE2UkJWMVJCR1NiTVhGZVQydExOZ3BXejBsdjBVTXNV?=
 =?utf-8?B?ZDhJaEhDQzQxa3lPYU02aDlrUVJOSFNJZFdFRUR5U3VtOS9OQUsxdEVLL0FX?=
 =?utf-8?B?VzFBUlc4a1FEUGJsb2phME9TVUtGR1pIV2w1UjZmeU9aMitkNDEwSHQxSXl0?=
 =?utf-8?Q?t7Kput8fz1kE8VKc=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae3268e-caae-4601-93c4-08de63e3d7f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:52:16.6066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+dpckznEMmu01pTevg7Rlh/3z1ewi/8ZNLvv4PtsDa5+daHYc5L55m5KhRAsO3cY6fBHr+SLtIRhNsbcbk46yTGpjQ4CjsE2Hx3qRqN2Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8096
X-Proofpoint-ORIG-GUID: rC_i0XrvFaBeaiT720sTkjkqb8D5l996
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MCBTYWx0ZWRfX7Me8dirOXG74
 krD133cIP/PNzZQ3nLBrutc/tDqx8PskUy4Io9sSFf2i7zeVAQJMDXXh5u9NDNICqV8tccEANop
 PD9YFL0elo0sLGbUdP5kIqxcdgm+DO2Lh7ypJUhvQUzmcpvmHCEWfyyh44pjYrFsJFFsHboEEtp
 6od7chQWH7MPV/FbZRMIGRhz+3Ikg19LTpNIBCmrtA0yt3PJMoHKrAl3LXlrxM53UfmL4NbmzdE
 qSsScThLTQGwNg7bgHCPrexmVq/DcokqCy2PlMI7rNAiLV+DS38BKJNKw9/z9HZ8QxukqNdQ1Cp
 YxEOElWonyTWOk+pSMNVKhJ9uz+WuWcHjiSjF4EumsLrhE8kF/ke21T+Sp81oG0w6ARXN7FWlba
 juBGy8tAL10GjA6cx/kU9LPYL7abGdRcVV/v6VwgSYCDkIyOmPi1kIWMkewpweyxdPmvQ3jeeJc
 IxyPm9k5p86tfLcqlRA==
X-Authority-Analysis: v=2.4 cv=K6cv3iWI c=1 sm=1 tr=0 ts=698332f2 cx=c_pps
 a=75ld24InqEMuLHyMbyxsIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=jFI5uHYYtXjgSx7Qso0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rC_i0XrvFaBeaiT720sTkjkqb8D5l996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
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
> The next patches are going to remove usage of the driver callbacks in
> favor of QOM realize/finalize.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio-mixeng-be.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 8ebceb968ce..2c9c2af87a0 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -1520,9 +1520,11 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
>       audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
>   
>       be->dev = dev;
> -    be->drv_opaque = drv->init(be->dev, errp);
> -    if (!be->drv_opaque) {
> -        return false;
> +    if (drv->init != NULL) {
> +        be->drv_opaque = drv->init(be->dev, errp);
> +        if (!be->drv_opaque) {
> +            return false;
> +        }
>       }
>   
>       if (!drv->pcm_ops->get_buffer_in) {
> @@ -1663,7 +1665,9 @@ static void audio_mixeng_backend_finalize(Object *obj)
>       }
>   
>       if (s->drv) {
> -        s->drv->fini (s->drv_opaque);
> +        if (s->drv->fini) {
> +            s->drv->fini (s->drv_opaque);
> +        }
>           s->drv = NULL;
>       }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


