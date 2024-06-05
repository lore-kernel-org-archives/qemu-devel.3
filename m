Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51636C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuM7-000685-O9; Wed, 05 Jun 2024 13:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM5-00063r-Re
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM4-0003tI-92
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f44b4404dfso1149515ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608199; x=1718212999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBCU7kemEaxMNx4Xnmn8j/Roj1P+mR9pGOaXhWJ3PgY=;
 b=TQ4uIsB86q5gDFvCTMsS2Ap/CpIJ8oFuPE+pXLMt+jJA+vle5Jn3hmNQIqj8D4668p
 qNAwe2aVUUdjz+ONyKsqKO2iGf2C3Ypx3HJTW7swTUDunDQoDAlMd1SvIOPhhfAN0xgm
 xfA4t11JEDhSS7oMS7VYoK4L9de5hwVaL50cADpAtnYGDZtJEOpiQ7MhyMtyvFUVvZv5
 m4wHalmoCxsXWc7K5B6Qgn54DgL3mDMZ1RCEmX13uFXDJIAC9UIAl3derNn4SPinMkv+
 61SAf3j1SlxBfIy2LafSUlclPVW84TGwa6KT3RpiF0eOIynxXlChKcMMIPqiTGT+IZQ3
 /cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608199; x=1718212999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBCU7kemEaxMNx4Xnmn8j/Roj1P+mR9pGOaXhWJ3PgY=;
 b=BvWW9CGiC8wi3WQfZrxmusEJD0skFjEuQ14WI5iqQ8U50B5FrU5aWJAj95hIgx3r0m
 rEez64N8cnXlOylwDrXgh5JPevoMi6VFXHFNgZSqS87MM7BKTB61v75WSk7AjKCfMYBp
 YGQsEEt4hYFJHSeHN7WOEWM5m/v1ZIwcmrtF0M77UzLnZaeJ8zf6ALFenataXeGP4uTx
 OY28mkNGRDDkET94aKByLIwQfndfbZjLebPVQOGbZKi6eNEoc+6QyE1M/pmQSWQXl5Pg
 KlTdxuM3yP2Tbc8K4cys9IpD7nCITxqQtuHpkm5b+MBEEWd71dEdpPa8jUgeHD6deh1Y
 /rIQ==
X-Gm-Message-State: AOJu0YwgTAVEV+PBU6gvah+NuPbR1BGr+X2SPRRl5UAnHWzXS/RKBQzq
 02jLNJ8OZUGHs91ykbDp9JoJwyzjtKGkXz3c/kdRws6rTL8lV+P69rE7LjTBcsapmvn6xIty4B6
 n
X-Google-Smtp-Source: AGHT+IGTXy88IkKe5ByiLkGC3vHanoNQ2LK1udcVXnXvOFbxMPPY8h2HcJ+j/pXDchi6SohRuA2LDg==
X-Received: by 2002:a17:90b:33ca:b0:2bf:ea42:d0c3 with SMTP id
 98e67ed59e1d1-2c27db1652bmr2931360a91.16.1717608198971; 
 Wed, 05 Jun 2024 10:23:18 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/38] target/sparc: Implement UMULXHI
Date: Wed,  5 Jun 2024 10:22:41 -0700
Message-Id: <20240605172253.356302-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 1 +
 target/sparc/translate.c  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 09c8adca37..508175eccd 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -389,6 +389,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
 
     ADDXC       10 ..... 110110 ..... 0 0001 0001 .....    @r_r_r
     ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
+    UMULXHI     10 ..... 110110 ..... 0 0001 0110 .....    @r_r_r
     LZCNT       10 ..... 110110 00000 0 0001 0111 .....    @r_r2
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2480eed1e7..2a38152f58 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -581,6 +581,12 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
+static void gen_op_umulxhi(TCGv dst, TCGv src1, TCGv src2)
+{
+    TCGv discard = tcg_temp_new();
+    tcg_gen_mulu2_tl(discard, dst, src1, src2);
+}
+
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
 #ifdef TARGET_SPARC64
@@ -3919,6 +3925,8 @@ TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 TRANS(ADDXC, VIS3, do_rrr, a, gen_op_addxc)
 TRANS(ADDXCcc, VIS3, do_rrr, a, gen_op_addxccc)
 
+TRANS(UMULXHI, VIS3, do_rrr, a, gen_op_umulxhi)
+
 static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
 {
 #ifdef TARGET_SPARC64
-- 
2.34.1


