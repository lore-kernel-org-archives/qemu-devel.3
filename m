Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265D7D29FB2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKB-0006x7-P1; Thu, 04 Dec 2025 14:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK9-0006un-1H
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK6-0007KV-OR
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:08 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so8781945e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877745; x=1765482545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtxwRFbRlZjM4xo9PN294aEQYGolkWcQI/Ck6g+FZjQ=;
 b=A+jT96H0OXCOFFjC+WZDy2E6fBfUj6oyt69JrjypBKJYFjzyx3MQrdL2ZXpsAjvPwI
 4O8ONq5E7q8WB/QTI6FALxBtu8g+NidU3dgFtK4i2uowVD8JYZp6vBLUJ8iCXRvUT45L
 f8cArV44fSXQ/nGy97SsjNXjQa7NDJTiNE+KNXcd8H7b/Fpwhjjr1WmAZWXCjb+0IXMG
 Cd/K1lHgtRgoFavIYlNfzVLKM7BfEfsK0N0kZ6Qy1Sgt0Y9aLhpL1nZ+KucmWnD6l5WT
 xbvGotUf/Ay3dqgjgXkWCzHRWrN2lYxchO77qyHeA/sLyGnZnEILmPicdzngBVvugarv
 XF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877745; x=1765482545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gtxwRFbRlZjM4xo9PN294aEQYGolkWcQI/Ck6g+FZjQ=;
 b=uQ0TBIE27EVQOeOcl0Zg0cGRGbeW/Z0zE/L2Gjhn5Cn4/+5QtHZtiwx5pafBnu/fYv
 G3RFFX+I2DN6gNYgZOMwS94VZ5Ajp8Ow8tx317lWdMqzZIEWns7+coZyb27QrhsKzlLH
 0M4VGLIjZIijvhv0+SHz0RavAGlRt6L5RTEO+G9iX6OcAI1zSQ4sfVK1lEAaIMg2DPUL
 aTbnzY6Urdqq41egycDmLgqR5oblUpm/+TI6C2VopQ8yeEe+G3lhd0k2ipjR/BisHZKc
 vmvf5qgzrTERQ0igBveH7XSoVnAvGddLhi5KdJw+7KxPSNHgcU1w3Dbrt+sQ3Bz0+/6K
 Cxjg==
X-Gm-Message-State: AOJu0Yz16Qc2dCeK0pnSHSAUXkLXLskS0TXfmcmbAj4QKQPYUJAwYB53
 9R4CUJg/nKGSj9+ZjEtWq+9sXHuaZLcINwu6EwnHG9LNYUXu4umULZsS/a+s8iVW5tw=
X-Gm-Gg: ASbGncvO8Bho03/z1awDYuWTyX6sNtqannO1o+Yv9PKp8ykcqmQN+NdoclHXGOQ/AKs
 CNAgVnXkP9DG60/7G7jc0Jg+36FdEacV/NMtI6YkPOujRfQf+96zCpn0HWau/7a0fzCM3UvcP6Z
 m6GZppOHu/UrJg9wQsvqGOOHpba6bZVd/NzKqwdPJzrxFAy680kRfIlPqDptdHRQcFHvHM9H+NC
 qu7RQTfPdMHw+sZkM3ISuVXPKqONJJFxzSXt3RtwpTcWPq8uPGctW2dXiv7BdyTGqD8EcPjB8EK
 A9szgijwwbpr743Xm3rt3SexepmZ6Vf2o05z574JxZJHqdsd/RrLisBJTnpwViJz5+Ta9SnJE0D
 5IJG/IZA3zDTY5JhE0KbGxvNzyey7cTFCjpeXTDXvJuZqQ1dR6UNqzmLkP6o8qH5+CO9lzqm0Y1
 Zw8DAcNE1LOa4=
X-Google-Smtp-Source: AGHT+IGJL1tXU+9uJgO2MIRqpl/CqKX/zxSz8m6TOhmlC/msJzvtaKVSuNBUSiCqRQHFZZ0OajaxLA==
X-Received: by 2002:a05:600c:1d0d:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4792af49480mr70702305e9.34.1764877744912; 
 Thu, 04 Dec 2025 11:49:04 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47933aef61fsm11173605e9.7.2025.12.04.11.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B89625F827;
 Thu, 04 Dec 2025 19:49:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2 01/11] gitlab: drop --disable-pie from
 aarch64-all-linux-static build
Date: Thu,  4 Dec 2025 19:48:52 +0000
Message-ID: <20251204194902.1340008-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Since we have upgraded to 24.04 with its new libc we no longer need
this workaround.

Link: https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
---
 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index 98d99193457..b4c0faab15d 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -41,9 +41,7 @@
 ubuntu-24.04-aarch64-all-linux-static:
   extends: .ubuntu_aarch64_template
   variables:
-    # Disable -static-pie due to build error with system libc:
-    # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
-    CONFIGURE_ARGS: --enable-debug --static --disable-system --disable-pie
+    CONFIGURE_ARGS: --enable-debug --static --disable-system
     MAKE_CHECK_ARGS: check-tcg
 
 ubuntu-24.04-aarch64-all:
-- 
2.47.3


