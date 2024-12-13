Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3704BE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB1R-0002TT-35; Fri, 13 Dec 2024 14:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1O-0002Su-SI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:18 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1F-0006Su-El
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:18 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f2e13cb356so1019278eaf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116885; x=1734721685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSpM/cySkQR88JEHiMbsxZTNBsH+C3Qxc74QedSJwMg=;
 b=XfKLNa9qZqlZX8iIMUUty/QeQGtF5zVpKLN9h6jmJUjwrQinjHIf4AOI0sPsZgmNug
 Y6bIzo3+Y10kJ72maPZBSywlMCmoklqeKYgTy8i08LHVTuS7uHtjlhfhBrUnA3HT4A3q
 BOfUKZW9K91sPkhgwsksbEOCWyJ1aIz0l5/pV9evhBvhMw65QXte451bo3IYiQqB5VlI
 SUs2Q6K92aboumamKus+EbEkonTSBbv8wwFs6lYsyfFhsW1qv/dGh5ZuzEBDz84e81uU
 sGU7tchmdeuxf5hajsJfi2iUF5LIkK59OAd8zJqGNK13zxfjkLbeNsKyLS8moa+5Ftoj
 ruGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116885; x=1734721685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSpM/cySkQR88JEHiMbsxZTNBsH+C3Qxc74QedSJwMg=;
 b=l93ThORlwo2/TxSuGI4qvxv4r/eEwFhphN/TaK2brItIF52gWz3f4FaoLD2HoK8UXU
 R4veiPEGVKZ9VrgidLcVHnk2q8eLDdQTjBdC7rYo01XoNFDjwU0NgbX+T17OmHVWY0mf
 nrzETfqwRB5fN+BFAFWapqqnWJA4lbvOxudcHcMI3U/bdU5egBCdgq857hTsuYYki8Xe
 HWsdV98bw30P18eXNtihb2JpRYZYNbDZwwiZ7RCb2JbProoyoMeAtRiAQNVes0H4GCM7
 gjg5P0LJBhca7MArlFyetjP+11gJk707oPbWEzyChX03Bi4xKBlK7NI8gTOqZ/6bvU8B
 c1/w==
X-Gm-Message-State: AOJu0YxGwJ2MKskELlhmBNR0rbdQAUHi2F0/bJMgoXnkjE7NFJ/tx99C
 l9P/V1EgSXWWwul/Bnwt7Bc1KAO54Lcr+wnm00VniFLlzS4YM+ttleChdMyxOXDacdgFT301/zk
 c+rl/X0JC
X-Gm-Gg: ASbGncvGKL0vzxPxhOzjZTHb7nmzCBa3OpHRgxQxpkJA44PJ25QapaGIwQ5R2RPARsx
 FP/1Ls35qmMtm2wrL+PBdHYdi2I98B8WNrOyrkwrGJwkFpBG0p/VgV6Wn/B+cgthzF2uW+Vr/JB
 yyZPxntSKieKVXe4UmyU6dx6DWRadJ5tYM8173W9uDm0cHPMogpdGP9OXYzJPryianoHLmMrvRy
 FyUuGo2lLqmeJBsyr7Qa9vQrV0PquEzWLZyFK0v0Rn3XFq+1DA+QE0WJnXIdnkT
X-Google-Smtp-Source: AGHT+IEaTe0uJAW1Xl0mzwP1EYUCZQb9gvn2N/T9mZEaTGRzrK2xpZi/FUgytaIxWgmBpC28bNkllQ==
X-Received: by 2002:a05:6820:1844:b0:5f2:c035:9d1c with SMTP id
 006d021491bc7-5f32936619bmr2336405eaf.0.1734116885093; 
 Fri, 13 Dec 2024 11:08:05 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 3/4] include/exec: Introduce fpst alias in helper-head.h.inc
Date: Fri, 13 Dec 2024 13:06:35 -0600
Message-ID: <20241213190750.2513964-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This allows targets to declare that the helper requires a
float_status pointer and instead of a generic void pointer.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 5ef467a79d..bce5db06ef 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -23,6 +23,7 @@
 #define dh_alias_ptr ptr
 #define dh_alias_cptr ptr
 #define dh_alias_env ptr
+#define dh_alias_fpst ptr
 #define dh_alias_void void
 #define dh_alias_noreturn noreturn
 #define dh_alias(t) glue(dh_alias_, t)
@@ -39,6 +40,7 @@
 #define dh_ctype_ptr void *
 #define dh_ctype_cptr const void *
 #define dh_ctype_env CPUArchState *
+#define dh_ctype_fpst float_status *
 #define dh_ctype_void void
 #define dh_ctype_noreturn G_NORETURN void
 #define dh_ctype(t) dh_ctype_##t
@@ -96,6 +98,7 @@
 #define dh_typecode_f64 dh_typecode_i64
 #define dh_typecode_cptr dh_typecode_ptr
 #define dh_typecode_env dh_typecode_ptr
+#define dh_typecode_fpst dh_typecode_ptr
 #define dh_typecode(t) dh_typecode_##t
 
 #define dh_callflag_i32  0
-- 
2.43.0


