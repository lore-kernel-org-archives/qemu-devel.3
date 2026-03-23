Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF0BEC01B6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bvY-00017v-4X; Mon, 23 Mar 2026 05:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bvW-00017Q-BP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:50:26 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bvU-00020Q-Ko
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:50:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo3098780f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774259423; x=1774864223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fRUbWa9EoshrLPcFotiw2eoFcJR1oBcx2I97maoI5JQ=;
 b=PdvhxgQhpqf179vVD9Pruvv0vtvqlxv3Osk8QQSp30Zkpcm/Wva2EP0Dqe5TgwjIxD
 bjl7wv6RVkwKXDTwCGISyz2y6SVvELCgONw7RtyEGGU9C0j/nnvO1JnyoOVtfLGCW8wu
 20K2M9qp/RbEkKBlf4NhktQ3iySkHsTYnthLXPA+Z7FHKhk2mwmknhdUDEGLffqaRO0r
 gPxIiVgApby74j999XNDjvhNuzOemMb+5THsNdRw0Y/ub3QcYxNWXvSAlFYygbzklIO/
 V5++eOZJk3Vb7qQI6zIGAC71AAo9BaDj+tLC4BI77xYQaDEf8T/yi4BPiQpPQBfoxMo3
 mdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774259423; x=1774864223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRUbWa9EoshrLPcFotiw2eoFcJR1oBcx2I97maoI5JQ=;
 b=YB1m+wexsiMNIobt0v7naBYE68HcpmRlm2UdWLiWVedXAa7cBPve+4Z4lJBMkuyRXI
 l0VQhADfYas7zFc378FV53v1m5v2GdfTT6pTR9r2W2D+xcnYXuXwylBsUAkmlJi8HdRj
 zdlYB7KbZ0EW2j2wP/rrHjDlu9GAEc3SQEAoEzaouiDU3nUqAAdfe4qMHOztnzbyNCBP
 CoyNXq4omwfWqEpRggYzg3cW7K30iDGwPyiEa1Jm4lhBEmDYPeCcAM6ySoarJIPE/y0e
 OMyiHzXPkrxdT/+IMignd+Ji+KOcelwPp8mg+SkVXvTq8s3EDOiLSzmzu4mOlByxA6+d
 rPew==
X-Gm-Message-State: AOJu0Yy9/gIupluP+HTNOOQek0CYsv8+5udGdu4AmwkL1RzYdYX6yXxk
 qDTVXz/OFh/FxN4m2114g7CALz+XISAie0ZXAUhsgz245enf69ascxySmYjuVWJwgBc3H9YFj8G
 J4xK2WFpNPw==
X-Gm-Gg: ATEYQzzSGZUik7/dlor5W/5D72TebNFw0AYZiqBDp+dShUbW8488x3jbnCDhOjtOw4t
 On3bMdqrPzDJn23TOw5/Ok6npyf5+CYjiA5wyutXw4qtSqR6Hbw0YOt5Jm4yeabu/8LJr9o8OUz
 dfp4tse+0stqnGcNrott2jrz1RxL6hg+EJ9vnyZo7tkrXKgJKTej/joIl7IhuxFGu6JH17BqYht
 GkiFDcDpVcDgleOvM1UnlE9vCyMI40SBgJpIDp0p9FAFFPBVKGpBHF+KBVXjxB2LckPwwOXRxCr
 zKDtUBcDBhd/JCfDPz3vN2vEx+vXZOLGhh0txoLrPrm4Az2pHiMEeOPiuKxKho9EBQzXByDdDVM
 GUpM0xZBFB50bt82r2WA8gtfrM25Upj2blH3J29JS3BHiw73L77K6WYv+HtzI3nbg+pLaweTtPl
 VikcrmefukPgPFJZIszT6AaDM8PeYLn+gZXVPwurPnjmdPQRMhDtbzCnFKXs4wkr0OH16CHsSr
X-Received: by 2002:a05:6000:290b:b0:439:c67d:9fe8 with SMTP id
 ffacd0b85a97d-43b6424ef8bmr18413472f8f.22.1774259422581; 
 Mon, 23 Mar 2026 02:50:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae132sm27424526f8f.6.2026.03.23.02.50.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 02:50:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-11.0] monitor: Correctly display virtual addresses while
 dumping memory
Date: Mon, 23 Mar 2026 10:50:20 +0100
Message-ID: <20260323095020.66658-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

While reworking the address format width in commit 6ad593a75a8 we
introduce a bug, leading to addresses being displayed with too many
zeroes:

  $ qemu-system-ppc -monitor stdio -S
  QEMU 10.2.90 monitor - type 'help' for more information
  (qemu) x/x 0
  0000000000000000000000000000000000000000000000000000000000000000: 0x00000000
  (qemu) x/x 0xfff00000
  00000000000000000000000000000000000000000000000000000000fff00000: 0x60000000

  $ qemu-system-ppc64 -monitor stdio -S
  QEMU 10.2.90 monitor - type 'help' for more information
  (qemu) x/x 0
  00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000: 0x00000000

Correct the format width to restore the previous behavior:

  $ qemu-system-ppc -monitor stdio -S
  QEMU 10.2.90 monitor - type 'help' for more information
  (qemu) x/x 0
  00000000: 0x00000000

  $ qemu-system-ppc64 -monitor stdio -S
  QEMU 10.2.90 monitor - type 'help' for more information
  (qemu) x/x 0
  0000000000000000: 0x00000000

Fixes: 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr argument in memory_dump()")
Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bad034937a9..bc26b39d708 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -537,7 +537,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     uint8_t buf[16];
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
-    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
+    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() / 4);
     const bool big_endian = target_big_endian();
 
     if (!cs && (format == 'i' || !is_physical)) {
-- 
2.53.0


