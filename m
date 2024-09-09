Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A22ECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfmh-0005Zn-5h; Mon, 09 Sep 2024 10:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfmb-0005QH-WF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfma-000723-4U
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725893663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CrZS8781pHGUPuwCPCQ1wvEpYbe8ELrbjJpLH7JCnvU=;
 b=JYlcdSZR+boXJ8UObiUhwupEkWvx57lVkPn4+QLjCyWxtw22hfPJZw70Jb39c1hNpFoD21
 hpdl9z+0sBQ7x0diJFGjGMZm5x7h0m8Fr+Ctv90oGOY36fNI+4t+Tgg8+do7OojzAfC7+M
 v/g7ExzZxOLAepZtWpol3xP/G/xFntY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-nXApTwkuPlOkKOdEm8Sxsg-1; Mon, 09 Sep 2024 10:54:22 -0400
X-MC-Unique: nXApTwkuPlOkKOdEm8Sxsg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a9aae6728aso392750885a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725893661; x=1726498461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrZS8781pHGUPuwCPCQ1wvEpYbe8ELrbjJpLH7JCnvU=;
 b=KUFHYfv0cdebyEEoT3ScBtMeH+ORrlpSmFEFWiIGRbi0uILyjepryuNi9M3MYCcTld
 y8I1c6c1lQ76soFKE7h9+imS4pujC6Keu19rCDuqsl37F6/2t1LoJGoNKED1pLsoPXpg
 w1MpElUqLh5fZCYs+eZz4chWI8bDg7W93ych7wE71jWl5+O3XyxjKv5RE8xf3Gb3cg/o
 PmSV/s9DbTD31esXa4rFeostL/pWwOGSpflP5IefEWg0wihZtslcaGTJTjqFDo/VJ+Bt
 5PFcjPuWasKF+40jDTw3nDpqHbjpOI0kkz1wzqEQR9uQzcmopu4quevl7TVoA/pTqbjl
 zrDw==
X-Gm-Message-State: AOJu0YzP2DbY2z2m/xpeK/Vj0/Jt5LvtbVhpP7fXnE4LABFENz/gzyER
 0WqSVlcEfQJP3hDar0FCpHt/PGohaXgSJSlGfJUhBy+AyNaqpkCMkp1OUee5ImdOho1eN5gLEnH
 NbiJjWTv41nkWdocCnUVqwxUq8OdW+9oW7LcpFGlvP4dBxYzxcHrhXGAKNNDoIiJ29dyvmoSvHO
 CF54Hahy7PlJzNnkALiSLqKeL+y38dw8lzGIH8
X-Received: by 2002:a05:620a:2685:b0:7a9:bdac:63fe with SMTP id
 af79cd13be357-7a9bdac6734mr166867085a.11.1725893661299; 
 Mon, 09 Sep 2024 07:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhUWO9wpYAAnIhrWrEGD6pkrTLIfWjX1eE5Sp1EgBf7OqBu6xU+luf+nixk7K+GkpfA2SahA==
X-Received: by 2002:a05:620a:2685:b0:7a9:bdac:63fe with SMTP id
 af79cd13be357-7a9bdac6734mr166862685a.11.1725893660833; 
 Mon, 09 Sep 2024 07:54:20 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a79455b1sm225387585a.19.2024.09.09.07.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:54:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 3/4] KVM: Rename KVMMemoryListener.nr_used_slots to
 nr_slots_used
Date: Mon,  9 Sep 2024 10:54:12 -0400
Message-ID: <20240909145413.3748429-4-peterx@redhat.com>
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

This will make all nr_slots counters to be named in the same manner.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h | 2 +-
 accel/kvm/kvm-all.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 48e496b3d4..b705dfc9b4 100644
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
index 2a2ee4e7d7..ab0ab98a71 100644
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
2.45.0


