Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D20CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNDx-0003Sg-5p; Sat, 30 Aug 2025 11:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1urwLi-0008CK-TE
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 06:28:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1urwLg-00019t-Io
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 06:28:50 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so271192166b.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756463326; x=1757068126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0OAYDaE9GsknEeqaJd9kzGBYjESvoyAnzYx/N1AbW7o=;
 b=b8nveYjmzLJcsEMBe2CgWrEwHYOKlASj09nz93kC2WCmKtlpw6jEBEpHS6EXyn212A
 PnCPrPpTm4EHX6xly3pxOBOk1mYQ2YblFiXFAg6H5hi2wEsb4FHS0luu+clrMabFPFcQ
 OeXhipJYu25R/vQaX4F3yDhbhnikjn+o0VYGWGA/8BOL1NTy+wo8hceSMM9xPrqxqCEw
 /qXLsB9m0BUp5HfpkCPyBccOUwF2d00tyn0lzJMyrOo9dUH2if43n8DhDkb2R7y6D6cV
 Lw0KFOdmGZvxOAZkqa9iUeKz/IM25qzblPy6186niAZTKMAAyVpCa6/1f0Ox00vjQ+Zi
 NM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756463326; x=1757068126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OAYDaE9GsknEeqaJd9kzGBYjESvoyAnzYx/N1AbW7o=;
 b=gG42njat0kUS1ePxH5Jfs/QHBxtJQB+j9W61+aMTjpjix5OcEy8GPKVI0KuI3TffcY
 No6kgs98cLIrdQRs4RczHQS9nfHVWNVv66TiC12fk7bxWpgJ5Mb2ZIhefiDLTcK91KPc
 KUfCZnQwbo4PbKALIb0cxLseifX0C7Uxxdp9mL7j4h7XM6PFPPui+3V3tBuSjg5vgQbq
 TjE1iBestWDdgYqVL9BaDxWpnfFQ+ErrbsRiWaJCdNN94Fojl5bXGOOUjpXsH0uEK6iy
 RQPPPA35H6+AjBqyacwKl74QbplvMoaNw5BiBH5iSceTxTx7FNECtGS2dlaAnj3w5OGk
 8tKw==
X-Gm-Message-State: AOJu0YyyPnKPwCNCkTo+hiwIo0MtH3FCMcDALI9pELOzVqhphFOK6Ena
 oUs9HWvWl1t4ANxw/Vl7euaaTavDKHoyhgDssEtRrDD5Xnp9o8dVsRIHPkbyEbbuLbg=
X-Gm-Gg: ASbGncv/WA/ZnahaPh2aNtRF9GJQY0Lh3uN5SpsmZMsVGUwoiZK+8rhaXgTOnLq2SsL
 iyTIBZdKrC3pjFHTVtY+vgA9wyqV0rLi91B7ANndTlj7HtWN7RRsnMS/V/TwRWX/TxuTLyWb4GD
 DJKBMya6o+TWmyzldtEFjFGxD5sO04fmZwm5texyN3BiVo0L63fUk48dL6SwbBDMES01KrQpMcr
 HfMKfDnJu7kdqA0edzW/LtTS6tI968pFProjf3ySVuuOV89fa2SGJdn3C/jZGnrzCHVOsKM/oi0
 0QT2MjjKn0km5RnWR91WQe2ifwqnD623v/ZdI/8QdznxeZY60+kl3NVsyndQtvXZfSs1AYv2msk
 bOTJ8zzmLKMS8SjP06yRVbX0=
X-Google-Smtp-Source: AGHT+IErKVVpi9FUdAmR2pX1yDBQI3+k/PKYE0O4/+/d/oEan+IYw68skgb0b2AxTmbabaBKu1QPVw==
X-Received: by 2002:a17:907:6e86:b0:afe:ba6c:7ba0 with SMTP id
 a640c23a62f3a-afeba6d2b90mr1038364366b.53.1756463325939; 
 Fri, 29 Aug 2025 03:28:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afefca08b62sm174610166b.31.2025.08.29.03.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 03:28:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6A765F747;
 Fri, 29 Aug 2025 11:28:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] docs/devel: fix typo in code-provenance.rst
Date: Fri, 29 Aug 2025 11:28:41 +0100
Message-ID: <20250829102841.52702-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/code-provenance.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index b5aae2e2532..af5d7349e12 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -331,7 +331,7 @@ ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
 generation agents which are built on top of such tools.
 
 This policy may evolve as AI tools mature and the legal situation is
-clarifed. In the meanwhile, requests for exceptions to this policy will be
+clarified. In the meanwhile, requests for exceptions to this policy will be
 evaluated by the QEMU project on a case by case basis. To be granted an
 exception, a contributor will need to demonstrate clarity of the license and
 copyright status for the tool's output in relation to its training model and
-- 
2.47.2


