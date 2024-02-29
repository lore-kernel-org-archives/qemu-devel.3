Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43094C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfi4H-0005GZ-Rs; Thu, 29 Feb 2024 10:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1rfi4F-0005GH-11
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:11:27 -0500
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:240a::600]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1rfi4C-0000Sv-VG
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:11:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKIzbGVTFvNH8Iq61u+mAExlcNIKMktP/rh5alQsBkTIFhW8vrdWw3qX5Vc/9960bz044G83hSG1Mr/cRAbUzSmRwmgUTMeB0YZ1wzohOH+nT1TsSzJcDCa36h6cnzsXzFXygTICxAn3yfi2McIQCjjaUmFCBaiZTsrF8umqc8nibO2AgfniKZcVSaNnOPHSCh8900j/5AUxK1LLJA3m2aJdxk7AKQu+zKOiehx1+yUpPGumm58rzi3fx8TevlusMZIDZ0aXCw72TFZAUW3wK4nGsuHuFYs/r/CQO8WxcCEQfD/IyPywe90CWZNvBaYHN9jgh5FdAjOIEVEt2DU0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d1gt0NG0Iz8VWm9zEnZsg6f9zjHxAy7EU8/y3QW6p4=;
 b=b9xBBRZRmJ/bN5dx4K1Hn4QsVk4G7488lMw3c8/mSZasIkjdP3Aa3XV+K9jJO2FTOK/ljtRiDML4Re6pXAdmY5mArCVLD7yIjD5RDMcE3W3CdCmt0JJykeuK7KatSU0kKWjiNL4kM1NIOYXwIeXzRYMtJ6UhUNN6xOaFuIS7YskCSnPvxW3aKyAY4WsmGnyEzfsLDJ4ZmVwvVAZeTbpbDqahJdvkGfvqZhjeRejQLyGTYDYIzwhvQQkiYh1TsNyCLOwB7CoqYnub0/eo/B8se+soibe8jHEvMAzJOT18RStrE5g1Ut2SaSRDSIjLMQ/fLyLDMo0c42f+zy64X1OB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d1gt0NG0Iz8VWm9zEnZsg6f9zjHxAy7EU8/y3QW6p4=;
 b=CwXQxW3fxn+Txt0NqAXqQ5dH0ir2mPHQMLXJG9C8Q5E3XYRzzbzuZfvwjB9LuKEWQQlKhV9pyXgs1KJw7uWF+yD0unLOVBG7eGzY6yFEFnlUmIquQCddLP+7SnZmN05UA3n9sDo2RkllmhZVwUlRxp34Y2fkpPS2MpgSEClPBxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 15:11:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 15:11:20 +0000
Message-ID: <a67f6856-e5d5-4fb4-a94d-7748979bbbe9@amd.com>
Date: Thu, 29 Feb 2024 09:11:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/21] hw/i386/pc: Support smp.modules for x86 PC
 machine
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Yongwei Ma
 <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-19-zhao1.liu@linux.intel.com>
 <3ab53ea9-be77-4ee7-9247-d89c0ec62346@amd.com> <ZeAzB/ISM+g/XGa3@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZeAzB/ISM+g/XGa3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0034.prod.exchangelabs.com (2603:10b6:805:b6::47)
 To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8baa52-6066-425c-57ff-08dc3938af86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bB77FTF12O4qm5s8LDKUbDB91rEF5viN5HlTFQ9RJhayYY0EVrzlg9ysZ2ZoWLotmjBSmIuUhKMSP/7BFs2mWbqMkc6G7yGJJ1pzeQmb0e4da9XXgIAqjxpj2KmB+rw0pqvidbVb8AvRtRhRqBHIo0+DurNNYSiw4ZVzM+esp3c9us8v/Cp3Vgp/dhig7Lt7HGGYfOF2GhSdjDaRuocLZCiBjOeh7tC8kcKXT/ZzQ4djzNlZLUeX3GKAPEppYMWW7DVmdQWBptq0P+tIckmj8VA49YfumuDw11NMGwsR27B9TWGGzggSwY5CLKk9ocU9tCC8nOaz7gqgUtubT8myYIgvrIM19FdJDxo8NlMPTrqz8X0xmf7v2UVLvwPkda2mVInw8gJazCEuNHjCEu60mMo32jqowHUglm9bIUt7j0TFevClNJFfEq/kSVfvXTOVbo05BKoWhs48Kw2dm9fXFcCe6t+21RlVCwjK5RaNizL/KTGOBxDE1SotIqauSm/8ceixCfA6Am1kaV6iEWE++yvuxPXmag4oSlnSxSSdCpPZd0FSWn8QFeYC2jIdrwevMsr2Zb1gN0jytHBCoNUubJ4r/GenS7Tn8dTRLu7zx/dUpGYcviXGU8Paf7BV0a3l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b29XSGQxSzhhSGExRkl3dVZwVkhZRy9KbEtOR1NRWnVMUUR4cTlVQnpxVWdQ?=
 =?utf-8?B?ano3OWFDSDl1TTdCbm5xMGRNd1hSOVJ1KysyMmVDT2ZFcFNkNDBoWDJSZWJK?=
 =?utf-8?B?RDY0dkpDZHJnc2RrbmJpeDBiT1RtZTZlZW1sUmIxZ29zWnJBY0IwQmx2Ukdy?=
 =?utf-8?B?QWQxbkJoTGJHM1RwVGQrcW40L2FXVlQxbUpmVWVvU0VjbWZzOWkxMEpuK21B?=
 =?utf-8?B?SnpzSjJLN21ITCtwV3V1VGcreWwwM25PZnpzUCtQQ1l0S0pNSzlvakVYdVZ3?=
 =?utf-8?B?andJLyt5MmNTa3F5YXBmWnN6TGxXZ1JGSDZ2bkQyTGUxQ0ZhY1lnT29EY2ZY?=
 =?utf-8?B?YXZPWGROWVcrYXJwVzRPeHp4RTF2TFVUOWhiM2o3cDRvcE95OThYZ2YxNWQ3?=
 =?utf-8?B?RytvVmJsaXlhdzI0R2kxSytSRTdrNG83YVlmaTlzWlpjdEllaEJybFNKS2tP?=
 =?utf-8?B?MDVYYjBIQ2E4ajltTTZvTUNLSkZZeTkwbzFrWkFZWWd6a2xhZy9xRkwwWVFV?=
 =?utf-8?B?ZFhlMFRaUGhBNUxyQ2E2ZWZBYk81RG12bWZacS9OWHhGMi9oOFk1TzNOcHBX?=
 =?utf-8?B?SnNCNnJUMGVhV3Exa2xUQ1ZqdngvY1V4MjJqdmJFd0FYSjdubFN6M0NDZFFm?=
 =?utf-8?B?RUJibjV2ZVlKRmxiTzhCRjNBUWRHVU84aXA4cHY5UGRzOTRZOW4yZzZ0eC9u?=
 =?utf-8?B?S3pla0UrVzhCS3FCVFdINVkwYW80ckRnNEJQQXViOE1jTWg2N1k0T1pzNWY3?=
 =?utf-8?B?VDhyUGdKTDU1d0RZNmRTWnRuUThodjF0Wm1Fa3d3V1UxbU80RERDenpuQW11?=
 =?utf-8?B?am5tZ2JFTmhqSGxRTEdjV1AweXJ2Q3hrVjhnREVYSTJwNFczSHViWlhBVlFz?=
 =?utf-8?B?bDFVaXorNXNQRzg0elJmSy9CTEY4TTVJcnhKaEMrZGd1TnBhdmhrakoxdHUy?=
 =?utf-8?B?ZFNLZ0ZzNmNCY2ZPeVFzZjBIMDViZko5TEJQUUp5bUJ0VmVrdnJ1UUZteGtN?=
 =?utf-8?B?bjlEOEtwTDdXQlBPKy9ST1dtMWl3S3l4a0duS3E4b2QzcDNIRW1sUFJadTJq?=
 =?utf-8?B?a2dwMG1WaGNsYVVNV3hNN3NsMWQ4UjJNTHZVSm94VFlGUnlQTDUxMmxvbE5v?=
 =?utf-8?B?b2EyL0JDeW5JcXBoZ24xMmpUUUhGZnlESWVVaTZXaHFKL3RON3FodG40SUVK?=
 =?utf-8?B?VWlkMExiMklsVGk0cDRXZ3V5ZFVtVEx6VDBnNWROQlI4SUd1eGlweDZyZUNV?=
 =?utf-8?B?WHZHcUJJM3d5Tkp1V3hlUkpLaGlXWlZGS2x0cnkrbG4zb3lsN2JUVFBiY1di?=
 =?utf-8?B?QWtYOHE1blppeXQ4Vm1nMWpIQS9Ba2lGRUtTVjdXNjl3eVlXWlJnWG9SV2xr?=
 =?utf-8?B?ZCtYMjhaRWRFV3h4YTF1anRTdE42N0IwYzByakxrWXhiTlJRQUJOOTBNclVu?=
 =?utf-8?B?Q0ZWOXVrV290ZFRWSUR6OEZIYVEzbEg0TVlxN3FJMHZyaXVhRVZvSFI3MTUr?=
 =?utf-8?B?LzBZV04zaTdKa204VC9HNVRTcTFwaWZKYWhuUHdmNlJySUZTRlFhdGM2RlFr?=
 =?utf-8?B?eGFqMWROUmliUkh6dUhHTitsQ0xZTDlkUk5rOEYvYXdXcjdxRCt2M0V3cnVp?=
 =?utf-8?B?Uk1FWTM3SzhEYzNsL0l1a1V4blV3OTJjeG5rdUZTelg0NU1LMzMzN0E0ZEh3?=
 =?utf-8?B?d0VYanAxQTJ5SE0ydTJHZnl2MVNDNE9JbDh5QnF5czVSeEVHU1V2eHVZUTFj?=
 =?utf-8?B?aXdpVTNKOE5VbUpFTVVyb01wL1YzcU4xQlpKb0x6dW9xNDhMdytpNXY1aDRP?=
 =?utf-8?B?SDBtbk50eVpaanNGeHQyNFM2NFNULzhmZTlQT2ZocnZkcGp0ajE4T0dWWjBi?=
 =?utf-8?B?WS9jdElubTRsQXBBS3RHWXk5UUEzdVh4Y2RUTkMrSW1FNXlVM3JCS3JjZlBu?=
 =?utf-8?B?SnZwQk1md2txb3lrME0rSlliZmppYTRRcEZ3cjRZbWMyNlJrVVhpcUE3UU9F?=
 =?utf-8?B?bUpaWXZqUlFrQUNtR1ZTR21kUlFrZ0k2endmMlR1c2V4b2xxcCtEa3RjMnBV?=
 =?utf-8?B?L0NkaTVDU2c0T3Qwd0RrZWRPcWhOTUMyWE5jclJiaFNHSTArakRNWnpZU2th?=
 =?utf-8?Q?kFyA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8baa52-6066-425c-57ff-08dc3938af86
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:11:20.7423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFSMRgYux3lohThQNl2j0+H4gKs9CybNx0o0zwKtefl/RfpREKckK+Ch087cgnZp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
Received-SPF: softfail client-ip=2a01:111:f403:240a::600;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/29/24 01:32, Zhao Liu wrote:
> Hi Babu,
> 
>>>  DEF("smp", HAS_ARG, QEMU_OPTION_smp,
>>>      "-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]\n"
> 
> Here the "drawers" and "books" are listed...
> 
>>> -    "               [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]\n"
>>> +    "               [,dies=dies][,clusters=clusters][,modules=modules][,cores=cores]\n"
>>> +    "               [,threads=threads]\n"
>>>      "                set the number of initial CPUs to 'n' [default=1]\n"
>>>      "                maxcpus= maximum number of total CPUs, including\n"
>>>      "                offline CPUs for hotplug, etc\n"
>>> @@ -290,7 +291,8 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
>>>      "                sockets= number of sockets in one book\n"
>>>      "                dies= number of dies in one socket\n"
>>>      "                clusters= number of clusters in one die\n"
>>> -    "                cores= number of cores in one cluster\n"
>>> +    "                modules= number of modules in one cluster\n"
>>> +    "                cores= number of cores in one module\n"
>>>      "                threads= number of threads in one core\n"
>>>      "Note: Different machines may have different subsets of the CPU topology\n"
>>>      "      parameters supported, so the actual meaning of the supported parameters\n"
>>> @@ -306,7 +308,7 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
>>>      "      must be set as 1 in the purpose of correct parsing.\n",
>>>      QEMU_ARCH_ALL)
>>>  SRST
>>> -``-smp [[cpus=]n][,maxcpus=maxcpus][,sockets=sockets][,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]``
>>> +``-smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets][,dies=dies][,clusters=clusters][,modules=modules][,cores=cores][,threads=threads]``
>>
>> You have added drawers, books here. Were they missing before?
>>
> 
> ...so yes, I think those 2 parameters are missed at this place.

ok. If there is another revision then add a line about this change in the
commit message. Otherwise it is fine.

Reviewed-by: Babu Moger <babu.moger@amd.com>

> 
> Thank you for reviewing this.
> 
> Regards,
> Zhao
> 

-- 
Thanks
Babu Moger

