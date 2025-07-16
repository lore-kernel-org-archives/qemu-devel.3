Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877EBC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5vt-00020m-9H; Wed, 16 Jul 2025 13:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc5vo-0001uc-5I
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:28:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uc5vl-0000Br-DK
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 13:28:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so881035e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752686911; x=1753291711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWQe0nwaHjFSPbzauTR/fxg60n5AbbyVfV/ixwGD2ZA=;
 b=joR7FKTo8VLlQrV//2eA0+ep+sNdHtOZvnZbJxl0kl4tFQ65bdsQwYNa75qZr4kyrD
 GoySaN+P21wck7cPBGDQrgNvOUeIp2lF19or2HRnTh07I6cPp44vcmWkpLBQVSfA3NBO
 YIVb5/ALUGrvuS3P6nxYS3u2kqSuCcIkEBAgnL6ROvzQvxhHBAZHYCq+GkgKulVoSoFi
 XZzc4xFk91Jgiesn9oOh3koQy/dhXPfbxTVcBCd9UWsIzQoKgy6h7E/x96XSp6sAq76X
 inrNUFLUNFnTZq2mY/bC4TaaFVRDceTL70R90NurYRtgGpkOaH1T7lwv2wVCLgOoojd1
 u1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752686911; x=1753291711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWQe0nwaHjFSPbzauTR/fxg60n5AbbyVfV/ixwGD2ZA=;
 b=CJ4sbmPqCainzt1QNDmqXJlOxoownkxGO2UQohGyLZ3MuHzhw2Qh+MgrnnDDbYSAcN
 KcvFzKEBaZ8QOhB2sF9/mCDftNb/CPhxHQUbtmH4IQBwtYYO4yf+ZSbdZWXbQIEkfRsB
 9BsTC+apC/xV2sLDTsHwkBXy1RqDWEK+vESA8ka40I5RyyXHIualORwISAky0kN4Rrf8
 g5GLCKVJuqmQVf8alTv4JfOETlq6SYMUBGi+GV7Vo6jHVyrDZCU5NHjIpUZX8cQLjWSA
 hyKGUhF7/JgZ7yyiR3f35uBZXLe+Ioq2d6r+JMEwZC8QpAgAH4UWvgeDVdYWtoABOj8p
 AgHg==
X-Gm-Message-State: AOJu0YyoTaJBg/j4YBks7VDzBmv9h30Kw8FcmEdcgw13nhFM8oV/xiS6
 nIQNlnZrtE7qzKhR7AxmrjPsnoVi3rcs5rhUE/jcB13wITZc0UI0q+SBcuBBZv/7yQ1ZfM7SjaV
 YNsBbMns=
X-Gm-Gg: ASbGncvy1gMCTNEPt0ojmhq/njJpEabt6voYzWJMnbKMqeOoYVGp889eMcNn5xXrtIz
 MufUXOOBapsMIpBncg5J5d8OZhwicLe4S6nckSFLgHs/ak52h2DMKOEk6d2PUkAMtgJ6PS51WJI
 xJXOJCXpkr8DINhQeWhSlHtEB9U4bS8U7We21rKSyr/W9thT4zZCleN8L/LgvKZnNVGnlbf72i+
 3TwWmIwkfq2EfCyO8dQMXH3G7BVNAXQtvXNQfRe0bfpExC+yZbjUK9I81IbVhdbJVg3vpKRjmNm
 Nm988CB4aggxlVuaprQZY4au1yPkRgiedEamChEE7gALHqJ8axqV4YnFV5ePZ9mJcELk28drUOm
 +IqRn2lQ1NRg2MLsV1c7JP+n9LAe7VMc9A1weHIdM/r0/W0SNCnw9GEPEynBnGTmE0mlM4DAb
X-Google-Smtp-Source: AGHT+IEjy5mT+VlMmimH2ItxJttWj0qTFpf6nuSVx7+W3QydPRBGRLmZ/xijNFByXbddHOJj4wQBww==
X-Received: by 2002:a05:600c:3496:b0:456:1b8b:b8c6 with SMTP id
 5b1f17b1804b1-4562edaa066mr35328655e9.14.1752686911508; 
 Wed, 16 Jul 2025 10:28:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e83c712sm26892265e9.33.2025.07.16.10.28.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 16 Jul 2025 10:28:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 3/3] hw/arm/virt: Warn when HVF doesn't report IPA
 bit length
Date: Wed, 16 Jul 2025 19:28:13 +0200
Message-ID: <20250716172813.73405-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716172813.73405-1-philmd@linaro.org>
References: <20250716172813.73405-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Emit a warning when HVF doesn't return the IPA bit length
and return -1 as "this accelerator is not usable", allowing
QEMU to try with the next one (when using '-accel hvf:tcg').

Reported-by: Ivan Krasilnikov
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f5..062812bf252 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3149,8 +3149,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
 
-    int default_ipa_size = hvf_arm_get_default_ipa_bit_size();
-    int max_ipa_size = hvf_arm_get_max_ipa_bit_size();
+    uint32_t default_ipa_size = hvf_arm_get_default_ipa_bit_size();
+    uint32_t max_ipa_size = hvf_arm_get_max_ipa_bit_size();
+    if (!default_ipa_size || !max_ipa_size) {
+        warn_report("HVF didn't report IPA bit length");
+        return -1;
+    }
 
     /* We freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_ipa_size);
-- 
2.49.0


