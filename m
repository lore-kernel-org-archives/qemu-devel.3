Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08F2C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdtk-0003Kf-EA; Fri, 03 Jul 2026 09:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfdtd-0003Ji-GS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:25:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfdtb-0003Bp-Pl
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:25:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493be1b9682so4776905e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783085130; x=1783689930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K1WfYP/AVnGL9yCNhgkXBBOTZWvzXfb+5TR8YCleTrA=;
 b=P6vLQw/4kGmylrNdBi2gD+h82bljw5fosmk4v766a2VdOggIOKvO5QWeaqbN0yWV06
 E52gkO0s30n/dCXYI6c8ZZYsbO1D8spPZUr6VqU+89P6r8TXedJlJxaWqysVcMCKhV/W
 nJnxH+mORR5XafhOc2PCZC2+y/gcrisXwyXQTkRt5wuuzyboLTnfHZJNnwjY5GPsldwK
 HCK9ai8OJeGQ/8zw3rgO6rC7nCC5DOZaRWhXfkqBiHxYl3S6r0qLj/yzhNTAZyz4WxkU
 xpbL2kG7Icw71APehesVdsaUZW5BHgMn1izGZXgTZ93vy8tZEJtZOtRhjVyjA6jYvC95
 TryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783085130; x=1783689930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1WfYP/AVnGL9yCNhgkXBBOTZWvzXfb+5TR8YCleTrA=;
 b=oBgvO1XDl4ryx46VaFLqKpT66WD840LgQG0zDlMg8Ju293YUGnDNblJulv+8PfGjjp
 BIE4NXD3t3c2LV/wNyy3K/3qMEQd9f6o0UyCUThjxd+bji4SF4EN/Mm85WRgLH7e2+HN
 Js6OWExh+juamwdI8khDef8BOQHgK4MONlTF4LlYSWjHxh4v7ORyK1tq/XKH5uc/q0Wk
 zaktaAFe0O2L8mEJV/5a1qV+Ba3O3Htu4/IfNoQYgKRL8rwApP7gmRMGQLk/vItE8GJB
 J0LkYGUhj/mSK7ma4A2XCe7Iy1niaUJYjbjsEwDAXZBEvfGrVM4ljKNhVEhiQVxtN/Ou
 A8Gg==
X-Gm-Message-State: AOJu0Yz2nxmmzrmjwBj6iTKMrU76vEz5+IjKl1eRiF8BBqdsrZvFhZVA
 8w+E3XXdquP1AbenDJcfXaZmJOvuKoyKsZK+I8Uo5mesYFBCmjH2hzUZ/38JQEixVo/gEfAE1GE
 9aZHrjE1MWg==
X-Gm-Gg: AfdE7clw9C5tPFONxlO7L66Z+MWq4zVkxo2kEz8bkhCIwRpI/6o7BRGPqHH2VtZJJcV
 hA22JYfTcgjmHwch6znwe5XGKo7CSNxck0yvNz2UQ6+4zEE2xObEnYdDiAk3EL8pGIGk4NHeI14
 qWcd5Lizwc0SF+XMURbheo0kNozhZ/8sU9ZlExPRAquf6BbV5npd3fcw4v4/8pKPsQov0fK/9dz
 WXkzdoNu6TCLkc+P9xWKdZsZ+K6Py2XrJUqJfDUHXBvqUSh+EBcJ95hxoLc//5qz1+vtkpXHkFe
 xPJEiS6db5ndosV0FOm6hoAv6Em0MgonT9aqMKlnlH5+RVhFHAKRWuq8/sQCit6MzxyC0W4qkdw
 l8gEDDfsZQeOsoDtTXXqT55iVParGD4LPUzKdcXDnLYSHVeWG4gH6CgHgkbevaxj2+adRiF6/Gr
 BXzeFXIw7fkjXOQAAbyCaWjAqeJvNGY6Dnf3NikBytKyNYH7sJt38eZqMnfxSXlWNHuwFWp6i5H
 4GK6C00gRiTfVRZ1Gte+8tn9FZYfLPO
X-Received: by 2002:a05:600c:1594:b0:493:bcba:46a4 with SMTP id
 5b1f17b1804b1-493c2b7dc45mr85352095e9.20.1783085129757; 
 Fri, 03 Jul 2026 06:25:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4b73sm17773242f8f.15.2026.07.03.06.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 06:25:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH] hw/9pfs: Check for error return from local_fid_fd()
Date: Fri,  3 Jul 2026 14:25:28 +0100
Message-ID: <20260703132528.4035684-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The local_fid_fd() function can fail (returning -1 if dirfd() fails);
check for this explicitly rather than relying on something later on
failing because it was passed a -1 file descriptor.

This was flagged up by Coverity: CID 1660923, 1660924, 1660925

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/9pfs/9p-local.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ee592b62f8..8f27c562b5 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -788,6 +788,9 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
 {
     int err, fd = local_fid_fd(fid_type, fs);
 
+    if (fd < 0) {
+        return fd;
+    }
     err = fstat(fd, stbuf);
     if (err) {
         return err;
@@ -1055,6 +1058,9 @@ static int local_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
 {
     int fd = local_fid_fd(fid_type, fs);
 
+    if (fd < 0) {
+        return fd;
+    }
     return ftruncate(fd, size);
 }
 
@@ -1113,6 +1119,9 @@ static int local_futimens(FsContext *s, int fid_type, V9fsFidOpenState *fs,
 {
     int fd = local_fid_fd(fid_type, fs);
 
+    if (fd < 0) {
+        return fd;
+    }
     return qemu_futimens(fd, times);
 }
 
@@ -1196,6 +1205,9 @@ static int local_fsync(FsContext *ctx, int fid_type,
 {
     int fd = local_fid_fd(fid_type, fs);
 
+    if (fd < 0) {
+        return fd;
+    }
     if (datasync) {
         return qemu_fdatasync(fd);
     } else {
-- 
2.43.0


