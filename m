Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55152F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtc-0006PK-0m; Thu, 23 Apr 2026 06:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqta-0006OZ-UZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtW-00022r-JS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so3461258f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938569; x=1777543369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZrQIDmttclUaAXYpJi+mOwzJolfVOzUQMfv7ec7TVxQ=;
 b=CKXS6mjo68XFgwW9fk1CqRuwe4mg1DrK1FP857sYX+gaiKmaqGTqyE5y0gbJlZGVGK
 qaAeBo8w8qNuNNbdyzSXkH6jWGWHEyysx7G10qoE3n3djQvZ23jWER+ftinxtX0IQ2zM
 UAc33WOsfQEgwltIz97/XU0yA32DUnG34hk1iYmGsErDkulbw3wet5Fa6PKIq7DZPHE4
 YTyq6asOjaSz55/5NaXbyGVtD8oEIKEaURXENclwHuKqJh8WEN3U+W37OTDNVtUYItiG
 jbKXujo3y9ii3UqBLa04X79iEZhIfZCXDOgKlTD6GD2KCuq6B6h5bzadk2D4pnuVzy2P
 RfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938569; x=1777543369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZrQIDmttclUaAXYpJi+mOwzJolfVOzUQMfv7ec7TVxQ=;
 b=hOdJ/s96J6/xHeIKtFGl+ZKHK9I1CTjXgb2P/gYoydoy/ADVg7nnRKIt3MhKsTaNYn
 qiIy3KUs4A3cpOmKKz5xnELSlAtrnVEVV47wIBm63+BbJnmwLuHHaGIVag2IojWN3Yzw
 IzziTY9djfetPeZF3U4oO2esMGDUUcO76F4JU+cwMRXTb0mwz5i+fAzA1vU2waX7aq+G
 oLjsnJOij7k3jOfbrhu+ziVC+Fv3Tu93lsT2SLkFKlPUKWYQd5NWdh7tGZC/R2t2QiIU
 SEFUUVJBai2N2jq7VkKwR4zpTRYtC9NiMAI6eRBR0HYRrwz7B9WlbB4j7IYSLoZL6M5q
 xiNg==
X-Gm-Message-State: AOJu0YycfpRGU3j5VAZ9xB/EfxBV31q1ZPy3QKNTQq806F4uDjA7kTFJ
 KHaHfU4/o+C91W5E4GpwQsS1u04kOX3GC/rNjzTll3HDS24wYakDAx3bvZVQpIQNyamuH1yHTDh
 g3PN9
X-Gm-Gg: AeBDietRyqwtg65aoOEW0paoSQtc0qpFBsSWfl3aDHH01bsx3p6nPY6vzyLm3uVu7g8
 1OY9rdaqkeLn/goap0jBR9yAw6vDg0Bip6SvOftCd2p5d4cMApnkvYSqER0nOGhq3FtwepAs8in
 fqhxXwgiqlsea6LyKQognezZjqJjcFfRs1icqekcV8a9K8qGxK6ven2mXmCT8tzyM0HLaxvLaE8
 40pbL8EMxYmHtuOgmC/UH6E6GzJnnkKy+x4qPUUbK0VV1MakHW9gwTPR/FNkIPHGLspXCoPnMLk
 +ZxyUH1TYT+u6g75pEjWXEvmwUeuRMOwDZSBDbvh2lGyWWpZ0BZwhMDhwOlE7K5ti5z1UULZrKT
 eyNK3cL1KadFw7paIJuqBh+me9IimQWv5Po6q7XxhzOp8vcYuxd2Xecn7SYkvt07qpR7wc6gFxN
 IZJJZQaySO09xUhvloufFPJ3/VIpo+Xjd8nuh+TZJ4uI3hF8VW+YwuF+kpe8rpxzLAMzhnLWmE7
 bvgL9pkBCiHoBHM3GCtUBqrlESlHAWWH4SLa+XplA==
X-Received: by 2002:a05:6000:1a8b:b0:43d:c95b:c46f with SMTP id
 ffacd0b85a97d-43fe3e0be86mr40645237f8f.38.1776938568473; 
 Thu, 23 Apr 2026 03:02:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/59] target/arm/tcg/translate-mve.c: make compilation unit
 common
Date: Thu, 23 Apr 2026 11:01:46 +0100
Message-ID: <20260423100229.2941820-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-8-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 8d9112f6da..89c3b47682 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -16,9 +16,10 @@ neon_d = [
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
 ]
 
+mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
+
 gen_a32 = [
   decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
-  decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
@@ -34,7 +35,6 @@ arm_ss.add(files(
   'gengvec.c',
   'translate.c',
   'translate-m-nocp.c',
-  'translate-mve.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -65,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  mve_d,
   neon_d,
   vfp_d,
   files(
@@ -75,12 +76,14 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  mve_d,
   neon_d,
   vfp_d,
   files(
@@ -88,6 +91,7 @@ arm_user_ss.add(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
-- 
2.43.0


