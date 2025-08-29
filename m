Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EC3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNl4-000432-Dg; Sat, 30 Aug 2025 11:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fT-0005xb-OD
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:33:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fR-0004mN-Up
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:33:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1104094b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506836; x=1757111636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2UyNXYokJ6TnLyjAm0R/ws5bbTquqkinE1D7/JLlk4=;
 b=Ji2ns9FtYV/OLVzizotyvDWoSF7c/kZPGGGBMKPIagZgwqbBwmVo6h6ReVygjTaXzE
 JGv8v2r5ey20xFjTDLpnITiIO819V5KySIws0S57boyUUCnZ32f9Mi2ZGdxzcNALRu9Y
 afa1x0UNOc/VuXQFxAhBcGYSg9c0Smz7UccPOROysPrQMYY1r+jMP2ysTggrXccffBTc
 n9GEHh8vAnLAjMJezWXtQ3NNpO77UVThw7kveNvsHFKGN1p8hmhu22DMr8AgPFA/kfWr
 /OmtAJqxBmypUBx5a/w3x+KQFz4xyrQdLki1qPavhfWXLwC7GZTZDVXd5rP2RnftG6Tx
 Ha2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506836; x=1757111636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2UyNXYokJ6TnLyjAm0R/ws5bbTquqkinE1D7/JLlk4=;
 b=YOPROSOdafWadUiGL5fRort5d92T2ms4OJkaq/YxEtnvHpLMKGizWTyvIypQX1h01L
 rKPbw61plqSeenhCe8/uPwF3ZHtpIXG2OLl/019Q0zgbqw5lv2jqJxJPb/WO9ZNPMJiP
 obAmshLxC30RGZaOptdnVKN5vqbWviDrhSGnwsD8GtYXwpB1a+CbFj1ZjQVvOYvKv/X8
 +LA6UJAXuNxyRaFQLF0wWIPzvdrhqZ/pgUyHpU/rKHb+LCGnFk4NJbpZDcTEfBjtt2z8
 vktoDjvQTyj9Kn2/ckMYoRxultnbxwndIZsgJ3s7o2xQVVoD+T0fGkMRaUt0No+PQO0Q
 66Qg==
X-Gm-Message-State: AOJu0Yw7fPlnSEdAH2W5K0cLhd5/nI5KU24/QzLQ+K8uKZXnjlSGDZIR
 NQkxE9Lofadb7MNhhlpE5QT3j7SdFMf7UMbZeKUlV8svUMQFjn7lvWdoCxGUd6uB3kJujK1rLiJ
 Yq8kzp8A=
X-Gm-Gg: ASbGncvnbYuteG5RieIyiO7e+4a/X2Ek1FzmQqQVsflIOTkI5fOs/jXHYpH5EIYJwXs
 caitg3veDR+iel//20UuwQhrUuYmOGTb/3nZ9GFFDaNV2RYYHGMnBLx2LSq6m7LmX/tCv7zH9Xt
 GBRbTf87wi1RYxA0K49lRM2/8x44+W7viaodNj+srTP3JyoH9kRv6KMbf09Tr08Fr2rOppiX8wc
 287JWZFdRc8zB/WQLFjtHuMtGwgzGAaLKsLTBTM/+Pi29nwwOSt/tLVWFTHKD0TqmnpaxallE32
 Be2OAWQbMOCsw+tQJzkpjegEqephEZIXTnkhrEv2cTwtqe0DXod3i4+DFHmmW6fPffOXvVVu/lg
 deRcfB/m/S5y9FHqJ+iiycQl8S4CfEfUPhdRDnqKkDnPImWO1gpyMcawHM2eN
X-Google-Smtp-Source: AGHT+IHMQtZIQBN1gTKasqostZ+bTW/5Tj5hJxZmCpZfP3jgwGuKmg1Z4dad2yTQ18FTgNM6EeUcUw==
X-Received: by 2002:a05:6a00:2e86:b0:76c:5781:2c01 with SMTP id
 d2e1a72fcca58-7723e0d39f1mr278862b3a.0.1756506836442; 
 Fri, 29 Aug 2025 15:33:56 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:33:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 83/91] linux-user: Move elf parameters to hexagon/target_elf.h
Date: Sat, 30 Aug 2025 08:24:19 +1000
Message-ID: <20250829222427.289668-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hexagon/target_elf.h | 3 +++
 linux-user/elfload.c            | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
index eccf207f6b..a9f6d77fc6 100644
--- a/linux-user/hexagon/target_elf.h
+++ b/linux-user/hexagon/target_elf.h
@@ -18,4 +18,7 @@
 #ifndef HEXAGON_TARGET_ELF_H
 #define HEXAGON_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_HEXAGON
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 804a819471..33c4214c95 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_HEXAGON
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_HEXAGON
-
-#endif /* TARGET_HEXAGON */
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
-- 
2.43.0


