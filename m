Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E32C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 01:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcZ4k-0000Ij-Rd; Sun, 04 Jan 2026 20:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcZ4j-0000Hr-6G
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:08:01 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcZ4h-00044e-Of
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:08:00 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c75a5cb752so9663055a34.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 17:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1767575278; x=1768180078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6nimTH4x6Y6T9Mv55zR1WreMunRtz7sMNJXYNDPhSI=;
 b=dIRPtwNdECB4na3jDkcFK/w3EaVyluLuxVcNcu8FZwjtiC9z/jChCu6CyRfXwQdNzk
 LPPIz6sSUKJadihJYu50pubPCkh88OHTnGpFYY+7bdUUf+RQS41yH1M81QUbOghzLX10
 sPtvfwdSCOkqAM5skMTr2Xt9KoXcQWuS4bG/DR6QLsN6BQeCrsC9/TH/2+bSoMAC3WLo
 7YOZZHrWx+bRyFW93AmEyCMUSXvxxlekBOSgrGtsNwWKd+SrMpvbl/gdZEj2DQyazqoW
 /Cud5EOiudyGYAVkQkkou69ZmhHU6vWkRZbAiSeO2C1bSoKANfsbjYAZqBmbWuMo8xcp
 KbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767575278; x=1768180078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R6nimTH4x6Y6T9Mv55zR1WreMunRtz7sMNJXYNDPhSI=;
 b=ThtxBzLI4pAUIluWpeTPXVvUusINYEDXUq7LWwntFReug8r1o5xL/3tLBgUZWhbpTq
 P+8YcasiFC65xq7cdfJoyMyUUO5l7WEJP8c+z5vKjYns8sNotgVXjiiloFuFzJTW9Ykp
 Di1+Ck70ueHUDiKkxedi60ptqn/fTW5Zxkb0fIvDePVNePDHNr00Q87kkGYdj3a+R+Fz
 Ike66CWSHzKXC2LCizUM54AsOFJL8xQbFnBv+V3XC7qPXLX+dXZ0qCIkS84cNnvNNUJO
 XuBWTEUkG78qbeBdoozRvql8mLAlfHg+QddYM5Oo/ns4wVBXNyCsVArzdXWRXuLNUxGY
 eC0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZpjK4UwH2sXo+iSBOONMPx+vBqUbcgIlTuTnsOboyywvnWqw8JmNzNO44STxHLd35RgJiLUXBFbrm@nongnu.org
X-Gm-Message-State: AOJu0Yy4S6x756RnOWjWCLs1snX6IAYksgl0YbiqtiLi72yIZZMpoxGb
 5ZrphX9IiN+toFNdLCrmKmm1zljBgKiqRKEKmr5/MERocI/yDwXAi1WeotRe+D434+g=
X-Gm-Gg: AY/fxX4AU9l+pRRaWXecc2qlX29W2UEnpgnuirziTWn14DBx5vZkRylJqGg6trneM4m
 fDCNKkynrj+ZE5WVv6aidf2cdyfn23wPcNj6SrBQgF1Yw0EVlH+7fAjJjWW6AHagIPPZa3Askz3
 6xhag3/Xd0SuxUVLoyzQoSw5Imwlbjh/Cw7ClnIL7w7CfuKFcaHwyAbqY4koF4kGGPKngVZtLcV
 P9a1nLkOH59kWNSJpGCape+N9O/df1JTj6N2wfcOjCEi7M61s8k4/DO2TjTQUnx/kvmMPrFp6Bz
 1xjswES39ysVA936uaP+PuE4/I7STn1OOiB9IDCeWbGOo4zRyACV7ZgmIPXQd8Kwju/1WFF6pU5
 VsyQxIlaC1T4Kj7YIEpZoucAX5LJh7SNP1rnEZOEOu/ymLQxbYJDeRXEbzDxQmG/5dgmyqb4Lkf
 YaKOmlIDTuAXPlmQ9PCfljK1uVANBjs62oVbLhwY6HIOAM
X-Google-Smtp-Source: AGHT+IGPq9eIPe+nM1Ssvlacl73ydAbK126cIQ+k/h2R2A4J/epEQMwx4PXmg+2NqNghJXn8U/uMOQ==
X-Received: by 2002:a05:6830:71a8:b0:7c7:7adb:e0c5 with SMTP id
 46e09a7af769-7cc66a289d8mr21802552a34.25.1767575278513; 
 Sun, 04 Jan 2026 17:07:58 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cdf600885asm15962364a34.21.2026.01.04.17.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jan 2026 17:07:57 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 4/4] target/riscv: Add mask_reg_full_update to Ascalon CPU
 model
Date: Mon,  5 Jan 2026 01:05:57 +0000
Message-Id: <20260105010557.318635-4-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105010557.318635-1-antonb@tenstorrent.com>
References: <20260105010557.318635-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x32e.google.com
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

Ascalon writes all bits of the destination on mask-logical and
mask-manipulation instructions.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 671891f2a4..fe4234b665 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3169,6 +3169,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.elen = 64,
         .cfg.rvv_ma_all_1s = true,
         .cfg.rvv_ta_all_1s = true,
+        .cfg.rvv_mask_reg_full_update = true,
         .cfg.misa_w = true,
         .cfg.pmp = true,
         .cfg.cbom_blocksize = 64,
-- 
2.34.1


