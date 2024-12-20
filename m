Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CB0E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOT2O-0001yJ-CT; Thu, 19 Dec 2024 21:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT2M-0001xJ-Ek; Thu, 19 Dec 2024 21:46:46 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT2K-0000JU-RM; Thu, 19 Dec 2024 21:46:46 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-72764c995e5so893280b3a.2; 
 Thu, 19 Dec 2024 18:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734662802; x=1735267602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ozzd5pDOTq1/IYcv7geWeZ29LCOfsyB2PUifZhowjvc=;
 b=Ak+3AfPfA8eOzx6zG6nDmC5GV6b+Pmaec7L56lfZMvhzITlvKYDkdmkaxQ6JhRDaDv
 UVT9pGA7bI+QhaWjRMAkfsEWgNANHTZR4RYgawHNDwQz7s2jH6vuPvVrdCWvuIhRGXwT
 1ZhutXaCnzzC0qILhFiXqljoYd86u60ReW6VQgobh+09tueKkxyuTwFifIGrwPYs6+aW
 K/ES+/dc04zgcF+OML8XaS9rGv3QEm0J/jgKTqHMLrj256FKVQfVMyPmypt00C/KoZSq
 8jRdDul4AaFhl+hvBLf1A3LAQuqISrAZaGXxwg1V9cXG18X7acHeFiI1C9L7a3qJKrYH
 eqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734662802; x=1735267602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ozzd5pDOTq1/IYcv7geWeZ29LCOfsyB2PUifZhowjvc=;
 b=M5iAkz8xpMeVgj5mKM4PzRgjLCXGxaHE23HC6V3yagVXFRDEHnsdnDL+iDwGzj8NAE
 nBWZ797cy87v1H76Zd4iDe1iJoKPoVlhOsmkvHR+COnLRMNZvhpuS9LBsvtkfHuA7iXo
 Q1104u9UfSU2KWr1XZ3PYSIz6SJzSAgZDwFGfrZ/cdYd+36tmvwtIBrF//zRo0PV1MGK
 ii428wNIzehy8yGSN580iht7bHo/SXqbQ2mCmljZHmb/ynVadRu77Auh2s0QvvyXyyHb
 LRVS1VizczLAQnID3VCBN4+UUf0LX+EBkHJvqiv7vD/5XRdJ5yyF64qIBIx6rVNvWe5P
 siOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHUWKTUL7CECgbzbRRj689YrgockaJ0JPj53s6sdaiE2eaMWVJxF6OBycSFbQ4EoPZyrlkJ61pJg==@nongnu.org
X-Gm-Message-State: AOJu0YyeWDxjA5GK76btkUptLCDdNBKWmIrCufVStSCBTssX2/iRRV0e
 sRZ3EkD6uHRAhZdYeDMX0mWqnMchUvHcuw30c9I0qtY4w8228xvXo3iGYg==
X-Gm-Gg: ASbGncsV5Muv4b55DjamkSMLJXLgvbVzOc4RDTceA6of9wSch8lmxbZjMgezuZR97qW
 eEacXlD1L0C3vFFcW17I1NxV0jAQJqY0Qbx25ELlNlmFiJlMrSuvrImSXBTvkQUyl4l+SPAqJbl
 rNnhKyvwFYYu6r9xfuy6wNjdqwQCg+7rD+MTB6dUfkjDQLRDhu3gvJVu3R+j0dwKi4XxImPmxJd
 moGkfb7Mf4zCdHmzfkyW3m15nJFSy3dTPP91PQefxvH3F/UxJrPCr4hTn8GfjtRqQxuxiVAot9A
 FGhGEYXfdg==
X-Google-Smtp-Source: AGHT+IEIL17gJrwBAmS8zSAsb7500PRFyMoNAEbNGFGn4aMC7cB0tYnN1hW647/+XwXIbmdoRYXL+g==
X-Received: by 2002:a05:6a21:c8c:b0:1e1:a48f:1246 with SMTP id
 adf61e73a8af0-1e5e0818c00mr2421680637.45.1734662802561; 
 Thu, 19 Dec 2024 18:46:42 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dba99sm2037830b3a.92.2024.12.19.18.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 18:46:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 4/4] tests/functional/test_ppc64_hv: Update to Alpine 3.21.0
Date: Fri, 20 Dec 2024 12:46:17 +1000
Message-ID: <20241220024617.1968556-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220024617.1968556-1-npiggin@gmail.com>
References: <20241220024617.1968556-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/test_ppc64_hv.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 62e1a0f3a2d..f5ff0993ff5 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -56,9 +56,9 @@ class HypervisorTest(QemuSystemTest):
     good_message = 'VFS: Cannot open root device'
 
     ASSET_ISO = Asset(
-        ('https://dl-cdn.alpinelinux.org/alpine/v3.18/'
-         'releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso'),
-        'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff')
+        ('https://dl-cdn.alpinelinux.org/alpine/v3.21/'
+         'releases/ppc64le/alpine-standard-3.21.0-ppc64le.iso'),
+        '7651ab4e3027604535c0b36e86c901b4695bf8fe97b908f5b48590f6baae8f30')
 
     def extract_from_iso(self, iso, path):
         """
@@ -143,7 +143,7 @@ def do_test_kvm(self, hpt=False):
                            '-initrd /media/nvme0n1/boot/initramfs-lts '
                            '-kernel /media/nvme0n1/boot/vmlinuz-lts '
                            '-append \'usbcore.nousb ' + append + '\'')
-        # Alpine 3.18 kernel seems to crash in XHCI USB driver.
+        # Alpine 3.21 kernel seems to crash in XHCI USB driver.
         ps1='localhost:~#'
         wait_for_console_pattern(self, 'localhost login:')
         exec_command_and_wait_for_pattern(self, 'root', ps1)
-- 
2.45.2


