Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D85FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMAL-0003FJ-ES; Fri, 24 Apr 2026 15:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAK-0003FA-Ej
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAJ-0001Rj-0A
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so6024745f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058773; x=1777663573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R90PdZauiZI9NPQAAyuBJNEsMEZVoUprNiMPEbS7KfA=;
 b=SWxey4dibqtMfsOAH3dJVLp4nFemS1QzHUTEWA/IvLql7rKAJ5Ny2bMptCsN+LDrJ9
 a2g48ix7CbfnLQywDRG1X0tdOZAOpUL7elW4+bobCZ8se14L60skMh3S8iPHTZad6kH0
 USY7UGnHARSb6Ro3V6RbJRWwuiswmjFA6hIvPlt+a2efOx+36ub4En+PfMvX0yrq2MxT
 67cnc7wqmd0S1crKfyEal1Keg7UsV/Kz6dVBjeLfNBDE3WxSJvisqIm0cQtVT3/2bxVr
 vbjA1y3IImdocJuOpTbJyonRPMOy7vT0uCpC93s+HhMcBjX9WeCQ942GtwZDHG9zynMq
 pHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058773; x=1777663573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R90PdZauiZI9NPQAAyuBJNEsMEZVoUprNiMPEbS7KfA=;
 b=Fzh1IpbXnH48gWElOFk14bIJUsgFzPWOIJF30QUzirqXM1msEfOl7ZHy6M1qDWv/Aa
 TJL+XHNjCWo4H5pVUAxJEpd+TYBu8adc112CUrCF7nB0rNTlnznO47Dz0oYjnMkuQ7is
 0bUseT5m3CMPveGrWL7p1KxmjCUea7PYE9spVhkD7ptL649euAEepiG6opIlit6JG7fV
 2kJQv5fxRh6La4/ZEYhA36/6eKR3t0AtC0kfExRS4n7MslcE8shn2yY8ynkMkudukg6v
 rEcH5xfpVVX9iv0Del6PGQAQ00AIA9+y+i/ZeXzREoFJJTUt6kumcKtmCW2UqeukHmDI
 31zA==
X-Gm-Message-State: AOJu0Yy3GzNefTqQPdwXbNl27JbaGpnJVWmytiGGmNi0T4pVK1/TMPum
 dbpIJobzn2q5/+ZlhQbht1VehosKTwFqRBN089Gyu5XwLfAVtIy9LU6EvpDED8KIrgLrglKOxbO
 ayJIDjiQ=
X-Gm-Gg: AeBDietykaT+LvtLdru0snHWXC3LsUrosP5kOn+TqYA5zNOMzmx02VMnsTYP93DsNVL
 5MuWdsiDYW5+ZtZeFEKQkBSlewhuwVcJL/sL1SXtjk2nL5gpUyX2hKEcDFA00W7Gnrl9LWKuWTi
 fjozWB7OuMWheb9gmncgjZU7eG6pMS62/nuSXs9AlCG08m4hkLlMXzqhvHpR7zcWp1/9/CAndqB
 RhFwbQTOGRQuTbbcOuqiVKOXEbWkeryuC99U8AyMuw/xSsA92pCK3w3EyCCzrZaE4bjouAm2L3y
 oRnqFhhxhtrjw4Jg+KMgBbKSYCKk9z+R1Z3gJRr8Vmz+4F3wSeFvReNwsUE7Z9now0njhfWLPFO
 A7rRwWAxe5sfxjGulTxPa/IJY9Z/9zG/FpVjTzlyBScvdi7UoYB0+qMV5NvyzboMbVIJRYalVW3
 jeANXGH7Zd+1yr69JbCvAKGXvNYQx1iUonCE9P1BRfzNl2pQy6b6rzYbmaF9uXhQspa0/pOJvPs
 HZmtItFoBlNdms3fY0FmQ==
X-Received: by 2002:a05:6000:1889:b0:43d:6244:f8b with SMTP id
 ffacd0b85a97d-43fe3dc3824mr51734959f8f.13.1777058773176; 
 Fri, 24 Apr 2026 12:26:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4411c9f4f03sm32092155f8f.1.2026.04.24.12.26.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:26:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 48/62] hw/cxl: Define cxl_fmws_get_all_sorted() stub
Date: Fri, 24 Apr 2026 21:25:36 +0200
Message-ID: <20260424192543.22614-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Add a stub for cxl_fmws_get_all_sorted() to fix building
a QEMU configured with the '--without-default-devices' option:

  Undefined symbols for architecture arm64:
    "_cxl_fmws_get_all_sorted", referenced from:
        _cxl_build_cedt in hw_acpi_cxl.c.o

Note, the CXL <-> ACPI Kconfig relationship is a bit convoluted.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260423170229.64655-3-philmd@linaro.org>
---
 hw/cxl/cxl-host-stubs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index c015baac813..9b515913ea4 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -18,3 +18,8 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 void cxl_fmws_update_mmio(void) {};
 
 const MemoryRegionOps cfmws_ops;
+
+GSList *cxl_fmws_get_all_sorted(void)
+{
+    g_assert_not_reached();
+}
-- 
2.53.0


