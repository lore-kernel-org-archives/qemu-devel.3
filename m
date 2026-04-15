Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D78F433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD9oS-0003AI-E7; Wed, 15 Apr 2026 19:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9oL-00039O-Ot
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:22 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9oJ-0003cB-SH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:21 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c796163fac5so513501a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776296298; x=1776901098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09bnGsDbKTHVT0HRhPjc1Z5jPce1HDUtrYwYOy1p71Y=;
 b=ECCLwCxJDWstUgX1v6/EsqsKZkd0aJ2L4VygSFcDigzIXdBF9By8uPy/3RLAS5tUH0
 xnbXVkUJnXf2x2ykw4PHweKbmRgSE2WWO9A4RtprcXDhPsr6+ozho0ZNJqSGdjGH7Jf1
 KBZ66c3IFckGq2Jj9vQhuqd2whkcXj9Zn0+nCJWLokqNbqwKAtaxYxJYt5TkKrXq3g1z
 yQu4gCGaVumwMlMsEwbcLDRhzKCmvBouNa7yGYcJ5FjJTWwCzMn/V7mgFFeouqql5G6n
 jSxW9+eDTS8EtYJ2fc6sw8GnDRZkqwmUvOMEBjqHVhSwE2l0H9hCtLYtIJHh49jEuHA3
 kiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776296298; x=1776901098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=09bnGsDbKTHVT0HRhPjc1Z5jPce1HDUtrYwYOy1p71Y=;
 b=ii3K2/zE018uF5I4raI3X8xoDWJIseHKMpWQ7+t8ads3nYceZdqmRRdTeN0nkGOuZY
 HZClD+jIdGGzoBXZHg/YJYjsXHJn2A6ONWjgq0iKOnaYUpdEui+yUP6CAccd8Nxtp2Uy
 4OdDlXiOAM2Z+54EylrOi908MxTWF3FMkG4HC3HvRhwlUBeHBy656YHghAZjTttfxEgC
 /GbHkSdLEjzlttL57ipMfeJiM9LYMtRJmMw4u9ykzvtZbBJRFVi1bkmR7ijugU/g9JEG
 Zz3NVV6/W+zE765i4w34jOEdg0eWN3CRjYjUAKIn9K+tNWl2GH4Rfmg7I74UmD0uX1Qj
 nKKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CZQypyR70FuNiTpBWl9o4G66BpuThDpChDkuKvXNUJlszM/Jd0hCAwpJXv038yuJb9moMkvcptit2@nongnu.org
X-Gm-Message-State: AOJu0Yzf5JkEFQywDZgLImgcoQXP1k/qJRxX9VRQshTtI3YMa4FBZ3Tw
 PbW17NyZfY6GNzSG3d/AcgasVJTbWAqq8sz2bYfyRdkQvdp0Q01ictM3
X-Gm-Gg: AeBDiesXOnIFIC/qfTBZKBDSVNjCSc6G07of5haXaAn6IYONBXRHPyK4mu/2scVYDb0
 o4f7JapcpytIJA9+twMlqxi9GjN5HcM7e9CBh2EbssZlUsAbHWDz2PxrZHCzQVpT8h8+jkMsPv3
 Yq5YCie/yEzAPKMRKHkBKGjD1nV3UsJcZjuDqBSd03osElf329snU1y4ZmCnn3bfSqOHPe1uM4Y
 WoU7mbhR6gw6Geh3CizDJcsgep+3MZZ4nn4odGWuWn3autHgQ8JFZGwfiZ9JmgKVArPaU0s8YkE
 LxPCW5Sm0GqR3dOXYUl2nkzh8YLrgsYGrx/RdtJ0jD/l2W+yJwL4wdIiF9j66aSoNlQ4EmRdy2M
 z4pZaTwGoxJ55777Bw4JaJWcFnNJm/zQ2EU9Whhlf6Yai1reqELznMPKur0BqDPOU+AGpCJ7794
 CxdUchw4Pa1RqBdY36MC8zaE99o7LZdIAWp20ZLwtma5x4Xnoh+O8=
X-Received: by 2002:a17:902:b193:b0:2ae:c529:a13f with SMTP id
 d9443c01a7336-2b2d5978f2bmr191714575ad.14.1776296297694; 
 Wed, 15 Apr 2026 16:38:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47826ea53sm32341675ad.52.2026.04.15.16.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:38:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 3/4] target/riscv: Don't OR mip.SEIP when mvien is one
Date: Thu, 16 Apr 2026 09:37:39 +1000
Message-ID: <20260415233740.3027321-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415233740.3027321-1-alistair.francis@wdc.com>
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states that

"""
But when bit 9 of mvien is one, bit SEIP in mip is read-only and does
not include the value of bit 9 of mvip. Rather, the value of mip.SEIP
is simply the supervisor external interrupt signal from the hart’s
external interrupt controller (APLIC or IMSIC).
"""

As such let's mark the mip.SEIP in rmw_mip64().

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2828
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Move the changes to rmw_mip64() instead

 target/riscv/csr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a75281539b..29dd596ae4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3671,6 +3671,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     uint64_t old_mip, mask = wr_mask & delegable_ints;
     uint32_t gin;
 
+    /*
+     * When mvien[9]=1, mip.SEIP is read-only and reflects only
+     * the external interrupt signal from the interrupt controller.
+     */
+    if (env->mvien & MIP_SEIP) {
+        mask &= ~MIP_SEIP;
+    }
+
     if (mask & MIP_SEIP) {
         env->software_seip = new_val & MIP_SEIP;
         new_val |= env->external_seip * MIP_SEIP;
-- 
2.53.0


