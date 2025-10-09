Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F18DCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wgv-0007l7-Kg; Thu, 09 Oct 2025 15:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgm-0007g2-8W
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:38 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wge-0004V6-0G
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so1115995f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760039543; x=1760644343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bP2+LnxominadBEhovoOi7tOfGjBf3Nu+saR3IK19ew=;
 b=S7Kb/UwelGSiSuy2S/fZqZG75ZXgGA06giENP4DA7DixHXdpK3PITiKjGLl5Ryjas4
 +II1sADXqiELyZL9iS3uz9mK3ygjPqmyJMtEmOnRFZvqxnQNwET4Vuf4Kdfj8GwSTyFD
 9e+wlzqMyWC/o9eOXpY2D3+JPVMwkOzhWuZ015K6+63kmboMrF8SH3LLbLIzsX3yu0dR
 ZLO+6dZjwEmUeC1RpKUHyzKk0xsOEh3TKUlEwrDf8QGD54Lnp2ICkGkIsTO+ZtgFeusv
 3LVv1KZc8fXqVrkYIflmXY2CJyrnLS42uyxU7OobLg0vODc3O1dsjq02QL4ecNnET391
 KLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039543; x=1760644343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bP2+LnxominadBEhovoOi7tOfGjBf3Nu+saR3IK19ew=;
 b=HTqgrBYvFnjX5DM5DSFZA8XcaYIwOTTPd7dd9EyME34YIS7CfYXUaHMrR2kzOauwOG
 hyN6K+X4FnkS9B9tiBG3aAvaaO/RP2VM18p7dIkwAVhHlEl8IoRXucYXZ3QXLfYnWfEL
 NMhGNfL5w/1o3XxgUEpyRZKqWvhzzMc/QTBmwiYSewEUq6iB6FtYGUv/3NQIFkFDlxhZ
 nBq7p0maexLsfCFtWb/KEUMyMA4okfjEHDZWxQ2maSov3lA+GB07EJ6PByaW5lpqQsLU
 py+ChlMsHN+MzQkUEU7dQPF9hVNM4RZNGcZyBp4Qsfn43REihAAyFcE+1sMvQ83UQWPz
 c2qQ==
X-Gm-Message-State: AOJu0YxcIASWVvTzbdhmIHKCATvGVjcU38WTrge5Q9EAtJJElxAk60QN
 yAqVR0v07DD/XrdDCvBws39ABjRXff++2I8T6qOSs3VLXPQPo1d/vSgj/T7j2OWqJeQqnItrMK9
 coFiB6M3Nzg==
X-Gm-Gg: ASbGnctF8HiDR/+lWaa0M0sqO8JYUIrJ4fADf7I5m+OOQqYrydQVi3bMc8wcU3y3X8s
 3LGIwBDsAlA4YGP6fGF6Dr99SBs1K/N+T1HAsT1lvAPcrEvTR3ByWg2u5h1TaLR0Jil1b6h/9Ok
 7kgeRQimFbGVsss+yx/787wgTnXKLfOK3pLir9EMcJQJ6bK3qKL6bIqMBEMk0+/uDxAr14GKj+v
 aOIaaIjSyT81bhZgQwyt++RaFzn4837V1N1pzB0Dqzbawt5YMDXblh+S70nB+x7Nw7LCk/9iAhu
 usd0GgfnwHLyWG17/9i2YdQ2Mia9ePEQxOuvH25nwSxH2hkyVRaJBlqYMeKgzDo3l3MIcnXrOzK
 Bth4Cj+No/44TAsHAir5xDElsq8mgmvTsr7e6fDyEAtuvJzO/9BBOmevqClmJl872PoksSHZafx
 c8PrWhfiE2LYUTjb2SEt+WSXzpcOTht/sWI0s=
X-Google-Smtp-Source: AGHT+IFL+JtvRsxWkqEa5izCX5ImEeUDksPSYSXlOSSi5ZPj9k5U0eF5rUJMjTuMU0elo84g4jP4lA==
X-Received: by 2002:a05:6000:24ca:b0:3e5:47a9:1c7f with SMTP id
 ffacd0b85a97d-4266e7df708mr5985970f8f.47.1760039542681; 
 Thu, 09 Oct 2025 12:52:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582b44sm543067f8f.16.2025.10.09.12.52.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 12:52:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 2/7] gitlab: Stop cross-testing for 32-bit MIPS hosts
Date: Thu,  9 Oct 2025 21:52:05 +0200
Message-ID: <20251009195210.33161-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009195210.33161-1-philmd@linaro.org>
References: <20251009195210.33161-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"). Next commits will
remove support for 32-bit MIPS hosts. Stop cross-building
QEMU on our CI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/container-cross.yml |  6 ------
 .gitlab-ci.d/crossbuilds.yml     | 14 --------------
 2 files changed, 20 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d3be53b75b..0fd7341afac 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -52,12 +52,6 @@ mips64el-debian-cross-container:
   variables:
     NAME: debian-mips64el-cross
 
-mipsel-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mipsel-cross
-
 ppc64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 8ff0c27f74d..99dfa7eea6f 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -68,20 +68,6 @@ cross-i686-tci:
     # would otherwise be using a parallelism of 9.
     MAKE_CHECK_ARGS: check check-tcg -j2
 
-cross-mipsel-system:
-  extends: .cross_system_build_job
-  needs:
-    - job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
-cross-mipsel-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
 cross-mips64el-system:
   extends: .cross_system_build_job
   needs:
-- 
2.51.0


