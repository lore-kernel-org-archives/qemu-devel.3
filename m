Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1641FCCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQk-0008KL-AY; Thu, 09 Oct 2025 03:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQi-0008Im-5G
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQe-0004QG-Rj
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUFiULUVUzPH0BKks65FyI6vNwb5lhVHtOUe9XrvOsw=;
 b=MxkeYlvPktbiKY0jlexyzuhvMmUKk69WUOMcnQtlIN9b05eot3X+RUwWHfYz6UpZm+4QS/
 e4zcyYXi5vIOZPBsZHuV27ZGSOtYJDbckB5gf1j/pqDLAK+RcHlJg7SZgQNopGbUjUGx0l
 tXbKoFPICwyIIuNP1czrUzf9LUKWYY4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-lqbaUwSDOP2jKGhIorblWw-1; Thu, 09 Oct 2025 03:51:09 -0400
X-MC-Unique: lqbaUwSDOP2jKGhIorblWw-1
X-Mimecast-MFC-AGG-ID: lqbaUwSDOP2jKGhIorblWw_1759996268
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46b303f6c9cso4328605e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996268; x=1760601068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUFiULUVUzPH0BKks65FyI6vNwb5lhVHtOUe9XrvOsw=;
 b=ppEF7SaBzvtPJp5UmRnnnHtTrIXtTpcsBC1EWzTidfBiCUywYIRcwqqpxNDJDsqegw
 pyIyjry4B+AHBg7wRI/ed2HVQP9EBmGZa4Jcgbs409zgj+RoSzwCYxe9KTtgvIrxM5tA
 +xXfhDoyOrgTBdfh1GxSWFs/p/xnNTamaS+YtO5z3mapgBuV8Vjy8hwViE6H8xCQc7QE
 ov3P67NqqcYKSlhBuj1oreKtxNnuODBvHLzNWOR2Kw+Rq/V53PXK7uXH4tnzKvrdI5bH
 B9Kd7O03lUHAIgYQ6hBsyxtjyImaB3vWnUR6ISa9E6r8j4iKoxC6SNH1GBnJoAorOepn
 0F5Q==
X-Gm-Message-State: AOJu0YxbngIuQLYGd3fi5eQ0seLE1/8IjQSKu5snxCs+Jv/WEUuQ2d8u
 tYTIn2JHJ8hHyC2tQTuDmMXsXp5sj4FQD4kbwjpTwS1rWOAtExu5J+YiSIQLHq5N605uJNQ/k7v
 WvSyVqRkN5w7OQzWmi5/mYChKZ4Kgu0xh2Z4bSH/gzLBoUdxBKLZG7Z/Qff7gFKiyMu4Hkm32lH
 iEzH1DUgwF5o4mGouxqWPC2ryfOlB+6gWar+MRtfzH2xU=
X-Gm-Gg: ASbGncuKC68bXyy/ExRp6B/P2QoJQU7fxFXD4oNDyC4shKrwLF22Zy0sixell8O1dh9
 3SdLhz+iIxzWVKdX9n+po76Q1WGlyR0gPPV3fgFOksplZc1RPmOEWN10zmJ1x4nPkNOaGWUAYia
 VUP/qnUB1NMlT71ZbTztjaiQ8RDaEOF7Lng/gsP8V28Ha8bk18YJVZbxGlxHx0AkEPQBKP9Bq9C
 q8UDfiQUZv4of3cooWhFObb0e0gob0cxs2Mloe/v2EloU+OmfLvP38AP4eXXB2vdxKXU816F9ZN
 JHIjt2r4X3RjRzv77aSA0j3y1LoH0vYMXsU97GLbdNxqHXxRl69QYGocZPz6l43Ya3iAv6JvKmm
 3LQVLWxPGB6CG/FAWnX7FDyeh5kD0QjWOfe3lUmhEDusfc9bw
X-Received: by 2002:a05:600c:3b2a:b0:461:8bdb:e8 with SMTP id
 5b1f17b1804b1-46fa9b06c50mr50772595e9.30.1759996267940; 
 Thu, 09 Oct 2025 00:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcmxZ0RQ3ZSpR7X2jz0a7Uc3cD7JtYWf8Nr2Y04yPz0GR7R04c0TGJprT5HfxkzfiNxk1kBg==
X-Received: by 2002:a05:600c:3b2a:b0:461:8bdb:e8 with SMTP id
 5b1f17b1804b1-46fa9b06c50mr50772305e9.30.1759996267492; 
 Thu, 09 Oct 2025 00:51:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab633cdasm30515265e9.9.2025.10.09.00.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 18/35] target/i386/mshv: Add CPU create and remove logic
Date: Thu,  9 Oct 2025 09:50:08 +0200
Message-ID: <20251009075026.505715-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Implement MSHV-specific hooks for vCPU creation and teardown in the
i386 target.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-13-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 02d71ebc14a..5069ab7a22f 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -30,6 +30,8 @@
 #include "trace-accel_mshv.h"
 #include "trace.h"
 
+#include <sys/ioctl.h>
+
 int mshv_store_regs(CPUState *cpu)
 {
     error_report("unimplemented");
@@ -62,20 +64,29 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 
 void mshv_remove_vcpu(int vm_fd, int cpu_fd)
 {
-    error_report("unimplemented");
-    abort();
+    close(cpu_fd);
 }
 
+
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+    struct mshv_create_vp vp_arg = {
+        .vp_index = vp_index,
+    };
+    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
+    if (ret < 0) {
+        error_report("failed to create mshv vcpu: %s", strerror(errno));
+        return -1;
+    }
+
+    *cpu_fd = ret;
+
+    return 0;
 }
 
 void mshv_init_mmio_emu(void)
 {
-    error_report("unimplemented");
-    abort();
 }
 
 void mshv_arch_init_vcpu(CPUState *cpu)
-- 
2.51.0


