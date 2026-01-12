Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61DCC9EC63
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDM-00025Q-Go; Mon, 12 Jan 2026 05:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDK-0001kn-At
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:58 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFDH-0001mw-TM
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:58 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so44256595e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213912; x=1768818712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y91fAvc6xKZuK9le0d8AtWKsv85XevnNosJ5k8ViqPs=;
 b=LIaRnWbrnWBEY4SZEucLHKlMk57rAjAnh28e0hctfoAsIxLWwDHmTLC1dk0pEgxFM+
 z2Kb3JdVWqbv+YtDIzJHal5Jo0EITelgzDsRyrB82l2Bg2DLx2O0YT8m5ndIwlIh14TA
 QHXNG9CNAeYvRBWKIS4E+6/BDPkgT1NI+l4Kqx5sVraCX2NtrfhQfsr8VJ67DCySst9F
 R23mSxVTCVRwpvVGgPLXyg58Y2igAS2dwbopSzDeN7fCbHyVSrLf4OTIOKS24Rzi534R
 bSLvmAs8lydTm7UFYwq4SU/LgTg03lNC7lM7a+o8jSKjjB6vfUyGqhzUzVbZKikWp+de
 d1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213912; x=1768818712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y91fAvc6xKZuK9le0d8AtWKsv85XevnNosJ5k8ViqPs=;
 b=I7T7VXRzvfm5HbrbmOa5MIWYPvNvHIi1Acl7xBUQfSHYf/yVqgxLjkMd5B4Y0uuGO1
 i1yVvegXPLg3m8EZ5EjxiNk6mshYN2dUSYfEY0oc2H9M1AIdF/GkaAFTIoF31v2naRw0
 OiqI8rOOt6xqKFVePrDpvbaJP4NEEabRjCxKvY+F4SFK4QA29NYLd0kO2FAdfxQFz+in
 4drqXxtV2pP4JZgd5ZwubaYpTrf1iZ/NbWnyyjAng4H4XxMFkE5DqOSY990C5d/bp3RL
 RYDFNY7uzx1JmcTmP1dTv85tkmYbysa9yt4envXhrGNVtz+v1SpyO98H9gge+DGsPWe3
 TQxw==
X-Gm-Message-State: AOJu0YwfPX9DCvETUD2ME2Ko35PY3FhVcMUZexIQOACtJsrd2AIQ17Of
 qh0zLqOOuAl5loyJ0Z8GowATU46OurnoM7tsKGpdWmMwblzmbRsoW4J5Ou7GtAybTuHEs0Nj9x+
 j41q+gy4=
X-Gm-Gg: AY/fxX7RBJX6giiqnxaZaG2nnKpKLFmf3NSidI16ih6WyrRbf0y/Z2Rt9fARSYafTa8
 VZWJgf56Pbruh5wueEN50UHmfC1294G/iSuiGXTN3Os7gMLpJrdY7YMj2O6hfcOesGphQrYKsVC
 K3kQ9f+3+5k2A9m7iQnxPrUTZHbQeXIp+8tskwhbkJDxQQa8UhhlHoEt3Db0hyXEmlFY2DzxR65
 6T7BcKAG0sHphslEvnGaB6FbP8q9yauKhaGBpaKNLLjlicXGLyp4IEgiC+bwcD1n5Vl4Nmt8Cug
 zAVgbd+xGF6X7o0En97IG65xUk/iIPUcrF9qoCtgsutDUOVt0JvzgwBPNGxAQaYQccEtgrDGQdZ
 7xX7gki7kTRAa6JqEwEXHH6dDm90sn+P+b8Bl/dJH0ZrK0B8x8hGBySwc3qKgGpc2dDeq2kpOKh
 XZgQwMFEdU1V4k6hRnQyrnEsoFBv3lwR6fjbuLTD2AigsYjn0tnAoGQy0wjwPU
X-Google-Smtp-Source: AGHT+IF4tNvGEfgGyLJ0gHv50pXMI++ff4bnPOIRsPkDgJIApYNMzrEw0GLsE39MPAuclIxWVnFdUg==
X-Received: by 2002:a05:600c:4e13:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-47d84b32f30mr219949655e9.17.1768213912562; 
 Mon, 12 Jan 2026 02:31:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8660be14sm133154575e9.1.2026.01.12.02.31.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:31:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 11/19] target/arm/hvf: Implement dirty page tracking
Date: Mon, 12 Jan 2026 11:30:25 +0100
Message-ID: <20260112103034.65310-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/hvf/hvf.c | 52 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fa26f63a61a..af28b8e8825 100644
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
2.52.0


