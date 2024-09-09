Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B9EEB64DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snTuK-0006lD-PY; Sun, 08 Sep 2024 22:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snTuJ-0006kD-M5; Sun, 08 Sep 2024 22:13:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snTuH-0001MX-VH; Sun, 08 Sep 2024 22:13:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-718da0821cbso1891078b3a.0; 
 Sun, 08 Sep 2024 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725848012; x=1726452812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsWFRdYWdBaST8wvMPQrZTKJI/aAOCM7Gcb6EQnnHW0=;
 b=fp/I4hxbwHYB0yref/vM8j8PFDTwuTCDxD084PL5zqsjwyUkQor2kXxTL6oyOpJSd5
 fkVA58CIHzi2v4XYTA1hPQ1i/Y+yHwDV8QGrqXxfz2Xn326Byns8W/mWEo/u9exV7pWd
 /RxEQybHKlxQA+XpridAJKVvZqDYAq8IfofMX+BQV2JrQLxvWUpZyLt0MnK9ydy7EhB0
 i0EgAK13dEX0NZodfMbLDdH7H2lvfrS+UvfrnFSgcSTmyGg2xkErU6DQvODws+G6OSZ8
 bTWo90qyy1dd0UWGwAGCxlxHutfOXz+5BO8rrOiCO+CH8aXMaBV5IXEsOUbku6Tl7mCO
 UYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725848012; x=1726452812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsWFRdYWdBaST8wvMPQrZTKJI/aAOCM7Gcb6EQnnHW0=;
 b=Pog8wuujTLIbOk6GLwx8/ADdrboSVyZIhaYmAaPW2kMclbKI+G4BuBgaBSttGGjBNr
 TdbdV6rUN8GPSjLHL1+9H2+BLjjPX6UcY6pL+EUDw1mnMiQLxYP1JYPVoFRpaxNkk21T
 Lg+AG6N6scZB629VlncLGWrNi1NRzVyMz5ifssTXDV4ZOZ9o6qub2vUG07m6985GBSyG
 KOAkML8eh6dv8EfzCMA6bi+i0gK5klWY+Z75i5C8qVcX2TptXdTijtFFcKuyvgJpKDuY
 JD64SW5eCT+9w+syATtbQbgIgMAVj3NbvK6Iw8aiBJ05VCnedwhNYKdNDcgH028Bye83
 YDcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcZ94SYwLvSG2v0lpXJDfTfQcrGmovooQ1ggRVv2+31nXUnrdh2ODucnbAATSPpqQk+kv956teJ3hs@nongnu.org,
 AJvYcCWeM/K4YfUL0PhRs4lo/umA7+M5S0WUEyKWLrwmo+KYXRVF8yJNMqbN+KLOxmXG3OG/ahu6KBLSfwjgVA==@nongnu.org
X-Gm-Message-State: AOJu0YxxshQ5NlPMoL1wKstJXhDdRc/NufxKFdIybz/jt/tjh9hf2H1W
 VtDguTwQiL6AQ9UCUrRw5+pnlHSCUBk0uV9t/dLPjIzd6PRlKRF8
X-Google-Smtp-Source: AGHT+IH9xuG0htxZ1C7TbpVaozzZ/Alh/YT/2G4WBIFBzExcL5hmH0GOeqZfjTKEsoj2iKTGO15V+g==
X-Received: by 2002:a05:6a20:271d:b0:1cf:2d2f:34fa with SMTP id
 adf61e73a8af0-1cf2d2f365emr7292964637.25.1725848012201; 
 Sun, 08 Sep 2024 19:13:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58c68d3sm2528155b3a.84.2024.09.08.19.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 19:13:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.bennee@linaro.org,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, palmer@dabbelt.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, Alistair Francis <alistair.francis@wdc.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 1/2] hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
Date: Mon,  9 Sep 2024 12:13:16 +1000
Message-ID: <20240909021317.58192-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909021317.58192-1-alistair.francis@wdc.com>
References: <20240909021317.58192-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

The current approach of using qemu_chr_fe_write() and ignoring the
return values results in dropped characters [1]. Ideally we want to
report FIFO status to the guest, but the HTIF isn't a real UART, so we
don't really have a way to do that.

Instead let's just use qemu_chr_fe_write_all() so at least we don't drop
characters.

1: https://gitlab.com/qemu-project/qemu/-/issues/2114

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/char/riscv_htif.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 9bef60def1..d40b542948 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -218,7 +218,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                     tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                     uint8_t ch;
                     cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
-                    qemu_chr_fe_write(&s->chr, &ch, 1);
+                    /*
+                     * XXX this blocks entire thread. Rewrite to use
+                     * qemu_chr_fe_write and background I/O callbacks
+                     */
+                    qemu_chr_fe_write_all(&s->chr, &ch, 1);
                     resp = 0x100 | (uint8_t)payload;
                 } else {
                     qemu_log_mask(LOG_UNIMP,
@@ -237,7 +241,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
             return;
         } else if (cmd == HTIF_CONSOLE_CMD_PUTC) {
             uint8_t ch = (uint8_t)payload;
-            qemu_chr_fe_write(&s->chr, &ch, 1);
+            /*
+             * XXX this blocks entire thread. Rewrite to use
+             * qemu_chr_fe_write and background I/O callbacks
+             */
+            qemu_chr_fe_write_all(&s->chr, &ch, 1);
             resp = 0x100 | (uint8_t)payload;
         } else {
             qemu_log("HTIF device %d: unknown command\n", device);
-- 
2.46.0


