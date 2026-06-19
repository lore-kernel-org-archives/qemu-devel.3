Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABFECD98E6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRAe-0008Sp-ML; Fri, 19 Jun 2026 00:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRAc-0008RX-Aa
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:49:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRAa-0005Va-JN
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:49:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-842307472d4so748427b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781844571; x=1782449371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKPKLU7Wp4oiXp2bE1zP5WND+gmgqtQwA9/gdvD+Eus=;
 b=afeyuAhQ4JeY8wZpquSlbGA1HnBxMsfKQ8Pvl9VxnJkx97JImI1K336/zZMzic65S3
 dRDsw3jrSFfLTjxmU7EMDKyO6rSAvzaAbY0tEtu4ELDJFgzfoqC+Of/sFO7heUhOTqUl
 OMYD8UGPhC/JqnWNGgSqd4ASW1QIR/jjVIjZi1nEfiz5roTFlqu//auQA5Z2chbom8xr
 txqqIj7m3vh9FrDH5HT55ZB49mygPGGrRym7XHQdbg/ZLo4tTh7Yzw8jxpexp4d6/8mG
 csF21Q1S+bhU8oZbN6VX5/9BW23gu1aMDaNwA8DaJ5thSsrHtX3HhnN5H1YH9Y4b6UBm
 Hm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781844571; x=1782449371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PKPKLU7Wp4oiXp2bE1zP5WND+gmgqtQwA9/gdvD+Eus=;
 b=IDRFEcmQwM6Ke8LcR8O3Wl5WDQYD+XMAh4MU3rbLkMkNh/dfnkue3oHI8WCQWXGhL8
 4t4Z/odt80ZQ/Ns4f1u7qRWzx2A4wNCF8UIHYE1XEntYR6WTMVKQx7cSnRjxTJ1zhIyG
 J7zJ5YPE1PySJmiDyNI2/GKaM3dPzMNjU5RumdyQd6zFZxkijYt1WxM1ktWX+9W94M/K
 hxyN3OzCgFBrHzgb0bzmktp27StvqbZLp5za3VsYehhYTi5+la2iRCEsbSCLJzfMP1bW
 09p8QSvCgdstSxLVwDGus4sdpMFn+NqAAWKJkLDo97WgFEpHvg6bLhrb32yuA6vhpOUY
 8d1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9K/G9XDg9Pi4QJvpNtx4FWya04TzaOdlZL11FwQ78KYu0kp/duTgq39kvolDvvGjIvTjCTQFsLyYqZ@nongnu.org
X-Gm-Message-State: AOJu0YyPA7ANQtrswSVxv2anNKVFpGmByNxSyBX8OblwbPN1YwsH8rAg
 cBDixeRVm/ljBPffqQfSLcN+popsqFOWEUNDDRpMJbUO+WAByaawurM9
X-Gm-Gg: AfdE7ck3h9y58dmyHeEI133jLSRdmlwGFhNHauCfosafu7LP5KAq6Y1mZbRDudPqSMH
 rt3asXD/wJkHyp6v2ME98XAb4JGv6nZ/br5HrI9gMndHS1x89DeTSwydMZxo0ZTXGkUHyrrl416
 nZdhrH57S4O/KYTODZI7St10lualMDmlMcxibwYqWa6BsgoDlo2+9hSPYC+XxBiTW9nIQU6buvW
 M4znJxnshEy6t100OgZOH3Ynx8woMaff7Pbe3KWbTB0jQcdQXQrFxV3v55FY7JKbuYinhGtU/ya
 UY3zJm3GzRNPDTCyNQYlSZ2HKauBNj+yoa83Cvs5knHoTic2DO/ATei4bXyS0VF584mZZb5I4/R
 S/p9ol8rOj3Gd09wge6n6pwFeI8HAi9OKLGLVmsEXFT5w4IXJ7ywdbETiVwWXu7rsVlEkwCGLyp
 G3b3nzQQUNizag5xH1FSMJXOOLdMDvLhYs6OxPQi1DNDiclnwzPqAvjorFRuduUZLI9RLUJOJlX
 qZrmmj43M4p+DkJwtt9qLnOX1eqOC4XujKUL+IkiQ==
X-Received: by 2002:a05:6a00:1ad2:b0:842:614e:cc97 with SMTP id
 d2e1a72fcca58-8455087753bmr2113107b3a.23.1781844571187; 
 Thu, 18 Jun 2026 21:49:31 -0700 (PDT)
Received: from donnager-debian.. ([144.6.172.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8455363da44sm870141b3a.8.2026.06.18.21.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:49:30 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v9 06/12] target/riscv: tt-ascalon: Enable Zkr extension
Date: Fri, 19 Jun 2026 14:18:30 +0930
Message-ID: <20260619044838.1054677-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619044838.1054677-1-joel@jms.id.au>
References: <20260619044838.1054677-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Zkr and the SEED CSR.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa497e5e8ab4..6c1b0059980d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3211,6 +3211,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbs = true,
+        .cfg.ext_zkr = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zvbb = true,
         .cfg.ext_zvbc = true,
-- 
2.47.3


