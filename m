Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6372CE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd1B-0003mt-Tt; Mon, 09 Dec 2024 07:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd12-0003kR-7x
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd0z-0007Nv-38
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EK+6NhPLRnfB+w3ii90rEiEDD8OWs1ZakSYY9qmOsvM=;
 b=HmX/HCXIZD0Q9/iR3NZzaGbZlDPUMgSNQY5NbGua9teOpPSkq4rnoM5ZL0BfU+UvYLkZv3
 ZXZoSHDRGiEC4Cl/8rrYdG+ZLd5HJY70k/8VA1pn1SD1qw3ZO0Mf2dMB0n4JhIQC574WHL
 AcKsZ1DxYg4S7ICUQYBNKvmBnghBJ6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-Qr6IG8QJMyCZ9dfloSjGlQ-1; Mon, 09 Dec 2024 07:37:24 -0500
X-MC-Unique: Qr6IG8QJMyCZ9dfloSjGlQ-1
X-Mimecast-MFC-AGG-ID: Qr6IG8QJMyCZ9dfloSjGlQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434f0206a83so9544855e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747842; x=1734352642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EK+6NhPLRnfB+w3ii90rEiEDD8OWs1ZakSYY9qmOsvM=;
 b=w9AtqdWe83RKi2ic4Rtz6QpgYBt6A2WuV/UiythWoS4FEXuAj40x0QmAVaIMH9U1lw
 X7U1Tav0RcbGWB7lxFmTcbYGkzfnbJ4jvMBnsqnYrK8vC9bY5xqDvE3TG+Wv0deucyAW
 /k5iN5nw3sxge1pV5aJ45UWFW/43cWtzqFt48YW2uXJohIoeBDxvpCZunN6pONJKweC8
 XyBWtcpic83F+Nml5aapgIXx6+5rUBfIp54VYB40zfO1LArd8UdjQScEdyqEI28i8SJN
 LNfPN5vOEY+m9ckvS76XNxzPOlbYUsyYRSnzVqIm01pC4LY/s+Tfwhf3rhEUh1UWFvny
 a21w==
X-Gm-Message-State: AOJu0YyJRgUJ7uOEQYTUdl+gbQN9Ah7lHVNvhI3KKuGshZZPE4jz+EOU
 J1l6qjgcJ0fA/b+9r0jx3/Sb6IFZpMc4xvBpKG3Axfb/4njK259/8yahTi8iohP8bGV8fTeen+a
 ZY8SYYifOJK4XSun6t0+fXYGFJ6sXWyevGrDSI5PVS4D17EkQAeN3F24R9mkLK8FGQ30GNnI2LE
 eWtfKsALIs6yOZH3AoUiDNcNFzKXCoY/SiKDOQ
X-Gm-Gg: ASbGnctE21jBH3HH5VUar0y68ltbdz6EMJ/PACl/cg0KQJPGCx17snOgCDVrT3ev61J
 YRDP7fK8Rn5kHUUu2iU7yfr22VESyOmUFDy+it3T3tn+OIM/zYIodhrwImE5RdQ+7i7fY7Bw2Y4
 2c7TTJIdKQxqTFZNIlE7K0dZRmivUl3WVCQCPY/57sKpKudMYaOOcjB0HlqOg1btuvgjAuqSR3s
 +m+BFJhd+3sFsZFD4Vc2w6TI2HBVbK59LBe5R8lOZLqKAMJq0XXMQ==
X-Received: by 2002:a05:600c:4e8a:b0:434:ffd7:6fca with SMTP id
 5b1f17b1804b1-434fff36e7cmr2877565e9.2.1733747842557; 
 Mon, 09 Dec 2024 04:37:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8GPC6tM8BP4oyS2XcKjZs8CdR5KwXF8EBpX963R9c5kDlndkEeVFU1H/170eovy4nBhnt/A==
X-Received: by 2002:a05:600c:4e8a:b0:434:ffd7:6fca with SMTP id
 5b1f17b1804b1-434fff36e7cmr2877225e9.2.1733747842143; 
 Mon, 09 Dec 2024 04:37:22 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f08b9eebsm74725945e9.10.2024.12.09.04.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 01/26] bql: check that the BQL is not dropped within marked
 sections
Date: Mon,  9 Dec 2024 13:36:52 +0100
Message-ID: <20241209123717.99077-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


