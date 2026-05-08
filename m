Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8723BCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIk0-000139-Li; Fri, 08 May 2026 06:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLIjz-00012o-8v
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:47:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLIjx-0004GD-E8
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:47:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so29315855e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778237247; x=1778842047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9hmTdjAGYEFbjfkL65buTiS5hMFYJAuwkxpFwe5VIWc=;
 b=nUo7s2zoabm74gM7ayUfX6KsL0JbL6+DK6h0BgoIFEeMYj7F0FA3cUyie4k6KfIuQA
 SxErWFNk1ijcZhpvYxjMrlhXvCb1zyAR6/H3mhKjlfi71Q9NBvzawAahuiRAjY9rJCIg
 3GoOmsnsC8e0c6XGKqnMxQEHDX7tDYhOZcuFczR01ORxJGV9H8ED8uKPWqzbhwJpdbtA
 1hkAUkduKa0mZLgKYD9uEe1OktBeVXR6NOdKmZ+9tU1LFJy1myBbV8QtcfUSLSnCcpCd
 m39dVtJ82cDo2nebEYNN2Rcd3DooU62eYsA0sjZukw5MADNQQWtmpKVTPIH/bbQwqQZy
 G0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778237247; x=1778842047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hmTdjAGYEFbjfkL65buTiS5hMFYJAuwkxpFwe5VIWc=;
 b=AaaTourzqGHUfNou+SK4PyL3TgecrU+cNFVPem6VPLQgrlrJeY4AV2o+MUngIhI0Ap
 549TUnEXpTLpyrydQ6+DQLiTzhVlJG1Ku2n1jrH6ws7FiVpJMiK1A232YIIi/4Mwt1gB
 Qjr1J8XvHU7NRsPJjAh3hWhYE2Pu1puHmL7mZlSHc66yTPig92WT4TnAAkaje9HcDOOC
 N1lBu8KECnI80lAsEGGB5Dfx+9IH2TeqROBofW6sFRqz7hTzGdEHDVqY4LtKEiKiGzrX
 TB4P3jCVqC0FjwqdCVlbUPBQTSKnYEBxHwfUkiu1ZZnTAftKM12z76H36n3IKGkZioxX
 /u+A==
X-Gm-Message-State: AOJu0YzrQVCTPusmTuxeSIDagggmk1Znv5DY16Igc7/X1NsYSPzlE5AO
 piEt0a+EwvW5bSovh0Kcmv8odGO9kgZ6T+mx0p0g7EtZGA77Ton30AKMQezAtLtp1ZYC80AfFRc
 +q/Sj
X-Gm-Gg: AeBDieu4lPdbvrLDPyNOe0F5E5j6OUQR26BanzTi5NYnXMI9Zi1kAoHTULgf+BR6T4H
 Hu0OG7q0JEw165tJtBJpm8/nhudS1DPqD/qCm+9u6Zulm2rWjuTCVtsjhrKbSOiUks6DqhQ2VK8
 tqoaHXEBMCsq9AG4iP1gEmNF9/3N7RH0bXwlDb3axD+Mt8aZicZBJC0M7PO/afaTSm+JL/ryzFd
 9AGWND8kq23CNfv6An6rzeOmFzjrMffhwmg7pfF7BKu/OpBK3VY24FvcJGKBENEAhXJXi3Y36JE
 F7Kpo7AX2rzdHZ8U/YftsPfcDqOjCvDq6xLzJWMurXoH1iIVZaOMV4Yz3x7dy5dwgY8IYEtRchI
 KwVZ/auMJibGQcwKm3NnXw5NT7ubrpTen2kk7aH2GZ2KuY49Crfmok5ZwrxL9D0VASpeTtNUwTH
 +minNz53BrCfm6k4eUi5q4FjQqq8rU8ri5gttMzWA0dpXI0wrOHxt60o/pTbVjnxp1wxVdU8qVT
 1EGLsNybuQkxMig91wMnBtY5p37lwc=
X-Received: by 2002:a05:600c:17d4:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-48e51f4cde9mr108350025e9.26.1778237247313; 
 Fri, 08 May 2026 03:47:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c01d7bsm20444105e9.8.2026.05.08.03.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 03:47:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] meson.build: Add -fzero-init-padding-bits=all
Date: Fri,  8 May 2026 11:47:23 +0100
Message-ID: <20260508104723.2144051-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The C standard doesn't always guarantee that struct and union padding
bits are zero initialized, even if the code initializes a struct.
For QEMU, this is potentially problematic, because we often have
structs that match data structures in guest memory, where we
initialize them and then bulk copy them into the guest.  If the
compiler didn't zero init the whole of the memory containing the
struct, we could potentially leak random data from the host into the
guest via the padding bytes.

We already use -ftrivial-auto-var-init=zero, which will zero out
padding in many of these cases, but -fzero-init-padding-bits=all
closes some gaps, for example cases where we initialize a
variable with a struct initializer, and cases involving unions.

Follow the Linux kernel in using both options. Compare kernel
commit dce4aab8441 ("kbuild: Use -fzero-init-padding-bits=all").

This option exists in gcc-15 and above; it's not supported
by clang, but clang documents that it guarantees zero init
of these cases always:
https://clang.llvm.org/docs/LanguageExtensions.html#union-and-aggregate-initialization-in-c
Older gcc which don't have the option behave as if it were set.

(These options are passed through the cc.get_supported_arguments()
filter, so we don't need to do anything extra to avoid passing it to
a compiler that doesn't recognize it.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
CC stable just as a precautionary thing; it's safe and we
might as well make sure the hardening options are set there.
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index 5fbdc75a0f..d3df10eeef 100644
--- a/meson.build
+++ b/meson.build
@@ -684,6 +684,12 @@ hardening_flags = [
     # it harder to take advantage of uninitialized stack
     # data to drive exploits
     '-ftrivial-auto-var-init=zero',
+    # Ensure GCC zero-initializes padding bits and trailing fields in
+    # unions. This avoids potentially leaking host data into the guest
+    # when we init a struct and copy it into guest memory.  GCC 15 and
+    # clang don't have this, but they zero the padding and trailing
+    # portions of a union by default.
+    '-fzero-init-padding-bits=all',
 ]
 
 # Zero out registers used during a function call
-- 
2.43.0


