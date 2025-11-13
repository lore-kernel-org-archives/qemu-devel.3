Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BEBCD5BBD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWU-00082D-10; Thu, 13 Nov 2025 05:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWR-0007xB-Td
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:47 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWH-0007KZ-EM
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:47 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b72dad1b713so91237466b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029535; x=1763634335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZHfy1fDQhmHrgPlYUJxZXN3O1QxQXWctC2JvDVkN54=;
 b=MZj7W1v0/rdkyYOhS5vlvrhr+rwOtqr52FngjWuQKo8EHpPlVDUuirCyMKbINQ6qqi
 rY+6GNhIyWNEeUgOuCbg4UE3Tbygnclc+8CeNcLL6YLdX7f88fvgrdVzb5taELXAbWeS
 rIimSayd4XLY6CCc7j8+2pqMDG3jXPJ1bo4Rqp1b90z+GRSmyMHY0jRWkDScnNubw6MG
 ZDD0if51tZQYFe+PxaD0Hed83g2zajtxnJ4ymW/XCqpL27tJuQLBDHTXJ/IjMEFrON7U
 BRz4EfgThbLnz8tC2NFGk3/P+39AGLgl3K55XF4cy8xASQFFMBzj6QMPGmWPYjKMKMa7
 Azlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029535; x=1763634335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LZHfy1fDQhmHrgPlYUJxZXN3O1QxQXWctC2JvDVkN54=;
 b=o94Mdmbb36q818uX6qfGFemXZmitUtrByAeHPmT29qFoxndObpN4L/LRBXc+drUNG+
 xeFaHL6ggZVE9iLJUvU72V5cTvVyXMGkhAENXAOiWgb+KOhJyeEqQKufK/KAAoN2cV9l
 7bVnBwwB/veeTbp8uk9rWIn5c6Ea8EuFkxxQxafa3gLn2M0NFM3WdPbTnQIllDjZcHI2
 KAo15r8YeNe+TYNXnWtpfvW8VS9EcBdwVT4z8O86dmppaIdSSb0YwpoShLwZPNAh59Xb
 Gr8xfS8906gc/2MoPIscjttOjhMyWywEGvXHkUzYO7hsHj7SN54xS3C66qrk9OhSRw2S
 XhhA==
X-Gm-Message-State: AOJu0YyJJe6xAoynHOk9wYgbiaD73OzYqvIIsLiUPqhKgLD4JUeDuP8F
 2em4SG/JubUFRMlyfybMJ2eUaYZsSq5ggJFkASSrGmMYbqyl3j0ddqa2xZq2jKfN3co=
X-Gm-Gg: ASbGncthDWv0qVkRs5fOWlBremWCI96MD0PHID77LsJJB81344tL1YokMi3VsNKY8hj
 NoIGMc7tzEZRMR3dWb4scwCOCusBP822mFZSNJrrD8iJnhM6q0mLiqiIwc398Wv7Mw2lZBqe+qk
 XL+MH1RQDiJtlyMUBj63solQLWwJHQ26RPvD6WHqkjLz/HwU8tCfHjCHqS4NtVzykmFaZtextSs
 ujd2bjpZllGG3msRPhImRrhrJ7dEuzUqO9kpNFd3f06B4sPYNpBDlwUBEOANJnQPdgwvCO6iqMR
 sgixN8OTHVBFxddalZZySkw12f+2mJZn6mHaj1zUbyfFgGdys4SU4tEOJ2cDBuiwcyI2gxvH/FT
 IRsBjln3xZt3Uk7cLnT3xgN2HDS+JJLLeKdWH/jNYrzdk084wP21TTp/mmUaJi2FI6S57pyH3Or
 EY
X-Google-Smtp-Source: AGHT+IGCj0v6Ge91/as+pZ+yCH8uvkTWHMynzVHIQw0uD1UlgZtepQBCd27gBeFwL7tvPUMHRaDG8w==
X-Received: by 2002:a17:907:6e93:b0:b72:9d0b:defa with SMTP id
 a640c23a62f3a-b7331ab3429mr662951766b.41.1763029535507; 
 Thu, 13 Nov 2025 02:25:35 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fa812a3sm136349366b.8.2025.11.13.02.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24EAE607D3;
 Thu, 13 Nov 2025 10:25:27 +0000 (GMT)
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
Subject: [PATCH v2 12/18] tests: move test_virt_gpu to share.linaro.org
Date: Thu, 13 Nov 2025 10:25:18 +0000
Message-ID: <20251113102525.1255370-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org

---
v2
  - indentation for long lines
---
 tests/functional/aarch64/test_virt_gpu.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_virt_gpu.py b/tests/functional/aarch64/test_virt_gpu.py
index 4e50887c3e9..c26a1f20c65 100755
--- a/tests/functional/aarch64/test_virt_gpu.py
+++ b/tests/functional/aarch64/test_virt_gpu.py
@@ -23,15 +23,11 @@
 class Aarch64VirtGPUMachine(LinuxKernelTest):
 
     ASSET_VIRT_GPU_KERNEL = Asset(
-        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
-        'download?path=%2F&files='
-        'Image.6.12.16.aarch64',
+        'https://share.linaro.org/downloadFile?id=lL8wgnMmSXZo7Co',
         '7888c51c55d37e86bbbdeb5acea9f08c34e6b0f03c1f5b2463285f6a6f6eec8b')
 
     ASSET_VIRT_GPU_ROOTFS = Asset(
-        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
-        'download?path=%2F&files='
-        'rootfs.aarch64.ext2.zstd',
+        'https://share.linaro.org/downloadFile?id=qOn1wbfKmS6KVHZ',
         'd45118c899420b7e673f1539a37a35480134b3e36e3a59e2cb69b1781cbb14ef')
 
     def _launch_virt_gpu(self, gpu_device):
-- 
2.47.3


