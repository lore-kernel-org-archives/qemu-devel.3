Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58419C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPrl-0003aa-Pv; Fri, 09 Feb 2024 07:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rYPrj-0003aN-RZ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:20:23 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rYPrh-0007hU-NW
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:20:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6094E21DD9;
 Fri,  9 Feb 2024 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707481218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCsO4fESd7RusOjQ+hKsdOeXPRqV9vzRH9cdoMov368=;
 b=xf/P6PgjzqvNtVwWOqIg67gpKr45H+Tvuphgk58gY3mV1BmpspLF6EN/zC3cTxxYDf+tWR
 9S4qIjJ8F38RtZXNHWzR200Z/9a1k8+WVcg5e5Ot77Yg35FabOWGG/0h1HLYvf5DHzfpVA
 1wsRYZWcX38dJB6cV39e3OMNF36sPEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707481218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCsO4fESd7RusOjQ+hKsdOeXPRqV9vzRH9cdoMov368=;
 b=UyOy4pZTEUtwEA+J/nCPKbDBKMpfYlIfuln6p5IhByPuHBtaeeYQzWhFDAbOxGyDKJkRf7
 GgnaBSvGxNlZjCBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707481218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCsO4fESd7RusOjQ+hKsdOeXPRqV9vzRH9cdoMov368=;
 b=xf/P6PgjzqvNtVwWOqIg67gpKr45H+Tvuphgk58gY3mV1BmpspLF6EN/zC3cTxxYDf+tWR
 9S4qIjJ8F38RtZXNHWzR200Z/9a1k8+WVcg5e5Ot77Yg35FabOWGG/0h1HLYvf5DHzfpVA
 1wsRYZWcX38dJB6cV39e3OMNF36sPEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707481218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCsO4fESd7RusOjQ+hKsdOeXPRqV9vzRH9cdoMov368=;
 b=UyOy4pZTEUtwEA+J/nCPKbDBKMpfYlIfuln6p5IhByPuHBtaeeYQzWhFDAbOxGyDKJkRf7
 GgnaBSvGxNlZjCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF7F11326D;
 Fri,  9 Feb 2024 12:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S3lMJIEYxmXcRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Feb 2024 12:20:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>, Avihai
 Horon <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [External] [PATCH v2 05/23] migration/multifd: Drop
 MultiFDSendParams.normal[] array
In-Reply-To: <CAAYibXiZ-c5zQutHHvL6-bO2yotPX=LQOmjj=HhhwmrAHc+2dA@mail.gmail.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-6-peterx@redhat.com>
 <CAAYibXiZ-c5zQutHHvL6-bO2yotPX=LQOmjj=HhhwmrAHc+2dA@mail.gmail.com>
Date: Fri, 09 Feb 2024 09:20:15 -0300
Message-ID: <871q9lde2o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,bytedance.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> On Fri, Feb 2, 2024 at 2:30=E2=80=AFAM <peterx@redhat.com> wrote:
>>
>> From: Peter Xu <peterx@redhat.com>
>>
>> This array is redundant when p->pages exists.  Now we extended the life =
of
>> p->pages to the whole period where pending_job is set, it should be safe=
 to
>> always use p->pages->offset[] rather than p->normal[].  Drop the array.
>>
>> Alongside, the normal_num is also redundant, which is the same to
>> p->pages->num.
>
> Can we not drop p->normal and p_normal_num? It is redundant now but I
> think it will be needed for multifd zero page checking. In multifd
> zero page, we find out all zero pages and we sort the normal pages and
> zero pages in two seperate arrays. p->offset is the original array of
> pages, p->normal will contain the array of normal pages and p->zero
> will contain the array of zero pages.

We're moving send_fill_packet into send_prepare(), so you should be able
to do whatever data transformation at send_prepare() and add any fields
you need into p->pages.

If we keep p->normal we will not be able to switch into an opaque
payload later on. There should be no mention of pages outside of
hooks. This is long-term work, but let's avoid blocking it if possible.

>>
>> This doesn't apply to recv side, because there's no extra buffering on r=
ecv
>> side, so p->normal[] array is still needed.
>>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  migration/multifd.h      |  4 ----
>>  migration/multifd-zlib.c |  7 ++++---
>>  migration/multifd-zstd.c |  7 ++++---
>>  migration/multifd.c      | 33 +++++++++++++--------------------
>>  4 files changed, 21 insertions(+), 30 deletions(-)
>>
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index 7c040cb85a..3920bdbcf1 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -122,10 +122,6 @@ typedef struct {
>>      struct iovec *iov;
>>      /* number of iovs used */
>>      uint32_t iovs_num;
>> -    /* Pages that are not zero */
>> -    ram_addr_t *normal;
>> -    /* num of non zero pages */
>> -    uint32_t normal_num;
>>      /* used for compression methods */
>>      void *data;
>>  }  MultiFDSendParams;
>> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
>> index 37ce48621e..100809abc1 100644
>> --- a/migration/multifd-zlib.c
>> +++ b/migration/multifd-zlib.c
>> @@ -116,17 +116,18 @@ static void zlib_send_cleanup(MultiFDSendParams *p=
, Error **errp)
>>   */
>>  static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
>>  {
>> +    MultiFDPages_t *pages =3D p->pages;
>>      struct zlib_data *z =3D p->data;
>>      z_stream *zs =3D &z->zs;
>>      uint32_t out_size =3D 0;
>>      int ret;
>>      uint32_t i;
>>
>> -    for (i =3D 0; i < p->normal_num; i++) {
>> +    for (i =3D 0; i < pages->num; i++) {
>>          uint32_t available =3D z->zbuff_len - out_size;
>>          int flush =3D Z_NO_FLUSH;
>>
>> -        if (i =3D=3D p->normal_num - 1) {
>> +        if (i =3D=3D pages->num - 1) {
>>              flush =3D Z_SYNC_FLUSH;
>>          }
>>
>> @@ -135,7 +136,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, E=
rror **errp)
>>           * with compression. zlib does not guarantee that this is safe,
>>           * therefore copy the page before calling deflate().
>>           */
>> -        memcpy(z->buf, p->pages->block->host + p->normal[i], p->page_si=
ze);
>> +        memcpy(z->buf, p->pages->block->host + pages->offset[i], p->pag=
e_size);
>>          zs->avail_in =3D p->page_size;
>>          zs->next_in =3D z->buf;
>>
>> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
>> index b471daadcd..2023edd8cc 100644
>> --- a/migration/multifd-zstd.c
>> +++ b/migration/multifd-zstd.c
>> @@ -113,6 +113,7 @@ static void zstd_send_cleanup(MultiFDSendParams *p, =
Error **errp)
>>   */
>>  static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
>>  {
>> +    MultiFDPages_t *pages =3D p->pages;
>>      struct zstd_data *z =3D p->data;
>>      int ret;
>>      uint32_t i;
>> @@ -121,13 +122,13 @@ static int zstd_send_prepare(MultiFDSendParams *p,=
 Error **errp)
>>      z->out.size =3D z->zbuff_len;
>>      z->out.pos =3D 0;
>>
>> -    for (i =3D 0; i < p->normal_num; i++) {
>> +    for (i =3D 0; i < pages->num; i++) {
>>          ZSTD_EndDirective flush =3D ZSTD_e_continue;
>>
>> -        if (i =3D=3D p->normal_num - 1) {
>> +        if (i =3D=3D pages->num - 1) {
>>              flush =3D ZSTD_e_flush;
>>          }
>> -        z->in.src =3D p->pages->block->host + p->normal[i];
>> +        z->in.src =3D p->pages->block->host + pages->offset[i];
>>          z->in.size =3D p->page_size;
>>          z->in.pos =3D 0;
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 5633ac245a..8bb1fd95cf 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -90,13 +90,13 @@ static int nocomp_send_prepare(MultiFDSendParams *p,=
 Error **errp)
>>  {
>>      MultiFDPages_t *pages =3D p->pages;
>>
>> -    for (int i =3D 0; i < p->normal_num; i++) {
>> -        p->iov[p->iovs_num].iov_base =3D pages->block->host + p->normal=
[i];
>> +    for (int i =3D 0; i < pages->num; i++) {
>> +        p->iov[p->iovs_num].iov_base =3D pages->block->host + pages->of=
fset[i];
>>          p->iov[p->iovs_num].iov_len =3D p->page_size;
>>          p->iovs_num++;
>>      }
>>
>> -    p->next_packet_size =3D p->normal_num * p->page_size;
>> +    p->next_packet_size =3D pages->num * p->page_size;
>>      p->flags |=3D MULTIFD_FLAG_NOCOMP;
>>      return 0;
>>  }
>> @@ -269,21 +269,22 @@ static void multifd_pages_clear(MultiFDPages_t *pa=
ges)
>>  static void multifd_send_fill_packet(MultiFDSendParams *p)
>>  {
>>      MultiFDPacket_t *packet =3D p->packet;
>> +    MultiFDPages_t *pages =3D p->pages;
>>      int i;
>>
>>      packet->flags =3D cpu_to_be32(p->flags);
>>      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
>> -    packet->normal_pages =3D cpu_to_be32(p->normal_num);
>> +    packet->normal_pages =3D cpu_to_be32(pages->num);
>>      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
>>      packet->packet_num =3D cpu_to_be64(p->packet_num);
>>
>> -    if (p->pages->block) {
>> -        strncpy(packet->ramblock, p->pages->block->idstr, 256);
>> +    if (pages->block) {
>> +        strncpy(packet->ramblock, pages->block->idstr, 256);
>>      }
>>
>> -    for (i =3D 0; i < p->normal_num; i++) {
>> +    for (i =3D 0; i < pages->num; i++) {
>>          /* there are architectures where ram_addr_t is 32 bit */
>> -        uint64_t temp =3D p->normal[i];
>> +        uint64_t temp =3D pages->offset[i];
>>
>>          packet->offset[i] =3D cpu_to_be64(temp);
>>      }
>> @@ -570,8 +571,6 @@ void multifd_save_cleanup(void)
>>          p->packet =3D NULL;
>>          g_free(p->iov);
>>          p->iov =3D NULL;
>> -        g_free(p->normal);
>> -        p->normal =3D NULL;
>>          multifd_send_state->ops->send_cleanup(p, &local_err);
>>          if (local_err) {
>>              migrate_set_error(migrate_get_current(), local_err);
>> @@ -688,8 +687,8 @@ static void *multifd_send_thread(void *opaque)
>>
>>          if (p->pending_job) {
>>              uint64_t packet_num =3D p->packet_num;
>> +            MultiFDPages_t *pages =3D p->pages;
>>              uint32_t flags;
>> -            p->normal_num =3D 0;
>>
>>              if (use_zero_copy_send) {
>>                  p->iovs_num =3D 0;
>> @@ -697,12 +696,7 @@ static void *multifd_send_thread(void *opaque)
>>                  p->iovs_num =3D 1;
>>              }
>>
>> -            for (int i =3D 0; i < p->pages->num; i++) {
>> -                p->normal[p->normal_num] =3D p->pages->offset[i];
>> -                p->normal_num++;
>> -            }
>> -
>> -            if (p->normal_num) {
>> +            if (pages->num) {
>>                  ret =3D multifd_send_state->ops->send_prepare(p, &local=
_err);
>>                  if (ret !=3D 0) {
>>                      qemu_mutex_unlock(&p->mutex);
>> @@ -713,10 +707,10 @@ static void *multifd_send_thread(void *opaque)
>>              flags =3D p->flags;
>>              p->flags =3D 0;
>>              p->num_packets++;
>> -            p->total_normal_pages +=3D p->normal_num;
>> +            p->total_normal_pages +=3D pages->num;
>>              qemu_mutex_unlock(&p->mutex);
>>
>> -            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
>> +            trace_multifd_send(p->id, packet_num, pages->num, flags,
>>                                 p->next_packet_size);
>>
>>              if (use_zero_copy_send) {
>> @@ -924,7 +918,6 @@ int multifd_save_setup(Error **errp)
>>          p->name =3D g_strdup_printf("multifdsend_%d", i);
>>          /* We need one extra place for the packet header */
>>          p->iov =3D g_new0(struct iovec, page_count + 1);
>> -        p->normal =3D g_new0(ram_addr_t, page_count);
>>          p->page_size =3D qemu_target_page_size();
>>          p->page_count =3D page_count;
>>
>> --
>> 2.43.0
>>

