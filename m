Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B811093172
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3RiM-0007r5-Ke; Fri, 20 Mar 2026 00:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w3Qml-0002d1-OT
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 23:44:31 -0400
Received: from mail-westcentralusazon11010057.outbound.protection.outlook.com
 ([40.93.198.57] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w3Qmj-0005uM-6d
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 23:44:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWgBXc/MX/qtykUxwEAX3qQXyHRzwrh3GH++JwylVRSGx5ZghV1/BVscQxCjIdSS6yz8TrN8ouVO+yBewiipp3u/EvdDy0UfONL5HdB20HzpsJqswBjwCFA1n0nH42wQwVZReQD6NFgkMSoxRHHL025cMZkUl17KI8u/wV/udErYRP2SDLfU+cZGTFKfwiLeDroq3pun7j1bN/iU39Ie9unzKHMN42ELyaMh1TRqT/80w7Lhj5HJJGi9YjIaP0q9SYQKxcnCiWeEMY75n434mfqi38XWeoWwEBctzoN5gXMz/bxR56Q4jbsOQiJ7Ygsa1kn/Jd0ItBJX39nvtAkGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSN030Y/7jZsQu7CHh0kR+oKv28ZOlT2EsQmaEiHztQ=;
 b=kMWW+dydKQQePK52ynGp8q4A4xVlRwk6wTbMeWBm1T/FL1vICDQO/KrZ3LG4rqwdO8cF6Npw6BoxNJpGNFJl7oha7qgmUCJzKooigKN4mcjG6eDsU7dVwqeFfhArXNvNaiRdNuuuvpbQLP7wP6fsTYRaAx0/0wgLhNJliUNxVx7S/GP+vBwS9pqDzoIrAOe3KvYBXsNlGVUK6RK+Cg74mORnX5jZKmdwiUoUbEVRQyH7QGz/9c3vUcznDo9ZiZf71HKJBtvupUlnYA+XP8NSJdBAuVYhl3u8h6cdFqjfRmv/R2eavozixObdWuVg/p3hZyVEc1asubiZiAoKUBAJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSN030Y/7jZsQu7CHh0kR+oKv28ZOlT2EsQmaEiHztQ=;
 b=bIVtwInnbtwY2VPXe5aqp+AXUslvrci3cAJhKCtQ5csHlkFlAM3+aqiau9xYoN4iV6SAIA8B+Fvae/YPLKtC5lEs7Vn0cuYVp5oMa004NCXDHtKgLirEUvi1Fq5bj4dS1yRm04pESpjrnDwJjhUD3ZjgBHD3xHVHeP9HkFnOgOs=
Received: from SJ0PR13CA0013.namprd13.prod.outlook.com (2603:10b6:a03:2c0::18)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 03:39:16 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::25) by SJ0PR13CA0013.outlook.office365.com
 (2603:10b6:a03:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 03:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 03:39:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 22:39:15 -0500
Received: from [10.67.184.128] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Mar 2026 22:39:13 -0500
Message-ID: <8a8a7325-0356-4113-b929-60b9941f8e5f@amd.com>
Date: Fri, 20 Mar 2026 11:39:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
Subject: Re: [PATCH] migration/rdma: add x-rdma-chunk-shift parameter
To: Markus Armbruster <armbru@redhat.com>, Samuel Zhang <guoqing.zhang@amd.com>
CC: <qemu-devel@nongnu.org>, <Emily.Deng@amd.com>, <PengJu.Zhou@amd.com>
References: <20260316062308.1240426-1-guoqing.zhang@amd.com>
 <874imcciht.fsf@pond.sub.org>
Content-Language: en-US
In-Reply-To: <874imcciht.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aed0773-8f50-4351-72de-08de8632429d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007|56012099003|7053199007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wJlgIN3gpqpHd6rgOHdqNMUp9eJfGYR8NRpnHzcOdLOFhCdRTEGkpEJ2/8KBP0v6SfMop+EkeHZ/xJOTXoEFHbqArT5pl2/x8IBId5xDJcL3Hen0dxBxt5gZmGDMd2+Vhd1ElbtU5JXJekJZX566LOdrTVBzOUQUk+56zlEZX11Z/5QoLDq+QGtff0gdgEulGZp0J7lcqczrnjLuysGm0pb+K9BwoRWSFSkASoT0MKHVV+y8yFd8FqefnlgbC1E5mzBjJ1lyyC4P/Xfyk/gWlAKfS4p07LTgH5GWAWqaLfxiCKAWS7h4QEJiIXsSnyDzq85Zmnd11WsmT+fVPqein7svZ2M+l8sLEBZ43CxbXxZl753dXPKfy5HQgAF5ksEWooJeW/Vy7oSTsuBCbUw34y/dDHCFvvqBW/Ef4Al92v5C0Z6Bur+NdQKQKjql69Lhas4edaJKieXQTWWC+c2uclOZ8/sZPbCPBzz5HTIAP1a7hpUMkYJU91tClEbPwjeTI2aNUu5VqhTXr6vuD6+bPW+Q6lB1WjcHkilZu5LKrJbNAwtF+mRw/cynOvDZ6L/ejB6KjfMxhgfYFVgAvKd0wVosJu32Wt2Wa2T8v7CB6r+5c3sdp9gBHNyuQJjN1U4nmQi3uRcihXoxDt+y/gwnvTA27t+b8GBaHsbPayfOykmDrW/HWPp1dPJWlWQ1L3i0dkLaAcPaC16NuWgLjnvbo2MLF/V94qkmN7c/7xebUwIyeHDYMIQpAIU7ymuPykXFHuT6vIAQE8OgcodSMQvy/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(56012099003)(7053199007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qzD0ap03/6VvjBJLFZ6K0hW5dejIxTq0xr7CwNln69RkrDxCVbc+P99zvTg21Ix/maHUUDyM5HG0qPBfmWxX+NeP2xnAEi8Z6SOfKFZ8+Dq7Jhnj/jADWEHqy907+wi6Rn12oMJijAIA+tjZ8ZBT1wrDD46z0ULi1PR60h2erppWD0/2NSrGyVTbiMylPs1TIhv5dVe84LxlUVxZWgSwH0VfkjlpVagscsORciK1WHnDao3xLd9SplINExnLkjO3Z7bacCan0TQvHYTSiW/hIzKIfXmhZvnREdxqJe7NmuGeENvw1i4rgkv3sTXTDEVwE1O0y+T6y30RgHjV0qGtmlYqpoiVNEocakkglFmefgZyQryoTCN+li2X8OxmSWeT5LgP22ry0nXR5qE6DwAkxc9IFLoEZCRuFfCZnMpdg7NcnEa7RQE+lngiukx2HiZv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 03:39:15.6593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aed0773-8f50-4351-72de-08de8632429d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
Received-SPF: permerror client-ip=40.93.198.57;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:43:57 -0400
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

Hi Markus,

Thank you for your feedback. Please see my replies inline.

Regards
Sam


On 2026/3/19 16:48, Markus Armbruster wrote:
> [You don't often get email fromarmbru@redhat.com. Learn why this is important athttps://aka.ms/LearnAboutSenderIdentification ]
>
> Samuel Zhang<guoqing.zhang@amd.com> writes:
>
>> The default 1MB RDMA chunk size causes slow live migration because
>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>> 1MB chunks produce ~15000 flushes vs ~3700 with 1GB chunks.
>>
>> Add x-rdma-chunk-shift parameter to configure the RDMA chunk size
>> (2^N bytes) for faster migration.
>> Usage: -global migration.x-rdma-chunk-shift=30
>>
>> Performance with RDMA live migration of 8GB RAM VM:
>>
>> | x-rdma-chunk-shift | chunk size | time (s) | throughput (Mbps) |
>> |--------------------|------------|----------|-------------------|
>> | 20 (default)       | 1 MB       | 37.915   | 1,007             |
>> | 25                 | 32 MB      | 17.880   | 2,260             |
>> | 30                 | 1 GB       |  4.368   | 17,529            |
>>
>> Signed-off-by: Samuel Zhang<guoqing.zhang@amd.com>
>> ---
>>   migration/options.c | 13 +++++++++++++
>>   migration/options.h |  1 +
>>   migration/rdma.c    | 37 ++++++++++++++++++++++---------------
>>   qapi/migration.json |  9 ++++++++-
>>   4 files changed, 44 insertions(+), 16 deletions(-)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index f33b297929..1503ae35a2 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -90,6 +90,7 @@ const PropertyInfo qdev_prop_StrOrNull;
>>
>>   #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>>   #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>> +#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SHIFT          20      /* 1MB */
>>
>>   const Property migration_properties[] = {
>>       DEFINE_PROP_BOOL("store-global-state", MigrationState,
>> @@ -183,6 +184,9 @@ const Property migration_properties[] = {
>>       DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
>>                          parameters.zero_page_detection,
>>                          ZERO_PAGE_DETECTION_MULTIFD),
>> +    DEFINE_PROP_UINT8("x-rdma-chunk-shift", MigrationState,
>> +                      parameters.x_rdma_chunk_shift,
>> +                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SHIFT),
>>
>>       /* Migration capabilities */
>>       DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>> @@ -993,6 +997,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
>>       return s->parameters.zero_page_detection;
>>   }
>>
>> +uint8_t migrate_rdma_chunk_shift(void)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +    uint8_t chunk_shift = s->parameters.x_rdma_chunk_shift;
>> +
>> +    assert(20 <= chunk_shift && chunk_shift <= 30);
> Where is this ensured?

It is ensured just here.

The chunk_shift is provided by user when starting qemu process.

`-global migration.x-rdma-chunk-shift=30`

Valid range is [20, 30], if user provided an invalid value, assert will 
fail and qemu will exit with error logs.

I don't know any better places to validate the value. Any suggestions on 
this? Thank you!


>> +    return chunk_shift;
>> +}
>> +
>>   /* parameters helpers */
>>
>>   AnnounceParameters *migrate_announce_params(void)
>> diff --git a/migration/options.h b/migration/options.h
>> index b502871097..3f214465a3 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -87,6 +87,7 @@ const char *migrate_tls_creds(void);
>>   const char *migrate_tls_hostname(void);
>>   uint64_t migrate_xbzrle_cache_size(void);
>>   ZeroPageDetection migrate_zero_page_detection(void);
>> +uint8_t migrate_rdma_chunk_shift(void);
>>
>>   /* parameters helpers */
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 55ab85650a..d914a7cd3b 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -44,11 +44,18 @@
>>
>>   #define RDMA_RESOLVE_TIMEOUT_MS 10000
>>
>> -/* Do not merge data if larger than this. */
>> -#define RDMA_MERGE_MAX (2 * 1024 * 1024)
>> -#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
>> +#define RDMA_SIGNALED_SEND_MAX 512
>> +
>> +static inline uint64_t rdma_chunk_size(void)
>> +{
>> +    return 1UL << migrate_rdma_chunk_shift();
>> +}
>>
>> -#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
>> +/* Do not merge data if larger than this. */
>> +static inline uint64_t rdma_merge_max(void)
>> +{
>> +    return rdma_chunk_size() * 2;
>> +}
>>
>>   /*
>>    * This is only for non-live state being migrated.
>> @@ -527,21 +534,21 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
>>   static inline uint64_t ram_chunk_index(const uint8_t *start,
>>                                          const uint8_t *host)
>>   {
>> -    return ((uintptr_t) host - (uintptr_t) start) >> RDMA_REG_CHUNK_SHIFT;
>> +    return ((uintptr_t) host - (uintptr_t) start) >> migrate_rdma_chunk_shift();
>>   }
>>
>>   static inline uint8_t *ram_chunk_start(const RDMALocalBlock *rdma_ram_block,
>>                                          uint64_t i)
>>   {
>>       return (uint8_t *)(uintptr_t)(rdma_ram_block->local_host_addr +
>> -                                  (i << RDMA_REG_CHUNK_SHIFT));
>> +                                  (i << migrate_rdma_chunk_shift()));
>>   }
>>
>>   static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_block,
>>                                        uint64_t i)
>>   {
>>       uint8_t *result = ram_chunk_start(rdma_ram_block, i) +
>> -                                         (1UL << RDMA_REG_CHUNK_SHIFT);
>> +                                         rdma_chunk_size();
>>
>>       if (result > (rdma_ram_block->local_host_addr + rdma_ram_block->length)) {
>>           result = rdma_ram_block->local_host_addr + rdma_ram_block->length;
>> @@ -1841,6 +1848,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>>       struct ibv_send_wr *bad_wr;
>>       int reg_result_idx, ret, count = 0;
>>       uint64_t chunk, chunks;
>> +    uint64_t chunk_size = rdma_chunk_size();
>>       uint8_t *chunk_start, *chunk_end;
>>       RDMALocalBlock *block = &(rdma->local_ram_blocks.block[current_index]);
>>       RDMARegister reg;
>> @@ -1861,22 +1869,21 @@ retry:
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
>> @@ -2176,7 +2183,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
>>       rdma->current_length += len;
>>
>>       /* flush it if buffer is too large */
>> -    if (rdma->current_length >= RDMA_MERGE_MAX) {
>> +    if (rdma->current_length >= rdma_merge_max()) {
>>           return qemu_rdma_write_flush(rdma, errp);
>>       }
>>
>> @@ -3522,7 +3529,7 @@ int rdma_registration_handle(QEMUFile *f)
>>                   } else {
>>                       chunk = reg->key.chunk;
>>                       host_addr = block->local_host_addr +
>> -                        (reg->key.chunk * (1UL << RDMA_REG_CHUNK_SHIFT));
>> +                        (reg->key.chunk * rdma_chunk_size());
>>                       /* Check for particularly bad chunk value */
>>                       if (host_addr < (void *)block->local_host_addr) {
>>                           error_report("rdma: bad chunk for block %s"
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 7134d4ce47..0521bf3d69 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1007,9 +1007,14 @@
>>   #     is @cpr-exec.  The first list element is the program's filename,
>>   #     the remainder its arguments.  (Since 10.2)
>>   #
>> +# @x-rdma-chunk-shift: RDMA memory registration chunk shift.
>> +#     The chunk size is 2^N bytes where N is the value.
> The value of what?  Oh, the value of @x-rdma-chunk-shift.
>
> Acceptable range?  I doubt 0 or 255 work :)

The valid range is [20, 30]. 20 is the default/original value. 30 is the 
largest value working on my servers with Mellanox RDMA NIC.


> Would this be easier to document if we make it a byte count
> @x-rdma-chunk-size, must be a power of two?

Switch to byte count will be easier to document, but the user may find 
it a bit harder to use.

`-global migration.x-rdma-chunk-size=1073741824`

The valid range is [1048576, 1073741824] and it should be power of 2.


Do you prefer `x-rdma-chunk-size`? If yes, I will make the switch in v2 
patch.


>> +#     Defaults to 20 (1 MiB).  Only takes effect for RDMA migration.
>> +#     (Since 10.2)
> 11.0 right now, but realistically 11.1.

OK. I will update it in v2 patch.


>> +#
>>   # Features:
>>   #
>> -# @unstable: Members @x-checkpoint-delay and
>> +# @unstable: Members @x-rdma-chunk-shift, @x-checkpoint-delay and
>>   #     @x-vcpu-dirty-limit-period are experimental.
> Keep the list of members sorted:
>
>     # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-shift, and
>     #     @x-vcpu-dirty-limit-period are experimental.


OK. I will update it in v2 patch.


>
>>   #
>>   # Since: 2.4
>> @@ -1045,6 +1050,8 @@
>>               '*vcpu-dirty-limit': 'uint64',
>>               '*mode': 'MigMode',
>>               '*zero-page-detection': 'ZeroPageDetection',
>> +            '*x-rdma-chunk-shift': { 'type': 'uint8',
>> +                                     'features': [ 'unstable' ] },
>>               '*direct-io': 'bool',
>>               '*cpr-exec-command': [ 'str' ]} }

