Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF1FCD98D8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY2Vz-0006RD-K0; Fri, 12 Jun 2026 10:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wY2Vw-0006Qu-9l
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:05:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wY2Vu-0003DJ-8K
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:05:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-491b390f9e9so3338675e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781273136; x=1781877936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xp7vY5UphGOs1n3bwR9aAU6Zb6ExPajMhjsbYT+FvfU=;
 b=NKyHMdb1uilvizmac4U0SHo90xWMA8U1ydOUsoN1ooa872UzgxIPSIWrY2IJos4VUj
 WvJ74y5defxhlYYFLwqP3Y0sbX0AF0fBb5+anqhKcc9tMOi0WbEpGKIA6hSEelq7yp07
 zopGk1xu6SWT6LwuXv79FjpqzL1/FLxtGhhhKYDz4yJMJxVmmXwwiAaY1mvIS08Vw/WY
 SCddwH1Fb5pcjBvSjz84sRwgeNRoXfvis/JK36G6rAAq6lrkcthCx+O0zaUoamfbFfjr
 ZfvXaMaeHrfe1G9CfiK1uvJLYQA84ODV/pjTOUeOStLavqr1IVzhsXWQGlFDubjwdQwv
 Srqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781273136; x=1781877936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp7vY5UphGOs1n3bwR9aAU6Zb6ExPajMhjsbYT+FvfU=;
 b=FTdiWpXohs5j/pyMtPCio8TxjMnOGLYwGPXew8wXI+JV7R10OYPg2LucYEnO9nC9oK
 jv4QqPhRY+aC7PtG1aTBCPywUlBFpQoYKZXm/GxpXNpujYpIeFlvGpz7g4wiERimxwoB
 Nv/lRewO2vD4pGK+SlJaR1IEEBy4qp3ltHWtLMLgWyr91okJQjJvnI5vRGBH8uXWWx6h
 c2Y/ZCNnuaVpRJhlK5nKMCdEApEsfDq7g0jWJfrAgWC5ljmwi/66+GZn6PypDM4fkAea
 egpP2fCiRi8smGwJcu+9dlt7I4zJ5EzCdg3ZwLggkOO20o/+DP9yhELmUPL8V47B4e24
 UVzA==
X-Gm-Message-State: AOJu0YxM/oY0NN1U6R2xjvkd+HsjiQzzpR/afJT9iMiCUXZJH/oSE5f8
 brKJKtGzyK8z+DPbGJeG9yntChLsi4p6+6hA+1R6f1bmUBHGb1/livF2inCGfsRcfV4=
X-Gm-Gg: Acq92OFzFZjJkNxOyUC+sn6cxVtOCyl/N7QBCXyPAykV3zLD6R8poPnaaqN53KkUtZd
 9xJl1hRSiSGH5ROfjHuw22CRIsXPei/mb/OIMAyIChKv4fFAyAkdRn7Z8a7qjYTgcgqAmivJNWw
 g3u/GCNOe7plnExsMXRTCDDWfle2pUjyVuIyqC0WYzWxEioO9tMYR9i2wS+NFd5CPojPBkFdTpr
 00JpenVU8UNoTAk5z9ivbx1CV/k+dZmfCJX/cqUfCFGGmYI3IAb3aE1h/nw7AZ4q8G1V43W3p0t
 vC3eXK6jMTiBSQfdBbKa7W6wYwQvhj209jYXlagzeJhhdZCxjkSatIf/Z6AhSO+qh2KIqPyBnEP
 tNm8tRs0BNVj/2tVbfnv+1m+zyGTHAt+4M/rYzUf82Vo55xLAIYillFzn/EdGx6P1hOSKq16yqt
 WmBWbTHGrHBXZwl0/dmsJjvjE=
X-Received: by 2002:a05:600c:3b84:b0:490:388f:1c0d with SMTP id
 5b1f17b1804b1-490ec4a1607mr46048125e9.5.1781273136188; 
 Fri, 12 Jun 2026 07:05:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea52sm159034555e9.2.2026.06.12.07.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 07:05:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 813205F814;
 Fri, 12 Jun 2026 15:05:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH v2] tests/functional: tell pylint not to check c-modules
Date: Fri, 12 Jun 2026 15:05:31 +0100
Message-ID: <20260612140531.3530387-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

To fix:

  qemu-test.test_pylint "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83: I1101: Module 'cv2' has no 'imread' member, but source is unavailable. Consider adding this module to extension-pkg-allow-list if you want to perform analysis based on run-time introspection of living objects. (c-extension-no-member)"

Manually running python3 showed I could indeed import cv2 and call
those functions. Rather than allowing pylint to introspect lets just
tell it to skip c modules.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/pylintrc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
index 049c3e76f12..949bea611fe 100644
--- a/tests/functional/pylintrc
+++ b/tests/functional/pylintrc
@@ -58,6 +58,7 @@ confidence=HIGH,
 # no Warning level messages displayed, use "--disable=all --enable=classes
 # --disable=W".
 disable=bad-inline-option,
+        c-extension-no-member,
         consider-using-f-string,
         file-ignored,
         fixme,
-- 
2.47.3


