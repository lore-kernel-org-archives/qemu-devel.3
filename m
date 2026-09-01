Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6488AC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 22:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Wwt-0004Zt-4T; Tue, 01 Sep 2026 18:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x1Wwq-0004ZZ-NO; Tue, 01 Sep 2026 18:27:20 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x1Wwo-0006v8-O3; Tue, 01 Sep 2026 18:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbt9zCNCmNrM2sWDqe3LIyBorW3NEfUIpI8rVy93IvObt81pURkrN7GlMf6iz6Be/5txxHhm3u+b0g4XTeZvX+Hfv6JTtZ/0rd9fvOWomcdatAhdwYaMMpGikiJ/kJFM9DTcAzGjDKQd9fQcxfWqiXW98TwOZREu1ud8Y+XrDmrbKuWZrY0CkZNK1M+8BYOFqQ7o3sfe4p1JIJpXDFOBFo8ks1NUqmO2c1udVOqohnXtDbWUCWkmlf13jBaJlzBEN07SMwmPY9E7wAbKVqsxb0o31KybKr4YzxPmXdAFLfjiDolb/jFkJtO5Bsaq80yIAWl+mAYVYcUeEdeBSNtRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/rVbAspbDuqp6dHydHHc+hijgGBT93PwVVCGmdO3lQ=;
 b=Hv70ZFKsWmu5710wETGaqJduirE+k6jP270pInytXW7h4JwquSKAUTHYsY1r62sILNGBvMv6SAhy7m/YD9MQ163SwBR9HIvbcy/5TIs97h/1WW+S8Jw54QPFEHHlcTGFWSK3HcFoNyOx4wxRbXDmtaUGOgRhH/IyqFamNeOQi1tOJKQuWCpSQPfdxG6BR7Rm8GuZrk3x7Qm0uD0FPlMOJq5fn1dody+w0/60Q93QmIcp86C2lWRoTPSgW/HhPuAjADEmrP8v1JDUiOW/XRCC/Xy+KdooB/7swGh3mLYlqpPbgNOcmQpCRiyYGfPo+14fisIEZeMUgBrv402kEesMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/rVbAspbDuqp6dHydHHc+hijgGBT93PwVVCGmdO3lQ=;
 b=swjb//7e3XN4lj/fjuNGq1OQSWAJ0FYm8W4DWxWnwROUbCn4pssFFrJSEdQp81wZoRgBXpbhdceGkOJ/1HEKXbzkV2sX0OqSTPcGiVX/oyndqKSCbjY7VXvmlYfJCFWWxt1HyN1rZS3hu/6UjgjEAn0tWNiJ0ad+gkAlK5id7rUYo1EcCNQv4lqVQ00E9vtgvMf1uAfdfgD8moSWpkTTRVYFdJpvSzaKs2sdOiTVVdXkS12j4fN5aVmqEiyyztTeBVo5JTap47pgVpgw5Pti/rqkBcTmeE2GTikMowW+EMI1fzeWgPNhmn6r1Dq39yJNTQDvM+a3Nl1wB+jmXsY7kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 22:27:12 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 22:27:12 +0000
Message-ID: <b4d51232-43a0-4058-af96-5c3ca847edd8@nvidia.com>
Date: Tue, 1 Sep 2026 17:27:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
To: Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:303:6a::10) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b117e8-c0a9-4c17-48ae-08df08782af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|11063799006|6133799003|10067099003|4143699003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: vKaxJZSxz8nRGz5ldgxJjZ9EWxrgFaMbz9HgUZpx/5MkFyqnjJA5Im7brG2JxjWqXhvQIfjDL+s2T2bpMxlzjitsJTJKlXMhqWoSLkzXbjpQtbh+NCVEVwJJ7ocOp+MwiC23ce681FL+OE6FzMvoU0CSRKgpa7PzPWw/2qRg7R1SUkK4jdIASCFZYq9pWyK4pqCy/m4dOEUW+0AkwOwhP4E4G6fXn6+ATsz9tHBSBXC+WHbPBejp1R4xStasFEk4M46OxuGzC4KQrxfI92eqEXcZzeh6rF+aqk+5JGa64273OqIEiseTSSe0jzZklSHLdZY+D4wx0UZUqNasuY3upBASJu6mLAKpWe2A2Z43b4YB97jCD54r/EeXWZmd4Yz6LOQuk0HbdAsGRHTtE9Oi2frFyj3N9103+bL9cAU3YQ3qbZuebfDWuxYRk5wqCW2bA3t/B05IpyRh80NVbfV2KOjuH+L+N0ulMdHpA8HTs40NXsaxpJ9AW/M/QkJKpf+Daw+YeWmfCQ5nPsCALUmCR86adiT6JkG6u6QrbzI62PteFxEeF1VlkGJd3NbDhGlN+T12fzm9xboGNh9UUObm+re0M6EWTZZjFzH5aieW1wOGSk7IZD63mM08qNBj5GWxORQy7LZKVGh4qADOpPQRImBkOjDgWG4TS8TQmlTi8p4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(11063799006)(6133799003)(10067099003)(4143699003)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9uQW84aU1CcXpVVHBIVUUvUElZeEpIVmlwMGRFN1NnQTZtNkZmT3VMSHhz?=
 =?utf-8?B?S0JweUVPQjhqQ3hQZVVZMUZ3MlMzT3lhMkl4RzFKQVJveTB5OVYxZ1NKWkZw?=
 =?utf-8?B?RWdQdW5vQ3lxS3JEKytLODNsRitsdWw4dDBSOVBndzJINVhqMVRveVJwWHVx?=
 =?utf-8?B?cFVCcC8wTjZ5TXlkQ0NyK2tCbkxTazRTNTZlUXgwUUFUZDJLcnF1blRWMm1m?=
 =?utf-8?B?ZXdaOHpUV2krN2luTkZwaDkxbHAxNUVXRUl2YUY1TVJKSDQzeDRmYWtaNmFa?=
 =?utf-8?B?OVpxMXM3SExHR2tJaFpsbnA1U3M4T1dpMkxHZDF2cjV1NFRJOVExZ3NUdVFj?=
 =?utf-8?B?N3RPQnp0MWRLbGJDY0FEaWoxQ1RjWjBGWndxOG9NM3d5eHBweXZueUh4V1VD?=
 =?utf-8?B?TVlzanpuT0RXZnlORVliTjdLYnI3dDROSThKQnFxbkFycnB4U0hXS29kclpQ?=
 =?utf-8?B?cXBnUW5tVHJlZHRQYWpRUk9NVXZRT3hFNXo3MnhmZkMxMVhMRWF3UEgvZC8r?=
 =?utf-8?B?NjQ5b2gwdU9ITkE0ektNVUNPaGFTS0hVWkRqTjg4WUo2YlNEZ3lseEpyaWdk?=
 =?utf-8?B?Z0ZvYXJCOXVjZG85QlFnRm9wR0xuUVN5VVBVcG11WjlGY1RVcytPOFlmVHpw?=
 =?utf-8?B?UDFKbCtQcHhBR25VVW1qWGhNSDZMVnI1VTV2Q0F3VWlleXFoNHBFVVNSVGEz?=
 =?utf-8?B?dE9JNnpkMWRRMEFueWl5eXlTTy91bS91NDlpai8yZnpBNDh6TVdxTkJOUUpo?=
 =?utf-8?B?dVlDcHpXTlBWeWY4dnFqRVJzN0ZTMHJYajNYNVVkQmJRSU5SeEgyK1I4Vlcz?=
 =?utf-8?B?SGM5TDNCS2svWGp5eVJwUC9TL2x6RXZWbE8yT3dPeU9lVnRqVnozK0dac3NW?=
 =?utf-8?B?QmVQMmk3VjBwbDRaZElWZ2kzQUd2ek9SMytNS2krVitNVVd2N25nWENSNTFT?=
 =?utf-8?B?SXZlSUtyNVF0Wk9DMGdzanlic3lZQU9TcUthZTJtNmkwb3h4ZlBVdFhQWWxM?=
 =?utf-8?B?K08rSXBkRTZvM0crNnM4NmE5MEhtOENwdG10SldyZWo0US90cXhpZmtpMjNY?=
 =?utf-8?B?RFY4cTB5dGNDckhZWm5ycm5rSW9FajNPVzAzQ2s4M01DNEdyV2RQd2dJL2pT?=
 =?utf-8?B?ZXZNbWtqdEdrdVhZVDcxOFBCSFFiNmp0SzdrVnp1dHdRSHJsN1dGaUJkYjBE?=
 =?utf-8?B?eXNRVU0xT2lpeFM0SFI1UGpMekdOajhaWmUzSFgva3k1L3Z5cW5EVnptNTZJ?=
 =?utf-8?B?OVNUbGlDMHU0L3BXMlVSSkkxMDh6RVVqU2dhN1JSRkJwM3JxbnJtais3eXF2?=
 =?utf-8?B?N1U3dXdWbGpaZkUxMFhxY1d5bVdoNW9vSUowUDFZemdDV3FMTkdpZS94T0x6?=
 =?utf-8?B?KzAwSmdIUlBodDVjQktyV2pLWkIwanNHTFo0UHZsZHgzS0NucEpIdGw0SUtm?=
 =?utf-8?B?a2FhRHVVWEVYeGVOTks5MEZEWFl3WTdtZU9CVFJiRi9Udi9HRlJmSzVzbFZX?=
 =?utf-8?B?bENsZ0pGWTZIZHQvbTBSZExoN2xaRnlTdXJXcWx2YmcyVktJeGxvbUp5NDlD?=
 =?utf-8?B?WjlEUXVCREF0SWtMdmxJbXRmQlJ0VkxjRXVWdkt1aXlXWk1BRjRSMXd6VzEv?=
 =?utf-8?B?QzBqd1BkYm9hVXY4cDM4VVpRazJ4cXBlWk5CNEZadUZpb3pTZnB4S2R4SXlk?=
 =?utf-8?B?RjBpQk5mRXhZaklPeURkVjNHM0lvMDZCTGh2dnZUN2NTdFNZbkh4Sk9tWmdQ?=
 =?utf-8?B?SVFyMUpicUZYR3FSclJjYnY2dklOazlsdy9RV3BsSEZ4VVVMNUVaMjc2aXlr?=
 =?utf-8?B?dmNYblIzb2Q0V3FoUStnSmxVYmUwcy93Y25jU1lVV0xrbWxlQkNiZUtpWGpG?=
 =?utf-8?B?cGNqSDA2L2JWQlBUS1ltbHVlajZVSDNzelFvL0lzNG15NWJsRXk0ODFoVzEr?=
 =?utf-8?B?RG8rYWFKb0k4a1Z1bm5aRllYRmo0czFlZHVGK2VyVWlMS2hPNEhQdHFMWk9X?=
 =?utf-8?B?WXR5cmdJK3ZKU0dHM09Kc0t1OFRlcm9oQWN5T1VLRkdoU0paMHJMWFJwK0Nq?=
 =?utf-8?B?UnB3bWNuMWRVOUR5MUd5Q3IwL0JkMm13d3RpSkF3N2xJUDk5aVlpWkVQNXEz?=
 =?utf-8?B?RVRKRjRFaFNXWXR4TFN0M1RCelNGeXo3cmNEeXQ1SEJ0c25sMTlCYjdoRXpz?=
 =?utf-8?B?Nkc0aG5ZUTZlWVJ4bXg0M2F0RHpROHlPNll5SW1XUy9DWXRITVFJQ1c1bk15?=
 =?utf-8?B?eWxSZFVVVHlxVFd3M2hMUEpzNXIvWndwRXBMSFJXOWNLTitoaFl2Nm1oR0k5?=
 =?utf-8?Q?hucxD5eNuM70uPIsKR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b117e8-c0a9-4c17-48ae-08df08782af5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 22:27:12.1019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQlfblvdnC/JFEU5qjRc4FkCHkJqDs8WrPnS5pZ2JSSiSJeLpV1+SmLJ3PMxXcIGqFANRVBT/4V2dNeSGofg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=tdave@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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



On 8/31/2026 8:24 AM, Gerd Hoffmann wrote:
> On Thu, Aug 27, 2026 at 07:47:33AM -0600, Alex Williamson wrote:
>> On Thu, 27 Aug 2026 09:18:50 +0200
>> Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>>> I'd strongly recommend to do the same for the fixed bars:  Add a pci
>>> capability to pass that information.  All the logic you have today to
>>> link the information in the fw_cfg file to the correct pci device is
>>> simply not needed any more then.
>>
>> Placement of a VMM defined capability into a vfio-pci device is not
>> such a trivial problem as it is for emulated devices.  Space may not be
>> readily available and the capability may mask non-architected registers.
>>
>> Does this suggestion relate to fixing the gap between mapping fw_cfg
>> entries by vendor/device IDs or is there something fundamentally
>> undesirable about using fw_cfg here?
> 
> Well, fw_cfg is the fallback option if we don't have any better way.
> Attaching the information directly to the device by placing it in a
> pci capability is at very minimum worth exploring.  If this is not
> working for vfio devices, ok, we have to accept that I guess.
> 
> And, yes, the logic to match entries in the fw_cfg file with the correct
> device using vendor and device id looks somewhat fragile to me too.
> 
> Existing code in qemu+firmware (for example bootorder) uses the location
> in the physical device tree to identify devices, like this:
> 
> /pci@i0cf8/pci-bridge@3/*@0/*@0/*@0,0
>  ^^^^^^^^^                             pcie root bus
>            ^^^^^^^^^^^^                pcie root port @ slot 3
>                         ^^^            virtio-scsi-pci @ slot 0
>                             ^^^        scsi controller bus #0
>                                 ^^^^^  scsi device target 0, lun 0

Good point but the problem is CheckDevice()'s own signature, which is
fixed by UEFI PI spec (only passes
VendorId/DeviceId/RevisionId/SubsystemVendorId/SubsystemDeviceId). Even
though the path exists internally, the standard protocol interface
doesn't pass it to the callback. Therefore, we prepare the blob entries
in the same order PciBusDxe discovers devices, so matching by VID:DID
inherently works.

> 
>>>> * fixed-bar=on on a PCIe root port marks its subordinate hierarchy for
>>>>   fixed BAR placement. Every device with memory BARs in that hierarchy
>>>>   must provide a complete pci-bars= configuration.  
>>>
>>> Why is this needed?
>>
>> AIUI, the problem space is greatly expanded if we mix user provided
>> fixed-bars with firmware assigned BARs and it's possible that there is
>> no solution that meets the requirements.  This option both simplifies
>> the problem space and allows the resource windows to be audited to
>> generate user actionable errors in QEMU.
> 
> I can see that allowing fixed and non-fixed bars mix is much harder to
> handle.  Do we need to ask the user to manually set that though?  I'd
> prefer pci devices propagating automatically to the parent bus that they
> have fixed bars and additional constrains apply.

I looked at this again, and technically nothing actually needs the flag
to exist. The real reason I kept it is closer to a usability one; it's
meant to be a visible signal in the launch script itself, so anyone
reading or writing the qemu command line sees up front that every device
under that root port is expected to have pci-bars= configured, rather
than that requirement only surfacing as a runtime error if something's
missing.

I would be okay to drop it but that was the reasoning. Let me know.

> 
> Also: if the main use case for this is to map vfio devices with guest
> physical address == host physical address, is there a need to specify
> this manually at all?  Shouldn't we have a 'vfio-pci-fixed' device which
> handles this automatically?

VFIO GPA == HPA is the primary motivation, but I don't think fixed-bar
should be tied to VFIO or automatically derive guest addresses from the
host. For the VFIO use case, the admin can choose to specify the host
BAR addresses as the fixed-bar configuration to get GPA == HPA, but the
mechanism itself doesn't assume or enforce that -- the desired guest
layout isn't always just a copy of the host's, so having fixed-bar
auto-derive it on its own would be incorrect in some cases, not just
less general. The mechanism remains a generic way to explicitly specify
PCI BAR addresses.

> 
>>>> * pci-bars=barN@<addr>[,barM@<addr>]... on a PCI endpoint specifies the
>>>>   required address for each memory BAR. All memory BARs on the device
>>>>   must have an explicitly assigned address.  
>>>
>>> fixed-bar-<nr>=<addr> ?
>>
>> Could be a reasonable alternative.
> 
> Parsing (and quoting) property strings with commas in the middle is a
> PITA, also when using numerical properties you can use the 'size'
> property type which accepts things like '16G'.

Fair point.

-device some-device,pci-bars=bar0@0x1000000000,bar1@0x2000000000

would become:

-device some-device,fixed-bar-0=0x1000000000,fixed-bar-1=0x2000000000

and, with the 'size' property type, the same addresses could also be
expressed as:

-device some-device,fixed-bar-0=64G,fixed-bar-1=128G

> 
> take care,
>   Gerd

Thanks.
-Tushar


