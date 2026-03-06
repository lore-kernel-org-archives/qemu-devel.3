Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820EEFCB61F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXs6-0008Ln-BV; Fri, 06 Mar 2026 11:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXru-0007KW-LF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:42 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrq-0007jd-Dr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so110085915e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772813852; x=1773418652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urxW2gg1DQqa1lFTmb1r3ld5F0FP1d2hWKlK17rzMHU=;
 b=Esr1DXZzIc01HPZGvXgIip5XRzdZGG576UoECKxs8mOsdmyBlqX4+NEOufbvDSMwlt
 4hcQZiMO9UC62zLtlQRi4dCb/JVQJqm6PXZg0X/AG+w6/f0W4wnTXuMlr+lzZTwu3iFH
 /DXoYBfYNBL9cVcDMAen/oEj0EgJbk5WmuOxPI0XUMp2NJg4RoSRfl2C1oEyJF99Jg6X
 wOnx/zqcdpitEbf9fW1n2lUHKfjhm/W9xq7JRj5D5MdEgAXN4dd7zrFuG59qrrHbExFH
 db8bNTAJ/2PX7ET9cVYdbVe9pp925MTmHpVjYnkw2imOlrN7KJ84ofGF2HSVvqD5R/3V
 Bk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813852; x=1773418652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=urxW2gg1DQqa1lFTmb1r3ld5F0FP1d2hWKlK17rzMHU=;
 b=pYbONQ0alBjWDEEuAe1D+zzBQHg7KgM6Kib1upqRK/5lw1lxTwnXszshwW5m7cDCIr
 QFVNgKTBUk8RE0a5wLLTtC5K31u/dBCpG21S92wRJvUNrRQNsMhacHDg0S7N21AXjE98
 tO/E4w7A0wVcoqhiMjpZ4M08CT5DBiV0ycZ/AdzC+ezEx1nJoAHjMCE0Cag0VO1qhguE
 12PybS5fuqhpkfyqqnBQsVUhXkl5Ry3ibGKXgyBMqv0x7VDCq5CDrSgBzB1zwFu5YZTd
 ItAZcgZv1LtRePAQWfeYAQyNvYnx6XJzKWf2TXuWkiWEqXPpkOlKxF/PyWGoTYP+03Ly
 n6wA==
X-Gm-Message-State: AOJu0YzxYETEiR1m90K+pStPzFuFwlkRdqDWMT+x9lHj9AFQwvSmtrKR
 oGSHdnC2+TokSLLX+8jtkZ1coipt3Md/VvIg6JFwdTlgswJgMzt0fHZYwX6Qbor1dkE=
X-Gm-Gg: ATEYQzyr4FuwvDJNq46k30P/6ML3qSgIN6FfK5+J+j973LoZTv18LyXJybt8BCd0pUn
 dSzir7uJCM4z1j0kmawPzXxxAlodopbMSYLLWbdWCOUQmCnIOKly/gZPSwHTBcmbIGFZ1zQwJsr
 PiM/HaqF4691WEaMZWlrN7zPnQDnD7FgK8WR+Nt6X4kG3vwiLMoQwRk95w6VCIS3VOwXlpqoGkL
 obL2WtbrLXdJqsgVB/i45OhhNsGJOmwgijVB5kvWZFgNSy9GBJnIh4Mo7tt5XT6GJ0Me7pD+HbM
 IcEiq80Rrcj380cNnEtBsMFlVBzcnuEcflxbHPkdNttjLQkgQkRUof+P2p+r3PN+IxtaMuOSexg
 Tzq5lZCOlIpi8gky7BuInh3E5+FH699fGmky3OBSTQdvzWXsi2OU84W+mjGtCMOSkp+8820DPii
 LhxL8DBIB67oBGDUQ9kwe/5ig=
X-Received: by 2002:a05:600c:4e04:b0:483:b3d7:2e80 with SMTP id
 5b1f17b1804b1-485269792e8mr41238865e9.33.1772813852424; 
 Fri, 06 Mar 2026 08:17:32 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246fd237sm38156665e9.7.2026.03.06.08.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:17:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EDD0E689D0;
 Fri, 06 Mar 2026 16:17:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
Date: Fri,  6 Mar 2026 16:17:22 +0000
Message-ID: <20260306161728.2657486-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306161728.2657486-1-alex.bennee@linaro.org>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This allows the gdb integration tests to be run as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
 tests/lcitool/refresh                                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index b73776d95b5..287770a995a 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -59,6 +59,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   clang\
   dpkg-dev\
+  gdb-multiarch\
   libclang-rt-dev
 ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 3e4b026035b..259e6ea0729 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -167,6 +167,7 @@ debian_all_test_cross_compilers = [
     "  apt install -y --no-install-recommends \\\n",
     "  clang\\\n",
     "  dpkg-dev\\\n",
+    "  gdb-multiarch\\\n",
     "  libclang-rt-dev\n",
     "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
     "  libc6-dev-arm64-cross \\\n",
-- 
2.47.3


