Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E385C5DF89
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkr-0005CC-HZ; Wed, 19 Aug 2026 23:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtko-0004mg-H6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:46 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkm-0004DC-SX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2524328a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197663; x=1787802463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1iq/zZquDTsNMfYQjuptbKKoh31S0HQU5QbrfhrMH/8=;
 b=XH77IMQ1abHzH5OaHOemc3DnzwV57RCMJ2rc2OwdJ7zzgpAem6N8fHez61rDEAaXR1
 4g6lSu29INjK0eoVsGr2IMsKqpr/hNpNkZdjP+qviA2uaHY0827+OR8/rQeRpv6wVCX3
 /dDOrO3qSLNISnQhJ3U4EFuUlHO3ORIVORzcF//WbQbjIcmPEwweYN0qECYC5G8uoPjL
 3s0jnKkMcuFWS1pv7D/Cuke0kNZosAIixrYLYESYQU2lsafmqN3krpfaXXC0Loq5X2aE
 pVs1XDIXbvxgaWGBZCxjxIVNnEwKg8KnCI8lNjTZzCgMEvL9OQgLOMWnz9bPY7sQuHyi
 itXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197663; x=1787802463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1iq/zZquDTsNMfYQjuptbKKoh31S0HQU5QbrfhrMH/8=;
 b=a6bwKb7w5F6Xp/Fyk2D6djkgeeu76gLggyjFZ7u+lE7IMJOCisoHD9X8Mz+tcqnIVM
 fi7irI3QZK0B7GYSBS/aP50b4N/fa0XzTxgv9r75BMj6N8ASwud25Gk20RP5lJTxQZfD
 2GthrcCmvxY/IEJ/3bft1ll3jxEl0Bt1H+Hd3vmh/bD/0aD1MgySradXMNe+Wp5X2ZCL
 /oDhea36Mp54EXb4kadt7DvAOIy134GHaJrrN7WH7zjrWfvrNWL6ydTwzccIuXE8uVdQ
 +cwqbFBDPSaAy3M+nz+wQMbT/14D1uklpJ1D/9TZac6CY+1SocSSegM/2cVgNjNko07i
 lX6g==
X-Gm-Message-State: AFuF++kbHl97hPLmJqVqv0pxazDeK5Bz9/hdgDtid2SA3J38vWYmaNvw
 FuNrmqDqB0+smc0aeY4pJ+MR7o6U2/BeKR7uE4XXax7n4oKZfGZviq6tfd0yQg==
X-Gm-Gg: AR+sD104V6z79pA+k2wdZxz+IXbQB5vOjfvmW2hCqCEP84XN0mJub5VIVcxCM2qHGJZ
 NKNo5fPkytKTMACZ16eftqMnXPzqAuPFeU1z/n+WeCMTxwB/gaO6HwFx5CVXt831kWxIUl8W4BS
 snzFX0mpIh+uurKrELc2ziAbvEm2H89+Q0fItcQaJroekwdueQfcdmTgNRqBbmw9FWhKQktE+nz
 YwgnYkbR0RasOhXWioDEIC8v73bG08M2D0iB8Z0lZUb92X38hpmx5+d9jQYf92MHQRIgIZEyvDr
 VCV3LaOCGR6jFy1K2My+lgDXHFM3IRu7Xi4KHGBRAErXl5oaFmjnLApCWUbktQmwMd5jX0GOhpq
 A39AVxh4fOHnGn1vRjSC0A2zrngADtZ9FhRo347XX+6rkAOJ203MmoMTeH7J1HTwtkuEkipacMY
 +OGwK2f8XY/fT3trGbyZgRFlfReNmg9uXFaZYDq+fFvPRVcsO4Fp2k8QjP9TSf7Ug=
X-Received: by 2002:a17:90b:2f8b:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-395810d73e6mr18346293a91.15.1787197663247; 
 Wed, 19 Aug 2026 20:47:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 62/93] disas/riscv: Allow decode_inst_lift_pseudo to loop
Date: Thu, 20 Aug 2026 13:43:59 +1000
Message-ID: <20260820034430.1186695-63-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Allow pseudo expansion to proceed in multiple steps.
Assert that we don't have simple loops.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-27-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index fe503b6cae..b8e5b124a5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5259,9 +5259,9 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
     if (comp_data) {
         while (comp_data->constraints) {
             if (check_constraints(dec, comp_data->constraints)) {
-                dec->op = comp_data->op;
-                op = &dec->opcode_data[dec->op];
-                break;
+                const rv_opcode_data *new_op = &dec->opcode_data[comp_data->op];
+                assert(new_op != op);
+                return decode_inst_lift_pseudo(dec, new_op);
             }
             comp_data++;
         }
-- 
2.54.0


