Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CCDC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1WUp-0007hI-R4; Tue, 01 Sep 2026 17:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x1WUn-0007gN-Oe; Tue, 01 Sep 2026 17:58:21 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x1WUm-0003Ko-0W; Tue, 01 Sep 2026 17:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSBUOwqijquk88e9L9kkZVHTfp3lJLnNtA/rupfNasAmMajRlog8qWbkF4C98OGuvMn12Hx67v5J2oqrgVFrKmIfLKYjAXcd+wBQ7vzTgmvF4pizAKqp7wlqtIJqirhHnjUXcu5Y8cdp8S8fPMQOisyf9PWomOJ+GkJDoDwkUirHWhafZM2WlRNce7YD8IKTtGMXT/Ud3pEtVLoOw3Vcchw/Nl+XsJW+aKq5L4ptj9OQavUj2tFjhy0PfMdK7a0eied8xbsC3VoS1RCw9SWKPipgIMrBZ/Qe7hPmLIUs8Mtzx6+BgNiacRBTpjWQ0JrgsPs4NieuFs5mzqNrKBdz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gyrmvcm0Cww0eakvTd1LwQl1AOl0M1Y4cQ0Ti+u6950=;
 b=VV0hO3L4UrLATeIOqN/ld2yGGo2L4JQcl3pf0sbAxrKE2NA+7LM/2CrfTB7Hw5suIJ6L0+Otpotkfz3ccGraSAB8y0CjpYSKyPhJTWavU2Bco2PytkLHvagCY6xLb9OWLjvxvja7Fd9wbAy/Cme0t2jgqA3sJD8Wj4bO2o5WDdlo/mYET4JvKkt6wU/VOjXxAOTPWDPHIVHMzipDac3lWOc6rBKOb63Iew5z83KlV1s5IkFscBQnH0O3+TXMeTWqL1lxDbfN+J2YQgJ7J3l4pK7B8dA/+LB2PcPJcXgkwbIoeJnUc/xopijyQcScZXd0W3BnYss987u3ttiJBc3pLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gyrmvcm0Cww0eakvTd1LwQl1AOl0M1Y4cQ0Ti+u6950=;
 b=coytB5BKtdwo1jnj5cPMVjZLU6b6+hKUOo9IwZahLVUgeHpmEfZJfZ01Be5S1l04EGEvPtfvGpBjyhsM0i7OXOEXDAxHXVUrG+1DbkCDCXxseEzknE/FV7XOQU9wzAvwbqXs9kCwCsEvEJV6+bG6OMAbT+gcLh8hWWHxZ1pqo/ggpbV5FPOx2cLS/jCUkpyeUqoWg3wrdU/7VGaVlSAmVxZJq2hwxxsHUYEgBbYHXcI8yehLgDVJMmsaNVKhZn2NWjLGGx+FWOmxYMnRv8/oU1XEV/kvHBOpUf4Fq9fmXF63+B3jzLivQw+gDdPTQu6lsSB285ZT3n0StWbxa9+rTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 21:58:12 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 21:58:12 +0000
Message-ID: <39c5034b-7bfa-4f04-84b6-42cee42b0c96@nvidia.com>
Date: Tue, 1 Sep 2026 16:58:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [edk2-devel] [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI
 BAR placement
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Alex Williamson <alex@shazbot.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <46b4544a-6e97-4433-b3e2-60cf43e62c7b@app.fastmail.com>
 <f2fe3c7f-4a8f-4025-ac09-777eb5cfc31c@nvidia.com>
 <apWAprXWglNIWjdp@sirius.home.kraxel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <apWAprXWglNIWjdp@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0128.namprd11.prod.outlook.com
 (2603:10b6:806:131::13) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 489f1290-9d2a-4187-2fe6-08df08741de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|3023799007|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QQTFBkrIZ5wiUveHolz+adLhVC1lieOmKUamJ7PcXVEoGFJ4vCIylKEp4sBlCzdiFmkVbr8p+OPLrbq5MAeDQ7yKr5WNaCM104i/gTIbwFc2YgxbWnY2KgqF3XYBjCY/JEibVNdXPGw9+ct4/zbJ7LWtgFYIMUJUYGAU0v4H9LMvtoYBGOVag7IaUoHhMS+P7TIUg0wP13JkOuaGWxUKCEPGRwBTyDSbJkDEdtu9+GwfcN+2TQwACEMgUEltB0RkJQUHL9EA5jwvE7pjn2rPtHxWnt89+qOtUM2Fl2i9ppFIthfKbWDy5LUbch883v3Tw+32vuvzxElmHPoR1vI1F5PtaXT2cQNFAF8yGaKxmXX8QmzV6mM/UryfMcJxzubADHyIrIuVbscIYQvHZZh+7iKIUcvdQbNKkDlvt8uC8pwwupww3Vlv3KmSCYkoGf1ydXmAKNo9LuvJBdMye9tlogbU3EOa3Agf9qwo+uAhTP2C+23k1A5QczrDlzdUZoqw0kl5QN8o6HNxsv/gZoPFrUvClB8P23vdZdcBK/3cGYWZqqnwbADbGDjvw6dUAOMFvpZZXORHkuIiXjnv7jzfxUsbRngds9HM6Tro1w7A7ILIDJElQIKyXhqVZ88bzLkSvtOwODbDxAkWpF1lTQvpQbDQt3WaTodBkmACLDwMsbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2hQVWZLNmppMVRjL25xUXZocVdHNHJWNTZlKytDR3Z6b3pSRWVNOTgrQ1U4?=
 =?utf-8?B?SkswdEhvTGY2YkcybEorQTdwYmY5NFlQOTNQRlZNYVJsU1VnSjV2QkVYeXlm?=
 =?utf-8?B?Mi8wa3Z2MkFyTGlRbERCNzJJZFNPWjNqNUlGUkc4Zk9XT3VIQzBYQUJ5UlpE?=
 =?utf-8?B?RVQwRGo4TTJxMm9yeUJoU2dGbGZNV3N0QktqWWdUK1ZFUUk0KzM5MWJUeDQy?=
 =?utf-8?B?dmJzUEJHK3djZDc5aG5OSGZscXVXbHVzVGlGZno2c21CZUpCRWIrUExGZHFv?=
 =?utf-8?B?Tms3b3RtOTBmQXRXQ1lCcW4xYjh4SjBDSWtkT1FTSVBMdERxT3NnTDVqeTBv?=
 =?utf-8?B?YlpKU3RqeFRnL2pBN0Q2SGJyOHp2bno2ekVnUkdVTUdlVGx1TVoyZWVvTHQy?=
 =?utf-8?B?QS9uUExTWE1weWVwOHNRYXJHQ2grK0poVmh5TnRjVW5peGk4UzRaQndXSmpT?=
 =?utf-8?B?YlBSUnMwYWxxN3I1aFczcWp2V29KOWJRdVBwUXN6bzdFS29HRmsrd0VMT2lX?=
 =?utf-8?B?QStjZW9PRDk1aVR3ZUxZMDhmZkMyS2prZHZjN3FxQ1c1MVFqdlZpbXoxUGpX?=
 =?utf-8?B?d2w0TS9MbjZHNU45dm1wWWI2ZDlBdWVzK0lGQnF1Z3FYSkU4aTJ5OEkxTlhk?=
 =?utf-8?B?MG5lRHdXZHUvdXJ1ak5RVEF0Vnk5MVI3QlRHU1NiRnhOT2VWMDM5T0lEMGpD?=
 =?utf-8?B?eTB5c2w3MnRMMHVkUnlQOHVBZ0ZQN0NtZUl4U3A3aUN3QmkzRXZOUVNCYWtr?=
 =?utf-8?B?SWdTbWZzY1drOGxaVGhuVUJPTkhwVkR6MnZzNzlJdlR3N3lKNWgwVkpnZTgw?=
 =?utf-8?B?U28yMjRRR09ycXlqWFVKLytKL2dENWZyNk9ic2dWYmwvekFLMUpONmxiMnBW?=
 =?utf-8?B?cit0KzJZalhNdzVYalVndUxLNjlpd1dnOXMrOXQxRjdqNmNIQWo1Rm40QVEz?=
 =?utf-8?B?bFZWcXQxbFhNTktidEdYRnU0OXNNRDJwZG5DcHF1aEpIbkxURkU2TUZxZ245?=
 =?utf-8?B?OEx2ZFJmd2xFU2dENTRFUUkzc0NaWVNlWkZJQW56enFVVThHZEgvcG9sNjEx?=
 =?utf-8?B?VnY0R2t0U0MxQXJXM0Jyd0UwT1EzdnExTzdON0lCSmZIQTZET2xreGRDVUZx?=
 =?utf-8?B?M2duMjdqblB2LzRtdXRXdzdBYmFJaFNGWUg5TVhVOGtuUkpzRFQydWgxbE1o?=
 =?utf-8?B?SFZXd0pZM28rV2xRWjBEMjc2SVMzcUUvTnIvZ2d4VlRDR0lQQmJwdVFPNEdM?=
 =?utf-8?B?Q0xERFlGS0NIVkhCYW5hUTZFdDVncjBMT0ovS29PVzdhc1JiZGNiVzBHSkRY?=
 =?utf-8?B?WXB2bXo0QUhpSWgrMWc1SDBabFhVaVZhZitmaE9kNVM5dGhGdU03blNjdG5s?=
 =?utf-8?B?YTdZeGVneHgrSHZqVFI0bHYreG9wdHQ2QjJkY0IwWHlPVE1iSVBPRk1wQXhu?=
 =?utf-8?B?b2NiQjdzOU9SVnFFaGVRK1lJcitLcTlnRzdSL3pCN3A0YUp3THBYNTE3ZVM5?=
 =?utf-8?B?UzdZUC9ObzhZMXRjWlI1b0Z0aHZjb0JpemJzYUoyMXBoTDhnUFZ1SU5MMndZ?=
 =?utf-8?B?SnNqaFlQY2N6bFA2WUMwcUsvSVo3T3RKdWswYkhydngwU1U0RTc5VnpkWmNS?=
 =?utf-8?B?Q2Y1Tk9IU3o1alJiOVFqbnROTUsrOHZqcDlrUFk2WllYZzRwUjVodlZHZ243?=
 =?utf-8?B?MG41WHBUR2pRTlFSRlZCNFNWTUo0WVQvdVVqelNCSkU0dVNLOTlPeXdrU2gw?=
 =?utf-8?B?L2NPdkJ0aXpXKzFiMnd4WnpQTDdiSzZycEdwM3lTL1QyQ0dxdzdjRzB0ZmJ3?=
 =?utf-8?B?OVR3NlBNVWo4OU5QUGY1c1hITWRkZXhXOElWL0xQRmx4YnlqV3oveUF3enli?=
 =?utf-8?B?RUpWZXBVVDRKYVZ2c1FlMDVQWW45TGg3UjJEeE1aV2psTjlSNU5MaDhRTnVa?=
 =?utf-8?B?c09Pb05OVU9hcnA3NTg5cE50Ulh6QTNzeHRJaHZMcTNSL2E4emd3bWs4QlNC?=
 =?utf-8?B?bXVmSjFXei9PMHMvMVRIblU4cGVjeDFmMG0xOEJxbnY5RUN6Rmo1OVoxUUxx?=
 =?utf-8?B?TnppNGFrbjhXVE5JQVdjSGlMNHdBRHh2VndJVkJ2ZkljMDZVTFpIM1FMNGpj?=
 =?utf-8?B?T3lUTFRleEd6RDVjK3RjUlNDbVFVbHM4aVMraHkwaHJrS0JVMGdQcExGTGdz?=
 =?utf-8?B?bWVpR1BxNkRzaEF2b3hQZUZ5M09uM1ZOcEEwMG1MYmpZS3IrR3VZSFF5TlNx?=
 =?utf-8?B?OGtmTjFkQWQ3ZGo5R1BzU1lxa2owQ1ZLQmtJcVFVRXlRanhnRUNTU29nR2NZ?=
 =?utf-8?Q?D+cJ4TQriY4o+iZw1c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489f1290-9d2a-4187-2fe6-08df08741de5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:58:12.2082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7SJHIWbWAZOSfxQ4vX+R27M/nZvIdfmAQsGTjl6PwK4T7vhzGK/WfOhcuk3uIZH/Ictmz55Mbkkl712ouppzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 8/31/2026 8:42 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> Is this the reason we cannot rely on the Enhanced Allocation (EA)
>>> capability here?
>>
>> AFAICT, this was explored on RFC v1.
> 
>> EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL was suggested as the
>> shorter path at the time, which is what this series uses.
> 
> Essentially we have *two* problems to solve here.  The first is how do
> we get the fixed bar information from qemu to the firmware, and the
> second is how we integrate that into edk2.
> 
> So we could have a driver which parses EA and passes along the
> information found to PciDxe using
> EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL.
> 
> Not sure how much of a win that would be compared to adding EA support
> to PciDxe directly given that the PciDxe bridge window logic needs
> enhancements to properly handle fixed bars (as discussed below).

Agreed, EA doesn't buy us much here; the bridge-window fix is needed
either way.

> 
>>> Agreed - if the bridge windows are not programmed correctly on the first
>>> pass, there is something in the code that needs to be fixed. I don't think
>>> papering over it like this is the right approach.
>>
>> That's a fair point. I did the window-sizing after PciBusDxe because I
>> didn't want to touch existing PciBusDxe code too much.
>>
>> As per my understanding, PciBusDxe's enumeration splits into three phases:
>>
>> Phase 1 (PciHostBridgeEnumerator) walks the whole tree and calls
>> CheckDevice() per device — by the time this phase finishes, every fixed
>> BAR address is already known and cached on the device
>> (PciBar[Bar].FixedBaseAddress).
>>
>> Phase 2 (PciHostBridgeResourceAllocator) prepares an address for every
>> resource node in the tree — both individual BARs and bridge windows
>> alike — purely from size and alignment; PCI_RESOURCE_NODE has no address
>> field at all, so this is entirely blind to whether a fixed address was
>> already required.
>>
>> Phase 3 (ProgramResource) then writes the actual PCI config-space
>> registers, and by default it just writes whatever address Phase 2
>> prepared, for both BARs and bridge windows. The one exception is
>> ProgramBar() — it specifically checks whether that particular BAR was
>> marked fixed back in Phase 1, and if so, overrides Phase 2's prepared
>> base address with the real fixed one. However, ProgramPpbApperture(),
>> which writes the bridge's own window registers, has no equivalent
>> override — it always writes whatever Phase 2 prepared, with no awareness
>> of a fixed BAR anywhere underneath it. And that needs fixing, and for
>> that I have to change the existing code.
>>
>> I think the fix would be to extend Phase 2's own sizing step
>> (CalculateResourceAperture() in PciResourceSupport.c) to check for the
>> already-known fixed address on each child and, when present, size and
>> position the window as the exact union of those addresses instead of the
>> blind size-only sum. Does that match the direction you had in mind, or
>> is there a different integration point you'd suggest?
> 
> Sounds about right, when propagating resource requirements up from
> devices to bridges looking only at the size is not enough if we want
> properly support pci bars at fixed locations.

Thanks for confirming the direction. I'll implement this and post it as
part of the next round.

> 
> take care,
>   Gerd


Thanks.
-Tushar


