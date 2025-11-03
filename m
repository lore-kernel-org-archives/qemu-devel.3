Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2F9CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrWw-0002tm-PT; Mon, 03 Nov 2025 05:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrWv-0002t9-KL
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:11:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrWo-0002Ms-Ov
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:11:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so22231065e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164665; x=1762769465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rAlH1/lu+rh7awee2lje3uE1FvJDSXtcSFDkovTFo0=;
 b=W9Z6f/WFLSs1dKubvM7c7XENY0XLmGLj6HJYLAbCHwjzu3/bNpJRH8luXTACSlaciD
 1n4hEUnqDvayfJ0iZVxIg3rhk8+xExNYYqZIJGVxN9d2l9bE2qQQ4df+y3+kw944uRlp
 fTVc77u/+ropXR42E37vnGLt+F5GI5KMONql5Mz0t1vGLtX1fCv2HJTwNaOzRLOZ8cot
 H7ExkWrPW4R/bIoUDPD/RLJY0UsGbbD/Z3Xg+pg+54io3qZZwQii8zc2sEl4f5/U0YEC
 BqIAn/4KR2RUNT8AuCjuP2m1x+7f/Ha3SNufZuUo8pD/Bnvs4Lu3ZJ8AoskUqHutXizm
 xY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164665; x=1762769465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rAlH1/lu+rh7awee2lje3uE1FvJDSXtcSFDkovTFo0=;
 b=WKg9/aco+aA4P2J0iohBP4z0dDpzZ8ilMjSa/sfd4ba8YZCMihKLcpbdpubpYO+sce
 Pu0QDrMTR2TNXC68H1ZINn4LS9VqE5jnutWI9V6h+6dEjbdR0PNfs8bY8dr+PDZi8u9e
 zKYOL7YRXd/kxHu2g7MCcvm9POGkI3RmQp6K7GVcIAXnreEG9UCLT4QLGvnJLvo072VU
 KPLkA9oHGurIcutX1I15H2ItUQA1s03toNFJBoOvv5+mnz/kwAiIizxxHtYhSXb4Hjn5
 mS6rnBBGZt5tnMi8RXHmD/j1V4oS6QQEQMjJBgZOgM8xEgIgeibpkW4c+GH6ub7Qs5ak
 yGjg==
X-Gm-Message-State: AOJu0Yz8zhVXJZEBvqlLDXB5lE8TblKaa+Za4szxVwSdmhnHJdoSYGb7
 VxoI/G22G0FU+KmevmL6Xg7ZmQdoO+/ZJcsri3W14B9KFJFQ4vwygx74YVUkbh9K/VXSSLH6zze
 AWQGZ3ag=
X-Gm-Gg: ASbGncvOoeQxL1DqgnIdkryQdaMJbUkSF14/KDJDBD+t62fy8/v1tYcbrSztiYFmiWg
 7omlVZ6VqmIfk9x0om/YaeYTn2ERhiNexkMewVWbAl2f1NXbfytJpuJ0IQNbItGyZ1EzEyrcvT6
 h5NoLu6ncBO/AV64BwxauSsKCme1Sc0sayy10lUspeLNJb3tVwlVnkd8vVdVr8k/zWPxhalaSXb
 YxqTW42bKgneWQTpK8+uGkAVxmV5lS7iMs84c5LaJSM1RQgRfbsC2YrtqklIWyXTlXWGce57uGs
 eac+o7I9Mljuq5zL5sgjA11hiVwx9YEuqfpVir7hSBi+Crb0XCPLzA79M789epmqFct1CeIw1PA
 7aN8vAhvZsZud/v9u3sQaPZ6jWmFxfShjT67s19KFtCW7o6iAXh+5dhgZtVvKG2kbOBXWITmQR0
 4xWP5hX/xyhmBl7kqcH1/6s5KVbrMWXBkIHaF11f6hXHirbREm40YXB7nSEKXhxvAs7y+cQg==
X-Google-Smtp-Source: AGHT+IHs/P5YscPj+tiHtkpPgXXoxry5aWicGkm7sN3Y5SjwmybunJib5OIWFCd+Nq4DsHykxWj25Q==
X-Received: by 2002:a05:600c:1553:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-477307ba7d2mr101696115e9.13.1762164665037; 
 Mon, 03 Nov 2025 02:11:05 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c2ff714sm145460205e9.8.2025.11.03.02.11.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:11:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 01/23] accel/hvf: Create hvf_protect_clean_range,
 hvf_unprotect_dirty_range
Date: Mon,  3 Nov 2025 11:10:10 +0100
Message-ID: <20251103101034.59039-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h |  3 +++
 accel/hvf/hvf-all.c      | 25 +++++++++++++++++++++++++
 accel/hvf/trace-events   |  1 +
 3 files changed, 29 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 3d2be4092ef..5a57691885f 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -89,6 +89,9 @@ int hvf_arch_get_registers(CPUState *);
 /* Must be called by the owning thread */
 void hvf_arch_update_guest_debug(CPUState *cpu);
 
+void hvf_protect_clean_range(hwaddr addr, size_t size);
+void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
+
 struct hvf_sw_breakpoint {
     vaddr pc;
     vaddr saved_insn;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0a4b498e836..e13abddbd9c 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -58,6 +58,31 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
     abort();
 }
 
+static void do_hv_vm_protect(hwaddr start, size_t size,
+                             hv_memory_flags_t flags)
+{
+    hv_return_t ret;
+
+    trace_hvf_vm_protect(start, size, flags,
+                         flags & HV_MEMORY_READ  ? 'R' : '-',
+                         flags & HV_MEMORY_WRITE ? 'W' : '-',
+                         flags & HV_MEMORY_EXEC  ? 'X' : '-');
+
+    ret = hv_vm_protect(start, size, flags);
+    assert_hvf_ok(ret);
+}
+
+void hvf_protect_clean_range(hwaddr addr, size_t size)
+{
+    do_hv_vm_protect(addr, size, HV_MEMORY_READ | HV_MEMORY_EXEC);
+}
+
+void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
+{
+    do_hv_vm_protect(addr, size,
+                     HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+}
+
 static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
 {
     struct mac_slot *macslot;
diff --git a/accel/hvf/trace-events b/accel/hvf/trace-events
index 2fd3e127c74..f989da59492 100644
--- a/accel/hvf/trace-events
+++ b/accel/hvf/trace-events
@@ -5,3 +5,4 @@
 # hvf-accel-ops.c
 hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08"PRIx64" vaddr:%p flags:0x%02x/%c%c%c"
 hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016"PRIx64" size:0x%08"PRIx64
+hvf_vm_protect(uint64_t paddr, size_t size, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08zx flags:0x%02x/%c%c%c"
-- 
2.51.0


