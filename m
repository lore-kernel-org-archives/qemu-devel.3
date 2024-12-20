Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B0CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 12:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOc8X-0005kK-5Y; Fri, 20 Dec 2024 07:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOc8R-0005k1-85
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 07:29:39 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOc8O-0007wK-Cw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 07:29:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C30B11F461;
 Fri, 20 Dec 2024 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734697773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16Z7WHZ6yiYVpspgyeZZJq85j2eYbnyYBcKRPyhZMmw=;
 b=sTZoUhOLTYyoEPgYJZ+BNDtlrxOP9Y+LN7IG36oQ/Ung3aaxfGQnqKBH07Ke1Kese7ZhOk
 G9ay2gnTioJM7ToNBAInA+miVTDHV5tgjxzGAx7HQ4b9ZXIZc2SsoOmdkj+5hrjnmbMIQA
 wHutuJEuSykRvKyBPE8BvDEEw9lNH4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734697773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16Z7WHZ6yiYVpspgyeZZJq85j2eYbnyYBcKRPyhZMmw=;
 b=pY/u6pFFu6IPWQLAj5FCCANG178ArIxzQAEtuKgRpUwAtl26rn4h6aT5xmdflZfQZzDXfb
 9nHB6CHZ+KJpZtBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2R+FOdPZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vdtSlLYu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734697772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16Z7WHZ6yiYVpspgyeZZJq85j2eYbnyYBcKRPyhZMmw=;
 b=2R+FOdPZp/SqI1nBNlrlssSSX0f9GGr2I55vzag5/6ISkvlKMuLNHY6IxdigHnK1/xCxPt
 oDtyw/7fToHyXM4qeBqQus2kaNB0NCupyXNp+psU/s24xff30lmthHj22bXjHXw8J1oPG6
 fYmpcsqAyZPPglbneG1MPUWc6sH+yrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734697772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16Z7WHZ6yiYVpspgyeZZJq85j2eYbnyYBcKRPyhZMmw=;
 b=vdtSlLYumicVkTRO8qRDIEacNom1UYwQLq6COj7BenEILfjc9kpyuWLJdVB3x5HtbCwLx/
 pqWR+PnkO1KcF2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FA7F13A63;
 Fri, 20 Dec 2024 12:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zFWzASxjZWdbKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 20 Dec 2024 12:29:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-A?=
 =?utf-8?Q?ndr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1"
 <yuan1.liu@intel.com>, Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren
 (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [External] Re: [PATCH v8 09/12] migration/multifd: Enable DSA
 offloading in multifd sender path.
In-Reply-To: <CAHObMVZWAToy9b=OhMPwFOkRdz9e01JB1fgG4g3jnMeOOGKdMw@mail.gmail.com>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
 <20241204021142.24184-10-yichen.wang@bytedance.com>
 <87wmfyurat.fsf@suse.de>
 <CAHObMVZWAToy9b=OhMPwFOkRdz9e01JB1fgG4g3jnMeOOGKdMw@mail.gmail.com>
Date: Fri, 20 Dec 2024 09:29:29 -0300
Message-ID: <87ttaytu52.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C30B11F461
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> On Tue, Dec 17, 2024 at 9:56=E2=80=AFAM Fabiano Rosas <farosas@suse.de> w=
rote:
>>
>> Yichen Wang <yichen.wang@bytedance.com> writes:
>>
>> > From: Hao Xiang <hao.xiang@linux.dev>
>> >
>> > Multifd sender path gets an array of pages queued by the migration
>> > thread. It performs zero page checking on every page in the array.
>> > The pages are classfied as either a zero page or a normal page. This
>> > change uses Intel DSA to offload the zero page checking from CPU to
>> > the DSA accelerator. The sender thread submits a batch of pages to DSA
>> > hardware and waits for the DSA completion thread to signal for work
>> > completion.
>> >
>> > Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
>> > Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
>> > ---
>> >  migration/multifd-zero-page.c | 149 ++++++++++++++++++++++++++++++----
>> >  migration/multifd.c           |  15 +++-
>> >  migration/multifd.h           |   6 ++
>> >  migration/options.c           |  13 +++
>> >  migration/options.h           |   1 +
>> >  5 files changed, 168 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-pa=
ge.c
>> > index f1e988a959..08e7fc3d92 100644
>> > --- a/migration/multifd-zero-page.c
>> > +++ b/migration/multifd-zero-page.c
>> > @@ -21,7 +21,9 @@
>> >
>> >  static bool multifd_zero_page_enabled(void)
>> >  {
>> > -    return migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_M=
ULTIFD;
>> > +    ZeroPageDetection curMethod =3D migrate_zero_page_detection();
>> > +    return (curMethod =3D=3D ZERO_PAGE_DETECTION_MULTIFD ||
>> > +            curMethod =3D=3D ZERO_PAGE_DETECTION_DSA_ACCEL);
>> >  }
>> >
>> >  static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
>> > @@ -37,26 +39,49 @@ static void swap_page_offset(ram_addr_t *pages_off=
set, int a, int b)
>> >      pages_offset[b] =3D temp;
>> >  }
>> >
>> > +#ifdef CONFIG_DSA_OPT
>> > +
>> > +static void swap_result(bool *results, int a, int b)
>> > +{
>> > +    bool temp;
>> > +
>> > +    if (a =3D=3D b) {
>> > +        return;
>> > +    }
>> > +
>> > +    temp =3D results[a];
>> > +    results[a] =3D results[b];
>> > +    results[b] =3D temp;
>> > +}
>> > +
>> >  /**
>> > - * multifd_send_zero_page_detect: Perform zero page detection on all =
pages.
>> > + * zero_page_detect_dsa: Perform zero page detection using
>> > + * Intel Data Streaming Accelerator (DSA).
>> >   *
>> > - * Sorts normal pages before zero pages in p->pages->offset and updat=
es
>> > - * p->pages->normal_num.
>> > + * Sorts normal pages before zero pages in pages->offset and updates
>> > + * pages->normal_num.
>> >   *
>> >   * @param p A pointer to the send params.
>> >   */
>> > -void multifd_send_zero_page_detect(MultiFDSendParams *p)
>> > +static void zero_page_detect_dsa(MultiFDSendParams *p)
>> >  {
>> >      MultiFDPages_t *pages =3D &p->data->u.ram;
>> >      RAMBlock *rb =3D pages->block;
>> > -    int i =3D 0;
>> > -    int j =3D pages->num - 1;
>> > +    bool *results =3D p->dsa_batch_task->results;
>> >
>> > -    if (!multifd_zero_page_enabled()) {
>> > -        pages->normal_num =3D pages->num;
>> > -        goto out;
>> > +    for (int i =3D 0; i < pages->num; i++) {
>> > +        p->dsa_batch_task->addr[i] =3D
>> > +            (ram_addr_t)(rb->host + pages->offset[i]);
>> >      }
>> >
>> > +    buffer_is_zero_dsa_batch_sync(p->dsa_batch_task,
>> > +                                  (const void **)p->dsa_batch_task->a=
ddr,
>> > +                                  pages->num,
>> > +                                  multifd_ram_page_size());
>> > +
>> > +    int i =3D 0;
>> > +    int j =3D pages->num - 1;
>> > +
>> >      /*
>> >       * Sort the page offset array by moving all normal pages to
>> >       * the left and all zero pages to the right of the array.
>> > @@ -64,23 +89,59 @@ void multifd_send_zero_page_detect(MultiFDSendPara=
ms *p)
>> >      while (i <=3D j) {
>> >          uint64_t offset =3D pages->offset[i];
>> >
>> > -        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size(=
))) {
>> > +        if (!results[i]) {
>> >              i++;
>> >              continue;
>> >          }
>> >
>> > +        swap_result(results, i, j);
>> >          swap_page_offset(pages->offset, i, j);
>> >          ram_release_page(rb->idstr, offset);
>> >          j--;
>> >      }
>> >
>> >      pages->normal_num =3D i;
>> > +}
>> >
>> > -out:
>> > -    stat64_add(&mig_stats.normal_pages, pages->normal_num);
>> > -    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
>> > +int multifd_dsa_setup(MigrationState *s, Error *local_err)
>> > +{
>> > +    g_autofree strList *dsa_parameter =3D g_malloc0(sizeof(strList));
>> > +    migrate_dsa_accel_path(dsa_parameter);
>> > +    if (qemu_dsa_init(dsa_parameter, &local_err)) {
>> > +        migrate_set_error(s, local_err);
>> > +        return -1;
>> > +    } else {
>> > +        qemu_dsa_start();
>> > +    }
>> > +
>> > +    return 0;
>> > +}
>> > +
>> > +void multifd_dsa_cleanup(void)
>> > +{
>> > +    qemu_dsa_cleanup();
>> > +}
>> > +
>> > +#else
>> > +
>> > +static void zero_page_detect_dsa(MultiFDSendParams *p)
>> > +{
>> > +    g_assert_not_reached();
>> >  }
>> >
>> > +int multifd_dsa_setup(MigrationState *s, Error *local_err)
>> > +{
>> > +    g_assert_not_reached();
>> > +    return -1;
>> > +}
>> > +
>> > +void multifd_dsa_cleanup(void)
>> > +{
>> > +    return ;
>> > +}
>> > +
>> > +#endif
>> > +
>> >  void multifd_recv_zero_page_process(MultiFDRecvParams *p)
>> >  {
>> >      for (int i =3D 0; i < p->zero_num; i++) {
>> > @@ -92,3 +153,63 @@ void multifd_recv_zero_page_process(MultiFDRecvPar=
ams *p)
>> >          }
>> >      }
>> >  }
>> > +
>> > +/**
>> > + * zero_page_detect_cpu: Perform zero page detection using CPU.
>> > + *
>> > + * Sorts normal pages before zero pages in p->pages->offset and updat=
es
>> > + * p->pages->normal_num.
>> > + *
>> > + * @param p A pointer to the send params.
>> > + */
>> > +static void zero_page_detect_cpu(MultiFDSendParams *p)
>> > +{
>> > +    MultiFDPages_t *pages =3D &p->data->u.ram;
>> > +    RAMBlock *rb =3D pages->block;
>> > +    int i =3D 0;
>> > +    int j =3D pages->num - 1;
>> > +
>> > +    /*
>> > +     * Sort the page offset array by moving all normal pages to
>> > +     * the left and all zero pages to the right of the array.
>> > +     */
>> > +    while (i <=3D j) {
>> > +        uint64_t offset =3D pages->offset[i];
>> > +
>> > +        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size(=
))) {
>> > +            i++;
>> > +            continue;
>> > +        }
>> > +
>> > +        swap_page_offset(pages->offset, i, j);
>> > +        ram_release_page(rb->idstr, offset);
>> > +        j--;
>> > +    }
>> > +
>> > +    pages->normal_num =3D i;
>> > +}
>> > +
>> > +/**
>> > + * multifd_send_zero_page_detect: Perform zero page detection on all =
pages.
>> > + *
>> > + * @param p A pointer to the send params.
>> > + */
>> > +void multifd_send_zero_page_detect(MultiFDSendParams *p)
>> > +{
>> > +    MultiFDPages_t *pages =3D &p->data->u.ram;
>> > +
>> > +    if (!multifd_zero_page_enabled()) {
>> > +        pages->normal_num =3D pages->num;
>> > +        goto out;
>> > +    }
>> > +
>> > +    if (qemu_dsa_is_running()) {
>> > +        zero_page_detect_dsa(p);
>> > +    } else {
>> > +        zero_page_detect_cpu(p);
>> > +    }
>> > +
>> > +out:
>> > +    stat64_add(&mig_stats.normal_pages, pages->normal_num);
>> > +    stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
>> > +}
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index 498e71fd10..946144fc2f 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -13,6 +13,7 @@
>> >  #include "qemu/osdep.h"
>> >  #include "qemu/cutils.h"
>> >  #include "qemu/rcu.h"
>> > +#include "qemu/dsa.h"
>> >  #include "exec/target_page.h"
>> >  #include "sysemu/sysemu.h"
>> >  #include "exec/ramblock.h"
>> > @@ -462,6 +463,8 @@ static bool multifd_send_cleanup_channel(MultiFDSe=
ndParams *p, Error **errp)
>> >      p->name =3D NULL;
>> >      g_free(p->data);
>> >      p->data =3D NULL;
>> > +    buffer_zero_batch_task_destroy(p->dsa_batch_task);
>> > +    p->dsa_batch_task =3D NULL;
>> >      p->packet_len =3D 0;
>> >      g_free(p->packet);
>> >      p->packet =3D NULL;
>> > @@ -493,6 +496,8 @@ void multifd_send_shutdown(void)
>> >
>> >      multifd_send_terminate_threads();
>> >
>> > +    multifd_dsa_cleanup();
>> > +
>> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
>> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
>> >          Error *local_err =3D NULL;
>> > @@ -814,11 +819,17 @@ bool multifd_send_setup(void)
>> >      uint32_t page_count =3D multifd_ram_page_count();
>> >      bool use_packets =3D multifd_use_packets();
>> >      uint8_t i;
>> > +    Error *local_err =3D NULL;
>> >
>> >      if (!migrate_multifd()) {
>> >          return true;
>> >      }
>> >
>> > +    if (s &&
>> > +        s->parameters.zero_page_detection =3D=3D ZERO_PAGE_DETECTION_=
DSA_ACCEL) {
>> > +        ret =3D multifd_dsa_setup(s, local_err);
>>
>> This leaves the local_err set and will cause an assert if the code below
>> tries to set it again. We should at the very least report the error here
>> and free it. But that's not ideal because it allows the code to
>> continue.
>>
>> Can you move this whole block after the channels loop as suggested
>> previously but this time take the p->dsa_batch_task along and put it the
>> ->send_setup() loop?
>>
>
> I am trying to make this change. If I put the p->dsa_batch_task into
> the multifd_dsa_setup() in multifd-zero-page.c, things are a little
> tricky. I will need to pass thread_count and multifd_send_state into
> multifd_dsa_setup(), but multifd_send_state is a multifd.c only data
> structure/variable. I have to make the whole struct into multifd.h,
> and not sure if that is a good idea?

I meant something simpler:

+    if (s &&
+        s->parameters.zero_page_detection =3D=3D ZERO_PAGE_DETECTION_DSA_A=
CCEL) {
+        ret =3D multifd_dsa_setup(s, local_err);
+    }

    if (ret) {
        goto err;
    }

    for (i =3D 0; i < thread_count; i++) {
        MultiFDSendParams *p =3D &multifd_send_state->params[i];
        Error *local_err =3D NULL;

+        p->dsa_batch_task =3D buffer_zero_batch_task_init(page_count);

        ret =3D multifd_send_state->ops->send_setup(p, &local_err);
        if (ret) {
            migrate_set_error(s, local_err);
            goto err;
        }
        assert(p->iov);
    }


>
>> > +    }
>> > +
>> >      thread_count =3D migrate_multifd_channels();
>> >      multifd_send_state =3D g_malloc0(sizeof(*multifd_send_state));
>> >      multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_c=
ount);
>> > @@ -829,12 +840,12 @@ bool multifd_send_setup(void)
>> >
>> >      for (i =3D 0; i < thread_count; i++) {
>> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
>> > -        Error *local_err =3D NULL;
>> >
>> >          qemu_sem_init(&p->sem, 0);
>> >          qemu_sem_init(&p->sem_sync, 0);
>> >          p->id =3D i;
>> >          p->data =3D multifd_send_data_alloc();
>> > +        p->dsa_batch_task =3D buffer_zero_batch_task_init(page_count);
>> >
>> >          if (use_packets) {
>> >              p->packet_len =3D sizeof(MultiFDPacket_t)
>> > @@ -865,7 +876,6 @@ bool multifd_send_setup(void)
>> >
>> >      for (i =3D 0; i < thread_count; i++) {
>> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
>> > -        Error *local_err =3D NULL;
>> >
>> >          ret =3D multifd_send_state->ops->send_setup(p, &local_err);
>> >          if (ret) {
>> > @@ -1047,6 +1057,7 @@ void multifd_recv_cleanup(void)
>> >              qemu_thread_join(&p->thread);
>> >          }
>> >      }
>> > +    multifd_dsa_cleanup();
>> >      for (i =3D 0; i < migrate_multifd_channels(); i++) {
>> >          multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
>> >      }
>> > diff --git a/migration/multifd.h b/migration/multifd.h
>> > index 50d58c0c9c..da53b0bdfd 100644
>> > --- a/migration/multifd.h
>> > +++ b/migration/multifd.h
>> > @@ -15,6 +15,7 @@
>> >
>> >  #include "exec/target_page.h"
>> >  #include "ram.h"
>> > +#include "qemu/dsa.h"
>> >
>> >  typedef struct MultiFDRecvData MultiFDRecvData;
>> >  typedef struct MultiFDSendData MultiFDSendData;
>> > @@ -155,6 +156,9 @@ typedef struct {
>> >      bool pending_sync;
>> >      MultiFDSendData *data;
>> >
>> > +    /* Zero page checking batch task */
>> > +    QemuDsaBatchTask *dsa_batch_task;
>> > +
>> >      /* thread local variables. No locking required */
>> >
>> >      /* pointer to the packet */
>> > @@ -313,6 +317,8 @@ void multifd_send_fill_packet(MultiFDSendParams *p=
);
>> >  bool multifd_send_prepare_common(MultiFDSendParams *p);
>> >  void multifd_send_zero_page_detect(MultiFDSendParams *p);
>> >  void multifd_recv_zero_page_process(MultiFDRecvParams *p);
>> > +int multifd_dsa_setup(MigrationState *s, Error *local_err);
>> > +void multifd_dsa_cleanup(void);
>> >
>> >  static inline void multifd_send_prepare_header(MultiFDSendParams *p)
>> >  {
>> > diff --git a/migration/options.c b/migration/options.c
>> > index ca89fdc4f4..cc40d3dfea 100644
>> > --- a/migration/options.c
>> > +++ b/migration/options.c
>> > @@ -817,6 +817,19 @@ const strList *migrate_accel_path(void)
>> >      return s->parameters.accel_path;
>> >  }
>> >
>> > +void migrate_dsa_accel_path(strList *dsa_accel_path)
>> > +{
>> > +    MigrationState *s =3D migrate_get_current();
>> > +    strList *accel_path =3D s->parameters.accel_path;
>> > +    strList **tail =3D &dsa_accel_path;
>> > +    while (accel_path) {
>> > +        if (strncmp(accel_path->value, "dsa:", 4) =3D=3D 0) {
>> > +            QAPI_LIST_APPEND(tail, &accel_path->value[4]);
>> > +        }
>> > +        accel_path =3D accel_path->next;
>> > +    }
>> > +}
>> > +
>> >  const char *migrate_tls_hostname(void)
>> >  {
>> >      MigrationState *s =3D migrate_get_current();
>> > diff --git a/migration/options.h b/migration/options.h
>> > index 3d1e91dc52..5e34b7c997 100644
>> > --- a/migration/options.h
>> > +++ b/migration/options.h
>> > @@ -85,6 +85,7 @@ const char *migrate_tls_hostname(void);
>> >  uint64_t migrate_xbzrle_cache_size(void);
>> >  ZeroPageDetection migrate_zero_page_detection(void);
>> >  const strList *migrate_accel_path(void);
>> > +void migrate_dsa_accel_path(strList *dsa_accel_path);
>> >
>> >  /* parameters helpers */

