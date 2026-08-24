Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC84C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcF-0000gs-SO; Mon, 24 Aug 2026 01:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcD-0000WU-SA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:01 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNcC-0003Fz-6m
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:53:01 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so2956531a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550779; x=1788155579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fHznkkcv3gS+qybKIUYty1mKyqPU0IGiBPNOFxV3iB0=;
 b=hBhT0x69rrs6rMMidzWNqp8GzBbzWx11ztB0oCabGP3K7g94q+ikkzzAgn8/lP10yd
 Zvk8jLWCA3abZkShiBs80+7luvIV2nehQU17SHAx0BmdeoUzlwWuiZOQozTH22/VozMP
 SKMZcwaut+HsPxgmVR+8CYCzRwyR/7Ix7/Nqb1Zs5etppCDnrYJ7jdNY68n4OnvbZj78
 qYX3rI/pFffsPmyxLbPJXw/E6hRo0+oyV/ZX089sMzstpFM7K+dpDjOaj09glffx7TXt
 +k7RMl9t8ROESj7e9Xp/L0lFfrnMmDMY60m/qKGqWOFGBZ5ODmpU2GaKzyusOwlNezZl
 +pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550779; x=1788155579;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fHznkkcv3gS+qybKIUYty1mKyqPU0IGiBPNOFxV3iB0=;
 b=r+P3kiDGfGpcANQNbrv5wpY9W3oXCms23ct77/rAf93xR4ReZZdPJcYDG3SbwOLnzq
 e8wKhIYEmphTGIAHpnzIlNOq2uDi6XmMJu/GObaFSauaNpqr4XBecL/efo14sqgclTDW
 nHAUtQBQc6/+TJeRwRP43o3EJPTcPhOwvcfIpxwQswcvbrrJAxk1/9LBr/YUrL7UeFON
 Gtr/NMH6NaPdDWniAr5masFYklLnlZzHe4hNDzoWpgpwkrAhJWOkHM1RNqubJjrubY3i
 H12jo0Ee6KPATaCBZ9kLWwypndOIzO1dEg730aG7CkJd6pUPVm4M7/FBc2QKMzAqVN3l
 t/jg==
X-Gm-Message-State: AFuF++k/M8Q7bEQ+0g5bmq8KZ+ib0T8e4ym0BUGJazmLCmZGeLdqB/S2
 qneuKVbW39CbdapQqzVORmEJsQT/PG6qENgDhZfqv1mQNDyK98ue4MsJlSA32g==
X-Gm-Gg: AR+sD12uXsKQcl7tp7Dq3XbakgZyDjf9rHx4PYDHIUApj+vsLYovIcbplvBQk5FH1up
 MvJIalBVYlXbyeWOvxuZomf/D539ch5K2G59dj1JJrKCCXFxBPEKPEdVMXEizO0LeYh/YhkB7A7
 ktEiTYBZpmj4hFSUowT4utVnfhAMtT2Mmib8mcxEYjeAnl79PJO1+qDZ5EJyNhGL0mT/MA4DBCG
 fkiVfTNo4vq9yGvQDZBoSiMHwv0nI405Wwbj2NWbulkgumJDNTD2YB4IQDZNO8NvDgLGQtckcWe
 d1cRJSJT4eAkpbx8tzcCZGpVkeks3txIq0jCzlpMyzgzurNw2q1jgiadWBVX3gPdjrBoj0dMUqM
 /v6+xaxRVAEyqA6Bk6lu8UayP1CbTouA2bWQ3adngzM4sLIx9vyTUy81MWJ1Nfohj2RvdMnQmJm
 tAEml0VvznxA96fCb73cKZiBGI0+IoU9jnT3ni/kgYMkiZ6QWOzf8lSj58fsVIMBYhZ245cgtjT
 s6Vkg==
X-Received: by 2002:a17:90b:39a3:b0:384:927f:3db9 with SMTP id
 98e67ed59e1d1-395c4bdddaemr18676983a91.1.1787550778878; 
 Sun, 23 Aug 2026 22:52:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL v2 91/96] target/riscv: Fix sstatus update in rv128
Date: Mon, 24 Aug 2026 15:48:01 +1000
Message-ID: <20260824054806.2790041-92-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

The sstatus register assignment was performed before the write
mask was fully constructed, leading to an incomplete update of
sstatus fields on the experimental rv128 target.

Move the sstatus write after the mask completion so the full
write mask is applied correctly.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260819105655.33391-2-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index ffd751caa5..9cc6297328 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3998,7 +3998,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
                                         Int128 *val)
 {
     uint64_t mask = sstatus_v1_10_mask;
-    uint64_t sstatus = env->mstatus & mask;
+    uint64_t sstatus;
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
@@ -4009,7 +4009,7 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
     if (env_archcpu(env)->cfg.ext_zicfilp) {
         mask |= SSTATUS_SPELP;
     }
-
+    sstatus = env->mstatus & mask;
     *val = int128_make128(sstatus, add_status_sd(MXL_RV128, sstatus));
     return RISCV_EXCP_NONE;
 }
-- 
2.54.0


