Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC81C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8gZI-0007CG-Ug; Mon, 21 Sep 2026 12:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8gZ8-0007BK-Ut
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 12:08:29 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8gZ3-0002wq-RJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 12:08:24 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso23362605e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790006899; x=1790611699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hAo0Hho+maQkvebwGWazKA+nTqRTbj+QViTrc1OXNY0=;
 b=ckZRgWFoJsmCXaPhLKE7EmqLM6uVsnmJ9uIr3Ntbp+7PF/eoZ7C/k72iLjMV/+ZfsB
 b0jTnwqPPH3EEF50C7dnabPIdw7R0nxH4Fmkpkc/MmYQGDpqVItb5gCnNc1x7ySaDYxZ
 FW6kTQV/4pw528zmZQURAk7vIOCteMH4qYYGV6dvx1vn97cBKLBrnMogQPwBuSe+J03/
 OTZ4Svc7C0ZkW3/YXxCPy4N3bSJXutnpI1QxcD5QJ7LY64asyYshTl+eXmPvoWcg3sjH
 U/azbY6wMolymZ6NPlKobtGYQ8ayouU7jMnwJKwW7JXCCq7MnV9Oe5XhyNYcLyOlNvsD
 /YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006899; x=1790611699;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hAo0Hho+maQkvebwGWazKA+nTqRTbj+QViTrc1OXNY0=;
 b=wWKxlK/t3an6kqhKIAaPTkGzmckux88D7uLcGeaEcWkERg7E/5HWA5c6ZE8GTE0dZ/
 QvtAX0IHQyDfF9upYsslPSs+IAaA7VQ+FpBQClxs3ozQRnzBliA57kpF1T0s2YsNYbz6
 VdU/uXNR3vuHsl3RCIhbmloB3CJV8QvIvqArTubp43xVH+3rLCZM6W507N7X3xxc/DGI
 drtph83vEK2R/+Tu0apxtWIbOedmp5LQlwP2v8wO3ViPDbXk+E9s2WAugXTWwP5FsMiD
 3hv4mzMbbAlf3JbYveF4hXCKqDWGMKu34rJI0EudpHJe3jUibMvoRfX/C1d4hBw567u7
 tDMQ==
X-Gm-Message-State: AFuF++l+qQ3uEx4vFPuXxE904yk6/zOPSzt6sSWPHH7ZB6C8adKbA3RB
 YuPVZWn8NTwevWYCN1+2Y9owUttDwKAYti/oW8Ary3JWbPSbagV+VFavQ5h3OFjEszY=
X-Gm-Gg: AYBFou3Na748xLiGJ/GeY4NsWnK/EqHEOup9J4OUlGw0bEjJRwjevMHZyUbZAXKxDTo
 UErbpPL2f/QS0OnLPjS3x0vyv+3j+ReDAufiVneBY9GWRNNIbH+bh7yhbH52DBNkWLZ3hpN270p
 jgezd77KFBxykiQG3q7IupX4P6OKFn7xfSxM1RBuJuLulxok6IL+INaQYDzb27WyVh+uvGjBWKk
 AzljxVOt63elvUptrs+cYHIRSXQO+xxurwNDw41rGAT+7vXscB+jmTHFOPQ4TWjx7W10+ZtQZch
 EYaRYd8VTio86FgpUwEi0gE0AKfSsUd5WvpBPf1UcFEb+YIxC5zkGSk931Lny6815EF+28egyPm
 MKb8XAzKlfLCF7tXs6Fq6Z6Rj4yiweAFcIXh3UYts1bAqRYxQdGqS7rhLUdwHPi5POQm3gJq8X8
 qlJltcn1U1HUy3D9AJ5My2Mp6YaSm3m0tEvNuIcQq2QlVgVfNBhdQzAIUuArMeTYxQg52Z5AQ=
X-Received: by 2002:a05:600c:4691:b0:49f:bd3c:bc1b with SMTP id
 5b1f17b1804b1-49fc572f297mr141924195e9.22.1790006899433; 
 Mon, 21 Sep 2026 09:08:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8b9740bsm1055285e9.1.2026.09.21.09.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:08:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF7495F871;
 Mon, 21 Sep 2026 17:08:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC PATCH] tests/functional: test_acpi_bits requires TCG
Date: Mon, 21 Sep 2026 17:08:14 +0100
Message-ID: <20260921160815.1623803-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Running a full thorough test suite on a KVM-only build fails due to
acpi bits needing icount, therefor tcg. Declare the restriction so the
test harness can skip it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_acpi_bits.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/x86_64/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
index ec716d643bf..62c57d23f6c 100755
--- a/tests/functional/x86_64/test_acpi_bits.py
+++ b/tests/functional/x86_64/test_acpi_bits.py
@@ -303,6 +303,8 @@ def test_acpi_smbios_bits(self):
         """The main test case implementation."""
 
         self.set_machine('pc')
+        self.require_accelerator('tcg')
+
         iso_file = self.scratch_file('bits-%d.iso' % self.BITS_INTERNAL_VER)
 
         self.assertTrue(os.access(iso_file, os.R_OK))
-- 
2.47.3


