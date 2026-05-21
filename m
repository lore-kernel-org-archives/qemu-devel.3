Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA4CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3I5-0004Nx-N3; Thu, 21 May 2026 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hk-00045r-L2
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:02 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hg-0008Tp-Ql
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so6667535e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369468; x=1779974268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffNTZsOoJb72T97S2Idm/k/at+IhxpF2B8d702ojQE4=;
 b=hpvaZe8tyRHs196TrERg5V38mbYenLQ7fA3pnqJ8NyB5r7UHh5EIqo4ynXhRua8Gx0
 Gtw14y/o+BevuPj+cABTe7hca40nAVXoM76boeAU9uWIPD7ja/R+K6Cag3Fv3OHctCz8
 U1iQIhg4iu3zSL9HvyTnxnS5bVTmK+yw4+rGHass8lOOtHWr6tf64hw6VuX9sGrJnPlK
 0DQPLiZ66IOnsiyENJFYpoBOf46V5iiPWS4KfxJGlK/Q6q3Qf3EV0o/OK7j70S+KrYHA
 IFstrlMUhld3sVI7KmIQgnM2zfbOQLB8RS8XeCtCF/n1HQ4ounlUji6+bY1FK7f7LVMM
 po7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369468; x=1779974268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ffNTZsOoJb72T97S2Idm/k/at+IhxpF2B8d702ojQE4=;
 b=VQ/haAeKWSmu54BGtrXVWsX343ak/ot/iFCMi7VC73HTzsV69xGJdKlxCsEIEfts5V
 +7N0gd23I3/lnPq/Ly+RuA7YxAgoZrEZngXfefdqdsx8L+5zNxdsoFYzN9UhUgd0mf5f
 smxWAPqqkmMv8DHFjt/3ZBXLAOQq+3QDdm6AmJO/EeA16OZ6o9+9vF+TpjOgo2uicTfg
 XundCN41akJk+WJCteWqCqG4bBPzzT5bibBtCkxLMnAbJTVrWYj3Wfnp0hxmEqkREC4E
 i1OyIAzggch48nZZcjVCOGiYZY6WNNcevhNYFjhe54cE0JGY4dylEg20jVm+E60XGmmP
 lH6A==
X-Gm-Message-State: AOJu0YzHrL5EGmiJyG8bJuEVnkUDMfe/J0vVgCzRJFNOTErZ1xJZw7rp
 E3C4WGRBdW7a7GCDAxcZ4z/mvktYX8/2iak1tOOdZEUYybtGeqSAg+D7i2l5OEsnVMA=
X-Gm-Gg: Acq92OE71nTH7oQ5356hUAEgfuz+qVc7JHhBdRY5zqAlJ71brCGsMVGIl5Ue2poMd+a
 NRTTrTT1dIZln5emPk+8xseaz6mkg8upEK4U/3RFTlj5dLg2QzkPT5u9GiUsilj9o3P395EzWnn
 xLAwVnYJ04mml8uek2Xs5Qjm1ELYmoHM6Mds2JLlreBHDIu1IfY24gfUdxR3NEduKFv9xx5SmZm
 EWJLCfOKV9GOq2tIvN4V1ckUvw33zeJtF2aevaWfMZKji3FrfaXkWExEUukcuwGZJEl7k9eCvhU
 fTR3oH0m8rk46r3sNyQ3dEWFMibCRNRnHG2l+QAsdUVK9K0jEkYTE4HuKW/u+KYxKvTfLlfdv9V
 NWiUfQMeS8ufQhIRylFgZk/rZzRCwEP0yhIxPwd4LN1Cikpaihnlkoe8HAyLWDzsHWlp26DaK5s
 jd1pNcPWI8Ydhktc4JhzecOiU=
X-Received: by 2002:a05:600c:c086:b0:48f:e230:c3fb with SMTP id
 5b1f17b1804b1-490360dfc18mr33017965e9.33.1779369468280; 
 Thu, 21 May 2026 06:17:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035adf173sm23145475e9.0.2026.05.21.06.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 36CBF60570;
 Thu, 21 May 2026 14:17:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 10/16] MAINTAINERS: Fix
 docker/dockerfiles/debian-hexagon-cross.docker path
Date: Thu, 21 May 2026 14:17:32 +0100
Message-ID: <20260521131739.540157-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fixes: afbdf0a44ea ("docker: Add Hexagon image")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b61a23893a..5fadf2cfcc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -257,7 +257,7 @@ F: linux-user/hexagon/
 F: tests/tcg/hexagon/
 F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
-F: docker/dockerfiles/debian-hexagon-cross.docker
+F: tests/docker/dockerfiles/debian-hexagon-cross.docker
 F: gdbstub/gdb-xml/hexagon*.xml
 T: git https://github.com/quic/qemu.git hex-next
 
-- 
2.47.3


