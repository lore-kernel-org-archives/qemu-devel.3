Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50322C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQh-0006yI-L2; Thu, 05 Jun 2025 12:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQf-0006xi-7x
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:26:57 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQc-0007va-Py
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:26:56 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-602c3f113bbso2218335a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140813; x=1749745613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTYdr84tCNHvOUWyneCXSwfyApd3PWJITaMticHbWrg=;
 b=SuBc+Xr5v7RwYrJU5FgZsYvHbHl6bKwJyPRWtMC8h6+CPx3N/+9AGSRAE8RXpwfmpa
 TNoK087NLfCNW5fGzqOLEAsYSxF5XOzkeKcz2NrgSYH2h7kN/jnrftwC6nplKFN0QRxV
 5TTlGLe4EgjpTdqawbEv/G+vKNd6X1dIyf4GjCOGeo0nltfPkDEW9aVo+X08Wu12Uff3
 ouu2hlG0KRjEKMUytsrDwTpePDiJx7vDDgNe5INnGXtirskbyac+e9cyHQcafBYGebun
 15Kx/ylSOnZwAsLewFmeSroPUjcdoUpDsftujOscqF5XsAHTzswCm9QfBnRTXwk5st1S
 Qe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140813; x=1749745613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTYdr84tCNHvOUWyneCXSwfyApd3PWJITaMticHbWrg=;
 b=r0YSF4+KEmjDj42YjjF9QFVMhKvhf30McJsLpWsPRJRtOfwPZ5NX6Q3dvHv4tQzKux
 BtNOIauByhYF+IkfvptcyUivD9g8j8q1hOqNN5V1+Lbps/b5CRq7Wo9btMV8KJcfb30A
 +YP6Lsp/VBeVQgmLxtsASW5XyzmIc8uN3iMt1aFLthsSwPwHRsdE6FCSUkSjJn+I+3X9
 CrgW23K5sL+H4qNS6QJHZvRv3eSnvqxuF/z4cgnDV5TqugfvmRG4rQ8DMc0iVUljYzlC
 hawsguCfUIIGciE6N0VPWuvNSTzYgdOtqkrrVky5C1aZVaWe7Z+998TsyeodrrMwlY3N
 GPYQ==
X-Gm-Message-State: AOJu0YzQcvOoUcjNEg+eMOP/uPW3IhoSu4jJlku0fWmeQrPFQVoywXzZ
 4r0TiI0wRMzKFkeEwi7m8k/GmFFR713oYYDgCTR7aN/X+LShOV7H5DLAbnghfk4sgx8=
X-Gm-Gg: ASbGncvLqu/5lKC0u0thsui5XD8oXHitxFXVobJFPfhu+sNItxwWDqgazlKmD4K/0yl
 zYvI+djbIdYPdyvWQwS9kxLhwoeUbY57VfwTsUbpieHInmz493VZEIr6I6qv9OUpMMazq4CVpbX
 njDf0gcPpvMNRrAFqbTc9llUe9/57V8jxh+J2+X2Eoh2nfbTtLDviAdjW+IZrDz4/KqaHEpxkrM
 kSP9lt0t7sD3H1fx2PVgwErtnjwBxCdbT3Gb8lzOV17TOEbBFzh7O6WmNJf4E3CRBkRQrCXQkDW
 o2lGqR54doswWWyREVlCW4aKthcjSBJrQec0UP9V6tg5YMEJroby
X-Google-Smtp-Source: AGHT+IG5WnS4EbOfReGCr9m6OtbvYlqRPi79cA1Br+0T6AM/hWq/Lta/zaTbDwK7YhsGRgqMPkt1GA==
X-Received: by 2002:a17:907:5c1:b0:ad8:89f8:3f51 with SMTP id
 a640c23a62f3a-addf8c9b571mr642591166b.6.1749140813184; 
 Thu, 05 Jun 2025 09:26:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d84f2dfsm1272659766b.78.2025.06.05.09.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 87CA65F7F4;
 Thu, 05 Jun 2025 17:26:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/17] gitlab: disable debug info on CI builds
Date: Thu,  5 Jun 2025 17:26:35 +0100
Message-ID: <20250605162651.2614401-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Our default build enables debug info which adds hugely to the size of
the builds as well as the size of cached objects. Disable debug info
across the board to save space and reduce pressure on the CI system.
We still have a number of builds which explicitly enable debug and
related extra asserts like --enable-debug-tcg.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-3-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 118371e377..19663126ca 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -24,6 +24,7 @@
     - ccache --zero-stats
     - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
+          --disable-debug-info
           ${TARGETS:+--target-list="$TARGETS"}
           $CONFIGURE_ARGS ||
       { cat config.log meson-logs/meson-log.txt && exit 1; }
-- 
2.47.2


