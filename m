Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9161FE7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2cA-0007Bh-Ia; Wed, 18 Dec 2024 17:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2a3-0003ts-M0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2a2-0003Lt-0u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:47 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216401de828so1626935ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561104; x=1735165904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2jazWrbuU7Wql6HgnR4OcxPEdzrMN59Mrc21VP922M=;
 b=XGVDuWs0YjxZUJrcXm9O5zSjGuKexPEQKlfaqBvr5cpBVYwHTaaDd5iKKLcfVXyZ+0
 SnS0LMOGm4ZCZNgdLMdg/4RI86eNZnZl49wnMcdNcS64H3BKEnOAITCFegjBX3rGFumK
 zCcdFyjwlMqNpdwI/s66nVYT8286ls2hoo7vmPxsL2gmRBhm5hTxvLG3COPZy6P3NnnM
 W4mGI8yiDf7+6GkZolF5rE4H+bNwK/5siKmQ9YEkqOfjPGK9sF7boK+jWunWWdGQwNnp
 GtxWB7V5mPf8CUSKw8BCPL1Qh/ACwJ0+vK7ITYKWDto61Hn5hPfjftFAN+kGLpVC/oit
 0FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561104; x=1735165904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2jazWrbuU7Wql6HgnR4OcxPEdzrMN59Mrc21VP922M=;
 b=BoN/v7TXllJNxMmAOVtQXISqEWOAailYXTxewuip83kOpKP4is4KEF+8RKp4FTKxqK
 RMugmtDGhekSjwprpINCNJzEViXfwXchgtSAQ0I524I5y+CcKBZnl7i3AcZBr6i+C3q5
 d/FHR4ki+7kpvBYcFtkIvr0R3SCreEfIyxX9hFyyzuROujqqd/0Tmta4ePccBTvyqaif
 JgyrnUTVtDlpXyPk7cpmFiZesQuv4rOih73oqaYCwwqPZgKIxSSoztWKBS79b200/2u4
 BamUuiXjJ1XcdTydixqAKmIGywDSH3pu53VYlxTEVwRmfQ1gTN99CA9M4PEq0C6jNPva
 +7rQ==
X-Gm-Message-State: AOJu0YwpazNV10nJwmuCBUKFn+DNqYmWaO8ADb2FYwpTyhsVolNid+on
 RxQoHfsMHoyzWraW//bwySCqw8gbHhTsExj84GfgY/McLYXuCfigZ8M+oEJe
X-Gm-Gg: ASbGncsQC/vmNUo/bKQvhqWKwDyO3YG/LCKH0s2thfmw+hVL75pXTHXhjZruT5+X+5T
 y9MBdhqVEVYy93KkAcx3pMhig5ddoDymd2gsVtIyIEK0JnB1AUeBYOTCCeKtaY3YidxhlWQl+yW
 15vt07A9iOj94ThILlXD/rUxOb9+1pTwL5vJ93f1vjV5cjbnVRWA9b+15tkUeT7XsEJueqXyAgW
 jqTKeU+gZOBEzKMbAn76zCK2B0JUx/Q/C/6V20WVwjKcdVI8YNsiCnc0BOvFbhUCfAGaMxMj5Ev
 eY7S62duL1gys32ptFhK458tcNft9t/tb/kLEcROx86R95gOG5FmBGVtd5JB0g4=
X-Google-Smtp-Source: AGHT+IEDsr3ELmuUqB6JM96gcqwzwXHDhN3T7BUx07Vr5D9jXhYi3Ok8kAkTxaUMJ5EqZdQZP44wCw==
X-Received: by 2002:a17:902:ebd1:b0:215:b087:5d62 with SMTP id
 d9443c01a7336-219d96ff1c1mr21228645ad.36.1734561104568; 
 Wed, 18 Dec 2024 14:31:44 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:44 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/39] target/riscv: Add svukte extension capability variable
Date: Thu, 19 Dec 2024 08:29:59 +1000
Message-ID: <20241218223010.1931245-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-2-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 59d6fc445d..d8771ca641 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_svnapot;
     bool ext_svpbmt;
     bool ext_svvptc;
+    bool ext_svukte;
     bool ext_zdinx;
     bool ext_zaamo;
     bool ext_zacas;
-- 
2.47.1


