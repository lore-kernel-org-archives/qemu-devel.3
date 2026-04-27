Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1E5FF8869
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQD-0002Bz-Hm; Mon, 27 Apr 2026 08:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO7-0008D8-PY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0005ku-HT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so172754555e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294106; x=1777898906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mOoSY+iuv6Itz71wlhRRL9GhUQ6RnDF/CADilvxqJcA=;
 b=UYM41hMfyECrdCNTxrCW6acnelMBz/nN5RSI5aSja8kfPp3a9jI6tBCoM9mcoEJkEG
 P8X6MS+ARHh1BClSI2ZO6IWJJlkPdZNQz9leXUKkrb1/3Ece1twfGaXHAtFgd+KJK3gK
 5rzoq0705+FuIVnOQkst4luIBq1WCddyt4Xaq67EZ8p0crGK4gjfAlOL6Tf5iIIktNYC
 mzSSuvRcac5+7bZuMBujrMNNxcbp7VgskeVRhOcnU5xzwqn4lAmKxQwWu0EpD7JUjtW4
 CF//h9lrNC2kfY5thEb4CAdePIp/F6pQBtW2T4PdT8zbCO7ysG75H0/cYQi7dbtOjvqb
 aJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294106; x=1777898906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mOoSY+iuv6Itz71wlhRRL9GhUQ6RnDF/CADilvxqJcA=;
 b=e5Z6Mi67Jj8s4oKC5S56soOr/s9XFgs7o2pmV12I8MHU2rFdEYhutT4D/H5RUzwKj/
 R1Ls1DAQh++y33UR7D1pYH0zrbjldFdm6YkUP+5Hol5ipNCa1Uha0pMNM12+IOgRxNzZ
 TiEi38V50GVb1tn/BWYWzjHmjXgXpdJ0diTGQNKzGDYN0YrOPgG8o4AdJvG0H6jgA6wc
 9bDln37cZTihdGpkygEVqB804nc9Si3PpHVy79sgRyUaFT7fe7ElEJ4FJ6eBfYrO8QVR
 jkHdqUBHLAX511hOidK6KzhsXOgdqsLTZbUkAtmYBD5VSSnGJyq7Xtrk/0elfA9zbvIq
 q/fQ==
X-Gm-Message-State: AOJu0Yy9Fmse3f4vDJ/wn2nLQmZj5Yxb+66MLkmHrT0YixereDpwRtni
 Pi4gwAKos+DTHzVm3fd/kCz6ybty5oz6lX3QlFuwBeJ9Xd9gLEjsaFaofM80wrpwAKDfpNSXd2G
 wwxtf
X-Gm-Gg: AeBDietOnwk3RVqEc50f2Q655Rxq0zUGe5XdO425zc6mDSVIuTpCmdG/1s1Ids/nfaz
 Tea1BNqEmOaC6jDEfMLpJ8dTXBH91eY/Q+L/NA86G+krFnBQHyiL0053ONN5Olp/JH1LPpWj9LB
 4pA4DU6Me3dkg8mjEsphXqAa+0r5jjy1b4nhhHguwIMRnx6SI6mU81WEyqislZAgOGDVhe9JwY0
 7/7R6L8q4wNoCj3en99MOQm/QVvIlV8Onqma1OaMBkGk/TtrAvZXQmycECnOHqwhB3Y96jGLtzv
 R60gKmgMkEGF3qqGIIdMT9Gjn1Oaeu0cZIO2SYrLV8DoX5dQ6NlwWVot5vT3kVLQtdBYPhO9Sev
 hyi2j3O4TPralpy0jrJHOuRbdoidWQxj6/wTcW4OzhduuysgFulHNjQjGKKB8RYkZuANIoEhsz9
 +GGbs4FPzKDvsR3BOFEjsq8Qj03p0lTCBMwpFYyiXxp/i6pcBoEKTyXHBC6sSsP2GhsXzVIti8A
 6aX4yEqlaewfPCLepe7eodlCk5gnkoFU3KZjl4Afg==
X-Received: by 2002:a05:600c:33aa:b0:488:ae6c:42c0 with SMTP id
 5b1f17b1804b1-488fb742e7fmr358988765e9.7.1777294106260; 
 Mon, 27 Apr 2026 05:48:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/63] target/arm: migrate debug syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:25 +0100
Message-ID: <20260427124738.966578-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Migrate syn_swstep, syn_watchpoint and syn_breakpoint to the
registerfields API.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-12-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 54 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 2031b3704f..2ad6b97aea 100644
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
2.43.0


