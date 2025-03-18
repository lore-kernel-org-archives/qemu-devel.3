Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F4CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueYO-0001RT-Ir; Tue, 18 Mar 2025 17:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXv-0001Fq-Ma
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:26 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXt-0000l7-Mg
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:23 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3014678689aso5033010a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333540; x=1742938340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXxySmM5H2uZxfcMpHXVVabc3DpRRBx3hmcc7DOhhC4=;
 b=FJWI1NbPE92AMuGYqNRP2DgHzvpQB62CBdY5a7m2zBaRvGWdF8id7PEFvrdij/rt/U
 lPsX9MBm0hzv/V31xrofp87+z7Fn2liTIYtn5QZuL88Rm1TjmC2xDuY8K5f/HvhSAXHm
 k9DmtZUAdbCKWgLtp0CbXzhUGr5ufXPfEfzi1YGI65/VFxdHBV7x7BmBpFiwTn/HcAkX
 gtZD5FWdOSQp0CRbQs5kLdojUigqFf7AjzdjaEMhnvnha622nz1lCfFNJ3cEN3A5J/aR
 /dIh3iYF36gBN25N2tPllK+BKETfygn8PB6BZRw8NDaDpv4a/0MJv+HhqZi9Em6xGmJ7
 0+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333540; x=1742938340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXxySmM5H2uZxfcMpHXVVabc3DpRRBx3hmcc7DOhhC4=;
 b=skO2RF5tsZfEei63muNtSmfbGLm7Vw7ZSRWSBou8KXL4YxpVRWO2XiqxHr+hH+IDgI
 dDztOvQzAloxB/qxMXVXBmKoQ8JUbg8iPGMwsi6CFjbPdM7YU0se8fJeh/cocIfaP421
 xAs+kXtY6SMEHB508ZjLGZIvsII8FUM3YphTHCKEgTtl1Pfsz3Swjhj6SRyXa+88q+J9
 ZVi+8204vbgiq8G5ngo/LTuZY6RCnZ45X2f0IBTLsYYOu0nvgE+UtPGYc6IGlC3NxlA9
 3AIg007mNyx08M6HylFvVXAHMVpgHAxJtplKSO7zvZomQup/RTYkwvlsBfQrW1KLedqG
 kOGg==
X-Gm-Message-State: AOJu0Yy9P0iiLD5/Za37JixMQMfkJA+xI0pKWNRGKNAjNbLRFSsABRfF
 P5nX1Af7PWqATttyX4YPGOqPbKnkpkZ4ZQAduxnUKk9ex3TVU7xdeKx4tpjX/8cpEphaB3PftWR
 F
X-Gm-Gg: ASbGncsGIJTcmezHkyjdJ4tQLePCkni/V+cr8yjYoNa2GMfesT3CHAjs264/Jjxs58g
 N+p0mZzRT0i+QTcG17QvW5RiTcop2mkqlNzicQvAPOQGxmnyon7FMoXZR5nYQbJi/94NStqVnWS
 wdxqiXeYj0pKf/rn1jk0C6I/62pzPTUXMcKsjVX+FbHRe9owcsmqNzGM00pbbWqT2o/6OMGSDrX
 /GIu9K84fFH2qcDGCCZdwMWSimOmsXhXTcDgvE5ei3WUc5jG46LD5+Xl+d7i0O587NUKjOPvP3u
 DE2tALfOEQqzs8w/YuCx/ouUMgllHN/vemPnCPE4o3U5RmFNfSL3vdIvChzMeqP5Gx9at+Vvrf4
 YIpsi/NnHKi0=
X-Google-Smtp-Source: AGHT+IG/uW6dNn7XLAGIfxugaQ5wUW3YEUK6Hu2d8GRsOfgKtWAa12WbEW/61aftGlTwCbRW2jAW4Q==
X-Received: by 2002:a17:90b:17cd:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-301be221d24mr293321a91.33.1742333540143; 
 Tue, 18 Mar 2025 14:32:20 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 14/42] accel/tcg: Remove mmap_lock/unlock from watchpoint.c
Date: Tue, 18 Mar 2025 14:31:39 -0700
Message-ID: <20250318213209.2579218-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

The mmap_lock is user-only, whereas watchpoint.c
is only compiled for system mode.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/watchpoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 65b21884ce..cfb37a49e7 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -124,17 +124,14 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
             }
             cpu->watchpoint_hit = wp;
 
-            mmap_lock();
             /* This call also restores vCPU state */
             tb_check_watchpoint(cpu, ra);
             if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                 cpu->exception_index = EXCP_DEBUG;
-                mmap_unlock();
                 cpu_loop_exit(cpu);
             } else {
                 /* Force execution of one insn next time.  */
                 cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-                mmap_unlock();
                 cpu_loop_exit_noexc(cpu);
             }
         } else {
-- 
2.43.0


