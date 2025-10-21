Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05629CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHQm-0002Ap-4F; Tue, 21 Oct 2025 14:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHQk-0002Ah-Hz
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHQg-0004zj-W3
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761072592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JqFBRVGjJf/rrw3qfdp0iTwufRk+FLar0YbWHZeaWXM=;
 b=cKhUOcFCm1aTBE5vBJEJ6rul6Lxfinu56wZn0Siu5TN8GWWmdIN9lsGhRv5YDN5Fi1cuqK
 mq77kTsKJM+HKOAuUPLSczq5DXmWs3eRL2PgINGyVKckjw9BW5WT7+YvCUpHJzxDnNgRRh
 oRoxx37nMZx1PqTJEinSVJAg5PfajMk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-EMmOkjNBNSiWxbgp1ax7Pw-1; Tue, 21 Oct 2025 14:49:50 -0400
X-MC-Unique: EMmOkjNBNSiWxbgp1ax7Pw-1
X-Mimecast-MFC-AGG-ID: EMmOkjNBNSiWxbgp1ax7Pw_1761072590
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-87c171369aaso6382316d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761072590; x=1761677390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqFBRVGjJf/rrw3qfdp0iTwufRk+FLar0YbWHZeaWXM=;
 b=IOo7ldEmLsYEt4EVv9X5KpWfanzlCmJDbxD8Ac4dLofziyq1Wm60xTmba7piDe5B7e
 gGBHFTddxD2LjBJqYlgiCmo/jtQ1+pCmlhy7CzMZV0QtcoV2vAV58NNaGoJC2+F3Jzie
 0dsyHfYviBKYIE+bunIEWFk+SotfsSeb7uPCKAlIXiTnC2mmqODo1UBB1ywKbfazVAFm
 uYxqvcG9SMDGqaPQK6gE8iEfTfiZjIQ+uveEiZbRwjLLdPgbxPKilXfiaRvaN6J8w7uJ
 42MBt9+nb8h+HgeUicfIzhb0mEJpooc4Z/9LUktvr5rPutJqdzR4bwLJs/DhSOKt2Zal
 h1Bw==
X-Gm-Message-State: AOJu0YwKcOMuBAb11hmlyN9BRdeldFF9pFrhrQUWOUjupS4msuVXQISQ
 gr0CNvuP2Vu2FrXWF9I7fhlt/D5twiADzjIVFdhvCNAv4k2c/FDK0fgV9AY6lhZzIOn5UGceJIJ
 LhTj6RGzRcSVMm6BSLJcTCwpufqsYsr8LZM2qdwy08LuJifozKSL/i8uq
X-Gm-Gg: ASbGncsL4DANcpsOXBd7liBS9GHK7KKVVnMCdiaAZCM9sXTJHcMCEmAhiik/zxd7s63
 wDX5byPBzuLa2uN2Kle/8UULZURO7Wy7ewsQRPnS9n6dgG3RwFtuvwm7ZOQ20GfJmgEqICpslB0
 Q+Mb5PzSTvB3CkUj+MAo/KumIVxf7/loknz2TtDhl0h6vcllB8llC9+LI9p4ZA12qcBOBmxJCTS
 2Smi9nWRrRPewVB2mb1LHujPlup2RBrOuBh+yZxPPZFdl97p85YJuv0G5i00l5ghMz3y8za0/QB
 f/aODd+LxpnV6DXxBWBztjAQchPu3tpjA6ugsIXfbN8CDK2jTazbOZDeW1ZJ83Y6fP8=
X-Received: by 2002:a05:6214:5294:b0:78f:48ef:d8c with SMTP id
 6a1803df08f44-87df6748e1cmr9979446d6.22.1761072589834; 
 Tue, 21 Oct 2025 11:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuy37n58n9UQdea+S8Pdhvoa89arv9k22rCfjtCHdQVWt2RLymMGDYMPe8mSuhzXhjOxLPqA==
X-Received: by 2002:a05:6214:5294:b0:78f:48ef:d8c with SMTP id
 6a1803df08f44-87df6748e1cmr9979016d6.22.1761072589267; 
 Tue, 21 Oct 2025 11:49:49 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87cf51fcd39sm73678546d6.6.2025.10.21.11.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:49:48 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:49:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
Message-ID: <aPfVymCqfnsSc_0M@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-6-peterx@redhat.com>
 <a7f72cc7-d5ec-4a9e-a1a1-d77f376c5ce4@yandex-team.ru>
 <aLHgmt7vDbmWCS24@x1.local>
 <e54b8dde-1b77-4bbd-aca6-221a747f24d3@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e54b8dde-1b77-4bbd-aca6-221a747f24d3@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 01, 2025 at 12:35:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 29.08.25 20:17, Peter Xu wrote:
> > On Fri, Aug 29, 2025 at 11:29:59AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > For that, qemu_loadvm_state() and qemu_loadvm_state_main() functions need
> > > > to now take a "bql_held" parameter saying whether bql is held.  We could
> > > > use things like BQL_LOCK_GUARD(), but this patch goes with explicit
> > > > lockings rather than relying on bql_locked TLS variable.  In case of
> > > > migration, we always know whether BQL is held in different context as long
> > > > as we can still pass that information downwards.
> > > 
> > > Agree, but I think it's better to make new macros following same pattern, i.e.
> > > 
> > > WITH_BQL_HELD(bql_held) {
> > >      action();
> > > }
> > > 
> > > instead of
> > > 
> > > WITH_BQL_HELD(bql_held, actions());
> > > 
> > > ..
> > > 
> > > Or I'm missing something and we already have a precedent of the latter
> > > notation?
> > 
> > Nop.. it's just that when initially working on that I didn't try as hard to
> > achieve such pattern.  Here we need to recover the BQL status after the
> > block, so I didn't immediately see how autoptr would work there.
> > 
> > But I tried slightly harder, I think below should achieve the same pattern
> > but based on some for() magic.
> > 
> > Thanks for raising this, early comments still be welcomed or I'll go with
> > that.
> > 
> > ===8<===
> > 
> > static inline void
> > with_bql_held_lock(bool bql_held, const char *file, int line)
> > {
> >      assert(bql_held == bql_locked());
> >      if (!bql_held) {
> >          bql_lock_impl(file, line);
> >      }
> > }
> > 
> > static inline void
> > with_bql_held_unlock(bool bql_held)
> > {
> >      assert(bql_locked());
> >      if (!bql_held) {
> >          bql_unlock();
> >      }
> > }
> > 
> > /**
> >   * WITH_BQL_HELD(): Run a block of code, making sure BQL is held
> >   * @bql_held: Whether BQL is already held
> >   *
> >   * Example use case:
> >   *
> >   * WITH_BQL_HELD(bql_held) {
> >   *     // BQL is guaranteed to be held within this block,
> >   *     // if it wasn't held, will be released when the block finishes.
> >   * }
> >   */
> > #define  WITH_BQL_HELD(bql_held)                                \
> >      for (bool _bql_once = \
> >               (with_bql_held_lock(bql_held, __FILE__, __LINE__), true);  \
> >           _bql_once;                                                     \
> >           _bql_once = (with_bql_held_unlock(bql_held), false))           \
> > 
> > static inline void
> > with_bql_released_unlock(bool bql_held)
> > {
> >      assert(bql_held == bql_locked());
> >      if (bql_held) {
> >          bql_unlock();
> >      }
> > }
> > 
> > static inline void
> > with_bql_released_lock(bool bql_held, const char *file, int line)
> > {
> >      assert(!bql_locked());
> >      if (bql_held) {
> >          bql_lock_impl(file, line);
> >      }
> > }
> > 
> > /**
> >   * WITH_BQL_RELEASED(): Run a task, making sure BQL is released
> >   * @bql_held: Whether BQL is already held
> >   *
> >   * Example use case:
> >   *
> >   * WITH_BQL_RELEASED(bql_held) {
> >   *     // BQL is guaranteed to be released within this block,
> >   *     // if it was held, will be re-taken when the block finishes.
> >   * }
> >   */
> > #define  WITH_BQL_RELEASED(bql_held)                                    \
> >      for (bool _bql_once = (with_bql_released_unlock(bql_held), true);   \
> >           _bql_once;                                                     \
> >           _bql_once =                                                    \
> >               (with_bql_released_lock(bql_held, __FILE__, __LINE__), false)) \
> > 
> 
> 
> Hm, still it's doesn't achieve same magic as WITH_QEMU_LOCK_GUARD, as we cant use
> "return" inside this for-loop (may be not critical, as you anyway don't use it..)
> 
> Something like this should work I think:
> 
> static inline BQLLockAutoCond *bql_auto_lock_cond(bool bql_held, const char *file, int line)
> {
>     assert(bql_held == bql_locked());
>     if (bql_held) {
>         return (BQLLockAutoCond *)(uintptr_t)2;
>     }
>     bql_lock_impl(file, line);
>     return (BQLLockAutoCond *)(uintptr_t)1;
> }
> 
> static inline void bql_auto_unlock_cond(BQLLockAutoCond *l)
> {
>     if (l == (BQLLockAutoCond *)(uintptr_t)1) {
>         bql_unlock();
>     }
> }
> 
> G_DEFINE_AUTOPTR_CLEANUP_FUNC(BQLLockAutoCond, bql_auto_unlock_cond)
> 
> #define WITH_BQL_HELD_(bql_held, var) \
>     for (g_autoptr(BQLLockAutoCond) var = \
>              bql_auto_lock_cond(bql_held, __FILE__, __LINE__); \
>          var; \
>          bql_auto_unlock_cond(var), var = NULL)
> 
> #define WITH_BQL_HELD(bql_held) \
>     WITH_BQL_HELD_((bql_held), glue(bql_held_cond_auto, __COUNTER__))

Even though I don't think any of our use case would need an internal
"return" on either of them..  I switched to what you suggested.  Please
have a look at this below and leave early comments if there is. I moved it
out into a standalone patch to make the current patch smaller.

One thing to mention is, to use g_autoptr I cannot pass in FILE/LINE info
into WITH_BQL_RELEASED() anymore trivially.  I can allocate something real
for WithBqlReleaseAuto to keep those, but IMHO that might be an
overkill.. Let me know if you have idea on keeping the info if without
extra overheads.

================8<=================

From 5b0d61034b81d6e67ab6cc317d2edc97965bc6d0 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 21 Oct 2025 10:23:58 -0400
Subject: [PATCH] migration: Introduce WITH_BQL_HELD() / WITH_BQL_RELEASED()

Introduce the helpers to conditionally take or release BQL for a process.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 94 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 01329bf824..5f0d5f9ead 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -42,6 +42,100 @@
 #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
 #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
 
+struct WithBqlHeldAuto;
+typedef struct WithBqlHeldAuto WithBqlHeldAuto;
+
+static inline WithBqlHeldAuto *
+with_bql_held_auto_lock(bool bql_held, const char *file, int line)
+{
+    assert(bql_held == bql_locked());
+    if (!bql_held) {
+        bql_lock_impl(file, line);
+        return (WithBqlHeldAuto *)1;
+    }
+    return (WithBqlHeldAuto *)2;
+}
+
+static inline void
+with_bql_held_auto_unlock(WithBqlHeldAuto *v)
+{
+    assert(bql_locked());
+    if (v == (WithBqlHeldAuto *)1) {
+        bql_unlock();
+    }
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(WithBqlHeldAuto, with_bql_held_auto_unlock);
+
+#define  _WITH_BQL_HELD(bql_held, var)                              \
+    for (g_autoptr(WithBqlHeldAuto) var =                          \
+             with_bql_held_auto_lock(bql_held, __FILE__, __LINE__); \
+         var;                                                       \
+         with_bql_held_auto_unlock(var), var = NULL)                \
+
+/**
+ * WITH_BQL_HELD(): Run a block of code, making sure BQL is held
+ * @bql_held: Whether BQL is already held
+ *
+ * Example use case:
+ *
+ * WITH_BQL_HELD(bql_held) {
+ *     // BQL is guaranteed to be held within this block.
+ *     // If bql_held==false, bql will be released when the block finishes.
+ * }
+ */
+#define  WITH_BQL_HELD(bql_held)                                    \
+    _WITH_BQL_HELD(bql_held, glue(with_bql_held_var, __COUNTER__))
+
+struct WithBqlReleaseAuto;
+typedef struct WithBqlReleaseAuto WithBqlReleaseAuto;
+
+static inline WithBqlReleaseAuto *
+with_bql_release_auto_unlock(bool bql_held)
+{
+    assert(bql_held == bql_locked());
+    if (bql_held) {
+        bql_unlock();
+        return (WithBqlReleaseAuto *)1;
+    }
+    return (WithBqlReleaseAuto *)2;
+}
+
+static inline void
+with_bql_release_auto_lock(WithBqlReleaseAuto *v)
+{
+    assert(!bql_locked());
+    if (v == (WithBqlReleaseAuto *)1) {
+        /*
+         * NOTE: cleanup function cannot take more than 1 argument.  Keep
+         * it simple here by not passing __FILE__/__LINE__ from the caller.
+         */
+        bql_lock_impl(__FILE__, __LINE__);
+    }
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(WithBqlReleaseAuto, with_bql_release_auto_lock);
+
+#define  _WITH_BQL_RELEASED(bql_held, var)              \
+    for (g_autoptr(WithBqlReleaseAuto) var =           \
+             with_bql_release_auto_unlock(bql_held);    \
+         var;                                           \
+         with_bql_release_auto_lock(var), var = NULL)   \
+
+/**
+ * WITH_BQL_RELEASED(): Run a block of code, making sure BQL is release
+ * @bql_held: Whether BQL is already held
+ *
+ * Example use case:
+ *
+ * WITH_BQL_RELEASE(bql_held) {
+ *     // BQL is guaranteed to be release within this block.
+ *     // If bql_held==true, bql will be re-taken when the block finishes.
+ * }
+ */
+#define  WITH_BQL_RELEASED(bql_held)                                    \
+    _WITH_BQL_RELEASED(bql_held, glue(with_bql_release_var, __COUNTER__))
+
 struct PostcopyBlocktimeContext;
 typedef struct ThreadPool ThreadPool;
 
-- 
2.50.1


-- 
Peter Xu


