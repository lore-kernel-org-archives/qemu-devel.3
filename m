Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4693CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yQc-0001WL-4D; Wed, 01 Oct 2025 11:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQX-0001QY-I6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPT-0000hX-KM
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso6125268f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331168; x=1759935968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9kbDI6gt6dPazB+RCzdsNUL1mFGQ3AIw1PjA8Z/NCU=;
 b=fT0WXwIltjUw1UfAaiCfOfEc6RtWK4HmJNrbxxbTPhOIeq6yKrhdA18zvh7UUGeOXt
 wtbf8pOCXhDMME4fILwtV6CGyTCe82xtgA3CE+v40Q3gKBYq5PMgqq0w3L36L0Z+y7DL
 BzC6BVg1QuwuCm0SGD3JbRD4JSc0e/irFuVZoVizJ2X3LVjGX+ss+E+xVGQ0ngycUhiO
 A/Ct3ZBCIfyTA/Q5ZVC2Bp4g1GT+ax/3JxXF2ZbBDG7ruh4HGOUi/ezzNYjwWjInaTcw
 ZgIMX479Dr02Z/E++/SZAAcREWseZEVrbKg9OMIGLsc6prsYm0JcFXAdwsPgFUWPrbgn
 N4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331168; x=1759935968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9kbDI6gt6dPazB+RCzdsNUL1mFGQ3AIw1PjA8Z/NCU=;
 b=uHMXzCyhf9dSNaSlW0gsxSKcB/cTz+qdcmg+Y3hnR0uJTwxPCkWF731uvDeuEx5h5M
 6O8s6pk6Z+FYvwVGJwrihW61kJFK1k8LcbyXKhq2jpkl59TFyzP9RFacg5q6I5nTuq70
 bRpq1hZwFP0dR9ljqtX7y9TOC/YIuwdjOB3H+ZQlVkD5jy+UmhZS7g4TcC9HSsF1qBgC
 eY0QZoA24fwQclritiMzxWw9n6LvCEjRey92ZKrrwlY60zIWDcSl3ADsofeK2ndwjduF
 hKqH217GLmHROd4id5oirfxSfZcHJ7jrraV9NZliO49K/kxpkEmD+CHunwEBmZotCQDi
 j22g==
X-Gm-Message-State: AOJu0YwmzjCs448VWz1MkvoJT0fsE0Mshy5H9skT8bwISjq9nasf5dje
 w1kJ1jx3SrTcLocju1+IxVQ/NPKR3jQBDWVuQT2lqzijvz+TbUrQ4O7UP7hD4avYuwZTaT8GJ23
 xVt9wtv6vwQ==
X-Gm-Gg: ASbGncto4zTwzy/DqlWwn8ijeWfsv/zuZ/ROFzgNpFtOpk53E8AJtqN/xSiR9MaNk9H
 OexQnrwcNo/6DWdxD3Xbl0GwCxMWgmCohBRT9T/O4dfBuImg+u5YI5b6gC8IvqdeS8e8f2pRVCm
 cN4qSe1qN+LG8dq9f9BhLbEqymPRBV2gy6GLkJbNatcZFkeddVHZn+EnBo6qEXVFiQUqixeBsI4
 2B8ZEN7TGHjbt2fczF01yILU07smmBPed8wRXZpcYNnk7FCJ/wRuSqB8kg35Pt21FWRJftVak8C
 WGyL5cQIWk2EA/rGDQb2CujffGfiQ+GeJQKTgnVKCSyNAeosETDoO3Da0mJA37cz+55OAj4d39N
 Wrpk+fEmDuZgFk1Wv475HSQeorJ9fYHG94UD/yuYQ0LBdpzXVUUV7Xd6hdPmMku03rgG6GkxpJ8
 dRC0sCrcjsZigkUQkCjgrZ
X-Google-Smtp-Source: AGHT+IFG7MuDuZJFDFbAIRDXd/Qu078WvgZ2+fJk49zovMAfy5ixIcVr4nN1V3C3tTz01soo0R8NEQ==
X-Received: by 2002:a05:6000:1889:b0:3f7:b7ac:f3aa with SMTP id
 ffacd0b85a97d-4255780b83bmr2820427f8f.29.1759331167788; 
 Wed, 01 Oct 2025 08:06:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2ff6sm27282833f8f.56.2025.10.01.08.06.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:06:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 07/22] target/xtensa: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:12 +0200
Message-ID: <20251001150529.14122-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/mmu_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 71330fc84b9..9c868ec3cde 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -889,9 +889,10 @@ static bool get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte)
     }
 
     if (ret == 0) {
+        AddressSpace *as = cpu_get_address_space(cs, 0);
         MemTxResult result;
 
-        *pte = address_space_ldl(cs->as, paddr, MEMTXATTRS_UNSPECIFIED,
+        *pte = address_space_ldl(as, paddr, MEMTXATTRS_UNSPECIFIED,
                                  &result);
         if (result != MEMTX_OK) {
             qemu_log_mask(CPU_LOG_MMU,
-- 
2.51.0


