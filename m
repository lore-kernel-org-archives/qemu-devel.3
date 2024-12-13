Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194EEE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2E-0002sQ-C1; Fri, 13 Dec 2024 14:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1j-0002VM-CM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:40 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1Y-0006VT-7M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:38 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e3005916aso392464a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116905; x=1734721705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/N1O6+KdnI0Nthc0qwwbnzGBocJ9psam8as1orMligo=;
 b=B9QiR2oY+6rhxt+qKsFf3jl2U12fVDRpZgF7pcTigE6cgqMxWLJ3oFUdG5zn94x9/E
 H2sE2CtBUtm9hqizY1eHIj7ldieVCSZbyW1U418/1UN4rsfzf4+uWVfI0VwgBYi4Qqcn
 O/RtYIqu2t7v1AhtTdxvfAR2zGjukGVef6hTooGgPqCyDDkN27FQRGLmopTALp3RYXzJ
 Qkgk3npQecOADXqpTmaam8Cz1KfDdgFkWMPUn9I3HmZe2FFRXJraxc+DIBQRYRfHRvJS
 1ELTHWo9KDifIEd8yAx933hkAyxTmalD359Nj0uluFOnGyGE61xYJUM7Rp7q4LPiYFAi
 pWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116905; x=1734721705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/N1O6+KdnI0Nthc0qwwbnzGBocJ9psam8as1orMligo=;
 b=Tv8yP5aApUMO1kyk6FVnKqPHM33nw6b6oRrVLn3F0XMKnavXOn3TwrNee0Hp3aO6Xd
 8CAcpVl6OUEkA+Zd40c6nN3A9PxHmnr9xOQmqcU4LxBO0oEHHQPJHFeDuIsLCGilROwe
 HlmxIAitqzsy6RZAoS7LYLEcuTVy3cFYODKpRDEx/65qmsTlboNkXvUtERaNZ5Wut2Ua
 /DSKoj9bWvGZiVKfoMBcYrqCN41qwMT2mPVmzZy97XGQzbpkC2el/VsF/ZzueBeK7XMW
 mHDdbm7FDCKcZibCZ5NGV4nZj33aO9IgM/oxaxfZaKSF2jsd3vE8ZVO2i3swZv2I7iyC
 641w==
X-Gm-Message-State: AOJu0YyoqSQLmcTPawThf/fQK3sAOwOAt+koly7LvRwZnIm19RZI1v75
 wjj+y2oud3bK9c3zXzmDJ+w6gPf+9eIsYvQ8dIzsai5SkcZpZa2YalHj2AhFlOCP4pEpC7/wdFi
 eCxi9O4wl
X-Gm-Gg: ASbGncuicPUqgEq5cTBHC0dQq8oMoj5Vs1IBAzEYmboMc+vWNrL1kSR1iKCanzCV07h
 f+/t5S1krQo/GwmrSTvajftj5HxjMwrWZSiV2SjytH1+VAiZL28+ZOPvBWAF0SSSeomaHxgMt8A
 ZV5j54GG/IPv0UfzIXVlO4awS4nxrNWKgaV7aSEU4UGcJdSEP+fY74QzXhmtabEKk2bLnLiL0oH
 pBOEabqNWhVKQi/qu2IIlXabcsjFq5no0jwEgmuz7ISwVbb4es6okVY9gjl3gJK
X-Google-Smtp-Source: AGHT+IHE8OiA5O21jl1bl6r3rLUoq5bZS1aL1TbJmx+Mx8kSDE8A/boiyGC5l9ThClarUHh8ociCDA==
X-Received: by 2002:a05:6830:6c12:b0:71e:5a:f4e6 with SMTP id
 46e09a7af769-71e3ba24b35mr1944612a34.20.1734116904828; 
 Fri, 13 Dec 2024 11:08:24 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH 07/71] target/ppc: Remove empty property list
Date: Fri, 13 Dec 2024 13:06:41 -0600
Message-ID: <20241213190750.2513964-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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


