Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EA8C3600C
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXRA-00087f-I3; Sat, 29 Mar 2025 10:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXR3-000846-DV
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:22 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXR1-0004SI-Mv
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:21 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso4918857a91.3
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259518; x=1743864318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJYDev/cZ7hbKldzMhzdvTYiCgJzdwhs4Kyy76l5wE0=;
 b=ODa12ZPj96Xei0+eLDkY/jCLcArqKNmTHLV8WUPK66PBJauNfe5vfzCtF7IQ/AofMy
 PoP5OGEVDzPtgUcUV6osoFILgx0iJjU7pxQXsOaZSwhkvM2JjzA71wrVLpXw667tEw5j
 /nWhyDe4zv/W6rtgWiMgitr1yMX3KafDhlsSTTeP980/XIIJaYiIlWhBHtv8v3uzP4ze
 Z81KreW7Y0v6//gP80iou7yg7W18l5D9LxyeKPMcGZnGvvJos73DZuYH6yvZOc8MaOiR
 t1T4rbmvgko3ZJoiYU8x2VnLJeCagOnPk5d1k6xIzfkivlg58z2tb50VGKWINR8CjkA2
 eMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259518; x=1743864318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJYDev/cZ7hbKldzMhzdvTYiCgJzdwhs4Kyy76l5wE0=;
 b=YCOZNWiTMLYBDcQBgUqHcWms9RVpb6DhmhtiPAwWBHBJ2eplhFwniEK5SJ5LI1kiiD
 IrUK+aXoBMHRAqFHXeX8z+PjpiZqUayTqIuZOyBbntMeG4u02Pj+qT0THae+ewHoHvQR
 4umKM84A05Ymp4yADmD47EX1mults77AQpbF/W4M7+u+XAQ2qjIn/RERY0Ky+Oj+cv6T
 xi/3T+JCJmZNqwATKwlQ3SWuLZaPz1P1Yx9TpJW53gSd/U4IN4t7MEIFjBHC1vbo+147
 wjFfCQoiZph+xg8Jb9X09U1PUR6RHHHPTMS5Fn/ZxvVS7/38t0w7aCZ8Hpb3cZJ5fDL9
 N5wg==
X-Gm-Message-State: AOJu0YwCoC0Ky0PYfduwKZpDjg+4QHPhuD3EOQ/NCm0g0oY8UboXS7KA
 J35gkXeqcbxeai9y6fT2xa2WZwfUTFOIcoewfn2idZjMEpA4IkNLcEI2dxCtmQ1bso/TPt0BOAB
 XMVtENF7/EfFu5urRo3WOzk57gwtHCaUuvF8eC2EiVmcjm5hZZDGiUGj/KN/WJSyA2/d8KyFg+r
 wKE20TiaRqOKMCJmOez8XrsPJPgE1RgKPBx6x21Q==
X-Gm-Gg: ASbGncsAs3sGjar4SjQ50hMmS35WyqilMu2aRts9qrkSHOOC+L/fKEc1sT2YMQuDprM
 zGoiE81TwhkCwOtp4X7XoyrO8Ii7erJYq5fufyGj2KfhjvqmHLPHNRi/CfRFC0Ba3ggl/Mxq8Pm
 a4ZeTNFtB3vC95IAkLQjdZ/BPL2WxFRP+nr/JEzNuPu2qr80j6qDAJW55LFrgOgfxvBljKuuE9B
 efAeZMyC9i97/8Ot6TBmpxr96krnyaW9pIMXTcaYlxLGW1Y634NzqrR1EIEQC1UGwf186OUE1ZD
 VAUbOGnNxOHxFhpMifJ+SxYzupYiFEL5u/VfqtsihohsyhxE8mPO2sTShB3BzbcBM5aahC/jECT
 3mrwjc2bRhApznQ==
X-Google-Smtp-Source: AGHT+IGijYcF1tFClTlA4fzA9XD+7M0sYy7HpdV/xJSug/U7OzJEG67obK2mRRJdrFrdseXZBFuotQ==
X-Received: by 2002:a17:90b:534b:b0:2fe:afa7:eaf8 with SMTP id
 98e67ed59e1d1-30531fa4f38mr4604712a91.13.1743259517942; 
 Sat, 29 Mar 2025 07:45:17 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:45:17 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 08/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector integer extension instructions(OPMVV)
Date: Sat, 29 Mar 2025 22:44:42 +0800
Message-ID: <20250329144446.2619306-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Co-authored-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index f397ae46446..728912fc1f2 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3660,7 +3660,9 @@ static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
         require_align(a->rd, s->lmul) &&
         require_align(a->rs2, s->lmul - div) &&
         require_vm(a->vm, a->rd) &&
-        require_noover(a->rd, s->lmul, a->rs2, s->lmul - div);
+        require_noover(a->rd, s->lmul, a->rs2, s->lmul - div) &&
+        vext_check_input_eew(s, -1, 0, a->rs2, s->sew, a->vm);
+
     return ret;
 }
 
-- 
2.43.0


