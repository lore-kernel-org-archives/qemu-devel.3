Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1037FED9E8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2X7w-0003fm-OX; Tue, 17 Mar 2026 12:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X7v-0003eZ-3K; Tue, 17 Mar 2026 12:18:39 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X7t-00048R-NB; Tue, 17 Mar 2026 12:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFupDoBU4w7mi3e5foeMW8WkI8SXxE88uC7GZMmbM3oOH3wx/EMBjNEBHnbX6ustEhj+icVBVEDvt/SKXA5JOf1pim260xsSJX4C7r0xsGZQtzxY0rCVZnMWUPCikIM/ZG2rvOL9teCeTGvQXpm+rVDDdmPXQDxK4heNR29EhH+/nnYoYyXh6JvJ3Yr9hVOmvWDkbBk0gihVeQ27nPYEmGpLzCBde5L2ukBSWPoIMefv/EYJfy6mvFI7HQ6MSTmiifTn8GTHQ/jENcYKARQKxuLLLCUAZaJby8YQoCheifDUZZy5j1RVU2zPEFo9WI9TJbGf7cfD8ZlXEjEdg1U3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4Ao5oa4dvQQNQsbdxHPE4wX9oSg53+P6bT4GjekJLY=;
 b=Q4UFXhnA4BeLpyhUn0kVzZTAKD46e3PFw4sj16ce81QkA21n7ibtbIn3wefo6/ruOsX1AFMpqIowpCsVCi2nCFa8OrWgy9zaKKhJ/20ay+ojfNa7zMsbz0BP2IEovd6AcFsVvGw77h7e9IfkCjRaa4IMcSZ7xhYTXC4JaRmuymnOIA78ALzfCe0+EhvyIuHyeucXtr1wajHkKlnBDPuwfQvf3P+9TCa8Fp42RDnjT3Df/BrvzTLrS2/50eeCBHwFi2aLrDc+0Fi7fwPr1Ac/ilXen6qCcLYtKWrbtwsOmIYXSCiMGKfz/dduBL3uDFcFOjpKwdhHJrlw1khbdObG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4Ao5oa4dvQQNQsbdxHPE4wX9oSg53+P6bT4GjekJLY=;
 b=IJvXCeQeRYembdVJFN7h/wI+iho5vzrxC0ShP7cApq4CXoYv9qbwrO0bxpCGUlqgynYwnGiic36Qt6NPdOyAlzCpvCDWDxuNWFjnXlGXy+Wm+YBLiVTVJhXnZjQD4LFOb1eNYzvDPmxOjqaOoBVTfuuf40wAVLXG2r7Vgv2RS5ZOUNTffqkZ+uOLwACfcNjEJ/k/vihKgCig7lFCZWvwfCvEKDPzv3cSVGXSN+J39/OIG0c3TBkObpbidslakUcVXVfbMSk0BAbd8vbOZyBjnZ/NKsH6hH7CiL9/m/Gvb0ZnOY/Ee4KXR+DbzoLqQ0LvuGtO78vZGLM9DJecJBxLCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 16:18:32 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:18:31 +0000
Message-ID: <ae20b55f-8b4a-4f71-9ad3-110ac6a9f563@nvidia.com>
Date: Tue, 17 Mar 2026 09:18:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-3-nathanc@nvidia.com>
 <CH3PR12MB7548E1905A6500D2D685B55BAB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB7548E1905A6500D2D685B55BAB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3e8b5a-b1ad-46ce-dd81-08de8440d4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +Og+JGjHEENVUFiosM1/hN8+M89KymGVf/FPxoumx+Gpt/1KSx/efk+30OAgV6C5hXi14UIIv+hv/xXxFfdSY5ZdgzLCkJ4gx8XZIZoirKRvbPJh+w4dje9ySDwgLzmWLMT0yFefhF/WzFMAmQh91lTQVu58fQK0iNA1mxs9zkbTF8pfIbdJ5qJeYE/Z34Mw5S7PEhkC8dYwoRU57gbRPgA8S9BcB8t5ykIpl7ONrJmnj1ZctCc83F48mDH/YD6yp8PopnrnfeMFB2cN31ep91sFAergiLFrlPH60PDNEkejkXnAe9PQdUCpg/WaI9VDXhsve6I5RFy2tUODriRH09eYrMCU87rJZKi6HyTGX+wo1i2xOKGBUJZvi8i1rHXOpGKIUzyzyToK5UsqEoCMFR63oPe0FczDiQbWkVySTazaMwFZfJ6BXAwTb7RfW17nuiqBLaQrWSV43BYhWPzNq/raPf4iWKJ/NkO5JX1dna/T/Z98iL146dNT9QfCGiQjqJzsOHzxLbooOCm09PRciWZDGltqZRI+RzulA10jf+ASYrER6TxKrhkyZEoMUNKjPJ8KJjBqN1z/033ifnf3RXTiGxnitWumj3B4grDSl4nfgwkPzkUNZhhTaOE9Uf/3ajUcZAT/o7fHJKpU0bZpkkXXj4gxtvjh5DvHCU/GWXQtjUHBBOYppQ+LyLL0TZzHFqziXEjMuLeVBFlIhIhLE6uPIizjoLAxu1o85p7DSw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpRQnZGM0JxNUNtWmJ3M0UvVWpMbFNQZ1hxakRhaDdoblRtek5aay90K0Vv?=
 =?utf-8?B?ZmRmVDRubVBxc0F1WWZBMHZCako1UXR1VEVqK3JKUmE5MVYvOHVPK2N5SGdL?=
 =?utf-8?B?dm9maG1jSmlYUXpVVy9SQkZDN2RFOGdJODZ4SDVoYzBZWENkSTJHRGU0dkl3?=
 =?utf-8?B?dU9rZEo2UytZZU9JNDVlNjdPRW03d3VTczd6NG9UOGh1NERSKzJvcGtYNUlB?=
 =?utf-8?B?M0xNZlhMeXZ2K2NlQzV6MkdDendIS1dZcHFWOEI0VVVaWHEyM2lHekNrQnE2?=
 =?utf-8?B?bXBxZ1dGa0E3ZVUvSk1UeFZlMmROMzBUTVZqZkd4QTJUb0Q3cDQ4aWZpaVVp?=
 =?utf-8?B?YzRFWTViRWM3c2o3TjVtd0JNcjRNSEMzemV6c05IRW1oL1Vjd2NpT3A2U1hv?=
 =?utf-8?B?eS8zQkNZQWxFM0YrRXR3MWpURkZjZXk0MHdVTi9DVVA4MktCYVVaTHhhUFNE?=
 =?utf-8?B?UXBkcVUxOHI3K0NFK2dTeHo1VjlwQjdicW42OXRmZjNtRzh6SHVHM1NKY29u?=
 =?utf-8?B?L0p4WXlmNzZlOVZUWUgvRlNENFozU1FFRWMwbEtNVjRqdFVjS1VNanFDWmE5?=
 =?utf-8?B?TVNFZkF5Q0dIMUJRbzR6N3E0NENTRUVROXJtV2d4Snl3dTdUd04yL0RtQ1FF?=
 =?utf-8?B?YWpsekVOQW9uckkyc1JYNkhySE1qRi9zN1BiUjlIWGxqb2drdXlKWFl6YWZD?=
 =?utf-8?B?akhUanFONnZadmNqSGcyZlJSS2tFTEdHRkZlYlNsNk9ZWGVTRDRxOEh5OHli?=
 =?utf-8?B?QzJPcVlDbWxLS3BWMk10TTJnbFZHdTk5SUM0N1pjckJ4NlJhQjVLRWhaMFZi?=
 =?utf-8?B?RWhic3kzOXlyQ2wxWnMzZUZPREMxT0ZnVHkvTmRJYXN1djlJeCt3OVZYMVcr?=
 =?utf-8?B?bWxBU1dUUUFMb3pmelB4aW8zclloYjJDU1VoSGdjM3krcXNraWxyNXEybHkw?=
 =?utf-8?B?dTJVUkN1R2tyTGpBR2hIN1dsQzFHZ01VY3BTbDJGQ1hlL2ZsOGtodVJlY1Vl?=
 =?utf-8?B?Y2lWUzRXMUxLNTRsbzlpSEJIdzEyM1RReGJsdHczODU4WlhvOENxWVVYWDFE?=
 =?utf-8?B?WmFCY0tKcndEZVJNeHdXZkc1Tlk2Ny9tVG4yV3lpSVR6L1craDVYb2Z2R3dO?=
 =?utf-8?B?a1U3ZnQzem5hNUZ1N2Z5WDNOTzcydUpNRUtWVCtpVmZSb2VZUkdwZDZneU9T?=
 =?utf-8?B?NTQvaXFIc2VTdjIrMEY2UVJLemdlSThnK2t3RURMSUZaRmFYTkhraGNwdHVj?=
 =?utf-8?B?b1NsR2NhYUQrcEszUml3MFNTNVhTc2NmSk95QmxUdUltTzhnb0hqdHh3ZDhE?=
 =?utf-8?B?KzBHWHZsUHFEMEFhZlNDVkIrdlZGb09YeVdodUhKQUNsTVQwdWZROE45aXNr?=
 =?utf-8?B?aG9HRktrdWJuamZON0RneTFjSkN6QVdUUGFIY0gyNEhOUlNqby9Dak1OZzJ5?=
 =?utf-8?B?QmRyTUljYkVtWENIWnpIbmJESjdVVE1IM1ZxdGNHb2ZBRG5FeThweWJhYktG?=
 =?utf-8?B?aGdRbGgvN2FOTnBrYURTelR0OGxPaVFTbmFvcG5VNUVZeVNGVXV2REVaM1FX?=
 =?utf-8?B?aFRXNWlmKzVHWmNYUUNCbHorRHo1aGxyLzRSMGRTM1VOYi9rckxMVU92NDJM?=
 =?utf-8?B?SHRESjkvdm4ydjhuRkVpYUl5Y21iUlZIbjZVZk5EamhLNUFqbGtzOEQwRHBS?=
 =?utf-8?B?L2h4ZmZMWVNzWVpwaUdNbnBkOWFMMTFNSVJ3QW1vY2dMdXdSNmhpdzh4aE82?=
 =?utf-8?B?b0hwS0FEcjZidFhrTnhDTFBNTDFaS0lSZGEyeUZReHBhY3gxbWZaWmJGandO?=
 =?utf-8?B?Q3VyMitacGdGcmdyYURTaE9VaFpzWEJmSlFDMzkvSEJsSTY2aEFjaEtnenZF?=
 =?utf-8?B?Vm10M3FlYzlVMjlpWVR3K0RyZ1pYRUVaNFREOXJaZXNjMEhETnVSa2hyWjFl?=
 =?utf-8?B?UHN6bE0yQ2hWQlFORmFiVXY0MjRrTlNwZ0pPUnFDRWpFa0VYN2pzTktQcjh4?=
 =?utf-8?B?R21XdEUrb3VCcDBoYnZlSU10OFdHRFBNZFFxTmVBdjQ3QWRwbFBzZnlERmNv?=
 =?utf-8?B?citua1pvRWE5ODZ4bVlGdzY3SityTmtUblh6d2gzaWkvVHpEZ2syOWFBaEtF?=
 =?utf-8?B?YnhxMUVFSlZadFFZNVV4Tzc4UHZyenczRmgxOE5uYU1DSXpraU1RZ3hCTVlr?=
 =?utf-8?B?cTh1UzNzU3AvbWNkTzkrZ044K1lZa3hzYVNYd0Q5MGNlSzJTYm1tVHZqRklV?=
 =?utf-8?B?MjZvVys3cURteC8relFodzA2TWRkY1hlMExRN08rRnlmMUVKcEhROGxTc1R0?=
 =?utf-8?B?ODJDVi9uTFI4Z0Q0N3BndndxenUxRG85ZllWdlJMYlltank0dmg0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3e8b5a-b1ad-46ce-dd81-08de8440d4cf
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:18:31.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXiXTHklxFrunII9YQGiuRZNupTVPqf2SJCCcFLFLLgX5lZAzjZypdnJMw6zhFxVb5yKbA4uNlddAR2cp1JNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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



On 3/16/2026 1:48 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 12 March 2026 21:03
>> To:qemu-devel@nongnu.org;qemu-arm@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Michael S . Tsirkin<mst@redhat.com>; Igor
>> Mammedov<imammedo@redhat.com>; Ani Sinha<anisinha@redhat.com>;
>> Shannon Zhao<shannon.zhaosl@gmail.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Daniel P . Berrangé<berrange@redhat.com>;
>> Eduardo Habkost<eduardo@habkost.net>; Eric Blake<eblake@redhat.com>;
>> Markus Armbruster<armbru@redhat.com>; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Matt
>> Ochs<mochs@nvidia.com>; Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH v2 2/8] hw/arm/smmuv3-accel: Change ATS property to
>> OnOffAuto
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Change accel SMMUv3 ATS property from bool to OnOffAuto. Setting 'auto'
>> will result in the default value being used, i.e. 0 in IDR0 which
>> translates to 'off'. A future patch will implement resolution of 'auto'
>> value to match the host SMMUv3 ATS support.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c    | 8 ++++++--
>>   hw/arm/smmuv3.c          | 9 +++++++--
>>   hw/arm/virt-acpi-build.c | 2 +-
>>   include/hw/arm/smmuv3.h  | 4 +++-
>>   4 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index fe78ce69a5..5d14abe307 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -827,8 +827,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>       /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>>       s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>>
>> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>> +    /* Only override ATS if user explicitly set ON or OFF */
>> +    if (s->ats == ON_OFF_AUTO_ON) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
>> +    } else if (s->ats == ON_OFF_AUTO_OFF) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
>> +    }
> The else condition is not required as ATS will be set to 0 by default.

I see, I will remove the else condition here.

Thanks,
Nathan

