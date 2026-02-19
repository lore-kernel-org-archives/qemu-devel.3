Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C2BE9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9au-0002Mi-2M; Thu, 19 Feb 2026 14:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9aq-0001zF-7b
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:44 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9an-00084D-GR
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837584120eso9553675e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528899; x=1772133699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HXlrNLQEJo12y7bAqBOXsab5CEiSRP5NzEAPS/keIM=;
 b=BNpgo+r+zO4J73PTr1rnT6CY0ZpLBqaj5YmuueT6437XjHOBQwIV+NBQuF7ZSyvhl6
 /Oab/XxTWsFkLuUcAYxL4TpPkJGwjW3es24p/Y8hqE1Q03SpbmSygmT+CTwZWNZ0EC1C
 mhbS7u9blJaONlOvEdkRc4BVaXskhYO4abaM8c1SNXYMIboBd+tb4kuyygmUwQ5RpqCv
 JfxT+vx19JHXsrLW/1tQQYt58SsjaFqcfb8DCDK2voOELDhDz+nTUuzhPvOiBif8bygN
 ROVnNg42ehntCHC30I5qyXQcM+6SB37UEV6yeCMxXFWFL4uogRksNWujOyfl0K8we9SO
 5awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528899; x=1772133699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HXlrNLQEJo12y7bAqBOXsab5CEiSRP5NzEAPS/keIM=;
 b=SYEbmqNiMVkXsN3dvLJHz4cb89Ucb2QLxOGf2feU+6T26w6zMCnn9y6D/nQcKph8TA
 xrH4mKBWa6ToIwUOrk7iYXzfskx8IPZNJmY+jJSM5009lYsSmnaZsFJHeVbp0FRjtSK0
 geSAzdzky7ItxEhZGGIW6tYwMBvOdUiQf3xsFVZiHYxiXM8iJeRFvvmtU1MTx4QsYMw/
 jYmlwdRUITALi1Z4uwUaJzJgBDWydZGk0+HundQVT+4UVlG/psL6OWsaC5HgYJ7JoMg5
 VQujKT295cvYgA+3Dtjn6t1EeOUZWpO4uy1cQR6uELpY9AmgTd9j7TguQ6Ge6n035wf+
 yPcA==
X-Gm-Message-State: AOJu0YxLzKU/O0MhLqSUFfVE0xc/tBMmIPzaInN+v7mrBDdNFmDyULRt
 lWSjLbM8QTplrEVRdJXsPw6jzmoJJCBHByngLhMap34Js6qc4Cz4CzCSOTz+VD81Egu6jTw+yA8
 vrfveI/Q0cg==
X-Gm-Gg: AZuq6aJ4uycaZ31GrMYDCqNP1QuEKZCvYpS2PA3wo7StPTH1bAt9CMeot+uYbilj8kk
 nxhwIV5I0Amc4vAphO7Nu/E+31++tj36cNN8zYeKyUZswhBjGpA7lvzXhwjbRCZ20lpPjCHSQYC
 aslKCiZXZRj5GGhqVbDQyfvS6jJOlsMh8IzB44MUz83qAPug2b9m5fdBQWDLvhQsrgB8zocKDO3
 6JrFmT5yl7HNz/pnIkhWicyvJxhNfvNkepAAcwSNnv7uySiOBaVIMcbkMpgBk1qkUqv4CpmkbxH
 Wsw4vAvt07psjZGI1/JxRJtD5LyJy+TYkfPe7HY2BdN4kCu1E2ioxP63BqFqjnK/m/mM6Rfy7xO
 ZRN2Svl1ExKtCNSFinIxCkUEsjMZeyjB4dAPnWzKuRhlHOpNFPf97t7B3RlaKqGadvREhu9tkz6
 rf05esNqbgeZR6eYX9CDU3Dgs9O3nUbVaVuX0YCllS0mz6s1vSqnW7e73m5MaD5fCqyZBKp3oS
X-Received: by 2002:a05:600c:8189:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-48379b99069mr330720885e9.9.1771528899082; 
 Thu, 19 Feb 2026 11:21:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31c51ddsm22629675e9.8.2026.02.19.11.21.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:21:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 14/50] target/sparc: Expose gdbstub registers to
 sparc32plus target
Date: Thu, 19 Feb 2026 20:19:16 +0100
Message-ID: <20260219191955.83815-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc32plus-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 3e6c72e793e..cf49c53ce44 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -5,5 +5,6 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


