Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D698FF9EDC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX5g-0006nV-Kt; Wed, 22 Apr 2026 08:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4l-000617-AN
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4i-0005Uu-1V
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so38386905e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862382; x=1777467182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nsukKtrqlrIyVc1W2h4m0opSAHZeyebGQjoHRKe/ww=;
 b=EyQ184mOwMarJxWi0h2hAhZAPvXwVuO2Ierk7o81EfUkuut5pkJkycujVwpfGJPTvf
 lCmCBfSqTekP7QwGVABsO2yOBZXTGYQlevlJFuwKiRH7A337gp2sURQ+ZG3jqOPtKgr6
 U28/TIRdzpfUioQdVrkB1QitfxUWiaEdwpCRsCDszWBDdYb0H+b1M2B5qJSezEwseE2T
 js7FZvgL0bZ4j+gn3ZE9df13x1yW362/Gjpxg7xdf8t24TT7oPworQu8dE0koPMYlq0N
 LTtUJYV0eaRtN4exyrTu8YVYTj+dxZuuLpX8qOiA9VDRLVV++BCu+8bui9EfavXMjhad
 a4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862382; x=1777467182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7nsukKtrqlrIyVc1W2h4m0opSAHZeyebGQjoHRKe/ww=;
 b=NR7myxfV2cIDoQunpuAockorXaA4IEsz0D4FTEzTHbHmS7zk3HEWirN2AXbfXBD94E
 Cj/x4H6RwkUyU0sb0nw/v8Cdubtki12NwcaaWZ5Bk0eilBbH7x41WK9Po3LAmpI6zOuf
 XUwM1G08LKHCJdDCmEOLTiJJscm6zV24Tgpxw+osNx9yI87P0drmXqY9iGsrBlJmSP+8
 4tA4GaDDUZlmSP67yMF2IR68AOC8VhHSwLFFVgK9/ZX/RcVJ00BeQ6U7yX1VysIF9eHg
 v2XIfpz5ofv5xcvJ/BHzolh5Q/wKO8Vr29IwdET/8edrju9EjLKjQuoVembOStad4RvK
 NhaQ==
X-Gm-Message-State: AOJu0YxFxZS81cAgOHovxrTm2cAsA0diMkR7MsO1Ta9ejtUHeQYJEHYK
 Ob7mnOpPKde8ukdXHByhofkNR5eZhhmzxAS1BIQkfEjvxl6kiVKP2c6qrSoA5EFHkeA=
X-Gm-Gg: AeBDiesuKcQz812CfA5KadG7vwbe2Gm2vt192numuqjKeBh529p1Kes9uAonQh8xHFI
 v4iUtxn0D+j03gJKHuAfqp6oX6PsTvrlcCyxoQa8bR0CVNR3RtnCov5RC4Tk1O+MsDyhpbExd4H
 hnTyjzw2iwqgUspSzEb12B8myU/LM4TtctXGfvYZ4XwKzYMu+6sh85QU1k4Va/kUA7404IpaSdW
 uG4nEo5buqEdXF8zy3knOgTuGDlNINV96BdtLzZjoz/tj4ESEm2PYpLydsu9YJpqKKnQ7SW/Mst
 BuRM+7gRyYTBLsVYT02wCACeZF7O0RyLDv6Vd6C0oavQIyix3Mtihk8m3LgZTEtf/gvPt+rwgJy
 aI9gp/tbIGkUf/Vd58u2z9Vv9sbGJEFqMjEBtHSi5RnwHPTXr4L74ClMgCm60Eq3q+cuBBlmFd1
 DcVhqHSAoYFg/o4qYjUMDLXF2JZgy3WeYdxQ==
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id
 5b1f17b1804b1-488fb7786e4mr229329295e9.19.1776862382062; 
 Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm753005695e9.3.2026.04.22.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CAF0560EFD;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 11/32] target/arm: migrate debug syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:28 +0100
Message-ID: <20260422125250.1303100-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


