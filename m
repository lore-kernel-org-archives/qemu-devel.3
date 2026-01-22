Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8373D6CFA2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 20:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1AE-0004OU-IL; Thu, 22 Jan 2026 15:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vj1A4-00042J-Po
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 15:20:14 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vj19x-00010i-B3
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 15:20:08 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3530f597ea3so712983a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769113199; x=1769717999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JGdMvHw8iItUH3yp9/lazIMLmB70jts0/53WbK99AGc=;
 b=QYA6Qc9SMyBbj3tAnHr96v48zyw4PdjT28k9OMdXSkBJ6kT5MWJiuMGKofKhynKqvD
 dYJH80Sg5R9a+AJBtmtTokGvdIcYdOgUqQU2SSxjV31WIHDYy47Fea2Hci6CqJZzXfbW
 x7PvuodR1/VQvCAqdW1rhYP16myM0zlj9asN2Y2/S7ZcF+AzVQaSyftXjhueW1qT2ErM
 gpBbboYhpqt6JUkr63cheq0ueVxBPJFlJBaZGT4YQp8mcVqJQJsNQP/sy+2YtvadncJn
 Ak4/8YYSkRcxRa77mgSTzSBzvyCA4uyYkGvYkZ77ZyFp9Gcd7+BTvWCbFV1dB5zB9QBG
 tByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769113199; x=1769717999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGdMvHw8iItUH3yp9/lazIMLmB70jts0/53WbK99AGc=;
 b=IpTpNCITCUAtH2nGbQ1IB31vVxBZt/6eb0gTMuLZS7aDIJq0ddZZT52WSq7tmZN/Y+
 g9eaJhYqxZvKaln13kGMOjUwmqrTq9fWb13J4QsZF2g0S37tpkCl/Zpy1Ew/6QzV4uCT
 rRAj7r6VNEmLUz69GCpK/DafC4j97qkaZj6RtkNY3/+mqyZ3+UQNw576Pbl56QRnuiKV
 TbRkxTstzVn3IqZEud8kv9v3j0UknqoNUrYqTiqJUdkp206z06v9QMqiy4RorL4iWDeR
 ntmT9NtEmL1toFSoNC+u9iLYs6dqu/2ESqhs0UYPouq+WSVztkNP5XeJ+A1elIDnAI2j
 YV5g==
X-Gm-Message-State: AOJu0Yz1gk9jtCgFuSl4N6VhLthnmOnAdZce9ZBd8rDmAxfK2X4E7YFR
 piUvBTnU3BSng7ar5bETSbky9+16ZrT9+J0vGXuFQsQYUuiHd8KOxkRjWnzlVMDnWDfxGRDTCZ3
 a0XfqsUc=
X-Gm-Gg: AZuq6aKGZlysl6pIt/s5ssAtId14TijteFCWQIlSc39Yd/DJHGKbSdw9ctRl1k8KDss
 1TmO+gzoJ5XzefPl31fRoGMzQHa2W1xmNVMKtH5i7dB+lL2YFD6A7CZOLQmSHGoDCw88HSfFh8E
 zwhsI/9aq8/emm9LZw+HYb7y9OR9JKfYQjo41rChh73DNkYYQL4L5Pu1++KMX/VE8h5xiFv/xKJ
 +t9mpZgcYWaxAuV2XdgZqORrdKYpZtauPP132qC9QtHqKbfW3aE8gcHTfV1eUujgPqys2PBykSi
 OeghU5fNm1LPAT14LUiw8RONX367V4kPpw0C9xWJseHmDtc4V/sQ6ghp/xjNrJkWyLjDKIp4JtK
 LmE8u/01qtaVFEGwO+N0XVO70Ck+uMXlwVErv4XWhxLnHRbIDjg/53gknYD02IxVG9yW5p+mHFP
 GBTfIlghhWvr2WRsdCbIlwg2Ja9qJhGxe3EF/0gzjORTX1J5np1/AYZO06QFY9rJYH
X-Received: by 2002:a17:90b:2ec8:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-35369411bb1mr480736a91.37.1769113198863; 
 Thu, 22 Jan 2026 12:19:58 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35335216059sm3172516a91.6.2026.01.22.12.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 12:19:58 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] meson: fix build of qemu-system-microblaze with
 --enable-modules
Date: Thu, 22 Jan 2026 12:19:50 -0800
Message-ID: <20260122201950.214834-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

A previous commit wrongly skipped including the generated modinfo in
case hw_arch dictionary ends up being empty.
Fix that by adding an empty source set in dictionary in this case.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3280
Fixes: e8efe5ff4 (meson: Do not try to build module for empty per-target hw/ directory)
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index a84f14258b0..ca33b0f2ce1 100644
--- a/meson.build
+++ b/meson.build
@@ -3958,10 +3958,6 @@ if enable_modules
     if target.endswith('-softmmu')
       config_target = config_target_mak[target]
       arch = config_target['TARGET_NAME'] == 'sparc64' ? 'sparc64' : config_target['TARGET_BASE_ARCH']
-      if not hw_arch.has_key(arch)
-        continue
-      endif
-
       config_devices_mak = target + '-config-devices.mak'
       modinfo_src = custom_target('modinfo-' + target + '.c',
                                   output: 'modinfo-' + target + '.c',
@@ -3971,6 +3967,11 @@ if enable_modules
 
       modinfo_lib = static_library('modinfo-' + target + '.c', modinfo_src)
       modinfo_dep = declare_dependency(link_with: modinfo_lib)
+
+      if not hw_arch.has_key(arch)
+        hw_arch += {arch: ss.source_set()}
+      endif
+
       hw_arch[arch].add(modinfo_dep)
     endif
   endforeach
-- 
2.47.3


