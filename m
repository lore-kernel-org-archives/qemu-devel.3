Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D39C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJu6-0001dv-Qa; Sat, 18 Jan 2025 20:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtw-0001Hg-3i
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:56 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtu-0003Qz-8k
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:55 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f78a4ca5deso2184682a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249293; x=1737854093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t14AYRuGs2SL7RwFjkxmv907YPXKPHoDqrHxeht7Kdk=;
 b=GLx/lNV23Z01ITYcOioH00L7Dbtbms8R6fmwwcg73ytHytxMd5VavXvyGiqspF9zME
 t0mDej/MdAABV5/of7ydOwQFKnwj14cN0ciz7OGDZodhhG5QKgaCoynp5Xdy5nII1T50
 SxKcCxunjyeEZqfmo/po/3zsD8D82XPegybi4C9fGar+o6WQ0fnIST8jTithGR83ARrR
 ilnf/y/jLPJEr80ZmWxjrhpPu9zijZX4oSP8jOKZfMSvtUSg+T6H1EIlQ1rbdFLur2ce
 MTtHaHzrt9e1H3NT4oq3yGb6+oas+qtbWAkhh/YLSAvuIfidHOmsgvanPFORTokKOuvJ
 HSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249293; x=1737854093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t14AYRuGs2SL7RwFjkxmv907YPXKPHoDqrHxeht7Kdk=;
 b=Q7oDUvdHgrdSigTyWhd3Z/lAdc1kJEJt+4pEtetlIxWcHKqrv7V5ziNh/o0InhD/7e
 gctcIY4nBhiuHLRvYLrE2iiZ0k/v3gc7PHwPfv4w0RveN+W8TXQLvSp4RmgkHEzgghXS
 4Bi9xPrWkvbUHEvGPQuvyrXsvQQs7JiQ5vBGKfA3S6TVpoBSCnPd3ztpYrXkJYLFTrdL
 Tm3HGnaPuorWCjD/qvGZZpv38+Ltx8YttE0wmX0mSy4kkyfo5ES+9CRKlrZh4byUjeSD
 m2ChZZns7sdVU2oQn3vlnam3J1gDHSWKF/SyWnG6BeZTG/76lQiHw7iAii/i7CqZn1hj
 v2Jw==
X-Gm-Message-State: AOJu0YyUZhkqkD45xdXSyOeSg2kpKGX7foyvpxym2mXdnak8Soo61cII
 X/GZ7zYH7ym1uOe7pzvRUm/+MvEKB1/WzvZuV+Gpc5XXZhP/98xDLhnW+xCM
X-Gm-Gg: ASbGncvz2wsrkaCYazAosls43/9Q+kcJVTaWwVUhAyRxkxRASlydTreBguX4mi/cV2W
 VgZLIVdgBm8WpTTVhFtkPFfrNt+3VbevEydrTLVM4efjRMJPNopd7Bb2Xn34RzMf0HDrQ2DKWI4
 5vl8ZBdvAS/WSPEf6siSgjsAc7txTgna8ozPEqQeZaUiOJFOXpLM5rmVA+zsaLGsmr5pmvmQyH8
 SChgHigla+1Kr1CRUJRDyZlOfgW0QURmQza/VtUo7rrbDXUQ+1idw+5/t88+bU7z7XZLb3gL4+E
 6HAA8LlXwb+CVLwsaVjALULbu1ZA594lkYGVUZNN5TFJtisZEPp+gC7me/oCsfiq1ecNLZxcRg=
 =
X-Google-Smtp-Source: AGHT+IEV70DFh59o4QWzZrSB41B8RlQz1Vy1n60J83eNdnG4CoPeSl2tqYekOCvgqW9AvzIzKonN3A==
X-Received: by 2002:a17:90b:2652:b0:2ee:599e:f411 with SMTP id
 98e67ed59e1d1-2f782d8cf56mr10084011a91.34.1737249292666; 
 Sat, 18 Jan 2025 17:14:52 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 38/50] target/riscv: Add configuration for S[m|s]csrind,
 Smcdeleg/Ssccfg
Date: Sun, 19 Jan 2025 11:12:13 +1000
Message-ID: <20250119011225.11452-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Atish Patra <atishp@rivosinc.com>

Add configuration options so that they can be enabled/disabld from
qemu commandline.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-11-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 671fc3d1c1..fe470f646d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1587,6 +1587,10 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
+    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
+    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
+    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
+    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
-- 
2.48.1


