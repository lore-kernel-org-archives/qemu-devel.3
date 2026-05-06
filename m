Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6E5FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcMS-0005SV-6t; Wed, 06 May 2026 09:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcMQ-0005SK-Dt
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:32:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcMO-00015F-Tv
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:32:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48374014a77so76417355e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778074339; x=1778679139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hvycp9+eMXwrUVcSV1d0TUGIgSukSssnM7gXDLa6L/w=;
 b=d9RUl+YuZGR4h7ClsThdf7/LZ4+abQ8yULtuMEd3QwKLP+soOCkA6tV0rPCA7b6dmZ
 /ZLFoQdnA3Mk7BJydMamnWgq4SAU7Ov3sp2fs9v4Gor5xqHft7x6V5Kr3qXXZjCqCWo5
 F9hchfFDx88Pge40ZvklsGI/B1KysOZJDJyKTFTFNh0M5+XLwvEFkS8UGQiGs+5kfp0I
 GBHvK9cNAW8YokbL768hdyy4KO/ZKiH5jACXMKb+0ipmxohu8sUTPvo4s2pPowU/Vq7T
 OJU1mPAu3Q1nhXPONGSG6ZKJdhvOQcVgFxm+w0aG8rAPEajW7eY+wWQWUUq9A7zx2wbk
 P1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778074339; x=1778679139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvycp9+eMXwrUVcSV1d0TUGIgSukSssnM7gXDLa6L/w=;
 b=APuekLyjEM08bf3A8cS3VClVoQzyV3WCdWAmBxt1NGQqWpEAlLMzuGy3HIez03UcmZ
 9843zl/IcYE47kPI6pUAGnOrVYubtpqy1fJq/xawryXu7cQ+PLciENpt1vCiosmsRWlj
 auWkNpEZAexsXVz+pN/V41M65QqerCbIAgxnLi8AkXJaravPJBOIrUjhroJtod5YL7s6
 92vaoYS80eyBKZuFbROP6FEe9mh+9p27p1oVOYo6slGdd1Zy9HboZYRVgkr/y+r7ol2S
 YwtqM4SEhp36UiBKqWGqKPJzYFKR+X3AuustK4GsmrQxkcDvk/MujlXhfUqoF9+oD8nv
 oi/g==
X-Gm-Message-State: AOJu0YxDAvsfqwF6vGABXCSoai6zbofVvA0zWVqNS/NDmq8QXXpbp3i4
 5QKaSj8dtkt501O7AbMOVQAVuRDdJYYIpUacR52abNOw6PGwuLg/uQk7E4xtWW0Aw/NQHiYBFP4
 xfQJEHqk=
X-Gm-Gg: AeBDiet8tWbXV+Pow+b+fk8aquNGMMsc0VdEtPDiKmKoWvoVPGlnTMx88a4MAVK1X6r
 nLJiZ2GIGNgZR74GgGwUeOoTL1ffu76A8DEKxMK9ZRd8fO5WOg2pciXbnG30MeV7qeROHMRH8ff
 LtSs6XJL1buJ5QJFLCINx5FZVe08k3UEfrqje2pl8IqubrkOiOIjc1VKUiN35iDT+t4oJTY9S9z
 12gN4eSPdto0RWGQo6yQDL47IhCthNRnqAe4kR07oOqngH7krifOBsc2daB/7RdYmcAN4hg9ZB6
 Wo/Nab24kSpQJe8mHhPRRvGujnbPWveqfObAyux9TkUyxKcOOFDNqv7Dr+J5rhzEIgc1313i063
 d6qZH5v21mh/1LENMDcl3JhxzEBJHipBBEqqHpbw7p6gugaVJMHugFtd44h9nW33aNlUs9wRQrb
 8n7UVihcS/DuXlOC+Y15oaS2OiDu4aFMYfHgziANwrSj48Bt/kgal1g8NBlm48YnegkORYhEvY/
 HO/8tovGXU=
X-Received: by 2002:a05:600c:3b17:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-48e51e15c37mr58595965e9.8.1778074338656; 
 Wed, 06 May 2026 06:32:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53895f0asm52984555e9.2.2026.05.06.06.32.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:32:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] meson: Allow building with empty target_arch[] source set
Date: Wed,  6 May 2026 15:32:16 +0200
Message-ID: <20260506133216.18730-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Complete commit 83d5db95d38 ("meson: Allow system binaries
to not have target-specific units") with yet another guard,
allowing empty target_arch[] source sets for some targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 4176d020c21..987f33bacee 100644
--- a/meson.build
+++ b/meson.build
@@ -4332,9 +4332,11 @@ foreach target : target_dirs
     arch_srcs += files('target-info-stub.c')
   endif
 
-  t = target_arch[target_base_arch].apply(config_target, strict: false)
-  arch_srcs += t.sources()
-  arch_deps += t.dependencies()
+  if target_base_arch in target_arch
+    t = target_arch[target_base_arch].apply(config_target, strict: false)
+    arch_srcs += t.sources()
+    arch_deps += t.dependencies()
+  endif
 
   target_common = common_ss.apply(config_target, strict: false)
   objects = [common_all.extract_objects(target_common.sources())]
-- 
2.53.0


