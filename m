Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CCFF532CC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ymA-0004a7-8m; Fri, 27 Mar 2026 00:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w5ym8-0004Zk-DY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:26:24 -0400
Received: from mail-northcentralusazon11013052.outbound.protection.outlook.com
 ([40.107.201.52] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w5ym5-0005fa-DM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:26:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0ys+7eFvwrQESwvAZb9SN4gxaPEupRu3WhIMkZv8lRfjzcTn5uc6tto8KGJ5c985KYzcgswLZKAMBvcUaSbN4GIttuO+cX8yzf0of4iAyhgz9LHMFXaQj742QFLxdoAPYqU9vzaQvQTPmR5aKBd8jzI3ZG67VjF3jIAPDTL7trFj4o/LWsViiXRMSlejBiydJ5ySLW3TSgwf4OS3RxXEPAKbdeF1N3fWKp7iikz9PAOS4ixZIjPTuM7yC2GlRzJhiep3f5sMyex9uHvcw835sK4JnYt60XrstwOyuvATo5CZHIy+ytrATZmBTcqCyA9vFl3fI01u8NAcWDf1DQQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCOwg0+aKilgm+EWPPSnR8C0GvS2TNhqidxrFXXOsCk=;
 b=bNjiZCGqB9PHxmOMeey9mTtlutWK7z7QulVOB73waDvzA9fGz5jyEvcafnlKBFqn1+JQc0cjALPkkobTqa7KfNIRmWvEJF+/vOl6xek/ST2OLyLPhIF50xH0OHCW6vH7BoaxXzikms0p/3wWtK6UwnB4nqpTUTK5/cXITwS4jgXIHd7pBJEBJV24c90l/ZEUCPENVJGJRR9Ukl5sA+tQ2+0V5fEyOx8X/4W/u4Q7uJ85GhYIYnTxFdlLJsyUcff6hvv6y291sWpPyHDCP+Ww6G63YzuET8C2C7UhaklpAveaEnvzksO2w5Za7cP9FNr9sCL/fiRtpNX8Kd3Te7wSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCOwg0+aKilgm+EWPPSnR8C0GvS2TNhqidxrFXXOsCk=;
 b=1zfCIkSx54Zsc3JKxNAu4/MrltWo2NFQuiN/307GUZcRY8el7VymGEh6iMtVyJdrfsfEU+Q8Ns3T2KDK933hicvqIJKwA7blQ/lD4SG1FJ9q1T5pe7ELZvphY2xTqOcgHwgrZPvZTRBJhV1dlgA/xFz9OWfb/XJ0lIwuCFSJYWU=
Received: from DM6PR03CA0044.namprd03.prod.outlook.com (2603:10b6:5:100::21)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 04:21:11 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::3b) by DM6PR03CA0044.outlook.office365.com
 (2603:10b6:5:100::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 04:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 04:21:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 23:21:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 21:21:10 -0700
Received: from [10.67.184.128] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 23:21:08 -0500
Message-ID: <7251ce8a-d5d6-491d-b885-44e4424c8b3e@amd.com>
Date: Fri, 27 Mar 2026 12:21:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration/rdma: add x-rdma-chunk-size parameter
To: Markus Armbruster <armbru@redhat.com>, Samuel Zhang <guoqing.zhang@amd.com>
CC: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>,
 <lizhijian@fujitsu.com>, <eblake@redhat.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <PengJu.Zhou@amd.com>, <Qing.Ma@amd.com>
References: <20260316062308.1240426-1-guoqing.zhang@amd.com>
 <20260326025825.2427332-1-guoqing.zhang@amd.com>
 <87jyuzhybv.fsf@pond.sub.org>
Content-Language: en-US
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
In-Reply-To: <87jyuzhybv.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: b63f0b08-b512-4623-5e93-08de8bb8471f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ImigphvfFQ+cpjYZ2nhg+pDuR6r+/WOJiGyhG5wh6siZpvVCY+Kdy2wp2X+ZZaiRkGELUSl86rMikVjoNcyug9ARZznG4c3jF/OVhlnVjItjh9IcoMFL4lO3O5KDpUjUUGaM7gGDlHuhbujhpTIbE5dkW4/giqgZIwLiSSgTyuVBfiHNPNcXSiqODBnSCeShJMa2K8CGa3B3tkAWFWwUIdBEdK0mIj9G1XfARejYIXreH8AClPW/wd4SZi+I1VePbj1KajPD0yjcDMly7vtQOAzc4rdzNUvJ70xFNBj/Wh+nG7T2wEkJc/LzCXFpGu1mxgFwmKi8WNkpWqFw1U50rgL7lp+SRBEn/zzY+1h94zg7paqM5M0hBoVytDYH4+DPsRU5n7pbHKcaEBxLQjDv0fle7IrbIjaNShQS6NpxrnI+n1fO49RsDIPstNhC3ErUtOTD+mCUJ+T/1F93486VSR6P2VZrPep29RSedgf6UvfHZk/25rmeGU8UithasRgUw7GtY5qAEoYSWpth6zFXPk34unAbDR5fyGO0Ih8eksreeGZzPsXrvt60uUvCR3di49rsDllJHh7XDB8y054z3tld6/ujiCCE81fXO7M+Bd5t3D6X/pTrO/tBVocF3FRSswj4bK7UId0RQBMrRN10bwdZETBIzEIDu6ufRAbm57aKScCvt8p04ihdkLzc7nCEZMeCb/ul0lIrHcAhlplamO70amgY6Fy3TlTwiUsWZeNfbrhdCQvuynUZkRpp32Ae8vVyApThWQy8qywINuLmVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 60seuoIqeCza0AC7a5llB8g+naTLCd3hCSPm1/GCQnGIdNEraOEdMQbLyJDBkwYkpWp6kONcGYE/pPGaiOTXaAZbMVN3EPrK+q6F1JcZzIGSY6Uttjv4G8JztPZxur6PqVlUMiybza68kZag6tfy7P19dlxU2AOJLF/BIHIRZ3VhfODVJOAZnhAt0NXXDdCiNlNJfcjOT6rDd8F9Y9bcNy1Pi3Y/mHk9Pk+B8v3xCfcw/jIYIzHJdbka38jurcIPYyjyGGzqRDazQJU8d2GWKDkeBpaFwqgbWMjvN32vEUqOOn4VxVkAV5ZccucMcxoRTUHgZoPmIr5z+AN85WHpdrgnOueHU5TOXGfSgnIe9e3GzXbTnvyl14Wr33vqwNkHNrHoy+qrn+6soO+1rV67pkkzNK6AzjSiCiDi9Gc/8JxXz8MfV2qko5qUBzIOVIiY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:21:11.5919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63f0b08-b512-4623-5e93-08de8bb8471f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
Received-SPF: permerror client-ip=40.107.201.52;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2026/3/26 14:57, Markus Armbruster wrote:
> [You don't often get email from armbru@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> By convention, we don't post new patches in reply to old ones.  Next
> time :)
>
> Samuel Zhang <guoqing.zhang@amd.com> writes:
>
>> The default 1MB RDMA chunk size causes slow live migration because
>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>> 1MB chunk size produce ~15000 flushes vs ~3700 with 1024MB chunk size.
>>
>> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
>> faster migration.
>> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>>
>> Performance with RDMA live migration of 8GB RAM VM:
>>
>> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
>> |-----------------------|----------|-------------------|
>> | 1M (default)          | 37.915   |  1,007            |
>> | 32M                   | 17.880   |  2,260            |
>> | 1024M                 |  4.368   | 17,529            |
>>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>> ---
>> v2:
>> - Renamed x-rdma-chunk-shift to x-rdma-chunk-size (byte count)
>> - Added validation in migrate_params_check()
>> - Added hmp_migrate_set_parameter() support
>> - Added hmp_info_migrate_parameters() support
>> - Added migrate_mark_all_params_present()
>> - Use qemu_strtosz() for size suffix support
>>
>>   migration/migration-hmp-cmds.c | 17 +++++++++++++++++
>>   migration/options.c            | 32 +++++++++++++++++++++++++++++++-
>>   migration/options.h            |  1 +
>>   migration/rdma.c               | 30 ++++++++++++++++--------------
>>   qapi/migration.json            | 11 +++++++++--
>>   5 files changed, 74 insertions(+), 17 deletions(-)
>>
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 0a193b8f54..2c005c08a6 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -451,6 +451,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>                              params->direct_io ? "on" : "off");
>>           }
>>
>> +        if (params->has_x_rdma_chunk_size) {
>> +            monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
>> +                           MigrationParameter_str(
>> +                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
>> +                           params->x_rdma_chunk_size);
>> +        }
>> +
>>           assert(params->has_cpr_exec_command);
>>           monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
>>       }
>> @@ -730,6 +737,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>           p->has_mode = true;
>>           visit_type_MigMode(v, param, &p->mode, &err);
>>           break;
>> +    case MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE:
>> +        p->has_x_rdma_chunk_size = true;
>> +        ret = qemu_strtosz(valuestr, NULL, &valuebw);
> We use several variations of the conversion to size:
>
>                         default          examples
> function                suffix  scale     "1"         "64K"
> -----------------------------------------------------------
> qemu_strtosz()             B     1024      1        64*1024
> qemu_strtosz_MiB()         M     1024   1024*1024   64*1024
> qemu_strtosz_metric()      B     1000      1        64*1000
>
> Unfortunate complication of the user interface if you ask me, but
> changing it now is likely a bad idea.  My point is: which one to use
> here?
>
> This function uses two: qemu_strtosz_MiB() directly, and qemu_strtosz()
> via visit_type_size().
>
> Unless you have a specific reason to want default suffix 'M', use
> visit_type_size(), it's less code, and the error reporting is better.
>
>
>> +        if (ret != 0 || valuebw < (1<<20) || valuebw > (1<<30)
>> +            || !is_power_of_2(valuebw)) {
>> +            error_setg(&err, "Invalid size %s", valuestr);
>> +            break;
>> +        }
> This is partly redundant with the checking in migrate_params_check().
>
> If you use visit_type_size(), you don't need it at all.
>
> If you use qemu_strtosz_MiB(), you should check less.  Have a look at
> the other uses in this function.
>
>> +        p->x_rdma_chunk_size = valuebw;
>> +        break;
>>       case MIGRATION_PARAMETER_DIRECT_IO:
>>           p->has_direct_io = true;
>>           visit_type_bool(v, param, &p->direct_io, &err);
>> diff --git a/migration/options.c b/migration/options.c
>> index f33b297929..91dd874b5e 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -90,6 +90,7 @@ const PropertyInfo qdev_prop_StrOrNull;
>>
>>   #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>>   #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>> +#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           (1<<20) /* 1MB */
>>
>>   const Property migration_properties[] = {
>>       DEFINE_PROP_BOOL("store-global-state", MigrationState,
>> @@ -183,6 +184,9 @@ const Property migration_properties[] = {
>>       DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
>>                          parameters.zero_page_detection,
>>                          ZERO_PAGE_DETECTION_MULTIFD),
>> +    DEFINE_PROP_UINT64("x-rdma-chunk-size", MigrationState,
>> +                      parameters.x_rdma_chunk_size,
>> +                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE),
>>
>>       /* Migration capabilities */
>>       DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>> @@ -993,6 +997,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
>>       return s->parameters.zero_page_detection;
>>   }
>>
>> +uint64_t migrate_rdma_chunk_size(void)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +    uint64_t size = s->parameters.x_rdma_chunk_size;
>> +
>> +    assert((1<<20) <= size && size <= (1<<30) && is_power_of_2(size));
> Suggest MiB <= size && size <= GiB.
>
>> +    return size;
>> +}
>> +
>>   /* parameters helpers */
>>
>>   AnnounceParameters *migrate_announce_params(void)
>> @@ -1055,7 +1068,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
>>           &p->has_announce_step, &p->has_block_bitmap_mapping,
>>           &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
>>           &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
>> -        &p->has_cpr_exec_command,
>> +        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
>>       };
>>
>>       len = ARRAY_SIZE(has_fields);
>> @@ -1227,6 +1240,15 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>>           return false;
>>       }
>>
>> +    if (params->has_x_rdma_chunk_size &&
>> +        (params->x_rdma_chunk_size < (1<<20) ||
>> +         params->x_rdma_chunk_size > (1<<30) ||
> Suggest < MiB and > GiB.
>
>> +         !is_power_of_2(params->x_rdma_chunk_size))) {
>> +        error_setg(errp, "Option x_rdma_chunk_size expects "
>> +                   "a power of 2 in the range 1M to 1024M");
>> +        return false;
>> +    }
>> +
>>       if (!check_dirty_bitmap_mig_alias_map(params->block_bitmap_mapping, errp)) {
>>           error_prepend(errp, "Invalid mapping given for block-bitmap-mapping: ");
>>           return false;
>> @@ -1391,6 +1413,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
>>           dest->direct_io = params->direct_io;
>>       }
>>
>> +    if (params->has_x_rdma_chunk_size) {
>> +        dest->x_rdma_chunk_size = params->x_rdma_chunk_size;
>> +    }
>> +
>>       if (params->has_cpr_exec_command) {
>>           dest->cpr_exec_command = params->cpr_exec_command;
>>       }
>> @@ -1517,6 +1543,10 @@ static void migrate_params_apply(MigrationParameters *params)
>>           s->parameters.direct_io = params->direct_io;
>>       }
>>
>> +    if (params->has_x_rdma_chunk_size) {
>> +        s->parameters.x_rdma_chunk_size = params->x_rdma_chunk_size;
>> +    }
>> +
>>       if (params->has_cpr_exec_command) {
>>           qapi_free_strList(s->parameters.cpr_exec_command);
>>           s->parameters.cpr_exec_command =
>> diff --git a/migration/options.h b/migration/options.h
>> index b502871097..b46221998a 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -87,6 +87,7 @@ const char *migrate_tls_creds(void);
>>   const char *migrate_tls_hostname(void);
>>   uint64_t migrate_xbzrle_cache_size(void);
>>   ZeroPageDetection migrate_zero_page_detection(void);
>> +uint64_t migrate_rdma_chunk_size(void);
>>
>>   /* parameters helpers */
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 55ab85650a..3e37a1d440 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -45,10 +45,12 @@
>>   #define RDMA_RESOLVE_TIMEOUT_MS 10000
>>
>>   /* Do not merge data if larger than this. */
>> -#define RDMA_MERGE_MAX (2 * 1024 * 1024)
>> -#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
>> +static inline uint64_t rdma_merge_max(void)
>> +{
>> +    return migrate_rdma_chunk_size() * 2;
>> +}
>>
>> -#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
>> +#define RDMA_SIGNALED_SEND_MAX 512
>>
>>   /*
>>    * This is only for non-live state being migrated.
>> @@ -527,21 +529,21 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
>>   static inline uint64_t ram_chunk_index(const uint8_t *start,
>>                                          const uint8_t *host)
>>   {
>> -    return ((uintptr_t) host - (uintptr_t) start) >> RDMA_REG_CHUNK_SHIFT;
>> +    return ((uintptr_t) host - (uintptr_t) start) / migrate_rdma_chunk_size();
> Double-checking: this function isn't speed-critical, correct?


It's not. it is called once per chunk during live-migration. And no 
performance change is observed when comparing with original implementation.

Should I change it to `>> ctz64(migrate_rdma_chunk_size())` ?


>
>>   }
>>
>>   static inline uint8_t *ram_chunk_start(const RDMALocalBlock *rdma_ram_block,
>>                                          uint64_t i)
>>   {
>>       return (uint8_t *)(uintptr_t)(rdma_ram_block->local_host_addr +
>> -                                  (i << RDMA_REG_CHUNK_SHIFT));
>> +                                  (i * migrate_rdma_chunk_size()));
>>   }
>>
>>   static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_block,
>>                                        uint64_t i)
>>   {
>>       uint8_t *result = ram_chunk_start(rdma_ram_block, i) +
>> -                                         (1UL << RDMA_REG_CHUNK_SHIFT);
>> +                                         migrate_rdma_chunk_size();
>>
>>       if (result > (rdma_ram_block->local_host_addr + rdma_ram_block->length)) {
>>           result = rdma_ram_block->local_host_addr + rdma_ram_block->length;
>> @@ -1841,6 +1843,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>>       struct ibv_send_wr *bad_wr;
>>       int reg_result_idx, ret, count = 0;
>>       uint64_t chunk, chunks;
>> +    uint64_t chunk_size = migrate_rdma_chunk_size();
>>       uint8_t *chunk_start, *chunk_end;
>>       RDMALocalBlock *block = &(rdma->local_ram_blocks.block[current_index]);
>>       RDMARegister reg;
>> @@ -1861,22 +1864,21 @@ retry:
>>       chunk_start = ram_chunk_start(block, chunk);
>>
>>       if (block->is_ram_block) {
>> -        chunks = length / (1UL << RDMA_REG_CHUNK_SHIFT);
>> +        chunks = length / chunk_size;
>>
>> -        if (chunks && ((length % (1UL << RDMA_REG_CHUNK_SHIFT)) == 0)) {
>> +        if (chunks && ((length % chunk_size) == 0)) {
>>               chunks--;
>>           }
>>       } else {
>> -        chunks = block->length / (1UL << RDMA_REG_CHUNK_SHIFT);
>> +        chunks = block->length / chunk_size;
>>
>> -        if (chunks && ((block->length % (1UL << RDMA_REG_CHUNK_SHIFT)) == 0)) {
>> +        if (chunks && ((block->length % chunk_size) == 0)) {
>>               chunks--;
>>           }
>>       }
>>
>>       trace_qemu_rdma_write_one_top(chunks + 1,
>> -                                  (chunks + 1) *
>> -                                  (1UL << RDMA_REG_CHUNK_SHIFT) / 1024 / 1024);
>> +                                  (chunks + 1) * chunk_size / 1024 / 1024);
>>
>>       chunk_end = ram_chunk_end(block, chunk + chunks);
>>
>> @@ -2176,7 +2178,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
>>       rdma->current_length += len;
>>
>>       /* flush it if buffer is too large */
>> -    if (rdma->current_length >= RDMA_MERGE_MAX) {
>> +    if (rdma->current_length >= rdma_merge_max()) {
>>           return qemu_rdma_write_flush(rdma, errp);
>>       }
>>
>> @@ -3522,7 +3524,7 @@ int rdma_registration_handle(QEMUFile *f)
>>                   } else {
>>                       chunk = reg->key.chunk;
>>                       host_addr = block->local_host_addr +
>> -                        (reg->key.chunk * (1UL << RDMA_REG_CHUNK_SHIFT));
>> +                        (reg->key.chunk * migrate_rdma_chunk_size());
>>                       /* Check for particularly bad chunk value */
>>                       if (host_addr < (void *)block->local_host_addr) {
>>                           error_report("rdma: bad chunk for block %s"
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 7134d4ce47..94d2c1c65f 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -806,7 +806,7 @@
>>   #
>>   # Features:
>>   #
>> -# @unstable: Members @x-checkpoint-delay and
>> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>>   #     @x-vcpu-dirty-limit-period are experimental.
>>   #
>>   # Since: 2.4
>> @@ -831,6 +831,7 @@
>>              'mode',
>>              'zero-page-detection',
>>              'direct-io',
>> +           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>>              'cpr-exec-command'] }
>>
>>   ##
>> @@ -1007,9 +1008,13 @@
>>   #     is @cpr-exec.  The first list element is the program's filename,
>>   #     the remainder its arguments.  (Since 10.2)
>>   #
>> +# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
>> +#     Default is 1M.  Must be a power of 2 in the range [1M, 1024M].
> Let's use 1MiB and 1024MiB for extra clarity.
>
>> +#     Only takes effect for RDMA migration.  (Since 11.1)
>> +#
>>   # Features:
>>   #
>> -# @unstable: Members @x-checkpoint-delay and
>> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>>   #     @x-vcpu-dirty-limit-period are experimental.
>>   #
>>   # Since: 2.4
>> @@ -1046,6 +1051,8 @@
>>               '*mode': 'MigMode',
>>               '*zero-page-detection': 'ZeroPageDetection',
>>               '*direct-io': 'bool',
>> +            '*x-rdma-chunk-size': { 'type': 'uint64',
>> +                                    'features': [ 'unstable' ] },
>>               '*cpr-exec-command': [ 'str' ]} }
>>
>>   ##

