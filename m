Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B129C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkXA-0006GN-DQ; Wed, 06 Mar 2024 01:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWc-0005Ni-Ai
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:14 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWa-0006K1-Cl
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:09 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dd178fc492so21316255ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705586; x=1710310386;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SWv/n6ZKj2r4AuXL4UqGI23kMpuzOnRejuu9Q3uLHrw=;
 b=awIkjGG97cQD04nPmjSlI9R2DPp5Xo80X02aSklKkEsQWa8aAOh5Yj3O2TalRF5Xpo
 t2/pecNc7G/+0ksulMzFbfjZvwgO7RtTiC9YDxFaMzHUERZxIUaAMYN2q/hgj0qUoXtt
 frUk1bFBq+bwAsoi1hKqoHe8OorbvNSD00gI/OOddIr0Fg5aBB/zT8TjwgY3JcVmOJyr
 XJyyruoHlAIfagigTAXjaHgL/DYfyU/u2piAgiOkMyN06C542DiVzlU8hgdPT8LTzGX8
 4tY+ypyxzByDvtC20fiXeFjN+cJx8gqSTDwlqCK3F6U51KYzC7Z5+1Jr4F6exVqfb6Lk
 GYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705586; x=1710310386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWv/n6ZKj2r4AuXL4UqGI23kMpuzOnRejuu9Q3uLHrw=;
 b=FI6EbCy56Nk2lAQgb/Shhos5kesvhgZTokumoBrVv6c03S+jHSB/J1XwSzt8sq0WB/
 wMsEjRUO1VTFVquq+zv0ItvH3xtdDXlj97V9QpRqVSOP8mZyyqm3GO6tas8YhLwJfgEc
 FKilE8afETbMGI/SXL/8NVnORzHDQ1xOLlGUtQFrjqrQo4owmwOtugkktizAlgVLud2x
 bRICfqyHmapqJ2zhYmHTKYKntk+S+UEs95NaKzTDncGS1PwVyw67TYgWWTguzfQNWFNA
 ksBZLO9lM2eNueLSvpB9tJ4cKN5yBcC4IMpfcvVUnUnUFM0RBEqSnlO9StNKccengnMi
 SVig==
X-Gm-Message-State: AOJu0YxAh1fjRgRMvfv2l165F9BUlhtb2+c9csWGvN9jXsnG2SGVXbNC
 rHVn7cfARsFMlpTJ90eaAe8+ZyAEoIn2QzuiIiclkHgQ5ucgWH0432upgtiVEc4=
X-Google-Smtp-Source: AGHT+IH9pIVIF0ENYYG9PeRqLVnU1y/kU+LQR7lftfdwgK3RObineI/3jGNd83iaYMyO+qRGISfa9g==
X-Received: by 2002:a17:902:c1c5:b0:1d9:8f6e:86e8 with SMTP id
 c5-20020a170902c1c500b001d98f6e86e8mr4057960plc.69.1709705585988; 
 Tue, 05 Mar 2024 22:13:05 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 s9-20020a170902988900b001dc3ef786f9sm11617879plp.308.2024.03.05.22.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:13:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:23 +0900
Subject: [PATCH v3 17/19] contrib/elf2dmp: Use GPtrArray
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-17-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This removes the need to enumarate QEMUCPUState twice and saves code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index a22c057d3ec3..7d896cac5b15 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -66,7 +66,7 @@ static bool init_states(QEMU_Elf *qe)
     Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
     Elf64_Nhdr *end = (void *)((uint8_t *)start + phdr[0].p_memsz);
     Elf64_Nhdr *nhdr;
-    size_t cpu_nr = 0;
+    GPtrArray *states;
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
@@ -74,38 +74,29 @@ static bool init_states(QEMU_Elf *qe)
     }
 
     qe->has_kernel_gs_base = 1;
+    states = g_ptr_array_new();
 
     for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
         if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
             QEMUCPUState *state = nhdr_get_desc(nhdr);
 
             if (state->size < sizeof(*state)) {
-                eprintf("CPU #%zu: QEMU CPU state size %u doesn't match\n",
-                        cpu_nr, state->size);
+                eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
+                        states->len, state->size);
                 /*
                  * We assume either every QEMU CPU state has KERNEL_GS_BASE or
                  * no one has.
                  */
                 qe->has_kernel_gs_base = 0;
             }
-            cpu_nr++;
+            g_ptr_array_add(states, state);
         }
     }
 
-    printf("%zu CPU states has been found\n", cpu_nr);
+    printf("%u CPU states has been found\n", states->len);
 
-    qe->state = g_new(QEMUCPUState*, cpu_nr);
-
-    cpu_nr = 0;
-
-    for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
-        if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
-            qe->state[cpu_nr] = nhdr_get_desc(nhdr);
-            cpu_nr++;
-        }
-    }
-
-    qe->state_nr = cpu_nr;
+    qe->state_nr = states->len;
+    qe->state = (void *)g_ptr_array_free(states, FALSE);
 
     return true;
 }

-- 
2.44.0


