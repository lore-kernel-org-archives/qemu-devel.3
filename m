Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A92C0218E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyN-00056S-Cs; Sun, 26 Jan 2025 02:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyI-000554-ON
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:19 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyG-0004JW-W9
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:18 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2a3bf796cccso1624434fac.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876136; x=1738480936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBsjI7aW2nO70G4tu6wAlrovv3tWfVJtXnpKYO3Mao8=;
 b=XyV8UybOFOH0oObZ1EoeRGq24x6h6vgKa9tITlamU+3Oz5u/1g3zwo53mBIi3HnWS1
 lzwJaSFQQS9PD3yoT9TdHqNCS3uJ2nt0FF5VLATKtM8QyuF2CmsVBWTp6NRooeZkmg92
 HqwQcRe048vocgmMm7sAuQDWTV3O9gbILTuZnzJSBZ886a5vYqlY/XzoCCE7yqh8iZvK
 GBDChEdItNe0uCu0BvZJpT+tTu8BOhnUpN4Am9Jd4jh/h+fd2op0T0T1FNBtySK3RE6/
 bVl26yNokdaaaRCep3x+UrZN2XYKadazimhBQ6ZbOPbA0HHAelmJBeDL11+AbnOKoyYl
 UCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876136; x=1738480936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBsjI7aW2nO70G4tu6wAlrovv3tWfVJtXnpKYO3Mao8=;
 b=gNuK8GHfLcoAD3enMmO1/3zAo4GwGol7Lnoju/fLySpZuQ/M5UiEEumJuCvesc8Ufv
 3v9AS/zPVGTqSpN76xVMUXjnrSLhgsL70X5mgi/JDe7Rwz2Nu4xU3dQO8FG+0p7ikm3a
 Aa+FHLNAdax182sfOIt4F20vahcVd6ijQ2h5IjPWRQTN5+hSgp20Q12rGZ6+yt9/pswx
 D1Oeekcbj1MoydmoUGv8gsDsN6Ou5tmVFnvGZxGViM/K//9WmZc3wift/mWJ3apk+rgO
 4+ctVD7so8MbJuXtwATaZ3QCPwV/yuNksKL1uSHsSTIt5Dvdo+56AJt3UMZtvP9Pox9a
 LSHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWQLoUmGAAC1vR3MQWcOp3jrvWb3Nl4BZBUPwLJUintYS7P9VzRmZccU76N/RUpoGHFqFGOK442spA@nongnu.org
X-Gm-Message-State: AOJu0Yzr27ek/TF8E21QlaHXfRDbJDMCH1F1NuAtmL2SMjHmnbCTXaib
 O2D0zGdrBpRMU3OyryNw2a5DRgZUsyUYXzf0yJnLurJ5cbkTiE4cnONWG9nehvs=
X-Gm-Gg: ASbGncvPWcVEOhHQvmxqDmamS5LBrf0dHNNerD1okzy+B+ujo7LdrmeML0m81Gt/Ebz
 M+uQo3td39XyfQkhh7g97g4IHq4xLq8jyLkTenHxgI4ra75FGfHwByAo/G1dEFiJgbLe8QIqn5l
 TOlJFX4/P/dCM1WeMiYHp9QXmmoYMrUgRRjPV7xdKYzuQepEq3PEM10R/oEb5DaPa2swREomd2y
 V/qRKa0f4x51pwX6sxktccGGluxNUzyoL7C79wD1FZsoGfeG7Tax2XHc1z32blBln2V7LRGv75s
 C3A0xPpCJ1hLfPY5rT7czZMMuiH0Dd3STpnvrns=
X-Google-Smtp-Source: AGHT+IE6AL+BXFmwwop/qvocFxEigrnoelWWwX6AGvRIAbYALQhffyVk0yo9IQS+WHpiyxdUmwsK2Q==
X-Received: by 2002:a05:6871:538e:b0:29e:5894:9de7 with SMTP id
 586e51a60fabf-2b1c0cd8350mr20684770fac.33.1737876135890; 
 Sat, 25 Jan 2025 23:22:15 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:15 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 07/12] target/riscv: handle vwadd.vx form mask and source
 overlap
Date: Sun, 26 Jan 2025 07:20:51 +0000
Message-Id: <20250126072056.4004912-8-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=antonb@tenstorrent.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 0952bcbe2c..bc22b42801 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -458,13 +458,14 @@ static bool vext_check_mss(DisasContext *s, int vd, int vs1, int vs2)
  *      instruction cannot overlap the source mask register (v0).
  *      (Section 5.3)
  */
-static bool vext_wide_check_common(DisasContext *s, int vd, int vm)
+static bool vext_wide_check_common(DisasContext *s, int vd, int vs, int vm)
 {
     return (s->lmul <= 2) &&
            (s->sew < MO_64) &&
            ((s->sew + 1) <= (s->cfg_ptr->elen >> 4)) &&
            require_align(vd, s->lmul + 1) &&
-           require_vm(vm, vd);
+           require_vm(vm, vd) &&
+           require_vm(vm, vs);
 }
 
 /*
@@ -498,14 +499,14 @@ static bool vext_narrow_check_common(DisasContext *s, int vd, int vs2,
 
 static bool vext_check_ds(DisasContext *s, int vd, int vs, int vm)
 {
-    return vext_wide_check_common(s, vd, vm) &&
+    return vext_wide_check_common(s, vd, vs, vm) &&
            require_align(vs, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs, s->lmul);
 }
 
 static bool vext_check_dd(DisasContext *s, int vd, int vs, int vm)
 {
-    return vext_wide_check_common(s, vd, vm) &&
+    return vext_wide_check_common(s, vd, vs, vm) &&
            require_align(vs, s->lmul + 1);
 }
 
-- 
2.34.1


