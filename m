Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E07C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqI2-0004mc-Ck; Tue, 25 Aug 2026 08:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqI0-0004lr-Az
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHy-0000Re-Ij
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787661001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ne7T8Aqgahxe/jZvtSSKRCWy+jh7XQ1vqlcwBgfQ2l8=;
 b=ffX1twfMAMX8zU1uepO14ZRDQhK6zZdfq8HnFKOeOVtaP/yxubOr2Uf/yvZtgv8QJTZdDY
 L2Y3n87NAskeN+f9ICOzeXWIUTmMXg7pSuUNc/Y1jZGyUGyvCR9EEArY5E10Z3JI/+eQaY
 m4E9mB4SAn5lKKSR4KV/AuibEdpmG54=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-0avaKfOdPv-Rn8jfv4ro3Q-1; Tue, 25 Aug 2026 08:29:59 -0400
X-MC-Unique: 0avaKfOdPv-Rn8jfv4ro3Q-1
X-Mimecast-MFC-AGG-ID: 0avaKfOdPv-Rn8jfv4ro3Q_1787660998
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c1f548718d0so502909166b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660998; x=1788265798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ne7T8Aqgahxe/jZvtSSKRCWy+jh7XQ1vqlcwBgfQ2l8=;
 b=bmUqBDrfmcss/2e3SDgAQPNxeltSQ7OoC6bjjKrpJq10Iyj5JKEimh1hVOn/xpk2bD
 B4pEMRalycumv97uNafju9x7Mc5kF2ksjDjgx46Kc+D82vLBH0/D3C9cTiBlphwnC+Dr
 ERUcT1L7ovynV0oORJZYxQT95/H9dximR/S4aDhpGjWGN0Djx7M2ZHpgwChH7rK2sJgb
 QkPayaj+yHJEW14IZHBfyj0+SqAbVNzvwj3AgVRZtM3vzmQkedePyRBvq4xBZVQj0DQ2
 /BMjpOMM8+wCP7Avor3V4PawTugUK1lC4xhwmWSfpq2gMPVCTovGRKb9Kyj0hRLSsUz2
 rhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660998; x=1788265798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ne7T8Aqgahxe/jZvtSSKRCWy+jh7XQ1vqlcwBgfQ2l8=;
 b=pzfncTOAU1L4J2ZUv0mk04EIFLTlJFyzzFoxc5sZFk652cI1zlN7c/A6VNy+t4bMcu
 xG0MoR6pfklrW9hqP+lH9wdFlLFri0KpQB1xfozFVDlpJJMwvVLsmKCQ+ZaojQ6FfD6n
 Dx8fAJmqfp695okEtCe6CLlQ/iBa5wPUKCPcPe/cbpMqDoJ6ETk6hZGPelBNlSjC2T5Z
 uMF3GbdL5UO/O8vA4uCFnLxHFF4FkdSl/fmZAbWLKsWvVHE8LJSfbWvMSsjPL+M3USIT
 GQ39kDfSryPZ/hEGyJNUVidWRWIg00kKMCHRfWbZ8rTEnhlATh5BUmlm/0V1Z30DT4cz
 prRQ==
X-Gm-Message-State: AFuF++l0m70dXAqcr2b2/6UxoQRUII9BNAUgRFdn0leHeFK7P2s/4v9J
 ULruDe9xrzNP/KbL9LqXh3VUSdnPXbANweIRvNlt6iaZrkVCnDqvX8951EZ38KtcwIALWMCGa7r
 D8BcNYwAM2Z7uPq3HhCKNmTTQQK0jIaArVhL7JXQOsnvSP1P+h8CDmXM3jekJEZNMjCx/8qWnUU
 o0FFyPK83N0hfHqclqEnyL5I0+Cjj15CE8PNPlStV/
X-Gm-Gg: AR+sD10uikK5NYrg3C5rxV8cTX7fdug4/pufG+IZ0bFCb7bSht3RmpYR8XZzTrfoAvG
 fXKAwScs00XzAm4tufVPPrhNYRANS9/z9Nkpp7I2h218mUijIw+3F8jMA3Lo4gUHwHhs/UItLjO
 wNSrVk5GPmrlrwGyjSQNfep4PPD3lOcnco1VK8gE1rCp0jAYoCi930YHONQff8mHpEUPbsRYaA+
 +/cCWtPQVNCwpkECcnJrMWf78lvBirZ9XHPrE/DBYeyM/lb3JJQsx+tYCZ5b7rntlyprWjHOpYA
 cFcIYcqHu8gWCj8WXAypuA+ohEtMYEckHJNjtUeXT8Q1fjbLHszezwKjsVTOhXOgwEcNNjYgu1A
 qXgQhNqZBw+9QJJx3fSt6jsQoabtEYX0bwOxf3NWm4AgJ8T2O7BmPpzGsD5cIHttpHT87LEwvkC
 X7GA==
X-Received: by 2002:a17:907:6090:b0:c12:695b:8876 with SMTP id
 a640c23a62f3a-c24e5c8b8ccmr651396766b.5.1787660998158; 
 Tue, 25 Aug 2026 05:29:58 -0700 (PDT)
X-Received: by 2002:a17:907:6090:b0:c12:695b:8876 with SMTP id
 a640c23a62f3a-c24e5c8b8ccmr651384166b.5.1787660997566; 
 Tue, 25 Aug 2026 05:29:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24dfd91dd4sm467146166b.16.2026.08.25.05.29.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/20] target/i386/tcg: add ZU writeback
Date: Tue, 25 Aug 2026 14:29:16 +0200
Message-ID: <20260825122921.431739-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 3 +++
 target/i386/tcg/decode-new.c.inc | 4 ++++
 target/i386/tcg/emit.c.inc       | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 4998712e86d..8650b5ae7a0 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -212,6 +212,9 @@ typedef enum X86InsnSpecial {
      */
     X86_SPECIAL_Op0_Rd,
 
+    /* ZU-modified APX instruction.  */
+    X86_SPECIAL_Op0_ZU,
+
     /*
      * Ry/Mb in the manual (PINSRB).  However, the high bits are never used by
      * the instruction in either the register or memory cases; the *real* effect
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 37245570751..76266b829cb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -3237,6 +3237,10 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         accept_lock = decode.op[0].has_ea;
         break;
 
+    case X86_SPECIAL_Op0_ZU:
+        assert(decode.op[0].unit == X86_OP_INT);
+        break;
+
     case X86_SPECIAL_Op0_Rd:
         assert(decode.op[0].unit == X86_OP_INT);
         if (!decode.op[0].has_ea) {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c83ab809408..8c8adcf3255 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -347,6 +347,8 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
     case X86_OP_INT:
         if (op->has_ea) {
             gen_op_st_v(s, op->ot, v, s->A0);
+        } else if (decode->e.special == X86_SPECIAL_Op0_ZU) {
+            tcg_gen_ext_tl(cpu_regs[op->n], v, op->ot);
         } else {
             gen_op_mov_reg_v(s, op->ot, op->n, v);
         }
-- 
2.55.0


