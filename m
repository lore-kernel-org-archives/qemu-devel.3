Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F395E64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR93-00014r-Cz; Tue, 03 Dec 2024 06:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR91-00010L-Nl
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:43 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR90-0000bu-3J
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:43 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so45258685e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225560; x=1733830360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Psz6QYjNWfaE66z0yRJOGzXu5KyUodxfagJJPxkvaQY=;
 b=gj7kK/tDusnQTxv5C5adruWXrIEkqyN4SeY414yHKLVjdu/7v278pLvynYzWKET5pb
 xI7MY2b8RRoYQr/hhaEfTUODq3/XD5kDjrmtW9xMrDNWULxIsV4KJFCln26AkOk5zqoH
 0bjVaTltwqETVBUvQaBq7MPNEKT6mUJ9zLrJAHum7Fd+PHw3j8IiS15SK1lVuglycAzY
 uFMhUKEPLt1P5nQH2JSahi3HZTZeGTkdv0lnden5w7GAZL5+YcecLBYJTxfR9mOXmJ7K
 QfvN6C1POTuKyg66f59bFWpD4eXduCYuUW6BDrP15gnrZJMiWxY5+c/2MtaOGzhd0IPq
 RZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225560; x=1733830360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Psz6QYjNWfaE66z0yRJOGzXu5KyUodxfagJJPxkvaQY=;
 b=iQMRxhAAaJCRtwOjB87r2vP1hiru7GubwIDTRnrVi3CzAwRvF6El4kJ/9nVsnYvN4p
 SZSsHJjzmDUvmJ/MR8Rhx0APeyb0RytDt27QYKg8zOBO/t6hozz2i0XgFb/yKxeuB2tr
 5K7ZuRjTCOwfw3w2Muv4Oe9MRA7MVfcvZVF+JuwAI36kFBDDMgHYFUeTcwGlbW8hDKNL
 jocvo9b46VxRaRPqtssFNyW1ctT38gJU4OcDjWktrC/Ctxqk0A2xrxQS3jmy7ZoqgILa
 vN5kr6XZI5hY8Na0RmZ4jMCzrl4v/OEuJ+QzwA/wrE8AWpO8No1mX+6ziB5URv0ObXx4
 STYw==
X-Gm-Message-State: AOJu0Ywha0nToedStExZr3609wf7lq4VLlFlt7IDCQZiZt9xhfcKfaIm
 r7nM3VnTgxBHNwDIttcGQIRuCMDsRYOZ4yR1VAe7d2f9MLpuplulBDoCrxLEmKwtSVgdZ9mwlyn
 nMTE=
X-Gm-Gg: ASbGncvUAZjb+cyOCkBp3i4D8KoX0GryBpEWx1gptU7nrrjD4NFJCkIQBE7ZlVIkqxN
 DzXW7lHBJb42ELY9uLk9Oy95uAkGe/Nr+S8bFKHpih9Vfa6ocZpmsLiQU3vpBRnnM1EYFPQ0GNn
 nwVi3QWp/1fo4WLg++cDhJzrwnSEOVvPuVr5F9yaC6avYd6u9NHNDYQMFezP0Y1xhnALIpbIOo8
 dLvgIbn3qhx1So8WRSWnVZ8ZfVse5RYHaPbhzWgQcdJafRFb/okVTbvDn9SWsU0f9bNs6+y
X-Google-Smtp-Source: AGHT+IEVoz8HWXjkCJ3vM0xt7vv7wFXmlvqdiFZntTPPhK3tn5QsZM2exo7j9qEXEn7GlARXjN/omg==
X-Received: by 2002:a5d:47a2:0:b0:385:f47a:e9d1 with SMTP id
 ffacd0b85a97d-385fd3e8f33mr1665357f8f.17.1733225560021; 
 Tue, 03 Dec 2024 03:32:40 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e19104a0sm10690514f8f.32.2024.12.03.03.32.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 11/13] tests/qtest: drop 'fuzz-' prefix from virtio-balloon test
Date: Tue,  3 Dec 2024 12:31:38 +0100
Message-ID: <20241203113140.63513-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

This test file is expected to be extended for arbitrary virtio-balloon
related tests, not merely those discovered by fuzzing.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20241129135507.699030-3-berrange@redhat.com>
[PMD: Update MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS                                                   | 1 +
 .../{fuzz-virtio-balloon-test.c => virtio-balloon-test.c}     | 4 ++--
 tests/qtest/meson.build                                       | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
 rename tests/qtest/{fuzz-virtio-balloon-test.c => virtio-balloon-test.c} (84%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f92be047756..aaf0505a214 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2228,6 +2228,7 @@ F: hw/virtio/virtio-balloon*.c
 F: include/hw/virtio/virtio-balloon.h
 F: system/balloon.c
 F: include/sysemu/balloon.h
+F: tests/qtest/virtio-balloon-test.c
 
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
diff --git a/tests/qtest/fuzz-virtio-balloon-test.c b/tests/qtest/virtio-balloon-test.c
similarity index 84%
rename from tests/qtest/fuzz-virtio-balloon-test.c
rename to tests/qtest/virtio-balloon-test.c
index ecb597fbee3..6bea33b5901 100644
--- a/tests/qtest/fuzz-virtio-balloon-test.c
+++ b/tests/qtest/virtio-balloon-test.c
@@ -1,5 +1,5 @@
 /*
- * QTest fuzzer-generated testcase for virtio balloon device
+ * QTest test cases for virtio balloon device
  *
  * Copyright (c) 2024 Gao Shiyuan <gaoshiyuan@baidu.com>
  *
@@ -30,7 +30,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("fuzz/virtio/oss_fuzz_71649", oss_fuzz_71649);
+    qtest_add_func("virtio-balloon/oss_fuzz_71649", oss_fuzz_71649);
 
     return g_test_run();
 }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f2f35367ae7..bd41c9da5fd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -88,7 +88,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_MEGASAS_SCSI_PCI') ? ['fuzz-megasas-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_LSI_SCSI_PCI') ? ['fuzz-lsi53c895a-test'] : []) +     \
   (config_all_devices.has_key('CONFIG_VIRTIO_SCSI') ? ['fuzz-virtio-scsi-test'] : []) +     \
-  (config_all_devices.has_key('CONFIG_VIRTIO_BALLOON') ? ['fuzz-virtio-balloon-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_VIRTIO_BALLOON') ? ['virtio-balloon-test'] : []) + \
   (config_all_devices.has_key('CONFIG_Q35') ? ['q35-test'] : []) +                          \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
-- 
2.45.2


