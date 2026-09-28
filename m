Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40A4CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0f-0005Cm-4c; Mon, 28 Sep 2026 09:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0b-0005BZ-9C
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0Z-0004N6-HA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSLEISylSiJNwY0Q9y+CKPHH5pYkBTTvvnRNG1F/obs=;
 b=JXss2JqAvH8lVewMmM0Iq+nMDnw7HyWGzO9CPDUbyvaHGobhSG82gMvSuuqwTUkvVTtWOv
 rjrd4SlPvor5UIzDAS8+gXA+B++To+ATXgYB1d1luE2wk2t4amKZtnfJsmHAuiSC3CTftv
 eEv8P7VVQbDPjv6Cjo1VSWJtEHDp6yQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-dSTk4TR3Ptq7i6febftGog-1; Mon, 28 Sep 2026 09:03:01 -0400
X-MC-Unique: dSTk4TR3Ptq7i6febftGog-1
X-Mimecast-MFC-AGG-ID: dSTk4TR3Ptq7i6febftGog_1790600580
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c29680b34b5so2434666b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600580; x=1791205380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pSLEISylSiJNwY0Q9y+CKPHH5pYkBTTvvnRNG1F/obs=;
 b=jKWiMwxYAF8YT34FZc0SeYWL93oX5C0dgx2CFG0AhICMXJ8urmuTQm1A19kXRju8pB
 ziB2KyNWIv4sDsbMJeM7UipV62+keirJLJSovAn85xGlYep/Icco/xWayyAEtDl/lLhP
 45AIdxsTImnhoAAbHvKK+qdOn7LwzMnzRrQku9o8brSwRnJ4PZOio2FElOLqqBPzanYS
 XrOwbfvKwG9+yeaTghDpWtP//gYCs8tKmB16lznWVP9hbjJFJU//TJ+3gbQHUcz4W04G
 seP6PqutyqxH88Ixv7tpkeS5rcxb+trRfyaSxAOS00nFLFXs8zravsWxUYByDtpsWsXJ
 5V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600580; x=1791205380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pSLEISylSiJNwY0Q9y+CKPHH5pYkBTTvvnRNG1F/obs=;
 b=UTydd80m4wnfccZMgARbgZJ9sUWQcKlIpeAmWzWYjfgFnFgGLxnKX8uRdlQ30OJoug
 fF9GUl4F4bCKanbvDnUgSPPBpXWpg4OUDq6Cop02TPXrUj+5oWmuHR+R6q4zGe1ZjNcb
 XKKYZdV049OPt98AqGA8kS1LL3oboQx0oXZQ75eMKAWaf/A6Jxa0Eg+jNiznbkVnf5c8
 5b9n/s69C/SS+q/n9ZYC7c1hfjpDUu6lyXxnO4DAlSAC5Qtnv+yV5IN+TF2HmM4KIJa8
 HnM5cQ6XS5B4+wwsMw/DA+ecKxW4ZSCtcnBN9ud+Ju0n177zRuCKWpdvVF7ZG62siExj
 BzhQ==
X-Gm-Message-State: AFuF++lfTgEm0EGK2RSSpTRdcN1Hm0seZKsAV7OrkLZg3fsmqKTUUffE
 9qxFns0Mpr0yo/ggQatNmiep/LaXsmBvjiXWF8LLvR8EDK32HhGUt1Wv2tNgxsVHmzN8XvxDcmF
 xMXomMA0QHhfcbFzArewp61LRtCEJMDgYPjUXATGFjcOIVRFg3qynGGOA/lxv4oHPHZmQCwuNPQ
 jxBA9WGq2NUSTEfaufLcvjOwC6SzEWLGhJAYcfWyOK
X-Gm-Gg: AYBFou3pV4+e+n5SfWtx596BVk/lctfZuI9KgKcx+IZHeWrXB1u2Y6R9SFzgWN96r08
 sCAl/040aRfM5y+p4Wi1Uac7tUOiCJ1t+hRwLknqPj03yyeUiuEn/7mnPlPftm/6Qjwm43MHOh0
 kPzdXSt8kKhBDEmdhDy/zd78NrboIgbPymyqsPdVFLAfMOyp0NOuxz18YLu4NqFJAdTYNBnsBMY
 sp5ji2qUMYTMeukrF283M1hnc5JTXgYPsDQv3fZeKkwrdZeVs8cs7FrVwkhh8IiV/fYbhMYnjey
 E5R/dRYvsFVPrBSDBjavfPmsLIlpM0HvtT++Qr5rgdItsiNQvg7nR8pRv6pIaNgROz0qzlR0omk
 O/cD9raKnLEKqmJme5zxLUFUd0DRtfc3XbrAPHz356JXKLHisgtr95YCafLHvaIG6Aw9L7Yo/aW
 tYDr1R
X-Received: by 2002:a17:907:960d:b0:c25:f7db:4bf0 with SMTP id
 a640c23a62f3a-c2ac238a8d0mr1170609666b.22.1790600580006; 
 Mon, 28 Sep 2026 06:03:00 -0700 (PDT)
X-Received: by 2002:a17:907:960d:b0:c25:f7db:4bf0 with SMTP id
 a640c23a62f3a-c2ac238a8d0mr1170605566b.22.1790600579326; 
 Mon, 28 Sep 2026 06:02:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dc7b6f438sm236245366b.2.2026.09.28.06.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
 "Vulnerability Report" <vr@darknavy.com>
Subject: [PULL 10/30] accel/kvm: protect kvm_resample_fd_list with a mutex
Date: Mon, 28 Sep 2026 15:02:08 +0200
Message-ID: <20260928130228.877003-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Maxim Levitsky <mlevitsk@redhat.com>

Legacy PCI INTx interrupts are level triggered and can, in theory, be shared.

Upon receiving such an interrupt, VFIO kernel driver masks it in a generic way,
using INTX_DISABLE bit in the PCI config space.

It then waits for the guest to signal completion (EOI) of the interrupt,
upon which VFIO re-enables the interrupt.

The completion is signaled with another eventfd.

For split irqchip mode, KVM doesn't have a notion of EOI on IOAPIC level.
Instead it signals EOI with a userspace VM exit, KVM_EXIT_IOAPIC_EOI.

Upon receiving this VM exit, Qemu manually signals the above-mentioned eventfd.

The problem that this patch resolves is that QEMU keeps these eventfds in
a linked list without any locking to prevent the list from being corrupted by
concurrent access.

Such use is possible and guest triggerable if the guest rapidly toggles
INTX mode of a VFIO device and at the same time signals EOI with an arbitrary
vector.

Fix this by protecting this list (kvm_resample_fd_list) with a mutex.

This patch was only compile tested.

Reported-by: "Vulnerability Report" <vr@darknavy.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3942
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20260923004651.101197-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a84..da3afdc68d8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -146,6 +146,7 @@ typedef struct KVMResampleFd KVMResampleFd;
 static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =
     QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
 
+static QemuMutex kvm_resample_fd_list_lock;
 static QemuMutex kml_slots_lock;
 
 #define kvm_slots_lock()    qemu_mutex_lock(&kml_slots_lock)
@@ -157,6 +158,8 @@ static inline void kvm_resample_fd_remove(int gsi)
 {
     KVMResampleFd *rfd;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
+
     QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
         if (rfd->gsi == gsi) {
             QLIST_REMOVE(rfd, node);
@@ -164,6 +167,8 @@ static inline void kvm_resample_fd_remove(int gsi)
             break;
         }
     }
+
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
@@ -173,20 +178,26 @@ static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
     rfd->gsi = gsi;
     rfd->resample_event = event;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
     QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 void kvm_resample_fd_notify(int gsi)
 {
     KVMResampleFd *rfd;
 
+    qemu_mutex_lock(&kvm_resample_fd_list_lock);
+
     QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
         if (rfd->gsi == gsi) {
             event_notifier_set(rfd->resample_event);
             trace_kvm_resample_fd_notify(gsi);
-            return;
+            break;
         }
     }
+
+    qemu_mutex_unlock(&kvm_resample_fd_list_lock);
 }
 
 /**
@@ -2910,6 +2921,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
+    qemu_mutex_init(&kvm_resample_fd_list_lock);
 
     /*
      * On systems where the kernel can support different base page
-- 
2.55.0


