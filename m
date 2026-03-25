Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A12109C045
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RVl-0006dQ-TQ; Wed, 25 Mar 2026 12:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5RVk-0006dG-CK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:55:16 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w5RVe-0000Ys-UJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:55:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/57wvySfpI3/AJ6241ol6oQldf5iNlXmZ8vvJidmqkWiO8yixmVCzz/eb2e6RwEp+QdUoCC2IeceUQXH4nd397+EgQK5f6+HFmMnxKjTG2Ezii23H7i61BonPDBgLSKOsDYIOEBILq9Cdduf28lnEbhTNaWg3iBjAuz5b6aOGoT6vAEeEYLoT1T8IDMhcVAJJRhUhJNkir0+AaW05ZpemwZEFKyTJ7SJpX4AciIIqJYRwtbQ6CeoS6Vwy2hMC+8Ji1nHfw7oNJK+QkwKr7sqy/5SKlK7HpThgb3Gp5a37WKTP0U6lKd6ujx66FADachyNiq1MUEnovsp3XjvvxxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AshqD9ejkG2PFnA2s0K42SUPyw/A/nmo2X8ouAzmmcY=;
 b=Awrt4+jeeWCCFEE8Ad27DxMBxT9CgW0a0drJWFJ4Xz80bF8bM3uIHDn14BhxAXkycpd3IIZWBk8AqABYJdb5WFRimTmh2YD+susPVxDrm1BLxZWkfR5olNh+LU5uUVVzx3Ou8L+Yi7LH9AiW5o2e99zNBu67vY14WagQl+83mwr8Q/SOqFG15SmN2SsqXJEro85LLTXT+am+9l/Z/ElevBrLSPWYEa/rI0SqkY1RjorbCR3bfp2Tct8tAfld3QdjQGOGMf0gxBH1WnN17W7l0I1aVId4UvoNpkjiVKPiE6+kw0/WXWfT60F1D9flyqw+fMXwuXuRfdHtQYCKgc9EjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AshqD9ejkG2PFnA2s0K42SUPyw/A/nmo2X8ouAzmmcY=;
 b=Xomb00QBAPmr42NIhFsmRlCPI+cf4NsBuh567fr9yOhbEAulOGGqMhVFTAOhJaeTjsMTYeNWQdx9Wqgr5i6t4H0VNs1JFzgIbkd6m4Xys+4Dfn8cnd4hQPdGqaC9IQH0KXdB5kv3FMDG1lj19gnzx3fF4Xg8XbIEnpPDc7/cyhMhjdX/zk8Z8PgLZAeUuSUJonjv66FCduyhxaoxM1dNQ9IBv83imI4V+aDXREZjtvZJvZuUVac/kn6V1O/xzCNMpfA3PiT9eaId7SRE6k/foGXl4fSsdrS3lblNI8fu4AVqrppgN1sMhiKVEuREAL0ZpckB0Eyzrh8X3zCamC1/5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 16:55:04 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 16:55:04 +0000
Message-ID: <82b40877-482e-4dbe-add1-6e0cc4292ae7@nvidia.com>
Date: Wed, 25 Mar 2026 18:54:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260319231302.123135-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c448e2d-f6ed-4fa2-fce4-08de8a8f42e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info: El3Hr2JvKH4JyBYw+Ww9z18RLNE1DPuhqkMshSCSNk1UqubmsMqB4nXpZvib1L++qe8ZfzZtBS3RF32VNLkvmc1OiWfNw9cFS4cDYAoZbGqh3mfuw7eOeWAl6ZcsmEEmL9vXGkx6M5G3a+j633QVTaKjW3qdVctt9HeRM9we28tBGEhvTp/vWY51We4966yhBQJWJrSkuzdKiscydcWxKUGHE6IzszqhpIEAV1v5ETQfHwYdTsot/YPcWhhN4DEw+/geGKOMQomsQ2doxdmM0n59+CrI7sFay94szvu4zlwM2EOyeb18VQv4w91dsR6LJfyioUhfi+yYsqYtfBs1N7ARvlwVJlECK9fNaH2o2h/9MFB7JCTEHotglZmgtwSe114jwMAxMqUKKgdM01MD8W0etrcKQS77WjHoI1+0n0PTj2AAPH/Xd18dMoGD8Mr0pF0TGhXxoQ07dYC3IpVFKF/OIPzSzm0TGrIoG5fa2oijZlQAoSkjcFJ1hxLiGrDGGoyCzWiYocrLccmjDglR9vffFjkvjtUjSBzCONpr9qKuH97nlTGA7vNQvLSbzbZhsp7tiXi0NjSdlXf+VHvDfj13yVgJMERrIlrc9zoQ+CzWny8e3ANhlmnNYD6D+lSQraniIgWAw5imUS/YiVViRMXrvbLab4TDWkBwX1K+fAbftK+MBgZ86OlPNjvtOe5sOJKSXXf+ThmiPkkCLk66bxNdbk2jr3DWryFdWQgCg7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(7053199007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2UvZVRZRm1DTk1POVFaUW9xMkN2Q3dyMUZTMkxvczdkbkxZUU1iWW1nblBO?=
 =?utf-8?B?czdpVngxQUFaaUJLVWhJSnRlRHROaTNZU0MrM2krTUJONEV2VHB0dExaV1l4?=
 =?utf-8?B?Q0xSck5LS21oSThDNDR6V2ZUOWJScThPQ3FvYnBQQTRwVVB4NFZJVnUrbUR4?=
 =?utf-8?B?eStVTmtNamx4RU1NUlptc1ZZNlBscFlkbUFxbGhGbTN2bU1LdE5ZTWhkUEVQ?=
 =?utf-8?B?bmcvWmRSQ3lIcjFscnBXWThDRUF4MWZmbDBEVVUxRTIwWmhhSlNMZCtWVjQ2?=
 =?utf-8?B?VHEwUy8vS0MyUFcrMC9tK3hwMEJ0NzBMdnR3L2ZaaEp6cHl4NVAxUUZ3Zitw?=
 =?utf-8?B?cjh0YitSajhUbnl6Qm1tMWZOU3R2VDl3YmZlWTBoVGg4b2dNNEhXK0p0Qmds?=
 =?utf-8?B?SVdxTVp3NEprZTBIZzlsaWlyQTFMbXN5TGZ6VjdZMmh2WkRoSlhvWkpMTjJO?=
 =?utf-8?B?NW5QK25QWjhFdnRLUDFvalBGeVo3YVZyZ1JJNERDRmNZYVdzWEZ2Y2dBWlgy?=
 =?utf-8?B?ZitjVzlmRXFSaVpjNEg1bVhsTmhwblBoQ2dBeXZadGFnQ1hXUUFia1RPNFZP?=
 =?utf-8?B?T1pkaGRxT3VWRnhoejAxQkp2ZktQWFVndUVZMzhuMlJSN3JQS1ZrMkR4cG45?=
 =?utf-8?B?QStRT1Z0elN4aE9RbjI1YzEzMFoyZ1QvcndJV0dLQTFOSndzSlJCRm83OE1z?=
 =?utf-8?B?cnJ3V1BFSFcrQ1J5WW1hVlM3THZaNk4xcmErZXAveFJoRWI2SU5DWHJidkRW?=
 =?utf-8?B?THlQck1tNWtXM1hxZ0dRdk9vMmtOU0xLSG51VHExT25jay9yNHZVMldGWEZM?=
 =?utf-8?B?U0NJTkVnU1ZYVmlDMUJvMmFWaTM3aVQvakp3NFZnaGZoSWhBWG9wcmwrQzd1?=
 =?utf-8?B?QVNwYWJXL0wxTkpUSk8vQ3AzSE5jZWU5Nmd6bnRxa1dMYVI1QnArTy94ejJr?=
 =?utf-8?B?QU42MDFoNGNxTlpKU3FDVFBIY0dOMHp3SWhOL1lMWklISisxemxwWFY0OWtF?=
 =?utf-8?B?MldtaXZUZ3ZMa1BrUjB3RkNYM01FQ2plSUFLMDQ4ZDE5MkpuUVdSdGNLdElX?=
 =?utf-8?B?WmFFRDRRYmp5dzVwYzFtS1dGamlxbjVUN000NmFtOUtOaDlseGVUT2tndjlm?=
 =?utf-8?B?ekRtR0wyZnJ6M1RkY3VMVWs0WHJtR09Xblo1ZVgrVzl3UDdaZDBDaEFBN2JR?=
 =?utf-8?B?bEhJaE8vYUl6QnFkaUV4eXFjYndDaHFtTzR0NC9ZMS8rbXhZanNxc2pBS2sw?=
 =?utf-8?B?eXFvZi93U3ZVRnEwdFpuQ0tPUVZ0L05uQklzUXMyNkc5RjB1eDRMeEhzQ3Q2?=
 =?utf-8?B?L05BK0VqbEx3eVJZdms0WXcyMTl1Q0VCYmViMzlCNUN0RXFuUkRYdC9jS3lL?=
 =?utf-8?B?dW0rRmlWVzJEWE5qNDZrWkdvaEd1QnhqK3FTZXRFcHRNcDlpUGtQdjRBOExP?=
 =?utf-8?B?L29VVGJDay9wOHVFZjdOb2U3RkN3N3pzZEhSaHFDMHNLeExjcWlVUk4vQWlN?=
 =?utf-8?B?SitsWlo0Tlg5S29lK1Y2MXVMNzQ2bnFkZzRhWm9oWjcyVkk2NTNnSXdnY2FP?=
 =?utf-8?B?U1RiNEdneStLM3I1by9BaUJ6VUNyTTF0YkROQWZlNlVrL3NTY2hiM3RXTldS?=
 =?utf-8?B?dVMxaUE5SXl2MW13clVvaFRvWEtTS0RlM0VWU3g2VW42MWkrQnlGWWViMWFC?=
 =?utf-8?B?bTRLNjdQN3RuTE1SY3VtejEwWFB5VVQ5OWQ1TXhMUXhqZmtQWTdPU0VXbjIv?=
 =?utf-8?B?VVBNRUdwY01tKzJHV3ZkLzVqdHhGRFhxcXhCUFlYT2FWU1Uyb1pkR1lqbXdK?=
 =?utf-8?B?eWpWdHZORmxJZGtSakFzTHlRZklIeVZ4NkRiNmhkZUR5TWpscVFwVE0raHdW?=
 =?utf-8?B?NzFaVlFVaW9BMFk3RlJmVWlieC9ub0l5VG9XZXlCVm1LL2prRlM2eGdQWGxt?=
 =?utf-8?B?bDZvcjZER1dOY0hld21IN0VFemlrMG9UOTBxc1ZmM25IeFhORVNOb1ZxYk5K?=
 =?utf-8?B?L1hEeGdHU2F6K294SlJUM1ZQV1czS25zZERwY3hzdDh1Vzl2enV1K0NMVk9v?=
 =?utf-8?B?dCtTbHRybStBc2RmcnE3MGdBWkNlVStUQjI5NHczWUtGOGF6eTB5MFNKYkRr?=
 =?utf-8?B?eDFUNCtvMEhOUVBpS1RYbC8wdTcySjMzUDkvSC80TTlUS0F1WkNGcnY4TXQv?=
 =?utf-8?B?WHoxempMOUdZbCtsbGREWitOdU8vRnBwZ2xiNGhWejNrMGtIeTVVc1pnSDQr?=
 =?utf-8?B?MitoTGszWkFDV1dVT3g2b2lMNjd1OHAvbzh4dFpXanQ0UzFBeWNQYkUrTTFQ?=
 =?utf-8?B?ckErTFVBUEN4MHp0STRqb0o3SnI2dENrMWV4bHlUelRDVnJFTDFqdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c448e2d-f6ed-4fa2-fce4-08de8a8f42e3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 16:55:04.2344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbHHst/qy9kBmtRmCF7LwFWQyp2kycnKC/n/FpfD5ZDK8h/Hy0b1oo5PJ5pS+0TUhDnmVpBWUcjcDnuFEr/yFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=avihaih@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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


On 3/20/2026 1:12 AM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Allow modules to report data that can only be migrated after VM is stopped.
>
> When this concept is introduced, we will need to account stopcopy size to
> be part of pending_size as before.
>
> One thing to mention is, when there can be stopcopy size, it means the old
> "pending_size" may not always be able to reach low enough to kickoff an
> slow version of query sync.  While it used to be almost guaranteed to
> happen because if we keep iterating, normally pending_size can go to zero
> for precopy-only because we assume everything reported can be migrated in
> precopy phase.
>
> So we need to make sure QEMU will kickoff a synchronized version of query
> pending when all precopy data is migrated too.  This might be important to
> VFIO to keep making progress even if the downtime cannot yet be satisfied.
>
> So far, this patch should introduce no functional change, as no module yet
> report stopcopy size.
>
> This will pave way for VFIO to properly report its pending data sizes,
> which was actually buggy today.  Will be done in follow up patches.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/migration/register.h | 12 +++++++++
>   migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
>   migration/savevm.c           |  7 +++--
>   migration/trace-events       |  2 +-
>   4 files changed, 62 insertions(+), 11 deletions(-)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 2320c3a981..3824958ba5 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -17,12 +17,24 @@
>   #include "hw/core/vmstate-if.h"
>
>   typedef struct MigPendingData {
> +    /*
> +     * Modules can only update these fields in a query request via its
> +     * save_query_pending() API.
> +     */

Move comment to patch #5?

>       /* How many bytes are pending for precopy / stopcopy? */
>       uint64_t precopy_bytes;
>       /* How many bytes are pending that can be transferred in postcopy? */
>       uint64_t postcopy_bytes;
> +    /* How many bytes that can only be transferred when VM stopped? */
> +    uint64_t stopcopy_bytes;

Keep consistent phrasing?

/* Amount of pending bytes that can be transferred either in precopy or 
stopcopy */
uint64_t precopy_bytes;
/* Amount of pending bytes that can be transferred in postcopy */
uint64_t postcopy_bytes;
/* Amount of pending bytes that can be transferred only in stopcopy */
uint64_t stopcopy_bytes;

> +
> +    /*
> +     * Modules should never update these fields.
> +     */

Move comment to patch #5?

>       /* Is this a fastpath query (which can be inaccurate)? */
>       bool fastpath;
> +    /* Total pending data */
> +    uint64_t total_bytes;
>   } MigPendingData ;
>
>   /**
> diff --git a/migration/migration.c b/migration/migration.c
> index 99c4d09000..42facb16d1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3198,6 +3198,44 @@ typedef enum {
>       MIG_ITERATE_BREAK,          /* Break the loop */
>   } MigIterateState;
>
> +/* Are we ready to move to the next iteration phase? */
> +static bool migration_iteration_next_ready(MigrationState *s,
> +                                           MigPendingData *pending)
> +{
> +    /*
> +     * If the estimated values already suggest us to switchover, mark this
> +     * iteration finished, time to do a slow sync.
> +     */
> +    if (pending->total_bytes <= s->threshold_size) {
> +        return true;
> +    }
> +
> +    /*
> +     * Since we may have modules reporting stop-only data, we also want to
> +     * re-query with slow mode if all precopy data is moved over.  This
> +     * will also mark the current iteration done.
> +     *
> +     * This could happen when e.g. a module (like, VFIO) reports stopcopy
> +     * size too large so it will never yet satisfy the downtime with the
> +     * current setup (above check).  Here, slow version of re-query helps
> +     * because we keep trying the best to move whatever we have.
> +     */
> +    if (pending->precopy_bytes == 0) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void migration_iteration_go_next(MigPendingData *pending)
> +{
> +    /*
> +     * Do a slow sync will achieve this.  TODO: move RAM iteration code
> +     * into the core layer.
> +     */
> +    qemu_savevm_query_pending(pending, false);
> +}

I think the iteration terminology here could be confusing, because these 
two functions are called from migration_iteration_run() and they don't 
refer to the same iteration concept.
How about migration_pass_next_ready/migration_pass_go_next?
Or migration_dirty_sync_ready/migration_dirty_sync?

Thanks.

> +
>   /*
>    * Return true if continue to the next iteration directly, false
>    * otherwise.
> @@ -3209,12 +3247,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>                           s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>       bool can_switchover = migration_can_switchover(s);
>       MigPendingData pending = { };
> -    uint64_t pending_size;
>       bool complete_ready;
>
>       /* Fast path - get the estimated amount of pending data */
>       qemu_savevm_query_pending(&pending, true);
> -    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
>
>       if (in_postcopy) {
>           /*
> @@ -3222,7 +3258,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>            * postcopy completion doesn't rely on can_switchover, because when
>            * POSTCOPY_ACTIVE it means switchover already happened.
>            */
> -        complete_ready = !pending_size;
> +        complete_ready = !pending.total_bytes;
>           if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE &&
>               (s->postcopy_package_loaded || complete_ready)) {
>               /*
> @@ -3242,9 +3278,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>            * postcopy started, so ESTIMATE should always match with EXACT
>            * during postcopy phase.
>            */
> -        if (pending_size <= s->threshold_size) {
> -            qemu_savevm_query_pending(&pending, false);
> -            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
> +        if (migration_iteration_next_ready(s, &pending)) {
> +            migration_iteration_go_next(&pending);
>           }
>
>           /* Should we switch to postcopy now? */
> @@ -3264,11 +3299,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>            * (2) Pending size is no more than the threshold specified
>            *     (which was calculated from expected downtime)
>            */
> -        complete_ready = can_switchover && (pending_size <= s->threshold_size);
> +        complete_ready = can_switchover &&
> +            (pending.total_bytes <= s->threshold_size);
>       }
>
>       if (complete_ready) {
> -        trace_migration_thread_low_pending(pending_size);
> +        trace_migration_thread_low_pending(pending.total_bytes);
>           migration_completion(s);
>           return MIG_ITERATE_BREAK;
>       }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b3285d480f..812c72b3e5 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1766,8 +1766,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>   {
>       SaveStateEntry *se;
>
> -    pending->precopy_bytes = 0;
> -    pending->postcopy_bytes = 0;
> +    memset(pending, 0, sizeof(*pending));
>       pending->fastpath = fastpath;
>
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> @@ -1780,7 +1779,11 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>           se->ops->save_query_pending(se->opaque, pending);
>       }
>
> +    pending->total_bytes = pending->precopy_bytes +
> +        pending->stopcopy_bytes + pending->postcopy_bytes;
> +
>       trace_qemu_savevm_query_pending(fastpath, pending->precopy_bytes,
> +                                    pending->stopcopy_bytes,
>                                       pending->postcopy_bytes);
>   }
>
> diff --git a/migration/trace-events b/migration/trace-events
> index 5f836a8652..175f09f8ad 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>   qemu_loadvm_state_post_main(int ret) "%d"
>   qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>   qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", postcopy=%"PRIu64
> +qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
>   loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>   loadvm_state_setup(void) ""
>   loadvm_state_cleanup(void) ""
> --
> 2.50.1
>

