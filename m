Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97604CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx4-00059f-1r; Sun, 10 May 2026 16:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwo-00056c-KC
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:22 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwn-00040e-0b
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:22 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-47c6f914617so1851578b6e.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445620; x=1779050420; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s55ZWJ02q/cJnEgqiV/e17CboaSVjVzHZpgSgqSG/6k=;
 b=Ein/PyhQP4Ypglo+IaP2tI7DRtqG2V0PvPvFdd48BmxfXRAb1u/LXNmO+u5H2cdAna
 FqNdbMkcKT5nXInkodqwKTFRFI9UkrWFsh3NcOZomskVqUbWVayb6pScwaGUpLgVuYuo
 eVYVO7wHMBXtVxmUEBlIOaS+TjvHc437XKcYRb+bMHdP+K19LjU9abuhdyWXUNVX0mxP
 SypXWl9FVR5O/jEoWWImtLtCcRxVflUFsNtLRMlONatrPhyOZnTSct14jjVHjFuNyG6q
 cRVGSDWc5voMGP6ZASu6UMY6IYndFU4DDzzv+pr3FetMXOuZ13Yxlk7WTQ5oPlRU6RHC
 wAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445620; x=1779050420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s55ZWJ02q/cJnEgqiV/e17CboaSVjVzHZpgSgqSG/6k=;
 b=WAdpwPIdmgUW9x3qXJ9qVeSmxyP6TjzKcDB0rhmyp+rXVX+MbTUqCY28/vy/thoVPc
 3/HvX7OAFtG7o0mGwUiJJ2JT2iQCPjvHq7Zdq4zsF2NDrV5xPjUTfGsj4V1bZdDu4ZlG
 0uKKWwEM7nMBLzUlnbJFhx9Nln9XlJUR83pZ32ozDtXBJY7kzCxTT2JPyh2iqOzVInH+
 /Q1uY1i5EbUzl+QSh919rsnezgSIMe9u1FiXuI4L/pEV6M+GA0zga8iPIXxG2fg/VbSI
 Jy/7VQf/NbubxV8marLkKjYIDetJDZNgxE2lxtz3JJ9lnRcM9fTxWBMaQN3gdTghiVMB
 Kt/A==
X-Gm-Message-State: AOJu0YymGneYyAiApikefAQc6S2E8WzduL041R43Vw4QI52HWtU02N9J
 4LCXie9mOlL6O/08SwIy0PPcQDvCY8lxeejwtW5NZMtWhy4XpTlhKYeQ
X-Gm-Gg: Acq92OFDm5deUR4d3gfRQJh+shpZS4w2u+ws2TveQh0prVxxeISa6UPfELsHzzy+0Sa
 3OgdliMknbJMteUgR8rWfutd6UbTSwh681oZlAXGHMJrCLA4zIkDROaBSJrTQvRka5WltMWS3ed
 uXE53wMDp+wmw/UE6HW9s4761SAonD5SxU5ThVSYnJzM8kXDPPybMmKi1ewhFsCEVKMRfKXfyVs
 1Imb6UHnROKUYJPTpl2/jvXYBkSKAIfnPTTCFhBlOsTo82li0zgfcgcYYc4HSLtDttYXuyzqHyi
 oQpdpFjartxKiLzkWIh3bV5To+4fHTfp/A25OUiin6wNHViDwvtuo9doIM4dH5AtuDlvuxIhE7D
 jOmccp8g/CKTeChTrGL7+urf8xYHazCaP4wS1Nj5qPTBkS5eWr3B5dvcGiWyyeOVMJEQiADpnf7
 kXDZEeQHYLCetZZ1+9gr9qNIIvmPTW9qhHzcC7fk+p0L59XbJG+nrwmVsgSDqsPgLVaO7hMvJzx
 S3sobVDXPlYw2mozMBzV59JldUOq8/lRylLUaUHR5110e0WlfqMfA==
X-Received: by 2002:a05:6808:228f:b0:44d:bcb0:1409 with SMTP id
 5614622812f47-4824a944055mr4149252b6e.22.1778445619994; 
 Sun, 10 May 2026 13:40:19 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:46 -0600
Subject: [PATCH v5 16/32] target/mips: add Octeon MTP0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-16-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22d.google.com
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

MTP0 loads the low Octeon3 partial-product pair from rs/rt into P[0]
and P[3].

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior. Add the
translator storage path so subsequent VMULU/VMM0/V3MULU operations can
consume guest-managed partial products.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTP encodings use rt == $zero.
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index bf1dab61e1..59ab7401ab 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -45,6 +45,7 @@ SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &r2          rs rt
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
+MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 126aa41b21..3df46c3c03 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -250,6 +250,21 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
     return true;
 }
 
+static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    /*
+     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(value, a->rs);
+    octeon_store_p(index, value);
+    gen_load_gpr(value, a->rt);
+    octeon_store_p(index + 3, value);
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
@@ -260,3 +275,4 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTP0, trans_mtp, 0);

-- 
2.54.0


