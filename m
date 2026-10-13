Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3045FCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY9L-0000Wr-TR; Tue, 13 Oct 2026 04:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1xGY5G-0002aq-4W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:42:07 -0400
Received: from mail-southcentralusazon11011059.outbound.protection.outlook.com
 ([40.93.194.59] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1xGY5D-0008Nv-Om
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:42:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzQPdIytXVHY6aRBYZGAeyOdHqzF5jCUPvzVHEyS+4PrGz+HrQGj4FyjbP3wwBgDjr8luF7Xw5ZXyXeAVvgfFdu/3KOb2iCZ/DDjv4CL03tZDOjGbazsjVbAMdfdDH2kzFjMh0RkDUNv+ngfqgG8oi67pNbva/k6kgADBdZbdHaeddVC27yPPhqIct8bPYBZXli72Ru1p3z9ALcBOtUipAKOWA0gzi+1NBiSFnjr3EHTRrAUjyfsGv/IPJq9dVKn5WRry2qUxZlgK4jX90svjBXXWxRY1HFRKsxIehF74QATCgiNu9hr+F4dRxmgUCWvXqeSGX+54CCh5g1MzB/lRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00u1YONG9v3bdwh3CJTxgQwT9n/BHtImKbnc9eMLEnY=;
 b=oM6q2f0+uQMBltz+wVk3p2MJ/7sqV6wxQZw+1htMmEB/wHhVcSVO8mdLfXSk8mmn/ARCLpUwdALRLtbQz5BeUohS3XWGap1uIHfXH0iSdmz11es6UdzV+pNo00SxPSvokBa0kVDna28mEZBR5+U8h5009W4YFEiqefqqU6stIokj5c1RPqUmEfkQL0RID+umaI9cUj309Zq1Yf5KgqIrwjDKyyTa2PTbsZLeMa96NsZ64qJyskb01xUdHUOGLL7ricr9UWGoyKq6jt24oa6YXud7BMGkH0Pj48VXAZHiiGSIBMEk1il5Qa+xjh1xRJn6z4dW/R2CmJDDlSnh1TY5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00u1YONG9v3bdwh3CJTxgQwT9n/BHtImKbnc9eMLEnY=;
 b=ukoJ0dtR46z/6HC3WOh0aQ5qS/Wa471uBr1Xs/dfXjMrHUlT0wlzk1IVGgv3O92iQ4ZlRLKmpeCkX3AyQnXudAtFkA4kCZYc/xlttmtrNBExXendVIgEwy463p6MLlhh4Tf/4DB6P2CA9JwOur3LI+CE4CQAXgIdrwSQCDpqo+XlCSMtnCN9NdEe99Qhbgix2hmdFNd4tkmQ98lTEWI4GSuuJrO+Sdqf/yCxNMOAaNvnZIy+0Mi8MmeYYKJayU3+gpYeaiP0JNKYOyzIuHuUk32dUs8Bk3tevYlixY6dLv07WrHgbadhqoxNOpnvztmPklS49L9L6wynTN5MEJ9ftA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:36:57 +0000
Received: from DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56]) by DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 08:36:57 +0000
Message-ID: <72d85479-6be4-4978-b176-0b1a547e7e86@nvidia.com>
Date: Tue, 13 Oct 2026 11:36:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/migration: Don't reset a device on a declined
 stop transition
To: Pankaj Kumar <pshit@nvidia.com>, alex@shazbot.org, clg@redhat.com
Cc: qemu-devel@nongnu.org, pmohite@nvidia.com, dnigam@nvidia.com,
 alwilliamson@nvidia.com, smitra@nvidia.com, kwankhede@nvidia.com,
 vkale@nvidia.com, targupta@nvidia.com
References: <20261008024329.1996536-1-pshit@nvidia.com>
 <20261013044520.2439021-1-pshit@nvidia.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20261013044520.2439021-1-pshit@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To DM4PR12MB5119.namprd12.prod.outlook.com
 (2603:10b6:5:392::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1aa930-1aca-4066-1644-08df29052431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009223027099003|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: DmaLluahu1UN0YF4MI5JSNaPBDsceTMVaVuo6VsRHwlcP9ocLB7aLstwzNzCGolKXUYqzZXKBWsN0tdXLhycvxf+aHRLlz/HfwtUuPr/YQibk7KFhcezYXqbF/QhmSMbM+UL27ECARLWgoJ6yobjTuDG6CrjWtzCg5jvDb1wS3b9zEeNm0RLFX0QqNJA5wPOjvACpAIyxjOWPoHEzIkG/Uc2lIG7JLRWQp9U5VEF4FMZ6LOTCYeDjv0T8E89LDMggw0FNFbZkH7VA0bFvkJfIXPa7HV9sYRxZCOcloVBCMw860TH8mZsDsGSjFhKTP9qu8W/WQhhrWeruZnjqANOmGA+I9DKxqbv64PeNv13c5szqE3MwUlwUAHk6pw4jEZTvtnWI3PhBFC1m/dvAvD53x1jarGyy8L/FWpwcNeOan7r9rEmyc6NKy/ZjgK/mojpH5yBE6OGdlgWtxWKyArJKpA6TH/zLxbNEhKsLsJGDHpnku3w9sO05nKkbcKTM+anzckBq80kReom6I9GCSqAPzuRKWWjhANl4DuZx5k78YRRMZsah69T2MvvHYD7ev8qQ+z+5rlvmjrW1pTCA3/GhlCShZLOZzJP54IzJPDimN4wIRz0bAg/bQa9Mr/helSI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5119.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009223027099003)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhTSDZzWjg3VHlIdktxZGF5ZUVqMXBPa3RRR0pTelM4YzlNTnlMamtoeTdy?=
 =?utf-8?B?WVNsVUZOUjRnTWRFeEZ6WGpxSVJoRnBqdUpDQmcrUjh3cGVxZmxXUXhESnc1?=
 =?utf-8?B?djdheWNqa2d6M0VsbHM5cjF4TW1sRmJ0Q2IzaHZ2aU9zYTlNUmR6eUxIWEZJ?=
 =?utf-8?B?K05yeW16eUhJYWN6R05mM1RpUlY4bDdPYU41K3F4bllob2h3dXhZZU1PTnRl?=
 =?utf-8?B?V0dMYitnUWtxVU10ZG5uanFReHg1SHFkY2tkVUcwTk5jY3NyK1g4T1RqM0RW?=
 =?utf-8?B?OEt3NG94djZQb3RGZWMrM2pEWXd2UkZ0WS8wZFpYeXQ3ZytObml1WXcwUlpo?=
 =?utf-8?B?endRSmo0Y2hRMkJGS3lncjRwV01UT2RlcVFHTUdaZENlWndsSHJRWTZxT1Mx?=
 =?utf-8?B?RGdjNWNZL0hFcktqR2Q5dGU1ZGtzNjdPdU43Lzljc2xYbmwvWE8ycUhrcDU2?=
 =?utf-8?B?T2FKSGNwVGRsd3M4NlhpZURiR1I2aitNaytSTFlpZkJrTWIzK2I3cnpMM1lz?=
 =?utf-8?B?ZGQrSU80RkVIT1NsU0xxdXlnMWJtUDh2YnNYQnI4ZmJYWjg4cjZVNm9rWTVN?=
 =?utf-8?B?QkFjdWI3MEo3R2JObjBPNkxoVGpXL3JMR3EvdmFVSHkraWJwYUlJWjk5RHpt?=
 =?utf-8?B?M3VXSUp5N08vN3U3REVTWGdVOG43VjRkZDlSaUZlNFRxYTNveEZOZzJ3YUd0?=
 =?utf-8?B?NTZBdFNyWjd0by9aNUREOENLdVdPNFpHN0pSTFQrN1pIbGlGd3BkamVMU2lC?=
 =?utf-8?B?NEhMeXBVUE9CT0ZuTGhYMmVQaERORVZHUXpORDE5dDVjdGM2dFRDK2lVKzc0?=
 =?utf-8?B?TWZTTEVOWjJOOGpKZ3pSWUg5WlQ5bXVub1NSSk5aYkdOKzg1bVdVTFVGcEd6?=
 =?utf-8?B?MWplUTFGaDI0QU5kTUFRN1kwQmtySmNLbzRTRFNzdmZ1blJrL205NmdKTHN1?=
 =?utf-8?B?T0xHdWJtWmdTNkNUYnZtSEpsUDNLSTEraC9NeWxJVXVsNXdvQ0x4TEVocW1R?=
 =?utf-8?B?bC9yN25WcFZBSnQzQ1V2SUQ3dVNmQWUwUTFjQXB2KzBjbzYySU03eGZXVFcw?=
 =?utf-8?B?V1FWcXFMRGlDcTZDTHNhK1dWYUo5MTFXMDZ6R245cVNkT2h4MnJkaW92Kzl2?=
 =?utf-8?B?T1Zjc0JTajVYdFdJNHd6Y2hUaHJ6bUpLZXFkbjEvRDZnMGlOekxHdXdkYTEr?=
 =?utf-8?B?R2w5VjNHQTY0WUp1T3piUzg0NFNrdlloVHRBRHRPVWpoOWJra0Z1YUlscE4x?=
 =?utf-8?B?K3JKdEZqUGVLTnE1NStoaUt4bnZ5UDM5OE9Qb2VJTHJLQ2lxZTRxVk9GdFVk?=
 =?utf-8?B?WGF3VFFCZ3dxendsUVdvZURDcHdmTjRnYlkvelBXRG41MDFPSHh1K1VCb3F6?=
 =?utf-8?B?cDVsRGlZNmN3enUyVGFUSnp2bW9YMVRINE5MdVc5VjJVVjJ6TExsUTJsZ3JP?=
 =?utf-8?B?MXJhWStwUkJGSDR4MDNYSGY2RFNua2t3Ni9FL0dONEl5eTljUWdEbkQ0ZkF6?=
 =?utf-8?B?blBJQXNkZ3FCWk5HY2RYMU1oZ2I3bmZuVTZpd0xqTU5lamNDU3U0VEhlVWR0?=
 =?utf-8?B?dE9abXdocnU0Z2Z6SVh4Q2h4cFEyMmZROUIzMlIxdUQwTzNqb0xLTEtFQmR3?=
 =?utf-8?B?dmVKSUx2TUQ3aXVrYU1FOXhmbUdNNUIwTXdxNytoY0tPMTFvTGpaTzhCYVEy?=
 =?utf-8?B?TWg4MmxwQkdZUmVXZUliTDd2T3NHbzdnNG03WURHcXRJYzZZNW1HNjNyYXds?=
 =?utf-8?B?OFlXM2JHd0xFaXJldTBLcHNMckNybmVBWHNHODd3OEhNWnFFYnM0REhTKzlC?=
 =?utf-8?B?VE1lc2s3RXFvb3E3UVVjeHpYcHYvM0Yvak4vYTdFeUxTQ1lBNm03SGpVVG4w?=
 =?utf-8?B?Zjk0L3hCVS9UQmVVdGpudDB5RTR3YWh2T0JaVFlpeUxXbktRbFpoTHJjOCtv?=
 =?utf-8?B?RCs3Q0FGa2VkbnJzVk00OVQ3R0p0YVdyQ1dQOE1FZXdBaUZwZitnUVdEeVZ0?=
 =?utf-8?B?Q0xBaHFDUWJiK1dUMmFFSEJBWW9nMVFBbGlhZlpua1h6aFQyaDVKdlJrMmsr?=
 =?utf-8?B?NExxc3hmMzhlcmZHUFFsL0hrb3ZxbUw0bTJsSDlyVmExNHljb1RqZGhRTEFm?=
 =?utf-8?B?K0Y2aUdqc2VYd0dGZWhmT1I1SkhZRGRKT1hTYUk2R01oUnNjMkMvN29DSDRl?=
 =?utf-8?B?TStveUNNeUlpSzZTSmFkK2xxKzZ2VERNZ3JvVFlINnpjTUtucG02Mlg4N3Ji?=
 =?utf-8?B?Z1o4UWw3UldQbGs0aTk0Si9mL1VmbjA3dXVkQlU1ZE9PckhPNHZwSDZFS3p6?=
 =?utf-8?B?NWxyVkMwVEtEdnVmSkhRZGVFTmRET1BkSlRyOEwwZnV0SGl6NmYrUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1aa930-1aca-4066-1644-08df29052431
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5119.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:36:57.1131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkrGamUR8kknXtVtg1JfH6J+AG4AZZySjnp2f9vdhPqqG+/jS/bDEYWtWFvUbRqF9mO+n3kdDmqsrcxpuzWewQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
Received-SPF: permerror client-ip=40.93.194.59;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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


On 10/13/2026 7:45 AM, Pankaj Kumar wrote:
> QEMU resets a VFIO device whenever a migration state transition it requests
> fails. This is done by vfio_migration_set_state_or_reset(), which passes
> VFIO_DEVICE_STATE_ERROR as the recover state, forcing an immediate
> VFIO_DEVICE_RESET.
>
> However, a device may legitimately decline a state transition, e.g. a vGPU
> that refuses to stop while a profiling/debug session is active in the guest.
> Such a device is still healthy and running the guest, so resetting it destroys
> a perfectly good VM.
>
> Instead of resetting on a declined stop, recover the device to its current
> state. The current device state is always a valid, already-reached state, so
> recovering to it is effectively a no-op transition that cannot itself fail and
> trigger a reset.
>
> Introduce a helper, vfio_migration_set_state_or_recover(), that selects the
> recover state based on the transition direction, and route the vmstate change
> and save-completion paths through it:
>
>   - vfio_vmstate_change() and vfio_vmstate_change_prepare() recover to the
>     current device state for the stop direction. The resume direction keeps
>     ERROR as the recover state, since a device that cannot resume is genuinely
>     broken.
>
>   - vfio_save_complete_precopy() recovers to the current device state rather
>     than STOP. If it runs after an earlier stop was declined (the device still
>     in a running state), the stop-copy attempt is then rolled back instead of
>     resetting the device.
>
> The existing vfio_migration_set_state_or_reset() is retained for the paths
> that must still reset on failure (save cleanup and the migration-failed
> notifier).
>
> This lets vendor drivers decline a stop as a matter of policy without losing
> the guest, and lets such drivers drop their own workarounds that swallowed the
> spurious reset.
>
> Signed-off-by: Pankaj Kumar <pshit@nvidia.com>
> ---
> v2:
>   - Introduce a vfio_migration_set_state_or_recover() helper that selects the
>     recover state by transition direction, and route all three call sites
>     through it instead of open-coding the recover-state selection (Cédric).
>   - Keep vfio_migration_set_state_or_reset() for the paths that must still
>     reset on failure (save cleanup and the migration-failed notifier).
>
> v1: https://lore.kernel.org/qemu-devel/20261008024329.1996536-1-pshit@nvidia.com/
>
>   hw/vfio/migration.c | 38 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 33 insertions(+), 5 deletions(-)

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Thanks.

> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 73c49d8c24..69d50cebdd 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -246,6 +246,25 @@ vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
>                                       VFIO_DEVICE_STATE_ERROR, errp);
>   }
>   
> +/*
> + * On a stop-direction transition failure, recover the device to its current
> + * state instead of resetting it: the current state is valid and already
> + * reached, so recovering to it is effectively a no-op that cannot itself fail.
> + * On a resume-direction (running) failure, the device is genuinely broken, so
> + * reset it by using ERROR as the recover state.
> + */
> +static int
> +vfio_migration_set_state_or_recover(VFIODevice *vbasedev,
> +                                    enum vfio_device_mig_state new_state,
> +                                    bool running, Error **errp)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    enum vfio_device_mig_state recover_state =
> +        running ? VFIO_DEVICE_STATE_ERROR : migration->device_state;
> +
> +    return vfio_migration_set_state(vbasedev, new_state, recover_state, errp);
> +}
> +
>   static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>                               uint64_t data_size)
>   {
> @@ -771,9 +790,16 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>   
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>   
> -    /* We reach here with device state STOP or STOP_COPY only */
> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP, &local_err);
> +    /*
> +     * We normally reach here with the device in STOP or STOP_COPY. However, if
> +     * an earlier stop transition was declined by the device, it may still be in
> +     * a running state. Recover to the current device state rather than STOP, so
> +     * a device that declines the stop-copy transition is rolled back to its
> +     * current state instead of being reset out from under the guest.
> +     */
> +    ret = vfio_migration_set_state_or_recover(vbasedev,
> +                                              VFIO_DEVICE_STATE_STOP_COPY,
> +                                              false, &local_err);
>       if (ret) {
>           error_report_err(local_err);
>           return ret;
> @@ -1009,7 +1035,8 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>           vfio_final_precopy_reinit_check(vbasedev);
>       }
>   
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
> +    ret = vfio_migration_set_state_or_recover(vbasedev, new_state, running,
> +                                              &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
> @@ -1040,7 +1067,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>                   VFIO_DEVICE_STATE_STOP;
>       }
>   
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
> +    ret = vfio_migration_set_state_or_recover(vbasedev, new_state, running,
> +                                              &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()

