Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6775CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufP-0006rC-F0; Mon, 19 Jan 2026 14:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufL-0006oC-UY
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:55 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufK-0001UX-2D
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:55 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a09757004cso41205145ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849913; x=1769454713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMnuo30GCDeWWxDDe/w68HWaxEyzphEdDTKSqE6c6wY=;
 b=fFJFqyAOxpSmmsyRaVUvLGlNmFak5LmbDLXBH+aI/VnuvsjT2D1BFmOpW5g/nmQn94
 bTK3JxW++6EB1lZ3T1NmFqV2I65EZhVkmvMAf9Z6anuW2++SMGKEcKZbNbS4M3QYkHZw
 ptRwZRWelMZdQXEsC0I1t5WwJrKi4Am17pxUm7ub5SqSo5IlrD55xW1giUdEwPRMa5WF
 QHRcvcVXeQsMUdWLbWVheb5GUpwq0S1W+X8PzUEib+r8/3C+SVdNvpCtbtFZ1sLMf9gM
 FlcWwjVUehf1EhxNxmfK+0jm7voEnJ6IL1rC5ZEkcpLCPsLCtbXJk1mzKTmYmo4nncGb
 Qduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849913; x=1769454713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMnuo30GCDeWWxDDe/w68HWaxEyzphEdDTKSqE6c6wY=;
 b=F8nf/21LtiIhIQorFOlYX4nK/aXkwBbjJaLgBHB83MS4zIQZ9WFG2EsOkpw2k3ARB1
 2wHJc8m7y4zfbVIiDnD3XX4CRz/1F0gclq4xK5kRJq6LiJD41Z4qSbci/C1Hz3wG1H0J
 gHnGow9RhgrjZALk4pgfXEsFuAeUlpoTFfWrc4knYwhQMfv+yx7Yot0ghFw1/W11UxM4
 J5lby4otPUBHTcUQCNUcX6GWZSzvqN79o4M/ShAeEoMlUG52w48ZY3vCMRWww+rkclp8
 sG+PoaSJub40FzQXYe8EEUL8PC9MHa7Eki4y9Fv0I6hlkEx8l0FCtDUirf8z3dxwLe3/
 3HdQ==
X-Gm-Message-State: AOJu0YxKdxVfCnXBzo22kw0OswtZFCCjztgtksSGDwVgcnp7UrXe02OX
 bwdXn6wGV2c9n72r06vm1SKBtuNLpQtdHpNBHnK7D/MpDO4uI2pkcl23yq72+AKe0fU3j8KM5a7
 tAaLJ
X-Gm-Gg: AZuq6aIUrhw6xoQ+FfHsQakdM5JfR7OqfgDbLUjAdjaTslu4XAjgquoVoMygVnPwQ2f
 Cnm3q/r+jApkl5MLoDBuGCrx+Ocd6IWU8bb70CjJWuAe29f2QP57uErwCcBd7uxsFlLSu5EcCyK
 lJuTGyx96aFjujSA4RHwUWGE6/T5gNNdCnElqw4DVFXHbZU8eIcNhPsOPDEMhFKs4mEAzNzG3xf
 X7isMuaWV7XwROLidPCs4zlqmak2dpes/6oh0MKrqQpcKLCAU++Zp3eEyyIA/CP2+YJbJyCXQB4
 XSViZ8IkH/TN50ZdGdTnrylarAYtF/PR4HH2kTycTye6vvhrcACY9HftSjPTWnpd/zs261tBsWY
 gWRuROCLd7GZcSnfs9Hdhgm+CdCLLbxKKFOs8Ew0gGpjVpE/TWNv3G4s3fEONrRnSQ7y1cIqLAh
 h93lr5HO08aMuXfgixEcpKOb8PRG7FGIR/hCs0d9uXqS950kJbAvuJGzpxIP0AQ5lz7LT6IDinz
 RU=
X-Received: by 2002:a17:902:e74c:b0:2a0:97d2:a25d with SMTP id
 d9443c01a7336-2a717516415mr110710885ad.15.1768849912638; 
 Mon, 19 Jan 2026 11:11:52 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:52 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 08/11] meson: enable cpp (optionally) for plugins
Date: Mon, 19 Jan 2026 11:11:34 -0800
Message-ID: <20260119191138.811069-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8820a9832c0..a2671a325a6 100644
--- a/meson.build
+++ b/meson.build
@@ -77,7 +77,8 @@ python = import('python').find_installation()
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
-if host_os == 'windows' and add_languages('cpp', required: false, native: false)
+enable_cpp = host_os == 'windows' or get_option('plugins')
+if enable_cpp and add_languages('cpp', required: false, native: false)
   all_languages += ['cpp']
   cxx = meson.get_compiler('cpp')
 endif
-- 
2.47.3


