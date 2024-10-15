Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD24CFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewv-0006lx-5v; Tue, 15 Oct 2024 06:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewZ-0006gr-4Y
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewW-0005yB-Oi
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:22 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso3356010f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988699; x=1729593499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V5xHU8VN3b7hwHGq1dhu6Bn19HDtikxnlAf8IYDTy+8=;
 b=pDLyA8k8YltgYcZ0Lf0AbeTehaWlfyiI9PHkZ8YCy+Wx2U0YXtHYzzN3rFtUMupdni
 JLVzKbKNr4L069qvwK7NPwcuz/sDCbFF+C3houuF+fgZDlBqoXLFZmkMKjbsIPAn1BCg
 f7KHKM1Csa2T0ZZJnXkDjJ90RMQr04OZJfbZeEZNQ135jlpQN5pnaAdtKH/wsUbICwMh
 N6Xw4f/CSjFpTSSt1D2GFOMg7xel6JQYYEJGUjVsW3CSyOcLQS5R6UP6+OAZupNwCOXe
 ZpnaLRCqPkwtap7sCVlGh+BP8We4N3p+L7/6erALQ6cAASUbbut5DNeuPVT0RhqLKbJI
 akLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988699; x=1729593499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5xHU8VN3b7hwHGq1dhu6Bn19HDtikxnlAf8IYDTy+8=;
 b=bTuQZesMHDEKVZMvmL3PCVXd7/cnLMNlkVezRaglgMHiDQTujwWWejjaDCljYdiR4Q
 SbLldESB6b5712tQ+DNhKgcHvFVkd1o3tl7+2kxGEOtAgaV+oQDBMpvkw41XGJfYPHid
 U7TEQDcK2AWrWlvUZcuxrrLvSN4gN80wiNMa/o50dAtWA8ugQ6NugZ8ZRYhq+X6+kN7w
 WeVXV56mFLH4vEDEsKGdIM46w81kDRPekLTGzQsEumPQVFViv26TviqtWLIlSOWE+jAM
 uPceae9Ui9IMen43mSOA4pxmUVfmgGhHhXKe/c9g8b5q5raww+iNlRA8I7qu8DkdYoF8
 V53g==
X-Gm-Message-State: AOJu0Yz2usYsKoXM/3339UHikqDxMvgSgMqaXmsMGW4zYOzlEqsoqnvx
 xFNTNzDChAdvKS3D+fKJamv8CAQNHe6m69NcLAY5dRGYF52lO0hfpLT3fX5HAFq5ayYky76GEY4
 x
X-Google-Smtp-Source: AGHT+IEeGHACVdFsht+7jQA5DHqPeUlloPJFMMXOQkGwNN/KhpfJvQnwU4HrBpbdlz/xJq1hKu3YXg==
X-Received: by 2002:a5d:4e12:0:b0:37d:373c:ed24 with SMTP id
 ffacd0b85a97d-37d5fec8d41mr6550328f8f.4.1728988699291; 
 Tue, 15 Oct 2024 03:38:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/28] docs/devel/lockcnt: Include kernel-doc API documentation
Date: Tue, 15 Oct 2024 11:38:00 +0100
Message-Id: <20241015103808.133024-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Pull in the kernel-doc API documentation into the lockcnt docs.
This requires us to fix one rST markup syntax error in the
header file comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240816132212.3602106-8-peter.maydell@linaro.org
---
 docs/devel/lockcnt.rst | 2 +-
 include/qemu/lockcnt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/lockcnt.rst b/docs/devel/lockcnt.rst
index 728594bcea3..8b43578f6c7 100644
--- a/docs/devel/lockcnt.rst
+++ b/docs/devel/lockcnt.rst
@@ -175,7 +175,7 @@ three instructions in the critical path, two assignments and a ``smp_wmb()``.
 ``QemuLockCnt`` API
 -------------------
 
-The ``QemuLockCnt`` API is described in ``include/qemu/lockcnt.h``.
+.. kernel-doc:: include/qemu/lockcnt.h
 
 
 ``QemuLockCnt`` usage
diff --git a/include/qemu/lockcnt.h b/include/qemu/lockcnt.h
index 2c92ae17c9e..f4b62a3f701 100644
--- a/include/qemu/lockcnt.h
+++ b/include/qemu/lockcnt.h
@@ -51,7 +51,7 @@ void qemu_lockcnt_destroy(QemuLockCnt *lockcnt);
  * Because this function can wait on the mutex, it must not be
  * called while the lockcnt's mutex is held by the current thread.
  * For the same reason, qemu_lockcnt_inc can also contribute to
- * AB-BA deadlocks.  This is a sample deadlock scenario:
+ * AB-BA deadlocks.  This is a sample deadlock scenario::
  *
  *            thread 1                      thread 2
  *            -------------------------------------------------------
-- 
2.34.1


