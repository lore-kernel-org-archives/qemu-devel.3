Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0023F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Pi-0006fw-Cj; Sun, 08 Mar 2026 03:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Pg-0006ec-JQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:56 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Pf-0001Pn-5Y
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:56 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-12732e6a123so1413881c88.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954333; x=1773559133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYcU9A1WiITUSWFwxQC1FMA42v4mgGSsjlTStLdxexA=;
 b=W8sh9T4dlUUiW77XYG/o9i2eoLkP3xX67rxpxCFGhFlXRMcNacoXUpMh2AVYb82qsY
 5S9BNrXzd2r/EAL2jcgYnsIrr6HXcAoULzlaQZlzKYev65WGepQcY4giKfbw06U6U43c
 caaNI7DiJIUSrPi2wqw0DLKJbYptB+JU+7HUjMWJXD56hlRItxoqOAF7t8ckR6qZSSfl
 GCqjWn2H/sxMMpzFJxIbF2NhuzowuZ04KIZqYaeGUj4+W7HEE7Y4Dq0eV84oMreoKQhK
 et0bRAM6KrExLLlAku9/xnbpXLKlTvFMFGzI45pKSHT+TdBc7dDTmnU2t2LCAAaJ9TeS
 F0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954333; x=1773559133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bYcU9A1WiITUSWFwxQC1FMA42v4mgGSsjlTStLdxexA=;
 b=o4uoQuly3TOirh42blwxRMJgAg/ycyBGvsc0x2KiuBMBlY3Q6tJoP5oV+Y1aAGgmX7
 eBnZjqOhrBl0VIOI7QyC0m6H4rzbbT/BSYKWCnd5v1KcwcTsKo8Fr20fig4oSC9woRLu
 7RxXikmZesPXeo+a6llxy1QxTRRA0y45xBylaUdADhYye/JVlwh3Tfho/4fBO84IuaN6
 4R3/JlbTcRkOkrhh8oZ2CnpLQpGRoEvaXwzcFZrxugTf5dD9EEIMDc6n1g2Bck3x09PR
 wJIeacLFTTz5u50Hfn6EOYZFj5mDCFBeVAO+0KJIcCYoSYPJVwK3ghkWflf0SVgCVhVy
 coTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRoYnBM+tT/g2PgkGjEcjp8VLIAVKIUOH+kuDuUuWN3dayqkyIuszvf8fVaV2yGvqRnOwUSSRncTDG@nongnu.org
X-Gm-Message-State: AOJu0Yy463PNKgKYzRfEYlUOLI5xTeVO6Kknyx1J7+M7k4Uju9dPm4J2
 BchDXH0uZ5QgHqDaJgjTK5BNqSHfl0Kra2qdkK9cBA43amhbNz5j9we5
X-Gm-Gg: ATEYQzx2+4SNQGS5vt9msMaP7LUePP2lnLLJ+PBO0wOp1LZEP8fF3v75MLYHMXP++CR
 Z71HxCwKQjM0K2u0AklWB8DS3BZo1SyEk8gHb8v8wjLf/kk146VU+8E2LfeBEzB2qJafj3iGJwi
 htEwRVINgTN/2VvVFeDgp/YsSxtRVowq4dkDIwNqTr81/EWEmiYfuYadjwlqCNwxvqgWdJLHxLy
 eY39Nj762acgMKxfaxPV0lSq9JY+ATRmEW8RkL5aSxju48cXmLyRTrxlWcdiNl7cvmfrwbeP1eS
 mAfVnCduydzPv2cREy7bmymj49qxwZvEDfQ+qHs8Chy3NpDxXB1Ofi5vpHENqmJq7Q6ghKoMh4M
 1VKLCTZCopkVYfPNsuBREGwb0gyX50grQATkQ2/UjJ7rM4NCEdysIs/+K6/QwE7ZctI2RW4CeMU
 /ZuMyE0lte1z2WzAXft7RcRGlBxD7u4nITVr//OVY0YY9qCN0i83ikDfKIzRi3Fl7EaT4padkKz
 UB1CeKEp8mAGKXqbnIprtdACAc=
X-Received: by 2002:a05:7301:1009:b0:2be:3f:307c with SMTP id
 5a478bee46e88-2be4e0644camr2877195eec.29.1772954333513; 
 Sat, 07 Mar 2026 23:18:53 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:18:51 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 04/28] target/riscv: route in-debug exceptions back to the
 DM ROM
Date: Sun,  8 Mar 2026 15:17:07 +0800
Message-ID: <fd669f903f8ded5b2c96023bf9a11bcbdfda400b.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When a hart is already executing from the Debug Module ROM,
redirect synchronous exceptions to the ROM exception entry
instead of taking the normal trap path.

This keeps the hart inside the Debug Module state machine and
lets the ROM report command faults through its mailbox protocol.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e477016d4a..81b74f7e4a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -142,6 +142,9 @@ static bool riscv_sdext_enabled(CPURISCVState *env)
     return riscv_cpu_cfg(env)->ext_sdext;
 }
 
+/* DM ROM entry window offsets: exception vector is entry + 0x10 (0x810). */
+#define RISCV_DEBUG_ROM_EXCEPTION_OFS 0x10
+
 /*
  * Debug Spec v1.0 Table 9:
  * - ebreak: dpc = address of the ebreak instruction.
@@ -2326,6 +2329,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         return;
     }
 
+    if (env->debug_mode && env->dm_rom_present) {
+        /*
+         * Exceptions taken while already in Debug Mode are handled by the
+         * DM ROM exception entry (0x810 in the backing ROM).
+         */
+        env->pc = env->dm_halt_addr + RISCV_DEBUG_ROM_EXCEPTION_OFS;
+        return;
+    }
+
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
-- 
2.53.0


