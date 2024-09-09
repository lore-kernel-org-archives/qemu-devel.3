Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626DFECE585
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC2-0005EF-Ov; Mon, 09 Sep 2024 13:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBn-00049y-Df
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBl-00061A-9d
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so3738119b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902912; x=1726507712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSotwpVP0Set/QuWa40e5OXb7QO8R2QJLi2VvBAPNm8=;
 b=dLJr0qA2moSlIrBpbjvs02C06pmcjI4aPsnFspdaDMNsWfbKlUbc+YR5GaL/I4kai4
 yjEVm6oymvz3F8SmmtrfHyCXdIVClfm2pGRAVKR5P5iNVSoz5rm/LIac6ZSnrU63gK+X
 1NUuWvzZrP2p+4Y0F7RvDhU/edz5Zvihgr8nJYEYe+UWwjX2lPjaabG6crmmQKS8di2q
 V7FHk5g5jr3aX3XxHBKBIa/cZ8CMxqt8ZuU3u5fF3kqYoj4DsiJpNcpQqB2LfjmmlfR9
 wbxP3Rx8BvyFOvmr9gs7lUNpeokxJ6cLcXtokAaWW8L9MK++S8z7p11rYKfTXLCwwnMw
 bHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902912; x=1726507712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSotwpVP0Set/QuWa40e5OXb7QO8R2QJLi2VvBAPNm8=;
 b=Qq84Wn2OsZoJQx+b8muXA7pHseRbKPZQQHY0e4mzO7TvY/ESgBwkuBVgDpFRyqKod4
 MEzO70H7sR8Yl/OcQRtblgXK4RANoyQ0eRHq38lyoRuUXFjvHx0OaSbbcXYfOSas5R1T
 dd30JfnzkFOPZ8GJEOlssh6YSndXtSBNG3+swClW9O8oTPE+kF1/IVNDFpYCysaLKQsZ
 cVzoipVjUwzFCjHBpEx3mPc7VgvdFeR3stO6fBzcjFLoKG5k36sdbRBoJCAFUCHfl3Mf
 tEGJrbwdicFEpTZh/SxUwngSq3RmEFbAgVqBHOW3HFKTEzUEe5OradIjH/zNXXfrDd9Y
 T29Q==
X-Gm-Message-State: AOJu0YzilmK24c4a4aaMKfOeITFHsvMG3xtXxwx0DQLTTJGXeQeOPIr2
 ivY/j91KuxBpav2GHjdLUS9e20o611yFT/MBnqjOE0671UxpAKOmbO8wVIVSM6hmDfJhh4UyP3U
 S
X-Google-Smtp-Source: AGHT+IHSsscpubQYG834BkxrkoSaVP1pquROrMdoyFMiqiSs/IS2y/WBiRcef6haxkx8o4yyxFMULQ==
X-Received: by 2002:a05:6a20:43a2:b0:1c2:905c:dc2 with SMTP id
 adf61e73a8af0-1cf2a031b07mr7949432637.15.1725902911791; 
 Mon, 09 Sep 2024 10:28:31 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 07/26] target/m68k: Invoke update_fpsr for FMOVECR
Date: Mon,  9 Sep 2024 10:28:04 -0700
Message-ID: <20240909172823.649837-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
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

This instruction sets CC and EXC bits just like any other.
So far we do not properly emulate inexact for the various
rom entries, but we can certainly update CC correctly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 423c663607..003318163c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4955,6 +4955,7 @@ DISAS_INSN(fpu)
             TCGv rom_offset = tcg_constant_i32(opmode);
             cpu_dest = gen_fp_ptr(REG(ext, 7));
             gen_helper_fconst(tcg_env, cpu_dest, rom_offset);
+            gen_helper_update_fpsr(tcg_env, cpu_dest);
             return;
         }
         break;
-- 
2.43.0


