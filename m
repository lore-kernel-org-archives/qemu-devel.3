Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879F8D41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjgc-00034N-IA; Thu, 11 Dec 2025 11:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjga-00032w-JR
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:36 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgZ-0003t9-59
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:36 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29806bd47b5so1846325ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471113; x=1766075913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFjzAt3V16vj8pMOvPT4tfpSGw4vX8nwSrhUGNpwdlI=;
 b=CX8R2dOQxXYUM4Pc3uvoSMPFKTV1yNF9Uy75eKeUuAtc4PTjMOT4TLmiY/BdfJ/lEA
 AAkoOs82CO30NZsDLfHbEtHbVNMEulDNyrxZaAKSirNfLaIvYmdhq+PSF6KnYve1oH7E
 yRYgqp9Pv3rH/I7p8vp5T2Ui3s42PYY6I95pZQqZwlKGbfb2ghCT073YAMK7cmWdFjAM
 S+Qm8b25ismR2eyUfzhW4hHhL5kFY+QuL45sP/NlOQG3mBo+QUmSwR5H+5gEJp3H8gb/
 n4sQ6aYB2EbCc7DYq60rWM7egYYdjJOQDomqRrwBHrjHoWmeA0E9xpQ0tR72udlDx/9P
 m0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471113; x=1766075913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pFjzAt3V16vj8pMOvPT4tfpSGw4vX8nwSrhUGNpwdlI=;
 b=OZCSKNo0q3cSv9YywhKhCC6IeiFg0p8+/VME6VSfdoamN2b7ZBgU6BQrBSeWIkSa6f
 TqE4M4ppuB0bFJwO7IoU/r8L6WXO8gFQBMz8E8ECnWqIIAsOQztU6KsTufn5kbLoad9S
 CGJ7n1dBmtAU5rClaxLc7kYXiCjNFfbZlxjgc79ck5bMOdNKnyCy5b/ESTkXbHLSjcjR
 Gm+bAQ2lIjwc3rxDphgJkYqKgdNhmxWtUeVi+eiZCUShkXSM1X3ia3baugB2kBz9y3wJ
 CiqDulXBMu5ZBclKYj0R4azTDEw0Gd/K890POxwLL7a8QwDYehXSeoV3GVGEdhzOTWu0
 YA6Q==
X-Gm-Message-State: AOJu0Yxs0U4XQR4Z9Di/EqXyDCgbr1J4tUQ28/S2o6CHNVXINd9sYJBh
 nVBBboCau8rJyUqVQR0YHA0b3mbpCEsXC+8BfG16J5MU3buMI/4Y+O6FwQyZn3ffkPvrpcDzj3v
 TN2e1EkIZ4eR+MEabOzsC/J1GWC9Es+jgU15+QQ5QfIUP8pVISb+U8MmowIikOHCW+Qgrk2efsR
 Z8O4i2VyhxlX7tFTTK8h6vfEi+18k88rTR53aiZZ8D19Q=
X-Gm-Gg: AY/fxX6CwK4XqhcgPSFct4mqjrJN/BD6FuH4cWMiki8kPAy8XRPVmVt4NewvGK3mQ0w
 7riauEKiQ4ugEPcDZWAtvc0qnIvlFaEP9VtOKkaUSgk3D3z+KhCi09yv7d+PnLObNqU9YtlNg75
 lM1IysPLZ/Ndw7s2ubn9nrsePQQXXlxYP0QHaxCEXxPuCLzkY1Thmc75z4qrnAYzLI2YcudguAa
 X3YZVUxoErOYsGiVKPyJP0BhA02HEPBIMl8GF3eKUxrjaNasE5r3PlG2czEAFNtUvWS1bZm4Yhk
 zp5ObIGxRNpFfHZuv/p9ZmhJxRILnimKMoXaG6Dp55uWFA8OsBMdN5SK1STjuchbVwt1GdyCPzl
 TDDh5z/tqpb3GpdqCq4yx38rbKBRjVu3K7w0ZNiv1bJhQ5bsuDUHjyqLgJT0uJ17mrg5rM7/0TD
 EPDh5CsFLEZnOMeB6yJJ0EW/NxUJFzVFnaQs9Htg==
X-Google-Smtp-Source: AGHT+IHLQi81XNmf60owEyBqaCe2pQozfVYqDqUGIyU9jOmygm9KTR5wX+2KzxEaQYsDwwZnCgECCw==
X-Received: by 2002:a17:902:e54f:b0:29d:9f5a:e0d1 with SMTP id
 d9443c01a7336-29ec27be9f9mr67461425ad.27.1765471113097; 
 Thu, 11 Dec 2025 08:38:33 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016c63sm28962965ad.48.2025.12.11.08.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:38:32 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v3 1/6] target/riscv: fix address masking
Date: Fri, 12 Dec 2025 00:38:20 +0800
Message-ID: <20251211163826.3998266-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211163826.3998266-1-frank.chang@sifive.com>
References: <20251211163826.3998266-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

The pmlen should get the corresponding value before shifting address.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 172296f12e2..9b3f01144d2 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -203,8 +203,8 @@ static inline target_ulong adjust_addr_body(CPURISCVState *env,
     if (!is_virt_addr) {
         signext = riscv_cpu_virt_mem_enabled(env);
     }
-    addr = addr << pmlen;
     pmlen = riscv_pm_get_pmlen(pmm);
+    addr = addr << pmlen;
 
     /* sign/zero extend masked address by N-1 bit */
     if (signext) {
-- 
2.43.0


