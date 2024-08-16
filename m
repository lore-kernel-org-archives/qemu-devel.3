Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE236C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewuL-0005AY-T5; Fri, 16 Aug 2024 09:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuK-00058M-9g
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuH-0007k3-FK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3719753d365so329409f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723814535; x=1724419335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3BYyoFuiUhi097Go1IdQzbbTPVpAV8zdtNg6dApNEU=;
 b=J0EN+EmQx8V2LrNaxrckjspv+g/23rnQZw0XXM15V7rrJM1uKtjTKi/X0JW9vLmGel
 pfcxbAh2e1Ye0xxX4wqr2GyfhR8HOCR8xlQWgmBEV06B6UzkuhAQTGv1Y0MRWymgs/V0
 BILz2Cq9Qor3obJomOx7U1vVE9oXoYScFlFVCji6Enpb6esIvHcWvf5x2HbdN8phLndy
 8Awz6qsOMR959WUHAblHDIPE8W/iqwh+fZM9nKuYDFGlOxypx9Auvcb/uLqscNw3BELN
 qlgN93+Sxpi27tOcKaCldafuXaII1GVBEXRSMDKNGJUvwKfR+i97n4uxIoXQE4SD+Aka
 kQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723814535; x=1724419335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3BYyoFuiUhi097Go1IdQzbbTPVpAV8zdtNg6dApNEU=;
 b=TAX0y+tE7HDNwvEkpOcL7ylYGZ7pEOdElBzqnc0LcjsYrtX+AtJihpkg/gaKtDt8mx
 aAYnvI2f0URi2jqT1heQOrxDi/nw9oHPeJnseAAoRV3Qql+2kc4NrdnxkKC4huFXhQ3H
 Xp8pvxwDqrzfIpD1lLi3LROrJqNRcObjcKuX1Fe5HCiUEhS46oDJoNW+OwG9tAW2iH5f
 TBvIkci5C32c4o8uX0Fo0EHoWL5sBV5lHSYZomFP3WimZgj4M/mY1q2FSQBVSYmqAMcK
 g1N7wlkslDQbEEenJSW/zoDjtiAEkEEZVE6S9fxUmK6FMK3hpwhPClR8g67z/rahxonN
 JMBg==
X-Gm-Message-State: AOJu0Yw70+GqqqqeFVgz16nGA8fKxnvbEkQfTZ3YRAD6CKNHNyaLkCqy
 DExItae1iWEHCvsPm67Yg50eqTwOGiCZP4MOVnYst5PnhcV78LhmWL0SWNaToGsv7fdh0fKgFbQ
 Z
X-Google-Smtp-Source: AGHT+IG4oyYbdCOLq7ErxdT7m0wtT+/At885LDS58iJUq46gVTm5u2Piyn9vS0USHKuQLXAnVcEx3Q==
X-Received: by 2002:adf:f1c2:0:b0:368:3789:1a2 with SMTP id
 ffacd0b85a97d-37194641ac2mr1951421f8f.21.1723814535469; 
 Fri, 16 Aug 2024 06:22:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ab855sm3631948f8f.105.2024.08.16.06.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 06:22:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/7] docs/devel/blkverify: Convert to rST format
Date: Fri, 16 Aug 2024 14:22:07 +0100
Message-Id: <20240816132212.3602106-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816132212.3602106-1-peter.maydell@linaro.org>
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Convert blkverify.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                 |  1 +
 docs/devel/{blkverify.txt => blkverify.rst} | 30 ++++++++++++---------
 docs/devel/index-build.rst                  |  1 +
 3 files changed, 19 insertions(+), 13 deletions(-)
 rename docs/devel/{blkverify.txt => blkverify.rst} (77%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca0a5c731f5..e9dd1180077 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3938,6 +3938,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/blkverify.c
+F: docs/devel/blkverify.rst
 
 bochs
 M: Stefan Hajnoczi <stefanha@redhat.com>
diff --git a/docs/devel/blkverify.txt b/docs/devel/blkverify.rst
similarity index 77%
rename from docs/devel/blkverify.txt
rename to docs/devel/blkverify.rst
index aca826c51cc..2a71778b5e3 100644
--- a/docs/devel/blkverify.txt
+++ b/docs/devel/blkverify.rst
@@ -1,8 +1,10 @@
-= Block driver correctness testing with blkverify =
+Block driver correctness testing with ``blkverify``
+===================================================
 
-== Introduction ==
+Introduction
+------------
 
-This document describes how to use the blkverify protocol to test that a block
+This document describes how to use the ``blkverify`` protocol to test that a block
 driver is operating correctly.
 
 It is difficult to test and debug block drivers against real guests.  Often
@@ -11,12 +13,13 @@ of the executable.  Other times obscure errors are raised by a program inside
 the guest.  These issues are extremely hard to trace back to bugs in the block
 driver.
 
-Blkverify solves this problem by catching data corruption inside QEMU the first
+``blkverify`` solves this problem by catching data corruption inside QEMU the first
 time bad data is read and reporting the disk sector that is corrupted.
 
-== How it works ==
+How it works
+------------
 
-The blkverify protocol has two child block devices, the "test" device and the
+The ``blkverify`` protocol has two child block devices, the "test" device and the
 "raw" device.  Read/write operations are mirrored to both devices so their
 state should always be in sync.
 
@@ -25,13 +28,14 @@ contents to the "test" image.  The idea is that the "raw" device will handle
 read/write operations correctly and not corrupt data.  It can be used as a
 reference for comparison against the "test" device.
 
-After a mirrored read operation completes, blkverify will compare the data and
+After a mirrored read operation completes, ``blkverify`` will compare the data and
 raise an error if it is not identical.  This makes it possible to catch the
 first instance where corrupt data is read.
 
-== Example ==
+Example
+-------
 
-Imagine raw.img has 0xcd repeated throughout its first sector:
+Imagine raw.img has 0xcd repeated throughout its first sector::
 
     $ ./qemu-io -c 'read -v 0 512' raw.img
     00000000:  cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  ................
@@ -42,7 +46,7 @@ Imagine raw.img has 0xcd repeated throughout its first sector:
     read 512/512 bytes at offset 0
     512.000000 bytes, 1 ops; 0.0000 sec (97.656 MiB/sec and 200000.0000 ops/sec)
 
-And test.img is corrupt, its first sector is zeroed when it shouldn't be:
+And test.img is corrupt, its first sector is zeroed when it shouldn't be::
 
     $ ./qemu-io -c 'read -v 0 512' test.img
     00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
@@ -53,17 +57,17 @@ And test.img is corrupt, its first sector is zeroed when it shouldn't be:
     read 512/512 bytes at offset 0
     512.000000 bytes, 1 ops; 0.0000 sec (81.380 MiB/sec and 166666.6667 ops/sec)
 
-This error is caught by blkverify:
+This error is caught by ``blkverify``::
 
     $ ./qemu-io -c 'read 0 512' blkverify:a.img:b.img
     blkverify: read sector_num=0 nb_sectors=4 contents mismatch in sector 0
 
-A more realistic scenario is verifying the installation of a guest OS:
+A more realistic scenario is verifying the installation of a guest OS::
 
     $ ./qemu-img create raw.img 16G
     $ ./qemu-img create -f qcow2 test.qcow2 16G
     $ ./qemu-system-x86_64 -cdrom debian.iso \
           -drive file=blkverify:raw.img:test.qcow2
 
-If the installation is aborted when blkverify detects corruption, use qemu-io
+If the installation is aborted when ``blkverify`` detects corruption, use ``qemu-io``
 to explore the contents of the disk image at the sector in question.
diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
index 3a912aefcfa..a8f7c5cdebc 100644
--- a/docs/devel/index-build.rst
+++ b/docs/devel/index-build.rst
@@ -19,3 +19,4 @@ the basics if you are adding new files and targets to the build.
    fuzzing
    control-flow-integrity
    blkdebug
+   blkverify
-- 
2.34.1


