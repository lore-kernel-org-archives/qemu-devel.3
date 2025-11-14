Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A07DCEACC9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK08l-0000Y0-Mc; Fri, 14 Nov 2025 15:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK038-0007XE-Fl
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:40 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK035-00052I-0A
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477442b1de0so16557385e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150733; x=1763755533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c57WLejTczCDPIZIT4ByZo9teKQW5zfA4LdyJABPRTg=;
 b=QppJPeo+VWYr4Q75W7p8EbkgDRw8IYmRPUbR/eVthkPB72UKGvNrlYs31gmioACHYQ
 s98ls2nIgKQF+DZtr+rnLAJz3pMY7BLujRtq4wDiaq6f28d54sKf6n8jPIT/BQQ2xOVV
 vsAs107qWNtGb/iHcUM/EEWhyoo49XJ7D9zvzwrFXCuQrB5oNblWlT2XRosmSzTQ4ET5
 fRgamfpZru45vqrOkuRjhrUYm1Y6l9tp6WTYizEV6Ha73dfAUodAUtUq3wks1PxlaJSV
 nLprT1Qck73wtrkcAT5K2sNKr+5akSqiGNyjYDqU8dwIeNZb7i3K7AahJ6xl6GAQcZqX
 028Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150733; x=1763755533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c57WLejTczCDPIZIT4ByZo9teKQW5zfA4LdyJABPRTg=;
 b=guek0d/8GbV4qGeOARbmGrTR1cJxBtGoYqbi9s/gtcZIhBHDNA5GMTyTRMB4hDiJy8
 BDybAqgCTDpvGW+4B52ba1p+IiEsx9aoGtcNXy1fm0Yc4slaVU4eGH7NpriLh2Hu+y8N
 5iJBSNHKgoWcZIo79hGT0jREmuIzwUc5Q5bj/ihiyRpeLKZnUjnELoZPIj29UY2uSyJ4
 /eHhXjGqifNUOL7UUekUCHkh//AsVZwKFLyVhp1msiueO2B0zstQjC84DjcvzjLvzsiD
 si3PGgz/K//JWsJ4SHOt0dqry2gyuE71nv/R6qgEs5XcatiVGaHtCJToUdcpLWRE2REk
 qnWg==
X-Gm-Message-State: AOJu0YxOfXE1niaYRCcZRThW3I9SCGDr716Wq1LXYyUP6/9ifpSkrLa/
 2ySgmB8Q73H4uiIKN/PnWhvgYBssEYFbHBEXMTkTRjxiwdJMTyjBRd3fhDJh59CjHlt6K8oWLoG
 vJlduVQhjGw==
X-Gm-Gg: ASbGnctX8zckuae7bpqOF40hqxaQGyxnhsaht1Gm53nrqVkvMGQMaosEl3Os1q/gDy3
 etwuasPFAq6HUFiCJ8jPcCxip+qVxuxJBR9ubOunW7m5YcqsGQgmxIBeCTEAaVR1/L6kQCuvJgk
 KwvWIyaep1GiVRQj9MVELBA9izVlDPB11/2GZd+wjrO7u1h3nCsB+A/Cm2RhphdaUo69sUL/PPR
 ToWVUaPJP/kuDLZKHPKHlrx2gIM2Zk+p17wMduWxtXANLxcN261bckCgCPUA0eYd2Sj41BkMums
 jDZF+pv8zwOdfQyi9D0lq5E+k44yRrLB7KIFTKvXtYzh3Vtyj2fZbSavtsPubrwL4HPcOUBwh1y
 2GR9YKaUVZYlDK7fuE1l/OSWdsmuyXuWilqXLJ3J48JJDm2JXwxEFbk8Q6tn/iCmreF4TYp7dRs
 yC7H7Jzre/qs/QtMgTx7KyH9LbscUJlfrmays8vY/v5rfthEoUIQ==
X-Google-Smtp-Source: AGHT+IHqeBOSMKLNNldaJRXQP0ek6SqnouURcfZIVOVRbaJb9P1r5Ge/Nma316g307Ny2vao37Wy0g==
X-Received: by 2002:a05:600c:6289:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-4778fe8cae9mr43597315e9.34.1763150733059; 
 Fri, 14 Nov 2025 12:05:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779528bc65sm27641595e9.15.2025.11.14.12.05.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:05:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 09/19] accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
Date: Fri, 14 Nov 2025 21:04:11 +0100
Message-ID: <20251114200422.4280-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

These are now unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h  | 13 -------------
 accel/hvf/hvf-accel-ops.c | 14 --------------
 2 files changed, 27 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index ee7ab689f45..d842d4b2b99 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -24,15 +24,6 @@ typedef hv_vcpu_t hvf_vcpuid;
 typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
-typedef struct hvf_slot {
-    uint64_t start;
-    uint64_t size;
-    uint8_t *mem;
-    int slot_id;
-    uint32_t flags;
-    MemoryRegion *region;
-} hvf_slot;
-
 typedef struct hvf_vcpu_caps {
     uint64_t vmx_cap_pinbased;
     uint64_t vmx_cap_procbased;
@@ -45,9 +36,6 @@ typedef struct hvf_vcpu_caps {
 struct HVFState {
     AccelState parent_obj;
 
-    hvf_slot slots[32];
-    int num_slots;
-
     hvf_vcpu_caps *hvf_caps;
     uint64_t vtimer_offset;
     QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
@@ -70,7 +58,6 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3e5feecd8a7..bbb0b385fe9 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -64,20 +64,6 @@ HVFState *hvf_state;
 
 /* Memory slots */
 
-hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
-{
-    hvf_slot *slot;
-    int x;
-    for (x = 0; x < hvf_state->num_slots; ++x) {
-        slot = &hvf_state->slots[x];
-        if (slot->size && start < (slot->start + slot->size) &&
-            (start + size) > slot->start) {
-            return slot;
-        }
-    }
-    return NULL;
-}
-
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-- 
2.51.0


