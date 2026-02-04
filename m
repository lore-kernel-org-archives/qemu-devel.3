Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9868E95381
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnalc-00066s-Pz; Wed, 04 Feb 2026 06:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnalb-00066R-11
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:09:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnalZ-00051N-81
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:09:50 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145LgWC2991385; Wed, 4 Feb 2026 03:09:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LiG4y/6uCiAa832WfEssfj3F68SacQeWlh1QMDrUp
 Yw=; b=hG2mKzLADBLZQybM4H+/DENhghUzspAbh/iCgAHtDRrQc12tvC+YdPnWP
 DbvsB4w2AemFuVPOFgo0+Fb95yHGFOeFLjXq81ipm75G5ekhxGTM+/ACBMU15VyN
 Bbi/bjibP9/LuLXZyUA+AMM3W3ffrLAot/nn6X8i2Bccln4dkMKAWXqhf+7ewgqM
 DZ9E+THi4Hg9r7CgPLfmx1+C2IPMOVsVlmyK6Y2RJlqQrFv7XBpds6MZWjFR3hYV
 WJ4CH2ynN8pQ5ZXwdDkUN7UrDAhOO2GWfnL2z6A5VN/5nweuVlgupnx4+5ZH8fWq
 10mTzb+ysXenPWuntE7lPCmYf5gtw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020139.outbound.protection.outlook.com [52.101.46.139])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3ntja458-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:09:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6XzG4jMawURwIUpTbBzIm0PQDgvi0u/MEzWUJG3UfSJWUUr0pZYBoRmwLUVkrp9fMxV2eGbLsjRUTgJgfK3UE+/Q6jKI3BW+Kd8TQMy1WrG4hk/bkXbx2Fm7cDccs0LokzojWn1+RfOqfQhXr9TiUt7KxNCUQCvuULBaydt/d8JciNL8sEQ5HviyqMeydfBtLxu7451ZSjEhpKR9u6A9+1u4x+4GSjXyBYBP/8QXCmnS0kwYawFMswR9xXrZI6H7+0zw64wG0WHslj34zWKZCP+d59XX3/ixeINt8IBvXXNzzg6TA1QtqXN4mAdEdnn5Z/zIvlcbeWYPdARqadkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiG4y/6uCiAa832WfEssfj3F68SacQeWlh1QMDrUpYw=;
 b=sS0H3wYunz3IfppZNPICpynNu+znFpfNwxrONLJO/HVQNlRHk7mIC5nn7W04oV5tBA38LCrfbeyBSRDezVgXuoF1wlNtG7Fcve4oj+e4xFJzDIosAq+fGuMWIUwRIIOarnEiZU1zTOa33APLe/3EXouVoeyppKOI5/CMB4SJIkhlZhhJhZeEGGUpngxhWUWlVM65bbzKypoOpz2nSLUMfZxY7c+xEgt7ZJAhAgtwvbkxu8Peuph7m5AWaMxCKob3huIix4OpJq/0Zwfotxe1EosWXQVJ2BEHeNOrpyvCZUGBTdIDivwFKSEb3TgPDlj5thT8qJO2ZMFUYG+uCnHxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiG4y/6uCiAa832WfEssfj3F68SacQeWlh1QMDrUpYw=;
 b=pc/IwTDaorpXfEE8Y0uXnPAF526d2CdyKiQ0LgRi61El+sHhTxZ5WMyzDAJEfU4IskXUThd6gAWEeFzeBjFTB52K8VBT8THy/9MHJI83H70BuC/y0IpTC+EiWY3fRAWb4tUg23Phlp0i98svE7pkplm7X9xuaVg2aC4cri6Cq+PAGqPXzvaqTCdW4SrleUnnRBT8XzV6ULEPaVd8jYsHm/TT+2FW3CGWVT3xzJa5NgxoKwg/kT11oo7vrD4rqwd97SYDnA8RcX43s6LYD3OHMmWQP8GsoeKzmhBwZ91Hhj4vfsRnhMOY+tVJ9c9ZbIfY11IsxLr1gHhEU5XEJ//Q/w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10892.namprd02.prod.outlook.com (2603:10b6:8:266::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Wed, 4 Feb
 2026 11:09:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:09:44 +0000
Message-ID: <45496226-53eb-4ce6-b93e-7c1b2ffbea83@nutanix.com>
Date: Wed, 4 Feb 2026 11:09:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/37] audio: move object creation to audio_driver_init()
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-21-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-21-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0034.namprd11.prod.outlook.com
 (2603:10b6:806:d0::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10892:EE_
X-MS-Office365-Filtering-Correlation-Id: a80bf840-0ae7-42b0-91c7-08de63dde6a9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXRkMVMvcitaTmE5VXJTNWxxUEg4L1FCZ3VsRGFwb3htUEo3NnJvVXdVemR4?=
 =?utf-8?B?MksxZGNOeXR4SVViemk2eDRIRDB3RERVUDgwUnY2VmxsdVIwZWNZNS95U2FJ?=
 =?utf-8?B?bkt1Z090d0N3ak9mdmJUNHBxRFlIaXhjV3plSkJuSXpVL09WaHNMaWZub3pT?=
 =?utf-8?B?cnZiRHZKOEtKdk44WEE4Q1JUaHpGaXMra3ZseWpNY1J2aFZxVHBVQWcwMnJn?=
 =?utf-8?B?MWhiNXlNNnN6UjNpRE44MXFsUjRiNlB4QkxvYjBuMWZQVzZxQVJiMWNIVWE3?=
 =?utf-8?B?ZGVXWThGWS8vNWhNbEl5d0FrUEZrTDJmWkNaUlNwMU1yZlkwRG9PWWhvZ3Q2?=
 =?utf-8?B?eTZLVDQyNFNBTVBwRlBKTEJGVzhpSUl3SitUQnhTU3hBaWdLTVJDZFI3d3hR?=
 =?utf-8?B?clR6ODZTR2NySTZFbkN4THhiRVNYTXN1TkNPd2tUQ1djdGZacm0yWVdzM3NG?=
 =?utf-8?B?TWhDL1gzbU5GNnRzMDVKWkRDNDQrV1l0WE9RUmcyNlByYXNsNC9Kd0JSY2pQ?=
 =?utf-8?B?dm4wR0ViL3E2M1hpV0Z2TWZGR0VJd29SMWwrRjByalBrZnFzOC9RL0t5Snk2?=
 =?utf-8?B?ajJKaUo1eW56YnNGdXpMcld3VExoSGRqV1hjL0pHQXJwR0x4NVNwTndxK1pV?=
 =?utf-8?B?K2orV3U0blJOS01CTkhOcGcyYkYxL2FRYTh6ZmlRUnVGRWZacEJmUVVZaWtF?=
 =?utf-8?B?WTlwYkZPSWk3ZEFqWldTdnpNVVJOSm5GYjB2M2dGUFNtK0Q1WG1manhLT2RW?=
 =?utf-8?B?Zzhocm01alVrTklrd3pLaytKY3E4Rm5HdGcvbFFiM2t5MU1TQ04zajFrWmhZ?=
 =?utf-8?B?K0dhSmdFNnkxZXYwZU5KS1V0eXdPejIwNE5nYnc0Z0orMUhZM3IwS0xkdFhl?=
 =?utf-8?B?TWs1ODlYSHprWXFkSDEzRzdhVE4rZ1JWTGNRMExsUGVGQTFpL3ZLMzFzcklU?=
 =?utf-8?B?NTRTeHlFK2RBOUtJU1M2bmMrOFowYXdQZ3lzQTN6ODN0QnBsNWZyL2s2WndS?=
 =?utf-8?B?REh1c3M0ZVdORUx4R3gxOXEwM3NFM010T0Vsa2tnbmJNSTM4anZEdG85bUpD?=
 =?utf-8?B?dW0rWmg0ZXNFVmwzZ3VCblUzWmplM0dtems2dDV6ek9qNlNzbDUyU1NOb0VO?=
 =?utf-8?B?Mmw3MXlPanZDTFpsdS9UY1B3ZVdzQkRpWGp2bXJLU3QyR2pXTGhYQ29HL2lq?=
 =?utf-8?B?UDcycEE4Zm4vU0NkZzI5aXNTMGZCK25KekR2ZTlpMnpwb0JBRGdxOTRxUjNo?=
 =?utf-8?B?dmlpb3pkb3dkSVRYbkhXRFJuc1duemV4M3V4dTBMZ24wR2pwVFZLZzlhUXJN?=
 =?utf-8?B?cFNkWkIyNUNwOG5uSHJ5aWlRTkgrWmVrZzFhTGVOT21VRFJZV1FnMHgyamVy?=
 =?utf-8?B?MnhEL0pBdXdLbE53a1hEYS9FME80R3lqYnUyOFk0K3dZTi9jb0JoYU9XYmpk?=
 =?utf-8?B?c2RHa0lTekRYb2NObU9FR29ZYTBkT2NIYytDdXhHTTlaZGI0cDN0VzdmYmJ5?=
 =?utf-8?B?R0ZVazdxb1BmNVhXTlQ0R2txNkJrN2V6bTd4ZEhvOCtnLzZOWnlRVEdaSTht?=
 =?utf-8?B?bXprUFFRUEZCTHR1eGQ5S3JLQzhEalVDOTNvN3Jsbk8zRDlIb2xTVUR5N0ts?=
 =?utf-8?B?WG5YRndKUTVGK3M1czdrOXVhK2FJNElwdElYcHV5Tlo2ejR6bEpqcFN0ZS9L?=
 =?utf-8?B?aS9VeGdISmVyT0lIeUYvL2tlall3anZTREx6ZG8veEJzS3YyM0YzcDJEc2Na?=
 =?utf-8?B?eElMZzdOdHJIU0hRYlNTY290SkhrQmtZOW9MNlJQSWUvMUlYRjdaenIyWmR0?=
 =?utf-8?B?TWNhcjdqM1paVURkUnZVTkJHTUdiZ29lRnVwK2JMWU93RndMZFNIWTFHV0hj?=
 =?utf-8?B?Z1FQcGk3cGFGajdyQjhrbTRpVlVNcUwwcW1maUY1enlDTWNBdFJqTDNDYUxE?=
 =?utf-8?B?VUFwb0hjcDgvaDJVa0JoM2wzQWM4cFkwZTZ4aUpBd0J6ZTE5K2xkaHJkMVFt?=
 =?utf-8?B?OXRxSjVodGxLa1JWWDhqSXRvTW5uOGhadlMweDV5ZFZoMFFBUEgwV3RoeXdF?=
 =?utf-8?B?dng3cDBhNVNpblJ3cDQ3RkNZOHNqZ3NMazNOcXIwL2lJMUE4OVgyRC9oZGww?=
 =?utf-8?Q?e7U8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlByME1Cb0NraUtjQkhxdWV4eWF1NmExUnpCVVNoNCtDRmNIcVZ5bG16TnFi?=
 =?utf-8?B?UExNekxnMGNmd29KRkowTi96anpqc1hpemJtc1VIWEtRZlJxWkhVLzRMNkZS?=
 =?utf-8?B?V0oxN2lvSTlrYkpMeHdnS2doUHBKdGdsTHFQdlVFd1c3dXF6K0plck9ieVBO?=
 =?utf-8?B?Mm5scWlXaW84SFV5bG41bXJlWllDV29EWjl0QWd5VFVSNFZUSWRZdklIdjlj?=
 =?utf-8?B?YWo3OWtxR1d5US8rdkIrL1dqazRJcWVQTEdCVk5aOVNidGpqMkkzQnlaT2VQ?=
 =?utf-8?B?a0RnN0ZYdzBKTkMvc2hIYmIvN2gyK0VENjVqYmNwa0gzcXVlcVBVaHc3MFU5?=
 =?utf-8?B?amYxRDdIeGpmL0RCUlZUWDhHRGhJMVVjWWhYYW1Say9TNDRBbWdmL1BidlU4?=
 =?utf-8?B?RVJCOG8vZ1JZbTRnMlg2cWRnWW5PY0JUOWpwWVN3dUhKbTA0Q0pyVVZuTU1M?=
 =?utf-8?B?MzlKaUhpdVFXWlRKcUM3Mkx5ZGx3d3lHMjVMMVNNVlNRUEp3UzhiMGZVZno0?=
 =?utf-8?B?ajhVVHVsN2YzTzBTd0tYUUt1aEhTUnowS3k4bFlaS1MxbFJTaDFjbHMzVXBF?=
 =?utf-8?B?VVZVdmcyQ2lobWgrVTZvNjVlWHlaTlVNMkF3NVJRQ2tLbWtKREFKNk92b285?=
 =?utf-8?B?OVlFcTJkZFZDSXhTRjNPNGhHb254cVl5dUZHWEsvSWRueWtXek82RVlVVnVr?=
 =?utf-8?B?WksrTHRVSENSbk01ZDd3d3ppeDhnNjF5RGVoQkJhTlZOWFhueTBpMjVoMm8x?=
 =?utf-8?B?OWVpb0JZK1hybCtETzFsWkZuM2xFYVF6cXdoQnp4c1YzQm82WmN5QjQyYThj?=
 =?utf-8?B?R29xN1gzUjZsWFRoOEIwSHl1UFhBTDQzd1BEYWdnQmpETEQ3MzJ5ZGN0S2Mw?=
 =?utf-8?B?NlhIeGg2M2dpTk9TMSszbFg4UG5QMFNjckNHU1paR1F5UjZEeEVwRG5CbDEx?=
 =?utf-8?B?bVFDYnprVzlRV3JyYmJ5dUh6K2hINkl2VWR1dVdpSWVOT0U1ODY2dFM3dTRt?=
 =?utf-8?B?c3lqVkgrUjYwU0FOWTdtYWFlbnQ2YUEwMzJhSTVPRk5NbytYYjFhSS9ZMm5L?=
 =?utf-8?B?Q2EyK0xuTERFaERtL051aVlqSFlsSDVvQ0ZuNVpiZnBHcHorUmhyYXJRd1Zp?=
 =?utf-8?B?U2FyWTVJMmdvLy9mVFBEeXl4WGcxbzBRQVFjVi9OQ1oyQmEzZENCckZzUHJn?=
 =?utf-8?B?NFE0YU03bEJNWDkxTTRFWUxod0w4SWpzL05xNFNIOHRBUXlZckRCQ2N0Mi9F?=
 =?utf-8?B?MUwxMFVqWjVSVWlleWpHOVJ5d2F0S1AwN1I2NEczeTRrSERyc0QwRUl0STlI?=
 =?utf-8?B?VTNXTWxUVFRheUhqQ1BSbEFKOEpqWCtqM3UxZzRzNTRZRTFPWC9aVjZMbGpQ?=
 =?utf-8?B?a0Fnb2M5MmdlUllnall6YlNNWkJPK2xBWjdHVngwYjFyWmx4VmhSeXBoZWdq?=
 =?utf-8?B?QVhZTzV0czdoUmtrYzdmTjdOUXhsMEVheEpSK0pBcCtvQ0dlNEYxUGpwbXlB?=
 =?utf-8?B?TEREUFRsUzNqVXV4QkkvVjBzdXdNYlpPYWplYk9yKzExaUJFREUvQjlhdXJL?=
 =?utf-8?B?bzk2TjNVZjBYcFlFSUk0RXV3VHB3REV2UHNZbWp6Y2ltU3BwU3NTSnZjVHNu?=
 =?utf-8?B?NjgvYmVwNDYxeS9mMy9rMDNrMFJxNlV2WnpHNis3c0pSU2k1aDNQREp5ZkI0?=
 =?utf-8?B?T1lVcmpvVWZlc1dHTS9lck52MTYzU3l3SENIaDJFdldsR1VrZnhOWHNLTHpl?=
 =?utf-8?B?MjFlWWo3endYTk1DdGZibjJGeUxidTVDWGZsYWpEZEpHZ21BMVQ5N2FIdjZD?=
 =?utf-8?B?ZFUzaXVzN2pmbUZLYzRWNWo5WFJaa1BpeUJ2MEZmREpyVWJBRW1zQ24xMFhx?=
 =?utf-8?B?MmJBM2NRQjAreEVQTno1TVdtTDVZQmxDdEVKb1NiQ3craWg4RmgzRVdtSHhV?=
 =?utf-8?B?cm1xZHZZNnJ6SHNaZDhzTmV0M0dNUTFLTnFSYmhPdVJ6OVc2d2lndnFkZW9j?=
 =?utf-8?B?SDBRRGtaRmJ5ZU5YRHlOcHd5MklWTzhESEdBdHFDQmo2ZHpOSnBhb0VHTlg1?=
 =?utf-8?B?VTZDSkNMSGsvOG9GS1k4VWROSnZBS1VVZ2VnMFpLeFpsZytXamhocXgzc2Mw?=
 =?utf-8?B?WFIyQW1Sc3Y5dFFLeEE5VWlBUEFvOTd3dEd6V3lQelBRbmNXOVV1TC80WVYy?=
 =?utf-8?B?QVh6K2Z1U3Z4YTBXNHVmbnRvdHJtbVpHOGZCTnpCRmlHOE1HZjB2SHZnR3Bm?=
 =?utf-8?B?anNlVzl0NlJCdm5qb1JFc2ZtbDdLOHdWVGtpK3JnWWxGY25KRUxncWkwMGdT?=
 =?utf-8?B?S1diZTNvMGpxR1BZZDlDeHBZS2VuaHZWMmtyQVZnOXVqbCtLaGp5bEVYTWxU?=
 =?utf-8?Q?YtcUVqloGyuf0LNo=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80bf840-0ae7-42b0-91c7-08de63dde6a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:09:44.3857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMg3t7k62b4ew7A7WdrEZ0u6wWK6JFIYt8tmf82du8+ObEr6Ct8UtXDtjFvZ+sTYl9dX9miFyhjGvQyEYsUVL0n+CLIA3WTsfKSIiywnFTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10892
X-Proofpoint-ORIG-GUID: EnH5GpFvZ8jylEi1kvY7EBTIsxewl1En
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4NSBTYWx0ZWRfX9DQ5zhFU04bA
 ng+pqXh0sbcv1Xw+ZQ4vYaiaqUh0+TaFfwkLI29qCJ9yKfnyuekvzQTup111W4aOx7fMVrfqJc3
 O+R7ApqB2zqMhjtrzibgUpC+dDJwC/xN7F6MnnInMcts69/PIdUYJ7NbhSZsPRiprpuMGaboq+K
 4ly/GwY95CEwfT/zaXcxHmYu7U2++39+v7+DgzPcXD3o1a0v934Nsc0qQW/Anttb2ZVlMGDi+ya
 wV4bYngrRxeNcz5BKY+2WuFJKa4fCI3mFu8Fjt5sy2p+eRZFKsHk6o1I3NhUzcm6QIaCDMyK56m
 JeSaJaM/gcZRXXNm/H60e9nTdtzLLvJQ3tap3KUbk4EmMQGbxS1ku9XvJ4bVI2wsFgiBnwxEcuY
 PCuMoqtJircGEBsewVaei1+oPBC5o3GqSZf4jH6WBHThcNJZY1zcv5FOZlWKZq5Bsrbe7XeExQz
 J9Vr/UpY3ZKbnyVMTaA==
X-Authority-Analysis: v=2.4 cv=K6cv3iWI c=1 sm=1 tr=0 ts=698328fa cx=c_pps
 a=mX607ur0qtllMGi8m/+XyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=RORn-v7hUX7ud_ETi_QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EnH5GpFvZ8jylEi1kvY7EBTIsxewl1En
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
> As we will allow other kind of AudioBackend objects to be instantiated,
> move the object allocation to a audio_driver_init() and rename it
> audio_be_new().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c | 65 +++++++++++++++++++++++++++------------------------
>   1 file changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 2a067075b0c..323608ea0d5 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1561,19 +1561,24 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
>       return total;
>   }
>   
> -static bool audio_driver_do_init(AudioMixengBackend *d, Error **errp)
> +static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
>   {
> -    const char *drvname = AudiodevDriver_str(d->dev->driver);
> +    const char *drvname = AudiodevDriver_str(dev->driver);
>       struct audio_driver *drv = audio_driver_lookup(drvname);
>   
>       if (!drv) {
>           error_setg(errp, "Unknown audio driver `%s'", drvname);
> -        return false;
> +        qapi_free_Audiodev(dev);
> +        return NULL;
>       }
>   
> -    d->drv_opaque = drv->init(d->dev, errp);
> -    if (!d->drv_opaque) {
> -        return false;
> +    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
> +    be->dev = dev;
> +
> +    be->drv_opaque = drv->init(be->dev, errp);
> +    if (!be->drv_opaque) {
> +        object_unref(OBJECT(be));
> +        return NULL;
>       }
>   
>       if (!drv->pcm_ops->get_buffer_in) {
> @@ -1585,17 +1590,17 @@ static bool audio_driver_do_init(AudioMixengBackend *d, Error **errp)
>           drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
>       }
>   
> -    audio_init_nb_voices_out(d, drv, 1);
> -    audio_init_nb_voices_in(d, drv, 0);
> -    d->drv = drv;
> +    audio_init_nb_voices_out(be, drv, 1);
> +    audio_init_nb_voices_in(be, drv, 0);
> +    be->drv = drv;
>   
> -    if (d->dev->timer_period <= 0) {
> -        d->period_ticks = 1;
> +    if (be->dev->timer_period <= 0) {
> +        be->period_ticks = 1;
>       } else {
> -        d->period_ticks = d->dev->timer_period * (int64_t)SCALE_US;
> +        be->period_ticks = be->dev->timer_period * (int64_t)SCALE_US;
>       }
>   
> -    return true;
> +    return AUDIO_BACKEND(be);
>   }
>   
>   static void audio_vm_change_state_handler (void *opaque, bool running,
> @@ -1792,41 +1797,39 @@ void audio_create_default_audiodevs(void)
>    */
>   static AudioBackend *audio_init(Audiodev *dev, Error **errp)
>   {
> -    AudioMixengBackend *d;
> +    AudioBackend *be;
>   
> -    d = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
> -    d->dev = dev;
> -    if (d->dev) {
> -        if (!audio_driver_do_init(d, errp)) {
> -            goto out;
> +    if (dev) {
> +        be = audio_be_new(dev, errp);
> +        if (!be) {
> +            return NULL;
>           }
>       } else {
>           assert(!default_audio_be);
>           for (;;) {
>               AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
> +
>               if (!e) {
>                   error_setg(errp, "no default audio driver available");
> -                goto out;
> +                return NULL;
>               }
> -            d->dev = e->dev;
> +            dev = e->dev;
>               QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
>               g_free(e);
> -            if (audio_driver_do_init(d, NULL)) {
> +            be = audio_be_new(dev, NULL);
> +            if (be) {
>                   break;
>               }
>           }
>       }
>   
>       if (!object_property_try_add_child(get_audiodevs_root(),
> -                                       d->dev->id, OBJECT(d), errp)) {
> -        goto out;
> +                                       audio_be_get_id(be), OBJECT(be), errp)) {
> +        object_unref(be);
> +        return NULL;
>       }
> -    object_unref(d);
> -    return AUDIO_BACKEND(d);
> -
> -out:
> -    object_unref(d);
> -    return NULL;
> +    object_unref(be);
> +    return be;
>   }
>   
>   AudioBackend *audio_get_default_audio_be(Error **errp)
> @@ -2182,7 +2185,7 @@ void audio_init_audiodevs(void)
>       AudiodevListEntry *e;
>   
>       QSIMPLEQ_FOREACH(e, &audiodevs, next) {
> -        audio_init(e->dev, &error_fatal);
> +        audio_init(QAPI_CLONE(Audiodev, e->dev), &error_fatal);
>       }
>   }

Mildy curious as to the use of QAPI_CLONE() and qapi_free_Audiodev() 
introduced here, but otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


