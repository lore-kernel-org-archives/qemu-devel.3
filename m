Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED99CD37A7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtU-0002lh-8h; Fri, 08 May 2026 11:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt8-0002ey-QG
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:14 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt7-0001ha-DQ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:14 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso1679021fac.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253192; x=1778857992; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K3ojpg58r0+Ylc8ZgO1Nz1kHZAQgozXy6HlS1Oz1uXE=;
 b=CcMhBGtNAkDOHpqQirA3jSMuJty/PFN2DAxY535N0LXYTCnCoPpCxJj0F2y8k4HhRs
 iO+zRfkd36wvNM0DGVk7LZbTZR6ZruR3y891MlcGEI8re2vwJnkZVx+eVOJiPHiruKcs
 TQKRIwi5CBEekn13J0hzJ2eXeTVe9GDzb8jAf5hMxdc743Y7YJ3yWV3JnrTZoe2hcOXz
 y2bBSkWa8Y5bZ9wab59x9lOUjfN3xqgoYsyrb38PIHycx80fH68uwBJAgZny/p5tloWm
 BPdBZUPwz/6ZK5RypCVhBUn4CLRVVtOqOjKK+qc/n8OvMwrJiAu+CDdxh4RuZsg2VGJ+
 iWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253192; x=1778857992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K3ojpg58r0+Ylc8ZgO1Nz1kHZAQgozXy6HlS1Oz1uXE=;
 b=eAtqh01F6ZVyAuPhsrr65ISJ2d7tAjzcc+Q8DQ+8Erz197/M+f9vYBRXok/Hp6N5T3
 OJEy2F+MxZPfsTvz7/7jKKueCHMsdChJbcqzfWcS3oklWZ/MG4dss+mteEKJW4bj9qCq
 l6gxoFRhoEdWH14XcYa9+xEylO35UAKXTB7kp/ZQN2Nz70Xcrqs+doXtF331krSlqMJT
 N9648+a0EwNFPPWiOY9CjTphZOle9WRdAIHZsdTw9KRzhcu5xUyz7zTfuNo0uxrXt2al
 aWXSIjMATJFs0tOAx1rf9oilQGnQ9C1/zBp3koPE4o78lKc0o45bB9DfIMWR3ld2Zod5
 TwrA==
X-Gm-Message-State: AOJu0YyI521KW3a2A/DIEcW8UNerYFpixzvWZzgw52MA10jjzHGktYVN
 kekL4+9G4r/HK6f62A6isLOOUa2JB2Aif1m6jidjVoZ/PdSHS/YA29W/J87tNw==
X-Gm-Gg: AeBDieuj08kJgQOOMPssaCPv+9oJ4+F4/21BsQuxAFwT5PXwocnRM7ibHvnz+hYcsd5
 lXfN/8FQrF3bA8p61BZFjIRw53FQSMH4aNlK+3lvg99sDqgvluzZ80oYZHlSV4V8N2wp38z+o0C
 ZdHsvOod5shQ8E4GcGsD+FbxIzOk3UdPi3zyMd3Kt+wAfnC9/Q82nEFbJ1kN3uzJ3ktkcqN2Y4x
 aZ8/I6MDgEeQWTl3Vpdlozgy1jLnSPM0DWBQY4gSQFrA+/oBw6Ff5Xp5QuAXPeuk4+G+2i4+xRw
 H29ncJvLOJLjLn6jL9DcbZuDpeoHiEJTzaBMfD7hR+X8lBKe0DS3bfbEYcm9aV6j+7+pHGEpIlH
 zYEMJ+EmrWbXs7V/Hu696JBNUgStiA7LM+osVHJQdFmbgJ3iPAI9G65KMXdR3SHVaIz51Mr+IUu
 Oxje/+L7U0er3v7xEcGENk/iusRgiOZd/gaYehviSBJPiC2rrKqGJfpP5/3UrKzdUfq4yTSkLgb
 E3IWZEMdGdfROUsfdCFQIo6jXacZ6qdb2TRbZmNIvw5n/LNab71/tQicox1VwHOUR9fJrGgp/EN
 2jyHCmASSuL+YDudrM5W2VnGuFYvBNgvdgkbl06LWw+9NBX01IuGn11m2jwLp3zA1oAHJp67sOM
 lbBsOVw==
X-Received: by 2002:a05:6870:4208:b0:42f:b718:a9b2 with SMTP id
 586e51a60fabf-434f6760c15mr8790282fac.39.1778253192009; 
 Fri, 08 May 2026 08:13:12 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:14 -0600
Subject: [PATCH v3 14/32] target/mips: add Octeon ZCBT instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-14-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x30.google.com
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

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split ZCBT out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d8a1bfce77..56c54e0973 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,7 @@ SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &zcb         base
 ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index c2a3eae134..f94f765055 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -211,6 +211,11 @@ static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
     return true;
 }
 
+static bool trans_ZCBT(DisasContext *ctx, arg_zcb *a)
+{
+    return trans_ZCB(ctx, a);
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);

-- 
2.54.0


