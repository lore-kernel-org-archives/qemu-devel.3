Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9236BEDF17C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvcv-00005u-Dz; Fri, 13 Feb 2026 11:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvcd-0008Q2-RE
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:02:28 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvcZ-0002yJ-De
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:02:23 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7m5QZ169788; Fri, 13 Feb 2026 08:02:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gsIVgjDTt38+RkXEofyGlOksoUezwgPyxTpdoL/T2
 j0=; b=HXteMtqoGzY6ehSz8aoWUVLZfNe3D70WoCxzGcguBZ2BQ4TTfPv5+FLmp
 mMySQ9zV7ELl0bk6H1+h4pOEuNxlqkEDgfIOUt7ayFeNb+pQ5dmNkCnvXIXqw1jW
 Aq4zoHpPRfG8ODihhYB+h8A5CsVTPkpvwF/RnC8yexCw+o36Ihq6c+amJ6KU4S/4
 XRUjSBpdRz4B3kEJRq3lcQuG2LfbaHX49SOEX5JWtS+nqeiRXSAQLnuiyo7rCY4M
 RgLV4myym3kODFcIrTdmDm7Y8B2wWQLqtiNDOR3+NY0c1ehU8IMDy++0tC4ZgwF7
 OPcSdulSDNKqTW0hjleX3gXdTkPYQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021090.outbound.protection.outlook.com [52.101.62.90])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9yvvs4kr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 08:02:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GggwNO4bkj7/MW3XuKQjIwuGjUCOrPESnO7vHS5wtznAYL/TCBI6sXBmwH7QKb0HWMWJ+tU+G7/nrhNLi3620QzY0xJsN2ciFPWuEQUPrx0WEQ6H+dhmgyW9qTEpySjhq6w5ffXbgU/nxp+RHSoiZLXCzdlWTvmQ+wO4ZyjY8ANWUcSTECfpnT+g/2V3/xdBmGXvHm3IyuL/cDlNYDCd3wTOXmDquerodJTzSW0Qgtu5A5zGChnMkqg+EzhSg6Yz/9r8Dv+UMwlyNBw7v4JtVMndsJKC63e5rR2xBhAMqla2x8uPUyBmmEkvxoka/uAQpBhY5RdfGF+gpmSPKIoi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsIVgjDTt38+RkXEofyGlOksoUezwgPyxTpdoL/T2j0=;
 b=f9rQA1re+AM9szSpEuZYkr5DssQfvxiuf/kgruyPVaiAaosihrNiWB72YcNYzCqIxby0fxEnvH60UsE9CA3mzh2l3FjW/XVBZH85luwoiDxF6HMQJIlYAiLiCj5eCkXI+Ka/h4cAdVLY7JeUXg7Hd0rtE86Qe/o/sBJkHS/yCgmv585ZaRD6PLwE6BAtIpXGT0T5oJxnpSUoFMZCXuw0pzAH9d5Dp4ZJtpXoU7IodM8JbBmQnbKl1P1pakpFrtG35J6dqEb2SvR3CV5Qs4gPebOkzPWoID11wmsr0v3svx8KWGkowcNV/dW5/HhxU6wfg9C1TlcxtFfvUGnklwF5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsIVgjDTt38+RkXEofyGlOksoUezwgPyxTpdoL/T2j0=;
 b=k4H8aYRj7wJrMsxJ21vKZStgWHIfqA5Sr7knxvoMKqQ6Y4j6W4kbnIHkAEId0ka1WQU+DOUR3qTGl8AD57H/nMZAMS//06ZlFV/RwgxoeOYvPiHJkkKq0RuFTWqdpAbYEtu5KcTbIX08LTC8Wd3+D5luZY8amgBBX2bpju+lwJTt6ifptbwSOF8ULbrI3McRErZQi7ueCSgrosJjNHfoKz/GPNs59ENaNaNNFKO5K0t/L5mBNZOT0XApwXlE1QCkGipQzhpNL9IySSD3EtwAJ7bJkVUJBtqB7iOTnj4IBsPlrjpJgUtF2MksYcXBQyHszz+fVIvsV5mSHYFx4zimqA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9811.namprd02.prod.outlook.com (2603:10b6:610:167::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:02:13 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:02:13 +0000
Message-ID: <85e3675d-0753-448f-9880-d0ecbb284cb3@nutanix.com>
Date: Fri, 13 Feb 2026 16:02:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/43] audio: rework audio_bug()
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-41-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-41-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca320c7-6b85-4a73-02c4-08de6b194017
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b29RcUM5ak43Nmp0TEZib0o1VHVYRnV6YS9lVEl4TkdJQnJ3NmNoOW9KZ3Q5?=
 =?utf-8?B?ODM1Y05UTjRUK1ZYcjJabTlYVXlpS1pKWVFmSDcxbklUMlZYSHhuUmhWUmxt?=
 =?utf-8?B?cE44ZE00NHl5R1RyS0tCTWNVbHV5YU92VldpQitVZDE1WVRhL1E4eWloK29i?=
 =?utf-8?B?VHZZMkJ6OXFNZU1rVmFjRjdORFFSSjg3RzREa0F3R3c4YTNqYTlpM0hWU1di?=
 =?utf-8?B?WUMyc3Jza1ppL2lRMGhJN3RxQktPcTBGMlhoOEkycFhyMGZwdTBHZXIzM2pH?=
 =?utf-8?B?WUc0QmJ6b2hKUmtjM3VLQ3Myazc5Skt5bk9HelpWZ1pmNHdqRURZYVRRSlRu?=
 =?utf-8?B?VExqNVhFbmx2c1RveldYdFFSTUdreWFWbUUvaW52b21EUUxPRWZJNDFrOXhw?=
 =?utf-8?B?ZHcyWjAzczM5ZlJrUFZPTXpxUEtUb2pKSlB5TzZWR2xNNEN0Nzkrd3VkZno2?=
 =?utf-8?B?NDJBSXZDd3B2NEFRemF2K1g4aU55TXU3cDkxMkpScFpOYUJBcVMyRkY4Snd4?=
 =?utf-8?B?bllMbDVSU3Y1RFFYQzJEN0V3Z21kb0czUmIzMG5hT1FITFIvTkNGLzBiZkxp?=
 =?utf-8?B?V0s4bzZCVG5hRmRQYkJjanFDbjBzWkRhREtyVDhOQUxHWUYxUldvKzdud1Bk?=
 =?utf-8?B?QjNUdHVGamw3WjlFbDlqYWJEMTM3cEZNdDlZZzljY2lBbVNKdEZ0ZzNpWXNO?=
 =?utf-8?B?bmZVRmJSR21kdkRFSHJIRmY0NjhyVzd3TWJENFBQWitBa3FUM0p6dTZtMjV6?=
 =?utf-8?B?MGczb1dVWWFiZVA2OHdaN1JKRzVWSlBLaDdDeWJpQnJaU3d4YlNveFZWeU1Q?=
 =?utf-8?B?OUNhbFJvdjd3Y0xTY285SFBWTXBQQmtUeWo1VEh1aHZnaWxDTnJSSG5FKy9I?=
 =?utf-8?B?MDZVYlZVSHdESExPNjV0TzZTa2Z6Mkd2SzZoNDNvM0svbzVKd0YvMmc4NTM2?=
 =?utf-8?B?VnZyTm53eGpZN1NCTWRvVGs5aW1zWXk2NjhvSVBhS3dPSTRwQUFxb2g4Z0FC?=
 =?utf-8?B?dDRVNm1LSHladGRwN1p3RWRReHJWWjUyc2x0M3VTRUJpWHh0UjFIbGxseFpm?=
 =?utf-8?B?cm5GSUVaR24yL1NOeW9jenZtRXhSTVlWUm04UUQ5TzZvNGdTY3hZUWN0eFpY?=
 =?utf-8?B?UDBLenJQWVhNdHYvNSs1Y3FyZGt5TGVIUnVGdnhjcFlRdjZBOUFTdkJUVk1h?=
 =?utf-8?B?alhXMU1VS2FXVXFVbTMxclpRMHZSWTFnS2tFUGJFWG9DQ240elhTSVdaeWpG?=
 =?utf-8?B?TmNacEpaWWFXbzVIR0xUYzRHSnp1MnNMSGZXQ3RFdVF4QjhtVXJrS01HQlAz?=
 =?utf-8?B?dkM2T0tLSXd3RDI1Rzc2MWtTbGk1WWhMZ04zOTBkMHFoVE5CbUF2aXZ2cEFv?=
 =?utf-8?B?L1pOQllqODhUSDlwcXhsOVluWldHdjVDbWF4bFZZakJ4MzYyVTJ0WStnKy9r?=
 =?utf-8?B?bjRSTzNoQ0JINENZMnhWV3FQTHMvL1FPUVBCRldzMlFnbEZ4Zk5jR2dNWGx3?=
 =?utf-8?B?ay8yRWgremhLUGFnUHAxakdzVTltR2MzL21WZ0Y5MGxXZU13WmZlL2hNRGFs?=
 =?utf-8?B?dUd3Qy9aWUpTMTdQZzRucEFZVFB3VXdneS9samwwRVVQdGZkc01KTDVhS0hD?=
 =?utf-8?B?YlZpR3VSL0lDYnhTWU5CSFZqYWI5UnprZkRrZE1DUlp3OGIzVDI1bUIyOFBa?=
 =?utf-8?B?aGtSN2lVM1VZd0ZjaVkxcVVMN0tMZERDTkRGSUx4SkVqU0JINnh6a0FxSHp3?=
 =?utf-8?B?R1RNNEpaS2hPL0M4Skl1QW5FaGtpMXBvRXg2ditKRkZ6TDJOM3hBdTlXV3Rn?=
 =?utf-8?B?M05idzZRYTFaaVk3cjU4SHJlSDhBMlQzTVBOZG5CVERmbUE3bnRDOXVZTjRE?=
 =?utf-8?B?Mlk2enJ1MEN3RUhvWHNWNUVSMnFTaDVicUZWR0lEeVlZK0MvblN5bWFpcWl2?=
 =?utf-8?B?TXo3cllHMVA1bXd0Rm5nUERETEZYdHQ3b0pMc3Z1RUthOEF4aUV5Zm9yaktr?=
 =?utf-8?B?ZmFRS2ZNQ1A5OEcxUFVteUxMZEd5Z2s2Z2kwTVJVNlhmWTV5VElzMUJmTXl1?=
 =?utf-8?B?V20rZ2xxcGdkTEozWW81MU9BMG1xb21sRXlBeFdxSStZcGdSNm1sTVhDWTVo?=
 =?utf-8?Q?d4mw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm5ya2U5NzlJQWpOcmJYVU5Ub3B1S3cxbURta2RBRm9ReENZZzRkWm9xYWQ0?=
 =?utf-8?B?ak5Oc3VxMEZ4NzBrNkFmUUxob29rdStvb0JreEhoTTJ2Z3hkZmRRQnJhcXli?=
 =?utf-8?B?eFFrTldPa3JhYlBwY0VWYmxSL2w0QS9MVGtNekxxK0szdHVadWJHdnJqSmJi?=
 =?utf-8?B?K1ByRGdpSmZSUzJkYUFITEhnUnNkSHZldUdDOTB4emNCYm1hMU9CSDZWZytk?=
 =?utf-8?B?MGlSQ28zMFE0SDh3NEo0dmNjUWNjTE1FUlRxd3N0dzE5RWJnam4xVkhpZ1BW?=
 =?utf-8?B?eGs0MHB2VkN4eUpHcXZMbHNKK1IrS1cxdU9ISHUvazd4L2RQTmM1Q0FvdlFT?=
 =?utf-8?B?TG5MK3lVNjlnUXo0RUp4Qzlpc0Nhb2g0MzBqRWp3RmM3UE8zblMvUUhCZ3Jr?=
 =?utf-8?B?bnRYSzlBKzZtSXkramJkNDcwTHl3MDFDUEJHOE1HRVlpd1JIVGtjOHM0N1Vs?=
 =?utf-8?B?K0xqTDRZUnd5czVvZVJFOWx3a01hcTFPb3RuKzExNTZFZUFkUG12UmhpQW5Y?=
 =?utf-8?B?QldscjI5U1RTb3NqUUNoemVGZjFXSVU0eUh2R1FiSUtlcm9ScnFjc0tGQkFI?=
 =?utf-8?B?Q3VhT0NpckZDK1J3WWE3eSt3Y25zaDY0K1pKenl1SEFrOGNONktLQWs1czhB?=
 =?utf-8?B?UVpldWwydmFIVitBdDRhQ0VUeGRHUy9qaXd1d2hZUGN6cXk3NUhsTmZyQ292?=
 =?utf-8?B?aEgwUG5reFpoQklIaGdPZHZkcTlINlFDTXkvaW9hUHBxZFlWQk1URnAyNFds?=
 =?utf-8?B?RmJrcmk2dWlZYXNQTk9BTWlGdFIzbllkaVREUlUwNzVkU29mK1R0SzQrdHdZ?=
 =?utf-8?B?ZEJKT2o5bFpmWTdzZlhsTHphS24zN3hEeXVNK3ZNTTFGU2MzaVFtYldDWTRI?=
 =?utf-8?B?YWs3TkJyTVFjZ1V4QlhHT1dOa2NUcC9BRnNoZGJ6OTRvMFd2UzN0eUE5azc3?=
 =?utf-8?B?RTE0ckNaYWVFYmU2N1pWTWlTQUZ3OWFOaWNROUNGOFV6MHRGbWM0Wk5yZEY3?=
 =?utf-8?B?aHNyT292Qm9MNFkvWndudUNITEp1Q0JLcW1Ram1sUDlpd1RhYzFsY21oSEtk?=
 =?utf-8?B?eWZaNk1mNDNRUDJiY0lxd2hzTWRLQStBSEZaM1BScTcrbEZxdWs2NDBhWEM4?=
 =?utf-8?B?YkRTdS9UVk9hZUErZXFCa3E0YW9Da3dxVTJTRFVRWXE1SzJpcG0yR2FoZzNQ?=
 =?utf-8?B?bk5lSldza3lSSFl6eXZTWEhLUTJFN3RoQXdMeGk0UGVwZnNleWIrVERpc3JX?=
 =?utf-8?B?aEMwT29vWUt3TnptYWkyWWJGcVViVEtXREhwSm13SVJEamZPc2RoU25yMTNQ?=
 =?utf-8?B?V08wdWpvV2JtVUFPdW05TnUxKzc2emphcjJHdUUvQVl2TDVGeHFVeWM5WHRv?=
 =?utf-8?B?TGF2TVp0NElUYnhWT2xXUmdJcnZoTnAyZmJ1bU4xaWc5QTM2UHhkWXFpSDEx?=
 =?utf-8?B?RU1yU2FBbHo2TzZQWnQ2OXFUZWhwNEdFNDNLelE2S3JXaVJXVGpMKzZnSXEx?=
 =?utf-8?B?bG56UndaRVJqRHR6SVZxU1N5OGE1RTQzdEtib1pPR3BOQ2g1NFEyWmp2YUJx?=
 =?utf-8?B?NzFPS25sL1dYbWVsWVB1YkNZOG41UHlaQzlWaUtERCsybFpLMkZpZzFJMVFK?=
 =?utf-8?B?S0N5SFo1UVp2SHlZTElxMUl4bjNpKy8wV1Q4WVYvN3J6VkFzMGxzS2FWWGdQ?=
 =?utf-8?B?cTlwWGROc1hraGFNWWNoeWtMSDNjQWxpS0tqaUx2eEpYRDkxYkphWE56bUp6?=
 =?utf-8?B?Y3BOdXpVYW82MDVlOC9vdnExV3lqSzJMbjVvbG1nRStGZVVHNlZxdFkxOFV4?=
 =?utf-8?B?YVZCTmRWSGhyZ2VVb3lnR3AxQndwUmlCSCtiN05lNmIzNlJiTjZ5UGZUOUpR?=
 =?utf-8?B?SGIyazFvRTdwQ29Bbm5NVklTWVcwNHR2SGNpeFpsWFd2N2JicWhqeXhzYXI0?=
 =?utf-8?B?cEgyQXh2SFZUeDFjcEFCZEY5L1Y3U1pGZDY5Z3VqWXVFTmtYSHZoSjNLbUow?=
 =?utf-8?B?RDBDRjhycDczemFXS1pwdVdrUjlzc3R3aldVQUdEYzVOZHA5TFByc1JpekN5?=
 =?utf-8?B?VHczbzZoZW1SQitNTmxFVFNJaFJycFlEYmROaXk2NGIzYVBzYzNUbk8rNVJB?=
 =?utf-8?B?d3c4R3EvWUgydHFlNTdOb3VCUGgzb1ZDL2JLSkxwQ2lHQldNTWpteWdUSTdI?=
 =?utf-8?B?K1JJYVh2VHRTc2ZFc2RBQnR5M0tKQUxYeG5tRGxETGl2cTBISDZvcnRCUm1Q?=
 =?utf-8?B?OElwM3VCUVkvdWFyUnc5K2YxSEQ0OVhNTWdNUjlTdjhQa09lUnlTaFpuRHdR?=
 =?utf-8?B?VllWbFdEMTh0eU5ZSC9CSEZVME1xb25ZR0Fsa0wrTGt5K2VoWnpKU0MwZUZ3?=
 =?utf-8?Q?OwcabwSOFTA6BogU=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca320c7-6b85-4a73-02c4-08de6b194017
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:02:12.9823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M32nz4HD+NGdlhMVRd9OyjfLHKr9oDF06BQrehZm1SXlViCrJ0yEaxvt95+CNgvD7LiXi5p9bUZTj0p49KdlwR2yuraNdbR332pYw2AUE9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9811
X-Proofpoint-GUID: UEKvjO_0PZu8RVPnDD-sbuVSeyIEOEZ2
X-Proofpoint-ORIG-GUID: UEKvjO_0PZu8RVPnDD-sbuVSeyIEOEZ2
X-Authority-Analysis: v=2.4 cv=CegFJbrl c=1 sm=1 tr=0 ts=698f4b09 cx=c_pps
 a=pMj1vk9pV3S8wB1vsTRRtw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=Jh6g8D1eammCtCeh7wUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMyBTYWx0ZWRfX35CuzYpcT/f8
 lM1fTIlsoRTTRkwIOTOe+x47+V+yer3wFy1LjwlotoTIzShlllaswfNaxqmn3zVLz4WauSZZF7t
 PtuMIqncwS7NUKOuWFTCnC5AbUdZ8z1JfXZH2brLwc0K03ViYNktBP+os6Si9OgF+rYFO4ijpDv
 xkrWKPpl0/45CmB2ba+xYEEL+pxlfdv1hA6n1b+1EfVUSC35wAaUIkrTVbLAmOmI92KLmVoxICp
 uClW7Zf/KfOFRDmHXZ/RrXonFWnNGCqgeO3i3N5YaGPqyks+HAIMfSzWFQMaJbBTQnKb6hPPaEO
 KES1MQyOp1UuGy+nQCIoNaXh8tINmeVJrz8X4hmBsGvBTT5bjykkALgPc8jr4DH26K9Kmh6sOsr
 URElhbMxUi4QkbLrp4YvmKHGdHnwDWtF4rYGThf49b+T/nUUQzubEvfY09/i6s7s4/rCAGgnmKL
 hgfdBu9i48EPHB3PF9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> audio_bug() is a bit unconventional, it is meant to be used as a
> condition expression, passing the actual condition as second argument
> (and __func__ as first argument).
> 
> If the condition is true, it uses AUD_log() to print to stderr, and has
> some dubious recommendations printed only once.
> 
> This change:
> - clears the control flow, and make the condition directly visible in
>    the 'if' statement.
> - uses standard QEMU error_report()
> - audio_bug() now captures __func__
> - remove the "Save all your work and restart..." once hint
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h       |  2 --
>   audio/audio_template.h  | 38 +++++++++++------------
>   audio/audio-mixeng-be.c | 69 ++++++++++++++++-------------------------
>   3 files changed, 46 insertions(+), 63 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index e0ed6af67ed..20ec7883aab 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -244,8 +244,6 @@ extern const char *audio_prio_list[];
>   void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as);
>   void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
>   
> -int audio_bug (const char *funcname, int cond);
> -
>   void audio_run(AudioMixengBackend *s, const char *msg);
>   
>   typedef struct RateCtl {
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 5711f4a26e1..9dde36738bc 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -64,15 +64,15 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
>                  min_voices);
>       }
>   
> -    if (audio_bug(__func__, !voice_size && max_voices)) {
> -        dolog("drv=`%s' voice_size=0 max_voices=%d\n",
> -               k->name, max_voices);
> +    if (!voice_size && max_voices) {
> +        audio_bug("drv=`%s' voice_size=0 max_voices=%d",
> +                  k->name, max_voices);
>           glue(s->nb_hw_voices_, TYPE) = 0;
>       }
>   
> -    if (audio_bug(__func__, voice_size && !max_voices)) {
> -        dolog("drv=`%s' voice_size=%zu max_voices=0\n",
> -              k->name, voice_size);
> +    if (voice_size && !max_voices) {
> +        audio_bug("drv=`%s' voice_size=%zu max_voices=0",
> +                  k->name, voice_size);
>       }
>   }
>   
> @@ -88,8 +88,8 @@ static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
>   {
>       if (glue(audio_get_pdo_, TYPE)(hw->s->dev)->mixing_engine) {
>           size_t samples = hw->samples;
> -        if (audio_bug(__func__, samples == 0)) {
> -            dolog("Attempted to allocate empty buffer\n");
> +        if (samples == 0) {
> +            audio_bug("Attempted to allocate empty buffer");
>           }
>   
>           HWBUF.buffer = g_new0(st_sample, samples);
> @@ -275,8 +275,8 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>           return NULL;
>       }
>   
> -    if (audio_bug(__func__, !glue(k->init_, TYPE))) {
> -        dolog("No host audio driver or missing init_%s\n", NAME);
> +    if (!glue(k->init_, TYPE)) {
> +        audio_bug("No host audio driver or missing init_%s", NAME);
>           return NULL;
>       }
>   
> @@ -295,8 +295,8 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>           goto err0;
>       }
>   
> -    if (audio_bug(__func__, hw->samples <= 0)) {
> -        dolog("hw->samples=%zd\n", hw->samples);
> +    if (hw->samples <= 0) {
> +        audio_bug("hw->samples=%zd", hw->samples);
>           goto err1;
>       }
>   
> @@ -477,8 +477,8 @@ static void glue (audio_close_, TYPE) (SW *sw)
>   static void glue(audio_mixeng_backend_close_, TYPE)(AudioBackend *be, SW *sw)
>   {
>       if (sw) {
> -        if (audio_bug(__func__, !be)) {
> -            dolog("backend=%p\n", be);
> +        if (!be) {
> +            audio_bug("backend=%p", be);
>               return;
>           }
>   
> @@ -498,9 +498,9 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>       AudioMixengBackendClass *k;
>       AudiodevPerDirectionOptions *pdo;
>   
> -    if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
> -        dolog("backend=%p name=%p callback_fn=%p as=%p\n",
> -              be, name, callback_fn, as);
> +    if (!be || !name || !callback_fn || !as) {
> +        audio_bug("backend=%p name=%p callback_fn=%p as=%p",
> +                  be, name, callback_fn, as);
>           goto fail;
>       }
>   
> @@ -519,8 +519,8 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>           goto fail;
>       }
>   
> -    if (audio_bug(__func__, !glue(k->init_, TYPE))) {
> -        dolog("Can not open `%s' (no host audio driver)\n", name);
> +    if (!glue(k->init_, TYPE)) {
> +        error_report("audio: Can not open `%s' (no host audio driver)", name);
>           goto fail;
>       }
>   
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index e8fae2ab977..4988627279e 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -31,6 +31,8 @@
>   
>   #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
>   
> +#define audio_bug(fmt, ...) error_report("%s: " fmt, __func__, ##__VA_ARGS__)
> +
>   const struct mixeng_volume nominal_volume = {
>       .mute = 0,
>   #ifdef FLOAT_MIXENG
> @@ -42,23 +44,6 @@ const struct mixeng_volume nominal_volume = {
>   #endif
>   };
>   
> -int audio_bug (const char *funcname, int cond)
> -{
> -    if (cond) {
> -        static int shown;
> -
> -        AUD_log (NULL, "A bug was just triggered in %s\n", funcname);
> -        if (!shown) {
> -            shown = 1;
> -            AUD_log (NULL, "Save all your work and restart without audio\n");
> -            AUD_log (NULL, "I am sorry\n");
> -        }
> -        AUD_log (NULL, "Context:\n");
> -    }
> -
> -    return cond;
> -}
> -
>   /*
>    * Convert audio format to mixeng_clip index. Used by audio_pcm_sw_init_ and
>    * audio_mixeng_backend_add_capture()
> @@ -332,8 +317,8 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
>   static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
>   {
>       size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
> -    if (audio_bug(__func__, live > hw->conv_buf.size)) {
> -        dolog("live=%zu hw->conv_buf.size=%zu\n", live, hw->conv_buf.size);
> +    if (live > hw->conv_buf.size) {
> +        audio_bug("live=%zu hw->conv_buf.size=%zu", live, hw->conv_buf.size);
>           return 0;
>       }
>       return live;
> @@ -402,8 +387,8 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t buf_len)
>       if (!live) {
>           return 0;
>       }
> -    if (audio_bug(__func__, live > hw->conv_buf.size)) {
> -        dolog("live_in=%zu hw->conv_buf.size=%zu\n", live, hw->conv_buf.size);
> +    if (live > hw->conv_buf.size) {
> +        audio_bug("live=%zu hw->conv_buf.size=%zu", live, hw->conv_buf.size);
>           return 0;
>       }
>   
> @@ -454,8 +439,8 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
>       if (nb_live1) {
>           size_t live = smin;
>   
> -        if (audio_bug(__func__, live > hw->mix_buf.size)) {
> -            dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> +        if (live > hw->mix_buf.size) {
> +            audio_bug("live=%zu hw->mix_buf.size=%zu", live, hw->mix_buf.size);
>               return 0;
>           }
>           return live;
> @@ -533,8 +518,8 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
>       size_t frames_in_max, frames_out_max, total_in, total_out;
>   
>       live = sw->total_hw_samples_mixed;
> -    if (audio_bug(__func__, live > hw->mix_buf.size)) {
> -        dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> +    if (live > hw->mix_buf.size) {
> +        audio_bug("live=%zu hw->mix_buf.size=%zu", live, hw->mix_buf.size);
>           return 0;
>       }
>   
> @@ -824,9 +809,9 @@ static size_t audio_get_avail(SWVoiceIn *sw)
>       }
>   
>       live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
> -    if (audio_bug(__func__, live > sw->hw->conv_buf.size)) {
> -        dolog("live=%zu sw->hw->conv_buf.size=%zu\n", live,
> -              sw->hw->conv_buf.size);
> +    if (live > sw->hw->conv_buf.size) {
> +        audio_bug("live=%zu sw->hw->conv_buf.size=%zu", live,
> +                  sw->hw->conv_buf.size);
>           return 0;
>       }
>   
> @@ -845,9 +830,9 @@ static size_t audio_get_free(SWVoiceOut *sw)
>   
>       live = sw->total_hw_samples_mixed;
>   
> -    if (audio_bug(__func__, live > sw->hw->mix_buf.size)) {
> -        dolog("live=%zu sw->hw->mix_buf.size=%zu\n", live,
> -              sw->hw->mix_buf.size);
> +    if (live > sw->hw->mix_buf.size) {
> +        audio_bug("live=%zu sw->hw->mix_buf.size=%zu", live,
> +                  sw->hw->mix_buf.size);
>           return 0;
>       }
>   
> @@ -1002,8 +987,8 @@ static void audio_run_out(AudioMixengBackend *s)
>               live = 0;
>           }
>   
> -        if (audio_bug(__func__, live > hw->mix_buf.size)) {
> -            dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> +        if (live > hw->mix_buf.size) {
> +            audio_bug("live=%zu hw->mix_buf.size=%zu", live, hw->mix_buf.size);
>               continue;
>           }
>   
> @@ -1033,9 +1018,9 @@ static void audio_run_out(AudioMixengBackend *s)
>           prev_rpos = hw->mix_buf.pos;
>           played = audio_pcm_hw_run_out(hw, live);
>           replay_audio_out(&played);
> -        if (audio_bug(__func__, hw->mix_buf.pos >= hw->mix_buf.size)) {
> -            dolog("hw->mix_buf.pos=%zu hw->mix_buf.size=%zu played=%zu\n",
> -                  hw->mix_buf.pos, hw->mix_buf.size, played);
> +        if (hw->mix_buf.pos >= hw->mix_buf.size) {
> +            audio_bug("hw->mix_buf.pos=%zu hw->mix_buf.size=%zu played=%zu",
> +                      hw->mix_buf.pos, hw->mix_buf.size, played);
>               hw->mix_buf.pos = 0;
>           }
>   
> @@ -1050,9 +1035,9 @@ static void audio_run_out(AudioMixengBackend *s)
>                   continue;
>               }
>   
> -            if (audio_bug(__func__, played > sw->total_hw_samples_mixed)) {
> -                dolog("played=%zu sw->total_hw_samples_mixed=%zu\n",
> -                      played, sw->total_hw_samples_mixed);
> +            if (played > sw->total_hw_samples_mixed) {
> +                audio_bug("played=%zu sw->total_hw_samples_mixed=%zu",
> +                          played, sw->total_hw_samples_mixed);
>                   played = sw->total_hw_samples_mixed;
>               }
>   
> @@ -1195,9 +1180,9 @@ static void audio_run_capture(AudioMixengBackend *s)
>                   continue;
>               }
>   
> -            if (audio_bug(__func__, captured > sw->total_hw_samples_mixed)) {
> -                dolog("captured=%zu sw->total_hw_samples_mixed=%zu\n",
> -                      captured, sw->total_hw_samples_mixed);
> +            if (captured > sw->total_hw_samples_mixed) {
> +                audio_bug("captured=%zu sw->total_hw_samples_mixed=%zu",
> +                          captured, sw->total_hw_samples_mixed);
>                   captured = sw->total_hw_samples_mixed;
>               }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


