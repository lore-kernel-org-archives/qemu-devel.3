Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01060CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 16:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHPW7-0006tu-0P; Fri, 07 Nov 2025 11:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vHPW3-0006nk-H0
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 11:40:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vHPW0-0003yq-1v
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 11:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762533640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCvTyjnZPqz5LzgZT1v0dy3W1+4VMW5Ypl+a9M8KYwM=;
 b=IBuhDV2hr4oVxeJO3ethYN+ojvUQu5a9b9F1fhrrTfrrUOZLYb7E3VIaXeYHdU4+Oincak
 S5XqCSk29bxKnJS9dDoiaLYXULHfhBrvmkrgAC8hoPTIX8+GCI4BFowEk2BoRFQYAZ04da
 +BHWj4l0Tr6BEfsaCHls5qJ75g/h4xM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-igBLMXZjNcS1ahCeQf1Y3Q-1; Fri, 07 Nov 2025 11:40:39 -0500
X-MC-Unique: igBLMXZjNcS1ahCeQf1Y3Q-1
X-Mimecast-MFC-AGG-ID: igBLMXZjNcS1ahCeQf1Y3Q_1762533639
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e8984d8833so37866531cf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762533639; x=1763138439; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nCvTyjnZPqz5LzgZT1v0dy3W1+4VMW5Ypl+a9M8KYwM=;
 b=Axl1W5psdgjfbaFL4qiQkfiPvtxfVPpDqVmFpJj3gk9peD9UxNAxCCS2fLKM6yaXbc
 p38eu1+fpZxuJllbQL7F73om4yE29gOlEpVl5xkMf0YrfYUygv/da5oCH+dq8faYQmBg
 oda4X45auJhvctGNp5ley0i4SDCdQYmZVVy6Bud+HRcVnvC9dFTDHi6prWp6no50EYHz
 zqCQ6w0rv8ZOdGjYPrA+OE4ZG+iim+ePycoXWoYpHVsVKSc+SMC3Ce6iG5z//3sTT7Ty
 B9fAPsxLm22lIWqqouhhPfqJJTHmQc/KE7QVyeH/Vruhf+aZ3R1mrAutyMA/8CIbyTWY
 3l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762533639; x=1763138439;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nCvTyjnZPqz5LzgZT1v0dy3W1+4VMW5Ypl+a9M8KYwM=;
 b=oDLtmGE2rU3XMHnR0P/jVnMRXrtvAEiN42stEu8ymz8ldon/3lgbS6LIRr6v51l103
 ncZAAipojf1o9tRNNyOXVC8xLVEQGs3n51Aux74/JM8Kwr8tOXlGsTPRD1VEQ9O/fDUq
 1cf/dRzd+lSLpm76bVzi0hXl/6bHwIlHoxAD3RS7ao0NW5mruz4GsSK4+Si1jOjw4mte
 7CYS4ZQr1en5V9x+naK5F62OoVO5AGrppgtl8uvcxKzo34FU28s5XvHNKS81mR45qOuL
 iwfhc7pxlh5p0xCRSWLGHBxE0CefxI2HdRqlycQmTzeKoVfpBw5eIuXQAKIcuf5isPg3
 qgow==
X-Gm-Message-State: AOJu0YzMECjSYkJywUky2KaTSymveQj9NYacxjuXaQ7FoacGlmTk0ITj
 BUoGCSjuKEwjGOncQgf2pUnElKjDVTGrhgGTsbixwo8ENtN83Tfk2vdRLhF9FkWEFd8XFTxXj5G
 nbZVy86BQjNRDnltXkg5CUn0MCAHq+SUdCddTfjT9iDyRezz7Uv7anA/9
X-Gm-Gg: ASbGncuubOQzD4qg7SqRVwAw3WrTZcMvbMOwyHXVXuOWXkuLcwTMEe0uYxoTVcCazhP
 yy/U4RLt9v7tPMOTvV1pC9IeIbByw5hCXsWRnbwK8REA9lKPdhB0HtTEEf7vcsFgcCko8UPWGgW
 X3YA+Eny+2VUIWHf6sooi9tDEcDluhrKmcm0ROklofOqdXB23CkvMjdnfzB/6R/RNrF/dz0+Xm8
 ozR/nFRHP2HY7YpsqxjrtXIP3egU3wgRD5E3nAAr28OpfFWPYt3oUtrCENqguC0CwQKTIrX45tg
 FhzoWJqoGkl3VVxWditheNmVESlt+oxsMOhyUOtdeKFdazos2uFgIMeL40v6axuuhZ0=
X-Received: by 2002:ac8:584c:0:b0:4e7:2003:3c31 with SMTP id
 d75a77b69052e-4ed9497bfddmr42872541cf.27.1762533638579; 
 Fri, 07 Nov 2025 08:40:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9Q3v1Xz0GuZzbDK56FY9w22i0gAJqUkD4n3lOePCDjVlLbmCuMQhF+OBy+GQdK9rSUpOMMw==
X-Received: by 2002:ac8:584c:0:b0:4e7:2003:3c31 with SMTP id
 d75a77b69052e-4ed9497bfddmr42872131cf.27.1762533637985; 
 Fri, 07 Nov 2025 08:40:37 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed8131d19asm40337041cf.5.2025.11.07.08.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 08:40:37 -0800 (PST)
Date: Fri, 7 Nov 2025 11:40:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] memory: Make FlatView root references weak
Message-ID: <aQ4g_UsDhTBYiQSZ@x1.local>
References: <20251027-root-v1-1-ddf92b9058be@rsg.ci.i.u-tokyo.ac.jp>
 <aQE_M1qsr78RrQaw@x1.local>
 <376f8d41-6ffb-4e1b-b50b-93a0f307d017@rsg.ci.i.u-tokyo.ac.jp>
 <aQIxA8MzkSO7qm4Z@x1.local>
 <13cb4e7e-1949-4dc6-b5d6-a976f6f280e4@rsg.ci.i.u-tokyo.ac.jp>
 <aQuuhSL6rXmyqm8x@x1.local>
 <f1e40576-67ef-41e7-8131-6a022c9d5fc4@rsg.ci.i.u-tokyo.ac.jp>
 <aQzf4F6RgkzYWkeM@x1.local>
 <6d9caf51-df32-4c83-9b62-1c99dfea2e50@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d9caf51-df32-4c83-9b62-1c99dfea2e50@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Nov 07, 2025 at 11:16:56AM +0900, Akihiko Odaki wrote:
> On 2025/11/07 2:50, Peter Xu wrote:
> > On Thu, Nov 06, 2025 at 11:23:32AM +0900, Akihiko Odaki wrote:
> > > Generally speaking, we will not necessarily "always" get an issue report
> > > when things went wrong with memory management. A bug in memory management
> > > may not cause an immediate crash but corrupt the memory state which you will
> > > find only later. The end result of memory corruption may look random and
> > > result in a hard-to-debug issue report. A user may not even bother writing
> > > an issue report at all; this is especially true for this kind of corner
> > > cases that rarely happen.
> > > 
> > > There should have been no such a hazard of memory corruption if the code did
> > > exactly what the documentation said in the first place. The consistency of
> > > the code and the documentation is essential, especially for this kind of
> > > complex and fundamental code.
> > 
> > Do you have encountered such case before?
> > 
> > I wasn't expecting that, because what you were saying looks more like what
> > Linux kernel would have a bug in mm.  QEMU is still special as it has the
> > default unassigned MR trapping everything by default, meanwhile normally
> > what is moving is MMIO / alias regions rather than real ramblocks.  It
> > means when things go wrong we have much higher chance to trap them
> > properly.
> 
> When I said "memory management" I meant the methods we use to allocate and
> free memory (the Linux equivalents would be kmalloc()/free()/kref), not the
> MM tracking or unassigned MR trapping behavior you mentioned. The unassigned
> MR trap and MMIO/alias movement are a separate concern and don’t change the
> underlying risk.
> 
> Concrete example: imagine an alias is allocated with g_new() and freed
> immediately after object_unparent(). If that alias accidentally becomes the
> FlatView root, destroying the FlatView later will call memory_region_unref()
> and produce a use-after-free. We cannot predict what memory_region_unref()
> will read or write in that scenario — the result can be arbitrary memory
> corruption that surfaces much later as a hard-to-debug, intermittent
> problem. Users often won’t file an issue for these rare corner cases.

OK I see what you meant now.  Yes it's a valid concern.

> 
> > 
> > I also confess though that I'm pretty conservative on fixing things with
> > hypothetical issues.  In general, I prefer fixing things with explicit
> > problems, so we know how to measure and justify a fix (depending on how
> > aggressive the fix is and how much maintanence burden it will bring to
> > QEMU).  Without a real problem, it's harder to quantify that even if such
> > evaluation will also normally be subjective too.
> 
> Regarding your preference to fix only explicit problems: I understand the
> conservatism, but here are the facts we need to weigh:
> 
> - The documentation claims we may free aliases because
>   memory_region_ref() is never called, yet there is code that does call
>   memory_region_ref().
> - The patch adds code to align behavior with the documentation.
> 
> The significance of both potential impacts (the behavioral divergence for
> devices other than pci-bridge, and the added complexity needed for
> consistency) may be subjective and hypothetical, but that applies equally to
> both sides.
> 
> In this case, the long-term reliability and maintainability of QEMU depend
> on having the code behave as documented. Correctness should take precedence
> over simplicity.

Fair enough.

Let's then still try to see whether we can brainstorm something that can
still at least avoid the "let's clear a remote pointer in a finalize(),
because it looks safe" approach.. I'm not sure if I'm the only one that
feels nervous with it.

Fundamentally, if you can remotely clear a pointer, it means it's not used
at all. In practise, that's correct because as I also discussed before I
don't think RCU readers use flatview->root at all.  It was almost only
because we have some very light references on flatview->root.  The major
"hidden" reference is actually the key in flat_views hash, however I don't
think it will have any stale root MR VA as key, as long as after a proper
commit() completes.

In short, I want to discuss with you on whether we can completely remove
the flatview->root reference, instead of resetting it in finalize().

Since that'll need to be justified, I prepared some sample patches myself.
It survives all my smoke tests.  Once again, please treat them as comments
only.  Would you think that's slightly better?  Attached at the end.

IMHO removing view->root makes sure nothing will surprise us in the future
v.s. remote resets.

Thanks,

===8<===

From 4b495d935dfb145ed7ff57b3f6e4d6b9cb5ce038 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 7 Nov 2025 10:47:40 -0500
Subject: [PATCH 1/3] memory: Remove flatview root reference in
 mtree_print_dispatch()

This is so far only used to dump an extra "[ROOT]" tag when the termination
MR is the root MR.  This is so far the only real necessary reference to
flatview's root.  Remove it.  We lose this tag, but the hope is with the
MR's name still being available it's still clear on what it represents.

This paves way for a complete removal of root MR reference on flatviews.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory-internal.h | 3 +--
 system/memory.c          | 4 ++--
 system/physmem.c         | 5 ++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/system/memory-internal.h b/system/memory-internal.h
index 46f758fa7e..c5841a603c 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -35,8 +35,7 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
 void address_space_dispatch_compact(AddressSpaceDispatch *d);
 void address_space_dispatch_free(AddressSpaceDispatch *d);
 
-void mtree_print_dispatch(struct AddressSpaceDispatch *d,
-                          MemoryRegion *root);
+void mtree_print_dispatch(struct AddressSpaceDispatch *d);
 
 /* returns true if end is big endian. */
 static inline bool devend_big_endian(enum device_endian end)
diff --git a/system/memory.c b/system/memory.c
index 8b84661ae3..0d14e60d26 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3573,8 +3573,8 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     }
 
 #if !defined(CONFIG_USER_ONLY)
-    if (fvi->dispatch_tree && view->root) {
-        mtree_print_dispatch(view->dispatch, view->root);
+    if (fvi->dispatch_tree) {
+        mtree_print_dispatch(view->dispatch);
     }
 #endif
 
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..26ae6e3acd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4257,7 +4257,7 @@ static void mtree_print_phys_entries(int start, int end, int skip, int ptr)
 #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
                            int128_sub((size), int128_one())) : 0)
 
-void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
+void mtree_print_dispatch(AddressSpaceDispatch *d)
 {
     int i;
 
@@ -4270,13 +4270,12 @@ void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
                                 " [ROM]", " [watch]" };
 
         qemu_printf("      #%d @" HWADDR_FMT_plx ".." HWADDR_FMT_plx
-                    " %s%s%s%s%s",
+                    " %s%s%s%s",
             i,
             s->offset_within_address_space,
             s->offset_within_address_space + MR_SIZE(s->size),
             s->mr->name ? s->mr->name : "(noname)",
             i < ARRAY_SIZE(names) ? names[i] : "",
-            s->mr == root ? " [ROOT]" : "",
             s == d->mru_section ? " [MRU]" : "",
             s->mr->is_iommu ? " [iommu]" : "");
 
-- 
2.50.1


From f96e31623f6d13e27b835f06b3c131e91590b13f Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 7 Nov 2025 10:59:15 -0500
Subject: [PATCH 2/3] memory: Introduce flatview's root name

One other reason to reference a Flatview's root MR is to fetch a name.
Remember that inside Flatview itself so as to drop this reference to
Flatview's root MR.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 1 +
 system/memory.c         | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0..301cda1a8f 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1202,6 +1202,7 @@ struct FlatView {
     unsigned nr_allocated;
     struct AddressSpaceDispatch *dispatch;
     MemoryRegion *root;
+    char *root_name;
 };
 
 static inline FlatView *address_space_to_flatview(AddressSpace *as)
diff --git a/system/memory.c b/system/memory.c
index 0d14e60d26..86891c50b4 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -266,6 +266,7 @@ static FlatView *flatview_new(MemoryRegion *mr_root)
     view = g_new0(FlatView, 1);
     view->ref = 1;
     view->root = mr_root;
+    view->root_name = g_strdup(mr_root ? memory_region_name(mr_root) : "(none)");
     memory_region_ref(mr_root);
     trace_flatview_new(view, mr_root);
 
@@ -301,6 +302,7 @@ static void flatview_destroy(FlatView *view)
         memory_region_unref(view->ranges[i].mr);
     }
     g_free(view->ranges);
+    g_free(view->root_name);
     memory_region_unref(view->root);
     g_free(view);
 }
@@ -3522,8 +3524,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         qemu_printf("\n");
     }
 
-    qemu_printf(" Root memory region: %s\n",
-      view->root ? memory_region_name(view->root) : "(none)");
+    qemu_printf(" Root memory region: %s\n", view->root_name);
 
     if (n <= 0) {
         qemu_printf(MTREE_INDENT "No rendered FlatView\n\n");
-- 
2.50.1


From 19f4451a1a7ea2ea3c0c41849f9c118f2b909293 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 7 Nov 2025 11:10:19 -0500
Subject: [PATCH 3/3] memory: Remove Flatview->root reference completely

memory.rst has this paragraph, which is currently inaccurate:

  This exceptional usage is valid because aliases and containers only help
  QEMU building the guest's memory map; they are never accessed directly.
  memory_region_ref and memory_region_unref are never called on aliases or
  containers, and the above situation then cannot happen.  Exploiting this
  exception is rarely necessary, and therefore it is discouraged, but
  nevertheless it is used in a few places.

It was inaccurate because flatviews so far can take a refcount on an alias
MR, which may cause an object_unparent() on top of alias MR unsafe too.

However, Flatview logically doesn't need to take refcount on its root MR
that was used to generate the topology.

When generating the topology, the root MR is used within the whole process.
Said that, it doesn't need the refcount because it keeps holding BQL
without releasing, so the root MR cannot have chance to be detached or
freed.

There's another very implicit use of the root MR, which is as the index of
the flat_views hash.  However that is fine too without refcount, because
for each memory whole transaction, it will guarantee that after memory
region commit()ed and returned, the flat_views hash will not have any key
that points to an invalid root MR.  It's because the role is the MR needs
to be fully detached first before object_unparent(), then it guarantees it
won't appear in any of the Flatviews.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h |  1 -
 system/memory.c         | 13 +++++++------
 system/trace-events     |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 301cda1a8f..d383081155 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1201,7 +1201,6 @@ struct FlatView {
     unsigned nr;
     unsigned nr_allocated;
     struct AddressSpaceDispatch *dispatch;
-    MemoryRegion *root;
     char *root_name;
 };
 
diff --git a/system/memory.c b/system/memory.c
index 86891c50b4..6576e673d4 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -265,9 +265,7 @@ static FlatView *flatview_new(MemoryRegion *mr_root)
 
     view = g_new0(FlatView, 1);
     view->ref = 1;
-    view->root = mr_root;
     view->root_name = g_strdup(mr_root ? memory_region_name(mr_root) : "(none)");
-    memory_region_ref(mr_root);
     trace_flatview_new(view, mr_root);
 
     return view;
@@ -294,7 +292,7 @@ static void flatview_destroy(FlatView *view)
 {
     int i;
 
-    trace_flatview_destroy(view, view->root);
+    trace_flatview_destroy(view, view->root_name);
     if (view->dispatch) {
         address_space_dispatch_free(view->dispatch);
     }
@@ -303,7 +301,6 @@ static void flatview_destroy(FlatView *view)
     }
     g_free(view->ranges);
     g_free(view->root_name);
-    memory_region_unref(view->root);
     g_free(view);
 }
 
@@ -315,8 +312,7 @@ static bool flatview_ref(FlatView *view)
 void flatview_unref(FlatView *view)
 {
     if (qatomic_fetch_dec(&view->ref) == 1) {
-        trace_flatview_destroy_rcu(view, view->root);
-        assert(view->root);
+        trace_flatview_destroy_rcu(view, view->root_name);
         call_rcu(view, flatview_destroy, rcu);
     }
 }
@@ -751,6 +747,11 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
     int i;
     FlatView *view;
 
+    /*
+     * Holding BQL makes sure @mr (if non-NULL) will not be gone from under
+     * us, hence we do not need a refcount while using it.
+     */
+    assert(bql_locked());
     view = flatview_new(mr);
 
     if (mr) {
diff --git a/system/trace-events b/system/trace-events
index 82856e44f2..21efd8047e 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -24,8 +24,8 @@ memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t v
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_sync_dirty(const char *mr, const char *listener, int global) "mr '%s' listener '%s' synced (global=%d)"
 flatview_new(void *view, void *root) "%p (root %p)"
-flatview_destroy(void *view, void *root) "%p (root %p)"
-flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
+flatview_destroy(void *view, char *root) "%p (root %p)"
+flatview_destroy_rcu(void *view, char *root) "%p (root %p)"
 global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
 
 # physmem.c
-- 
2.50.1


-- 
Peter Xu


