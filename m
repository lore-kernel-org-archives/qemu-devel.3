Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D67CD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDm-0006kn-PI; Tue, 19 May 2026 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDc-0006fl-RL
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:56 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDa-0000hR-Vn
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:56 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-439b2aad735so1597311fac.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207772; x=1779812572; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qx1EB3AzUT0IaeA4UDNUUR4EbpM8WjBRGlVYCivFgZU=;
 b=l+1Ie/mYrcRE6fHgJpBfnJ8y4qAXxxIpiOpOObuMlJGYC6rrpg3Vy9r1PLMH2p6/Ss
 nh5kaQQAjcIljp4iT8/pqE8QgdtFwv+1xngN3BCD91mJxobzumstpcKF3+ddS3mVG3qr
 wafEOsI2hEGAyTknH0YjF5r3AN26TUQClhLISrMbqkHt8kexsz/I8AFzMO5/2/LBquC8
 zLFylmbwyfG3hpSmbUGSTwvt1FW65n/Srhqil0kZbn8xRZVh8ZeKTWuje4OkHHD9F9WT
 UaZdoCxR0VgXwoBeSw1Sciqk1T7gZ8aRilPgsFCZQCjSU14Co3106xE4AL/ANWJqSo9E
 EblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207772; x=1779812572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qx1EB3AzUT0IaeA4UDNUUR4EbpM8WjBRGlVYCivFgZU=;
 b=JTTvN+9EBinJYhMwfu7yLUSP05Tky13sEJ+6kyadhTIV54TW9x685eMKLKI4BvO48h
 NeXcwPyvJy6cdTgP7buYU0w07IPzKm12GpNWlFrFjqQH71ql6mLCdKWAImcpe8DPNRwi
 0J7f8qOTPv5DZAkn3IuozbzbVLnW6sm592OPkZb95mYfzN/4mM2SDNEtR9Kzl6HCZQTj
 NxHP/amB9bDPYpDR5SWt1zRosA3RZuCq+zpwk8qNvHx9TKAfSzCCYrGOU58euFNWxy51
 klGIkgbfYFaXXY89qARSw2q6BisKMELHML3O4yJaCvKnHbMyceqfm3oPVuaZ9oTIpOcq
 RohQ==
X-Gm-Message-State: AOJu0Yy6ZmRN59WAPTuApvyGSERwuNPV/5LqMze19VW2jXKvHsfUUeRI
 Heyr3V5dxMxesitkMmpODFjl0Hg1puW2swgHrB0G5F3TqXgoxpKXlUY8
X-Gm-Gg: Acq92OG4s7xiy2I0NdGRaRqc+uHxtUxJFh/s9TnHRm2nx724wVixWGiKfHy9MqBbW5N
 8bIYYOsQ9XDdfmtfGwop65PpEarCbUd7DVbQAm5rINpGZDRClctyjuh95Ycq8WK5G4AQev2/1t+
 lkm9z4ToCkHvxuvBAJ7UfSS0FnxfIGKTg1tpG2LkP1dGPj2htc3eHzUtiB36y/KKK+f/FlEIWG5
 KrN+0Q2gtqAvv+JM2nlLRaKa1o0pUPfyWcJG0+KqBxdy69cTEr7UplIwH/lmBJE+L+hZUEJI23s
 qx8WECQtD6K+Nfh1bD2WEhEs6nyMQCg1fK/a4Cy0ZRvtqcatDlzAJS4kfEJu6VjBjzKPtTlc274
 Lva5GcK89KezlzwNqK/hbngmTrArgYRMP4SwgLYTwQx+NMJ2IZ0wbj/bPvjktiaSyoUjqt5Rzde
 Ow2caCIhDK4wn3JoN+UtAitFzA7ZnDWcb4HlZaGiDQFOfgtB8Yb8GJakTqVfGlZYSp9UNa4thBc
 /CCwNz42SGawAebB1zNWSIS2rXJnKn6lIwBD+eTipXbxHmvjuGrPwNPD204DF/C/cN0IWaz+2zd
 wNo=
X-Received: by 2002:a05:6870:e6c1:b0:439:b52e:5e83 with SMTP id
 586e51a60fabf-43a2dedb48emr12860332fac.37.1779207771966; 
 Tue, 19 May 2026 09:22:51 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:19 -0600
Subject: [PATCH v9 17/40] target/mips: add Octeon MTP instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-17-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x35.google.com
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

Add the MTP0, MTP1, and MTP2 forms. MTP0 loads the low Octeon3
partial-product pair from rs/rt into P[0]/P[3], MTP1 loads the middle
pair into P[1]/P[4], and MTP2 loads the high pair into P[2]/P[5].
For MTP0, also set P[1] to zero for backward compatibility with
Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split MTP0/MTP1/MTP2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTP encodings use rt == $zero.

Changes v5 -> v6:
  - Zero P1 after checking the CN71XX register-state table and
    description.

Changes v7 -> v8:
  - Combine MTP0/MTP1/MTP2 in the v7.5 inline TCG translator form from
    Richard Henderson.
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 5139543b15..bb0a9f1d99 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,10 @@ MTM0         011100 ..... ..... 00000 00000 001000 @r2
 MTM1         011100 ..... ..... 00000 00000 001100 @r2
 MTM2         011100 ..... ..... 00000 00000 001101 @r2
 
+MTP0         011100 ..... ..... 00000 00000 001001 @r2
+MTP1         011100 ..... ..... 00000 00000 001010 @r2
+MTP2         011100 ..... ..... 00000 00000 001011 @r2
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 67d95423c1..f778ca22f0 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -242,3 +242,26 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
 TRANS(MTM2, trans_mtm, 2);
+
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_p[index], a->rs);
+    gen_load_gpr(oct_p[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears P1 with P0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_p[1], 0);
+    }
+    return true;
+}
+
+TRANS(MTP0, trans_mtp, 0);
+TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


