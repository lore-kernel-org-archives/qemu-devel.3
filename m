Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752B0CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Im-0002kp-Jp; Tue, 07 Oct 2025 07:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IE-0002WG-QV
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I6-0001JA-KX
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e52279279so41390845e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838131; x=1760442931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDCwQK3HllcZn/oLXm7cm4a9yrjhRqqLzaYppWTL0io=;
 b=X9MjW5810zkdy3cL5Bx5LK+fqEleuM6wSJYNFa7Z3QAw+laF6B30h5M1JrtH09qVRA
 rBsEtAIF67CKsnBqhJedjAFhz0c783giwV7HWnBgol5/QtN8ySN38V+oFaK2ypNvxPr9
 /l9Ze2ueiQk0sYhCqe+ou2aKKcNjVSVE58frRaBq2SECGeE1Cyk9OORam6GdTjaNljPe
 vAssQTMSPxLJ+5Hz44G9yTW57Vp4oiuhYCI9mG/aQhq2h5J/j4JbOWYlsBIOMoGGsa/T
 N4fCOF+bJLy1e/f4y3jz//n1pQoOcrEyuNNo76l89dEGjOoy7arPH79egblnvD6l7SsU
 eeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838131; x=1760442931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDCwQK3HllcZn/oLXm7cm4a9yrjhRqqLzaYppWTL0io=;
 b=PKb1YH2bAzIgwWCwbu8Buh+p8Ia/hy6/OCs6eXg3ylzi9q34N/Dod9o+Nb0M+ftK3N
 ko3qNeKKXqZvf95iqgfQexZkxxCRVfLCQFpvGK9mLZJeHCbKXS2EMnzhkA3zgcD/Umxi
 wVLEADQyUlDXtZf3MvngoJOyLy4FoiXMfArpGBjeVv8KoYso9v8vkCcXqQ/EQooanfVz
 ddvnxQq05Vceb/Rz/32biMON8iGhe+1OwJbmuNuTAQko5sfrJWic2JwDJVaHYTVvevc+
 MD8R+grtF+FT5Xtg0c4xlifZJ8iXw3dPo8eO4GmppgQY/iRizrhK9K8WPnSApx10UY/o
 lEYA==
X-Gm-Message-State: AOJu0YzjOZ9cCvAP/m8a5A8tVUULhCGwbJ5jLDe9dlgM9nRqD9ukZkqM
 xnkNAoavdlUlpNCLmVEBN2+SOWUSib9+/nyt6gVR9rqsYcM54fykYDFhJg+U5j1Vy7LmtScvK41
 Yt0cs
X-Gm-Gg: ASbGncuzk93ueZtopGdbI7GNMnZVlu2Pjc0irOW9bkfSDm0dz4nf4s6Qwr0ZfGhSNjI
 D8QKq6GzUIv6abP0i0h4KaGK308SvxN6UURf0wG+XZikCIOmo7ZihD/YpwnrjrN065jxFL+e6rb
 FNMl1vyMU3FZkUAX7WKiZJKxMEzwY9/QS+vgcDkBis0yxEMMPxY6O9A5ThwZRB3gXDu8GDAZeZD
 C4bGQFGNft4XkShgMBqx1uKEAkV7G3NI3u5ACcZsIFSN/lBprXRbD4uP6t5bvTbSh2eFO4Amkqq
 +fYBIQ+3K1DZZ6cPbz9qUGeonPT0Est9Cf6VVkELYy5uBk7faJxWLV6dgPsGr2aUJYCyIqsHgNj
 O/7f0edQhPoSSnEYqOYoiqJqf949uxF+M4KNqjNWlyxkZSG8SStU=
X-Google-Smtp-Source: AGHT+IGRxgHhgLZgBgOzMEuVoMQ9RMwYuZykkw2XfkIJgIGUONJPOsaO2Po66uM0aZbUUbbGX606Jw==
X-Received: by 2002:a05:600c:4746:b0:46e:506b:20c9 with SMTP id
 5b1f17b1804b1-46e71109f22mr113233555e9.12.1759838131307; 
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723614c9sm199491695e9.14.2025.10.07.04.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 535125FB06;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/17] tests/lcitool: drop 64 bit guests from i686 cross build
Date: Tue,  7 Oct 2025 12:55:12 +0100
Message-ID: <20251007115525.1998643-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

With only TCG available we can't support 64 bit guests on a 32 bit
host.

Fixes: 5c27baf9519 (docs/about/deprecated: Deprecate 32-bit x86 hosts for system emulation)
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20251001170947.2769296-5-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 4e8b3a8293d..2998764065f 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -178,7 +178,7 @@ ENV ABI "i686-linux-gnu"
 ENV MESON_OPTS "--cross-file=i686-linux-gnu"
 ENV RUST_TARGET "i686-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
-ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
+ENV DEF_TARGET_LIST i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 645959318a3..185a47cebe6 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -216,8 +216,6 @@ try:
     generate_dockerfile("debian-i686-cross", "debian-13",
                         cross="i686",
                         trailer=cross_build("i686-linux-gnu-",
-                                            "x86_64-softmmu,"
-                                            "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
     # mips no longer supported in debian-13
-- 
2.47.3


