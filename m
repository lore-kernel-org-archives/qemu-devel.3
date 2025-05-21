Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED5EC54ED0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXD-0000Yu-EQ; Wed, 21 May 2025 12:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX8-0000Vd-6q
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:10 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWz-0006AB-Gk
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad52dfe06ceso602158466b.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845779; x=1748450579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Zy7bHoTjVWIOBbr2AD55ceZ3kB03o6gn1A+C8POtkw=;
 b=OA4faqZaKcNIDjzY7RPVS7yStyhZY/OX1pS5g1II9SiDNVJM/Cy57EDrVj90tZpVuW
 56alPqkTSMt1rc42DyFB3asJTGuftLr0/yHyQpL1gleSDFsO6pJ1qOyTt0dNwhZ+xF26
 T9as1XL9LoH0f4aH5X06dKdXSwWMAJTG7r4OVvmPaQ2JJaSTIzsbVIZk3mWIQ4mNTw2b
 wwzpr8cMGtAbMyWbCQyqWiLR8pycLg8DEnkeHj0r2/RUcdCoaXUz/mcqgjXImmEG7kZj
 z7MrAO2CRdlqJcLSr+ApLz0Se8BXW8cD4HRtoQBQ7d1AcMedkaMZH/Mer13HdKiXJTXJ
 NnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845779; x=1748450579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Zy7bHoTjVWIOBbr2AD55ceZ3kB03o6gn1A+C8POtkw=;
 b=TgtOWl/iG0OgH8I4V9MwgTOOdHNINRR1TvCNWkG2O9t2qG1ApYqEsZcMIas/zQoglH
 PQm/G98ys3QL0ZJX6GTZkUS5ATnJEcMQgTwMpiS//XuU4iZHDjCipCgTC7JOCuJ530NO
 1hWQsGdrNx3mtV/8+E/qczPVKHdu0bCajXofbsZDTV064mDCxeEy22ptvW1mY4ZRxfEF
 3rZpSV7wU9y7bhvQhNSX6DmR6IOFfDpa9CEQ5mtVXIU7hqWxH7/ncun/WmdbVm+DQvsS
 cLPrKox0/j89Pede7itoYBXUQY//v6wzWPvD+gaUTnKgwN5OGnbXwRDt0o5Az7Ca2NZA
 dQEg==
X-Gm-Message-State: AOJu0Yx//iGP4jpUQfA5JgPmvAd2GcitL3dLt7/x/vflqbkG6996KbhN
 bYj65kQyaXoE436lMKQCgmZWxVfr8cGQpbWPcyQ2wlIjkJlPE2/uqB9CbDpWo4WFb2w=
X-Gm-Gg: ASbGncurMyvjpQ6mmqkIXtRB6tlfhJenlsGwr6w/7zLt9dXHBTv0KArHcuU1XPoepW7
 PTLNeTCju+ENDsxqICKbqKD2VJgb2eHEexJ5Xk+fKO59m1jnaJgQ5mG1WhZhwT3B8y22TPzmzaz
 vtGzXEFf/trEHgR0v3rsPfnWC9rJnKmzRGMQU88iSbfol4GfGLQ8FWMmtHEDsJ3DtAaGobZitVD
 CXknT7eqeTkTgRVE1GVZirxA7Dw2VvzaDfz44kc/4UjgxJxcb0LMuE43xENVm7c8rRQPHClxOGM
 dvwRdIuyraeAPXZTxOBdILXsUCt+lwoHExklWcrgLOi5zzsvWDAk
X-Google-Smtp-Source: AGHT+IHcBtHLzIOe7hDg/2xuDzEZUC/72t/OIPIUfEQyz8eUI6SPuMREiwS2yhxtxRI3nrBcCXsz9A==
X-Received: by 2002:a17:906:6a19:b0:ad4:d069:324a with SMTP id
 a640c23a62f3a-ad52d26e41dmr1761043666b.0.1747845779079; 
 Wed, 21 May 2025 09:42:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d278290sm919281166b.78.2025.05.21.09.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 906E55F9EC;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 05/20] tests/Makefile: include test-plugins in per-arch
 build deps
Date: Wed, 21 May 2025 17:42:35 +0100
Message-Id: <20250521164250.135776-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The user can run a subset of the tcg tests directly, e.g.:

  make run-tcg-tests-hexagon-linux-user

but in this case we fail if there has not been a full build to ensure
all the test-plugins are there. Fix the dependency to ensure we always
will build them before running tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 23fb722d42..7f7f62cbf6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -46,7 +46,7 @@ $(foreach TARGET,$(TCG_TESTS_TARGETS), \
         $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
 
 .PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
-$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
+$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak test-plugins
 	$(call quiet-command, \
             $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
         "BUILD","$* guest-tests")
-- 
2.39.5


