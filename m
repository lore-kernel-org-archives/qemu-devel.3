Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDA9CDDE6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uZm-00018x-Bp; Thu, 24 Oct 2024 05:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZg-00017N-7j
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:12 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZd-0003mC-Nb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:11 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c984352742so719560a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763768; x=1730368568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lfu7y7t8iZrdGD3A91dZIpglo3CjC4+pIrt7G7QYlLM=;
 b=GfKuh3ZSKVbma+A5LNy3MJZr+Wpiov26iJ7Lqk20RY7kYIdgRwtCMHRjZe4CmpC0lu
 JgAScjI7U/etD18ALqRwVmfvD3x8uSjr8wrnAB8iwIFKkAIC0FtycWpY0xjzRRCVQDRq
 78O9Jm9pG6mdR9kierMfyy1NfcmGzNy0upbjXPYAT/XAZkqX1726+QOP2T9gNSKWKvPW
 Ava3EmPRWJxi7/MOsQtq3RET2S+7U6Qb2VH9XFzGIL4OwAqxelZB/Lj9FysMmypNTMk6
 hQMA8IUEq+7KrkJUl+a9FUoaQ4lc0QL7yueBGn3A80TJED3NpU2Wdcn1LubJfMd9Br5I
 MO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763768; x=1730368568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lfu7y7t8iZrdGD3A91dZIpglo3CjC4+pIrt7G7QYlLM=;
 b=nj3rCbixCBMNumcKCVMsVcX6FOXoFaedYL/6KRWPgsKOJuQoYTqxVN4xrNE2Eu5ZKl
 RMC1hBb5IURtRhZKB8ZZ4/aFSNvOucVJ7uM3UOozf21/xBvbwADn5rWOZ/9WRjAhYU5j
 K02hi/CSjE7n78ED0Qub4q6r5MkUMllMpJTQtTTE4aAGhgVMkpkXcthahEYsjC97TIxL
 1UuW4nbB12EdFAzAebQedXaxrbxnW/edXpnYVqN2yAbWtZASC1HINYgcgFid0VKLx1Az
 CstJw5GZV1pVQcZRk1hZTkwJ7szBEF9YVCTU1yz7o6nZuHxEIe6m/UMVtHn7H5r3JzLV
 o5Nw==
X-Gm-Message-State: AOJu0YyTbzcmpmAWoUiXceUPaBibU4peUaSvtVJ1RnsW+H9p6gbvs7TD
 jz/P6sstn5WuSXkQ8Xepy2T7L7OXRMVjU6tuogWu+F6g/fykDSKQFnhh8Vm/0qo=
X-Google-Smtp-Source: AGHT+IFJjwj7sxl6LoYsQDKJLsRjNitDygi9tI3Cw6jaIM5CEYwTMCpVUKNmGNVzeA3VU2YY0gzLKw==
X-Received: by 2002:a05:6402:51d3:b0:5c9:8b00:3c13 with SMTP id
 4fb4d7f45d1cf-5cba24a030amr989505a12.29.1729763768173; 
 Thu, 24 Oct 2024 02:56:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6a468sm5736775a12.47.2024.10.24.02.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E4FF5F8D7;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/17] meson: hide tsan related warnings
Date: Thu, 24 Oct 2024 10:55:50 +0100
Message-Id: <20241024095603.1813285-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

When building with gcc-12 -fsanitize=thread, gcc reports some
constructions not supported with tsan.
Found on debian stable.

qemu/include/qemu/atomic.h:36:52: error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’ [-Werror=tsan]
   36 | #define smp_mb()                     ({ barrier(); __atomic_thread_fence(__ATOMIC_SEQ_CST); })
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240910174013.1433331-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-5-alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index d26690ce20..bdd67a2d6d 100644
--- a/meson.build
+++ b/meson.build
@@ -538,7 +538,15 @@ if get_option('tsan')
                          prefix: '#include <sanitizer/tsan_interface.h>')
     error('Cannot enable TSAN due to missing fiber annotation interface')
   endif
-  qemu_cflags = ['-fsanitize=thread'] + qemu_cflags
+  tsan_warn_suppress = []
+  # gcc (>=11) will report constructions not supported by tsan:
+  # "error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’"
+  # https://gcc.gnu.org/gcc-11/changes.html
+  # However, clang does not support this warning and this triggers an error.
+  if cc.has_argument('-Wno-tsan')
+    tsan_warn_suppress = ['-Wno-tsan']
+  endif
+  qemu_cflags = ['-fsanitize=thread'] + tsan_warn_suppress + qemu_cflags
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
-- 
2.39.5


