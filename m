Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB0CE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 17:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCqO-0006gQ-H9; Tue, 07 Jan 2025 11:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCpV-00054v-4M
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:23 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVCoY-0005vS-HC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:53:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso151148605e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736268741; x=1736873541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG7MbUBeLhp7BGSne5jxjhgnKJrC/8a0zBr1FqLJA6g=;
 b=EaYY86GjY8yx41cog3rReYU6GGriUpxaAe4MJg9qimL0qMkBKGnO9Yky8K9tW1T+YN
 awbZTls/CpZ1zljQyuX1AWgVzjA4hgxai74tLCpgqVY85h5eyNEZrZvuIkhKvgl7TFI5
 R1jLGKjxI2phzjKZ0x7U/jesgNY0dSGUDOT4xuwv2dqDPV+PedqdxMm4tp8ZvJWtA2b7
 hqtCqchZ03iBJJA1YBKwpPSMWvtEfDmWI+iEJyaqlgklRRI6aYAYKKhpnpTEWmqm2h7K
 p4AHi4xKOQjPC8/s/w+9mzojWig9jfLrHtFBuSUiWt6wsf4PRufb3VkkqvBSzPPeWSat
 iuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268741; x=1736873541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG7MbUBeLhp7BGSne5jxjhgnKJrC/8a0zBr1FqLJA6g=;
 b=qd4IHLfzeiQQqu7T+j0NVnEI+M3VJCYluvOJIsl4mCdhcuPtt5aTT7dB6NQnuBoPaD
 VI0VeBOpeKy0YCVNcwixvF8eNKaDSv4thZrboMoDBB3T5oebY+qZfcQja0q4VaZUrSvL
 IaT1/+CRKEPgodD9QApRSk83bjyokN1D2wl/MEKssL9buLHRmduhqrW1JU7JTy8q5fom
 FbSPqrCu2da3bk+f34xttTdOZP5yKL0b7KDeydAbGY9bKD0ZR7wF566Hm1RpqLjvxsgk
 wM4kWIUbJ3MKQhOyltumamZW8bd8X+hq4Ab50JFcVoxMwAp6Y+/7SU60zdCWhWyev2/O
 fT+A==
X-Gm-Message-State: AOJu0YyLj9SrOlW2bGBU+PgK+4qBLulYdYJB506LxJHnzIJbXu0UfsYW
 yAAmpI+/GuZoPLt8s/0XJ4SfszrlpjYNY23QRC34mKUzAMLcmRRJLZWxx2saclw=
X-Gm-Gg: ASbGnct38pZTulMha/KjNwY2ic7t/h2499cGop4BRRBkgf6OdeCCtWqkBMzJCD//ZrE
 LJZ3mT9IWQ8n/PYzLXMUhQxCSCXsh8lNdCBtJlDaFNMjKNPU2Sj0gcuI5I36QY0oZhlXF2fwjCY
 ERT408iR2hecwURCDAzniWLjNxYeQevbUxrNnWw3seMxQ0ffXCcxKQqQNFcv2rPTBl92GLi7PTE
 fvw/5zKTmYnLNVs368Fh+KKP3G58qqpg1c6FmIJOiGbvnRSXOIxVNM=
X-Google-Smtp-Source: AGHT+IH7iqwDon8XGewQLXgOu/1cStkxVfVLr5WLrNmcktmwgWaeERsXwdfPTe57yv3zWJosorlr2w==
X-Received: by 2002:a05:600c:3106:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-43668b93817mr508634885e9.27.1736268740993; 
 Tue, 07 Jan 2025 08:52:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcceb8c6sm14053885e9.0.2025.01.07.08.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C8D05FEF9;
 Tue,  7 Jan 2025 16:52:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Beraldo Leal <bleal@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-riscv@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Weiwei Li <liwei1518@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Eric Farman <farman@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 22/29] tests/docker: move riscv64 cross container from sid
 to trixie
Date: Tue,  7 Jan 2025 16:52:00 +0000
Message-Id: <20250107165208.743958-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107165208.743958-1-alex.bennee@linaro.org>
References: <20250107165208.743958-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


