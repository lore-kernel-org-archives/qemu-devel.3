Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79827C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLti-0007LY-Fi; Sat, 02 Aug 2025 19:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoC-0005oO-2c
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:40 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoA-0006O0-Ep
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:35 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-741a5e8fa94so126815a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177913; x=1754782713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+95ujyjR79+yagfD63HNcgJD7lOK+ke9LaFMk4/bVTM=;
 b=W/cJibt97b7N02R/IdXY/0q5rGXo52AYX0DamkvnWWmFEwCAunTpE8MynWCSVnXEPF
 iQxCUO+t1VcVyPytDAjFNpgudmE3njSltXr+QeOSeu86He8Et0A7EX33bMk4fKdfpsty
 zCD6dlYBgI43grhLzeJptDo0HStpal2l7O475Ore68/6wNipbDh3SBQCilgFqlmMZJ01
 KUQdesHarvVtUHjYLXp8Q/Oj+DGkNJjVJ4lxD15srAtXO4jlSanDYwC/FCQAezaQ0Fvr
 lCQ+S4s+Nqj7QsWyPQCqNQ73rdYEU4U/PWT6KsdjbDQse7DjPBHPfeJyCzInpDuIv+rm
 ghOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177913; x=1754782713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+95ujyjR79+yagfD63HNcgJD7lOK+ke9LaFMk4/bVTM=;
 b=SW5S3o7x9YhQb4KDmmSx8Fh8eKkQVvB0arqKtdh4DI2xG+T8C+uYNbpYjBtnJNd81k
 q0TYFUhvZmge0KYNcZOCLMHQtNju4cgSFxfpEbu+VuqgR6KkpugtMfrnzgDJRfdsT+18
 7rY8x54byT157snAcFB0XIlM/uasvTjx2zDjss+VyDQxCDoByEs5+2vGCq8/oho4vjYB
 dzpNu8N/GI1Zn0xrdjXUn6xU1JnDtkPusIxC7gswGQIotBtjiJiHUwE/aUQyC054Ff6/
 GbQEMMUsSCD5gq0A9c7otAYKrQ4WcDPmLF4DJahmVEONDxXq8PxyLgPrLE44HmBNpGET
 5arA==
X-Gm-Message-State: AOJu0Yyw2aMkv2iOeNhN6RwkWBDXmvvMlclPJMBrmp25XGb5MZlhfv74
 4Oqdj53TOTO3byCLIoFw1Ls0E4204PEvmhDn7nzIvlZB+YbsLFOFWSjAnaEU7Vf+S6q4BBGdUDR
 QAduPiso=
X-Gm-Gg: ASbGnctuvcQfAv/Eng8Y69qH5kOnaJvu3Zwjs/epW9btx2DWJMOGRWi0Cs2GMO4rSEM
 o/4skvFxziWMJ67WnHiWVAhN0G+gjh4wf9egYFB5g5JKX/UMiEV0pk8fY/ubbsrSq2iUnyug6Dy
 DTsKcwTdr+kmlPIiIg8Z44TsTGG87ZGUddNE32SbOWTPPBcOKl8df/CbSBVqU0ub5NXdsDGZqqi
 42Yt17Y47fT0TCdoebJwTaQILbLlX1EBIpC2HjM7V2LyQPUEUwqlQJ3PPsF3zquyza3FCDMlR8R
 8FCSQpe2HBtJAKxgpF8PFOZjF46UTe6kG4V4LQwR5zjcpEyfpnM9EI5B+541/9gpns0KoQQkt6p
 80UxAVjTSDko8rIxj73S/9qa1BVdol4+vHfvBSv456uA/tKEzzyEX
X-Google-Smtp-Source: AGHT+IGgEIY4k9w6d93Tg8cM/mOs+27WfhssD8yRLC/6Ql4Cc1ax6aosm+M8yyJ9vbEJ7bybUhvu9A==
X-Received: by 2002:a05:6830:60d6:20b0:73e:996d:cccd with SMTP id
 46e09a7af769-7419d23774dmr1753543a34.22.1754177913322; 
 Sat, 02 Aug 2025 16:38:33 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 70/85] target/arm: Load gcs record for RET with PAuth
Date: Sun,  3 Aug 2025 09:29:38 +1000
Message-ID: <20250802232953.413294-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 49e17548c1..23186850f8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1890,7 +1890,12 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
     }
 
     dst = auth_branch_target(s, cpu_reg(s, 30), cpu_X[31], !a->m);
-    gen_a64_set_pc(s, dst);
+    if (s->gcs_en) {
+        GCSInstructionType it = a->m ? GCS_IT_RET_PauthB : GCS_IT_RET_PauthA;
+        gen_load_check_gcs_record(s, dst, it, 30);
+    } else {
+        gen_a64_set_pc(s, dst);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


