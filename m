Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0B3D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nu6-0003V4-U2; Tue, 29 Oct 2024 11:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nsD-0000qF-Bk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns7-0007k5-2U
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so3624564f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214659; x=1730819459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hIn8TWQshR4xk0eH6ep1S0A+hm2DkFGROZexRTXqVg4=;
 b=H4lExa5A0RsdnzyMzJtjzhKvjyt73g1ZtZtZE9dJEO2+nS4oXL3G30TxHfgFHyk/Yy
 MQn6nK9Hw8ckctr4a0IttIupiyJNav0I2WtjWhN/dW4ypSoAJyjlwseQb37rGfie66Op
 AO+3LSAHL3/HvSOAiaKxRfHENqzEJPvtuB1T68OaamUKPTpTZsqxVO7zewmu4BFfgjA+
 U4AFo1OXpznfL2ikYa/Deads5gkepMJDcP2d59v3P328pmgfihN7878qjHp1360el7C3
 Axqn5M+RZ12151pxwBsE0xNUjkYO/NPCSz8JJ3FOCkEnyhyfFEA+i2TLSbO06lu8lenc
 7Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214659; x=1730819459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIn8TWQshR4xk0eH6ep1S0A+hm2DkFGROZexRTXqVg4=;
 b=AllDJ76lywmQSyl2D9Co0FyU3qDZqC7vX6VfLtxdlY74XM/swFGlY4b8c1EfjT0Q8Z
 pSCuBpnB1E92/TF3jweWcGTsvppf2iJItfgibpcdLyS8n6vddxJueHLr8EaBjUb7+v5A
 nt6EZXOz80xMcHKxfh/kxhgqPVsHexWOObuOF8Qg1pW+hb0yZtvXeB5COigLZNoenL81
 cFhJTqmbxVtgTZ7Z0A4ULHv1jcy9PbVLyMVMgfxv3qM1lTcCdJKq/Jm9cE4zaIhAoks+
 5biCj7Pi8Ew76tVBwPYzkcdlwi8eioQ3h0T83krzKdbF1Mhl9bq61o4ImjiR+UIY3Nnv
 7fdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKmCGwEdwxgftYQ/KzXXb5y6HBWgOUK4tLAy7kESrLRw369sHu3GRHrhMAwCKfMTmhI+fLX9UPKjEC@nongnu.org
X-Gm-Message-State: AOJu0YzY21Jf/VxYhpbqF4QlcY/284X5VGddNQpNsy8XHtg2T/BsTZAc
 ANDYzjTTmSb3jvzxNS/mysd33ZwnYnNSO1xvC89j4E/sXadbwJlxAVTF7mzD8Yg=
X-Google-Smtp-Source: AGHT+IH/iU/ZQm3dWa9FBVK1hQmkAqHmFea1NQGXfCibzteKAJ8OXTV6pb4SWfnM6/iSZc5j4Sa3sw==
X-Received: by 2002:adf:ea52:0:b0:374:b6e4:16a7 with SMTP id
 ffacd0b85a97d-38159d6e341mr2167784f8f.8.1730214658615; 
 Tue, 29 Oct 2024 08:10:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 17/18] docs/devel/reset: Fix minor grammatical error
Date: Tue, 29 Oct 2024 15:10:47 +0000
Message-Id: <20241029151048.1047247-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Fix a minor grammatical error in the reset documentation:
a couple of missing words and a singular/plural swap.

Signed-off-by: Axel Heider <axel.heider@codasip.com>
Message-id: 173006362760.28451.11319467059840843945-1@git.sr.ht
[PMM: squashed two patches into one, tweaked commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/reset.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 74c7c0171ad..adefd59ef97 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -286,8 +286,8 @@ every reset child of the given resettable object. All children must be
 resettable too. Additional parameters (a reset type and an opaque pointer) must
 be passed to the callback too.
 
-In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located
-``DeviceState`` and ``BusState`` structure. ``child_foreach()`` is implemented
+In ``DeviceClass`` and ``BusClass`` the ``ResettableState`` is located in the
+``DeviceState`` and ``BusState`` structures. ``child_foreach()`` is implemented
 to follow the bus hierarchy; for a bus, it calls the function on every child
 device; for a device, it calls the function on every bus child. When we reset
 the main system bus, we reset the whole machine bus tree.
-- 
2.34.1


