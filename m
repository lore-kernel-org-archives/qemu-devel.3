Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D257C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeV0-0008Pq-1f; Fri, 05 Jul 2024 04:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUx-0008O9-HX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:40:55 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUt-0003An-MZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:40:54 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a77c25beae1so122073566b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168850; x=1720773650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmUkQvx1dTB8+ePPVm90+LdKbwFZU9qtx5zavLenp5Q=;
 b=k4sZbqJFw1RUoUrV6XWEpXc/BpKiGMgIxOXbwv+s/ZyRIQGltrv1fIEq81K95a21Kw
 6R4MwrNvK6XVhkFthDDBmfkEvsw/W8OxICBy3GKyrWoCHTVk/P2I9L1QVBBL9iC0CIv9
 sfOXBPh3cJyI+aOobKa1PnRzxkNCyeMYveVtFiMKfQYPW9dZNd5qXYG9IbfozLS/HkQq
 WwyvqShHVlgqWxY+HqH79m6BnBrQ+MBi5iCUA2aqeq27FmsitNLAE+DTYdvRo/ezfokc
 Rb5iI82TuWUZS3kc26LdH8uN8hQYmBBy9Ggd/8wHprmqnUVAp6DHGtuBKM2FE71Nc+nE
 eRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168850; x=1720773650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmUkQvx1dTB8+ePPVm90+LdKbwFZU9qtx5zavLenp5Q=;
 b=MmTyxzDoE9sr58UWvEKFWI6KYNJ+5IwYyDko3vuRkzuhPZwU4k2gyd9ty1O7Q/t0X7
 PXNuFGZzm09PRTeWLz57B2NPwCpzXbeWW5DETEQqBqbhKldj6rgRJB6J8z6P6U54l36m
 oSuiHRh94qelNjYRpOk1KKr0TUoVkIc0fp8swRww31O7N4UNfnm9g1i444Mj1yKPCLMY
 VR9rv/U2h1oSWIlvHAT56gZpBujs0sSfia3SH/4Qxs8da8juUx5hzOftzwgKHL4iM32s
 ROr0qUvxmF2FpzWSg571pJmS2Y6UB3JgS4YDhSBzZ8XDRGUoCNiDQho4N0a5TD8/m1RP
 GfmQ==
X-Gm-Message-State: AOJu0YyDQV3V3GD/TTW8Aky9SagDyR3+fvWaYJYNc9Wt+WWfJI8jOwGX
 PAtOoA3bCOyBlJZKjP9QAmoEb8BrVUrYrO67FqJF1qDmot/L8c2wM7RW75RoJqg=
X-Google-Smtp-Source: AGHT+IE3NrdBl5Ki9NzL085dznEQEjUe3VQGIfwJKOG7VhYN56mjbWrRb1W3GeIKHIy2b9hSvND/8A==
X-Received: by 2002:a17:907:969e:b0:a77:ab40:6d7f with SMTP id
 a640c23a62f3a-a77ba482a47mr330935666b.43.1720168849744; 
 Fri, 05 Jul 2024 01:40:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b56e6sm656502566b.202.2024.07.05.01.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA1F95F92A;
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
Subject: [PATCH v2 02/40] testing: restore some testing for i686
Date: Fri,  5 Jul 2024 09:40:09 +0100
Message-Id: <20240705084047.857176-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

The commit 4f9a8315e6 (gitlab-ci.d/crossbuilds: Drop the i386 system
emulation job) was a little too aggressive dropping testing for 32 bit
system builds. Partially revert but using the debian-i686 cross build
images this time as fedora has deprecated the 32 bit stuff.

As the SEV breakage gets in the way and its TCG issues we want to
catch I've added --disable-kvm to the build.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add --disable-kvm
  - currently blocked by https://gitlab.com/qemu-project/qemu/-/issues/2413
---
 .gitlab-ci.d/crossbuilds.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 47bdb99b5b..3de0341afe 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -37,6 +37,17 @@ cross-arm64-kvm-only:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
 
+cross-i686-system:
+  extends:
+    - .cross_system_build_job
+    - .cross_test_artifacts
+  needs:
+    job: i686-debian-cross-container
+  variables:
+    IMAGE: debian-i686-cross
+    EXTRA_CONFIGURE_OPTS: --disable-kvm
+    MAKE_CHECK_ARGS: check-qtest
+
 cross-i686-user:
   extends:
     - .cross_user_build_job
-- 
2.39.2


