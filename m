Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0CF10F284E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AJt-000797-IS; Fri, 27 Mar 2026 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ1-0006eO-HS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:09 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AIz-0003AP-2V
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so15932405ad.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629902; x=1775234702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76pt2dDyK109O4DclIsLAZjjAPxT8fp7+YkgIE/RghQ=;
 b=Ey1X83cdOMlCPM4H5iNWELb/lkeqRZ3D5AHy4S50D0OGsZEhA2d0+O5sXv7yVlQsCS
 GiC3l4Go2wvFdGEXW5MfFKJuuXWDIIcywBQpNyOAGXUhXU547rMuLfzlMVxih8QawbZz
 +OQA2J74fUNdxuQlBCCPCUuQaCnMGUYKE3eUCE+VPbx5POM5/ZpeoEMWR9ltq9ai24e0
 gK9TVwoQz+5bCs8elUw/1IAaIGSfimt9kRl9C2wz8GWmRetI1XZfoOV0xXFAr/jHHBNk
 xal5+uYsb4vhfwzCnegVqdPdXWwe3l+VdTVJkKDJBkQqcF7ZIWa33H1n4oP92O8jl8/8
 LWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629902; x=1775234702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=76pt2dDyK109O4DclIsLAZjjAPxT8fp7+YkgIE/RghQ=;
 b=tN3q12EFzD8WabKBfIcpfAg4zH2dQ4ZEYN9t4/rVHlT4PWafJ225V8rB5tGQpDOZPO
 uH8JDVX1vsfPQ2+u2VuBgQHJzpUX2iUYIdCIrWLu1PO7B1n3IEhBYbOUBoSLCUXrGAUS
 sEj7CPTs/Pq/xjD0kkbdo1pzvkewnJErdxlH0IQTsM5PEG17s3eLf6fvGxV8KIBnJtb5
 mxOTysrrG7KpvmrUsxNS9Iavq1ezCmX3FZL9vD4lF8pmtrcM2NA4GYrmJkjBQYsfFUyH
 SnrrPGn4NvamGiLwX2oyY39fuGTW9hYA+ybJy3a8QiTJaKc5Fm2kw6sN6by2JwGG7MBV
 1Ihg==
X-Gm-Message-State: AOJu0Yy+mnknk1iJs/7w5dZ17/Xj2IfQBqoF9Gu0RRGQYy/U9sbIR7Ql
 /bSHPy5mKV0EkV6NniAD14XkR8tX6iUnsBIWHEd6V+/0OARr+/XzbXWWdXEFZWa+zv2knQjfIpB
 Tf5JIl18=
X-Gm-Gg: ATEYQzwWKdozUgCi4uefRNWWD8nWTkQUtLDFC6u/UDfC5qpzLNtBWAG3gm5t1yliiOA
 1nTxzOqRuL6QQa2kjAmaOi9YBLSMiMiRTxaEk+0uwu3tbgpW1T4+N7vxmJAYb96kmc3i0LheuAa
 2TWtlw1HZAqvl8awZcjLppQOtsJcrHvi+lfwZDxLJ0usorGpZzVPpPbRQaASloV12hIkEyGLg2Q
 EEuiT967EX5DU2Owu+cnLtjS5FOJwFdG5xhAdsjmEv8Atqm8vf+xEa3xaa5lfbpuQK3Xv7qwKB0
 mg3GEOdYAKNFyzpB4l5GQilFD4o5HP3xVDQQQsBGrLSuR3bvDmZzhAu3yC7qwcl04WBUBYMbsEU
 Yrq1nqr/v/keePibhi8FpG1tabkOfjFVHx2IWpneJlqRx7HY7Yt4jscfGj7pYtJrklkpe02Zj6d
 UOvqaCe08cutPgIaUwC2jYRlJVzQA3oiGPY7IUdTRdR5vrn9nood3ReyEEhhLCJ0VMhCYGa1TOg
 jJs
X-Received: by 2002:a17:902:fc4b:b0:2aa:d67b:ef96 with SMTP id
 d9443c01a7336-2b0cdcaa72dmr35335915ad.31.1774629902165; 
 Fri, 27 Mar 2026 09:45:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:45:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/12] target/arm/tcg/translate-m-nocp.c: make compilation
 unit common
Date: Fri, 27 Mar 2026 09:44:45 -0700
Message-ID: <20260327164449.596767-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1e9c147e4d2..eb87eb63c1b 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -27,7 +27,6 @@ arm_ss.add(files(
   'cpu32.c',
   'gengvec.c',
   'translate.c',
-  'translate-m-nocp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -58,6 +57,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
@@ -72,6 +72,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
@@ -83,6 +84,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-- 
2.47.3


