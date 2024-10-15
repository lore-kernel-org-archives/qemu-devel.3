Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35F6CFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewp-0006ho-Ki; Tue, 15 Oct 2024 06:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewX-0006gC-RX
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewV-0005xl-To
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:21 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso3355998f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988698; x=1729593498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t1cGmO53mZ9iNqSL2eF/CAirgGUIZeKIwH4XCXTjDe0=;
 b=W09w4z7bvy+2eYH51dIry1c99h+6D+cCZrv4wT87iDT7FiL2XJVOjjxRAgWGX3DDmX
 RmBY3OGRxr4+YBiyQOEcR0nGs88WHmIcq4mvSI0JQcWT05ARCpdnTXMCZy+Mx/ruMp1w
 s3rHQff3cVNfgctkJITVI7K/8WeNELvLtHO2UiFfAouoJP+raar55vVotSTRcqcd3LHw
 CWa7Qbf1kXTE9/+oBk9we8nQqdmE2fnyn3ewL0lN+FaXtBtl7pJuzNauMccLqW/tD2+F
 XPn5IPB9Zyo4e5Yl8SpoIcWOphRvpn/KLE58LSpvI9Z8NIKM3rTS24yGM1LFsxKp4lcr
 mh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988698; x=1729593498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1cGmO53mZ9iNqSL2eF/CAirgGUIZeKIwH4XCXTjDe0=;
 b=MyCnYMWtLppqMGvbMj7B5EDzF4dqIge+exCLwer3P0QVt/TXgA31zyYQdoF4pKjjbF
 0fgcdZI08NLIwAMMZqYNBonOVqo4kLDQKj2Hz38KXcCGA8qhLUtuvGGfdJkUWUQflQfF
 hJeydwqXmXTg2+XCjtT+jNcfeGWZPi5NmJnTQHVuPkEugwG13eks3c56yBFYwB+BhHA1
 ah9iygatpUiS95sPsdgKIWiuDTQnjtkbZTQ+OhNGLhEAwT7v1pH8CTC0I9BomcgWEZQX
 rQ7uJpwthd9ttag3FC7yL34rRpzLh5YwIPIkiG5yGyHKRxdCjvlwDKAC+d6uChFdOekf
 jB6A==
X-Gm-Message-State: AOJu0YyL9RlEXKfTSA8zvTkeA219O+3I4v8HBAySWar5XWLVgdVB4kQ0
 9/dnQCyOyKztCcdt2oB/tN0Zf5R+4aHojs90t+T3nVT9mRQpPQG8mSCMkirawrLFxE+nFCKW2Dr
 3
X-Google-Smtp-Source: AGHT+IEJXYv1+CyvajGjIW1NZrBgRTvcVYH9YghKW9Se8TMt9uNTmKbbJW4uyaP3eN/83iLYWaQbuw==
X-Received: by 2002:a5d:4742:0:b0:374:fa0a:773c with SMTP id
 ffacd0b85a97d-37d5ffc1a53mr8284397f8f.47.1728988696962; 
 Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/28] docs/devel/blkverify: Convert to rST format
Date: Tue, 15 Oct 2024 11:37:55 +0100
Message-Id: <20241015103808.133024-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Convert blkverify.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240816132212.3602106-3-peter.maydell@linaro.org
---
 MAINTAINERS                                   |  1 +
 .../{blkverify.txt => testing/blkverify.rst}  | 30 +++++++++++--------
 docs/devel/testing/index.rst                  |  1 +
 3 files changed, 19 insertions(+), 13 deletions(-)
 rename docs/devel/{blkverify.txt => testing/blkverify.rst} (77%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4eb221b88c..22cc98bbfee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3890,6 +3890,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/blkverify.c
+F: docs/devel/blkverify.rst
 
 bochs
 M: Stefan Hajnoczi <stefanha@redhat.com>
diff --git a/docs/devel/blkverify.txt b/docs/devel/testing/blkverify.rst
similarity index 77%
rename from docs/devel/blkverify.txt
rename to docs/devel/testing/blkverify.rst
index aca826c51cc..2a71778b5e3 100644
--- a/docs/devel/blkverify.txt
+++ b/docs/devel/testing/blkverify.rst
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
diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
index 9e772c7fd1d..1171f7db8f0 100644
--- a/docs/devel/testing/index.rst
+++ b/docs/devel/testing/index.rst
@@ -15,3 +15,4 @@ testing infrastructure.
    ci
    fuzzing
    blkdebug
+   blkverify
-- 
2.34.1


