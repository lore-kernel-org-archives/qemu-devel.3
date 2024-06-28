Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C801DC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN42p-0003GH-H7; Fri, 28 Jun 2024 01:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42o-0003G5-Rv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:10 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42l-0008D7-He
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:10 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-375f5c3ddb1so1121485ab.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719552065; x=1720156865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TUFa5RFEE0mlvWgiU9FcmbW/faCfrest43wgdD9lPk=;
 b=VNQHBiuON1gUNpJRthIe+yg9Qt0QjasWUew7+7eGsGOssBNzF8IDHCF/Gam3GtzlIs
 1zQWm8EEh0DKTh7MsB588YwZ56fuTAWMdYuQV4xCKXnq9ln8A6ncRZ0qQo0GxEjyxTnZ
 MyqCliQiMcnp1ODcrEVtB/GdYU0CWqKFXa8jx2OiUvsWj8G665GxlpOTLnHgavPHr5GJ
 OJnhAYhDwYYcbVsJEDataLzZm7medSjn7SfPJqZt/2JZWsHiwUUduI1iYiH4eMX+otO0
 3FbBE0rDd8VZcFUP+dUIa36AGgquqGZgNyTZuNBAcKBvWZhTEWMr1cJzm4WR6bpgDKtY
 nFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719552065; x=1720156865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TUFa5RFEE0mlvWgiU9FcmbW/faCfrest43wgdD9lPk=;
 b=HDtE8iNYIfxEt48KHTaoQRAzzeSWsH2XMmdFKSfqCI084iji5IlgXBx9esK9lcydT7
 kJiSB1ARg8G4K91adJnLhM6k8GgSmxVt4Sihv0sLfqVacBIbH1tiMOxeLxLqYNGmGoVi
 gnyhpiw09/kcVyF8hMWKLb0xVXxEHNBT8TAKEcFkATT6bvxk4gxvN6PDZgTd+i1OCxSp
 mncGlzlJZVhWrjOkccHCSk9+YDDcmAOzH7aj3nkfeYGAQIzG3SEevIXkNTZOx8GAuBVU
 SJhNwxzUT0uYoMCkyYpPP9pAISbQ34N7rJG+PZ1RR9qGzQw5DPnaMhP8Ih5pjhNvaEDi
 RZ5A==
X-Gm-Message-State: AOJu0Yx43gXeeJKBTZVw8hzEhDZ5V+l0dNO08cFfvAlda7q1j1D/OHS3
 nmuvrgqjIPjMfe6YnKU7QZyubjAUO61JHk4PXHbjWwuGLhgvuONJTr1nRUqgTavhor9mEqbmMsv
 t
X-Google-Smtp-Source: AGHT+IHHohAaRvLevTIU6/cePEw518cQy/YAEQTTIZEzqIR70ZQRu12gAwy0Nd7hiLazaipBsMfOHQ==
X-Received: by 2002:a92:c54c:0:b0:379:86a8:e42e with SMTP id
 e9e14a558f8ab-37986a8e56amr51904945ab.0.1719552065546; 
 Thu, 27 Jun 2024 22:21:05 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6b2a16cdsm423932a12.46.2024.06.27.22.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 22:21:05 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 04/11] target/arm: Fix exception case in
 allocation_tag_mem_probe
Date: Fri, 28 Jun 2024 05:08:43 +0000
Message-Id: <20240628050850.536447-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628050850.536447-1-gustavo.romero@linaro.org>
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=gustavo.romero@linaro.org; helo=mail-il1-x130.google.com
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

If page in 'ptr_access' is inaccessible and probe is 'true'
allocation_tag_mem_probe should not throw an exception, but currently it
does, so fix it.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 037ac6dd60..a50d576294 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -96,6 +96,9 @@ static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     assert(!(probe && ra));
 
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+        if (probe) {
+            return NULL;
+        }
         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
                               !(flags & PAGE_VALID), ra);
     }
-- 
2.34.1


