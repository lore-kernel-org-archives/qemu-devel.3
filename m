Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C949BC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4q-0006BG-VE; Wed, 07 May 2025 17:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4m-00069Y-D4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:12 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4k-0006D0-LS
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:12 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso472405b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652389; x=1747257189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jk4EjQefaC29HViyknRVvmNGslUguEBFOQzXT/8c2wA=;
 b=r/EcXkfMF1rkZMY1ZZ7gs4V6kl1tpwyBXJTLoUA9avUOZWKZ90u4VUuAo99MhZD6+0
 580Ia8WYeh2GGUiHEf2Y31KuXC93BdFetPfWewkFuhkjo1i1WhDNLdtaUjDpyUtKpUuM
 s+eliB2N3CcvyAFzJKJPSuwBMq1wgjf/cZXJmWhICXbrRvJ0y4hutCEs4aDtRfrOxUNW
 gQrTIGZUcnDdn+B8Qevgaw5Fnp496aOlQtUOE2g7m19SPx2BfFypdAtz3u/runHdBwcg
 P4900HKPkVmgANDXBx2LlHgqVEAkpnfC+V4F9OzN/if4SHxGq6NBuMAMe+D4BJR0+fmA
 Vsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652389; x=1747257189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jk4EjQefaC29HViyknRVvmNGslUguEBFOQzXT/8c2wA=;
 b=rqay7jBVwmdM9ni5IPRAI19jAsFmq7cI8dYDdIwuaprT3LDN6T0HQc0wM3/FkvPa35
 EWHP3Hvi7LlT0aLt8S8hzsDaf5qUuFsdsagZ31vefyOj+sEUGmF+DMKjxhcDtmEM8VgZ
 SkGvidFJLP2UXEggz1gtBo4DdrGg3zw9vgXWp7gfUI9lx2UoCOwf8+Vlh/p0WPTSqGb+
 WgseZ86itg4Cxbrnnn5B6ahSso7F+jh0oHI/IjHLwbeF+vq0PfzkuM/tnfNcvDjXkNHb
 5bQix/meCs5RwxmAIHIlrZ4GcbMYIeIuP/xvXxPc9aZkyxc37KGCoU20oyBeOmgC0Vxq
 /M0A==
X-Gm-Message-State: AOJu0YyrxgDNYx8USmcjD5WBsd+M8furCc1omDFdWsxpE16hg3dQmw3A
 LxSwvQk9N316+8PD/rlnlZtIt9HFf86qA0dv+HmLGK30BnECj2NtLgCha+K3ZF6dR3U/N1wF15Z
 q
X-Gm-Gg: ASbGnctwzzX/IjmESkWCPs2Jsa+dPmWZ9yaIvdRO61LqxUiSfpTZnjHP07KvNfgQV1n
 XglqPkHmH4iOVtFm1BeoWHOH52utdfljXuJ1Nv2JwZzTHemEXNHOEVwsCkubwXhz/VrxMF3gg6Z
 A67rIFKCTYsQwa/G9rh34q+/FDer0Iho0Jua2frOMHEUetlW+WA7cWRUJxW2XuG9LWtOdMRITbx
 icUeAY6LCoczLqqKiAp8qsJFFRxwGLy2S9kWiDw/U2eLqAYFOi+AGbtgCQVFllyO3U5XoBd4YN+
 riUfpAxd3pBXJfI/WcWqBgBNm3jkhgLPogTx4N7f/R6hPZ8JFl/I/WWNOX0t0wazXqIjidBoD3k
 =
X-Google-Smtp-Source: AGHT+IFi+BC0VDcMYteBT6JzCkH6q6H7XNBlf7BDHKbxwsbSlRIPFVgW2yR5AAD5VD7B+EkOnr/b4w==
X-Received: by 2002:a05:6a00:2a09:b0:73e:30dc:bb9b with SMTP id
 d2e1a72fcca58-7409cedc8b4mr6570611b3a.2.1746652388741; 
 Wed, 07 May 2025 14:13:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 08/24] target/m68k: Use g_assert_not_reached in
 gen_lea_mode and gen_ea_mode
Date: Wed,  7 May 2025 14:12:43 -0700
Message-ID: <20250507211300.9735-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

The mode argument is extracted from 3 bits, and all cases are covered.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index b9633e06da..f87eff3b10 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -768,8 +768,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         tcg_gen_movi_i32(tmp, offset);
         return tmp;
     }
-    /* Should never happen.  */
-    return NULL_QREG;
+    g_assert_not_reached();
 }
 
 static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
@@ -893,8 +892,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             return NULL_QREG;
         }
     }
-    /* Should never happen.  */
-    return NULL_QREG;
+    g_assert_not_reached();
 }
 
 static TCGv_ptr gen_fp_ptr(int freg)
-- 
2.43.0


