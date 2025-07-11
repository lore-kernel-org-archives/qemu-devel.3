Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89C5C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDup-00061d-8X; Fri, 11 Jul 2025 09:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtw-0004TT-PM
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtv-00036v-0h
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-455e6fb8057so6306635e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240893; x=1752845693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4D1P721eTGF05yoXPAl8RR3ddO38S69UMpsn5Oq3Ffc=;
 b=TAACE78ByWO7m02I6UVpGHdeEcvFbCJLtjYOjw0yuHOq7vCAasGFUzCCmdGvFGr34L
 7SA5/DeV2ThRyCQHjWy1cK8Bmdu0DV1of/OfkX2wMovYFqCiovl4NUohlMwJcrf7HpC6
 anR69RA57IG3RBzwb/ot3Oo5d/VIpG7kvjAwksQBoi5PM+N8h1bw90bcMmGswyFoGzKP
 hyQ1PoHD5gTQA5vRJeI1M5HiBXZnyovgqo0Bm+9bEdMEZf6qilfiGWtFo6ZEovDkC9O4
 zbXKwfUT9+23v4QNlRPiqW0jSJnZxJAZIwYAhdpfBnWFSpOEkAzuCw7J1Zq6Zf9YWRvc
 FJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240893; x=1752845693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4D1P721eTGF05yoXPAl8RR3ddO38S69UMpsn5Oq3Ffc=;
 b=QtkRvXsFzsdtUJwjAt4/wNfOGjdIZZqqUDvKHlkmyEdLO18SFjDXENhI6rxu6qvJIR
 Bqj/KngGawz4Rek6k5J0rBwHfamrmhxHlVwVs6zDj/rqJeqCulpb7/Kjxdsc6U7cK9Js
 ap+SGhGZTDvKdyjXdKC5ommlhEGCHv893/u1wzaSQutYlVtZej3A+zxGa+1umw7tw3fC
 UZH939RQupQkDfdT+lD52eEQP3T1HKVETwzjmWUPQxeEv9A42WwQf8IcIliod3IU1Kuv
 rpoggo42tk9DKnNnZSCy707FUn8Gje1D16Rh98NMMg8E6G5q9nRghIY2BjgSBZX4LgFY
 jLmA==
X-Gm-Message-State: AOJu0YwqIKp5MUnsdIIET0T2nqMfShIzicQh5KueAVr2qFgXdBgFFzK9
 siUE9FGcpAKOqtbJOZ+/8GtWUlgdTXFoKMuV5lTXjzIARNktnScj59zBYE2WOFKPLulkH8MbPVx
 KfyfV
X-Gm-Gg: ASbGncuEqoMyzs60uQUh0d12jx/RL/rMsDzmy/ckTyhM1tMBwyfjhVsiSqr14TO0mUO
 HsEwj0gqrpurlkuoxby7YIUTA3AV0L5NQkFQPxIh5tTL3PnNK7xxjEwo8cedS02QBgZygdeJZzH
 cqFsE3oFYyD8K6XmpsoAOoy59dQvD18MnDpSbNdWoE+6NbMZswqZZOMY8aqZqgi5YPSQsypekPm
 AGCEx23ovkaO4pt7IIf7qA73dm6TD9zEW8ciiDz2mxcB8N1jnHXk4oqvdQxI5Y0ItVi4HfYgXkT
 I4NdoU9O90T+pcNKreFLWrfGKtu+arCxwwCaRvF/q0HHq8lcdrJFp2ALSSmRkGFRNypqqzudV9H
 KmOTRarNigRB1HZ1dq1Vl7teKLVFO
X-Google-Smtp-Source: AGHT+IFoGT7AtPo6/0JtV5y3fUeCo/3/9cENyDQkJE4KusBCMXFJhtyA3D6mBCqpHHsLHpTppfOv3w==
X-Received: by 2002:a05:600c:3e0b:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-454e7b603b9mr28157485e9.7.1752240893458; 
 Fri, 11 Jul 2025 06:34:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/36] arm/kvm: shorten one overly long line
Date: Fri, 11 Jul 2025 14:34:14 +0100
Message-ID: <20250711133429.1423030-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Fixes: 804cfc7eedb7 ("arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250704141927.38963-6-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 426f8b159e8..8ab0d692d36 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -230,7 +230,8 @@ static uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
 }
 
 /* read a sysreg value and store it in the idregs */
-static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx index)
+static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
+                            ARMIDRegisterIdx index)
 {
     uint64_t *reg;
     int ret;
-- 
2.43.0


