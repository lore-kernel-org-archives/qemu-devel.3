Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6F1C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWp-0006IS-1k; Tue, 04 Mar 2025 20:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVC-0004Dv-5o
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdV8-0007I5-Ae
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:48 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-439a4fc2d65so66719755e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137884; x=1741742684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsB2TZLz8IJAYUss30F4SD873ZK7oobvrmd57J9F3o0=;
 b=d9EBc4M7DtdnX5/ouPG6Hv8NEZttA3tFYjeIBH8By2eqq2Ra2oDAacct+xHPxuJBtd
 rxAXOnw338au/rq7PawSmKqghl+EkOYFfck2CtrXoTnbSgqvaPUUC74qMIE4ZhRc1Xpc
 3ejC1PSzJBUn2Grbkk4x2jXYm+9A1/EZJcq/Pr748W+IM/qkhY233cQEYtMLxKm/0CLW
 AeHg/ewbJ4FHOOg+GSfWQhO64IO8EG5d3711lUhQhdaPH1Rzi10fF6P0LEdIOEsCBXFF
 yNrLqrCePQZ0/t5C08NzXZUy7Xtpg3Eh1MBwyC1urX5oB0Mkl561tFyZzQv8uMMKynYZ
 VO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137884; x=1741742684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsB2TZLz8IJAYUss30F4SD873ZK7oobvrmd57J9F3o0=;
 b=PI3JXkfEffI5PA6p8xlaHexr5ccfZhUhxRLtPdFAexz33ELG31HCE8ps51XNnKJXej
 uK0Pq4PArRcSnabZxD47MA8TkKjP44Bf+ZhevL1Bmxs3jGyVXhVulGHy9zwf3LxcGYXA
 72UBP1Rg4je9O0XY0MTVMNfbG29EkKYn3wSBH4ilq2M07VTDbAZK4zJVmQGbvvRsX40E
 VDpHK5K+iZmUKxRBe1CmUe8K2wP2FaIFudkqMWr+swnLk1MIUiUFHXZLdS7o8JLRz0YS
 e7HsmEHvc7t/Zn3xx4LIjzBfVOiXbUF27NvIlXTUDvLEhEXD6rLMn4ECOnZkqfJIZNCd
 vlMg==
X-Gm-Message-State: AOJu0YyuCaR5hiEVFAvkOFtp5FVIFvbfyYLind+ZtmEjOX7Xc3L/FqI3
 1ctyJNU41+Tr5ZZujEVeauahMwUyQ8h+wBsOYZwbM3xJ3PO3gixBIQ0KM0twIsR4OBTmm9/c/7F
 /BOg=
X-Gm-Gg: ASbGnctTi7vBCWiV+Hdwvsja/40HvItJ0sIqF5Dr6a2jsCrLdihGRnHduFGgZJl1Dnt
 w+Vw+p+aF5g0DaaHwnJ83Ns7552zvxjE7mT7y3EsAHg/U/hQfZZRGqIvIMvTgV7mlsmXS7FRlGQ
 CF1UuYlJODjBhbhDweTDT8n7xsHR9k6Hg2awaQIDimPqYyFhYsTrbYlabBxlQCQrHf5XfTYiPRi
 Piz3y6TFXAVa2CKF/DBzqeqqrXVSWro93mO9ZWkOzJ+PVG8peEOsPPbZn0MOn0bjLkFBXzbp3El
 dKNgyb+6EnsCC9FKy9KRyks0sgjSaKfSxtPfIeig7o2PVOVgH5FyNXboLTgUhj/CMjSwoYgre8L
 bMiHqWO6mwtYDV0/r19o=
X-Google-Smtp-Source: AGHT+IGxk7eg1Xv5sm2d19xhoDzc6uZ48JcHKvIhl1VpBR9o+o0bqgzx6p/f0J3nikKvpGQLF/QMrg==
X-Received: by 2002:a05:600c:458c:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-43bd29e0456mr7645145e9.30.1741137884655; 
 Tue, 04 Mar 2025 17:24:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42b7478sm2005795e9.17.2025.03.04.17.24.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/41] hw/arm/omap1: Drop ALMDEBUG ifdeffed out code
Date: Wed,  5 Mar 2025 02:21:49 +0100
Message-ID: <20250305012157.96463-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In omap1.c, there are some debug printfs in the omap_rtc_write()
function that are guardad by ifdef ALMDEBUG. ALMDEBUG is never
set, so this is all dead code.

It's not worth the effort of converting all of these to tracepoints;
a modern tracepoint approach would probably have a single tracepoint
covering all the register writes anyway. Just delete the printf()s.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250227170117.1726895-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/omap1.c | 51 --------------------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 3c0ce5e0979..8f5bb81c96a 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -2660,25 +2660,16 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
 
     switch (offset) {
     case 0x00:	/* SECONDS_REG */
-#ifdef ALMDEBUG
-        printf("RTC SEC_REG <-- %02x\n", value);
-#endif
         s->ti -= s->current_tm.tm_sec;
         s->ti += from_bcd(value);
         return;
 
     case 0x04:	/* MINUTES_REG */
-#ifdef ALMDEBUG
-        printf("RTC MIN_REG <-- %02x\n", value);
-#endif
         s->ti -= s->current_tm.tm_min * 60;
         s->ti += from_bcd(value) * 60;
         return;
 
     case 0x08:	/* HOURS_REG */
-#ifdef ALMDEBUG
-        printf("RTC HRS_REG <-- %02x\n", value);
-#endif
         s->ti -= s->current_tm.tm_hour * 3600;
         if (s->pm_am) {
             s->ti += (from_bcd(value & 0x3f) & 12) * 3600;
@@ -2688,17 +2679,11 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         return;
 
     case 0x0c:	/* DAYS_REG */
-#ifdef ALMDEBUG
-        printf("RTC DAY_REG <-- %02x\n", value);
-#endif
         s->ti -= s->current_tm.tm_mday * 86400;
         s->ti += from_bcd(value) * 86400;
         return;
 
     case 0x10:	/* MONTHS_REG */
-#ifdef ALMDEBUG
-        printf("RTC MTH_REG <-- %02x\n", value);
-#endif
         memcpy(&new_tm, &s->current_tm, sizeof(new_tm));
         new_tm.tm_mon = from_bcd(value);
         ti[0] = mktimegm(&s->current_tm);
@@ -2715,9 +2700,6 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         return;
 
     case 0x14:	/* YEARS_REG */
-#ifdef ALMDEBUG
-        printf("RTC YRS_REG <-- %02x\n", value);
-#endif
         memcpy(&new_tm, &s->current_tm, sizeof(new_tm));
         new_tm.tm_year += from_bcd(value) - (new_tm.tm_year % 100);
         ti[0] = mktimegm(&s->current_tm);
@@ -2737,25 +2719,16 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         return;	/* Ignored */
 
     case 0x20:	/* ALARM_SECONDS_REG */
-#ifdef ALMDEBUG
-        printf("ALM SEC_REG <-- %02x\n", value);
-#endif
         s->alarm_tm.tm_sec = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
     case 0x24:	/* ALARM_MINUTES_REG */
-#ifdef ALMDEBUG
-        printf("ALM MIN_REG <-- %02x\n", value);
-#endif
         s->alarm_tm.tm_min = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
     case 0x28:	/* ALARM_HOURS_REG */
-#ifdef ALMDEBUG
-        printf("ALM HRS_REG <-- %02x\n", value);
-#endif
         if (s->pm_am)
             s->alarm_tm.tm_hour =
                     ((from_bcd(value & 0x3f)) % 12) +
@@ -2766,33 +2739,21 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         return;
 
     case 0x2c:	/* ALARM_DAYS_REG */
-#ifdef ALMDEBUG
-        printf("ALM DAY_REG <-- %02x\n", value);
-#endif
         s->alarm_tm.tm_mday = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
     case 0x30:	/* ALARM_MONTHS_REG */
-#ifdef ALMDEBUG
-        printf("ALM MON_REG <-- %02x\n", value);
-#endif
         s->alarm_tm.tm_mon = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
     case 0x34:	/* ALARM_YEARS_REG */
-#ifdef ALMDEBUG
-        printf("ALM YRS_REG <-- %02x\n", value);
-#endif
         s->alarm_tm.tm_year = from_bcd(value);
         omap_rtc_alarm_update(s);
         return;
 
     case 0x40:	/* RTC_CTRL_REG */
-#ifdef ALMDEBUG
-        printf("RTC CONTROL <-- %02x\n", value);
-#endif
         s->pm_am = (value >> 3) & 1;
         s->auto_comp = (value >> 2) & 1;
         s->round = (value >> 1) & 1;
@@ -2802,32 +2763,20 @@ static void omap_rtc_write(void *opaque, hwaddr addr,
         return;
 
     case 0x44:	/* RTC_STATUS_REG */
-#ifdef ALMDEBUG
-        printf("RTC STATUSL <-- %02x\n", value);
-#endif
         s->status &= ~((value & 0xc0) ^ 0x80);
         omap_rtc_interrupts_update(s);
         return;
 
     case 0x48:	/* RTC_INTERRUPTS_REG */
-#ifdef ALMDEBUG
-        printf("RTC INTRS <-- %02x\n", value);
-#endif
         s->interrupts = value;
         return;
 
     case 0x4c:	/* RTC_COMP_LSB_REG */
-#ifdef ALMDEBUG
-        printf("RTC COMPLSB <-- %02x\n", value);
-#endif
         s->comp_reg &= 0xff00;
         s->comp_reg |= 0x00ff & value;
         return;
 
     case 0x50:	/* RTC_COMP_MSB_REG */
-#ifdef ALMDEBUG
-        printf("RTC COMPMSB <-- %02x\n", value);
-#endif
         s->comp_reg &= 0x00ff;
         s->comp_reg |= 0xff00 & (value << 8);
         return;
-- 
2.47.1


