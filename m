Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEC8C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxj-0003VL-DJ; Tue, 04 Mar 2025 20:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxh-0003SC-4d
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:17 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxf-0008TO-Dv
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:16 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22349dc31bcso110902965ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139654; x=1741744454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhcMHAF0LEx4SB+8bqtdgUZxuEwpD7O1r3fLFnMpyJA=;
 b=Par+Cxjr1cdRQMn4+jMLgE5rSzqWQVVkAHCw4PudxHEJnYKkDDx8K1EUYUdTgIWp1x
 dIcRisOwxqXcA4vQ8SdXnjqazzuc60HFbtmw3sdMFdefrpw6SK1PC8qhrcxjoJ/y4BTf
 DrBcRPkSkEVw5f2wD3smzj4XXNeicPUK1ynK4ffFYwmGtn/AMcvXVViccHrcJkOobafW
 3lDDRTA8Sm7eIFC5XluT+QPRjfyQsWyUo71Pn/5NeUxqs8CWMeW6qlL5u1wVKVqTwSRn
 uj2IzqabygVaNPxYa7epQSBrvwk2UHbZLitRFMwgqjbhpA9xl/NC+nQrQVWCTnbWPYx5
 oKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139654; x=1741744454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhcMHAF0LEx4SB+8bqtdgUZxuEwpD7O1r3fLFnMpyJA=;
 b=JJ3n0ilJ7JLGZqHbp+DAObLLtCDTyBAHjZlYKQAwxT5pwyHz1U5lOtKXyGVcRozlJC
 UYcKUiD1O5q/WhiTk2np1F9aRpQs63FiujUSoSBjx8hFO+iuvC/rXX4iw9YyKHUb950s
 8Pj4ncWJqpQNmlU+RaVtonbb63iYuXg7WUgdetrMvUH0qZyeH0VNZfcYQp1oOOG2ljtd
 3RHytMtCNFpycSEoygb12eX7bZWesrmDdlz+Yyitcc8zh6rr13/kzQ+w0btjI++gQMPd
 kTAOVBq0ZS5ndKOBOx4mtgOKIhsIDGJc9Ri4/wvxRoEXWz32EsPyRj0HKoUbjzmqo1cF
 YNmw==
X-Gm-Message-State: AOJu0Ywn2gmQtVzVnmeQPNNrpJSlWK7ru4fc/vKiZ7ztdA5PayhDKtzT
 4n4F1oWin+Saya/B4fGSx8JIpadWkOEqBxz0hqh5Z7XXgksCZ/Kz5mJ7PHNmvXU=
X-Gm-Gg: ASbGncv0MADuhpCNxGbvHNHMonvrn90YmF6Xoe4BTqcZOmu4ZmopkGgwGnOu5e1nqHP
 gJbVQoVc1yL7WtQT9fzRWcSSgvzEE522O246nKtSlXihxIiiYJcoxrnLM9TKKYDRqhFZkMltTco
 ttKzJuHqqK6LVsR6xjak7wkHoAMvvQK/SXCmLzBT6FOPEQ43G74YxM5HjjPQrUQbnAQHq5iEJyc
 kVGhUXx1csD/jrfT+5tbsmngBpxpa/0TypkIQ/Yx5y/+X6lVnWEnZjPpkAnXxGL0yblkdOrlkIg
 Zd/ROvctIxeQIPK1oXmdzNrpsD6HusuJVTeSe0Q54PXQmyHQ/LtqIeRpwlYvdNHGjy+wgH1+qVB
 iKMFxENSttpHQS02avcn7WwBR/Z6J8eLL3L7mzbziXwyNZs+zgB0=
X-Google-Smtp-Source: AGHT+IGOgguZULiQwawFZuCYN84Spa8roeJdqYWB28rTP+rq9/aWIJaCf102B0wrjfsQqUCFq0BCWA==
X-Received: by 2002:a17:902:e54a:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-223f1cf3515mr26184075ad.38.1741139653723; 
 Tue, 04 Mar 2025 17:54:13 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:13 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vasilis Liaskovitis <vliaskovitis@suse.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/59] hw/riscv/virt: Add serial alias in DTB
Date: Wed,  5 Mar 2025 11:52:28 +1000
Message-ID: <20250305015307.1463560-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vasilis Liaskovitis <vliaskovitis@suse.com>

Add an "aliases" node with a "serial0" entry for the single UART
in the riscv virt machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2774
Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250116161007.39710-1-vliaskovitis@suse.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 241389d72f..dae46f4733 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -971,6 +971,7 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
     }
 
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
+    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
 }
 
 static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
@@ -1180,6 +1181,8 @@ static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
                      rng_seed, sizeof(rng_seed));
 
+    qemu_fdt_add_subnode(ms->fdt, "/aliases");
+
     create_fdt_flash(s, memmap);
     create_fdt_fw_cfg(s, memmap);
     create_fdt_pmu(s);
-- 
2.48.1


