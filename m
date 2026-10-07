Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D826CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUet-0002nl-6t; Wed, 07 Oct 2026 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xEUer-0002nP-P2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:38:21 -0400
Received: from mail-westus3azon11010044.outbound.protection.outlook.com
 ([52.101.201.44] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xEUep-0006nU-Jt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:38:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulQmjgqHI2XvciPP6pTv+foUPDJbUcdLd5+vOe5k0iXxCrEVcHGrDfhb5D3tfYSFynInLxrlKtnocibJuwZQcXSDCad95rwOSq7j7ZOy3bhm0cwlMsuc1NaBVGVX+t1jcRIpzgIFdrpxUpBje/nA+D6Y/g1sf4m/tQB7gIU4QKhqUQz2h/cnaavPsNPblaQ+oAODQ9wEzW0K1tFMQVc7A6kimz9nux2um/zC3IgYTrBG09Pa3/SYPWRqvDBGWrsqEvTtK26d0qr0aAPWz2OmOKpTcnN7QkuUQ2uZbiwdn+V7FFftMPA6g0GpWyVe7+RohreUB3zEmKTGHIe6OhpB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgcCPdUJMMKYuzsJpMdhhXrzVVKjCmlcuyX+TsX8iTM=;
 b=OkKvuW9Apg1oyvUW14pJtammbzobnHj42T1KY/I7L+70ZbuqIA3m3HPNZ+1q56t4PQSX4QUj5f9g8whzXs/d/ZBuYgyX4CEKFfunxjM8s9vQHRMkmJCM5nUBRmFuaWn/EQAR9olMV4zNe6+bITIWF5vcWWD0Lz0kKWhPv5JT0GougJm55wPZArM1kQsz/5/BIRDGAQdZL+tKQAVJwNYN0MhgXCiunuxtxAF2OnLtQpZNEOZtvUhaDdUEr4CcXCP09MzEMdBkL6cLCZ9GtWQkGC0BPBKuDTeuMx5aN87sGjTNam3Ef9hkwk83hI/K/ltzdDiQZRQFNZNoTtBWUH/uiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgcCPdUJMMKYuzsJpMdhhXrzVVKjCmlcuyX+TsX8iTM=;
 b=hvvykU8PqnmFkmdOqcTmjKQBztL9IUIn92RgO+OnoqfFe5KUd2pIeVlpj4nn1jlvWmhb7hvDrTLMLDj+nW9llkikIGjdnUiwZQfBvhPtyEjn6Yr80chPnPsrvkR+QBeRfcQ713djGF0bxUvRdnKxk/FwqIomcZgB1WyBMfDweYbh/dwd/sSzjjJFAzaJ4EZ7ba7JhtBqDCd8Lyn/5dCr0D/xG9F/22g08LJ0x4wLhyJUSw18su6qxJySEnSyDAGqrIbsh1nzeBzRyyKMaEQHS4Fk2gow/RTeHv2LzcodWIG6HX1UqtmGdLwtR1OvA2aQa69bdaGzrqgwrUJFNE9NnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH8PR12MB7349.namprd12.prod.outlook.com
 (2603:10b6:510:217::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 16:33:07 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 16:33:07 +0000
Message-ID: <0dccf054-fe56-4ab5-98cf-1be764005851@nvidia.com>
Date: Wed, 7 Oct 2026 11:33:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/pci: Make ACS Control read-only to guests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
References: <20261006013133.3457555-1-tdave@nvidia.com>
 <20261006013133.3457555-4-tdave@nvidia.com>
 <20261006004130-mutt-send-email-mst@kernel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <20261006004130-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:303:8e::15) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: c703a856-40d4-4671-f1ee-08df2490aae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|10067099003|56012099006|6133799003|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: ubrcpQ5eRWQtDzyyImA6GeWSNP9hiCFFvVs1J/Itvjl5ZJqA85J/P/MdCg4CeWtjVrO8XksWfzODegJUlURMr5w/VU5xsTWJWuYDNYv/PXJNRtds0D1gd5kgNZRD2Cn7g4tnSE6fePAmqmveDvwSqfNTAq+sBtm1vWSFPoG82+BzY93+JWpYnGrHYyrhdd6mHfMjvVuZMZBCbtRWUx56d80+V8F6iFSRYdY7NS8QKnpSdryikaMABmsVOy+HidsZ6XT0Z0g52qJE7sLD7OOfGOVLhhX16Xf3+nluruQGzZo+k7HuZ0ewOfdtFGRizq4EjKZFWp4nQRDhQkTzzW+AZ56FiThbyfsLT8NehC0rx7tM1V9CW2iE0YMcIlcvbpMjsXk+GDDNYgynKq9zmE0+spOkrbcrFtNdPRPHSUO+rikW8IWKUZy+HK2RQThPwocbeX7kevDZUxK2lFXNriYJux0Cu0Go5Xq7/YL3xdSeeFC4Kvw6rZBk60sWO5FhULYwY7GNbwL89hSPWiJASp1dyBvr2yq1niCpknXLE5cVJ7qd/7fNjOU2ONHcKSYNtf5wt/2vdmLpAn8yuM0gYlZAIM1rHdb6oJMdA0ek2IBBRxPRo3TK79knsvp614MsskUbA8uBgejlyT8euQySxz+ez55lCUB84yRPlAZdwG7tZM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(10067099003)(56012099006)(6133799003)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBOdW5weXFYSGt0aS9VaHFzTU1tS0grUU00QmZXNjFYcDFLbXQ5WjNDOXNm?=
 =?utf-8?B?ajJlTU9QSXRCQzFCbnhPUTFoMWY5amM3Tll1YkhDUFpjRFJRZElLSUFGRU1O?=
 =?utf-8?B?Q1orYVVkNG5GeWFYemJHL0R0NVNDbU1LRnhHek9qTEU0bXBtMGxoSTl6UHJV?=
 =?utf-8?B?U0NCaUhwaVVXUnFodWxzd0NLWVpieEVIdWlUYld6eXp4ZnF0aWVUNUdBSlpT?=
 =?utf-8?B?R3UxTXRGTGpYbzkwTkpXV05ZelpPTFNBaE45OVE0ZUc2ZUxoMlhvL04yaGp1?=
 =?utf-8?B?SXdmMjhjSjVUaTJOZUo4ZVkzUE10TjlBZEdSdThFTVBhQU5QRDNTZTBsd0ps?=
 =?utf-8?B?TnZkOGRwUWRjcktURVl3NkFHU3pZRUJ5c29aVDQvQXVnTGRvY0F0Vmg5ZFI4?=
 =?utf-8?B?QTFhcnh3NzVEVkdaeDB3NkdhWHhWOTVsZ2xSQXpDU3EvZkFPbEs0aFR2T3pT?=
 =?utf-8?B?R2U4TkIyYmlSQ0lvRUlTc29SeGd5VVZSZkRmdjhZdlhoUWdWNW9OUUN0Uk8w?=
 =?utf-8?B?Q3Q2dEJGb0x0QWd0ckdRaWZOOVJPN3NjNUl1NTFjRGZqclZJUTZjVUtqa3Vi?=
 =?utf-8?B?cEdjSzZZaTRGU1JVdyswd3EwUXFHMFY5TzZtL3ZXUW9maElOQlVBQ3gwcnRT?=
 =?utf-8?B?M1FidmROVWN0V0lJSUVZeng5TUhpTUQ3WC90dW1LNUNtM0EwaTVab2lkdjZz?=
 =?utf-8?B?bTMzWlhZUENxMVc5ZFhYSVpkTWRkMFUwRy9uZ0RoT25GbDZGbjNhUjFMdkpZ?=
 =?utf-8?B?R2JLa21STVBhNWdlREdMM000bzh5NTFHZ1lQdlEyRkx0WGFRVmxLaS9ZdFZr?=
 =?utf-8?B?eW5NUkg3V3ZBbFhNQUNqbFRDZmpOMWFYTktZeEpYZlpibktTSDFwRXQ4MTMv?=
 =?utf-8?B?RUlZQmZPOEdic3VNZXNVSDI4bVFiNlM5b1pkNDduY2xVQ2ljNlJSeUE1WndZ?=
 =?utf-8?B?VkxrRXlYanNLRWEzTFBqU3VQRkgwL3ZJeFZTamhrYlYyM3FWTGJ3TUFzWWNt?=
 =?utf-8?B?WVhkYWcza3lxa3QwN1VSeGVKMmZGbUdwcU5UYXpuYThtZjZtRjRWcEdURXpY?=
 =?utf-8?B?WHMrdkJiZGM3UDRIYVNFaHRPalNnMUkrMitoNUpYQk9ZblQ1Z0NqU0FuQmlE?=
 =?utf-8?B?aEJEU0tDbUhmaVE0OWdLWFNaN2tqVHg1TnlvQlE0RlM3cWE4U0hFUHU0aytU?=
 =?utf-8?B?ekNxVnc2d3NFT1F4QjI3WjV3eGxWUUxRS0VINjJMd05xaXk1MWNyM0JCdXc1?=
 =?utf-8?B?dXFZRGZkTk5ZQzB2SndHOE5BaUpySi91RUJ1c1ZuQWExU0RzNmhlN1hVejhF?=
 =?utf-8?B?MWJQRW1kNVhlN0J2eVpzREZlRk80NlRrVUVOcXZidEhiR1JqWU9qRXNnM1kv?=
 =?utf-8?B?VDYxK1lEVFFLVStSMGJBRjcvTUVDemdjYjN4bUJ1V1VSUlBaYlB0NDMrdmdj?=
 =?utf-8?B?NlJaMUdMVFB4OWYySUVmN1hUWHJrYmJQYitXdWk0cFIyNFRGRm1kcUtILzBI?=
 =?utf-8?B?OStUa1dMcmQ5bE5Ya3pnRVNTd1RBdEpIOERvZjRMZ0ltSkhLMUJERkhtcjhE?=
 =?utf-8?B?c1FBZlh3VWNGY2lmOTVXV0lQM25ZZ0VsQ0FXNVVyS2JoWlVNazZIZ3cxMzgr?=
 =?utf-8?B?R0wvOXpGN3ZKLzNPQUo2ZmlwS2EwN3FwOUprQXBHNzZISDBOYTg1L0l1WTVh?=
 =?utf-8?B?Q1NqYnJsekNxSmhFdkJGSmxQbjI0WjZLYU42Wk9jbklEUHVSVDl3WHd4SGtL?=
 =?utf-8?B?Vko3cS9DVElrUENOZnpxRUpOYXFHNVJtcjBoZzNvNEVzMzU3Yk1CajJYbDNM?=
 =?utf-8?B?anVVWFYyU3dYSEwyVjRNYkhMaE90MU1KSDlGSUZRMDZoWS91NmZNTEpBSnlw?=
 =?utf-8?B?ZE43eUhCWTVuMnpjODcxcE5KUmtBR0x5aTFWVGFKdVhNdjNvd1BzOW53YytN?=
 =?utf-8?B?N2NGWkNGek9YdVBNMnU1cnFablhvVmthTEFYUVdZdk5qR2lnb1pPWUN3WDla?=
 =?utf-8?B?QkE3SDhvU0hqT0RTekxDZkV2YVppb3ZGN1ZoQmdDZi9zTlFheHYxTFQ2aktk?=
 =?utf-8?B?ZW9ub2U4S1A2b0JTWGtVVXJzeE9jNGJhN1grRnlxTW1LMGRDUUUvS2w4OE1m?=
 =?utf-8?B?S29nSUZTRnB4TVNzMkVVRmp2R3BDZnRWZXdQQmQzbUxmTUFhTk5mZFhOMTQw?=
 =?utf-8?B?cTF1K2NXS1hrODRwMmNKZGpiN0tjdFhYZmdPSXhhWnZlaURiTFU4Wmo1N0xK?=
 =?utf-8?B?a3h1QnlvYnREQmlPcEVwc3krTkV4YzhMei9nYVhyeDhGdi9SQXEyazZydjJ5?=
 =?utf-8?Q?PMsWnKO94BGSCTB+rg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c703a856-40d4-4671-f1ee-08df2490aae5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:33:07.2270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfzLzpwh1+BZxZz9QwUXgiYm7rzaMXjD8LGGhX56piyfJWzkMu4l+UGhemPoO1MSGvUQ3wvUqUCiSeqb2iOq+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
Received-SPF: permerror client-ip=52.101.201.44; envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 10/5/2026 11:44 PM, Michael S. Tsirkin wrote:
> On Mon, Oct 05, 2026 at 08:31:33PM -0500, Tushar Dave wrote:
>> GPUDirect RDMA using data-direct requires a specific ACS configuration
>> on PCIe Root Ports and Downstream Ports.
>>
>> While ACS can be configured via QEMU's 'acs-ctrl' property, the guest
>> kernel may overwrite ACS during standard programming.
>>
>> This change blocks all guest writes to the PCIe ACS Control register and
>> preserves QEMU-provided ACS settings across device resets on PCIe Root Ports
>> and Downstream Ports.
> 
> Why is that a sensible thing to do?


It is sensible because it allows the administrator to define and
preserve the PCIe topology and P2P configuration from the QEMU command
line. The administrator can configure ACS on a Root Port or Downstream
Port as part of defining the desired PCIe topology and P2P behavior. If
the guest could modify the ACS Control register, it could change the
administrator-defined ACS configuration, which could prevent P2P from
working as expected.


> per pci express spec:
> 
> 7.16.3. ACS Control Register (Offset 06h)
> 
> Bit Location
> 0
> Register Description
> ACS Source Validation Enable (V) – When Set, the component
> validates the Bus Number from the Requester ID of Upstream
> Requests against the secondary/subordinate Bus Numbers.
> Attributes
> RW
> Default value of this bit is 0b. Must be hardwired to 0b if the ACS
> Source Validation functionality is not implemented.
> 
> 
> And this is repeated for every bit:
> 
> RW
> Default value of this bit is 0b. Must be hardwired to 0b if the ACS
> Source Validation functionality is not implemented.
> 
> 
> 
> Looks like your change would put us out of spec?


You are right that the ACS Control bits are defined as RW, and I am not
claiming otherwise. The intent is not to make ACS Control read-only in
general. The read-only behavior is tied to the acs-ctrl property:

- If acs-ctrl is not specified, ACS Control remains writable as it is
  today.
- If acs-ctrl is explicitly specified, the administrator has requested a
  specific ACS configuration. QEMU then preserves that configuration and
  does not allow the guest to modify it.

This is an intentional virtualization policy. When the administrator
explicitly configures the ACS Control register, the guest should not be
able to change the ACS configuration and P2P behavior selected by the
administrator.

Thanks.
-Tushar

> 
> 
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  hw/pci-bridge/pcie_root_port.c     |  5 ++--
>>  hw/pci-bridge/xio3130_downstream.c |  5 ++--
>>  hw/pci/pcie.c                      | 46 ++++++++++++++++++++++++++++--
>>  include/hw/pci/pcie.h              |  3 ++
>>  include/hw/pci/pcie_port.h         |  1 +
>>  5 files changed, 54 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
>> index e7cce8c0ee..6ac64c8b2b 100644
>> --- a/hw/pci-bridge/pcie_root_port.c
>> +++ b/hw/pci-bridge/pcie_root_port.c
>> @@ -123,7 +123,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
>>          if (rc < 0) {
>>              goto err;
>>          }
>> -    } else if (p->acs_ctrl) {
>> +    } else if (p->acs_ctrl_configured) {
>>          error_setg(errp, "acs-ctrl is not supported by this root port");
>>          goto err;
>>      }
>> @@ -159,7 +159,8 @@ static void rp_exit(PCIDevice *d)
>>  static const Property rp_props[] = {
>>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>> -    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
>> +    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
>> +                                   qdev_prop_acs_ctrl, uint16_t),
>>  };
>>  
>>  static void rp_instance_post_init(Object *obj)
>> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
>> index e243dfdf7d..66d25098d7 100644
>> --- a/hw/pci-bridge/xio3130_downstream.c
>> +++ b/hw/pci-bridge/xio3130_downstream.c
>> @@ -120,7 +120,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>>          if (rc < 0) {
>>              goto err;
>>          }
>> -    } else if (p->acs_ctrl) {
>> +    } else if (p->acs_ctrl_configured) {
>>          error_setg(errp, "acs-ctrl requires x-pcie-acs to be on");
>>          goto err;
>>      }
>> @@ -154,7 +154,8 @@ static const Property xio3130_downstream_props[] = {
>>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>>      DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
>>                      QEMU_PCIE_ACS_BITNR, true),
>> -    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
>> +    DEFINE_PROP_UNSIGNED_NODEFAULT("acs-ctrl", PCIEPort, acs_ctrl,
>> +                                   qdev_prop_acs_ctrl, uint16_t),
>>  };
>>  
>>  static const VMStateDescription vmstate_xio3130_downstream = {
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index af24ec7fd9..1fead3a053 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -1265,6 +1265,8 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
>>  {
>>      bool is_downstream = pci_is_express_downstream_port(dev);
>>      uint16_t cap_bits = 0;
>> +    PCIEPort *p = (PCIEPort *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_PORT);
>> +    bool configured = p && p->acs_ctrl_configured;
>>  
>>      /* For endpoints, only multifunction devs may have an ACS capability: */
>>      assert(is_downstream ||
>> @@ -1286,7 +1288,7 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
>>          cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
>>              PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
>>  
>> -        if (ctrl_bits & ~cap_bits) {
>> +        if (configured && (ctrl_bits & ~cap_bits)) {
>>              error_setg(errp,
>>                         "acs-ctrl 0x%hx has bits not supported by this port "
>>                         "(supported: 0x%hx)", ctrl_bits, cap_bits);
>> @@ -1295,7 +1297,17 @@ int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
>>      }
>>  
>>      pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
>> -    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
>> +
>> +    if (is_downstream && configured) {
>> +        /*
>> +         * Block guest writes to ACS Control entirely to preserve QEMU
>> +         * ACS settings
>> +         */
>> +        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, 0);
>> +    } else {
>> +        pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
>> +    }
>> +
>>      pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
>>  
>>      return 0;
>> @@ -1308,6 +1320,36 @@ void pcie_acs_reset(PCIDevice *dev, uint16_t val)
>>      }
>>  }
>>  
>> +static void set_acs_ctrl(Object *obj, Visitor *v, const char *name,
>> +                         void *opaque, Error **errp)
>> +{
>> +    PCIEPort *p = PCIE_PORT(obj);
>> +    const Property *prop = opaque;
>> +    uint16_t *ptr = object_field_prop_ptr(obj, prop);
>> +
>> +    if (!visit_type_uint16(v, name, ptr, errp)) {
>> +        return;
>> +    }
>> +    p->acs_ctrl_configured = true;
>> +}
>> +
>> +static void get_acs_ctrl(Object *obj, Visitor *v, const char *name,
>> +                         void *opaque, Error **errp)
>> +{
>> +    const Property *prop = opaque;
>> +    uint16_t *ptr = object_field_prop_ptr(obj, prop);
>> +
>> +    visit_type_uint16(v, name, ptr, errp);
>> +}
>> +
>> +const PropertyInfo qdev_prop_acs_ctrl = {
>> +    .type = "uint16",
>> +    .description = "PCIe ACS ctrl configuration (if set, even to 0, "
>> +                   "makes ACS Control read-only to the guest)",
>> +    .get = get_acs_ctrl,
>> +    .set = set_acs_ctrl,
>> +};
>> +
>>  void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
>>                              uint8_t pasid_width, bool exec_perm, bool priv_mod)
>>  {
>> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
>> index 678ad73f7f..bbb11fd402 100644
>> --- a/include/hw/pci/pcie.h
>> +++ b/include/hw/pci/pcie.h
>> @@ -26,6 +26,7 @@
>>  #include "hw/pci/pcie_aer.h"
>>  #include "hw/pci/pcie_sriov.h"
>>  #include "hw/core/hotplug.h"
>> +#include "hw/core/qdev-properties.h"
>>  
>>  typedef struct PCIEPort PCIEPort;
>>  typedef struct PCIESlot PCIESlot;
>> @@ -86,6 +87,8 @@ struct PCIExpressDevice {
>>  
>>  #define COMPAT_PROP_PCP "power_controller_present"
>>  
>> +extern const PropertyInfo qdev_prop_acs_ctrl;
>> +
>>  /* PCI express capability helper functions */
>>  int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
>>                    uint8_t port, Error **errp);
>> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
>> index 2ad9a563d9..ef2c2ec2cd 100644
>> --- a/include/hw/pci/pcie_port.h
>> +++ b/include/hw/pci/pcie_port.h
>> @@ -37,6 +37,7 @@ struct PCIEPort {
>>      /* pci express switch port */
>>      uint8_t     port;
>>      uint16_t    acs_ctrl;
>> +    bool        acs_ctrl_configured;
>>  };
>>  
>>  void pcie_port_init_reg(PCIDevice *d);
>> -- 
>> 2.34.1
> 


