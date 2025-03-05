Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56873C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 21:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpwSK-0006v6-9W; Wed, 05 Mar 2025 16:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpwSH-0006uR-Qe
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 16:39:05 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpwSF-00086w-4x
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 16:39:05 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22409077c06so7486245ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 13:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741210740; x=1741815540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lcWas7bVHxtHRVay+IPouc2YT5aytIrBdJ55/LYvMC4=;
 b=K2yow3qIiIihWvqwhxY0AofQ8289rNUuyTjRMqdBrcA3tEznQhYy23IC0CGQRm0ALJ
 i1lApG94tqNa/2ULT5SyOPnlsZnUjbZcVIyZt2JNr/qll6d/01utNANM8SQukMJAb/kk
 d4kMQJd2A8JJjzoL1gTNvEFqc7Njp3EJK+4NR5fq0O10jm5nzesSVMvfoVsmSC4yLXk+
 doh9JsMPJ58VKqI17cjHYd9ztXMokSJc1UiwZ8jreRtOeYoIqr4luQ2ewZVlrTN2hegN
 DFak8+4gMviJo7S3sCfGVfrPIVjlaVucRIugAZsWRaZ7MbVH/7UgudUonkxPC4iEq6Mi
 Yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741210740; x=1741815540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcWas7bVHxtHRVay+IPouc2YT5aytIrBdJ55/LYvMC4=;
 b=ktFWmwtH3DceaY7iu7dijtt2S2vSXKFVuV24USundBcCcWvvpbmTzi7CToDwsa/Fwv
 sw1An3zv9I3dV+WpuOWDo9l+Is4gQJ9/9HLM+GRjbLP6kChyas4LV7Exf8na2ihanww8
 EWy8/SoFP0ZeBLW5fRv7Ja/YD65+sfOhMlMVdJ6o2tsgy1pWOgCXN/yXXYbVU0LHh6O8
 FN3VIjyCl16OfDd+RIzRatIFxIi2TgsjBwoJqb7fDNgyjdAqs+rt7JJaXvva0AOMbE4h
 DZhNhi5f03ROK7BRSq0v2sA5XeVAVvXiVIqjS9i7w8HP6TJ1STHuEWMqTBvMurYw2lBc
 fxsQ==
X-Gm-Message-State: AOJu0YygfhM9FqC81o6NLurBIl+OJ2TyEl4S+lYKayjc9K96yoe5FOq/
 okcoaEvC/MG8akkx+EBDqNAvsyRKDvKgYs4c0CXxh777bMyt6z6EGVivC1lYXMXCAEeiodiP4Oe
 l/uQ=
X-Gm-Gg: ASbGnctx6H91te1ZWP6iaOb3Hj3UiVeHxuU9jgbIFIDtU79ep+pHGm8NyLdv72cfvFF
 uEW8RQeKVw/rroqgoQvg+slHA74flN62KPgfZ3d55Aw+ftxjhSUCWGlAp6mZ6Ss2zPyV4sOZmOg
 B0L3HK0o3SQEqb6m2n6tLn1M0OJgk+Bk1aIXhZdGE9jH62go3q869UJGqpgIzi6gcvbvax+eH1p
 hYviFqDvANZmzGq8dshcl+rhzgvMByN0+sHxcmnYuioCBM2BsV8HzD6aThUihc6Pjs7VwxUVFst
 s02et1wwBy/KNOe9TgJZoM/PEez2AvoIoSn7BM6rZWHm
X-Google-Smtp-Source: AGHT+IHXkuCZAvZMrSiBLhKiqDW2h9CXLE4PYqwmtC+Zj3t5amdGnoHmGKq8umA5gmdRCFo2KY5R8g==
X-Received: by 2002:a17:902:da8c:b0:221:183:5bea with SMTP id
 d9443c01a7336-223f1d1f971mr74799475ad.50.1741210740687; 
 Wed, 05 Mar 2025 13:39:00 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73650123868sm7004692b3a.7.2025.03.05.13.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 13:39:00 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] docs/devel/build-environment: enhance MSYS2 instructions
Date: Wed,  5 Mar 2025 13:38:53 -0800
Message-Id: <20250305213853.3685771-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/build-environment.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
index f133ef2e012..661f6ea8504 100644
--- a/docs/devel/build-environment.rst
+++ b/docs/devel/build-environment.rst
@@ -97,11 +97,11 @@ build QEMU in MSYS2 itself.
 
 ::
 
-    pacman -S wget
+    pacman -S wget base-devel git
     wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/heads/master/mingw-w64-qemu/PKGBUILD
     # Some packages may be missing for your environment, installation will still
     # be done though.
-    makepkg -s PKGBUILD || true
+    makepkg --syncdeps --nobuild PKGBUILD || true
 
 Build on windows-aarch64
 ++++++++++++++++++++++++
-- 
2.39.5


