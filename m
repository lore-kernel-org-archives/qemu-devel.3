Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BCBC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRtF-0002Al-OC; Mon, 12 Feb 2024 03:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZRtD-0002A9-CW
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:42:11 -0500
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com
 ([40.107.94.47] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZRtA-0005UV-Vb
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:42:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKa0aPouzK3D6gNuyq5L6vCqvHLQ8RuOr/c9J6chsEV7i1Zr+V31LMu33euvNkm9z5b+FsiFDMCrotfPldYDg49f7v5rpJzzy/hGQJJ7GpmvutFdhxu/OVpJ3/cGTgiyDxPPtAr0MT0emJf5myPwc9AUqP2cEUzer/tH2S0IR4Xf7EK8KsO7nctkoPV1H53ZO1BP//oaEEBe27aXrKBBaoi+2Z8W2hn5Xdae5t4TpwY1qxG3pZr8F587tOoa1RlXulkp4b+2CBR5xUy4ka9NeU1OWRhD7a+S26sAJoHUzpSysgo0HeKMqXOypqIDg8e6uK4Zxs2lh9GK90yNRsV02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jez1QIb4Kb54h9tisxehol5maAx1LveLY0p+8MtUUIQ=;
 b=GTadW1ho3u+ejMvFOXuXRATfyLbhvbvtTIlr2V/urA6zMouIY/cvE8I4B3z296aVIlZjzzfb/JO4wumbEvdlLyTnfwUq39KrBE5iJIG39LkJn6sczxGj24pTn3n3FZPrZNaaDYIMsC8AtnwQbdcX3KhHRwMJUoO55QteWIfS/1cLH/8EXgUHu+bONPPGY3oxuuML6pF8rnfseQJ7MR1E9l1LsBOwV+sDw73p1l7/MtHk5HtoDvjKlDyNlRZpQxsKipMTNhKrmS8tMO1JLdem3z8a6kbLFVRPTfhyRM7Kt5cpiVLZFlGYcN93/dT5+H8xqNhXc8CjGxBF6r6sZ+doeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jez1QIb4Kb54h9tisxehol5maAx1LveLY0p+8MtUUIQ=;
 b=idnrx8A/z30JW4B8KwwXK8Jw32Kb4pwSurtc8x8jfvit4ufbQmBdy+tMNsOeQdi7eDMjWEnQeZU8a2tRBATm9J5IzoMhqch6oGZDt/rpkW0HMHWRYULxVyRwszU/lRX9XKajmcPsMJGAMlOsMRMkdeqCXRA6AOmzzHzvh0j4oGH9Yvx3ya9P/y0xlF+lYKZnkwXQvFdGHYEsg8/ifdZpc5F9n+FBjGrfFOTTktwI5G/Z/x0xCwDYw5cvTfRExWjL5QgtlmYQ5I0CaUYr+G3HnfK0G1dFiVeCsML6NEpgOwbEZFGYVU5WZ+EmYuD282hjh3ZvckUPawrNmMXD9if7fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.21; Mon, 12 Feb 2024 08:37:01 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 08:37:01 +0000
Message-ID: <5addf455-c0e0-4aa6-8970-c8050a194783@nvidia.com>
Date: Mon, 12 Feb 2024 10:36:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-2-clg@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240207133347.1115903-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::10) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 339e6e67-dcad-4311-f3e2-08dc2ba5c84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwQ70IuAFDOFb2BlzRove+p2PsglB6+53EcQt9erjAQsa96YeDmvJEurQwMkcF6lYw5kuVRQupupJlpU32diBpPJ5p006SFzlp7jCzbh/p/Hl3otBYfkYbdvpfK/ZgEGr85GzEXqzXjHcPVBwWBVO/zN2vocaN4zWwzqIvYY35rq6jYaSE4gWYeNYj0UAj98zzosFvElQV2QplJuBd+aRVs8WFMmnH8MdhwT+5BCvLY/rpW7ujdalUoom1iGRJRpOHHeAmhXZB1ZNDGmFiyiIonFcfXHQi+1Yxj50GYRf1yNgKrmxOGAexqQ3rqaSE8gov8eOqO9+e7dAzBZXy55M9j3snR2IaFgUaJt1ADVpTJdXVHEgibU52hcRMLdMd5PHL4CmR/0AOm+LZgsl6zjWxljJMGZAr3pGDXBotThAUqdVzvxShq/USvv9peh6Gtl5DKViLGhK8IbSw/DHLtga1LPChLXNsu7LoQX4/h6leGoqdM++kui1KHxdH4T+tQlMLvcPhsGKyth8akYpH2jku/9QUq/mRfyC8T1tbS+zgyf+ot3ahMnHEcOQ5+TvNem
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6486002)(6512007)(478600001)(41300700001)(31686004)(8936002)(5660300002)(4326008)(2906002)(8676002)(66946007)(6506007)(53546011)(6666004)(316002)(66556008)(54906003)(66476007)(2616005)(83380400001)(66574015)(31696002)(86362001)(26005)(38100700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0NBeFhEVDZ0QmNWVldJN25JSU52dnFnMXFNUmNrQmZpajhVTWEzT3BuQjU3?=
 =?utf-8?B?dC9BNi8yUWZDdmRvL3Q4MGRGZDV1eStXSDZMNkhQOERjUG14ZVlUL0JnMnND?=
 =?utf-8?B?Z1BudzcxM3VGVTUxREZjZkZOZ2ZLODBZQjFQZ2QwRzJxWmRPQy9NYWYrZ1R2?=
 =?utf-8?B?K1kvL1NMTWZOWmVhWG1LSjUvYXVyT1lrZlVCOUFOV1Z6cFBjN2Z6TDhyaXZB?=
 =?utf-8?B?M1VyUk82MHEzVGdNVVhqSXQvdFQ2UmFOU2dueTJNb3hjWkZQRGp2UEd4SHZJ?=
 =?utf-8?B?ZnpGNWRUZlgrMjJKRStmUDgyNC9JaWpGNlo1dW5uSndiNk5EWGFtMkxWcno0?=
 =?utf-8?B?bGwzUGNINC9ybHJxNzZhMktMSE1YQWlsSno2Q0NOdG5JYjRTY1pDM3NLbDl4?=
 =?utf-8?B?VjBNT3JleXhzSE11YUNFVVNFQ2tXSFlLSjY1UDlYV3BOSEY0eUJWZ2sySmMw?=
 =?utf-8?B?ZytKZTRhbEpFcGw2c3JkR2pJWUxwY2FKQkY4UnZIcjFiSnltRlE3SS9mK2h2?=
 =?utf-8?B?OGIvRno0b1VKSytEQXRYNGhFaEpxSWNIRkQyUTBqQmtHenNvbUp2SDlDUzFk?=
 =?utf-8?B?Y3ZnN29LU0pOeXNPQkJOa1JPR2c1dm1YN3hzbU5xcDIrRWNzcFR5eFFnR3kz?=
 =?utf-8?B?SU40cnBRNzRlMTF4L1A1OThaYlUwLzdzVjA0bzRTbEdWemk1Y2hYclU5M25t?=
 =?utf-8?B?dk1yT3RYZS90S1p6MEZIQXVUZmUrSk40dk9yYzlRM1dHaWcxeElwdGV2eVRS?=
 =?utf-8?B?RVdlWUF2VWlERm5mbVVoTmxqemhJeDEzOU1XdG1lWW1qbFhWRGd5SDlxVGVv?=
 =?utf-8?B?MXRPSjZWbGt4bEszbkhGcE5CaFIyaTZEcmtPUlcyMlF2NDRuUUl1OXQ3eFlX?=
 =?utf-8?B?LzdqWXpWR2pVbDdBRlVNYUkrQzlLQk8weTdseHBuQStNL09yVWhBbFB0THpW?=
 =?utf-8?B?WlQ5aExPUDE2VndoelZXLzRkNndBZ1loeE9TVytjZzlTKzNHZG0zbmJ5T3Fh?=
 =?utf-8?B?WmxJdjZ4ZDlhZk5lM0JKakZLY05YRW1DbzgwYjhNZThrUTQ4bkw3WnFzVTF0?=
 =?utf-8?B?Q0JSQ3EzUlZaS1kwQ1JYNlVjMTMyTTVzMVlSU042QnVyMDVxeEI4d0s3dVFZ?=
 =?utf-8?B?MHZBdHU3V2EwQm5Ja09kd3RhbGF6MWp3ZjlQWmFUYnJxYVZMOEZwL050Rkh5?=
 =?utf-8?B?UU9OaDRZWEUveGJpY1J3QUdvSTdVVEhCWi9yZVBVZ3VHcithSzdPQWNvY0RZ?=
 =?utf-8?B?SzBTQUhFMWJRU2xwbm1IM1JGaUZRaWJuQ2kzUUd6RGxrTERRaU1LWmR3L0tR?=
 =?utf-8?B?SE0rcUhSZlo3eU0rOVdScUVraU5NUENRV3RhdkllbFIrcmNNa1VNeTRjL1ds?=
 =?utf-8?B?MkNRalRNd1NtYUJkdEJDb250U0tjZWlickdjQ0drTUJvYmdpVDhtbnV2VXcz?=
 =?utf-8?B?c1B3M3JjcDBZdnFlYnNZdUgwRVY2NGtJUkVRenYwa0FYZ0xSUForVEM1bU9G?=
 =?utf-8?B?T0l2bmFJNWVlTWZQTFBzVlZaNTc1QzcxcDhMNmk2cHEzRkRrdHNaZ3dkUFU4?=
 =?utf-8?B?cWxSdVplWSs5cmRYakNuMG9SMVV1Y3JMazlxbUFaMGFPMjBtRnhYdGtYeG1G?=
 =?utf-8?B?TWZkVlZLR2pEV3JxTEVjK0FoVEZmelRnbVNmc1ZOdFR0RDFyVUNxTXZQZ2gy?=
 =?utf-8?B?N0ZsQWdlblNoR1BRRFQvK3A0aE0xVDhvbnk4TDROVW9hREtVMVlGYnJZTWlH?=
 =?utf-8?B?WTR2dG5MR1pzQWNQTjdpUXFaRXZOV0VGMkE3T2JUb0lZQld0N1BBYjFrSCtp?=
 =?utf-8?B?M09BUmtCR3lBZXA0RWUrQ1VRRjEzckg0eEE0UWhPSVg0OEV2YTVGdTNoQmg3?=
 =?utf-8?B?WkVVaW5OOHZoT0I4bzZvbUxXWXdRQXFYSzh5YjIwd09hRHVsRktJalBKd25Y?=
 =?utf-8?B?ZnNCTDlPdjFmVzlndGJVbWZ3Mk1heVN2NkxValdFMjVVVHZRd1lVSWhhbWZz?=
 =?utf-8?B?eWEybTJTa0o0T3AyWVZGRkdOK3F1bk9KN3ZsOFpqMWdPSzVYTmpKOEFjTkxG?=
 =?utf-8?B?UzRrSDJYaStpZmhyZC9QeFdWK0ZpZ0xJcDVXSXRvTlFCd3B2bFQxTEhBSkpx?=
 =?utf-8?Q?ZQRfhA9Ch6MatlwOGvdb2Owc1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339e6e67-dcad-4311-f3e2-08dc2ba5c84b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 08:37:01.1587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIzRZ1XApOkGtyC3hhKfpcIasZNBMimETzjj0bvSZvoJrIBuMX6qwWtXdhU6eodAL8fzOd9daFdlzCCcWATU1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
Received-SPF: softfail client-ip=40.107.94.47; envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
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

Hi, Cedric

On 07/02/2024 15:33, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> The purpose is to record a potential error in the migration stream if
> qemu_savevm_state_setup() fails. Most of the current .save_setup()
> handlers can be modified to use the Error argument instead of managing
> their own and calling locally error_report(). The following patches
> will introduce such changes for VFIO first.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/migration/register.h   | 2 +-
>   hw/ppc/spapr.c                 | 2 +-
>   hw/s390x/s390-stattrib.c       | 2 +-
>   hw/vfio/migration.c            | 2 +-
>   migration/block-dirty-bitmap.c | 2 +-
>   migration/block.c              | 2 +-
>   migration/ram.c                | 2 +-
>   migration/savevm.c             | 4 ++--
>   8 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 9ab1f79512c605f0c88a45b560c57486fa054441..831600a00eae4efd0464b60925d65de4d9dbcff8 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -25,7 +25,7 @@ typedef struct SaveVMHandlers {
>        * used to perform early checks.
>        */
>       int (*save_prepare)(void *opaque, Error **errp);
> -    int (*save_setup)(QEMUFile *f, void *opaque);
> +    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);
>       void (*save_cleanup)(void *opaque);
>       int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0d72d286d80f0435122593555f79fae4d90acf81..a1b0aa02582ad2d68a13476c1859b18143da7bb8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2142,7 +2142,7 @@ static const VMStateDescription vmstate_spapr = {
>       }
>   };
>
> -static int htab_save_setup(QEMUFile *f, void *opaque)
> +static int htab_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       SpaprMachineState *spapr = opaque;
>
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c483b62a9b5f71772639fc180bdad15ecb6711cb..c934df424a555d83d2198f5ddfc0cbe0ea98e9ec 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -166,7 +166,7 @@ static int cmma_load(QEMUFile *f, void *opaque, int version_id)
>       return ret;
>   }
>
> -static int cmma_save_setup(QEMUFile *f, void *opaque)
> +static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       S390StAttribState *sas = S390_STATTRIB(opaque);
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 70e6b1a709f9b67e4c9eb41033d76347275cac42..8bcb4bc73cd5ba5338e3ffa4d907d0e6bfbb9485 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -378,7 +378,7 @@ static int vfio_save_prepare(void *opaque, Error **errp)
>       return 0;
>   }
>
> -static int vfio_save_setup(QEMUFile *f, void *opaque)
> +static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 2708abf3d762de774ed294d3fdb8e56690d2974c..16f84e6c57c2403a8c2d6319f4e7b6360dade28c 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -1213,7 +1213,7 @@ fail:
>       return ret;
>   }
>
> -static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
> +static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       DBMSaveState *s = &((DBMState *)opaque)->save;
>       SaveBitmapState *dbms = NULL;
> diff --git a/migration/block.c b/migration/block.c
> index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..df15319ceab66201b043f15eac1b0a7d6522b60c 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -708,7 +708,7 @@ static void block_migration_cleanup(void *opaque)
>       blk_mig_unlock();
>   }
>
> -static int block_save_setup(QEMUFile *f, void *opaque)
> +static int block_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       int ret;
>
> diff --git a/migration/ram.c b/migration/ram.c
> index d5b7cd5ac2f31aabf4a248b966153401c48912cf..136c237f4079f68d4e578cf1c72eec2efc815bc8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2931,7 +2931,7 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
>    * @f: QEMUFile where to send the data
>    * @opaque: RAMState pointer
>    */
> -static int ram_save_setup(QEMUFile *f, void *opaque)
> +static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       RAMState **rsp = opaque;
>       RAMBlock *block;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d612c8a9020b204d5d078d5df85f0e6449c27645..f2ae799bad13e631bccf733a34c3a8fd22e8dd48 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1342,10 +1342,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
>           }
>           save_section_header(f, se, QEMU_VM_SECTION_START);
>
> -        ret = se->ops->save_setup(f, se->opaque);
> +        ret = se->ops->save_setup(f, se->opaque, &local_err);
>           save_section_footer(f, se);
>           if (ret < 0) {
> -            qemu_file_set_error(f, ret);
> +            qemu_file_set_error_obj(f, ret, local_err);

Should we set local_err = NULL? Because it is re-used a few lines after 
this, by precopy_notify().

BTW, I think that if we add Error** parameter to functions we must make 
sure all their error flows set errp as well.
According to Error API:
* - On success, the function should not touch *errp.  On failure, it
*   should set a new error, e.g. with error_setg(errp, ...), or
*   propagate an existing one, e.g. with error_propagate(errp, ...).

For example, a caller that handles errors by printing them with 
error_report_err() would crash when trying to access NULL error object 
(if some error path didn't set errp).
If you agree, we should check it throughout the series.

Thanks.

>               break;
>           }
>       }
> --
> 2.43.0
>
>

