Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A040C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYN63-0000MV-VF; Fri, 09 Feb 2024 04:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rYN61-0000ME-Nz
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:22:57 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkale@nvidia.com>) id 1rYN5z-00046W-Fx
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:22:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgPt6lpPnP9PwNhI8UG/OjwJQr2uVPKazD04sd4zEboEkva7S6CCns8shOlxYNAs1r7MwaqYgNGW6lbO891CvvVg9kliDsKQ6IurdupN60o8ONp9YzbuQKgD1dmPm5MCISpLKq9sbXD38vh8UmrCNyEqe8as2jx5rRGzeT9wexQWxLYSw8m8yWNQgmw1bleBPxeigLrKn6SlXDFXjXA90vinXGHApIBzJyjKMw9TV+aAbmAlHqEYzp1yivt0ZCygGw6G+ri8oGv0U5ngru0vgkG9iO+CNXSuZ3l0ilIFJ0OqsQV/64e4p6IIHaPJh0vhRDUUUQXKYx8uiQ1H+u8Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZK4BYzqQNyOz3VJwkG2OBCHji7ivdR48jJ1PtCKynU=;
 b=Ij5oFh9Atp5Sm8nKv7xIr17cAdeJ00aQrYW0PsynN+Ugs1I943/m2AtuSgIN397xuHS1h3V4nT8Rm/7Qzec9MQWyxAjG/pQAQ9YIEyjFnWAskBSd/VNaoq32YTOW7/+s/wJknGlfLmUqbV2g1/UsTP+oPe51loQba/eM8ldym/aNkdVyCWG3RV4oiVOkNK/B+A3Y207Xodz5e4ZgGVjl0VjMn89HxyOn+ICOf6ZvjTDGJN3ZE0tcUILFjYDcv2lA+jhR5ilZdrY3STDpUIpYR8oxGmC/ApsIT10iOgA8LVKpb+LTs1Brka5nmwnqLFGSkUexkzTaTqynYkZIzFfekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZK4BYzqQNyOz3VJwkG2OBCHji7ivdR48jJ1PtCKynU=;
 b=JJ9VGUE2dSwKXF3rLxY+i5NHpjYUNti13j0FPLV+m40RFG2OV4EOylvcYcZRgCWs/W5Mng259jBVhQ79EPqrN4sF2HFvKBGFywT2vTq5vDq0+J3sHnpDZYI+cCk1VtwSYAxjOUfgR1H+IEaUnNslm7tUbNT9VD+Qh31EqC3gdR/BYrryVGBLoIYJe7h74vFnYKJxp+7Zi/8ueKINCyBf6AGjztA9aczwuc4DIL50ATvlPLhK+rY8K5nN4v9uoHa+jNPZ7IxuD6mk44XnmHrk0k5Gk3SsOfOBSNDtW6QjTIxsPFutPyOcyKU6/maFcl89VKsz7EpwrfQ28I4H0JjOAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Fri, 9 Feb
 2024 09:17:45 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::882:18fc:98cd:f5e6]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::882:18fc:98cd:f5e6%6]) with mapi id 15.20.7292.010; Fri, 9 Feb 2024
 09:17:45 +0000
Message-ID: <46fdbaae-2181-4ff9-af73-4e6e69cc6f08@nvidia.com>
Date: Fri, 9 Feb 2024 14:47:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, zhiw@nvidia.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 targupta@nvidia.com, cjia@nvidia.com, acurrid@nvidia.com,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com
References: <20240130095617.31661-1-vkale@nvidia.com>
 <4d6a45ed-ca8d-4e41-b536-c2502ff1ce8b@nvidia.com>
 <20240130115832.462e76b7.alex.williamson@redhat.com>
 <f6586fc8-d64c-4ff0-80ac-1eb18b5f486b@nvidia.com>
 <20240131103817.50389f39.alex.williamson@redhat.com>
 <b83a9452-cbcc-4f4d-b0f7-b4957029e755@nvidia.com>
 <20240201130440-mutt-send-email-mst@kernel.org>
 <20240201170347.41b8994b.alex.williamson@redhat.com>
X-Nvconfidentiality: public
From: Vinayak Kale <vkale@nvidia.com>
In-Reply-To: <20240201170347.41b8994b.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 68461a73-e11b-4322-5aa5-08dc294ff9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUYqcbs8sH1l5BhnU2Vw5KV5RArJ9x5+u9ZFTXKQDLslip4KOkB9m4RbmSzkIH6jOfFA0HuTcwQhgiC43GznbcKbiQpnG8dAfYlJSIk9ehyCtTpsgVuUvOWtqWTLoPnFS8aWj1821NVMr9qobqTzn9Eq0c8esmYl9P9EUcuy+znfYCTqxg2eGkEALjKSAfDWBpEbMQccS4JdMmeP0R5+HHkmIPEywwx6oXkfEw3r8YpSpSvdaTKExRIW7xWO7iSIFWTgrRAkwjWN+0MmKmKT2oWb2Tc7yuhFIid2EqmKKBMOfJoEjF3/d3/HuT/uKPkVnvaYE2oFBGnuaoxYI4fXLIduTfYxcdAnC6JEe4ICunr90LmJytzrx10RLkjSTS1j/GBzkdcyIBO58L3KV+Vp1AVK9tOebXfCsLE4+XbHy9xtng/6CTBOqh6kiMu/jkji/0F/i3gjugW+9er2+6VnRBlc5iZ2zin7+m+YuYMNt8l7tCLnYbzioTZ+XW09uNAwjujsA+MNKP6P1MVmb4d+BDzrLixd0n54R9mPpDRQTgnWKoS+KwwyXCH1fr7GUQ78
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(38100700002)(83380400001)(66946007)(2616005)(6486002)(86362001)(31696002)(107886003)(26005)(6666004)(6506007)(478600001)(6512007)(53546011)(66899024)(36756003)(316002)(6636002)(66476007)(41300700001)(66556008)(8676002)(8936002)(4326008)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpsNHpUY09qd0lhV1N0M0pOYW5CN1RKbUJ1TkVkUU9mVVB2ZnF2N1h6NnVJ?=
 =?utf-8?B?cEhaVVFFazJmcENudzYzaThCRndoQzBORi9acElSenZ1Mi9iQkFxc2VNNlRF?=
 =?utf-8?B?a0NENllpQUtWZWdPMURDNGNDcnpRUmJVekZQaGNoVG1pK1RvT2VBRWpoM0M5?=
 =?utf-8?B?dnFlRmpya25YRHpFSHFtdUw0WmkrODdjeFlJL2xLMlhTYk1USGtQNGIzdWto?=
 =?utf-8?B?MDhJbUF3aXkya3NvN2pPYXY3NGlNN28wTkU1MWtLRktHcjU1VjRSdHc4V1JT?=
 =?utf-8?B?TGZCTWRUTlRhaVNoeE1pY3BEeDRSbE5UQldTTmZZRkloUEQxUVB1TWdiK3VK?=
 =?utf-8?B?YkhydFA2UXQ0b2xGNGJHVllNT0N4WktMa3o2VUF3aGZvVGl2Q0dxYWhRYTlJ?=
 =?utf-8?B?UkI1Wk5Qcjd3TmZhTytiSjlUWHJEdXVsOTNVWFBNQ1hkUmsxVHpZN3BKNnM3?=
 =?utf-8?B?TlJGT2dnbHl2dXl6RUcwYnBNS2pId0U5bC8xOEdUMWQ1TDNodjFmTHV2Rjlx?=
 =?utf-8?B?am9tL0NLV0UwSG9YbU0xNkttZzhqWjlpV01NTUNPdmN1MFZjdXk5eVlUdTNO?=
 =?utf-8?B?cWEwZEZWekUzV3dQZzliMDh0SXkzTTBmY2JRbHl6eGkySGJFNTJUQy9OYkxF?=
 =?utf-8?B?NXp4QmJEeEsraWdSeitKYXU2ZUszUTVWdmpMZmNwUUFLZ3A4Q1RNQ2tod002?=
 =?utf-8?B?VDNMVDhSMzFiWWVPMU5XRFdzM29vb1hqdzZ4dDhONnJZMVhLR0xUQXkwVlZC?=
 =?utf-8?B?SW9IZS80Q1FDSVFBNE1mU0Q4WE9GNkhocjFCRC9yMFVNM2pobzFielROdTVh?=
 =?utf-8?B?UWo0QUU4SncyaUNNTzhub01sNU1NS2ZVdjhrMTcvLzJvWWtFWlB5TXNFbDAy?=
 =?utf-8?B?MlhWUXhQTlljWUNZVThWWUg3K3VQZVZ6SlVDcXlWWWJ0azFoc1hTalExT2ht?=
 =?utf-8?B?Q3l2T3hQR21Wc0Z0bjQzWTJvUDVZNmQ3R01aUTREbit2WGM1bnhPVFhPSU9M?=
 =?utf-8?B?K2NiV0EyRU84a1dLbUphZFNtajhEZXVhL00zblUwaytob3VnelRMU0V2SDdy?=
 =?utf-8?B?bTJ6L1F2OGZhYkFSTno3azVVYlRjdzl0SWJsR2dnUEZBdytQUkJ6blozcm0x?=
 =?utf-8?B?TE5rQS9JdTM2OGFtRE14MnBoZEFaMTJwYi93QlI1SkNCU1hESGZBMW45ck9V?=
 =?utf-8?B?WUZJSUJWSkVGWjl2MmhsUTJnRXduaDV4Nk1XRkNiU0dTSUtJWFNiU1VXNE80?=
 =?utf-8?B?eWovckN2b21YYzRmYkIxMG1acjd3Y25XYnBwM05sZm5qV0xyc1VsWEZzWWhZ?=
 =?utf-8?B?L25McHpVUXlCWDlCYVVPL0w4T2xRanh3SVdqRWgzMy9RY3krakZiTGxOUVMz?=
 =?utf-8?B?bXp2cDQ0cm1UN1JzdDVzaFJTK21TQU9KUStDTkhhWHVLNmZrVFNMbkxRb2wy?=
 =?utf-8?B?YUZXZE5GNndtbHh1cEhmNnF4R1JRQ01sOGg1SVlJbzJXaUgwLzhtUmF4amY1?=
 =?utf-8?B?UVRkb3pxemZubjk3L1BZa2JwREZCS0Q1ekJLS1Jwd3FMR2FYRkhKMUh1ZG1K?=
 =?utf-8?B?WTRuM2xTSVN6RWlDVGhHRUpnaHhZcmh6NHc3ejJsZ01CcDByRDYvZDZuUENa?=
 =?utf-8?B?dmFkS1FVRy8wcFJUNVhNTXE4N3R0L0xLcVBGZUJ3MjhlQ0p0SDdCYjZMS3lh?=
 =?utf-8?B?Wldldno1eW5ZN2JMb1A3MFh1OHJkZlQyV2dVOE9wbFU3TDEwUVQwdnZXdmo0?=
 =?utf-8?B?NjFNOWtVbGQxUFhnOG1SYys1M1pLbnV5Tzcwa2xOUmw0dUJLRnIxQnN2RVM4?=
 =?utf-8?B?ODgwTDErNncxNVY4Y0VUWmhMSFN2MWh0ZlA0Y1F5NXordXFKSVRuQ1ZyQzR0?=
 =?utf-8?B?dW5vYTdla3l1V3F5Z3BtdTU5RzZhQ1Zyc1pLbDNUOVFjMlZpR2NsTEZmdUFE?=
 =?utf-8?B?Q2huQ2VIVHpmQ01VcXZQTjlNaUc2MTJCRlZmd2FIdUhjMGcwREhjZXZBcE9Q?=
 =?utf-8?B?WGh1c213S0MvOVhzUlpEQWJUTVQzL05CeWF1dVd1eVBKdGpRbXFtV2xxREZQ?=
 =?utf-8?B?bC9scjU4MFFyeXVrNko4NitaWENockhlSGFzWnRjeHJ0OXUxOGFuMVhjUTFh?=
 =?utf-8?Q?oR+d7f9wy3CkAS4QaEu2AptGk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68461a73-e11b-4322-5aa5-08dc294ff9ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 09:17:45.6216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAFdVAVOhCMZtf5MXvvlAGJqFAEhQmF70Q52ky+93Gfm2hrBXXIRDAOp2RQQQJgNp6PgrC/rXz5hpROJ82wphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
Received-SPF: softfail client-ip=40.107.236.41; envelope-from=vkale@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 02/02/24 5:33 am, Alex Williamson wrote:
> 
> On Thu, 1 Feb 2024 13:10:48 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Thu, Feb 01, 2024 at 11:08:58PM +0530, Vinayak Kale wrote:
>>>
>>> On 31/01/24 11:08 pm, Alex Williamson wrote:
>>>>
>>>> On Wed, 31 Jan 2024 15:22:59 +0530
>>>> Vinayak Kale <vkale@nvidia.com> wrote:
>>>>
>>>>> On 31/01/24 12:28 am, Alex Williamson wrote:
>>>>>>
>>>>>> On Tue, 30 Jan 2024 23:32:26 +0530
>>>>>> Vinayak Kale <vkale@nvidia.com> wrote:
>>>>>>
>>>>>>> Missed adding Michael, Marcel, Alex and Avihai earlier, apologies.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Vinayak
>>>>>>>
>>>>>>> On 30/01/24 3:26 pm, Vinayak Kale wrote:
>>>>>>>> In case of migration, during restore operation, qemu checks the config space of the pci device with the config space
>>>>>>>> in the migration stream captured during save operation. In case of config space data mismatch, restore operation is failed.
>>>>>>>>
>>>>>>>> config space check is done in function get_pci_config_device(). By default VSC (vendor-specific-capability) in config space is checked.
>>>>>>>>
>>>>>>>> Ideally qemu should not check VSC during restore/load. This patch skips the check by not setting pdev->cmask[] for VSC offsets in pci_add_capability().
>>>>>>>> If cmask[] is not set for an offset, then qemu skips config space check for that offset.
>>>>>>>>
>>>>>>>> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
>>>>>>>> ---
>>>>>>>>      hw/pci/pci.c | 7 +++++--
>>>>>>>>      1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>>>>> index 76080af580..32429109df 100644
>>>>>>>> --- a/hw/pci/pci.c
>>>>>>>> +++ b/hw/pci/pci.c
>>>>>>>> @@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>>>>>>>>          memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size, 4));
>>>>>>>>          /* Make capability read-only by default */
>>>>>>>>          memset(pdev->wmask + offset, 0, size);
>>>>>>>> -    /* Check capability by default */
>>>>>>>> -    memset(pdev->cmask + offset, 0xFF, size);
>>>>>>>> +
>>>>>>>> +    if (cap_id != PCI_CAP_ID_VNDR) {
>>>>>>>> +        /* Check non-vendor specific capability by default */
>>>>>>>> +        memset(pdev->cmask + offset, 0xFF, size);
>>>>>>>> +    }
>>>>>>>>          return offset;
>>>>>>>>      }
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> If there is a possibility that the data within the vendor specific cap
>>>>>> can be consumed by the driver or diagnostic tools, then it's part of
>>>>>> the device ABI and should be consistent across migration.  A mismatch
>>>>>> can certainly cause a migration failure, but why shouldn't it?
>>>>>
>>>>> Sure, the device ABI should be consistent across migration. In case of
>>>>> VSC, it should represent same format on source and destination. But
>>>>> shouldn't VSC content check or its interpretation be left to vendor
>>>>> driver instead of qemu?
>>>>
>>>> By "vendor driver" here, are you suggesting that QEMU device models (ex.
>>>> hw/net/{e1000*,igb*,rtl8139*}) should perform that validation?  If so,
>>>> where's the patch that introduces any sort of validation hooks for
>>>> vendors to provide?  Where is this validation going to happen in the
>>>> case of a migratable vfio-pci variant devices?  Nothing about this
>>>> patch suggests that it's deferring responsibility to some other code
>>>> entity, it only indicates "checking this breaks, let's not do it".
>>>>
>>>> It's possible that the device you care about only reports volatile
>>>> diagnostic information through the vendor specific capability, but
>>>> another device might use it to report information relative to the
>>>> internal hardware configuration.  Without knowing what the vendor
>>>> specific capability contains, QEMU needs to take the most conservative
>>>> approach by default.  Thanks,
>>>
>>> PCI/PCIe spec doesn’t define ABI for VSC/VSEC contents. Any other code
>>> entity except vendor driver should ignore VSC contents. QEMU’s expectation
>>> of VSC contents to be equal on source and destination seems incorrect given
>>> that QEMU has no control over ABI for VSC contents.
>>>
>>>>
>>>> Alex
>>>>
>>
>> I don't get why this matters though. This is no different from any other
>> device specific register. If a register is visible to guest it generally
>> should not change across migration. If you are migrating a VFIO device and
>> you are making a vsc visible to guest then your migration routine must
>> make sure to migrate the contents of vsc.
>>
>> Maybe there's a good reason to have a register which actually does
>> change. Then, please document the actual reason. When you say:
>>
>>         Ideally qemu should not check VSC during restore/load.
>>
>> then that is clearly wrong in most cases.
> 
> The argument as I understand it is that enforcing that the contents
> remain unchanged between source and target is a policy, but QEMU has
> no basis to create such a policy because the ABI for this capability is
> not defined by the spec.  Furthermore since the ABI of this capability
> is only defined by the device, only the driver for the device should
> have any interaction with the capability.
> 
> There's some merit there, but a potential flaw is that QEMU does in
> fact register several vendor specific capabilities for which it does
> know the ABI.  See for example:
> 
>          vfio_add_vmd_shadow_cap()
>          vfio_add_nv_gpudirect_cap()
>          pci_bridge_qemu_reserve_cap_init()
>          virtio_pci_add_mem_cap()
> 
> I think only the vfio VMD one can be claimed not to support migration
> since afaik we could add a GPUDirect clique capability to a migratable
> vGPU.  So since these are QEMU created capabilities and QEMU does
> understand the ABI, what about these specific capabilities would allow
> them to change between source and target VMs?
> 
> The GPUDirect clique capability describes p2p capabilities between
> devices.  That information cannot spontaneously change.
> 
> The bridge vendor capability exposes reserved bridge resources, which I
> think is consumed by firmware so a change would result in resources
> shifting after migration and a guest reboot.  That would be bad.
> 
> The virtio vendor capability does a variety of things that I'm sure MST
> could explain better than me, but also seems like defined ABI to the VM.
> 
> So actually is it the case that the only vendor specific capabilities
> exposed to the VM that QEMU doesn't understand are those provided from
> a device exposed through vfio-pci?  If that's the case, then QEMU's
> default policy to verify that the vendor capability is unchanged seems
> to be valid and I'd think the patch instead should be creating
> exceptions to that default policy for vfio-pci devices (ie. nothing
> says vfio-pci cannot clear cmask bits set by the pci-core).

In our case yes, QEMU doesn't know VSC ABI as the device is exposed 
through vfio-pci. I will update the patch to create an exception to the 
default policy for vfio-pci. Thanks.

> 
> I think we also see above that there are vendor specific capabilities
> that have a scope beyond the guest driver itself, some visible through
> userspace tools, some consumed by firmware.  So I still find it
> difficult to determine whether any vfio-pci exception should be
> unconditional or tied to specific devices.
> 
> Also, migration is only supported by vfio-pci variant drivers, so why
> is it that the variant driver cannot or should not make the target
> capability match the source?  If the contents of the capability
> changes, does it need to be exposed at all by the variant driver, or is
> the vendor specific capability the only means to expose this
> information for the driver?  Thanks,
> 
> Alex
> 

