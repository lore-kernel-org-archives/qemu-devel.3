Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D99C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBe1-0007ka-QQ; Thu, 06 Jun 2024 07:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdz-0007i2-NY
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:59 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdw-0000t0-Vn
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:59 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6c828238dcso50807466b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674655; x=1718279455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kb+0fTRsR51rfQqfYGIWW8wQJF7n2zwqsVXnuKE2tow=;
 b=AvKNxv7nyKC1YlOt1IjzyLTU/6j4JghGSeZi/J80SD2cGmGEpWtSGHFGDUZDLEQbtg
 kY0/5FV+W26XzxtP5WqFq2SHdDu76p1d2OOzaO7N0FHM2psrC94nwZdUM6z2HeW3DUaT
 3RG8TPnKAanduYjQo56H3vO0ASq1Pju4s4xC98CpTxxu5QkDp3yTnnvNidgN8cJaE1r/
 SwogGQKsvRDbpT2ZnI3FOZaqo7Zn2E9oHFT2UKMRsj5R+fcmmCtAFpmUV/EPH9SUT5r/
 SUWTOuRHoVzCcFAVL9e+Hhb718/04F6fMTRv+MGyF1NTAj15v+m4Xx6PO+ct+1MsQgmx
 pfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674655; x=1718279455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb+0fTRsR51rfQqfYGIWW8wQJF7n2zwqsVXnuKE2tow=;
 b=HVUT308cnq4uLHEBoNtEctXo4bGPESWcZC4ZzWn1QKzh3cBt6bq59Eye0o7p/NsYT0
 VjQrnJjp7ekWlgA4vB7+6xRq46X3RoZBdFSkvLny0qdfrmhMesZVMvEaKGgTWdcPdF/F
 4gBTdJL8x1g0jPQ1Z3RGp6EHS5cMDEuSFHOBJNJdifSscT3XnuqPAnYQDmfgbFnKGoJl
 MnMUMPRlSlT6DkZW8QBul3i2oJExKcchCwGNDlidFlIY20Z3kNqeMv30kzYdLrNIgF3S
 sTbpC2eywYaXdan8TOq0E68oNy6HS8aBIzLu93FF5ULYBDliW2LMMkgNH4umkRKWyAJR
 dtDg==
X-Gm-Message-State: AOJu0YwYA1idlDwp5afA+n7EWd9RGSt4N/A5bzAa+vfXRi++U9AsS3MV
 nVvz0Fe38U9AE8KhyJVbv3Ic2HvZ8oQrYl6mtZyv4vtoV/sgi8Z2bMxx/P9RY0ijM0PBIb7gMlh
 o
X-Google-Smtp-Source: AGHT+IHI3/4Kyf+moJPRkmAepwiwQr9nDgkgUZWU2TImNPS93QEjdRoXp8YMllCjxco7kuFTKA06Yg==
X-Received: by 2002:a17:906:ca8e:b0:a6c:7072:1444 with SMTP id
 a640c23a62f3a-a6c7072156emr205921866b.41.1717674655358; 
 Thu, 06 Jun 2024 04:50:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805c421esm87086066b.48.2024.06.06.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A45B95FA2B;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 08/12] .gitlab-ci.d/buildtest.yml: Use -fno-sanitize=function
 in the clang-system job
Date: Thu,  6 Jun 2024 12:50:43 +0100
Message-Id: <20240606115047.421045-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The latest version of Clang (version 18 from Fedora 40) now reports
bad function pointer casts as undefined behavior. Unfortunately, we are
still doing this in quite a lot of places in the QEMU code and some of
them are not easy to fix. So for the time being, temporarily switch this
off in the failing clang-system job until all spots in the QEMU sources
have been tackled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240601070543.37786-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-9-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91c57efded..0eec570310 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -432,6 +432,7 @@ clang-system:
     IMAGE: fedora
     CONFIGURE_ARGS: --cc=clang --cxx=clang++
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
+      --extra-cflags=-fno-sanitize=function
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-qtest check-tcg
 
-- 
2.39.2


