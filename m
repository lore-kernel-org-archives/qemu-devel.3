Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67079CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gqn-00079o-Td; Mon, 22 Sep 2025 09:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v0gqi-00078g-QM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:45:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v0gqe-0000eu-P2
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:45:00 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58MAHnwR1382577; Mon, 22 Sep 2025 06:44:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+Zp/4pP2LrEJJpn3llYw/GwfqszPYFAkPoHPWvu1C
 1c=; b=vww/tDe53rNSHHTYy4MU33+r5vXuQ3AwkAXUDS/TVNIzd+km0CtJoKjxs
 mZFSbUgvL+Eqi3NG2BqCan+aVI2NwkR2hr4F8o957AcDRYPf2PsLvSBoudmMaP6M
 f6t18ASmt/j34cI86/DAjjspB7jDMLMgoeWRNpYLPzhirATCqv9fYdfuv49e18N5
 dMjAUZA6fBxAp1GL08ns/lR6ubFHwjh0byIwOb0St7hnmFuZp51i6XLKvxnvNtaN
 AZTh0YVPWl9OoAVwlBW5bInhqdImYSdOpyYr04DVUZie1pEERC2bkQalfT834Fbz
 whrEwKJ+xO7NduQ5E5AcPWRMO48EA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022089.outbound.protection.outlook.com [52.101.48.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 499rkrkat9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 06:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU/KaMH/K4436Ml6OCA23u9pQfAoiyBXs63zB8pDf/6NxXkO87F2eeQvuPIrn2EiupytTSY+crh9SPezC5+LUlNBjeQzbbmQQm5a54sNiRyxirOXvhkqfPxjTaA/tvdH7CAO4S50lUO3R+wP5IW2cAPgPres2oSD9I9L91NxRtdHPI89HEMPnkEf0Mztru/w+4V7pGLnjc90/SxalI4QzgXlXIv/VJqzM1Z+hiFT5ODwrKrsr+ycSkXlpvzJjOjesX98YiPP+KBksCbvOi+Q5JXUNvdZq9NYuaTye23msgQ3jdpV4kcww/QlSRn0mKM6XXnflawDjmlh6AYmOn4jJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Zp/4pP2LrEJJpn3llYw/GwfqszPYFAkPoHPWvu1C1c=;
 b=wVmojV8Wz4FMBNVe4a4dJwx/nrwC0jZNR3DsLLQQflHatlJIJbdEptUfOURpWwSXEjW9hRxZBcMVsQekPNlcNzi3IHug6IHPd17aTV88wbHJhZZCPzJF5LJmQ91nM974H/aFbmppD44mQi0uSK9BCEyQ5shhen5Psj9OY0++ACZgOsyZCwURv4Yrom/PciYnoQFFQTXnPDYH+1/m7tgWWj3W3BbUiVLWGACR9V1M4NuVRtgq/sBgLrhmgqmMgjNbQutQEWMrcdBWhp1+BX0okVdEZIlxqqTdyat1RUEKum99UI4soyUoQcTzXlarGgDlRgExXRkrT1vrsdAG7n+lng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zp/4pP2LrEJJpn3llYw/GwfqszPYFAkPoHPWvu1C1c=;
 b=nqBSsSBpd+oLxaG1mqQTJ7Ek5E49V3rblxAE/4LnmmLwh5z+VSAf9NibZOrPZwHA9waAduAEGNWnEi5nLy6bOvP1NBvW9UqOCnnfUGHjqcNffLB4ahRw4o2l42qki38kT8AxXvjHhpgJDPbQhvJ2Gt7yGhxhp3pyfDBEx4bcbZwZE+pzqhhESuVm53PZsyB5SbUt2SXEDmPxjETWErtY8RRFzSH8OIvpTydxQs9FwMM6ImZltFjO/As8VeP2gnr1RBXSCispjDUpMkPJkv2nyqVwL4jAVn1LI2WPg47KJN74jqJFkjx3e6ZosH897lX/52Iiylf4zD0gZVsITfMP3A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7764.namprd02.prod.outlook.com (2603:10b6:303:a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 13:44:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:44:44 +0000
Message-ID: <fe890438-a46d-4d46-8092-95001da3b2b4@nutanix.com>
Date: Mon, 22 Sep 2025 14:44:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-10-mark.caveayland@nutanix.com>
 <7fa8968e-c584-4441-8859-a40788067e95@intel.com>
 <fd631cee-4089-400a-a79f-0091341fec1f@nutanix.com>
 <345b5031-c8e2-42d7-b944-5341747c7349@nutanix.com>
 <03daa425-0f1a-4377-90c1-34846e98e810@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <03daa425-0f1a-4377-90c1-34846e98e810@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a711023-1635-45a1-cc17-08ddf9de3014
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTh5S0xZb0RRQnZWby9PdktQT2VCTkxQaWQ4dElRUWtveDA0ck5VNVptZjRk?=
 =?utf-8?B?NklRUEVzbFEwdnZnSXBLTUhRNDJtalRyUW8xaUh1RzJWQzRSTlIxQkRHRndo?=
 =?utf-8?B?OXJHVHluenJHUUlES0hhQnhUVlZlYlB1WmVyNEorRDUveVJneTVYT2Z4ZzFI?=
 =?utf-8?B?ZHQxZmI2YSsrU3dwaUdQN25ydjVPZGxxMC9ycy9UVnF3SVhuNjJuNmdPSUdv?=
 =?utf-8?B?K1R6c3NuWGM5VlNmU0wrQnNmdzFUSm1Ock4rWmY1YkJTdmJyKzVhNWpYM0Jt?=
 =?utf-8?B?MUFWd1NBcFNqbml4R0xCMXAxQjRWdkYxUGFhaXNPYWlHSmhuallYQzUzWmc4?=
 =?utf-8?B?bzBkUkhSdTFuUU1DR21HZWFRWWZjQzBVV3J5VnpROGkrcFpRd0xmWDN2Um1z?=
 =?utf-8?B?N29xS0lhVmFnQ1lscmRkbEVsbUtMMHRPZ0VuZVQ0elpvV3dYakVQUXNOQTc0?=
 =?utf-8?B?VE9VUTBhUG1IOVpQTGg3djVmeHRVQmVRdXR2alQzUHhpZVk2UDlsbzBrVjBL?=
 =?utf-8?B?R2Iwb2lCV2J0K01xSHZ6Ly94LzBVbXZ1SkdoeVVtTlhhWTlrSU1HMjd5ZzZF?=
 =?utf-8?B?a1B6T2dKSk1mVmRqNHVlNGxYQ254SUllbTdKaUVjVUVRcTVmcGtpSjIwZzNQ?=
 =?utf-8?B?ODBKWU9hbmlWVU1lQ3NsMmhSWGRTNnA3UUFveUZsMXpHQk4rYjhkaW5aVWdW?=
 =?utf-8?B?V1pGRTdnSmJwbHRqQXYzTU51OTdsR1FCMmp1RWlXbTBzRzhjc3VGSjFLSzZP?=
 =?utf-8?B?eE0vUGFCb1phVUZDWC80cGYrOUlUb2FLQmhWN3ErVGlUS0t5NW1GZURMMkdI?=
 =?utf-8?B?d01ocGVHdEVTdE0rYWNERE1ZSUxMT0JWbmJUK1pqSVNIV2R2QU12TjZBVHFY?=
 =?utf-8?B?ellFRGRQZ3YrQmVIZDZSRDFXcXRXOUFGcUF0WllHTWNaZzBKNjRQWElaTFRF?=
 =?utf-8?B?K0RUK0t3cUhBR3loRkJTT290clpOSnFOeStyRFd5eTdxcnRGU2hnYWlWYXdk?=
 =?utf-8?B?ZUc4ZTBvSVpJR2VsS2Vxd0ZPUEJSWFZFZWRMY1Bsd3ROMEZSQkNYcWk4VmtL?=
 =?utf-8?B?N21ZVlNkVEJGb0FFM251RnFOS0Z6SHhtZXFjR3JjTmNGbEYxNFMvelVUN3hr?=
 =?utf-8?B?aExUSVJBdDYyeWltM0FXdHBCN0o2dldNbittWU8wU1I5cU0wWk9JR0xGQTd6?=
 =?utf-8?B?TGNNZGdIWFVXVk9ZSmJpWUYwLzZuQkxzM1ZxdDdrSnRhNHYvU0hEUXdOeXdH?=
 =?utf-8?B?Q2Q4Y1NKcmlxQTRKb3BBOXVHN1Ezd3dSRzJsTEllY1ErdGowcUlXVEJvWlhI?=
 =?utf-8?B?cHlhdDBKN3VVLzNjZnB6dnRQdlZQTFc0d2p0d2MwV1BaODhObFd0OXNaNExF?=
 =?utf-8?B?ejk3THpFK09WNmVLTXdaLzliL1MrL1VOMlBPOGhUNTV5ZEdTN0ZaYzdzK0R1?=
 =?utf-8?B?eWlQTWhkZUJQOFRkVERtdzZrVmFXNmZFcnp5UmlBWm13OUVBKzJmT0xZVHZT?=
 =?utf-8?B?WEtlRG9Ob3FXRVpqTG5VNzlkZEFBU3ZZRC9zN3NmRGF5SVFsbmplNkNvZjB1?=
 =?utf-8?B?VWJNakpFOEtCemQwNzBLemZNaElsQ2hyZ3Y1QmgwQmpRS3NuQ0N1MlQwaElu?=
 =?utf-8?B?RVp5d2RrQ1czYlJ5YXNVRTBEaGViMFNJcytzY2VuT0FmL3NuVmd6QTdvYjdY?=
 =?utf-8?B?OWxWei91NzFxTStMN3JvQjc0ZGorQ3BqVjljbmZ6VXpoMWdwTzd2M1pUandJ?=
 =?utf-8?B?VFI4Y1Q0b1lISG92VVpiRlpBTkRoM0hoTENUUnJISlVBUmt0QXUwZWFhK1lO?=
 =?utf-8?B?WTZJVHkwcjhsVkRKVk5zb1FtWmt1YTQzVzJDeER6WVdTb1Q3b2k5UXBDdXN3?=
 =?utf-8?B?czV0WUNaOEh6SXpXbDh3TGJjZDQyMzVPZmxPb1BxQU9IcG1MaWd5VTBiUnBM?=
 =?utf-8?Q?ZZW9v0fGE8g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akcwT1g4b05MVE8ydm9DdldWUU9tQ05qOTFXS3l0Z2N3NDllU3pIQTEwRThv?=
 =?utf-8?B?R0srMHVqNE5lSGdVa1hnc0pSRzJhY1l1Q1M5UXU5ckgwZklUM0FGZ0x6SktO?=
 =?utf-8?B?Z21MaGU0Y3BHTXpGNmZXcXF3UVR6M29kS1hiNGFlR3FyY1NFUEJLY1IyZVNz?=
 =?utf-8?B?YkJjbzBqUHFhcWV5V3pNem1RVC9mZ1liTUNrY29WVTdvWmRJa2E5UE9mcmlZ?=
 =?utf-8?B?WkNiVmFTRzcrRG1NVHowYUJlbnhvbFFIaU9zd1hMdTk3ZlF3Qm9tUzZhTjBC?=
 =?utf-8?B?N0lBWEtnWUQ3SGFkbkQ1MjRWbFQ4UCs5bzh0QW5SQnhSaGtBK2h3UUM4eTdW?=
 =?utf-8?B?eVV3VS9ZMTl2OVBPc0MrQ3QwTGpyMVRrMjV6NjR6QmRUZDJDZEdWblo5d3Y2?=
 =?utf-8?B?azJqbzR3ZVI3NGh0a1B5WXdtblpLNFJiWGg5OHlNeHJZNTZZWTVScHZEQTh3?=
 =?utf-8?B?WDhkMi9jSDdpSkExcVY0eldRaFJ1U25EN2o0S3oyY1NILy9Cb0V1UVUvZ2t3?=
 =?utf-8?B?ZjcwVUVKUDdwMDhUVmxqaXU5RzVyc0ZWdlNPTVVwU04rbUtBdXZMZGMxaGVr?=
 =?utf-8?B?ZnExMElOOEFzTXRmYWJUVm5rQVQ2a2dhZ0ZQM2ZYd2tkbGhzYzBtZk9TZS9W?=
 =?utf-8?B?TmZCMFNRWTVRbE1DRXBGYlJ3bFdjMU0vcVBWTkUzem00eHhKRFhsQVMzUUJG?=
 =?utf-8?B?UVFJejNiem5JQXNrRHI1eEN1TVJNZ0xpOXYyS0c1d0xhZ3NkVHNxR21JVldx?=
 =?utf-8?B?SG9jQVkybE53alFpaFVZMC8zRTNYaVp3Wkw0RkYxcDh1TDRRdExNRENrZ1BL?=
 =?utf-8?B?dWdHdHlzWUM3OUFBS1AxQUYzdkhFLy9iOXJoU3hpSXJYclNITjd3bXBvMUlo?=
 =?utf-8?B?NStjbzMzN0NBYlFiY2tLWGdKdHpWcTVUZld5aDNHcXJJWnNaTUZNQ3hrZUdp?=
 =?utf-8?B?NUMxVlB3ZEZ4dVBVNW5hUWtYSHhmWC9HUXN1M2ZvNU41VkpkZDZWU0tBNG9F?=
 =?utf-8?B?bHkrUlo0Q1RrZEQvc0g0NEVuL3NYSVQzZGQ0c01yZ2M4d242d1A3bmVCU25C?=
 =?utf-8?B?UUI2TGVuT3dFWncxVHB0bkRzYjlSMm5lUUd0VGpPQVBXeitIdm9ESTR3elUr?=
 =?utf-8?B?UU54NUVpU0xNanF5VGlCWlI5bmZvR1krMU82TTZiWmQrWGFhaFBBTnpSWitF?=
 =?utf-8?B?TWZtdEdjQ2srVzIxZ2pPUytJcHlObnp5RXJsdkZKalNJVHF0Q29NWTdvWm94?=
 =?utf-8?B?K0h5Q1FtSmw3Qmg2c2Vab3N0dHVGUDZNTlMvb2hrekxBSlVBaDduYTNSNlA4?=
 =?utf-8?B?OGJsdVo2SDZoT3pTMG1oZDA5a3NLbzFqdzBjSFoyVXkwS0oxTHV5NVNsbWQ1?=
 =?utf-8?B?NUIxWExFNUtUNnRPcWtjMGp2K2JzTWlMUWI0RlUveTFlNitodCtkbk1jMnB3?=
 =?utf-8?B?MDl3Rjh3N3J0UjBtSytTcUZFazQxbUJKRlI4Y2h3enFTeXNSZWU4bWJlSXdL?=
 =?utf-8?B?VllDdzlkZUNzd0tyTnVtNTNrWUc1UFRNT05VTkg2Mit2SGU5YnZxUUkrQTRz?=
 =?utf-8?B?V2VBV1RZVXp5czhmVDEvU3RpOHNLQ0thcWp4MkJYVDZVbTQzcVZVaitoSjJp?=
 =?utf-8?B?T2IydzlUSmVHRWNDRkpwSE5aVkk4SWJtVVNiWXFtWHZ5Y1prekRxYlJxZ2Rr?=
 =?utf-8?B?bE5QYUNoSk1GWitwRHFEZUdSS0FuQjJndVlGV25YRDJ5eGFVTE52TldBeGFZ?=
 =?utf-8?B?TE96NEJJT2VNVE5hTXJlb08zbzB2TnZNU0IzNXVYWDh1MnQwakNsUE1MSkRH?=
 =?utf-8?B?ZHdkb0ZaWkZvM1M1WFp3bTljcVVKc0oxTGRuKytlakJ4NFB6ZmJ2UjR3Z0lT?=
 =?utf-8?B?Q1JhODhERzdRVTlkbUdFbzFkVDZTcHZxYTBkWEpNdEVXcmg1QnNJQkNKWXI1?=
 =?utf-8?B?UzNOOEZMeXpWUUUwL0x1bHdEMlJWR3oyaUdtWVNGUzdTcDhiTFJHUUYwMFBo?=
 =?utf-8?B?bTFSb21yNEgvWTVuWFJPMHBDYXY5Q1pXZHNhKzdseUNFQllMU1hVMXV5bUhW?=
 =?utf-8?B?a09TWnAzTElyMk13eU9oZEVMa3RhNmFtRGx0Qkd1WGRMdFBCaFR3RFZzdUY5?=
 =?utf-8?B?R3B0NVE1eTFldnNwZ3dNWEZGd2pnRnNUQlJiSkNEYmdqVGI3aXA5cGNWQjBj?=
 =?utf-8?B?d0tLaWpFdU1sMXZMNHNBa1lvWGR4UlVLWDQ2MWJXbGg1ODBwQVNwQXVXUzlQ?=
 =?utf-8?B?WTFwb2FUS21nQko4M2s0SU1mS3d3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a711023-1635-45a1-cc17-08ddf9de3014
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:44:44.3803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eWez69/uqZo0Y3jPX/2Cf2ObBzl8NI2pWyEfvomWZf377Q/Ow8sLkjobTTP2jSfKKEthltHZhMotesFUNLysKpyW56m6PGNeJ/Hias/PV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7764
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDEzNCBTYWx0ZWRfX0LQyqrFxypux
 +bdbpx1U/VSHRsMwWw5GMcJ28vaRct49nuzetEvh/CUzdsFLhL6w1L2IlktjuIc+IBAa1WpTbZ0
 MZiPaMA0dYzZ1h4UjaIOt3yeL+ZuyXXbzTBk4ftXh9g1VHN/y+jRN13NQAtH1oj/Ta8eliwFoZ6
 8c1Ip8iVvuKxL6XGLeUPDcw2/lfjlm282NMBlxUAuK7/4gndfZohgsV+ZaUqv4rv9mpGxKuztXd
 h5owp+X6GNLy0/IHcWlYnnGrdwCAzLKq21wxe2hM4iPd0RN4uk5ECKyfVrAVXKgE3zpTE9qG9kL
 HsoaE9wQZjhRwnCTaQWSCCGJ7oW315nksbvvw2UoN/+MQja6gM/lQ0wDGC3X7o=
X-Proofpoint-ORIG-GUID: jLFKXQjTD_wl4-WgoD69H54Lipwfx4S-
X-Proofpoint-GUID: jLFKXQjTD_wl4-WgoD69H54Lipwfx4S-
X-Authority-Analysis: v=2.4 cv=eaM9f6EH c=1 sm=1 tr=0 ts=68d152cf cx=c_pps
 a=88cenwDluC1K+zw7ozncdA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=10W7aoRrh_3PQ8YIFtQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 22/09/2025 13:08, Philippe Mathieu-Daudé wrote:

> On 28/8/25 10:41, Mark Cave-Ayland wrote:
>> On 27/08/2025 12:00, Mark Cave-Ayland wrote:
>>
>>> On 26/08/2025 11:01, Xiaoyao Li wrote:
>>>
>>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>>>> All isapc machines must have 32-bit CPUs and so the RAM split logic 
>>>>> can be hardcoded
>>>>> accordingly.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>> ---
>>>>>   hw/i386/pc_piix.c | 58 +++ 
>>>>> +-------------------------------------------
>>>>>   1 file changed, 4 insertions(+), 54 deletions(-)
>>>>>
>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>> index 816124c027..fc94937ad4 100644
>>>>> --- a/hw/i386/pc_piix.c
>>>>> +++ b/hw/i386/pc_piix.c
>>>>> @@ -444,69 +444,19 @@ static void pc_init_isa(MachineState *machine)
>>>>>       GSIState *gsi_state;
>>>>>       MemoryRegion *ram_memory;
>>>>>       MemoryRegion *rom_memory = system_memory;
>>>>> -    ram_addr_t lowmem;
>>>>>       uint64_t hole64_size = 0;
>>>>>       /*
>>>>> -     * Calculate ram split, for memory below and above 4G.  It's a 
>>>>> bit
>>>>> -     * complicated for backward compatibility reasons ...
>>>>> -     *
>>>>> -     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This 
>>>>> is the
>>>>> -     *    default value for max_ram_below_4g now.
>>>>> -     *
>>>>> -     *  - Then, to gigabyte align the memory, we move the split to 3G
>>>>> -     *    (lowmem = 0xc0000000).  But only in case we have to 
>>>>> split in
>>>>> -     *    the first place, i.e. ram_size is larger than (traditional)
>>>>> -     *    lowmem.  And for new machine types (gigabyte_align = true)
>>>>> -     *    only, for live migration compatibility reasons.
>>>>> -     *
>>>>> -     *  - Next the max-ram-below-4g option was added, which 
>>>>> allowed to
>>>>> -     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
>>>>> -     *    window below 4G.  qemu doesn't enforce gigabyte 
>>>>> alignment here,
>>>>> -     *    but prints a warning.
>>>>> -     *
>>>>> -     *  - Finally max-ram-below-4g got updated to also allow 
>>>>> raising lowmem,
>>>>> -     *    so legacy non-PAE guests can get as much memory as 
>>>>> possible in
>>>>> -     *    the 32bit address space below 4G.
>>>>> -     *
>>>>> -     *  - Note that Xen has its own ram setup code in xen_ram_init(),
>>>>> -     *    called via xen_hvm_init_pc().
>>>>> -     *
>>>>> -     * Examples:
>>>>> -     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low, 
>>>>> 512M high
>>>>> -     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 
>>>>> 1024M high
>>>>> -     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 
>>>>> 2048M high
>>>>> -     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low 
>>>>> (=4G-128M)
>>>>> +     * There is no RAM split for the isapc machine
>>>>>        */
>>>>>       if (xen_enabled()) {
>>>>>           xen_hvm_init_pc(pcms, &ram_memory);
>>>>>       } else {
>>>>>           ram_memory = machine->ram;
>>>>> -        if (!pcms->max_ram_below_4g) {
>>>>> -            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>>>>> -        }
>>>>> -        lowmem = pcms->max_ram_below_4g;
>>>>> -        if (machine->ram_size >= pcms->max_ram_below_4g) {
>>>>> -            if (pcmc->gigabyte_align) {
>>>>> -                if (lowmem > 0xc0000000) {
>>>>> -                    lowmem = 0xc0000000;
>>>>> -                }
>>>>> -                if (lowmem & (1 * GiB - 1)) {
>>>>> -                    warn_report("Large machine and max_ram_below_4g "
>>>>> -                                "(%" PRIu64 ") not a multiple of 
>>>>> 1G; "
>>>>> -                                "possible bad performance.",
>>>>> -                                pcms->max_ram_below_4g);
>>>>> -                }
>>>>> -            }
>>>>> -        }
>>>>> -        if (machine->ram_size >= lowmem) {
>>>>> -            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
>>>>> -            x86ms->below_4g_mem_size = lowmem;
>>>>> -        } else {
>>>>> -            x86ms->above_4g_mem_size = 0;
>>>>> -            x86ms->below_4g_mem_size = machine->ram_size;
>>>>> -        }
>>>>> +        pcms->max_ram_below_4g = 4 * GiB;
>>>>> +        x86ms->above_4g_mem_size = 0;
>>>>> +        x86ms->below_4g_mem_size = machine->ram_size;
>>>>
>>>> I think we need to sanity check the machine->ram_size is not bigger 
>>>> than 4G, and error out if it exceeds.
>>>
>>> Amazingly there is currently no limit for the isapc machine, but I 
>>> shall add it in for v7.
>>
>> With the PCI hole removed it appears that TCG and KVM have a different 
>> idea as to the maximum allowable amount of RAM available:
>>
>> Fails with KVM:
>> ./build/qemu-system-x86_64 -accel kvm -M isapc -m 4079M
>> qemu-system-x86_64: kvm_set_user_memory_region: 
>> KVM_SET_USER_MEMORY_REGION failed, slot=0, start=0x0, size=0xfef00000: 
>> File exists
>> kvm_set_phys_mem: error registering slot: File exists
> 
> Is this a bug? Clearly not obvious error message...

I'm not sure? I suspect the change to the PCI hole size is what causes 
this to appear, but I'm not overly familiar with the KVM memory layout.


ATB,

Mark.


