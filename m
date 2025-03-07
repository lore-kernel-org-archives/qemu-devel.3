Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723E6C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsh-0007YE-Hb; Fri, 07 Mar 2025 13:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsV-0007TE-5S
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:59 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsS-0007nh-LT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:58 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso3416133a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373815; x=1741978615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJaPAtjiKCI7xNvYK1z8ajXotpby2ndW32q1olZ40bI=;
 b=LKy+LO5A3dcrlEDDg490qYWC9j6l36pYZnsEeb3NvVRWJGQhZYoFvKjGQoUkf1Pv4B
 Vye28e3iMyN8wYTXIfF7jV8vMBevEX0fmEpeb4ALQJV24t8cf60WiEzuD1Zcb5cTJcvj
 /+m6v5WPuQfLJqFzs72ZU6BrbjK4vX30oy55S4URrMqVMNR+NbajRHRSkX18U96/+yl+
 pJy7gLY2n82v1udFKpxfxD0ft11iTJakw16MbsM55yVzP9gVXts/cJjFfaNEEeCz7/fk
 P2GtsAZT6xSr4vq8g36i0FdN1IItr/WZPqhB2KaLEcYGXXXMbAckDb5V+4fRCK/mxkNc
 Ogxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373815; x=1741978615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJaPAtjiKCI7xNvYK1z8ajXotpby2ndW32q1olZ40bI=;
 b=sV3AoEIj+kZcwevgXWy33XNg5OVzTom2X4M8IpPwTtkr4a9vBgvM6/R7iRGk2Y2Z1B
 gs4Jsazk+X08irUs2Ae7bghCKi3gDvqa/eP8iYxDnEKcq2IyQxHFpxwNDj0PLqQPXhIJ
 LjXGV4aTo2YEawqYYyIeciQOtBVmnQoReUE5q9C0wrtqd2zAzvbvqUNhcBCSt57FjLUM
 mTnUV5bcjX301bpXtnE4OZ7DyhA1ro0VbkOwa9NqJDYHYOlbH/7saxH9v2iiIcLUarlF
 x5xN/E/UpDoc24RzAtyihbkmWTEw0zOobPiwzLWdvZ7wEadWh1DBlIpXfA85NfghdLRV
 hToQ==
X-Gm-Message-State: AOJu0YxAxnZH1D7VnPNQXOH2hQ3t9NQmCvGHYtMu9J0V7a2Nu/i+0N7e
 w6i1def56oQS3xNc/xBuKL+h0LfRk6FSDmmg4aaaEULhRt76CaKYThMWo13W4b2rLwpeAhEcW39
 a
X-Gm-Gg: ASbGncuGgkNAiaMrhoC+xiX/itXXCGL1ex25qRwrnHZdjIwpyxPgPMQL3XqQ4b7aVLk
 aKCQn171cKMQtt41LQFRJina0si5nxlzMUdEtS3WerT7CdAh77CFKuTt1ei7++c8mcOTY58W4oh
 aqGfpNMEV/0yCaXbEel2aTNSHKb/JH6P4HYXzt13+D99khBPkOjfYOMPJ+jP7RC8nbL1oV7KjBN
 MbJDbBzjOCIN22pU+uOc3wmnJ4cmMW5jNOuJm+DoI+FoEhQQCy0a9djylT03dc45MhsV75qiU3+
 LVfRun3KIh4hIbhUfxErJRNuUPeOLiKDQ/JiokNWXkub+831UXuJNa6A76azcvFAKZP7P/pSpM5
 Q
X-Google-Smtp-Source: AGHT+IFc5IBAh3DDbrzfFjHNPAm2YzILwpM4eAQf1qnNkHqFWHnSMAD0qMOwagFPsEQYU8LIpduYgQ==
X-Received: by 2002:a17:90b:4c8a:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2ff7ce4f28amr6637684a91.5.1741373815192; 
 Fri, 07 Mar 2025 10:56:55 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 10/16] accel/tcg: Build tcg-accel-ops.c once
Date: Fri,  7 Mar 2025 10:56:39 -0800
Message-ID: <20250307185645.970034-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Now that tcg-accel-ops.c uses cputlb.h instead of exec-all.h,
it can be built once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 979ce90eb0..70ada21f42 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-  'tcg-accel-ops.c',
   'tcg-accel-ops-mttcg.c',
   'tcg-accel-ops-icount.c',
   'tcg-accel-ops-rr.c',
@@ -29,5 +28,6 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
+  'tcg-accel-ops.c',
   'watchpoint.c',
 ))
-- 
2.43.0


