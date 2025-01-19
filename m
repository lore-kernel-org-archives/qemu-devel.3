Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43507C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJst-0002x9-7B; Sat, 18 Jan 2025 20:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsr-0002nA-Ko
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:49 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsp-0003G5-QY
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:49 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f441904a42so6105181a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249226; x=1737854026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZSJ+p1yAQCwMdEMaZfFPCzep6ypElgVWhIRM+5ATyE=;
 b=QH2EqNCGOICDrlUFEEVMA352DdGlvuyS2fS0LArz+NcJmPZnvy0r8mE8rU+a2dG6Ot
 GYE9VBw1mFi8AtqH0K8gX+y0lQCULgsjjpnNXoaiz+rdMyRZdg1mthH8nZc5bX10PaLJ
 ZmuJryMAq6ou65y403kJ6plNfmGkh7agQbCFS+QJxMDHqS//UT0Rwe+YgMJyoIkf+0KD
 rNEkjvVhqlGzMASvMCjkuT14/jiKwwqHT0Fj3cpqXerJgwHo2aImBO/DJ10z8/EAqgZm
 Qqqh7p5enPfD4Ka7K9t/5PD5ZSuay/7DSJOAFDENdj3/lp2Un8sAou4fHZ1pn0UL6PqZ
 PkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249226; x=1737854026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZSJ+p1yAQCwMdEMaZfFPCzep6ypElgVWhIRM+5ATyE=;
 b=IBCPlWDJyx/f6BrfgsetP527t3BYA/666JHTJTC7fcmvcFXlruImlpWKi5otP5pJRE
 BS5SPPVonFKdv/4j276undzugnxRb41CdpsQ0rfB37s3HRelj3P8BZOGud2V2pGsc6fJ
 9DyLVI8YtgUNUZIXRrffHrVigsIgyCty2oq4wK4rRL+ngvXtj5mJ+8Cs+fChEu2R2foZ
 vNj3F/TDN2VvcF0+wUDbxvTMma4l7ZN+OuZaSlLEhHRW+8rd2Cm0dCMMCUPmhIkbHXpy
 RAMxpQhKPCkAHWc1WrVkFNOwPGMSN+ZR73ZI7vmDIn1zXV9fBgNpXX//Y/ddVAHCZ0Mx
 M/VA==
X-Gm-Message-State: AOJu0YxIo5hRM6VxLhyDJlOlVFG7GGJ/VoO7RBmHynO18Qvoug7kCQMx
 UMSKdDQWVUZuwBT7TSBwhIvCfIIrEANFcfZ6sXqXLcyAqFJ0U8ggcYKHbUKE
X-Gm-Gg: ASbGncsSOaa+MhVSlFfECike2KgY6iTqJ3u5NySj/WiL0U6rdWrm5qQb7Lj61bO/wef
 3uTl41MpkChQZgj3/uliaucgP01RyeynR5hmn+qFC1MtMQt0D89ZTSZvkZrqwvatFAk5jcfcRPB
 8g+czOQ9aKk4Z5fyfN6hMXJWllSsxgMn0c0phMGZKy2Ly1doOoSaw1p2jD4P2jr6efUMyPI1sFM
 Ik4ssDyPJQ+5gN3svtdcVRNFM4zfUMUh2ZDBwjUeDrprGgCSYW6ElUE/xNRhg7o6mZqPM+os3LB
 MF8eFHSpxuTTwkd8nR5ReqeIfrQVorWENw9NIoCzYDVmbNbMikbyv1BHGn6T5/N4lBOXEm5Jjw=
 =
X-Google-Smtp-Source: AGHT+IElFcOwQkPikFhOIpWdIElEfDtPHY4ocECSWUOuEzaZFJv7B3+8n6QQtXc+0Y9CxemM/MxpEw==
X-Received: by 2002:a17:90a:d00b:b0:2f6:f107:fae4 with SMTP id
 98e67ed59e1d1-2f782c93e5dmr11859931a91.8.1737249225925; 
 Sat, 18 Jan 2025 17:13:45 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 20/50] target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
Date: Sun, 19 Jan 2025 11:11:55 +1000
Message-ID: <20250119011225.11452-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

The boolean variable 'ext_smrnmi' is used to determine whether the
Smrnmi extension exists.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106054336.1878291-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index a36d3fada3..ee7c908710 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -129,6 +129,7 @@ struct RISCVCPUConfig {
     bool ext_ssaia;
     bool ext_sscofpmf;
     bool ext_smepmp;
+    bool ext_smrnmi;
     bool ext_ssnpm;
     bool ext_smnpm;
     bool ext_smmpm;
-- 
2.48.1


