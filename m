Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6B6E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNR1A-0002zD-Rw; Tue, 17 Dec 2024 01:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR14-0002wi-5Y
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:11 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR12-00052n-1c
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:09 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso1687891b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 22:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734416704; x=1735021504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/EMwbW9ao32OaXwASoWqvLNsXxITTvHnX2/S/pK7bk=;
 b=nw/8vQABY3ZDfK5I9enrytT01ZMb2kJmfCjxIKEM0uKGsT9SrH+jfcWWc61TDuOLYW
 c7bkjmjpy+0bNYsy7+hI6mN2ciqXUk94pQENk9d7KFBx2edA6bOm58kgSrnF1NAI3raM
 DxwcaE34u86l8tPNxRZLRwLLf3rl9qekn2FiZtzrYpYt3bBuUb9Bo9YwAXd+ncyc9wHz
 uoBG4NA2gO6Dvu21LnSS4x4AG32qQaLTE7ouJ+vW+WVTFap1R3JSd6rqs8k+yz/hqu6U
 so3MPD1D6g09vbMMIknxT67LrT9hV9vc9UkBEjKCeDQ139yAA85hdoNidorJYGhT+vEC
 I8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416704; x=1735021504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/EMwbW9ao32OaXwASoWqvLNsXxITTvHnX2/S/pK7bk=;
 b=EN1/QpDRdhIUomWMQPnJKZwCTm2nC9JqWivEdntnRBWyMo6AKV5OoQilrmBsPhPc3U
 mKSqahPBGRTW2OGM1tmfpPvmhBOmLuiYWdMyvNOpRWQhxYD82T3d699nGS21FKha94rh
 0W1Dk24qPJJTQNgPX3n8YPAjeb8xUQETUY4Xc9yivscgnsWnkkMFGBxsYZJTS+/iR17f
 BXhDNFpNGggKa/PEg7ULjOeeNBtInQX9W5iDS5elLAacfv+XhZrvs3xGNBY7c8kcn7wg
 dDCcIrM8sXAnDXp/ajhOboGWNPJ8N6TjKzG7Iq3bgeHZgWOMiANaalfBOKCgMFAAPHTK
 P+cA==
X-Gm-Message-State: AOJu0YwcaVeQ+5fOGPNbmbgriNwgik3N3G6DyB4loMfsEBjz68JvxFK+
 0l4P+C3d8sBr+Vc+0AVKOTokPGpo4V1aH8GxhHRMFeBXcaIaFrvl0dqNeic1wLW2Z2PfwIcxFB5
 6j6J4zVaj3hCEJm8gPPv4/ruAKJTPF4/jYBwi0yekVP7x2BrG6CEIkt3++4eBUw9a54JKfjfZWD
 UsfRsRrteV6E7a7+MNpUj8VEKWooMySlLL9CX3m3hq7Q==
X-Gm-Gg: ASbGncu8231QjLyPC1VWsK6rDxo5fKSiRVhpinLPchcVLrN18fkq5J1nbjhkMLfFK1d
 3KqlwV0PgJKXYcNk4S9yUBN2wqk4l64vTX0e+ftVqbfFFwea6bVLPt0YCY4bxYUGnrQwEvodMIT
 885TbEaFk/lTOdALYSE8M5tXxLsLmcam8kccQvRnMjXiUZwBu97WFZtQe9F2RgZ5y0+aWMafMXt
 vlPaGrz+v5urpUf1YH/HOt1YC1/JGXjHaHrKt/3DlpMycGt309WiJYCHItP7ovelxjX2XjMasPL
 qNxWKG3IfDQ=
X-Google-Smtp-Source: AGHT+IEhxxNcDgS5bc3zYHMdMy0u2jBj4nrJj3SyESHEWESAy3C8OzSN9WJYOGvVzyXnh5WMQXmpYA==
X-Received: by 2002:a05:6a00:cd5:b0:724:f86e:e3d9 with SMTP id
 d2e1a72fcca58-7290c181255mr23057700b3a.14.1734416704046; 
 Mon, 16 Dec 2024 22:25:04 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72925e6e8b1sm4354301b3a.139.2024.12.16.22.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:25:03 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 1/7] target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
Date: Tue, 17 Dec 2024 14:24:34 +0800
Message-Id: <20241217062440.884261-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217062440.884261-1-frank.chang@sifive.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42c.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

The boolean variable 'ext_smrnmi' is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fe0c4173d2..28b43932db 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -129,6 +129,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
     bool rvv_vl_half_avl;
-- 
2.34.1


