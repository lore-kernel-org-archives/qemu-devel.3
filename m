Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36192C3DA41
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl0B-0002of-2q; Fri, 05 Jul 2024 11:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl02-0002dY-Dm
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:26 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzz-0001J6-LN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:25 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52e976208f8so2006598e87.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193842; x=1720798642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yODWEb1vcYCc/9pyRjXwD+WI1whqQ36urKRs7eztwzQ=;
 b=FUxHJhzyg4AMlhXoDxktgeU9WXxBc6bcfh3t3iJWUWKsiUiPivNJkAqSIk8Hav8eKS
 8uwb15BJhLLZYN4etVQITdCvXvWPTKEAH2LZixf2qT3sJ9izBihdawT7P9IBqaAfNqZc
 PxpQgrOV87W/0so/ffEjyaKNyTElheQIf6xyuqJMZF4N+iz6Dh2k2CIM2zXdqgIEXlCQ
 u6oy7P5FHYvB9lwbVP8YCYdLI/fIeXXlEXtXaXlG9Wev4q40MKXM9pxH44UfBpAH3DKG
 0Yl4uqDYongF4xJK7IcPuija3KDB2MXtwAvxdBvha9CD/Wk5zjhW0PxhwMdVD1JFX1sx
 un1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193842; x=1720798642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yODWEb1vcYCc/9pyRjXwD+WI1whqQ36urKRs7eztwzQ=;
 b=D41wt7RHMxxx6QYooI17hnqpyPfgtdn74vvA4CwALS+opohBvA4t2IIRMa9oHmZL/X
 /3v6LIJ451MjBCDS4oC9P929+NJ6+myYaLQbqNfRL25rGmC1ch1jDIT4AW4eLrn6koI/
 4nsxntRyrKPtiaw9YYNAzb4t9o/2RN7DcN8DEmVy5OTBX9oIyjOe+D7QVPbvthTHdukV
 yWwLOzZ2ifiFBwG2zKJTsKzamTwOAYs99d66xIG7z2DK24qwEYh3WpOlsbegslZVZAIn
 GXIuCp3iPvvIudauhE+hQOtCZ8CP0ufTyLRQLeKqTduwo+0rPWuppPu1gyRmLbX0nReh
 lgHw==
X-Gm-Message-State: AOJu0YyVPcQsFvbQS3qTsiGCU1422O7v3Ucu/SqevnyiX3+VU21juw6K
 MS4JxjWP+xgoR68z19O7C92fZ4Z4F+qRX+qIByZ31GRpRPDtGgmeLfrFVrM48e0=
X-Google-Smtp-Source: AGHT+IFKxUGk7CuQ2Jqs30QtZpZGDjHf4y0EX6R/CCBx5cBsjTBfMYyrpN4eGxrhXhGfbaIWcqvDEQ==
X-Received: by 2002:ac2:4115:0:b0:52c:f3fa:86c with SMTP id
 2adb3069b0e04-52ea0629bc7mr4008184e87.18.1720193841693; 
 Fri, 05 Jul 2024 08:37:21 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a752cb50dc7sm417579466b.101.2024.07.05.08.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6DD35F92A;
 Fri,  5 Jul 2024 16:30:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 18/40] tests/tcg/arm: Use vmrs/vmsr instead of mcr/mrc
Date: Fri,  5 Jul 2024 16:30:30 +0100
Message-Id: <20240705153052.1219696-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Clang 14 generates

/home/rth/qemu/src/tests/tcg/arm/fcvt.c:431:9: error: invalid operand for instruction
    asm("mrc p10, 7, r1, cr1, cr0, 0\n\t"
        ^
<inline asm>:1:6: note: instantiated into assembly here
        mrc p10, 7, r1, cr1, cr0, 0
            ^
/home/rth/qemu/src/tests/tcg/arm/fcvt.c:432:32: error: invalid operand for instruction
        "orr r1, r1, %[flags]\n\t"
                               ^
<inline asm>:3:6: note: instantiated into assembly here
        mcr p10, 7, r1, cr1, cr0, 0
            ^

This is perhaps a clang bug, but using the neon mnemonic is clearer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-14-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-19-alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index d8c61cd29f..ecebbb0247 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -427,10 +427,9 @@ int main(int argc, char *argv[argc])
 
     /* And now with ARM alternative FP16 */
 #if defined(__arm__)
-    /* See glibc sysdeps/arm/fpu_control.h */
-    asm("mrc p10, 7, r1, cr1, cr0, 0\n\t"
+    asm("vmrs r1, fpscr\n\t"
         "orr r1, r1, %[flags]\n\t"
-        "mcr p10, 7, r1, cr1, cr0, 0\n\t"
+        "vmsr fpscr, r1"
         : /* no output */ : [flags] "n" (1 << 26) : "r1" );
 #else
     asm("mrs x1, fpcr\n\t"
-- 
2.39.2


