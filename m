Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A73DCD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDP3-0003TE-QB; Thu, 21 May 2026 20:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOH-0002hx-Iv
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOF-0004jb-36
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso45756525ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408322; x=1780013122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yD8fWSpMvnt/ynUYd2DzfjQir4S3kdV8v5Qh3BFmA/Q=;
 b=Xi5u5V0sU9QX9pcKUMSpCIoKI7xze5EGCyIPAfleNPCU5ut4PzlCGqxig5V9KDKkBG
 YJ5B0B5HLv5dwMkV/qVxHcWyl/577/Lwi01UONe58D7EXA3mfqjWOt/20ggdd+TZC4R2
 lb+Dv226tcV1LdIFrSvfmKAYleM4FqGxFgdFr9cSv/d0MWBkFqSklkqA9PC24E22H423
 MlRiMzdD7jWYAeRza48tcCxwV/9JNqiSgXkEZeQnvoki+3dSueDV5rtQ5WareS1ObgZT
 7BNl6OE05APNs67P94SwLTrvNFV7Hmul7FdPBH8IHIeRpeoT6ckHl/gCPCnegAvDHaph
 j2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408322; x=1780013122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yD8fWSpMvnt/ynUYd2DzfjQir4S3kdV8v5Qh3BFmA/Q=;
 b=pmS1XGD5c/1a6WO7zGtzHWuiogH7Dnq0BylyLzxds6rJQYPRl8tP2LBMwyp+CBXFJk
 D0my4z0YBVr+Q2v1ub3E6FDNPcCAIjWygrI836DCdYS+qr3znfcJinvGuq/rc29bySWm
 aNWIqemfmlME89l07GOJhWv3EkbEe4HCDEKKsoTyjYq8yNuzXcQHK/ss/CIr5GT7Ia5P
 Mz3/v5SIgLcxSXDhtWBC6jsaHivywOuFyhznxWoeCTW1Pcc9/Du1JeVpX3kGUy1aw2hF
 RhbjyXYOZVZuWHvaZerQAPtyuKMyHUnJMgq/ObYMcTYipb6Usb18MfSMcEp2scHbRxGS
 tvhw==
X-Gm-Message-State: AOJu0YzqIwlXtFJyfProH6zgsTnfGiJSz8JUF3H/B7eESerNnvDWPJgJ
 HoWaGS8qH8MQYe/u8c14SfnZCHCq+6Q44qTx586lTvDgDdP2r5S34oeAfTBffaUn
X-Gm-Gg: Acq92OHBDDhEpWrY9DEsdWKQF8PMxqaBXsSk5lgpkUW/m6vzcajWCigAE+Mg/2GP6Bc
 /iT5ZdIK+73H5/H/6MqjNZy/ILne96bXRhIJ1hXmkY6d9W3FzYq9GlscqZk2tKmSb4eCqBiSVNf
 rqTz+c9D2wKeostMMR1rHrRszOJG+vdY3G17mbgd2KYcBBMJXUaeh7yQPBvLUUKq8NDXkEUfWQk
 DsLQEn9eQssn1V5b+QWsCMNFoCGkb5rXKyJuudSVIqxcnPSPwm+zmaED0HffIggTz9lYOBeMiPC
 9cElb3WWunXJVAIGTwae9OE2LACRqoP+zIZwbRxEzuNtoizW2p7ReNKxetXtSaigBpY9lvr+1Fp
 l0N2qUUZupI0f63y3Y+W1Ng2ihfwtVEz/T/quh2F3KyyYZ4q1EI+HJdyaNrdMyaOreoJT7Js4mD
 XhLV+j6wjreT0i6mGyles7JrPBVOa0jNxWwcN+W2WqGw==
X-Received: by 2002:a17:902:e78e:b0:2bd:657f:3a1b with SMTP id
 d9443c01a7336-2beb065d2b3mr9730595ad.40.1779408321639; 
 Thu, 21 May 2026 17:05:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/48] target/riscv/tcg: use isa_edata_arr[] in
 riscv_cpu_update_misa_x()
Date: Fri, 22 May 2026 10:03:09 +1000
Message-ID: <20260522000324.23255-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The non-standard extensions, in this particular function the vendor
extensions, are all riscv,isa names that starts with 'x'.

In theory this is a bit slower than using riscv_cpu_vendor_exts
(isa_edata_arr is longer) but riscv_cpu_update_misa_x() is executed only
once during finalize(), i.e. not a hot path.  We're accepting a tiny
performance hit as as a tradeoff for the code simplication we'll have
later by removing all riscv_cpu_* arrays.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-9-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8dea22bae5..b7d59f40f2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1155,10 +1155,11 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
 static void riscv_cpu_update_misa_x(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
-    const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
+    const RISCVIsaExtData *edata;
 
-    for (int i = 0; arr[i].name != NULL; i++) {
-        if (isa_ext_is_enabled(cpu, arr[i].offset)) {
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->name[0] == 'x'
+            && isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
             riscv_cpu_set_misa_ext(env, env->misa_ext | RVX);
             break;
         }
-- 
2.53.0


