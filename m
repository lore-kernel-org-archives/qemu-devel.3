Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E5DC3600C
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXRI-0008Gi-6b; Sat, 29 Mar 2025 10:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXRC-0008BO-7S
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXRA-0004Tb-9k
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2241053582dso30883385ad.1
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259526; x=1743864326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lbs71pKdlN7MyNJTt4MNBTzM7Sw2d+gd3ctimJRhzq4=;
 b=agSdIGM4/aulZ2qmGYc2/HaOCFUPsdr3bSlxZzW6coqtt2xDeSsySRh5+ueOnHDxxX
 KAy5OEljgLDwDaRRadPfmIwz9dzOMaAT2Mu6xo+yPUK3mPmR+EmIxZdszmiMbx7kgepj
 6LzYUChkwRoycTTRa4wdOycKZCxBHdO44TMRuwgkiEjP/oHjQto0VRvuewHOsIrRqid3
 VdVAUGBQ/urcQvnTFjhRFRDuOSRciAj3TUboU1rEz6t7X0euYbV7ldY5Z6C9TizqlHlu
 +CGZW0xMVWnoCu2hFMiqGUmopeRyCaeI8SwZJ4h9O/SqZJc8VvRSEQfynYu768MegnnN
 Lx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259526; x=1743864326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lbs71pKdlN7MyNJTt4MNBTzM7Sw2d+gd3ctimJRhzq4=;
 b=WgkI6261v9jsg6YqOL9bWgNmnMZQwa+5u2gUZIlrmwZtE1rCNsMRKjC9PPoqgSytsA
 ea2gIstYk9HosALC4Dyoc/Va3SSsOzAzxLOKqZ+aPGCE0fcICmWH+SQh/idwXvKsAF5N
 ZCHAJ6cWqDGYlv96Bx+ucRX+MV4ACKuk50YZs/3DPXjfJYS1vCUqROF6gkg+EEb09N/P
 RG8PIHQ6IsG4+y8r8g52bP6a8yfzMHV9hhghTJIOsZG82IOINIqvzgDfVZVDk89BxFE9
 EptWmoUxOEbWmSXFrMfSWSuYz9i1b6IWciiKPamqEQn9Qaup5sKD1HFYzHj/qcWUT5pt
 CKDw==
X-Gm-Message-State: AOJu0YzQ84VLv3pjq55CnoY7nDibMBQrSxFB2rcmHGUDmQy+DfPSLtVf
 2TWUkhnoiryJvtm7unikMdXR4SpM+D1OD6Vky2gyaJW3NfCjnLQmifgv3E5Mn4V2QeTSQz/ZHXs
 Go+uSbAx5VeNgVCZY4/gzvQLvbaPtdo9bBaKDzOVcTpI/XL6OVmVuy/xJVcw9ygNBAEbzaocRl4
 2WNLUAx8sX3gjyzS3CstxQplgFXSngx/2X4/IbYw==
X-Gm-Gg: ASbGncs+MG7J7GJ0MAyiPNaufO1jU/OZiNwexBTA2xedNYHaKImm8gEcW6kI2h4DTXU
 Fr3WMYiYiccy0r0dqxV3vvGR7DNcASuVU2KkW38mowuqAy6TraEXxsyV2t26CDi2LkZJwerJLcj
 V4hcbAzDcWRSca75WwI9znsF4sUwBQXxWqePKUcCQEwJ6D6Vp3ogbgdLHWJ0tgG18kDmx880Aqk
 UOjnkraMeAT2Qlkm59epYu5kqHeG66bDVhZqf1+zK31G1RA+ix5lFXTbBax0MSV1vYiF52Q/ZLC
 gKUT7Z/eS6qdHsZkLM+USVJM+PzBZIYLkFSOzmUldcVCzwTLMBeO/OJXP6RGXc9a82VIQVBOHhg
 JGHa5oMy8TRGuTw==
X-Google-Smtp-Source: AGHT+IGTo1qr2paOOCah2W0K6rQkW1qzZxLtzsmPAvfcasaosEiaoqCEWb1Rszoagg2KKBVjo+pAAg==
X-Received: by 2002:a17:90b:5450:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-30531fa13bbmr6268851a91.12.1743259526376; 
 Sat, 29 Mar 2025 07:45:26 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:45:26 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 11/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector indexed load/store instructions
Date: Sat, 29 Mar 2025 22:44:45 +0800
Message-ID: <20250329144446.2619306-12-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62b.google.com
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
 target/riscv/insn_trans/trans_rvv.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d4d1ad055fa..3b36464176a 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1044,7 +1044,8 @@ static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm, eew);
+           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm, eew) &&
+           vext_check_input_eew(s, -1, 0, a->rs2, eew, a->vm);
 }
 
 GEN_VEXT_TRANS(vlxei8_v,  MO_8,  rnfvm, ld_index_op, ld_index_check)
@@ -1096,7 +1097,8 @@ static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_st_index(s, a->rd, a->rs2, a->nf, eew);
+           vext_check_st_index(s, a->rd, a->rs2, a->nf, eew) &&
+           vext_check_input_eew(s, a->rd, s->sew, a->rs2, eew, a->vm);
 }
 
 GEN_VEXT_TRANS(vsxei8_v,  MO_8,  rnfvm, st_index_op, st_index_check)
-- 
2.43.0


