Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016A3CEF17A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAyH-00070t-5C; Tue, 08 Oct 2024 10:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAy5-0006zS-TJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:13:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAy4-0007EF-E9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:13:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37cd1ccaf71so3761404f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728396819; x=1729001619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t/g4cdbbckmBk49nDH03Wv6cYaOlPs+FNuw7aPENYSM=;
 b=U8j5700MUGdrHX10kcsMRGfaBNe9w2HYlMlBZBMjwHTco3YYzrF6I5DxZmj1aUKaQx
 2dfJqMZkCsxyTevda+H1X6cam0BqtSu7I2Mjk0BdYEe43Z1/o44zr8yj7nb3uSygl5jd
 VfThlfu1ZtJVKrKFJ76yvk+w1kM0B18tV21nOmSBsmo6snOc08ULmfkE9hX2agtnhmuT
 2VqIr8kmWs1f1EWHecWWFbgayFAF27YGGs6iOh4FhzbfMmFzUqtlYXqI2kp5gRgbOB4E
 ANk7bt8jWTtpCwOTax/RLLU9VqY2vNMrlLcMFFu8Q+b6hEKmmCJBAWkpFlQ9nc7lSiqe
 E5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396819; x=1729001619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/g4cdbbckmBk49nDH03Wv6cYaOlPs+FNuw7aPENYSM=;
 b=b7OVLeMt6NskLbGsOX2D94ayXkBmPe4xw0rVubmxoP0k0hTWkRvlMNummhooPsOnnS
 92RfgvHuQeLY1AlvGAQPev/zJeZ2w1TWk7QqQR6q1xXqXunR78rSgwC312B0Cm6cxgsd
 o0cGb6s8DIAmICkAMuUCou8lrB2m6HMZ8ijEnFZ0q9ERwCCZV1MmLVffxMJCg7YU2vaN
 H40iM6J3W6wf8iOUh2cr2pB3FRZb+dBo5v5u84mldGHl0MWSxc9+JLN5EnG7SYBdlHze
 Yw7vecO3pJI2bSLHniEPCqLwUSkhywiPokSr+oJEbaH/PE9z2XktwvImbRBU1cZ59m/O
 873A==
X-Gm-Message-State: AOJu0YwdLRZW6vrwESNuLujuhb64mmdKk2/R506/4DfH7zCPkDea2pGT
 sFpbV2wY2Le+zDcnrGtc215fQCPszoSZt3sacFH61rIPAOZm20tVCmGI7Fj+xf2BGHH4fNgNmvc
 O
X-Google-Smtp-Source: AGHT+IE8qC3x2vnO9zGbNKNP8nO1w3X+JSgpXWToYSqEQHvNwjZ4BYLss9/1njt1rMgDrG47JjH9Tw==
X-Received: by 2002:a05:6000:1968:b0:374:b9ca:f1e8 with SMTP id
 ffacd0b85a97d-37d29340579mr2154022f8f.20.1728396818644; 
 Tue, 08 Oct 2024 07:13:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d31165724sm1405238f8f.63.2024.10.08.07.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 07:13:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/qtest: Bump qmp-cmd-test timeout to 120s
Date: Tue,  8 Oct 2024 15:13:37 +0100
Message-Id: <20241008141337.2790423-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The qmp-cmd-test test takes typically about 15s on my local machine.
On the k8s runners it takes usually 20s but sometimes about 60s,
because the k8s runners have wildly variable execution time.  If
they're running slow, we hit the default timeout.  Bump the
qmp-cmd-test timeout to 120s to avoid this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2b90abf0007..b207e386965 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -7,6 +7,7 @@ slow_qtests = {
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'npcm7xx_watchdog_timer-test': 120,
+  'qmp-cmd-test' : 120,
   'qom-test' : 900,
   'stm32l4x5_usart-test' : 600,
   'test-hmp' : 240,
-- 
2.34.1


