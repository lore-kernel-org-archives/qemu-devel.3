Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A93FCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn42-0003wZ-C6; Thu, 23 Oct 2025 00:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3l-0003n6-MX
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3j-0001Xc-Li
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-290aaff555eso3322925ad.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194177; x=1761798977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=350XNCdecgPAX+wmyPNQHhgr60+8VzYIB+50MP3LTE4=;
 b=idqylpp8bVBmulLMNesCTOQ1t1fB8kD7Gkw/Exu3dBFeFkhO9IVyN/uG0ZVt+b7OJe
 P1AQT1B98J67zTEe2UVJmgfbBXmiJXKmLYTuzfR3CyCGls4/FsYKgCQsHns+vPNxs7tY
 9BpY7+EmHe+32pFQmyAQi7AEbVkRo0tOddUM7YJhyelIF5Vq/4hpWWnx2VbqnEMMtIU4
 7CwdYdCCno/EGVSz9WzF2gU+59aQzrgS2RI/7v9GGE686DyX7VTVBOOq9I9iGocypy5p
 +ACFvARcmRtgyak2QxIx8tii4tWwdoGweSeJtqoDT+bCeefnP7/D9t4gLNmQZS6Jsg5y
 EAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194177; x=1761798977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=350XNCdecgPAX+wmyPNQHhgr60+8VzYIB+50MP3LTE4=;
 b=arJIHezOlbmvZ8kQ6NW2LQvN3S0FiOOyEuhAZ4f3SbvNLPb/p+dxyXqS3KAK9/XD7P
 WPCqbKCSk/+VoVsdEHOQssS/QWvWncvWSCqpf/9ElVakrB1Lb25koAbqZq4lezTtzmfM
 qA2/2ah/P5YTXOTR/Xyl2kHUgdN9kLqYevduTdjcT7SoiRDotm+G2g3E7e+OHqkhjNG9
 ecNPQuaa/H2ivw/mG70zXYnn4vnluE6HAi+S5pzW4XbyWa644PZO9urvH0wSVflbO0Jc
 hlIhnL4Kdq5a+UtJPYeX8R6DWaypevrbPc5kZB9DAydem3WAGqV7knxvtwmKHhhM87p3
 gWPg==
X-Gm-Message-State: AOJu0YwRorctirlQIxXv8sR28lSG5qdW+WJp/De5R0WL4zWtsaj8tklF
 TAqYb19xp+ftfcQ2MTZ6ychoiQfsdKJazf4wnMDA9/bkdDHyh9B9dp013N8cZw==
X-Gm-Gg: ASbGncsFdNV4RKFoz3yRwA25Gl3/W1opeEOm4y/QZppqZtMXIqRKuyGC9pqsnPERAmM
 ogVKiV+DNCZyJnMkgc99W3+0RkgqhVry8ALj17ZM7Lvc4O7kRX02LrsoqI6h8tEsC5BnFOkUITt
 MHI0qOtoGp5Qak3us3Zsw+xm+vXj133luz8nTnAhKvWeGsr5uZjgskOP4Rujh/s577iDhYmkEp2
 KR3sUgY5MtraygNA1bDyWEMBUjUo5ziwy827prWF3LD6DhIpzNDyx3eF8+5AlrIYhrKmKB/j2Wn
 MzIroOqFRblXBbeVYtGWtgRAxk+rVFZBNj0gyv1nqWkuoXbfasgfmGhRtFs/DAadYIiji4yyNyw
 pYFRV8AiejilkG9SntfjKvAuXO5qlmxBKCZM+r4yeDQj+0H42OgQTLcPtB1EEKpr8EU1qJvahfI
 FkCkgcOGBuwSaFRT8I/5AnfIqSamBGMm5P+SGFDI7w9VvFrSMXX/cyVC+1fpuavXh5vHWbJ+9U1
 +4ErLRACDNXfOd0Mh4=
X-Google-Smtp-Source: AGHT+IGCUjtB6fNwPWP6Xv2zSBg7q0v+eYNCCg029fn4zA/ZswedJcI7sYcMwtxmeWRkjWlt/c4/mA==
X-Received: by 2002:a17:903:230a:b0:27e:f018:d2fb with SMTP id
 d9443c01a7336-290c9cf37d3mr268423705ad.6.1761194176954; 
 Wed, 22 Oct 2025 21:36:16 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:36:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 34/37] target/riscv: fix riscv_cpu_sirq_pending() mask
Date: Thu, 23 Oct 2025 14:35:17 +1000
Message-ID: <20251023043520.1777130-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We're filtering out (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP) from S-mode
pending interrupts without apparent reason. There's no special treatment
for these ints as far as the spec goes, and this filtering is causing
read_stopi() to miss those VS interrupts [1].

We shouldn't return delegated VS interrupts in S-mode though, so change
the current mask with "~env->hideleg". Note that this is the same
handling we're doing in riscv_cpu_mirq_pending() and env->mideleg.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2820

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2820
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251022124340.493358-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/cpu_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3479a62cc7..360db133e2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -443,8 +443,7 @@ int riscv_cpu_mirq_pending(CPURISCVState *env)
 
 int riscv_cpu_sirq_pending(CPURISCVState *env)
 {
-    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg &
-                    ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
     uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
 
     return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-- 
2.51.0


