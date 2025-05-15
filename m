Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2526C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcNc-0000oh-6T; Thu, 15 May 2025 13:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcNA-0000Bm-Ok
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:57 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN4-00027X-Ub
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7423fadbe77so1378559b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330069; x=1747934869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbuvyyDE6gTlrgir5RDD6et/JTOv9aQoK4kjj65E+Do=;
 b=CAtwAt15Aotz8NnG3WGH5J52lpOPD3y+WNPQCwzljEa92Va/BYLXYiPGkQE333TKD6
 79J+GHwxCsFCyBpolZLeon9cQcS0wF1eXlLKRS5JfCE71To1e8KpynKHjapRZ29M9V2X
 +3kMacxftCKFxKo0CcjJHMIoQyFRvj1LvgQcGZtEms+//CNcgswSsWDuoMGh/ua8ujr+
 q0jkVBzQZuES0nW6PJNGRqTAqicdbrbW080HnzYmQeRseOOAWuKfeo6bCOVBLbjW0hff
 owXGql7FnYyk+Qg2416ZShmoJAHksvkG7XbPhOnfMtfHTHrSX1LPs3YoNBSdCtgqOmfg
 OfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330069; x=1747934869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbuvyyDE6gTlrgir5RDD6et/JTOv9aQoK4kjj65E+Do=;
 b=mwHobebtFH+4fbL/BGbuGschha2NlD5kXuytn2apuRjGm1CL6jgLczllbiK6t/JVWa
 Id1lVLJATPOnDvJTSFNDMabcQyr1LBBDqIU4vnz5lUaFor3e5li81FP9NDJwzbagyrTG
 jxBHaKq1SwZ1m/71cG+MHkjeR6algD4yv1LGdGkeD8FMuhMzNJcf7M3JpwFgT3rPTzOj
 HJIbhe58l8/atddhBfVoPKLrfxIwU/5z5TJSlx+FFldP5Aia85DMR22zJAe0hsUcie44
 EAPVekm/4G83gEKHLhJO84FYjmKNI0TWW9A2i5xiBti1yTD9x0w9ZwJuthO9tZY/0YrJ
 TBrQ==
X-Gm-Message-State: AOJu0YzXLfCYnOjFBDXPoXYw2Xwyk/5J8tgXNduBcU9VuXX4oLvssbFi
 7rUhwenBgWWufekVUtNficL0TDEUZEG9dAFCJGkgr2INXMzt4rTevXBsq4HoOKwn82UuyfdUL2o
 kaJAg
X-Gm-Gg: ASbGncsb+cm81zX5afvG/u7Lca8F2lAu5xUdLCCMIn097K8vD+5mTgevL8JB/CKU40e
 +scrFZKRh8p0055Zr2xJq6/DYoACC5l1uYqdb/5Z7x+92mWmb0DLTDjqhP+YqvBAZCCjgw7MB4g
 CLnI/Jw9MkmmRDbH1roG+bxZp1/cWZ/Uja4b/v2/psTxiW7LR+bdadg68PUZemYWExsyARbUT1y
 n7kfzQ/E7Bpo/aIBw3o9v036tfZrcbu4DdZmXiSyfzF0R/+7i1usE8Tu04chzpxyrJIcCEEg4Lr
 VW6FJiA+bWFbrjEybLQEKIXerUiUWBIgUgIIOrq5fPy7oYTcRsQ=
X-Google-Smtp-Source: AGHT+IF09Xh1rGfHCkQgdRcfe+iSKrUzLXDcq3brc788r8GmBJnZmWJcViv/xA4m7Ql1vPqbgLIxGw==
X-Received: by 2002:a05:6a00:10c6:b0:736:4fe0:2661 with SMTP id
 d2e1a72fcca58-742a97aa21cmr269875b3a.11.1747330069387; 
 Thu, 15 May 2025 10:27:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 11/12] qapi: remove qapi_specific_outputs from meson.build
Date: Thu, 15 May 2025 10:27:31 -0700
Message-ID: <20250515172732.3992504-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

There is no more QAPI files that need to be compiled per target, so we
can remove this.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/meson.build | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index e038b636c9d..7582c2b5bcf 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -92,7 +92,6 @@ qapi_util_outputs = [
 ]
 
 qapi_inputs = []
-qapi_specific_outputs = []
 foreach module : qapi_all_modules
   qapi_inputs += [ files(module + '.json') ]
   qapi_module_outputs = [
@@ -110,15 +109,11 @@ foreach module : qapi_all_modules
       'qapi-commands-@0@.trace-events'.format(module),
     ]
   endif
-  if module.endswith('-target')
-    qapi_specific_outputs += qapi_module_outputs
-  else
-    qapi_util_outputs += qapi_module_outputs
-  endif
+  qapi_util_outputs += qapi_module_outputs
 endforeach
 
 qapi_files = custom_target('shared QAPI source files',
-  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs,
+  output: qapi_util_outputs + qapi_nonmodule_outputs,
   input: [ files('qapi-schema.json') ],
   command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
   depend_files: [ qapi_inputs, qapi_gen_depends ])
@@ -138,7 +133,7 @@ foreach output : qapi_util_outputs
   i = i + 1
 endforeach
 
-foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
+foreach output : qapi_nonmodule_outputs
   if output.endswith('.h')
     genh += qapi_files[i]
   endif
-- 
2.47.2


