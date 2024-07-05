Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10E5C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPktu-0005cq-Oa; Fri, 05 Jul 2024 11:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkts-0005bq-73
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:04 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktp-0000Ju-Sv
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:03 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52ea2ce7abaso1860650e87.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193458; x=1720798258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yb3iq8Uefi2wrk4lmxR12EyJjPJCI4ULXKQi9nDSkSE=;
 b=OQqyg1isdbClJoHoIs0oT5BZ+oNSIqP0HKXjRvYB3u5eHOQHxFlh9YltDwC9bHtLsd
 RjZfknKoP46HW1C53AWtM8fSHJrheCqL2BnJeuXAWEK3KYoUaXD5XVIOHf+KQdh24ir3
 kYN+WBdwlbALdrVTL29I2KTwWotQl4ppKeKCmbCYhhFUjOjBH1SiqoEyYNgO5EX/Ca+B
 evCvOqkwSabnYqmdY93F+rOsmO+ibWTFS0SB+CoqM6V/OowrardRjwfRMl7pwcNj+WAo
 bQpnD8BV7VKCYmDEzdWroL0wu5E0Pp2r/qvk7SAGume+7H5zK8v6GMmCmnE3J7/+E9rj
 ilrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193458; x=1720798258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yb3iq8Uefi2wrk4lmxR12EyJjPJCI4ULXKQi9nDSkSE=;
 b=HikECl/UDx2qa7yLrl4ld/t/PDWPddDF/zeHoSG0LguRh3R5/RAb/E8aJIWjF9vDly
 CcOhxZBiDFOdGWEuJnFnikVcXmR5XcmHkoVQw0dRr766WxWN+ZxWslrUCq7em1Fgg/wT
 SiqSjyVUYT3iYvFCGTFfsmKfS2O7OVTd6qDmFnpcpFECnGYJQ84KQ4RiK4S9F04pHHJF
 PnrNN879EfiP/W0at/pGqlb8Lkru8vNRyOP9mpqPH2xnHlvpf6OCitPmmMXmBoE/NknO
 FqmfVft/CbMNnr5sMQ9P/RLyJvUxtyHJEi/W2pu0iA7QdpW6pERk1+zqTrdZ86Eqiv0Y
 2dFg==
X-Gm-Message-State: AOJu0YzTG/CMaB2mq7BCUurDjQEYG7GYj4hK7WiE1gDGa3v6L4vzWqkZ
 yVHZpIUREyvXFQ3EZ3fg6DHbPSHyJMOCbTVYbNNuQppV/sl/3xbfVKtRUVUPXIg=
X-Google-Smtp-Source: AGHT+IHfMA9NFaJxHx6aXpr+68A520t5IjObMWRon1c2zY7oqiy+85/NpP25xu0BpNDt52ckLMFJSA==
X-Received: by 2002:ac2:4115:0:b0:52c:f3fa:86c with SMTP id
 2adb3069b0e04-52ea0629bc7mr3994185e87.18.1720193457678; 
 Fri, 05 Jul 2024 08:30:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58e9e68e110sm1929049a12.91.2024.07.05.08.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7AA925F935;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 05/40] tests/docker: Specify --userns keep-id for Podman
Date: Fri,  5 Jul 2024 16:30:17 +0100
Message-Id: <20240705153052.1219696-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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
Message-Id: <20240705084047.857176-6-alex.bennee@linaro.org>

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


