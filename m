Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C45C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZY-0002Rz-Dp; Mon, 24 Aug 2026 01:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYd-0001R4-Qm
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:24 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYY-0001uf-J2
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:17 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so4138919a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550553; x=1788155353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bEOIVZvOI6v3LMY4XYw/LCi0puozDvkVflYenuC6IF8=;
 b=IN1/k9pPPP4YYdMfaRYh3wl1r9rOOSSDR5tb30LtyE+JHuFwbtW2oj2LoyRdGD/WcR
 PdOZ+SQAc3Cw79BFH897UjmnMEFvZZobnH5JB3NvaPT9KnAiuo/w+sGxEaSSOFl5Ihoj
 nOwGS6FloyO9t4fUnHO7FW6iFr0efhqJVRss9OXwu0p5aTODRJhzW0Zw9/OwYUhI5HgE
 OvXhtBQXWCt9y+Oio8Ri1aX9iWiIABnHtJ1S3haTcTwoOeAswWZ7Nq5qSN8+KI8Hf6Tp
 47/r+JJIhnfklmxYHY5npL9i/iS19/J0rvY2aIoClng5kkciW84lsEkjT4xst55UokNW
 kfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550553; x=1788155353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bEOIVZvOI6v3LMY4XYw/LCi0puozDvkVflYenuC6IF8=;
 b=E4TwNNuG5+GNYhRGYqBLbohD+Wyv1VItQ2AdtpLyatlaW0oAdMDqz02o+eOMMtM59O
 XFjtdtddQ+pP4nwHZIAYCLbG1giXD4EzqEUOUCA+RzxmK95i71t5A+RuHF7ZjR3Of3eH
 O0nSQUSSRcklj10+RRFBXvyeo1/59mnTRnGoMkxCqrq53vrU2qHLuqyfRs8m2hGa8F5Q
 TK53L57EsUzXiunTYERE/IROJJrVR9wrA9T5hHxqxS4cZIudnc0Xo7A+W3wBC159eCfD
 5HlqnZkHByzfjI3YuD86imatZ6860leRDb9nr9PiopzEPEftKrKRkl4PxlXQk49XC+cW
 Fb0w==
X-Gm-Message-State: AFuF++n1uMQ5inPj/SfFDDpa8e3dhoE0K9aA2CBoesiLMDqHdvIMtXut
 czEAettqTUbl1FUKxPjnEmM+cmFeWLWrQzbaElYHtVpj9dnZWZuP0Uf7qyzsNA==
X-Gm-Gg: AR+sD10crECxS3mBDJaaHt08LaQntr7wHNnPF4sYf07z+Y8ubk7hgNx44QYGaMwHW08
 lp4RCwDDcfGLBbh5l2aDNJdVB9if2d/dd8OSuQ0zQQp8Beke2iQRJtWyvwDmuP/b+0sYtBfUPhM
 vZFLI0syRx71WlVEubM+YmyHAq3SYTQmXDmyixzzIHusbDq1qPbogUQY7DTXlqyvdBSR8y88C5y
 48c4JXekC58c19MTY31/kWhD5NoRSYe+1IOfHU6qBhtP8e5k7pSQKQAPxm4x1SwDklOuvpG3Z6d
 7ab4MdlyGcO4fH+pcNKCujSz9ENYiGl533PnO7Cz9PpCzZ5AuOB2M7UEfTBLmaX2BWuxkq9P1+1
 R/bpkmC4DRY0tQ4U7Cr+q9auThF2G74sgwJYHP98WkIhFWurmOcaALOrPWbrvn8C1sbJsxvoKvN
 8VOq4zEZBpWiHesJvmeqaQwv0pI3yCRU2QVkBPw2rVjuOBxJ8/QlL12qQHPWchMTvrUcRlupRa4
 4Siog==
X-Received: by 2002:a17:90a:f945:b0:38e:8300:af51 with SMTP id
 98e67ed59e1d1-395c35485b4mr44971143a91.8.1787550553359; 
 Sun, 23 Aug 2026 22:49:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 17/96] hw/riscv: sifive_u: Align ROM reset vector data
Date: Mon, 24 Aug 2026 15:46:47 +1000
Message-ID: <20260824054806.2790041-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

From: Frank Chang <frank.chang@sifive.com>

The SiFive U ROM reset vector data needs proper 8-byte alignment for
RV64 ld instructions. The misaligned load will cause exception when
Zicclsm is supported as SiFive U CPU doesn't support hardware misaligned
loads and stores.

Add padding to ensure start_addr and fdt_load_addr are placed at 8-byte
aligned offsets and adjust the load instruction offsets to match the new
data layout.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260810055618.1175500-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 99423ef472..57a57c96e1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -564,19 +564,20 @@ static void sifive_u_machine_init(MachineState *machine)
         0,
         0,
         0x00028067,                    /*     jr     t0 */
+        0x00000000,                    /* padding for alignment */
         start_addr,                    /* start: .dword */
         start_addr_hi32,
         fdt_load_addr,                 /* fdt_laddr: .dword */
         fdt_load_addr_hi32,
-        0x00000000,
                                        /* fw_dyn: */
     };
+
     if (riscv_is_32bit(&s->soc.u_cpus)) {
-        reset_vec[4] = 0x0202a583;     /*     lw     a1, 32(t0) */
-        reset_vec[5] = 0x0182a283;     /*     lw     t0, 24(t0) */
+        reset_vec[4] = 0x0242a583;     /*     lw     a1, 36(t0) */
+        reset_vec[5] = 0x01c2a283;     /*     lw     t0, 28(t0) */
     } else {
-        reset_vec[4] = 0x0202b583;     /*     ld     a1, 32(t0) */
-        reset_vec[5] = 0x0182b283;     /*     ld     t0, 24(t0) */
+        reset_vec[4] = 0x0242b583;     /*     ld     a1, 36(t0) */
+        reset_vec[5] = 0x01c2b283;     /*     ld     t0, 28(t0) */
     }
 
 
-- 
2.54.0


