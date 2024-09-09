Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C840ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfmj-0005lN-VA; Mon, 09 Sep 2024 10:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfmf-0005Tk-PN
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfmc-00072R-NH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725893666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJxhZRez+hiilw4HFMtQuOQuennGpo9FEmpsBy+bM5w=;
 b=iGh/CExUqxfbvgeG4BXz3yvjz0h2JsI3wJxUwd6jCr6MggquWiXYC5zumKwDQyKchAHUY0
 YIzKQyILfgHuHD76jfNZezY464wG6fqnHHJjDcAY8mp1AxPALhbI5J/30Ge3xnJLi0Y1iD
 V7yYkPAHbRtkGx4SDDIj29Fa0RDKeTc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-DqVq-GqMNSGvVrO9NLdRNg-1; Mon, 09 Sep 2024 10:54:23 -0400
X-MC-Unique: DqVq-GqMNSGvVrO9NLdRNg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9b1216a68so282398285a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725893663; x=1726498463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJxhZRez+hiilw4HFMtQuOQuennGpo9FEmpsBy+bM5w=;
 b=XD43+f89548lMigiMvhX7H3hrim9NQ53zqEfrZWI9324EFgVwszX3bLmAToUAmZXQc
 D4dv1IQ4ecja2PCR8uyVlQ1I/5N8Bo3wq3TsK9KAUsRe3JYBKgv+5dHtJU9Xphulivq9
 4QxkxFet6gDERTMD2yC+ieiqwlmQ0qUE959oEPXRJPL/IIKnqA8DfN7qyK67E+h6+IVC
 tHiGsBHDKHKBHOpaaH7Q4NmxoxNsUP+dBj9Z1ouN9PDEjo0jM0INjzXjN0l72xB8lYQq
 4DaFue75tNsYqTrrc8csBLsQBgmcNLgltSbp2dYorW6+j5eIQu5HSLdWXzRUuvQQxxtO
 t02w==
X-Gm-Message-State: AOJu0YzFS6gvjit4KcmW6yDVEUg+hZNHM0gCee2w1ZLOh6hPKIVxUk3d
 lvnRrOFW+0rzxOJJUIk2xmyitFQXml1+1NnPDMlgMD2Nr+F9D84o1HbtpPIS9ts8w5oWigS2TSY
 GzCNzoHVp2EBb2QP0Ix/BPG10EEFiMkx6FvzPFzjkWul50Scggme9UHpM550UGg0GUaRXeJPGzK
 nTB/BylNKL03SO4sb5nrQwagS1+jhe99tFY8g+
X-Received: by 2002:a05:620a:459f:b0:7a9:a744:f989 with SMTP id
 af79cd13be357-7a9a7450021mr761639185a.46.1725893662775; 
 Mon, 09 Sep 2024 07:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxyyDuRFutZ9SurivTZezl9sM7RaJ/Sy3n2utubAl5K9EQoOTV0wbZ/DrDyKBpyDrg07WlGA==
X-Received: by 2002:a05:620a:459f:b0:7a9:a744:f989 with SMTP id
 af79cd13be357-7a9a7450021mr761634785a.46.1725893662302; 
 Mon, 09 Sep 2024 07:54:22 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a79455b1sm225387585a.19.2024.09.09.07.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:54:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 4/4] KVM: Rename KVMState->nr_slots to nr_slots_max
Date: Mon,  9 Sep 2024 10:54:13 -0400
Message-ID: <20240909145413.3748429-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909145413.3748429-1-peterx@redhat.com>
References: <20240909145413.3748429-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This value used to reflect the maximum supported memslots from KVM kernel.
Rename it to be clearer.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h |  4 ++--
 accel/kvm/kvm-all.c      | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index b705dfc9b4..2c57194b6b 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -103,8 +103,8 @@ struct KVMDirtyRingReaper {
 struct KVMState
 {
     AccelState parent_obj;
-
-    int nr_slots;
+    /* Max number of KVM slots supported */
+    int nr_slots_max;
     int fd;
     int vmfd;
     int coalesced_mmio;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ab0ab98a71..bad2930827 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -183,8 +183,8 @@ static bool kvm_slots_grow(KVMMemoryListener *kml, unsigned int nr_slots_new)
     unsigned int i, cur = kml->nr_slots_allocated;
     KVMSlot *slots;
 
-    if (nr_slots_new > kvm_state->nr_slots) {
-        nr_slots_new = kvm_state->nr_slots;
+    if (nr_slots_new > kvm_state->nr_slots_max) {
+        nr_slots_new = kvm_state->nr_slots_max;
     }
 
     if (cur >= nr_slots_new) {
@@ -225,7 +225,7 @@ unsigned int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
 
-    return s->nr_slots;
+    return s->nr_slots_max;
 }
 
 unsigned int kvm_get_free_memslots(void)
@@ -243,7 +243,7 @@ unsigned int kvm_get_free_memslots(void)
     }
     kvm_slots_unlock();
 
-    return s->nr_slots - used_slots;
+    return s->nr_slots_max - used_slots;
 }
 
 /* Called with KVMMemoryListener.slots_lock held */
@@ -2513,10 +2513,10 @@ static int kvm_init(MachineState *ms)
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
     kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
-    s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
+    s->nr_slots_max = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
     /* If unspecified, use the default value */
-    if (!s->nr_slots) {
+    if (!s->nr_slots_max) {
         s->nr_slots_max = KVM_MEMSLOTS_NR_MAX_DEFAULT;
     }
 
@@ -2525,10 +2525,10 @@ static int kvm_init(MachineState *ms)
      * fail to boot.  Make sure the supported value is always at least
      * larger than what we will initially allocate.
      */
-    if (s->nr_slots < KVM_MEMSLOTS_NR_ALLOC_DEFAULT) {
+    if (s->nr_slots_max < KVM_MEMSLOTS_NR_ALLOC_DEFAULT) {
         ret = -EINVAL;
         fprintf(stderr, "KVM max supported number of slots (%d) too small\n",
-                s->nr_slots);
+                s->nr_slots_max);
         goto err;
     }
 
-- 
2.45.0


