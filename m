Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B592CD3443
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKctJ-0005Zr-4N; Wed, 06 May 2026 10:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsa-0004Yd-Iu
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsY-0001gS-U8
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:36 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso3164474f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076332; x=1778681132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qW84427DTcBCLrenghzAgnxBgq52ewVVKhGxkzWvkog=;
 b=OhKMzxyXru2CiMjTRsk1AiqolMKNoDpIKM8L8Qja2MtZC716GoS38qb56m3Zmyt+P1
 t59ftKP97WHr20jUfLL1rtVF2TXElN9fJKFzaDfAvgXyltwIyitWfaTPQXHX2QbZizoI
 X/qfC+mfbX5lRgt5nj9voxFy8SP12coaQAXVWe78yxd8fa6CGjS9Lh0FFUWoRNAiBsOB
 Z6s/7zn+GMUKU+NnsTn1xDb5QW3frXtVqHfG3wtEjMBU08X5XJx7OVLDtLEqJyIMGUUp
 OcAAe33xmhrvojSRRkV4helIeTnw0/EOpbAhcNJJLTButQCQTPl6NebmodQiNI+RLbC4
 GBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076332; x=1778681132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qW84427DTcBCLrenghzAgnxBgq52ewVVKhGxkzWvkog=;
 b=N7G7ixjx0IwDEwM+XNVccelRIw2jR4suIP4fZzvOMtmu8dsbdlgCwmvkbwgaoR1hMH
 tmNJ+YUJfzOVxgHnyxP7pDSjJTnVcOuWz/bcWpJiBUWqcTTqIfM3PbtatH6B4gkM5s96
 xBQvC2BctgPQaEWgNc2NW39QL77PKM/dv1BWhqy+a5ro7RGQUO+Wseqhebykyl2IP88m
 ef2k5BOnaca7wCsarBINYE/WMVUNfPl7mMDgdU2CQxOr2qRuXRLY2sMHB5+s3Lg2gOFE
 aATo6h470OFn/+tzAF0H7VEW32E6Kn1ETWP4PkXCiheIS2giQndj7HCynkwxbdnoDd2p
 ZkGw==
X-Gm-Message-State: AOJu0YyC2Afp9+7X+/ogbPbl7rDk8z90DOa6XGmT+oA4CY+T3qubi33L
 h/f9kxb/oob5YIPuZc+IvRmp/RbqKW4E/mDRtwOEBpo4keNVDMUYwo3/gQsOkQhSU2IxeMzPxQ9
 5rxEyiKA=
X-Gm-Gg: AeBDiesrCPg8+6m+XViq53Z9pRsmOvCH+BkGO2PWCZSqtpaVX/vx+a8uy4lxZYeCJND
 gg11oHrc9o5s/HPw4oYszxxsGx1mNTSMvhb3IwT6UXQvAdwbBCOoQa3RYwJQbgpeJSHTf7fsoB5
 4yEsPo5q6OKa/lIAL2Lk+lgqQCLB50QDMHdR/p9cAzN3Zs9AnWjcszxHq1a9OtYtCRSe6gMRjqa
 jWpgaFrxWGjERzJIlC6RjLnbZW1TWXPGcxK1vklxFkAikVQUbgo6G6/AOlRSwrLlRiLxrd5PNT2
 UWYaJ9xHYEyUlVHbfzCJiG1KgXHHqwX+DcrnW3GrI+NeQ5je/AACOTnf9R1LOAzn7np3mCkNKC3
 mBO5ImrsBv4DUKyBx80uWiEyvFV4DbWmvpQOH4cli8EMUmSX25KIDxy8rAbub9F+qmpTYJWhWQQ
 ilqIuIZ/qYPduRJeMsxrgct5OBkhV0siIpETD6wgK3wdSxdlyitiCBbyXTOr72gudv2MZzr/0Pv
 YVDB3MN5dk=
X-Received: by 2002:a05:600c:1e8a:b0:488:fd7e:1063 with SMTP id
 5b1f17b1804b1-48e51f4cdcdmr62798465e9.29.1778076332216; 
 Wed, 06 May 2026 07:05:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e539109b7sm46156995e9.15.2026.05.06.07.05.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:05:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 077/110] meson: Allow building with empty target_arch[] source
 set
Date: Wed,  6 May 2026 15:54:49 +0200
Message-ID: <20260506135524.20617-78-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20260506133216.18730-1-philmd@linaro.org>
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


