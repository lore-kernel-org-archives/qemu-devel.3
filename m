Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DB1CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdDA-0004F6-LV; Thu, 28 May 2026 12:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSdCy-0004BY-8C
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSdCu-0003gs-Pt
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779984219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+YR5JQziASzLevYpZipyy8jTxRIMk5d78Gn1FUvW+Y=;
 b=G9lhL5o9NpQO31O/ttO5h9hKreuYOB4Nha+5SIXjBGhXLG30QQIlHYq1+nIYdVFK1owvm0
 S7JA2Fome9q4GkrDVnhAON8PH7s7WJWQC9/cocXEN+qBcMVp3pu5qUrPvpeisZs+eKI9ZN
 F/SQQc9a4ffvHpwzs41047e+y+aAxpA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-W7pXx9nKMFmGGraMdWHp_Q-1; Thu, 28 May 2026 12:03:36 -0400
X-MC-Unique: W7pXx9nKMFmGGraMdWHp_Q-1
X-Mimecast-MFC-AGG-ID: W7pXx9nKMFmGGraMdWHp_Q_1779984216
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4856ddc73acso1859970b6e.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779984215; x=1780589015; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C+YR5JQziASzLevYpZipyy8jTxRIMk5d78Gn1FUvW+Y=;
 b=sKr12mV+oH1iJaqUJDbR04m6mQye7HOGdlL5syNTOZ0WG3+GoehEJh2NL/LgWALC5i
 MqOkhpehP3n+JPfd5psUEEYZpVZrXX7dZo52TlBWVMef97Bi7Tt034QHX5+OkTv2bxm6
 xnwAm3nysSId3KQYT6uyqmXyI+3OQ2/7S3hTvF77sXc0dSSfJ74ePeGzFnD/+AGHasbb
 bLQZtLXNyM7gy0MTgbW1YzbGqxKbJKLxsQGIVeCW4lEDtMHjtuE7T13XRIeQ1Y+5hz4U
 sXX6wRNni0pENSDXiRpc/S90NXSAi2KXg0JzOdTloHb56TMGtGi5CARPH48YDV7DPaEp
 R82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984215; x=1780589015;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C+YR5JQziASzLevYpZipyy8jTxRIMk5d78Gn1FUvW+Y=;
 b=j3ykWZk6rTngS1kWLLlnNfBpoI2ck2eSp6pld9jiUMjHgEYkvIlrPruf+VaZLgFyC4
 BMqXl+jf5Av6AN7ohhOSH3r5aVxBKR+qN7HFCy6EhtHSM+zS6zfiG7uCNYpKFuy4exMT
 Gbwfpn9Z1i/D/klMrdS8FFIz0258UQQPx9YRVkVOpsEL3vjsl+JnL8T4/JAtODpbfbEV
 CuGPLFtqu2QzheBoTXpG8wwIZ2yk6EDoB+LLAn5D5r8vPXk9rx8l9eW3+betBJ5QACt8
 WlL0DyX+8jIdXksBJ5zQNyP+7f7sOn68RfSX6pHb5RqYSeox5x/QHQVX29ZKE1F39IRp
 Xl9w==
X-Gm-Message-State: AOJu0YySpsftpgic4nYziu5lDbP6ac756+BBYYYYVgqjRvnHifRwJqwy
 gxJvbNyI8xqK1/ROOjRzFTR10g4jkqm8pujRE1YN5eYeD1ly1sOg5D0atffXGxvm+9oT2eCtM1u
 krVMQYfCfyv7ztRLPnvZMMfnVJR7fqm8nPdryumPo86C83txxCwG7MLVg
X-Gm-Gg: Acq92OGzq4kjWsqWz1M5/u/xiWUjnfxBQ9+PN1UbYjRtrWVIlbp3iHTu3BTZBMT+VfO
 neuLCKSG2X7L0Yu5H1sjL5B+21ZDsiQeemwqxRjqlz3mIou3BYPAqIPqge7zdkMYnrQ7tl6PEAG
 hvs1nD7sU3WYQyWQtJcXI9e2WkBa4IvlZ5aEV5DPu04hKEPj/Wv1oZ3ZGrmFhFO3DhiyS0Diyzx
 s1N8q/acJtAB6hMZMjSTeYaWzG7PdsmvZVMbg2AlvhfYzsKFIUR+Qop6a7BW2vPSnLMqt/7OSJw
 EmFjUvhVGRm2znZ56+f2HMM+kZHJJMSZCkux/mgJw/J2FOqfiVz5UYpNVDlnOYI6mxZmha8fgmF
 SV4FZUwKPAFHg4T19tMavLTeTNO2rZC5TdCncdWKfZt87rb9+byo0nGtNfA==
X-Received: by 2002:a05:6808:238f:b0:485:29ad:d1ab with SMTP id
 5614622812f47-4854a2242aemr14937497b6e.36.1779984215348; 
 Thu, 28 May 2026 09:03:35 -0700 (PDT)
X-Received: by 2002:a05:6808:238f:b0:485:29ad:d1ab with SMTP id
 5614622812f47-4854a2242aemr14937436b6e.36.1779984214492; 
 Thu, 28 May 2026 09:03:34 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706b0bad4sm78143351cf.31.2026.05.28.09.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:03:33 -0700 (PDT)
Date: Thu, 28 May 2026 12:03:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] system/physmem: Synchronize ram_list accesses
Message-ID: <ahhnUz0Il0nRvhoz@x1.local>
References: <20260523-tsan-v1-1-07d5eb9dcaa2@rsg.ci.i.u-tokyo.ac.jp>
 <ahYSO98JgdYJrP2e@x1.local>
 <8d81e622-1397-4579-bbe5-50ee174a3272@rsg.ci.i.u-tokyo.ac.jp>
 <ahhcvqnOWEoYmCJF@x1.local>
 <b4f87ec7-0406-430e-b645-0539a5e083be@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4f87ec7-0406-430e-b645-0539a5e083be@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 29, 2026 at 12:32:18AM +0900, Akihiko Odaki wrote:
> 
> 
> On 2026/05/29 0:18, Peter Xu wrote:
> > On Wed, May 27, 2026 at 04:54:42PM +0900, Akihiko Odaki wrote:
> > > On 2026/05/27 6:35, Peter Xu wrote:
> > > > On Sat, May 23, 2026 at 09:38:28PM +0900, Akihiko Odaki wrote:
> > > > > Alex Bennée reported a ThreadSanitizer warning about a plain concurrent
> > > > > access to ram_list [1]. Ensure the concurrent accesses to ram_list are
> > > > > properly synchronized with atomic accesses, mutexes, or RCU.
> > > > > 
> > > > > First, the plain assignments of ram_list.mru_block are replaced with
> > > > > qatomic_set(). A comment in qemu_get_ram_block() explains why the
> > > > > ordering requirement is relaxed, but it still needs to be atomically
> > > > > accessed. include/qemu/atomic.h says:
> > > > > 
> > > > > > The C11 memory model says that variables that are accessed from
> > > > > > different threads should at least be done with __ATOMIC_RELAXED
> > > > > > primitives or the result is undefined. Generally this has little to
> > > > > > no effect on the generated code but not using the atomic primitives
> > > > > > will get flagged by sanitizers as a violation.
> > > > > 
> > > > > Second, ram_list.version accesses are replaced with atomic operations
> > > > > or protected with a mutex. Unlike ram_list.mru_block, ram_list.version
> > > > > has tighter ordering requirements for one of its goals: ensuring that
> > > > > the reader-held rs->last_seen_block value is invalidated whenever a RAM
> > > > > block is reclaimed between two RCU reader critical sections. Below are
> > > > > steps a reader and an updater follow:
> > > > > 
> > > > > Reader:
> > > > > 
> > > > > R-1. Enter the first RCU read-side critical section:
> > > > > R-1-1. rs->last_version = qatomic_load_acquire(&ram_list.version)
> > > > > R-1-2. rs->last_seen_block = an element of ram_list.blocks
> > > > > R-2. Enter the second RCU read-side critical section:
> > > > > R-2-1. if (qatomic_read(&ram_list.version) != rs->last_version)
> > > > > R-2-2.     rs->last_seen_block = NULL
> > > > > 
> > > > > Updater:
> > > > > 
> > > > > W-1. Enter a ram_list.mutex critical section
> > > > > W-1-1. Update ram_list.blocks
> > > > > W-1-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
> > > > > W-2. Enter another ram_list.mutex critical section
> > > > > W-2-1. QLIST_REMOVE_RCU(block, next)
> > > > > W-2-2. qatomic_store_release(&ram_list.version, ram_list.version + 1)
> > > > > W-2-3. call_rcu(block, reclaim_ramblock, rcu)
> > > > > 
> > > > > W-1-2 represents the write observed by R-1-1.
> > > > > 
> > > > > ram_list.version is read non-atomically on the update side because the
> > > > > update side is serialized with ram_list.mutex. The other ram_list
> > > > > accesses in these steps are reasoned about in two cases.
> > > > > 
> > > > > When the grace period of W-2-3 contains R-2:
> > > > >       qatomic_load_acquire() at R-1-1 and qatomic_store_release() at W-1-2
> > > > >       enforce the following ordering:
> > > > >           W-1-1 -> W-1-2 -> R-1-1 -> R-1-2
> > > > >       The value of ram_list.blocks stored by W-1-1 or a newer value that
> > > > >       was loaded by R-1-2 is still valid because of the grace period.
> > > > > 
> > > > > When the grace period of W-2-3 ends before R-2:
> > > > >       call_rcu() at W-2-3 and the read-side critical section at R-2 ensure
> > > > >       the following ordering:
> > > > >           W-2-2 -> W-2-3 -> the grace period -> R-2 -> R-2-1
> > > > >       The value of ram_list.version stored by W-2-2 or a newer value that
> > > > >       was loaded by R-2-1 differs from rs->last_version and the reader
> > > > >       invalidates rs->last_seen_block.
> > > > > 
> > > > > Together, these steps ensure that rs->last_seen_block is invalidated
> > > > > whenever necessary. With added atomic operations, pre-existing memory
> > > > > barriers are no longer necessary and are removed.
> > > > > 
> > > > > Any other ram_list accesses are already properly synchronized.
> > > > > 
> > > > > [1] https://lore.kernel.org/qemu-devel/878q9fbmap.fsf@draig.linaro.org/
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > > 
> > > > Above link [1] also mentioned about a hang.  Just to double check: we're
> > > > only trying to silent the TSAN warning (which is a false positive), right?
> > > 
> > > The hang is irrelevant and this is indeed to address the TSAN warning,
> > > though I'm a bit reluctant to call it false positive because, strictly
> > > speaking, the code actually relies on undefined behavior.
> > > 
> > > > 
> > > > > ---
> > > > >    migration/ram.c  | 10 +++++-----
> > > > >    system/physmem.c | 16 +++++++---------
> > > > >    2 files changed, 12 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > > index fc38ffbf8af1..6da24d725861 100644
> > > > > --- a/migration/ram.c
> > > > > +++ b/migration/ram.c
> > > > > @@ -2495,7 +2495,10 @@ static void ram_state_reset(RAMState *rs)
> > > > >        rs->last_seen_block = NULL;
> > > > >        rs->last_page = 0;
> > > > > -    rs->last_version = ram_list.version;
> > > > > +
> > > > > +    /* Read version before ram_list.blocks */
> > > > > +    rs->last_version = qatomic_load_acquire(&ram_list.version);
> > > > > +
> > > > >        rs->xbzrle_started = false;
> > > > >        ram_page_hint_reset(&rs->page_hint);
> > > > > @@ -3270,13 +3273,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> > > > >         */
> > > > >        WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
> > > > >            WITH_RCU_READ_LOCK_GUARD() {
> > > > > -            if (ram_list.version != rs->last_version) {
> > > > > +            if (qatomic_read(&ram_list.version) != rs->last_version) {
> > > > >                    ram_state_reset(rs);
> > > > >                }
> > > > 
> > > > Not directly relevant to this patch, but I never thought into why this few
> > > > lines are needed at all, and then I found I don't have an answer..
> > > > 
> > > > Here, ram_list version change should only happen during ramblock
> > > > add/remove.  I can think of a few special cases:
> > > > 
> > > > a) device add/remove (e.g. dimms) causing new / removing ramblocks, should
> > > >      never happen as qdev code fails any device add/remove attempt during
> > > >      migration (qdev_device_add_from_qdict, qdev_unplug)
> > > > 
> > > > b) virtio-mem, which only manages one memory backend, hence one ramblock,
> > > >      no add/remove
> > > > 
> > > > c) virtio-gpu, will do random add/remove with memory_region_init_ram_ptr()
> > > >      which means ramblocks are not migratable
> > > > 
> > > > PS: I recall we have other special cases like ROM sizes can change on dest
> > > > QEMU, but it's about used_length, not about version boosts, so doesn't
> > > > matter here.
> > > > 
> > > > Both a) and b) should make sure no change on version, c) will change
> > > > version, but in a case where the ramblock is destined to be not migratable,
> > > > hence not visible to migration core.
> > > > 
> > > > The patch itself looks all fine, but I'm just wondering if we should just
> > > > remove this check completely or even try to somehow trap it from happening
> > > > (if we can rule out things like virtio-gpu): if something really changed,
> > > > it'll be a serious problem because we sync ramblock list already during
> > > > ram_save_setup.
> > > 
> > > There is another edge case: a ram_list.blocks change may be propagated to
> > > the thread calling ram_save_setup() and ram_save_iterate() at different
> > > timing. We are only ensuring that ram_list.blocks changes invalidating old
> > > blocks are delivered with WITH_RCU_READ_LOCK_GUARD().
> > > 
> > > So I think there is a theoretical race condition that breaks migration,
> > > though triggering it in practice may not be realistic.
> > 
> > Could you elaborate more on the theoretical race mentioned?
> > 
> > My comment above was trying to say there should have no such happening, the
> > virtio-gpu boosting the version seems to be an accident to me because
> > migration doesn't need that (because virtio-gpu ramblocks are not
> > migratable anyway).
> 
> For example, a device may be removed before migration, but the removal of
> the block from ram_list.blocks and the increment of ram_list.version may not
> be observed by the thread calling ram_save_setup(); RCU only guarantees that
> these writes will be visible in read-side critical sections *after* the
> grace period ends, which can be after the ram_save_setup() call and before
> following ram_save_iterate() calls.

Ah. I think it should be fine, since save_setup() holds BQL, done by all
callers when invoking qemu_savevm_state_do_setup().  I expect removal of a
device needs BQL too while invoking qemu_ram_free(), so serialized with it.

The other thing is, very early we'll set MIGRATION_STATUS_SETUP, covering
both save_setup() and save_iterate(), so things will start to get blocked
very early too.

OTOH, any comments on below?

Thanks,

> 
> Regards,
> Akihiko Odaki
> 
> > 
> > While looking at this once more, I found that I'm lost why mru_block is
> > race free..
> > 
> > The problem is mru_block is written by the RCU readers, then... see whether
> > this race can happen (even with this patch):
> > 
> >    Reader A                              Writer
> >    --------                              ------
> >    rcu_read_lock()
> >    walk list, find block X
> >                                          QLIST_REMOVE_RCU(X)
> >                                          qatomic_set(&mru_block, NULL)
> >                                          call_rcu(X, reclaim_ramblock)
> >    qatomic_set(&mru_block, X)  <----------- overwrites NULL
> >    rcu_read_unlock()
> >                                          grace period ends, X freed
> > 
> >    Reader C
> >    --------
> >    rcu_read_lock()
> >    qatomic_rcu_read(&mru_block) -> X
> >    Read X's block->offset ...  <----------- UAF
> > 
> > One thing I can think of so far is this (pesudo code only, ignoring atomic
> > ops for now):
> > 
> > qemu_ram_free():
> >      qemu_mutex_lock_ramlist();
> >      ...
> >      QLIST_REMOVE_RCU(block, next);
> >      /*
> >       * 1st attempt to reset it, note: concurrent reader may set it again,
> >       * even to the ramblock being freed.
> >       */
> >      ram_list.mru_block = NULL;
> >      ram_list.version++;
> >      /*
> >       * Only to make sure whoever might be using this ramblock being
> >       * removed to finish using it.
> >       */
> >      call_rcu(block, rcu_noop_fn, rcu);
> >      drain_call_rcu();
> >      /*
> >       * 2nd attempt to clear it: after call_rcu() we make sure nobody yet
> >       * has access to the ramblock being removed, hence this clear makes
> >       * sure it won't get set again by anyone to the removed ramblock.
> >       */
> >      ram_list.mru_block = NULL;
> >      call_rcu(block, reclaim_ramblock, rcu);
> >      qemu_mutex_unlock_ramlist();
> > 
> > But it looks a bit ugly.  Thoughts?
> > 
> > Thanks,
> > 
> 

-- 
Peter Xu


