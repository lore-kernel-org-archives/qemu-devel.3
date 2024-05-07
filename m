Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE10C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Lt6-0003Nw-Sa; Tue, 07 May 2024 10:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsk-0003BU-32
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsd-0001MY-Mb
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:25 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so24408225ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092397; x=1715697197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9wcs8XKRd8uFWf7+gb0OcRlyNEORvMcLw5aFQixK3I=;
 b=exJL8WmvBh3xm/Yf5nUUXByN0DD9XOyFGYgu1H5PSva61bSPT0X+1h7PXfFx9mTO4a
 D78ImuFihonl8+GKeWAyC0XZPKFqhhVH0aXxzxC373SabYtRvEUTAUlrka8itGAEhx3K
 CxRXtG7STDkW1iz5VcfKQi5PELTrt3RKEkLIvSwxBd0Ogm77fmlBCR9VOvXWvnrrG9JP
 opGxn9Y/Lgo5rMQfUx0xiyXZHlm1A6+pL/bCrAifuqYzWAK9cVSOroAlKVxeoK4jv93q
 wwnBDhpfexNX8vJoAaOlLOLF4AM6Eh7qsCrT9Ov8Wx9BO5OsLs5eCllUeoaDE8T1rahF
 EK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092397; x=1715697197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9wcs8XKRd8uFWf7+gb0OcRlyNEORvMcLw5aFQixK3I=;
 b=SJoDsQc0j9E+RfWDZ5zdnN2AwQBAEdElohFzDxzPlwwWYMMlKFo8lhOquP4BRD1REH
 N4SuXuD+4Dedv8Rc2RB6oAeH41ugbzCIjDjw/oz4VPbarHC6J42TDp+pdmHkzOAlJcqk
 /GxvZtEXeMXrA+qn6UtaGKxyMni1XJc7bcRLcvAuuX8hlIbQ+WAu4Ea2AVXP7ZkYkinl
 CU3EWkT9he/ZPM1c+FmNKTg6Ufnk8dZ7IlmMH0rEfQkq4/3rFEdWhedoXz0vi/pw8VYc
 F12lJvIhIN/+JX770vpPY14c2dXB28GBTnEjm9eXkE/qqdZYImxeeeIWTRB1qphipUCh
 eYvg==
X-Gm-Message-State: AOJu0YztqKGQasWJJe4SCwIp7tfFWpDYRH5RYiUEHWevprBOD5yu9K8H
 WyfJ+VdvS5gQwbJ14ianW3UPIPK/mBw7mQc9HRCAPyp63caj01uuI1jlejf0VYVOKxt9ogVobbs
 8
X-Google-Smtp-Source: AGHT+IENKPIb5sj4Nv4wpzwGY1d3UMydu3ShWciFIEfHgxGHpCaOntvNQic76qEgyGOtTvx2NmMHbA==
X-Received: by 2002:a17:903:18d:b0:1dd:c288:899f with SMTP id
 z13-20020a170903018d00b001ddc288899fmr16181288plg.18.1715092397212; 
 Tue, 07 May 2024 07:33:17 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 7/9] gitlab: Drop --disable-libssh from ubuntu-22.04-s390x.yml
Date: Tue,  7 May 2024 07:33:07 -0700
Message-Id: <20240507143309.5528-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This was a workaround for ubuntu 20.04.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index 105981879f..2b9e1ff749 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -35,7 +35,7 @@ ubuntu-22.04-s390x-all:
  script:
  - mkdir build
  - cd build
- - ../configure --disable-libssh
+ - ../configure
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
@@ -57,7 +57,7 @@ ubuntu-22.04-s390x-alldbg:
  script:
  - mkdir build
  - cd build
- - ../configure --enable-debug --disable-libssh
+ - ../configure --enable-debug
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make clean
  - make --output-sync -j`nproc`
@@ -80,7 +80,7 @@ ubuntu-22.04-s390x-clang:
  script:
  - mkdir build
  - cd build
- - ../configure --disable-libssh --cc=clang --cxx=clang++ --enable-sanitizers
+ - ../configure --cc=clang --cxx=clang++ --enable-sanitizers
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
@@ -101,7 +101,7 @@ ubuntu-22.04-s390x-tci:
  script:
  - mkdir build
  - cd build
- - ../configure --disable-libssh --enable-tcg-interpreter
+ - ../configure --enable-tcg-interpreter
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
 
@@ -122,7 +122,7 @@ ubuntu-22.04-s390x-notcg:
  script:
  - mkdir build
  - cd build
- - ../configure --disable-libssh --disable-tcg
+ - ../configure --disable-tcg
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
-- 
2.34.1


