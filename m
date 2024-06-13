Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79758C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo8q-0000gK-6l; Thu, 13 Jun 2024 13:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8o-0000ex-54
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8m-0005qb-KG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f7028196f2so11155525ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299295; x=1718904095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04DwH8iRtH8HRKfvqAVHCt4qHmUcr5TXQeOZHTbNSLI=;
 b=euAZXan1f60AgVpYPUm943RNbH7ePh1MEyZOsHzuAw+Kc6VnUJ54LjZic98z+ehx6A
 CpnxGIP6VDAHa1uFmkdGGkwBGAGS3pxM32sZ+932NcV9NPUsnXLMv8E1+jnhDsiGEDua
 WP6mPDpxz99nL1yjtjqRB4PmUOn4WvrHCGh6lSN+OpB4TonOLGoICUt00q7ai1EODicO
 vcWRNr05a3DB+4BivZTUtycsVO64w6WKwOiczsrfUxbOM8+jjWRX019lvRiDq1frpjBK
 inyH/+z2O/bWZKM2TVstbXjvxB5qDbonPe8kjutmKnLhavIsGxKx5gkrTc4/pYpa+oQl
 2ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299295; x=1718904095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04DwH8iRtH8HRKfvqAVHCt4qHmUcr5TXQeOZHTbNSLI=;
 b=CbVXrrjH7AXZAUF4Dpxy+7gl93wwde5Yb27gnm5MLe64woOjPK0HYC3o+cFeCAz1Tc
 U/JtQ+tuJZUuCX69X2Nzsrn23oDCJ/xCn1b9a4H996ExIIdSr5aboFYbchgSOSdCWavB
 H/hewClE4CFB3rKb0rcKVdCzV/ucIjkoWpA4wQdI6pDeWs/9I8DN0ay/E2dR9F5QQYlB
 zQSz8V5fmAs5VjByoMK+4KOACK1ODOnJZmTj0bTZ99VAN7CVZyBuL8eohOANuZje1Esj
 tvaHu3bdrN2Qeg1Pn+s2fjV2xxYyd9jeSY2vhi1gPneWFQ7inEmaNtHaFvRmJeyNGETe
 Nr3A==
X-Gm-Message-State: AOJu0YyoO9WLJ0tyJ83tEJHcuPuN2pSGgFuiouZKMG5CIDGxYQGVnvo6
 Xc8Z51JO6L4XGhNJmNy6X/890ytbaJQ6b/KWWkUlEINZXstqp2f8MLYLMwnB7nQoXhVK18PGs/t
 S
X-Google-Smtp-Source: AGHT+IECMN8MvkQWM9azGcvhfnp5IprnFSwURbLJmL5ebvv8trCfgzkKYeEoHDebH17LtVYyjwFJ+g==
X-Received: by 2002:a17:902:e804:b0:1f7:171e:5264 with SMTP id
 d9443c01a7336-1f8625c0649mr3365135ad.4.1718299294939; 
 Thu, 13 Jun 2024 10:21:34 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5b85bsm16443885ad.32.2024.06.13.10.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:21:34 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 4/9] target/arm: Fix exception case in
 allocation_tag_mem_probe
Date: Thu, 13 Jun 2024 17:20:58 +0000
Message-Id: <20240613172103.2987519-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613172103.2987519-1-gustavo.romero@linaro.org>
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


