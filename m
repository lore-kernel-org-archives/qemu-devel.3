Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CC6CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY9j-0002mh-5g; Tue, 13 Oct 2026 04:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4d-0001nF-RU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4c-0008Jc-6o
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1ad2e2391so2933775e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880885; x=1792485685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MeT+bQbA4mzMBemWeTOL9DdPMgcpzifck65oWgevcU0=;
 b=yHGLZ/l/OWbP5NKMO+/e6qdeVQ6RCI8H3lDsoJyYV/HjY2xQPQ/haMIL+k4QFB0ZE9
 jaD2ZsGIhh5SWr8nWbL09rPNaGajDxWRPEMCm8FWPwwzFbmwO0wyWIaEVmjgmQ5v6OHb
 8uH9g+5zLQ6lS8upCIHRd/B/rzgr3ziBWIpww3hbMAHMVT6n7252Gr5j3ZTOVB2P/rMc
 uAN2L8lvZbtBtJuaEq9j44xjFqOIKkYlpJyvOYGdMOkvdw89V55MVUy5BygdrOnpueNg
 9D1OhQOV2zPrpYVkR+IUB9TvR0DbFqyrgu9bKeG1TI6fzwCYQqwpY6LX3Jlt6n9Ycm6F
 qgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880885; x=1792485685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MeT+bQbA4mzMBemWeTOL9DdPMgcpzifck65oWgevcU0=;
 b=NsTADhJtsvzcFJxw5LYAXysgK9SLfvttir4VNZxca1wuo0EgD52q8tBbfp3rF2PCyi
 aIsS20dbW/fwedz3NIbs62m+yh9aIVEUlhOFi7O8PETxvBa2AW/f/qxbzA030cMgkKOO
 8G2vSi3UPUG0Kk6SxHhFrDtu6RDiJK14FPXcGjvGqmxC7f46bJtBYC3K7TKoMMzN/6En
 XZGlrv5CdqhfwGtCVsY8fLmhYfVEjnUiCRpvkUvD4PR7SQA5Kyv2Q6RuSSYjFzRg0dQJ
 Q38v30H/tgse4OcKnsnHbmIsoS8TmZRXJibgSrhXRO8QE4mbESM4owjGYYPHrcZDheLC
 iZ+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/b02TQdXcKP0WcPYmZUoLRjsJthlJJR2IKc8mnXsPSWDiLk4SyqgTMiWh1GkfL/2AoSIUsSU8aKn/@nongnu.org
X-Gm-Message-State: AFq9FYKoaLaTYsfF/shlnBWkqdRqxrTUbHR3qDIws79AVoNHDemkxEJr
 cHyhL/ptVzaNHqznYZLz+/RQB8W/rYW2NARjM5QSbFIisAo+eIR9dnaaujdCBxzW96c=
X-Gm-Gg: AYBFou2V2fW9t0Z9LrWSWNEYdI+KIm459Shu5bYooTmJPgGnimndUKUlmcWvEjzLUdM
 g4KZOFgAMcEl4dZBNwazOMRBj1M19JmeetVjbvUzc7Ca5kNBJZwwIKBBDIXc8B9+7af3V5NMxzD
 mZo0KAyJtPJELpZbKdlEY4K2yuEjDVBQuuUT8Ed9wFQ0NZfAGeqGxYLBCiC/O/1OrbLlM9VwuNz
 NCq0gwYE7037Y8ww6kubwxmmaKTCT9PHzXzLQu5+NPxT3whu5C4ysmMzSFyVLN8I04XTNj9s+TJ
 QHCN9eDjhIJuu3VgKusteKHZOQqHjlnKouds4hDwbBof/7wVsSbp4F8tDhuGkqriPSgJXLHx7+6
 XfzSgZuLHFScahFYwHASxexDGKbGj4TH90+WTfni/LLepRV3e+Arij2ED+/keL3fjRrO7WbS1q5
 UCsOyn7pntj/vYGnSh4cMhfPbhPHEPZQJKv1yTtInkxKiFfvf0dh2wjfGsmxpoo3hsVm78c0pRf
 dQkkhydh3SOb6G93TfAS60vRus/BgA8kxu3WuckiYZKcRLGK19VFfKnzrpeb52saQZa7A2FiygF
 gL4=
X-Received: by 2002:a05:600c:4689:b0:4a0:1cfd:321 with SMTP id
 5b1f17b1804b1-4a18e4a9b31mr249422025e9.12.1791880884628; 
 Tue, 13 Oct 2026 01:41:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 85/86] hw/intc/arm_gicv5: Implement no-passthrough IRS_SPI_VMR
Date: Tue, 13 Oct 2026 09:39:32 +0100
Message-ID: <20261013083933.1024405-86-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The GICv5 spec recommends, but does not require, that the IRS
implements passthrough of SPIs to VMs.  Linux does not currently use
SPI passthrough.

For our initial implementation, implement the IRS_SPI_VMR register as
RAZ/WI, corresponding to "passthrough is not supported for any SPI",
and with a LOG_UNIMP message if the guest attempts to configure
passthrough for an SPI.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index de595d93506..f380f144f6d 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -2582,6 +2582,24 @@ static uint64_t irs_save_vm_statusr_read(GICv5 *s, GICv5Domain domain)
     return value;
 }
 
+static void irs_spi_vmr_write(GICv5 *s, GICv5Domain domain)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+
+    /* RAZ/WI if no virt */
+    if (!gicv5_domain_has_virt(cs, domain)) {
+        return;
+    }
+
+    /*
+     * The spec merely recommends that passthrough of SPIs is supported.
+     * For an SPI where passthrough is not supported, IRS_SPI_VMR is
+     * RAZ/WI (indicating "not passed through" and not permitting it to
+     * be set to "passed through"). Log the missing functionality.
+     */
+    qemu_log_mask(LOG_UNIMP, "QEMU GICv5 SPI passthrough not implemented\n");
+}
+
 static void spi_sample(GICv5SPIState *spi)
 {
     /*
@@ -2873,6 +2891,11 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_SPI_VMR:
+    case A_IRS_SPI_VMR + 4:
+        /* Always RAZ/WI until we implement SPI passthrough */
+        *data = 0;
+        return true;
     case A_IRS_VPE_CR0:
         /* RES0 when VIRT_ONE_N is not implemented */
         *data = 0;
@@ -3077,6 +3100,12 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
         irs_save_vmr_write(s, domain,
                            deposit64(cs->irs_save_vmr[domain], 32, 32, data));
         return true;
+    case A_IRS_SPI_VMR:
+        irs_spi_vmr_write(s, domain);
+        return true;
+    case A_IRS_SPI_VMR + 4:
+        irs_spi_vmr_write(s, domain);
+        return true;
     case A_IRS_VPE_CR0:
         /* RES0 when VIRT_ONE_N is not implemented */
         return true;
@@ -3244,6 +3273,10 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_SPI_VMR:
+        /* Always RAZ/WI until we implement SPI passthrough */
+        *data = 0;
+        return true;
     }
 
     return false;
@@ -3283,6 +3316,8 @@ static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_SAVE_VMR:
         irs_save_vmr_write(s, domain, data);
         return true;
+    case A_IRS_SPI_VMR:
+        irs_spi_vmr_write(s, domain);
     }
 
     return false;
-- 
2.43.0


