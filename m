Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A54C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAwT-0004mV-Mn; Fri, 28 Jun 2024 08:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwS-0004mB-Hv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:04 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwQ-0005ej-RK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:04 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d1d45ba34so761479a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578581; x=1720183381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=896nhI4YHOq1vJSOrCodsrbn34tjrTqeFeUAOFAZbLo=;
 b=NUmOoihGwvMDtbpkJ6Wluu8fUtMdcmx2LxyEfiCpITnybtExwf+TAy5kk3kPq/cOF4
 MQiq1CruMPOaAXajXS60mIf5GAuMVlOphoe0Oj4D84Xq5YzOoP0qvO0JgMNjAm9c8ngg
 ATHz4qjSf3PngC/fPxvMnN+meDhZimfBoNqZXIzn5nB7wXhcjjDIdj7lbU8LBz2Dbteh
 BC8/KSsryBVUaYtIcVFK/e5T7/EdIOKTLNQhjzaoP/FeYE0UqSWxwdHQfFA//LAbeInZ
 w0K2927bBx3wmNc39KUnidCY0EG2r3UbMny6BHAPGYLopombZZQZ8H2S+teINHXZDW+d
 dLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578581; x=1720183381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=896nhI4YHOq1vJSOrCodsrbn34tjrTqeFeUAOFAZbLo=;
 b=VWKKckyUb2clm3jmfWdJn1mzWDFglQuvOR7MF+wfxAWRAza2V95+55pNxgFizndsPI
 GgXHjTNJUE5pKN3WMT/V0i0ltTVoJjYnR7fLVPTZ3tAZ8h4xon50wUTmF2ekBO7g5WK1
 Ttbu53tIOo5TdRW90TIStB4mzLj2sXASqMyg/4DAWR1vQz3kdsMCDgwNJ5HyJVWkjIGk
 fnYLQmt9/c8CH5gQMYyiHD0bex2NTeQK88d/EBiref03S1seGCyf1jAj3ovL1mcYlVmE
 xTEa4mRv4GjwZEAji7keFI3Pb0o5uFcwYsBkwbUhGISHwljdjVpFFP18XfNkQE3EDUqL
 vwgg==
X-Gm-Message-State: AOJu0YzqXeJ7ZOGflA7eO+LQOm/s8vaAmytH6kJomD6wdxV3PppA5zly
 KwDOqzhFDl4gg/osA1RMAQXNfK+P/bH9rEWqWR+hjKqnMMdNYirYm5JRKALVQPA=
X-Google-Smtp-Source: AGHT+IGtP9VjO3Aq3HA9bPMyEV9olo6yxLzW3r16rkqlIU/FqowM4XslRzFKoddNNniPIByRm6xCSQ==
X-Received: by 2002:a05:6402:26c5:b0:582:5195:3a75 with SMTP id
 4fb4d7f45d1cf-58251957824mr10014980a12.39.1719578580690; 
 Fri, 28 Jun 2024 05:43:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-586138164a2sm985159a12.51.2024.06.28.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:42:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 158F75F929;
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
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 01/23] tests/lcitool: fix debian-i686-cross toolchain prefix
Date: Fri, 28 Jun 2024 13:42:36 +0100
Message-Id: <20240628124258.832466-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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


