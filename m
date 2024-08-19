Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBE7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBFV-0003y5-3X; Mon, 19 Aug 2024 18:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEY-0000wM-MR
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEW-0000k6-F3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42819654737so37535685e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107934; x=1724712734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gH5ZVKOWkjk4IlT33UjiZBwifnlYiOD0/fyxwxSrNuk=;
 b=Vz9NUEdmngJJ7rRYp54QNUv49p7JmFrC0uYgt4bG/DxNmDYY1mMlYAFmqeAb8aqJLc
 Q4fxgzZnf0nh87ZxU9S3hRUDBKINw91flDUsP+ppl3apEBPXZrKE8R7SVTAKrToHyVmV
 gQnQou/dqAOVXE3E1wJpCODG03nukGClFwJjmxsMiACyEEM2CLNE+7hs8e/HRoQU8vRc
 yjByaJJrer0EWCxbJmP3LRev/XhaafLua8wkmGE1I6+6Ansk3FEj9jBOd0aoXY8TCKhK
 3TyGBetRKKE1Xb0radJ3u/XpA7dIx4mb+RULPN3ZYBvpqlbD/fPBP8WzJxNEXWgDCwld
 hA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107934; x=1724712734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gH5ZVKOWkjk4IlT33UjiZBwifnlYiOD0/fyxwxSrNuk=;
 b=MXU+SU6Q9EGzYckGim7UFwL8IlpQaP3odw8AMYlMcQ3sAx8SvDxSpFbWHL+H1oCL75
 AkaPd6taGbf9tWP41sRvbEpI+wcbdYS8DL9ZixfMvx4oYgfLBV3vMjk4Nyi0XENyt4ZF
 ROro3oysfCTFwiwh+d3jlEgx0GgBeFaK5DBCF7yhQ1UtxDRd65RyBebUZgzq5p0dkYD6
 r67ReYHzAGSi7XM64F4+bhRDqmHpRcGbkBjPt+zm0MdV4/I/xGLeBuoBYedeGIwxhpiB
 8TwYwJVOk0cXpO5540uwXnoS/IPhrYYkDPJ8Kp2KBbaOLskLaM50ZvLZgQrGNa/Ixi2c
 Ca4g==
X-Gm-Message-State: AOJu0Yy5MC5TgDDDBvIRG1QzWiSkBwuUdEPgtiGnqT5hCpSStiH1yssU
 NUDhqowktkmIZH9fxxa8vtWofIPJ0IHgINw/kOujrpvz9gokmqr27qBDg+8h4l+yQTq2HnovLQ8
 SMhY=
X-Google-Smtp-Source: AGHT+IGAgZ8Nebntb1v26tGrEE4MkMcJ25HwcDm3w8PL/mnReUCAK5Mo2gjFpzpkx+uscjVr+PElNQ==
X-Received: by 2002:a7b:cc04:0:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-42aa6d23365mr69737375e9.21.1724107934480; 
 Mon, 19 Aug 2024 15:52:14 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed4a857bsm124559175e9.0.2024.08.19.15.52.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/20] linux-user/mips: Select Loongson CPU for Loongson
 binaries
Date: Tue, 20 Aug 2024 00:51:08 +0200
Message-ID: <20240819225116.17928-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240814133928.6746-5-philmd@linaro.org>
---
 linux-user/mips64/target_elf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index a3a8b2e385..502af9d278 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -14,6 +14,12 @@ static inline const char *cpu_get_model(uint32_t eflags)
     case EF_MIPS_MACH_OCTEON2:
     case EF_MIPS_MACH_OCTEON3:
         return "Octeon68XX";
+    case EF_MIPS_MACH_LS2E:
+        return "Loongson-2E";
+    case EF_MIPS_MACH_LS2F:
+        return "Loongson-2F";
+    case EF_MIPS_MACH_LS3A:
+        return "Loongson-3A1000";
     default:
         break;
     }
-- 
2.45.2


