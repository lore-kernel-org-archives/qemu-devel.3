Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E826E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwoe-0000QL-Ph; Wed, 18 Dec 2024 11:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnz-0007ww-NF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:47 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnb-0006uf-8n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:47 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so11925067a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538881; x=1735143681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG7MbUBeLhp7BGSne5jxjhgnKJrC/8a0zBr1FqLJA6g=;
 b=NHLUoErNvU9DqJVIJpPuZ8CFdRXyY1MvthEUfBAPu44QQtSazJk9luOO938QSx88Zx
 Z+HnqMkNpiCoRQWfljC1xFU+S6ap2SbFhBSroYrm97ORcbSEw7/b1Zcs0LRAYd02YeuI
 rCj4E97EaBffYeqLQYfm6a99VQg9oHirXxsT9opnU5iIibR9OzAz/MQ6ICT6zHtYuILs
 wE5+BtYuNFsZHiwtKuUJGS5N7kJNPUg8i86OelVND6kuNvdENDReeV85zVTiai/e29mJ
 nij46xNey75gRNMFX9GRJWoGpg1v0REyDHFt96JfoTRdP1kNVNA6RpuRnuydIoBw/Plg
 sEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538881; x=1735143681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG7MbUBeLhp7BGSne5jxjhgnKJrC/8a0zBr1FqLJA6g=;
 b=BeqryL3ev8xrbdvjGLrvrmaaeXRnsez4QrtE6Wpd9eCixXOEYI/70dUTq5G8/+/2ZY
 NKTu6IUvGdTbhW2FKACUKV3p6Y3MERvP8QvcKJEJMuel7bLymL/+v4XVjUB0vu3QuLeZ
 jru7OqFRdVHF37o9oGn5B8idnkg7GHEdCHyjzO7X+7gXd1CC6NQkiE2Jo/7GhTr5Gs7E
 w/kHCfBgYz/R3r6fv2TsnJJpV3ev89A+4BLiqx9slCVDmKGIciXWoCuIShaDtfLx1xHr
 RUm70cYaAK7xFvDK2ntPKI1jmJ3WGo3VGE+dZf9xN0tCPYWTfRWvQPMM9g2RhOrro0zZ
 Oryg==
X-Gm-Message-State: AOJu0YxiIsvb8bK/yhp/UCzM50cT8kLHXACimf3caTA1kZMBW8kzUCRD
 1Rx8QIhgllaXS9FLzc01KsqkwF6urlx1PA+REYmetNnGBMS2qkRQcXu+gCLNZVo=
X-Gm-Gg: ASbGncsPwtXCGMS3pXO8QGBMZ1jtzc7zTfp2iKsavqMq8herEkk0yCAyUMj7SnUS1hT
 vOgfnmlulH06VOk/OBUOezdtr57hVfJ/DDfpakyKI/xNu8s7YD+qWXc0rgIkFsSkKeC1tXiE6hj
 1YPIvJS3Bbk6JXaumFk+7gKRKDL3vs4RdpjtyFMqwNqDb/67bAXGhVKUetLx3qb/NMmmDyBtWG9
 1HCepBAGoZ3YoakTBFAmzHVa9U1SRWwu1DzfJ4F564DGCdQtmVuKbU=
X-Google-Smtp-Source: AGHT+IFcp+j4tlely32MlF+oeAn5yKl27JROY39I7hFbPS58gikkauyhkL5DTdLtqO+uRgsdZoj3DA==
X-Received: by 2002:a05:6402:4001:b0:5d0:81f3:18bc with SMTP id
 4fb4d7f45d1cf-5d7ee37660emr2710751a12.1.1734538881527; 
 Wed, 18 Dec 2024 08:21:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652f25afbsm5752895a12.55.2024.12.18.08.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 48D2860BA3;
 Wed, 18 Dec 2024 16:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 22/27] tests/docker: move riscv64 cross container from sid
 to trixie
Date: Wed, 18 Dec 2024 16:20:58 +0000
Message-Id: <20241218162104.3493551-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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
---
 tests/docker/dockerfiles/debian-riscv64-cross.docker | 4 ++--
 tests/lcitool/refresh                                | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

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


