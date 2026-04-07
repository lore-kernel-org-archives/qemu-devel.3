Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB05FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABQo-0002b7-UE; Tue, 07 Apr 2026 14:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wABQm-0002LR-U1
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAAda-0000eO-Py
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 13:54:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso1709215e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775584493; x=1776189293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j+V5/wr6hJYCNRYt/6OeCVTMAVFIsehdIhZ+xeB+P7M=;
 b=ai0jpHnNwE1D0Jv9fIHLmaxiG0Z4D2mMETrBhW5ogDThiXlWkOiCL7uoXBKpgWhujy
 3w+UksqhWf99fqsXl3zJuyfTHhHxzni6CnwFGAabNbll8aDmniPERG9erUHjjwes0BIp
 qguqzxf5N9xXX2zbe9I0viwSAErJUzNsYhhuh+i69XMn48DQjAh5Uin/Xtiynxax7jkx
 XpLY0/tr+wYz0mHruDFKfaY74/9A2ylU6mBceg+2wse8cTxRuirrD+/QNnIl+CmOKJ5I
 W+7yMhUwYgcDFTqFgjeJGfoJxBVdMqDO2VxGfQ1aJ8x9DS3QDKCKvzmxFOUvmIsiuMyg
 q/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775584493; x=1776189293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j+V5/wr6hJYCNRYt/6OeCVTMAVFIsehdIhZ+xeB+P7M=;
 b=Rjhpc+3vbS054k6hDzk87xG0qzFbz3EQ2ANF+Z3R6gjHIemDzMcmz79fWotHxtOjHH
 ellWgVHnFvrV4/XW4q3FKb/zZ9OyjoL0xIgNCumKn8RRHAIEkgoevMzDzcjAvIu2v6E9
 YTJvhPgnZ4AnDDEFghx/e0R7BrjOUDrp1Ny4gajh65G1AgawjM+Z05WPg9n/xnd11Eek
 EGwK+r0EGr3fV2IvGfyCQjrY5hDOtwdP1drO81lunpaf2shjJEcN66F56CPkFmDmGild
 3z/EA7xFMhXauk2Uq8tPIOBIlsGeq+ncs8CD/SIQRz9yYxDjZTmZCkaQEZukQxOwy1lz
 QCeg==
X-Gm-Message-State: AOJu0YxRwbJzP5wNOkjywZO3jnr0q/Oq0lnY0ggAUG9wgI1bLliHc7uW
 E2JqoBQXW23TvvcP0mSeXOOTf11rhKcB2AC7DGYNGXN2hWK1ouTBtd8irMu2YbqlI258yjHoFZI
 CcnRxbps=
X-Gm-Gg: AeBDieuoxF7ykBrKUPRYpabW4QWgYRcer0dJ1ejv+ElAW8ksG7WrtKbZP3v0s3oesvn
 OQ2PRS9yr9kvDC2rKsvMBdHhf/NKcfs3ys9c1w4Zv3FyHCf2XKJzufnpzmvWcCHwdFc7zo1jIMD
 PlPv9Vl2DpRhPErBrlQgRxYzDlPpCxS0q8eIezWAS6L/R7/o2RR/Lk/SkdZhrczEKZ0NZU/TNFT
 WKktw0BEJENjxv2xo/lBso5YjdEwgmzNGZ52nIJKLUoJdCY9QKOGsyOvrVNNdzlveNW/qLWpw9C
 ckRKZDqtYSNim+/AAf6P3E54eBTxM39KOn1fyrC0TafGeqBcmO5Qlcmf66G53H1dqX4K2URbUnC
 qKm+FRmD+83c3IaYeBLGhUWlGSwDTTCavQz2GfQ4+BtyWKTAv0JoLqdbqlIDbfSw0FYaDbOEeMC
 GX1da/+XdEM3cnzdCkhz942ZnOFR7z+HiiVBD5J3kB/En1znspTkU28ei+fbeSGCDRqCGyoABHc
 jnSDSy+SQLxKLXbFIetMD1C/SpMTsw=
X-Received: by 2002:a05:600c:3404:b0:488:9c3b:ff40 with SMTP id
 5b1f17b1804b1-4889c3c0127mr118895975e9.15.1775584493149; 
 Tue, 07 Apr 2026 10:54:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488c5308b3esm1615525e9.1.2026.04.07.10.54.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 10:54:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] docs/system: remove extraneous sentence
Date: Tue,  7 Apr 2026 18:54:48 +0100
Message-ID: <20260407175448.3329196-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407175448.3329196-1-peter.maydell@linaro.org>
References: <20260407175448.3329196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Lest we confuse the reader about something we are no longer showing in
the example.

Fixes: 132f8ec799c (target/arm: change default pauth algorithm to impdef)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260406165648.997995-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/introduction.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index be387a6645..bec7291e47 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -165,10 +165,8 @@ names so we can override the defaults later.
     -m 4096 \
 
 We then define the 4 vCPUs using the ``max`` option which gives us all
-the Arm features QEMU is capable of emulating. We enable a more
-emulation friendly implementation of Arm's pointer authentication
-algorithm. We explicitly specify TCG acceleration even though QEMU
-would default to it anyway.
+the Arm features QEMU is capable of emulating. We explicitly specify
+TCG acceleration even though QEMU would default to it anyway.
 
 .. code::
 
-- 
2.43.0


