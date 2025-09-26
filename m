Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C817CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2ACG-0004Y6-HO; Fri, 26 Sep 2025 11:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v2AC3-0004Sh-M1
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v2ABs-0005Xd-I3
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758899812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuCihrpLHNrghmMhRouRiyVhPf04fN9EcSOmih+B9MI=;
 b=drXGMyV24j0UEPRZU6cHjx7NxjWj5EVpQPsV45v6IJKBHgNpkVJaZPUxA3W24bGarfCnQ1
 AcfErUi8dph571/LXn7AcQKO9ZX0ON/qeQY1hKcHNWRetjKzJhqw8sPEBjuhF1kfOJDVIz
 t6nexdNN7qyXtN0c2PDoI0AgakdzWTg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-GmDUqRnON0CZSnTGlNgTUw-1; Fri, 26 Sep 2025 11:16:50 -0400
X-MC-Unique: GmDUqRnON0CZSnTGlNgTUw-1
X-Mimecast-MFC-AGG-ID: GmDUqRnON0CZSnTGlNgTUw_1758899810
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8217df6d44cso401865385a.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 08:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758899810; x=1759504610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuCihrpLHNrghmMhRouRiyVhPf04fN9EcSOmih+B9MI=;
 b=wG65tPCGhBT+9B4SRPCRDQvHLLmvATd0DkYCX5TI6NKMb3Nv2TNFp36AWoulsUQHch
 DizhmPIQmHwrv01oUWU3e1D4maMweKwRKv5pHCtA+08JTcOk9BuN95X1tS4TJz/HmSry
 zpHAxiy6AiBSOaLE7S+kDhEiFHgc0Kg+9iZfxMPBU7X/E5Vh64v4R07IzVk+WE9M5vX5
 qxfibOs6wW30kL1WypASKiVd2ryuIDm0Uhz4FYM2oC6KL0Rs5INwEbfZSNaurRn/Nf1I
 iZCWBA2q8aNuhRoH7H5w/g1oEF7LXOYB1XPaH2UWiCh0L0v46yv+ft4iz+NijuWkAGv6
 2FQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU87wv4aRq7cG/F3mD+aSaPxsPh4+xMec8AhR261Fq06M9Mh+VnvqORaNXN4Etx+WUFvh2GnaCgt2/2@nongnu.org
X-Gm-Message-State: AOJu0YwXJW8WR2CJT614MqH8TMMfyOIaJS4/zwL6EhBu3VXrVX0/1nh0
 3TTo4PL0zJLQjYfJ2gSiMhqZBXFhlcz5HHLsFP5JuU5aYOp+gPkSkQ4XlHcABTs9OcUR1f/oBTk
 d0kLJ/iE92QwT1moo0kkpn+pH5yTJW2HMIOZTnAFB2CeK9cA2SUtPPpkf
X-Gm-Gg: ASbGncuL7w4oiI4QuRGGNj96N2t5YS196UZB150NcFtan70nY93FI8Sv55vzwi5v5uB
 us/cO+62Y9oqxaful0af+wcVwKgOLsGsd9gaMUv29agdFI/vgQa0SlqPwJk5FEfnaxfzVS02svj
 XtYL6w2yrq/Q5k5qSNm+rujx6kox98lICluiMp/9NyXzG0JKhgSGkhdh4t88hEo59atX2pP/wH4
 3RUoCCEg+WPBBNusyEshB0V7ZPRl74aJVxNNRBC+Dz0lp61u78UbtAwwRm8dStAWMmRW9r9Fgn5
 HaRPo+9JKG6yMsDE4Jk+tUjEs/PQm9wr
X-Received: by 2002:a05:620a:2988:b0:806:484e:7c39 with SMTP id
 af79cd13be357-85ade962990mr1115150685a.14.1758899809666; 
 Fri, 26 Sep 2025 08:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiysaoTyiOJATr0CQAvgdpTawichcScZ1yVQyGEXV2u90myzipMpDCiSOUiWqRWmFAZQFANg==
X-Received: by 2002:a05:620a:2988:b0:806:484e:7c39 with SMTP id
 af79cd13be357-85ade962990mr1115142485a.14.1758899809047; 
 Fri, 26 Sep 2025 08:16:49 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c3218f039sm293894385a.47.2025.09.26.08.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:16:47 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:16:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
Message-ID: <aNauXSMiP0LUWQ5J@x1.local>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
 <aNRfHQoBgwBMjK04@x1.local>
 <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
 <aNWgnBV-9p6UnsYT@x1.local>
 <CAFEAcA8qdWtdX0Xc0WAuT9eZsXbudV2g2=Da8pK6tEfytdMbpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8qdWtdX0Xc0WAuT9eZsXbudV2g2=Da8pK6tEfytdMbpw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Sep 26, 2025 at 10:09:29AM +0100, Peter Maydell wrote:
> On Thu, 25 Sept 2025 at 21:06, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 10:03:45AM +0100, Peter Maydell wrote:
> > > On Wed, 24 Sept 2025 at 22:14, Peter Xu <peterx@redhat.com> wrote:
> > > > Side note: when I was trying to test hotplugs with i386/q35, unfortunately
> > > > I didn't really see when the address space was destroyed, maybe there's a
> > > > bug somewhere; I put that info into appendix at the end.
> > >
> > > This is https://gitlab.com/qemu-project/qemu/-/issues/2517
> > >
> > > I got blocked on that because I ran into a weird "I have some
> > > memory that needs to be freed by the RCU callback, but only
> > > after the callback has freed some other RCU stuff". I see
> > > Paolo made a reply on that bug -- I would need to get back
> > > to it and reproduce whatever it was I was doing.
> >
> > Thanks for the link, right that looks exactly like what I hit.
> >
> > I am curious if FIFO is guaranteed for RCU in general, or it is an impl
> > detail only specific to QEMU.
> >
> > The other thing is I feel like it should be OK to reorder callbacks, if all
> > the call_rcu() users can make sure the rcu-freed object is completely
> > detached from the rest world, e.g. resetting all relevant pointers to NULL.
> > With that, it seems the order won't matter too, because nobody will be able
> > to reference the internal object anyway, so the two objects (after reseting
> > all referers to NULL pointer of the inner object) are completely standalone.
> 
> The specific ordering problem for cpu_address_space is that
> there's a g_new allocated array of memory which contains
> the AddressSpace objects (not pointers to them). The ASes need
> to be RCU-deallocated first so they can clean up their internal
> data structures; only once that has happened can we free the
> memory that holds the AddressSpace structs themselves.

If it's about cpu_address_space_destroy(), then IIUC it can also be done by
providing a destroy_free() function so that instead of trying to serialize
two rcu callbacks, we could easily serialize the operations in one
callback.  One sample patch attached to avoid relying on order of rcu
enqueue.

Thanks,

===8<===

From 427ce0d2c7efe5771be859fa34c6f3ec18498a29 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 26 Sep 2025 10:55:26 -0400
Subject: [PATCH] memory: New AS helper to serialize destroy+free

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 10 ++++++++++
 system/memory.c         | 20 +++++++++++++++++++-
 system/physmem.c        |  3 +--
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a1..45f8c3d4aa 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2735,6 +2735,16 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
  */
 void address_space_destroy(AddressSpace *as);
 
+/**
+ * address_space_destroy_free: destroy an address space and free it
+ *
+ * Same to address_space_destroy(), only that it will also free the
+ * memory that AddressSpace pointer points to.
+ *
+ * @as: address space to be destroyed
+ */
+void address_space_destroy_free(AddressSpace *as);
+
 /**
  * address_space_remove_listeners: unregister all listeners of an address space
  *
diff --git a/system/memory.c b/system/memory.c
index cf8cad6961..fe8b28a096 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3278,7 +3278,14 @@ static void do_address_space_destroy(AddressSpace *as)
     memory_region_unref(as->root);
 }
 
-void address_space_destroy(AddressSpace *as)
+static void do_address_space_destroy_free(AddressSpace *as)
+{
+    do_address_space_destroy(as);
+    g_free(as);
+}
+
+/* Detach address space from global view, notify all listeners */
+static void address_space_detach(AddressSpace *as)
 {
     MemoryRegion *root = as->root;
 
@@ -3293,9 +3300,20 @@ void address_space_destroy(AddressSpace *as)
      * values to expire before freeing the data.
      */
     as->root = root;
+}
+
+void address_space_destroy(AddressSpace *as)
+{
+    address_space_detach(as);
     call_rcu(as, do_address_space_destroy, rcu);
 }
 
+void address_space_destroy_free(AddressSpace *as)
+{
+    address_space_detach(as);
+    call_rcu(as, do_address_space_destroy_free, rcu);
+}
+
 static const char *memory_region_type(MemoryRegion *mr)
 {
     if (mr->alias) {
diff --git a/system/physmem.c b/system/physmem.c
index ae8ecd50ea..5afd6c67e6 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -821,8 +821,7 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx)
         memory_listener_unregister(&cpuas->tcg_as_listener);
     }
 
-    address_space_destroy(cpuas->as);
-    g_free_rcu(cpuas->as, rcu);
+    g_clear_pointer(&cpuas->as, address_space_destroy_free);
 
     if (asidx == 0) {
         /* reset the convenience alias for address space 0 */
-- 
2.50.1


-- 
Peter Xu


