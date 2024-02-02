Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6019C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 12:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVsSd-0002hQ-IW; Fri, 02 Feb 2024 07:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVsSV-0002gg-1F
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 07:15:53 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVsSH-0001ph-84
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 07:15:50 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7790922096;
 Fri,  2 Feb 2024 12:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706876135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNykqSs8ZgjBygir2o/EjhAa+DA++vbEsKNj7hYMqFs=;
 b=KRxLfyZrVYtr6+D0Hc5jYPxAvps5yZ01vr4Aq3jdjoauBvAkeAxn/EJ9rODh4KtjTjBagl
 eWezwxGGm8XLZuJh9iYEqXkrUqXtQcjSKU1CraZ2doRBcJbLlNpsz48E2XCRzrb6J4lMNH
 3auYKRBcVWJh+cjjjdeOU1+zW40eCCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706876135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNykqSs8ZgjBygir2o/EjhAa+DA++vbEsKNj7hYMqFs=;
 b=uMXwj3EX251W2yYJFTrgbtn9D/rVfIvheqVIr2bK7/qjIF0URLdDTXQT4HmjsYVhP2wUf9
 WutkfIRQxJ02cyBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706876134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNykqSs8ZgjBygir2o/EjhAa+DA++vbEsKNj7hYMqFs=;
 b=TLMpPgiWsAAKpul5/96NWAQzsL7rm7YS9Ne7Qnn1RcAn6n8PrjMgK19zyjNYNPkV0apMtP
 0JYBrjr4RMI8/ITAP5cIhuS3vywZZStEKmZn0FCpcHFuXFSxny9T4vAHRoJ14b4QCrs9+l
 4+BkN1n8fyIly29xcUln1BviXPV9fME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706876134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNykqSs8ZgjBygir2o/EjhAa+DA++vbEsKNj7hYMqFs=;
 b=mvWYVRjO39Xbmp20Eiv1s+XLfnn/CjPs7ClmabmTErlpSAKYwNski60X3h1+LAa5Mqy7vV
 m9LLxGIWK+SQ4/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 030B413A58;
 Fri,  2 Feb 2024 12:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SCijLuXcvGU+fAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 12:15:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>, Prasad
 Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>, Avihai Horon
 <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 04/14] migration/multifd: Postpone reset of MultiFDPages_t
In-Reply-To: <Zbw5TpO5xOgMSmB5@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-5-peterx@redhat.com> <87wmrpjzew.fsf@suse.de>
 <ZbtsCsBFuMj1fx-q@x1n> <87plxgi51k.fsf@suse.de> <Zbw3P26zfARNBsBy@x1n>
 <Zbw5TpO5xOgMSmB5@x1n>
Date: Fri, 02 Feb 2024 09:15:31 -0300
Message-ID: <87il37hxjw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Feb 02, 2024 at 08:28:47AM +0800, Peter Xu wrote:
>> > Pages allocated is nonsense. See if you agree with its removal:
>> > https://gitlab.com/farosas/qemu/-/commit/7cfff1a3e31b271e901a6c08d8b5d8c01b680e4d
>> > 
>> > ---
>> > From 7cfff1a3e31b271e901a6c08d8b5d8c01b680e4d Mon Sep 17 00:00:00 2001
>> > From: Fabiano Rosas <farosas@suse.de>
>> > Date: Tue, 24 Oct 2023 19:03:41 -0300
>> > Subject: [PATCH] multifd: Remove MultiFDPage_t:allocated
>> > 
>> > When dealing with RAM, having a field called 'allocated' is
>> > confusing. This field simply holds number of pages that fit in a
>> > multifd packet.
>> > 
>> > Since it is a constant dependent on the size of the multifd packet,
>> > remove it and instead use the page size and MULTIFD_PACKET_SIZE
>> > directly.
>> > 
>> > This is another step in the direction of having no mentions of 'page'
>> > in the multifd send thread.
>> > 
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> >  migration/multifd.c | 6 ++----
>> >  migration/multifd.h | 2 --
>> >  2 files changed, 2 insertions(+), 6 deletions(-)
>> > 
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index bdefce27706..83fb2caab04 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -241,7 +241,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
>> >  {
>> >      MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
>> >  
>> > -    pages->allocated = n;
>> >      pages->offset = g_new0(ram_addr_t, n);
>> >      pages->page_size = qemu_target_page_size();
>> >  
>> > @@ -251,7 +250,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
>> >  static void multifd_pages_clear(MultiFDPages_t *pages)
>> >  {
>> >      pages->num = 0;
>> > -    pages->allocated = 0;
>> >      pages->block = NULL;
>> >      g_free(pages->offset);
>> >      pages->offset = NULL;
>> > @@ -264,7 +262,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>> >      int i;
>> >  
>> >      packet->flags = cpu_to_be32(p->flags);
>> > -    packet->pages_alloc = cpu_to_be32(p->pages->allocated);
>> > +    packet->pages_alloc = cpu_to_be32(MULTIFD_PACKET_SIZE / p->pages->page_size);
>> >      packet->normal_pages = cpu_to_be32(p->pages->num);
>> >      packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>> >      packet->packet_num = cpu_to_be64(p->packet_num);
>> > @@ -451,7 +449,7 @@ int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
>> >          pages->offset[pages->num] = offset;
>> >          pages->num++;
>> >  
>> > -        if (pages->num < pages->allocated) {
>> > +        if (pages->num * pages->page_size < MULTIFD_PACKET_SIZE) {
>> >              return 1;
>> >          }
>> >      } else {
>> > diff --git a/migration/multifd.h b/migration/multifd.h
>> > index 655f8d5eeb4..d1342296d63 100644
>> > --- a/migration/multifd.h
>> > +++ b/migration/multifd.h
>> > @@ -56,8 +56,6 @@ typedef struct {
>> >  typedef struct {
>> >      /* number of used pages */
>> >      uint32_t num;
>> > -    /* number of allocated pages */
>> > -    uint32_t allocated;
>> >      /* guest page size */
>> >      uint32_t page_size;
>> >      /* offset of each page */
>> > -- 
>> 
>> I agree.
>> 
>> Even if we would like to add a parameter to setup the allcated size (I
>> remember one of the accelerator series has it), it'll still be a global
>> variable rather than per-pages thing.
>> 
>> I can cherry pick this and post together; will need a rebase but I can do
>> that.
>
> I see a slight step back here when rebase, since we'll calculate n_pages
> every time to enqueue the page:
>
> static inline bool multifd_queue_full(MultiFDPages_t *pages)
> {
>     return pages->num == (MULTIFD_PACKET_SIZE / pages->page_size);
> }
>
> The "allocated" is still good to cache the value.  Fabiano, would it make
> sense we still use a global var (perhaps in multifd_save_state?) to cache
> this?

Yep.

>
> I'll leave this alone as of now I think, but again I agree we should have
> something similar.

Ok, no problem. I can change this at another time.

