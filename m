Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE01C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvSu-0007nP-MY; Fri, 28 Aug 2026 08:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSt-0007n9-TG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSp-0005XK-UU
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso10293585e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787919222; x=1788524022; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KTnDhGyx42lBPoLeBEOxx57vDVutvWlkR3VbWjbTnDQ=;
 b=zZ8IOrKLMbERls+M9vwGYzvwBjUYkQ9jxfOJ+sw5rURPpUhj9u1NJi0gruAi+PGmo8
 tV3LR9ZM08cFM+sRE2oZ+SpXl5GwVgYut0e2mJIHit1a+eIxZCODu6TAZw6asT7xCcl/
 5AcI9cPHPJ9reBIV+5G/8o5wCbmymGmwa3xlJK4nTeOJSt13+1g2OaUOZsSZthGUy5qA
 qYU5KWmlaWNDCoFU+YeYJ/cqvu3Mmu3Pb76N49dDPnUtZhA/vTtaZAZr0Pqw8s9WWSO0
 pp9TXmqrSUe8n2oTebDFaoJedyIQonMec+xSOWIvmT1/8zY5hK6WuuslWOL31g4ce2lJ
 dXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919222; x=1788524022;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KTnDhGyx42lBPoLeBEOxx57vDVutvWlkR3VbWjbTnDQ=;
 b=YOdplRqCOM4gSISZz5A8Vy76CI5vqiXtN1KeTEWPF7oHvngFV3MAbqFHgoAZF5DR8h
 i8zw70gOd98uUsYi1uEC3rGSPI5ptHvN11jlE8SmftLLrGqvB1qvIVtWSt7tsc78ZmAJ
 F8T8eIdXIWaAVHtFZdPBwOSyJ6e1CHpxvvdPEVfMf7A73g7YzFE3X5xfAsNr+TqC6jQc
 aHkLX/tojaYU1MhfBQBDiAuFx3f7Xwmq4hBo+srL0z7XQIs2eHpeESDwtVQrZFWm/KSG
 JUclLCoGAzj9NyO/4zn7iDQjUOQgBOAmmglwKy4wne8faOb2NLQ1y1RRU0BCatx4c6e4
 F34g==
X-Gm-Message-State: AFuF++n6Rq72CpM8YsaQDH7o8QSlKGSfmPxMNtTl+zzhIRMkmg7zN5Rg
 bsKyrSATbId/l9T+358zB56MP6KY3Pu3E1jLgY+qprsHzKjvDEq6VQpc4xb9OWhX08k=
X-Gm-Gg: AR+sD13MvGPYTBsIiS9COry3yQrTJf7rQmWjYxl1MsMP7HrFfeVDVBlKnGQcqXm+vuv
 fxKuuPpaZpaJHJ8Bg5jb5ShVxTiDzGP74l6TIGPcBpyU0R6+O/h21gc8F6icatyQy/kgsgXy4d3
 LthYFI5Hy3hts3oJgbZaBJgif2ApyQBP9x4hQUepsqWYqhmlGeqJfdAQD5NDuvxThngjpNDzYZW
 EZ8fKA0mOi2gZ0IRBFae/CwocN3grcb/dasaXJFsyG3MC77zopDFVdUnEd/5qDgL2SQNXs+suMT
 GXm945BQ5wStScxWJULYWABndMm6YP2Jrx/eDOD2ujttlWr+TUDpoxFp2cJGP/4TbWIHGu4Na29
 K7NDcFbC6DF5Ivf4iNn4J1SxETiMYQTcuN62yyKMgKnFX+rB3qdcnaRlXVliSUhAtDWZGMK+mGf
 pW3qjFvEGnKtIBVztoJjkRxxJGZZs37sbvHpkgkmBh5VIxLEQ6jIRmXMx8Ad7F
X-Received: by 2002:a05:600c:83c3:b0:499:b01e:911c with SMTP id
 5b1f17b1804b1-49b91c26535mr91544425e9.2.1787919222277; 
 Fri, 28 Aug 2026 05:13:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dc103dsm44864165e9.1.2026.08.28.05.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:13:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21B815FC17;
 Fri, 28 Aug 2026 13:13:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 3/6] gitlab: add arm-softmmu tests to the macOS build
Date: Fri, 28 Aug 2026 13:13:34 +0100
Message-ID: <20260828121337.2277303-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828121337.2277303-1-alex.bennee@linaro.org>
References: <20260828121337.2277303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now we have fixed the compiler issues lets have at it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260824-fixes-for-11-2-v2-3-352c6b890402@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index bdb3eae18f0..40b9b637b3b 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -22,7 +22,7 @@
     - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
     - brew update
     - brew install $PKGS
-    - brew install aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
+    - brew install arm-none-eabi-gcc aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
     - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
   script:
     - mkdir build
@@ -40,8 +40,9 @@ aarch64-macos-15-build:
     PATH_EXTRA: /opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
-        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
+        --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,x86_64-softmmu
         --cross-prefix-aarch64=aarch64-elf-
+        --cross-prefix-arm=arm-none-eabi-
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
-- 
2.47.3


