Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E5BC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tqi-000413-7n; Thu, 24 Apr 2025 06:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tqW-0003xf-Gb
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:30:23 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tqQ-0007Az-40
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:30:17 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8mx5T000806;
 Thu, 24 Apr 2025 03:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OvhJ+Ki8yN9xdy+ytveyW+LyDdbE5l8lHTQVD9ao9
 Ow=; b=tAhjpA2Beja/1JsefjLet67m/DEUnT584jqH51TJJY5qjahWxTvSrT5dC
 uIZbfGJ/CU87B0O/nrGcu7op5cbp9WeHxBzEcHEvrJ9tyVlQr7C7/LYfOeFywITi
 kuanigxlwDS+44hihLGfUHK9DAHq/pi9UMGaFEIEwgLrwWx8TqJcXyHDlt2ABj+W
 VmKDBrfdXtt4sqQbDdqywm6Q19+/r11Rb9hncvB5hXw1lQS/Sda546bjSY1/lyYe
 ZukwVRaLsyXc/+T4SqNEB1OxlGL1K3NvDC76wVbKyf9CxMTs9gp0lgwenOH29xj4
 7GUhBB+xcQ87xLzlyamTzRa9EG8tA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012010.outbound.protection.outlook.com
 [40.93.14.10])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhtvb4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tnvd68qXDUjrzA20LpnNWvPGUE+Eh9NtNfDGRrhPM9oRa5F+lwI8mE4qAtnQzoCX8eaFEaFb5i1bRly1y+ACCkhOOZukHnkJpwdqEoEypKm7Li7FHzkYSlxLuYIEKZ5pTB/pL3nQSlQm5VNq6dusk2TEaPHr4b5Ji5jqT6N5gnhKv/crxjgO4BAspK+UnWN3A0PSV9I/zA242MY552mVW+7BLHEPBfGYBU9K/VB+lwXR5nPi89RGhlfkjmppba78z/Pc/3x0/C4C9pFqcxvVKyZtp96zj2pgpqs/Uin3YdzWCDaI9elUlGYDbXbrTtRV1HwZxKcPUr0pmDvlsoksZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvhJ+Ki8yN9xdy+ytveyW+LyDdbE5l8lHTQVD9ao9Ow=;
 b=FEhmvdTQLaZn8TFbWXcUY5RCxUEbFnBbIG36ejrrlA0ADSie0Xi2oXKrPSYD58ZALih/9o6BDhWGSZzCR319T8DvqZj+30q5c+M7tyHlLyd4IGdvEzAKUynXW/5V9IuYtHK4wb0uwLqKyzV4xneTZi77ZmziJQazHhAjqYohiDUKr94ksdIcriMgeVoqLN02jQGBRfGiZySR8+mKNzhbKRWeZPzFYiQawIHrR9dS/oaegfTtF+eNLWMhxYIMgHUvwhgmy3zcA3Y+/PFwUxwcVlvXbc2pAyEF+z1X6SMBYgD/GPZ0Xr7MkzsNB2d0RUeUBaCge9n3d8Dx53rfjZlKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvhJ+Ki8yN9xdy+ytveyW+LyDdbE5l8lHTQVD9ao9Ow=;
 b=I05v6ltAi1X9wcjKmYxAeQkbvLdq2a+NyzUXFtMM+RKF9aISA8yOg0fqm52sifv9U3g+nEsJ/YYSkOh+Q+hszghCOjcNAUrUBhSO6NDSpmqZowpmlLrjVeXT9PgMZmTjedX019N8gI5qES2Q3sBp2uGztnIiucOVZ51dqQPh9O7AGsIBsuJZ1LPxKQiBDWkESzp9NlnjUgLdUMXdITWsjSZFs3grs2tjmKOPesgfAI89h+PEo83yoGoBPeuj8aDGIAlKO+we1msgmW+y8ioU3IMmrG3j2Uapu0CEV4ShgbmqOlDvUzdU24+sR+aLj1uXD6kYQVRrQ2oCz1gxJkrWTQ==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA1PR02MB8366.namprd02.prod.outlook.com (2603:10b6:806:1f1::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.8; Thu, 24 Apr 2025 10:30:08 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:30:07 +0000
Message-ID: <403a6217-7be9-4adb-8552-2704c7dc2c9a@nutanix.com>
Date: Thu, 24 Apr 2025 11:30:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] accel/tcg: Extract probe API out of
 'exec/exec-all.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-13-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0098.eurprd03.prod.outlook.com
 (2603:10a6:208:69::39) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA1PR02MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: b050a0d1-eb19-49cb-461c-08dd831afbef
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2hFeHBUQklzRGEybndLcHFBS1VyczR0SzBtSmVHSDRrTFRpTnp2WEw3RXFy?=
 =?utf-8?B?RWFBQ3paejJBMkN2ckN4cjQ3aVgvclV3b2MrL2FqYkIzZUtMVGlhTjltSUxG?=
 =?utf-8?B?RE5Kd1VTNjltaXlIQjQySUlXbGQ0bll4M0tXbzR6MGlTZklYeXh0RENXMGZ3?=
 =?utf-8?B?K29idkRCMW1wdytyUElPbm5SR0lxR2ViK1RrZmpxV2ZBUkxxOXFxcVBlbExF?=
 =?utf-8?B?bUpQL0tPZHMzL2JJQmVlTy8xam5xRytKeGloZUExSGVKTlBvYVdzcWVnaG1p?=
 =?utf-8?B?ckY5ek5oV2xJOEZEYWRXMzVrQTlmeG8ySTNwcTZEaFhHVzFkRmFXWC9RR2sw?=
 =?utf-8?B?OGJPeEtBbEJheXhWVndMTSt5U245MlhSOVV3R2hpYWVnN3p2M1pFQW9IQWls?=
 =?utf-8?B?cUVja3I0ZDZmYmc1T2FaVTh3cUxQRm0zcVU5ZXc1Tm1rcEdXV0lsekY4Z1Vt?=
 =?utf-8?B?ODhENzdaaGJHNjFnVVZVV3RxQUVkMjFaeHVaSFRhdE4xbGFOZnFabzhGMnhq?=
 =?utf-8?B?RE9sS01IZ3UySHp4WFVyNnM3eklMc3Z3ZFM4Y0M4R3o1SGlMZWNmV3hURHRU?=
 =?utf-8?B?NTF5RnZ6aVpIeWFoTGdobUxGUko5ZDMwNlRrOW1tR3JGaGdZb2N3aVZzaFJE?=
 =?utf-8?B?T3JYRml1MWt4TGd5Q2lGU0VLME5iVTl6elhUQldvNkFLc20yT3B4QWx0MWRJ?=
 =?utf-8?B?ZHBvMUhrQmw1a3AwUktLc2tibVZjeTR3a0hMdEVmVVNPMXpzVGhsU0FVcW4r?=
 =?utf-8?B?V2RQT1NFSDc5OGZpQjRGWDExR0NTRmcxOU1UTjhEQ2xHQkExdWZHRkVMb3VH?=
 =?utf-8?B?UWwwU1psbmxBTzNXR2J2K2IxUnBJQmZLemZMV0l4ZktzazlLSEFlM09OV0ht?=
 =?utf-8?B?SFdiRE5ITngwUnVhaWEvRDBYZkkrc1VMa1NKYnZ6Y1VrVStlM2c3YWpCSzZE?=
 =?utf-8?B?QnZxN2FCODE5QThpTGcrWGlMREFodWlISnNlWG95dDRuU3pJcDNIM00zRVZR?=
 =?utf-8?B?S3NGVmFPMnExclhsVFc3aUNubEI5TFp2SlVYOCsvejZQWEFJVWZxb0srd2Zh?=
 =?utf-8?B?cHFXV0VXYWplTDhOYVY1QTFVRC9iNHYxTGVZYkJPL2hpaXZMa1VwSDNjckRE?=
 =?utf-8?B?Y25ueTFpS2VUZ3lVem1ybE5MUjVBcG9XYXhDQlIwem53SzNIbGRMQnBXVStJ?=
 =?utf-8?B?bGQxWXZoTFJsOFd3V2RvZTVUMHFlZnBzMVpZMXZHR2kwRTdNSkg0SDc2OVlR?=
 =?utf-8?B?VTFzeXF3WHBHbHVrdkZRN01qZTZRNE4wRVJpMGtSWkRVeFc3SVNzV3JCMVI4?=
 =?utf-8?B?a0k3bUJTQWVvdS8rdTZmdGVFZUY0UmhaRFMrRTFBS3pORGltL002YTM5eHh3?=
 =?utf-8?B?V3FnUllGNDkvWkxVV3RVdVBZMC9tK0swbndUeHl2NDRsdTB6Zk9PdjNPN3Ni?=
 =?utf-8?B?OXhGVDgzNUw3SHR3M0hPdnkvQzhQSkpTZFZUenNmUkh4Z3oydjJMMDZOV3By?=
 =?utf-8?B?YTdCdzErSW9JWmpPVkpSc2pIa3dmTisyVG96RWpCVnBSZWZqM2FrUUtOTDNi?=
 =?utf-8?B?Q0pUUkNBbk9oK3hydXFoUUdLUk5OV2tVdEFUWEhudU9WdGFNZTNOOVE5TUlY?=
 =?utf-8?B?TXNxSnRZSDU4QmNHejErWmNoMjV2Y3BnUEdHK0J5Y1FLcVd2bXhKSndFUDZF?=
 =?utf-8?B?UWZPLzJOakJuSVUrZ01zN3JmY3VDbVYvc3NibjhFNGQrVEJQRll0cUFsWVlo?=
 =?utf-8?B?SHFTQ2tnS3pvRE9uaFo3YzRQWnhxQmp6N3lzSHB5a0N0d1BoRDRab1FOYW9z?=
 =?utf-8?B?cS9zWGFXbDd4REpnUnZMNzZCUVozTDAwN21mZWU2WitqL004dDBBQmhqQXB5?=
 =?utf-8?B?dm1adE5UT1NDSkhPT0xycnhqWERZRnpGbUJWSlA4VzFNcXlIdmxGbk5LU0ky?=
 =?utf-8?Q?AR9dLyXMzmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXcrV2IzR2JPMXM1TDluUUNLNW5ITlJvL2pWcUQrblZicGtyK2gyMGpPd2pu?=
 =?utf-8?B?VlU3V2VKVitLRC9tMDljdUVoUDZreTk5TDFpYzJ3QUU1VVNDelpLalFYajE0?=
 =?utf-8?B?U3pPQ3d4MlJ0SmIzZDRxdXIyUTFMa1hxUUpsZ2V2aUN2L3IxalpXd3FyWHF0?=
 =?utf-8?B?M0NGNUFuK1h6VERzQjU1aHBISTRnOFhOVGdGa0RkZTJVdGNZNmlXb3lYcHNk?=
 =?utf-8?B?UXNWaXB3U3NWSHZLTXNsNVJ5djVsamI4WW1KK3JxMDIwaHdmT24zY0ZpWFE0?=
 =?utf-8?B?VCs3UUhyY0crNTVUaEt3c09DZXYzWklkZlF5ckxuM0l0enNGYnZtc2luZFh0?=
 =?utf-8?B?VXZiZ1kzSlRURHVQNEFCOFJjVndtM2tTdDZMYllyTkRwc1dWWGpNZ21KVGda?=
 =?utf-8?B?dWovVkFJYkpwK3JHcHVqNDZ4UzBLWjVnYlRhcmZSL3Z6R2tGeXhlREJoZm5n?=
 =?utf-8?B?Q21FRmdzWnk2M29NZytDNS84NTFLajZzTjJLWXJVaHBDTDlETE9HRjhSWVEx?=
 =?utf-8?B?b3UreFFMeHNscW1aQU8xa3hGR0FsVlYwNFdNU2Q4cmt6L3hLS3dUbHpHWDl0?=
 =?utf-8?B?cFhtQnJVNmFRalhvc0U3eVpkbHVndjNwOWFSNld5TkRpWjFnb2xrVjRjMkdB?=
 =?utf-8?B?eEJHWm1uUGFPWkNTYmhCSHVNUDc4NHh3WDA0VTlyUWdDbEM3SEsrQmFPT0N1?=
 =?utf-8?B?aXEvRDZJV3ZZbXgvOWk0OW9hR0pZNzJXNE96d1BBR2w2S0dpeUwwNDQ4T01T?=
 =?utf-8?B?WGpmWGtYd3B0bWNtNmdzTk9oR0o0QTJzOXA3QkJpTXFUNVo1K29lT0VabElU?=
 =?utf-8?B?T0tvMkhVT3NUdlpTR1ZlZDFMT0lWU1gvRFU5WGNKM0dKS2xMTDN5MUtvcTU3?=
 =?utf-8?B?d0pkbVE1MGhBMkowR3BxckczdjZSN1pCUUlncjZMKzlON3g0Q1NoRC91SUR2?=
 =?utf-8?B?Y2QyYzZtZEo5SUJCdzVKVEgwNlJWNE1hMlByWEl6V1kvdVJpQ041YnV6cDFF?=
 =?utf-8?B?NTlzZ0hNT1NPOHNSQWs3MUhJbEhBR3g0YTErYklXaXNOME9qM1VmTW03UStw?=
 =?utf-8?B?dEl0aVpURDlBOFEwZURYS0xpampMUzFEVU8zUlZtaGc0SWF2UmV3eHM5TlFB?=
 =?utf-8?B?TjNqblJMdGhYWUZSV3I3KzFNL2NDU04zcDJoc2c0QzY2WmJ5dTZIY015VHdi?=
 =?utf-8?B?Y1pjWGFVWEdpdTZBZ2QxdWRJbGp4VVpJQzVTT2N6K1VIeVZ6NkhTazdFY1FK?=
 =?utf-8?B?ekJET0VVc2tXUjI5a1JLTk9XaW4zblUrRmoveUl6Q2RuNnFkdSsxU3VCWHcr?=
 =?utf-8?B?ZkthaFY0SXR3ZWFlcUR5b0tpTWpEa0xDZ2o5K2hhMlRIbTlpQ3pMcmJqWWdm?=
 =?utf-8?B?cS9wWDlNWWQ3SDlraElPajRuUVMrYjNhaDlEcEErMWE3QTBnMFVJREpUOXRl?=
 =?utf-8?B?QTJYd0dPWnh2QkxwYkxRVFhBdU4ySE8ycUFpSHVuRjBFZ0pheVNnVlJBdjAz?=
 =?utf-8?B?VEZWTFNENEQ2NHh2dHo5TjFEcW5POThSUXNVUjBzUEkvNzR3NnhYS1UyaDlC?=
 =?utf-8?B?WE9xclczdFZsTnlxaHJUM1VGcHdpazJSL080R0lVNFB2QU0rVkhGQTFMb0Fk?=
 =?utf-8?B?UmdGcnNnRE5WOEM1NWVTUkFKcDRqRTcxYk0xWklYMjI1aGJldFBOdnN5ZVRm?=
 =?utf-8?B?Z0tabm5mSUpCUFdOZ2Z0dm1OZXNqNHBRTS9KYlFkSjJhT25UemFCa2RRQTFk?=
 =?utf-8?B?NlVLMnJFVk5kQklCMFJYSjFrNytuMGYwc2IxeXhrMXRNQWdDSGFSd3dadndD?=
 =?utf-8?B?aUZvWWtJVllvdGE1NU01azV2RFc4SEJBL1hJdmgwTnlxaVRvRGx0aU5IeFBD?=
 =?utf-8?B?NmMzMXYwR1lPc1cvYVV5ZjQyODROZ2lwTE1FNTFmYlVhZVkzc2ZrMnVBcU91?=
 =?utf-8?B?UkF2L1RkTGVxTzlUTFRjTEhUckJWSFRzMk5jcXJIQVBzZmFPUFdHa3JhbEx6?=
 =?utf-8?B?QlpyMDNvMC9EQ29aN0loRXVKbnJUNTNFWXQ2WUpmbmM3NDN3WThXelhjbGdY?=
 =?utf-8?B?VUdJUEE3NFNFbVNiMVB0WUd1TlJ5QXNSMC91c1FpMmVZN1hyVnk3QUtoSXJY?=
 =?utf-8?B?aEhyQzJvOTVFVElKVEgwVjVWSXdEUEV6WGRka2FtM0l3M25GSjlqakdJYUZ5?=
 =?utf-8?B?OWhxUnpBank4YzhTTmZPMlVKUUJMYlQ2WTRXMW9WMTB4WGlJZk16aEFxVUJK?=
 =?utf-8?B?YzlWcEkxTDBYaFhqSGJMSC9maHJRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b050a0d1-eb19-49cb-461c-08dd831afbef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:30:07.6882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmeyDtqXgGeEhIBa7OAht1ey0KBHWr7ld5d/WcwcDOG3HZEN8xmbo+5SwKPsgey3gnwaz3tnZgz3kL5VO36hPJkZ32PmqzwcQNQH5DhlRPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8366
X-Proofpoint-ORIG-GUID: 0oQjBB625jk17lCepoOmKmqt_KGZ8ve9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2OSBTYWx0ZWRfX1JwXzTHH6e4v
 r6GNF+SLuX7wxSSQhR3doRXFKFEUvZVhajUY7vPDN7BGZ7n/wZQoRAyXhEp5CJDrOm5jWKw/Neb
 jo5hAEmoBiPpMudo/405TjW+dFfp/AbY5mma8vfJwsDtIhf2VWkCQGY6XJ8LOZLjBrYEv95GEYM
 5LRosi3Jn0yxR1KonBgiBfjwznhXUMOVLBCimP0iiOZI53qJ+JV+XiIVeXcxEycpudDsthzRLaW
 7cv8Oo9kh6VyQyP9vKnkpEEVSt3RdZY6p8S5CynC0YQwrzrI/y0Fqhpbgmz/UvdNS1TYtH3sH9c
 4kxyOvjOoQk/fZIYKA2DY6sd4auTlW2Ni6H+/robqCfS/SEUyJL/CmUGSXqMLTrlaat/AcKBFE/
 YXw0e+6swJFR4vZNX7bUkWpfSQsFC5NtzL64VdBdmufD73wG65+o4T1sAdAHA87V/z+ILZFw
X-Authority-Analysis: v=2.4 cv=KLlaDEFo c=1 sm=1 tr=0 ts=680a12b1 cx=c_pps
 a=5L1ZokDb34JZJib1CqSWiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=nRMyocbY28m5gkkUYQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0oQjBB625jk17lCepoOmKmqt_KGZ8ve9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:

> Declare probe methods in "accel/tcg/probe.h" to emphasize
> they are specific to TCG accelerator.
> 
> target/arm/ptw.c is the only non-TCG specific file, its
> call to the probe API is already guarded within CONFIG_TCG
> checks.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/accel/tcg/probe.h            | 110 +++++++++++++++++++++++++++
>   include/exec/exec-all.h              | 100 ------------------------
>   target/hexagon/mmvec/macros.h        |   1 +
>   accel/tcg/cputlb.c                   |   1 +
>   accel/tcg/user-exec.c                |   1 +
>   semihosting/uaccess.c                |   1 +
>   target/arm/helper.c                  |   1 +
>   target/arm/ptw.c                     |   3 +
>   target/arm/tcg/helper-a64.c          |   1 +
>   target/arm/tcg/mte_helper.c          |   1 +
>   target/arm/tcg/op_helper.c           |   1 +
>   target/arm/tcg/sve_helper.c          |   1 +
>   target/hexagon/op_helper.c           |   1 +
>   target/hppa/mem_helper.c             |   1 +
>   target/hppa/op_helper.c              |   1 +
>   target/i386/tcg/access.c             |   1 +
>   target/i386/tcg/seg_helper.c         |   1 +
>   target/i386/tcg/system/excp_helper.c |   1 +
>   target/mips/tcg/msa_helper.c         |   1 +
>   target/ppc/mem_helper.c              |   1 +
>   target/riscv/op_helper.c             |   1 +
>   target/riscv/vector_helper.c         |   1 +
>   target/s390x/tcg/mem_helper.c        |   1 +
>   target/xtensa/mmu_helper.c           |   1 +
>   24 files changed, 134 insertions(+), 100 deletions(-)
>   create mode 100644 include/accel/tcg/probe.h
> 
> diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
> new file mode 100644
> index 00000000000..b748c00ba96
> --- /dev/null
> +++ b/include/accel/tcg/probe.h
> @@ -0,0 +1,110 @@
> +/*
> + * Probe guest virtual addresses for access permissions.
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +#ifndef ACCEL_TCG_PROBE_H
> +#define ACCEL_TCG_PROBE_H
> +
> +#ifndef CONFIG_TCG
> +#error Can only include this header with TCG
> +#endif
> +
> +#include "exec/mmu-access-type.h"
> +#include "exec/vaddr.h"
> +
> +/**
> + * probe_access:
> + * @env: CPUArchState
> + * @addr: guest virtual address to look up
> + * @size: size of the access
> + * @access_type: read, write or execute permission
> + * @mmu_idx: MMU index to use for lookup
> + * @retaddr: return address for unwinding
> + *
> + * Look up the guest virtual address @addr.  Raise an exception if the
> + * page does not satisfy @access_type.  Raise an exception if the
> + * access (@addr, @size) hits a watchpoint.  For writes, mark a clean
> + * page as dirty.
> + *
> + * Finally, return the host address for a page that is backed by RAM,
> + * or NULL if the page requires I/O.
> + */
> +void *probe_access(CPUArchState *env, vaddr addr, int size,
> +                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
> +
> +static inline void *probe_write(CPUArchState *env, vaddr addr, int size,
> +                                int mmu_idx, uintptr_t retaddr)
> +{
> +    return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
> +}
> +
> +static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
> +                               int mmu_idx, uintptr_t retaddr)
> +{
> +    return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> +}
> +
> +/**
> + * probe_access_flags:
> + * @env: CPUArchState
> + * @addr: guest virtual address to look up
> + * @size: size of the access
> + * @access_type: read, write or execute permission
> + * @mmu_idx: MMU index to use for lookup
> + * @nonfault: suppress the fault
> + * @phost: return value for host address
> + * @retaddr: return address for unwinding
> + *
> + * Similar to probe_access, loosely returning the TLB_FLAGS_MASK for
> + * the page, and storing the host address for RAM in @phost.
> + *
> + * If @nonfault is set, do not raise an exception but return TLB_INVALID_MASK.
> + * Do not handle watchpoints, but include TLB_WATCHPOINT in the returned flags.
> + * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
> + * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
> + */
> +int probe_access_flags(CPUArchState *env, vaddr addr, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool nonfault, void **phost, uintptr_t retaddr);
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +/**
> + * probe_access_full:
> + * Like probe_access_flags, except also return into @pfull.
> + *
> + * The CPUTLBEntryFull structure returned via @pfull is transient
> + * and must be consumed or copied immediately, before any further
> + * access or changes to TLB @mmu_idx.
> + *
> + * This function will not fault if @nonfault is set, but will
> + * return TLB_INVALID_MASK if the page is not mapped, or is not
> + * accessible with @access_type.
> + *
> + * This function will return TLB_MMIO in order to force the access
> + * to be handled out-of-line if plugins wish to instrument the access.
> + */
> +int probe_access_full(CPUArchState *env, vaddr addr, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool nonfault, void **phost,
> +                      CPUTLBEntryFull **pfull, uintptr_t retaddr);
> +
> +/**
> + * probe_access_full_mmu:
> + * Like probe_access_full, except:
> + *
> + * This function is intended to be used for page table accesses by
> + * the target mmu itself.  Since such page walking happens while
> + * handling another potential mmu fault, this function never raises
> + * exceptions (akin to @nonfault true for probe_access_full).
> + * Likewise this function does not trigger plugin instrumentation.
> + */
> +int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
> +                          MMUAccessType access_type, int mmu_idx,
> +                          void **phost, CPUTLBEntryFull **pfull);
> +
> +#endif /* !CONFIG_USER_ONLY */
> +
> +#endif
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index b9eb9bc4b63..9ef7569a0b8 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -20,104 +20,4 @@
>   #ifndef EXEC_ALL_H
>   #define EXEC_ALL_H
>   
> -#include "exec/hwaddr.h"
> -#include "exec/mmu-access-type.h"
> -#include "exec/vaddr.h"
> -
> -#if defined(CONFIG_TCG)
> -
> -/**
> - * probe_access:
> - * @env: CPUArchState
> - * @addr: guest virtual address to look up
> - * @size: size of the access
> - * @access_type: read, write or execute permission
> - * @mmu_idx: MMU index to use for lookup
> - * @retaddr: return address for unwinding
> - *
> - * Look up the guest virtual address @addr.  Raise an exception if the
> - * page does not satisfy @access_type.  Raise an exception if the
> - * access (@addr, @size) hits a watchpoint.  For writes, mark a clean
> - * page as dirty.
> - *
> - * Finally, return the host address for a page that is backed by RAM,
> - * or NULL if the page requires I/O.
> - */
> -void *probe_access(CPUArchState *env, vaddr addr, int size,
> -                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
> -
> -static inline void *probe_write(CPUArchState *env, vaddr addr, int size,
> -                                int mmu_idx, uintptr_t retaddr)
> -{
> -    return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
> -}
> -
> -static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
> -                               int mmu_idx, uintptr_t retaddr)
> -{
> -    return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> -}
> -
> -/**
> - * probe_access_flags:
> - * @env: CPUArchState
> - * @addr: guest virtual address to look up
> - * @size: size of the access
> - * @access_type: read, write or execute permission
> - * @mmu_idx: MMU index to use for lookup
> - * @nonfault: suppress the fault
> - * @phost: return value for host address
> - * @retaddr: return address for unwinding
> - *
> - * Similar to probe_access, loosely returning the TLB_FLAGS_MASK for
> - * the page, and storing the host address for RAM in @phost.
> - *
> - * If @nonfault is set, do not raise an exception but return TLB_INVALID_MASK.
> - * Do not handle watchpoints, but include TLB_WATCHPOINT in the returned flags.
> - * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
> - * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
> - */
> -int probe_access_flags(CPUArchState *env, vaddr addr, int size,
> -                       MMUAccessType access_type, int mmu_idx,
> -                       bool nonfault, void **phost, uintptr_t retaddr);
> -
> -#ifndef CONFIG_USER_ONLY
> -
> -/**
> - * probe_access_full:
> - * Like probe_access_flags, except also return into @pfull.
> - *
> - * The CPUTLBEntryFull structure returned via @pfull is transient
> - * and must be consumed or copied immediately, before any further
> - * access or changes to TLB @mmu_idx.
> - *
> - * This function will not fault if @nonfault is set, but will
> - * return TLB_INVALID_MASK if the page is not mapped, or is not
> - * accessible with @access_type.
> - *
> - * This function will return TLB_MMIO in order to force the access
> - * to be handled out-of-line if plugins wish to instrument the access.
> - */
> -int probe_access_full(CPUArchState *env, vaddr addr, int size,
> -                      MMUAccessType access_type, int mmu_idx,
> -                      bool nonfault, void **phost,
> -                      CPUTLBEntryFull **pfull, uintptr_t retaddr);
> -
> -/**
> - * probe_access_full_mmu:
> - * Like probe_access_full, except:
> - *
> - * This function is intended to be used for page table accesses by
> - * the target mmu itself.  Since such page walking happens while
> - * handling another potential mmu fault, this function never raises
> - * exceptions (akin to @nonfault true for probe_access_full).
> - * Likewise this function does not trigger plugin instrumentation.
> - */
> -int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
> -                          MMUAccessType access_type, int mmu_idx,
> -                          void **phost, CPUTLBEntryFull **pfull);
> -
> -#endif /* !CONFIG_USER_ONLY */
> -#endif /* CONFIG_TCG */
> -
>   #endif
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index c1a88392c05..c7840fbf2e1 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -22,6 +22,7 @@
>   #include "arch.h"
>   #include "mmvec/system_ext_mmvec.h"
>   #include "accel/tcg/getpc.h"
> +#include "accel/tcg/probe.h"
>   
>   #ifndef QEMU_GENERATE
>   #define VdV      (*(MMVector *restrict)(VdV_void))
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d11989f5674..b346af942a0 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -21,6 +21,7 @@
>   #include "qemu/main-loop.h"
>   #include "accel/tcg/cpu-ops.h"
>   #include "accel/tcg/iommu.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "system/memory.h"
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 43d005e24e4..697fdf18241 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -27,6 +27,7 @@
>   #include "qemu/bitops.h"
>   #include "qemu/rcu.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "user/cpu_loop.h"
>   #include "qemu/main-loop.h"
>   #include "user/page-protection.h"
> diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> index 81ffecaaba4..ebbb300f86a 100644
> --- a/semihosting/uaccess.c
> +++ b/semihosting/uaccess.c
> @@ -9,6 +9,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "accel/tcg/cpu-mmu-index.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "exec/tlb-flags.h"
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c6fd2900126..2f039b2db33 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -30,6 +30,7 @@
>   #include "qapi/error.h"
>   #include "qemu/guest-random.h"
>   #ifdef CONFIG_TCG
> +#include "accel/tcg/probe.h"
>   #include "semihosting/common-semi.h"
>   #endif
>   #include "cpregs.h"
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index e0e82ae507f..58f1cd0b34c 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -14,6 +14,9 @@
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "exec/tlb-flags.h"
> +#ifdef CONFIG_TCG
> +#include "accel/tcg/probe.h"
> +#endif
>   #include "cpu.h"
>   #include "internals.h"
>   #include "cpu-features.h"
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 08d8f63ffea..ac86629432a 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -31,6 +31,7 @@
>   #include "exec/cpu-common.h"
>   #include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/target_page.h"
>   #include "exec/tlb-flags.h"
>   #include "qemu/int128.h"
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 7dc5fb776b3..8fbdcc8fb95 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -30,6 +30,7 @@
>   #include "system/ram_addr.h"
>   #endif
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/helper-proto.h"
>   #include "exec/tlb-flags.h"
>   #include "accel/tcg/cpu-ops.h"
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 38d49cbb9d8..d50b8720ad6 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -25,6 +25,7 @@
>   #include "cpu-features.h"
>   #include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "cpregs.h"
>   
>   #define SIGNBIT (uint32_t)0x80000000
> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
> index 87b6b4b3e64..50aca54eaa3 100644
> --- a/target/arm/tcg/sve_helper.c
> +++ b/target/arm/tcg/sve_helper.c
> @@ -32,6 +32,7 @@
>   #include "sve_ldst_internal.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/cpu-ops.h"
> +#include "accel/tcg/probe.h"
>   #ifdef CONFIG_USER_ONLY
>   #include "user/page-protection.h"
>   #endif
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 3f3d86db2b2..dd726b43187 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -19,6 +19,7 @@
>   #include "qemu/log.h"
>   #include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   #include "cpu.h"
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 554d7bf4d14..a5f73aedf82 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -23,6 +23,7 @@
>   #include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "accel/tcg/cpu-mmu-index.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index 2398ce2c648..32207c1a4c8 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -23,6 +23,7 @@
>   #include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "qemu/timer.h"
>   #include "trace.h"
>   #ifdef CONFIG_USER_ONLY
> diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
> index 0fdd587eddf..ee5b4514597 100644
> --- a/target/i386/tcg/access.c
> +++ b/target/i386/tcg/access.c
> @@ -4,6 +4,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "access.h"
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 3af902e0ec5..e45d71fa1ad 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -24,6 +24,7 @@
>   #include "exec/helper-proto.h"
>   #include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/log.h"
>   #include "helper-tcg.h"
>   #include "seg_helper.h"
> diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
> index 93614aa3e54..c1626215877 100644
> --- a/target/i386/tcg/system/excp_helper.c
> +++ b/target/i386/tcg/system/excp_helper.c
> @@ -20,6 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/cputlb.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
> diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
> index 14de4a71ff6..4d9a4468e53 100644
> --- a/target/mips/tcg/msa_helper.c
> +++ b/target/mips/tcg/msa_helper.c
> @@ -23,6 +23,7 @@
>   #include "tcg/tcg.h"
>   #include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/helper-proto.h"
>   #include "exec/memop.h"
>   #include "exec/target_page.h"
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index d7e8d678f4b..50f05a915ed 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -25,6 +25,7 @@
>   #include "exec/helper-proto.h"
>   #include "helper_regs.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "internal.h"
>   #include "qemu/atomic128.h"
>   
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 5b0db2c45ab..abb1d284dce 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -24,6 +24,7 @@
>   #include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/helper-proto.h"
>   #include "exec/tlb-flags.h"
>   #include "trace.h"
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index b8ae7044578..5ccb294e319 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -23,6 +23,7 @@
>   #include "exec/memop.h"
>   #include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/page-protection.h"
>   #include "exec/helper-proto.h"
>   #include "exec/tlb-flags.h"
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 0cdfd380ce4..9e77cde81bd 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -29,6 +29,7 @@
>   #include "exec/cputlb.h"
>   #include "exec/page-protection.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/target_page.h"
>   #include "exec/tlb-flags.h"
>   #include "accel/tcg/cpu-ops.h"
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index a7dd8100555..182c6e35c17 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -34,6 +34,7 @@
>   #include "qemu/host-utils.h"
>   #include "exec/cputlb.h"
>   #include "accel/tcg/cpu-mmu-index.h"
> +#include "accel/tcg/probe.h"
>   #include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"

Moving the functions out of exec/exec-all.h feels like the right thing 
to do here, although I do wonder once the dust has settled from the 
single binary work if this is something else that should be consolidated 
into an existing TCG header? Anyhow:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


