Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E63C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl9Z-0005m6-Rj; Fri, 05 Jul 2024 11:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl9Y-0005lx-FE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:47:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl9W-0005dj-Tp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:47:16 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a72517e6225so200780166b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720194433; x=1720799233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcX3YpwLOTpsYf6Zhkg5VHQ84A4CmDm7f1BhkBXtQSg=;
 b=v6x66gDWZIcj7Rb9RA3+pRjGb9NtRY19pacTflwaG2+Vo0C9XGMC+hqQ1xCvCuAP7r
 W3kjfk/T8eqMIhr/W6AHeuLPVZ4pYgaXxijIkZ082BaEci+809NdEXuIe/FouaNuTmqu
 fNNlAuM5IQ/rwgkL0tTRvse/Dxo7m+VQgzSjztcO7YbOuAWOQX6iPndY26lSc2KHoB+d
 IXuX+37ijJNvRK4WRUDkgjvHOnst/tWGhVxw44RIOFsohocqhtDBD0GU0z/XM3/jjYmg
 8lFn+s8vjLL4CQqKd/cFFvL6hYsgUEP2iIsyU3fNn3Ckaa6up8xuNJqoS9zo13ENp2bt
 AFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720194433; x=1720799233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcX3YpwLOTpsYf6Zhkg5VHQ84A4CmDm7f1BhkBXtQSg=;
 b=SmVkYPFdv52ZkjlaIk6HoXrNqXGOM4NvgEXa2DihH0lg3soYbFC6YZWf7gW2ZiRwDo
 DEH1fPWfuwMmiZQSig4n2aO38/CdJsm/APz4QRMl5LTGdKWa6isHWEwVmNVifTTyN3cl
 z7aHk6JcC5p/p1yZzThd5J+rg62k2YcRiw9FJ0Mth2+9eueuBZPKMwgMNdCS1QzcYnS4
 OH8WAWvP2RXYMX6NZd/9olnat+IBnq0xtVz9y9obBGzF8TJX4IHvZOU5aj9mRhM74NrU
 GbJ8U0LEEH5jWzd7hDUqB2mnBf/KYQmWEtd3q5lnqIVcp+i4PxB4cTi6bGnbreZNIz3V
 pdNQ==
X-Gm-Message-State: AOJu0Yys4yT/j8672BHUjFROciVseKdFwGAql/tKusoW3Ikj+0QYLZwA
 qfrr3Ow3FLH5yY8gWsayOsuUHMF5JpsbqH9EkwveHNnSakSoObyY0IFCe3GufsQ=
X-Google-Smtp-Source: AGHT+IHZakTOQ63u/vDKjw44Uccj2lVU1sTcoUBNRJ82FyC4S746mGvFDpyZSgcVR24XXRn4D+kliw==
X-Received: by 2002:a17:906:8746:b0:a77:c5e4:eebd with SMTP id
 a640c23a62f3a-a77c5e4f35fmr225965566b.26.1720194432531; 
 Fri, 05 Jul 2024 08:47:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab065672sm694985966b.136.2024.07.05.08.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:47:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E421D62139;
 Fri,  5 Jul 2024 16:30:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 20/40] gitlab: don't bother with KVM for TCI builds
Date: Fri,  5 Jul 2024 16:30:32 +0100
Message-Id: <20240705153052.1219696-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
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

In fact any other accelerator would be pointless as the point is to
exercise the TCI accelerator anyway.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-21-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 425fc6479b..e3a0758bd9 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -635,7 +635,7 @@ build-tci:
     - TARGETS="aarch64 arm hppa m68k microblaze ppc64 s390x x86_64"
     - mkdir build
     - cd build
-    - ../configure --enable-tcg-interpreter --disable-docs --disable-gtk --disable-vnc
+    - ../configure --enable-tcg-interpreter --disable-kvm --disable-docs --disable-gtk --disable-vnc
         --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
         || { cat config.log meson-logs/meson-log.txt && exit 1; }
     - make -j"$JOBS"
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 3de0341afe..cb499e4ee0 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -68,7 +68,7 @@ cross-i686-tci:
   variables:
     IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins
+    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
     MAKE_CHECK_ARGS: check check-tcg
 
 cross-mipsel-system:
-- 
2.39.2


