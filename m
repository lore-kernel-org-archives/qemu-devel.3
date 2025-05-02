Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41111C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmOc-0003yk-71; Fri, 02 May 2025 05:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmOZ-0003yU-W6
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:09:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmOV-0008Rj-Ku
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:09:23 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5424m4dJ006875;
 Fri, 2 May 2025 02:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/7RkGNHI4+FujHi+zJM2egs29EtNybEmimuJLrKvq
 Dw=; b=sCG982SZD2fPmH8j0lfehQ2glc5Bcp0jPNz3Sn8v75oJ+vnu4FYzdCfo0
 vZrKFiZJCM6GmU6BpX6HIEeNwpkZYE5ruun09/EkTVAWWxRjbCgiX6dBNAZV1y4i
 nlt+/YnrCFQNxBOwlxG5CE1+WyaYAxRteJjEeaYYATGyR0ggiS/LI3nQ/rXkYA9n
 jEyEdaNXmTUk9msu+BfmEvnDuysg3N7lhj5LN+bUdwg08o4MgK1BhtNTNPKmQ6eT
 ngzNYerVtiz/EnSV/Lq7/uenICaI9CGwJ+gKVNW2LrdVNSMbAQKhpquNZ9pEsbSD
 K4FJeFX8kwncu3jWCastRPGC/35jg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46b9g65wvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDcElL4Z+XXm7CccLICQa4gkOI8ZH3w5TZaMMaXEf8w3Mt2ySkbMshrWa2eCrvdKNucaOCF75t1A11YNMx1eZkpZXt0Wh+04UJpfY59kO7Xz+mwl4vqKakmbAl8clqQlzO3C81bpJ6C48lR/wE1FE65pj3/hgpsIyaS45HcA0pUbOB8u3LuYO1tLRrNotadM9gjVNEkx6SLNe4aONE7JB46ngRPkdwDk5IbVWdLVJrjG1CN/vZza7BKJfLCIj4UBxFEW2BWEHYTrSWZQX96YQD6djv/DVgMsqcRWa/aYNGwwc6yV0EUQ3bJcnkDbT6oxZWNjhDOKYtFOw+UCvqghAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7RkGNHI4+FujHi+zJM2egs29EtNybEmimuJLrKvqDw=;
 b=SjOMYndJHjJ2y2wbvPYu9hLnITWaQ1nxEAV21EEFCxKHdQgO29uubUy+ckgqmwTO/Sobz0pXJegb38wBkfa2XZzdQLpBJz1h60mkpw/nfjs0qQPuEmSEZOQOHiXLjxX0pv6c3WvNLR8/xptWwkeiAXNPbBKasJY3j6r8Qygi7QjGnA4wjg1khxA0FC/Gt1BlP9SHa/e+a9K3oWO1EEmqLb5tiHLJyH46OgrrW7XUbIkqnF3r6uDpyLOnHVoN+f3keCxC1DbAjJ6FXIC5yyY1+H2C4F271ioOtCRlogFuVUpvveyQGGPR7HJfkkpUnvNwuvYNMm7fpl6EF7dNR041dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7RkGNHI4+FujHi+zJM2egs29EtNybEmimuJLrKvqDw=;
 b=yxMR9O9MD5Eh180QwMih1nNDvdCGCBaEnSNKtk9ZwiNWMGs1MglC09b8V526lUCCNFQ33Y4a4e10J8L+2Xdlt3lFSyTdO1ZmMA96XtrWyJsbhkDX/jnQKiiQPjEDY/k8DgppSBZ1WN7zHUiKIAfXjpotaSqXVE1JsXyXlh5GZzNCwAsqusTfEXvslPY7Jx74wlJbs07P6esntahRiVuOKeQdx1G2UaNQ4SGxztj5OTKnIzHCjyqgXVhjf/T4AhBwJCAw7GYELTM1odqNWMZQxAe+kcsbfZQCW6xachJ/XB1/JmJR9vNGwJG19aw/5loWRzr1+XJJ5ldtV93jFDr+Wg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA1PR02MB9846.namprd02.prod.outlook.com (2603:10b6:806:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 09:08:56 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:08:55 +0000
Message-ID: <2acc8c0c-f563-4d27-b73d-ce4c0f8ef424@nutanix.com>
Date: Fri, 2 May 2025 10:08:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
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
 <20250501183628.87479-4-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::9) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA1PR02MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f6a4f4-865b-4c84-03bd-08dd8958f763
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEZCL0J5YVdjN241M2I1ZTdsT1VnVEJYNHNIU01rVlVDaWtaU2ZKR24yMGQv?=
 =?utf-8?B?M3FJM2MyTlNmbk4xWEhKZzdKQUI0alFDeFlNQ1V5K25ueWdtS0FuNlplMVVC?=
 =?utf-8?B?VFEzQUN5NVVUaHFVY1dKRUlmdnQ5UCt4OFlEOE9zcWF0ejlRMnB0ZmJ1NDhL?=
 =?utf-8?B?U2NsUEVrSHVsSGtTRzVRSXhiZzVEK1V3cXBEQlg2d2hROHdEYk5LSmdibmx2?=
 =?utf-8?B?TTBaYTlyMTJjSjBHWi9CQm16ang4K3dhN09sWHNaWGpreElPNU9VeWh2cW4w?=
 =?utf-8?B?dzBoS1ByckZzcEZIQVRncXVXeEZwOUZ3TWQ1NnFvRTEvUHQ5eWZHYzFkQUVx?=
 =?utf-8?B?MUkzRDJIWXNJK3ErTGI0YlVvZ3F3ZlZDdkpoQytNY2RWVzhnZkIrRGpXRFZU?=
 =?utf-8?B?VENuVE5lcURCUGM0N2NoZU9lYjFwZFBkRjdmWnU1cldKUER3NWt5bDZhS1FO?=
 =?utf-8?B?SzhQeTIrbUx5NVZONm85WDR5NDd4ZEx5TFd3ampzYkwyNldMYnNybXBVK1JK?=
 =?utf-8?B?L0dXaWRVYk5vbjZIUDVOKzQzVTVNVjRweHk3NkNsWDA5N2F6dXdlT1ZxeWRv?=
 =?utf-8?B?RkpDazVrcEI1RDB1VWIrUW9qYTJHZ0wvVG9OY3l6Z1VlcU95bHJaK1prTkF6?=
 =?utf-8?B?NURhM1gyQTQwVk95V3JlR1ZZeDZXVWlGUHRNMGtobk5EWWwxYlRUK0hZYnps?=
 =?utf-8?B?T3Y4R0pCWGk3YUJDYnVxVTg0TzVycW1zdFZ2eW1MbEY5dWt4RXVYaWpxYnhS?=
 =?utf-8?B?UXJnV3dLTXdVdGFvL0hZc0hyMkxuWU1qVE1DaEo3eXQ3a0ZWdWdlODdiWHBz?=
 =?utf-8?B?UUFpUzQreVZHM2F6SUpYNFNMeGNSRnByVTNIMXJlTWhOSzF6UHNRWnVPMDdU?=
 =?utf-8?B?SHNFRWt1a0pYQUR1aUhFMTJiNWdHcU1QcXRFb1pQREFad3g2UFFiMUpQbUpi?=
 =?utf-8?B?WkxlbXRKSWdpc1hUVGxUaGhveHRGd01Wbk1JNW1JK1V1RERhdXBVUWRTVitG?=
 =?utf-8?B?b1I2cWlud3VxTmg5VDlZZWptMjR3V2F6QWZwUlh3a3ZrZlVzZWY5VnZrUjdk?=
 =?utf-8?B?L0xFQlkzakN5cFVmMUZPVFU3OTlSWlprMkRVd2ZqZDlWNVlSU0JXcGZpanQy?=
 =?utf-8?B?Q3lteDVPV1lXSFVucGdrTkUxRHdjV1ovQ29FdXZJVlI3Q2dEQXZjam85OHM5?=
 =?utf-8?B?aEFqbzVjR015MmFOYSthbXEyUk56SHo1ckwva0xDNXBEVHRXbTVOZmJzZHNv?=
 =?utf-8?B?ZWJob0Z6S2RzV0hDYkdQLzZ6enBzWEV4Q1NFYXZ5c29USi91TVNwZ1MxMTVp?=
 =?utf-8?B?UzRhUHd5cVg2aTNzbjhKbjR0YXhjZ0pPWHZzblVQYWhrMXVFQStQSGNjUWt4?=
 =?utf-8?B?dzg5Y0NNaGVQeFRIK3JsQmhZZThRZ0h5Vm9rQ1VYcFBzVmVya09nY1ZYdlFj?=
 =?utf-8?B?THFZU2VWK3JHMzFuN3VMa2cza2Rzd2NJNXNXV2pRNFNrTDlQVWNVYkQrUURB?=
 =?utf-8?B?bDVaMFRrMnVJSTNWeWFUTStjZzVSWGdGVUx2U29uREZCdy9LWnZHaTkxV3Jm?=
 =?utf-8?B?QnJQb3hJWHBSaXUyeDBOZEZyWWFBNngzcWd3K243VzJyN2dyWk1OcWxFTnpG?=
 =?utf-8?B?N2lwT09nM1U2cmt2Q1NKcStIVklPa1pmSDNKN2w3QStWa1puTEpFN2cyMHpa?=
 =?utf-8?B?Q1RUQ0xnQmlSOHBWU2Q4Y2NTS3pVdy9hcGdQWURyL1lYaG8xWFdzQVc4V2lP?=
 =?utf-8?B?UGpWTzkxMzF4RnhBbi9YS0V6SGZsb1hqR2hlTS9HM2FTaHJQcWpzMlQwT0Ey?=
 =?utf-8?B?YUNZSFhXKzY3bVVyT1doWk81WlVKc3pWbEt4enBQTVBvMWtMQWJhWmtORHZ1?=
 =?utf-8?B?NHJyYlV4TlFnckNxRVhIRUwrWUoxczNlaDNxcXhwUkZubDJpWUZSUGg4VjZm?=
 =?utf-8?Q?HpZaTf5wyUg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFzbGVKSzhPNWdXcFNRWDQ0dFV2NWtOaEVNSGx5OC9vVEFSZTliNU5qQ0lX?=
 =?utf-8?B?VWdNS2RmK2hBZE1OTG9xQUpKUERoOVRHbzRSYUJKUVZvdGViUzBGWXhKYTd3?=
 =?utf-8?B?bzB0eGFvSVFXS2JQVGx2cGpKRUZnMHJFTjNOUWFHTXg3MkdEbjlBWjYydUxp?=
 =?utf-8?B?WE4zK29ZckZlUWo5N08rWG1rblBEckNRZlNhWkN3c3pmK3V2RFV5bTRBWlRU?=
 =?utf-8?B?dW5GQ3N3ZnN4S1ExRmVDWEI2U0toUDcxTzNBUmh5clVKV3p1R0FCd1N4ZFI1?=
 =?utf-8?B?VXJqR0FuemFoY1FBVmFBa2JGNlZ2ZXdoL1pjblU4bEtGQ3U2RGR2Q1VRK1h4?=
 =?utf-8?B?ZkNFTi9JNk5HcWhhSmhEZ2lwTTgxeDhsU2NGeG1BYXdlS1BsaVJDZTdBMHBp?=
 =?utf-8?B?K3Y0SlV0aVdLc2xsS3dSRVBrVmdRRW9WaUFHeWJqTVpYVWhhbnFMVUFkZmVF?=
 =?utf-8?B?RWJabXdlN3R2cVk3ZGFER1R5VmpVdUc2ODZObjUralo4WGdKWTVvL09GZ3dT?=
 =?utf-8?B?eDVyWkNYWERHaWt0UmxUelR2emMxUCtqRFcwNUhoZnU4STl0YmtSa01VeU03?=
 =?utf-8?B?bkdMVFA0K2U5eExTUlhCVnYxQTlrNkUyeG9LZ2dROGdOY2FTQ2lPUmZVS2xO?=
 =?utf-8?B?YTFXY3BIOG53eEdpaytrVHdURVNOVk04Nmd4QXc4eXBUVDAvS2prTDZZdUdx?=
 =?utf-8?B?RFRaSWFzT3NVRmtOam43WkdIRTVuNUY4WlVXazY4OVkwd09OT0M5NGs1MDZF?=
 =?utf-8?B?eGF2V01nUWNoTHhIbEFyS2Nkajk1cmhpaWNwdXEzajAyeU1abERTRk1KdFp1?=
 =?utf-8?B?NWcxcXVMa0l5N2crZFN4Ylc3U21nTjFuc2wvS3N6dmhnTExvTG0xQzUwTnBQ?=
 =?utf-8?B?b2QzclZkMXp2NEtsVUR4UjBndHJEUndKZW5JTFo0Vko2dWNVTU9CR2RTcXd3?=
 =?utf-8?B?ODdLMnB3aHNaM2N4eFBBRW1xQUdEM1RsMUxHaEYzYlEyd2FvMTJjWlR2bFdZ?=
 =?utf-8?B?SXJITTU1cjVDeVdXUHV6SGRXZnB6UEV2WWh2TGZDK2ZZcUVMWXdUOUJJTFhy?=
 =?utf-8?B?RHhQNVpKeDNIc043NW9tM3I3MVdvWmo4enZITDMwU3lxY1ZKM2hwQ0dQUmJ3?=
 =?utf-8?B?Y0ZZL1FpWWw5T1lPN1RqOWFRWkczV2l5MFg4ZFBZSysyMEhabFVpdHJyK3Jr?=
 =?utf-8?B?VW1JU3pKRWVhSXV0SmZ6ZjZndUl4Nm1mL2pKMzhmT3RTN0l6YzNSamtxamts?=
 =?utf-8?B?QmJGOTJPdkxMTThJOE5JOEpXUU9DQ3IvVU5xSENoNHhaZkpVQkR3Ry9oM043?=
 =?utf-8?B?VEJyeW5peG9YSk9ZY0tFZTVPU2ZvcmxoVUt6dHZZSis2aGhNMHhkQTNmdnh6?=
 =?utf-8?B?NEQ0dmlhZXZmamR6UTBETGZPV3hwQjI0bGsrOGY4ZENyaVN0V2FwdTBOdk1M?=
 =?utf-8?B?UytpNTlQSEd0NjJKWWxjVHRLb0N2YStnbmJmb2RqOXgxb1dzUVdwQmxYdHZs?=
 =?utf-8?B?SHUyQm44cmpnT3gydDJIcWlaalRrcWlrSDlsNy9CL0JQY09OMVprNEJwdnUr?=
 =?utf-8?B?b28zZk9oS2tzVG5OSUVRbm9ML0tvV3ZidzVLVTE4allTMVByZlBvSysxLzda?=
 =?utf-8?B?R1FXVHo3MW1tUC90bG03VHVzQWhHQS9WdmtWM0U3aWRUOGJRL2lwRk9HdU1w?=
 =?utf-8?B?VkpvanBrcXc1UzViTG1NWmEvbnRhZFpNQjVsdFNwOVl2bWxHZlZrY0dadHdn?=
 =?utf-8?B?TXBBdHZUQmFSdVpwVzdnWDA2K216MjREdTM3b2s4YlpSN1A3dmxDL3hPeTJN?=
 =?utf-8?B?eUp6ZEhIdzZQMUQxQWEwZ0Zad3gyaThTc0hPcm50ZnBaUDlDZHZCTmNUVkdi?=
 =?utf-8?B?SDJTNHFMSWdld3htQVZvQjhwWGxhUmFqZG1qb3IwRjNjQStsaGFYd3RiWFkz?=
 =?utf-8?B?c1paVkNqMXpEOW9rYVl4OHhFdWIzdGhuVDV1ajNOYTFVc0pWd3RxUHlhMEVL?=
 =?utf-8?B?dk1IWVU0V1lkMmZ6UjhwclJsbTVPekF1bHZST3RpSDZyWTlpQk9NTHMyQWNR?=
 =?utf-8?B?VzJDYmJKbTlmNDVqS2hqUS9wQ2NDd252MVcvYlJLVHc4L3pqeDZldHFHamIw?=
 =?utf-8?B?Q2JGOGtoRnJjWnRMK0U3UmowNU9XRnRmSnVQNVplREtoUUtYeExCK2J3ZENx?=
 =?utf-8?B?MUlQMVZjL0Ridm80UEkyeVJMcXFKeU8rNktsN1hqTnRhRWUzSnd5OEM5bXh3?=
 =?utf-8?B?NnAzTDdLMUtiS2phZmNqeDZjYUx3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f6a4f4-865b-4c84-03bd-08dd8958f763
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:08:55.8027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t91Z4v1L0SK+cMUNTJi29Y7/cY7S2IHgRfULYK1lpiJJ2r59ZMYRqSybrLfk8q/+sZ1RhAym3rt+8CpZ1KA9/KBgCUEtRQI+tRMMkFximlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9846
X-Authority-Analysis: v=2.4 cv=GolC+l1C c=1 sm=1 tr=0 ts=68148baa cx=c_pps
 a=ybfeQeV9t1qutTZukg5VSg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=hQ4Vx1NNK52Ut7JZlEgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jG5CZk10eUXoKdJ8cu5uSQsQM2O4UuWt
X-Proofpoint-ORIG-GUID: jG5CZk10eUXoKdJ8cu5uSQsQM2O4UuWt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MSBTYWx0ZWRfX7umq4cG/MrkU
 7gQPepJFF+t9PfTasna/k+IFvLKlF7ml5HIUiZfQeNLQVJdXE/uLUB5zwnPL3Fd+PlypUe22M6r
 LpmdN8nY7Lfchdhb0PJ7HkB1FaGiuSDrA3MIvXI1A0SakxNytgFuokJq8ROb7gaoaC/r8z2PbWb
 6ti9mPy/1FO433FOkz6r/OQIzO5olmJhxYJ8IDp9wFM9Vqt+OwdvuY1nUaH/TWzoGEkR8+noLbb
 X0onFow3vNYfs6hlM2oEBg8NeOuJYBQPHRDl0ArN3KboDevJ/wJsc17srk/SDJFTJqMb8C7jMTz
 JRP03h1XXJ7kIgEvkXz3jjijUD20tbRmiB2Nb0fgUlHMPIfUzQXJlX/hSxVOJSTxFTMoqCifJyf
 gMK1OAayXExhb97SzuH4NWnxleLlDo5gAix9sDneyFkzB8G3HpdYTBKLylcwiWukbLt/Wlbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

> The X86MachineClass::fwcfg_dma_enabled boolean was only used
> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> removed. Remove it and simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/x86.h | 2 --
>   hw/i386/microvm.c     | 3 ---
>   hw/i386/multiboot.c   | 7 +------
>   hw/i386/x86-common.c  | 3 +--
>   hw/i386/x86.c         | 2 --
>   5 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index fc460b82f82..29d37af11e6 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -29,8 +29,6 @@
>   struct X86MachineClass {
>       MachineClass parent;
>   
> -    /* use DMA capable linuxboot option rom */
> -    bool fwcfg_dma_enabled;
>       /* CPU and apic information: */
>       bool apic_xrupt_override;
>   };
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index e0daf0d4fc3..b1262fb1523 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -637,7 +637,6 @@ GlobalProperty microvm_properties[] = {
>   
>   static void microvm_class_init(ObjectClass *oc, const void *data)
>   {
> -    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
>       MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
>       MachineClass *mc = MACHINE_CLASS(oc);
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
> @@ -671,8 +670,6 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
>       hc->unplug_request = microvm_device_unplug_request_cb;
>       hc->unplug = microvm_device_unplug_cb;
>   
> -    x86mc->fwcfg_dma_enabled = true;
> -
>       object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
>                                 microvm_machine_get_rtc,
>                                 microvm_machine_set_rtc,
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 6e6b96bc345..bfa7e8f1e83 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
>                      int kernel_file_size,
>                      uint8_t *header)
>   {
> -    bool multiboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
>       int i, is_multiboot = 0;
>       uint32_t flags = 0;
>       uint32_t mh_entry_addr;
> @@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
>       fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
>                        sizeof(bootinfo));
>   
> -    if (multiboot_dma_enabled) {
> -        option_rom[nb_option_roms].name = "multiboot_dma.bin";
> -    } else {
> -        option_rom[nb_option_roms].name = "multiboot.bin";
> -    }
> +    option_rom[nb_option_roms].name = "multiboot_dma.bin";

Question: now that all machines support DMA-capable fw_cfg, does that 
mean that the non-DMA options roms above can also be removed?

>       option_rom[nb_option_roms].bootindex = 0;
>       nb_option_roms++;
>   
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 1b0671c5239..27254a0e9f1 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -634,7 +634,6 @@ void x86_load_linux(X86MachineState *x86ms,
>                       int acpi_data_size,
>                       bool pvh_enabled)
>   {
> -    bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
>       uint16_t protocol;
>       int setup_size, kernel_size, cmdline_size;
>       int dtb_size, setup_data_offset;
> @@ -993,7 +992,7 @@ void x86_load_linux(X86MachineState *x86ms,
>   
>       option_rom[nb_option_roms].bootindex = 0;
>       option_rom[nb_option_roms].name = "linuxboot.bin";
> -    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
> +    if (fw_cfg_dma_enabled(fw_cfg)) {
>           option_rom[nb_option_roms].name = "linuxboot_dma.bin";
>       }

And same question here too.

>       nb_option_roms++;
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index f80533df1c5..dbf104d60af 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -375,14 +375,12 @@ static void x86_machine_initfn(Object *obj)
>   static void x86_machine_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> -    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
>       NMIClass *nc = NMI_CLASS(oc);
>   
>       mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
>       mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
>       mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
>       mc->kvm_type = x86_kvm_type;
> -    x86mc->fwcfg_dma_enabled = true;
>       nc->nmi_monitor_handler = x86_nmi;
>   
>       object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",


ATB,

Mark.


