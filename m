Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7EAC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAwV-0004np-Cj; Fri, 28 Jun 2024 08:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwU-0004ml-53
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:06 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwQ-0005eo-Rm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:05 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57d4ee2aaabso685207a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578581; x=1720183381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmUkQvx1dTB8+ePPVm90+LdKbwFZU9qtx5zavLenp5Q=;
 b=pSOcW5/vmKHE/qM/W1jqN4rsS89OBW9O3t4P2YIP/8xCgPkBUOZx24hG/2g3ma2Yvh
 1QXIoU0uj71NbJFCwsMlzQxkNOML8O1GsSggm/zXw7bVMfDe8nCOERQT2kdhEB+Txh8n
 1bGn8O5/cDbKfpqDMKxof2LU0pFZ/XUEwIlEoe5xXVMiT6FQ8rRWvuFhx4A7WazmiXhs
 2w6bz5bdr5okEEaIx95Du99mBjCnIkGifXCrjFsU+Y3lommkbkkXs43sw3dl49hQHn9b
 k1oAUHYsFeL48o+0r2/zln1sYGiKtQhqq0k+uvY02UZ7/t2BqJh2MzljSoDj22vFCYpG
 XUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578581; x=1720183381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmUkQvx1dTB8+ePPVm90+LdKbwFZU9qtx5zavLenp5Q=;
 b=TTTSzO1I2pYRaNfRQyPshDG5YmKQfqUcX6vn4MiqVlst8zlKvkOWs97+WwH98eE4it
 8KmxVeSmnQXXPPxtwkjxuW3E2+zT+cIthA4WuXwc73qyutVqvoL54KqmSx2wDcKeLW67
 ho1EN7VwBH60jgjEj5o6O5FL1ah/Fw/1lKr+qdktso0UaBNEi4Be2P4MbfUWIrPV2lOs
 rc19Iv02pzEqn/EcQTfEFrmHTSakX29RDbLson9b+9VB8SZM7TaEqOKwaIDakDgdPqDA
 7m4cQGb8LJDEvObXs3Ft/ziLcdA+ExIUcmRlCipjffkmrWcSFzLfjak3Fvl89dQo2/0V
 t7jg==
X-Gm-Message-State: AOJu0YzmnvQ4Kbaf3Yt2mi1LH1FRWrnHHK9lYmxaM36WDPEkE9/gcXBB
 EnFfO6muSxlNxdIiWk1Gh7OXZRJMhr+jl1spO0gbTak6V72DL7nXEi54ohw1Czw=
X-Google-Smtp-Source: AGHT+IExDOg+4B1GItkum2PW4gtyVdJh0wbalWZQe1E69UXOv2qv1tIu8TUudMNmRRwGqmDDUo5Fgw==
X-Received: by 2002:a50:c35b:0:b0:57c:6c1c:f942 with SMTP id
 4fb4d7f45d1cf-57d4bdda616mr11042632a12.38.1719578581001; 
 Fri, 28 Jun 2024 05:43:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c835adsm982859a12.17.2024.06.28.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:42:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FC425F958;
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
Subject: [PATCH 03/23] testing: restore some testing for i686
Date: Fri, 28 Jun 2024 13:42:38 +0100
Message-Id: <20240628124258.832466-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


