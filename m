Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDD6CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqZ4-0008Kl-CC; Mon, 18 May 2026 01:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY2-0006tu-8G
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:50 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXw-0003Un-OP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:48 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-479ef2b7979so1346586b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082180; x=1779686980; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9xwIUAR3iiDg3JESdSPGwXzW+kc4/Crmw5lNBAzgw4s=;
 b=N2yb2SQlLg25QOLM2lTJYXGmsqZGDL8LY1AtViej3aW14zNTrY8DwUf/F1Gl91DS6S
 WR7sh2HZtBy4I3hratnbOMAiFFamQu1qNuzIlAemrKVOx1gQLXJdm+JpBCgnq1YqPjFz
 /2HDw0BSkdjJrlCNdooAbGoxKJF8LCTDTpaqQyOxZ4EULT/XCoFCDhVOKnu4/JLP0IqT
 OFIRdmdLRg0jdWG0wyxd4KkL4KSJpFNjJdH64l1+lwxRdRwZYEclpfRJHgsCuW72VnY5
 4qrf+9MApGJltK/isn4kKgfpmadiLXmoK25iVfd0FBne/Mc5k/daGcv2PaXCSiPPdS1y
 eTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082180; x=1779686980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9xwIUAR3iiDg3JESdSPGwXzW+kc4/Crmw5lNBAzgw4s=;
 b=OC7dxYd6ZclSc/eQXD3duM/pAk3p8nkqxFmeNf3lfmJebSK0Vg5ptK6wYthz8nA4hW
 OV2EQSUfE2HvY2SKTJRiMg47FKSp8vhPGGKhK59mXjCnP94zUs3DIwPCnVZfl1oi5AE1
 tqJqGaVKoVNl8t3IZQfGDryw2Q8xyTuJ11AOIlPeZtVkSX5PcPg1tfQcGZvEzyXkgr8S
 KPc5tRSTq0RIS0hSEuuHhMGsEpi0SEVdVgQk/gpmrru6cjorfzS1lllq9LvrDGPlqT0O
 AHBpPICUGgaozvn396IXNZPf7hWXHxFhiSSKOMlL203Q2e1RYYuH6fbCg2p9sQpYsvVj
 fvDA==
X-Gm-Message-State: AOJu0YynZVWri3RzhdDHpsGhStSFyF8dmHLjN4yM2KovZ+N5XQUfy3oH
 tFSgrwtD2jW5fOiGRyNURnRzK/ls8V/QHAyBlB14mEAPQp9F2QJp+nfX
X-Gm-Gg: Acq92OG2rRVfiWGgawp6bgvlDou2YhgMGkftfz7V78D3wYe4QQQ9lPTFuaSy9VKtpg8
 RZrnIV1JWxEi5J7SZwGJtrW+lOS+RP+louDgHuqc4VKnmP5t/k2/o7b+5OHuGWMBKYSUurlWvjY
 9ObUZLhokfLYSanEAwBB7YduxwlOG3fXX3TAVGqgOwcyZlj4f1VJw4ZJiYafGEFfVYcQa4vfdH+
 Q5vShsKzMj7h1YSqGGX8jMdPguf04MXhoXkJoKExUYoYvHKdI4TLRxmppNp8AYCb+42S71me2M7
 19PhNCzJoQa5EP198mjJGX4KT9dddJJmoCWVtGg/BxtxTcuyb7y/BynoivztKVfh/DLn4aZIJk3
 /ObDEiMytc4dw7CMOOXmVxywQ4hhsjBKw9LGWY/1St4Y7aOdlQFIOO+hTRAidheibqEIubcKkMq
 F8sh8JQr35Uc6ezWvBITn2pteQKIS+85WftiBYlLilqSPvls29I07YLt++Bd/d+dw6reFiRcYdB
 13Cpe/VUXm+/DKI2ZO9RDuVWnaYEYwRlHz5km44CjKb2bes+uBus1XJd1qjyda6uGO8W9M=
X-Received: by 2002:a05:6809:3c8:20b0:484:afc2:eee3 with SMTP id
 5614622812f47-484afc306ffmr3234179b6e.5.1779082180249; 
 Sun, 17 May 2026 22:29:40 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:14 -0600
Subject: [PATCH v8 17/35] target/mips: add Octeon MTP instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-17-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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
index 0abc839907..472b81dd70 100644
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


