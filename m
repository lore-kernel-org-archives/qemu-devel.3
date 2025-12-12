Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BCAD49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hO-0001uE-Ep; Fri, 12 Dec 2025 10:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hA-0001nV-K4
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4h9-0005dV-5m
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6wSYJ8ap6r0Z/WMP8uHRmbaJ+AkxxgFyz2Vc2Mo7DI=;
 b=HTe5aFuLXUcGEAZBKoftb2fC+PZX+6LDNd+VptsLLvpecVZQZSeemQaWk+mLltwnxMS+d+
 6xVT4eohDvO+fKWseK1ds23UqPa5kaZFPxKRkXyzzy4WzuOHa8++tWMfjUOvOlB2RfMiNC
 TKBTXcz6yN6dWxoOxlkbdA6feOXIqgU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Uk9SAxWUP2yC5aX5ZhXTEQ-1; Fri, 12 Dec 2025 10:04:33 -0500
X-MC-Unique: Uk9SAxWUP2yC5aX5ZhXTEQ-1
X-Mimecast-MFC-AGG-ID: Uk9SAxWUP2yC5aX5ZhXTEQ_1765551872
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29be4d2ef78so24271385ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551872; x=1766156672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6wSYJ8ap6r0Z/WMP8uHRmbaJ+AkxxgFyz2Vc2Mo7DI=;
 b=OHuNUFR+SjHmsm6agjWMvihegwmI7ulUjYBgR5Ks6P2S3GXRdvYcD2Nbe7JlR19afR
 qp2aUYozZCNUJnq5LjYi05N7OJuZgFmAApTJHhhys0Um4axkFd5hw2ksaqnO61xUotyg
 LqiE/dMKgIWIwRNmeQIYeuJlx/JJHrXNB6SDEtErzH0Xi1jYhi4W74yKX92Wsb6+bk9l
 +f3bdkUjGE3pxn0kYu20TJFpOlpPisPV0SWd0lXJ5B/pPrEgLpRr5t7gYW/UEs4bZyvV
 u1gqbD/h4datRFdPG60CepLEuqZz4+7f66QSBO5pAwOS1NDWMBfBEIJcbaa2QVlFSGmw
 kQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551872; x=1766156672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C6wSYJ8ap6r0Z/WMP8uHRmbaJ+AkxxgFyz2Vc2Mo7DI=;
 b=jrAIMJiPGl1cjLavRRqMVOACUEfdjfG5AbmruksbGZBd7JNmFcnY9qfmEv/GZ7fxJU
 4zhuGfwbLqnrM08Fkkcf6m4TUN81D8UUUAEP1CPTgjLtSzc3WClaQ/eEwU9DrHKwgBLV
 oXP6K7V9X2pMZZkm97RWtGg5ubKMftlroE9o+jNu//h8/bTkbD6woA+QqXEDBRuBE/OA
 Y9CCoNLOldzUyCnZCkPYmK9g655RHvZmexqxCGguv7fK7dUJYJhX0ekOLYN9aMaJFZIP
 +q3EY/IEuyKpDqKAiBltuV5CxCIxWntNvm9VztmW/r5HmY79pW2Hop31xVcUR0SmoyeX
 m7mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqdhrz3m9wt75h+aI9hmB0q5WimyGPD/132MFrcG3SfvwVEzzV2IRlCMLyjdXd1OFbKsbdf6Zmr2p0@nongnu.org
X-Gm-Message-State: AOJu0YwxxTSruOSE/cCS/h6KYhyH38vHLLgafRqxlsboSvjVIMt3qGvI
 1i7Y2+OSYnDNSgsJocF8Zi6n9wU50rh0mXjG4oOcEB4yLbs3fIBn10eKQIHir+w86lwRKDOQmRs
 +8/qWkaFIPlMzhw0ODlHNwuM2OfvRhCHRbPDwnKMpZkAWR98WAr10WHue
X-Gm-Gg: AY/fxX68BBch5Npuf8yc2R8IinfWq/Y6so+z/56s6d9r7khh3UmEuLPrMqETJZWDdRa
 ZseBZoHO4aTDiKviUTp17IkY9VkXHyRxb6wy/645j4nopoXhv9aZR8ryUh34zIUGhttS85q7j9f
 zIbOYbfsx8gQNN3T8VL++FQ+PePSt30oWk4fqHJtC9vI2236J+sqecC6yQAZv3yFj/a2UB0LI5I
 5Q++GcZhh67riAmX9FhFV7zODbwQY7TUTKYmLQ8DFwfWY6Eh/+tZzYvQ98jQWDfFfYsHfiZL8Oh
 dIxs/iSF9bLbUJpQ6xojLGy3SjGLc1a5OZQOLdXTUv7MshDTE06vba8yLAcyqT1IZ49SXnh1ISe
 KE1BAl4eG702gsDhNyOXJmQIUZ7VKPtArTG8gkMkibOU=
X-Received: by 2002:a17:903:1aa8:b0:29e:9387:f2b7 with SMTP id
 d9443c01a7336-29f23de5f93mr22668985ad.11.1765551871873; 
 Fri, 12 Dec 2025 07:04:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE08PQKtH01txzVb58tmhQN8dUCENuVM80YududBQ2mzo4i2lT2A+k0CkldiCwWeXjkA3Bp3A==
X-Received: by 2002:a17:903:1aa8:b0:29e:9387:f2b7 with SMTP id
 d9443c01a7336-29f23de5f93mr22668515ad.11.1765551871328; 
 Fri, 12 Dec 2025 07:04:31 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:31 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 03/28] system/physmem: add helper to reattach existing
 memory after KVM VM fd change
Date: Fri, 12 Dec 2025 20:33:31 +0530
Message-ID: <20251212150359.548787-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

After the guest KVM file descriptor has changed as a part of the process of
confidential guest reset mechanism, existing memory needs to be reattached to
the new file descriptor. This change adds a helper function ram_block_rebind()
for this purpose. The next patch will make use of this function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/system/physmem.h |  1 +
 system/physmem.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/system/physmem.h b/include/system/physmem.h
index 879f6eae38..bfc0a623ac 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -50,5 +50,6 @@ physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
 bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                         ram_addr_t start,
                                         ram_addr_t length);
+int ram_block_rebind(Error **errp);
 
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..9a3e3c16f8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2839,6 +2839,34 @@ found:
     return block;
 }
 
+/*
+ * Creates new guest memfd for the ramblocks and closes the
+ * existing memfd.
+ */
+int ram_block_rebind(Error **errp)
+{
+    RAMBlock *block;
+
+    qemu_mutex_lock_ramlist();
+
+    RAMBLOCK_FOREACH(block) {
+        if (block->flags & RAM_GUEST_MEMFD) {
+            if (block->guest_memfd >= 0) {
+                close(block->guest_memfd);
+            }
+            block->guest_memfd = kvm_create_guest_memfd(block->max_length,
+                                                        0, errp);
+            if (block->guest_memfd < 0) {
+                qemu_mutex_unlock_ramlist();
+                return -1;
+            }
+
+        }
+    }
+    qemu_mutex_unlock_ramlist();
+    return 0;
+}
+
 /*
  * Finds the named RAMBlock
  *
-- 
2.42.0


