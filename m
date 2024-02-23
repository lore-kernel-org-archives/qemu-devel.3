Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA34C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdWmK-0005Oz-8V; Fri, 23 Feb 2024 09:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdWgy-0004Yv-65
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:38:24 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdWgw-0002fj-26
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:38:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C6F621EFD;
 Fri, 23 Feb 2024 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708699100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy9u19WtuGN34285HK6n9KImIsJ5Jj6gq6oG1yo2U3E=;
 b=oBoUOZG/R7J8I+RC3SSs47/7crbzTxqKKrij2VqaP4TZiJ37vhyJmkShGLEvBxXgR/c6ID
 iya0JnAmE/+xPITC98ho4SYAb2uKgPUecphwtlrWwnfHJrlVxmqW9afk7glDwZCTTgyhvN
 C1r/rSNokfwmUWcYqEZD6o1Hc1YGKoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708699100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy9u19WtuGN34285HK6n9KImIsJ5Jj6gq6oG1yo2U3E=;
 b=HsmbGWbQJUivwGTcIc/7A5TZyaE1LkweZb5XB1FgWndgTxmyPo9XCx6KaehhzX23/4jtzE
 tiw45aqYCo4yweBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708699100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy9u19WtuGN34285HK6n9KImIsJ5Jj6gq6oG1yo2U3E=;
 b=oBoUOZG/R7J8I+RC3SSs47/7crbzTxqKKrij2VqaP4TZiJ37vhyJmkShGLEvBxXgR/c6ID
 iya0JnAmE/+xPITC98ho4SYAb2uKgPUecphwtlrWwnfHJrlVxmqW9afk7glDwZCTTgyhvN
 C1r/rSNokfwmUWcYqEZD6o1Hc1YGKoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708699100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy9u19WtuGN34285HK6n9KImIsJ5Jj6gq6oG1yo2U3E=;
 b=HsmbGWbQJUivwGTcIc/7A5TZyaE1LkweZb5XB1FgWndgTxmyPo9XCx6KaehhzX23/4jtzE
 tiw45aqYCo4yweBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0ADE133DC;
 Fri, 23 Feb 2024 14:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N+FKHdut2GVIFgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Feb 2024 14:38:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, qemu-devel@nongnu.org, jdenemar@redhat.com
Subject: Re: [External] Re: [PATCH v2 4/7] migration/multifd: Enable zero
 page checking from multifd threads.
In-Reply-To: <CAAYibXhGx=m8wbGMbpfy4vMQAQURaemLFOvCDEAMeGUiLXDfdg@mail.gmail.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com>
 <875xyhbk8k.fsf@suse.de>
 <CAAYibXhGx=m8wbGMbpfy4vMQAQURaemLFOvCDEAMeGUiLXDfdg@mail.gmail.com>
Date: Fri, 23 Feb 2024 11:38:17 -0300
Message-ID: <877civ9rfq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="oBoUOZG/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HsmbGWbQ
X-Spamd-Result: default: False [-4.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3C6F621EFD
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

> On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Fabiano Rosas <farosas@suse.de> w=
rote:
>>
>> Hao Xiang <hao.xiang@bytedance.com> writes:
>>
>> > This change adds a dedicated handler for MigrationOps::ram_save_target=
_page in
>>
>> nit: Add a dedicated handler...
>>
>> Usually "this patch/change" is used only when necessary to avoid
>> ambiguity.
>
> Will do.
>
>>
>> > multifd live migration. Now zero page checking can be done in the mult=
ifd threads
>> > and this becomes the default configuration. We still provide backward =
compatibility
>> > where zero page checking is done from the migration main thread.
>> >
>> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> > ---
>> >  migration/multifd.c |  1 +
>> >  migration/options.c |  2 +-
>> >  migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++-----------
>> >  3 files changed, 42 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index fbb40ea10b..ef5dad1019 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -13,6 +13,7 @@
>> >  #include "qemu/osdep.h"
>> >  #include "qemu/cutils.h"
>>
>> This include...
>>
>> >  #include "qemu/rcu.h"
>> > +#include "qemu/cutils.h"
>>
>> is there already.
>>
>> >  #include "exec/target_page.h"
>> >  #include "sysemu/sysemu.h"
>> >  #include "exec/ramblock.h"
>> > diff --git a/migration/options.c b/migration/options.c
>> > index 3c603391b0..3c79b6ccd4 100644
>> > --- a/migration/options.c
>> > +++ b/migration/options.c
>> > @@ -181,7 +181,7 @@ Property migration_properties[] =3D {
>> >                        MIG_MODE_NORMAL),
>> >      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationS=
tate,
>> >                         parameters.zero_page_detection,
>> > -                       ZERO_PAGE_DETECTION_LEGACY),
>> > +                       ZERO_PAGE_DETECTION_MULTIFD),
>>
>> I think we'll need something to avoid a 9.0 -> 8.2 migration with this
>> enabled. Otherwise it will go along happily until we get data corruption
>> because the new QEMU didn't send any zero pages on the migration thread
>> and the old QEMU did not look for them in the multifd packet.
>>
>> Perhaps bumping the MULTIFD_VERSION when ZERO_PAGE_DETECTION_MULTIFD is
>> in use. We'd just need to fix the test in the new QEMU to check
>> (msg.version > MULTIFD_VERSION) instead of (msg.version !=3D MULTIFD_VER=
SION).
>>
>> >
>> >      /* Migration capabilities */
>> >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>> > diff --git a/migration/ram.c b/migration/ram.c
>> > index 5ece9f042e..b088c5a98c 100644
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSea=
rchStatus *pss,
>> >      QEMUFile *file =3D pss->pss_channel;
>> >      int len =3D 0;
>> >
>> > -    if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_LEGACY=
) {
>> > -        return 0;
>> > -    }
>>
>> How does 'none' work now?
>
> I tested it and all pages are transferred with payload (including the
> zero pages).
>
>>
>> > -
>> >      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>> >          return 0;
>> >      }
>> > @@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSear=
chStatus *pss)
>> >
>> >  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
>> >  {
>> > +    assert(migrate_multifd());
>> > +    assert(!migrate_compress());
>> > +    assert(!migration_in_postcopy());
>>
>> Drop these, please. Keep only the asserts that are likely to trigger
>> during development, such as the existing ones at multifd_send_pages.
>
> I think I have got enough feedback regarding too many asserts. I will
> drop these. assert is not compiled into the free build, correct?
>

From include/qemu/osdep.h:

  /*
   * We have a lot of unaudited code that may fail in strange ways, or
   * even be a security risk during migration, if you disable assertions
   * at compile-time.  You may comment out these safety checks if you
   * absolutely want to disable assertion overhead, but it is not
   * supported upstream so the risk is all yours.  Meanwhile, please
   * submit patches to remove any side-effects inside an assertion, or
   * fixing error handling that should use Error instead of assert.
   */
  #ifdef NDEBUG
  #error building with NDEBUG is not supported
  #endif
  #ifdef G_DISABLE_ASSERT
  #error building with G_DISABLE_ASSERT is not supported
  #endif

>>
>> > +
>> >      if (!multifd_queue_page(block, offset)) {
>> >          return -1;
>> >      }
>> > @@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, Pag=
eSearchStatus *pss,
>> >   */
>> >  static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus=
 *pss)
>> >  {
>> > -    RAMBlock *block =3D pss->block;
>> >      ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>> >      int res;
>> >
>> > @@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMStat=
e *rs, PageSearchStatus *pss)
>> >          return 1;
>> >      }
>> >
>> > +    return ram_save_page(rs, pss);
>>
>> Look at where git put this! Are you using the default diff algorithm? If
>> not try using --patience to see if it improves the diff.
>
> I used the default diff algorithm.
>
>>
>> > +}
>> > +
>> > +/**
>> > + * ram_save_target_page_multifd: save one target page
>> > + *
>> > + * Returns the number of pages written
>>
>> We could be more precise here:
>>
>>  ram_save_target_page_multifd: send one target page to multifd workers
>>
>>  Returns 1 if the page was queued, -1 otherwise.
>
> Will do.
>
>>
>> > + *
>> > + * @rs: current RAM state
>> > + * @pss: data about the page we want to send
>> > + */
>> > +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatu=
s *pss)
>> > +{
>> > +    RAMBlock *block =3D pss->block;
>> > +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>> > +
>> > +    /* Multifd is not compatible with old compression. */
>> > +    assert(!migrate_compress());
>>
>> This should already be enforced at options.c.
>>
>> > +
>> > +    /* Multifd is not compabible with postcopy. */
>> > +    assert(!migration_in_postcopy());
>>
>> Same here.
>>
>> > +
>> >      /*
>> > -     * Do not use multifd in postcopy as one whole host page should be
>> > -     * placed.  Meanwhile postcopy requires atomic update of pages, s=
o even
>> > -     * if host page size =3D=3D guest page size the dest guest during=
 run may
>> > -     * still see partially copied pages which is data corruption.
>> > +     * Backward compatibility support. While using multifd live
>> > +     * migration, we still need to handle zero page checking on the
>> > +     * migration main thread.
>> >       */
>> > -    if (migrate_multifd() && !migration_in_postcopy()) {
>> > -        return ram_save_multifd_page(block, offset);
>> > +    if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_LEGA=
CY) {
>> > +        if (save_zero_page(rs, pss, offset)) {
>> > +            return 1;
>> > +        }
>> >      }
>> >
>> > -    return ram_save_page(rs, pss);
>> > +    return ram_save_multifd_page(block, offset);
>> >  }
>> >
>> >  /* Should be called before sending a host page */
>> > @@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *op=
aque)
>> >      }
>> >
>> >      migration_ops =3D g_malloc0(sizeof(MigrationOps));
>> > -    migration_ops->ram_save_target_page =3D ram_save_target_page_lega=
cy;
>> > +
>> > +    if (migrate_multifd()) {
>> > +        migration_ops->ram_save_target_page =3D ram_save_target_page_=
multifd;
>> > +    } else {
>> > +        migration_ops->ram_save_target_page =3D ram_save_target_page_=
legacy;
>> > +    }
>> >
>> >      bql_unlock();
>> >      ret =3D multifd_send_sync_main();

