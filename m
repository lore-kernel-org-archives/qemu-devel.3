Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6B8C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeV2-0008Tp-JY; Fri, 05 Jul 2024 04:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV0-0008Q2-7L
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:40:58 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUv-0003Aj-Dw
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:40:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso2259777a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168850; x=1720773650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0F1ubdjTjfUgOjFoVtYGFPGbIziBRq1wNHSOYJr4Cqo=;
 b=T0alJLfwWI7MZDT8YXo9MU695xBz8ct2IHYZ4eQ6NGR2phNvQCWTjJrCVBmwKJbR8e
 FU+6bZIhSFclENE2ghVmSyla5qj5ZxMRO8Lk4rt6r4sNGR8DbZe/bBuRDP26JsIJFGyy
 xXeHbkNsmzOsDsiAyMEU6CFerQkueorPwq6aqVl2Ng9wwarvbhpn3rOw/uiMEkxmW3gT
 HYecYY/UbSCDSQoumE6r6Sw78txq0T58M+CtQ9oAZKXea3Kz1a5O9eKhuWX57DvZAbaV
 fLfDti3/0Jz1mnz9aFvZClVyNBbElkC7bPv/pBOFX9oQSEr50crPCpQU3KUoxiuwKO+u
 sWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168850; x=1720773650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0F1ubdjTjfUgOjFoVtYGFPGbIziBRq1wNHSOYJr4Cqo=;
 b=TTYKKh94aGYnsgnxHJFQH5Kje0Pq8GEql+Ojwjs+Px71axREGlAm8kYP3gB0e1w5FG
 T4KQrLfIMyJVKiK0WhrT8G7H2+W0SUkomWTAkocvXaux55BER/TMHjChS1/kLqEe2xJG
 ah7zh9jwxib25mXe2Xi8G9Vjp8NcMJ0uGZ4EYVh5Wk6Ihv1XW4lFeGpZQ+nUHgtGWAQx
 uOEtxbAbHE+BtXnUrMPGZyU0qCPDm3PCIXCxC8oFPublYqMTLJwJz8WbmX7UknNMZ50a
 2VwLoFEUP2tG4pZgfefoOGX4TwS5NZmDaZtn6hOx1WSE5IcG7o7CMPPPtGeCTMooP8VA
 5yxA==
X-Gm-Message-State: AOJu0YxZTrndpoCvJ3pb6xBzm1ERreO0ck0cnPQpvp+ryuxonWE/TMgm
 bU3Eld96IojbfsyWpne/zB7StKH5kE6pOk8gYLv4KpZseCvg1jpv12ArGl1DsWA=
X-Google-Smtp-Source: AGHT+IFW3Y03zwSxGnaJubf7MbKYPWgM/N2gBI0ZffN4L/lJ6xltOb1sdohV+6nFHC6coxWP2TCfpQ==
X-Received: by 2002:a05:6402:1d4e:b0:57c:5fcf:b570 with SMTP id
 4fb4d7f45d1cf-58e5aecb1d7mr2823840a12.32.1720168849351; 
 Fri, 05 Jul 2024 01:40:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58cb2b83380sm3333502a12.74.2024.07.05.01.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C44435F8AF;
 Fri,  5 Jul 2024 09:40:47 +0100 (BST)
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
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 01/40] tests/lcitool: fix debian-i686-cross toolchain prefix
Date: Fri,  5 Jul 2024 09:40:08 +0100
Message-Id: <20240705084047.857176-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

I guess we never noticed and tried to build with this cross image. Fix
the toolchain prefix so we actually build 32 bit images.

Message-Id: <20240628124258.832466-2-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-i686-cross.docker | 2 +-
 tests/lcitool/refresh                             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index f1e5b0b877..f4ef054a2e 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -169,7 +169,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
 
 ENV ABI "i686-linux-gnu"
 ENV MESON_OPTS "--cross-file=i686-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index b25e3ac4dd..ac803e34f1 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -167,7 +167,7 @@ try:
 
     generate_dockerfile("debian-i686-cross", "debian-11",
                         cross="i686",
-                        trailer=cross_build("x86_64-linux-gnu-",
+                        trailer=cross_build("i686-linux-gnu-",
                                             "x86_64-softmmu,"
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
-- 
2.39.2


