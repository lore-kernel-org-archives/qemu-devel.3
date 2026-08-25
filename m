Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA4DC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR0-0000i2-IE; Tue, 25 Aug 2026 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2w-0002wG-5D
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:38 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys2u-0002Bj-IX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:37 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5aeba09900bso3766895e87.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667755; x=1788272555; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LI3sq1n8XBnLR5ub4+Q8rmK77n4x7xn6BqJ31PJd3nw=;
 b=YKII06pd1uGQiNIuOIEuVOIg/oq7+qePODAJ76lnH9I5dvigCuaCUtstwE1ioQBM6m
 yPaI9fCgV+n/rid2UBS9tjuZu/sK2EL3lTWvWNHZRdoM+O/Hu+BbE8LBjWfeRuoSjSgO
 +P5Zm5StaZSCBtmJvGA9tUKt4XzF604Bigll+j8/tCmnOeWcEa3sdchkAM375BZBfp+/
 fxSyUHrUYTxe0Zev2qOJ6OYCJ1jCKvtvtqwRJ/FzWjyqt3a6+d9g8eG/ZtXFn0AlFo0l
 lt1jTML6aV13/kW+pJoR9gDoMe9fEpiAGCQ5jb0Nep55OirtiuP7Za/KKfVOT96Z8ixr
 s4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667755; x=1788272555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LI3sq1n8XBnLR5ub4+Q8rmK77n4x7xn6BqJ31PJd3nw=;
 b=Ol/ctekF9vrUkQH4ozTILz5C51uuY3avnqupHGN3S2dQaEWHMOYz9mdZTVwQUAfVs0
 BG7d5EFnnPTgLdQuG376CIgviGMc5xn9mG910v23iydRqSZRDyzIujp/HlkWgam4rd0r
 +ED9bh+u1k5kh+eOFSAsExiq5qATD75zy9449KrhYkH4QNMInZ7cyTj0nUIR8dXkZ/Nl
 TNkGBahwdV8adEVTnY8zjg4KK84buqewwscLl5loLFhWFjryVT449OTh9TIoHgMbuN+c
 cDNaEjx6tW+BNRW9z4ewQUWYE7C9tFF5xnO7QAN1djq1jJp2violyawwh01vadkSDR33
 mW0g==
X-Gm-Message-State: AFuF++kKHzdCJNClguGIobVarxvk5m8VlihDeVwRKqeIq4banK4qMlMI
 gsy29WSZS0C8bNFx/GtLGQK0blI7OXF84ifpieR8kY/ydeBekiDbay/s
X-Gm-Gg: AR+sD13sMeFKjKSB4Dx+WFoAQelImLHJuSf2lu83DmxsaqWKbvg0gIVHuszX3j5Gd5L
 cq9kg2Oi0nsVUdFzJA4i1P1U2ojAYcOgIP7flTj0E8tiVT746ohN2T8bc3Ntla6eIcGCRQnJaTW
 h1vyY0vmmT1xatCJMagSaqrYU8YwODxsQdLj/SlJ/5wfHkDWJbgCv23oQTQxRx1IkYyQ2w0ZzkM
 +q67HsoQeespqvq+SnoQQjNKP0rEO2y61fPpIQjk3lSiiVotJBtK9bbJ9aVt+5R3F5z4w/p4Zy6
 BmR4VVCNnLFPi/cFXGRs+0pC/3HGQePWZh4meTemx3zvFcwEIO3qIfXhGp/4WQjs1lHEu+z7x7K
 RmE6VD+UdkR2sgbKxW7fNVMq/NRW07jy8zzdz8qml/1gmQU2MBNS8dXG4SSBpL+i1+zj2My+CYR
 eAD/FFy4wpHugehlLJdrugcNrzPVbT9i04B+YfKn+Em0USyKOW0q+WKLfb+OIkxvlul8R3NVlTs
 ECRM+1MyCRPIWAq/OiS7oCJBV5XsQ==
X-Received: by 2002:a05:6512:3984:b0:5ae:bfd6:1bc1 with SMTP id
 2adb3069b0e04-5b49cdbd7a9mr2072476e87.14.1787667754610; 
 Tue, 25 Aug 2026 07:22:34 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:34 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:28 +0300
Subject: [PATCH 04/13] hw/riscv/trace-encoder.c: align ntrace messages with
 ones
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-4-f8be2f40d2fd@gmail.com>
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexei Filippov <halip0503@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=tHjTrH7pT1Lm/SAlViZQNQityFhQMBTTvYUp/zeZ1NE=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUjFsEo44uVfvzYKKDsDgRvgzx4AhMbxN35V
 wQD9rY3fbyJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIwAKCRBIiqVupVDe
 dpGmD/92JTGTTCu1GuWFErE7vjJPkk3BHxDIjmuFkpli6mtmw3/Bn9fje/ZErzJSgS8XAhF1J3M
 EQ9XlSLeiT1C4rdIbAy5cLG5n4qRvaFkis5cCm4a1FpFhpQhugXiQJZVbSJ5JejzdYN0sXX0EMK
 tkGp359qal39z/YA/eURyziG6Pp2VjCbeBIDI8DFSsYsgbDGQ4GswlBKtbjepw+6vwveo3odhH0
 mjF6MDXAC0SHGlB7BepCLF0hr4ctoxjtx14ciGFwi6Ss7AUkvle59Q3FTHBJGgd8WKIgGD3hgcS
 Q7pj1UChCb64J6VOLV0SXZSnTqN0Z8eb2xtvULECu+QTRBRTreW5TWpC9P0bzpfE4KUmkUWT8g2
 YSD72YTIvAukuQY4QXOgSkDzTYWYXhvaoSy7IaRwqvE66QLvJhSAnOFiMDpNbEU25PLsbmCLaCA
 3gWLEQHyaCWXVklXfDr/UiTb8SMpuZMXv4ujob3TsNwriCfASZlwyPLRzoe7v9aq2wHEUUhmtil
 Krv6k3HYO8bJ3HSsllKbRk72R1RpyTkIu5VaXtPME0zVxcWyR6KKke6kIiu8XgBXpgpSovMevb1
 U8lJn+ZPgKHGdDZhptJzOAtcdAeN2r5VqUXorQI01g9bMK3TPof6oqVGf9zYdnJGJlAXUcS12qq
 YJFcgmeKeqiivPw==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=antikostya2@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2026 10:47:29 -0400
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

N-Trace format requires idle bytes to be filled with 0xff, instead of
zeroes, like E-Trace format

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 hw/riscv/trace-encoder.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 10e52e207e..703454c9b7 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -398,21 +398,35 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     hwaddr dest = trencoder_read_ramsink_writep(trencoder);
     bool wrapped = false;
 
+    if (trencoder->ntrace) {
+        /*
+         * RISC-V N-Trace 3.1. MSEO Sequences:
+         * idle bytes in N-Trace format are filled with 0xff, instead of zeroes
+         */
+        memset(msg + msg_size, 0xff, 4 - msg_size % 4);
+    }
     msg_size = QEMU_ALIGN_UP(msg_size, 4);
 
     /* clear trRamWrap before writing to SMEM */
     dest = FIELD_DP64(dest, TR_RAM_WP_LOW, WRAP, 0);
 
     /*
-     * Fill with null bytes if we can't fit the packet in
+     * Fill with idle bytes if we can't fit the packet in
      * ramlimit, set wrap and write the packet in ramstart.
      */
     if (dest + msg_size > trencoder->ramsink_ramlimit) {
-        g_autofree uint8_t *null_packet = NULL;
-        uint8_t null_size = trencoder->ramsink_ramlimit - dest;
+        g_autofree uint8_t *idle_packet = NULL;
+        uint8_t idle_size = trencoder->ramsink_ramlimit - dest;
 
-        null_packet = g_malloc0(null_size);
-        cpu_physical_memory_write(dest, null_packet, null_size);
+        idle_packet = g_malloc0(idle_size);
+        if (trencoder->ntrace) {
+            /*
+             * RISC-V N-Trace 3.1. MSEO Sequences:
+             * idle bytes in N-Trace format are filled with 0xff, instead of zeroes
+             */
+            memset(idle_packet, 0xff, idle_size);
+        }
+        cpu_physical_memory_write(dest, idle_packet, idle_size);
 
         dest = trencoder->ramsink_ramstart;
         wrapped = true;

-- 
2.43.0


