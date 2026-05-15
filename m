Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFF5CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtGO-0005mi-AO; Fri, 15 May 2026 10:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGM-0005lZ-Ns
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGL-00045J-0J
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so6220725e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854295; x=1779459095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPeBcaZ5YD7e95Npghm6maaNh0uoOJNDDsoQJDSIkp0=;
 b=YUhJBmSMwW3m6qpcrKK48lSrUzjEQm2kbYzZlE7FJYxMMemOba2TfIrDW03moWhs95
 ed+kgfpP5MzkxBRo894KKwwZ/H0WkMbZGxHM6cJejv84dMUbqlyCfeUkCO3mUeI+GqZm
 6BpeFbDfniC3Iomvv3G3eEoIHvEBn81mdhTkkYb7wuNvpgRrKXN9gAuVQe+6ZwE8ow6y
 cQ10IPf0kqnHPgO6VUwyHVGALf/YdstTg8efdmCacPJPg6Jot/a6V+5tpbafdLQV/b9s
 lWDIlDMPSXOh0t6rMUQMLX7ZiDhsqaTdEjKJt8erw8ZWz1B87yrQxbbkZDawGrtcQCLZ
 CqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854295; x=1779459095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xPeBcaZ5YD7e95Npghm6maaNh0uoOJNDDsoQJDSIkp0=;
 b=cgNPNMUdG5WGknU8AtlcKxTWZdK9Zvl3ooVyVyzrlmHE69F9uGDA+zNB1BM70ckVMV
 ynBGhuLUfRcjKmVWI2rg6SSr5brOCFinBTee8T90kfOJss00XwfwJ9VtT0xqJA84M673
 OYnIkhCN5q8C/fb+qVEtNN7oG91cZsLk2gv7Ey68xLvv13wW/bG6yaqvz7AS8FEuudNU
 PG9zGcPK7/jmo4pK2JvT+Nta7Omaf2Trb+pjDJ22M89Ns2Ad3JQIJhXksmLyLSfIhaNJ
 B+ylnR6faY6p+FhVIpZny99bM4Wl3xDb0+ZXm03FWslnI5uBj3Zb4U8byxgJ4NfxgTaN
 oN+g==
X-Gm-Message-State: AOJu0Yz7DNTEl/BkbH6TCGJi3qWqtm+tHrMRSWh4+dgQ6edUvT+uX07g
 pOCwiZUwJtIdfpeag9UrgeSSh2od2XXl4vo+XtNk8Nlc93yim/lzjEXLjH7xKGbD80Dd0hzcYdI
 2EIAJC28=
X-Gm-Gg: Acq92OFzVMZjduuB+ab2h3aXrUM37XcdOHag2i6IlGvoofe+4odbG/QfupxpSabnxRD
 1frZ4BzGK4CVLJWoHYLb0e9k0EAEIfZX0bEF65eRcSXGONI/E5dHpkcddr3RzkWyQewVYDwBnZi
 LtyLBmvvwuEVqCtnAtXr0jiKU2c/2dEben3MOPP8k8zBS+m7n1Y5OjD/GCBhsS2d5jKf1evt6J4
 KjudidYIP3t/yXVCO+z89NDbHTBdJeuUkPAPKPg1GyJjMHJzIlQ6HLSQN6DbWALtUFkFMibeeFN
 jGwQbB7JlZ/dW48T6jDnKCru0Y19jimgnY3ll16Q3gK7OTqiwRa6HdXs9MxdzbS98Y5Ikf66rZh
 8vkJGQpGXSySTR5abz9FMynP53Y4oBIkkhjIlc/16AEM6xGjLi1kiI+KiI6I8HVkwylsG6XVpBW
 bLjNClOVJdghle9rvUFEml+hFvy3JURReosWG1QUbhge0lD95N/9A1fd20v7CO4Fngm2VwrhAd
X-Received: by 2002:a05:600d:8:b0:48f:e044:927d with SMTP id
 5b1f17b1804b1-48fe537fa84mr59363415e9.10.1778854294926; 
 Fri, 15 May 2026 07:11:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39806sm15166142f8f.9.2026.05.15.07.11.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:11:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 08/20] target/arm: Build gdbstub64.o as common object
Date: Fri, 15 May 2026 16:10:19 +0200
Message-ID: <20260515141032.3271-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

While gdbstub64.o is already built once, build it as
common object, reducing target-specific set in arm_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index e56fc943bdf..5376be2e3bc 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,7 +11,6 @@ arm_user_ss.add(files('gdbstub.c'))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
-  'gdbstub64.c'
 ))
 
 arm_common_ss.add(files(
@@ -24,6 +23,9 @@ arm_common_user_system_ss.add(files(
   'helper.c',
   'vfp_fpscr.c',
 ))
+arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'gdbstub64.c'
+))
 
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
-- 
2.53.0


