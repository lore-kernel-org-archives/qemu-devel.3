Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F14C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrsk-0002gk-JA; Mon, 19 May 2025 00:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmk-0004kC-Fe
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:33 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmg-00045c-Pa
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:28 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30ed99132abso752409a91.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627645; x=1748232445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQ8oK567cL4InAUCLjpcMcBvYiQLXRFYVbtoODZATfI=;
 b=ZFOJwxFRF7tDSEo90iCHdp8ixY9FcBGrj2sJs1XAtDDOhXcWiT1RR8S8WCFyZWzvby
 wJW3ZEch4U6xnwhg7GCxRE0nd1gaVmw5IqOnv6Sa+/XCGaYQFBEeQ6MFX4QHe+kctFYs
 BEHDwgJIi/Jov/fnyrDg0UryjLQ86oUnW/T6rM/uHknle8X9PdZeakJHKhKh3WFfkkwc
 uV/cgPCfMJIm96JFZomOOuBXezDyvSt9DfWd9le06MF4gsMnIe6KffEQLBoH6H7GVPs7
 C4gQM5Izscqc/LzULa8/vRDzhJXJCFIKnc+Sd5wbqNUl6bjKpOaUqrd5ZNiSBqrJ0TRE
 Go7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627645; x=1748232445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQ8oK567cL4InAUCLjpcMcBvYiQLXRFYVbtoODZATfI=;
 b=e6fGHvPBrvzPhmVk9ZDi+j9Cen/X9Qti2aa/VL9+b9VwwdK37w7PVEMRdS2kslqClx
 IrQ526QEvUGXIFp838tesf/Tf2GUk2RIy2hKPdYSbZX4kJ0fn9AnwsRzfN3k6nsw/LhU
 NEogj8vAfhdC63WrRbE+MkLij3vFO0MtCj2Sl+tmmckimH3O/rWgEQRNYHKMxrbPVTSB
 rRjSOyKH3kBdnEJhnjwDsVe4BVX/eHQtGYspehttBN5xd4r7LvaLQagnTSyvPW13p3GW
 niRM61Z+FHhduo9YMVuRpUVhU+YjvR1J51NtRM1+rYjjdBfv1VFy0JYDw5JqhyJPkufq
 3vrA==
X-Gm-Message-State: AOJu0YylSvQsrg9qKLnMifahOniYebwc6y5YHHG2BFOEtftfOLJTOYYu
 nM58VwhbtDuEKCAanFxUQd23q26Jqz4fkYQKrxvjF7nvC4VrxGkK59NwJB/NQA==
X-Gm-Gg: ASbGncvWYlQLPfJFZ9TUR/eAubhhEv+zLg6IX8M8MukuNnpVjbesEJePp0Vs4rS3nI+
 1vuI5B6L+PvGxs88kRDcHOS3onqt3iWSIcuE1HXQ9mBdwGa+RriGt6TH27c23MnMkExJ0qlJlNV
 8/Uwc5iO4XXKjPM46z9FaWbvy5T2TZNrzIUcdU4bWN39Fb1T56qxPVEo320l4Mf5dvuQZBOcqF2
 h1Ek5JK+zZ4cj+LXCylDpA/Vp48NAongHIE1WMCczJoqk6b9Ud15PwBQSUy/kQ4B1RKotMvuG8p
 SNuyaow68gOjmtV9qoF2XiFy1goDI8DITkmcSi7Zjb7naoNiPkqdFwuHRI4LI+XT5ilvg/CD6q/
 7gaZXkb8qY+3klYfUXIpVk8tKVCI4bkMpkuAVM+I7lf5V4nMDnJw3UH8s
X-Google-Smtp-Source: AGHT+IGVOZWfhn2SIfXo1tf+oMj5+2825n7mGdgRmxejbaGH5S2f9xhJsJLeE7BHwf/6TbBYUkc3+A==
X-Received: by 2002:a17:902:c948:b0:22f:c91f:d05f with SMTP id
 d9443c01a7336-231d45c99c7mr173264435ad.46.1747627644713; 
 Sun, 18 May 2025 21:07:24 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 06/56] target/riscv: pmp: exit csr writes early if value was
 not changed
Date: Mon, 19 May 2025 14:05:03 +1000
Message-ID: <20250519040555.3797167-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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

From: Loïc Lefort <loic@rivosinc.com>

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20250313193011.720075-5-loic@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 8fc313990a..4070e21ea3 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -142,6 +142,11 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
+        if (env->pmp_state.pmp[pmp_index].cfg_reg == val) {
+            /* no change */
+            return false;
+        }
+
         if (pmp_is_readonly(env, pmp_index)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpcfg write - read only\n");
@@ -529,6 +534,11 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
     bool is_next_cfg_tor = false;
 
     if (addr_index < MAX_RISCV_PMPS) {
+        if (env->pmp_state.pmp[addr_index].addr_reg == val) {
+            /* no change */
+            return;
+        }
+
         /*
          * In TOR mode, need to check the lock bit of the next pmp
          * (if there is a next).
@@ -545,14 +555,12 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
         }
 
         if (!pmp_is_readonly(env, addr_index)) {
-            if (env->pmp_state.pmp[addr_index].addr_reg != val) {
-                env->pmp_state.pmp[addr_index].addr_reg = val;
-                pmp_update_rule_addr(env, addr_index);
-                if (is_next_cfg_tor) {
-                    pmp_update_rule_addr(env, addr_index + 1);
-                }
-                tlb_flush(env_cpu(env));
+            env->pmp_state.pmp[addr_index].addr_reg = val;
+            pmp_update_rule_addr(env, addr_index);
+            if (is_next_cfg_tor) {
+                pmp_update_rule_addr(env, addr_index + 1);
             }
+            tlb_flush(env_cpu(env));
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpaddr write - read only\n");
-- 
2.49.0


