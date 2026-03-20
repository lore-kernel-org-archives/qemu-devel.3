Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D951093182
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3UVG-0002EU-PR; Fri, 20 Mar 2026 03:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3UVE-0002E6-FJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3UVB-0002CN-4U
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773992555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjujA0I13C0rpqWw71s6dO0iuhxxKitU1tRacONt468=;
 b=SHinlFjo5FE+bL5RcTTQ2CWwFQsshmOmPb/kALjh18eENMC4T+9jVAbSTpZIVbhWZbjbGK
 AFQhSQ1PfDO6EKHy+qjncnY2Xocl2M11pn3zvV3QlCcEcPfOlP9Xp/HguxY0Y1/VBgIq/y
 DEDd+qn6sqZj37hQWtZI07GnK9g1vok=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-hxj6BzZPOGazS4x5drcXPw-1; Fri,
 20 Mar 2026 03:42:31 -0400
X-MC-Unique: hxj6BzZPOGazS4x5drcXPw-1
X-Mimecast-MFC-AGG-ID: hxj6BzZPOGazS4x5drcXPw_1773992550
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C582418005B6; Fri, 20 Mar 2026 07:42:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F400230001A1; Fri, 20 Mar 2026 07:42:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB66A21E6937; Fri, 20 Mar 2026 08:42:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,  <qemu-devel@nongnu.org>,
 <Emily.Deng@amd.com>,  <PengJu.Zhou@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Li
 Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH] migration/rdma: add x-rdma-chunk-shift parameter
In-Reply-To: <8a8a7325-0356-4113-b929-60b9941f8e5f@amd.com> (GuoQing Zhang's
 message of "Fri, 20 Mar 2026 11:39:13 +0800")
References: <20260316062308.1240426-1-guoqing.zhang@amd.com>
 <874imcciht.fsf@pond.sub.org>
 <8a8a7325-0356-4113-b929-60b9941f8e5f@amd.com>
Date: Fri, 20 Mar 2026 08:42:26 +0100
Message-ID: <87ikarj6al.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I just realized you neglected to cc: migration maintainers.  I'm fixing
that for you.  You can use scripts/get_maintainer *patch to find
maintainers you might want to cc:.

"Zhang, GuoQing (Sam)" <guoqzhan@amd.com> writes:

> Hi=C2=A0Markus,
>
> Thank you for your feedback. Please see my replies inline.
>
> Regards
> Sam
>
>
> On 2026/3/19 16:48, Markus Armbruster wrote:

[...]

>> Samuel Zhang<guoqing.zhang@amd.com> writes:
>>
>>> The default 1MB RDMA chunk size causes slow live migration because
>>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>>> 1MB chunks produce ~15000 flushes vs ~3700 with 1GB chunks.
>>>
>>> Add x-rdma-chunk-shift parameter to configure the RDMA chunk size
>>> (2^N bytes) for faster migration.
>>> Usage: -global migration.x-rdma-chunk-shift=3D30

Does monitor command migrate-set-parameters work?  Testing...  it's
accepted:

    { "execute": "migrate-set-parameters", "arguments": { "x-rdma-chunk-shi=
ft": 30 } }
    {"return": {}}

Didn't test it actually works.

However, query-migrate-parameters does not show the new parameter.
Needs fixing.  See migrate_mark_all_params_present().

Also missing: update to hmp_migrate_set_parameter() and
hmp_info_migrate_parameters().

Friends don't let friends use -global unless there is no other way.

>>> Performance with RDMA live migration of 8GB RAM VM:
>>>
>>> | x-rdma-chunk-shift | chunk size | time (s) | throughput (Mbps) |
>>> |--------------------|------------|----------|-------------------|
>>> | 20 (default)       | 1 MB       | 37.915   | 1,007             |
>>> | 25                 | 32 MB      | 17.880   | 2,260             |
>>> | 30                 | 1 GB       |  4.368   | 17,529            |
>>>
>>> Signed-off-by: Samuel Zhang<guoqing.zhang@amd.com>
>>> ---
>>>  migration/options.c | 13 +++++++++++++
>>>  migration/options.h |  1 +
>>>  migration/rdma.c    | 37 ++++++++++++++++++++++---------------
>>>  qapi/migration.json |  9 ++++++++-
>>>  4 files changed, 44 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/migration/options.c b/migration/options.c
>>> index f33b297929..1503ae35a2 100644
>>> --- a/migration/options.c
>>> +++ b/migration/options.c
>>> @@ -90,6 +90,7 @@ const PropertyInfo qdev_prop_StrOrNull;
>>>
>>>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* millise=
conds */
>>>  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>>> +#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SHIFT          20      /* 1MB */
>>>
>>>  const Property migration_properties[] =3D {
>>>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
>>> @@ -183,6 +184,9 @@ const Property migration_properties[] =3D {
>>>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationSt=
ate,
>>>                         parameters.zero_page_detection,
>>>                         ZERO_PAGE_DETECTION_MULTIFD),
>>> +    DEFINE_PROP_UINT8("x-rdma-chunk-shift", MigrationState,
>>> +                      parameters.x_rdma_chunk_shift,
>>> +                      DEFAULT_MIGRATE_X_RDMA_CHUNK_SHIFT),
>>>
>>>      /* Migration capabilities */
>>>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>>> @@ -993,6 +997,15 @@ ZeroPageDetection migrate_zero_page_detection(void)
>>>      return s->parameters.zero_page_detection;
>>>  }
>>>
>>> +uint8_t migrate_rdma_chunk_shift(void)
>>> +{
>>> +    MigrationState *s =3D migrate_get_current();
>>> +    uint8_t chunk_shift =3D s->parameters.x_rdma_chunk_shift;
>>> +
>>> +    assert(20 <=3D chunk_shift && chunk_shift <=3D 30);
>>
>> Where is this ensured?
>
> It is ensured just here.

So, invalid configuration will be accepted, the VM starts, and when you
try to migrate it, it crashes.  Potential data loss.

Crashing on bad input is always wrong.

Always, always, always test with bad input, too.

I caught in in review this time, but it could've slipped through easily.
Dangerous.

> The chunk_shift is provided by user when starting qemu process.
>
> `-global migration.x-rdma-chunk-shift=3D30`
>
> Valid range is [20, 30], if user provided an invalid value, assert will f=
ail and qemu will exit with error logs.
>
> I don't know any better places to validate the value. Any suggestions on =
this? Thank you!

It's perfectly fine not to know things!  Just ask then.

@x-rdma-chunk-shift is a member of MigrationParameters.  The other
members are validated migrate_params_check().  Try doing the same for
@x-rdma-chunk-shift.

>>> +    return chunk_shift;
>>> +}
>>> +
>>>  /* parameters helpers */
>>>
>>>  AnnounceParameters *migrate_announce_params(void)
>>> diff --git a/migration/options.h b/migration/options.h
>>> index b502871097..3f214465a3 100644
>>> --- a/migration/options.h
>>> +++ b/migration/options.h
>>> @@ -87,6 +87,7 @@ const char *migrate_tls_creds(void);
>>>  const char *migrate_tls_hostname(void);
>>>  uint64_t migrate_xbzrle_cache_size(void);
>>>  ZeroPageDetection migrate_zero_page_detection(void);
>>> +uint8_t migrate_rdma_chunk_shift(void);
>>>
>>>  /* parameters helpers */
>>>
>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>> index 55ab85650a..d914a7cd3b 100644
>>> --- a/migration/rdma.c
>>> +++ b/migration/rdma.c
>>> @@ -44,11 +44,18 @@
>>>
>>>  #define RDMA_RESOLVE_TIMEOUT_MS 10000
>>>
>>> -/* Do not merge data if larger than this. */
>>> -#define RDMA_MERGE_MAX (2 * 1024 * 1024)
>>> -#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
>>> +#define RDMA_SIGNALED_SEND_MAX 512
>>> +
>>> +static inline uint64_t rdma_chunk_size(void)
>>> +{
>>> +    return 1UL << migrate_rdma_chunk_shift();
>>> +}
>>>
>>> -#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
>>> +/* Do not merge data if larger than this. */
>>> +static inline uint64_t rdma_merge_max(void)
>>> +{
>>> +    return rdma_chunk_size() * 2;
>>> +}
>>>
>>>  /*
>>>   * This is only for non-live state being migrated.
>>> @@ -527,21 +534,21 @@ static int qemu_rdma_exchange_send(RDMAContext *r=
dma, RDMAControlHeader *head,
>>>  static inline uint64_t ram_chunk_index(const uint8_t *start,
>>>                                         const uint8_t *host)
>>>  {
>>> -    return ((uintptr_t) host - (uintptr_t) start) >> RDMA_REG_CHUNK_SH=
IFT;
>>> +    return ((uintptr_t) host - (uintptr_t) start) >> migrate_rdma_chun=
k_shift();
>>>  }
>>>
>>>  static inline uint8_t *ram_chunk_start(const RDMALocalBlock *rdma_ram_=
block,
>>>                                         uint64_t i)
>>>  {
>>>      return (uint8_t *)(uintptr_t)(rdma_ram_block->local_host_addr +
>>> -                                  (i << RDMA_REG_CHUNK_SHIFT));
>>> +                                  (i << migrate_rdma_chunk_shift()));
>>>  }
>>>
>>>  static inline uint8_t *ram_chunk_end(const RDMALocalBlock *rdma_ram_bl=
ock,
>>>                                       uint64_t i)
>>>  {
>>>      uint8_t *result =3D ram_chunk_start(rdma_ram_block, i) +
>>> -                                         (1UL << RDMA_REG_CHUNK_SHIFT);
>>> +                                         rdma_chunk_size();
>>>
>>>      if (result > (rdma_ram_block->local_host_addr + rdma_ram_block->le=
ngth)) {
>>>          result =3D rdma_ram_block->local_host_addr + rdma_ram_block->l=
ength;
>>> @@ -1841,6 +1848,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
>>>      struct ibv_send_wr *bad_wr;
>>>      int reg_result_idx, ret, count =3D 0;
>>>      uint64_t chunk, chunks;
>>> +    uint64_t chunk_size =3D rdma_chunk_size();
>>>      uint8_t *chunk_start, *chunk_end;
>>>      RDMALocalBlock *block =3D &(rdma->local_ram_blocks.block[current_i=
ndex]);
>>>      RDMARegister reg;
>>> @@ -1861,22 +1869,21 @@ retry:
>>>      chunk_start =3D ram_chunk_start(block, chunk);
>>>
>>>      if (block->is_ram_block) {
>>> -        chunks =3D length / (1UL << RDMA_REG_CHUNK_SHIFT);
>>> +        chunks =3D length / chunk_size;
>>>
>>> -        if (chunks && ((length % (1UL << RDMA_REG_CHUNK_SHIFT)) =3D=3D=
 0)) {
>>> +        if (chunks && ((length % chunk_size) =3D=3D 0)) {
>>>              chunks--;
>>>          }
>>>      } else {
>>> -        chunks =3D block->length / (1UL << RDMA_REG_CHUNK_SHIFT);
>>> +        chunks =3D block->length / chunk_size;
>>>
>>> -        if (chunks && ((block->length % (1UL << RDMA_REG_CHUNK_SHIFT))=
 =3D=3D 0)) {
>>> +        if (chunks && ((block->length % chunk_size) =3D=3D 0)) {
>>>              chunks--;
>>>          }
>>>      }
>>>
>>>      trace_qemu_rdma_write_one_top(chunks + 1,
>>> -                                  (chunks + 1) *
>>> -                                  (1UL << RDMA_REG_CHUNK_SHIFT) / 1024=
 / 1024);
>>> +                                  (chunks + 1) * chunk_size / 1024 / 1=
024);
>>>
>>>      chunk_end =3D ram_chunk_end(block, chunk + chunks);
>>>
>>> @@ -2176,7 +2183,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
>>>      rdma->current_length +=3D len;
>>>
>>>      /* flush it if buffer is too large */
>>> -    if (rdma->current_length >=3D RDMA_MERGE_MAX) {
>>> +    if (rdma->current_length >=3D rdma_merge_max()) {
>>>          return qemu_rdma_write_flush(rdma, errp);
>>>      }
>>>
>>> @@ -3522,7 +3529,7 @@ int rdma_registration_handle(QEMUFile *f)
>>>                  } else {
>>>                      chunk =3D reg->key.chunk;
>>>                      host_addr =3D block->local_host_addr +
>>> -                        (reg->key.chunk * (1UL << RDMA_REG_CHUNK_SHIFT=
));
>>> +                        (reg->key.chunk * rdma_chunk_size());
>>>                      /* Check for particularly bad chunk value */
>>>                      if (host_addr < (void *)block->local_host_addr) {
>>>                          error_report("rdma: bad chunk for block %s"
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 7134d4ce47..0521bf3d69 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1007,9 +1007,14 @@
>>>  #     is @cpr-exec.  The first list element is the program's filename,
>>>  #     the remainder its arguments.  (Since 10.2)
>>>  #
>>> +# @x-rdma-chunk-shift: RDMA memory registration chunk shift.
>>> +#     The chunk size is 2^N bytes where N is the value.
>>
>> The value of what?  Oh, the value of @x-rdma-chunk-shift.
>>
>> Acceptable range?  I doubt 0 or 255 work :)
>
> The valid range is [20, 30]. 20 is the default/original value. 30 is the =
largest value working on my servers with Mellanox RDMA NIC.

The range needs to be documented here.

>> Would this be easier to document if we make it a byte count
>> @x-rdma-chunk-size, must be a power of two?
>
> Switch to byte count will be easier to document, but the user may find it=
 a bit harder to use.
>
> `-global migration.x-rdma-chunk-size=3D1073741824`
>
> The valid range is [1048576,=C2=A01073741824] and it should be power of 2.
>
>
> Do you prefer `x-rdma-chunk-size`? If yes, I will make the switch in v2 p=
atch.

Have a look at migration parameter @max-bandwidth.  It supports size
prefixes like 1M.

>>> +#     Defaults to 20 (1 MiB).  Only takes effect for RDMA migration.
>>> +#     (Since 10.2)
>>
>> 11.0 right now, but realistically 11.1.
>
> OK. I will update it in v2 patch.
>
>
>>> +#
>>>  # Features:
>>>  #
>>> -# @unstable: Members @x-checkpoint-delay and
>>> +# @unstable: Members @x-rdma-chunk-shift, @x-checkpoint-delay and
>>>  #     @x-vcpu-dirty-limit-period are experimental.
>>
>> Keep the list of members sorted:
>>
>>     # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-shift, and
>>     #     @x-vcpu-dirty-limit-period are experimental.
>
>
> OK. I will update it in v2 patch.
>
>
>>
>>>  #
>>>  # Since: 2.4
>>> @@ -1045,6 +1050,8 @@
>>>              '*vcpu-dirty-limit': 'uint64',
>>>              '*mode': 'MigMode',
>>>              '*zero-page-detection': 'ZeroPageDetection',
>>> +            '*x-rdma-chunk-shift': { 'type': 'uint8',
>>> +                                     'features': [ 'unstable' ] },
>>>              '*direct-io': 'bool',
>>>              '*cpr-exec-command': [ 'str' ]} }


