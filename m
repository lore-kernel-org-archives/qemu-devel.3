Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33E2C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQa-0001WF-G5; Wed, 07 May 2025 19:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoQ4-0000b1-6a
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:20 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoQ2-0002dX-BK
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:19 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30a93117e1bso580444a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661396; x=1747266196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6rvyCptpZZum3a3XLfgy4KbKHlT47oeB0wfjegrLwc=;
 b=b9IqBhVhE1lyEYXVLNtHJGf77un77vIbI1cY4hz+nxg/S+EOMwOxy2/nh14PxJ/Hom
 z9M0md6x25/syCyt/eAqkJfWK3y5/tzJ4sj6iouAgClAvmEHqr2TMzwo1SMONVAQD9TT
 oO2ojDkwNoWmrBzng8oD+SxHxQbf985uLjaMO5A1qI1uI5ImC5Eh6edasnSZqyrvcfte
 wa8IYRwK1/ZEBoVKf1phnX2gXKdRJoDx50EEffaEEMierdefrXxx+bYA+TEDzjqFcQyZ
 i/G8vH+sDzcwoV5cqf836i6hUBQwBgiGLwiBDQ1jp1a0HOWZIJSh4W8C2j6LJzNcHaX7
 Jfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661396; x=1747266196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6rvyCptpZZum3a3XLfgy4KbKHlT47oeB0wfjegrLwc=;
 b=Fi0qdH0KW1Ak+iWJGdtd6ahNMepadPOZknb7b6JwlC+HCluFPV4GgvKiLiZI8IIGR2
 fPDxdxoLi+FNBIHC2zYzqLRoKoRTvj4CfZG0c12arl4rB8e8TgkeH6sUIjHB/UbVoLY7
 9JSCkE0eRjqNeeomLIzHvArZtR7JS1XgsMVbC5Wv2EHjYqXWDjNxvEYw+pfy03oUVeDS
 sAi68TkNkza8eER98ESgpDep+7BV8iNAHbkg7Vzh5dmRuBfEkVfjIQxzMS2LJ76r6oTj
 gCdwPWhMFkJmA8NhGh5fx0/y0OmKmOmzABCbUUh5pfT7nrg7rWCHSwfE6cZyrZoKtnbJ
 jNpg==
X-Gm-Message-State: AOJu0YyrwLT6QcHws56L5/csn4q0qmnIjLwEgZElT4OypVvWOsSKWcdu
 YYjcTQJVdSJ3ePlwMPHaofvm9PZUhKaKp3wu4NlSWJQomRjVChm/OeM9tGMIULtiG896k2CHD8W
 4M2+CyA==
X-Gm-Gg: ASbGnctwDivP9KpwZLgo+11e/+L/IK03V+kgZ0Et6BKoo2mv1PuPjlRNicr8vtg/Qtb
 S2UXoIYke2+J6Z9hZphQv+dCAvmD3AjeVHO4uvLg1pxfvEjwhaCjgVTa8fX5wDGW1nDMjioDjx2
 tzXObXBCZ0lXc0KwpwkCWO/SViCV1AMirv9umer7okAd3Ohd3JnTysPj/zz6wIq6R7KD9YIo+Dn
 2mNGYbc/8zHTVlpg/gbh9oWQR1Xfw5Km5bRgti368n2Un/OEjP6aXQYcMmaJPFLIf9RzmFWlItZ
 uwaJYeZd4AHAMbS8s8TmAbbPGmVhzWkzV6xEY6d9
X-Google-Smtp-Source: AGHT+IGbXpVTbR041CeMnGcomU3gZeDQGJYdsxW6D2UWIAmpkewY+S/xE0Eh1L5Jy7l2aT8fMDhxzA==
X-Received: by 2002:a17:90b:2d06:b0:301:98fc:9b5a with SMTP id
 98e67ed59e1d1-30aac186270mr7642172a91.6.1746661396688; 
 Wed, 07 May 2025 16:43:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 39/49] target/arm/machine: compile file once (system)
Date: Wed,  7 May 2025 16:42:30 -0700
Message-ID: <20250507234241.957746-40-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index bb1c09676d5..b404fa54863 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -13,7 +13,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'machine.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
@@ -39,6 +38,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'machine.c',
   'ptw.c',
   'vfp_fpscr.c',
 ))
-- 
2.47.2


