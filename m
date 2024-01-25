Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B58C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 23:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT8vW-0001YN-0X; Thu, 25 Jan 2024 18:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rT8vS-0001Xf-HS
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 18:14:27 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rT8vO-0006IL-TQ
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 18:14:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B0F92239A;
 Thu, 25 Jan 2024 23:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706224458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euoW8o35qM/auFwJDRVsBwc0uT6tGGTPwoE0bIdjVk0=;
 b=p1gS9a3kUSb6iDUeiZgTscH6846qZ86Cz0hlGCH49rY8F/YmpVbzxEsAqKgwK3oV5WQ/uC
 GwYaeGADsyUGxhEPcks+UyJRT4Cl6N4TBqXjMde4pNaiZNaQneURzQqOlxkE1b82nay+1Z
 fbvoa6zOuMrzpEi2a9AmU8BT17KiTSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706224458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euoW8o35qM/auFwJDRVsBwc0uT6tGGTPwoE0bIdjVk0=;
 b=1+98PfWUzLSgyB0GqrRM7QmWaSpZmJlDKJixPoXf6OOYI69pP34TUTkPEEAia/qwj8tnWp
 +8OiQxWrZQ6siXBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706224458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euoW8o35qM/auFwJDRVsBwc0uT6tGGTPwoE0bIdjVk0=;
 b=p1gS9a3kUSb6iDUeiZgTscH6846qZ86Cz0hlGCH49rY8F/YmpVbzxEsAqKgwK3oV5WQ/uC
 GwYaeGADsyUGxhEPcks+UyJRT4Cl6N4TBqXjMde4pNaiZNaQneURzQqOlxkE1b82nay+1Z
 fbvoa6zOuMrzpEi2a9AmU8BT17KiTSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706224458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euoW8o35qM/auFwJDRVsBwc0uT6tGGTPwoE0bIdjVk0=;
 b=1+98PfWUzLSgyB0GqrRM7QmWaSpZmJlDKJixPoXf6OOYI69pP34TUTkPEEAia/qwj8tnWp
 +8OiQxWrZQ6siXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A02A134C3;
 Thu, 25 Jan 2024 23:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kaXML0nrsmW8agAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Jan 2024 23:14:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [External] Re: [PATCH v2 04/20] So we use multifd to transmit
 zero pages.
In-Reply-To: <CAAYibXgtVP-w02Jiy-JM8JZBj2h4jxvwnmeM6VvfycxY09jxzQ@mail.gmail.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-5-hao.xiang@bytedance.com>
 <87pm09ennn.fsf@suse.de>
 <CAAYibXiD5Ni4Dh8=K-iXAuv9sx_LpxXd8ZkA3XP_dJy+P7J7Sw@mail.gmail.com>
 <CAAYibXgtVP-w02Jiy-JM8JZBj2h4jxvwnmeM6VvfycxY09jxzQ@mail.gmail.com>
Date: Thu, 25 Jan 2024 20:14:15 -0300
Message-ID: <877cjxvwe0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p1gS9a3k;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1+98PfWU
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 8B0F92239A
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

> On Mon, Jan 22, 2024 at 8:28=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.co=
m> wrote:
>>
>> On Thu, Nov 16, 2023 at 7:14=E2=80=AFAM Fabiano Rosas <farosas@suse.de> =
wrote:
>> >
>> > Hao Xiang <hao.xiang@bytedance.com> writes:
>> >
>> > > From: Juan Quintela <quintela@redhat.com>
>> > >
>> > > Signed-off-by: Juan Quintela <quintela@redhat.com>
>> > > Reviewed-by: Leonardo Bras <leobras@redhat.com>
>> > > ---
>> > >  migration/multifd.c |  7 ++++---
>> > >  migration/options.c | 13 +++++++------
>> > >  migration/ram.c     | 45 ++++++++++++++++++++++++++++++++++++++----=
---
>> > >  qapi/migration.json |  1 -
>> > >  4 files changed, 49 insertions(+), 17 deletions(-)
>> > >
>> > > diff --git a/migration/multifd.c b/migration/multifd.c
>> > > index 1b994790d5..1198ffde9c 100644
>> > > --- a/migration/multifd.c
>> > > +++ b/migration/multifd.c
>> > > @@ -13,6 +13,7 @@
>> > >  #include "qemu/osdep.h"
>> > >  #include "qemu/cutils.h"
>> > >  #include "qemu/rcu.h"
>> > > +#include "qemu/cutils.h"
>> > >  #include "exec/target_page.h"
>> > >  #include "sysemu/sysemu.h"
>> > >  #include "exec/ramblock.h"
>> > > @@ -459,7 +460,6 @@ static int multifd_send_pages(QEMUFile *f)
>> > >      p->packet_num =3D multifd_send_state->packet_num++;
>> > >      multifd_send_state->pages =3D p->pages;
>> > >      p->pages =3D pages;
>> > > -
>> > >      qemu_mutex_unlock(&p->mutex);
>> > >      qemu_sem_post(&p->sem);
>> > >
>> > > @@ -684,7 +684,7 @@ static void *multifd_send_thread(void *opaque)
>> > >      MigrationThread *thread =3D NULL;
>> > >      Error *local_err =3D NULL;
>> > >      /* qemu older than 8.2 don't understand zero page on multifd ch=
annel */
>> > > -    bool use_zero_page =3D !migrate_use_main_zero_page();
>> > > +    bool use_multifd_zero_page =3D !migrate_use_main_zero_page();
>> > >      int ret =3D 0;
>> > >      bool use_zero_copy_send =3D migrate_zero_copy_send();
>> > >
>> > > @@ -713,6 +713,7 @@ static void *multifd_send_thread(void *opaque)
>> > >              RAMBlock *rb =3D p->pages->block;
>> > >              uint64_t packet_num =3D p->packet_num;
>> > >              uint32_t flags;
>> > > +
>> > >              p->normal_num =3D 0;
>> > >              p->zero_num =3D 0;
>> > >
>> > > @@ -724,7 +725,7 @@ static void *multifd_send_thread(void *opaque)
>> > >
>> > >              for (int i =3D 0; i < p->pages->num; i++) {
>> > >                  uint64_t offset =3D p->pages->offset[i];
>> > > -                if (use_zero_page &&
>> > > +                if (use_multifd_zero_page &&
>> >
>> > We could have a new function in multifd_ops for zero page
>> > handling. We're already considering an accelerator for the compression
>> > method in the other series[1] and in this series we're adding an
>> > accelerator for zero page checking. It's about time we make the
>> > multifd_ops generic instead of only compression/no compression.
>>
>> Sorry I overlooked this email earlier.
>> I will extend the multifd_ops interface and add a new API for zero
>> page checking.
>>
>> >
>> > 1- [PATCH v2 0/4] Live Migration Acceleration with IAA Compression
>> > https://lore.kernel.org/r/20231109154638.488213-1-yuan1.liu@intel.com
>> >
>> > >                      buffer_is_zero(rb->host + offset, p->page_size)=
) {
>> > >                      p->zero[p->zero_num] =3D offset;
>> > >                      p->zero_num++;
>> > > diff --git a/migration/options.c b/migration/options.c
>> > > index 00c0c4a0d6..97d121d4d7 100644
>> > > --- a/migration/options.c
>> > > +++ b/migration/options.c
>> > > @@ -195,6 +195,7 @@ Property migration_properties[] =3D {
>> > >      DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
>> > >      DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETUR=
N_PATH),
>> > >      DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
>> > > +    DEFINE_PROP_MIG_CAP("x-main-zero-page", MIGRATION_CAPABILITY_MA=
IN_ZERO_PAGE),
>> > >      DEFINE_PROP_MIG_CAP("x-background-snapshot",
>> > >              MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
>> > >  #ifdef CONFIG_LINUX
>> > > @@ -288,13 +289,9 @@ bool migrate_multifd(void)
>> > >
>> > >  bool migrate_use_main_zero_page(void)
>> > >  {
>> > > -    //MigrationState *s;
>> > > -
>> > > -    //s =3D migrate_get_current();
>> > > +    MigrationState *s =3D migrate_get_current();
>> > >
>> > > -    // We will enable this when we add the right code.
>> > > -    // return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZER=
O_PAGE];
>> > > -    return true;
>> > > +    return s->capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
>> >
>> > What happens if we disable main-zero-page while multifd is not enabled?
>>
>> In ram.c
>> ...
>> if (migrate_multifd() && !migrate_use_main_zero_page()) {
>> migration_ops->ram_save_target_page =3D ram_save_target_page_multifd;
>> } else {
>> migration_ops->ram_save_target_page =3D ram_save_target_page_legacy;
>> }
>> ...
>>
>> So if main-zero-page is disabled and multifd is also disabled, it will
>> go with the "else" path, which is the legacy path
>> ram_save_target_page_legacy() and do zero page checking from the main
>> thread.
>>
>> >
>> > >  }
>> > >
>> > >  bool migrate_pause_before_switchover(void)
>> > > @@ -457,6 +454,7 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_backgroun=
d_snapshot,
>> > >      MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
>> > >      MIGRATION_CAPABILITY_RETURN_PATH,
>> > >      MIGRATION_CAPABILITY_MULTIFD,
>> > > +    MIGRATION_CAPABILITY_MAIN_ZERO_PAGE,
>> > >      MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
>> > >      MIGRATION_CAPABILITY_AUTO_CONVERGE,
>> > >      MIGRATION_CAPABILITY_RELEASE_RAM,
>> > > @@ -534,6 +532,9 @@ bool migrate_caps_check(bool *old_caps, bool *ne=
w_caps, Error **errp)
>> > >              error_setg(errp, "Postcopy is not yet compatible with m=
ultifd");
>> > >              return false;
>> > >          }
>> > > +        if (new_caps[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE]) {
>> > > +            error_setg(errp, "Postcopy is not yet compatible with m=
ain zero copy");
>> > > +        }
>> >
>> > Won't this will breaks compatibility for postcopy? A command that used
>> > to work now will have to disable main-zero-page first.
>>
>> main-zero-page is disabled by default.
>>
>> >
>> > >      }
>> > >
>> > >      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
>> > > diff --git a/migration/ram.c b/migration/ram.c
>> > > index 8c7886ab79..f7a42feff2 100644
>> > > --- a/migration/ram.c
>> > > +++ b/migration/ram.c
>> > > @@ -2059,17 +2059,42 @@ static int ram_save_target_page_legacy(RAMSt=
ate *rs, PageSearchStatus *pss)
>> > >      if (save_zero_page(rs, pss, offset)) {
>> > >          return 1;
>> > >      }
>> > > -
>> > >      /*
>> > > -     * Do not use multifd in postcopy as one whole host page should=
 be
>> > > -     * placed.  Meanwhile postcopy requires atomic update of pages,=
 so even
>> > > -     * if host page size =3D=3D guest page size the dest guest duri=
ng run may
>> > > -     * still see partially copied pages which is data corruption.
>> > > +     * Do not use multifd for:
>> > > +     * 1. Compression as the first page in the new block should be =
posted out
>> > > +     *    before sending the compressed page
>> > > +     * 2. In postcopy as one whole host page should be placed
>> > >       */
>> > > -    if (migrate_multifd() && !migration_in_postcopy()) {
>> > > +    if (!migrate_compress() && migrate_multifd() && !migration_in_p=
ostcopy()) {
>> > > +        return ram_save_multifd_page(pss->pss_channel, block, offse=
t);
>> > > +    }
>> >
>> > This could go into ram_save_target_page_multifd like so:
>> >
>> > if (!migrate_compress() && !migration_in_postcopy() && !migration_main=
_zero_page()) {
>> >     return ram_save_multifd_page(pss->pss_channel, block, offset);
>> > } else {
>> >   return ram_save_target_page_legacy();
>> > }
>> >
>> > > +
>> > > +    return ram_save_page(rs, pss);
>> > > +}
>> > > +
>> > > +/**
>> > > + * ram_save_target_page_multifd: save one target page
>> > > + *
>> > > + * Returns the number of pages written
>> > > + *
>> > > + * @rs: current RAM state
>> > > + * @pss: data about the page we want to send
>> > > + */
>> > > +static int ram_save_target_page_multifd(RAMState *rs, PageSearchSta=
tus *pss)
>> > > +{
>> > > +    RAMBlock *block =3D pss->block;
>> > > +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BI=
TS;
>> > > +    int res;
>> > > +
>> > > +    if (!migration_in_postcopy()) {
>> > >          return ram_save_multifd_page(pss->pss_channel, block, offse=
t);
>> > >      }
>> > >
>> > > +    res =3D save_zero_page(rs, pss, offset);
>> > > +    if (res > 0) {
>> > > +        return res;
>> > > +    }
>> > > +
>> > >      return ram_save_page(rs, pss);
>> > >  }
>> > >
>> > > @@ -2982,9 +3007,15 @@ static int ram_save_setup(QEMUFile *f, void *=
opaque)
>> > >      }
>> > >
>> > >      migration_ops =3D g_malloc0(sizeof(MigrationOps));
>> > > -    migration_ops->ram_save_target_page =3D ram_save_target_page_le=
gacy;
>> > > +
>> > > +    if (migrate_multifd() && !migrate_use_main_zero_page()) {
>> > > +        migration_ops->ram_save_target_page =3D ram_save_target_pag=
e_multifd;
>> > > +    } else {
>> > > +        migration_ops->ram_save_target_page =3D ram_save_target_pag=
e_legacy;
>> > > +    }
>> >
>> > This should not check main-zero-page. Just have multifd vs. legacy and
>> > have the multifd function defer to _legacy if main-zero-page or
>> > in_postcopy.
>>
>> I noticed that ram_save_target_page_legacy and
>> ram_save_target_page_multifd have a lot of overlap and are quite
>> confusing. I can refactor this path and take-in your comments here.
>>
>> 1) Remove ram_save_multifd_page() call from
>> ram_save_target_page_legacy(). ram_save_multifd_page() will only be
>> called in ram_save_target_page_multifd().
>> 2) Remove save_zero_page() and ram_save_page() from
>> ram_save_target_page_multifd().
>> 3) Postcopy will always go with the ram_save_target_page_legacy() path.
>> 4) Legacy compression will always go with the
>> ram_save_target_page_legacy() path.
>> 5) Call ram_save_target_page_legacy() from within
>> ram_save_target_page_multifd() if postcopy or legacy compression.
>>
>
> Hi Fabiano,
> So I spent some time reading the
> ram_save_target_page_legacy/ram_save_target_page_multifd code path
> Juan wrote and here is my current understanding:
> 1) Multifd and legacy compression are not compatible.
> 2) Multifd and postcopy are not compatible.
> The compatibility checks are implemented in migrate_caps_check(). So
> there is really no need to handle a lot of the complexity in Juan's
> code.
>
> I think what we can do is:
> 1) If multifd is enabled, use ram_save_target_page_multifd().
> Otherwise, use ram_save_target_page_legacy().
> 2) In ram_save_target_page_legacy(), we don't need the special path to
> call ram_save_multifd_page(). That can be handled by
> ram_save_target_page_multifd() alone.
> 3) In ram_save_target_page_multifd(), we assert that legacy
> compression is not enabled. And we also assert that postcopy is also
> not enabled.
> 4) We do need backward compatibility support for the main zero page
> checking case in multifd. So in ram_save_target_page_multifd(), we
> call save_zero_page() if migrate_multifd_zero_page() is false.
>

Sounds good. Could you apply those changes and the capability we
discussed in the other message and send a separate series?  I haven't
found the time to work on this yet.


