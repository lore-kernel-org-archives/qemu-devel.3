Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8BCC02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtk-0008B0-I4; Sat, 18 Jan 2025 20:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtg-0007oP-RR
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:41 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtf-0003O3-83
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:40 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso5829330a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249278; x=1737854078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqVRu2hI2A23etr2Fkz4TNdFQJTMNXhUJdYX9Q1S8FM=;
 b=lFqXTbXm+D23C3X48eB74EGxXXXV8m8QFX0f+N2zm9Qz2LQaeH/i25p0JED0oWlUeg
 OcKWAuMrN5ww/tnEYNx0+R7pu7GFLUV2+GQegjvU/nmG9YTk15G2XztiBrxUmSwVx1Dn
 Xqmp9bJNmTebifJDrGa3VtsUEVWhhswPTciJgRQrTZs81QydM5LfQfHqb+ybm2BGuj/S
 Aie7CjGFkEXBQ/LnR5NM8Ju+6qoGmOh+pFcuAnLk6FaHI1hWu3d35NjIA+qLwkM+PZQ/
 /01ojHBcQ7zormCsPWEL4jc5nFhC6NLS62pWEQx3rjOgxSycdGYkwm0MlyPHF8ml5V79
 pi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249278; x=1737854078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqVRu2hI2A23etr2Fkz4TNdFQJTMNXhUJdYX9Q1S8FM=;
 b=Igll4QDQJxSc1MBXLWALhYcfa8uex4SRwgrOAx1fale/W9eXTanYWzRS3FfF/MBpPa
 BgO9JMaRfXGT41TVz+38cr6AhpbYFwnc0NLBekOid0fe1kvqgsMX+3zD4acvQKxO7ejd
 X+K2+yGCLTDR0lJ7nnQ2qde5phAUEXZ1rpNYPg8COcznugVNWBo2JvS8plGGNknICW8O
 Rb2zcb7FfvGmRTxdWkAwwMqppNSlfc0kW2T3k7/VSk98eURAC7reSmIPfgMXQP+kv71H
 D6ZOs7XpvvD6HnkSN+6xyITj7hPtBQKHpARL4tl19TJsAtaxg6q86n6dNAz83kvgsmId
 MIqQ==
X-Gm-Message-State: AOJu0Yx//FV2AWWmPi7k0jTifL7rFiC7PRSGCFtO8ebwKndBGSlh2K+X
 XxhQJzDZvvycJGbuon3zTExBW+GfXj+IdJTkCgaAQ98byZ5BckQ89GgRHRCh
X-Gm-Gg: ASbGncuZaG7JeoStSoj7zPyF0scJQ4KsyQcFITkWYp4zlXGHFsKBEsEQxV+NFdBEyE8
 wfmHRQ66y+h24Lo/1Rmfq2E0A0Xd0oae+DDxeMaTeMx2wxKrZjIac27zztifpdlsS4WedHR8RHr
 N6k4VXCbvasWg6ZiFi5nDXBdG5xlYKeabRLy8AmSgTwbTpxA24N8ZQFdDUK6RppveKE2fSzELXy
 z9pXQnAkNXk1BStsR+0dCwD1amKhBSvqAkk21lrMvWCbu5ZHHWyufeZGFpPO7luoj3Gwx6h2F/z
 O6vAd9R2i3E7bvfhdOFjeDPuuieCx5n+nytBtI+b4sgPu33UEddvXzBoGJ3Oznqd44QO7iXpZA=
 =
X-Google-Smtp-Source: AGHT+IHovdntfUp/M+QcdcFRVRfE6opctoIrIhTWasyVX1YktN+dRnpGRRFRgB110WUMNBG+mO4t3w==
X-Received: by 2002:a17:90b:540b:b0:2f2:8bdd:cd8b with SMTP id
 98e67ed59e1d1-2f782d972a2mr11420294a91.29.1737249277711; 
 Sat, 18 Jan 2025 17:14:37 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 34/50] target/riscv: Add select value range check for
 counter delegation
Date: Sun, 19 Jan 2025 11:12:09 +1000
Message-ID: <20250119011225.11452-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds checks in ops performed on xireg and xireg2-xireg6 so that the
counter delegation function will receive a valid xiselect value with the
proper extensions enabled.

Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-7-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 49648ddc95..df748dffa3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2159,6 +2159,11 @@ static bool xiselect_aia_range(target_ulong isel)
            (ISELECT_IMSIC_FIRST <= isel && isel <= ISELECT_IMSIC_LAST);
 }
 
+static bool xiselect_cd_range(target_ulong isel)
+{
+    return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2284,6 +2289,17 @@ done:
     return RISCV_EXCP_NONE;
 }
 
+static int rmw_xireg_cd(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    /* TODO: Implement the functionality later */
+    return RISCV_EXCP_NONE;
+}
+
 /*
  * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2295,7 +2311,25 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
                               target_ulong isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
-    return -EINVAL;
+    int ret = -EINVAL;
+    bool virt = csrno == CSR_VSIREG ? true : false;
+
+    if (xiselect_cd_range(isel)) {
+        ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
+    } else {
+        /*
+         * As per the specification, access to unimplented region is undefined
+         * but recommendation is to raise illegal instruction exception.
+         */
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (ret) {
+        return (env->virt_enabled && virt) ?
+               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
 }
 
 static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
-- 
2.48.1


