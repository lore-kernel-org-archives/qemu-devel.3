Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8C9CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyXM-0000gb-AB; Tue, 26 May 2026 16:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXE-0000cJ-Ix
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXC-0006xP-KL
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49040362e4aso54175005e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827872; x=1780432672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsM35W/WkO5VOGyCq5JTHjDkwnrXsH+8MtcBngCSo5c=;
 b=h7ySPZ0eCqJbvl2tg1LIJclzDugLFIQh2Cb2VRZ1GoxWSeE++jLcTrP6QKWim9Bb7I
 6luKU74OQINfCCQFcTkRbebKrccgnyGgcOf0J8IZxTQvvPbU1P1slnbDz/iafXDtTh9P
 8n2qwv4bZNocw4vPznBg0J8hJEw0OfljvesroBt7FAmTZCfctatOnu45JyRw3mAErWCM
 lJRtHVZGnAU7RUO9HuUe7Atu5606OWS7pN6/j12QeHHtvvGs3xw+tGibcQ2O1MuhLc3f
 MgeRgs2bTLLDRM6YBMK5INhBT/bs5FxXPbYAIUEpDcVf4eVNhnO8CgFIIN+tWMPMI/HV
 mVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827872; x=1780432672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsM35W/WkO5VOGyCq5JTHjDkwnrXsH+8MtcBngCSo5c=;
 b=ZhyiRcr/w8S2aZcoL/1CxPA7W1TVJfQxdJNc3uEO2oOHczEChNcMAWoxc5LN+yapc8
 SmBmrxNcctE8hHtd7lyHaag8/5hOJyc2ZU1Z0dz5dS/M5lECjLV5l2V13pdRU47OW3kQ
 3cJEUOKO/rI64rbtPpwYZWBs3kM3Wz6VfAJQrtkU5JEsm03zz2SvzGLWeCV04z9hGtjg
 BrM2rZkYS7+I+Bu12kRiB9ClyoV/Iw2V9zgywUivwoSm50Im4cToJyVvaWB8QaXjPv0t
 VRKUTGiVghyw3p9CC4HuIvNJrrGfO7hLE76s6/2tbcWR6CnPWcy3TVo6517Y4xBfPeDw
 OQIA==
X-Gm-Message-State: AOJu0YxIkF+noDeP2ydBoGznW5n0sp759lV2AwiCmmFDpzwhxAOHkBBZ
 9QhjjdQ2KdHHKk9zP8fKLUcvWHUf4FwDVSpksVme52pIkl7k9tpZOVma3yN7deWHWtnFZ60t/kU
 Re70PuMrugQ==
X-Gm-Gg: Acq92OH9+Az+/EdMw3RM2RF4KXDNRisivUBs31hecxQH/zixwvQqGBWkku7JiISCMyw
 2bCEfOuwrpWkVALYhCqs9BJx4SPwAfuAYUWsSVSCzqRJQVTeQgndPxgZOSLcRnniUZWs1Rj5byx
 FErFPoyebszMvmnzNmhJXRPVpRNqGhbbE+3cQbL/DRqIE0UEColsSHCJMwWVLg8FjCD2A4iyh8v
 yGN/82x2JQLeljx313MRUKbs7ilJliKe6Dd71R5+tVqYGbPBmwheZL+oKqWzcSGWFDudQ6SmMzJ
 pRpAh6wSJa37Npf1NPr/soG6NMGEFk1NK3mQkTvR9rP2DzBeCbtCq5Ae1wZRpPqdyMM35O2b5+d
 nIK8ATEjy5BdOEyWRoyvnVXGGvICQ0uBaa+8zGoiSPnwYI6lXxwc8UlX2RRGEoDgey2U4T8vPC5
 EvbXcZ/6oRBVGpzbiA/1UzJWhIhnyYVJXhJU0sZFPFZvZYE60haPfzk9GvGq+gL746MA==
X-Received: by 2002:a05:600c:3393:b0:490:4b89:5375 with SMTP id
 5b1f17b1804b1-4904b89553dmr168242065e9.10.1779827872251; 
 Tue, 26 May 2026 13:37:52 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454dedd9sm320125765e9.6.2026.05.26.13.37.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:37:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 04/17] hw/arm/aspeed: Build objects once
Date: Tue, 26 May 2026 22:37:09 +0200
Message-ID: <20260526203722.79463-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Commit 064f1ce95fe ("hw/arm/aspeed: Split AST2700 EVB
machine into a separate source file for maintainability")
remove the last TARGET_AARCH64 use.

Now than Aspeed machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
compile the aspeed.c file once, moving it from arm_ss[]
source set to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f149ed68d09..22e8ad924a2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'x
 arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
-arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
@@ -69,8 +69,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast10x0.c',
   'aspeed_ast10x0_evb.c',
   'aspeed_ast1040.c',
-  'aspeed_ast1040_evb.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
+  'aspeed_ast1040_evb.c',
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
   'aspeed_ast27x0_evb.c',
-- 
2.53.0


