Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64187D68BD5
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PL-0007ZM-3D; Fri, 15 Nov 2024 15:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PE-0007Y8-04
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:04 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PC-0004OS-BW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:03 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7eae96e6624so1697531a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704341; x=1732309141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmGOoAEdsZQwCIJ4omCZkOp7rOERWrd5RA0N/up0Nbg=;
 b=KjuQu91pE9+iT3TO/+gTLWmnxagvuNxUmjcxd4ececHJcp796Au726Q2+SBHsF9sTB
 KkElzyq2wtqjtTTANlarIUn63v/8bRjKn2RahwzjbxqLXKxLHOaT+zG6x9PmEDsjwVA1
 v0D6d1d7+uoaCNkabn5qESzXIvIcHEI9nMIquwWTnbpCOxRkvLiuaZuiK/8jD3JVD+k7
 LkyDjL+nm5Jsyh7zh7PWO2R/FWr9X8m9FxsIoDrpWfYXpHPc8A6Xet9xfQlYyScH6NBd
 VfuZPhwPKdkVplEPaxNTardTHqqwj33FX0HI1htvB3cIdBLtkEjEAk/PETYOi7eQkIb/
 n+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704341; x=1732309141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmGOoAEdsZQwCIJ4omCZkOp7rOERWrd5RA0N/up0Nbg=;
 b=PtNOZCVik/rM/ANFQDTFoz5Xk6oU5rreMAamIdu3zETy81v2TfU5tiQOTHPr2d1qOK
 kx+9r0vDwU98PMF6FGijaBgbStDsYMhY/nXIGRDRuBJ3lev7KClJ540ppleWUbrNxCu5
 0cbRZJnw6vm36P8GFZxkUdidsWwSpmPR4nxjANYiAPHrPRc20/ZQSV08z2YXYLnelBbp
 1zzkN4P9A7AoueuqqVCwGyx3ZlbBe4yNPBJMQA6GO69v6XbUrsRVWZLJU25cxcoU748e
 NA8RQBNs7v+EuuPMBOXRKZJMUh9q5MBDgeGLECXoyPLuQ/ExbmGpjnvWOO0n1eex2Otp
 Iu4w==
X-Gm-Message-State: AOJu0YwxxOtiNWoVdePCb2djNx/sMkUSCQSo6C0wqKX8SMWn1lJeiPpm
 cAyR98vFJ/hEm31wlUNzP6yTuI4HbsZTOFaUd+17S+3s5IP2QexnswRnPlCjLk8gpPqbNBiJEme
 G
X-Google-Smtp-Source: AGHT+IGRE3C1En8DY8171XTXN381l6et7M32Lnku4XTayFQB6gXGFW+9tFQd/jaHDWyVjak6hiZRCw==
X-Received: by 2002:a17:902:db11:b0:20c:7c09:b2ac with SMTP id
 d9443c01a7336-211d0ed2d5amr57445055ad.52.1731704340862; 
 Fri, 15 Nov 2024 12:59:00 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:59:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/14] linux-user/aarch64: Reduce vdso alignment to 4k
Date: Fri, 15 Nov 2024 12:58:44 -0800
Message-ID: <20241115205849.266094-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reduce vdso alignment to minimum page size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/Makefile.vdso |   5 +++--
 linux-user/aarch64/vdso-be.so    | Bin 3224 -> 3224 bytes
 linux-user/aarch64/vdso-le.so    | Bin 3224 -> 3224 bytes
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
index 599958116b..c33a679c0f 100644
--- a/linux-user/aarch64/Makefile.vdso
+++ b/linux-user/aarch64/Makefile.vdso
@@ -5,8 +5,9 @@ VPATH += $(SUBDIR)
 
 all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
 
-LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
-	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
+LDFLAGS = -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
+	  -Wl,--build-id=sha1 -Wl,--hash-style=both \
+	  -Wl,-z,max-page-size=4096 -Wl,-T,$(SUBDIR)/vdso.ld
 
 $(SUBDIR)/vdso-be.so: vdso.S vdso.ld
 	$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
diff --git a/linux-user/aarch64/vdso-be.so b/linux-user/aarch64/vdso-be.so
index 808206ade824b09d786f6cc34f7cddf80b63130e..d43c3b19cdf6588757f2039f2308a8bce21aed9c 100755
GIT binary patch
delta 50
zcmV-20L}lH8JHQ6tpWfLk+0bl<zcO@sx8Bk2RT5)R`<=5QB@Vnvz!6X1qOFSFiLP%
IvvCI}1uUl&oB#j-

delta 50
zcmV-20L}lH8JHQ6tpWi6k+0blA5kqX4aFpe)BQ2Nwg4c8+P|Ifvz!6X1qO9#Ib$<7
IvvCI}1^-?Xy#N3J

diff --git a/linux-user/aarch64/vdso-le.so b/linux-user/aarch64/vdso-le.so
index 941aaf29931193300de1f62097867c282a7e0c74..aaedc9d85e568d5dadc9c394e9c4459f1f0c8c88 100755
GIT binary patch
delta 49
zcmV-10M7rI8JHQ6sR9rHk*nPlH6|OK!ah4~>4vUoZ1rE*XtsXbvz!6Y1qE4ha#lpM
HaR(;_22&J+

delta 49
zcmV-10M7rI8JHQ6sR952k*nPl^~i=KtbcHFtl42<9TUsw2PpfHvz!6Y1qD@cX=ik^
HaR(;_8o3m&

-- 
2.43.0


