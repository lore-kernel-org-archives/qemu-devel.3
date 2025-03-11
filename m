Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250B0C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzQf-0000tn-Bj; Tue, 11 Mar 2025 09:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1trzQX-0000S0-5X
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:13:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1trzQU-0002VJ-I2
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:13:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225477548e1so52854995ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698819; x=1742303619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MQ4XAzp89chAAsvM6R6ygnZUi0Fq1GN2QGo72cNPc2g=;
 b=JLP5SSRw/RnHNkyv8InhOLKffNvh0wnE/r/yBZLp/hA53XW1N+OeKdqs6MBNI7TIeA
 R5J/q7TAHRdZjBvXd/pytqPDLP5/r1dCaQWPyA4musT+jzhJkYzRDBSCCcfGtFL6sivF
 gdIykEU7tPjZxZqhK4khufHm1LZQ1SmyOyk83u8tRIZ/4C48jw38IDC7p4gUv+JclBjN
 92c5Q8kHsrFcAp5jTHkNq+lLoRsy+f1BsOWSfZAu4PoJ5O1GP0ahYD/W+iAkfios2DNJ
 CDK1mMaKR2FNjiTebpEOah73XaEQJz0QKgUTv/qW+xoRyWD/N+Zi60KxDZlbSRCMb5UA
 ilRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698819; x=1742303619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQ4XAzp89chAAsvM6R6ygnZUi0Fq1GN2QGo72cNPc2g=;
 b=MwoiMd2t9oqryci7seA1rVeGhYgM9ZGH5WhUBbfHNaoqVEDuyP0jyNOBjGSCAywcum
 hB7J32m/mxYNSfCZiDwR70d9/M/fA1zthEkL2NUsv5K5uAAFk2Yst5XiiM++pvevpXWs
 9JRI63GnlV/To4QKJ/P3YIOpz7kBbe8ICGAQk3tVlXEpwFxcBMAHxHb/67JJOQTG8VS4
 PoT01NAtc/0dk+h+NAWzmf+2bga6syo++j5q0S3+LFUGtUCvitCR/hAVg3B7w2IjSeQh
 eoElrnRMKq1nmC4rxza46JoeCxl2/K2CR7FriTiNCxmFlV3Fz9JcDEFPRK/lJb4qQ95p
 b0xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB6n7V6iij3DfG5qA/txXxdzE87DNdEIq17+Ed979HRdLAKlErO4snKnN322wBxo1bxAdLWJLhYKC8@nongnu.org
X-Gm-Message-State: AOJu0Yy8SH+ZErbAPQ0LAxkv7AGPXMRYVu22GH6DbXJUeuSrWwJ6wWP6
 PXzIhj1HCcwH4THxC5sN3vVj3Kyh45T64/PzAAW9JVW0za6e+oGL
X-Gm-Gg: ASbGnctfajAuAZ7jmFKyypNe3olflh7oofVNx8erfdK+3ND/t8It/jdX4oxTd3cfzJV
 QVjXAs3d2ykzuM8BihquVJAt4VcOo3erk+VuU6rHl0e7QrqNsvAJGfFnAsvze6PcGTP6V2cCZYd
 seAkoTuZWUIC+M4m0gYX9G0uE0dqPZfmkO3M4gBgteXqxQ8raFCUVSSkBjGtcp56LpuYg13m6Ny
 Z5uE9eUnuhVOTczeUJTrG7ewa2jnQHTrna1FIvsn8xI3LLf66/BhlnUw2dd3S5HG5UwDsth7ePS
 tAJSh6qvWsMlTbwm3vcDeoPd+c7jGPsQUC0XOA7s+dmYoPNzzIE=
X-Google-Smtp-Source: AGHT+IE84gNN7Uf9mhUPJ1rx//ZOh9I/zE/RWpURjTBRGo0ljD5PKXyMxH/vOBoSb/rgniH8ldsiUQ==
X-Received: by 2002:a05:6a00:1887:b0:736:450c:fa56 with SMTP id
 d2e1a72fcca58-736aa9e7ac9mr22665695b3a.5.1741698819621; 
 Tue, 11 Mar 2025 06:13:39 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736c05cb6e3sm6516026b3a.45.2025.03.11.06.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:13:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH] tests/functional: Don't fail any precaching errors
Date: Tue, 11 Mar 2025 23:13:26 +1000
Message-ID: <20250311131327.903329-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

The NetBSD archive is currently failing part-way through downloads,
which results in no clean HTTP error but a short transfer and checksum
error. This is treated as fatal in the precache download, and it halts
an entire set of tests even if some others could run.

I hacked up this patch to get a bunch of CI tests going again for ppc
merge testing.

Don't treat any precaching failures as errors.
This causes tests to be skipped when they try to fetch their asset.
Some CI results before/after patching:

functional-system-fedora
https://gitlab.com/npiggin/qemu/-/jobs/9370860490 #bad
https://gitlab.com/npiggin/qemu/-/jobs/9373246826 #good

functional-system-debian
https://gitlab.com/npiggin/qemu/-/jobs/9370860479 #bad
https://gitlab.com/npiggin/qemu/-/jobs/9373246822 #good

This is making the tests skip. Is there a way to make the error more
prominent / obvious in the output? Should they fail instead? I think
there should be a more obvious indication of failure due to asset so
it does not go unnoticed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/qemu_test/asset.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index f0730695f09..3134ccb10da 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -174,14 +174,11 @@ def precache_test(test):
                 try:
                     asset.fetch()
                 except HTTPError as e:
-                    # Treat 404 as fatal, since it is highly likely to
-                    # indicate a broken test rather than a transient
-                    # server or networking problem
-                    if e.code == 404:
-                        raise
-
                     log.debug(f"HTTP error {e.code} from {asset.url} " +
                               "skipping asset precache")
+                except:
+                    log.debug(f"Error from {asset.url} " +
+                              "skipping asset precache")
 
         log.removeHandler(handler)
 
-- 
2.47.1


