Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95977C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIU-0002Vf-NO; Tue, 22 Apr 2025 15:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIH-0002Op-1C
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:33 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIC-0006AQ-R4
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:30 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so4278187a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350107; x=1745954907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG5GR1LgS5q2ZsGX0HNw3y+WcVPJJCWNVDcD2UvIEdE=;
 b=aYEoco6e8pLd3bvf0NnqHfzYWOuROZVQVKNV6hQKfMMvt38WcRopUzvE+x0NJSlbaX
 ciwChYo0BukrKxiE7Lj/dn+KYwptXmeGt3oXkkxLi0xrlUqhvGka+aG8JmWtfDVoKf8G
 CHngq2ZlXE9vxN4AEQlQksbrTxAYLt+jA+QttZG8ZLkI+XPBVCDa3fPr12pbnaeE9cA/
 fTGhOV7rURCj3ca+XEMashcuUep4EcoDA6K02ZD52sOR2U1PKbjbQEmeHiI/PCPz3jdJ
 HULE+bJSmtRD0xD1TOE2ocy/tApMgOlBsotKElUxTuAmBAmMku0etWQtYUnwlaMInDzn
 xMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350107; x=1745954907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG5GR1LgS5q2ZsGX0HNw3y+WcVPJJCWNVDcD2UvIEdE=;
 b=OB2n7A+RXllc/Nm6jyw+tYha27ML1Pgjl+S7i5O0CMQD1H0DvQ079H95OqkoVGdpt5
 CAg8Gp+N5i8/TPFpzd+hXWqnP8/3KfJowzEl4EPavXAQUhfCiYthwnsM9tetzF51qYAa
 9HCHVRb84WMHtWBrtTXuvtooTPOV3n31rPiwUvCvaVBTgbwOMG6TGjU2iGAsou5cQLQS
 FCAfaob/nBZ2nmDYhDnsr23B1zpA/NbFWrMLg5AiVm5lE4SNfo8WMWh9pCpFAsuMl2ET
 EEjHMUrsL1thhlSNZReBkEx8N1mGZmlSL8dsQmryubLLJ+w5CPMG2QwyIx3+IVlYUS/w
 ThIQ==
X-Gm-Message-State: AOJu0YzW+oqSxwhzJXEmDmy6os6GS9rSelBw8NsxcRvsTLTBcGQvwBcV
 2Mx1o9x/ZkZFw41PsxW1fYmKdzG0NONjDewP2QWmrKaeBnyPUjarjZ/e3A+Wsis0OI53JEz4ZXY
 L
X-Gm-Gg: ASbGncuQLEjFBY1Xsx/pfxEIH3ap0mfn08JMLjjq0yJQcPizWPiVOy5W+zCKA87uDhA
 DjYo9h+jDNGL5RONoaGeaRUHAFRbcIzDjdLLQgRyZBt5cbww9hb/CvYDZPr4R9S6TeQ4fwdoyfK
 uL8rtEtGYtH/XsyKIrVv0J2IoTu6hvtiQxYifgTv0ZwF9uPUu5VANCYYmq6REWmBMrwTUX7Gvpt
 HJrvrufjIPy+AEnkTVJHIjoiXfmgL5LbaA63SeOQdsdJz1CBrmLm5L1C1ReW1U6juWp6MsMkWlC
 osGq2JPwzTObogpSAQn5hBVvqVrpS0eHk7vgV3KYXzv9GkL2jVsIrcXoppvpF5nL4Jj7AJyovQE
 =
X-Google-Smtp-Source: AGHT+IEUJKbf7X+M9bzS4q1774LQzNqrQVFSwKH5sgQSrhuSuW9S3bffIHTGeyXigdsVZuouEfff0w==
X-Received: by 2002:a17:90b:2807:b0:2ee:ee5e:42fb with SMTP id
 98e67ed59e1d1-3087bb4d0bbmr26115450a91.13.1745350107271; 
 Tue, 22 Apr 2025 12:28:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 010/147] system/kvm: make kvm_flush_coalesced_mmio_buffer()
 accessible for common code
Date: Tue, 22 Apr 2025 12:25:59 -0700
Message-ID: <20250422192819.302784-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This function is used by system/physmem.c will be turn into common code
in next commit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-11-pierrick.bouvier@linaro.org>
---
 include/system/kvm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a55..21da3b8b05 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -210,11 +210,11 @@ bool kvm_arm_supports_user_irq(void);
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
 
+void kvm_flush_coalesced_mmio_buffer(void);
+
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
 
-void kvm_flush_coalesced_mmio_buffer(void);
-
 /**
  * kvm_update_guest_debug(): ensure KVM debug structures updated
  * @cs: the CPUState for this cpu
-- 
2.43.0


