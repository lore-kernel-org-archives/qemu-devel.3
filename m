Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4355EC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLjC-0001pH-4G; Wed, 14 May 2025 19:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj8-0001gv-2y
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:30 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj5-00035P-JA
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:29 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b0b2d1f2845so184509a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266086; x=1747870886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwJjemUjD9ZnxOnBtW/8nh4JOR16dJgUBDJaYDLzvO4=;
 b=q/mhxlVhoWI/pXeF1zd2OOKj6hHyuuR4IXG/Nv/CpVkG1h7CXJ5fPl0S62RRZ3Fabx
 OOVy7DIkt7o+ngW6cCY0MqQ1raFoEL//9PzGsgQVqDnYYUDU7rSdi8U7tXgtJAgih+9O
 ATCZR+1OOp4SZGxd/xBaTa0+xxbLrhDbu7xIqQlCHYFlc6aXjId7gsHbe6qTckBHIuRj
 YljzE4pLRgk2AjZ45oIXX3fziRuSBgtnwknGanc6XEs1WKMKP1a8tAKyB/TyH/yBXQSb
 aqT/WBbvqgGeDtmb8tnwycGKhzC+XSAtjaCiq2jphz15UmWGXuO2GpXPRJGBI95kQl6T
 oJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266086; x=1747870886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwJjemUjD9ZnxOnBtW/8nh4JOR16dJgUBDJaYDLzvO4=;
 b=kBnlsUkEdRMBd01qd0qPaAJPRtVOwT/gkp4NoZ+H9gMFX0+Zvvx7z28YFtH6b3nPuw
 pcds41A6XhUQAHkBm6/jjjsq9G5weJVysdW+wj/uBK3WTVjAoxry0KQc4x6rqQDm/JGa
 slBE0OoGkf+u85tJZL24N29djTpFhyeFbRlVTEfkIIuYZyojMEt5pmuWNQJ1PGbW4vCO
 f3WS5eNQn5pLkcwY/PCIIs9rENtINuYzXsPdl7L4yyKDMFm+HY1YTRBUp4f1FOx40JtS
 BD3pldYOsCGEf31xO0ibyjuRWi4rXHYXrOrAUMOMj57Rcrq+nnrev/cjnEV7ksnbTbSb
 GzuA==
X-Gm-Message-State: AOJu0Ywi9RZ0wVlKMuCaZ4M3QcOc86z+VlkiHHXbUpQQkiDMnyiKYgam
 5FajUMnaLPEFzYtJzgoVdT7FLACP1ll+Xh8ido5idGOTpblvCBBEwfFFZBWK3tRuTO1T3SdR3GO
 FRck=
X-Gm-Gg: ASbGncvcnjA4GykSiZEIq8eVbCSBoVAt/MEbg22+hsNL+FK2khSkGktUYCIKN5AYXIk
 xG1jNhepTkYcxGzXRWipj/yXBeGisexmRTfQn2x7bNsukF/+V+3zVCWPFj3ou36xmhHGy/sq52V
 xkgOmtHh/4EfAmiMfvWfqIvnvMevto1VfBRsKQhlqtbkhctAWty5bp95itLCM0p3vrOAAgCCGvV
 6duRbqjWo66LsoR/WqfThGCVM7q1bXPVtWI3Kicjk3bpCUPXuzxyB5jVxDuml8HNbUkZiwffeUT
 zRrZ/JCYh5OAVpYsBcI3n+7jnN0AqmdxZ3zOwSgvFgZlbgE1Guw=
X-Google-Smtp-Source: AGHT+IFBAzu3kofMsAZ4FKw7lJ/7uG9lgi2y490lG8850VnNBv6/ae3XyCp/TbtZ8Ip/D3yWZci9GQ==
X-Received: by 2002:a17:903:1207:b0:224:b60:3cd3 with SMTP id
 d9443c01a7336-2319813ec9cmr78295375ad.19.1747266086203; 
 Wed, 14 May 2025 16:41:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/12] qapi: remove qapi_specific_outputs from meson.build
Date: Wed, 14 May 2025 16:41:07 -0700
Message-ID: <20250514234108.3746675-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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


