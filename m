Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7C3C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57e-0007Fv-Ck; Mon, 05 May 2025 19:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57F-0006UR-Rt
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57E-0003gB-5V
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224341bbc1dso65407535ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487250; x=1747092050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=H62mNgqFLUWQ5GzdqZREIpWSP2WZ73uc/5SA0e95BGT2TRchL0A60kolCL5SQ1kcvg
 i5evg0OeTywnICXvJVRdXHf9pQlYCN+Dh732/naHZFptuJUxHJI9+qjOhxXp4HftBsY2
 /ebskNaJ25/CHa42CSgWDRDRzzxMB/+yXVzLWKune3qrQeWeYrhMVFqN81mm3oM92RlL
 pXYJkp6i1I6fdAJ6XkuTGFbP+/XWH582rBxCg4AzSQfx0PSlcXZ/f7hP5LOTl/0ZmTrI
 /WzAuv0Hv2hDflQ/JxDL05OOer4zN/qZH9XLhs0oXw7G5u0G+BMo6k5/EYA+E71SspAD
 xYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487250; x=1747092050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=Fpn9QFK0bBfN4yKIlvWTUIENN/I8VW6UFZAYZXn9kmG2slg7UEeat6FGFX/5wUMb3u
 qEaWgcroiZCRIVWBdWgu4rTLp4RsgWDsSOVjifoJxdIUAieiyVwSv7p2Fbm1aFoRsOO+
 AQChB/Gxtu+4tJ+cjSuf98GAr3vfdNQKp10nPxN9sOL2KzhwfzSplahBVawg9PTYG/1c
 z+G2nOadCaS+XYytX0jSXD6lPAMal2ZOOWPVOZiuQsBEQXI0HADMjQ9q/tykcOoSt7Br
 jhJs2w8A/ywHJSWCGXf2K8UILQUCuhMm/2FCQNizBlsuutHIRo7UH/yx6m/miznIZev2
 65PA==
X-Gm-Message-State: AOJu0YwPxrSeotUlwh6YnS1AMIBWknnQE4chZP1n2PmrdrcqQOkZiW+5
 p0gS0Mel0NuIC+0JCLRAxay3CqvRRXPOSYWczimBZBogTbdn4xtLzako2RNoSBbC9X+nwlfOKqN
 Rv/o=
X-Gm-Gg: ASbGncvM+ilDb42uvJpegQvW01bw37xz1Bqy4m+6Iby8mFdWnDYC44WxnCVFp2HANUb
 WmeVE+yYK2as+zg/3gIUzh/p1sPe1yauTL0KtjdLkdwV9tbAhxTa2zyU/G8vg09h/6hjNgx0yAi
 eHSNl513o6PY/1+twgW0GKyNNQwY457SEPeAXhbfa644n8BVgSrAam+52PrQIIbgBjHuf1ENt6q
 SNwakjgjCqj2eBkR6PpVwfM3/W5nqqq4KcUCuNGkY6nxY6/6P8t3dQvkgQv/YfDolODJYYhMyX3
 a8s+N+RN/QwLh/iHXk0ggwKkR2bfb5+mcMjZ6wC5
X-Google-Smtp-Source: AGHT+IFVn+o02q7YLHYWbNJDn25BoizahTDh5kkjLLSkKyaYVzM3AQo7VDnS2nKlNPl290g0JQUCiw==
X-Received: by 2002:a17:902:e752:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-22e363b5382mr9664615ad.42.1746487250712; 
 Mon, 05 May 2025 16:20:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 34/50] target/arm/meson: accelerator files are not needed
 in user mode
Date: Mon,  5 May 2025 16:19:59 -0700
Message-ID: <20250505232015.130990-35-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 151184da71c..29a36fb3c5e 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,9 +5,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
-arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c'))
@@ -18,6 +15,8 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
-- 
2.47.2


