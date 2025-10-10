Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E051CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77EE-0001gU-F8; Fri, 10 Oct 2025 03:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77EB-0001fv-VI
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77E9-0007z5-D8
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so2007569f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080062; x=1760684862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf9zsMIIBLVPDxYKWcw2p2yBA08+F1bZhOqIsBLAVw4=;
 b=dNJDHtY75CjQp1oHPghUUb5pmrjEGdprD5rGPhtcxZEoBAy7GDi9bUIyGaPLm4cW86
 S5xlC2r+0lX9wdN3eeUyWq8oQlqifA7lLohMan412AVdPM8b1FpQM+1tbcyXqqefTSET
 buEQqWMAgEh964epO5thFZGe5meyqXRIj9+AHN/miNKHDI1m3CLPAr4UbiaY72EBRSl/
 XhZnWHRwROY7St88S5R3yzx5OvNCxn/uvPAEAv8/gZlTGTmjOC5hHqJUI8WGdSuhl8TE
 jKxKQ5eYHnUWwtftQw5ngx6nNC/r/jl447YjWKBNalJp+9nTUijic4jYdmt9w/1DFyBP
 k2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080062; x=1760684862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mf9zsMIIBLVPDxYKWcw2p2yBA08+F1bZhOqIsBLAVw4=;
 b=JoZJWNt/NL+I6N9GqIVZw2a2gDbJvYdl+WrdLXavs31HsGM5QbLVHMpI5di3ARSgpM
 rWwfb5jvvmyD8tTp9uYXw27/1bOcoY5Iy6mLINSmsLN0CRVhIRjGyXuTy2nrd72DubeG
 xtl/Sv9tisUonKiAz9R3KECQ9aUCHxogZWGz1GvmCFiHiKWFbuzMWHU/qkJEyku39hZ6
 F0DpkrliAZbV5vXVqyYEbuwtAPQcu+AiWHZXcOwq2dP6UXDiIMWvqW0UoSbbBqwu2gUD
 JA63VodXgNWfhlM5oT5V0YbDXoypWvUKKKwflIT3zf2xPWhZWXSxwoeiQTolft+PqCH3
 zNKg==
X-Gm-Message-State: AOJu0Yz21dMWsp+3WDoQJwXqlb6emPKTwEGIEqPWM8bj+ti53wN40smA
 8frfizKj0oVLqopr5naX0vIX8+OBVbZJ6U8xv94bjjSxvNgIMcG2jFtG6FEQMp9WL3U51IHvSlu
 UZ25WlpjUwg==
X-Gm-Gg: ASbGncuCTB7mxWbd8a8CIrB6yWrwopoYapZgy+iCG4+Vxh+vZUFMKOzVP3JFv+Ww/4K
 /V2lKlgtrpwfVZ+dhKUf6p46i8jhre+I3PPJG8JJ3veZstVE78ON5RY+V8++aD/PJ+z9R21YtuK
 ult/aJNpcxk3okuuJD+WHpFhzVAAR4U3ugI11PdqMkkPgSIhfQD7kPeWdPetFrMq51iA56hL7Ui
 B7hmYIC6b3G7UgsEB1oOqUVkglG8/WAgbj8WyW9coyFoNuX+KE7odRJe9X3SsEM4KE+6Zi0y9kb
 bKY9vKim+j3WheQdZCTnySwEWobINJ44boNqUuWq4yybgtImt7VJCxNUguibyRbC+yb7EtLV7gv
 ekipW2FFp/X5Nl24PDaaSS8tU02D4YWxT8HBuUdQPu4WIzmK9KqlL31mC+nO9PYUuYVvflLfOjp
 2z/FldykwqqJ1LqB7pvAw9mev3
X-Google-Smtp-Source: AGHT+IGfrD7tkaLRS07kjtkosus6HhoxKOuungcVG2rjaC2yZjJNkLInQJ/SF2AHsRIGaunLvs4fVw==
X-Received: by 2002:a05:6000:420e:b0:401:c55d:2d20 with SMTP id
 ffacd0b85a97d-42582a04d0amr8691472f8f.26.1760080062289; 
 Fri, 10 Oct 2025 00:07:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce50d70esm2793477f8f.0.2025.10.10.00.07.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/13] target/openrisc: Conceal MO_TE within do_load()
Date: Fri, 10 Oct 2025 09:06:56 +0200
Message-ID: <20251010070702.51484-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 52d51313f77..fe9128ea2fd 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -633,6 +633,7 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
     TCGv ea;
 
     check_r0_write(dc, a->d);
+    mop |= MO_TE;
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
     tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, mop);
@@ -640,13 +641,13 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 
 static bool trans_l_lwz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_UL);
+    do_load(dc, a, MO_UL);
     return true;
 }
 
 static bool trans_l_lws(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_SL);
+    do_load(dc, a, MO_SL);
     return true;
 }
 
@@ -664,13 +665,13 @@ static bool trans_l_lbs(DisasContext *dc, arg_load *a)
 
 static bool trans_l_lhz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_UW);
+    do_load(dc, a, MO_UW);
     return true;
 }
 
 static bool trans_l_lhs(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_SW);
+    do_load(dc, a, MO_SW);
     return true;
 }
 
-- 
2.51.0


