Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A4CC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfmf-0000Em-GD; Mon, 11 Mar 2024 09:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjfmd-0000EN-Pr
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:33:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjfmc-0006tB-3C
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:33:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33e76d653b5so3002714f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710164016; x=1710768816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oGT9eNu0PxBnJlxZhPsk46LUsox3J4QaHKuu+0usPQ0=;
 b=AwNkE3HFPICaLYkN8mWp7DT6siL/juX9HVnv8TuAxBpqScXLNPLktwzp0ecndwaaVL
 Cw1VaAdJKsWok89HBD4oUUZxfLmWfw21HbDt8qH3avPoR4Zs62ajXkcqWvpu2JSpGg7i
 Dny+wrZ8ncJc8igCAgbTCBCgcvbrc1wcTV5V/qQIUwWgV7KKetNy9LL3DnwHvK9ClNr7
 5vRz0aG/ohUGc3wuLEAysJEHRhrfL3gA2BMMLiN26MfOXq5BpaW8SS5IXlbLDHLWCMNJ
 ec/TV1yGtfjy9ga+/0m0RydRdgs4Hzk76i4hz5hnaDDcqy79oG1wskan+CysvpvrARfQ
 Eayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710164016; x=1710768816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGT9eNu0PxBnJlxZhPsk46LUsox3J4QaHKuu+0usPQ0=;
 b=eTIwBDHggTsO219sXTl3kQGyS1ULb5IHmYRWgr85V6+eEaxSx1L04lAIg/ESnkXPPz
 1iWvnYujk02cqNxf7FvDmL0+c7S6/ZRLsWpkoENJiEWnHTT24erOJvNV1zkVrxyvZqjU
 RlH07ys1H3t/YuSDc3Jinx0lmVkJyrOUPo2VzwS9YDqDsB+3PB6hyB1ww8+nkyVsJVF8
 tz/3Xblfy6uf7Pt9aH7y6Zx8Vh09MPr4EIPFoV6JMny1gZqft4Yj4twNtPn6GF2QXWg6
 ZiW5CC5T3Lmksdg0ishWKma5bqdl2eEgMvzViMOl+IQ2KxyEso6CGpxpFeSTTj8FpBcd
 bJ0A==
X-Gm-Message-State: AOJu0YzbBz9fy8v51R2KvbqO4O+gQv1ETzA3PbdlnH+2sFeR9+NBx85q
 THd5PAA59KaRdirqJ3UOoAZVFP3MW+hLOAsTTQW2l2ZY6WW5xTwcGd+8JE/rvbiYJnqyotwfDDn
 C
X-Google-Smtp-Source: AGHT+IHGppTWdxDBxco8pU4FJdYFTksBh4BvRe9GVBMjjpU2n9+zBGq2UI751xDOWpi4aiXUYkbSVw==
X-Received: by 2002:a05:6000:2ca:b0:33d:6fd8:90d3 with SMTP id
 o10-20020a05600002ca00b0033d6fd890d3mr6315944wry.4.1710164016277; 
 Mon, 11 Mar 2024 06:33:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a5d6083000000b0033e75e5f280sm6459007wrt.113.2024.03.11.06.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 06:33:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] meson.build: Always require an objc compiler on macos hosts
Date: Mon, 11 Mar 2024 13:33:34 +0000
Message-Id: <20240311133334.3991537-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We currently only insist that an ObjectiveC compiler is present on
macos hosts if we're building the Cocoa UI.  However, since then
we've added some other parts of QEMU which are also written in ObjC:
the coreaudio audio backend, and the vmnet net backend.  This means
that if you try to configure QEMU on macos with --disable-cocoa the
build will fail:

../meson.build:3741:13: ERROR: No host machine compiler for 'audio/coreaudio.m'

Since in practice any macos host will have an ObjC compiler
available, rather than trying to gate the compiler detection on an
increasingly complicated list of every bit of QEMU that uses ObjC,
just require it unconditionally on macos hosts.

Resolves https://gitlab.com/qemu-project/qemu/-/issues/2138
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Per the commit message, in theory we could allow a no-objc
build and disable coreaudio, vmnet, etc. But I didn't really see
a reason why that would be useful, and it's bound to keep
breaking unless we actively defend it in CI. So I preferred
to simply require ObjC on macos.

 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index f9dbe7634e5..e3fab8ce9ff 100644
--- a/meson.build
+++ b/meson.build
@@ -66,7 +66,7 @@ if host_os == 'windows' and add_languages('cpp', required: false, native: false)
   cxx = meson.get_compiler('cpp')
 endif
 if host_os == 'darwin' and \
-   add_languages('objc', required: get_option('cocoa'), native: false)
+   add_languages('objc', required: true, native: false)
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
 endif
-- 
2.34.1


