Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF61C30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAxE-0005WG-Vm; Fri, 28 Jun 2024 08:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwX-0004pm-LN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:11 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwV-0005hs-Pj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:09 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5854ac8168fso652490a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578586; x=1720183386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9Mm2xBLn8Ufe39/+67RjiS06msB6AjL659puseOu/8=;
 b=DxTjHBdWq3UAZkZ2d9bJBVPvuhFZE7dSNBgp+SNCHM5hdanRJ0F+tJFYOgeZ+3g2xR
 VIm0OpOY/wdOKgdAKampsVc+/Pab8FrYPubrinM7TkyD0FPiRmz7nzhWdWW/HIxhrMu3
 aMcZ/NfKuYIofCjUMrQ2cU15mwTF4VJ91c/bNZU8kxFAi9tSnM9opTKZRaNfIXVz7Anv
 gHsG2CqyYvImEGg75auGRSHydzMpGKP9MX1+cNbtGO8J/PCdWZWrUV6UEayA16sBxqjB
 FcBQDamJ5xYn13o6d1ukVT4NFEBsG7QlBl8S0qn0btwkHu1HfXjWhEYuPUu4CQB7y1Aj
 xG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578586; x=1720183386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9Mm2xBLn8Ufe39/+67RjiS06msB6AjL659puseOu/8=;
 b=k3VDXtVbJrlVK6WUxDO1RRspPH612UUobAMNnigbXM3llPN7L92+BTtIcQhLx8WqNm
 GkTA2kzeuhMCLN5CA+dj0ckCb/8LdI3cRM/ceznDGFY/MtmZPMyOzotEpx1FF/T6wCqN
 qSM8LMu9Yr8zXwgv2JeLgiANxsMyLydRigtErsMYHhWUTdBEBdzOAsodeH4OPymNY0IH
 oNxdFZoKw2MDbRNtWA3Omi7i7dfDQN7TqPpvQCSWeGUXuBOrTE/l0SWmJPcFfSZ5Ob0C
 ETgzuWUQIzofV2csi6hE+xDL9E+/Jk2dOWW7AKOwEmohzN82Uvl0H0IxgGE5efreaFRl
 G5Bg==
X-Gm-Message-State: AOJu0YxmaS59ueDOP7XGtf+rza5Os7jIu117P4s9ZyxQYAo44GbQPcWY
 jQDXld10eAoOW66fbIkDMpQbDsAo5EkOi/BxivhoZUcJIMj5NlencjmV00JHY3g=
X-Google-Smtp-Source: AGHT+IH79IaWV40gYP0GxuuwUjDaUjnSbw93+yXZG5vqhXyYnHEhuApFlQo01SwVkKya22wREATRnQ==
X-Received: by 2002:a50:9359:0:b0:57d:3691:baf3 with SMTP id
 4fb4d7f45d1cf-57d4bdd932fmr10904590a12.41.1719578586070; 
 Fri, 28 Jun 2024 05:43:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861324ff85sm983330a12.29.2024.06.28.05.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C1EE5F9FA;
 Fri, 28 Jun 2024 13:42:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 05/23] tests/docker: Specify --userns keep-id for Podman
Date: Fri, 28 Jun 2024 13:42:40 +0100
Message-Id: <20240628124258.832466-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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


