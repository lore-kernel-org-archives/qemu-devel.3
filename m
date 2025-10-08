Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D226CCCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cD7-00019T-Mk; Wed, 08 Oct 2025 18:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCr-0000aP-1c
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:22 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCT-0007P0-5r
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-78f3bfe3f69so271560b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960793; x=1760565593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bjs2KSAaFbdAG1b499mTeRXJBukAcX/iNNZB5CfLwbQ=;
 b=eEOBtiihkPmma1eqLoJyn8m0MVL0ck+wCja8zrAovNBgh1CArO5oXPQ8jFaMkHYduN
 9is67LWqvASkVYhXBJoPzuiglYTtrlZi1OLf3pDTlsBYI6LnxRyOwgxdHxjryQkLohgY
 3riQQa52GN08sVu80DKoU3knI4fhN6ExVGCQnZd3SVuxz+yGPyLJcPfX7j8ZIoLHboUd
 kxXcZZu/XspHdXPOL4MpxrPsDPFLxfXkXZjGL5u2MLAseyLzUDIZwof/iuOkGR8bdkFT
 p4btRvaD93tC30nhswLczMr65oF0lAbTuIP7+4aWqdoc4HtrNjmXj5K4MpYxdxXVrLlo
 Q5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960793; x=1760565593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bjs2KSAaFbdAG1b499mTeRXJBukAcX/iNNZB5CfLwbQ=;
 b=chN5GKxe8uyqwi/Rple6SEOhqZX0zGiYppMDH+3Uf0eWWLP952NHWNEHcb/DzEVRUv
 owd4CasYOmYiFsAK6LgHHccfo3ZFmJARQ3O5m65JLODxCJMepk/KsOLpo9iO5tJKODMe
 Edg9VjEkkXanZkk+Q9R/diAFY1SEv7W5iqatuM8J4VIGqskjJf2VmJhdtMy+qlG/UiBT
 QywUi9KOOPb0gIagIMyTyeKW/Qw0aMxgj0fCZvjvMKIpW7AT3+kdxGwTsQOL8TvjG75S
 +jiLQZwSUCLIkWRcS2xTK37KSRJPvltskTbYbEFYiYVN+6DCF2ddVQDxO/lO5+r8HQY8
 JCdg==
X-Gm-Message-State: AOJu0YxgxXKEwbLdv5EfFP/8DUInyNCZ2Q9xFWYEbir+RuZOuFZ9Tnyl
 FuHri5Bfbgce+oBlXEWSqgp7jBrCDxARUA4/8axJ5sMq7Bi8GSQT1OkzlN8LJTGNZJD/JGuUIem
 Q0a2yXMs=
X-Gm-Gg: ASbGnctzMOXwL5uVPTog4z9d6nXjw+VB3c1ks/FRePaV1w1VdHDZ5pqq1ub4GAlfoU7
 ghbSEDM66l3HudYrPn9ExCYl6ed7Qigxe1U1dB8ToF3OJhUvCeJEfrW6uklZ71ZOU4keiOX/deA
 3dv3WmXIDPZlZRgYGPDbWEvcBBCHJ0P8pmBi04enyiLMNXsUWL1SF5FCH4rXZ//hovJSx8U5jIi
 7uZaIEt71SOAddVKf26UN7wNfQGvG14gB2NPxeg/G18Iqe/7kf8gs1xZl03gdZP4upYhGfFZlH+
 R107t8nwF5xz7hyOCWndcfQmNph5r1fpqsZywNu0oUdPMwBqa33BGmYF39S5mW7pyuvm8aS+VFb
 VB49E1HxjVkOuRwaU58Iwm//tZvoJ07HCmYltsw+PvWy8vvteXZD9diZamtrpQjNugLw=
X-Google-Smtp-Source: AGHT+IHr6eY8VcJfZSP7GMbeh30NI8HiHwq2mgJDGRdmmxb2FMRk9D6ccta2XDYvZuYUgCTbEBIuww==
X-Received: by 2002:a05:6a00:194d:b0:781:7e1:a315 with SMTP id
 d2e1a72fcca58-79387c17862mr5482444b3a.22.1759960793105; 
 Wed, 08 Oct 2025 14:59:53 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 59/73] target/arm: Load gcs record for RET with PAuth
Date: Wed,  8 Oct 2025 14:55:59 -0700
Message-ID: <20251008215613.300150-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index dfd5b17831..918d5ed112 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1898,7 +1898,12 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
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


