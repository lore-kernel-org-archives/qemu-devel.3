Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12C3C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 08:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmDU-0004mA-5U; Fri, 02 May 2025 04:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmDP-0004lr-V2
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:57:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmDL-0004Q0-W9
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:57:51 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KbFej025072;
 Fri, 2 May 2025 01:57:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iH+CcxJ9j/GusYM4bicza2ELo3cBa0fOpTWYByy5f
 ZE=; b=zweNl7iHkzyYK4iy/XGHclFJmmSBtRHAnVT5CcxJNSL0wakKovNQmskDE
 kD8d4lulssbe5gqGWo6b5dvqc1o8aWTU2tudjCSgOvddpS/w3C9nbQOXHMWZbdv8
 +PvT5zHL6GPEEYRKf5BjQl0ylJoIk+uUNKJEWjLC9Mxdy2li1JnhJLl+aesdtCbR
 7za7kiDqHBQGqGTO4qKtMHYWIlKwfwFaIuotqmmvtTbkJc8gJMXBt3dKSMc0u6be
 0xrzupRt30NiJ/WpQAD9sWY/n8zZCvnx6HX8CD/5G8TYA8AMxpUuHcKQKazG2CLG
 x/faGfM6ShM/btitwiFJeadcTttGA==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46b4m1pq3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 01:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FS8XdwEOWE1iO0vZ7NcmmKIBBpheS+7OlCErdwl//19Qbhq+pVfISMLFBtALptDjGDYSNf9nekzrrMWHAF7YA6gFVlUe7wTkl9GuIURogSW2Xq5Uu+U2fV8JXjKU9t2kaWGVjNbqXGz0F3A+Pwi07kDKvg+npza6QHyq9wE/68W5NXiTQ6ZglKWXrmBUTSPZ5ZYMSMrKy9kVeXLI6GtxcKFXRS7HqSNYTBMNEWy8+EWPYMVQA31NHVLCGVB1aidTqKL/vnNOOKvwVmGyehnscezDQwOBWsQe4bfQcwubi5YZlMbfwTU3KN4gpI6vcGHsGcJAZY0jqAh2SyVDabJ2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH+CcxJ9j/GusYM4bicza2ELo3cBa0fOpTWYByy5fZE=;
 b=tKI2+bU015IpaCi/IysDhBrEaEvnwABOtwwENlPLm1X5CxCkyQYgWZtvDTR2APsh9576OSycCNLZPZW0cekGqivOEGUTW5NINz550tsJ41WcXCQw8qE0toiVUbnkBHlvgqHjDcO38bu7xvCjsr0qbjvcVDo1ttAREnycfNb9ykCQQ3rd76v4JfbHywzevH1oSqOdap0Gsfj42oRyYXFt9EiD8HXBlR9+qWa29TXzTkZOnbKtdHdnNQ0XrplYDbai23OGnlEL6I33Bbll2DQETkiOFTbKfTpgbXwIx8PMbDGNMvp2qsGl8YCCxGXWWj4qNik+kmgKpR1yTq/CI4jHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH+CcxJ9j/GusYM4bicza2ELo3cBa0fOpTWYByy5fZE=;
 b=m+e6UxDz5bs/HDDGpLtjw0H/LqBxAra3pSH10HAsVIp81ocISHiJB0d6XqOXybtMLSWtXTr/Q5rZoJZlJJOswqvvmqFG8jF62IUX+cYhOELcofJHEkV4V+wrTav3eFHjwovG+OkSsxArMJCTvPL54/7eKuhpnFb602UPkoktgbSUwBgfkuUHQKb2mBFxWic/GEuUYQ7scV1np3TZEHh+DNR8oNtV3xYPGn0/4u/GddmlXTlJhs2ldACqmJBpAOO6+v8KmhTNwncOSavr1QGblTrp//ZL62gJB67FXT+ejZOii/6ZkOQw0e/MA9oMSxh9GU6x3m86y2WcStfxQPYtKw==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 PH0PR02MB7319.namprd02.prod.outlook.com (2603:10b6:510:1e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Fri, 2 May 2025 08:57:16 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 08:57:16 +0000
Message-ID: <e1c29ed2-828d-4a4d-b7b4-9417004fc64d@nutanix.com>
Date: Fri, 2 May 2025 09:57:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] hw/i386/pc: Remove
 PCMachineClass::legacy_cpu_hotplug field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-3-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::9) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|PH0PR02MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 300bb773-6fb3-4476-c221-08dd8957565d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVQrai95UDlIUVpjMXhXc1RINXVVeGRzUGtLQkVFWUE5cWg4Z2JaVllabXNE?=
 =?utf-8?B?ZGw0Q3VNc3d1VlJPOGZsbzUxem4yVW1ZQktwWU5SMWJMM0RHQnVoUDNZOVRV?=
 =?utf-8?B?OVZKTm4vcldOR2c1Skhxd2xxQzBhUWJ0VE51VUFjb0FaaTRNWGQ5bjgzNHZP?=
 =?utf-8?B?OWxXaWZva2NXNlJ5MTNTNWsreW40cldnd0szNUFjUGh6T3JBWlN5VHRSTnZ4?=
 =?utf-8?B?K1hiWGw5MnlrMlkramFnRnZkZ3hiM0o3d3dhd012M3k3Rnl6R2ZuaVlIUFRQ?=
 =?utf-8?B?Yk0xV1dSRTZDbHg4ZDlnZTlMQ21qWnNZR1ZMeFdYMytPbko0Y2ltcDY3OFBl?=
 =?utf-8?B?MEJmVW9QSnJzVG9WeXlYeWozdUQ5Zmwxa2tob2JrNVRKTmJQVDg0aDZOb3hr?=
 =?utf-8?B?bFlnV2lmNjU0WUFEUVlIais3TnJlY0JNUjNUTy9WQ0I5Mlh6MUxqWUJtZkUr?=
 =?utf-8?B?VzNsYk5nSXZ1MldZSDVBRmFjc0dMZm1mY000d1I5SjhGbEwvbEozbmpwOXlq?=
 =?utf-8?B?RXlrZGlJYldHNkUwVk9CUDhRNVZpSmltUjBJUXU0eG9jSS9VQmFFbkxzcEJR?=
 =?utf-8?B?RTZDODhEK3VMc2wzd3loMjIxWUpvNHVhL0ViV0pFQkFHb2o3MnI1d1NyeFhQ?=
 =?utf-8?B?MU5mU3l4c2pieHloN3BERUFnK3JxM0NVRXlpRzFIUkRLZTV1Z29OVzhCc1d4?=
 =?utf-8?B?ODlWOER0NlB0Z2dPc0FVb3lMSjEvaDhmenpsQlh4NXZGMmQxc3hvRXFJU0cz?=
 =?utf-8?B?SjQxdGlaWmpTOGozU1VxcFlGYVhpK3RyM2s3VklyK0w2ODNYWkZGVXhhMUsy?=
 =?utf-8?B?VytuMlRuZ0Z1Mk56bU1qSy8xU25SNjJ6cDhqbjdrQS9RaEhjSG1wci9CWTB4?=
 =?utf-8?B?cVN6dmlENDJ6TGloaHR2elN2Mkt4bUI3MTRuMzdDamQzZXdLeUUxNzJUVmFr?=
 =?utf-8?B?OEc2SWdqeEhNSHo2cnF6L01xNTYxTUZReFJIN1BqU0RKYUVTaFUvai9NU3Z1?=
 =?utf-8?B?UE1IME1Vbk5icHRPdjVpdWxXMGlqdlgrb1NWMTNKU05rek5xcWpRdkFLYVEw?=
 =?utf-8?B?OEZ0OVBwZEJocktueC9Wd1MwbEFPZHpRbkFoVWpDMDdnVzRNZE1SZUg1aFJm?=
 =?utf-8?B?UFp4YUtmenhZY3dyaHQxY3Q1b3Nia0N3dzlVL3hVMHFyMHp1bGN3SEt6TkRZ?=
 =?utf-8?B?dVgxeGRvUS9Fa29jVlJBUXNsNktBb1pGbEt0STJXOEVab1Fic2E0d2R1UmVG?=
 =?utf-8?B?YTZrUzdPOUFObHBGMXp4RXVmYm51a2xGWHdtWmYvTitvbmF4c2dSbysrVFdV?=
 =?utf-8?B?dmQzZ1F3cW9EelZwQU11bFZuUnI1WjN0K0hpSzVQb0NLM0NmZ3hqaTg3MDgr?=
 =?utf-8?B?Q1JVTXFvaEF6MWNIcUpOTS9zdHk3WHoxZnRYaE82d3dsSi9OdHlqd0JhRnVI?=
 =?utf-8?B?SmtrMGFraHJlZUlRYlRGQW1qYXpzQjhZNzROSXJSZWY4dFBWMGxiT3U3dFRM?=
 =?utf-8?B?a3B2YysrcUxBWkI2SkVCOTI4SE9jRVVTREJGcnlEbVJFK2VKdVkrdWtEclRT?=
 =?utf-8?B?ZkVPakRaRWNLOUtzdTZLWU9uMllHZmZwdlcxaVR0bXlEK3BaSDBTQ0hkOU9H?=
 =?utf-8?B?LzUxQ1hzN2ZuTW5SYnRsUGdFR2wwcGRCNmZPTG5RN0VGVE5qM0R0NHUrMGM3?=
 =?utf-8?B?ZUtlSjZqWXB3V0JuWnRONlhpUXAycUhUV3Y1elJVZzNQYnE0ODZyQVhkd3Q3?=
 =?utf-8?B?aGV2TmtERkdFME54cXVaNUpINmlvRURpam5qUVVCTzhSanJoSVRkbWk3RU9Q?=
 =?utf-8?B?S0tSTUZYYXAwMkJZTXZ5MDJNTEMxWk5rMGpUeC9wL1F0eWxvaUVZYXBaKzBn?=
 =?utf-8?B?RjlDZjlERUx4ZXd2eDNVdnJMbXNaeHdWbVF0N3ExdHk3WXYvRXE2U0xKSmJ2?=
 =?utf-8?Q?hOgJsy7IttU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVYd2dDWjVIU0I0dldvbFcvOVhRalorR1RuNWhnQnhYNFN4U0FaN044N2xT?=
 =?utf-8?B?Tk14b3lQMHR6TE5KUEttYVQxRG1zc1dGcHhXa0FJNy9CM0FkS2JudndndElU?=
 =?utf-8?B?RWQ5SUQvdXowTUJ3MjE5bk15dlltUVpudGRPK082RnhHMzhUcG5adlJZUG1Y?=
 =?utf-8?B?VFYwVnBoN0F6YzhMMDVrZmp0Z21OQzBqSGxNeGNqNFh2SXR4MWwzN0pUWVdl?=
 =?utf-8?B?eExIRmdXVVV2aEdzcTY3OGxmUFV5UlJHckVDdDA1TXJuZVRqNUhGNW9HZ2pK?=
 =?utf-8?B?MENnbHZVS1d2cFYvak9FSlRuSmVTSkMvdXJHbWRMcEpsdVFGR0FLa0t2aURL?=
 =?utf-8?B?amMvOURnTWdiSmR5R0JNWFh4SFh4bTN3czB3bWd3d3U5NU1janBjRXgvZ1Bp?=
 =?utf-8?B?RkVQM0JaZTR5TnNsTHIvdDM3UmJ1bnU3aXh6UE5CYllGeXVTWllsTEdWSnBN?=
 =?utf-8?B?RkRWbWN0L0J6a2wwc3BJN1dUSUNWUTBjWEZuLzNFclJKRHlSVDVPSmgzUEcv?=
 =?utf-8?B?c2h1bEc2bkZ5Rnh3N1luaXFnVE9SODVNRTJTSkJOZDBYb0lqbnMwQStOQjZy?=
 =?utf-8?B?R2h0MVZUamM2dUpscWV2RGxIdDVUL2hkbDVKMGQ3alZGclo1NjVjMWVJcTBT?=
 =?utf-8?B?VHh3aWRKQWxmWlBtRldITWJReXlrWEhYcVE5RHZ1MXVOUmZuOEEwSFlraHVp?=
 =?utf-8?B?NW91Nit1ZDdtcFcwU3F5MVEyRzllZjRBODRvcGRhRS9VVDIzRno4SmxqQ2hM?=
 =?utf-8?B?cnN4TG5YNy9lL0JaV2ZzbEVHRmJleUhPQmNEdytQUGZmdWVpRVZzblhUVVd0?=
 =?utf-8?B?RGQyNDRjTit4d3BlWEZac1dNVzZxM0dHNzJuSUZHREsyaTJSaWxjMEVZR3Vj?=
 =?utf-8?B?Mkd4dnJsZHY5dVVJWVY0UmtzNWtETER2dDdFM3Roc3ZBR0FxbjAya0ZPdS91?=
 =?utf-8?B?NEorRmdJUGdCZVpCakpRNVQwYVZJaEtOK2lPVm5wbVV4WVVtbHFoTjlIWU5M?=
 =?utf-8?B?bDlneU96a2FoMXQ0MjFmbkRBamQya1lFQjhoOEttbG8vTU5uc2xoeVVPZitq?=
 =?utf-8?B?RzNaWldPSnhvcDd0L2g2RmtTMUhaY0V0ODQrVmhJMmJFWHBndEtVMjZGZDVa?=
 =?utf-8?B?WkwyWEZ1RUNPOEZJVkdJRTJWaHRVc0lpZkhPSVAxc0FMblpSK2p3TTh2UmhJ?=
 =?utf-8?B?bkx4SXlvTlZCL1BtQzNwMUhQZEM3MkRUd1B1TE0yYWRFcUxUOGh6dFhXV3RG?=
 =?utf-8?B?RkxUNE9MaHVlVWxUSitNOG0xODZ2bXNEbWlGY1R4MFUrUk9MVTJENVNJK2Uz?=
 =?utf-8?B?eDkrei8rTXI2ZXFyaW5IcEY0QkNWYUVqbnZUbmoxSkR0QkRXdDJsZWRKSlAy?=
 =?utf-8?B?aXh5bnc0bjgySUVzSGNTNlNGTlhFclNqYXp3Mm9Sa0h6YmtzU1dnNEFWeklI?=
 =?utf-8?B?UVRCMi9pek5ZeWNMZCtHN1hmWDk4dHk2Vi85cjY1YTdJZzJhTkUyNGVBVTZ0?=
 =?utf-8?B?V0R3cnJMZWhuRTFWaFFlNHVOUVRwbU5mNmRUbVdWWTZSRDVFak5sMWlMODRn?=
 =?utf-8?B?M2IwSFk5SlRTQnNxcTZtT01ZbEVoUmdqdnFCSUV5dU5BVEdITTlNWWJ1aTNQ?=
 =?utf-8?B?elZIT0Z0bXdnVkJvWVlEejFieTZtSklSL21SYmlXazNKbzlYZm9QbzdaRmg5?=
 =?utf-8?B?T2pzeUwwOWlIaHpCR1ZwSHdHZStSMWU3N1Qrdm5TRzhDZVVROGwyeitWM3BP?=
 =?utf-8?B?cy9XSWUwUHdxNHVya3daQ24za256YUdyUWdqUXppSmxpaGFaT3ZrbGVOMUoy?=
 =?utf-8?B?Q2srQTZscFR4a2FTaTRDTmFEUURiamVtdEk3R0k2RjFjTDljYWYxTCtDd1RG?=
 =?utf-8?B?cngrUlpsZnI5MGFiblI4NkxBQ3I2NjdBaDM4NTMxRXl6NWpoTDM4azA0cEVs?=
 =?utf-8?B?Q1ZmaDd0U2VpWEIzZzJoc3lmRDgwdWZES2J2VFFMeE9IbmVoRGNTSVZuSDFj?=
 =?utf-8?B?UE1zbjZRU2dVNWd3dDdpcG53WFc2V0o0MVRoRHdxeEcxNkg2bU9KdS9YM2RT?=
 =?utf-8?B?VUJoZWVxdUdrVTdDcysyOTJKNnQ0OExoOWpFb0xJYlEwWTh2OHBuYVZqd0d5?=
 =?utf-8?B?dGNPQmJZZmdwdUdPTzhnbHFZbEZNOVRwdk5VV0N6MXRQSlViVUR3N0p5UkdB?=
 =?utf-8?B?cjgwZ1FLTEhIZUpUbmNwSWJFT1F4bitwSHAxM25YcUVqaEhxc2w5eVlOYlJt?=
 =?utf-8?B?RkVCSFJXci9hT3Z1SkNOWjJvVVFBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300bb773-6fb3-4476-c221-08dd8957565d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:57:16.2615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DRDTgQ4S61pXA3tzzB2geZJEnMLnb3O0ERusEjGhBzHHNOazeyB3vWBBZqXDgRmclHwgRW69wt0NIoHukMiNp+Tb+RnPoMcObuEsWezvI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7319
X-Authority-Analysis: v=2.4 cv=Y9n4sgeN c=1 sm=1 tr=0 ts=681488ee cx=c_pps
 a=nstxx7sbfik0j6lNDJSLGQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=7CJwTd3X23PHtRSDqdgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Zr4klDKV2kdQDlyT8eub1k5ox6jmVLPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX7z9QTcwaW7eI
 cMsiOelHZaRfQUlaOrQSrnp2SCKNT3ZuLT6iHOBiVGJqvf2069Bfjif+BSk5909vaUFRj7c2NWF
 b722X0GzYp61KGwj4dQ9NwyGOwH89e8XSDwSUaLPzMQavhc47LdPjvdQ6HkPsvQrauph5GPbW7F
 RE5+dL8DO3Mj2lJOnEwTkilwoa8rxHH4R3yISnHauE+CeiQtU3vk+e3IAN5jeECd8yI3fhrKyDu
 fRwZdxudkabsL+NNgzgHmhfUvQmtodx96N0bAL393nngsRx9UpBMyRLNsmF1t9dmXyGKvguJmED
 bt9lmb4C5iWtr6n/iB2O3m1cni0cjYLbT+jd3QV+o5dwas9kUO74uD4RIJXBPQw2J5HfztQo7Ar
 yI9keOcr/pGSQmeMIIUQQ5hiXHBweAY9OoQ/mYgr2mjD0wOnoefAAkxgyRIpN+WLN3nU7s67
X-Proofpoint-ORIG-GUID: Zr4klDKV2kdQDlyT8eub1k5ox6jmVLPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The PCMachineClass::legacy_cpu_hotplug boolean was only used
> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> removed. Remove it and simplify build_dsdt(), removing
> build_legacy_cpu_hotplug_aml() altogether.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/acpi/cpu_hotplug.h |   3 -
>   include/hw/i386/pc.h          |   3 -
>   hw/acpi/cpu_hotplug.c         | 230 ----------------------------------
>   hw/i386/acpi-build.c          |   4 +-
>   4 files changed, 1 insertion(+), 239 deletions(-)
> 
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 3b932abbbbe..aeee630cf05 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h
> @@ -34,7 +34,4 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>   void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
>                                   CPUHotplugState *cpuhp_state,
>                                   uint16_t io_port);
> -
> -void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
> -                                  uint16_t io_base);
>   #endif
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 79b72c54dd3..a3de3e9560d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -110,9 +110,6 @@ struct PCMachineClass {
>       bool enforce_amd_1tb_hole;
>       bool isa_bios_alias;
>   
> -    /* generate legacy CPU hotplug AML */
> -    bool legacy_cpu_hotplug;
> -
>       /* use PVH to load kernels that support this feature */
>       bool pvh_enabled;
>   
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index aa0e1e3efa5..fe439705bda 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -116,233 +116,3 @@ void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
>       memory_region_del_subregion(parent, &gpe_cpu->io);
>       cpu_hotplug_hw_init(parent, gpe_cpu->device, cpuhp_state, io_port);
>   }
> -
> -void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
> -                                  uint16_t io_base)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -    Aml *pkg;
> -    Aml *field;
> -    Aml *method;
> -    Aml *if_ctx;
> -    Aml *else_ctx;
> -    int i, apic_idx;
> -    Aml *sb_scope = aml_scope("_SB");
> -    uint8_t madt_tmpl[8] = {0x00, 0x08, 0x00, 0x00, 0x00, 0, 0, 0};
> -    Aml *cpu_id = aml_arg(1);
> -    Aml *apic_id = aml_arg(0);
> -    Aml *cpu_on = aml_local(0);
> -    Aml *madt = aml_local(1);
> -    Aml *cpus_map = aml_name(CPU_ON_BITMAP);
> -    Aml *zero = aml_int(0);
> -    Aml *one = aml_int(1);
> -    MachineClass *mc = MACHINE_GET_CLASS(machine);
> -    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
> -    X86MachineState *x86ms = X86_MACHINE(machine);
> -
> -    /*
> -     * _MAT method - creates an madt apic buffer
> -     * apic_id = Arg0 = Local APIC ID
> -     * cpu_id  = Arg1 = Processor ID
> -     * cpu_on = Local0 = CPON flag for this cpu
> -     * madt = Local1 = Buffer (in madt apic form) to return
> -     */
> -    method = aml_method(CPU_MAT_METHOD, 2, AML_NOTSERIALIZED);
> -    aml_append(method,
> -        aml_store(aml_derefof(aml_index(cpus_map, apic_id)), cpu_on));
> -    aml_append(method,
> -        aml_store(aml_buffer(sizeof(madt_tmpl), madt_tmpl), madt));
> -    /* Update the processor id, lapic id, and enable/disable status */
> -    aml_append(method, aml_store(cpu_id, aml_index(madt, aml_int(2))));
> -    aml_append(method, aml_store(apic_id, aml_index(madt, aml_int(3))));
> -    aml_append(method, aml_store(cpu_on, aml_index(madt, aml_int(4))));
> -    aml_append(method, aml_return(madt));
> -    aml_append(sb_scope, method);
> -
> -    /*
> -     * _STA method - return ON status of cpu
> -     * apic_id = Arg0 = Local APIC ID
> -     * cpu_on = Local0 = CPON flag for this cpu
> -     */
> -    method = aml_method(CPU_STATUS_METHOD, 1, AML_NOTSERIALIZED);
> -    aml_append(method,
> -        aml_store(aml_derefof(aml_index(cpus_map, apic_id)), cpu_on));
> -    if_ctx = aml_if(cpu_on);
> -    {
> -        aml_append(if_ctx, aml_return(aml_int(0xF)));
> -    }
> -    aml_append(method, if_ctx);
> -    else_ctx = aml_else();
> -    {
> -        aml_append(else_ctx, aml_return(zero));
> -    }
> -    aml_append(method, else_ctx);
> -    aml_append(sb_scope, method);
> -
> -    method = aml_method(CPU_EJECT_METHOD, 2, AML_NOTSERIALIZED);
> -    aml_append(method, aml_sleep(200));
> -    aml_append(sb_scope, method);
> -
> -    method = aml_method(CPU_SCAN_METHOD, 0, AML_NOTSERIALIZED);
> -    {
> -        Aml *while_ctx, *if_ctx2, *else_ctx2;
> -        Aml *bus_check_evt = aml_int(1);
> -        Aml *remove_evt = aml_int(3);
> -        Aml *status_map = aml_local(5); /* Local5 = active cpu bitmap */
> -        Aml *byte = aml_local(2); /* Local2 = last read byte from bitmap */
> -        Aml *idx = aml_local(0); /* Processor ID / APIC ID iterator */
> -        Aml *is_cpu_on = aml_local(1); /* Local1 = CPON flag for cpu */
> -        Aml *status = aml_local(3); /* Local3 = active state for cpu */
> -
> -        aml_append(method, aml_store(aml_name(CPU_STATUS_MAP), status_map));
> -        aml_append(method, aml_store(zero, byte));
> -        aml_append(method, aml_store(zero, idx));
> -
> -        /* While (idx < SizeOf(CPON)) */
> -        while_ctx = aml_while(aml_lless(idx, aml_sizeof(cpus_map)));
> -        aml_append(while_ctx,
> -            aml_store(aml_derefof(aml_index(cpus_map, idx)), is_cpu_on));
> -
> -        if_ctx = aml_if(aml_and(idx, aml_int(0x07), NULL));
> -        {
> -            /* Shift down previously read bitmap byte */
> -            aml_append(if_ctx, aml_shiftright(byte, one, byte));
> -        }
> -        aml_append(while_ctx, if_ctx);
> -
> -        else_ctx = aml_else();
> -        {
> -            /* Read next byte from cpu bitmap */
> -            aml_append(else_ctx, aml_store(aml_derefof(aml_index(status_map,
> -                       aml_shiftright(idx, aml_int(3), NULL))), byte));
> -        }
> -        aml_append(while_ctx, else_ctx);
> -
> -        aml_append(while_ctx, aml_store(aml_and(byte, one, NULL), status));
> -        if_ctx = aml_if(aml_lnot(aml_equal(is_cpu_on, status)));
> -        {
> -            /* State change - update CPON with new state */
> -            aml_append(if_ctx, aml_store(status, aml_index(cpus_map, idx)));
> -            if_ctx2 = aml_if(aml_equal(status, one));
> -            {
> -                aml_append(if_ctx2,
> -                    aml_call2(AML_NOTIFY_METHOD, idx, bus_check_evt));
> -            }
> -            aml_append(if_ctx, if_ctx2);
> -            else_ctx2 = aml_else();
> -            {
> -                aml_append(else_ctx2,
> -                    aml_call2(AML_NOTIFY_METHOD, idx, remove_evt));
> -            }
> -        }
> -        aml_append(if_ctx, else_ctx2);
> -        aml_append(while_ctx, if_ctx);
> -
> -        aml_append(while_ctx, aml_increment(idx)); /* go to next cpu */
> -        aml_append(method, while_ctx);
> -    }
> -    aml_append(sb_scope, method);
> -
> -    /* The current AML generator can cover the APIC ID range [0..255],
> -     * inclusive, for VCPU hotplug. */
> -    QEMU_BUILD_BUG_ON(ACPI_CPU_HOTPLUG_ID_LIMIT > 256);
> -    if (x86ms->apic_id_limit > ACPI_CPU_HOTPLUG_ID_LIMIT) {
> -        error_report("max_cpus is too large. APIC ID of last CPU is %u",
> -                     x86ms->apic_id_limit - 1);
> -        exit(1);
> -    }
> -
> -    /* create PCI0.PRES device and its _CRS to reserve CPU hotplug MMIO */
> -    dev = aml_device("PCI0." stringify(CPU_HOTPLUG_RESOURCE_DEVICE));
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A06")));
> -    aml_append(dev,
> -        aml_name_decl("_UID", aml_string("CPU Hotplug resources"))
> -    );
> -    /* device present, functioning, decoding, not shown in UI */
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> -    crs = aml_resource_template();
> -    aml_append(crs,
> -        aml_io(AML_DECODE16, io_base, io_base, 1, ACPI_GPE_PROC_LEN)
> -    );
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -    aml_append(sb_scope, dev);
> -    /* declare CPU hotplug MMIO region and PRS field to access it */
> -    aml_append(sb_scope, aml_operation_region(
> -        "PRST", AML_SYSTEM_IO, aml_int(io_base), ACPI_GPE_PROC_LEN));
> -    field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
> -    aml_append(field, aml_named_field("PRS", 256));
> -    aml_append(sb_scope, field);
> -
> -    /* build Processor object for each processor */
> -    for (i = 0; i < apic_ids->len; i++) {
> -        int cpu_apic_id = apic_ids->cpus[i].arch_id;
> -
> -        assert(cpu_apic_id < ACPI_CPU_HOTPLUG_ID_LIMIT);
> -
> -        dev = aml_processor(i, 0, 0, "CP%.02X", cpu_apic_id);
> -
> -        method = aml_method("_MAT", 0, AML_NOTSERIALIZED);
> -        aml_append(method,
> -            aml_return(aml_call2(CPU_MAT_METHOD,
> -                                 aml_int(cpu_apic_id), aml_int(i))
> -        ));
> -        aml_append(dev, method);
> -
> -        method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -        aml_append(method,
> -            aml_return(aml_call1(CPU_STATUS_METHOD, aml_int(cpu_apic_id))));
> -        aml_append(dev, method);
> -
> -        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> -        aml_append(method,
> -            aml_return(aml_call2(CPU_EJECT_METHOD, aml_int(cpu_apic_id),
> -                aml_arg(0)))
> -        );
> -        aml_append(dev, method);
> -
> -        aml_append(sb_scope, dev);
> -    }
> -
> -    /* build this code:
> -     *   Method(NTFY, 2) {If (LEqual(Arg0, 0x00)) {Notify(CP00, Arg1)} ...}
> -     */
> -    /* Arg0 = APIC ID */
> -    method = aml_method(AML_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
> -    for (i = 0; i < apic_ids->len; i++) {
> -        int cpu_apic_id = apic_ids->cpus[i].arch_id;
> -
> -        if_ctx = aml_if(aml_equal(aml_arg(0), aml_int(cpu_apic_id)));
> -        aml_append(if_ctx,
> -            aml_notify(aml_name("CP%.02X", cpu_apic_id), aml_arg(1))
> -        );
> -        aml_append(method, if_ctx);
> -    }
> -    aml_append(sb_scope, method);
> -
> -    /* build "Name(CPON, Package() { One, One, ..., Zero, Zero, ... })"
> -     *
> -     * Note: The ability to create variable-sized packages was first
> -     * introduced in ACPI 2.0. ACPI 1.0 only allowed fixed-size packages
> -     * ith up to 255 elements. Windows guests up to win2k8 fail when
> -     * VarPackageOp is used.
> -     */
> -    pkg = x86ms->apic_id_limit <= 255 ? aml_package(x86ms->apic_id_limit) :
> -                                        aml_varpackage(x86ms->apic_id_limit);
> -
> -    for (i = 0, apic_idx = 0; i < apic_ids->len; i++) {
> -        int cpu_apic_id = apic_ids->cpus[i].arch_id;
> -
> -        for (; apic_idx < cpu_apic_id; apic_idx++) {
> -            aml_append(pkg, aml_int(0));
> -        }
> -        aml_append(pkg, aml_int(apic_ids->cpus[i].cpu ? 1 : 0));
> -        apic_idx = cpu_apic_id + 1;
> -    }
> -    aml_append(sb_scope, aml_name_decl(CPU_ON_BITMAP, pkg));
> -    aml_append(ctx, sb_scope);
> -
> -    method = aml_method("\\_GPE._E02", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_call0("\\_SB." CPU_SCAN_METHOD));
> -    aml_append(ctx, method);
> -}
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3fffa4a3328..625889783ec 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1465,9 +1465,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>       }
>       aml_append(dsdt, scope);
>   
> -    if (pcmc->legacy_cpu_hotplug) {
> -        build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
> -    } else {
> +    {
>           CPUHotplugFeatures opts = {
>               .acpi_1_compatible = true, .has_legacy_cphp = true,
>               .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,

Do you happen to know exactly why the CPU hotplug ACPI entry was 
deprecated (it might be helpful to add this to the commit message). Anyhow:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


