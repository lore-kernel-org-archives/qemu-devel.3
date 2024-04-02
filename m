Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC639CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf4E-0000iJ-0E; Tue, 02 Apr 2024 10:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4A-0000h0-6o
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:24:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf47-0007Uo-Pf
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:24:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4161d73d876so3405255e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067882; x=1712672682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSDhdndLpU3XMgaG/Eh3mfm25De8u1KWUZwd2xX2iow=;
 b=zysXliyK1ShjDLhZ98ZmVfYgIYAbCtDcKrwvrUoGWcalGKopPbmLTdJ8b4NkchqZil
 Xw4tSLWYxKwaw8YwSH+Mb0nwfrvAuDsjVmHQVsgxoHUPuCesp2lD/S3P88l3x+XOdkUE
 J+l3EEU4mnQ4r3/7ilxAHZlclCcg5xlbojpLdKfUxqlLkOcfNh6/8GtHqfrbutCUSt/6
 1Jr5ejPQ3hUu+E2MO4gw2GuBCDAfW8HIY1x3DgXHRugo4ZOLjoq3BgK+VCr6IbYgSODL
 C7eaMPM/SqGSltX6KOMEP91lh74IvF05+TybZVtQT+kCuaIuTE1Yi483d0BTDixXwKf8
 9FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067882; x=1712672682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSDhdndLpU3XMgaG/Eh3mfm25De8u1KWUZwd2xX2iow=;
 b=Hnxrr5hCRj11QV3A+yBWETJ4pD9LHhQPqvbIHXI/1rDz1C1OBFiIBwtF44oFUXc1bI
 xXgP3xrPh9ap+ldjivBKB06Hc3zoJCnFA9NeyV2i+mg3iAlHrF+1e8kSwGjkivHdor/d
 d2p1Rg7JZrhCPTiIj2Kf0wQWzPprk+TpgV5sWbrCX/RLybxB50iLhZ0TOYChewof+G0J
 YVOFdu0DRQ0LACCe3mI08/prN4HvHbtARIG6hxkVcJcNmA+PA9v51V8lpfGELmw+Ly6Y
 BbpEuodUSpkBikLXtpvB2psxzGh+4MsYXx9elwRPpdgaZJaQA6bpscSarrF5pG0LJJQ4
 NeTA==
X-Gm-Message-State: AOJu0Yz8Oqz0ktw7S0ypjOfMDFpOJ/dW1F830ZlZJ2wKvf2mfKBtcVyA
 qhPQghPjUYyLVhfIPLYkpqPRkVc1ex2m3CSu9uc5OtUASscQJnRTUHagcEvcXPNLp9g4tt/S2Dm
 xdig=
X-Google-Smtp-Source: AGHT+IFQvTW30uNYzbYSkDXUzi5KUl4zSR7hskiZ9EFqc1byxnQMzXWybCe30R/WkousKSpVlgJg8g==
X-Received: by 2002:a05:600c:3b9f:b0:415:691c:f83d with SMTP id
 n31-20020a05600c3b9f00b00415691cf83dmr3342931wms.33.1712067881986; 
 Tue, 02 Apr 2024 07:24:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a5d4a8c000000b0033e7b05edf3sm14300080wrq.44.2024.04.02.07.24.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:24:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/15] accel/tcg/plugin: Remove CONFIG_SOFTMMU_GATE definition
Date: Tue,  2 Apr 2024 16:24:16 +0200
Message-ID: <20240402142431.70700-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The CONFIG_SOFTMMU_GATE definition was never used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240313213339.82071-2-philmd@linaro.org>
---
 accel/tcg/plugin-gen.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8028786c7b..cd78ef94a1 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -57,12 +57,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-#ifdef CONFIG_SOFTMMU
-# define CONFIG_SOFTMMU_GATE 1
-#else
-# define CONFIG_SOFTMMU_GATE 0
-#endif
-
 /*
  * plugin_cb_start TCG op args[]:
  * 0: enum plugin_gen_from
-- 
2.41.0


