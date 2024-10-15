Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD0DD216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNV-0007J3-9O; Tue, 15 Oct 2024 10:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNS-00071f-QT
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNQ-0003NJ-UE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koz/G3cW7QrxyAr2LwWkVqJu1GI0aKjAt6tlkdvB3fg=;
 b=UXoER6h2wPfhnt9ovmtG+a67O/yEtIxCWvzLev3kImiJ82NQ+GJQTCIb+I3UJOQfzXH9Uh
 oUk4NG3i86RGmzzke2LjUu7bs5tJoWcyLDevzOE3sSbYMXY+ASXvvTGH5ocjm9LKS9vnH+
 FXKhKmXASu27DWy43Pl0it1F8I+BfH0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-YUcg5UQzOkqGMSAAQ-FliA-1; Tue, 15 Oct 2024 10:18:18 -0400
X-MC-Unique: YUcg5UQzOkqGMSAAQ-FliA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d662dd3c8so1341688f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001897; x=1729606697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koz/G3cW7QrxyAr2LwWkVqJu1GI0aKjAt6tlkdvB3fg=;
 b=nJrQBV0WLRpL2QYiOmXzx30WDvsACyqobDbDo3wmDPcW+i+CSea/qFGEAwo7XdiTbK
 fcrMot+NUhcw4EguuAFn34Tlb/MavrcLA8B/RhEOg3VnexJmFdG5nMaTgtFPpz19EZ6q
 TXNFJAGNIrS3xS6F0exjtPoT5azlj8V8QVKfg6kAkMKh/TinEILqLhn2fSwX2nfZIJmP
 a+f4G7avUiMd/0JOZ1S1ueYKKERZEGvh0RVe6/V6ZEJRukXlVHJ/HobpBJ9dUwACLUTW
 TtjZH73OGWaQeSLQ+OL8FvvT263KkXGGgqpRhYSZd5/xlLgAV0UZoCqocfqGxTC4P5w/
 YAAw==
X-Gm-Message-State: AOJu0Yx/uCuLl11H4izJ6rpMHfINk8/clmZkLM9+A61adENHi/hklO9m
 xgVsCuk7mwGBmhSZTZy2n+bKir9Z42xreZRtUKGu4qmV+R/C95wGO54/czcEGYdeAzYl1vbBDtO
 ecWVabA4VUlHqLPfue5Ff7lSrx44vuQEF2ILHABvmbc0VsGyTpakmzLQO0K8ZbufwkkC/yG0x/v
 Jj6bL+ElpWZKUgLqtmhBguIE2v/dRKV9bUp82a7rA=
X-Received: by 2002:a05:6000:b0c:b0:37c:cf3a:42dc with SMTP id
 ffacd0b85a97d-37d55262e4emr9887833f8f.37.1729001896746; 
 Tue, 15 Oct 2024 07:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJD4fulMh+1zDy1H1mjwIbJrw3+lZwGC6PC4eVc2b6saP8c/4Wh4SOphGhvqU5mktjaopM5Q==
X-Received: by 2002:a05:6000:b0c:b0:37c:cf3a:42dc with SMTP id
 ffacd0b85a97d-37d55262e4emr9887801f8f.37.1729001895718; 
 Tue, 15 Oct 2024 07:18:15 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf821dsm1689553f8f.80.2024.10.15.07.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PULL 18/25] KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
Date: Tue, 15 Oct 2024 16:17:04 +0200
Message-ID: <20241015141711.528342-19-pbonzini@redhat.com>
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

Make the default max nr_slots a macro, it's only used when KVM reports
nothing.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240917163835.194664-3-peterx@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f84413b7954..c32a84eb5ad 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -71,6 +71,8 @@
 
 /* Default num of memslots to be allocated when VM starts */
 #define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
+/* Default max allowed memslots if kernel reported nothing */
+#define  KVM_MEMSLOTS_NR_MAX_DEFAULT                        32
 
 struct KVMParkedVcpu {
     unsigned long vcpu_id;
@@ -2613,7 +2615,7 @@ static int kvm_init(MachineState *ms)
 
     /* If unspecified, use the default value */
     if (!s->nr_slots) {
-        s->nr_slots = 32;
+        s->nr_slots_max = KVM_MEMSLOTS_NR_MAX_DEFAULT;
     }
 
     s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
-- 
2.46.2


