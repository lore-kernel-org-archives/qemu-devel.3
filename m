Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAAEC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 12:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXKu1-0004WF-7a; Tue, 06 Feb 2024 07:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rXKtq-0004Vg-Hu
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 07:50:09 -0500
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com
 ([40.107.223.62] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rXKto-0007iw-5B
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 07:50:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btH6SGo7KjZHtdVGLhkkyECElS+s4hhkYmH9baugdFJ1Yua8YfLxr7UrVjxtRx+pIP85YWY4vv+z6PI9ItVefGDVZfmq8KiOOY+FQKoKcyCQXnr2HW/GBZyVeTlyTTbS+fiBPCHRZ4ALzqg2eUZt7vfSRfaVLHnFGGJmZefF2V+G/io9EUYhEz1SraplyatchvzZUXGdBNtWzmzeLMs6ev/mo0MppDXL+wtne4N1Tt/8rrvAvzPVmVzBQ1i9zL8Vs6FNVTHgTTq+Pz5dTyE9pX+J5bwPWBr5KFeeRKJEoP79qefqL78hYlKanW7ZU52z1dHImnkBIG8NXScGOfKGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v54odVXIYUGkMlqPvymi5nT+hDWFSH4hku8pD/iEr0s=;
 b=eG08kYM+It6I/KHkk5Vjy4Cz6apS3dhviFhOdaolFPhnn4rjK5pTsfPsZkDx9Zy67SfUCVwO0tGTMYT4e614MJDCiUjJrqbD1zOgauUo7rW/fFcEhSARFVmCer+1Xy0kpApt30Q3vGZcWvDfqbpVMlsPSvIS3nHvUjUX+QJGoho+uWUAI18orqe5yaRE06su3wzc0Lft17F5MDsbQEeZkBlNcWlZins1f1+ifqPp62WkA05RLIPSVtBNrUR1nfJOSdnb7p4ans+ChQ6dfuMGopNZMwHSX+7i+eQwomYNP5F30ioMZVrzMjn0/m4Op1GK1DOsRHue63g5Tb0YVglziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v54odVXIYUGkMlqPvymi5nT+hDWFSH4hku8pD/iEr0s=;
 b=bCdb6485fEVHr+qskHdULUvuCayeLkYcfxhugKSccN4Jdx6EuKBNh5LCEywYghfWHnOlDtwZ2TsCORIZAbztQh4qLjLRWSEzjkxIIYMzToDyd/crfhYVS3BBMMkRNZUmd++QIaWc3p8HnsGcwmH1XZXdwhiX4RHjBjbgcUCOVnJuYbii1Nc3b0pHspygWdeBaIqw5s7DAkynOhcW2C9iUIpWaxaBDbETrIObeKEuaNjuDBxByfsXqXM4zw/JM2Qi4i+cGY3W4+/bEitOiqbKdvlFmShG3nSriXOfok8MCo3DUmmInEmNdCL2nRyeI1FtRhWDNS12eiX43Jzs41Zp5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 12:44:58 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 12:44:58 +0000
Message-ID: <e4f9337d-ed7d-4a11-84dd-76661009c3fc@nvidia.com>
Date: Tue, 6 Feb 2024 14:44:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] migration/multifd: Unify multifd and TLS
 connection paths
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240205194929.28963-1-farosas@suse.de>
 <20240205194929.28963-6-farosas@suse.de>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240205194929.28963-6-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: b80f7bda-0450-4fc6-0b63-08dc27116d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HULQiaQmYiaCRzGVHykHHRgb+AA3eeH0FbVUxM88m+3wqSfnBrapgCtvr0iHTI3MBZWF7r9xTjJKV6zBN2wWyV7Jvh2UXpbLgjoP9eOa4lrXtjsCAY0FlOEbO6DAq7gUA8KrP+j47lDcOmCrxd6Q2kb4RAdaED0a/5Mwtp/kUxeK7Iv265iD3MSASAB5uzcb9gV4MHSbMG4maA99fiLKL+3XsC5RDsqUvveLF+cuh1KKQHa5CVSYuAyLfUH70TPaA4D3/AlnSt3IA+03k+8NAabBTRklcX9KK7qmDRnoq4pWMf86Ud/H1zr/InDbvZ+NvU9F1b9fiveHZqQpIxrDx0DxYPgUVYBszUYc0Z8OjMMy8gM8wzqyWykqN3LuoIajc6AXMb2ru5OpTmmpWzdBq8tBpm40AMAzLZCFoSNzPw4IIuoIA4QAUW7Pn1I5VtWi1nnfaGar2pcJldMd0l89PySQ+XyXN7fYQGxQIEATB/vIdbo/G529AEFc8kPEnYPvgpuQsOErzGYzY4zbdg2laJz5XVY3c5otP6dRHcMFSHsd8zcy3hnfmg0r27M3UZ5hNUjBGG/H8NXCQuphXH/hBiySNiF/qxZHoGX+Ntt5lPl1mREHSRzZ6LJ8hT2s5UyPf9pVS14GJTswtW95kI55Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(83380400001)(6506007)(6666004)(2906002)(53546011)(66476007)(4326008)(316002)(66946007)(8676002)(54906003)(8936002)(66556008)(478600001)(5660300002)(6512007)(26005)(2616005)(36756003)(31696002)(31686004)(38100700002)(6486002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d09zdDJpTEVraGVCMWNzcExFRTJodWU1bUQ4cE9UOGNpQU9WUldwWDVsVUNq?=
 =?utf-8?B?TUdYYmhpVnJmZG5oWWRhRHFGTWUyRDZweTVGYXJnbXJDVTV6MS9YWjdZdTFN?=
 =?utf-8?B?cVczaUdtNGVaeFh0UXFwWE5Nd1ZLU09xSmdzZlRmU01XdTAvTEJ6SlIyRWpC?=
 =?utf-8?B?ck52Z1NlcDhaT0lQU3NsQVZ6a29GNUJNTENSNURRWm15VXNNWXRia0pSY1NR?=
 =?utf-8?B?bDhxWmpmcWF6M2lzaUVKVk1WbjNQaFh1ajYvTHppZ1JiMlcxK2Q1K3F0ZVRR?=
 =?utf-8?B?dDRTbm5xMU5IVWxCRFEyMFhMUVV4UUpKU3NpbjluNHlhRVgvUE1TckV1eHZP?=
 =?utf-8?B?clExNnFGalVvTTdiK0VrRlFZcEFHcFVvZnRrWHI4K3Y4dGQwOXVNQ21NMU9L?=
 =?utf-8?B?eHA2RlczU0tBTnNwS1ZYdDRtcVJNNUFxNi9pdy9tY1VicmhkVFZoa0NjZ2Fk?=
 =?utf-8?B?eWJuTTFBbXJvUWEzbXJSckNRT3ZDQkFycmN3NjdXTXhmR0ZPTkVBZmt1K1lu?=
 =?utf-8?B?dXVNM2YrNU5Fa3NLN0tvQnpyMk1FWkNtNWQ5dVlpSXg3ejBHTy9mRzNGS3Fy?=
 =?utf-8?B?UHJzckNWa2pSQ2taVHphTTc4cEtZM0xVVG4vZXZZM2lKYW9obEhoMk01dVVO?=
 =?utf-8?B?dGxqZVlnNmtJZlJlMGt2NzVmNHJHMlVuWm00YVhNSUJQc2FaZFpPbWlobHds?=
 =?utf-8?B?c21QMUJYRU4xRlJNdnRKaVNpM3dOME1NUEFTRDhYTTNHaE5nNTZiYksyNUV3?=
 =?utf-8?B?SUZkT3dvaGhCeHVCSm5DZFVNRDlndXlnYVJuRkRRNVFoSUNzYW8vQXNIYzFm?=
 =?utf-8?B?ZFozbjZTaGhjODU4OGhsb0Q0TGJXdXpOUDJqRFpqeUlYNEFINFdIbElFZmd4?=
 =?utf-8?B?d2Y0WXBXY0lVdU1PNkR4amZmaXNzRlBqaDdHMTUrQytNM0sxMnZ0L1JwaFUy?=
 =?utf-8?B?ZGpCbWFkSWp5NW5XNTk1VlBxeXZ3MTdCUGRhOUlZM0RIZWREeFh4MWpBWGEx?=
 =?utf-8?B?TjhOa2FqUWd3dHJXbWJlYkhPREd3RHNrbkpYZ09NUHcxeWgwcUFCT0gveXlS?=
 =?utf-8?B?aFVJU3YrajdMeFN2V1I5LzdTeCtSSGt4RzR3WnlhS3g3K2ZtTVV6VmFRWGZ2?=
 =?utf-8?B?OTE1V3FLay9JdjRIaGRudGQyakoxTFdnbTZEdkNDZDRQbWtJeVYvUXUwV3pV?=
 =?utf-8?B?aHNOZ3Z2eVZERTlMRVJxSXg1OFlUVy9FSW5ETytiRis0aytvbEF3K0lKY29q?=
 =?utf-8?B?Z29IaVVlMm9QYTlmejFnUllrUnZZYWU4STFEL0hmak5mL3pHclpHOWNpckhT?=
 =?utf-8?B?bFpoemNHQTFSMUNBWWpWdG45M3Y2OHo5RHkxOUJ6THNwSEZCS25ZVnJkSG92?=
 =?utf-8?B?eFJiOUo3dmVqSGpJTmJDTzRKcStoOFN6VmZ3aHl6YVdWdkl6RXNIME9UNVVs?=
 =?utf-8?B?Q0tXSndkMXJyVFBoTm01R1QzTWdmOEVvbXVsV25ZaGpvSmtaSlByQnpHMXJQ?=
 =?utf-8?B?U0ZCaTVtQzFPWFkwT1ZHQUF6S2Q0QXFSRXc5dTlobGJtbFhya3JrdnRkYmxX?=
 =?utf-8?B?eWpZN29Vd29SVWpvWUEyaGluckNLUHd4OEl1ejM2SGRJM05pYzNnODRqVUxN?=
 =?utf-8?B?RkpOakFMYXJkbzVIUTJrczVCR1d6Y0c3dXJsUlZiZ29oZHpzdWRpdjluRlhG?=
 =?utf-8?B?Rmc3V20xSFJIdW1lMVFpMlV2ZUhabXZWUjA5VjZvcTFMbDlzemM1bnBDRXBL?=
 =?utf-8?B?Zkc5ODN1R0tIZHNIMGVPcWs1SXh3d2VCL0EzVHNWY2FuRlZVeWNRTEVSVGRJ?=
 =?utf-8?B?S08yd0JFaENLbjZYOTFNMWx4d1pNcTNlMVEvcGJRSGVLRkN5NGlLUlIvR2R0?=
 =?utf-8?B?TkpOSDJCMXBoaWkrWGJ1SnhIbWplMCtXWnBkclRPODlDTkF1MnNhdlZFZnFj?=
 =?utf-8?B?Z0I4dXlxMVZoUWJkQ2poL3AvbE1RQTNpUVd6M1dBbnYzc2QvSW1UYTRnQUZY?=
 =?utf-8?B?bCs4cnk4cmVYNnlqZEZDRjVvWVZFR0ZGOWpPTENUUUNUQWsycnlhek9nUjN3?=
 =?utf-8?B?UnM0SmtzcytjZk9BdGJjSEl3VGI2b3U0Q01Za0h4MlJ5blh6NWRVREpEQnkw?=
 =?utf-8?Q?cjortHAgkodwNL34hYI8Hdj2L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80f7bda-0450-4fc6-0b63-08dc27116d1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:44:58.0346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aju9LZpy4X4Xq4C6q7zua4k0tI57rxKhymG5b+yG57bZ64f4SdYbHdeuRzfgUDkmPS+6B/VmrV8fC4fdiQAapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
Received-SPF: softfail client-ip=40.107.223.62;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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


On 05/02/2024 21:49, Fabiano Rosas wrote:
> External email: Use caution opening links or attachments
>
>
> During multifd channel creation (multifd_send_new_channel_async) when
> TLS is enabled, the multifd_channel_connect function is called twice,
> once to create the TLS handshake thread and another time after the
> asynchrounous TLS handshake has finished.
>
> This creates a slightly confusing call stack where
> multifd_channel_connect() is called more times than the number of
> channels. It also splits error handling between the two callers of
> multifd_channel_connect() causing some code duplication. Lastly, it
> gets in the way of having a single point to determine whether all
> channel creation tasks have been initiated.
>
> Refactor the code to move the reentrancy one level up at the
> multifd_new_send_channel_async() level, de-duplicating the error
> handling and allowing for the next patch to introduce a
> synchronization point common to all the multifd channel creation,
> regardless of TLS.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/multifd.c | 73 +++++++++++++++++++--------------------------
>   1 file changed, 30 insertions(+), 43 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index cc10be2c3f..89d39fa67c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -869,30 +869,7 @@ out:
>       return NULL;
>   }
>
> -static bool multifd_channel_connect(MultiFDSendParams *p,
> -                                    QIOChannel *ioc,
> -                                    Error **errp);
> -
> -static void multifd_tls_outgoing_handshake(QIOTask *task,
> -                                           gpointer opaque)
> -{
> -    MultiFDSendParams *p = opaque;
> -    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
> -    Error *err = NULL;
> -
> -    if (!qio_task_propagate_error(task, &err)) {
> -        trace_multifd_tls_outgoing_handshake_complete(ioc);
> -        if (multifd_channel_connect(p, ioc, &err)) {
> -            return;
> -        }
> -    }
> -
> -    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
> -
> -    multifd_send_set_error(err);
> -    multifd_send_kick_main(p);
> -    error_free(err);
> -}
> +static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
>
>   static void *multifd_tls_handshake_thread(void *opaque)
>   {
> @@ -900,7 +877,7 @@ static void *multifd_tls_handshake_thread(void *opaque)
>       QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
>
>       qio_channel_tls_handshake(tioc,
> -                              multifd_tls_outgoing_handshake,
> +                              multifd_new_send_channel_async,
>                                 p,
>                                 NULL,
>                                 NULL);
> @@ -936,19 +913,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>                                       QIOChannel *ioc,
>                                       Error **errp)
>   {
> -    trace_multifd_set_outgoing_channel(
> -        ioc, object_get_typename(OBJECT(ioc)),
> -        migrate_get_current()->hostname);
> -
> -    if (migrate_channel_requires_tls_upgrade(ioc)) {
> -        /*
> -         * tls_channel_connect will call back to this
> -         * function after the TLS handshake,
> -         * so we mustn't call multifd_send_thread until then
> -         */
> -        return multifd_tls_channel_connect(p, ioc, errp);
> -    }
> -
>       migration_ioc_register_yank(ioc);
>       p->registered_yank = true;
>       p->c = ioc;
> @@ -959,20 +923,43 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>       return true;
>   }
>
> +/*
> + * When TLS is enabled this function is called once to establish the
> + * TLS connection and a second time after the TLS handshake to create
> + * the multifd channel. Without TLS it goes straight into the channel
> + * creation.
> + */
>   static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>   {
>       MultiFDSendParams *p = opaque;
>       QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>       Error *local_err = NULL;
>
> +    bool ret;
> +
>       trace_multifd_new_send_channel_async(p->id);
> -    if (!qio_task_propagate_error(task, &local_err)) {
> -        qio_channel_set_delay(ioc, false);
> -        if (multifd_channel_connect(p, ioc, &local_err)) {
> -            return;
> -        }
> +
> +    if (qio_task_propagate_error(task, &local_err)) {
> +        ret = false;
> +        goto out;
> +    }

I think this common error handling for both TLS/non-TLS is a bit 
problematic if there is an error in TLS handshake:
multifd_tls_channel_connect() sets p->c = QIO_CHANNEL(tioc).
TLS handshake fails.
multifd_new_send_channel_async() errors and calls 
object_unref(OBJECT(ioc)) which will result in freeing the IOC.
Then, multifd_send_terminate_threads() will try to access p->ioc because 
it's not NULL, causing a segfault.

> +
> +    qio_channel_set_delay(ioc, false);

Maybe qio_channel_set_delay() should be moved inside 
multifd_channel_connect()? It's called two times when TLS is used.

> +
> +    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
> +                                       migrate_get_current()->hostname);
> +
> +    if (migrate_channel_requires_tls_upgrade(ioc)) {
> +        ret = multifd_tls_channel_connect(p, ioc, &local_err);
> +    } else {
> +        ret = multifd_channel_connect(p, ioc, &local_err);
> +    }
> +
> +    if (ret) {
> +        return;
>       }
>
> +out:
>       trace_multifd_new_send_channel_async_error(p->id, local_err);
>       multifd_send_set_error(local_err);
>       multifd_send_kick_main(p);
> --
> 2.35.3
>

