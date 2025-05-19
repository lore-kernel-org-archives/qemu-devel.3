Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D24C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3Q-0000e7-Tz; Mon, 19 May 2025 00:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrne-0005zY-Tx; Mon, 19 May 2025 00:08:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrna-0004Cx-U0; Mon, 19 May 2025 00:08:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23211e62204so7031835ad.3; 
 Sun, 18 May 2025 21:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627699; x=1748232499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLPiB5ILQC9X2kfSHGwP1n3Lx8m7kar42qvDirhs2+g=;
 b=E1i6ojNCxEnh03+mqMe9Wi3L1K0zv2sroRgqfpsiHCGL515JaQip+bq4ejay4fvGFX
 J+PKjAUBFBcqXxWTKSRjHFbk0F3XNAPneihcorED1oS3QGgKYGw9AFqAmGEHddlRFw5x
 DmTjFalAVsQYvZy+BOSZZuuSQRkKd++qLJF2oBnDiijUJgZcAc/4UZ7Gw1bUeHMB0wnp
 DI3X/0TUUQT3e5DvqpTLtfpFSKwsQwfP9XCRN/iZrKPQIgOQqdb17/DZ8Q43OtRPm7mX
 cNlCnKyc6ksHmBl7buMLsS+q/VmTqAj8OVII3yiZ9f7P1QG+GlW88NuIvjfcsAm41GZp
 snOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627699; x=1748232499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLPiB5ILQC9X2kfSHGwP1n3Lx8m7kar42qvDirhs2+g=;
 b=q59joA+HWHIFuWz4OC/UMUVPkGCt6n307Lv0cGXBgxKWIDoTTTPAkT7beb8gT7uxaW
 Rtp/y7atxPePKolTVejAmMRBlm2yEizzWR9UyiNhc+lZSttEEsBIz9vNXkCFX6u/yUs0
 4Qodj6BpcQXLMwNyqw8+rYKuHHHqTSg0UfvP36TxckPq18B9tO5zziFRbXgMj9nitI59
 t9hMzLnX6Op56trmI95emwbbNH05XTCTzP3AvPX0tn3loYp8Gk8TuSIQZ5ZQelJEMXu+
 pmAlEA0BAtLlSjX/EP3O8uvM9c7hWkw279A+1Br38OfjKgECeH4iDVRxYbgQU6FIt86C
 T6LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOBUGJJUBik4u1Ol1Iunl52BLWgwdB9HZsvKMlx/Nhx2UgVlqMfWQ21C/1BM9LX4Ta56/B3tHNDk97Bg==@nongnu.org
X-Gm-Message-State: AOJu0YzC24UoHHM26PPA18vvu/mu54pxoD6lg/8L9jcCPq31mALhW4yv
 Y998oetrsXSqZZoim/AeK6BckTGsXWaOZK7lIm3RglL8GwNIlZng84LEba7NIQ==
X-Gm-Gg: ASbGncuhxkrYc91EGqq7v2OJGMsuxc7ycHb+92za1vIzQr9fY3Z4nX3hb9+oaU96Fer
 aQHrAFHW4Arpes7K9kpvaziR7sEew47Jk6lWMVjpv4AMRPfijFsfoZNOs/KXGuOfzzlbW2EYNur
 mN8rillJt/gEXZxS81pc3Gd4settXX3mHR8MTMQQ41hg+I+aJ4LyEue1QNqELocAdQRtYIYSOlH
 a6Bi4aT+jiOGwovfJCCZAlBYQlnxNYeqY6vXvmGcP382pu4Kjn+FkZcTqSIkCiLoPWCuSG0Lt0H
 APELDa1N6n9RSZ5v+AS3WWLxA5a0vxpMTu4xBJyjsyIN2epQVHXuSbXEZfVo14D99zpgJ6XPt+I
 8ozof4dMaKpuP/N+lgu42dKzQCaQmUGtNzN0mwty4pLXiELnbebptsHk4
X-Google-Smtp-Source: AGHT+IHn9zmjIky5JO1i5m5EePREOZ+PT4Osu99qTFxixBtUkDfJ3h5hPydJCJVmUi93zUkHeDIlbA==
X-Received: by 2002:a17:902:cecf:b0:22d:e57a:279b with SMTP id
 d9443c01a7336-231d4519b0bmr197802165ad.24.1747627699486; 
 Sun, 18 May 2025 21:08:19 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 23/56] target/riscv: rvv: Apply vext_check_input_eew to
 OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
Date: Mon, 19 May 2025 14:05:20 +1000
Message-ID: <20250519040555.3797167-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Max Chou <max.chou@sifive.com>

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-5-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 04367e1bec..b1e1db04a0 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -412,7 +412,8 @@ static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
 {
     return require_vm(vm, vd) &&
            require_align(vd, s->lmul) &&
-           require_align(vs, s->lmul);
+           require_align(vs, s->lmul) &&
+           vext_check_input_eew(s, vs, s->sew, -1, s->sew, vm);
 }
 
 /*
-- 
2.49.0


