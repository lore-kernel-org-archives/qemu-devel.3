Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FBFCFA466
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 03:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMHc4-0003ch-Tr; Thu, 20 Nov 2025 22:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHbw-0003ai-IR
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 22:15:00 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMHbt-0003ur-2m
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 22:15:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gs+Uki5qJwbuOGv4wxmStcDH99Br8Rg/pTBykNiJRzrAgrGa1J9imOohBIYknaxk2EP9KS6pCr0T/ZdvWqASDgKLEZZdi9jePzTec9LFtX9hx698h3LUQcDqI6HvpH/PyrGco4PIHCtdJnWBTVbPkBoLzUpi6ug4RNMmQNKxG9cynHDNCDjvy8SQ3odFUhrftU9a4BPzuqdCQTRnoQxyPuEqybwtO/FwaOHgvSz3bb9YZjJhhKgzWoB7ENtvqRjg0X100e7rtkimUeyVpYr/Cb8dC3X9Y9sPW1y3WUydP49yXkUSlKDEUC41dijnSc/rvWN4q3j5FrsmpCKHtRtkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/FMqPR6C/6FlwiTQdq+P/YW2AM/by624UTAWmoJ4YY=;
 b=DMXQCE0tYCilg8bZxlFlstPDHvYz1uJoABfzZQl21ZdrLoznWLqsVstzV/IqLJwb8JEbHboe4XU2AAuIycksHfCfpw04e5ecDISC9JfI1v+KBeLjbkTMRfuDTgDVil6RTFQiio0udsTVMNFie/tfEtsdD3wSWBDdGJnU2RDSmtwICoNm1DTwx7JFECRl+tEVQLd6n8GfmbkKVCR7pjHLK9cdw9zsiyigOUEmCSg9Mt2fShk4rlrLf21Teu/hT/RWt0UKbOS5SNj0vIvcI4zaD48Mpol2AgJRMGVQaF7AvOSfiNu6Z5kO+8Rx9UrqmlQj7eyso8rHhJP637pKJ20ftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/FMqPR6C/6FlwiTQdq+P/YW2AM/by624UTAWmoJ4YY=;
 b=Grf0ZO5pwcgVhBnmcKAG93xnnAIdUn3Qs10W54neFEnaIgwnX+dK5JEqS9PTRdQeDNmy/Xgne1QyUOaPCEdNuMgHiwUTHv8lDgyQoH2Wa4lgOcC4tWyNOxlB3fZtZlYIGjAHjX1i20yerBdtmJQ3sTPMcLx7l3wLxGpfZ+tRSyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 03:14:44 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Fri, 21 Nov 2025
 03:14:43 +0000
Message-ID: <db263884-6159-4d25-8c40-44dd78291714@amd.com>
Date: Fri, 21 Nov 2025 11:14:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, dmitry.osipenko@collabora.com,
 alex.bennee@linaro.org
References: <20251121024705.1403042-1-honghuan@amd.com>
 <20251121024705.1403042-2-honghuan@amd.com>
 <b6f4cc26-7ebe-4b07-8e50-257b6f53d309@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <b6f4cc26-7ebe-4b07-8e50-257b6f53d309@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::12) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b7fa8d-8b1f-4fe8-f365-08de28ac1dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUh6TXNSTHkrT2ExT1pOQmIyWHdsZ2pDR0U3VU84RGh6UWFoQWcrMHVSK0RC?=
 =?utf-8?B?N0lCWFdVOFhGSXdHVWw4ZUxsb1JyYVdMN2E5c1RVb3JzSDRkaitXb0VlaTNH?=
 =?utf-8?B?dDJER1pYRm5JOVJNWlVYOWNpRUkydTlxdUorcmNrd2s4TUEwV0lreXZjU01P?=
 =?utf-8?B?cFFkK0JFRXgzdkdlZTlzZUZ4K1ZGZGJqNmpFSXFWSnhYT29VUHhtZk5qZzBL?=
 =?utf-8?B?MUloeG1idVVBKzZMVWd6b3VLUlNIVjgycjFTRUFOYm1tUko5V3V2cVRSQ0FV?=
 =?utf-8?B?enZwK3V1eitSaWJzWVVEbW1TK1FIeHozRDBIdk5KUEVUTWxkVnh2QS8vd2NR?=
 =?utf-8?B?UnJWYkwxL1VhRGRsUmZHVG5vTXJrR2dSdWFKN3F5MkFSZjVERHNQb3lYNkha?=
 =?utf-8?B?VlpvdmhsbCszQ0MyMnQvU3ZYY2hJcnUxTFI0bTBVTkRYcmtVOWhTZUlKWnI2?=
 =?utf-8?B?OFN4V3VqNmYySmk4SUlTRHVRTnpVM0tRS1pZYjRuTUMxWTV3NjJIOEFJWkR6?=
 =?utf-8?B?Z1gvaENScDJCdGRrdVNjL3pPUnBKMTIzU01rb3psN2VINGd6YkJhUkxjT3Jr?=
 =?utf-8?B?S3pUbXhnaVRnNmtYYVVoWGV4WmpXRkg2UWNaUHhiN0dkVWpuV2dFSGJyNW9u?=
 =?utf-8?B?WGhCc0Nzby95L1BLY3BFYnhwYUJrbkN3S0ZVNHZjUkYzcUgrTVh0N2puMnJF?=
 =?utf-8?B?UlBSUGNIem1Gb3NOcE1qY0h2K0N3eUsrTDRtOE1mUTBRMVVOR1lBVEtqNXZE?=
 =?utf-8?B?dzNwTndBaXlJVXZqMStNTTNMclVhdSswMFV3dXlCeHpwUExYdE4yNytQMnNw?=
 =?utf-8?B?aGpzRzF5WFZoVzR4b2xGUjdFOUYxZG9xTG9OVmRtellMaUxvWE5iTjNrMzVy?=
 =?utf-8?B?ekR0Z2FaU0VTK0VjNDM2UWI4VEVlMVpjU1cwV2l2cStkZXhTaFFxNklUN2VZ?=
 =?utf-8?B?RHZINkhGVmE5UGtaNkx4S3dBM1lxMFlnWVgyVDlrZlM2N2NkZDMxeVpGdDd6?=
 =?utf-8?B?YTc4cEdWK05SNml6TTJKWkZ1M2FHTk1IeW1jSFplUlFnZ1ZndnUwSktLZFhQ?=
 =?utf-8?B?RkVPSE5QSng0d2J1c2ZVeTVWQUZZRlRqOTBZWFN5TmNWbTZQZXNsR2JvNzBY?=
 =?utf-8?B?NDJKTUdqTFZ1MU94UWJZdFBVSE1lL1I2dzMvMlEzaGVCR3daSlcvWUlFdVFH?=
 =?utf-8?B?TmxjTy9NcS8xVm84R2ZlTlUrZ1lQMjdDaC9GMHBYamVLMDZuWTFMbDNlVDgv?=
 =?utf-8?B?Tk5odE9Ub0NZNXoyNmpXUEJEdUxKVk84S0wvWEtwRy81Z0VyL29xQ0xjdXZS?=
 =?utf-8?B?dHRnNGpZeVNad1F4cjFJWnB5ejU1emhBV3lLUm5sTjVySDdvb1RQb1hUa2hp?=
 =?utf-8?B?SDUwUktJN3lMVW5STTc3NWdpY2t1RDk5TG0yY2V1cTVNNzNqQTY1cGNxeitJ?=
 =?utf-8?B?ZnNBL1ltNmRnYmIwMWJ3UkE2ZkJFQVRDT1dpTjhoL2tQS3dtQUVLTlN6NDZ2?=
 =?utf-8?B?ZG5YUjQ0bHlDdWtiQWxwWCtOSVR6akk2RHFjcnhCblFFSHRKaks5NDFBZU8z?=
 =?utf-8?B?SUx3RnRVOTB6SlRLa0V4R1lqT0VHSmEwRnkvMEcyQm1SMFFsN0ZJZEx3UFV3?=
 =?utf-8?B?T1pZSXFZMWpWSGdPUFM0N3p1ZUpJd3lSZzkzQ3VGbVdFb05MeG5mWnV0UDlN?=
 =?utf-8?B?QzFTMzlQZzVoUEV2bytVRWpJMUg0Vkx6eGo4ZHRyTkJHenBrUWNUeWxGOGJu?=
 =?utf-8?B?YWo1U2JTK3Y0bW4rZjVYdVVkcXhhUUJ1WmM2bmdmZWRtVWVabkJWdTBMZ0V1?=
 =?utf-8?B?SUh3Q2tHZzVET2d4Z2YvNzZZc1p1UHg3WnFIRCtEb0NvSmM0VS9nUHhvQjZ6?=
 =?utf-8?B?MWVkeGJUWlZKOGhHR0xvbm1IUERQRnhCVUFiSlZ1R1FYVDV4TzBaUTdxUHJC?=
 =?utf-8?Q?JG+HJHMqnJcOHPw9i8kPXmXqnVCNEbS0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5YRmNoQVhtT0lFbis0MFNMbDdMYXplczN0VWRRV01ycysvN1cxa2Jodk9i?=
 =?utf-8?B?QVBzL2JNY0lXVkFHV2NzUkp3aUxqY0lTTFYxVit0TUJzcnZXbTRnUnpnSUc4?=
 =?utf-8?B?N3kvSHFkS0RXYloxdXRzeVAxV3dFaVF6YjB0dVh5ajZSenA2L1V5N1Z6ajBu?=
 =?utf-8?B?SGdrNm8xZS81amtwL3k1dUEyV2RGdkZ0Zi94N0h0R3VqbmRxcjlnWk90My9w?=
 =?utf-8?B?THZyL2lESHRiWk9MeGtWdzlydU1OZlRmNDZiaW9nRmtjRXFtd1NWMkN6d25Z?=
 =?utf-8?B?R2RuV01JRGpGK0k0UU1WVnVGUTJleGxtOXBvWnMzMmV0R2lGcEJiQ3NWUlo5?=
 =?utf-8?B?OHgrTUxtMml6TWtHWmQ1b3RWNW1BenJvZ1BLNVFnTzdaYzBBcnJlek5pMllF?=
 =?utf-8?B?N3UvQUtQUnozUzZUckZTMGdqZEdSblVjS0pJVlhZS2krYUxFRUtVVjQ1dkcv?=
 =?utf-8?B?NnJ1bml6di9ickdrTEdBOTMzNXhPR25KUEQrb1FscTJzUkxyRit1NlREbER4?=
 =?utf-8?B?U2xWQzJpNjBJRVhWK0laLzUyQm91QURrVHFsVHBVTVUxUkhnUXVWZnFCYWxX?=
 =?utf-8?B?TWZjVzhrTjMxcW5hRHhYaWViMTBWU1hZNDh1L3l4OFNqdU9iRGxrNThQY2hr?=
 =?utf-8?B?NzEzNE0ycXdxcWMzNEpSaVVFMmdXOGRvLzFFRVFJeEptaEJsaGRJTnBmOTJS?=
 =?utf-8?B?VldYd21IcE84NE1oV25MQ055UUhIUE5hanJGVXBSQ2ptUHhtUGg4R3VLVCtV?=
 =?utf-8?B?YlFmSHJGckJ4cTZpckszRVVoRDZNNHNnc0dKQkFHTjl2cXFsQ0gyUFVYUnJq?=
 =?utf-8?B?WjU3d2ZqcktRN2NrY1hBcHpTckJsWDQ0Y1dsWWtKdTFUVjdIbDZWTE1MSG5O?=
 =?utf-8?B?d3pYZ0J4QUJyWmEyNG9BVlB3TmhNMEp2eThCZkt1MS9aa1FtR3NvaHl1R1J1?=
 =?utf-8?B?STFoRHZOOUNCcDdsK2ZxYStYcDZ4T0EyemRhdGlvUWFvOHpzTFZzTWx4Si95?=
 =?utf-8?B?WW96TC9KWTVQQWVwSjlqMC81ZnBTenkrOFJ4VllTUVp2OTRnMDNDMmw4ZFF2?=
 =?utf-8?B?U215N1BWQkhRazRmTFMraHJNRTErZ0xEa2d5VGYzWURpYnMzeUFmUXBDZ2FU?=
 =?utf-8?B?ejhXY3pzWXRYZEQvOEQ5cFBua2lnVXc3UU1pTVBQQjRMb1c3WWE2MFZjd1du?=
 =?utf-8?B?dWE1MHlqeUk2eDdsWkVURW5RMXBrWWpDS21GOThuZFRHSi9HM0pHN3JKYXli?=
 =?utf-8?B?bkJRVWcwUWRlT0RDVXJ2b2RXcjBOelY5SWl5bVZwL0J2S2JVWEpidkt1SE8y?=
 =?utf-8?B?d0hNNnM3MGU3RjBwanZpRCtGOE5NKzhYaWRCaUdDeXRtMG1jYVhsNzNYaWtt?=
 =?utf-8?B?dHIxbWhyY2orMHJ6YVo5V0I5ODVBU1JER0Y4RTZwbVA5cjJNYjZtWVJkLzBO?=
 =?utf-8?B?Zm5vM2IxcW5jMjdIbkpLd2hoVWY3WUpnWjh0RjZxejNFN0pnR0FpTnJiQzZF?=
 =?utf-8?B?N3dNajlzem92VzNmdUhDaW4rNWluLzFsUlFrOGxZcVpyU250QmZ4SDQ1b1VO?=
 =?utf-8?B?UGJvRmlpSDFaWUNaQ3FOVm9OUS8ra3B1SEF4WjdydXpreFAvRUhVSmZWM3ZL?=
 =?utf-8?B?aXAvU01GVDZIL2IrWTlQVWFBRDQ0MTF0TDB1SUJDOUVKSlFWTGlldllUdkJ1?=
 =?utf-8?B?L3YxbXpJZkdCbWp5Nis5UktCZmFqVEY4aWxOcTMxamp1V01Oc0JpWjY4anZV?=
 =?utf-8?B?N3JHU0djT3k4Wlg0bnZWaTZNemhIanM0NEQ0YUpSMk1hK1FuV1RHdTBnSWs1?=
 =?utf-8?B?VU5ZdEJUejdvSUExak9VeGZsQTh4M3Y4dmpUckM0Qml3andybXA0NTl0VkFD?=
 =?utf-8?B?SmZURFZ2ajlqR2lMUUZSSzhRSUQ0ai9kcVdHSEw5ZkRDdzZWSVlrSGdhWE4w?=
 =?utf-8?B?LzZXRElTa291UHVGM2laV0xHVUZncGJWbjBGU2RHUWNxY1JUd3cydUIvUm1Y?=
 =?utf-8?B?TGFLeXo1QXJCZ0o3Q1Ztakl1VmMwWDM2ZEdFMmI2UVZHOXU2NjQxSHptR0ZO?=
 =?utf-8?B?NWEwVWVrS0J1QXR5bHFWYndQb2VqbTdGT0hFQTUyU2FNWHkwK1FZUERiSFJr?=
 =?utf-8?Q?/RzMJ/JZdgbtlFi93o1BDZMf1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b7fa8d-8b1f-4fe8-f365-08de28ac1dba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 03:14:43.5369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +THlBHYLVrq+Cf7a0xuXmLGqC3ezCvHAWRA8GJlL8kjbzPdZBQRjvx7T1YlEJS7/LreW/4u3oBapu3m/oY3i3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Honglei1.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 2025/11/21 10:56, Akihiko Odaki wrote:
> On 2025/11/21 11:47, Honglei Huang wrote:
>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>> user pointer mapping for blob resources. This allows guest applications
>> to use user-allocated memory for GPU resources more efficiently.
>>
>> Changes include:
>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>> - Enhance blob resource creation to handle userptr flag properly
>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>> - Add conditional handling for userptr vs regular blob mapping
> 
> I don't see the added conditional handling.

Sorry, the additional handing is replaced by the fixing of value check.
I will correct this commit message in the next version.

> 
>> - Support guest_blob_mapped parameter for virgl renderer
>> - Fix value check issue in virtio-gpu
>>
>> This enables more flexible memory management between guest and host
>> for GPU virtualization scenarios.
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   hw/display/virtio-gpu-virgl.c               | 2 +-
>>   hw/display/virtio-gpu.c                     | 7 -------
>>   include/standard-headers/linux/virtio_gpu.h | 1 +
>>   3 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu- 
>> virgl.c
>> index 07f6355ad6..c927275c79 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -705,7 +705,7 @@ static void 
>> virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, 
>> sizeof(cblob),
>>                                               cmd, &res->base.addrs,
>>                                               &res->base.iov, &res- 
>> >base.iov_cnt);
>> -        if (!ret) {
>> +        if (ret != 0) {
>>               cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>               return;
>>           }
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 43e88a4daf..956dc811fa 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -808,13 +808,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>       size_t esize, s;
>>       int e, v;
>> -    if (nr_entries > 16384) {
>> -        qemu_log_mask(LOG_GUEST_ERROR,
>> -                      "%s: nr_entries is too big (%d > 16384)\n",
>> -                      __func__, nr_entries);
>> -        return -1;
>> -    }
>> -
>>       esize = sizeof(*ents) * nr_entries;
>>       ents = g_malloc(esize);
>>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/ 
>> standard-headers/linux/virtio_gpu.h
>> index 00cd3f04af..b85e781a2d 100644
>> --- a/include/standard-headers/linux/virtio_gpu.h
>> +++ b/include/standard-headers/linux/virtio_gpu.h
>> @@ -405,6 +405,7 @@ struct virtio_gpu_resource_create_blob {
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
>> +#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
>>       /* zero is invalid blob mem */
>>       uint32_t blob_mem;
>>       uint32_t blob_flags;
> 


