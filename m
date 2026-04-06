Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE19F46C45
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVX-0002vT-MI; Mon, 06 Apr 2026 11:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVS-0002tb-VZ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVQ-0003r3-Qr
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aaed195901so17216445ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487887; x=1776092687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0wgNLa9n9Vgc0kuCG4RsEiFVidf8BLE6jw9JT+iAmc=;
 b=jHdLgVc6F9d9iMizDFKaTGp8UtmXUyy9wSYh+p1RywX5OUi+4stw9M8mMAnWRXfFC7
 Ykk538QfxN9g6PF+tnZYXeJGfPBNsNv4tpFi53ebkwdMRIUEPM+9CXhRcGXZMYUEmhU0
 w/hGeHCKMhuvzJuJU0wJP0rMl3tWCgsOYz5aP8Y1R7tpYaf+3ZmL/sMgwbRTTKsSX4p+
 VRE+KWMXqTOePBx97eLzHd9MelduFRFZNKj6NEFpoJY4HZ/iOVcTHhBOmr9KwUyO8Ueh
 vk4Jlqtm1zvADolTEoi61PFlOpHDb7m7yfK6kwYglQwyMRmbSGYKAPzTKC6ljtaMS+tw
 /vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487887; x=1776092687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n0wgNLa9n9Vgc0kuCG4RsEiFVidf8BLE6jw9JT+iAmc=;
 b=sEbHJdx+hnjXG0KCC31CW/dK+UVKavZ8cLwlsKQ7n3zosC9jGGAnHBRKY2gOfECyib
 IpsqeuOvOe1ZVqhvOP3wj4uYqhgfPjZepOQmYqr+MfZLIoR6xQhFaj9LaMAdPL7GnLIU
 8U+1uuVt43nECOaINzTxg2xtPjQCA4sjIsCNZrJrxeLBNruVo8irIr4EQUsTXuXS+pYn
 XwAXw6dbkjK8jIfhkIygXLuDRUGqbUnOSm9m/RseA++pwKHevJAp+9yawYO8aPVUFV7I
 ogJG+DhY3EjFXBbz/SjygIlbqYv6B6uXYS6XGkpCHZNMhrvDBrkavoGqW0ifS5Fl2p+t
 kvAQ==
X-Gm-Message-State: AOJu0Yy1UJ+PM51ucDkDVxurr0o2CTy+pyEmNoUreZTh3NdDI6q4lRXb
 GCOkh0N7cgCb09aOJF9lQykpm+Z6IC+obEr3i/Nd3zCc6AYSeMqlTH2tsgqCko7jyEB4r4Xx2JJ
 mWwNXPg6qwg==
X-Gm-Gg: AeBDietkNczxBi8UN6M9qfTsTz8ucFOd1q1tFLegdlZkUd06Tmp+24awO46MAycPVRY
 YabQWY8W/gLI1xjR+9sh71DLD2TBPdxvewHu0avSBZl4PFa0QzYBIGdpZObWNW4XsmyClxbBRce
 FygHORTCJqHcj8+q8pLLywW3uGaHBgyx2yOVncL9l9n6/LZgBJVy1uzr8W/atynU0gIWy7JcJU8
 BQTSlt0GdLsDxkAXJZF0mO44fGJ9xGD8j09hyV14bsW/IzLi24u/I0A8psx8CiSYr9cvRx0UctV
 C2XllGm4HAxN5dFb1i7uQ3yGjqkAKQwQgPDnzGEgFdbt5SSGv/m+AI1DtwfoM45rz4eCJGeFBUn
 ORySUx1xeW/UOVnIZBAtw4vnGKcAx1yHvkf0/rGa/fvg2iPOqSdizGnHAefZs90+QtbC9wegi3k
 zNpaqUETMqCNix1yTiekLu32e0QIDOyeMfPRR79gdBLEzLMusGcizMRJHNWP8POLQdNCNic33Kh
 iTG
X-Received: by 2002:a17:903:2c05:b0:2b2:6df1:10d4 with SMTP id
 d9443c01a7336-2b28182d46amr140828655ad.27.1775487887364; 
 Mon, 06 Apr 2026 08:04:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:04:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 05/14] target/arm/tcg/translate-vfp.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 08:04:25 -0700
Message-ID: <20260406150434.407201-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Generated decode files must be duplicated between user and system, as
they are generated in private folders per libs, and can't be included
otherwise, as meson does not give control on output folder.
Indeed, meson generator is a different approach than custom_target, and
this is a limitation by design.

They were already duplicated between arch variants anyway, so nothing
new here. They will now be compiled once for system binaries, and still
per target for user binaries.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 3e96c77df73..5f33ecd76e0 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -5,12 +5,15 @@ gen_a64 = [
   decodetree.process('sme-fa64.decode', extra_args: '--static-decode=disas_sme_fa64'),
 ]
 
+vfp_d = [
+  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
+  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
+]
+
 gen_a32 = [
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
-  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
-  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
   decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
@@ -30,7 +33,6 @@ arm_ss.add(files(
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-  'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -60,7 +62,9 @@ arm_common_ss.add(files(
   'crypto_helper.c',
 ))
 
-arm_common_system_ss.add(files(
+arm_common_system_ss.add(
+  vfp_d,
+  files(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
@@ -68,14 +72,18 @@ arm_common_system_ss.add(files(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
-arm_user_ss.add(files(
+arm_user_ss.add(
+  vfp_d,
+  files(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
-- 
2.47.3


