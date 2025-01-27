Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919DDC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNiK-0007LG-5a; Mon, 27 Jan 2025 06:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNi2-0006yN-5D
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:22 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhz-0007CA-F3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso2372382f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978911; x=1738583711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn2ReynSBdby37Nlff7xj1Nb5zVdrIwNIQImRA5QCJw=;
 b=ehKvFwhH+f/oRF2h5dbCqPg+durWCSfSarEasz9YZctCd/ZiQ6SgstO/r20zfbr+Bn
 3V51KeCTTRG3BcSUW7zBycmeaGdF/or2GaKZZLnyRTkPreorBCbrrAHTZLOzmkgGm4yJ
 XDUvnLXFToFhoukdfVMkRIsJha2cn8K5UZhMvnT03p/W4bkVS1SJlul5M4hzzYE7uNc4
 JZmvyakXWmGETP0Fi45/cQb+S5Uxg9BO3YdQCEknVkl4bwKo/zJ4xjYTE3jdiJdCXZp0
 Bg5ktvqXFmqjtJ5AT83QhK2Mike1tD0sqYUxqRj56b7WTpcJGOmiBaQ/+NZ0cOSLDBtk
 9mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978911; x=1738583711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rn2ReynSBdby37Nlff7xj1Nb5zVdrIwNIQImRA5QCJw=;
 b=H7eVWHRDAPpDQ5cfbnJyeqacYmf53Z2hIxH8tTf7jAdLK0EMbMgL2QcIjVycbtmfiE
 q2oQOD4iUAH0MWSDfvsaJ0orIwiOEUOVfLweON/Bcc6JyoCNlySFxvwn3OBq8aH7jXk+
 BczPwy5K4D+zJ826Eb2Mmj793rY4nsK0pXvhtKvgoV0F09v5rFCqUhZZQ0I/5hXtpOY9
 A7pTIrvOnaODJvlqxFU7GEhaoIKxIYDNfC4af3S8qGpuzAccMLbkA8pYgBLL4dZDrkm3
 1FNvkMvCptk7kvjt7KKEJk/X4gbDwS0WS089rf5x7W4HXsKPDHg4aDN6sbVhMn032EO3
 PY6A==
X-Gm-Message-State: AOJu0YxEZ7knTnNgfXAKxOVVJMQrLdrZv8yYFdtwAutjqYH7h92Jcf57
 5ubFG42ewr1KnhrYjtf32YDtfnnv++idptKHraw6UZAAr286mNF+8oP6jo3azg8LDg1WSX2lmuT
 oJSY=
X-Gm-Gg: ASbGncsj6dLpER8AHQNHEBEogOG7J8N2Ud453OKmFOPPzlqQD2I/n2QsdQ75Doo8GdG
 lDGA8l5BoV2wQzs3JSsmMaspHNfapycNUchdEIp7poj8opSxc6RxYIzSJ/oEFb7j/DxNrHCIkW+
 8/sUb5aO6nULiM2SH0nxgu6p1aE5zFs8bKrbdDqJjRzvRqhFoCSiznB48E7igmowStRVUtekRbR
 emyIneB2y0WgBh4fjrdSJteVx63zun+GqjmOQkEP+YReh4kX2kCb8LGIzn1j4dRszfspYlRpENz
 ORQuHOr3il//eKrEVaQFa+vpaNHUhMjSOpdvdCk0/bOWc3GfGCsCH3A=
X-Google-Smtp-Source: AGHT+IG0appsE+SO9dke28W7wykRckuQa5Du5b/UppbL4D5c8O3IybNWUnckdXh4XkAEBtIIIj1Bsg==
X-Received: by 2002:a05:6000:1faa:b0:38a:6264:d13e with SMTP id
 ffacd0b85a97d-38bf566e21fmr33389791f8f.8.1737978911217; 
 Mon, 27 Jan 2025 03:55:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188689sm10807831f8f.48.2025.01.27.03.55.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:55:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/10] target/xtensa: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 27 Jan 2025 12:54:25 +0100
Message-ID: <20250127115426.51355-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index efbfe73fcfb..bc170dbb5cc 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -159,6 +159,11 @@ static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 
     info->private_data = cpu->env.config->isa;
     info->print_insn = print_insn_xtensa;
+#if TARGET_BIG_ENDIAN
+    info->endian = BFD_ENDIAN_BIG;
+#else
+    info->endian = BFD_ENDIAN_LITTLE;
+#endif
 }
 
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.47.1


