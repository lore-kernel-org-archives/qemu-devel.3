Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D312C83030
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYszf-0001Yp-Br; Mon, 07 Jul 2025 17:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLH-0005M5-GD
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:36 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLF-0004K7-5B
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:34 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7d3e7503333so584744785a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919692; x=1752524492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gH9VNXBEfhinmOk/OsQiqn+Gb4kuwgshVCSdhCST/W4=;
 b=Fx3Pb1xUpX9oPAWqNvu54qHYpi7lpcWr+5pc1ApWZo2ToTIZOXSfIQjCnFBlVKADrP
 wuP01NdCcBQUf+3OkD8ItpVpYbnOWeLzDKDrNfyzpLJ6p9wvErsMfW7jPhU5hNfp69Hn
 cknznoa+03Beh5MtiePLsX2EpgiMzAF2eejbB0DoB7VRGPIz4suPQIBpIz78RIIXvXZv
 f9oGAUCuWiwQ3uwqrVF0BLZ4o8pp/UYDYWypZkh6hnNfGyW0KCmzDzWoTCFsavSxy0DC
 w8tHZVoZXQcgs9gHc8/VpRtv9/57JEHRvwJAAAczhL+jfPbSCptzrlXy+DwSNqm1upE+
 UoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919692; x=1752524492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gH9VNXBEfhinmOk/OsQiqn+Gb4kuwgshVCSdhCST/W4=;
 b=C5kAdViyut6joceqXqSe1A++3ysSg7RSGXA535SRyKgfmkb5bYrOQ3LL+1C+JxBQmp
 wfsTTAkWEmVF1Zki4DOT9z4YKRnHh2ga8dVoqa9cQm6o0henww5DG/tMtr3A2F2gbY9p
 DMnD3pmJko5KCxg7UO/HhZFHUdsb7gyo396UFGxjO6dLAPOxeut5DHIXvlrDpqwt0PPf
 45nWDwyrWI+7OSNZMuZWHUND5RfdKbmTpe/MH9AGQ0dr5teANXxoo8vIxuot/QG8StKv
 8eK46FIhWn4zaGS3N3QBHh40lMw73YW3pgd9EJv1/UqaHgcq9b0+g4whXhPYW4MZAND2
 nt+w==
X-Gm-Message-State: AOJu0Yw1FOLYbTo8KkMhGkUE1IZQmSDuNWkeVWbdbelTC7HZQIpgJiMq
 bijgYXMwghOWduxXTvJ9jiOuANGGgBYl0wClyQdtMkh6iQD6YEWgDmQUwaq2TEiFY0xEJEzvYbh
 hx4ux6HQ=
X-Gm-Gg: ASbGnctO9BqCl6nmNUe/cnheQn6mWimu6BgdfN+ynHWc9xyt+3FG6Tye5WdBNMTh9R3
 BBd3cU1xCaWndVnWeCowNM+UKzuwGXBKLO0/C8ZV21wCUQW3OjPpMIzl9PlRDSEFFwVAzEvhH0A
 AharG5hvTfCxAZdq0IaSKtjO4zLjYbiXf6Nl1anQQpeMQFMVxpLdNvPV9soi3pRo3od3fyunsPB
 OXFiII0gd4KNUaeFblb6p8EVIAXAlMbuQorm4eCENGB7p1pzaiGMdMhXw6mERtF6gxZnj6xpeU8
 w24VC1tiTZ0K9qiBj8hdT+X88jR+t5o5grdDeJeJBIIziPf3CwpayfAMZXXAicH0xMBZlO4dSs6
 Qwd+6IkcNvh6LpJhU
X-Google-Smtp-Source: AGHT+IFoGNOMe+FGzZ96WtNG6bkBWpVIS25sSsCd1ApP6Jo/ojTVFmHInB7LU2k9yFcIcx9nj1/jQw==
X-Received: by 2002:a05:620a:2b89:b0:7d4:4b92:85e4 with SMTP id
 af79cd13be357-7d5dcc5e457mr1833576085a.14.1751919691816; 
 Mon, 07 Jul 2025 13:21:31 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/20] target/arm: Convert get_phys_addr_pmsav8 to access_perm
Date: Mon,  7 Jul 2025 14:21:00 -0600
Message-ID: <20250707202111.293787-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
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
 target/arm/ptw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 709dfa2684..f1edbbee5b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2881,7 +2881,7 @@ void v8m_security_lookup(CPUARMState *env, uint32_t address,
 static bool get_phys_addr_pmsav8(CPUARMState *env,
                                  S1Translate *ptw,
                                  uint32_t address,
-                                 MMUAccessType access_type,
+                                 unsigned access_perm,
                                  GetPhysAddrResult *result,
                                  ARMMMUFaultInfo *fi)
 {
@@ -2891,9 +2891,9 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
     bool ret;
 
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-        v8m_security_lookup(env, address, 1 << access_type, mmu_idx,
+        v8m_security_lookup(env, address, access_perm, mmu_idx,
                             secure, &sattrs);
-        if (access_type == MMU_INST_FETCH) {
+        if (access_perm & PAGE_EXEC) {
             /*
              * Instruction fetches always use the MMU bank and the
              * transaction attribute determined by the fetch address,
@@ -2952,7 +2952,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, 1 << access_type, mmu_idx, secure,
+    ret = pmsav8_mpu_lookup(env, address, access_perm, mmu_idx, secure,
                             result, fi, NULL);
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
@@ -3477,7 +3477,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
-            ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
+            ret = get_phys_addr_pmsav8(env, ptw, address, 1 << access_type,
                                        result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
-- 
2.43.0


