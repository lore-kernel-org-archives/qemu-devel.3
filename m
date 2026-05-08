Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638F6CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMu6-0003hi-G6; Fri, 08 May 2026 11:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtE-0002gY-QJ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:22 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtC-0001k0-LD
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:19 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so918990fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253197; x=1778857997; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UY10vnoVBseLXfCKE/RTPCDzD7LtxNgrrQE0jMkHMdI=;
 b=sCs09toA/eg4XXmc79qDenApKo6icRY6iloegTEM9YI6Hu9ZZyib+vQ4WA0Enk84Pr
 c4XSyOiyKODC/cxwARvr2Mo4OFfV4DzT6spSuZRaNNa03XB7zFQT/fl0xXiZzQwuLOXU
 WT+V9FU31kd0w3DpNqekDUe38WIrG4C6L60BkXAqDybrlYFRSXseGem5LNtvitpkZ+tB
 8CajvTW3aAmjTOyebKr0McV3B1hyBg8wQAKUQUdWwk0msB1Om/AoYnY1COlUwYXSZ5SO
 0ztKDJ95q6TVbr3U4Eq8+otPwlNqdndJAFzmfnvjls4O0n7uDUK+28b6an++AeS3A5PZ
 TfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253197; x=1778857997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UY10vnoVBseLXfCKE/RTPCDzD7LtxNgrrQE0jMkHMdI=;
 b=LNA86CBYI2M3lA3FyNEeWOAfbGmsFnT05ySVYUDOvV67Zgt0CKvyBed9UYhhbsqLcB
 XENv/h1RIxYEO5ahEF2MBHmVJU7pao4Q0ASIn1CkfjTHMAz3KX3QP2LRKn3cS/VKpeXy
 WfKINcXHD+jJlc3RWYogK8ZsqZLYGEv88+AbNzUwhXeLyH6q2b9c/Ux6DkRclNf0cyC7
 ZlDdtukmGWy/un6vx2yH8IbVZ+UTff72Vg68yAlgJpK+tXI0y9fZxcEVGz2USKqeMK+9
 PR5jorj39tZ9Bb1c2vtPhzlWenWnktvG0Wx1XUA7n5jhB/VGGgkn3RCQS+GuqmexT7fe
 CYUw==
X-Gm-Message-State: AOJu0YymUDESAHSer7QWuA0VEpjJP37mzYz+T4AtcGlHf2/8J9aN07aX
 f18bmQUw9dlsfIOeV1F/jaFx1i7/6DbRwT+KimKs088BxLwzSCLSGhZvOLj/6g==
X-Gm-Gg: Acq92OHDJTMtlT28hXxgreZrKddWdLNSeBo6xjjDA/59bv948glvrW76DMAvE6wsuS5
 Ln1FBoa2xktFU716tVY4ZwbzFr29oDCacYJXL94j/+k8iDIIDrlNjFyCrl7t7+rSTYf+zF51pEt
 EzhE/nChHE8SoD31L1oA8OqhNsQWtzcqsS8zgUPsD+JVmJSRjQ4+yYJTFpBNtI/m67acJMkC+hK
 mjXFMIDstD38QWwk9WKyvB8G+Tri4XMnEsyVpb+I1rh1j26ms+q18gH/2y3uMzuozCriN4hHR9Q
 w2E5AcZTUh1cyOmjE7CeAJCEN8tA7UPeNV4WE0mG+mKxNSiBzoKfoAaa9eJyXcljeQjBCwr9Sg2
 bA90tcDhFKUha7N8Wv3D7QLot0XP95Kd0B0nLcQb0hrY2rOtZ3RHeVJ6PLEr0fOPCYwxjfP8aGj
 Bm4uu/w/u+I6HvrtH8vc/D7/Xa2lFhi302TuLXK169DASBOfLuBkUGLF2uBXE/aKaJiYnE2Co1k
 8uwWCEYcroDqZPwCCD6qnVBsFu366gb+SEOyYh9c2MsxdkMbpZDfR3DbNMz0LZ76gyp6z5DJv0S
 ijG6KZfuK8L0QLHakuqt4FjUr3Sls/HNjw97zLXNluma0a55+YE0Eskt3lh3KksanW2zSz7KP2B
 ANiF0RQ==
X-Received: by 2002:a05:6870:2c99:b0:41c:fdd7:5b4d with SMTP id
 586e51a60fabf-434f64f1577mr8230862fac.19.1778253196973; 
 Fri, 08 May 2026 08:13:16 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:19 -0600
Subject: [PATCH v3 19/32] target/mips: add Octeon MTM1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-19-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x32.google.com
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

MTM1 loads the middle multiplier operand pair from rs/rt into MPL[1] and
MPL[4].

Like the other MTM writes, it resets partial products so the following
multiplier operation starts from the newly programmed operand state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM1 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 165cd5088f..82d0410e6c 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
+MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 809a4ae70c..74533014d6 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -291,6 +291,7 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


