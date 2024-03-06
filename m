Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C3C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rho0p-0001hd-NZ; Wed, 06 Mar 2024 04:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rho0n-0001hC-R1
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:56:33 -0500
Received: from mail-dm6nam10on20619.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::619]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rho0j-0001vL-G4
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:56:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7XRwO5iCP9iT3+bfjq4d4Asvs18rwjnCCvRzQYL9II1vfsctXs6Jr0VQC2UX0dYJzwU9P1deeaYMT3JAchhbBRx/Z8oZPnVEWqmu0I3td9NVuLj4EEeOtqGzbUJdBbZA2iwkEFGEXg09z6oWO2tQUWhxWo3YPxYihktr0nnM3rtixy6kamiw22nxY0L4K+BJ0NXAFnXveMLTBa+fHdFiE1zKlpbMLJTrdodyS5px+I9b/E1Mf1Ez2pEPW2LdeglbyWqoIOYgftegEZFqq6a3oDW19ulTjKt/Pqit7e+IsA0WazCpeJjb5pKe2Loxoegoh74ynx7ivFuf6VLNK0fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA4y38uUMfw0sXhGd25iRJvV2kthUxjhwkAkzGmFYnw=;
 b=SdjHGV88l7Q08XJv7f9nQUOXgRlrKlyCoHDJ7ArgxJcVJ0BYUpW89ZJpU8Q8z+P5w798OkUXxFvjY741xuenZCo7CmeEpEAUR85xi7IqTt+7b5wRCTj92jXi38phRLGTlrAg0Dhtv0zBOu8LSFLGIdfsvtLY8gjcSxSYjcBdASpS9p9LKcVMHPNFn+UNT6IHr/hy2e9hrIVa0he12eK12bOHJcY3lV7Oa3dOfaL6tWw0nHZkPiu/Cc1EQ6QUH3Xz/RdpW6n2+3J9vkDlPMnl+Baa0B1nPgpUFezeLUsnnBODd9Fcs1nSR3nCzAm4/acIUPAkc5adT/rzzjrUUzZRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA4y38uUMfw0sXhGd25iRJvV2kthUxjhwkAkzGmFYnw=;
 b=VuNkPsVqrc3I6HZ6O0IX852y6BkREJQgl5GU9Daq5LadOImaHDdjAm3EyBXlg5nm3z3BTEZpM2I/GlJuX4ZwKTSFxLOOcsnLIkUfLL7UnzbZxkc3EbItBsxVMRGjcVOkIrBgWVa+1S/96Gy7PiP/QqGF6MgsctovhgbGx9o7yvIODXp/Fulwmc7ynowfDvPC60/6E16JmE0DMohJ18Ox8prCG3SWJfo5wg5fOrQYqKJnQAKBL/Sz07kxzkZFsxP4lUlmfZlIOfE1de/8SBhwYqwZB/g9eLSluicGvyA4LkhKx0PAYDvnZHMZdCT/TomQfC/IOsfIgL6virbJ3F/xww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Wed, 6 Mar 2024 09:56:25 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%5]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 09:56:25 +0000
Message-ID: <aad3aa6b-79e5-4968-8bb9-ddd35883d02b@nvidia.com>
Date: Wed, 6 Mar 2024 11:56:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/26] vfio: Always report an error in vfio_save_setup()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-3-clg@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240304122844.1888308-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0478.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: f93237a0-57cd-49de-5271-08dc3dc3af5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sBM7i1Xs1BiWhJjuF4nlf2jTFeAYGYCfikOrYFESqN1LGLrvZATL69KJy+HE7nGuFAoO3tOY6DNZAoHz12on40IlpTRmjsnwzF/ckRoLgOP0OeXb11MseCeYqWqa3hgvofLGjOrTqsjanrixNhi5UwOi/TbR8dZHc/P8sQ0Giqud/8Ec0mZM3lF0RC/WUnv0Nxs2alAmmSbhsLB2LrYp7Px+peQmIaDTzeFBbBqk1JMG0ED0kw6UNgZhs0QcuzoabHAb3ZlYKOuVC+5Rc3UgGPhOo+FdlSXkm3Bq0bcJqWWxy5NzGnHVW/jZWOE6yf/3/Mr6rtKrRq5myUtQCZosQbUEwRYgjJT5jn2l7+D+3h4f53Q+68VJYnBV6SIXu2S6eg4SINgrRS/t4UgYJn2IPLfPHDI27U0VtInafta+NQGww3k3Xqr8KdtxHdCrvl9UouGA3wTOfqle0U5RHxy7bRHuh6LGkm8nurNCFcYn8TzgLf1Y1LAKr/fwpKs9seFEUwIgq9CJaSF6HSIws2+gCpt6wHqiY9n47cklKIv00A+ucclM1zmz85eFqtUbSQAaCMvWckauGMxctns/tIibOu0r/WsXmekniY8b5yTc1BH8XL11SQVVBANMuFJbFytxpz26BhZrppShpdxOFH8uAvSBMdzsWChGN9w9xNG0lM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2RKOTVscXVVUVJ2RHVlZXZaZm5pMmhiL2hlTGxPVkx6YjBoTTNMWG5aeGY4?=
 =?utf-8?B?WXJaeGsyNUVORFhpL3l0MnVFSUlXaTI1UVlJSkpvZVB5TXBYYlNJZTRBQ0d6?=
 =?utf-8?B?Y2p6cG1SMTQ5NXZHTTJGWUpZTkFyK082RWovL2ZtNHFndW5hejVieEw2WXVH?=
 =?utf-8?B?QmNhS0NQOHNLZVI2QlFMNFBWVTJYU0MwcWFscGJ1RG9Bc2V1RjluUmZoK3pp?=
 =?utf-8?B?QytEMEdtb0kwWWovVDdTbXFWMkpaMFhoMnJad2NPUmY1eitPS1NzOUR1Tk1o?=
 =?utf-8?B?TElDeHdka0JqRXhTYXdkcGRCd2J2S0hPalV1VXQ4bGFTbzZNZmZuOG94QmJI?=
 =?utf-8?B?MFpDVC9UdjNCRWdyYkJ1d3EreC9hczBTUkczQXB3QmlTZUNPSG9Cd1dsS3RQ?=
 =?utf-8?B?Z2hKN2kzdVZHdHBlaWtXWVk1WHhMbDBFajVPMXRNUDZNYkYrSzlWOGhxdEVs?=
 =?utf-8?B?U0JybGZDMXhBMXFyanlNZE5kZUt4WWRqeGo0SkJtai85eWVMZXhCWmp0WW82?=
 =?utf-8?B?amFqT2t2bkJPNXA4VnlhT015WTd1MnVRcFFUZE5RRTF1VzA2WVVCNWMrdGE4?=
 =?utf-8?B?KzRhRzhZcXZyMDVsTVloYmhsZ2ZaWURPcmh3ZGNyUUtsQ2lFQ3Y5cG9JSUg1?=
 =?utf-8?B?Nk1oMDFmTkRQVFgrbGFWczNTNXJiR2xqelNiTzNQMUdIMHhQUFBxdDE5V2Zq?=
 =?utf-8?B?Tm85RGo4S2RyMHBySGtTM3B4V3g2NVpHYnAxaTAxM2hIcXhKQ3lJVWYweWw1?=
 =?utf-8?B?eXNOeGxCRUNOWk1DaExkYktZRm5yTDJkL1hBQkJCZ1F6dTlWb2hCUGxnWk5Z?=
 =?utf-8?B?clJrcnRBZUJFb0tkMUFsSDliNFhFREcyMWtDM1dlNTFQbGo2SFJlYjFTbndi?=
 =?utf-8?B?ZitpcG9PWURUMWlHZ0FMUy82aFhiNFc2K0NSQ0EwcEUxc1VjMEY1ZytJMUlT?=
 =?utf-8?B?azhBMVV6WExTMTA3TEVKUjV6am5TZ2s4cHhiZ2R2RVlTc1doYm5RaUdDTnBK?=
 =?utf-8?B?UVVSa2VrMzd6NHdxSDZrOXo0MzArYjhPUkg1NS9QKzVDRkx0N3N1MDVBbHZ5?=
 =?utf-8?B?S243RVNGME1ZcXd2MWQ2a0NkK2F4RmNJZlpWS3NKYU9MQ0d1VUFjd24xZmFy?=
 =?utf-8?B?R0NyREcveXFtNk5hbzAzRldLclh2S0RLT291dDh3a01LMU9VMXpvbE1QMHc0?=
 =?utf-8?B?SGY3SFppSTF3QUNiVTZ4NkRPVEJ2aTdnZWJHNnB4cHp6ZkRscjhXSDFhSXBK?=
 =?utf-8?B?ZXJPbDFSem5ja1V5MHBuWTMrVFBoeEtXbHJjaGU2elpZSUU1d2lBOG1Iclhl?=
 =?utf-8?B?YUpsRmtBWlF0cHYrSnRsQ2FrSy9TWXVHeTBqQmlYcy9vQWE0UVNNWjhUUWJ1?=
 =?utf-8?B?OUQrNzhSQitJUFVNVTRXSTExUEszM0RobUxDekEzR1V6dWZHM2hZRUlEWWpB?=
 =?utf-8?B?aDFYeDJ2ZkRQc3I4dFFEMUVBUjhZSWxpRy9KU3cxemxpblNHZkJOT3ZJNytS?=
 =?utf-8?B?RWJiR25hSDBRVjhGcjZZRFp3NllpVDd2VVZ6VmRNTEZ3U3BXQVBiY3BzdXhl?=
 =?utf-8?B?QU81bWpKd3lNMWJDUVNPVHErN2hRNGVaRGN4TXJMdXdzeFQyYUJrRXlnYUhx?=
 =?utf-8?B?MXFKbjhYZGdQcSsyaVc4cUQzUFY4VnhxVFNxU1I1T0RXM3JUVW5aUlhpQWJ1?=
 =?utf-8?B?WUF5OWNzLy84RENXMmwwMUFFSldiY2NvcDNobTdCV2ppRzlYQ0RjKyszdEtk?=
 =?utf-8?B?OS9lSVdlZnMwWmJ6R3FWK3Z6TWNic2RzRmpmenV5ZU9GaXBJYUNndHlReHlW?=
 =?utf-8?B?aGxsM2xhRCtYRnY1Y1Y1TWhpY2MxYmlZMXVzUnV4SGhDWEVjdzJlUEMxZVg0?=
 =?utf-8?B?cTV6OTVpQnUzOGVHLzhTQXowQ0VjbWltY2VSL2pNMERYdHVHeUtFQmhMYU1W?=
 =?utf-8?B?N1RJNGF5cnRoNTFSM0NyeitoKzd6NlJkWVdISjIrSm8xbGxRMjMrZ3Q3V1R4?=
 =?utf-8?B?T1EwbXJMc1NySnNvUXlVV2prWjBLYVU0WElXeWU3cVNJRHlKQkI4MVBMMytv?=
 =?utf-8?B?SHpHZVdxcU1oZWFKNVV6WldJVmd1ckZ5cXUwNHpuNHM3U3VKRnF0S25yeVZF?=
 =?utf-8?Q?S+rGc+lmRi/ihJScJYh8svf4Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93237a0-57cd-49de-5271-08dc3dc3af5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:56:25.2411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ux/+7W0rOgOI4PWnzIQjKeqxJCpPA5If5tq9zioJ+pMxwz9C+b7gx14V4pjE8hhwz8uJokFP80xEmcxMo1pu2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
Received-SPF: softfail client-ip=2a01:111:f400:7e88::619;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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


On 04/03/2024 14:28, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> This will prepare ground for futur changes adding an Error** argument
> to the save_setup() handler. We need to make sure that on failure,
> vfio_save_setup() always sets a new error.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/migration.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 2050ac8897231ff89cc223f0570d5c7a65dede9e..51bea536cc290ba0aa393f78b017b0650e333bff 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -383,6 +383,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
> +    int ret;
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>
> @@ -397,13 +398,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>       }
>
>       if (vfio_precopy_supported(vbasedev)) {
> -        int ret;
> -
>           switch (migration->device_state) {
>           case VFIO_DEVICE_STATE_RUNNING:
>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
>                                              VFIO_DEVICE_STATE_RUNNING);
>               if (ret) {
> +                error_report("%s: Failed to set new RUNNING state",
> +                             vbasedev->name);
>                   return ret;
>               }
>
> @@ -414,6 +415,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>               /* vfio_save_complete_precopy() will go to STOP_COPY */
>               break;
>           default:
> +            error_report("%s: Invalid device state %d", vbasedev->name,
> +                         migration->device_state);
>               return -EINVAL;
>           }
>       }
> @@ -422,7 +425,13 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>
> -    return qemu_file_get_error(f);
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        error_report("%s: save setup failed : %s", vbasedev->name,
> +                     strerror(ret));

Here it should be -ret (and also later in patch #12).

Thanks.

> +    }
> +
> +    return ret;
>   }
>
>   static void vfio_save_cleanup(void *opaque)
> --
> 2.44.0
>

