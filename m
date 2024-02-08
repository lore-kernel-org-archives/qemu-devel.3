Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C31EC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 14:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY5Cm-0008Br-O1; Thu, 08 Feb 2024 09:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rY5CN-00088c-1p
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:16:19 -0500
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com
 ([40.107.94.56] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rY5CE-0004yg-U4
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:16:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI/5J1xIi3aopJLXDb1gb3xZmHU4BeRAuqbvqql5gwKTsbKyTnVahXqHjaJ2o/kGByOmuGJ3+g+DgMWVWU0hV5KFobQ4L9M/R6A3obW1G3WGdZf1ftO0uOPwTb+j5q/zm5fxn+zpJx2gfllpTNEqYMOMpdAVm+txlNo+wLXsol6mbpzXkqXs0UyIBBy6SCuj03xKJ0+Xu+5jXctVY2xwjztYgpAjeB3zAfgxhVd3V+Q0zFqZvic8yj6fP13fZotBkew00XIT1vtS2uJNal8b6MBZQSFm/RAbiRmPhy149qaB8l0FThLDqhdHIXLptYcfK9iUBM7YlP1NUtbCgOCV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h0IvoxJGXJqbm2KmAvyxa6bQHlBXLPSVHNwpeab4Fs=;
 b=kSff/uZHJ19FNM4SvmEtMJ0hfJw2xEMBUajvrwPcRRfplMfn5pbUBYnPPS/OAj0ZW+wuk96Dz23F86Q6itQp59Yadhwyrm0SuHxwDorQYGBMK3b12EJjk0vP4errnRTRug6fW/dLFwcENH7o1PWIvRHDOBzkwtjieoWiE9cKB1MifEZe+r4jMKbr1XCj9EiBgPSbHKF/C/LrNtLTu+hZZHTeFvfotiLicS0cNMsWldVJ+2+ejZZV1kAOmJ+VCXKXinkrn3scyvZQ/WjNxvKLjWg+z6xQVdkrGWo1o5JhLXpYD4DgibKmJtHEWab998bEjmpdwzbVgWIE/4krkx3ERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h0IvoxJGXJqbm2KmAvyxa6bQHlBXLPSVHNwpeab4Fs=;
 b=MdigMHwE742bA9qdhtfqX/NwDXFeu6snzP49NGBNFKI5Sg/M4Lus2M2zYtAB4sOnxxiL52atmh3R7/KpiK6EuVuw9UbzM9QXtboKH1xifcZj7S8Jft5Z2c9vkgOBJKkhbMx5Ps9IcirQLezAO/YoDLE2kXQ0tTcEX5HDpX6Xx28fVVlEmmMXzM8TfVBr/UKjPdWmy+2dhR81/OyCFLShB/CjmyoV3sp+iU9DsD6amQxEVyZtT5SrTOjjMfQDtofc1CzzS0I1CcqNxKER/uh9kErkRwn/UnYlqgOibTNQaL0JvdecOS2Ur9BHYW2N11wYCu+bU3u65Vb5BPGSTP6D2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 14:11:02 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 14:11:02 +0000
Message-ID: <b29381a6-bbf9-4f00-a860-6f1b121f16b0@nvidia.com>
Date: Thu, 8 Feb 2024 16:10:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] migration/multifd: Cleanup TLS iochannel referencing
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240208035126.370620-1-peterx@redhat.com>
 <20240208035126.370620-2-peterx@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240208035126.370620-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::29) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: eaad9b7c-377c-4fb8-f808-08dc28afc7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aq3ckQ7zOKtIhTyFQXQgLImDSiF8670ksm0D05kvDo+ywgcVimNagIWPh4h9cauVz67nlIlud0WShIHyJc6/drsgdLnrB2XVVy199PFiGeFod7W512SYRL2xrnytrReC/hIB+Kk9EdlQruRqHgsiuGXm9Vhpuu8wNtpkJ6K/yd8uUepHkBvdqK0O4BgC0nrmaxudwKXqJfA+Vs8yIQjsC0rFkcf6nX0SImoRA2VtJirbm4vl1ulyICWv5rsLVqq7ONFG8c0qCBbC12VCMSRyhxZ/8FVoCzEFA8tSWbq6ymoi3Pm7NOAyS0v/YsE0EbnM3gPny8efuUa623pSy8wdhFx/WE4hG9jZR/7pLgTNJ3i8VtbQatff/RluqFpBSASy2C7Md3Fg7C20j/TMdNilSJn/yIu9uI2EWnzLdyQThYHj2Xm8Y9bkn2LOg+8kePemZc3giMs6IWRx7K1jhej2qpyXBJMm0F4DmhQYadzqQkYpu6GTXKRLJ7gqJKZK8TU8ev7Uc1sZd1nAdzesWfRLEhGH5SRRKLAZyOYPt+z6e32H4QHkt6BqOUVDptqY0Qcv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(5660300002)(83380400001)(54906003)(66556008)(8936002)(8676002)(66946007)(316002)(4326008)(36756003)(66476007)(41300700001)(2616005)(31696002)(86362001)(6666004)(478600001)(6512007)(53546011)(6506007)(26005)(38100700002)(6486002)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU9YazIwT2g1bFcveTlXY1FBR1lHY0wvZ0dDVng3WDAwWFFmdWJldEs3eVFD?=
 =?utf-8?B?Z1ZTU1RzSVUrTTAzaGg1VDV5ZXpiaHVSY293MVB1bkpPVTRxY0I2VDBrNFpm?=
 =?utf-8?B?a3RFSG5oNjk0SjA5SEdxZlVhSFFWNFVQa1lNQU44cVNJYWxWVkxsMjEyRXRK?=
 =?utf-8?B?NWtEcjNqb0NWd1hNM2k3cElGMnlsUzkyQm1GSWhQOWM3OHkvTjdaeWZpRTg5?=
 =?utf-8?B?Z3ViWlBaL3lGUXRNdU1TemJoditOaHNJWVBRckhCNG8renJJR1kxT09IQzBF?=
 =?utf-8?B?UmwvaVJmNUx5cXJNTjlhUXhXbzl0RmZOcy9KZ2VFSEErUHQxZ05IcDhUcDA5?=
 =?utf-8?B?UzlpNURrdUEwckt4QnQ4bklUbGFUcjBEaEMxeGxuSktQOVFIMVJZYWEwdGph?=
 =?utf-8?B?S3psUUJYT2h6aWJ4QTVzd0N2SDFBbys4OXFWb0FhQTMzU3ZQZU8vVmpqOStM?=
 =?utf-8?B?dFB2QlZjSmtkVGkyeW9uTHJJVElCTmk5NGNTRCtiMFVPdy8yWmxzeTA5T1gz?=
 =?utf-8?B?NktMSDZyL0QxMk5nTGhLR0p4UnNaZlJSN2RRUGRKQXpHOWNWUE1NVzBJVXBU?=
 =?utf-8?B?cDBuY3A2dVJ4V2J1ZzRYLy9HWlJONjhpUjZaV3NJZm1SQ3IrUFhNVEdmNEE4?=
 =?utf-8?B?WjZuaEZnVDFmdjhnaGc3WjNHMUhJT05MMWR5WGxYSkttZmJhb2VQV1BWdW5R?=
 =?utf-8?B?Ulp4bDlZdW41RTQxdDR3UHpwLzUxbmg5OGlQSktHbHJZaW9zS2JZTDN5THQ4?=
 =?utf-8?B?dTBtQ1pycUJRWXVIT0xIc1l5R2x3YXJod0YzbHkvdjYxQ1JhZWh6ejYzZk5M?=
 =?utf-8?B?NkxyY0VwUkpRRG5jRWwrYXJkbmZoVGNUR2x4dDd5WUU3MEp2LzhjODc1dVRn?=
 =?utf-8?B?QlFsZ2l4QWhINlRuUTY5RWk4eDBKbWlqMDNUY0RaclNpWE9iMTU2OFhFbDQ5?=
 =?utf-8?B?ZTF0L1R3Z1ZmTjVrMXo4U3RWSGlSZXpCSStIcXNLbmt1WklrL3M2MnlHNlJs?=
 =?utf-8?B?cWRoN3dLZWtQaWFENEUrNlJNeG14K09oc1lscGk4NWx1REZVVDdNWmluVksx?=
 =?utf-8?B?Zk00bmhpdU5KOFV1ZmhKUVE5aDZaeTkzbC9neC9MSGJ4VVE3TWZYMU40UkNI?=
 =?utf-8?B?YTUrdXpjWUQzc0FRSEFpemluWHh0UTh3RjBKNFVETERpcks1YnJkVTZJVUhM?=
 =?utf-8?B?clU0WTVDTFU1RFdFVzN5MDhDVWlvR1FodDhBT215Mk9uekdFN211bEd1VHFZ?=
 =?utf-8?B?Q0FVaFJJQU80eldrNFJhRFlNaDhnUnJWajJWaUFLdStFMFNCUjJCMTlXWDhV?=
 =?utf-8?B?R2orb1NwRUVRWEdvR2UwMVJiODA0bVJYWS9vZDhNSVozTnJqRDR6Yk1xTGx3?=
 =?utf-8?B?R1pCdmpZMWJySlJSNzlVMzZqSlJxMGluWmVQL0YyTzFvMk9KR000TU5GQytR?=
 =?utf-8?B?NjZEVWFidmRyKzhENzdneTFINkloOTkxbGdVd3lDRlRnUFJvOXZwMldvbmJi?=
 =?utf-8?B?dlorRUtqWnN5eE5KdTNQSUh2VmxlUVdUMmVEQ1ZZU0tPckZ6MDdSRWZoWEk1?=
 =?utf-8?B?WkdVL0ZZd2VJQnRQOGd4TXBZTnBaWUp3bGRhcUx2S0hYQ0ZLM3ZNeXBNUFVY?=
 =?utf-8?B?cTQvQnZESWc3MVU2YVJQa0R6M2tqY1BpalI4KzhUY0JhVEFzUElUZHY4VVFH?=
 =?utf-8?B?am5SWWg5NjBnVEF5ZW1ha013YmZyR2o4SjFldW1aZjVwMDNFMTZFQ3p6WUtI?=
 =?utf-8?B?SkljZDhnQjNCU2xPY1FvY1RCZ1NRVDZRMnFPQlkzNzlER3dJOS80RGtKSzhC?=
 =?utf-8?B?cGRYWDNZbHp0Q291TGJnUHc5ZkxFaDFYRk9QSGUyWDVzQ3lVNW80UFVpemhn?=
 =?utf-8?B?QnJiamdHbHkxZ3kwSjU5Ny93Qkh1eUdGMXJvL3Z6ZzcwS3hIakJXQWhPYWF6?=
 =?utf-8?B?TE15QW1WOXZrb1ByaU1hQUR5L2NkV0kyR09STW5UbzFrRE5pMnpoVVdxaW1Q?=
 =?utf-8?B?My9rU3VzY09CUUcxSHhESWtiNDBPaE41b0RRRG9Ma2locTNYQjZMalFZMXVH?=
 =?utf-8?B?eVI4enRwTmMxQ3Y0TWsyNHpDRFFDNHhLeE9iMjVZSTZIR1JLdXozT2J5ZEo1?=
 =?utf-8?Q?mrKMe4xe5USdDnH5ldegefkP3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaad9b7c-377c-4fb8-f808-08dc28afc7f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 14:11:02.1179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0PD5ktPU1hKWYVgf+52JTGpC8/c3Svk4/i25k0308rFL/Eb71IvJEuK0FUlBXDNz17k77Z6xFJK7kLTVrQFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
Received-SPF: softfail client-ip=40.107.94.56; envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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


On 08/02/2024 5:51, peterx@redhat.com wrote:
> External email: Use caution opening links or attachments
>
>
> From: Peter Xu <peterx@redhat.com>
>
> Commit a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to
> blocking handshake") introduced a thread for TLS channels, which will
> resolve the issue on blocking the main thread.  However in the same commit
> p->c is slightly abused just to be able to pass over the pointer "p" into
> the thread.
>
> That's the major reason we'll need to conditionally free the io channel in
> the fault paths.
>
> To clean it up, using a separate structure to pass over both "p" and "tioc"
> in the tls handshake thread.  Then we can make it a rule that p->c will
> never be set until the channel is completely setup.  With that, we can drop
> the tricky conditional unref of the io channel in the error path.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/multifd.c | 37 +++++++++++++++++++++++--------------
>   1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index adfe8c9a0a..4a85a6b7b3 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -873,16 +873,22 @@ out:
>
>   static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
>
> +typedef struct {
> +    MultiFDSendParams *p;
> +    QIOChannelTLS *tioc;
> +} MultiFDTLSThreadArgs;
> +
>   static void *multifd_tls_handshake_thread(void *opaque)
>   {
> -    MultiFDSendParams *p = opaque;
> -    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
> +    MultiFDTLSThreadArgs *args = opaque;
>
> -    qio_channel_tls_handshake(tioc,
> +    qio_channel_tls_handshake(args->tioc,
>                                 multifd_new_send_channel_async,
> -                              p,
> +                              args->p,
>                                 NULL,
>                                 NULL);
> +    g_free(args);
> +
>       return NULL;
>   }
>
> @@ -892,6 +898,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>   {
>       MigrationState *s = migrate_get_current();
>       const char *hostname = s->hostname;
> +    MultiFDTLSThreadArgs *args;
>       QIOChannelTLS *tioc;
>
>       tioc = migration_tls_client_create(ioc, hostname, errp);
> @@ -906,11 +913,14 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>       object_unref(OBJECT(ioc));
>       trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
>       qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
> -    p->c = QIO_CHANNEL(tioc);
> +
> +    args = g_new0(MultiFDTLSThreadArgs, 1);
> +    args->tioc = tioc;
> +    args->p = p;
>
>       p->tls_thread_created = true;
>       qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
> -                       multifd_tls_handshake_thread, p,
> +                       multifd_tls_handshake_thread, args,
>                          QEMU_THREAD_JOINABLE);
>       return true;
>   }
> @@ -923,6 +933,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>
>       migration_ioc_register_yank(ioc);
>       p->registered_yank = true;
> +    /* Setup p->c only if the channel is completely setup */
>       p->c = ioc;
>
>       p->thread_created = true;
> @@ -976,14 +987,12 @@ out:
>
>       trace_multifd_new_send_channel_async_error(p->id, local_err);
>       multifd_send_set_error(local_err);
> -    if (!p->c) {
> -        /*
> -         * If no channel has been created, drop the initial
> -         * reference. Otherwise cleanup happens at
> -         * multifd_send_channel_destroy()
> -         */
> -        object_unref(OBJECT(ioc));
> -    }
> +    /*
> +     * For error cases (TLS or non-TLS), IO channel is always freed here
> +     * rather than when cleanup multifd: since p->c is not set, multifd
> +     * cleanup code doesn't even know its existance.

Small nit:
s/existance/existence

BTW, I just noticed that multifd_channel_connect() can't fail, probably 
would be good to turn it into a void function.

Thanks.

> +     */
> +    object_unref(OBJECT(ioc));
>       error_free(local_err);
>   }
>
> --
> 2.43.0
>

