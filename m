Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37F3C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 15:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZYgf-0007lY-Vz; Mon, 12 Feb 2024 10:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZYge-0007lA-64
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:57:40 -0500
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZYga-0006vk-IB
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:57:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7rC5J9qCwcApvpQXD0gSHBidSszPSCFYXi0SSMZYzOs2bd5TisdRH14adfNzYU28hqxwdgzzgI32cIUyHES+Nw187k1vFf6njbBTuyvFL1Fk0EBh6rsIOVUM5h6H3C4PZUlY7ZqyWn5t/EnjgIl0B8tNP1r0+jaeSviNrLDRB5kAtw4qGxbCbBIhcRIECASJ40PVfDB8MJN3l3yXFPmK7zk4YBPpX+rWs9zLLMvQEIOVUnzAgY4rhUK8b+6iPndhut08QcByt/MQW20XmD6MlG+Gsj+Aydmin588r7wgQUsErtiCeCb5BCCwgXA26Jd7r5/ItPMe1bQn6gQLiVTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfILNxu2ncaSsNPIsCnNOd1mtNXpb2LIhlqea3ExNPo=;
 b=HsuvxUgTjrOU9jPcbrXlwzifjZvzwoTgOcGvurzGPa8tLEVM5eVmAcWl2gbSHCMA1IkCrBh+H3oJJ9vG60JT6bgfjyFuKhZqQkmk+NQVku8SACnzBqjVTVoed/dFiJg6W7INsKjvKKmj3Oria4cdc0PXrbykz5kUTI+OUDCevb3eunZxZGrFUW/Bp67n2F+NtnBpp2n5OpBXpjVQ8eVbNB/TQR4akwQr38L777pTkRdn9TKAIihUneUcFVKNeNR9VpxSujpZFRNM1QGBinzke8w8aQDrYDk+2mRucuKlmqK9wpLuMmOze5vPS9yuvLWO3QSj3sZjll07zXLLa42qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfILNxu2ncaSsNPIsCnNOd1mtNXpb2LIhlqea3ExNPo=;
 b=KMDDcPEMklPkCuwX5bITBioNbHEnzG/9NvUFLr0gIhT2+LyJC3PGw5WonxgRlpOdxdceBT0zwWYxh4Lcr/V9nrfZlcUUS9YTnO9z5ifmzLENteF/176exgN0OeLPrQ36YzTbdil54oxEyOs2eAYOL+AF7m2mxupsiw30SxXtIFHf7UIe7WA7lRjApleqdsjCutMG/VBvcb9rleW3zvsAqdh7K0AIsPHO4Rf0Vvcqb/9SeMb6D0R/F2J4/tOF5/sGMfOaKS6ds6MCd4yLN4VvgxAKfm7oG2x9T9BbAIbBahTU24z3L/HZPYNNyHrwZSDOb8kj1HsL9Wp7pFPVoXgvfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 15:57:30 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 15:57:30 +0000
Message-ID: <29b592ad-05c8-4552-ab24-99e3a32ba90d@nvidia.com>
Date: Mon, 12 Feb 2024 17:57:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-2-clg@redhat.com>
 <5addf455-c0e0-4aa6-8970-c8050a194783@nvidia.com>
 <2052b1e4-608d-4b44-a67c-e1d90e194f81@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <2052b1e4-608d-4b44-a67c-e1d90e194f81@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM6PR12MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 12af2f2e-8a66-45df-abc4-08dc2be35117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvOJ3tEDBTDPMkaCABL6sAx0gmtQFOhQ8YGS5WAWZ7AWAL/O4H3TUDFfId4ttmFCO1LjAZ+RA6EihKJwdijt6cB+RVapudWKuMfstly6bBlJxrIsOqUBRfcVbD0YcFf4Dn3aae/0mFwnOPv7GStxRX44uV3hiK7izAVkROOFkPjZ8naBgYC16ByB/xoaaBFucMZ6yJFha/J7Bhx3bt2MkpPzGSUg1tFUjeKamnlSUM6NseBaWBVDAXa2fpjWtW9zXrHNdSjbxFVLA0gkP0NawICGRUEBZ/V+y347Ohp20AmwB/0iLYgOPFIyoNRx8bkJSbQqWuatFisy+3SubbF9I0WYSwTyBmGvouilKGLwXTPUrUei3tuiMR0aDEMIVqR3/B2e+xFRtOnBJp2DUHc9NFwBgJ/sA1WlxnoBqZb0aGuXzIcg0rppfePcSqAciVqWFDWF2RI+QRy9hgQGTI+3itNBVjAqnVaZX4VwbXye+Zra5Sdk9+pE9g8QgCDo6pgyiCvm8Q6uUz6VGikQ4SUvpVuYFilappw3mQZxD3/md9luto4eyhx0IPyG1ePS6wO1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(31696002)(86362001)(38100700002)(6486002)(316002)(478600001)(54906003)(66476007)(66556008)(66946007)(66574015)(2616005)(6506007)(53546011)(6666004)(6512007)(26005)(36756003)(31686004)(41300700001)(8676002)(4326008)(8936002)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdoWmdCK0preWJwNjV2Ymdscno3TU00d1FXdVpHVTdUMEZiYmltMmZFRjFQ?=
 =?utf-8?B?SlhRUjJGM21kUGl3NWNkU2tDd0w4QnZKVHFDOUZ0dnF4ejlUNjhCblZteWlq?=
 =?utf-8?B?SEZ2NlFxaXY5TTFFZ1FHenlpWnNGdm1iNXYvMWVZQzFKWVp1ODlBNlpZeldC?=
 =?utf-8?B?UStZd3E4ZjJRNTYvd2Z0elk0SDdDdFJaSXk0U2hEc1RxUVBUWE9GM3JTWWdU?=
 =?utf-8?B?MnpvQVVsM3pjdklveDRaelJBMnVBTm5LQXNuNUtxcENOYnVGUjMvNkhFZml4?=
 =?utf-8?B?eHhEc3YrenZHNWpYMmlZVEdPV3ZnamVLRURDTmhEbXdxYXBXaklPMUxudDdL?=
 =?utf-8?B?VHl6ekxKVDZWWjBndHJNZ0U4YVpMK0g2bUh6VEUrUE0rOUJjOUorVTZIbGR1?=
 =?utf-8?B?U3BkUFZnczBrd0lGREVGdXBMVWhyMWh1Nm5zUDR0SmN6OHJRTGJQNGVBTndZ?=
 =?utf-8?B?a2pOZmNUMlpxS2NNS0VGUWp4YzVXY0FTb1JhUkdoZUZHVXF2T0FOTTBOU3V1?=
 =?utf-8?B?WFQyVW5DWlJYVTdKV0pzbUwyMDZPcVpzYzVwR2Qwdlhrb2RCY0plS3FNREVn?=
 =?utf-8?B?NW1vOE56S2ZId2NZS2lwQ09MZ0h5VEl6NG9Nc3oyb3dub3hPS0VDam5wSGNr?=
 =?utf-8?B?UUc0aVVDR2ViZ0RQb29rbm83dUk1Z0RpYnRHUUdmRDEzeHJzL1dhNXNRaDNL?=
 =?utf-8?B?N3pUUzJ6K0d0dEptM1RTeWV0MlVyU2lmbmRxYWFldW5vWk0vSHNoY2UweHJM?=
 =?utf-8?B?SEJodlpKazRxUG1PcGpQM2gvT2pNN3hSV3VZcW1rM1A1aDl6VWNyblZ5MjJx?=
 =?utf-8?B?SnVlWG1iaG9oZnZvYmlNSjNBKzRrZ3JmRU9maTJlalNNRTJGNytSMlBzMHBO?=
 =?utf-8?B?NnYvUlNPOUdlS3BXMmxkZlpKRmpoTlV4amFDTWFyVGVKQnZMVXdMR0phWE9x?=
 =?utf-8?B?WVQ3QnBsSDNra1VqNHlFbksxWXY5dXdOWEtnM2Q4d2VUTm1MQkdiWlpKb00v?=
 =?utf-8?B?b2NQQk1WK1dmMDMxeFYwd2p4SSthN1ZyUEhFeW55dkJVNFFWSklCU1J5Z29H?=
 =?utf-8?B?d0tZcmFSSHdDOVcyREdTZGlSeW91ZHB2bUhmMWhRa2FzMVNGdDl2dkdiQ01q?=
 =?utf-8?B?NTRxNTRKUEFYdnlDcVJWZHRObjhVU1JWZ1VVekg3Rk5icWZ2TVoxL1pNNzZj?=
 =?utf-8?B?dmZZVlVvTVh1RlRFL21rYUxwQksrL3NjcTEwejhFS1dWNEdzZmhNRjVHMFRh?=
 =?utf-8?B?WFA4ZlRMbi85OGJxcXZFd1V1OW9yb0Q0THZsWGVUT0FWRXJCaWQ3ekZIUUhh?=
 =?utf-8?B?WFBLelpJR09nVytyUVh6WTFab2NGdG5SZDcvYWp1ZnVxUmVwWWVZQzNsQWp1?=
 =?utf-8?B?V1ZiZDVnejhqT2xHWktjcEFwMXplSytQM1QxWVZGSGUxc1JVdHgxU3R4Y2U5?=
 =?utf-8?B?elJGMGlRcng5WkNpQjN3MTZ0UVJwMHZPalgvL1RxdURiUzNRYk0zUDFlMGxt?=
 =?utf-8?B?ZlgyVFB2RTVvZ1VGbDB4bldENHpDWElqUVlDUDJXZTNuWlhwZFgzMmNrdkRo?=
 =?utf-8?B?YnpOejJwbWlVMmdPSFl5akt6K2NZVzlVSFRjZ2h5Nmpua1llTkhHRTA5WWcv?=
 =?utf-8?B?K013QmtXV21SNzRGcTErREN1VkNkK3NpbTNzeTdCUFNmeTdKS3N5eWw3L0w5?=
 =?utf-8?B?ZE1SYVRRUndMcnplR1JnVDBFaWZPa3Z4OWl2SS9EYXgwVnFTNEk5T3N6L1NO?=
 =?utf-8?B?WTcxUEJzS1dyNmhTc0M5YnR2aks1M3ZXdGFpWWRnRkZXb0hhZlhUZU5HK3hJ?=
 =?utf-8?B?NGxUaFRXWE1rN0dLMTRZZ1JoNmVWNkZUcWErcHg0dkVxc2pFSC81Y1p2eCs5?=
 =?utf-8?B?QitvazBLSUdGZWhuUG1wK0Y0dUU0dG9pejR2ZmcwbDZQZDU1RWpEaXUyMzZx?=
 =?utf-8?B?T05HYzlvQy9hd3pieEVGV3d2RVdORXY2R1hWcmlWYjN0d25PUVZ2VzNqa0xL?=
 =?utf-8?B?MmcwTzA0ZkNjUGxpNHhZNmhCMC9vYys0YXdSVXg1bXVwdjRqR3VHOFZmejdj?=
 =?utf-8?B?elprRUNzQk1GQnhVZmhQNXBSQXY0S01zOThyYnpZSkxQZzRsNDdvbFpadVVC?=
 =?utf-8?Q?hSS8WJ/Awhbd9Uugtv0n81kz1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12af2f2e-8a66-45df-abc4-08dc2be35117
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:57:30.0046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlekCQNpEWzChq6bTcHZZdNZb8FQOJ0Q9xqiJNpJSweezg5vaVUezAdKknO9FmEk2d0m2gR57tC8AcF7+KzUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
Received-SPF: softfail client-ip=2a01:111:f403:200a::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 12/02/2024 16:49, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/12/24 09:36, Avihai Horon wrote:
>> Hi, Cedric
>>
>> On 07/02/2024 15:33, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> The purpose is to record a potential error in the migration stream if
>>> qemu_savevm_state_setup() fails. Most of the current .save_setup()
>>> handlers can be modified to use the Error argument instead of managing
>>> their own and calling locally error_report(). The following patches
>>> will introduce such changes for VFIO first.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   include/migration/register.h   | 2 +-
>>>   hw/ppc/spapr.c                 | 2 +-
>>>   hw/s390x/s390-stattrib.c       | 2 +-
>>>   hw/vfio/migration.c            | 2 +-
>>>   migration/block-dirty-bitmap.c | 2 +-
>>>   migration/block.c              | 2 +-
>>>   migration/ram.c                | 2 +-
>>>   migration/savevm.c             | 4 ++--
>>>   8 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/migration/register.h 
>>> b/include/migration/register.h
>>> index 
>>> 9ab1f79512c605f0c88a45b560c57486fa054441..831600a00eae4efd0464b60925d65de4d9dbcff8 
>>> 100644
>>> --- a/include/migration/register.h
>>> +++ b/include/migration/register.h
>>> @@ -25,7 +25,7 @@ typedef struct SaveVMHandlers {
>>>        * used to perform early checks.
>>>        */
>>>       int (*save_prepare)(void *opaque, Error **errp);
>>> -    int (*save_setup)(QEMUFile *f, void *opaque);
>>> +    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);
>>>       void (*save_cleanup)(void *opaque);
>>>       int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
>>>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 
>>> 0d72d286d80f0435122593555f79fae4d90acf81..a1b0aa02582ad2d68a13476c1859b18143da7bb8 
>>> 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2142,7 +2142,7 @@ static const VMStateDescription vmstate_spapr = {
>>>       }
>>>   };
>>>
>>> -static int htab_save_setup(QEMUFile *f, void *opaque)
>>> +static int htab_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   {
>>>       SpaprMachineState *spapr = opaque;
>>>
>>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>>> index 
>>> c483b62a9b5f71772639fc180bdad15ecb6711cb..c934df424a555d83d2198f5ddfc0cbe0ea98e9ec 
>>> 100644
>>> --- a/hw/s390x/s390-stattrib.c
>>> +++ b/hw/s390x/s390-stattrib.c
>>> @@ -166,7 +166,7 @@ static int cmma_load(QEMUFile *f, void *opaque, 
>>> int version_id)
>>>       return ret;
>>>   }
>>>
>>> -static int cmma_save_setup(QEMUFile *f, void *opaque)
>>> +static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   {
>>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 
>>> 70e6b1a709f9b67e4c9eb41033d76347275cac42..8bcb4bc73cd5ba5338e3ffa4d907d0e6bfbb9485 
>>> 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -378,7 +378,7 @@ static int vfio_save_prepare(void *opaque, Error 
>>> **errp)
>>>       return 0;
>>>   }
>>>
>>> -static int vfio_save_setup(QEMUFile *f, void *opaque)
>>> +static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>>       VFIOMigration *migration = vbasedev->migration;
>>> diff --git a/migration/block-dirty-bitmap.c 
>>> b/migration/block-dirty-bitmap.c
>>> index 
>>> 2708abf3d762de774ed294d3fdb8e56690d2974c..16f84e6c57c2403a8c2d6319f4e7b6360dade28c 
>>> 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -1213,7 +1213,7 @@ fail:
>>>       return ret;
>>>   }
>>>
>>> -static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>>> +static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error 
>>> **errp)
>>>   {
>>>       DBMSaveState *s = &((DBMState *)opaque)->save;
>>>       SaveBitmapState *dbms = NULL;
>>> diff --git a/migration/block.c b/migration/block.c
>>> index 
>>> 8c6ebafacc1ffe930d1d4f19d968817b14852c69..df15319ceab66201b043f15eac1b0a7d6522b60c 
>>> 100644
>>> --- a/migration/block.c
>>> +++ b/migration/block.c
>>> @@ -708,7 +708,7 @@ static void block_migration_cleanup(void *opaque)
>>>       blk_mig_unlock();
>>>   }
>>>
>>> -static int block_save_setup(QEMUFile *f, void *opaque)
>>> +static int block_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   {
>>>       int ret;
>>>
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 
>>> d5b7cd5ac2f31aabf4a248b966153401c48912cf..136c237f4079f68d4e578cf1c72eec2efc815bc8 
>>> 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -2931,7 +2931,7 @@ void qemu_guest_free_page_hint(void *addr, 
>>> size_t len)
>>>    * @f: QEMUFile where to send the data
>>>    * @opaque: RAMState pointer
>>>    */
>>> -static int ram_save_setup(QEMUFile *f, void *opaque)
>>> +static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>   {
>>>       RAMState **rsp = opaque;
>>>       RAMBlock *block;
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 
>>> d612c8a9020b204d5d078d5df85f0e6449c27645..f2ae799bad13e631bccf733a34c3a8fd22e8dd48 
>>> 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -1342,10 +1342,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
>>>           }
>>>           save_section_header(f, se, QEMU_VM_SECTION_START);
>>>
>>> -        ret = se->ops->save_setup(f, se->opaque);
>>> +        ret = se->ops->save_setup(f, se->opaque, &local_err);
>>>           save_section_footer(f, se);
>>>           if (ret < 0) {
>>> -            qemu_file_set_error(f, ret);
>>> +            qemu_file_set_error_obj(f, ret, local_err);
>>
>> Should we set local_err = NULL?
>
> possibly, yes.
>
>> Because it is re-used a few lines after this, by precopy_notify().
>
> I wonder why is precopy_notify(PRECOPY_NOTIFY_SETUP) even called when
> there was an error in one of the save_setup() handlers. It probably
> shouldn't and qemu_savevm_state_setup() should return at the first
> error in the loop. This is something that could have been overlooked
> by commit bd2270608fa0 "migration/ram.c: add a notifier chain for
> precopy" because qemu_savevm_state_setup() does not have a return
> value. Probably because the callers rely on qemu_file_get_error()
> to know if something wrong happened.

Yes, I guess here we could return early and skip precopy_notify().

>
> Also, the only user of PRECOPY_NOTIFY_SETUP is virtio-balloon and
> nothing is done. PrecopyNotifyData has an errp attribute which is
> unused.

You are right, with current code there won't be any problem, but new 
code that will make use of the errp can be problematic.

>
>>
>> BTW, I think that if we add Error** parameter to functions we must 
>> make sure all their error flows set errp as well.
>> According to Error API:
>> * - On success, the function should not touch *errp.  On failure, it
>> *   should set a new error, e.g. with error_setg(errp, ...), or
>> *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>
>> For example, a caller that handles errors by printing them with 
>> error_report_err() would crash when trying to access NULL error 
>> object (if some error path didn't set errp).
>
> One of the underlying goal is to avoid and remove all error_report_err()
> calls to propagate the error up the call stack.

Yes, I just gave an example of how this could go wrong.
I think the general point here is that a caller that provides a valid 
Error** errp assumes he will get an Error object from the callee in case 
of an error, and the caller can operate on it as he wants.

>
>> If you agree, we should check it throughout the series.
>
> I do agree and this is a can of worms !

Indeed.

> I haven't quite found my way
> around yet.

Briefly looking, it seems like .save_setup() / .load_setup() shouldn't 
be too hard.
However, memory stuff seem to be more involved.


