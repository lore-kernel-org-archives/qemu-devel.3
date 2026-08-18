Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF93C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCS-0007O3-CA; Tue, 18 Aug 2026 13:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCQ-0007Mq-Gs
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCO-0004dd-AN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso173311b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072523; x=1787677323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SWiOSCQHprs0gfSUIQ9TNVGn1jj3jaoW2kL+5yWHbRk=;
 b=IaGyoolHKsXKFc/1Q9WmSveLqJleLljPqJhcptWg01WPjx+1k62xdB1InjlyrLT3EV
 9CYWOlP0c8kVc1xxIAirQRXupDKpyRdlwQDs1Rwj+WR3bhNnlNAqBitM2eSgiBsMujDt
 QbHrphtYN25Vf3i7MgKTgSWlEkL+Ven54CYrM+qAmLNKQCeTn0WQGBDWPZfp4x6sY9XQ
 CyvKiko0RKT6T38qsypcIizk6aLDAgpm11WhF5L0IVwqScbbmE7YZtln5wKXNrpLwVDp
 WTB0VZonYw+Po+ju1b4CRHCTXV0dcAnomh79/LpUAHbe55m59vLvlRhQfSmthuFr2AG+
 WUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072523; x=1787677323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SWiOSCQHprs0gfSUIQ9TNVGn1jj3jaoW2kL+5yWHbRk=;
 b=S7cnVObAoWKW/CRKtT/TNnMVgcrtVXQ90456+/AFGssiQTsK1F0bWrpaa4f77Ld70Q
 o2cjsi3ndP/5Q4vX230RETiV+QzQKtoMSmp3YekQXZzKHzN6BiMJPXdZWn+XwVA4X4x9
 CDYiTZLrcQXSUx4qi00UZUP6Fdanv9B4A2M2uLL8TlcImVnlP64I3msjcE2tzdMaKjhJ
 kS1QjAKlveGZxXRil0yjckZ53rWQ7ZlImTFiGhmlGQrq5KQXxlXRCoZC5PGqn/pUCVbn
 MF4lGqGh4FQ5xUTC1/5e51sgzAoaVO7QV0Ab8/kuOYe4AKwR6hG4tSv0/sO4kJELtKaf
 jAoQ==
X-Gm-Message-State: AOJu0YxmCtza0Oqk2rD7cU5oR3ZSAxcsEzA2ZpWK3kVEHrcUZXVMshBZ
 oQ2NEKrIj6iL04UnPx07cZE0svSTPD/BQDRxCiyUzFgNdfJQpuFrRtu0CaSAeX5VFq5c4xDsPW0
 HRIshUuo=
X-Gm-Gg: AR+sD12zDT7kpLyzG0Ko/xQGnD5WxVXFPOF6dwQvvWnmpU9WMjJCxYylHW+iKxBB458
 jA9hgE+J7M/lvvVnMl3l/JioFbeucwA6QaZlF/soNHf5fdPQ5QmpigjINkZJxWdKAIHANi9HRJa
 v5i61r7VstyZgz6Tn9y1aaGz7QQLxJatUOOhk9y6d2HRqrgedUYk1JN1tL8aW2BcumSBH//WY1v
 nU2JBXrIWF8K82PFKMd7b4nNaag3CQuQrb/XQnd+3P39c/ltYGQV4cNZKBla44h/jNrp0eGuaJl
 zgznon4xOgMh+R9F5/c5hFJL+6iuo54FiSluuALS0XCaoTd0+gBA7iadHXrv1/eA4ro3ou7rGxA
 qpK1ZZ6aHUkWVBbInL+MqIPzDBytFCI9CUP5Dx6rIe7q1MwNbVfKM/OWVlWWz1LwMcOfGV9nY2x
 F/8+RHkkaFtSroPafS16ckHM8CuDHN1A4VYIzGrRlzw5tCVyN5AVMZv2rt3NFuM7jbamlDCjiT2
 YNVVXgQr+HfJAJ9pu12jEPMebMPO6GAsjE=
X-Received: by 2002:a05:6a00:448e:b0:848:42d0:bc91 with SMTP id
 d2e1a72fcca58-851b87d91a5mr14728823b3a.12.1787072522643; 
 Tue, 18 Aug 2026 10:02:02 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Chichkov <ilya.chichkov.dev@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 03/38] accel/tcg: Allow overlapping reads in record_save
Date: Tue, 18 Aug 2026 10:01:20 -0700
Message-ID: <20260818170155.1907006-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

From: Ilya Chichkov <ilya.chichkov.dev@gmail.com>

record_save() assumed that a target reads the bytes of an insn as a
strictly ascending sequence of adjacent chunks, and asserted that each
read begins exactly where the previous one ended.

That assumption no longer holds for riscv.  Since f9eaa1542b
("target/riscv: support atomic instruction fetch (Ziccif)"),
decode_opc() loads a full aligned word whenever pc is 4-byte aligned,
even when the insn turns out to be a 2-byte compressed one, so the
record may already hold bytes past the end of the insn being
translated.  When such a compressed insn sits at page offset 0xffc,
pc_next becomes 0xffe, which is within MAX_INSN_LEN of the end of the
page, and riscv_tr_translate_insn() probes the next insn to decide
whether it would cross the page boundary.  That probe reads at offset
2 while the record already covers [0,4), and the assert fires:

  qemu-system-riscv32: accel/tcg/translator.c:395: record_save:
  Assertion `offset == db->record_start + db->record_len' failed.

record_save() is only reached when the insn is fetched from MMIO, so
this is visible on boards that execute code from a region created with
memory_region_init_io(), such as an XIP flash window mapped over a
serial flash controller.

Both sides of the collision are correct: the wide fetch is required for
Ziccif atomicity, and the probe is required for correct fault reporting
at a page boundary, per 00c07344fa ("target/riscv: Make translator stop
before the end of a page").  Unlike a86d3352ab ("target/riscv: do not
use translator_ldl in opcode_at"), where a non-translation caller had
no business using translator_ld*, the probe here is a genuine
translation read whose bytes must be recorded.

Relax the invariant instead.  Keep requiring that a read neither moves
backwards nor leaves a gap, but let a read overlapping the recorded
range extend it only by the bytes past its end.

Cc: qemu-stable@nongnu.org
Fixes: f9eaa1542b ("target/riscv: support atomic instruction fetch (Ziccif)")
Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260814142159.3800744-1-ilya.chichkov.dev@gmail.com>
---
 accel/tcg/translator.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index cd7d079fe0..57daded60f 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -387,14 +387,22 @@ static void record_save(DisasContextBase *db, vaddr pc,
      * Either the first or second page may be I/O.  If it is the second,
      * then the first byte we need to record will be at a non-zero offset.
      * In either case, we should not need to record but a single insn.
+     *
+     * A read may re-read bytes that are already recorded: a target may
+     * fetch a whole aligned word to decode an insn (e.g. riscv Ziccif),
+     * then probe the following insn, which lies within that same word.
+     * Such a read extends the record only by the bytes past its end.
      */
     if (db->record_len == 0) {
         db->record_start = offset;
         db->record_len = size;
     } else {
-        assert(offset == db->record_start + db->record_len);
-        assert(db->record_len + size <= sizeof(db->record));
-        db->record_len += size;
+        int end = offset - db->record_start + size;
+
+        assert(offset >= db->record_start);
+        assert(offset <= db->record_start + db->record_len);
+        assert(end <= sizeof(db->record));
+        db->record_len = MAX(db->record_len, end);
     }
 
     memcpy(db->record + (offset - db->record_start), from, size);
-- 
2.43.0


