Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF27E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV1U-000370-MJ; Wed, 08 Jan 2025 07:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUue-0000ur-VP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:12:06 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVUuR-0007IQ-Mw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:11:52 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so31376305a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338266; x=1736943066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U9Od47PCiWI45o7WJdMxF/b5gdEZ4yrNLzNgilwbJs=;
 b=mzGqMcr7z7RxGJqDqIC1heS63soty7mhqWWfXRGwsHY93d5ySdZlDS8nMMN8FcrIE6
 NADT7QqoXRBogft+BZBmBdpoWhjJaNi7G3o2dfpIprVoiRmKPmb+yFoGOy1p879dTl0f
 RXUAK7RM+zAhy4y8RSI0zp6vxKr8MuZpIhsD9jA8WyH1MfJ6njx/4dyE5qRMJKDQ/bV5
 g9B5/zo34ZHgMsZN0uV9g38XryySjlXnEOXLCvm9roe3NMuu1norqR6ajFjZM3NJ7ixJ
 GxOPSkYjV2oKUYqEepDnnmGQ7CfulAZPCOOfwcqBmSKxakciW4vCwM+rU2/cVJMxSGmN
 qFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338266; x=1736943066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U9Od47PCiWI45o7WJdMxF/b5gdEZ4yrNLzNgilwbJs=;
 b=Di4mT19wc+wSUXDTdQW6eUKglMTFpkxLiOb9+nbO0/8w9DqiTBdXSIVqTWB8cbMVPU
 ZAzTAL4uv87AshEkgxib4QG18YTar4KLgW3OBtrPE+1d+LK9cxGSS+ZwJsMUsaupyUEB
 RelhQaGe8TIz+EfCLyFmJRYVLdDPgKJX9SmXV+wMcBGwXyT4Crww0QbAnIuBX7RmLciv
 lHym5WIQ2lH/AuzZP2502QYEXB/sk8/Q4u6b9pK6WQ2nIMfoJJtwCmcN7FnyHrVAVcJy
 mFqUrFrh5ocPt48soaanHAslUdegVSX5WbPfJvFm6Wy8sZjziAdkDMJ1rNF/9UsuX4XS
 hIyA==
X-Gm-Message-State: AOJu0YwyyjXemafOFEeuCAxld3ZwGlmW/nxH0hX/clYJiRocw35wp+/J
 nrQt93Fdo3AuqUBXLc4ALxEfgWoMs7GgI1VenCiEn4BQrRDRNSPIqnS6sCGcL28=
X-Gm-Gg: ASbGncuBJmco/JBVqnGhzN4aTouqezXsvH0NviY4ITFwXa61gTJRowWQ+vZeoBmccnk
 VprC8bOPlxd5EOZU+abIIsL35rlDdvxFQoXwB+ijNFD9ZCc4fuEd0RzN8oA3IzsFWtymGWeJGY5
 A+bdrmAHF+AhISDRTJBY272/O2eHAzQYAodUTveUhfdmT3+ICocwBuCY3Hq5OgRn2JXKEIAvkul
 MDrzOXD0conyom0AjG70CXNDRHbngPyRDkf+hesE8qsiijAuYeCMLM=
X-Google-Smtp-Source: AGHT+IE4/7HfEr1rKZyUBxcjVIcFjh+v0jCyBOLGAm/OgQeBMB1/NZ8naf83bJeHe1mWVEy7fuyp1g==
X-Received: by 2002:a05:6402:27cd:b0:5d3:cfd0:8d4b with SMTP id
 4fb4d7f45d1cf-5d972e6e3e4mr2214001a12.33.1736338264827; 
 Wed, 08 Jan 2025 04:11:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f013900sm2499453766b.144.2025.01.08.04.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:11:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CE2635FA6C;
 Wed,  8 Jan 2025 12:10:55 +0000 (GMT)
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
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v4 13/32] tests/functional: update the sparc64 tuxrun tests
Date: Wed,  8 Jan 2025 12:10:35 +0000
Message-Id: <20250108121054.1126164-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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


