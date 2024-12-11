Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0886FE77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPa0-00019G-Mu; Wed, 11 Dec 2024 11:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZy-0000l4-FP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZw-0000aq-F0
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EK+6NhPLRnfB+w3ii90rEiEDD8OWs1ZakSYY9qmOsvM=;
 b=X580G6WT+7ZRiQVuOTZIu8/wqVAl5NvpAQxMnjxNydPCB8OdPVy5HxvE0IlfQU7TxXH1Wi
 +MKNbGd3zECcCr/lLcWma5HOS1JkLpq86cqtgZJUA72D8oyvZby0o7JL8FRO3U1MTlSalM
 7E11riZRTOJW0+g+ved9TpmEeoXmfO4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-IGgLTkXOMx-7vjyvGgnRZA-1; Wed, 11 Dec 2024 11:28:46 -0500
X-MC-Unique: IGgLTkXOMx-7vjyvGgnRZA-1
X-Mimecast-MFC-AGG-ID: IGgLTkXOMx-7vjyvGgnRZA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436228ebc5eso545515e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934525; x=1734539325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EK+6NhPLRnfB+w3ii90rEiEDD8OWs1ZakSYY9qmOsvM=;
 b=wO5Bb93Hpkn52S/blx73fsBXC6GjavsfuHc14ORHi1ICN0fhb338pAlzQmYAN4DU5P
 /PfehYjtVqPsQm1Sjtilw1pq7QABTlp3WU3QzS0PmjF5t7P5ORPY2QW6RIdAUPw4MVUV
 wN1Nv5xyWF5VSgghekYrvneFGU09wVv62zpb3jjiGagfz5UWRT/rG2QEEjPrW5iCOX9r
 prMENmXUACMvaK4J/qOcLf3QAdfJ97JIvgzwerKz9OeRJVd+blvX9wMyUymEvijM3uc3
 0RWwfTTdZ3tUb75biFLyHfo9NjX1+BM/t9SSP7Yebp8E9X1+CSX4wFfKAX+33kdcAuPK
 QJhA==
X-Gm-Message-State: AOJu0YyQytHJE4wCAENt62aMvL1dLJClS50bsJa+4brPqtvqeVAi1auU
 8jPSLfQytpe432Hd3anncU9fzVD0JEgrl9ipHxrjQaQkYC5pdbNytZ53IFxO5A47L4sU5ALDcFd
 bE900NGLLAQuaSFa1GED/dd9BAdR++Iht32tCU7gopItMOIncAbZPdFxcFyq0MilQk4Q1mc1oSJ
 LSJaABfgCwk9j/yif0Ho6Tu8XGyxZ7y9W8L2D+
X-Gm-Gg: ASbGncsITO16PcREgrcK3yU7D1NxgxmGTD3jqZVGfLhrGbIL02gVkjJ/WzC672mpzJc
 ox2HIEYLUPaq3s1IibVdiEExcIIC9CPWef+9iT+RX7Xe1Oh6kHNKIPkPX0DP0nk5Q8BE9Go3gA0
 mAx/jA3j+qVOuWQEExqY7YcLCi0tATGWMAp4YKFzIqCgSQwJwSA2dC4topGaOPAUAQ/DrgtxOJ9
 gE+M7ibcJxssUUpa6Y39+e2IjF1V9GF5KfD5T+W7H9RSiL8YGW01fn2
X-Received: by 2002:a05:600c:1c16:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-4361c3445a8mr31170375e9.3.1733934524960; 
 Wed, 11 Dec 2024 08:28:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1NQSjtWwRbIgKj+KS2F0+VKRwFApGXkxJY9BRaohVm5M+WwGRd+Ack1uUA6b6Po3ix0qjOg==
X-Received: by 2002:a05:600c:1c16:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-4361c3445a8mr31170085e9.3.1733934524448; 
 Wed, 11 Dec 2024 08:28:44 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361ec75410sm16194305e9.1.2024.12.11.08.28.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/49] bql: check that the BQL is not dropped within marked
 sections
Date: Wed, 11 Dec 2024 17:27:05 +0100
Message-ID: <20241211162720.320070-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The Big QEMU Lock (BQL) is used to provide interior mutability to Rust
code.  While BqlCell performs indivisible accesses, an equivalent of
RefCell will allow the borrower to hold to the interior content for a
long time.  If the BQL is dropped, another thread could come and mutate
the data from C code (Rust code would panic on borrow_mut() instead).
In order to prevent this, add a new BQL primitive that can mark
BQL-atomic sections and aborts if the BQL is dropped within them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/main-loop.h | 15 +++++++++++++++
 stubs/iothread-lock.c    | 15 +++++++++++++++
 system/cpus.c            | 15 +++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 5764db157c9..646306c272f 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -262,6 +262,21 @@ AioContext *iohandler_get_aio_context(void);
  */
 bool bql_locked(void);
 
+/**
+ * bql_block: Allow/deny releasing the BQL
+ *
+ * The Big QEMU Lock (BQL) is used to provide interior mutability to
+ * Rust code, but this only works if other threads cannot run while
+ * the Rust code has an active borrow.  This is because C code in
+ * other threads could come in and mutate data under the Rust code's
+ * feet.
+ *
+ * @increase: Whether to increase or decrease the blocking counter.
+ *            Releasing the BQL while the counter is nonzero triggers
+ *            an assertion failure.
+ */
+void bql_block_unlock(bool increase);
+
 /**
  * qemu_in_main_thread: return whether it's possible to safely access
  * the global state of the block layer.
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index d7890e5581c..54676598950 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -1,6 +1,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 
+static uint32_t bql_unlock_blocked;
+
 bool bql_locked(void)
 {
     return false;
@@ -12,4 +14,17 @@ void bql_lock_impl(const char *file, int line)
 
 void bql_unlock(void)
 {
+    assert(!bql_unlock_blocked);
+}
+
+void bql_block_unlock(bool increase)
+{
+    uint32_t new_value;
+
+    assert(bql_locked());
+
+    /* check for overflow! */
+    new_value = bql_unlock_blocked + increase - !increase;
+    assert((new_value > bql_unlock_blocked) == increase);
+    bql_unlock_blocked = new_value;
 }
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff6828..ba633c7688b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -514,6 +514,20 @@ bool qemu_in_vcpu_thread(void)
 
 QEMU_DEFINE_STATIC_CO_TLS(bool, bql_locked)
 
+static uint32_t bql_unlock_blocked;
+
+void bql_block_unlock(bool increase)
+{
+    uint32_t new_value;
+
+    assert(bql_locked());
+
+    /* check for overflow! */
+    new_value = bql_unlock_blocked + increase - !increase;
+    assert((new_value > bql_unlock_blocked) == increase);
+    bql_unlock_blocked = new_value;
+}
+
 bool bql_locked(void)
 {
     return get_bql_locked();
@@ -540,6 +554,7 @@ void bql_lock_impl(const char *file, int line)
 void bql_unlock(void)
 {
     g_assert(bql_locked());
+    g_assert(!bql_unlock_blocked);
     set_bql_locked(false);
     qemu_mutex_unlock(&bql);
 }
-- 
2.47.1


