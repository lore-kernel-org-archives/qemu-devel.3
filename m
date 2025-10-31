Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B52BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwG-0004Ao-PA; Fri, 31 Oct 2025 14:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwE-0004A6-EI
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtw7-0006B0-F5
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so1515572f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935595; x=1762540395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4a5pZGC2LeA5EmYHWr+77na5jmR1RmVRW3azsXbL3Ag=;
 b=xBVJITi5pXbmADfJvEYwki58zFj8hFx519qwYUrXcKIE/hhWut696AXG16U36NFdVm
 TY7FxeU046QiykzijK5Ja1sC2U9AFl3f9fbGIPoCbFrr1ze6TESD/mw0dpqeUdwwQ144
 ukZXU33bKnNg5r/+gOyl+F23UUaU37EghZbXwMyTryTfjsHeZfSd0YaMuzRilXdVQLbW
 AnZODFa6Om5fOY2+3dcTDkaJ/Gnrn8FSuEOzsrV7k5a30JF7dkuWABbCg34hjQyJcwxh
 NTeD8yda833fAJEmd7QBz/X4U9sUAvxDdma37boosHrSlG0XC7wuBxdsO+a+3oKxciIQ
 CIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935595; x=1762540395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4a5pZGC2LeA5EmYHWr+77na5jmR1RmVRW3azsXbL3Ag=;
 b=O+NhofCiDx1vzXEAw57WCyrzvqGtfHTDXXUvlQrNLndBwMc3Re88NJX9KSiUSbl5ue
 7QAd1dz3yc3dl2irCZhi8/ZfRTfFiaPUtUnBHsNCoVmf6+pKpb3mlwYaarsLkhYVj/Y9
 535Iy0sX4hvVxhDT0/xOtQqZkUz+36rPGKtaiDAx5p95oGFmFBJF4vJzkomszZE/mEEA
 i5pI76xBEUp1t8UWLPinDKHUrwXOCS9IIoZ95ZAnPxFOSIqLnP+/hKBaIxyFZbLpfWfk
 Y/k8uKk6aiZmekKjqQ4hCp2ptpZondpGY5Dc6Dr1V9D8CF2IamMFFJj8Yf4eJ36L58eE
 0d6A==
X-Gm-Message-State: AOJu0Yyaci5UODfdbhXbmiyxg3/eddDbxs/b3wbqomS5/LkrsarQaHdv
 n22tGU2cFWA+b1t9MaVyn1JX61zom44RgKIBl8Ul/8X20iuDJlNP+9k8yrIYV4e3/9/c4XWg3bx
 IcnKb
X-Gm-Gg: ASbGncvaMkk+4psd2ufzUGXfJimBTf+g9aRI9TFvFH7SbDtWDO/YWlnZkpThfURnyjw
 hirmIrJ8OGXV5YztO1am+rbm7i0yw63atcqbsGFGg6OB2bzWPHv/+NasTC/cV121H6j/oSUtfkT
 s2VnSFRMaBGWsu0DBJiDq7hxo/Hc/kUbG5CqLQYJxGxiD2JCz4bUSpJXj1NJLvDbkGEh+mF+uj9
 UGlUALY9pmh4s5hQMflg1GNpcdAeKZdmhQj/K9Hq056maoXp4xAlJUYEQDakJT+SG3yZ9h/KkxZ
 ADcmVgf5I8Q3c+0vCuv3UVg9MzXQMZmleNvaq5yOwi5ZkMUK/m9CgxmY//4APivqDlYc+c4WRzq
 F/6UYKpsCk4+in3Rx0QMsZFFLD6U6sjCLZZo52P5ndyl0UyWq18KL0wQwPdZRCFGWNUeNUKxQuw
 6uaHbX3+ReT0qMzS3W
X-Google-Smtp-Source: AGHT+IEmxmmVfnuU31DzwJtrdRjeNcXi/MPq5LWYn8FFJYykp0yN3PGotZh4vuTfT5TKfBg66iZrUg==
X-Received: by 2002:a05:6000:240c:b0:429:bb21:94dd with SMTP id
 ffacd0b85a97d-429bd6ad96cmr4012366f8f.46.1761935594943; 
 Fri, 31 Oct 2025 11:33:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/38] docs/system/security: Restrict "virtualization use case"
 to specific machines
Date: Fri, 31 Oct 2025 18:32:35 +0000
Message-ID: <20251031183310.3778349-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Currently our security policy defines a "virtualization use case"
where we consider bugs to be security issues, and a
"non-virtualization use case" where we do not make any security
guarantees and don't consider bugs to be security issues.

The rationale for this split is that much code in QEMU is older and
was not written with malicious guests in mind, and we don't have the
resources to audit, fix and defend it.  So instead we inform users
about what the can in practice rely on as a security barrier, and
what they can't.

We don't currently restrict the "virtualization use case" to any
particular set of machine types.  This means that we have effectively
barred ourselves from adding KVM support to any machine type that we
don't want to put into the "bugs are security issues" category, even
if it would be useful for users to be able to get better performance
with a trusted guest by enabling KVM. This seems an unnecessary
restriction, and in practice the set of machine types it makes
sense to use for untrusted-guest virtualization is quite small.

Specifically, we would like to be able to enable the use of
KVM with the imx8 development board machine types, but we don't
want to commit ourselves to having to support those SoC models
and device models as part of QEMU's security boundary:
https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/

This patch updates the security policy to explicitly list the
machine types we consider to be useful for the "virtualization
use case".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20251016131159.750480-1-peter.maydell@linaro.org
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 docs/system/security.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index f2092c8768b..53992048e65 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -35,6 +35,32 @@ malicious:
 Bugs affecting these entities are evaluated on whether they can cause damage in
 real-world use cases and treated as security bugs if this is the case.
 
+To be covered by this security support policy you must:
+
+- use a virtualization accelerator like KVM or HVF
+- use one of the machine types listed below
+
+It may be possible to use other machine types with a virtualization
+accelerator to provide improved performance with a trusted guest
+workload, but any machine type not listed here should not be
+considered to be providing guest isolation or security guarantees,
+and falls under the "non-virtualization use case".
+
+Supported machine types for the virtualization use case, by target architecture:
+
+aarch64
+  ``virt``
+i386, x86_64
+  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
+s390x
+  ``s390-ccw-virtio``
+loongarch64:
+  ``virt``
+ppc64:
+  ``pseries``
+riscv32, riscv64:
+  ``virt``
+
 Non-virtualization Use Case
 '''''''''''''''''''''''''''
 
-- 
2.43.0


