Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117ACCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRRJ-0000YZ-DZ; Tue, 19 May 2026 16:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wPRRH-0000YH-F2; Tue, 19 May 2026 16:53:19 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wPRRF-00077x-P7; Tue, 19 May 2026 16:53:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUN1QYLJ6aqpSV4c4lSwUbgX6j0BWY9MLePq2qsh/BdTzPKxDUlbEWQz0OTusSxtQDJY7LxlWAaYO5JtebNDCYPWS+UneFKEDdGxxckc53Tck00xeJd7SEwZMqG6I5TqJSp/PfxaC5MWE1buEx7urUr0u7pGcvP2L6MFrRh6Id/GHHHtTFd11I04SwhB7WXWdUJ8r6sAfwQps0f1ZW+GV9Yt9xvv5KlJyHJcFMy929xvXZUTgizNwpr3+JwqtkMzt1cUEh+e7KsrVoMtNhf+WgyTQrXZgiPW4IA1eSbimCHxG0bv0VS5bzqkciAcPrlLOHa306yRqxCqxLRPH8j6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYQbZpRtTfqCG1Z5qaMp/YUIVviAl8BnSdoqtAstdeI=;
 b=dXsLIeM7Fepyu/41XKwyu2qLqd341wYTqv0UTANi5yBhiGuWVcbBxSG25PjkdEJS+BUtrXhrzgmseaNC0zwOjslBr/FTkbqtm2uMJMcpwSAmEsjZ4BRzuCYFJK0Zll/PGbf8y1iUZlGUpJJAcXR3jvYhy/+jZm2tr5cDKiCIaDQxDss/Ik9MluXcQftRPmvfIideFkOj6KhaOGx1Y+IpVzp5xwcMWDhKSm+zk009jDq1OYNOdoSU320vw8YLDt6rCw8lKBvWBAjf5v2UYk84PHKhfbHEF6OV5H2vAzER4Un0CABXX8hBo+jja4x3zwRqSgAcfcJbXI0Ik+84SvmQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYQbZpRtTfqCG1Z5qaMp/YUIVviAl8BnSdoqtAstdeI=;
 b=oWUk1nVvRkPW3oXu99mh1TGc5+VlrUfFtXMR3WXkGdCCzsBir5jlIMTW/JwAHZoOQvOpe6pZb8iKPW0JYXHtFbnXs/M5dx9E8MyCvG1HTrAz7as+TanFIMG79tJSlkYcZIDA1Iqd3IzwZE/ZSJ788tjV6uccwQnKExiOnRbA4VDFBi4VlekC1qqANMKi8/1TFr2o7twi2ZrwBW40n1e5UKtEcK5ACaJk92j8C7y7iDsxT2uFrxjGgCpz53CZ/MxX16LJ13hJueAKJUr0S5kK9IVyVgyKweIpBMf89zZUcKMIC6ZKilooPt0sh2cQvCg/6TR+TC14G2ecfq/xaaTwbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Tue, 19 May 2026 20:53:11 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 20:53:11 +0000
Message-ID: <33370934-a239-4215-87d9-2cc64648a258@nvidia.com>
Date: Tue, 19 May 2026 13:53:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-8-nathanc@nvidia.com>
 <0e747538-5e87-40ba-ac44-bc7bbe89bc7f@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <0e747538-5e87-40ba-ac44-bc7bbe89bc7f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: c6653cd8-ba10-42a8-1968-08deb5e8a344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|3023799007|11063799006|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: p7EpzEf6nWVVuRHDKl3HOAjPty9oWX79Bq00h8SvsyJTsN8GCpGgn9YrApsflqzK4dIzsigMyjY4g4MwwjkVk9YT6unDuotoLKkDL3oHM6Zi+kTUINkWO5kuipd2+5unG28gr0VbKQLxyL9W0+AIB2B04TF6fghkUi92/ZtWcW9Rff12M9Zc7KdHSmgZmNpexFu6ArewTt6ik9rtdzm2ZwupTCbSwaIeZZVMQ0NBy+rRXIIOygWfM3ThfDREneES59W/a4DOUqddnUVAqfigs1WKQd/SY1UWJnHP8ltqR+IHVDff/rsOBFryrn6gEAN3QwOypI2+NEJT95ZBuSFOH+cwfhbPfFFAfLpt+6DVUfo7jYoyrnJh7Wn1GEXYY5ii4weGc9sh9Rg69GQnnPPXdkyA2kSg+ZmuKlMJM/k1Q2fu4DfJgyZEHJgfZqV8qFVUB3UtOtU8k3vMHX8bme77Ykut3YnqwCDacwKc8txwEdKqDnJPODgNpom+1u9Ed3F3neLH2cqDYUatIgq3nKOIBHNL4x/+BTVxIUOb6CwpvClmT2gj+TwPCXnNUJipO5ZPrJxLOmZCKdUxZmQSEUVTrsKCU9jWQh3RbVuiwyVnuN8VlljSDN201aeEO90PepyBs72PvpgMuF25Y/kjkC54Wt18P+geYgM8L5UZkGl+cnOCrDC4FbPCYEQqvMBZ9zzI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(3023799007)(11063799006)(22082099003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhucDFxRURCeFVHZHhvR3hMS1pLQmVpN0FZUVN6NGZKUXBZM3hvck9VRHI3?=
 =?utf-8?B?eDFmVXhYWmkrTTFqUEJMcmc1c2d1dnNhcmNLei9jK212THNlVjNMaGdSSDU5?=
 =?utf-8?B?eTR0ZkkzUUFxRUs5V2JKUjd3OHp2eFJNVndBZktxcTVFRGlJSFZlZnAwaVI2?=
 =?utf-8?B?UzZEZEVNWnBvTC85UEI0RGRET1NEbUFIQ3BNaUh3UjNmaXluQndMNmpEdFM0?=
 =?utf-8?B?bS9DWC9hS1VhSEhuWVJCVlhqRmlCL2l1aEp1V2Vwb3krajNvMkpqYkZxNkEx?=
 =?utf-8?B?UEZYTGtxMHBzTmdiRjJraEVvdi9yOVlGRG9yTThVVVdLN3FFcFNYK1p5Y09R?=
 =?utf-8?B?WmN0NzBtT1pWNWRrY1VJbDVVMEdiR0Nrd0ZpVkhldDAwS0tJcGYyWm12Y1Zq?=
 =?utf-8?B?SFhUaHpPM2pLYUVXbW41N29kWmN3M1BqK2JERVhtQlRTSVlUb1QxejJud25o?=
 =?utf-8?B?R3NWYjNWZFkwdFpOaEVTNnZrdUNlK1ZwWGZZUDZYU0drWG5MWUNnZ2NSazNK?=
 =?utf-8?B?RmFvYVJvR3hoaDY1MmZmYWdqVjQ5T2VOeXM3VnF2OEV4T2xaWHZSZkZiVzRG?=
 =?utf-8?B?NGZFRTJLT3piYzlvZk03SEFoeVZYcCtQQ1JFOE83Z3I0NURIaFBxWHZ6VC83?=
 =?utf-8?B?cGVMQkVPSjhXWUhvM01iTGl4LzUvQjRCeFl2OU5TSjdrbGd3ZS94S3g4VlJm?=
 =?utf-8?B?VURldG5TcVlGY2ttSUxaaUIvZmRtUjA0TGNrRjQ4NThCMWlqK0FWRlNrdG53?=
 =?utf-8?B?MHF2aFVxTEM1K3p6azg1QmZ2NC83WFUzdlpDZTFuek9ueXQ3UWhZV244cFpr?=
 =?utf-8?B?VmFHWUFId0UxU0htNVBsRm8vZ0VVNFFwRHdLa1hiLzNDTEplWnNDdDIyTHRI?=
 =?utf-8?B?NFVxc1F3NHNlQzE1NG5wK0FidEdiQzFxNU9LL21PaG4yQWUyNzdrckY1b2lS?=
 =?utf-8?B?bDQ5TTdBNzJkRTFsU3ZqTytRYUo3MXZYRkpvci9vRGJvdEhRU0lISDc5bFNX?=
 =?utf-8?B?WXhsUkh6b25kaU9kU1I4Y0s1RWtYa2pPbXZGam1GU2loUDhUWVhTYyt4ZS9H?=
 =?utf-8?B?WWduU3plL1FQSUtodEhPNmxXZXlGM3NOZDk4S1ZySVBCU2xmM0JJeWpNak9y?=
 =?utf-8?B?NUxoS3dDMDlWcGFaTytjVVpLa3lNU1REK0NSNU9TVU5IMFkxT3o5WXZlSGh6?=
 =?utf-8?B?a0IvbFZaUDJnYUIxSmRLN1RtQmV6SmMxZWdvczNzVDR5bXdqVDNMcTFJRkdZ?=
 =?utf-8?B?OHNvQTFpMXdTKzI5SzQ5NEVzYk9PaFUxM2ZPZTRQRXExRjNnNzFTT1QrN1RM?=
 =?utf-8?B?dHhvQ3JVUis1Q0VVWGhYUXNpck9wQ3h6eENqbnlTZ0UzbzNSVEw4aGovQjNk?=
 =?utf-8?B?NkhjV3BFVi9YM2NoM1ZDMFV4ZGlWejJXWHFXbEtZMDRMbE1SZndxTktkSW9y?=
 =?utf-8?B?dldhdms3Sk4rWUlrZmxXenI2RFhCU1F1dUZSVmJpbzBQK3gzR2N3aEw2Qms5?=
 =?utf-8?B?bEFlMGVCcklNQjhTQlF1cnFweCsrUXQ2Ni9LaWp0RndXaTd6dGdKRWp2eGRK?=
 =?utf-8?B?bmdSRTdmLzhkQXFnaE9iSzRVdE0yLzN0WHJlTUc4UWQza1h2YXZhVXlxUi82?=
 =?utf-8?B?WUpCSUsvRTB1SUZwcEYzdSs2QjVTM2k1ZUFyTy9Xc0s1U2lTYjdzdTVnazJi?=
 =?utf-8?B?MkZzdmc0MWxvcUtqQjB4L25jKzN2RFNsbFRrelJEREYvT2YwaGwxdWl6WDQ4?=
 =?utf-8?B?RkpQbCtRMEhKL1B0UXJ3NWdzclZNL3Y2UndjZHQwN0hPRENFRG5xUkNnVTVD?=
 =?utf-8?B?TEtyWEkvTlhVT1hYQ1pVY2thVjVDSm9nbkc5ZEYzNmkwcGFHNDFEYzFJUjJ6?=
 =?utf-8?B?NkQzWUpmYm94UjZqa0lCNkdBbDh1ZDVPSk1zTEZtNjJZeFdPaFR3RGQ1aWpy?=
 =?utf-8?B?SUQ3U1VVd3NIZ3NjN0ZaMXZZY3hYTFZoSldUVlpvdWpnYXNZYUdOSkxkVFlh?=
 =?utf-8?B?OFA3cyswQkI4QmF6cDdpZTVmdXlQVUUraERRNXJuWmlITWJybDVBZmJzS0Jl?=
 =?utf-8?B?UFV0M2dNY2cxUzJiQjNvZngydWM5dzNNTjY4UE5pL0JWZG1JaGNDRGFaZ29Z?=
 =?utf-8?B?Mk85VlArbHFyRGtzd3FaNGRkNmFRekRFMUVlZW5mOGgySVh5S21oaTJyQUxo?=
 =?utf-8?B?T2gyTFdUMzJuYVZwajNScjFqb3FsWFdwSHFpNGtSL3FscEdFSVc4ZDl6eHky?=
 =?utf-8?B?RWVTSEFuaER6WlJ4UTcwNUkxOGxQM2d2Lysya1paVnJjTW1welh1UUxZOTA5?=
 =?utf-8?B?aUZJRDZhLzJRTHJ6dVBPSmUwQVRpN2ZaQStOR0E5Uk5xYVYxN1Zydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6653cd8-ba10-42a8-1968-08deb5e8a344
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 20:53:11.1018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk3TaUlyDckokCyDvlLGzhANi3wUmITlqfCGDl2eTknl+ZhCdKz9z4t092bppEZNNCMaedtNMMLH2S0cRQlOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Eric,

On 5/19/2026 9:03 AM, Eric Auger wrote:
> Hi Nathan,
> 
> On 5/12/26 9:35 PM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Update documentation now that "auto" is supported for accelerated SMMUv3
>> properties.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   qemu-options.hx | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 96ae41f787..46b02a1bb3 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1291,30 +1291,43 @@ SRST
>>           Enabling accel configures the host SMMUv3 in nested mode to support
>>           vfio-pci passthrough.
>>   
>> -     The following options are available when accel=on.
>> -     Note: 'auto' mode is not currently supported.
>> +     The following options will be set to auto by default if not manually
>> +     set. When accel=on and these properties are set to auto, the value is
>> +     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
>> +     accel=on, this requires at least one cold-plugged vfio-pci device; if
>> +     none is present at machine init, QEMU will abort.
>>   
>> -    ``ril=on|off`` (default: on)
>> +     If accel=off, auto values resolve to the non-accel defaults given below.
> [*]
>> +
>> +    ``ril=on|off|auto`` (default: auto)
>>           Support for Range Invalidation, which allows the SMMUv3 driver to
>>           invalidate TLB entries for a range of IOVAs at once instead of issuing
>>           separate commands to invalidate each page. Must match with host SMMUv3
>>           Range Invalidation support.
>> +        - With accel=on, auto means the value is automatically derived from the host SMMU.
> instead of repeating that sentence for all props you mean put it in [*]
I would like to omit this for all props since it is already mentioned 
above "When accel=on and these properties are set to auto, the value is 
derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO". Would 
that be OK?

Thanks,
Nathan

