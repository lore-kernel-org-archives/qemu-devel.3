Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933B3CD5BBB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWR-0007vi-Ce; Thu, 13 Nov 2025 05:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWM-0007lW-KL
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:42 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWE-0007Ih-BT
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:42 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-641977dc00fso955841a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029533; x=1763634333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlCHybPzDuoJOci0v74ijY95dNfkhBjmAJIbo8QxUw0=;
 b=qhnaOO09D1uCdnp3gRk/xD5TGO6JNAkGqRN/EMAL3MXAm+pgBkpoZayF8NVMNoJbwi
 W3ANKJWh5zmGIDu1msen8Zkbn1ebykHZtLT7DPVlqtCa2qV7aKXs8SkXhoeEjIGf3n0T
 o+CIlXq+ODn6haDouNIBHB0EdWCvIAUnu+hcX4VhVm8z1ZkG9SX704peA+uTIOzZtnGc
 sScYkXivvJ3hMdHfhzP3UjKYet44/YSObWEgL9IM3n2CxuPqpFawGRDGJGwv9lhnMZd2
 gSThmLuCi/TqjtcIH4pVCZQoY0E4wi/zcwr7duTy054Itsz729YsMcAFaAsJEcsHEbZP
 rKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029533; x=1763634333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vlCHybPzDuoJOci0v74ijY95dNfkhBjmAJIbo8QxUw0=;
 b=wZhE0lEA689c36KxCyKtyqM8syS4cqhm931QvHG3rTiZ7VpOX7jJV+BpwxYDu7AH1G
 qcegnJojUfUi5wxisD4N4Ua8rxTZebtUzCT9rL2amx73SZy/d9twHd4P/8k9yEWXs6XY
 sBKXA6Mlm13ZakmWNiFE3dAcrohKUGkD7JT6ssUDjJYoCwG2rUuS/4rknBRXwOZ14Any
 LlifvAj2MFEeK51N/dBFjIu17QfaUVJf1K/QzE2m1EfGMfAdFH4LyDM7VIyJENP/7TAE
 nstGzuQT3g9AzLWePoGT0URNhhduegWZFEUmmhL7NnCy5pxB12MnF3878pFEIgyv+UUi
 p5Gg==
X-Gm-Message-State: AOJu0YyzxcndNPNMAAsR4/8OzgrrVdXbwFcTJ44NtbRDEyjp2/XtjN2G
 5EeJSpqm45JeWRQVKA8HGmU+Tf5XFiCbyAt0g4Yu+Nywr2X3Nbk4hR4vIT3SKo91XOo=
X-Gm-Gg: ASbGnctD8CzfEw4Wi5qzLgLeUupULNtQ7sTP9RY0amztoTvEVJYOT6oHAVLeUORoT0u
 mRb8JZVAp6qLV0fiMVfaaLvCVo1Ut1qZgM/QFmO+76qtjLu5fdDvrsEXef75JezOI6AMlBHLMod
 C/kfiS7eMxpeDDLgqPXKfc/hT57rU+/AoB0cj34i55JpJkmgVf2a6QzuPQzVtzT/ANbGs+RyYOu
 ESBthMINdYirzv7pMxGerh6xbSz6n0LWnYcTVqhUnp/t3ATaFewl16akProdvx9YyesqBuqIsn5
 hQotkgKzmuXMWhPEYgBCQ/YMjfojl0nXZOruQIENo7cDAksk4BkA946gkT3FLkJcldPe5KBmNvj
 BzLaXNSwWhTnXXk24GhjlEFT1eC38GIB/9snZ9sbP0hGSLWmyp33xuH5vNgX3nBAPDO6J1qh3oo
 /p
X-Google-Smtp-Source: AGHT+IFSefeI3O3NTyzInxDbyr4d+Szrak+Wk48jqZT19jYcdXoczcU1I6FmxlB0Ky6wwAR6+WCrmA==
X-Received: by 2002:a17:907:8694:b0:b73:4894:6e10 with SMTP id
 a640c23a62f3a-b7348946ecdmr282833466b.46.1763029532396; 
 Thu, 13 Nov 2025 02:25:32 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fa81275sm135714466b.13.2025.11.13.02.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9FFD25F956;
 Thu, 13 Nov 2025 10:25:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 07/18] tests: move test_xen assets to share.linaro.org
Date: Thu, 13 Nov 2025 10:25:13 +0000
Message-ID: <20251113102525.1255370-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org

---
v2
  - strip un-needed ellipses
---
 tests/functional/aarch64/test_xen.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/functional/aarch64/test_xen.py b/tests/functional/aarch64/test_xen.py
index 261d796540d..d90595cad35 100755
--- a/tests/functional/aarch64/test_xen.py
+++ b/tests/functional/aarch64/test_xen.py
@@ -25,8 +25,7 @@ class BootXen(LinuxKernelTest):
     XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
 
     ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
-         'download?path=%2F&files=linux-5.9.9-arm64-ajb'),
+        'https://share.linaro.org/downloadFile?id=RRahAWwAwYKTZQd',
         '00366fa51ea957c19462d2e2aefd480bef80ce727120e714ae48e0c88f261edb')
 
     def launch_xen(self, xen_path):
@@ -55,8 +54,7 @@ def launch_xen(self, xen_path):
         wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
 
     ASSET_XEN_4_11 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb'),
+        'https://share.linaro.org/downloadFile?id=ALU4n2NGGYbE4fO',
         'b745c2631342f9fcc0147ddc364edb62c20ecfebd430e5a3546e7d7c6891c0bc')
 
     def test_arm64_xen_411_and_dom0(self):
@@ -66,8 +64,7 @@ def test_arm64_xen_411_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_14 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb'),
+        'https://share.linaro.org/downloadFile?id=os4zSXPl7WW4lqX',
         'e930a3293248edabd367d5b4b3b6448b9c99c057096ea8b47228a7870661d5cb')
 
     def test_arm64_xen_414_and_dom0(self):
@@ -77,8 +74,7 @@ def test_arm64_xen_414_and_dom0(self):
         self.launch_xen(xen_path)
 
     ASSET_XEN_4_15 = Asset(
-        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
-         'files=xen-upstream-4.15-unstable.deb'),
+        'https://share.linaro.org/downloadFile?id=jjjG4uTp2wuO4Ks',
         '2a9a8af8acf0231844657cc28baab95bd918b0ee2d493ee4ee6f8846e1358bc9')
 
     def test_arm64_xen_415_and_dom0(self):
-- 
2.47.3


