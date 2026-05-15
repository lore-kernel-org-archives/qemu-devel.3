Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E87CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7P-0000iZ-Dz; Fri, 15 May 2026 06:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7C-0000c2-5v
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7A-0001E9-0i
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso78789395e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842194; x=1779446994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ftWIhf0gBPz7p9Ru8niB7vMFl8ECdq16DZmRUgYJWoc=;
 b=r6MyF3YKit/duIojXuqnr0hzjS9RSM4yf4zetBg0TGjjzNAmL89tfSPPzaKTEAMiKs
 zz9Pa+YQuDLdanHpmCsjgbpiPgT/zEAFUH9aVplY4kPbE0IR9xtKN18c9OAt0XRzkMO6
 VU7lOcN1mMQu3K/1oI2kfHiXdZSP6bHdLEdZKNfRYAJooCMB8rSeTUhPctx5nEY7ZXPV
 0JpXxCKAjCY6ZSRZi811YAxI5vO73dgB8BLuW9SIdx8Jz1RgwXvfWJnqtsQ9/tpeM0FT
 3MHv52KLXZPqrczATV5r1mXtXoANg0Sr5Z2wh1EIGUP4ZIRycJvEwbGbbJDgE5rZp7W9
 kWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842194; x=1779446994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ftWIhf0gBPz7p9Ru8niB7vMFl8ECdq16DZmRUgYJWoc=;
 b=rG7xpK3aLWdzSB5NojERw+DRGJLc83RZ4e3OTmWLjWEE+dxpqAq3cJlYdrcLuWkgoU
 NhwJu//YhN0SGotbDUpEQPCKgvMb9pi0/dvNg+jj2JrVx9jOymy2Pwxaevg78I2nuZLA
 uNRqZptNUv+CeW7HiumXQ3iI/V6WKH9Hjbmqdal4PlJkSohmsSqLtuspqyWVhEUt8rOW
 cTQewL6U6Q+7+bzEfrXVcquSkiA2wKSUWw2wSRd2L7Z6WHGYwLkfepsat+uahz/6bmko
 W4pdnEkPM0R+o0JwmCivZ+Gck1oCGQFqbEqTwbBDq1iq2SDeiHWs3fmI+e8OCsfHDG9v
 p6tQ==
X-Gm-Message-State: AOJu0Yw9ybkcXZsNHGC5Yggd6soPydoOCWWv+8AfUO7WmdG0zv01PauX
 BkWazEr9Id9NBCTEGYwJoqYegrPeZqmbfp7E+phnF4v0HQk8vMjTpsRundMnqMVfjgws6dO8XpT
 Du9as
X-Gm-Gg: Acq92OEMB3LkRI86RriFaznQ66knkm++iD7nv7CxyiGhiuW8T2dhbO3dN9bjNtrj6hK
 DvqzyALgZoqQTTMRBGRXWZgOQZ1BqibyKG1x0h4RdKLvy9OrJ58L0A9C6aWRiJB+/VjkonPAqIa
 YJ+SEGQLqYh6ZMY42HZcSr7ss9nTcs2pGJjuztq2p/YMxo2vK7nlLQLbziv5GRYcC3JP0CZNW1Z
 ZfBMAggZlmIUytGEvOC46IKCQmartNFrQSR/zxR+gbnk6sjzPAOalIP6B9ROQRmhpJoaw97C77t
 +mOGUYCG11CUc/tY22icSzp9vrlmsfRTBjQh664DHLLtbYT5DZnw/3dUh5P8rPOMS4mLu0fpDCb
 FXg+qycH3xiyMkyKq50D8q9aGUGlzjs0p4xs/mF/Gc1ZqmGHN0GrJtAOoEO+Em2kNUvECCOd3cW
 0D42Q6YPFq9tuMC0iEkLXycejfikQHIYDmGZiULrWar2KBgWQ0WqWaznyI9ndoTHxbjAcpcCslG
 tOItIeF44hNtLIHjnXYZ0TF0WEHOQGV99ofGIst4A==
X-Received: by 2002:a05:600c:4f8a:b0:489:ad:7b5b with SMTP id
 5b1f17b1804b1-48fe62f8c6bmr48019035e9.24.1778842194398; 
 Fri, 15 May 2026 03:49:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/23] target/arm/hvf: Stop pre-allocating cpreg_vmstate arrays
Date: Fri, 15 May 2026 11:49:28 +0100
Message-ID: <20260515104945.4145203-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Scott J. Goldman" <scottjgo@gmail.com>

Commit ab2ddc7b66 ("target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC
for cpreg arrays") moved cpreg_vmstate_indexes / cpreg_vmstate_values
to be allocated by VMSTATE_VARRAY_INT32_ALLOC and added an assertion
in cpu_pre_load() that they are NULL on entry. The same commit dropped
the redundant g_renew()/array_len assignments from the kvm, whpx and
helper.c cpu init paths, but the hvf cpu init path still pre-allocates
them.

The result is that loading a snapshot or migration stream into an HVF
guest immediately aborts:

    ERROR:target/arm/machine.c:1043:cpu_pre_load:
        assertion failed: (!cpu->cpreg_vmstate_indexes)

Drop the leftover cpreg_vmstate_indexes / cpreg_vmstate_values
allocations and the cpreg_vmstate_array_len assignment from
hvf_arch_init_vcpu(), matching what was already done for the other
arm accelerators.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5a1718f7f9..9312607001 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1412,12 +1412,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                                      sregs_match_len);
     arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
                                     sregs_match_len);
-    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
-                                             arm_cpu->cpreg_vmstate_indexes,
-                                             sregs_match_len);
-    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
-                                            arm_cpu->cpreg_vmstate_values,
-                                            sregs_match_len);
 
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
@@ -1462,7 +1456,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
         }
     }
     arm_cpu->cpreg_array_len = sregs_cnt;
-    arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
     /* cpreg tuples must be in strictly ascending order */
     qsort(arm_cpu->cpreg_indexes, sregs_cnt, sizeof(uint64_t), compare_u64);
-- 
2.43.0


