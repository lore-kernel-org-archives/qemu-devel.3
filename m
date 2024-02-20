Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C1DC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsd-0000a9-HF; Tue, 20 Feb 2024 03:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsZ-0000Qr-SS
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:31 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsW-0008EQ-Nc
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:31 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3e87b2de41so179889566b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419205; x=1709024005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oYRntaNNMgPCCT0SX7UleETmeevTDso1L5CoXCo2/4=;
 b=YdmdMeXFVFsik+IorgnDv1Rfftp5D1jHNwHI+T0DElK5He75N+DihWNTfVvMyNHaP7
 k+5oj/64mIS4Kd+Ym6q7qbvC4qV6SwZQoYf6sGQrT7qsArJ6YnH5JvvfFqhvzPCvvWic
 F7573fOQG6Q8PhYnvvgtg2jafdaxPZm94rRt5dOP5++oqBZ4kTwAOHylrPLuEX1NLI5a
 gz13NLl4Q6393iBC/jeY2fyBvuW0ZajLjaVJRDOFkbykkVvQkZ17YeSmhRlsjjkmmfkf
 F1lvVO7ivSoOErTxMQFynxQ8g9ScnaqL3dMC0lyl5wAbrrztA5HQh+U/QAtlRgU+HpQT
 iAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419205; x=1709024005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oYRntaNNMgPCCT0SX7UleETmeevTDso1L5CoXCo2/4=;
 b=E1PMkvCeOhIRpRIj9q44P5ZVjIYGnFJLqtHGA1MBJ35mUHGd+58LmEI8k8nDmhSTaJ
 ZicJSgOk5EgalEVkgSir6fwPeHX8sDI3KUEH+bZ8ph61sMcXK/JPgppuKUzvHAP9kHLB
 GHBfWtqick/+wSwWIcGQuPgqei3wrygIEE9rFhem14FfPWDJFF8hbRTQWF/Kw9blwAun
 eTQpFK4DA3KTh200yCPXvY40CE335BHJuG5BAj+D84ClZeAtLNwcO/M1xPvHET+1FJD5
 K8FqgwW06rxmbbS2YANzQKpQd+bgSEJttr0FqUqtHA7j1P0OUUYigV4NZO/nbZWgt7Ns
 lK6g==
X-Gm-Message-State: AOJu0Yzda4y5e+Kw5B8pi2QbEHnHRzE39dj6GDQwOCYUXIaeQgHE+309
 28rskJElgzx94z/fcjiK2bmd+d6XOewR2uPRDQTQwGXoYnthnTL95w2bjLRnCxU=
X-Google-Smtp-Source: AGHT+IF8Ry0+Beac6Sx8cCpRJ1SkbxslngVsRNPeqT9w56ggTuQWHIkBuMu0GrqaICsOmH09ZkIb5w==
X-Received: by 2002:a17:906:ae55:b0:a3e:ff4d:6302 with SMTP id
 lf21-20020a170906ae5500b00a3eff4d6302mr834173ejb.9.1708419205351; 
 Tue, 20 Feb 2024 00:53:25 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:25 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v1 14/21] pc-bios/README: correct typos
Date: Tue, 20 Feb 2024 10:52:21 +0200
Message-Id: <300815e3494a5f016137a09f331bc4137f1ed9ff.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 pc-bios/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/README b/pc-bios/README
index 4189bb28cc..b8a0210d24 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -67,7 +67,7 @@
   and enable the use of well-known bootloaders such as U-Boot.
   OpenSBI is distributed under the terms of the BSD 2-clause license
   ("Simplified BSD License" or "FreeBSD License", SPDX: BSD-2-Clause). OpenSBI
-  source code also contains code reused from other projects desribed here:
+  source code also contains code reused from other projects described here:
   https://github.com/riscv/opensbi/blob/master/ThirdPartyNotices.md.
 
 - npcm7xx_bootrom.bin is a simplified, free (Apache 2.0) boot ROM for Nuvoton
-- 
γαῖα πυρί μιχθήτω


