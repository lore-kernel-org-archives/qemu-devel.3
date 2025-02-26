Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A756C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI0x-0000wi-0z; Wed, 26 Feb 2025 09:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0u-0000ub-I5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:52 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0q-0005e3-6J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:52 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390d98ae34dso486555f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578626; x=1741183426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZQvLPaKDF+dbYM2+HplYNybWE3eRF4fezEpNY1mdZs=;
 b=a8NcifKhEvXPfotSQLAwq96/ouBJH3ZrYxrnKTmd3WrhxdAZexGuGT5LRH+OTCf/vW
 uMysj2oX/8AF7LG/CnrTN092Gs9O8BYsRuvnMWmfokYu86w/RB8iJrXjtmA4CwHdbSuZ
 sMDeY3vCqFyXsXtKr7Fm0qS7G9yGl+CtQ1irs/oQbr8uKH98wG4X9eoPx2kFUC6ECQFe
 jNa6zleVVAUxZXsyM0Jvie6YqL7nnNcdMDLUru4xEWJFPHi/1CGRLZsAccYjRqoVIJmc
 Z4tLhIjWjNo2fxmNXepqIn7tPNQNkajMYV3tuN8bxgy5uM1EaPizKcZ4/aeMXAESQ5Bh
 4dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578626; x=1741183426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZQvLPaKDF+dbYM2+HplYNybWE3eRF4fezEpNY1mdZs=;
 b=wvXC5KVog5S8fGDx7ksHBk/SknWzz3RChhHydgqSRnk599Ow0OqFneZuagnVv3x7rK
 GoVyaIccFHnaQLdblbX2+3pZt7kQiFI9RVWZ5wnfqoySM8ISxk/Ew2dlZH6IFnvauyHZ
 VzKsJfebZVcK66WpDX8rIGPOLsbNftF2FKlzAxM4JM1YH5q3dAjiyAgZBQupqO2KSjOb
 xg8QzJIqaxpGtAzh5kO4MhDlnNhh9tt0ZGbXXKPYoXW181nOqu8M3R2IX5j+x1Wixwqi
 iEMqmJwoCAkUN+h9OAT3kkNS87KwsHCorsJ+rOjBlOOfST3RDuK3ZqhNunWb0mLqHNvw
 ZRgA==
X-Gm-Message-State: AOJu0YxeMPnMU5tGzatbTfWMx3bDU+r4pCM4AgzbBN4nO1kUd2E60JYj
 I4CuP5b+p63HNbfcaAPOf5q3u6gQGGwyG5PXf/DKMICc89aQtctPLIghf+wzBQI=
X-Gm-Gg: ASbGncuysvtwTrwB9WDV0+enQJqkYYd7uTvJgbI83YGo2jyfkF7xpEwKj08pUPIueg2
 jeRU2Zyjf+cYOy5AIj3CflTQbGKPMLxP2JE6S0grriolGDNSBzpQQFbODr+13qq2WwCtJyGSS5m
 iOJCd1yhXhNZUGZMSvkqqTEspbX13T03qmo3TRvFNcOcUbMJruQuPM5XK16lxQYmcBL/RMASP9L
 Eno3Pag9PtfdEwp5DYV1OYFbmgAcvcYKhOjwereL784n4St75AZc6eGAcWR9kpoHQ3DsJdVGp2h
 RK9OCslIwLArG9YZKlqr4U0ro/L8
X-Google-Smtp-Source: AGHT+IGHwhlbmcmrE4h+SUKRL/ImN7OqEb2rJwVxkeGY6jcKuQKVV1fJVvlJczgkEESuQL8KSu5vTQ==
X-Received: by 2002:a5d:6483:0:b0:38f:465d:fdf5 with SMTP id
 ffacd0b85a97d-390d4f4310emr2644631f8f.26.1740578626364; 
 Wed, 26 Feb 2025 06:03:46 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd88295dsm5655252f8f.45.2025.02.26.06.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F0DD600A1;
 Wed, 26 Feb 2025 14:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 03/25] tests/functional: ensure we have a GPU device for tests
Date: Wed, 26 Feb 2025 14:03:21 +0000
Message-Id: <20250226140343.3907080-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
Message-Id: <20250219150009.1662688-4-alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 06093c6b60..c9463d7285 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -91,6 +91,9 @@ def _run_virt_gpu_test(self, gpu_device,  weston_cmd, weston_pattern):
 
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
         gpu_device = "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on"
         weston_cmd = "vkmark -b:duration=1.0"
         weston_pattern = "vkmark Score"
-- 
2.39.5


