Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26132C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 18:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyEbF-0002K1-9p; Fri, 28 Mar 2025 14:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyEb7-0002JG-Gn
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 14:38:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyEb5-0002wO-8l
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 14:38:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2240b4de12bso14479335ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743187104; x=1743791904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ssdVNB+g9zRxrEC+Fseszdr1LEiiY1jNxyK/Gm+atso=;
 b=jN9nGEXL3ZgcftCOYocGl/JTSKe+/59GZExHNH1MxZfdDjAF8SKwFM7XmfBzbaqjy3
 QXlmaK4M3ZuxRnddeA8NMi3D4JdoTvaDC1eW4sSWbAb3O9tY5AUgfbC8S22Tu+fItK0/
 YGlKSz5cdLCUluyFvdKxwLgJbQnNJxnl75hlWpRjrTDWZH7Sw5Z3ftV/fGgpTdm1tuOd
 ROhYUfsDGMTOGvXZILYUW4ty3FR1bU4hNzmANzoF6EwsME6And5X1N5G6QwfgthYEOAc
 qGZdfm4tys7sg6jZkG1SM5l1/HgPIUwcI2BH1AE5/e1aGyPHWU4aVaSy/QUa5l2euxW7
 FX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743187104; x=1743791904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ssdVNB+g9zRxrEC+Fseszdr1LEiiY1jNxyK/Gm+atso=;
 b=H4hmfggdWAYT3sqsKTy5jh5AjTxi8aRQ0mhcWF765+P82H4Y0oRVlWk4gBfZwAuZta
 DbvcfOKlwkbAmHfqpiWzNSJe98AZdmeGJfkOrPN8hMgU10x6J7xN99kOnQLga9uBaXfb
 VjbeZEslF3/m2m3yaHdOogpff6MBOyq1iFGmsIP8BwtpJj7yej2i9jGY7+qBB+bHlduH
 DrSjJ5MFRAlC5zqAGlZpRKpqMYHLFtw+ltOPOsdJD4kwmqMUSN6j2vCtGPLStRDkrV2g
 nmdFkIbl2DTphOoHVEF9augjBjQkNb3+/Eb8xdbrUTaim0TEh/tE+6JvQ5KSUJfK0gvc
 wSrQ==
X-Gm-Message-State: AOJu0Yyy95FozG4L4Z4qkdES2/6VI1vA8P4OZsEBjQEofnx1QAJibMjf
 T3iRZdO62djoHTqm+D6gbC9QpkfRQEnwk5X0M+uqmkO2A08HnszPIBgYWL5drf4qGIaibXmjNIw
 1+Io=
X-Gm-Gg: ASbGnctEFVIIh2k0vX3A/3v0snrtleiPYESwPfq/3gzVoo8+qS+J3S/HQQVWC1cboN/
 MNUPFcc4N+9V5ioTGab2wThgQkfDQMh4bNgr6mE6AZJZwuAQGZv0qll1SW5NxfyBPyeR4taVZKP
 Ijrq9iSshn8zbJzA2EA4bz0C6WSQnVeSaAQCmBMc9K31K5S6f/oMJbuCcWPpEDGpwqS8rweGYKF
 IUYyNfT3Wa2GOQqyw1duYTHhq5TMj9lNzsStRp9+vds2LPWB5agBMruO08naB4MRrgnPsUM8Fw7
 Rh9IzbPG0DzeG/lLKJEZudA3EwkkOSLYcYgPnmC+OjeACVVdMyBnmCA=
X-Google-Smtp-Source: AGHT+IEsZ5CLLHOyuF2GEHYYXBy/cC/N6iQErdqNB/GMTo64QUs+RuZUh4ZMYIY1irAWy6xA2xFR2w==
X-Received: by 2002:a17:902:ce0b:b0:227:e74a:a063 with SMTP id
 d9443c01a7336-2292f9e53d5mr3138525ad.37.1743187104272; 
 Fri, 28 Mar 2025 11:38:24 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eedfd85sm22010365ad.77.2025.03.28.11.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 11:38:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, berrange@redhat.com,
 peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-arm@nongnu.org,
 thuth@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] tests/functional/test_aarch64_rme_virt: fix sporadic failure
Date: Fri, 28 Mar 2025 11:38:16 -0700
Message-Id: <20250328183816.2687925-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

This test was randomly failing on our CI, and on dev machines,
especially with QEMU debug builds.

From the information collected, it's related to an implementation choice
in edk2 QEMU virt support. The workaround is to disable KASLR, to avoid
accessing protected memory.
Note: this is *not* needed for the similar test_aarch64_rme_sbsaref.

More information is available on the associated GitLab issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2823
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/test_aarch64_rme_virt.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index f4ad4d33d58..a1abf584f0e 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -87,7 +87,9 @@ def test_aarch64_rme_virt(self):
         self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
         self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
         self.vm.add_args('-netdev', 'user,id=net0')
-        self.vm.add_args('-append', 'root=/dev/vda')
+        # We need to add nokaslr to avoid triggering this sporadic bug:
+        # https://gitlab.com/qemu-project/qemu/-/issues/2823
+        self.vm.add_args('-append', 'root=/dev/vda nokaslr')
 
         self.vm.launch()
         # Wait for host VM boot to complete.
-- 
2.39.5


