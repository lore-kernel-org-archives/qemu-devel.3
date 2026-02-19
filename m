Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B540CE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 04:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsvFH-0008TN-M5; Wed, 18 Feb 2026 23:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvFA-0008Q6-5U
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:24 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF8-0001GQ-Nl
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:23 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad22a5e245so3450675ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 20:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771473741; x=1772078541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+C4usfFJxntIkaYUwqttNHLWY0mMsZx1f8GtcALX8k=;
 b=GxTnLFwjBB3f4g7D5kvDDilPjfhJXtgJoOW46N/O5LqVJiNOUX/mUqXJEcaJXZ3/tx
 mFaxCGiA+gMx2n3FSngIMx3qROL3cYNNQ+pap5j2op0fiegGGnd+Lhex2Gj2y5o8VVQS
 dJL7fAdH60dxvDW45A0Ea/5fyGguyIV0GxsLxrCsL49z+yo6ONqGe8N2Q1rPWMnsHz5z
 dxWOl93L1BFJ+ZHWwmNJ80yssrxTYwg41ReMTnPCgsraMd7GpYMjQTFosctGkVSdKb/2
 X+seJVEDVHbDZVKUHBbe9mWZYS7CcA0n2Dw/CMjiT74ApK0Tv8Np9u/NVDLdUdzy2lg2
 T0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771473741; x=1772078541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+C4usfFJxntIkaYUwqttNHLWY0mMsZx1f8GtcALX8k=;
 b=fi24AgSUGCnGK/zhqBHMIbReFEqjcY0S5gg+0vbOI+xmHna2ev56JQYyyGHa/v389l
 XvrFjHWwRiVAUoUrcRCP0QTRx4M7dcmCl1f38uadFAHP/9+XSIv960O7LkrvvW9D53be
 cFPmP735w4YHasiIeIDSUCZeLLQTkC2lt6Orff+8FyMUajl5bij75uZUC/OrJP3ckDBC
 qQ48WPzcPh3Q1f6qf5cxu4H6UorDHAKFEx9UimmahFawD5iHG8fls5BFRrzPkMl1s8XP
 EUrDOb44+0e/oMrgpU65EhVxeMB9ZcbmV69UngiD97qDpl8RbekEzswDMGzxIr1vIveL
 1r3A==
X-Gm-Message-State: AOJu0YwEGPj+cRk0aNMOL2qROsORGo/K/Prr1MoJcgyl5dgIVMolMxQx
 ovDscEqnbhEI+qJsHL0ihT4NcSYDeiTQVOeACjB5ItRVO7PeLKe7pavqMRJGaJVW+ykxVBSGShM
 9zj8T
X-Gm-Gg: AZuq6aJrWXXbZXGHmpDR+xu9FwWzWuRwG/9J0czw6miOcy9Oa4UBHUZHrJA38WbODCH
 Q4bjR8z07fV2DKHrN2cSffbWPjrVFDaGGgAhQdndXXnYYOnUO4RJ66FUB0a9EqV24OFWUEPb59o
 6O1REF6WGafeECi+z5ztCfcboP3XtWipHShdRIK99pYe1zstr24XSLbCnVZ++P4Pb5jyAS8BVX5
 dUlVPwz5Sk9WPETREWu5e6FDJOoWTVabKTlIMVO4/uiJ0Cs1Bq05Edem6jSPx7GCRPjGoCLdKK0
 nNBfLQ2J77Vi9rdVw0Ppp6EBZqcfEYjIycDBLjJfn9Aun9Lh3LbOur6qgIe628yipTdVzfHjaMP
 rMb+h0YRdiHfxI9/Nmxnh9X38EHQupNY8me9UKMSKNHz2fzyBKbmVjXZomF3wFrUG+3lh2VVSs7
 uTcSH+GlPher+YTY9oS0CyyvX36Z07vjfkFoo1IQ1ij8ywKuBa64D55Lq/sDrl4bEnN1QZ1CXdn
 sNE
X-Received: by 2002:a17:902:f687:b0:295:99f0:6c66 with SMTP id
 d9443c01a7336-2ad50f63477mr40064175ad.36.1771473740760; 
 Wed, 18 Feb 2026 20:02:20 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a73200asm147636225ad.36.2026.02.18.20.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 20:02:20 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 12/14] target/arm/tcg/translate.h: replace target_ulong
 with vaddr
Date: Wed, 18 Feb 2026 20:01:48 -0800
Message-ID: <20260219040150.2098396-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 027769271c9..2c8358dd7fa 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -18,7 +18,7 @@
  */
 typedef struct DisasLabel {
     TCGLabel *label;
-    target_ulong pc_save;
+    vaddr pc_save;
 } DisasLabel;
 
 /*
@@ -42,7 +42,7 @@ typedef struct DisasContext {
     DisasDelayException *delay_excp_list;
 
     /* The address of the current instruction being translated. */
-    target_ulong pc_curr;
+    vaddr pc_curr;
     /*
      * For CF_PCREL, the full value of cpu_pc is not known
      * (although the page offset is known).  For convenience, the
@@ -56,8 +56,8 @@ typedef struct DisasContext {
      * pc_save contains -1 to indicate that relative updates are no
      * longer possible.
      */
-    target_ulong pc_save;
-    target_ulong page_start;
+    vaddr pc_save;
+    vaddr page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
-- 
2.47.3


