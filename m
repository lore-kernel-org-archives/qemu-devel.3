Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38156C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0L-00064T-29; Fri, 21 Aug 2026 07:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0H-00062a-D5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0F-0007Fz-Mc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso15554105e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310098; x=1787914898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8g5mM9Q649/0dlg8XApcPPU1rZYvV51fpODLqJsuqBE=;
 b=BTckQdfgd9aUQ3JAG7fQOD8PiXbi1ClbPqDjo21DOTlLADGZMvkkIG6UjM3fS60gGp
 ZkN7gP6XwKEU45OJsRg/dUA68ApAEiSfk8lqHcdvrak9RgHVpx0SEuX3NaUsNIk3PIoZ
 8yTxSgeCIocng4ps7/G5qN/dAQAh5Pn70gFjsLifg1vcQdK6tKTwjKj/a0inQdZyrA1x
 AjU5uW1p2yHYVnAOE1F6NZiSa/Is4+5qWR7GJQzRLTI9646kWWZ5+/dzjGwBt431gaif
 MH+HXnj+gxH0bCNTTetFQFNLgn99B1h65YAfmsrfxOl+c8cPUAMESCygC1RkEPKl0Vk1
 e9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310098; x=1787914898;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8g5mM9Q649/0dlg8XApcPPU1rZYvV51fpODLqJsuqBE=;
 b=jJ6CQSGsELsWMbO3KGBrITbIypRfKDul5hvBDyxsp2hPYCtD5eSYqFV30qu+ldJQ3W
 K9E6ryP2EzbTWblduwoOkgdPCRgAGYj39RtBWuETzw/nr/jXwDlONzUPCjn5waHJ7uRe
 xCb1KUZN9DRPA+s4AOmZOGdEf76x0H8Nu6F8U9J7LezG7YaV9cimwQTTQkSzHwiqYafy
 +t9XM5DYqRtCieFnyugApp7ROoJ3Ddz0/Q6LL9a72nomwQeBLYU6G3PI1nW7nqz5b98d
 KBeeHWvOWhDH3qrpKSTdYvCIRqsFJUepEwHzVPkqPN4NEWi+O93EUz9XW2x+lPMi9RTS
 O3DQ==
X-Gm-Message-State: AOJu0YxUGIWNKMQbcBXmY7eYZbzY7wOEdNc6duCohRWT1qKkg58viLGu
 wu3yjuhf9xHOBIjaSrFwGDtUS1QOyrqhQIVBqsqwQm8lRtX5c7NmFBdB7OBwbKVGtdqnCpxtwrz
 JSy5P
X-Gm-Gg: AR+sD11Pp9iaj7G3mdH6bfMJY8Yf1IXn8VVGXwtTfGsH0GkW95jyyAlrLKRmW6ZAOF4
 2UDPxJS90TCv5G+HfwoBGl3AVP2rFXs5Z9aFNTFaUGoZzqQjmsmuf63Z00c48CntxC2ZVvplCZq
 UDqnpfXFL3psg7FZeqGDc5O85i/x/Qm/sCgmjAMfVrzR0FCN0YWTGEzMG3hDwyIvN0Qt8NP5bwX
 plifNbYWsmXJSD42B4AcKO/txGBrlkTzEjmnamGLfD/0JbkK44hTDc0Kj7qK8nBVp1ISlgUbg8d
 e13EJ6y5dip5lYQDHqyCL+IH3GyLaDHmrbj1Q5kt9RanQN/aeW6amytokMs0n+DZ6RM0JV9KSfh
 dbVRGw3tl5XwQIueFUqjQSzPUZ6CgZDYFbUODgoUaLJz+9jCNuYQmz7DQoahnKrCnvdQE4GhqRb
 OLBVVUNULu+jVJ1ekxpDJmsbqlTx6deNFJf4s6EC15WgQ4UwT5ujJybYgfK10ZFS2KoD6CAJe3P
 M1vp9y7CXtGltSqQG8HcC5rlJkMSrkw5Q03WA4u/yZl9qILtaxg4yKfJOARiAIHd1DyhIKoRAP0
 BFW2Dw==
X-Received: by 2002:a05:600c:5490:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-499b913eb08mr46142275e9.1.1787310096203; 
 Fri, 21 Aug 2026 04:01:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/43] target/arm: Sink aarch64_aa32_a57_init into
 aarch64_max_tcg_initfn
Date: Fri, 21 Aug 2026 12:00:25 +0100
Message-ID: <20260821110101.3971391-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260812204435.295067-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-max.c   | 2 +-
 target/arm/tcg/cpu64.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index edb5b9e6c36..93f24114a52 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -206,8 +206,8 @@ static void cpu_max_initfn(Object *obj)
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
          */
-        aarch64_aa32_a57_init(cpu, aarch64_enabled);
         if (!aarch64_enabled) {
+            aarch64_aa32_a57_init(cpu, false);
             aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
             /*
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 24f34947eca..5649b853a7f 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,6 +1167,8 @@ void aarch64_max_tcg_initfn(Object *obj)
     uint64_t t;
     uint32_t u;
 
+    aarch64_aa32_a57_init(cpu, true);
+
     SET_IDREG(isar, CLIDR, 0x8200123);
     /* 64KB L1 dcache */
     cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
-- 
2.43.0


