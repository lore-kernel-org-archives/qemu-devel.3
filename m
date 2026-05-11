Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FE1CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI9-0005YX-Nc; Mon, 11 May 2026 14:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHs-0004vo-Dt
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:29 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHq-0002ya-8O
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:27 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-479d9b155deso1649100b6e.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523805; x=1779128605; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=OsrWuSW7MX+XFOu2rUa0WSTmVObn/NAFuCzWb8Hqv3sxZLA/HhJbzHFCmCtJL57rkg
 W5h8lq1vX1NI/jLZalgk09Y13zWmSvhuys1ExjoI871htt7D6DSDZhSGZVHnBfY2tLsp
 lvRAu85yrL2VLyAeD+HHRRVei2uCtvE1KmoqjQBVmDkpQK6sq93M7vATavFY9Kz4LnTD
 c/ob1/HvUw9N1llfmQ1FZ04T/UcVJShxXWmXBlC/0Ce4vj7mKBM1IeMHE+z6dYEiyDUl
 cpE7Qh9y0AX1jbW/q90yp1cQd5Cpysurk00ImrePsTvRmGF9I1xCGGP7sH4gsLg3bKTk
 2W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523805; x=1779128605;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hJekX8dH52yMvYykB5HOFELCbhNNSoNRaiTZ7e0Y8tM=;
 b=a8xNK+NNgLtxVrfgIizcXWgOQ91A7NqxWIgO35qFYsB417n3akSee02KtuyaOh9nQM
 qcvi9lM7IgPJ+RE1wO1TE0DrRIUjQXABy8jvhtrAGOxpSYdZuzxbX2eMemeaeD5zQr4W
 7Ffkismwjt+we8VE0IgtiT13DIMzDP3BMq3UQUarqAkW2D0zr62hrXJE+tbVDQaeNWsc
 +9cLBBqanU1WxXIFn/YO7Oi2IiO4oVnTip5lBlAxglQQx5O7mqarYyOTW7VvqnfOpo6D
 BQrBKMrooZnLeXnlheNcYQHSDPU5TFncb/L8FNFACv8tHBogjQcWsrfjFW1r7TJeDOdk
 DsWA==
X-Gm-Message-State: AOJu0YxDhHWsK4lptysnkpnTQ4LFalyuZlEGyXObK2RSHjP+Wxp5YonR
 xWPu8ikEgT3zZZJWFmaMoGywxjLwzbD8I7v8AM9m45K2qow0/NoWPh4R
X-Gm-Gg: Acq92OGJnCiWdgDk6Yzqq6O+GlodYnW0v3IvvdtIKrVbM+VXZqf/ftxFKDJPCVyhOfd
 4KKP6gz2WK/zaJmzxP7TLJKGyfqP+Ku2sSaB2wSWQRt1ArGDTd5sLEekrySgexjA6/guDD/OUwQ
 U1/9nV0vnjqwkeBTFZS44AWhaTaMrEzi1QbG7xgTfK4G+z1AylfRL60/5Y5xb2HXpYC/iPyJ+Jz
 pRWF0jb7LXjzXxTdMjKuOeObga/GIO0zFvFoR1yi/NH7wxBwW17URic4Llw3VN4FQB1QfjmRyUB
 zlfI022Yts9bMHsi7z6SEdSykJVJpFaV8J17ye2mJ9rDqwrRR9vJy0zKw/BjOQ+6VbtGvVKwXzI
 IHKAqF+yPesVuvF/DbqcpsoR+gfNG1qEwh+OhFXK3oHzKs71psKLRxtn+bc6M8Zsj0e1mWPmk+Y
 UINS4XHnhw9LT6SKokTPmi11VZ+P+Q0iRg/EMtCWSRNBVIFH7H3Z5GRu8w6sf2M3OzFKX4h2C0i
 HTiDZZbYdyfeUgWzPcMG8ii8zga6dkabqgjS2602jUhi60Y25dqNKqXuTPFmXNU/ea7
X-Received: by 2002:a05:6808:1481:b0:467:a44:dddd with SMTP id
 5614622812f47-480425a7060mr14459220b6e.47.1778523804709; 
 Mon, 11 May 2026 11:23:24 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:23:06 -0600
Subject: [PATCH v6 35/35] target/mips: expose Octeon68XX floating-point support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-35-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x234.google.com
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

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and
use CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v1 -> v2:
  - Move this CPU-model correction into a separate final patch.
    (suggested by Philippe Mathieu-Daudé)
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index faefab0473..cc1916232f 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,

-- 
2.54.0


