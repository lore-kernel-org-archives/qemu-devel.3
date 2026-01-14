Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B76D30CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfy4N-00079k-O5; Wed, 14 Jan 2026 05:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfy4E-00078z-5E
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:25:34 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfy4B-0003lu-TH
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:25:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so48916565e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 02:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768386326; x=1768991126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w9At/OlE9rIJSMnrDeVIsZXv7vrkN0bUdG7ikLHhNPc=;
 b=psMP1REcPBP3ADE0ronDM/WTsVd2TVZVyN4KCthLPoEuHndH4lYc6ZI9hOf9QVD84r
 LX+qXxKTONhYIIRBfuavzNEbtGJWlvlFV0DTd1AApFxpGAJpeflhJA48gCDMGOpq3ret
 uT6KpJ2zgelXtA4h0MZcRdcLGqGEnnM1WbC9hNB+FjMeoJKnmFT0mMeZSXfRwj/se+el
 9oF9HSj/c2xef2Or7V//szJczoS9WIca2DI8HopzUmkCaLFfLflJk6RGZ0ScpQHDsJUe
 Q8ILWwR3Yf3jdSblYCkYfWpGejBbFRvZtX4wQm5vZt9p+BIF3F7pqc4NlrOh0Y6c/GVv
 GsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768386326; x=1768991126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9At/OlE9rIJSMnrDeVIsZXv7vrkN0bUdG7ikLHhNPc=;
 b=UX3Md5ycdTaqW9puzRZCN4N5AvuwcXfmrUWmkSRTiKnkjyY0jkgqJY7G8aKVfNn1gp
 BwsAYCJWUWjnAnz/9C2IOJyzq3EpyEB36mjXBgtXkdIFYVa3tUrSQbBk4UO4DS5Y6n9y
 qlWV8i60ByfPZF0sGTipdS35Tbkz/cOtyzTyWxbdAAETWo1WzN8foGV7+LlMT+kfkh3K
 eqSEp/LAyM7WhHKNTI8rYODMvKuMLeKH3m2LN1U9mo76aqg7o3CpLybzU7ssep9NE7Q2
 zaJySO0qS6iXyvX59x28xuaDR28EY8hRnWuMXF8gGhzMmZVyRNY5tFKBRWAjHjJLZ1ku
 6doQ==
X-Gm-Message-State: AOJu0YzASKenX5hKjhT6ApVJbD3qi2nwgmEoQ4T038h2g7OCE8eXEhNO
 TPSZEFid55XS0OOqgG5zQxlobqhwg/Mhc/pWFH6sTtfzc2HNu4IIhT8bq/cTLgH4xRdjrQ/ziEl
 /0ijI
X-Gm-Gg: AY/fxX44ng3eDakU0kfukLY3fL+2atFNdbIPSdcIaFPfcrIl11hBursgLi6SEUab3K7
 z+VAwmlSS1XjHY1y4GdlTHgJP4lNRPm7Ejxs+80kY0nflENEUhPqX1JotH5bzjQQvMM/2E6QyRW
 +jZVKVdNRQlTHnr+jXJ4mgJRRWNLrsDI8BNnO9uWFGyup4yvOjsimMAecQ+FOcduTa0voIDUUsY
 H1IrMOcMY/jx3OwXkNdj/YPMYSJ6BdvdXFDS+Bf50MXtIDjtCNQJ18V4QOykGZQ2VUOtFJW24Yv
 9rbDxLx3p5wMlZyBjSey/yP2pwglDyb29RAHZJraR1riwA/xsII51jhmWyJlhiMEg7izJUf4ZTT
 GhOa0+bmstRO2d0IUiHvXbkgeR2NY9PIIbGflGBUkhk3AMp5I/tmqPatqmTfIsKhWrtvwyRYwA6
 4HzU/e3MLy9no=
X-Received: by 2002:a05:600d:6446:20b0:47e:e71a:e13a with SMTP id
 5b1f17b1804b1-47ee71ae39emr8337535e9.32.1768386326076; 
 Wed, 14 Jan 2026 02:25:26 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee563c8bbsm20432495e9.12.2026.01.14.02.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 02:25:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A3D875F803;
 Wed, 14 Jan 2026 10:25:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs/devel: s/most/most recent/ ``probe_target_compiler`` call
Date: Wed, 14 Jan 2026 10:25:22 +0000
Message-ID: <20260114102522.4044591-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/build-system.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 35c77343914..71331e64ac8 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -88,7 +88,7 @@ and operating systems:
   ``$target_ar``, etc. to non-empty values.
 
 ``write_target_makefile``
-  Write a Makefile fragment to stdout, exposing the result of the most
+  Write a Makefile fragment to stdout, exposing the result of the most recent
   ``probe_target_compiler`` call as the usual Make variables (``CC``,
   ``AR``, ``LD``, etc.).
 
-- 
2.47.3


