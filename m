Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DDECD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 15:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPiYG-0002i2-JX; Wed, 20 May 2026 11:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wPiY8-0002hZ-DH; Wed, 20 May 2026 11:09:33 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wPiXw-0004vg-V5; Wed, 20 May 2026 11:09:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvD4BCYWNYuDfL2zIpHD3jP5/QR7PX+1x6S5lA/1tDYe3iezRZi9Zim1fWiIN62QJh3bJnkjZU/znpuGsc2FVYW+O9W1g89bFwslypbKZ9rpbd+TkYN3+YnBtrkudrqsgMUhSK+w882Ct8x2gdyb7sqscf8BblOM9bdmNUeDKqJQA12Y34qR3YNiDsuPH+oSzFNH0Obh0OXeOdP+qj9zKBSUDVQQkHsQiyAhgDtjBR1ZmCjde3ihfkDyavFY0IxAf77YqbLNzTVarAPzJ6nCv6aD0jiBvsArVpMHreCjgwHHbscLm9KvmrHZkcD60w7asSv/zcrULnqk1LsCqGNS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=driz5QxritCHs8y7fwbaXGfoPZBl1rdqV0nQo3TInOc=;
 b=QWfaSCn7cF7R61M5zzqDrcKS3erQBzsA0LoaQOzVg4AO+0oM3z9yrofXjlE9+rS1rhU79hTq7qr8iQvKPLvd5YyJiXCIMydTne4KHAeO/lUS0QOsHE7jPGQQRF+RVQ7R0WssRG4XymPndAEHjOElLoE6XgUJhtbwP7wR6UYgHCj0Gn6iLhNSPjCt0vs08foAi7KH6daaFPu+XSEImNKkXfdHXAIPkyMC+OANiLox8gLEwRlARjFXdmH2dFKYxX/Xj8jZkQAk+c+fRIvVbdcv+aKShjihg6QwWdxAahloUxrfWnSNJQiSCI3ROkfJaj2kiWl3Wg64mb9otJaH/kw5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=driz5QxritCHs8y7fwbaXGfoPZBl1rdqV0nQo3TInOc=;
 b=b6t3vbARjEflWDGinDXZu/LppvHy5qHWUXQaSPMtJoY4+bJoo082tvznxTM6Yj2qucCHtbvQYbfYHzp7AwL5mQGH9g0uSs39NCU7ResJ3M0mS+iJA25/Xdaiglhx6MezvOIdh9PkJErDq1bKwb0YGkWm04cBTHY8L49+JbYRsdpY4T6d+NzZ5cd2S4I4vH2nDaqFIwaK7GZtUco4o3gPYhv7UnY8Vz7lIXjaeDnwOQV6EMBli9d9jr5j/Fq48PgrHS2OY75RbHsN4YAA6WaEjMzxTmxaGMNWkXAml3mOFPXAXTIybwGpnav7vDDMfmnILn6gH2n1hml0jzyyJcTz6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 15:09:06 +0000
Received: from DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::3885:dd8c:612c:a746]) by DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::3885:dd8c:612c:a746%7]) with mapi id 15.21.0025.020; Wed, 20 May 2026
 15:09:06 +0000
Message-ID: <5dce0686-d0a1-4b25-a17e-dc05e2b0c717@nvidia.com>
Date: Wed, 20 May 2026 10:09:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [edk2-devel] [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI
 pre-enumeration and fixed BAR allocation
To: Ard Biesheuvel <ardb@kernel.org>, Alex Williamson <alex@shazbot.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>, qemu-devel@nongnu.org,
 Jason Gunthorpe <jgg@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, marcel.apfelbaum@gmail.com
References: <20260508183717.193630-1-tdave@nvidia.com>
 <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
 <db604efd-9c1f-44e0-9921-71e4d97a81b3@nvidia.com>
 <20260512170650.4551c9f6@nvidia.com>
 <20260512191140-mutt-send-email-mst@kernel.org>
 <382877be-edad-4eca-a646-a75e1654747f@app.fastmail.com>
 <bd3000d0-add9-4245-bc83-cb7f4886377b@app.fastmail.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <bd3000d0-add9-4245-bc83-cb7f4886377b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To DM6PR12MB4186.namprd12.prod.outlook.com
 (2603:10b6:5:21b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: f52926d9-9563-42d2-7df5-08deb681bc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|3023799007|4143699003|22082099003|18002099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info: kIhv9B9mnG7oLLNpoxw8tdC3Ue8/zrFuYpN1CYdPbOCDTMrXHUR22FTnxuhyv3No554ojFKoAYLFA/tQh1+sSypUdDElXunmIo7CyBQ2tOrlfsSCMRrnHzXA/X1yo1tDpaxpQVZxmSw6n8THN1yozE4bHl55OjO0JMdh628AC7Y63Di+NVNXnnJEJLjdr2Srsqa1vTuspMUotKK6DlOMTHGrZLG94MvFpnl4cDsSLQva1qXlstyMos9dUoxpTSOB70/LiTLQt5AbwdHENWtE473V2GDkv3OH8eespXqEkKPcsq0l1el1ktvl4UyJeWgiWnbyr/5Eo8UY7nGg7qh8mgj2PRC8r2TnWPXUQhybVF3h8lQCXglkgc8kFddQYzlRiJ34p9Kwb1EG4CE8D54ItH9JkoSknAMBA4qkfDNOUESheVvXqpCXo6EtWhW/IXoDewCxkrsOD5NWxp9H+Dvi94rSw/eq4cjSs8gJF4FsYZVfGZ908gb0nAJ4TNrGXiEEJey3O35zIDMDGg5WO0SeIwt5aB5hHxU8uOJ15oiKmGNIpwzlze0i1wqfpY4LAaJ49RI8qq0k4+MXFlitX05+jIGvZQejVnskFhUrWodvUMLl5oCBPYqUEE7yuGSeCtSsOHUva1l1K1mvm1H6GQ0SBccJ1KAswADMKqJcZjU1Q/e2PENmIhtUR8uZI6Vpv/0N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4186.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(3023799007)(4143699003)(22082099003)(18002099003)(56012099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZksyVkhSZVJIZU5oSkNwZEtFeUNKT1RwR2dpVU5iVWFGSzZLd2twVnI2K203?=
 =?utf-8?B?c1k5RzVFcGFUVEJlYWxPRHJ4QWtmdDJPL25OY3R0bnpvdC9hOWJHaS8vUGJH?=
 =?utf-8?B?UUxyOUoyQXJ1cjBBUkhheGM3V1pSVnZFczFTOFA2N09Lc0ZuTHAwY3FKTEVL?=
 =?utf-8?B?OG4yM01qM0NvZnZ6ZXVyNnF4K1RMSld0UytNUFp3NTNXd3BmT2JCL1dXRHpx?=
 =?utf-8?B?OEQ0dzNwbmR0RmlSOXpacElYcmcyQTRwR2pkVWdJU3FaVFN4cWxDeklZM3lj?=
 =?utf-8?B?c3JXK2JxZE1yVjFDMDdsTC9KblVQeTk0TmZ5L3Rlc3ZhQURrdWpiTUFsVVZa?=
 =?utf-8?B?TVVPRE9mTHc1NnFNS2JPcmdwZndRb21xdlpKeklUSmJCVTVrb0JqQjllMWlF?=
 =?utf-8?B?aHNKUWlQbUZlQmFTbENuVWZCUk5BZDlYbndMZmpIVFEzL3ZRa3pXZ1BOeXkz?=
 =?utf-8?B?QVJJdldDQW1XekRVeEhzaVJVbmk5MGYzOW9FVk5odEp6NEZvQzYwRktPTC9F?=
 =?utf-8?B?bzM1VCtQK3YyR3Q1NTQwcnN5eGowbzFSenJzeUt3TlV4YllkQnIyMXV2R2dM?=
 =?utf-8?B?S0d5cXluMzU5d3JWOGNKM3dTM2pHeDlRUDU3OUc3TktSamZBbyt0amc0c1E2?=
 =?utf-8?B?elIrNDJkM1NEbzJEbUpwNlFRL2l1dDMxTDErZUduUTUvd0huNlFxZ3ZHVm9R?=
 =?utf-8?B?UlIra0hBRk00RjQ4dnA3OS9OSGY1dlBjM1lCL21pbnU0Vktyc2VrZDhqb0ti?=
 =?utf-8?B?R1A5NkxBYklDanFiYm1LQjFJbjBtakI5TUtXMFdlK2ptblpPS0FDWnFSeS8v?=
 =?utf-8?B?VnpoR1FUT1VVbTJ2WnVQd1F1dTFrV3RDR1IzU2tMODRSTU0ySjRlc0NPWmtU?=
 =?utf-8?B?eFFNcmUrSEJXZ2lYRWlrWC9QOC82WHkreTBCR2tnNnRrY1JEQUM3UFA5RG1I?=
 =?utf-8?B?QVJZRGZhbE8vcTZBZG43TmorY2hEUDVFbFFsK2Rpc1lrU0pUUThIeDRkTTQ0?=
 =?utf-8?B?WmJLYXJCNEV1alc5Rlk3aENlK29kdjJ1b1MrNTNtQnJQSHVJODVXWFZRVlNM?=
 =?utf-8?B?ZHI0ZVBva1owK2ZnUkNBcFdMTW9ZWXZrYnlVbGp0VFFQNDIyL0I1QUxMd1Bx?=
 =?utf-8?B?MW0zQjRSTk5XSjNTT0JtMzlhRG9CMXU5cXlkZC84Yjl6czYyWnNyUVNBdFVB?=
 =?utf-8?B?VlhacnNjTzNiWi9KZjdJc3pzUE1Qbzd1V0R3TkRBRkdiZTFiZHZ5blpVT3ZT?=
 =?utf-8?B?NWVVdGVmS2Y0Zkc5dTdYK0N5V1prRmxFK3BQTlRRa3ZtQU5mRnBGem03aW1S?=
 =?utf-8?B?SWhMZTlYNU1XaWxMMnJWRW43czFlUExBWVVMYWVJcGdaY21HTzJ4WEYrU3ZH?=
 =?utf-8?B?TWNhVndoZzllNy9hYngrZE1IS1cveVcrSFY4SGtES3FHZ2xTcnlJZHArRjRo?=
 =?utf-8?B?TGJnaVE1R0ZqaXRNaTBNLzA0aHVjNGVqaExqNnh4Q0c1Q2dCR0lLaUNzY3hw?=
 =?utf-8?B?SDJyQzZWaVgweG93em5vM2hEREdDWmlpa0piSnNTdWhDREdQaUs5T281dWRX?=
 =?utf-8?B?em9ZTzE0c2RzMTR4dlhQTVkwVEhxRTlIQU5YenRmMTd4ZG9ibTduYnpNNngz?=
 =?utf-8?B?NnRxR2JVVUkvRXQ1c3FHQ1p4Qk9EeVViSE5DK21QL0Rkc1VBWGZublhtUDQ0?=
 =?utf-8?B?ZHgyV1hVbFdmUnlRQmxIZEVvREpTRm5ROURoZGh6ZGdCa3VCR0hDYzdwZ1h5?=
 =?utf-8?B?RXZ5eU5yNyt0bkE0akNiOGFYM0dLbzdsMTJpQUQ2RGNZMW5xMXh2aHpheURW?=
 =?utf-8?B?Rm1GQjltNC9kOTRYcXZPd3E3ZVgzS1R5bUlPbWRoV3IzTjRUd1FjZTVMdC9l?=
 =?utf-8?B?aG51TTQvMzNWRW9JOC91Y1dHQTMyRXdoSTZCV1VPSXp2Z1R2dTUyL3FZeHdj?=
 =?utf-8?B?aWg5Vy9abXZjeFk2LzlKMFMxQVQzUkZEN3doOXZvVHc5ZldudVpBeFhMSDZi?=
 =?utf-8?B?dnhHM1E5aXROeC9BQTM2N01EWnVjVENGSFNCQzFpNkd5V2podjZCQ1g2MmlG?=
 =?utf-8?B?d0FjOWU3eGFqOWNwMUt6a0hEUWlacm15M2puS3l0dzVIdDF4M0JCODFsRDN2?=
 =?utf-8?B?S3pjRHBwVU9BUkREZGgzdEl0dXZsaFFEMklFN0ZMaFJwWm1UUGNmUm5VYjR6?=
 =?utf-8?B?eEtEUGM0L1VPbHlEZFlxWkZ5YlRUdUY2R2lvS1NoOWFwMitWN3A3SlA5SzZ1?=
 =?utf-8?B?WXJSMlliTWxZaWczR0lkV0Y5ZVp4dUNHRkQ3cHVqVEFBWUlpTTY2TldVREVL?=
 =?utf-8?B?a2tTWXhLa2FpblFrQS9MQlF5NnJFQUVuM3p3L0NrTVlqc1ROYWJKQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52926d9-9563-42d2-7df5-08deb681bc32
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:09:05.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOE1bLye3U2BnlenRzzZGSj1Jn7lDEePbrqGAhvRgBRRCqppO1SGkyctWUjB/m+05gHFD796a3c/UPCKRO558A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=tdave@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 5/13/2026 9:25 AM, Ard Biesheuvel wrote:
> 
> On Wed, 13 May 2026, at 01:57, Alex Williamson wrote:
>> On Tue, May 12, 2026, at 5:12 PM, Michael S. Tsirkin wrote:
>>> On Tue, May 12, 2026 at 05:06:50PM -0600, Alex Williamson wrote:
>>>> If we agree that homogeneous hierarchies (no mixing of EA and
>>>> programmable BARs) is a reasonable constraint, and possibly extend
>>>> that to homogeneous per host bridge to simplify the CRS mapping, we
>>>> have the following work items:
>>>>
>>>>  * Extend Linux EA support to program bridge apertures for
>>>>    subordinate homogeneous EA hierarchies.
>>>>
>>>>  * Develop options to virtualize programmable BARs as EA for vfio-
>>>>    pci devices, if not generically for the benefit of testing.
>>>>
>>>>  * Implement a way to poke holes in the VM address space and plumb
>>>>    through to account for addresses used by EA devices.
>>>>
>>>>  * Provide those same ranges to the guest via CRS (but not via DT to
>>>>    EDK2), or alternatively expose them through additional PXB host
>>>>    bridges.
>>>>
>>>> Does that shape roughly seem accurate?  Are there additional gaps
>>>> I've missed?  Thanks,
>>>
>>> just one question why not do it in firmware so windows is thinkably
>>> also handled?
>>
>> I suppose someone could chime in if they have a similar requirement
>> for Windows guests.  Otherwise, the incremental effort to extend Linux
>> EA support seems smaller, though I also don't know what, if any
>> support Windows has for EA to bother.  Regardless, improving Linux EA
>> support might help elsewhere and doesn't preclude edk2 support in the
>> future. Thanks,
>>
> 
> If EA is too much of a hassle to implement, another avenue that you
> might explore is EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL in edk2,
> which can be implemented by the platform to inform the PCI core about
> non-PCI compliant devices that have special requirements.
> 
> While it is supposed to support this use case too, the PCI resource
> allocation code in EDK2 currently does not correctly support fixed
> resources that are reported by this protocol, but getting that fixed
> (and implementing the protocol in your firmware) might be a shorter
> path to getting this hardware supported under any OS (assuming EFI
> boot) than EA.

Thanks for all the input.

It seems that EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL
is the path forward to explore for this design. At a
surface level, this looks feasible, and I'll spend some
time researching it and putting together a PoC before
coming back with more details.

-Tushar


