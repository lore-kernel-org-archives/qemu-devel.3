Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1F1C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc7T-0002Md-QE; Mon, 10 Feb 2025 17:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7K-0001qD-N7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:19:02 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7I-0002ta-1Y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:19:02 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dcb7122c1so2993028f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225938; x=1739830738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUkz5f9MQ2pvcvCLkym9eiE0tZLYKK08nDn81l1HJFM=;
 b=btk1CvvPA3YTyZkjjFkkQz71BxpkDtSyMlarm2zkWBwUP+lD2cBij426TTSlkHaBCD
 /9cfUN4o4zmgrGA+iViW3GE484L8KpVNBoKSSp4OCtd2xtyRaB0gfVhXOv6SCRWQGnKm
 1isH304D77gVIHSH1MOCVd/BicQqrb9l8pKQMyIpRFe8Z7mFraMdPwj7Zu5FIHePLl9v
 vswp6F2vLBvb5xpU4Yfrk1TH7l0P4XFDkALv9veT8C2p3xVggEfg3J05pYjWShP2IfWx
 0Z4HEox1ecxdX5/a3SnhizCwENC18tmwEY8fjKMUQcasbh04M/cRXrwC8fKrNnQjZ74f
 DAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225938; x=1739830738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUkz5f9MQ2pvcvCLkym9eiE0tZLYKK08nDn81l1HJFM=;
 b=qVUOrtVb6vgnc1XFhIqAFul94au5MBal0R/35sGkXBK06JdnddjW+sTF7LknN/uSLn
 m3nRKwx2SuzOc1gjm3SG4XqPd9cCzY7vNRfmof0yTWJq8tMdJqMJK1mYoL9ICbBdpzCh
 PG5+3SlSs8hoyTWwoE+40ZP8XBtWCvkl8enZpABMI95aBe1bpqsLT4tfv5ooljcig2Uw
 +XY1MhXGsNEFnVYBkml9DMDOa9axMimzhwFuFOBas+c0SK5ByrAJ6VY3cRDUlIccVNaV
 7Ohw+pONhDZ9fAv9/XnKMBFMBbdtPzD3jBIzguO8VNfClzApHgSBX4xMDxGHOA7Ypi2V
 NpCw==
X-Gm-Message-State: AOJu0YyOFECOoyKk1EsTzb+ebfc1/wSiCITGexviFM3eVFRc19ugQqbb
 hKDULv7nqyny1UD21DrFnsWvD1llZMtWX2fWBvG5I9pbvYZy6dg2K8OSQNNOoLCZhVwIX/aUqHs
 ZmX4=
X-Gm-Gg: ASbGncsoskCpUYzQR1kFPLeXB1r4wkHYX5jh4b04Cc3s7QsKv6azOxPPUHAfHvfKdiz
 AC3Xy+xS/1E5auEaXo3uv949PrYjKP8XNoSVJ1RsSNaD/M4tuZJdm05W/2b5AEylAhI9wQrMRT+
 /Cm8Ok7cJ/axCtNA1G8BwYkHln+k7rhwyxUO/9amcld9TG8sYYwM7wjpufkfxU7lk5abIze9WU6
 7G+hE5lIxnQCDBgUr44WVd/EXnwXfrVOM7w/5IpAnAmXI9WFmgjG4lyCzbYkacQQr4INKPOodAk
 /Le+lHshtIJdXid9dIsPz2nN8wiZO0K2vQEmvl4HgKQnfHkysizOaOpbYMQ+cN067Q==
X-Google-Smtp-Source: AGHT+IF0Ru1u5EVFKG2X3tJNsKsqsxVtsoW3vpp+BocPBd7gSwhzEWm6XTm5e4z3JeY+UPoIHgRYIg==
X-Received: by 2002:a05:6000:2c3:b0:38d:dbbc:3b07 with SMTP id
 ffacd0b85a97d-38ddbbc3d28mr6156987f8f.2.1739225938021; 
 Mon, 10 Feb 2025 14:18:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc9ef8ac6sm10675362f8f.27.2025.02.10.14.18.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 14:18:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/10] target/mips: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 10 Feb 2025 23:18:25 +0100
Message-ID: <20250210221830.69129-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210221830.69129-1-philmd@linaro.org>
References: <20250210221830.69129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
 target/mips/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0b267d2e507..e76298699ab 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -428,13 +428,13 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     if (!(cpu_env(s)->insn_flags & ISA_NANOMIPS32)) {
-#if TARGET_BIG_ENDIAN
-        info->print_insn = print_insn_big_mips;
-#else
-        info->print_insn = print_insn_little_mips;
-#endif
+        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
+                                         : BFD_ENDIAN_LITTLE;
+        info->print_insn = TARGET_BIG_ENDIAN ? print_insn_big_mips
+                                             : print_insn_little_mips;
     } else {
         info->print_insn = print_insn_nanomips;
+        info->endian = BFD_ENDIAN_LITTLE;
     }
 }
 
-- 
2.47.1


