Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E0FD0070
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi1A-0000m0-MZ; Sun, 01 Mar 2026 09:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0R-0000Ks-W5
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0Q-0005kC-Jd
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1bWQq5m4LvVQp0EwySwDYgA6hN9gim4vxj7cEPYMGY=;
 b=LQnbQeD8ehdO3opZmOAcBCqUzoW371q+74woPxQ39OyjOz3N0+uqI+vLn5pKm5lsSL9OLl
 3K57Bdpu4PzTyMyLtrdJ+NaGzu1ta4BiNqMw1TICDgaxhPaM7wZgPRhVzi6zUInSU4tU7y
 lKoNMZt8gQ6BckTEI7BQjsJlU1cJtJI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-CqQY-1bDNpiuOlz_ZoWPWw-1; Sun, 01 Mar 2026 09:42:48 -0500
X-MC-Unique: CqQY-1bDNpiuOlz_ZoWPWw-1
X-Mimecast-MFC-AGG-ID: CqQY-1bDNpiuOlz_ZoWPWw_1772376167
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837cee2e9bso27754435e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376167; x=1772980967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q1bWQq5m4LvVQp0EwySwDYgA6hN9gim4vxj7cEPYMGY=;
 b=IoZfm+kmfejksSnKq5xmWpIhZIgOlCJm1UfQR7M0sDTNBVkGFkJqRkEeLElnUI+wMK
 BLVGnXwFuU8eF5/TqwaxwBaFF3nDB05tFOkif3cJe8cOl3CsTHtRIVlMQKmckBRxUMSq
 jLdoiYUfNuKhEmcQ6yv6kw4IX9RiVkKNemVd8rTxDm2Ctqg5uLlzUfqN2A/vZAaPNaBr
 AqAMgF9JgxpdL5i3oh5vVTensAA+6obeL2mVon3c6BTi73opqAsqxGNg2/zZS1GfY6Oa
 SyVTqGta1biZo9W/bHrqOZOc6HC7/4jA5xYrvMgrYR86eMOijC4E14Nqr88VGOtyTy3X
 I1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376167; x=1772980967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q1bWQq5m4LvVQp0EwySwDYgA6hN9gim4vxj7cEPYMGY=;
 b=h5WOIq8lH/Y40nSQjs8BCPdD1418VK0ww+SC6FKNd5JpEWmdPKmhC2hcNiPyMoX175
 XwvQziInfbnPAzwg030jJlHrhq0LHHo7XvDeL4g+H8sto8k0YcOvLwnlPQY5bAwBq2Il
 OgKIa+q6S7fNiPDWwlnL2U6RaGRBnKeJVC/o2/UHjAhFqaGsdLQHxq8PRpDEBuoQWfkf
 fdAlHryvdEyaHV3kr0G0lZbdIrHAj0in8DaRQO48h0xysi6n9sIz7nwGBIGp6g79P2Dc
 Llp/us89TEMszRBfc+Fy4qARbvVPHnyNZIoOiTONZGllnxP3liN6Csf2Wwen/xzP1W6z
 CyQQ==
X-Gm-Message-State: AOJu0YxnCTYBHDpV4etY5pF2ZmGYabiyvFVEaWX4q5pK/7gapx1yKFzS
 LJ+DVapL6JZOXvNfflBL2v4ESrzebNesZc9liIg6ku+SdT1APN6wNkOGQsxvcIn/O937W+jClnd
 qbl62EmmjdIQENpbZa/BQWmr1KO5oiwNh/rD3M1Aemfk60+3BqATh2Ok0jbkujOGGAfjQy1W+UO
 STMNl8c/DC4/VoFBGZ9mP/yOKwmXjoyLzN68IsTB69
X-Gm-Gg: ATEYQzxpHAmo300kL9CtgUERg57vWKLIpEhJHCLUfTNg1E3xD9trO+Jyd1HM6ElwJFN
 JcnFpSPVfwfFpL0S7InD/8LcYM7nYSxpadPNnBGnJCZuwLqOG0vfShsjPglKqWBJbNgAbDHx1I5
 Nu4C2aU7XOaF8kUPveZFpk3NS40KpdnrHDfK5RPVzZppCXX5+fyZVgtgH4Umwd2Gyod72BMA0I7
 RpSr44aTapU2XDheycFN1woZ5j3BNrIawb05mH9pzCvQc1VcLMDZrEKN0yFzGPfUBVRXDG1kC1t
 2Q0yK0NR5dcguc+kbfD8kSFyw7uMJdIqkxxLRjmnttE7aAlStZOVBGYOS9qB0rgqMrMj/VkheOI
 zrmI1DX36EhR12XmIIUaYgh3oDndIgU65VvkinMCd3Vo2YsmfPp2lciXIjmJfeaPqZKWZZC+x8I
 7QC835wepxKEt3hOcWt2Zl8l79zLI=
X-Received: by 2002:a05:600c:1f06:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-483c9bc42c7mr154470105e9.14.1772376167043; 
 Sun, 01 Mar 2026 06:42:47 -0800 (PST)
X-Received: by 2002:a05:600c:1f06:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-483c9bc42c7mr154469755e9.14.1772376166521; 
 Sun, 01 Mar 2026 06:42:46 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b3471asm242680055e9.3.2026.03.01.06.42.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/18] target/i386/tcg: add ZU writeback
Date: Sun,  1 Mar 2026 15:42:12 +0100
Message-ID: <20260301144218.458140-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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
index c14a07be5ff..adb5595ddf3 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -3228,6 +3228,10 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
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
index ce636b6c56c..94a2bb49172 100644
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
2.52.0


