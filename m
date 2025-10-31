Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4725CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxE-0004x3-O8; Fri, 31 Oct 2025 14:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxA-0004wa-1D
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwc-0006Hr-9f
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47728f914a4so13286615e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935623; x=1762540423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xQqGIx0Iit/mmyUQN1sJFTz/pNHetWhqs6jkhC/S2Ro=;
 b=x9Rt9WRAfl0Zf04joUJr0EYvMo49+qVqCTv2enmjDAFX0W0oPYrTuYYTynHAtJ4gcn
 6P2Wn77aIjkE6rrnY4yzI1IrbibBd509suW/RKQXmq+E/hbGQWxhRoSkJvh0b7i9mboV
 KbyH/BpqIGr6lpsClj53gBQl7boeApsWUHZDvaBNpwZtWrph195sIikluhIS8yuLGKkK
 wgxDC/DHvRuuUw2FkLMrCEqcLHoDfJswiCcYtu800Vvd+T1JyjEWVhqGe8Vr7UmOWYgr
 ix5d//fo/GhBkFFzNsn1eCuwCPh0+ExlIDMcfQ+nk4nsuT9bp0u5UMjTqgoWEVfK6y+7
 pUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935623; x=1762540423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQqGIx0Iit/mmyUQN1sJFTz/pNHetWhqs6jkhC/S2Ro=;
 b=nEDXAxohalt+xTfzMNmt9/s4LgEbmImfoFiLD2ZghMEAKsd2TGh7om/u1MIZSzsFrn
 +x1i3eDQMn3wmsB4a9LbPap1vfkh+c5tzKYyollGeDMTp/vX2WzFH45iSIvm7J6qreXe
 DjAOkBF62rlXknjMPlyI+PpBBHgqnqgYRU+JOxImlRkDuz0otrVihZIpC0uJVhFvxRp9
 BWa0d49ikOLk8nHrz5vPEfy7d/9VLQngYtG0pu1qhfDYLBVHw7FS3goLOWBsSyBiEX0s
 IysULYmvKI14rS8wXiWPpXM5dF8inHBwUqEwIC6N/bPY9tzPX4NCRHHV9PIosbHI1xmD
 qduQ==
X-Gm-Message-State: AOJu0Yxw0QGIpCQsi3zEtTQmV52emVCcnM/LDEuadfUVcx5m0yYnjdOU
 jvSrmegAeFiqVVOirYTHdpRGJ7MkquTS/pdAKrpZWRKMl0aiSLE4ar8BwCcSMoUXiwF15BPxD23
 i6528
X-Gm-Gg: ASbGncuOsf3LxqG7E3zm7kaLRCggmDevFI69vOsR+XSh6jhyeLC2xdiMScaAKncQzdn
 X+ZLpyQ0Ce0EUE7BrEHCIMiEcxvn9HzqfVV9opzkGXuZ6NlYkLHndLUb8g4tm9kRfhTuL5TXdx+
 KoxgXcvCTXNqp36AyPCzzeiIOXLyL6W+BeH5GKE2JggMvRT1jkPHkQlvGHwKD7ILeBRkY+LkAlk
 t7KIZPJXOwAKB31fKbjxHljXSEQ6AEYVeuvNkkWwNJ8m8GeVz/otYaMtxAW5dMv17ZIbFNl7csD
 4/ihO5C7eMFr5ZzTcAX/0/ghbRZj2lPPUFAIVPa4mAAjmvFa3dUtBA+8mFtS1Zed0WSm4nfAMA3
 hVaKH9JaalQqOR+S+4DR9CNfaQkgMtSYox8CvybGhf3osuC8v8K3q8/AlnZ2Jowx8PIuugDjQw0
 hQrnOBUg==
X-Google-Smtp-Source: AGHT+IE9SZwnCh8+2bYWudVPAjBKthV+Xv2N8ujgyPrebr6s3Je0hlniMNvWVrjw9kI29b/S09IOGQ==
X-Received: by 2002:a05:6000:1846:b0:426:d5a0:bac8 with SMTP id
 ffacd0b85a97d-429bd6e3cc2mr4666706f8f.56.1761935623230; 
 Fri, 31 Oct 2025 11:33:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/38] accel/hvf: Restrict ARM specific fields of AccelCPUState
Date: Fri, 31 Oct 2025 18:33:04 +0000
Message-ID: <20251031183310.3778349-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Do not expose ARM specific fields to X86 implementation,
allowing to use the proper 'hv_vcpu_exit_t' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf_int.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 195d64dcf18..3d2be4092ef 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -59,10 +59,12 @@ extern HVFState *hvf_state;
 
 struct AccelCPUState {
     hvf_vcpuid fd;
-    void *exit;
+#ifdef __aarch64__
+    hv_vcpu_exit_t *exit;
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
+#endif
 };
 
 void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
-- 
2.43.0


