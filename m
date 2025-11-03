Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A32CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrbA-0008CZ-FA; Mon, 03 Nov 2025 05:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrb7-000828-Ho
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:15:37 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrb2-0003LV-Tv
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:15:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4710683a644so33123855e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164927; x=1762769727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4jVZL+EPfNSiEcUqc0mMtti7iz45SaUWfxueOvD5pC8=;
 b=tAzf9P4EjRPgLr8FVv1hca4kjM2As4clwhcmFcDAu00WpEGfuqjRCI9h6H85mCSdXd
 Lz7uMkVGZAy34QNytbvuQMqWI+EMGWLmSGQ3+d1ZRmyPQO/oqO0biZGhJEqQGxW4go52
 tcXZFd7sqC++mlpLtxlFyZB13p61wGmpS6pgd4a1VyVvvnWkrvRmUYRJQXYHX9IlS8bb
 g4fcHPI4OJzDCuKXjea21rM/vnhESPtSv1jRyhtXlWAvCQmi4Yoyhb9YEp0LMwD9yk4Z
 XN/xM7v2nEs70jGhXQmaZw2S2M3z9LBHX4ktj0gAZ2O8yqy5XYYbMAMOMB1ujGmrC3sF
 DUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164927; x=1762769727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4jVZL+EPfNSiEcUqc0mMtti7iz45SaUWfxueOvD5pC8=;
 b=diQ96upO3nZx0qOX5dvhzhxkC7WNZBvERST92oIuEr7vpzHJs31oz62aJPuuhdXrfu
 p5rTY3xwX0evSCIYMgMqDwGRF8PrAzLHhd0zux6r7KlM/PyVdyBMnsyRlXA2zkBTyh3L
 sm0yitrGv03zGAXJUpnYnihlJ+bY7C1Fw5QwFF5gQtwzHTyUZxRpuRX1/hFlF2PeDb5b
 Rvh990JYtj/PYtS8ipxIEDi8yjiv6Wzt2M2h+XDgMhrCQMvczB4+59PfqY7q0sybiwzg
 3W6JNzWlOgMQ8Sm88XEuGVQmyS6LVp4ywoXWrXd8FO8AThvM2TZWT3MhOni1YMa+u6zO
 tYdg==
X-Gm-Message-State: AOJu0YytGH3SDnrPu1XQNHwMkksQ78jite/oT6KMIPInBnQaQRhShsLv
 Il87Z828DLUbPuzZsjnj01MdEFkUquk0Ifql1T8fxfYiZDP88X5YTwBx7hKe35nVID9mzBsT1+O
 U/IcLfA4=
X-Gm-Gg: ASbGnctrXQNaDK3bLkdIQ2AkZIWtJ210CNjAQOnI4JtHy34+RxsGagePax5bX97CqHW
 TCLiH4BFWwIE85en15YxAV/bkoJF5OIc7ePYdAdNJdiWClRvQLBATK+MrG1VtYBHKq2GDz/7I5Y
 iJb4ON8OuIqg3ORbX7vJgETtqn0rPhf0mQ8y9JhYqbqYJ2NUgcGjOC70p1Q9+hmZozot9YN4Zn5
 NWzvVJHnhSTpNsj/0jo4VOSpqYuvjejc8fuNh6+f+4B/eDlBU9cWdHIW0m9FnP01EK46A6gNI7g
 IyPAPFjJ3rXm3Ne1rczWRQ8EgV3BHF9LnZKkyPuEA4d5k9g44GAInm+lxCd5esmJdJh4NbMj3/W
 impgjARwOSODBJJWHzHp53r78ntnsbauvcH0V577LGtfakWps9ReJwR7GrjnAN9SLWGo9kG27Eu
 2MMebUGO/NwsjqGlmdevh4q0rrA4upFe44qnZjGGB9lPEBaw5Yh+RjolAo2vjKmQ/7ho3E6Q==
X-Google-Smtp-Source: AGHT+IGduk51gM2vy9eDhtnuyyaB6zcePqGNY3tSTdUHZOPImWAYPDhGV/Bac1PijLJi9wQG36XOMQ==
X-Received: by 2002:a05:600c:530f:b0:46f:a8fd:c0dc with SMTP id
 5b1f17b1804b1-47730068201mr132385495e9.3.1762164927408; 
 Mon, 03 Nov 2025 02:15:27 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c394f0csm145356445e9.16.2025.11.03.02.15.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:15:26 -0800 (PST)
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
Subject: [PATCH v4 11/23] target/arm/hvf: Implement dirty page tracking
Date: Mon,  3 Nov 2025 11:10:20 +0100
Message-ID: <20251103101034.59039-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Notice writes to pages which are being monitored.  Mark the page dirty,
re-enable writes, and retry the instruction without emulation.

Assert the fault is not from a stage1 page table walk.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 52 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index de1e8fb8a05..0f584b8137a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1869,9 +1869,10 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         uint32_t srt = (syndrome >> 16) & 0x1f;
         uint32_t cm = (syndrome >> 8) & 0x1;
         uint64_t val = 0;
+        uint64_t ipa = excp->physical_address;
+        AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
 
-        trace_hvf_data_abort(excp->virtual_address,
-                             excp->physical_address, isv,
+        trace_hvf_data_abort(excp->virtual_address, ipa, isv,
                              iswrite, s1ptw, len, srt);
 
         if (cm) {
@@ -1880,23 +1881,56 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
             break;
         }
 
+        /* Handle dirty page logging for ram. */
+        if (iswrite) {
+            hwaddr xlat;
+            MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
+                                                       NULL, true,
+                                                       MEMTXATTRS_UNSPECIFIED);
+            if (memory_region_is_ram(mr)) {
+                uintptr_t page_size = qemu_real_host_page_size();
+                intptr_t page_mask = -(intptr_t)page_size;
+                uint64_t ipa_page = ipa & page_mask;
+
+                /* TODO: Inject exception to the guest. */
+                assert(!mr->readonly);
+
+                if (memory_region_get_dirty_log_mask(mr)) {
+                    memory_region_set_dirty(mr, ipa_page + xlat, page_size);
+                    hvf_unprotect_dirty_range(ipa_page, page_size);
+                }
+
+                /* Retry with page writes enabled. */
+                break;
+            }
+        }
+
+        /*
+         * TODO: If s1ptw, this is an error in the guest os page tables.
+         * Inject the exception into the guest.
+         */
+        assert(!s1ptw);
+
+        /*
+         * TODO: ISV will be 0 for SIMD or SVE accesses.
+         * Inject the exception into the guest.
+         */
         assert(isv);
 
+        /*
+         * Emulate MMIO.
+         * TODO: Inject faults for errors.
+         */
         if (iswrite) {
             val = hvf_get_reg(cpu, srt);
-            address_space_write(&address_space_memory,
-                                excp->physical_address,
-                                MEMTXATTRS_UNSPECIFIED, &val, len);
+            address_space_write(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
         } else {
-            address_space_read(&address_space_memory,
-                               excp->physical_address,
-                               MEMTXATTRS_UNSPECIFIED, &val, len);
+            address_space_read(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
             if (sse) {
                 val = sextract64(val, 0, len * 8);
             }
             hvf_set_reg(cpu, srt, val);
         }
-
         advance_pc = true;
         break;
     }
-- 
2.51.0


