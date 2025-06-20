Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69BCC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUK-0004hQ-3W; Fri, 20 Jun 2025 09:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUH-0004TP-1L
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUF-0004pi-9g
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso21167535e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424933; x=1751029733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoXZ8Al0R/es9sXpuEKkELf4IYQr/L/uwmOyRIHiR2c=;
 b=VJPAWiUU8ZrAI7HUR7Fh+SH22S5+wfd7ob+3W4tCfr9AIxxOm6vyCudaDtnAd88KaQ
 s8nuVtaTGV7P58LicYxqpX0cM1BrX4MLuU0p1qkSj3cIPecwS0LE8WUvQSbjwFFSC+uU
 K0gN+RuEQsAVLOPT0cnyVSFu8wetqnr+Srqge6+oVr9I8PVQCOUXwtgD+5GQkWGgpNEK
 tLAGLD53njoL0jwGg6gspT0rIsg4j6WjhBQIxoosPdUfb07ptfsgs5TGeu2UCjLBT04H
 IWh19k+LkiB5bAT1fO4nnSMLcsNgFKMf1FsGnDeCEYiPNsSeOIViXq9sVxf5EbTVPj4l
 1q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424933; x=1751029733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WoXZ8Al0R/es9sXpuEKkELf4IYQr/L/uwmOyRIHiR2c=;
 b=Py/w4cOQ3ZO1zbKxOk7ELqP023okKqhlQFEb3DA0aVwdDyBYNfMJ4kTQnoNboQjrcP
 aMEOi3PsWF0Grc3wTrKiKJ3C7yvDLEwlIPsgDf6Ot+fOoapt4tFfcxUp2hcGZzZzxikG
 hzVTlA6pzR+DMc6convCBurnL5XMn1xCflaDjrVAXyJFZ2CJ8GPqP8v6gu1+Dz//LF1s
 S+tc7pWFuL8R7dlMw0Kq8OjDeOEbfD8CePo/2CVSjDdGgviu8d3uLGQjrBT5+gHADCVj
 guKTU/DDI+NZlKhjpHrWCAy6rpdj2LbCUHwapkuTDFWO5F4f4PbQsLmNoIE8PzqmrPRk
 NoEg==
X-Gm-Message-State: AOJu0YwA6+4VqOL+R+gT0vx2J/7NLqdNzNRW4rvQEOfM9WcSgzskN/XB
 cFXiygvpVMonLdH5nU5JDN6lnbceIvaxRx9Glv++nLQNIJv5eo3nFPLBWdzDYA1pP+E8Uz1+0YY
 u2nW6+Ys=
X-Gm-Gg: ASbGnctv9jXZQBqa/Vixu6DiiUIAGPc2wYiWrS/nrEvt9V9Dybqyqw2NDeetwm7We6y
 /a5oGF875rhW8Ywdt2Ep1+3213/TbWA9HnMMDiql2L0Ugc93x+Cn/1ZDUxfrafLQGnGJsYeC9U+
 INsijHlhUoWiG7VhCw/qtvOu4SINmkx+5fsqcXoob1e2gjulRZfRrHAmvrUEypsdWp48TNx9mDM
 EpuL/LmsLIo35Laofjt4c4+FRLqFPVH6RDL0zp/8JW1aYzdFqxwsR8P6hZPKOcgTQSs/ZK0Do1u
 YMuQufvQmiuvYkia6dBKfb9wCqa1FDA4UyDijHdANlrWnAoDcTHo2VuBie7HID0omddMxwGjq25
 PEL6LvHaVP4suz3z8858WJ+Gj1zeAa3m2va9D
X-Google-Smtp-Source: AGHT+IGEOZJZmS9VN7oJFrBpyPnyA04MJAIvpYC6GlxrITVRrfApyBG3DfPjsMvyvrXG11kPH2vwoA==
X-Received: by 2002:a05:600c:8b52:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-453659c05e5mr32757335e9.10.1750424933502; 
 Fri, 20 Jun 2025 06:08:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470826fsm24688205e9.36.2025.06.20.06.08.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 18/26] target/arm/hvf: Trace host processor features
Date: Fri, 20 Jun 2025 15:07:01 +0200
Message-ID: <20250620130709.31073-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Tracing an Apple M1 (Icestorm core, ARMv8.4-A):

  hvf_processor_feature_register EL0: 1
  hvf_processor_feature_register EL1: 1
  hvf_processor_feature_register EL2: 0
  hvf_processor_feature_register FP: 1
  hvf_processor_feature_register AdvSIMD: 1
  hvf_processor_feature_register GIC: 0
  hvf_processor_feature_register SVE: 0
  hvf_processor_feature_register MTE: 0
  hvf_processor_feature_register SME: 0

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c        | 43 +++++++++++++++++++++++++++++++++++++
 target/arm/hvf/trace-events |  1 +
 2 files changed, 44 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 52199c4ff9d..87cd323c14d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2160,8 +2160,51 @@ static void hvf_vm_state_change(void *opaque, bool running, RunState state)
     }
 }
 
+static void trace_processor_feature_register(void)
+{
+    hv_return_t ret = HV_SUCCESS;
+    hv_vcpu_exit_t *exit;
+    hv_vcpu_t fd;
+    uint64_t pfr;
+
+    if (!trace_event_get_state_backends(TRACE_HVF_PROCESSOR_FEATURE_REGISTER)) {
+        return;
+    }
+
+    /* We set up a small vcpu to extract host registers */
+    ret = hv_vcpu_create(&fd, &exit, NULL);
+    assert_hvf_ok(ret);
+
+    ret = hv_vcpu_get_sys_reg(fd, HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
+    assert_hvf_ok(ret);
+    trace_hvf_processor_feature_register("EL0",
+                                         FIELD_EX64(pfr, ID_AA64PFR0, EL0));
+    trace_hvf_processor_feature_register("EL1",
+                                         FIELD_EX64(pfr, ID_AA64PFR0, EL1));
+    trace_hvf_processor_feature_register("EL2",
+                                         FIELD_EX64(pfr, ID_AA64PFR0, EL2));
+    trace_hvf_processor_feature_register("FP",
+                                         FIELD_EX64(pfr, ID_AA64PFR0, FP));
+    trace_hvf_processor_feature_register("AdvSIMD", FIELD_EX64(pfr,
+                                         ID_AA64PFR0, ADVSIMD));
+    trace_hvf_processor_feature_register("GIC", FIELD_EX64(pfr,
+                                         ID_AA64PFR0, GIC));
+    trace_hvf_processor_feature_register("SVE", FIELD_EX64(pfr,
+                                         ID_AA64PFR0, SVE));
+
+    ret = hv_vcpu_get_sys_reg(fd, HV_SYS_REG_ID_AA64PFR1_EL1, &pfr);
+    assert_hvf_ok(ret);
+    trace_hvf_processor_feature_register("MTE",
+                                         FIELD_EX64(pfr, ID_AA64PFR1, MTE));
+    trace_hvf_processor_feature_register("SME",
+                                         FIELD_EX64(pfr, ID_AA64PFR1, SME));
+    ret = hv_vcpu_destroy(fd);
+    assert_hvf_ok(ret);
+}
+
 int hvf_arch_init(void)
 {
+    trace_processor_feature_register();
     hvf_state->vtimer_offset = mach_absolute_time();
     vmstate_register(NULL, 0, &vmstate_hvf_vtimer, &vtimer);
     qemu_add_vm_change_state_handler(hvf_vm_state_change, &vtimer);
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index b49746f28d1..7ef75184901 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -12,3 +12,4 @@ hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
+hvf_processor_feature_register(const char *regname, unsigned value) "%s: %u"
-- 
2.49.0


