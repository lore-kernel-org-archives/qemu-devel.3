Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355B8C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYh-0003ua-9d; Mon, 21 Jul 2025 09:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYF-0000Bg-PB
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYC-0005IN-Ac
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so2478750f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104446; x=1753709246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rMO0z2Dg2xe9/sSr/rgtQPRY3C/mD4AtJBFkheyKZIo=;
 b=A3ATLQA9qQ7rfat6iAjbwseyPA5+4bN9BoTz8w48ApFFj/jh23uWFu5P8R49DYUZ4d
 w8mU+AL1BiMxAxqD+yA0ZptYnmu25rwxh1fjvjYeD4UPs+h5rXbSEkk4jx+b3huR4+iY
 BXf9XhrTL86+O96AdE84Mxejt69VkNCdMm2lh6otqHmZ24rC2Y427FZhEx/FpKK/QniO
 hxuY6E76H9HP73DGz+p9pjlNuDMegpucEVIZgsVzPXLkI/gxiouAYHGeQzFliy3w8IIn
 WDJ2dm+0xMvmvRTDzDV2zEK0JRtpQGc7ctb6SMtv+9iZ6Brfj2QvhIlRAS5+XaEOkNbA
 HT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104446; x=1753709246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMO0z2Dg2xe9/sSr/rgtQPRY3C/mD4AtJBFkheyKZIo=;
 b=FnFMQg4IaxvMcqtlBJ/uDaljw8wzoivHgVsto1GXqjYYk2OSC16kAe5CpsiL4Ag6Ff
 mharX+010GvjGP0NInKkGAb9J+0xGUc+5gwcnV6SswHbBXEupkwQoKQqz7/gz87ZW7zQ
 aiD2S4TplIn82k3hg64I97P+BcCfy4NoewVUsI3JKWNerD8+JPtsHzEc4QmuzIhWSC89
 Jb3ykVW88H8zLH3vHqZVAVziCxYdJs7cKDAyewWMF+U9IjiPjdRYTpE41VQKjhY5Aooy
 k2YhZjzMHoaMNfzXS32Z7rKcdA7uq/oCRFttMMVcuw+7PoTwWy4puVsRP0jfgY7+dYdc
 /lRg==
X-Gm-Message-State: AOJu0YyJQeuXJ3ITAvlUcb/xQZP4h38F106Fx5nNbcxsgNzOZSuBwARs
 bl+8NloM+oRCVaznG/4w1vMhEjopMdINfC4R0MH0IQLz5EBFzVXp4xBC+ayG9vXHZ8g8AThNSyp
 N8Ntx
X-Gm-Gg: ASbGncsD3/lgmPoKfZjuJdcokZL8aWwf+f9vHjYO60Df5/pnHc/tc6pXN4YFcuIXZ0o
 Gfp6Z8wPGEBCDrOK73+gW/v3TjNpJ5tlsLE7z2sw/qjrNTqdjNjn4g7FG7bAuOLowd08ZkxNBp9
 KAf/i16J8jgPmRkCGyB9WCi5567jCT0cxb6KdCHxV8RlI5gJml5BrTORXTxRLQE+1AXDCKQhaKI
 0bSGJ43cabTuco96/XO/CS8J76OROouc91oVw7ODRPgMltgZmvC/nbjVy7ZSj+qt++5V4tEyy4i
 1/Qmw2ifp4JlkG1hU6l8QbdrBztdQUnu7kCFGGEQhHfnX5fpHLJ6OvWfMFx2LyU4GekyLPVe+k3
 3VL5I97JxUM1T3Fu65xMAzMhs6Z+0
X-Google-Smtp-Source: AGHT+IHEliG8u9hGB5rHKVEqR/80qdXbGH2JsWhYJx98+QmP3vQCw/NPTx04ifCCISyrjd8P82FbRw==
X-Received: by 2002:a5d:5f55:0:b0:3a4:e841:b236 with SMTP id
 ffacd0b85a97d-3b61b217f68mr9274095f8f.33.1753104446409; 
 Mon, 21 Jul 2025 06:27:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] docs: Fix Aspeed title
Date: Mon, 21 Jul 2025 14:27:04 +0100
Message-ID: <20250721132718.2835729-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Cédric Le Goater <clg@redhat.com>

commit ad8e0e8a0088 removed the "======" underlining the file title
which broke documentation rendering. Add it back.

Fixes: ad8e0e8a0088 ("docs: add support for gb200-bmc")
Cc: Ed Tanous <etanous@nvidia.com>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Ed Tanous <etanous@nvidia.com>
Message-id: 20250715061904.97540-1-clg@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/aspeed.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index bec0a1dfa8b..bf18c563470 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,4 +1,5 @@
 Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+====================================================================================================================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
-- 
2.43.0


