Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928B6D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVx-0001hS-Pq; Thu, 15 Jan 2026 13:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVQ-0000jG-Eu
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:41 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0005um-TV
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbad1fa90so1178094f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503322; x=1769108122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ROW5G0LmCLnFSQU2/Ic6aBsvPza1+GU/DMA6doQA0/I=;
 b=lwbbcBlFkQx7Lc3qxkmbhf3bTx9oqCuxzbA+/kTiQkuOA+Th/kgKA6SffWwjaA0fwG
 fN0XbX3H2XEUIl2XuEtMNBp1QB6MmVlhCqO8fj/A/gSn8M8htiDYDvQ2fAgZSq1basIT
 8Um/s3zfuGl8vHPKvzuPnqwF7WjllySmaAd0zrEfZdCK7EZ3PJufO3c5Mt2U7Sldlv6W
 bslTwKJzJ6JgF14yD3QPaXNSGLdzLhKLwFgp1/cG9pIxmOyq+Uhk7+N+obfC/vQ/TFEZ
 3ATlSBvngcvGT/9HbkBJZmUDhCh/ReH5PeH5SvfnBjB8sf2Z8gd64q0Yb+6d3/JjUMb/
 fTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503322; x=1769108122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ROW5G0LmCLnFSQU2/Ic6aBsvPza1+GU/DMA6doQA0/I=;
 b=rVRfUpfowC5Ci7RJ8LXAnrXUfj6yKQ28Mng+2+e6km1dDIMDnDuUBK3eFngzJxmvNj
 qKQ+NpYDtc1aLxtz3ctAqcC2+/vE0R6NigZls4Cpp91E9E1W0IeQn6MqexzudXgpet5I
 HWd0AJgqwDa0JHAPSZFqJm/c5XnyW6gwu+95u09BSebbMGjiM6oyDiNC+n6SKzYjSiM9
 6dPOd+ftaZF8JTwsyYtUMamSC1M/7HNkp94/Fjrpv0COSHEtXzbtdpBnUEZVGVBjlLuf
 Etv9TF4jENLtC4UEsF7iyMcsKeLBNYQGRxJWbrgTzzf0DnA/A9pAMxMXWJLmf8ZWqol0
 85OQ==
X-Gm-Message-State: AOJu0YzGq+FoHqwj9rm+GE7TXstkKHq8nrys15bLam92CzV177BrNbig
 YO47gD7E7A5X8JHpZzdrhd3zRH6+KTymMxwiYJZmuecyny1Lz0IQINPCmuIiPbq9Yhx23KfbyZq
 jVWMM
X-Gm-Gg: AY/fxX5jUl9i/viXXdox0wty+F5ZnDeYvq9G0u5vrAPr2JgzC30qLUQCo/kMW6NmkW8
 A9avcP3doGyudkWZSDjVTGiDWpJzMvh53nE/nAdz36C7NggmSp14F98ogpl9NGIOcFvPlJZq9td
 bnYq4RER/+2syr/EMMxu3C87rjwWlhM3dShTfJO/QOxegVALQcp+wRyQ53vhf87u0Y1WxZEE8uv
 F/+HL/2I/4BBiopoBlfanr+F78Pebt6W3qRSO6ZNkuZwwsanJx2dZTUb0WPJ86AGY2wBmKvHZBn
 BMmR1ElI/uNgrtWxVS8CNEQlPLIdste60akSfihadPusMPBecmG9dbSr6fr7ajtrkaaqQE0i5ID
 Nvc7zLftF33YjU4ABsaT90VIHJyZGHXltn43huXZj6sNdEZfWEZL2ZwrSDlFKMiqc7Z4fkn++7s
 JbqxcmsZ5FlQwZ3CVdLyKeQ4QVBFgEQebtruXoYJfp6k1v3O64GrEUKvbQABJF7UV4aQkGiDBZa
 TkbmQNIe8zJqD+C9JsWV1X6W8jhm7q+f8MJPIn3BcdCUc+YLUih/DDd
X-Received: by 2002:a05:6000:22c9:b0:431:855:c791 with SMTP id
 ffacd0b85a97d-4356997f5e5mr458936f8f.3.1768503322381; 
 Thu, 15 Jan 2026 10:55:22 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/25] hw/arm/omap1: Remove omap_badwidth_read* calls
Date: Thu, 15 Jan 2026 18:54:56 +0000
Message-ID: <20260115185508.786428-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

The omap_badwidth_read* and omap_badwidth_write* functions are
used by various OMAP devices when the guest makes an access
to registers with an invalid width; they do two things:
 - log a GUEST_ERROR for the access
 - call cpu_physical_memory_read() or cpu_physical_memory_write()
   with the offset they are passed in

The first of these produces an unhelpful log message because the
function name that is printed is that of the omap-badwidth_*
function, not that of the read or write function of the device that
called it; this means you can't tell what device is involved.

The second is wrong because the offset is an offset into the device
but we use it as an absolute physical address, so we will access
whatever is at low memory.  That happens to be the boot ROM, so we
will ignore a write and return random garbage on a read.  This bug
has been present since 2011, when we did the conversions to the
MemoryRegion APIs, which involved changing all devices from working
with absolute physical addresses to working with offsets within their
MemoryRegions.  We must have missed updating these functions.

Replace the uses of the omap_badwidth_read* functions in omap1.c with
an open-coded call to qemu_log_mask() and RAZ/WI behaviour.
We do just the reads here because there are a lot of callsites in
omap1.c; the writes will be done in the next commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/omap1.c | 80 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 9ca8eecfa0..742ee48fcf 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -209,7 +209,9 @@ static uint64_t omap_mpu_timer_read(void *opaque, hwaddr addr,
     struct omap_mpu_timer_s *s = opaque;
 
     if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -315,7 +317,9 @@ static uint64_t omap_wd_timer_read(void *opaque, hwaddr addr,
     struct omap_watchdog_timer_s *s = opaque;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -439,7 +443,9 @@ static uint64_t omap_os_timer_read(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -540,7 +546,9 @@ static uint64_t omap_ulpd_pm_read(void *opaque, hwaddr addr,
     uint16_t ret;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -772,7 +780,9 @@ static uint64_t omap_pin_cfg_read(void *opaque, hwaddr addr,
     struct omap_mpu_state_s *s = opaque;
 
     if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -995,7 +1005,9 @@ static uint64_t omap_id_read(void *opaque, hwaddr addr,
     struct omap_mpu_state_s *s = opaque;
 
     if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -1077,7 +1089,9 @@ static uint64_t omap_mpui_read(void *opaque, hwaddr addr,
     struct omap_mpu_state_s *s = opaque;
 
     if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -1175,7 +1189,9 @@ static uint64_t omap_tipb_bridge_read(void *opaque, hwaddr addr,
     struct omap_tipb_bridge_s *s = opaque;
 
     if (size < 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -1277,7 +1293,9 @@ static uint64_t omap_tcmi_read(void *opaque, hwaddr addr,
     uint32_t ret;
 
     if (size != 4) {
-        return omap_badwidth_read32(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -1391,7 +1409,9 @@ static uint64_t omap_dpll_read(void *opaque, hwaddr addr,
     struct dpll_ctl_s *s = opaque;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     if (addr == 0x00)   /* CTL_REG */
@@ -1471,7 +1491,9 @@ static uint64_t omap_clkm_read(void *opaque, hwaddr addr,
     struct omap_mpu_state_s *s = opaque;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -1764,7 +1786,9 @@ static uint64_t omap_clkdsp_read(void *opaque, hwaddr addr,
     CPUState *cpu = CPU(s->cpu);
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -1956,7 +1980,9 @@ static uint64_t omap_mpuio_read(void *opaque, hwaddr addr,
     uint16_t ret;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -2206,7 +2232,9 @@ static uint64_t omap_uwire_read(void *opaque, hwaddr addr, unsigned size)
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -2347,7 +2375,9 @@ static uint64_t omap_pwl_read(void *opaque, hwaddr addr, unsigned size)
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 1) {
-        return omap_badwidth_read8(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -2440,7 +2470,9 @@ static uint64_t omap_pwt_read(void *opaque, hwaddr addr, unsigned size)
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 1) {
-        return omap_badwidth_read8(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -2574,7 +2606,9 @@ static uint64_t omap_rtc_read(void *opaque, hwaddr addr, unsigned size)
     uint8_t i;
 
     if (size != 1) {
-        return omap_badwidth_read8(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -3118,7 +3152,9 @@ static uint64_t omap_mcbsp_read(void *opaque, hwaddr addr,
     uint16_t ret;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -3547,7 +3583,9 @@ static uint64_t omap_lpg_read(void *opaque, hwaddr addr, unsigned size)
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 1) {
-        return omap_badwidth_read8(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -3628,7 +3666,9 @@ static uint64_t omap_mpui_io_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     if (addr == OMAP_MPUI_BASE) /* CMR */
-- 
2.47.3


