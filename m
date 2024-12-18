Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAF6E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwoZ-0000Ig-6v; Wed, 18 Dec 2024 11:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnp-0007hJ-Va
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:38 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnV-0006qN-8D
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:37 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d7e527becaso2399219a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538875; x=1735143675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U9Od47PCiWI45o7WJdMxF/b5gdEZ4yrNLzNgilwbJs=;
 b=Yc7jeEKOObw1lYRemV1In6dWjEjiqX5VPK0aYs5EvxZ1EkFXzDzpn0OSey8nvDbflm
 QwjOgEDDBi6NQ/T/nrZm2mkb7O/v/1/TZVTHJbUZFJ8Msx5t2hxIXs4HgFVlefW7nsXo
 myCDCIWkMEDp5oXssafE1uaTf9klMb6PPrUTjT+tTk9tffJ+AEjUtmIGFKl5rUsz+EuE
 aCK2Y+SiZ2bbDWcXc1asi5XyCgQuPGxwr1QIZXTpAgR7SZ6PoXxfT7iXxk6P4rEJZEOo
 0PistjJvwo3NBfOKYkOD6G8kJ0Ux1bm8kZ5bYaTX5AWeKmCUmSKACMasskrKCt//IP7I
 QyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538876; x=1735143676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U9Od47PCiWI45o7WJdMxF/b5gdEZ4yrNLzNgilwbJs=;
 b=eGVNKlcvhltXHTV6WM6pFvhoMdPui41puzRz6mvz0/zy1261UmUHtBWuYJApaKFZwC
 8L4g4InCfGlwDgOB7ONTzjv2BhXmFIlXS2F9pizE3Ri5G7HlEfq8xvLke/ePSMQ2pKf1
 rZ3NnC/EdcjOnLOQlMiFdGiY2UbUjpZcrjXpxezVOEnPp1Z2pCFuMf5w+9HdbDQPS/5Q
 ebaLtC8FV22YoX2HiCdh+sCj77/Ku//Q+Rtd9rKmW4ll8hztDndKOJ69eejIkDo69fhX
 kFId8tcL/jtWQ+ASKD5iPFkWCQkJPWEmwrVn8K8vl66EMHuEvYp0mD9DoCzXcX36ycGN
 GzCw==
X-Gm-Message-State: AOJu0YycQxDfvu97xgxn8CDhPmGMEwUcNrKdcn5P9vKuG1GqhiNlxTwP
 hTtWwv9MW7yq3ptiAzhHMSo5KfXajYw+0ZRuF0eXWgqs9I+mAufdN4kSlXhhOiU=
X-Gm-Gg: ASbGncsPoO6oiYQoldcNA1MUK9qcot2uvTSBEWs9fTs72iVo8/sGZW9OlALwSInonb8
 XLPqX49YB4l2SE/Vn1g+j+sszq+FI8t6fPLPFoxW0LVk4NaeOEd2MVFDrblED2c0Ka542S6l5lZ
 TdGaKlsXPh0A9HPXt4U/Yti4STpoj7BilKVTqnCYOlBjqGJTN3Qv6oNC4O1eeIDEKayeRduJXL4
 gtYY3u8eezSwkr4qjqnIQJVuGBx6V7jgWwwDWXQw8fW23O9JsR5Nkg=
X-Google-Smtp-Source: AGHT+IGVw6zNFpzc4dyq8ziuLsEmqlLkWQG4CrYHMSvsm+kZTmgYI+piuHWha8Lh4msyM5SPrF7H4w==
X-Received: by 2002:a05:6402:3550:b0:5d0:c7a7:ac13 with SMTP id
 4fb4d7f45d1cf-5d7ee3fde20mr7723950a12.34.1734538875440; 
 Wed, 18 Dec 2024 08:21:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652f352b9sm5704480a12.81.2024.12.18.08.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5D51B5FEF1;
 Wed, 18 Dec 2024 16:21:05 +0000 (GMT)
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 13/27] tests/functional: update the sparc64 tuxrun tests
Date: Wed, 18 Dec 2024 16:20:49 +0000
Message-Id: <20241218162104.3493551-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-34-alex.bennee@linaro.org>
---
 tests/functional/test_sparc64_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_sparc64_tuxrun.py b/tests/functional/test_sparc64_tuxrun.py
index 1c2c005630..3be08d6102 100755
--- a/tests/functional/test_sparc64_tuxrun.py
+++ b/tests/functional/test_sparc64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunSparc64Test(TuxRunBaselineTest):
 
     ASSET_SPARC64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/sparc64/vmlinux',
-        'e34313e4325ff21deaa3d38a502aa09a373ef62b9bd4d7f8f29388b688225c55')
+        'https://storage.tuxboot.com/buildroot/20241119/sparc64/vmlinux',
+        'a04cfb2e70a264051d161fdd93aabf4b2a9472f2e435c14ed18c5848c5fed261')
     ASSET_SPARC64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/sparc64/rootfs.ext4.zst',
-        'ad2f1dc436ab51583543d25d2c210cab478645d47078d30d129a66ab0e281d76')
+        'https://storage.tuxboot.com/buildroot/20241119/sparc64/rootfs.ext4.zst',
+        '479c3dc104c82b68be55e2c0c5c38cd473d0b37ad4badccde4775bb88ce34611')
 
     def test_sparc64(self):
         self.root='sda'
-- 
2.39.5


