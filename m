Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D4DCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Muk-00076v-Qk; Thu, 16 Oct 2025 08:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuY-0006do-89
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuO-0008Eh-NT
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so323889f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616992; x=1761221792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PXbPgWBX1Zd7tKapjmZwB4EE0Vw52SyPTtzhzpRRDWw=;
 b=a845RR8zZe1dPHQL6ZBhQ5FUqignWk8smfU0G3XFnob0FLPf6Dz6iNxiwDdvYzgrm2
 wJs91ti3DaDL6t+XloPpWvGVyXxNFplIcG3fjMA3QwTaz69Yq55Nv9SXL6Pe6GUKwF9m
 NW+r86ATGqT2Zo+vHgcPe5oxf/P1xH+5WzSQuq3wrJ2igcUmLJ0k6qrbc38y93yFMay9
 XJvZc8NIZodAznasbOTZ0MwRhn229x+NZwEj3N+ipp6ZwBjgPioUcUS5C1BP9AoiQe5I
 Mf2xssK5Ylo2bwATDyq5ZqhPyMvGpXevobAFuVP0eE2RCp3koyD5Wa581kONrTyHkLVz
 Nz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616992; x=1761221792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXbPgWBX1Zd7tKapjmZwB4EE0Vw52SyPTtzhzpRRDWw=;
 b=HB+znuuY/o2JX+k5Kghlmi8FR6nex4x4wq2bLFZcN9/NaRXQe3KB5C+t81/8MBzAvY
 hPCIgmhnbGWxDI7S8SBxUY6xGAGwVE0i+YKgOdPObMGNrCAeyxUajqdM0X7kCvg+hvoF
 tUf1v1huaW6vpVVPphEFRBQUk2zHq8JUK5PvHBki/b3MCEWBVj77U+9IMiHY/MH/ump5
 SQTe9A9da++6Mu+4/zTIoWyJhOqDuS0pisd278GBlsiPrqdNftA5YS0rkxR9TpFG9RPo
 AEk3FpKRfEXIfXnQD9FxxEW2eNQ6vDe/TFG+AFZVc8riZId9Q307rrrgHSh9e2pW0K5t
 d9tw==
X-Gm-Message-State: AOJu0YwwOMyqnOdLhUfhOT8xsN+rNqTHoAfyPIakPmWm4fdlMYHA/Ta0
 Smw6L+jRoIAKAPPJyAVe1TUOBqUyn4yegjPIUgpVUolHisZyaDO1ddiYhzbpKS29+8+DUrO5dqW
 E8BJ+Q28=
X-Gm-Gg: ASbGncug1CVVt54X7vx73W3zF81KmjI2asCbT8kJ/Ew18+gvP+rUo3FeRFqXZI9q0i0
 tst21UDtETAbjx2SLe/JMgQ1E+O/sH+pM0bpSy3SfQHmDfEng2yXNESvEUeDIXjI02r9E/xu1QK
 oN2ljvf3hIb5mgOLya+gwMJlyKg3KkqR0OhKz/iqv48uyrRGvsc78UFFMTMWPdsaij6BZl9jLuY
 NPn0FTpjxQex2COP4PkENQQ+o7fR6bkPuVX4Y5yxmorrtUbq3nfnt2YAnfOh3UtsyziIXGjuTcf
 Y4u4nF91i/n6NElvXGuEL83XjRPNM1tTbBWwhFpwtCZMbx9FbQt1GKWsyc3CfVxhEkFYEnAx/FD
 e1AF6JS22H1A1sRQE9doNquGDzt1Uo+TSH8od8fsgSIyI9XEKJ1WuRFrLefS+egaOixU3ifyUfH
 YhlPzwlYSU+SiExdh7015N5bMVqQAWA1t6bIJJf5tjx9LdJTU398By7oJdqaJaYAUC
X-Google-Smtp-Source: AGHT+IHcH9/lt+JtHihLljO3uPOBiCVPcIbSCA1/Yvoj4gaY+EDK7/O1MBVjFVInF8mk6CvwduVM8Q==
X-Received: by 2002:a05:6000:1886:b0:425:852e:ceb2 with SMTP id
 ffacd0b85a97d-4266e7d4490mr21496737f8f.31.1760616992254; 
 Thu, 16 Oct 2025 05:16:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711443e7a1sm24854465e9.9.2025.10.16.05.16.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/75] target/hppa: Replace MO_TE -> MO_BE
Date: Thu, 16 Oct 2025 14:14:28 +0200
Message-ID: <20251016121532.14042-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We only build the PA-RISC targets using big endianness order:

  $ git grep TARGET_BIG_ENDIAN configs/targets/hppa-*
  configs/targets/hppa-linux-user.mak:5:TARGET_BIG_ENDIAN=y
  configs/targets/hppa-softmmu.mak:2:TARGET_BIG_ENDIAN=y

Therefore the MO_TE definition always expands to MO_BE. Use the
latter to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-10-philmd@linaro.org>
---
 target/hppa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6fec63cb433..853cba2ba4f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -106,7 +106,8 @@ typedef struct DisasContext {
 
 static inline MemOp mo_endian(DisasContext *ctx)
 {
-    return MO_TE;
+   /* The PSW_E bit sets the (little) endianness, but we don't implement it. */
+   return MO_BE;
 }
 
 /* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
-- 
2.51.0


