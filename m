Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFEEE7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzG-0008RJ-Ft; Fri, 10 Jan 2025 08:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz1-0008FF-HQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:27 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEyz-0005ap-Ff
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:27 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa6c0dbce1fso278090166b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515403; x=1737120203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VKfQWDeXKLODbQaZ6d7RnCTImhLUxizRICJ8N9Qz/o=;
 b=tw/rIEKh04PODvxl4w8DRNpWNJTFiNXnd7mxJY3Xe+64KGHpm5WSFxd3wfvJnWUgnB
 WpzqEd2pBc6J18/YyS1UWBi4MR7vPiWyRCyBHtkMNIc8x1L5ACc9Ncd+rzvSdY4dLt1V
 RQTx3sdp6BhGXCP2+LBJWmwc6DKcWsgtIVUCuVR+XRsIqtN91atmcIKCtbmDatm6s0+4
 EDhyZwrZl2YBtrMXKprolGjFmF1PJ8D9US+QQu0WUsFSUTEsM1lDZfa66eV9vPkBBaL+
 1uV1gHJYRupcw9SlgNY91oE+6PT/PE06lVoNdoo/XPKVzulDlciYcCvGqjvEoxZ4q9TS
 lgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515403; x=1737120203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VKfQWDeXKLODbQaZ6d7RnCTImhLUxizRICJ8N9Qz/o=;
 b=XZi8gGshmgUTWeHMVsbqK8gduWQmH2vASofzKugCFl/6jRtCUvxjP9zpohrcqhyxPD
 jxnfvv4EZznXnXlutfwa4zJOPCF1/ndyDRadkB9NTpFO/PpX/fLtdFT7u8HirztbeKvB
 /2/Ju8GKB9FSYeZR0VZjowrRlMTJrpdZxoHB/f3iCLCYX07zX1At8rAL0240Z9ydA0Ku
 qgurnHSlSAFfCJHpWZBSSTTuL2Fpc3AnOnRQ9cPplXopYGc/rGWFA/O33AJxu1IiNvhc
 BimZe8GA0JqJHj15xXdyH+oIVg898pLDZN+bmWzeGmXParQu/YC1o0T4pRW1p5cdOOHR
 M5ew==
X-Gm-Message-State: AOJu0YyVbvWXmiNzSUo4exflB1uahqZ4MLgBtAJ0w9nLq13/7LZKtjPS
 l6/ZWQb1aS9B/kTB6yRgjb42bX8sPqFPdSTqcJG3UTUjFYbGY4ZjfsEwq/sj6sY=
X-Gm-Gg: ASbGncvWhR3tyxczZJFplU0t9/WMvgKvcfyoouvR2yWkMhNeAYdcgx+hH6fsbCRmoIi
 FESuX2O18Jgm/gVe4RGZ80xwPd/L2x68loduB4rF7QwhGew5qfPElNUjyN43MJs4KibpFBx3MNU
 z9RHt8wiiINfn+h90JmODRQgYtuOJXr7V7ZpsVK3T9M6goCGH8/4a7kk9YQ1qzoEOHp37Rh+y4c
 zaKtfy8YiECXWkzCAAWqezRBWc7TeQPPBlz054se25Vl1pe8Sq/2Ls=
X-Google-Smtp-Source: AGHT+IGNylbrz7pHPEGbmT1fsZLX+w3KFappw1Xx1c3vXqB4pxuv1cAosSWcU5HvTFmealcMhptYNw==
X-Received: by 2002:a05:6402:35ca:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5d972e0b954mr26003148a12.11.1736515402678; 
 Fri, 10 Jan 2025 05:23:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c956306bsm166756566b.104.2025.01.10.05.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 54B6B61779;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 25/32] tests/docker: move riscv64 cross container from sid to
 trixie
Date: Fri, 10 Jan 2025 13:17:47 +0000
Message-Id: <20250110131754.2769814-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Although riscv64 isn't going to be a release architecture for trixie
the packages are still built while it is testing. Moving from sid will
also avoid some of the volatility we get from tracking the bleeding
edge.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-26-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 4d8ca83cb3..b0386cd3a1 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch riscv64 debian-sid qemu-minimal
+#  $ lcitool dockerfile --layers all --cross-arch riscv64 debian-13 qemu-minimal
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:sid-slim
+FROM docker.io/library/debian:trixie-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 6720516b94..53f8d2585f 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -220,7 +220,9 @@ try:
                         trailer=cross_build("powerpc64le-linux-gnu-",
                                             "ppc64-softmmu,ppc64-linux-user"))
 
-    generate_dockerfile("debian-riscv64-cross", "debian-sid",
+    # while not yet a release architecture the packages are still
+    # build while part of testing
+    generate_dockerfile("debian-riscv64-cross", "debian-13",
                         project="qemu-minimal",
                         cross="riscv64",
                         trailer=cross_build("riscv64-linux-gnu-",
-- 
2.39.5


