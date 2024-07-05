Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C79C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVW-0000t5-QN; Fri, 05 Jul 2024 04:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVE-00008W-89
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV9-0003HT-TG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:11 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f419so1968677a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168866; x=1720773666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGMwdrjzaVjDq8zEZYSVnqK2CyrYL4caV/sFBWJUwr8=;
 b=Ak7jKdK4SNmN7ZUmF78STJF7G4GBBZ8fo+llHShZxXbtKsqUUynBtQa/2OMs2oVNXh
 QFRXG07XXL8su3CtknbFhWrbLbzKL3jmV/W2rHJ5I3MBO6LfGllkoES29D6IIQXa7JpW
 azT6LsVpXUj4NLHMId0ExvIGQbtEixOvurAdwM4P8vuPF7NnOJaq7PnKIshsYt1otdhz
 2MEhgCDNj0GtDBmU9HJZxNiSmurJr61mBLG5MGSARvU3bi25HodsbIlbTaWt/Ghh08FI
 moZj3IOaQ/dzW7zcMaav6iH0mzF22G1hgAymLq3xAZ3UCbQSM13uO81PedBgPj4vrmWl
 H6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168866; x=1720773666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGMwdrjzaVjDq8zEZYSVnqK2CyrYL4caV/sFBWJUwr8=;
 b=ND/nNf9A2Zb66BLknNyHeMtre8HT1Fnl3w6Ju7Xw3IlDlK1Ib4D5YOmUyjRsQslOCA
 inQhMu9LuimTB8GSU6Ff3kY6R3AoJqsahd/Tf3nVw4pbhvukk2qoj0GKcHyMAzQM6MP6
 lwGgowYOHcGvoapmBBp3xvhlKeZTD+805UpKphawsNw4JBeUbigXNlilV6/cmBp4UH5m
 D4yFr7D/4SEs8Zfz2lHdotnkdSydELRH1lZn6dzBpPKYBOR0MQQU0tTw7pr6GSswrvgk
 BNv+Z+nrsCo+MjP36TnHeUtS+HboUK9QECv56veIV7P340l4sv2vA0re4rKLFvR9Iw26
 p6aw==
X-Gm-Message-State: AOJu0Yy1ZUM1HtsVJsUAVBjb0M659JaJSP1EmhQUrQGwmPqMCGHlXpLR
 QWg9TGEABd1GdW44nzGm9doOZp54MDXozf5n2qt3wF8SqFpiotJ+Kz+7An7iCf0=
X-Google-Smtp-Source: AGHT+IG3ittBM/K9+GEuiAPuXbV5kJonx+k58MpQduMwZltZG15RemxO/mBmRFXnWoDn3Kr0/bwgSw==
X-Received: by 2002:a17:906:605:b0:a6f:e47d:a965 with SMTP id
 a640c23a62f3a-a77ba4d146dmr238250066b.41.1720168866257; 
 Fri, 05 Jul 2024 01:41:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a73e52c2cb5sm578758266b.16.2024.07.05.01.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:41:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A390462139;
 Fri,  5 Jul 2024 09:40:49 +0100 (BST)
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
Subject: [PATCH v2 20/40] gitlab: don't bother with KVM for TCI builds
Date: Fri,  5 Jul 2024 09:40:27 +0100
Message-Id: <20240705084047.857176-21-alex.bennee@linaro.org>
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

In fact any other accelerator would be pointless as the point is to
exercise the TCI accelerator anyway.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml   | 2 +-
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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


