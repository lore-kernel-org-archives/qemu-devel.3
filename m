Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448E0C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPO-00083C-RM; Tue, 03 Jun 2025 07:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPH-0007vV-OI
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:13 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPE-00029y-J6
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:11 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-604e2a2f200so10600476a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948527; x=1749553327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZTP38b1AWptwD4sVw7xjWUpbGhEyHUBDnJO6tIxuSQ=;
 b=pLxV3GQpROR9w4qIiw/0C6OfnH16FSmKk2LQZQKMQyXjp75gGLluB8j+hoaA+Cu0AX
 6Z3oVYg5+vyVmuK54C5/TuOUr6A1AQZ6TX7rxyk/CjXKDYYFKzDf1IdQ1hHmRGzjiIpo
 lEoMcPaQLQ9J78a2Eva5ZoECWzT9Qz50dMmsW86x/IBwwd06ooYBSaXvkrFb+ahSrYNB
 AAM1YA/ZWyaGIcDhu9BgIDrHqcBcxOYoihYOmZ4/MmVSh5PJUBF6lTJKE48mAEGVKfiS
 wqHk9/qTEYqk93Xpdzb8FLH4y9GObkwaX9LeJ86pcsVZhti++Fwf54b5WUpLxXJFCYuJ
 uHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948527; x=1749553327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZTP38b1AWptwD4sVw7xjWUpbGhEyHUBDnJO6tIxuSQ=;
 b=qjUz4CiNdhgLHjK4oxWJUPDrU0f9y2nXK3+KH6xwkHRBee49myHFutHanj0Osie+Rc
 ys3OzWt14qbzE11LQNeCb0FXjGevrXKkTmdR95Pn1tMnck8Cyc+IoArp5/Q0XX21MEZM
 khfONe8yRaKfkA6qs0ylcIHkh+MixCATxfRTHPNvxD1ks6+9MeI18RGgH77r1Y2z6i3g
 YjfNLdFyRVFcUpHw6EX5F2JkF0gtg9HBrfw5LAWLMH703AWu7q7WIv1KeG9KkGQVBD3Z
 hoB5z6cjl9wkeXSHusDIDNCE0VVp4ZnbkoI+lSB67yXdhF/DKThAz2QYeIgT+cSnBdWl
 5VKw==
X-Gm-Message-State: AOJu0YyCk+GYogDUiJnOHj9iTglHFX5nAjSA0GQZHLBpcTpRra5KqBt5
 x9rCqPpTegD4JdCUTI7eF1ttWxEpZWHYfehaSjLCYRnr+mOk0DuM9FuMbG3nVdhQo4Q=
X-Gm-Gg: ASbGncvA2ArShqOnsyqbDVZ3zHvykQawtM1wInQiS2YWDbk8Oqx10vbE8iSbXGGS0RF
 SyB9Tav6UR/WfLh0SP0Msfxu/hpX6qv3qjyixIG0GGsx0MlgzGQL14KhT1FMexJwoMuDGodFMti
 QwapeiVGxtmqWLdHEvnjkVQmUgll6JdOuVaMVjLoc/0P11+x6y+3S1fZW5jcPwxkV5XesPbs8l2
 ixLzJagR1XVrs2S1y7tO9VgUZatAMm5h7RMUF5MYch60k6rVEgeWl/jvq0Q1vRch9Poc46sqqFn
 rg06UZINlrD7yY4BwsDmWDmtu29wWbYBKrQ04ouHcL+Xq48ejdXCLwo+/pF3Xlo=
X-Google-Smtp-Source: AGHT+IGIbhG+GAjx8nOIhVVBwRcqHT5lptMJcPq9DI+dJqckilH7HWrRj+B1WhGc/ghsaWLd8c5L1A==
X-Received: by 2002:a05:6402:5205:b0:604:abcd:b176 with SMTP id
 4fb4d7f45d1cf-605b793e26emr11879813a12.25.1748948526720; 
 Tue, 03 Jun 2025 04:02:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-606b128c0acsm826516a12.1.2025.06.03.04.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F9D85F9CD;
 Tue, 03 Jun 2025 12:02:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 02/17] gitlab: disable debug info on CI builds
Date: Tue,  3 Jun 2025 12:01:49 +0100
Message-ID: <20250603110204.838117-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 1 +
 1 file changed, 1 insertion(+)

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


