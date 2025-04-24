Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AB6C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmj-0005Cb-Ux; Wed, 23 Apr 2025 20:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmf-00059E-GS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmd-0004JB-NV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso358761b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455782; x=1746060582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG5GR1LgS5q2ZsGX0HNw3y+WcVPJJCWNVDcD2UvIEdE=;
 b=kFcCHicqp+EIxKgTkwIgdBJ/16mmxjlXn3vFYmdpEq72n0YDYFmvN7k0HfCivsIBK8
 1J1jddVkJilQ8PmOgDldHOq8yxcLNloJfAtyyF80fLw0yLt48qkOnyzsWVA887plSA7F
 HntbsXiJv7Fcd0iTmfwH8xg3bi9OeoXPDIAAA44cbHa04hUF6vSO66DP7dHC3V++h0ZB
 eYpAomXMdscqM47dB9uLUVjPtRzw1ZHyZXNGUGwdPo4GwOqg7Zm4juNdVFrgoG5J/nh2
 cZCzZbjHZrFDiD9NjJgG5c0ZZu1quKdiMlC3uZKccM5OXj7eKkGV4aKZRu0Gsj9bWvX7
 U6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455782; x=1746060582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG5GR1LgS5q2ZsGX0HNw3y+WcVPJJCWNVDcD2UvIEdE=;
 b=HP4SxvmRoPrp3WLgDzfPLdJ0sx1eaTfuh14MDgM0RimhuO/f0hWABSEZRi7akgokpu
 IbJyEch34ccVxT1p9Xwr4USZW5sXRXZi1uSAO6YxnZbFZSMQMuQBlee9Nhr7axXYcA1p
 JVAYO6tt47jwhQdk9idgkNF7fDjNkpYZUKscCzsM/mq6EKqXapZ6kuiIzZd9+5rqBVsB
 8r0IzvjZleMeHKv0ZM7U/40GrZGRX6bFQUymaDS4UTWFzY74bhF7yv5Ebemh/7Jlm/tD
 anpBR6pZjN5enf7DmQ8MSt6MRvdh3YMvnXv3at8yif8Hl8RS77SchHBa0Z0LmDAq0ZoX
 L8Ng==
X-Gm-Message-State: AOJu0Yw+DsR3GwHcyZ2+lJoebaTzr8M7UOI5tCNjH1X4w29SYySgDGAe
 nOm8EPVE+npgRc5ZSWL/3XSqeuYBbcIXUoASmHJE67C+QMF7rL3bN+IJw40Q+YoIKOYNjQo+WL8
 o
X-Gm-Gg: ASbGnctCHEdzj/ochVno4i3xXYOAmmqWcMgP03Kz4Vt3WU0Y2bvJPJthxGRRSeGUMCc
 M1rU6jo04o0NjXCak30i65yaDX/DMhOYq8EWOqgwtZ1fauRsgv/ncHFlnZkaliE0klqatvwkUuF
 Fc2UHQYghh3xlZUJi1/MByTmqRGSTdz8b/30oEJna9t/1FDoxoGYay3nQSx2pl4QvK0Ug207JJh
 AIOn5XI5b/dvAoCjPsSWF00pDoexynQbPcIOFcDejcPANoQjKThHq3GF/V5ICFcDrgHFRC3NgNt
 o1+uT9kdSAzYIBCyN06UrkO5hc87zfXLDO1T+Hs7NuhSv3gI7Z4O79UTbzuNSIxjVu9/33nbnx0
 =
X-Google-Smtp-Source: AGHT+IGWFpHQGDViRSLddcs/Ypk4doGwQIru/oB50uM9dW4lwm9026L6YvbYIx1KXY/j8ktyx4h7iQ==
X-Received: by 2002:aa7:8a04:0:b0:736:aea8:c9b7 with SMTP id
 d2e1a72fcca58-73e267b8980mr580394b3a.2.1745455782140; 
 Wed, 23 Apr 2025 17:49:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 010/148] system/kvm: make kvm_flush_coalesced_mmio_buffer()
 accessible for common code
Date: Wed, 23 Apr 2025 17:47:15 -0700
Message-ID: <20250424004934.598783-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


