Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E08FEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMlS-0000Va-EJ; Sun, 08 Mar 2026 18:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlB-0000FP-5f
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMl8-0003aF-JI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:03 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so66955e9.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009480; x=1773614280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V+hagX+lMg1RLLXCOXLv/+2gyVSWe5aZrKHu4oJOc9M=;
 b=JpsoP0Ll5LlrNZb3mqE/PXMqlnjSbVQOVB20TGT3KN4u2oHHkaC438s3vxXQDnqv3d
 jvg4A7iCWXQaM6l05mLksTEg9kzU+kKwnmNDMPupn4mzYXXBQsLIw3XofarW56Idgl6I
 mgbmtp0dXaihdHgVYkUogz0bTW4BBho48E22J4ZW8Kjsx0QaT25/rOrJOvtts/M+VBOn
 l6hN/RN/5j5Xi8tjQ1vCOP4vm1O+yFW51mYhtz1ROCqgtsmVDvgiSbaD9jiWsOzKNFpt
 rqG6BnPSpv+4hPLO7vSjKcgtvrRr0ofLbvibWPl0ikZeET5bP8Yp8OEHiYvd+Go740A7
 xKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009480; x=1773614280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V+hagX+lMg1RLLXCOXLv/+2gyVSWe5aZrKHu4oJOc9M=;
 b=oB0iFmy17uWlZfRPv4zLqSsUZvn7Q+IZslGZGJvNp0oYSe9692+k+XCpdzuUdpzFuL
 KIf5Gr0Y1NjbeZbuVvTxuN+jYy8zcaIRjKMm1Jl6EDKf5pS8OcRxiqhupGUwchWWlmCq
 5P2ChenceliaUeF4TZ3+btQVEa6qiPBIGWuxfuy9M8rhMPE+eBcJJUEicnQfkc1jotfw
 zC9C+ReKyrIcqxI0hCRawOxEOG15K7qeQY4IZ9h12mPyInY/5ljEeQEMg2szyq6xHyjj
 iAZuhOw2EEnW2RWM28YmB/MnEg0W7C9v6L9RP7TNNxG7pJSsild7GZg38N6F3+qOqe9y
 /FkQ==
X-Gm-Message-State: AOJu0Yy9bktlJL6AW3/Yu8ZNUdSVThdv6Z8f0NIwyi42S7r5jdn8V4Fk
 FTFvRAuCj8xd09WGL24e1urGUfPrB/IPHxxOFKWo3oESamM/eOJWDBhLKa+ShHpnnHXEMCDrHw7
 GIA9+ibg=
X-Gm-Gg: ATEYQzzz6dIG9P5sn/1Lfqjhw/PZwYtRVK8z/YJk8E+zX009ONJkAsXVN4TGv3Qq+yR
 0BTob90TEAGU53L1kPp83f4uKXBEJ5NMJs8XW38WA+VCp1wV2V5KPKawrqC1wKnBVgWG/QOOrdu
 f5ZeLl5vz1EkfdJy8qboyt1btbDNheSS8lQqQRJ8CU+qMGTHk570A96TJnCDI5vAGlUnoS/razk
 ISxunEIzLJgBL79wkJmfVy7Bf9pYOMh46zH8+8JZK44UfBs3ytBHPwOV0P5UeONJc6pxhACMdDT
 ONpZCn2k3G7rA74pWJo/P1WW9sdNJ8QYUIMYvfu3U4y+WdVd+4D7zX2yrhmQV/e0Vnuk8rN255W
 ocCTDpsgu+47TSRADfFVq9Zv2cpkrJGbe2eZR/mYBv4j0QGMSWfemmgib2MZ0L/pnJvWYCNz7Zd
 mESKdg6edHxie3hqfeEly4I3sw5R8UknZgjsO9f4yY/H1gVXtwLGFBPUq2IS5zWLaWLPptVmczn
 b+Yig==
X-Received: by 2002:a05:600d:16:b0:485:3c14:885b with SMTP id
 5b1f17b1804b1-4853c148d07mr10771385e9.28.1773009480227; 
 Sun, 08 Mar 2026 15:38:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48529a2fa39sm55062995e9.8.2026.03.08.15.37.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/49] MAINTAINERS: Update the maintainer for the CHRP NVRAM
 section
Date: Sun,  8 Mar 2026 23:34:14 +0100
Message-ID: <20260308223433.25503-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Thomas Huth <thuth@redhat.com>

I am not involved in the ppc machines anymore (the pseries machine was
the reason why I took over maintainership of the CHRP NVRAM code in the
past), so it does not make much sense that I'm still listed here as the
maintainer.
The CHRP NVRAM code is used by the mac99 / g3beige ppc machines and
some Sparc machines, too, where Mark is the maintainer, so I asked him
whether he would be interested in being listed as the maintainer here,
and fortunately, he agreed! Thanks, Mark!

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20260305192223.6214-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ad5918d7aa..47e2782468f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2742,7 +2742,7 @@ F: tests/qtest/hexloader-test.c
 F: tests/data/hex-loader/test.hex
 
 CHRP NVRAM
-M: Thomas Huth <thuth@redhat.com>
+M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/nvram/chrp_nvram.c
 F: include/hw/nvram/chrp_nvram.h
-- 
2.53.0


