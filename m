Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A40C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1f-0004d6-0c; Fri, 25 Apr 2025 11:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L12-0001sb-5o
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L10-00040C-2I
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so1557650f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595055; x=1746199855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eYAybimTAdqZpfihYhFCBVjwEYiz4GIqDH1LbXttNY=;
 b=bkuIRDdXUPIAD2L55A7BiXEDg1HLYrZ6oMganht7KVS0t4BqdepUibnGgBarYTd0xl
 wgSZFwqLg2wsZZduwf3BUbjSvmn60Qsm24LnOByWvxQQhpE5ezzXPx5ZUsBbyAndiDA5
 pwR5dVTkWsMDGq+nlFcHy+fgbDjcmzuFcL4DmI/KmEixfOVTWRL69DIqILxXmVy5Mhlb
 lHLmWEH0FM+N1luahIon9e5mzDNOuwb0wpzt5LY7UU0zAypvchMTXREwzvYjspuC1Vno
 WmqjKxrlHt1NRuxh0CJMsorwjdo2a70+iJUqtmCWFEUtjiocrcJnKHApkzqqCNnEVFE1
 W3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595055; x=1746199855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+eYAybimTAdqZpfihYhFCBVjwEYiz4GIqDH1LbXttNY=;
 b=HdYVgY+bTLHrVW1c5x7hNHitV1+ate0SiPUTs46qlHknLmOUOl1+DQx7/UO97NdaMa
 lfiEYFq61S9u3Pvldd6b2HdkGkYIpalKsNYBxHWsz5ERLezyYcbVzlMIQhb+LhsVh0Wp
 OGS86tTeMzXa07BtrNJNITRSqD9XgaQVEQPYfH52agmHyZZ3+49d69JRSYhQrUtg10dw
 frsG15wcWHgB0kB9WcxBkqqo1HiFx5NS1ZAqcuxgq52MdSYXm5umjamBt9fOQB7tZlzU
 JPNBiWYrvjVtJ5Z0GUxfwO8YlGc+WOb/pga4g0OaMs6bq9yn9p9zVMXjIBCTKzbpF+uS
 A7YQ==
X-Gm-Message-State: AOJu0Yzns5CSecbIcBAqbRhaDizuzXgt8ZSZffMXsHa2spGnofUkrlQZ
 CcKWdXx0I1WYxP8mQYmFhqmaYvAxpw+4/upr/Dtc/vCtprnZt5wC0Fi3v8YldaaYK7mYHJxJpgr
 L
X-Gm-Gg: ASbGnctsUnINMeSAXLidRiQXQXSIXGdiwUAglMcJWVMSioaYjg6moeq05adWIpabNgn
 t3x2NEqoLwSNJmZL2zHUojy4pbb2cQna0QNKG5HgKoqgbd1IQPgVGX25XAAOI2KEviO7Nukz92i
 3N64idSyAXi7l2WC9l0+Hz6B+aY/UrfswTkPTZ3icV6IC0xe1WbbuWebpNhKvCGp7ar7WXO5HoC
 Q2ZRuzDc1NyrsTggm9abcJWbMTD7yjsGH0U+NKNXbiwgecI+PIv9wSoGsON0l5d0AsWYJ0AAHNc
 s31kUpGxHul8e1iZkmXPYbMTIYfqW2D6uskN7rp2w0b8pnWw/MmoWUVvTbqtNfPIxbdn5EHC0jy
 7x5s4D5sXvw2y+XL9gtAoeMCbOA==
X-Google-Smtp-Source: AGHT+IFGkXsSDO4ZFsr5augXkM7VBH6g57X0F/jwSb0W3Yj0qdfdmn2H8k3QmcP0P3Nct2m9h8nJbg==
X-Received: by 2002:a05:6000:2902:b0:39c:3122:ad55 with SMTP id
 ffacd0b85a97d-3a074e1edccmr2233633f8f.18.1745595054723; 
 Fri, 25 Apr 2025 08:30:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc1842sm2727448f8f.54.2025.04.25.08.30.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/58] target/mips: Fix MIPS16e translation
Date: Fri, 25 Apr 2025 17:28:10 +0200
Message-ID: <20250425152843.69638-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Hauke Mehrtens <hauke@hauke-m.de>

Fix a wrong conversion to gen_op_addr_addi(). The framesize should be
added like it was done before.

This bug broke booting OpenWrt MIPS32 BE malta Linux system images
generated by OpenWrt.

Cc: qemu-stable@nongnu.org
Fixes: d0b24b7f50e1 ("target/mips: Use gen_op_addr_addi() when possible")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250412194003.181411-1-hauke@hauke-m.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mips16e_translate.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index a9af8f1e74a..97da3456ea5 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -306,7 +306,7 @@ static void gen_mips16_restore(DisasContext *ctx,
     int astatic;
     TCGv t0 = tcg_temp_new();
 
-    gen_op_addr_addi(ctx, t0, cpu_gpr[29], -framesize);
+    gen_op_addr_addi(ctx, t0, cpu_gpr[29], framesize);
 
     if (do_ra) {
         decr_and_load(ctx, 31, t0);
@@ -386,7 +386,7 @@ static void gen_mips16_restore(DisasContext *ctx,
         }
     }
 
-    gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], -framesize);
+    gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], framesize);
 }
 
 #if defined(TARGET_MIPS64)
-- 
2.47.1


