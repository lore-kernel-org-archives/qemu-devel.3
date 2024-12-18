Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F354CE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKT-0001Iy-9f; Wed, 18 Dec 2024 08:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKQ-0001HU-Vq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:06 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKJ-0005dm-7X
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:06 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71e1b1767b3so3251443a34.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529378; x=1735134178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNGor91Xjo2TrZjyvRxbPbQsjTfqqtcCX9NnnDYkm1I=;
 b=sAUU+ZVzLAjJF5QOnlLmA1e/gzRdTAqpQQ3iNGJ8svoh5cL308gW0/BEHus8dnEbjf
 wG6waJItVtzTMUqWi5weKKZtdfBhxmf0AQ58+A4QXlgMx+oQ369n7aOd1x6Yq9Ylswa4
 TWVAPTQmzXH7kXaHwIS4M6tKCQkr6feoYi06BGdf7e/VkpXGshqvF5j+GGAYMedGYIF8
 fBiJF2Xjw0WosIsRTUTEPsSHj0vfl8ONGjt09+JC5aNexdIQE3eZGKseJBCuy9Cnrfep
 1Cln9M8k9g9UfwpANIibdhfa8uVKNNOKBZsp2kZ7byDNrqRHXujH7i27WKcbCiBCqKU/
 KtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529378; x=1735134178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNGor91Xjo2TrZjyvRxbPbQsjTfqqtcCX9NnnDYkm1I=;
 b=gs+t+FMdvXh5kIJWpa/QKwIMlyZQpS3nICfjB4exu/bHZytUWbn/TafkQbBeHf6sXu
 h29OmJugvLFXP/eoTTHmY42QZ/CD3Ac3Zv9MimebIoMDESpidc+d8jGE0u9Vf81OGbas
 rjQW0mx7XjszH/1Sn4za0plTPf6t/FFht449vYZ4MG3aPxXvt9CNhtqYJMwiqK+1NCcH
 8hwH7HzN322nGRIGQ/XCjlxy4KzdvdEXYQl7sTbScAvbVVLKlnPzoEBEBYvHnSN/ypS4
 2ozerszzwnOTM/TUT+FnGG7qFRdfiUZ1gZKRg6m9eLoCM3TJtya9RWMSCnDqUSK10U3C
 EGCg==
X-Gm-Message-State: AOJu0YyGdCio6C4l7V3F+5pMaGMyt7SNtOR0sqSjT1TSsi2ubrjFV1jL
 abW/G3A4z4c770Nsrn3Cq/PBoYEfVWIHWFEPVemFOHZ4XjsINCosDPpxsvwC8sXz0MfnMs+98bW
 T8HW3Y3RT
X-Gm-Gg: ASbGncuwpXlrhp3cF6IJdZLPN63TOjUdcqbwpO6v1Okl6OScgAQYi95TKDpGCSpkS3l
 3SwsW7EX8X7Riu5tUwa9W96F6VsVtdcTMtsGn22gqY5lTUFAATORgnAaqwi4XE0CqHaPZZlsoAl
 TXKKxZBLJrng7Zsy6x3PIwZZb1FvsXu01Iz9E1L44+VirFSvSgtgL1JogsdTrh9nqQ41WQYLHrC
 KYDsJFlwU8m7NAOU/SWi/H4BLrLhbPFfoWbsOmegiNDS9Y2lgv+TPNHacnUwIdO
X-Google-Smtp-Source: AGHT+IE0BnyQT4GcKPLlMeBBxHPrIQvgpbbGzj75GFH7ZcRy+UqmTPOfZ+NJrqre06m5sLovv6PmRA==
X-Received: by 2002:a05:6808:4441:b0:3e7:b2b4:ee7a with SMTP id
 5614622812f47-3eccc09c9b8mr2100634b6e.26.1734529377767; 
 Wed, 18 Dec 2024 05:42:57 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:42:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 03/24] target/ppc: Remove empty property list
Date: Wed, 18 Dec 2024 07:42:30 -0600
Message-ID: <20241218134251.4724-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu_init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1253dbf622..5e95790def 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7414,11 +7414,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 #endif
 }
 
-static Property ppc_cpu_properties[] = {
-    /* add default property here */
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -7468,7 +7463,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_unrealize(dc, ppc_cpu_unrealize,
                                       &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
-    device_class_set_props(dc, ppc_cpu_properties);
 
     resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
                                        &pcc->parent_phases);
-- 
2.43.0


