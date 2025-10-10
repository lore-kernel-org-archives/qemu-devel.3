Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFCECAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77EK-0001nk-Qr; Fri, 10 Oct 2025 03:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77EJ-0001mT-K7
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77EE-0007zX-DO
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso1538804f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080067; x=1760684867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOVspSP+Kxf/EK6oDqaKgAk7hxww0q2GmtKO0f8awRc=;
 b=JkhfsiwGME/zNFaBvDcFMm4BIoCkcjZoz3d6GYZ/n06f0sIf4XrQQdgJYzrk96TVLJ
 O608gPslsTNdC2Ym1kTbhX0J/CKkhrZjMlz4a5BotiTRwNnGX+qWoIkS+ZNv+EBTmgZn
 BgE+1oC5rF1NydqMx15XQ8OTFp59Jw7SZNfbWfbYKfpB//w7WHNNVEmVJswotUWpyzzB
 XXpUaZe8crDIAw61WK8jNnvwEvgxwRLmgCXTot/IXAPu3UHX/ygNjFsZ6v5gDofsPb88
 loF1uJcK9BYlKfikzM5V9RIB9TbX+hcIp357wp08N1fCQLoD1Svh4SXeNn6JV7B+dK7K
 svAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080067; x=1760684867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOVspSP+Kxf/EK6oDqaKgAk7hxww0q2GmtKO0f8awRc=;
 b=CPCZvjd542e9PQxJGRGgBTbYL4+CJ0TNKjxGCfsGgzo7FyCXoVhPA2u7yxn17aXobO
 wmhCrVhQivwj/UzWI83HkgIyS/j0mVOZ9qKAnqQLpqvhxDGbUmIQGwvviJ/DPygcidjV
 nuC8k5nq0SB0Nef0qH+HEpQeiZloWwjbELQHCm0EulRCoekZAPMFzLGeX+NYbb3buNWX
 ixRC8u8SzdG8cgb9QtCo836YDKgeTdKEYyO7uQ6b0PVhCNuMAst+ypKkMXWIhm4Wgdzw
 8tAvVJ34nEH9U8erIfx/qJUsKSqOCNy5KBpP7tVMSvNfA/O3O5qj2+m7tE+dWMSqv3xt
 kcmA==
X-Gm-Message-State: AOJu0YwFnha8BfQf1HMndirwo+h57SW14pT35crDDP7Eu1ByVTP5bwNT
 GeR64PQQsug+ZdraXsNasQupzE8pW5zYVae9+zcd/z0bY1gAq2g76a3SqWyX3lA4zoy3+Upikap
 iPQMiNgBgyg==
X-Gm-Gg: ASbGncv+Ju23qp79/J0VQ1XfxHkaDnuvGwV8yHaWISf6x9N6euk7V+iO0G+6v5hdeAU
 wIoYdDCoMP4UgHkF8KHm6lRWdu0R1xWzQWVkx64wdwnq3E/GkPK3PWiOZOf66U837XXGlIyCy6R
 ZIqfu1Fwe0auPA2k43siO2C6CBnEVKwYWtepkUzWx246928Ltq6WGBS1+X8CL0z9VZGf5F8FdTV
 UtCZX6u3CRD9JQf/fyrg8jpziFZHEM7PUnIEMn7WxOF3d2KKOjyhXEzJbEfD+4egjbQ5CZZEp19
 QwlOQWR67lN1EcGYfOz/RlRE+sizorI0yClbrTppxQU6gRHsp2q7sBj2VZKE8vEqc+9VLH3s533
 2YiNRH7BfqzEQvQpOSV7555BqxIKzNHu8yd752FFXONy36jFcXr8N+dGA+zhZ05yTRcooC0sAzS
 glWX0Uc4602vRZliZTmZfAVo42nIyBN56EN+I=
X-Google-Smtp-Source: AGHT+IG6Y9uietR/PNAq4XvblodG1NNPEVAl+rWBezRYagcK4XgkPEIfiMmzkDIz4OdX/U1rMTJj3A==
X-Received: by 2002:a05:6000:3101:b0:3e9:b208:f2f1 with SMTP id
 ffacd0b85a97d-4266e7d025amr6783834f8f.29.1760080066916; 
 Fri, 10 Oct 2025 00:07:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce589b3dsm2747375f8f.24.2025.10.10.00.07.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/13] target/openrisc: Conceal MO_TE within do_store()
Date: Fri, 10 Oct 2025 09:06:57 +0200
Message-ID: <20251010070702.51484-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index fe9128ea2fd..7363c45425e 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -705,13 +705,15 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 {
     TCGv t0 = tcg_temp_new();
+
+    mop |= MO_TE;
     tcg_gen_addi_tl(t0, cpu_R(dc, a->a), a->i);
     tcg_gen_qemu_st_tl(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
 }
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TE | MO_UL);
+    do_store(dc, a, MO_UL);
     return true;
 }
 
@@ -723,7 +725,7 @@ static bool trans_l_sb(DisasContext *dc, arg_store *a)
 
 static bool trans_l_sh(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TE | MO_UW);
+    do_store(dc, a, MO_UW);
     return true;
 }
 
-- 
2.51.0


