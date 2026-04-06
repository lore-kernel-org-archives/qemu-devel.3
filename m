Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F539F46C69
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oei-0007PY-9W; Mon, 06 Apr 2026 14:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oec-0007NY-2C
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeZ-0002NF-DI
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82ce09b61beso1826133b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499986; x=1776104786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EreTPxkuDGzkWgW1EVVjJMJZdSsPzYH3Oe6Wk0cickk=;
 b=NRv7OkIpoHmYNYkwuqrygGFUfzGfCfrQRw8Jhv/QJCiTgT6YiLNfWIbb+oYIqIHiS3
 hkvNV1ZogMA9kOT5Aa3BBZ6aO6Qm0BCLte8Phyq/ylNTF8DGDvAV2/W0xlUuIPC4eSda
 o+4/zQkehQLjm79sCDuhy7FETzNWpI6uxRDHtYZ3Zh3y9Qq7nGrf/9bCxKrg1i4u1+87
 GHxayMlsCbNVtWF59mLRSDlXn24UFGglJy7uFrBxipm3vvlj0qpNZ0iEQL902deP1eQw
 5CQmhYDLQfUvvqR1h1J1yOVoCiVDLHEsvXzqarVWP6EOecTidNS36AHtq4qGoDflrEdK
 oZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499986; x=1776104786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EreTPxkuDGzkWgW1EVVjJMJZdSsPzYH3Oe6Wk0cickk=;
 b=BRGNvAC6OeNCBa6Ecz5+jyAoRpZl/tikGgIL43n5cmDqgvP82wLCanZcYnF6C08Cco
 4xPy0YrzFPBtKZ5eaDca6SYD8PCbrFjudx/xHDGCxArswcudKHjxc84VGZjwkVhSdXpf
 bxqrLCnaT72Q7xG8Z/t0h0ATkyRuqFjJlFA3ADXU9+VVASgnfBHtgO4z5mFKPZZaxXG9
 LUQVyI+OsyOe42Nd3LQvu/UD1803Ee7d5whvWgYScv0OH1n8zriaP1dhiTeRMdwZ0N4y
 xKwtmP9y1tvPVJVoPZTmYfGypCBG1HCY3VD49xiIOaCFSiaI2j79lWmy7vre5rZWmfaN
 s8kg==
X-Gm-Message-State: AOJu0Yxrk0efQHooR+ChIyCUJyWj2u2YBv+6/52MtNQ84rEwiNJSXv5V
 whv/PAZGQqSu/RYza/MfkqTIuyJE67b+hPuTNnH5l+5gO2EbNIapJPmjAVvfZr3GarPZBn0ZYFX
 v+/AlXYU5/A==
X-Gm-Gg: AeBDieuqKOSlAUDv+XcN0G/6MQqMYO33FEyGLxiJlBQNs4iRgkEZSJW50ChZ267SaHH
 gWM6t4ON38oRywLuMvMHaPMvRs8+m5iJBp6oGWIRCThVdTEhkeJn33pnTAQ7W96F1sdb9JeNXrg
 7Wgkxo2Pa0pQKKR+D+BY1tQvvUga7IbiTaWbE2q/6OR+qBLKoNEKNCZMREOXl0+YH4RWfj2UdNt
 QORgBoAuSm0Bbj6YZpc+4Yoi93CQB24b73zK/ayhCz/x0tkY83zkNqADfZ0GJr29H8Yc+r6zoyh
 XVDxQbrWBrGg1Y50VyQ11wUbiwCJWcxXogLiufwQAo+GBo+CD/mxgjctLW31lxzrGGw+eqnUEWX
 jcsBKS3kL98+l0YOo1LwwdH7omCGr2PA44xNd9Mkyt5cgpOo47pvWWjuN7Qc3BtNMS7tDPBzAt9
 VevESk7zo+4Oc8druZhQnqCj1BEFZYFtj0+grIiIa8CfWe2/Oflw16X5ed5uY6YalLAgKR4u/9D
 9E9
X-Received: by 2002:a05:6a20:914e:b0:39b:c3a0:9f31 with SMTP id
 adf61e73a8af0-39f2ee01f55mr13417453637.21.1775499985771; 
 Mon, 06 Apr 2026 11:26:25 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 08/20] target/arm/tcg/translate-m-nocp.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 11:25:57 -0700
Message-ID: <20260406182609.193886-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 89c3b476822..70beec7a6c9 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -18,8 +18,9 @@ neon_d = [
 
 mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
 
+m_nocp_d = decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp')
+
 gen_a32 = [
-  decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
@@ -34,7 +35,6 @@ arm_ss.add(files(
   'cpu32.c',
   'gengvec.c',
   'translate.c',
-  'translate-m-nocp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -65,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  m_nocp_d,
   mve_d,
   neon_d,
   vfp_d,
@@ -76,6 +77,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
@@ -83,6 +85,7 @@ arm_common_system_ss.add(
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  m_nocp_d,
   mve_d,
   neon_d,
   vfp_d,
@@ -91,6 +94,7 @@ arm_user_ss.add(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-- 
2.47.3


