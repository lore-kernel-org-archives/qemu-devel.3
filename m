Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D030CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 19:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slvUx-0005l3-D3; Wed, 04 Sep 2024 15:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUs-0005Sc-UE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUp-0006GG-9H
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725477409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mc8B28oXTBzf9S8RSq3Ttc2Y0TeJWt0Pa9JyMRGB3Ro=;
 b=bkudo4RGC8QK6FHJu9HyLKUq+LSKxztcpc4CYUkFLteSf6xSf7epXgfCfwjsv24+XEFP1X
 YDxHAXXwSTSlWcBVLgLzwaWiWD9BiZqbwje5lmV1nOU3LdGJuHbXGYRucb3FH56LWazvG4
 mSgfybN90Dw2ae4mbHiTurDd55PGc4U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-zm_GItiYP2OiPa6YcjzHDg-1; Wed, 04 Sep 2024 15:16:46 -0400
X-MC-Unique: zm_GItiYP2OiPa6YcjzHDg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a80adc8735so288570985a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 12:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725477405; x=1726082205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mc8B28oXTBzf9S8RSq3Ttc2Y0TeJWt0Pa9JyMRGB3Ro=;
 b=pBxaSXFHNg/zXvXEGNBJshFqV2/4kvxDZXlkkzJoC4NxcRHk4DoSJcsNgafTZiTGkU
 TsB2FB/W///9W/hAeomMrNsHwxcOhxV87tG2Jn2fhV31w9qb2LmMK8oPdoAq+9JCF2bQ
 AzkzAnLMJ6rXQHfNjSyWfzFbTlz2fR9ykw1D9QkyyNSxhikYVfaa28KVnbyXr0+8RzI3
 5cdvkPi1u1+Kvh3gfcsnbqLtunZpKON3hXQeDz/ZC+iauKkhQop6T/dnRgQotwWKRxP7
 0TZxxu7GpMwaMWmAQP3w5O7YLZ29sCqEsFZuWqOPxkoTegYFBbN0ySnCtIPMIaYSv/qe
 wcgQ==
X-Gm-Message-State: AOJu0Yw0pp4DQ1d5ROcKFAvj+Mx+SCOT4hdT50D6eoLWLG5YEjI8ht/F
 3rTB19ExnuO5zJMNC8GH42VCXQPr/DnaqpZ/iOwjnD0ja0At4/vtarwHa/2gbLkB5LUl+dQ6f90
 CunghPyjR60Bi0BFuAw73aUN8P8JRv+7m+xsAGt/rKOuNkjrAkcVJ5z0+niI7SfCHPj8dmzudmC
 LSV+vJl8ur4te7yMNQ3VJTDLddYkfXifuR/Xx6
X-Received: by 2002:a05:620a:4691:b0:7a6:5d61:843 with SMTP id
 af79cd13be357-7a9888b5abemr511486885a.19.1725477405584; 
 Wed, 04 Sep 2024 12:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwhb5Mgf3o0CyvhRE9t23vYkO5g/1U0zT6Gbae75t9/30/MgOyMUl0oO5fzRoqjjzL1lq6YA==
X-Received: by 2002:a05:620a:4691:b0:7a6:5d61:843 with SMTP id
 af79cd13be357-7a9888b5abemr511481085a.19.1725477405088; 
 Wed, 04 Sep 2024 12:16:45 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef250d2sm10260285a.15.2024.09.04.12.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 12:16:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 4/4] KVM: Rename KVMMemoryListener.nr_used_slots to
 nr_slots_used
Date: Wed,  4 Sep 2024 15:16:35 -0400
Message-ID: <20240904191635.3045606-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240904191635.3045606-1-peterx@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This will make all nr_slots counters to be named in the same manner.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h | 2 +-
 accel/kvm/kvm-all.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index e67b2e5a68..2c57194b6b 100644
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
index 0d379606e4..0990d090cb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -234,7 +234,7 @@ unsigned int kvm_get_free_memslots(void)
         if (!s->as[i].ml) {
             continue;
         }
-        used_slots = MAX(used_slots, s->as[i].ml->nr_used_slots);
+        used_slots = MAX(used_slots, s->as[i].ml->nr_slots_used);
     }
     kvm_slots_unlock();
 
@@ -1505,7 +1505,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             }
             start_addr += slot_size;
             size -= slot_size;
-            kml->nr_used_slots--;
+            kml->nr_slots_used--;
         } while (size);
         return;
     }
@@ -1544,7 +1544,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         ram_start_offset += slot_size;
         ram += slot_size;
         size -= slot_size;
-        kml->nr_used_slots++;
+        kml->nr_slots_used++;
     } while (size);
 }
 
-- 
2.45.0


