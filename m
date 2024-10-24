Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694ECCDDE6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ua2-0001DS-6k; Thu, 24 Oct 2024 05:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZl-000194-OF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:18 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZi-0003oN-Au
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:17 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so111800266b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763773; x=1730368573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XK/zHX8qgXptgXry27/12QWgnPSEzecfyqvscRlng8I=;
 b=Uk8IoZjWBQqffroCcYl7dTuvjJc99N1C+USThumofJ7AUSSdA9ucF5RQIJ5GdpjPgH
 Z0xs5dwOu70SgUuaZF1fDmilPqaZO0qjHhWDJA03Bu+jCadso+QmVBsMdeZ4U37HHxI6
 UAA5DnNyY0UvArdqyj9xq07tXNtqWiGwbPbR39KvR3IDWXlHMoATeGnvPPs58o8DBwYs
 DYNR1//L5DkWW5/YTEkc4GUxj4Y0tRhfZo4Ez2vvbsJHAUvyIh2jm/HflBoiSsxV0UmD
 JzI4hbzaCwwS7mbU97hFazPaIipn4f5mXBvaKgwcnXddf4sG120GT1FPngXwu4P6k9ao
 B59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763773; x=1730368573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XK/zHX8qgXptgXry27/12QWgnPSEzecfyqvscRlng8I=;
 b=nJLr/iwKVI3jNtQzv7DFov7KCOGeUXX0mYGedo+O8wWOvmG3x6WNgHkglyusoUTCTx
 Yhd4D+FeYXZ52q78rw75pYcKssmVTYDrsRcs4vr+9bwchi+xJQCDYhvXFJScc+sCp44c
 dqYgxiUnwF3ABBOyBVZD2iLsWaoexAbJuxd7lHq0UCoN6WH6hZiMcnynEY8M4hbxYDJ4
 9mgN3D6Giz0yBiy6WzIbs6l6OwCTLQQMrH4NBZlruwsTSG4LKHE3bNGf7+1jZSoLqPKF
 hOcdvftcEMH5jsdiE9jVBAc/hcDSdzCLWt0WtxUp3RCty+yXoOFBw6tKGrj1pa7Dojki
 D6+A==
X-Gm-Message-State: AOJu0YyyjZ9l5aHWDhLBtX9c2l0gvZLudN1ZFxsUIMICWWEEJlTg3Kx5
 KnKoKtf0AZ4z1E7wabjAs8e+2sXxIXIHeH6w06LNBwqdAVcdu2GPGmQPqqNANLA=
X-Google-Smtp-Source: AGHT+IEOyQePChGWLvPydUo9luKyniLHTcp118GzZqLsR/2s04p0bWt/3Zyp/9H6Df53O9jmGDr9mg==
X-Received: by 2002:a17:907:9405:b0:a99:ee42:1f38 with SMTP id
 a640c23a62f3a-a9abf8aefbdmr501541866b.31.1729763772859; 
 Thu, 24 Oct 2024 02:56:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d623fsm594030066b.9.2024.10.24.02.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC4E75F9D0;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 09/17] dockerfiles: fix default targets for
 debian-loongarch-cross
Date: Thu, 24 Oct 2024 10:55:55 +0100
Message-Id: <20241024095603.1813285-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

fix system target name, and remove --disable-system (which deactivates
system target).

Found using: make docker-test-build@debian-loongarch-cross V=1

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241020213759.2168248-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-10-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 79eab5621e..538ab53490 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -43,8 +43,8 @@ RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.
 ENV PATH $PATH:/opt/cross-tools/bin
 ENV LD_LIBRARY_PATH /opt/cross-tools/lib:/opt/cross-tools/loongarch64-unknown-linux-gnu/lib:$LD_LIBRARY_PATH
 
-ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
-ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch-softmmu
+ENV QEMU_CONFIGURE_OPTS --disable-docs --disable-tools
+ENV DEF_TARGET_LIST loongarch64-linux-user,loongarch64-softmmu
 ENV MAKE /usr/bin/make
 
 # As a final step configure the user (if env is defined)
-- 
2.39.5


