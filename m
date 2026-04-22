Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741F0F9B605
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUYm-0007Pe-Lu; Wed, 22 Apr 2026 06:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXv-0006wV-7n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXr-0000oc-Nw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so37091935e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852658; x=1777457458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nsukKtrqlrIyVc1W2h4m0opSAHZeyebGQjoHRKe/ww=;
 b=vr8xjoqiSr/A9Q5vma+MiQS4ObghBSjoCH18IKJZY6b1nrDG0pOJom4JUHdhvXajq0
 YF9v0HufFyUiofn4gSpATaTxbY+WIFFBfn8EHnFmAFrYIQnn6Cxdxw5apKp1kd4MGoYs
 KPXhlxZRzdK8Hgm0e+bExCdmn6gEAa8SMngWy2zsOMwv2MbHes07f6LiKoC3sneEpdwg
 RhtMFN8kzx8SC41YcSyhiyR4kAxgDcaST8ri6ldNgc7XHzMbr7Tj4Hg2bKZ4oSqhH7Dw
 9V3paGeCDIqOcJ210B+sqqaSjAGR1cEhY1KuHKtqU8D9yuPf9kgHynA3P8HOqbIZV3f0
 AQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852658; x=1777457458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7nsukKtrqlrIyVc1W2h4m0opSAHZeyebGQjoHRKe/ww=;
 b=VtHS04/McFuATiKFKA3Tp9ahw7sOAuaAnxm9Bf0oQB2L1f6oHmMlr8fNEaZWZ5sp/i
 V4/QQK5QEtXLnuB69Fd5kV7Mp9CRGGeKqCM3O/A5ylduiO+Y6k7V8p1Su+ZpQyPI5Lk5
 64CLncNYphP0TSpll7mGj8Q6cP4sdXCz2OsWQhEUSXBR+9HFlfgUmVh2acREoXDv7/Qi
 S+FGNFk3zrO58fxfYIgiqSkgDjTHhAdsDWqEwTmOU3Q2Eb9pXimVwoVnMauq8VICR0OU
 Ra6N4mWEOXVthnoIZXtm/c9d+lkBQtwoS6pMj4uxCqsGhnhlIIWAb4VSQLg868CT84Ag
 zMmg==
X-Gm-Message-State: AOJu0YzQhySsFrL14cSlMr3wrS3nf7rz2CQy08ZHW5fMcFmLvigk9tPE
 hWZzQiD/+4iHpTPN5dgW1b0+vv+2mK1bZew8qFI98CQOSTLoYQoGWDTJ1gDsuFRNEaw=
X-Gm-Gg: AeBDiet+sklk6onk1oowckh8zlS6G1fAmgHKeVCEDa9fY8LNDMaJRpTj+pfK7QZj+oN
 6nOw2ibWZh14l1VkR6RLOiByoeUUvoWoDLxy4v2F205roVuiFEFotpgecq+hxKnLDC09KVk4qot
 zDAIAm0Pj8dgiusCilH79SK03y3+kE9AYUZ9/uI3A08IqSwhDRgOcndgWkTaiK97mtfXAawrUkD
 uH5INzDFYtbbhThQYcP6Uvh04YAdoUWPb1GMdawVK5dLJGKBtsYzu59Peq4S/wNAulrfCbo1ZMi
 un0U4dd0RjTMl61SpUCuVhErZi19XdxBxrBOSaJ23M18EElJOPOz0iDBjDdxwmxhBMTmyNlH6ou
 8ymP1D5q7rEgS2P/S6Wx16D+kJFEwQgIoDflRyqVtrVhHzPgY6ytTEvM9dkjKZvdW+hdm0ddX6X
 fn44GyrtfSPoiRdUGI2Jddgk39rlkNFIiBGQ==
X-Received: by 2002:a05:600c:888b:b0:488:c40b:c8bf with SMTP id
 5b1f17b1804b1-488fb73d234mr256866985e9.2.1776852657985; 
 Wed, 22 Apr 2026 03:10:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb794e26sm184086025e9.6.2026.04.22.03.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F1F060EFD;
 Wed, 22 Apr 2026 11:10:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 11/31] target/arm: migrate debug syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:22 +0100
Message-ID: <20260422101043.1234229-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Migrate syn_swstep, syn_watchpoint and syn_breakpoint to the
registerfields API.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 54 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 2031b3704fb..2ad6b97aea5 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -595,22 +595,64 @@ static inline uint32_t syn_data_abort_vncr(int ea, int wnr, int fsc)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a Software Step exception.
+ */
+FIELD(SOFTSTEP_ISS, IFSC, 0, 6)
+FIELD(SOFTSTEP_ISS, EX, 6, 1)
+FIELD(SOFTSTEP_ISS, ISV, 24, 1)
+
 static inline uint32_t syn_swstep(int same_el, int isv, int ex)
 {
-    return (EC_SOFTWARESTEP << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | (isv << 24) | (ex << 6) | 0x22;
+    uint32_t res = syn_set_ec(0, EC_SOFTWARESTEP + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, SOFTSTEP_ISS, ISV, isv);
+    res = FIELD_DP32(res, SOFTSTEP_ISS, EX, ex);
+    res = FIELD_DP32(res, SOFTSTEP_ISS, IFSC, 0x22);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a Watchpoint exception
+ */
+FIELD(WATCHPOINT_ISS, DFSC, 0, 6)
+FIELD(WATCHPOINT_ISS, WNR, 6, 1)
+FIELD(WATCHPOINT_ISS, CM, 8, 1)
+FIELD(WATCHPOINT_ISS, FnV, 10, 1)
+FIELD(WATCHPOINT_ISS, VNCR, 13, 1) /* FEAT_NV2 */
+FIELD(WATCHPOINT_ISS, FnP, 15, 1)
+FIELD(WATCHPOINT_ISS, WPF, 16, 1)
+/* bellow mandatory from FEAT_Debugv8p9 */
+FIELD(WATCHPOINT_ISS, WPTV, 17, 1) /* FEAT_Debugv8p2 - WPT valid */
+FIELD(WATCHPOINT_ISS, WPT, 18, 6) /* FEAT_Debugv8p2 - missing WP number */
+
 static inline uint32_t syn_watchpoint(int same_el, int cm, int wnr)
 {
-    return (EC_WATCHPOINT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | (cm << 8) | (wnr << 6) | 0x22;
+    uint32_t res = syn_set_ec(0, EC_WATCHPOINT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, WATCHPOINT_ISS, CM, cm);
+    res = FIELD_DP32(res, WATCHPOINT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, WATCHPOINT_ISS, DFSC, 0x22);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a Breakpoint or a Vector Catch
+ * debug exception.
+ */
+FIELD(BREAKPOINT_ISS, IFSC, 0, 6)
+
 static inline uint32_t syn_breakpoint(int same_el)
 {
-    return (EC_BREAKPOINT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | 0x22;
+    uint32_t res = syn_set_ec(0, EC_BREAKPOINT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, BREAKPOINT_ISS, IFSC, 0x22);
+
+    return res;
 }
 
 static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
-- 
2.47.3


