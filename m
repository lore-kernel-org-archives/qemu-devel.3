Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E598EDF173
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvQb-00036z-O5; Fri, 13 Feb 2026 10:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvQZ-0002pu-Oi
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:49:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvQV-000848-BV
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:49:55 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DEL2sV3415798; Fri, 13 Feb 2026 07:49:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zZ2JjFBL8vNKwgBxxzpcqsTyjNhkAEqEshvjwF3bg
 38=; b=Poa8Y36nCypjVISwHRTWlUqINCN2j8rrEtaXJPTW1ip7F9nFP2MbFLf0H
 YdqYtP/nJsHpTyoDOZTeQq5Gd6etcfRyNyj7pcTuvCSN7oGI7M3QvufyGH5mOgNW
 1xab9dotKjBFW6Be6Y8/MTNNl79NjE90unMBbC/ctaPlHii6WANDiyqCEtNSeYed
 WQf2mbTdlC6f0W4Lb3DXhgcAkc0Nu9DPCXsf1+xY3F3gkg+nSBSNFekOQ50XZt0W
 UBUK/H2oaTRjHDplOYTSUxCQHCtmvnU5Po5rNOE5OBeSap+SgcdPMChAouSDYiAH
 MUnpeTnfMfQMGHr4Ybqwb3z/kI4Kw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020076.outbound.protection.outlook.com [52.101.56.76])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9jp9tyep-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:49:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIwkMzUuWqQdExrJjco7HiV9C+cJ+I6dryDfZ+ZpLHyGyFK2BrMygN/ycXbNZ5BLM1aPaVAfPAXaK8e1qWWhkpoIdqzfl0Uo2IzLNKmSTKpfGNuoz0aerAFWQPG/16xjDr8TAakWzdUlBEzpvz8xH71MXhZtF2BfPVr695oKj2VjoANNHmjG+tenreO+AIPuwtmEdxxMUxOT29bQRqwUXeA8IFvX8xQQC0I7C4nF2J1KgeZIJBPYWpRc4eWcymt1F+LgLrxx6OVVOf6hF8SKVPJdW8PRga/OCfzC3zlvIzRP5cGVHPNAbw2n11I7X24QYcAaEw8EdYmnxA3IbtAYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ2JjFBL8vNKwgBxxzpcqsTyjNhkAEqEshvjwF3bg38=;
 b=eRp5e61zOPRipGFKol3tAaWwuPAmMUf5RD27cOUpkpBrzKK2OxsnN8GzNaOTZ9IlVvUWKFcbL0HZgJ50EQwDT7wvu+wBtDnnr0BC8P8oQNHO+/0Jp59sdj7nJKvg/Sdo3/xihpB/X2IYfQKhH4a4wfJTAnuswM8kk8vefrZ35e0U549/g9Qw8xLo6qWo0Y4gw/u2weXICdSn66EOQX+5UwvRt4mfhg5zHrH8DDucFETg8HiGDcjRU/UfmKqK+leKFJbk3f3JUkG02t6/bIC4jgxJ3pid4JCBr9+zx9PxFzsq5U6wxvqd7Ew7IzW1BIW9dimcHHVT7DVmcPj9nmIOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ2JjFBL8vNKwgBxxzpcqsTyjNhkAEqEshvjwF3bg38=;
 b=czFcFiW7mc+RodYYuVVesja3tH674EtWDjAtTjkI8hrRaAV/4PhjEuXsoOitWrpriLXSCQyl9MFCcQ/L0atvh3TCH+CPwz3/lYrEJB2K2aaZhkKIhFM/V8bzqUmEnDOWAL/gM8tT1S0rNgU1YSQhRiDazxTE3YlTcEGQyulwRK2TZZ5ZSCE+fbp7FzeFJ35tARxFgNB65noBf7umK8pjiwHfrirN85rsgEQxspY8UDoXvYProeF5zHTBxOYsiCITi3YwSUVxgIgCyrtOCNYdYucgPdD3pufNrZKb9tXkpIpO3W2gMLH8GlOfgI65vHf7y2h40Nbth6nGvzNSkrP0zA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB7924.namprd02.prod.outlook.com (2603:10b6:208:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 15:49:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:49:46 +0000
Message-ID: <d094a131-9ef7-4c49-b037-76583b3b48e0@nutanix.com>
Date: Fri, 13 Feb 2026 15:49:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/43] audio: rework DEBUG_POLL
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-35-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-35-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bb3a65-25b6-4b60-ace0-08de6b17834a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWlObjNYelpNUjVmMlRYM0Z1ZjZ1YWpKMUhxaERLTUpRUi91MmJ1c2Fnd3BH?=
 =?utf-8?B?YzRrQ3B6M3Y5V2RHMnlpNDVvZHJJNFhpS3I2TnNteTlVNGlGUVhIZGtuc2xV?=
 =?utf-8?B?dXpmQXBOV3I2YngvMVVuMXg5ZGNCWnkrSUZjTkowQ1dTQXpXUlNUYllVK1hq?=
 =?utf-8?B?cEN1OUMzWHZIajQ0SVkxK2NUK01XVlU0TDNxMCtmbm9aeHM1ZGE1ajQ1WDI2?=
 =?utf-8?B?MDJGZVVBZk9SWVBMNWFsUUFJZEtsOWppVFIzRkwwVUdER1lSYTRDb3ZIaisr?=
 =?utf-8?B?Mld4TFU1SEFzYWU4cWNGUzg2d2dFb1cyRHk1eEdyditsbnFwbE5pRXo3aVps?=
 =?utf-8?B?cmZrWXUyei93WUdMN0hrdmFleHMxVGJVeDlQODAvamZyUVZaK3ZFVnRaRFpr?=
 =?utf-8?B?cnN4RDJKQnNhM2lFOTJIdCs2aUpySHNEdmhoVXVta1QzMWVBWkZTQnlhV2Fv?=
 =?utf-8?B?UnRKNnR5STQrdEVKbHhscSs0emh5UzZhKzR5WUFjREw5NklVVmdGbDlVVEQ5?=
 =?utf-8?B?aEJuV1hHeGlXcHZlaGJhM0ZoakFtYmVsN2tHZmt1YW55enV6TWNDMyszdnJN?=
 =?utf-8?B?UzROdDVpcnR1WVo2MUo5SGUyZ1NkMndIemhsZmFIeVVibkdBdHpMNXNDQll3?=
 =?utf-8?B?bER5dkNCT0tvenh6RzlYbEp3MUsxV0F5U1NsTVZmREZZR0k2a3J2aFZaeDYy?=
 =?utf-8?B?blk5d0VMVnlXZU9iamk1Zk82VU5rL01CaDM5SUtQQkZNZWhVdHBKem9MOU5o?=
 =?utf-8?B?MFZqR3RvTjE4RGNDcWozSXpEbit5akVMcVdqL3kzSWsrWHh2RGp2UXU4VDRG?=
 =?utf-8?B?N0c4OUpUY3pxeHNWSCt5bTFvbEZaTjRxT1E5dE5IdUdCb1JqN1hyWUR3M1BS?=
 =?utf-8?B?WHlTSjdIT1dTRklYRmpNSEp3azFDT0RZU2FlV0hXdzlXb1AyampFUE1MVE1M?=
 =?utf-8?B?K05CYlVWazRncUxNR0w4cXBub1VBU2M1Mm5YMk40M3Z2Vkk0emlqTlU3SUhM?=
 =?utf-8?B?THBtT004bGZLZ0RvWlpmRGlmT0RPcTQ2UjEzVDBnYnpZbEgxU3pKVjJvUWd3?=
 =?utf-8?B?WURMRjdTWkIvamRXd0RaZXVqSk8rUkw5V1Vpb0FxeUR0ajQycStaNzlaaW1u?=
 =?utf-8?B?aEtXaTdTUFp6VERZT254czVMb3Bhd1huUG94clg4SFlKallwcWFOWGxoOXkw?=
 =?utf-8?B?eSs0RTVNTEsvbFRCVHpseVROK0dVTFlvV1pkQ1BrTmJQWUVGT085N2NTWjQv?=
 =?utf-8?B?OEhjSlJYejVyUi83em9tanZKUTRBTnlLaHRQcDU0WWZ4eFJVMXpudG1DUGZV?=
 =?utf-8?B?R3pzM0N1a1dEN2hzNVRFNzZzL25VTVlBNkhLei9YYjJCbGd4U20zT0VrODZK?=
 =?utf-8?B?S1JWYXhFeVJhNEtFS1NvZTIzRjZHN1hkdXJGaVI3SXgrYUZ3dW9zOHZjSHdB?=
 =?utf-8?B?Y0dBZWFTRy9Qa0E2NGNtMU9yeUMwK1hTYk5PUDQzYWU4ZUp0L2MvWHQ3OHor?=
 =?utf-8?B?Mmdjb3NuZVdDYW1zUnpCQXF1TllERTRDcm9QQkdKNUIxN29HWlZKQzRDUTN1?=
 =?utf-8?B?bndKc0h0OWpKZkI1Mk9pY3Z5cHQ1QkVqWllPM0VBR0JZcFFTaUd6bUJBelU0?=
 =?utf-8?B?VFQ4ajhxZHBGZW5ySG5xeTZMRWJpZDF0SzlCVlREQVByWWJhSXZ4TmtKS0xL?=
 =?utf-8?B?c1p0eVZXZ1l5a1R4N0R3Q0FyNXlYdVlEaEl1UDgySzhpaFBXZFhEamg3U3RR?=
 =?utf-8?B?dW81cFNDVWdSOWwxUHhMeWJMc2xNazEzM01XSkRraERBMUdwV3ZQOHVnNHJN?=
 =?utf-8?B?bnR2UmxodUlsUm10UHR2NXZqbXhhSUhIK3dmdUU0aWc3d2g4ZVozMmRnaWg1?=
 =?utf-8?B?MjcvTTZGL1E3dSszQzZRSHRBNE9iUXBXWnlOMUVMa3RJelFHaHZKQSt5UmFD?=
 =?utf-8?B?THR6bFlpY29xaVJxN1VNaFdvVjJwVkRuUE5RVzh6VFZ1cllVMTFjUVlCeTBt?=
 =?utf-8?B?ZFMyb0J2TDNSTTJPSzlIcXVRbmRZY1ViTEV0YmpJOG5LS0VEV01sNENWYU9o?=
 =?utf-8?B?M1NhMlJoR2JSY3ZkWUd1NmU1WU9xUXhtenNjaThhQjl5VzlKOFlwemJndDhk?=
 =?utf-8?Q?BvOY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzBYQU5pUVZUVmZscjRYZ2RSMDdteHBMZzFralgxV1NoTGoxZ1Z5dGZ0T3Jx?=
 =?utf-8?B?aDh4RjNHOVA2cklFTmp0Y0s4bnpKMFVqbFhjdzh2dFR4R0JTZG5PbUZjQ1pL?=
 =?utf-8?B?VkY5NWI1VHBEUUZERW1aQVRwTUgwWktiR2R3NUV3QlQ4bUIzU1hGS2VtWGNQ?=
 =?utf-8?B?dHh1TCtLVVhreG5Hb29vaVBRdVRRVThzOFQ5eENJNElqZ2JrL2M3L0htWnlh?=
 =?utf-8?B?Rk1waHFySGZ4ZzFjTGxBT09DeklQUW40REtjUGlQSThaU2VRS2dHSjVIOUpS?=
 =?utf-8?B?YWlGakx2OEZtd3pVUEM3ei91Z2tYZTBsOUNsOGk1Q2t1U2l6U21Lem82Z0Yx?=
 =?utf-8?B?VElRK1JxTlRiRTZmd3U0WEU2TUNKQ0NlRWZJZnFtWVdOOW95Rm1rZXMxT001?=
 =?utf-8?B?T2U5ZjNXUytSUjczQ1Nmb2prcVVJMlJ6RzIvcEN0eDFlU2pHaGwwWXhnMHV5?=
 =?utf-8?B?S09oNXhZS3RNMjRmNzYxbzlBOURTQ2NGcVU5aHY0NFZ4d3lvUTZJeWNPUDlX?=
 =?utf-8?B?U21xdlpuaUpzcmJnOWd6OEExUVh6bVNmSnV4akVZRlJqUmtjcE8wWVBCU24v?=
 =?utf-8?B?ekQxelN4SEc2YW5iWjdCSmlKeDlHSHhHZHcwb0toT3ZZa1F6NWZnZnVoeXlL?=
 =?utf-8?B?anN0S09aSVFSSEJYeTJOTVhkTXI1eXRBd2dObzJUM0RkRjlRZzdCc2x4R1hE?=
 =?utf-8?B?bXNMZXB5SnZkTFJrYUtSZGZPZm9tRjI4b0ttSmxua2pKR3Qwa2Nyc2ZvU2dL?=
 =?utf-8?B?b0I0c25Fa3VXTEdlYUxTQTBjSWEvYlBzQzBrSHZ2WWtKWWtJYURjOTFONUtM?=
 =?utf-8?B?bmdIYjNwV2tWMlZKLzBqZk9saENSZVZyb1lveW1DOVpBcGhnR2JoMlRDQU9R?=
 =?utf-8?B?dmsxVHVHQ1ZHdG94aVBaSjVKMGdWSUJZMlY2UnkvY2FaaFY3YUVoMjRMU0xr?=
 =?utf-8?B?NzFwZm5uOTRacWN1OCt6WXRUbDJlN3g3YUpSMDdraXlFWlZVdGhwRTQ0OE1S?=
 =?utf-8?B?SC9RT0hJdytUUHROYTZ2bkhLZGZ4ZGhNbjNicDVQU3BXQzdUYmpkT3YwekI0?=
 =?utf-8?B?R0x6RmJISHRYQU8xTEQ4T0dTam1vNmxYWEtIclFkUUhFaGwvQXFNZ3VBSnZh?=
 =?utf-8?B?cGluZ094QzduS01xVXNibjFoRVA2TmU1VnlzeXZxYUJrQlR0MlBOa2FoMlVi?=
 =?utf-8?B?T3pEZnV4TWdUclc0eW51aCtYVE5wYlY4UFVGdlNDdyszcXNjVXJqNmlwQTFG?=
 =?utf-8?B?NnZHSVAzU3pURHJsQnhHaWh2VUxmNUNkUWJCMWRTZ3ZEVFNHVlZvN3RRRUJX?=
 =?utf-8?B?TGppZFBVbWNGc3g4a1pOVDg4L0I4aXhqWXZOamNWWWh6dUtWZWcrejVDdmZr?=
 =?utf-8?B?QkVXeVN0eVNLeWN6cStTa3FkT1NMQzdBVDBUUjZyL2ZNZGwyRmE5TDZBUWs1?=
 =?utf-8?B?UlE5eC9Ec0RjUVBtNVRBQ1pMRldTNWxDc0t6Vlhubk16clRQalNPWEhIVVVh?=
 =?utf-8?B?b21oaU04NjF2SFBDa3pWOXg4YWllNFNhT0YwOEV3bUNIWldMbGFoVldWaDcy?=
 =?utf-8?B?MGZZYW5vK2xkQnNKelNUWm1uY1FjOEpqVENqMlM2ZnZtVExTTGlzdWt6M044?=
 =?utf-8?B?UHVQQ29oMW90RmRwOXNUU0w4dEtQQ2M1SkxHRFJZY0NEZWkxcHVoaHVTWFBV?=
 =?utf-8?B?UHM3eXEyQTVHVmt3TGV1SzhJQUVvNWMzL3hFYUZkQ3dTOU1nZFdrb3cwRGVk?=
 =?utf-8?B?YVJGSVUwanB6WUFSWWVYTVFrU2dDUkZPc0FGWUdWeVpLbUNCenY0dVFsSUZx?=
 =?utf-8?B?elNkb0wxTXduSTNjbytzY0NlZ2szc3VDNzlRTTJmNW1BVW9TVGM1L01VUTRN?=
 =?utf-8?B?MVBQWlNWUDZkam9xNUdjdUIwV09ma0JCNWpsWVJ1RTh5V1kzbmtIM21jYVhL?=
 =?utf-8?B?U1Z3VDB5YnlYRGRzM1VHRzhjWEhmbXowUXVYeHlWVU5yZzUzK1VDSVJLcDJk?=
 =?utf-8?B?a1BXK2dkWDVwNlY2dUlNdDRRRVFwRDBVUlA2U05ZbUlYSml6Mml4RzJzSDA0?=
 =?utf-8?B?UVJRdFJUeklYYUpROXhGYmh2SU1SeTZzYjBid3BNRDBCZVR4SlBIK3dpN0Fk?=
 =?utf-8?B?c2RlUU5Va296NFpiQ21QclNXZHpWY0pZSFBmNncrNisxMURVNFc3OTU1RlJo?=
 =?utf-8?B?U2p2cThuTDFDMTBNRkh4NFdDTnk0Q1psOXAvUDlRaVFvR2hIUjdmczZ1YThx?=
 =?utf-8?B?THIxU0hvd3dzVUl5UkJONlgxcGtXZEEya3lPUEo3Qk1DSjVvL1BaM1ZyWWdQ?=
 =?utf-8?B?OElhWDZaK0lWMTBiN0FFa1d3c0ZBUWRTWVlkK0tNUWwyOHRSbHExQ2E5T2Rm?=
 =?utf-8?Q?Jmfsir9xNd9HSldE=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bb3a65-25b6-4b60-ace0-08de6b17834a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:49:46.5860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdnjDiFVAVkRGuE/nsj8ZgNaADP7Gi3NwKI6M66u9+7CUz1rCwuN/wqRRFc94JO10yAVJIZBR/pXLL28sJuSlmtqqfFC7RvgJVg92830pOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7924
X-Proofpoint-ORIG-GUID: _ltOCB8sfODiR7SDJSvhLYmY47mAgK-J
X-Proofpoint-GUID: _ltOCB8sfODiR7SDJSvhLYmY47mAgK-J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMiBTYWx0ZWRfX8t76b+at8atu
 ZEQZE1Tl6aC89/uBM0PdM5KJgYi22EFN4oRIX+MI8j1I/V6Llwocke/EKeoj44cb6ybcPoASv8l
 0HaX3M64VRm2vMKdx2QJ6IqpGs4YEYeYNz853SWqkOKac7guhoeklF88BKgqZhv/uhAyMQwaEwp
 BcycMuShqMa0sLTjvD7p6OSjPblB9dpZ5RTWt5/vLoIu+dMn9CpjwytWAe48HJVGi0AsbITxd6A
 i2uVmmOe8KWlPODiEPylkv3rSy2J4Vab8gM66GSElI7WQMf2txJcyYaC3DINPNbBSc7KdYEIjQ1
 R7wUkcvIm5Jip+HfcmCrof9japawYOpeNCbhXT5tstuctNREQSMA/ytd4zaRJG4KGbjARhsRjc5
 tLmlK1zti3QWR+xVfw9I+TciZ4d9vLnTxtTfIAhvICntFo+6ss4zaZzCM0hBgvJBqT/g6G8p5nR
 8otlotUyeRNPLQZ2b9A==
X-Authority-Analysis: v=2.4 cv=SKJPlevH c=1 sm=1 tr=0 ts=698f481c cx=c_pps
 a=BIqkfoc/VDQRyBVOA29iEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=v88Uw0Gd4cnfq0hHdcUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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
> Use more correct GTimer, specific for each backend, with a trace event.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h       |  1 +
>   audio/audio-mixeng-be.c | 25 +++++++++----------------
>   audio/trace-events      |  1 +
>   3 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index dd5f2220d75..e0ed6af67ed 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -224,6 +224,7 @@ struct AudioMixengBackend {
>       Audiodev *dev;
>   
>       QEMUTimer *ts;
> +    GTimer *run_timer;
>       QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
>       QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
>       QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 343f6ec181e..1b2c1fafa87 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -24,13 +24,13 @@
>   #include "system/replay.h"
>   #include "system/runstate.h"
>   #include "trace.h"
> +#include "trace/control.h"
>   
>   #define AUDIO_CAP "audio"
>   #include "audio_int.h"
>   
>   /* #define DEBUG_OUT */
>   /* #define DEBUG_CAPTURE */
> -/* #define DEBUG_POLL */
>   
>   #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
>   
> @@ -1269,22 +1269,12 @@ void audio_run(AudioMixengBackend *s, const char *msg)
>       audio_run_in(s);
>       audio_run_capture(s);
>   
> -#ifdef DEBUG_POLL
> -    {
> -        static double prevtime;
> -        double currtime;
> -        struct timeval tv;
> -
> -        if (gettimeofday (&tv, NULL)) {
> -            perror ("audio_run: gettimeofday");
> -            return;
> -        }
> -
> -        currtime = tv.tv_sec + tv.tv_usec * 1e-6;
> -        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevtime);
> -        prevtime = currtime;
> +    if (trace_event_get_state(TRACE_AUDIO_RUN_POLL)) {
> +        /* Convert seconds to microseconds for trace event */
> +        int64_t elapsed_us = g_timer_elapsed(s->run_timer, NULL) * 1000000;

Not being familiar with g_timer_elapsed() I had a look at the glib docs, 
and it seems that g_timer_elapsed() returns a gdouble as opposed to an 
int64_t?

> +        trace_audio_run_poll(msg, elapsed_us);
> +        g_timer_start(s->run_timer);
>       }
> -#endif
>   }
>   
>   void audio_generic_run_buffer_in(HWVoiceIn *hw)
> @@ -1545,6 +1535,7 @@ static void audio_mixeng_backend_init(Object *obj)
>       QLIST_INIT(&s->hw_head_in);
>       QLIST_INIT(&s->cap_head);
>       s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
> +    s->run_timer = g_timer_new();
>   
>       s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
>       assert(s->vmse != NULL);
> @@ -1596,6 +1587,8 @@ static void audio_mixeng_backend_finalize(Object *obj)
>           s->ts = NULL;
>       }
>   
> +    g_clear_pointer(&s->run_timer, g_timer_destroy);
> +
>       if (s->vmse) {
>           qemu_del_vm_change_state_handler(s->vmse);
>           s->vmse = NULL;
> diff --git a/audio/trace-events b/audio/trace-events
> index 4749c54fc04..d66a712e871 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -61,6 +61,7 @@ audio_timer_delayed(int interval) "interval %d ms"
>   
>   # audio-mixeng-be.c
>   audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
> +audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since last %s: %" PRId64 " us"
>   
>   # audio_template.h
>   audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"


ATB,

Mark.


