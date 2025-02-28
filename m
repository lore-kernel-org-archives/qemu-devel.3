Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAADCC282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 19:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6UA-0006n4-W1; Fri, 28 Feb 2025 14:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1to6U8-0006mQ-T2; Fri, 28 Feb 2025 14:57:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1to6U5-0000IL-Qx; Fri, 28 Feb 2025 14:57:24 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390edaee0cfso808805f8f.2; 
 Fri, 28 Feb 2025 11:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740772639; x=1741377439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mDBWY57Bf9Ibr5qB0DFIWRzHoLx2Mj9UY/E0dsFYsN8=;
 b=NeQ2bjWVDpJb4CIBJ1S3YelLXQd53/L58LMhB/4B23Lt4pnaBvKOQ51jwWQkcpvo75
 YsZDlZdyQPM35jSPQFUqeNynK05nxvnEil+gWGFNJ8odnAjHQXkGzJ4s5AuUXTh5djyu
 Q7b/6jPydsCXDn+YncwGli4oVIzG3bvHqUaEHXAnkR8GtcnHhKiK7APxIHXLcZEs0ZOP
 RuTktrj8ZAEStxLBt5O6JO6Q+2OqBrhRnlv/soOisPXHiYZAlimaIfQHX80fBVffcMvd
 3GbdCS/wzAAwOX3O+brV9y0pArY0zxMcB4Qxp4NZom86ZoxJw4nE7ruKQibLBiKRCz7T
 Nn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740772639; x=1741377439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mDBWY57Bf9Ibr5qB0DFIWRzHoLx2Mj9UY/E0dsFYsN8=;
 b=w9lkCTnQ+UbjghAww6ZMkke3c28HNP9+YhaG5xB9mrFvjvU/sR+upklCoJjIgRw51B
 eJ//ktcmkwCFjFnz4qdjkbYDwFRsVPPuWiQb+gZB6O0i3uhRJ3xYxgRKiERzLb8NKRPs
 MJnCajcrP2v4JBxPO/crf1BcxIUvUKETDM7b2iFT5wzHLpwidLqAWj62AEIVb5zY6CRK
 p+QkNqRaA3nW/8x17l50azIyJBmrXG6gHZKc4CC6q0cqwO+V5kMH+pBzoY0/7stS0lAH
 qNdx89lVinzpXdIQnU+HzFoO9aFPIBKX9mi15F8uWVDiTtWd81F/a3cs+sWcsZyia6jt
 Vf/g==
X-Gm-Message-State: AOJu0YzwzdZslNbcvxwXmzyYHWt0KL/PEAmTK0VDZlL2919QPizzutGz
 qPec3I3rIS2tAfpwekkfHnj16XQS3oexrJxSL5wqLnj4nayDYd83Dt7HpA==
X-Gm-Gg: ASbGncvebIK6r8b51HKPFuorggzlskBpa8GXqmmOs8zvTfo/iMl92LK52XUlFdKOd7+
 foOM36X2afs0u34D57nNqAKe5Ouu0u/1VxNoNHN159o9xwcNXOQU99Nhx0ap2P1YVW4wguzb3zO
 gs1IidVAIi/vfGadNITAtiTM8bicXUCCyB4przikw/COOla+2BSylGQPzeastuOaameoK2fXDXP
 cxKbjk5UY0XYeoRs9rO3qSulTgloRqgzCE3ik2/F5/tLwHDzRp+Q5XZHVsvLYaR+Qiw46Tad8IL
 O6465s94RPFhc/NGikAR8oAiNslvpsfDxjpW+NVc1Xx6Fkh8ar7r86OQ5WcG0hYJGfMYn6RW0fl
 9P8LpeA==
X-Google-Smtp-Source: AGHT+IHAiVlMT+sAQusBwJz+zXa4JeQlP/BQ6fmdgfoq4ovMv6+r4PpHaNkS8qJ4RZ5r8MgF8xE1qA==
X-Received: by 2002:a05:6000:156d:b0:38d:e572:4dc2 with SMTP id
 ffacd0b85a97d-390eca27dabmr4047115f8f.40.1740772638822; 
 Fri, 28 Feb 2025 11:57:18 -0800 (PST)
Received: from localhost.localdomain (46-116-132-27.bb.netvision.net.il.
 [46.116.132.27]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5710ebsm102859325e9.26.2025.02.28.11.57.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Feb 2025 11:57:17 -0800 (PST)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v2] iotest: Unbreak 302 with python 3.13
Date: Fri, 28 Feb 2025 21:57:08 +0200
Message-Id: <20250228195708.48035-1-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x430.google.com
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

This test depends on TarFile.addfile() to add tar member header without
writing the member data, which we write ourself using qemu-nbd. Python
3.13 changed the function in a backward incompatible way[1] to require a
file object for tarinfo with non-zero size, breaking the test:

     -[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", "offset": 1536, "size": 393216}]
     +Traceback (most recent call last):
     +  File "/home/stefanha/qemu/tests/qemu-iotests/302", line 118, in <module>
     +    tar.addfile(disk)
     +    ~~~~~~~~~~~^^^^^^
     +  File "/usr/lib64/python3.13/tarfile.py", line 2262, in addfile
     +    raise ValueError("fileobj not provided for non zero-size regular file")
     +ValueError: fileobj not provided for non zero-size regular file

The new behavior makes sense for most users, but breaks our unusual
usage. Fix the test to add the member header directly using public but
undocumented attributes. This is more fragile but the test works again.

This also fixes a bug in the previous code - when calling addfile()
without a fileobject, tar.offset points to the start of the member data
instead of the end.

[1] https://github.com/python/cpython/pull/117988

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 tests/qemu-iotests/302 | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
index a6d79e727b..e980ec513f 100755
--- a/tests/qemu-iotests/302
+++ b/tests/qemu-iotests/302
@@ -115,13 +115,22 @@ with tarfile.open(tar_file, "w") as tar:
 
     disk = tarfile.TarInfo("disk")
     disk.size = actual_size
-    tar.addfile(disk)
 
-    # 6. Shrink the tar to the actual size, aligned to 512 bytes.
+    # Since python 3.13 we cannot use addfile() to create the member header.
+    # Add the tarinfo directly using public but undocumented attributes.
 
-    tar_size = offset + (disk.size + 511) & ~511
-    tar.fileobj.seek(tar_size)
-    tar.fileobj.truncate(tar_size)
+    buf = disk.tobuf(tar.format, tar.encoding, tar.errors)
+    tar.fileobj.write(buf)
+    tar.members.append(disk)
+
+    # Update the offset and position to the location of the next member.
+
+    tar.offset = offset + (disk.size + 511) & ~511
+    tar.fileobj.seek(tar.offset)
+
+    # 6. Shrink the tar to the actual size.
+
+    tar.fileobj.truncate(tar.offset)
 
 with tarfile.open(tar_file) as tar:
     members = [{"name": m.name, "size": m.size, "offset": m.offset_data}
-- 
2.39.5 (Apple Git-154)


