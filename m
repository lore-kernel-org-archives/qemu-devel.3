Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197F9CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2d-0003uc-3V; Thu, 14 May 2026 13:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa18-0000tH-GJ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-0003uZ-V0
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:35 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7df05fc49e5so7754505a34.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780286; x=1779385086; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EqInbH82B6Q2gDUtmLQHdLzI7ZbG7RlwjdzKrCGvowA=;
 b=MelZyUNCzlVfRD3KwSRO8GXknwPIeZNuBazvev5u66Rfqz5kvYjJzvUARikf4rclRp
 f/0z8VOqRqEa0/tS+KkcmfBJyge7mt4MNA0CdzVF+f3dIr62kPE+RDAtGhk9aeXbF41W
 39RDbyXQnuQVSgGeAqlo9RcxhpLfOo5MJJwR6aZVT89AYHrnuqN0E+FunyvGFTecKw9f
 ACSaGgF/oAY6TYbRfN/1gqLUZNk0QU90lN8L+pnnjXYPsv3n83Iff0PWB+spSsNy71eD
 llrXDWzmezfONOZyxhas8Zo60ObCllHcwjrZRifQjzCex9o/S6/zlB8REOIiGOZ9ClM7
 I37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780286; x=1779385086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EqInbH82B6Q2gDUtmLQHdLzI7ZbG7RlwjdzKrCGvowA=;
 b=jMpYTW7sIDE6hpjwiteNgmnPkfelVW6EYDZ9dL/Cpipi2n2GAqcP+qBzV0WDg0D9D8
 d+EE8feNCtWAoZe3UwkglKfaagjsL/5PhHZD76nZWY9P+9xaIZfvDfv4PMiNcc2mi0A1
 SDefOENRBgmnlM9cl5uBF3xsrASr40ePZDsewsAJJuUm8RXFThmdoLu0QVvmO8Tkr1r5
 kL4w8sv17JichpfVV7aaEnNkOjvssEnE5dHDML7u6k9zZXeOHRiZcW42DNHEZ+uAujHK
 3EabYdRBMK5TBZMuF+RDsHd0zuL1KhHLv+B0oj+TSoW17YKMHtuyqStotQxfFZ2jjgVz
 R/uA==
X-Gm-Message-State: AOJu0YyW9OnKQnAE85dsiylLOXBj5VNxqLMJhcaYPuxFQwC2zhOfR8KI
 n3qmfBDboM69E4wCOyYNtr+nlbAok8qUK5aFhg02M+xdCMVo+SSxVmFh
X-Gm-Gg: Acq92OFAdGcLCS6jhMIhQ2Gl3ggbB1rIehx1eogliyVJgmkPctF0Txcy9YKWKENRYk1
 3nWf2I8axZSJK+3zoZ1ljFWuZbLBIe2mK62bBU1otB94Aly5WfrbaBKddcddL87S2/vA0cIEReu
 3j28wxiXVB0II/O2nXVVDvNyb09Vt85KvInqBoYTqeJmkEgxs0fJBIhU0sYwZQ2T3is8QPdmFDz
 tVUgX44IUwJ2qRjMgz06MN4lULo9aWo50kqRS2myoF1JQ93a7ADBDwxWttuNTmlb9wGh0wk2vkM
 549iwhm6XsSLN17GxK6ZlM4Sf/736efPBiFRxFZA+5sXT3g2ppJeYBX7Z2etjm5fQ+3kfK1bZSb
 VLbWk/fAwDGVV5+L2oFDxmm9EyDaSMxwoVfHlqk0EZzajQsUgPGP4MQ0hu0qEG2MTscwhBuIQwU
 /hsp6uJdX9LHyR3Flr/HQd20T5oJcSc120Tk1UtGhXDuRw86sdLIW+cYl9TbADDCSC8pD3QAAaZ
 ldnf/kgY6l41DvjWlrObsLyj6S07Do4ea9Q/h8uVkZno2rDd1mebZq2+oEqDDrCo7LS1oZxkn6b
 oFA=
X-Received: by 2002:a05:6820:221e:b0:694:8428:dfd8 with SMTP id
 006d021491bc7-69c9436b0c7mr284355eaf.34.1778780286501; 
 Thu, 14 May 2026 10:38:06 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:02 -0600
Subject: [PATCH v7 13/35] target/mips: add Octeon ZCBT instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-13-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32b.google.com
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

ZCBT has the same user-mode memory effect as ZCB for QEMU's purposes.

Reuse the ZCB translator so both cache-block-zero forms clear the
containing 128-byte line.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Fold ZCB and ZCBT into a single decodetree wildcard entry instead of
    using a duplicate entry with a selector comment.  (suggested by Philippe
    Mathieu-Daudé)

Changes v2 -> v3:
  - Split ZCBT out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v4 -> v5:
  - Fold ZCBT into the ZCB decodetree entry with a selector comment
    instead of adding a separate translator thunk.  (suggested by Richard
    Henderson)
---
 target/mips/tcg/octeon.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d8a1bfce77..01ed3b50be 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,7 +50,7 @@ SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &zcb         base
-ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx

-- 
2.54.0


