Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456A8C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJYN-0006tf-A2; Tue, 06 May 2025 10:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVQ-00025U-41
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVN-0002AB-N6
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so35084015e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542563; x=1747147363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pBeKEajXSmAhb7LijWOPketZcw3p7yrO3ri2YB9hhOQ=;
 b=GlW1+/I8Q9iTpcf/l6GEjro49Ckrl/VCGNrKGrjcs7cpch2B34wQcSHpeus/FPhYgP
 z80X1ZDE68SMD4g5yRw4FfJYNR0CTeSWGOpt21SQtFXIHWAShWlBP6CGNI2M2Gx7tCMS
 eilhZno9g5Zn2/oeB3srbcS0yZCIIY0N+hxlb/8AMUga5rsSgdxFmrlAx9MmQaQdZ/Zc
 CDPGfkrJABLpg/9LiLKesHfg4R8I5B1P4wnz4aLleNjAMj2My+xqAbMUowHgr97TFGH8
 tXLGLAQrrlMeVmMlCD9hRiE9itNXggGtWApTqqVMq47Ny2ti5sxcYZSPtPG22BYtQHOQ
 tixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542563; x=1747147363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBeKEajXSmAhb7LijWOPketZcw3p7yrO3ri2YB9hhOQ=;
 b=gu4xofRZG6rvce235PwC2b4MqZWhYu1zHLt/XtjFFVYM9T7Pds+DOkHyNyelQ9BWlm
 W8dt4t7jB2OSI8YOCTUiReA+fIUhmQK7IcdIxiaRo32B9HK7dpXS9MYV1PmoYvr+IP6U
 TgZxsqPL18nf1di0qm0WMHgO2eY96Ybd1+0iK2PoxQTE4OYJwykmz5CsLFZVAB7nW50n
 +uGoO7NwMTnoXmli5zOSROJJG4vZFeXlDu89U5a6XHwFGfctWyLXanVuvknOTcyxfUFi
 jr68Bz6eVpkjF3IHKalF0SgpwSjgoCDK6uBm0wbSg7XI3KUA6iS5Xz1a9yLlLbafrfhY
 2bow==
X-Gm-Message-State: AOJu0Ywi8Ab6fopgw8XLIRJTjLRjSUuQAIYaOi8Zq/fdQfAUggTBK1fz
 FZgRZfPhjTjUdfEVtfpDbMoELr3PHEDVHRXMcMNb1KnUyXW5MzKS5mon7t5+b/WghLlE+DlCaij
 P
X-Gm-Gg: ASbGncuyNOJ5JKaZXo69+/ep7Wz8ztFTRcySxxgp8wcDDkz4dNtDqYk3dAYATKIsLsK
 WH0xrXdRZP7K0lkP9GDdkMjHlo86n2TnHa6v2n77mkPqzY5nVsPgz2UavSPE1cfSFlSO2KG9onY
 c39uUxkgfQVhuQvprMUau7zBl5ptJ6oOBIw70y3SQbFJfjt8TZVIk/x3ARg6TsV3nSGZp/gkdjX
 a64aCXdJMICbUS/9IHgCIYZE2a7emX7j97sGE/9qQlaAUgpEltdKkDMvfPCX2WMcVKg63ptR2yO
 +725BuDCTgEr980obE2nMnI8blxhwC6fpPvUO2kCwyWdPG5TJetOzhE61g==
X-Google-Smtp-Source: AGHT+IGnAIz+wCx5wzhhb02rvAFrcs4AfTSGJL1QFLF3P8/cSCzhpf+iMVUuy+utdkDAMq+1lkiG6g==
X-Received: by 2002:a05:600c:3c90:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-441c48bdfdamr114573375e9.14.1746542563643; 
 Tue, 06 May 2025 07:42:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] docs: Don't define duplicate label in
 qemu-block-drivers.rst.inc
Date: Tue,  6 May 2025 15:42:06 +0100
Message-ID: <20250506144214.1221450-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Sphinx requires that labels within documents are unique across the
whole manual.  This is because the "create a hyperlink" directive
specifies only the name of the label, not a filename+label.  Some
Sphinx versions will warn about duplicate labels, but even if there
is no warning there is still an ambiguity and no guarantee that the
hyperlink will be created to the right target.

For QEMU this is awkward, because we have various .rst.inc fragments
which we include into multiple .rst files.  If you define a label in
the .rst.inc file then it will be a duplicate label.  We have mostly
worked around this by not putting labels into those .rst.inc files,
or by adding "insert a label" functionality into the hxtool extension
(see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
argument to SRST directive").

Unfortunately in commit 7f6314427e78 ("docs/devel: add a codebase
section") we accidentally added a duplicate label, because not all
Sphinx versions warn about the mistake.

In this case the link was only from the developer docs codebase
summary, so as the simplest fix for the stable branch, we drop
the link entirely.

Cc: qemu-stable@nongnu.org
Fixes: 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label argument to SRST directive"
Reported-by: Dario Faggioli <dfaggioli@suse.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250501093126.716667-1-peter.maydell@linaro.org
---
 docs/devel/codebase.rst                | 2 +-
 docs/system/qemu-block-drivers.rst.inc | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
index 40273e7d31e..2a3143787a6 100644
--- a/docs/devel/codebase.rst
+++ b/docs/devel/codebase.rst
@@ -116,7 +116,7 @@ yet, so sometimes the source code is all you have.
 * `monitor <https://gitlab.com/qemu-project/qemu/-/tree/master/monitor>`_:
   `Monitor <QEMU monitor>` implementation (HMP & QMP).
 * `nbd <https://gitlab.com/qemu-project/qemu/-/tree/master/nbd>`_:
-  QEMU `NBD (Network Block Device) <nbd>` server.
+  QEMU NBD (Network Block Device) server.
 * `net <https://gitlab.com/qemu-project/qemu/-/tree/master/net>`_:
   Network (host) support.
 * `pc-bios <https://gitlab.com/qemu-project/qemu/-/tree/master/pc-bios>`_:
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index cfe1acb78ae..384e95ba765 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -500,8 +500,6 @@ What you should *never* do:
 - expect it to work when loadvm'ing
 - write to the FAT directory on the host system while accessing it with the guest system
 
-.. _nbd:
-
 NBD access
 ~~~~~~~~~~
 
-- 
2.43.0


