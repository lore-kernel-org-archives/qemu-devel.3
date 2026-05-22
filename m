Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEF5CD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJU-000396-OO; Fri, 22 May 2026 01:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJK-0002x7-Qa
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:39 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJI-0002CS-RT
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:38 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-47c7b282d73so4525598b6e.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427236; x=1780032036; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IIq/YskjRURxwXRrby+JleJo4nRwydEYBipsWaNUB70=;
 b=U+Jy1eMHXZciqrhTCJIMpQOnfXaqnDtuu3ajWoZaFf9G1lvTg+8dOUkFHj1LPbyPSH
 Bmi58OxCbqVTYeeub9lw79MY9JqnvNYbZH0UcTVNrlG6JdW7r555vSu91RMMDBriYFSr
 h1j7gc5ySk5reLaxnHxRB95aR8LC19RFqFoQ71HhcUTBmXuBh0l2yRVp5HVu8rc+vp1E
 S1ipmAqkgKmTqgbjG72V5YilGCCynoyhrqHaoW5PbcO1/lyFSK6+pW/UUfNvGiFsM4ko
 hm4Hl1zeXrwXq9HFbJtCyAi+9+QBwJoIz5+Hislk/ayhip5cGFImfTwxHcUn/BnmUgx2
 zCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427236; x=1780032036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IIq/YskjRURxwXRrby+JleJo4nRwydEYBipsWaNUB70=;
 b=H08mHUqghfXmRmLIQmGSBp/jcRzXrDPFhr15BGTjsQa8kx5ldDoITjvVOfURIjWNhn
 vo0SevsJz3AjUv6MLw1oRI3c5gywr7gPi2rg4MTrWQixJaAFjgxgnRZT9PSJxLRdBDOR
 QrsKYUmK8r7YwL09gfjTp9IutFn2/VCKwZxSqMSy9oQ6Am1As66N6O7W1OKUxrPxgiNP
 hMq+zEhtp+RjUJ694oXDGUEmGoQ1JD7TgIymjVBAnRW/V7nanq9Ksut2GkhN2rKZ6v/Q
 e2k/suZvs9XRonCqhMpmdiqe+9S08qsL+FhAYMhzFeN8gPPvDuxnejZmSQkMFim30RPM
 g22g==
X-Gm-Message-State: AOJu0YzH6jAhDLg1R23UOHOyRiehaQi+9MlzYrPfOzF8Vj/5WCVi98aM
 8wRM7RndbS1h0RqYQNFMehAzMFnkNZohcIEc3s0zweTzDz+5GiIi/2rR
X-Gm-Gg: Acq92OGZ0HP9gelkPALq5F3zJdPGdntLmRTJl3OxzLGbzL+zeSHfZg9dJuRzD1DnuYW
 M3kXuvTwzIEASSK03aMM1bSzj0RiuRBBQWwh1T0MGvK71Ho04Rd3U9GiaZ0UidRfJ+Z2gtYpgVj
 Y6kWF9vKavUCjeRL049rDY9p4jX00ETdGmkug3Sr5bXHK8e1el3AE9wcSgOZT+z0MnwVE0SqmZU
 vKfvjSvJSZFKBLRuBNH98FnyCKumWc7xO6mFb9dpjdWgqjn0z7TueepKo3CVD6fgeG7BqyNJ8cb
 g1NC9JG9rhD0ZsF0bCpcclmO8DjSdhLcPxy4wcq/qUvalua1WigIEpih3wqqRKzM5ywbT6j16mL
 OFLhyvV3qG/nrxQp6Vr+WnhJ1E7fONkC1tzZMXfwPLxKgxNUTVUNJRuipT/LPi58jyVQ1U5qs9h
 rI1Q8bpMC6WJdxnVXS8Rx6ZzaJH6pxsYFFySvOMmzlVPZQGl1mJAMlCjIcRbIgR7t1NMp1WZ7kY
 pkV/y1wjcNkC5cRCTaByHBlQ5g24bhaJ3rAeBnJA+XYaTljyW+hLBZcrEjLVSpzM3Po
X-Received: by 2002:a05:6808:23c9:b0:47c:7c7c:c792 with SMTP id
 5614622812f47-48549ecf769mr1444949b6e.7.1779427235763; 
 Thu, 21 May 2026 22:20:35 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:20:00 -0600
Subject: [PATCH v14 18/22] target/mips: decode Octeon ZUC and SNOW3G COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-18-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x229.google.com
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

Add explicit decodetree entries and translator bindings for the Octeon
ZUC and SNOW3G COP2 operation selectors.  These stream-cipher selectors
operate on the shared HSH register window state, so dispatch them through
the per-operation helpers added with the corresponding engine support.

Keep stream-cipher decode separate because these selectors share the HSH
register window with unrelated engines.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v9 -> v10:
  - Split ZUC/SNOW3G selector decode out of the monolithic Octeon COP2
    selector decode patch.
  - Kept stream-cipher operation selectors helper-backed because they
    operate on the shared HSH register-window state.
---
 target/mips/tcg/octeon.decode      | 4 ++++
 target/mips/tcg/octeon_translate.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index b1a63b743f..2b27fa205f 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -265,8 +265,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
     CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
+    CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
     CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
     CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_ZUC_START                     010010 00101 rt:5 0100 0000 0101 0101 &cp2
+    CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index c8c797e57f..cda9a0e0f5 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -320,6 +320,10 @@ CP2_MT_HELPER(CVM_MT_SHA3_XORDAT15, sha3_xordat15);
 CP2_MT_HELPER(CVM_MT_SHA3_XORDAT16, sha3_xordat16);
 CP2_MT_HELPER(CVM_MT_SHA3_XORDAT17, sha3_xordat17);
 CP2_MT_HELPER(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
+CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
+CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
+CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
 CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);

-- 
2.54.0


