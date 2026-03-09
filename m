Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE294F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcuM-0003HN-OO; Mon, 09 Mar 2026 11:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuH-0003C7-2w
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuE-00086B-Nc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so1790686f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071549; x=1773676349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aAGNceKt9ICMl3PKB0LspGbqju2ajHOrPESyT1vA8as=;
 b=CCE/ksDdVgOC+lyN8n0YVhpN180fyNxwuB9yPiuDKlMJP79hThuyn00eOjJy7yg7lK
 Sss/miSiejzbp191q5XeVuqGfyjPNqk8O0EwbcOrEhnwAMjzWy9+YpaGoAfNZANa0W6/
 xbvdDmPWjOvXDA8Dq3AH1UV7hOBzNHTUu3I8ZzWj05Urb8vN5o32vfjMw7g8R88PW85g
 AhupUnkvK3BkgupyZXod2Bozpa62Y9UPGLZT6+4sGXOl0mSMAu0H2lx/NGUAITijRAQU
 23O42H0Pxmpc0kuv/npL2kw38GBCNRLNPuIeswMJ3VBMJz8gphkR5LhIKMz7GUWOBR7n
 6Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071549; x=1773676349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aAGNceKt9ICMl3PKB0LspGbqju2ajHOrPESyT1vA8as=;
 b=RKc+D0CRGocsdC4ZCPvGqXia2VwUJEHRWCKfIlJjGiMrrEuf7oy8CXZtdI0Ls6atIP
 rI/F2lobqDiyphKrDD6/ZsrHkdXXAcD/UMBewykjI9z9EVisaKFJUNLZIxdKiZTUgTUG
 WxnK924oJscJW0shj8+Ai0vi/OJfoHiLzgcK4Umn3coWxCeuOexfIXlJTRi40uI+e5Ij
 K76s/u3tXeGVmo1FiijD0nmKlNO7+3DuMHNAeMwXTe9Npo9shR0LqmFX+qtAEHYslu38
 YNCSD+/wR24CAAu/UeB58B9vSPoYPofxEG0RPud/e3ZDrK62IXEETQ1+Kifok6uZkLY8
 4lwA==
X-Gm-Message-State: AOJu0Yw4QnPCArnVAKDprjgWbk9fBCJzADw6HFxUU8E+W+I45I7Sk5HP
 WFuIS69sTRlpXXxVk185yzmCzwiHp2rJpfjaX0VxICxSvISMUpQ75pcOVm34cctz9he9o4lLGYS
 rlOzuM5Q=
X-Gm-Gg: ATEYQzzQoaableH/KGA+Vn4mCDw1YCnaaYiVtNMEtxwdvI7OaCA8Z8Q+GnXFhv5QBKL
 +ESehcOeGkMmrmu/0OTQqJGsoFpPk3AcIeIe4jxDs6XrKWWyAF4Y3j5+4aLpTbS7yEhxMlyM39E
 oJxMfJsl/G/TUy7PibAhBTv8+vIaVQ1lxz11oaKmAXTgTOEbJUY4eMj9K8umMKBfNal4aq+W1wW
 rhkOD56b6dCNJZikPVyP1h0KBEjmnYGu3MXFrZIvS1ZvF7ugyUs5x/j6U1ROqxmUQyaqla6MQjm
 4RVAwFldMecwsZeAzSUeWaOnZZpEf5+58rvlAPdO5KOkkGNQpkHLwVLt6JMtQfWevyuWPLGCJdO
 9lJhjBL6nMKBoySU/AzeyPcgXgWN1AMFtubfpeZwlqlI0KsWIfp3vjvYyJqyyk3Rq4gpCnpRlfj
 oCeUL5e+hmjcM75eE5NZBra62L/QvjPDtOz621NDX+KRqpJFPTa37zAeUkLQVvEUPqGNNejjxp
X-Received: by 2002:a05:6000:2285:b0:439:ba69:101d with SMTP id
 ffacd0b85a97d-439da354ccbmr19755263f8f.1.1773071548697; 
 Mon, 09 Mar 2026 08:52:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba06sm29306158f8f.24.2026.03.09.08.52.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:52:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/49] hw/timer/hpet: Remove HPETState::hpet_offset_saved field
Date: Mon,  9 Mar 2026 16:51:31 +0100
Message-ID: <20260309155219.62400-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The HPETState::hpet_offset_saved boolean was only set in the
hw_compat_2_11[] array, via the 'hpet-offset-saved=false'
property. We removed all machines using that array, let's remove
that property and all the code around it.

Message-ID: <20250501230129.2596-6-philmd@linaro.org>
[thuth: Adapted the rust part to the current master branch]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260306093134.27789-1-thuth@redhat.com>
---
 hw/timer/hpet.c                  | 9 +--------
 rust/hw/timer/hpet/src/device.rs | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 0d7b8e0c7a3..767093c431a 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -75,7 +75,6 @@ struct HPETState {
     QemuMutex lock;
     MemoryRegion iomem;
     uint64_t hpet_offset;
-    bool hpet_offset_saved;
     QemuSeqLock state_version;
     qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
     uint32_t flags;
@@ -272,11 +271,6 @@ static int hpet_post_load(void *opaque, int version_id)
         t->cmp64 = hpet_calculate_cmp64(t, s->hpet_counter, t->cmp);
         t->last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - NANOSECONDS_PER_SECOND;
     }
-    /* Recalculate the offset between the main counter and guest time */
-    if (!s->hpet_offset_saved) {
-        s->hpet_offset = ticks_to_ns(s->hpet_counter)
-                        - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
 
     return 0;
 }
@@ -285,7 +279,7 @@ static bool hpet_offset_needed(void *opaque)
 {
     HPETState *s = opaque;
 
-    return hpet_enabled(s) && s->hpet_offset_saved;
+    return hpet_enabled(s);
 }
 
 static bool hpet_rtc_irq_level_needed(void *opaque)
@@ -766,7 +760,6 @@ static const Property hpet_device_properties[] = {
     DEFINE_PROP_UINT8("timers", HPETState, num_timers, HPET_MIN_TIMERS),
     DEFINE_PROP_BIT("msi", HPETState, flags, HPET_MSI_SUPPORT, false),
     DEFINE_PROP_UINT32(HPET_INTCAP, HPETState, intcap, 0),
-    DEFINE_PROP_BOOL("hpet-offset-saved", HPETState, hpet_offset_saved, true),
 };
 
 static void hpet_device_class_init(ObjectClass *klass, const void *data)
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index ebf715d3995..0a5c131819b 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -627,8 +627,6 @@ pub struct HPETState {
     flags: u32,
 
     hpet_offset_migration: BqlCell<u64>,
-    #[property(rename = "hpet-offset-saved", default = true)]
-    hpet_offset_saved: bool,
 
     irqs: [InterruptSource; HPET_NUM_IRQ_ROUTES],
     rtc_irq_level: BqlCell<u32>,
@@ -947,11 +945,6 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
             tn_regs.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
-        // Recalculate the offset between the main counter and guest time
-        if !self.hpet_offset_saved {
-            self.hpet_offset_migration
-                .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
-        }
         regs.hpet_offset = self.hpet_offset_migration.get();
 
         Ok(())
@@ -962,7 +955,7 @@ fn is_rtc_irq_level_needed(&self) -> bool {
     }
 
     fn is_offset_needed(&self) -> bool {
-        self.regs.borrow().is_hpet_enabled() && self.hpet_offset_saved
+        self.regs.borrow().is_hpet_enabled()
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-- 
2.53.0


