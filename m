Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3D8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkfw-000637-Jx; Wed, 20 May 2026 13:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfI-0005Qe-O5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfH-0003xw-5p
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so74914115e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297900; x=1779902700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+grgVQ1tl9w2OeEn6YWxvhx5A0/R4CBcF6vOOesoEM=;
 b=VP+JDl678BOOEQvGTeN0G5LqEJPVNBEEbCQEt8fZeD5X9atvXrFkDyrXgbxPTqHCaI
 yFAq1Td4dVZd334l/lnBm2TP/u28B2uBdgLa8oKTfFEZh/QIwcucs2kPNV6gQu+b1RDv
 OpVoA2qzrES4OmGlICq/jljuwLwmd2Iy8xQfgEQ+tEr8FnryyaWtokkpiASCGjhsOFGT
 BpTosDt5nyAd/I5vFUx979z5XxLu9OoDe4QyUhiY7LOCG5c3Ye4aIYmfIkRSMbj04tFI
 lCi52NO+Qik6XreBjHDdBngGccqL2WHwnqCnW0HZzvafxosA15bsYxlaaPRiv673AoHD
 KS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297900; x=1779902700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J+grgVQ1tl9w2OeEn6YWxvhx5A0/R4CBcF6vOOesoEM=;
 b=r+ft9vmSVm4N9Wt4IxdUE0RrvK7UBRvxdFu+D0128ibBbhvwS+2VaP8ovvoNufmhK+
 T+DjL3gICR50MrOvcK4TqTTIq62YiZ4vXmrfmnZG7wLp6TDPj1T+Zdk1HygQFDfwEnhA
 peaMmWzRDvCUDCXPwqDRSXnnhY8uOtDLvIJpbbUi7UgAsapNToaolOxhMFgf0/9apsXL
 jv9WH9m62m/ZRR0R73b8x/pEmXk6/mwEEoVGcccQFjBEtxGhe/OZzp4fmuHoe05Kminv
 UxT79CxyGwNZBC9rp+5xde/Xab6UEqesbvk3BBExC9SSxF/O3FQXPriNyYmgJYJkhCX2
 +8AA==
X-Gm-Message-State: AOJu0YyxEBX0quRaSld7veHarKhDJCGZtzSntsi7ToIUnXa5fxP1jAEg
 PiGtx2uPgRRw4KQZF2Ovq7sgwbdASwkgdAqO5nkVAj4wFNwXvEW3FVJdjBSBr+3rrIOMvsKXTpa
 JdsyxkSc=
X-Gm-Gg: Acq92OGNFau6rTpb3O1lYbnLQTZZGk2crf3KeL0lqmKLFs+K/ohi26NTT3OXhz4xsbq
 yE4WS2GPp0iAgMVSBwyIoOnom1G8ZiXCHHKZFzSj/b/g4wIFJVpNAE4KVkCkIPtSlgDJBOx9/k0
 HhuiziF+K9OrpKopSRYyd10HSl/h8Vx7olRIARwRQfhBU7MNRdLAdruvHOcHYQjiIVkDK4zrJeN
 neCLtMqrGUIBFLC5RJla4nd6mjIAQKGtUVSrPpfufozGUjK9cdaYMuZjeluq3BzwiRoWXti+4yl
 fkWHD1khB/ewk70pn8OXoefQJ3vPSo7j7S5g/AKmIrlyq3PftxfqVDdI1CNRNqvufavEvTKXkRK
 aFNuNsP44wIjoaKbmODmmIYstyFQVpOtmkuHSWXcHRTjD6a/ZeUP/ba340oHXbQu+4zHR5kCNMI
 qahL6icohBSXBeyTNYRRRX0sjXuF6kk/jYpA4xRdvgIUt/LNlpYYFvB5U9qx/amz2fL9U9/WYb
X-Received: by 2002:a05:600c:4692:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48fe632661bmr404731035e9.19.1779297899950; 
 Wed, 20 May 2026 10:24:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d9eca8sm4920255e9.12.2026.05.20.10.24.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:24:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 14/24] target/mips: add Octeon SAAD instruction
Date: Wed, 20 May 2026 19:23:02 +0200
Message-ID: <20260520172313.23777-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: James Hilliard <james.hilliard1@gmail.com>

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de421..d77717cd507 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 33b45611f20..23748695a14 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -183,3 +183,4 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_32);
+TRANS(SAAD, trans_saa, MO_64);
-- 
2.53.0


