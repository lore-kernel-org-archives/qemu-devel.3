Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6935C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVT-0000RB-Aj; Fri, 05 Jul 2024 04:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV3-0008VH-MU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:01 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUx-0003BL-A7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:01 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f419so1968361a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168853; x=1720773653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9Mm2xBLn8Ufe39/+67RjiS06msB6AjL659puseOu/8=;
 b=z5s69qjXTsB5rWhOXDAiFMA5iNNm8R4hU9jBH7GNN9S4rfJ6JDrcu0SZfjMdMO/6/+
 52Bubn/a0KYskr4EgaPA3C0yFuYjjG9kFDWLHg6Jo9wgbLh1ecfmMYg86CTteWFUDeuC
 +mQNwP0S3aNDXMUU0g3uEFRrXDwOirayjOyYHPkEbYbarloqKlgbWiwjFmov9XS3VYBK
 TMBWDt+HtXEor/UvuDMxVMC3m8b7uqbO+TbaGe+joUIcH+z5KjZZQ7Dp2yhUCR8CiaaL
 g0Gdj9F5MjOD9x+zgWywOoTOIWLlBO278NM1cw56Rv0hsaaHHBq7EotdpuNU15B7Y/A1
 3jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168853; x=1720773653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9Mm2xBLn8Ufe39/+67RjiS06msB6AjL659puseOu/8=;
 b=ZZLMHtk+HXFcRJ/Hvu4L2o4KcNnqOCxK9doQ9ay8wAQrWP2XYujQZHNQ/qNiaMK+yT
 Jpeo6AE3FeLBsseBQS001+KAeXkOixDXB/1OTdYOA+gX0aYV4yf2T6dXYwmRq4y/gnI8
 nnSlLlbDPwV9MCyRSGXO6qDGvGp2WYH+4UQOYz6/dOCLUA0MbmDm4WEF+0AXLWeEuOgk
 HDu1X1CLYb2osCA/WaFPTwUT8CbVW13eULVnoKEQyPSxStPLSLB3dZ1RYTAZF5J3f2TW
 7ClxA3hdj9wuCCCljtB3OCZuoDu5km9n3AIURb9lz6NloqhqeY+POTKhpn6Cbg3PhqQm
 EN2A==
X-Gm-Message-State: AOJu0YzafUeij0xnqMvfqFzq9i7o33YE4RJ8OSts2ZpaRYCuKQTd4eIt
 LmYXi/KtMJXvPaMrfM4TtfGqZHp89WxP/NqAQV23Kiwc2pgqNvxR0SWLwijV5lU=
X-Google-Smtp-Source: AGHT+IGKUDoIsj/94mIK7T0FryPpL7x1ITXmVtQ0E7yFz9LAM4mZ0DQkzZv185jjvMbyAmRj0Hh3Iw==
X-Received: by 2002:a17:906:b894:b0:a6f:b9d3:343a with SMTP id
 a640c23a62f3a-a77ba72c652mr252802166b.71.1720168852406; 
 Fri, 05 Jul 2024 01:40:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a75390ca05fsm349797666b.92.2024.07.05.01.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 293065F935;
 Fri,  5 Jul 2024 09:40:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 05/40] tests/docker: Specify --userns keep-id for Podman
Date: Fri,  5 Jul 2024 09:40:12 +0100
Message-Id: <20240705084047.857176-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Previously we are always specifying -u $(UID) to match the UID in the
container with one outside. This causes a problem with rootless Podman.

Rootless Podman remaps user IDs in the container to ones controllable
for the current user outside. The -u option instructs Podman to use
a specified UID in the container but does not affect the UID remapping.
Therefore, the UID in the container can be remapped to some other UID
outside the container. This can make the access to bind-mounted volumes
fail because the remapped UID mismatches with the owner of the
directories.

Replace -u $(UID) with --userns keep-id, which fixes the UID remapping.
This change is limited to Podman because Docker does not support
--userns keep-id.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240626-podman-v1-1-f8c8daf2bb0a@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8df50a0ca0..708e3a72fb 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -207,7 +207,12 @@ docker-run: docker-qemu-src
 	$(call quiet-command,						\
 		$(RUNC) run 						\
 			--rm						\
-			$(if $(NOUSER),,-u $(UID)) 			\
+			$(if $(NOUSER),,				\
+				$(if $(filter docker,$(RUNC)),		\
+					-u $(UID),			\
+					--userns keep-id		\
+				)					\
+			) 						\
 			--security-opt seccomp=unconfined		\
 			$(if $(DEBUG),-ti,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
-- 
2.39.2


