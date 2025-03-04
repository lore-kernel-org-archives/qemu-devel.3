Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06298C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpah1-0005OA-67; Tue, 04 Mar 2025 17:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagw-0005KK-1Z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:46 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpags-0006TF-WB
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:45 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso1174747666b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127081; x=1741731881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFMmkDHtawhhARFWMO1eCV3OspPEPY+ObvqNfaMPI4k=;
 b=OfGHA9n1OrEIH4V9Kiacxoi4zMw/ezQHnjohVjjciBX1fNUFCo/PPNKUipEXEzNrRi
 pblQZbtWae//VYVrP9KhBJReLtumY6uz/EYgBAmXfHVtiq+XxrxmRKasvxeTY2BmxdoG
 sF0zDlakzBm2j5M6p8r991JlSPaYPTRJ26/WLZesofSnqkNH45+sF/RfNleWNoHdYO5I
 6Jd4ShWevJowex04NhpTEV4v2zcWmUuwAuqCn1DERvpkjDbCVxL4xLS2esj/IE6T8DMu
 ypdyeE1x+p5igQSbXwzjwPzvfLGAKtuOefIqIyTpnCz+hg1GCnmBbz2ab3EmjOTl7pLu
 OZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127081; x=1741731881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFMmkDHtawhhARFWMO1eCV3OspPEPY+ObvqNfaMPI4k=;
 b=sOj3afzXl8ByB7x3TPmQY5bHDoozKrfAzoSbyE41i5vIm1PvJ8fkv+DZeUVmn8CzZs
 9+Huh8m+T+fdE3QjTooAFKkvOVxypOPyaiweDlZS0Pwiegz1psFVSs68ymHqvkzdUThi
 ECMVttGWF9/izjiPIDoQJcAoh//wczt48U2ft0p+s6AOEWeseRXcZIBgoQxpbn1/zjD/
 HQl2hjxNqz/YxcnijxK2WOZBxmh/hvZfq3e7g1EOCDwcFX1xFEbukJcvVNOqz22EuiGP
 B0YqtaGerMgyCs/PhJZgmoT9j6wlT+SYfZhd3+avIiM+sOg0QyrWQrfIioivO5usW3vp
 E2jg==
X-Gm-Message-State: AOJu0Yw54022NRFvPZYP1QbTImfQNQ5EZ40Y2SRKDO3x9E0PAzV6FkE6
 53sJ1Xq2z6i9TELSDiVhyFdE4GRVmmPmHTGF1UNvpTAJuHRChRMJni+EQTptNRs=
X-Gm-Gg: ASbGncuO6sFkOau3f02a+c/msvLKzJS+ZuONjWxMbXwMXEeX+KxY5q4EvdJSY4qf2Z3
 RtFWC+fgfBLP3ajosDk5gQnoU+AUaK9zWFFaukpU/p1/9SvT0jetzXW4ML1T55/oSdSBiuO1ei0
 8EaXKYPEYzYrBqxTXlsX6lPBHpO3UUz48fa8FfgIWCohTA+lQU9JPO1/BZ2McZUyIFQCBfy022x
 iSvsdr33/tmZl9oLVrP1ckDpujhD6dHdU0sIYgDHBVxgkgFnH8jyql8jm1YUoSFF+mknszvBMTN
 bpT0O/XZ1YIG9ztbsXF25a85xa695GMzU4opfSwVUd9ZvyE=
X-Google-Smtp-Source: AGHT+IHwZh7TkwJV7DRmtlPpEfA6KtNehl4c9aTzdgy/AZnbCsxDqWsb812dwrJ/3vfEtTn9mBwBCA==
X-Received: by 2002:a17:907:8688:b0:ab7:9df1:e562 with SMTP id
 a640c23a62f3a-ac20e42961bmr86717266b.48.1741127081286; 
 Tue, 04 Mar 2025 14:24:41 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ee491sm1030467166b.103.2025.03.04.14.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A81135FC87;
 Tue,  4 Mar 2025 22:24:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 03/32] tests/functional: ensure we have a GPU device for
 tests
Date: Tue,  4 Mar 2025 22:24:10 +0000
Message-Id: <20250304222439.2035603-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's possible to build QEMU without support for the GL enabled GPU
devices and we can catch that earlier with an explicit check.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250226140343.3907080-4-alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index bd325577c0..4420a6175f 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -91,6 +91,9 @@ def _run_virt_weston_test(self, cmd):
 
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
         self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
         self._run_virt_weston_test("vkmark -b:duration=1.0")
 
-- 
2.39.5


