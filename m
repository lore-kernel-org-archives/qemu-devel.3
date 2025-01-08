Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D416E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV52-0008Dh-2Z; Wed, 08 Jan 2025 07:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0o-0001sj-9k
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:23 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0g-0002R2-4q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso12660619f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338684; x=1736943484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG7MbUBeLhp7BGSne5jxjhgnKJrC/8a0zBr1FqLJA6g=;
 b=y5UGfwXqMAp4D7VDE4KV1B3mzMTzOqV+3PwDTg/HNSUbkmnKK0XJS/qz/wI/5B/19q
 zRnRUXUkBaHZt6rY3MWzbBsbvFVnObR+5sjAaO6afpEVSmo56fCctIyJ25OzX3IUgUsZ
 A4NlANj7FGLZV+HWCDlMytPWvPMIy7qGwNa5TYAxdKfdFJVXVbu1NAhM1tN3YG9Vjp8V
 dlPXqfSBYd6KGNJyhFLj+WN0TCWHnlw8WZlB6cpYoiGCN5p+VPhJu0pNe0Na0HD2HXq6
 EFgHU5mTZZFD00Csb13RLx74dZrgNxdOKwGr0FyY6yqygb1ZwNj0AdyXTfb1pASfUlL4
 2P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338684; x=1736943484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG7MbUBeLhp7BGSne5jxjhgnKJrC/8a0zBr1FqLJA6g=;
 b=MKKOODID9/cmFHy3BrA9XkHH1It1totcy/6R00+eS8Z1TC2uRvMi7SYD//KzM9CIZp
 hnYoJrgmqq/lrSIFIYqCS0lIJjWIDZKcFUm6Y0m8dsBRQVEdz1UHechjefm890/Hsh9I
 u6i0ts4N+Z61wq7DcgFWjBJsEJO/MBNC0CV1b6nZ+1x1zFwIBEnMfKCzD4oMl7f5f5gm
 3VeQPK63yGGhUdz4KhjOGBtc2k9z5tvzm/i1oLmsgHKEp1YcI0x+ZayExm6oVfwwP7oL
 7G/3uRQUeQJ7wXYiJRhzW20kENUB2f3067gqzOCK/fupebsm28wfPdBoA/40SXvotqa+
 dQmA==
X-Gm-Message-State: AOJu0Yx3bOZpjMkJry0cfBIClhh9dDhMhf2W4ndtL9essWF3kaZtKHnt
 qQgHAjLvYbIRc4kzcgbj5n+aULpkZFiejndp4EXg87WJpZESI45dFYygM/68Lx8=
X-Gm-Gg: ASbGncveCaoFfkkfUuUNSYtm/WSgFIT4JRhCZN0vU/FrrwZ2HGMc6wtiohdRbbVjJX1
 1xCGjspouHh5FhuQEZN0HtPfwix1j/TUqdhfCYaGtsi8R9rAC5OKldcEKMGyCia//bod68lNssk
 Lm49yenbnyfs4GytqmuKc864oYyQOG0t2MJ0inBGbUDyrZq2EeYWABvTjtQIrbnQUand6kiZxQM
 tGRvTColmJ7nGf6j36MLEWU70iA2iDoiN5pvOorGK/6ajnqpEcMGDc=
X-Google-Smtp-Source: AGHT+IEHZaAJ2SD64vSTdEjjQ7QTQR+yWe/VeRHzhza3WgYtMZRGPoDVhS6c1AsEkSs4m1a8PJy8+g==
X-Received: by 2002:a5d:6d02:0:b0:38a:50f7:24fa with SMTP id
 ffacd0b85a97d-38a87357a07mr2199041f8f.54.1736338683967; 
 Wed, 08 Jan 2025 04:18:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474c2sm52129192f8f.55.2025.01.08.04.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0757A5FD35;
 Wed,  8 Jan 2025 12:10:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 25/32] tests/docker: move riscv64 cross container from sid
 to trixie
Date: Wed,  8 Jan 2025 12:10:47 +0000
Message-Id: <20250108121054.1126164-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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


