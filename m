Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7B3C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc7b-0002kH-76; Mon, 10 Feb 2025 17:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7Y-0002bj-Sa
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:19:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7X-00030F-7h
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:19:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43618283dedso48744355e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225953; x=1739830753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00i7CvZqld+dgS2CaEcbjOiQuiuQI6ulPrtY/Q/ykxw=;
 b=Hq8sMejrYGJhc1c50NoLZcTx/4DnzFjqIQOpzGQ0h5sLl6rkZvb1EKL8q6rXYGSeuz
 wXVelyLxk+1qMPTTru5xZFkZktq7wdaUcYkQq3lfJXBOEytmj/VsL70H1NiiFrUWpu2i
 dkqStacVb7ee00E/zGQxOacV4BNlT4AKeuEOkD/iuajIqEBzSCGo2whZTBrNHDXwyEE+
 kg9rSuP8ort6tLCQELUArPJHu2esk2AE7BO/1MUKSzmuWm5xrdOy1mQP1Wp0c5gSqdBU
 GADwcCIs1fXonh/Zy1WUqybkM2gXJBoFM2eeFShG2MnfLa22+CjphsF6ynEP0Cf5yaii
 QJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225953; x=1739830753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00i7CvZqld+dgS2CaEcbjOiQuiuQI6ulPrtY/Q/ykxw=;
 b=f9Vb4uZPN8V1FFrV9xyJbM9LTL7YuQO0kaRJTzSnVxls5076z+tScWkMZ/a69n3cXJ
 9oPPh1e4xfdwsYp1be1/rf0KsN3Gm7sz1tl/Zlhkbg5RJkNM5qOUOXlYaMbxfMUFbWKz
 zCvQIx7WN7CXQKgu9Zbcd50VDnCjSa5imOOCpjQP7RzASnr+gkGR9WU7cO1r43yPk1DG
 HjoGQ/AGnrlivyPKn1fF+zsnYIkkWZFDjhaSSLgrDgDMssSBO+dW6timvHOaXleElBJm
 okxz/YHlMM6hiYINsbpdnUsbL0uhpDdxZuvGXVNFXSWtK1sUZB6OqFdsRbmRG99n8wtd
 KsAw==
X-Gm-Message-State: AOJu0YwI5GhKsyhnLZmbWoBQMSAlaT1jKg5LIDjoDUdhHJrj8TaCeyCg
 rmGFJIp7KSP4kHamxj/EDs8ZaLjpee55kro/W0JfUZPknCM4d2p7DuepGkCW34hfehy39oLv9r2
 sZBs=
X-Gm-Gg: ASbGnctn74WMYqrImyT8KMBc4wMy23v2LqMGx8LUdAPseWo4adkjq8GK/gwZ3mS70eO
 SJbo4kGlyESfJPzpChqn2Cm8p5A0vwbaES3rp58yUVLqh6Rv/FXhuv3S/1w2lYliQbTMqxY5uUu
 QBscN1LZMzSslymQxdvHMfOcGNrB0Uv5pu4whT14v8SjsgV9MdtjFBl46UVZ3Ph/K/A09umD/4v
 gD7Z6NzK0AgQXXsFYdCVkEgUgvNC71Fy1yONYixOJf6iKC2RguilRmQdGww2l4uaY6T6W8Sl1+z
 hzTXWPSYLlMoC/5G87J6FUbTjDXBlk4JdRpVwEdYC0qzWj0uA49ZIsnpcCldSAKa8Q==
X-Google-Smtp-Source: AGHT+IFfiuDWCPz7E/ZPc+Lcz0VbU+6d4WCx/9pbDO8ATTRZnH0PkFwhIoyO9dmt9KNYaZpCpBSZdw==
X-Received: by 2002:a05:6000:1a85:b0:38d:d906:dbb0 with SMTP id
 ffacd0b85a97d-38dd906dcbcmr6573230f8f.7.1739225953214; 
 Mon, 10 Feb 2025 14:19:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439427b48f8sm50529075e9.30.2025.02.10.14.19.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 14:19:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/10] target/sh4: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 10 Feb 2025 23:18:28 +0100
Message-ID: <20250210221830.69129-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210221830.69129-1-philmd@linaro.org>
References: <20250210221830.69129-1-philmd@linaro.org>
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index e3c2aea1a64..4a50f2746ab 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -134,6 +134,8 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
 
 static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
+    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
+                                     : BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_sh4;
     info->print_insn = print_insn_sh;
 }
-- 
2.47.1


