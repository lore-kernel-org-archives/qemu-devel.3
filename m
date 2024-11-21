Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2ECD78797
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAWH-0005HZ-NT; Thu, 21 Nov 2024 11:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVe-0004dN-K9
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:26 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVR-00080W-V0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso8976275e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208292; x=1732813092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dp3O7OQ3MnV8QkUA7aQUHJMfCFG23foe3+ZfbczUD2I=;
 b=qjPbzcrJqARFYgAJ6NjiJ/gasr8RR2l6p+Q+qWsKaMdFb3NRwi7BFEc5ybPYULBqTM
 suoE8rVlrj9BbPg90XZmrn0X/z8A7xML/A8ywmLxxLYdF85IuSayhbWRR0NLRNl6pbJy
 99eRQnsfqJtmBUPCm68OOvcbGY1vqSnN3GpPaNJ0I7EEFTR38RgN6zg04GAWlMNuPaqv
 mR7jMMzPRYAxxPcP3iXlGXLVFPTTHphtaaMk6fGVvjt4T74EOWd2TLU2EISvobhYlc7M
 kYQ32h56KywLhO0TIvEJC81ybpDi08SwWwF2TO+ZOLHmKLg9pioh9V8Xau+SLv+6T3xL
 /asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208292; x=1732813092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dp3O7OQ3MnV8QkUA7aQUHJMfCFG23foe3+ZfbczUD2I=;
 b=wa3umxDt19pOl2h5MEkp2WLklSUCoGYEZJ3eStmCze/tB398KpF5zh7ADsTkRYbo68
 5Mu59XUePy9p7ukEtqbtfTOI/JvddimOnxvDv+YA50XRm2IpAeZJlUklel5AFjsvfXLJ
 wn6YISXVc/dp8Bt8/xXEHkMRUbVldVYt6rOwi4g6MOCqPHIJ6SnOgzjwXNCZq/KQIpCn
 Tfh6zYrFUEQq9xp1hDj+2tbpfxFlzbfTSUI0CrwdItQUwUpKaKow2bwcZObuyHmSP6W9
 PlZUTI7Bh1Dq7ifWNla5jeK12NTdpwsgP94WspGmFVZmav8to7vwp6xuwLhNQQ0AfpFt
 /ESg==
X-Gm-Message-State: AOJu0YwA+sV6fS5vOCxqCPUmV/gTmNkmDc8FxqBdLK+uPLd8N3Ul0plY
 HvH3gEum/88rS65rD9fP+mus5eCe+9tE4tLr5pHEXYfkCTR5q1mz/e0PXTPupGg=
X-Gm-Gg: ASbGncunJXx5csO0mVEIVyVMKIYnPkfq0A0Q6jcbMx+/AhtkfFqtuLoSVq/JUKP7d8z
 3r91r7mkCip+2umXBeQnuabQ0Fmy6tfeK/r52kzhArtZzBx974fA/gzDKaWDR7qkfnJAwltaGiW
 0zls8r6D99JTCOBwUwjaCat7ZaOC8kVTVlMzoyY7JqlyWoQRFQ8xH4Tpo2pWWd1YrXEB4QsahNL
 YGIbOe3E1Mc4C8cE1116ghF6nHB38QxNBn3z+TVXWGM9l9p
X-Google-Smtp-Source: AGHT+IGuvjZ8B9pJ41YHj38dXxQihGEDFw8gT3+C8/s8S7wFGUizL5bTtIJgpGfbzxxGthdi6YweUA==
X-Received: by 2002:a05:600c:3507:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-433489869ccmr71250345e9.2.1732208292149; 
 Thu, 21 Nov 2024 08:58:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4616fc2sm61385585e9.22.2024.11.21.08.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C1525FC6C;
 Thu, 21 Nov 2024 16:58:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 07/39] tests/functional: remove comments talking about avocado
Date: Thu, 21 Nov 2024 16:57:34 +0000
Message-Id: <20241121165806.476008-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The first comment is still relevant but should talk about our own test
harness instead. The second comment adds no value over reading the code
and can be removed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-8-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_acpi_bits.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index ee40647d5b..4c192d95cc 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -196,11 +196,12 @@ def copy_test_scripts(self):
         for filename in os.listdir(bits_test_dir):
             if os.path.isfile(os.path.join(bits_test_dir, filename)) and \
                filename.endswith('.py2'):
-                # all test scripts are named with extension .py2 so that
-                # avocado does not try to load them. These scripts are
-                # written for python 2.7 not python 3 and hence if avocado
-                # loaded them, it would complain about python 3 specific
-                # syntaxes.
+                # All test scripts are named with extension .py2 so that
+                # they are not run by accident.
+                #
+                # These scripts are intended to run inside the test VM
+                # and are written for python 2.7 not python 3, hence
+                # would cause syntax errors if loaded ouside the VM.
                 newfilename = os.path.splitext(filename)[0] + '.py'
                 shutil.copy2(os.path.join(bits_test_dir, filename),
                              os.path.join(target_test_dir, newfilename))
@@ -399,8 +400,6 @@ def test_acpi_smbios_bits(self):
 
         # biosbits has been configured to run all the specified test suites
         # in batch mode and then automatically initiate a vm shutdown.
-        # Set timeout to BITS_TIMEOUT for SHUTDOWN event from bits VM at par
-        # with the avocado test timeout.
         self._vm.event_wait('SHUTDOWN', timeout=BITS_TIMEOUT)
         self._vm.wait(timeout=None)
         self.logger.debug("Checking console output ...")
-- 
2.39.5


