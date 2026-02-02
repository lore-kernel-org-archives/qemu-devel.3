Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABEDE7FDEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1YQ-0004w8-Gv; Mon, 02 Feb 2026 16:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1YP-0004vu-J8
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:33:53 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1YO-0001uF-4Q
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:33:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so49608945e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770068030; x=1770672830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ncliO2Y2RM1oHZsROrtZDG+hcxy9e4ipUfraRWJKNj4=;
 b=mkod/vNq4YZMNmDK+ZyzPCjy+BEhAj/DJYz5CWyuCd4zK4ayfVJDqvuXcGG+ij8cZv
 hM2VAIftTo1BTqt17MJqMyYK30ZNrSoiNkw14v/mW6SA/AcglwUOC5qnheXcoqCjgV4f
 sew/EBgRPcYcy2bAd/xKIF0cIMuhqChQo3pmTTmAiqR3PINX+waybFkufZS/VQE03b2F
 D45pdIL6+ba1h9ZfBQ7dbDTc2NWabCzRf3B3/Jz1fKguXPlO+UdRNpEv2t0bbRpebQlx
 kAuF9F10ZOtPogD7dt48atXUNGijaqc40upAuWvm3XMsVMNkGmCHVGKiSZyO0NZvx0W/
 oAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770068030; x=1770672830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncliO2Y2RM1oHZsROrtZDG+hcxy9e4ipUfraRWJKNj4=;
 b=eRK8vsD9Gne2/PoiO7pLq9EdJs5NCAwKKxy/fj/8E57LvrQ03W1tdw8czTu23xaDlP
 KNciR/WsaWykZujAvPkgn9v2ndLrYivsZxQx8/CywMS9XSdQZP7CNUqaDZLOFlrz4+1H
 tkukIjn3f52V1cSOuuK9fwAk/kKMuAGZUsO1f8yG2MSF98UTEXmPc9t1L3uUhcEmJZEN
 n9tie9r3owDjZHrnFyeIyS3T8Yr4XRL9DsjWErF0TcFjVu0XEmb06DUz2ER/rzy8DFc3
 eBSwya2I1IMd+J8vrt1LrAulcZJjRtqTOJJLSmBQLvSRTVVwcyvWC1Uy+C35eKTQrP6y
 1SiQ==
X-Gm-Message-State: AOJu0Yw4yoVGx+/yospHwAkK9ghg9S7ZG+EidjFnpljZFTKiVp1JYwYN
 EF5n7kNTiWaxT4zAwR3VINfMF7aB2pNeUZFKBHpcWaAgBiwpAtFvInZnK8eEH6mGSshitXh9g7t
 BJiqWHy8=
X-Gm-Gg: AZuq6aJ0QVpRlGALK9LtHDz1kGTj//w4E/+i/FvvZlxFXvBWsQiUMLAPeWquAZgNOtG
 SvCqEWNgFFTgnj0uKFIyK2MomGKRmN9O54UjgvPFOw67QBfA4MECVMq4YBWftyEPDzYoJHnsX5I
 4saXc9vVq9LeI2otY5ffoVyAiFNw6IBQ1bFpZoWwPhpcjjkmPNzv+QKNi5E4mAcTnhWo+1v/Qj9
 13kDo0nW9c7UURlZdQOjX0h9FChlXCcKU6f8pjEuu2J4N0q3YlbtZRQfMUV5i1sHJ6b/JeMab0h
 sGleDI1zBzZtsdiT6bxTFYkwPmC2ylcDHn2vtwKrAzjAGTWe8gFtszMrCmy08kZZWWIiQVFZJUh
 aoYju3KDrZbKTo7NhSPj7b86apVSSpFr4OoGNsm7K730kzHwgmf3RAUaw3npU/9VSEcpHpnVZay
 wRBRzSbMEcnRfZT7RvXBlR5EqC0NFpOZVT0UBj3yCMk1Jip5ja3JpEZdxoesI8
X-Received: by 2002:a05:6000:2dc9:b0:435:a287:82c with SMTP id
 ffacd0b85a97d-435f3a81d83mr19077055f8f.1.1770068030227; 
 Mon, 02 Feb 2026 13:33:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfccsm44915286f8f.17.2026.02.02.13.33.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:33:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/i386: Inline translator_ld[uw,l,q]() calls
Date: Mon,  2 Feb 2026 22:33:48 +0100
Message-ID: <20260202213348.96754-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In preparation of removing the translator_ld[uw,l,q]() methods,
inline them for the x86 targets, expanding MO_TE -> MO_LE since
the architecture uses little endian order.

Mechanical change using the following Coccinelle 'spatch' script:

    @@
    expression env, db, pc, do_swap;
    @@
    (
    - translator_lduw(env, db, pc)
    + translator_lduw_end(env, db, pc, MO_LE)
    |
    - translator_ldl(env, db, pc)
    + translator_ldl_end(env, db, pc, MO_LE)
    |
    - translator_ldq(env, db, pc)
    + translator_ldq_end(env, db, pc, MO_LE)
    )

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/decode-new.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 086a3bcec18..bc105aab9ea 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -315,18 +315,18 @@ static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
 
 static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
 {
-    return translator_lduw(env, &s->base, advance_pc(env, s, 2));
+    return translator_lduw_end(env, &s->base, advance_pc(env, s, 2), MO_LE);
 }
 
 static inline uint32_t x86_ldl_code(CPUX86State *env, DisasContext *s)
 {
-    return translator_ldl(env, &s->base, advance_pc(env, s, 4));
+    return translator_ldl_end(env, &s->base, advance_pc(env, s, 4), MO_LE);
 }
 
 #ifdef TARGET_X86_64
 static inline uint64_t x86_ldq_code(CPUX86State *env, DisasContext *s)
 {
-    return translator_ldq(env, &s->base, advance_pc(env, s, 8));
+    return translator_ldq_end(env, &s->base, advance_pc(env, s, 8), MO_LE);
 }
 #endif
 
-- 
2.52.0


