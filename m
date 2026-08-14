Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B99C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuso0-0005dr-5z; Fri, 14 Aug 2026 10:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wusny-0005da-JK
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 10:22:42 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wusnw-00073r-Uh
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 10:22:42 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5b0148201fbso914088e87.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786717359; x=1787322159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RRMfdgxEVVzbOl7prRPEfyfa94PseJB2tiTaRS3f1wM=;
 b=XlyXcwBQRXCtLVdV76nxnpLpYLA+ham6H/qDMNO/7Yp4M2vGc2byppfl2OKKToIFgL
 21j09wBiPFeqFQamdPhDTzOfzFM6S97xyVK5tWVb3Ghn/gQuzFHPmDSkeuEYk0lNCrjn
 JdBjKvsYBaQWWeQIhg1mbcw8kLMlchQY4T6VZKqW2q4xhD72rpoqtX9Pb7PCQFOwoRD8
 oc7rHOWlMmEZ+3YqiZb+O4LBbGtefOqYblkriutnZlLsnRCURECj/xRq6AVNaPbia8l4
 p/jHTbSBznPRa27hv9dIRrISw1qgXw14rXiC3dxUvfxVBM20IawRarifRpHvrHYAfcWB
 6itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786717359; x=1787322159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RRMfdgxEVVzbOl7prRPEfyfa94PseJB2tiTaRS3f1wM=;
 b=SQUf0MTZOaBp5y7pEH28MUnaFwa+brGgjeP5Dp+P0Ok/sINYUUbpPcIVkgrRP82oem
 fkqLh4HQeYhX8qy07J/y31n9DC4gqsN6AzC2Mjka+3Z5icm33QcobmJ+OKIaWLrYqwOg
 9cZHB9svxauQfCxS8nY7QUR4ZB/TytgAsuao07q5Wg2YP68ty5obKBxyL7DJ8asyGken
 HwgNhFzwzk/qLUrbl2vvfrLSJmETmQ80GtdBnq4ja6Ku3phd5fCCYa6xVXAnXNQgODO2
 perC5BuhUdQnY2zDeawbcNJoOItNb2HG/3guN51IaaeSi5z7TPCGLoa+I2Kb2rQRTFTL
 x2yw==
X-Gm-Message-State: AOJu0YxMlCHCp+ikHnpu4qkaiBFVZPgmFS7gxhXx6OunGiRYknxk1EFi
 s03XfDMQR7nZ35E/mZE/JTjZCj4YRvE9sw5FXnhtTPCBumD8RHi+dZ07VtWMEKvH
X-Gm-Gg: AR+sD12+RwX5DVlsKZjpxmjnLci3DI58BKGGzwz7htzvOk1N11q0xGv8l0Cmh2Q44si
 nAcNqOT2JjTfjHiIBxEBPCKVHNn06Hsnlbsm04cx856eYOUPOMRsn65r5jGwXmUw+XuvlYeBfJH
 6D2jR5tRYGVJ+Mk5lAa1rfDSNBpoWGPLpumXVB5Yna5uU2LktSz/CWz+45az+E5p/LpQZhFjB/g
 fU490xZjkmZtSYiwMMBPQPe2p/tn6IKuX7BulAdkVnMOCvbwf+A59BO9HQW8kaa4fi7dl63PeY9
 jqmgtfIzbn6TDeFTJNRI9nZuj4/y8YlTneakCnKZ6Z3JwthVVIZ/d3Qcf9nElYoG2qTFIIRSzIE
 B6CSMpX2hwK1axplBiOhFZdiaKz5iF5GTJiX71LSn1jr/Zj8LUbPdkPDaOmtw3XySadZIRsBQ3x
 hOAhh2Xnr4J9imrWInSx98ODiNDNOf2pxv9JrhBCU82JnVtwZeK0fNK5IX+wSn5aLUea4PzQ==
X-Received: by 2002:a05:6512:3da5:b0:5b4:5c5f:2ade with SMTP id
 2adb3069b0e04-5b45c5f2cd1mr558340e87.53.1786717358300; 
 Fri, 14 Aug 2026 07:22:38 -0700 (PDT)
Received: from gmail.com ([195.211.194.156]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b458beda99sm569721e87.41.2026.08.14.07.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:22:37 -0700 (PDT)
From: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Subject: [PATCH] accel/tcg: Allow overlapping reads in record_save
Date: Fri, 14 Aug 2026 17:21:59 +0300
Message-ID: <20260814142159.3800744-1-ilya.chichkov.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=ilya.chichkov.dev@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fixes: f9eaa1542b ("target/riscv: support atomic instruction fetch (Ziccif)")
Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
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


