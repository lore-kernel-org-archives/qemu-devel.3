Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99736C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 02:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjUgh-00051H-MK; Sat, 15 Feb 2025 21:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjUgd-00050G-Ee
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 21:47:15 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjUgb-0002Cd-2v
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 21:47:15 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so4759875a91.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 18:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739674032; x=1740278832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dm2DO/+GN4GPpQT093oRXrT3uL8BN2TTCxu/nGU2SfI=;
 b=dDtHX5qZUQYdHb1Nn+x90yo6RAOIbWXbvzwdoXkfklZn4eJoYoq+Uh4y4R9Q3Z3yMx
 HLy4Yo2lPDn5gINLy2wuj17i+iMdU1bx4M6aeNmSkx4Bz3YyIINx2Tu3Fe4ghRBUeivG
 auyhSGtUCR+YUeDZT2XrS48UafGX9P/+UtVMsd6PmLOe4Vq16XFFStMjIDKD69D0upPA
 ZcBnPwQMXqL3IS2wkAUFTj4Mvxz8NDNSHRY1zJ2Wg8vi4IeeTUSECJIkGc7ZkX8H5nkL
 +kcaNRhS+8ETKn6nZpj+uQc8/7OqYi885p7YJS0DpPOhsNhXPK2ALHMCZaJGtgt367js
 BocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739674032; x=1740278832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dm2DO/+GN4GPpQT093oRXrT3uL8BN2TTCxu/nGU2SfI=;
 b=f9sJoP4ar7UAFsQtY6zudcaf+UBkUybVulplukezh8k/yjl2KxEOjrTeJ5PNZ/tly/
 KgmELsFfK7jrx8M+c4TRCS2d8jI5ezUQGXWWSi3gmvvPBYWWbwxSByWvAGGnu4+CU+mq
 cS00ujagwQqYRqxNBY8NpxpqaB6luCixdzw3Y/irf0K7spKD+ShOZ/ONLn4reetdysnV
 2IefEwRKncJOsZzlRH0U9mLzpf82y5IES8lQTdvMcvqBUMk02uqXYzuhvtubj44/QjT7
 UyB4aJWY7/bOWuksEAEoCk7+fxzfeZxOFISFVr6zWv4ajNrM5EDiewUcLgQqCCuzokKt
 Nq4A==
X-Gm-Message-State: AOJu0YxV3MMY0JGmJOAKT+uvM3V55i+is6GpZMnOLZxfc7DURhwRJDHV
 YDDVEeL2bZdXXTCTqTfKTf067dvyQKOUsat+kOyrx05mQvn2uOtjOWUVrGpq5SSXX86Dc4Hnrrd
 c
X-Gm-Gg: ASbGncsY6Y842ABFpTJPmkgSja/7sdhgBxn4MxIXrV54nBLuQQI2v21qMlWWl052raw
 yNsfv8zfaXHt0dAfkjwcKk9MADvUp68/wskMu4Fql6czfYKiws1XmLOhoXKs5vDsTC9NAHURhQe
 9FLrXc/G5Dry3C7Tbc7Bax0QHg8GaReILT1oTCBql5w9blHE7wfw89pxAvwJEBHGOfh/YTNvC0C
 y/qS18bLs9W5Pp5bgWOv5SA6UJLEmAZ09WBd/NTsaUzG6xAhpoa6RX0fyfOP3P6Co46vdNU+T02
 gs+AAW9X8YOxMBxu7TyJHYxT7EQdmJQkd2AqqHovOMGTAYA=
X-Google-Smtp-Source: AGHT+IHdEl9ByMWJ1n+9IE8gvEiQE0zBMD2gIe65ucZrUIxCZnkVg6T/xLuzkbz8KE+n/UhCqhhReg==
X-Received: by 2002:a17:90b:2d07:b0:2ee:a76a:830 with SMTP id
 98e67ed59e1d1-2fc410493bbmr8112071a91.24.1739674031708; 
 Sat, 15 Feb 2025 18:47:11 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab0233sm7701710a91.44.2025.02.15.18.47.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 18:47:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tcg/i386: Use tcg_{high, unsigned}_cond in tcg_out_brcond2
Date: Sat, 15 Feb 2025 18:47:08 -0800
Message-ID: <20250216024709.2624325-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216024709.2624325-1-richard.henderson@linaro.org>
References: <20250216024709.2624325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Eliminate code repetition by using the appropriate helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 65 +++++----------------------------------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index cfea4c496d..33d303a123 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1658,6 +1658,7 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
         tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
+
     case TCG_COND_NE:
     case TCG_COND_TSTNE:
         tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
@@ -1665,64 +1666,14 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
         tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
-    case TCG_COND_LT:
-        tcg_out_brcond(s, 0, TCG_COND_LT, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_LTU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_LE:
-        tcg_out_brcond(s, 0, TCG_COND_LT, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_LEU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_GT:
-        tcg_out_brcond(s, 0, TCG_COND_GT, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_GTU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_GE:
-        tcg_out_brcond(s, 0, TCG_COND_GT, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_GEU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_LTU:
-        tcg_out_brcond(s, 0, TCG_COND_LTU, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_LTU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_LEU:
-        tcg_out_brcond(s, 0, TCG_COND_LTU, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_LEU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_GTU:
-        tcg_out_brcond(s, 0, TCG_COND_GTU, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_GTU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_GEU:
-        tcg_out_brcond(s, 0, TCG_COND_GTU, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_GEU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
+
     default:
-        g_assert_not_reached();
+        tcg_out_brcond(s, 0, tcg_high_cond(cond), args[1],
+                       args[3], const_args[3], label_this, small);
+        tcg_out_jxx(s, JCC_JNE, label_next, 1);
+        tcg_out_brcond(s, 0, tcg_unsigned_cond(cond), args[0],
+                       args[2], const_args[2], label_this, small);
+        break;
     }
     tcg_out_label(s, label_next);
 }
-- 
2.43.0


