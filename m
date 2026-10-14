Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EF9CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpr8-0006e3-Ku; Tue, 13 Oct 2026 23:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpr4-0006Sz-C7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:38 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpr2-0001es-Mc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so421240a91.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949235; x=1792554035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MnyxyYdrawolcL24xefBsccybANcOjP36kAp2ZG7XzY=;
 b=oUT772deZYMrtnvCPnnnhKCFXkoNvUYfRTs8sdiWjBMwTk60ZPLL49vgRUwDm035CF
 G1WytebYVHBLgB47LI93ebt9KySjdKDTIgN/xmz0ull5nG09qiwQy0WY5YgAYs1I+2oj
 dfrGh3f/fr/95UNniIQ2/EM9OA9NAHeyZ7LG31Zu8p41NYabhOVrm/WtWq/gSsFdC08O
 vDadov0/xzKABZOVUs7ubF57Fp1cxJQMAy+Z6JdBq14rT3QWdgU/lbkp7JH8MpbmVYNT
 97tyPsRuJJKiRz0Ov1SucXyPQX9aYLO5M1LSu2xM2cwSneMFwzDvAriV90H7TmOFbbHp
 n+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949235; x=1792554035;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MnyxyYdrawolcL24xefBsccybANcOjP36kAp2ZG7XzY=;
 b=Fi3jNFkGXKKs775CIH0hGAWaK7Ezz2hPl0dnlcViPHOFYS480Ri3wFjoXYw5Y5CqAl
 MeHeF/hSw98Ht0/M3b0oWak347bIx3xNkenM5LCJLds2b9D1GdxnPHKmj0cMU6P6eorH
 tsjpv7+45nrx7o5H4nT6GtRjjyG6tcxMr4noopo6MRBu4xTnDDoXp/ArxDXHN/3+rXzX
 jh3e1GSkSTH7Cdt9mrZ4oXxISzO4EtIHS+I24i1x6QyKFDEnuOqpl6L3pWuE3tubN4Eo
 lxp2DiJSNpclg/8rjes76YFsH/wJEhLb+UHnFUknaLyy0HD1HRlis3E40jsLx/uFc0fu
 ITkQ==
X-Gm-Message-State: AFq9FYJ04bMiFjOeh/VKB9L6cOGvMjoEyVF+TfixyoHAlj6tuGZhVNbV
 PXUHqlu6bFUgeeffKfgvqxRQQGY3lMEy2lLSq3+vjymKrbhwQGSgDnJeQVql8w==
X-Gm-Gg: AYBFou1sScejYQEdftKb879ruT7EfVCtqBtpewOd0/UmAYzr5a3yvcFuK/F1x78/tM3
 DEuivkdeiJxS/IoFUqPNCD00bQVSii0E8hs8dV45mJ2SWU/ZMPItLN3t58tlVl+7RFlKPY8MTA0
 EA1s3Zs+Uhnpgg+QUjfWHgQql3ism7Kx3HYv46sfMnturb1qJLDCYhH6QXjKywZs4RgBn+O8htu
 rgPRCUhHlOPs6qWwtSj5CoWb92D5RBRYPua8ODL4GyW3vFNqy1bfQQq8AtgU4TOrBeKRuHvn4sk
 fCfzODgOm1Vr1HQxT+QUMLVXYvYaJRZbQ1mESdRJKBe/nwTfC4UjmnCYaGwPJ9WZnDVE5ThpC0P
 rMcUnyglculaQgPee8EN/IMr0CBZaySc+qjc2gHSDA+HOBXHvqJPBnFtmZ56anoOPbpGPQr5jge
 ghYuu69yeK54857PvKRr5Vxzg5MizHKsRdLL9rLPTAAK2qdoRfP9sMutdjFpEf/vFk/fTS834Pc
 nnCh1xx73rWVWy3
X-Received: by 2002:a17:90b:1c08:b0:3a4:f75d:d1a3 with SMTP id
 98e67ed59e1d1-3ab3ab29dcbmr12904096a91.32.1791949235356; 
 Tue, 13 Oct 2026 20:40:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/52] target/riscv: Have riscv_cpu_set_mode() call
 riscv_cpu_interrupt()
Date: Wed, 14 Oct 2026 13:38:39 +1000
Message-ID: <20261014033907.3332383-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

riscv_cpu_set_mode() only want the interrupt re-poll: the mip update
with a zero mask is a no-op. Call riscv_cpu_interrupt() directly.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-5-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index e78acf37dc..6b44be4df8 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -886,7 +886,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
              *
              * To solve this, we check and inject interrupt after setting V=1.
              */
-            riscv_cpu_update_mip(env, 0, 0);
+            riscv_cpu_interrupt(env);
         }
     }
 }
-- 
2.55.0


