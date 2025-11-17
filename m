Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE2BCEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpg-0008T0-IW; Mon, 17 Nov 2025 06:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpd-0008Oe-Af
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpW-0005jQ-7o
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477632b0621so27772965e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380532; x=1763985332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNe986N1oAGIBabCsODBcDfYvCszxDoEGJSFW4ycP7o=;
 b=ck5FVhQbf2XHwhZVi7Zqjom1tzOPJ6SrhdpXHPCjzollXq8OrCovzrLyrStxzwoVEt
 8+svgtBerOYVAuLhyKE+wAmTi4ZYAx+SpM2VhO1iya/HL/A/ENCmnQWTb6/8o79F/pdo
 /sN9jME2lapvtnt/pC9frNYv0LNZug2ERk8YhhBOA6fHe11LOCbtGczCju9bXfR1ueeT
 kd2zJSlQ2FUl9Wi9nD7v1rZWkMpUEyTV1H8RPq+GvtA8s17mW2DJvDggtp0J5oqN/oJL
 h+RkdGs/IwUWIzOBJI1ZHzZX4W2tuT83c1/qJLWmYTp7U/NtgnA3dJuX7SF2+N+Dfxcr
 z6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380532; x=1763985332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TNe986N1oAGIBabCsODBcDfYvCszxDoEGJSFW4ycP7o=;
 b=d1mX3EELfVKpjEtI2zkUjH7hLNmu6sDY+2PceI/XXxp85LBJJc0CQKC+FslUuQ6c2G
 ESQAM2GO03u0Sa8OEs5q05+3xYJxz9oS3HbXQZKRDzid6GCuTLrBBQfM62QFP1jEau+g
 I8AA1111t942+YndYS9XrczQYL1lhiPamkNIst51EnIg6gHxkD9DXHpr0vE6kv0c3qTr
 DFGyxla+q66Tc1jS3yrpBHMILjLHCoTSjetACvuiaEAiM4XQ+rV1shkYnbLe8ihKIgEJ
 0QbnH1ADljn1XZXTTH2oacPGB43vhnHXMRkoD0RqtMEfVXgzYqULTv40ioYUrCJHqaKf
 1x3w==
X-Gm-Message-State: AOJu0YzybUnL9zXFrNCyzCWlFyN0vfA7WT+qM6fXk3SrHc5Pjud1veSS
 J14jqS83jhHGv9EP6Qi6UnPvuHxwcvGHdVxFyUjw8MtNkNmSeTKNEsUmUZ/p9XSwIas=
X-Gm-Gg: ASbGncvFRgAoJnU7OyCl6D5m8QlQi5MDlLw5j5zD5QiuFT5dt6ZcFYTAUgnEOHT7PDE
 dr+JcUAfWJ3Mnisr7L7+6sTYWKc1ng+DgGPnEuucchSHSpaTOcpvA8lX3VQDbqOvvEWpKhlb+LA
 l5nhyddg1shh8lBIvUourrFz9e9dmAAuc6qpkoTOZrOYYLnb+cBcDzNDTPluKb8YoMjwgA85jOR
 4e87sWYLMcRHoDVJls83b90rN68YOFb/9KGr2KIAV3OXCI17N/ZuxDXf4SKxB8DTchXNHhfpGcn
 SvwberTREYgM06yR5rBPFXFOolPCB8A6mRRDMW69MCHv70xTe/eeYyTZL2JkI8LOgD14B7ZhE7S
 dodm3N37TUuOHAdN1f1E/GZg0ZnnHFRwcTCChyL67mtZmMxsAa4BQLJD4OF3tBT2ZrBuVriZnF/
 t2tmhPRe/5hZ8=
X-Google-Smtp-Source: AGHT+IGEMvYMkFPRKGN4wUoDcbsbyC2wxVh4Z1nk3SuU5gmtS8Uuk4PMlICNl6kX/PndGaSF07jGiw==
X-Received: by 2002:a05:600c:3512:b0:477:7ab8:ad7 with SMTP id
 5b1f17b1804b1-4778fe5ddd2mr121599285e9.9.1763380532489; 
 Mon, 17 Nov 2025 03:55:32 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd11165sm112199175e9.6.2025.11.17.03.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 45F605FA3D;
 Mon, 17 Nov 2025 11:55:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH v3 10/18] tests: move test_kvm to share.linaro.org
Date: Mon, 17 Nov 2025 11:55:15 +0000
Message-ID: <20251117115523.3993105-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251113102525.1255370-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - fixed download URL
---
 tests/functional/aarch64/test_kvm.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index 9fb9286139f..7545f5ed554 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -19,9 +19,7 @@
 class Aarch64VirtKVMTests(LinuxKernelTest):
 
     ASSET_KVM_TEST_KERNEL = Asset(
-        'https://fileserver.linaro.org/s/HmjaxXXYHYSqbes/'
-        'download?path=%2F&files='
-        'image-with-kvm-tool-and-unit-tests.gz',
+        'https://share.linaro.org/downloadFile?id=Bs8Eb2Wb7yWtkTA',
         '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')
 
     # make it easier to detect successful return to shell
-- 
2.47.3


