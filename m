Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F5BCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1SWz-0005J5-4S; Wed, 24 Sep 2025 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1SWs-0005I2-KO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:39:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1SWf-00006d-6f
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:39:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e23a6617dso130005e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758731953; x=1759336753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eeqAk2Jyan0GqrbvgVH06Gi+p6oEHUacWiCvS3RqmM0=;
 b=azCGnAct/mYuTZBqlLXErg6ZV4M/FUxvgdSgArqQHFw9bFAWWLRrtMhrdAMqHZDd5/
 iTEF9FHHSl30W1oznixAdnCkXpxK2iI3Z/D9iKtRr8H2GjHvQNJccKWM6EkqvBSmsrvo
 PNOqXPm/WmFppJi62mBEEGAFOgBBybgFD0jEwQnOPW8E2h0ULsMIqr5rZL6mJL4XusyG
 qxTllM8XvR8zZbdmGGXckhYyBRSqHD7ce5As+sZEYsAvJI8UjAeg8MXQxhT9lQoCN0i5
 DrCS2k1JZh7NkuU7pBSNoyAcX3xtKdK4JkcSapfBU0whBgJws7RxutJJkjmLJ6juzNE5
 WeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758731953; x=1759336753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eeqAk2Jyan0GqrbvgVH06Gi+p6oEHUacWiCvS3RqmM0=;
 b=UHXhM2xGurbBCQ9csg3hC4xzWHtPmlOePhGB8KuFbkuNtb6wULLi1yz8ztFMAhw/BE
 7VZeEBbk/2cFzOG26vEeGakp2nsXq7FqUlV++rsaSVrgqo9dHMyE/9SrFX1PRJzMmaF0
 9kCFuo6B8T0fLXkiOvyIuh1ZAgpdT9XJeYyGxOTURJkjYPdoFxPWMz75ObNHJU0j+GQs
 AigG+3eWqTaWGV6YVQyPjhEi4p99z+9ATlfU3UlTy1vsH4lHXgiMtyTkRDrUwp8smqmj
 MpE0C/CYKJRRgKXf9ah7qt5eXlhxHuTps6kJFZgRl6RgYpYjE5m/lrkChXKTYe+XxRZd
 sQ0Q==
X-Gm-Message-State: AOJu0YxTbOrk/OvrZc3APN4uxzS6Qt7d9Jw88Ws5DbcyX2PzNdZf3+Rx
 0dKKVDlJdp+IZRsT2D+Jvqer3eWUlaRGQPmLSeFjz3PSZTL8hCwZ7mM0XnmppUVhftAeqAy2CI2
 kKV/F2KfpAmQG
X-Gm-Gg: ASbGncvE9xhw+VPtK0S/CvmSA4zvIloCJTkcA2RPg/e4O32d1WHMYZu/fXHOej25FyJ
 GOFlEAu11sQTc7zyqlFOjTu3vC0PLvUky2yd2adoq8TdMfxo1rwsIbJgm6NRqVP2NFEW6SXSE6k
 TDlSapAw1Bn4942sZw2a0asSmorR1R2d18g7ERD1LlXJxmUxMTaLOTyYWGbKWNJ0GgTOECsU3zi
 8f0OcT6LLqHcDt12uGMTqdfeK7DhQl7PMxFKbwPLN6qvom0JALDjfrRok895gKIb+uXIxo62mkv
 O5tAkMtwPTzWH9z1WOcRV9nORx13ex2v82r3YQi984Q+HNDn+AASgi80OLq3bn9qoAEuRLQuYrF
 W1/PN07FP9+lF2lBwtKsPTHk2jw1ncK4XkupaoYb0ybUbH38x/XlvdwIioomyZ5kYLg0fC69G
X-Google-Smtp-Source: AGHT+IFaHoimVBp+twR438md+QB0HD/Nr5kuW6ZlzDHZtPED4dPV+tGPQZIvqTExJo0a+1gteWRVFA==
X-Received: by 2002:a05:600c:3b8e:b0:45f:2cf9:c236 with SMTP id
 5b1f17b1804b1-46e329d4744mr6275415e9.4.1758731953478; 
 Wed, 24 Sep 2025 09:39:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2aadf5c9sm39028005e9.19.2025.09.24.09.39.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 09:39:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] scripts/checkpatch: Avoid recommending legacy
 qemu_bh_new_guarded()
Date: Wed, 24 Sep 2025 18:39:11 +0200
Message-ID: <20250924163911.51479-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

qemu_bh_new_guarded() is considered legacy since commit 9c86c97f12c
("async: Add an optional reentrancy guard to the BH API"); recommend
the new API: aio_bh_new_guarded().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 91616c974f2..6a0c06bebb9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3197,9 +3197,9 @@ sub process {
 		if ($line =~ /\bsignal\s*\(/ && !($line =~ /SIG_(?:IGN|DFL)/)) {
 			ERROR("use sigaction to establish signal handlers; signal is not portable\n" . $herecurr);
 		}
-# recommend qemu_bh_new_guarded instead of qemu_bh_new
-        if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\bqemu_bh_new\s*\(/) {
-			ERROR("use qemu_bh_new_guarded() instead of qemu_bh_new() to avoid reentrancy problems\n" . $herecurr);
+# recommend aio_bh_new_guarded instead of legacy qemu_bh_new / qemu_bh_new_guarded
+        if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\bqemu_bh_new(_guarded)?\s*\(/) {
+			ERROR("use aio_bh_new_guarded() instead of qemu_bh_new*() to avoid reentrancy problems\n" . $herecurr);
 		}
 # recommend aio_bh_new_guarded instead of aio_bh_new
         if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\baio_bh_new\s*\(/) {
-- 
2.51.0


