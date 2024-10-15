Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A205D216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNd-0007bW-Fq; Tue, 15 Oct 2024 10:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNW-0007PC-Ej
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNU-0003NT-Hz
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wp0cC746jAAuGLJVvfLopKXjLwCmvPCcZHJYwFAo+qQ=;
 b=GFTD8ne84IcXOxQBk8+pULNDZlpRTv+iE4oR2RXAO1F2P6CW2sh4mUFsVHIBBBE/s8RPO8
 gVqOGB73q5iLTLmUcb7p4IX8gpYaBetPVlcSZIAyamEHqJhiHBkrgof4Ovv6VboQa22QCY
 4MU4Fo6KT4I1ctFFNjHEbh7TtA3neTM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-HomQcQzvP6Ol8oOKquaX7g-1; Tue, 15 Oct 2024 10:18:21 -0400
X-MC-Unique: HomQcQzvP6Ol8oOKquaX7g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d56061a4cso2166866f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001899; x=1729606699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wp0cC746jAAuGLJVvfLopKXjLwCmvPCcZHJYwFAo+qQ=;
 b=oetAVd1siuKJQwXu+noZ4h+vQepnFxoXkVBx0LYZ1cPLKfH7kB6A3wQE0wNrwnpI+W
 uPgYmOQBR+zC8wmrpnUla2gdwoofgDnOpJ/j8xgviUynyr06OfJdVo9ApwJ1qTT8PIf3
 x0Ur42i4m6JEYNkctDHkppCuJRItb0sIbcFMeUtutfzpDBd3dc0c7NouvAq4o9R/JqIL
 NkB0YLsTY2cCqQY9h64NJNq9poly/LbDbp7lqLd/RdWcgCTZhFE9thb34Wu/rfVp7llb
 FbqzSXBNj6OJJT5EFqaEi2TeMP1+XjL0JS7xXuTHiiBCVzjyBJommn/NrvhGrtMYR+zB
 sdxw==
X-Gm-Message-State: AOJu0Yzwb1aSD50lfqAIPe44gMcEw9GTlHz3gKRJYxpBkZ10WMSE+OcC
 RRK2wpZXIlXeLc6mqn0tcQZfmVI69UJotPmiL1JqdlRinZyRRXgvnUN7WP3NtkdmAYlby3IqA9o
 quOxwqVpowjUmjtJyfPK4LrktGvCp9VdsjAMEJ5JiUFVx8iZAazEWkwLMSHgOWWIeZRNKAP+YSp
 PKiKiFHaHPAPsRC4dhtvYbY8wrL+mnKnpgvQyVrcg=
X-Received: by 2002:a05:6000:128f:b0:374:b71f:72c9 with SMTP id
 ffacd0b85a97d-37d5519b43fmr12284973f8f.16.1729001899448; 
 Tue, 15 Oct 2024 07:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+h3U4PdRH09/XsOhsuo+NfuVwNghkTB3R0sYf3deelk+IFKZPySFbkkKZK57aShvr3qrdfw==
X-Received: by 2002:a05:6000:128f:b0:374:b71f:72c9 with SMTP id
 ffacd0b85a97d-37d5519b43fmr12284945f8f.16.1729001898859; 
 Tue, 15 Oct 2024 07:18:18 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc445fesm1682672f8f.113.2024.10.15.07.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PULL 19/25] KVM: Rename KVMMemoryListener.nr_used_slots to
 nr_slots_used
Date: Tue, 15 Oct 2024 16:17:05 +0200
Message-ID: <20241015141711.528342-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Xu <peterx@redhat.com>

This will make all nr_slots counters to be named in the same manner.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240917163835.194664-4-peterx@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm_int.h | 2 +-
 accel/kvm/kvm-all.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 2304537b93c..914c5c9ec50 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -45,7 +45,7 @@ typedef struct KVMMemoryUpdate {
 typedef struct KVMMemoryListener {
     MemoryListener listener;
     KVMSlot *slots;
-    unsigned int nr_used_slots;
+    unsigned int nr_slots_used;
     unsigned int nr_slots_allocated;
     int as_id;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_add;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c32a84eb5ad..24d76a18906 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -239,7 +239,7 @@ unsigned int kvm_get_free_memslots(void)
         if (!s->as[i].ml) {
             continue;
         }
-        used_slots = MAX(used_slots, s->as[i].ml->nr_used_slots);
+        used_slots = MAX(used_slots, s->as[i].ml->nr_slots_used);
     }
     kvm_slots_unlock();
 
@@ -1516,7 +1516,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             }
             start_addr += slot_size;
             size -= slot_size;
-            kml->nr_used_slots--;
+            kml->nr_slots_used--;
         } while (size);
         return;
     }
@@ -1555,7 +1555,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         ram_start_offset += slot_size;
         ram += slot_size;
         size -= slot_size;
-        kml->nr_used_slots++;
+        kml->nr_slots_used++;
     } while (size);
 }
 
-- 
2.46.2


