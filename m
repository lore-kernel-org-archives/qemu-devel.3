Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5919C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1gL-0006kR-TF; Thu, 06 Feb 2025 08:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fs-00061f-QN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:12:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fr-0008H5-AJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:12:08 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso9710415e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847525; x=1739452325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ca93GC7mN6YPt3WWqji2t66DsugWAK2ak9CpDn3N/CI=;
 b=RURTQN8ctGT83eS/AVxCTh1cuivsavHE4nwcjcBi26kl/blahsMr3RoFSqr74nVmxy
 yZjSXeLWTuP6QBuRXNDAagNNspzOfJngGmvnZz28jZkRkrQaMtfxOSRhYsZ6fMm5wQ4s
 kh2T3sjT2jQGVeWJ72eSUvjsPg1w6nBapRk5uoCZ2ltqV+LTNectb8ZGxGZqETZI4VWw
 4go2bRxQcuJ5D9rJnueOzv+Or3130Uld3sENmuPkojKJD70jcgiq8iYvBeFZuweSl8gX
 6R50iUXJAg3DNWQdmvgZXMvsv3xPlORd5+AC5IdKu5QWDlwJ8l3BAjgnC4OTkGn9tnWv
 fqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847525; x=1739452325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ca93GC7mN6YPt3WWqji2t66DsugWAK2ak9CpDn3N/CI=;
 b=dCFGKnvCRZoy8jP99e97JTpDQ4s9hyeU7WpACqG6ZErv9TBD4ptCI1BYj+6f4WZ6OM
 q5k4z7w8T2aUKM4KmzE7UXfObrQzBO3gHPaARKdXdBDAF3hBzPs7url6Di7ealKXAoXa
 lUCfVGgYZwFeSa5CZ1belXF6qPRvh2HRthYW8UP0jVwdGw9Hz5lCXH7BxWnSky35DrkX
 wWBkCl6zr5KIEpanHBA9UVe9kZFg8XolPTBvuAIV4nfB33ddmv39ofip2HwdprEMWkub
 jHA1LBQNht+SI3bNWQo8SMR3bn4lu0czQg7hNd/YLfNFs8lQxKYWBufyXiN4Mgbo7ZbK
 0STg==
X-Gm-Message-State: AOJu0YwPHa3YH3cSaIP1w7ch/IoR2mQCFSsR06pd8OxF7hgdBjsp9GZY
 6/Y01rUVuTpCsv9fEz1LFFgTB4TJftjP81iEXrXKJxLxRnnml0EtrzvBkp/7jhJnuNLKLjUQ96a
 XFEA=
X-Gm-Gg: ASbGnctKrbk059JtAYaxpAHie72Egv/bFaJKQivhVSYY+D4xDDGZudD1s/iW9b0hzHr
 ViIUj2cwjqxV0QRvf/qay4gnHsJNsBJZF31Ml8XbRD4fsp1L8iknVMj99L3MMANkLnD0peioJ0X
 mgZxK/YkfDGxOAG7SYrOeCAIsnSKzP5qb2Z1I2DqHdw1qtzWQqqKTp24PpyT75V77TAAhqrR/LL
 zCKNn14VCmAbGrho0iLBdAIrPSgjpyicWbP25fGZIooDgtroaz0NvI05AUcj5W273hz86EzEWIp
 HRNuo5bV9aWgrVYACWupUI2qAoT9My40kDJ0brFmfAqdYuqDeWVZPs58Ke1D9wcvLQ==
X-Google-Smtp-Source: AGHT+IFVqjzXuEnDnkml/M4VYwoPKSCPNEhDXI3KviyMluXcIVCf/140gsFk7GgkK+a1VJhE/rPREg==
X-Received: by 2002:a05:600c:3511:b0:434:a202:7a0d with SMTP id
 5b1f17b1804b1-4390d569890mr50269095e9.22.1738847524879; 
 Thu, 06 Feb 2025 05:12:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd1af14sm1703873f8f.8.2025.02.06.05.12.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:12:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 14/16] tests/functional: Remove sleep() kludges from
 microblaze tests
Date: Thu,  6 Feb 2025 14:10:50 +0100
Message-ID: <20250206131052.30207-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Commit f0ec14c78c4 ("tests/avocado: Fix console data loss") fixed
QEMUMachine's problem with console, we don't need to use the sleep()
kludges.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_microblazeel_s3adsp1800.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 715ef3f79ac..60aab4a45e8 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -7,8 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-import time
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
@@ -31,9 +30,8 @@ def do_xmaton_le_test(self, machine):
         self.vm.add_args('-nic', f'user,tftp={tftproot}')
         self.vm.launch()
         wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
+        wait_for_console_pattern(self, 'buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
         exec_command_and_wait_for_pattern(self,
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
-- 
2.47.1


