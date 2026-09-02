Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC6DC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nrP-0005Ui-Vi; Wed, 02 Sep 2026 12:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x1nrO-0005U3-63; Wed, 02 Sep 2026 12:30:50 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x1nrM-0006jZ-5P; Wed, 02 Sep 2026 12:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/g7laHeqUSO/mGV1xTdlgsAv6lgK+ADfq3hQlMlICXUyBwgdXP3uOeLZuGp+VjQxvb2jl6giZhEqQyR+Cl2RpvM7UxL+8DP1AHiHh6ZGVuz5WrwVZ/L9bA/0m1DU8j6zyPGYWl+oPyD3+EtlXC+oda97DpYFFlxcphOypOyzczCtcvVTc6LwNoLsAenY6/dg5j2D6nxih9uwGGcXy+RHUlVXzjZJ+Au1yGBCIccqv86BXE6BbLH4A3gbUr6deBeFDocgsutyiFBKbAxU8nu/RmUG93HPUa2pftUpBigavG+e6Y32spdpKIM/K35Fpj/lRQTBqWEsznFF12sAVfMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avz8amdVeBjjJjlB/W/dr/q2aKNPmUxxrLrwlecYgR8=;
 b=b5ldlT6vWjH+H25eWmwMff68gZcSy7Xii4ZlcBpLlwY0a/GPAbdN9qwX1cu1JNTsf8jQaes+rUpARLdTSj9DKUYJrTQ+HgiNpiz/bN0oActd8opHWi35SY2W2wvFa8uLGFINLzzZC7QJNQPB/E45LsR9hL0MYSnYJABFOMZjD/UZrLE1Xesx15XFKUcmpm4BG9YZWf3RJfVd1jHJvDEmEO384SmOWswaimtFBSJ2FsUGG/BD6GD/n0AvQB9CHlpCQHJnqcgf2w3sQneIGgvo9+trDyqdbKL6p6icojrf/HkNVKu5HuZUazRYiOSg0kL2l4CThABuS8FtLlUjznCAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avz8amdVeBjjJjlB/W/dr/q2aKNPmUxxrLrwlecYgR8=;
 b=PJ/muwkuddUdHjaQGftVVnDgzu6JbGJVV88gh/S/aQLXm0JNm3iVAnu/TY7WuHwCjCeo6ue23LnZo/1VmuipQBJGirMimhzFBhta48W7RfQMusy7mixD0Lv4xt6Ql4Azd7fBkzu7cKuqvq7tRABl7aAUcYnEH6dC1OkuTIioU6VKMgpST+KUKJ2KHwQlEQKShNGbfzYqpJhXd3wz78BagLRtQZULz+98A1EytXzHmJj3bPnGrHHZcnhsEa/BSpd529f/g0SGgh2z+3guYfoZcW8owMxAXdZT/Fnmk2FH3ucZhkmvT/6P3sgIRz9nx57KWcWFklIRdx2ryc3it8mmbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Wed, 2 Sep 2026 16:30:35 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:30:35 +0000
Message-ID: <37f31842-e79a-4089-82ad-8003fd47fdb8@nvidia.com>
Date: Wed, 2 Sep 2026 11:30:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, qemu-devel@nongnu.org,
 jgg@nvidia.com, skolothumtho@nvidia.com, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 devel@edk2.groups.io
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
 <b4d51232-43a0-4058-af96-5c3ca847edd8@nvidia.com>
 <ape0Mbd7Lt4KS-wN@sirius.home.kraxel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <ape0Mbd7Lt4KS-wN@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0152.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::7) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: db2fc79a-e789-4bd1-fdee-08df090f839f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|10067099003|22082099003|4143699003|5023799004|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: xrm0d+TZQ1WpfY0XNVMyK2esxzcUwTvOvbU+JiudGxNC+p1pDS/G3WQ69GdOkMHKD0LfmnmZZXh+hbC2LQDFUfp77owxxiUZiT+JWLllOQaJ63/KHZwBLGOkQDrt37UjDwivKO5UXMQKAJhYdnEp8YWNAE0ZPYNbfw1z2dhivs8updjW3saSU5vOX1ml5kKK7wx9MAr0rWt4tahzISr1BfQNIF6wzP+HKTX6obc4Rfxp+AKsujEpRHIBhfWB9Zg4zEUqsns0VsMylNDrxFpOJhWqK+CsQz3whvZMqBbK1H3SUueht2+v4G4Cz19IBtKSINxphx22ytdrrkFW8BQYHb2zpob7LZxpvsF1yPOfiX2u4TXSJOoEoI/kDAqIH7aa9C1TuczajaAE1bTPbczi+egoEG1WMSIJvKAz/K97ZST0WHAnDEWhO8yenbjdxhojAdxPK+RchhZSNoY+ZsfM8Ha+8Lse7yu3b+bk+fLIIit8qc/wPvJ/0vd9TkofVSF9VOx0ncnLCi7/7NqQi8s98tF2bTHK7PL0JJB5F7oaV4RnDrPDGlhfnAleye3EQpwCiuHxZArFIISPE60c7pNqJlFemc8lwAFYBr9vXORHCK+OfT3Vwa+V3zC/xVJBxYdPTLt1ldDtKakpU+AM7WLIpYnaWL4mNvkX/zG34HgQzik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(4143699003)(5023799004)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aldqdHRZeDdjRWhGd2VlUDNVRTFqZ05vb2RCRkZqWTU0akVSdlZPRHE2VVA4?=
 =?utf-8?B?UmgzK0lUZzF3eTRJN2YrN3JOeURrVGNzNU5hbGJkWjV6UW51bVgxSnM5SFhn?=
 =?utf-8?B?SFpUN0ZEdTFldjRmZWsyakphYmtiTm5xM3gxWWV0MzQrTHdWdlBxb1N6bFph?=
 =?utf-8?B?VFlvWjBhNDlWQlNqSDg1OWdpM2JIdTVMdzNON0VVWXpsc2NMeXFaQ3kxUHpT?=
 =?utf-8?B?azVQM3MvOEpqSkc0WDJyekF0OEUvUXVnVHFjQ3lFbmVCTHNvdjhTcTJ1Z0ZD?=
 =?utf-8?B?R2RCMmtHQWJjSkFtZm1zNEN2dDBuWFp5cXFUNWpMWHhuR3NlMnk0SFpEeUx6?=
 =?utf-8?B?ZTNoeDNKVzdMR0hWUmNTT1dNbkpLdW9OTXBqWmNNZ3lCa2J6aVE1SjFaZXBJ?=
 =?utf-8?B?bDVwYmpveHp6R2JXY1ZJV2dzWFE4V28wNnBMMzhiRURvVGZ6Q3V4ZjYzOVVj?=
 =?utf-8?B?MVc0aE5RT091emo5SUdKYTJVUlkwS0VyOGpUcHE5Kyt5TjJpZTBGTXduKzlN?=
 =?utf-8?B?cjVic1Ayd2xKTjVoRFNnMmxzVEZVNUpBLzMyL1hYWjN4eHFNQWxhdml2M1hY?=
 =?utf-8?B?ZGNnanZHY3EzanRsbjF6eFB2M2daYm1SOVZGWHN6ci9FUjArNVROSnR0cUVa?=
 =?utf-8?B?TDRoaDlIRVM4ckFQNjcwT3dGSFV4T0ZjNWF0VG9OY2RyL0JyS0QzV0dBbUYz?=
 =?utf-8?B?cXUrZXNBa21nRTlrV3lKSk1NdHdVUmpGVGxKR0RVU001N0hmOUl1eExUaTYy?=
 =?utf-8?B?NFJQdk01VmhOYWN2amZkbkJ1WVltVDZ5T2VESFArNWRmNFpXbmlORHRwYlJ5?=
 =?utf-8?B?bnpLTld5Z2kvaHRSZWRvdkROMkpKYzBrbHc2SENPa1VSZUErVy9KQ3NPdU9l?=
 =?utf-8?B?L3NvNjJpOUNvZUZPTEIwa1MxOE84TUVrbi9SOXJsRFUvbG1CeEtpZ2trTTdm?=
 =?utf-8?B?VWpycG1SZlBhQ3JDM2VtWVB3emtBQk1XL0hhZ056anNuU21CeWQweDhNUC9R?=
 =?utf-8?B?ekxlb3ZZVHhlZVEzNFBtSm1YK1gxZVlWOStQZTVVSFlyMExNWE0yZmZ5R2pu?=
 =?utf-8?B?Y3JIcXk5TTFQZTJWVGJLT2s4QVYvUFlDU2JDU0tGL3lDU1FmMW5Uc2wvU0Fa?=
 =?utf-8?B?eDVFZFZRUEx5VlRxNm5yVmdpMmdEK0VDYy9kWWFMZmdyQTdpTk1yWFVzU2Fn?=
 =?utf-8?B?bGo1MTdtUEFsZ1orb1BrUHhnMU9KT0VQN0RST041VFNXZTJpMWp1NXRjWGJl?=
 =?utf-8?B?blIzNVoxRm5XODZNUFJhOVliU3dQSkZkV2JhRk9HWDhzdXo3UlFZR2lnU0Uw?=
 =?utf-8?B?NmxrZzhZY3FTSENaNHpINHZwTEdLOEdpQW1WS0xlNUpSMHk4d3g3NGNjVjc3?=
 =?utf-8?B?ZldaOGtreGREaC9UcUtPdFpTOFNwUTlBaXh0ZHZSODZ4QlNlSUlHT0trajdH?=
 =?utf-8?B?YVZjWjIxdE5nU1JVb3lzVjJnd2hZY3RxRmlWd0lOUUNjaVhNbjhZQndMdmZF?=
 =?utf-8?B?emtDdExIclBVaUtqVkY1M3hpbk5JVldHNGZLTkZiWTBFN3QyblUvRXN4Umpk?=
 =?utf-8?B?MERTNG5hQ2FJcGtGdUg3eVE5NERJQnNkS2ZQbjF3S2hhbjF4TGowSklGeUZ2?=
 =?utf-8?B?dmZtSU5SdG1OS3k5Mk1wM3ZJb3VSSTdlSFBXUWRrWXQvVWxiUGpqaWNuZ2JC?=
 =?utf-8?B?WThxeUlER2RsMURUM1JIb0RWanRPZjlFRDhJSEtSd1RqM1ZtbGFVOE04OEVu?=
 =?utf-8?B?MzFzK0JJczVmbkNWZzZvaFJhUFd6N3l4ZlFRcDg1SzJERkZkdVFwaTlRcDJW?=
 =?utf-8?B?bmh0ZjJMcTE1c3ZjMERUOEpEWFJwKzFIZi9KSDZiM01OdUFZamJQa1FKTHM4?=
 =?utf-8?B?ZnFrdDRxcjRPUDA0cXVPcUFhVjhPbDg1SktWaFVydlpiSHNNR205L2NnTVo3?=
 =?utf-8?B?dXl1TDVIWitNekczLzVCb3d5anVrYTJ5Nm01RVFCYUR3TFR6R3JiV1ZGalRS?=
 =?utf-8?B?VGl0elhOa2g0bmllYXdDd203eXRlQzJtY2pmcVdoeFQxemp0cEx1alBCdkdV?=
 =?utf-8?B?azgxQzNERENLQW5ORGpMbW56ZXhXbzJjaGZtQnRGRUVCSDMrdTBQbWoxTDA3?=
 =?utf-8?B?VW80dWppcFIrN0FZazdtSDhwMGlNS2tqNDVzWkd2cE9mci9WZUxvUm82Mjk5?=
 =?utf-8?B?U3V3SC9JN0NoYTJDRTZEWThzL2d1Snp4bmdnRW93bEZGcUNtdFhFM3E1REg5?=
 =?utf-8?B?M1preE1TeXM4MUxXcm43OEFFM1NlVk1zWmdNM2s0WSt5N3E0aTlyUVVhYy94?=
 =?utf-8?B?TkRudVJCSFkxcDIwajhUaURINTlEVlhoeUhoT2xZSk91czRURlBFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2fc79a-e789-4bd1-fdee-08df090f839f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 16:30:34.9697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eY6NdXRKQNJ2i0ujtYFYK77Y7FBlMD5osHxH4XDuhWpv0FBm10jQMx5MUhvKWUHurss68WVdRk+xpTbaL5izXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=tdave@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 9/2/2026 1:15 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> And, yes, the logic to match entries in the fw_cfg file with the correct
>>> device using vendor and device id looks somewhat fragile to me too.
>>>
>>> Existing code in qemu+firmware (for example bootorder) uses the location
>>> in the physical device tree to identify devices, like this:
>>>
>>> /pci@i0cf8/pci-bridge@3/*@0/*@0/*@0,0
>>>  ^^^^^^^^^                             pcie root bus
>>>            ^^^^^^^^^^^^                pcie root port @ slot 3
>>>                         ^^^            virtio-scsi-pci @ slot 0
>>>                             ^^^        scsi controller bus #0
>>>                                 ^^^^^  scsi device target 0, lun 0
>>
>> Good point but the problem is CheckDevice()'s own signature, which is
>> fixed by UEFI PI spec (only passes
>> VendorId/DeviceId/RevisionId/SubsystemVendorId/SubsystemDeviceId). Even
>> though the path exists internally, the standard protocol interface
>> doesn't pass it to the callback.
> 
> Hmm, yes.  Seems to be designed to apply quirks to device classes, not
> individual devices.
> 
> Also note that OVMF already has an incompatible pci device driver and
> there can be only one instance, so the code must be merged into the
> existing driver instead of adding a second.

I checked OvmfPkg/IncompatiblePciDeviceSupportDxe -- its CheckDevice()
is unconditional, it returns the same 64-bit-MMIO-preference descriptor
for every device regardless of VendorId/DeviceId. Merging Fixed BAR
design in would make it a simple dispatch: if the device has an entry in
the fw_cfg blob we export, return our descriptor; otherwise fall through
to the existing behavior unchanged. Does that match what you had in
mind, or is there a different integration point you'd prefer?

> 
>> Therefore, we prepare the blob entries
>> in the same order PciBusDxe discovers devices, so matching by VID:DID
>> inherently works.
> 
> Question is whenever we want have that edk2 limitation and the knowledge
> about edk2 internals (pci scan order) encoded in the qemu <-> firmware
> protocol.  I think it makes sense to (additionally) pass the complete
> device path even if the current edk2 implementation doesn't use it, so
> we have the option to improve things later on without having to change
> the qemu <-> firmware protocolS for that.

I see your point. Sure thing, I'll add it.

> 
>>> I can see that allowing fixed and non-fixed bars mix is much harder to
>>> handle.  Do we need to ask the user to manually set that though?  I'd
>>> prefer pci devices propagating automatically to the parent bus that they
>>> have fixed bars and additional constrains apply.
>>
>> I looked at this again, and technically nothing actually needs the flag
>> to exist. The real reason I kept it is closer to a usability one; it's
>> meant to be a visible signal in the launch script itself, so anyone
>> reading or writing the qemu command line sees up front that every device
>> under that root port is expected to have pci-bars= configured, rather
>> than that requirement only surfacing as a runtime error if something's
>> missing.
> 
> I'm not sure how much of a usability win that actually is, if you forget
> to set the flag you still get a runtime error.

Fair point. I will drop 'fixed-bar=on' from RP property.

Thanks.
-Tushar
> 
> In general I like things which can be done automatically actually happen
> automatically as this simplifies things for the user in most cases.
> 
>>> Also: if the main use case for this is to map vfio devices with guest
>>> physical address == host physical address, is there a need to specify
>>> this manually at all?  Shouldn't we have a 'vfio-pci-fixed' device which
>>> handles this automatically?
>>
>> VFIO GPA == HPA is the primary motivation, but I don't think fixed-bar
>> should be tied to VFIO or automatically derive guest addresses from the
>> host.
> 
> Why not?  It is a great usability improvement IMHO.
> 
>> For the VFIO use case, the admin can choose to specify the host
>> BAR addresses as the fixed-bar configuration to get GPA == HPA, but the
>> mechanism itself doesn't assume or enforce that -- the desired guest
>> layout isn't always just a copy of the host's, so having fixed-bar
>> auto-derive it on its own would be incorrect in some cases, not just
>> less general.
> 
> You still can have fixed-bar-<nr>=<addr> properties to override the
> auto-discovered address for some or all pci bars.
> 
>> The mechanism remains a generic way to explicitly specify
>> PCI BAR addresses.
> 
> Yes, the code which creates the fw_cfg files is generic and it makes
> sense to have that in the core pci code, so it can be used for every pci
> device.
> 
> Nevertheless I'd tend to only expose the properties for devices where an
> actual use case exists.  Which is obviously vfio-pci(-fixed).  Also
> pci-testdev for development / testing / CI.  I can't see much beyond
> that though.
> 
> take care,
>   Gerd

