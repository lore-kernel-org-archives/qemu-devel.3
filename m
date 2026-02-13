Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96874EDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvPr-0001ss-Cm; Fri, 13 Feb 2026 10:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqvPn-0001qB-M5
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:49:07 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqvPk-0007w4-64
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:49:07 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8f992167dcso130803966b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 07:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770997742; x=1771602542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuwDPGR02Gwv2B4v4N7w3i40mJ2a9DDLTQnWtjoONOk=;
 b=VHawES1+o1fCj5dbzW6lf2Nw/+SL7HB0/Z+XJoIV5XRiO0e0OOy7AL/bjQC9cTj9FK
 79U4MVot2RnL898RSxt9C2zXu9Q8RrS8eqqxc9Pqfvh9ZjoihqqnIFNT0J1Lnq7CJDDN
 n+U7Tp4kUugxLd4+GYbZ87CfUHw5oWUfUIiOMhZ6w/go61atQ30aSNYyuJLYQnzEaCoj
 5XvnJgtilFD9YjAmCRXOcNKZFz6d43FDOkJadjc8faG0/+uBBRC1/BUxwYcuYIxjpHWr
 RLeQJISAwszUPn0M5XyrYNVv5IKY3MRsVYNBT7kL4tDUcq22ry/OUSQZFrm5sxfoV0sA
 U2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770997742; x=1771602542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FuwDPGR02Gwv2B4v4N7w3i40mJ2a9DDLTQnWtjoONOk=;
 b=wODik1vcpC+Dv8vXcC50+ypHwQrYp5Ze1ZUxuTkKpHVz3BGhQ0TSy2OTqU9nxNYAVQ
 DSSIAFhI89M9ydTg9+Hma94eZmji0gO2VU4IjMWst/5N9EkgDZG7mHa7UBpy9xfMUqKw
 CYSVA0B/gxLgUNkMQce9OvRJv7FYuYSyNeZte8dMJTEqaYcnThybxrB0gxoTRw2Kp9sl
 Mq7uduT8D8RRXJz7EFVfupaxoVQSlPgyzBCqvfZEiYLLtODNdvfn528MNNA3AIeE5kDz
 QKk2TWGOF2YHfonmLSBfZOYHzC3TYtPkIjYH/5960e/hto0PQI6sp5wOs9BPoBCtqO5K
 Epig==
X-Gm-Message-State: AOJu0Yzip1/Kic4ZEkqIzL7h/qh4XJkVm/oKGf8gq89f7oiyhfsV4+4L
 ztucjfdJquDUnIzfcjpJo+cS1ivzrKIss7YHZyV0R16w2UtRe76DPmWScB6j30HAWrI=
X-Gm-Gg: AZuq6aLXDrDhSJs9X8xlyco1bEMKEjcsjCoTZVzznqW8257UXvOukzbjov+DxKh+jf4
 GpWUa/k6QRAw6C+ndROFAZT3TpKAGNsoZ5LQQqN7roS9Y7cQqCC79uITnWt5Jo93P4dZJ+AYblH
 ZktinlUKqPKplitWZcF1+DchFwzKQhk0ELlR/hKOo3QFF2MOAYr/fRfYmfxTNN71QCuKVC6eFYL
 0ryVckvBSGTINwTVxHR4erji6BTS0VtzauPy0RcR6LDZ+w/AQNnJUIrbXXDb4W9rKZzDz+U4AdS
 2uGC7T7J/vzNCKwcOg9tdf9JCLsD3U59xVn8F9QWVD2obSrYAajszcMXJ3bADzBsZov1d3Gz+sW
 j8HhE295hmvwTiBw2fJPDcZyBR+KNpV0t2e9aZTErCiWZnmg3sMjQ5yUS+FN6l53wB8WJiG4Z7j
 dE5ztdLifcQRuQHW92thL80Wk=
X-Received: by 2002:a17:907:7247:b0:b80:751:ee62 with SMTP id
 a640c23a62f3a-b8fb41d18bemr122943766b.14.1770997741941; 
 Fri, 13 Feb 2026 07:49:01 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8f6ec35688sm267902966b.51.2026.02.13.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 07:49:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 113025FC79;
 Fri, 13 Feb 2026 15:49:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 2/6] tests/vm: bump OpenBSD to the current 7.8 release
Date: Fri, 13 Feb 2026 15:48:55 +0000
Message-ID: <20260213154859.1551283-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213154859.1551283-1-alex.bennee@linaro.org>
References: <20260213154859.1551283-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/openbsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 2ea86a01bad..88b31dd9b59 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.7/amd64/install77.iso"
-    csum = "da0106e39463f015524dca806f407c37a9bdd17e6dfffe533b06a2dd2edd8a27"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.8/amd64/install78.iso"
+    csum = "a228d0a1ef558b4d9ec84c698f0d3ffd13cd38c64149487cba0f1ad873be07b2"
     size = "20G"
     pkgs = [
         # tools
-- 
2.47.3


