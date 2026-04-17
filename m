Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE916F43690
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh2C-00017L-NC; Fri, 17 Apr 2026 07:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh2A-000103-HX
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh28-0003xL-L8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso4854005e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776424006; x=1777028806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEvEamOQHBmameDSDr8g36Lk+2QPMHsbUKiwvPJl8u8=;
 b=WVmwTNnBqdhon05T+7aPI4ukzrkWeeaXFt0CMVcErBA0i33STP0gyiVv5dId9d5p3E
 flJl5CaLTIWY5Gdp8K4oCb0ZtevkDPbgJur4KPEyxnLXC2IEk7VpyrKUTz1flqUZViHD
 dCWLtw4RP5HQw3Brc/SRzfIcIv30rwC4bixbRKvGiROdQMeqWcViQJT5p1/rCiluN7VB
 CNJerdr3SZYteGuDm3yaekbhPwdaO+auGMioqPdomdeFd/6kDbqhpFJgMKCsndk5u8D2
 TVfHFfEeiG/NKEOxQibVLDxSrNPoj0bVuhgJeI/wdSvbZfotVrWdS9cWwf4wXCcaX9T9
 aPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776424006; x=1777028806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eEvEamOQHBmameDSDr8g36Lk+2QPMHsbUKiwvPJl8u8=;
 b=S8SkJCRrdgGOHji3VGlrNhSJ1Q/j0OgjFyvqj3DArLfArGYxqGZFVaWVRKBJdc+FnW
 xGLQEvEDZBRc3qUEN1YWhY+sHOJWWd6YCNlkElLPV59e9LLhDnfMLjb/sChR9Shosa2T
 w1EBeg6NePi6u8WbU7M7AFEkg7erL1mlhxWd/S4ffZUQyDAtRCdEag+aWaf3k5FWfAIX
 nvefHVS6g5XSPN8RO0/r9WQep+phoU5sLElJd+C/+sr6FpTfubZ1vH3H6POzywb4Pmd0
 9ds8ABcc0a7X0r9jug8ZGnDQD5A4kZ+nszlm4MR+OzVd0n27SSZZsI+x8EMgIP3zzGIO
 /Q6w==
X-Gm-Message-State: AOJu0Yyl2hE0jTAD0pTnumHLiM+2N1iHS98mx6PtAkM5r0ST1jn4HPLC
 /ufkBfIISiMV6AIc7N6XD6WhiBoaNtwqpExzJpuLu9vhPtD5/xqsBua4Bs7plMWoGFmvk5cwk9J
 kgJqTqdQ=
X-Gm-Gg: AeBDietE6OVMpCjQ93Dfqt57w4UiG70fTTNof0vM5AvuAZAUDO97h9Q798QgZnGXBRz
 27vKn9yo+DjVyvEumI64j+wiEjSTsyBg7ToVCLehuCDU589B75s9Z/3cEp/gKFozMh+Q01n4xgb
 D0LYT8QY3icPL59alvKqdCmxIHmMDC6VkbKUgcYRzm/BLbuoYsh8FiVsVKRfAX3C4KfGqDOtbgs
 hwwtUyZmmN1h5J3FZBvwXCwY9JYiErOfbotsCCB1/hvmn5zD8TcHgUI6PvESD/Im7CTpgftW8di
 CvAzjeTlih9rSqclXMdBL/pPKeFCd6hDVs9SNoyx0Iknty5Kqu00ISzxILRL2g3gAS0UJgZhgdJ
 hgnUyVaBwPxxBlg/sj+d6nF46+LwsCJfj5HHAgbJ3AqinQCq454VIqhBKR1TitR5hTWCJWe/v+P
 X+IcjZZnY+J/H1U4HAJhssyr68+l+oJqgqaL8ONc+L7NN2ayuRunG+bxAu+cMh9Mrkk992zcrXA
 cQN3d1uFRQ=
X-Received: by 2002:a05:600c:858f:b0:488:af7f:7751 with SMTP id
 5b1f17b1804b1-488fb768837mr23751115e9.15.1776424006485; 
 Fri, 17 Apr 2026 04:06:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0b4c85sm35398165e9.0.2026.04.17.04.06.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 04:06:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 7/7] MAINTAINERS: Transfer CI maintenance to Pierrick
Date: Fri, 17 Apr 2026 13:05:49 +0200
Message-ID: <20260417110550.70068-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417110550.70068-1-philmd@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Pass the torch to Pierrick who does much better and useful
work in this area: https://github.com/p-b-o/qemu-ci

Remove me from custom runner files since I don't have
contact with OSUOSL or IBM.

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cbb5d30709..1c326421848 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4444,7 +4444,7 @@ Build and test automation
 Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
 T: git https://gitlab.com/stsquad/qemu testing/next
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4489,13 +4489,11 @@ F: .gitlab-ci.d/windows.yml
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: tests/tcg/Makefile.target
 
 GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
 F: .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
@@ -4530,6 +4528,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: meson.build
 F: meson_options.txt
-- 
2.53.0


