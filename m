Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E22CAC5BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20on-0004iS-LX; Fri, 26 Sep 2025 01:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20oi-0004fL-EK
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:24 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20oc-0005zp-Jh
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:23 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-32e74ae0306so2499536a91.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 22:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758863772; x=1759468572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfw6pFN7dnHUrHR6X6D+GvMv/TVLaMbzCXTmrNOoSP0=;
 b=YHbwLtX31PryrIlTldrR2vi1FITcOrDSwu7CgvFWQasDW8nSXyb3k+JrWOLQVl9jMe
 KpWkJmdw9rcJ5DTA0u4fs7s/ouKLflhvj9SIQewvUpcE5R00Ge8IYzvNdIXm2teQQCfv
 VVPC1McllqX2emMtE3HW23Z2zMlK+WuWHJ5iGE03UwUXfmAQRBfyOq8ISP0xYilU/lZQ
 Abvc5IrBWxRe0K2iTNoGwH+gPe/m4y50WcGZ6GP/y0zdLx6Dx/q/xGnYgiFfnGrp2OT3
 meu0HjmU665pNmDPd4Ffj7jR+4iNXHrG+dADWFr/gqDkvhCWxM7omUUpWaFZ/4CLcbTe
 CQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758863772; x=1759468572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfw6pFN7dnHUrHR6X6D+GvMv/TVLaMbzCXTmrNOoSP0=;
 b=D66r5ndtg4ZTQtarO6NPw45yENQ7DsIKQLtbVN4czLjUjQd6Yn+zga0qmqJCABQ1NS
 UzaaqRpCDR8z4r7GbY8z2JaeplMzJYjSQPI5YYWudqjtdGEkWhwliroIJXfW/EnUCwcL
 HZolbPZo7UszJY87+3vyM207PBWL6Y7ro5toiT6y8uAgI+ipb+VdWb7+WDWWHVVxfu5h
 Gz+UZyPnCLHfSse/k34nHEpwOsnqJr7Li8yzEgmTXD/GjXKjuE1C8RZiIRpPpnOre3w3
 5esYW0JoCl3yGRSZFY66TjKWFxgSJvEHXSKbrmA4nb0+mP9CP3Qh2yVqyHd+v246JCQ8
 fA0Q==
X-Gm-Message-State: AOJu0YzSm3yvAHSLq+hae3n5r0ki9KCAdiJhT62sKB948KbjEJjs1vB+
 jZmXDEwbVGqMofDBjekW41RIX76Y0gWVh+RhsCgti5BcvhqLDwsBDhJQiolzmkIW1rbcWxQy/KF
 lgn39
X-Gm-Gg: ASbGncuACNbjO+96jZVEIlPNBOe3rW67todgZwMf8X+6TniFRm5iLAEfxi57V/O/CbP
 cj1eN+Mf4VLpsH5hmWxa/hWOAinutgB/iGEiLdnyIDv6zBUnXmBh6S5qeGOSOOtDkmLCxOToL/U
 k5TZAfYBHsDeUY/Nt+9V1vLr9AVkfmxPhq7MfGeYBzodGXZh8jTNAGowNZqLjN5diA8US1xPTzx
 fbKi9WLutLGF7nlk7lKft/tnviSlLGXkyP8UTgsDIUu1ZDAPkjl57V5Txsbz2RXGNXRQSLup1+V
 dhOfKM6k+vXoKaI33oTZH5Je2Ssezi5BsP+YLFwLCuOo8jEPXTu5NvDxijCCALygmOC63IMTHTd
 gLNl6vsTnaDV0DiFTym7UsCvhBHiveLfbhRfmWmr40C4ZcMvKiSiXdDaGtg==
X-Google-Smtp-Source: AGHT+IFdImT+dvV4PUe/mWQhlxfU2I54JafCP6wqf0CCaG/0neUMikNw1l1puERlaBxmDuTb+lvNiQ==
X-Received: by 2002:a17:903:1205:b0:269:95a1:94c2 with SMTP id
 d9443c01a7336-27ed6ad069cmr61483825ad.3.1758863771994; 
 Thu, 25 Sep 2025 22:16:11 -0700 (PDT)
Received: from gromero0.. (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed672a51fsm42160085ad.63.2025.09.25.22.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 22:16:11 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v4 2/9] python: Install pygdbmi in meson's venv
Date: Fri, 26 Sep 2025 05:15:35 +0000
Message-Id: <20250926051542.104432-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926051542.104432-1-gustavo.romero@linaro.org>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1030.google.com
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

The upcoming changes in the reverse_debugging functional test to remove
Avocado as a dependency will require pygdbmi for interacting with GDB,
so install it in meson's venv (located in the build dir's pyvenv/).

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 pythondeps.toml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pythondeps.toml b/pythondeps.toml
index 16fb2a989c..98e99e7900 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -33,3 +33,4 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
 [testdeps]
 qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
+pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
-- 
2.34.1


