Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C4DD5B857
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVC1X-0002qc-NH; Mon, 15 Dec 2025 12:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVC1H-0002mJ-H0
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:06:03 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVC1F-0006Np-DE
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:05:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso28307785e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765818354; x=1766423154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5dqEMUNpwCwHTOlA0/N2E0eE6wBHpfqJOJYF7Yrn5T4=;
 b=k3Y6BthuytoizW6KhtEKd6k2Ju36FRGSJjbNlXvb33dDsQbPkM7rfDx1/iVR3Eci7R
 1z6F6jgc/7riBZKYcC/U//Kbmsaz1Rx52SabcUAGli7CoXXXEfMcWwTCJUn6KZuzU7YO
 KDgDTFKCWWf5xKR9huh/TT9r4PHdb/3mWwmXyyGKzBIhMtdrnOxTzDm3gOPtnP4JJVBW
 SDPShfm4Bhu7OkoIiQIgqxAg8ruro3BcjeVKtwwUPScbr5dQZENPOCDWPdvKwAQ+zxAw
 /Y71xmuMHs/qdo5eAfuTG4+Ul9lI4mZxAhsVf2D3bRmotQV6pSpWFGIbkHaMdGqYHLkE
 i+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765818354; x=1766423154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dqEMUNpwCwHTOlA0/N2E0eE6wBHpfqJOJYF7Yrn5T4=;
 b=b5WtHbm7ut5681KYkqcUpqhpWby2yWDAlHNxPalSl2iIrVCYmm6j5CqLgoYKLi1CEz
 JcFnx/OYbcpKDZWQJM5+HUgwfshClH9tQl+gAMP5XRAs4Ch/FoV7BrFtzy0q3V2cg6EH
 ZQAbhRowyAO1Yddunuc1joZ4cXSdKQd/SJPmt6v89y7nPVE0olOpTKAu4WiY/PWS21X/
 8JLn1oX0zNkqVngyEEBsAahR+R0k+NvzyasZhicKDXIEKu/cekVQ+en7nXRx/YXoXcwV
 7JFlhOSoujCC1RIWTlroRmTcL4Arb2JjimgYYjJk1K8r23PEzmVwOBKSmH7NM1B6W2d2
 dF/w==
X-Gm-Message-State: AOJu0Yx7wLv6mPcXNdQWF13qRFqktdUCIxPK0XzgMTjrf6dkCldX/I7K
 F68PwW+uidDZIZY1hHZ6M8bAlpBHMsRQYGokMSmN/rPEjfBPuXpyz2Q1s8okqRrf76c=
X-Gm-Gg: AY/fxX6xSunOXr+QM+8ZGRBFyVSPy2J3PkNQcW9EvvmNxxfpd/xViH9SovPnEdR8cJW
 vtucXfKPTJxapsx2EBfOrBjbtj3PfjT1uIt9DF88jlSC+ZCV0vcB/gnHwbYt8fmyYa6B1QG0c26
 ZxokYRKfS0RG+cIg7ptGP8lKqCIuiySjQuDA1MCg75zN5NRw0iruZ6QD2u2uWtR4hC69mjXsGp7
 vbfmNoTVewe8Ol0iGds1fSu5IZbnl1TlShnzzoFVT4vgrrpUk5ChsNf07qLiTQGLB8B5ijOybsJ
 Dm1j0zVvtu9IWserLgLv9+JhvMPJvG6xJcxhqn15bETuqan0sMQulA4YlWU3fxB/L6tLdOF3WZk
 xVs6wxljx3KIYcioOTmtKSQO3GwRemW7JyU/CSYGvpGEXruK30gWrmPNYs+HLkG/ujhzzFFWx1W
 IE5/doyhhllf61UX86WzozeA==
X-Google-Smtp-Source: AGHT+IHFXArWI2TH85/gV1oVeEQJcXaIHNpjqJT0RSVFh2ZuoDUlpWnqog15JV1E3++Bes9P0342SQ==
X-Received: by 2002:a05:600c:3ace:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47a8f915c57mr96998455e9.32.1765818353701; 
 Mon, 15 Dec 2025 09:05:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a66b1fsm32290177f8f.9.2025.12.15.09.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 09:05:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 272685F856;
 Mon, 15 Dec 2025 17:05:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM PrimeCell and...)
Subject: [RFC PATCH] hw/misc: make the tz-ppc-port names more useful
Date: Mon, 15 Dec 2025 17:05:48 +0000
Message-ID: <20251215170548.2594651-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

The TrustZone peripheral protection controller (tz-ppc) sits between
peripherals and the main system. However this results in "info mtree"
looking at bit confusing, especially as the sequence numbers can
overlap and miss steps:

      0000000000000000-ffffffffffffffff (prio -2, i/o): system
        0000000000000000-00000000003fffff (prio 0, i/o): tz-mpc-upstream
        0000000000400000-00000000007fffff (prio 0, i/o): alias ssram-0-alias @tz-mpc-upstream 0000000000000000-00000000003fffff
        0000000028000000-00000000281fffff (prio 0, i/o): tz-mpc-upstream
        0000000028200000-00000000283fffff (prio 0, i/o): tz-mpc-upstream
        0000000040080000-0000000040080fff (prio 0, i/o): iotkit-secctl-ns-regs
        0000000040100000-0000000040100fff (prio 0, i/o): tz-ppc-port[1]
        0000000040101000-0000000040101fff (prio 0, i/o): tz-ppc-port[2]
        0000000040102000-0000000040102fff (prio 0, i/o): tz-ppc-port[3]
        0000000040103000-0000000040103fff (prio 0, i/o): tz-ppc-port[4]
        0000000040110000-0000000040110fff (prio 0, i/o): tz-ppc-port[0]
        0000000040111000-0000000040111fff (prio 0, i/o): tz-ppc-port[1]
        0000000040112000-0000000040112fff (prio 0, i/o): tz-ppc-port[2]
        0000000040113000-0000000040113fff (prio 0, i/o): tz-ppc-port[3]
        0000000040200000-0000000040200fff (prio 0, i/o): tz-ppc-port[5]
        0000000040201000-0000000040201fff (prio 0, i/o): tz-ppc-port[6]
        0000000040202000-0000000040202fff (prio 0, i/o): tz-ppc-port[7]
        0000000040203000-0000000040203fff (prio 0, i/o): tz-ppc-port[8]
        0000000040204000-0000000040204fff (prio 0, i/o): tz-ppc-port[9]
        0000000040205000-0000000040205fff (prio 0, i/o): tz-ppc-port[0]
        0000000040206000-0000000040206fff (prio 0, i/o): tz-ppc-port[1]
        0000000040207000-0000000040207fff (prio 0, i/o): tz-ppc-port[10]
        0000000040208000-0000000040208fff (prio 0, i/o): tz-ppc-port[11]
        0000000040209000-0000000040209fff (prio 0, i/o): tz-ppc-port[2]
        000000004020a000-000000004020afff (prio 0, i/o): tz-ppc-port[3]
        000000004020b000-000000004020bfff (prio 0, i/o): tz-ppc-port[4]
        000000004020c000-000000004020cfff (prio 0, i/o): tz-ppc-port[12]
        000000004020d000-000000004020dfff (prio 0, i/o): tz-ppc-port[13]
        0000000040300000-0000000040300fff (prio 0, i/o): tz-ppc-port[0]
        0000000040301000-0000000040301fff (prio 0, i/o): tz-ppc-port[1]
        0000000040302000-0000000040302fff (prio 0, i/o): tz-ppc-port[2]
        0000000041000000-000000004113ffff (prio 0, i/o): tz-ppc-port[0]
        0000000042000000-00000000420000ff (prio 0, i/o): tz-ppc-port[5]
        0000000048007000-0000000048007fff (prio -1000, i/o): FPGA NS PC
        0000000050080000-0000000050080fff (prio 0, i/o): iotkit-secctl-s-regs
        0000000058007000-0000000058007fff (prio 0, i/o): tz-ppc-port[0]
        0000000058008000-0000000058008fff (prio 0, i/o): tz-ppc-port[1]
        0000000058009000-0000000058009fff (prio 0, i/o): tz-ppc-port[2]
        0000000080000000-0000000080ffffff (prio 0, ram): mps.ram

So as a quality of life feature lets expose the name of the underlying
region so we get something more useful:

    0000000000000000-ffffffffffffffff (prio -2, i/o): system
      0000000000000000-00000000003fffff (prio 0, i/o): tz-mpc-upstream
      0000000000400000-00000000007fffff (prio 0, i/o): alias ssram-0-alias @tz-mpc-upstream 0000000000000000-00000000003fffff
      0000000028000000-00000000281fffff (prio 0, i/o): tz-mpc-upstream
      0000000028200000-00000000283fffff (prio 0, i/o): tz-mpc-upstream
      0000000040080000-0000000040080fff (prio 0, i/o): iotkit-secctl-ns-regs
      0000000040100000-0000000040100fff (prio 0, i/o): tz-ppc-port[gpio0]
      0000000040101000-0000000040101fff (prio 0, i/o): tz-ppc-port[gpio1]
      0000000040102000-0000000040102fff (prio 0, i/o): tz-ppc-port[gpio2]
      0000000040103000-0000000040103fff (prio 0, i/o): tz-ppc-port[gpio3]
      0000000040110000-0000000040110fff (prio 0, i/o): tz-ppc-port[pl080]
      0000000040111000-0000000040111fff (prio 0, i/o): tz-ppc-port[pl080]
      0000000040112000-0000000040112fff (prio 0, i/o): tz-ppc-port[pl080]
      0000000040113000-0000000040113fff (prio 0, i/o): tz-ppc-port[pl080]
      0000000040200000-0000000040200fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040201000-0000000040201fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040202000-0000000040202fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040203000-0000000040203fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040204000-0000000040204fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040205000-0000000040205fff (prio 0, i/o): tz-ppc-port[pl022]
      0000000040206000-0000000040206fff (prio 0, i/o): tz-ppc-port[pl022]
      0000000040207000-0000000040207fff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
      0000000040208000-0000000040208fff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
      0000000040209000-0000000040209fff (prio 0, i/o): tz-ppc-port[pl022]
      000000004020a000-000000004020afff (prio 0, i/o): tz-ppc-port[pl022]
      000000004020b000-000000004020bfff (prio 0, i/o): tz-ppc-port[pl022]
      000000004020c000-000000004020cfff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
      000000004020d000-000000004020dfff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
      0000000040300000-0000000040300fff (prio 0, i/o): tz-ppc-port[mps2-scc]
      0000000040301000-0000000040301fff (prio 0, i/o): tz-ppc-port[i2s-audio]
      0000000040302000-0000000040302fff (prio 0, i/o): tz-ppc-port[mps2-fpgaio]
      0000000041000000-000000004113ffff (prio 0, i/o): tz-ppc-port[gfx]
      0000000042000000-00000000420000ff (prio 0, i/o): tz-ppc-port[lan9118-mmio]
      0000000048007000-0000000048007fff (prio -1000, i/o): FPGA NS PC
      0000000050080000-0000000050080fff (prio 0, i/o): iotkit-secctl-s-regs
      0000000058007000-0000000058007fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
      0000000058008000-0000000058008fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
      0000000058009000-0000000058009fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
      0000000080000000-0000000080ffffff (prio 0, ram): mps.ram

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/misc/tz-ppc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index e4235a846d4..fd305f9f62f 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -273,7 +273,7 @@ static void tz_ppc_realize(DeviceState *dev, Error **errp)
             continue;
         }
 
-        name = g_strdup_printf("tz-ppc-port[%d]", i);
+        name = g_strdup_printf("tz-ppc-port[%s]", memory_region_name(port->downstream));
 
         port->ppc = s;
         address_space_init(&port->downstream_as, port->downstream, name);
-- 
2.47.3


