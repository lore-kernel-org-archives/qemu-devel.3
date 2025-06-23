Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B43C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg8v-0001KL-NJ; Mon, 23 Jun 2025 08:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8o-0001JO-Bf
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8h-0000Rd-Em
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450dd065828so29515055e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681143; x=1751285943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4jpPoIjWAnN20gltB2a/vOsrmaIk3+mmplMj5/YsrY=;
 b=yy93QNq4f+Oejjx68IoiEyOi3BqS4na1cZuzt3g1EOhgE82x/1QYEy4B15U1Y5EHzA
 dn5Ni2fVzhAtjTDVfXxD9xjQumlzZfCqF3Ev1xQ3XVMNR6Pwh2ePEAIxIn7/EO4bzREU
 dnnmfekN9qXnbKUdOJlNKRjD+hGjzMFbQSAtb4vd1EVW40kHNCPShG7sv1cBU4dxHHG6
 bQuVd58pKAiBeFVVCxmrGajXngjgmE8xo691dz9PkP1oDlaXFUOeqXlg4x9Ulo+h+zLy
 y50L0ZnlF7F8PVXkMPu5s8HPpLo4F9174F9el4eRvfBe0o1ZDv43DFMd/tyczDzHgBf3
 SgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681143; x=1751285943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4jpPoIjWAnN20gltB2a/vOsrmaIk3+mmplMj5/YsrY=;
 b=xLAMgS2lgqGmoqSu7q8WGHY7E4l0zkyRSwcifwjw2jHl7KNoD+c8Zxve9xEUxZUodP
 BbgEiuI1gSTxrArMO0jdvwcFWnrRIf6/+PN1lYMqwm30g3BzLLzFKcYk0yJJZECxqQgh
 INXPHPE4viDpQnbxYZWvYWAMEbPl3tWC+Wrbr1AWHYNmhM2fgpT+lCM7VsNK0SWiH+Gi
 hYCx9oHD8rN9d2o/oEwi7ipqI7rpBxrhA6Q1HAfocpLWcQK0MaKnOY2Fk0dX2L8GFe0C
 yvgJOdZOcbGGAxrmWebFNHECELdYyauS6Gcmh5eZMhjsejpom2cqrW4iZ6J0DGxuyvfE
 v7rQ==
X-Gm-Message-State: AOJu0YzaymN4PJ5ECGVFqfZFhg70d46+nIwg/Vtj9g6g52fgp51i+eQe
 xbnQDaHdB/lJL8juZjrby8sFHwhjdel3D6RZnLETsjESr9CUwA3moSBplAozcnZnS8iCa74BWpZ
 wIuOH
X-Gm-Gg: ASbGncuFB4HVJ94QEZ4wLfYwwOoDg1F373BUlF7ADt1silyIPIuyO60yIlH1J+3HaVV
 qCrQrn0nWHmEQ2zh88sw6Bjw//WO2Olv2qy1luKUyEml1FMAcRuWhFWCGInn8hJ2PfixwzNCa2o
 48t8ZbKNNt4D4UOF6x1d0kbQEUUcmPJLxzOQrFIK9ON1jAIBP0HGzYduhqEMWEZRqoSIzkm4yJR
 fdIPZSJoweAoBUQLHGay9ItQd33j8YDBTPvcMYz8p32v0v5mM8cj7SQ6Mlfvigee+Gmmb3rhk76
 XjlMjkSss4BHm1qWzQ1Sunna1wxAL/OMwY+M6vY2RTZzFIQAlDVV9stud1nDg6HgfPKlM3frVyZ
 SMh7XYuntRC1W2oi0A+6k+8EJwc7Gdxo1kHYZTnmXHcY/z/8=
X-Google-Smtp-Source: AGHT+IErlri5hkyOBSvRe8fCS9DDCc0yz8mXpTeS1g951cmKKKfzy6/tEWFiO/Q3SrTle+JMSQITVA==
X-Received: by 2002:a05:600c:3ac7:b0:450:d019:263 with SMTP id
 5b1f17b1804b1-453659aef70mr119085105e9.18.1750681143141; 
 Mon, 23 Jun 2025 05:19:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f189cdsm9443362f8f.35.2025.06.23.05.19.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 03/26] target/arm: Unify gen_exception_internal()
Date: Mon, 23 Jun 2025 14:18:22 +0200
Message-ID: <20250623121845.7214-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Same code, use the generic variant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 1 +
 target/arm/tcg/translate-a64.c | 6 ------
 target/arm/tcg/translate.c     | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1bfdb0fb9bb..0004a97219b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -347,6 +347,7 @@ void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
 void arm_gen_test_cc(int cc, TCGLabel *label);
 MemOp pow2_align(unsigned i);
 void unallocated_encoding(DisasContext *s);
+void gen_exception_internal(int excp);
 void gen_exception_insn_el(DisasContext *s, target_long pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
 void gen_exception_insn(DisasContext *s, target_long pc_diff,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ac80f572a2d..7c79b8c4401 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -433,12 +433,6 @@ static void gen_rebuild_hflags(DisasContext *s)
     gen_helper_rebuild_hflags_a64(tcg_env, tcg_constant_i32(s->current_el));
 }
 
-static void gen_exception_internal(int excp)
-{
-    assert(excp_is_internal(excp));
-    gen_helper_exception_internal(tcg_env, tcg_constant_i32(excp));
-}
-
 static void gen_exception_internal_insn(DisasContext *s, int excp)
 {
     gen_a64_update_pc(s, 0);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 9962f43b1d0..f7d6d8ce196 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -372,7 +372,7 @@ static void gen_rebuild_hflags(DisasContext *s, bool new_el)
     }
 }
 
-static void gen_exception_internal(int excp)
+void gen_exception_internal(int excp)
 {
     assert(excp_is_internal(excp));
     gen_helper_exception_internal(tcg_env, tcg_constant_i32(excp));
-- 
2.49.0


