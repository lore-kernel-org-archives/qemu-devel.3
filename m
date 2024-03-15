Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EDEC54E6E
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7LN-0001l5-It; Fri, 15 Mar 2024 09:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7KW-0007Hv-OB
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:37 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7KQ-00089U-Cr
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:36 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a468616ed70so87817766b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508228; x=1711113028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PuQ6WSEYLWnTCNPDldZo+Ppk/XGMtRnTbQuxwxDUsU=;
 b=N8uBIKKOFTKMTS2NhbYeYgKi9oxDwQ82f1F/hTkHPOKcQrXxY2o+Ar74bgtCAG++33
 afYmL6YtPS+Dl7GLQ1swVJ8qMN7WDvjoLCknXnWrNBuItICyvI6oC3RrDdS69t9zF/7w
 2F/5ROMzWcySpVTOkrpFHY/mUQrAYEWhLdMJb2a83DNE1o6NarOao0o0QVNz4YzzhtFu
 3PwdTOOq4Nsl6Kkyw7CS8iqgTvTJbfp0tknt5avEvdfkq3xoLnlP6WdHcQB4+iDcVopZ
 6MhduNeaSoNnCkgr51EDrLu0kMs5ivZ4jLFnOjCwuu2lqLWrzFNgdfrFuDVKisjEBule
 PwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508228; x=1711113028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PuQ6WSEYLWnTCNPDldZo+Ppk/XGMtRnTbQuxwxDUsU=;
 b=tY63dYRMP1LsTPo+LzONT1daiyomZU8iyLdYmaNVf26xQFY//U4gjorETa6pxaF3NP
 jQHgbkbHvsWNx4fS6O1fX0q3JbuTxbPCMA3leiitFVeDy8RZHalC46qUiiSbmV9QDZco
 tGOu7fG+ItKiyE4opk+iU2WCxi/urXNLOKqugCUjJHf4XuVEZouHrgYgldX2im6eUJ4c
 tP7dSd03g/R58xKjn46NnqAZdf+DnFWvnmJqrK0YcKpDGMfMWv/VQ/9dlN+5FBSBXvR0
 mkEVtWOREiboR8fL0AoKbe9IBU3skVcyFWJZklbf6tNPPtt68cdIShoIat/Nt2xeH9he
 qiYw==
X-Gm-Message-State: AOJu0Yyp21e8g8jPcrOy6hZZdHh+bR/fv3iDU35mktc7djTPlage7DxR
 KIe+8FIMR3AwxOZw/CE2CHSIZ/yRv/wua1WyaAGQTxkc0z7sSmTVDPWTBuWmI1T8wUT42+jpr+w
 0
X-Google-Smtp-Source: AGHT+IHgeAMf1+cGAIhix5rGRpA+zqYrLpk7WoUtK15pKAlNv3sQvH3L0f0P3bef1BLZ9RiIeTQhug==
X-Received: by 2002:a17:906:f845:b0:a3e:8300:1af3 with SMTP id
 ks5-20020a170906f84500b00a3e83001af3mr3107382ejb.30.1710508228508; 
 Fri, 15 Mar 2024 06:10:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 jl27-20020a17090775db00b00a45c9945251sm1696627ejc.192.2024.03.15.06.10.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:10:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH-for-9.1 11/21] qapi: Make CpuDefinitionInfo target agnostic
Date: Fri, 15 Mar 2024 14:08:59 +0100
Message-ID: <20240315130910.15750-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Generate the CpuDefinitionInfo type once for all targets.
In few commits @query-cpu-definitions will become generic
and all target will return their CPUs list.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine-target.json | 69 ----------------------------------------
 qapi/machine.json        | 63 ++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 69 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 0412400df3..7480921d33 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -212,75 +212,6 @@
                    'TARGET_LOONGARCH64',
                    'TARGET_RISCV' ] } }
 
-##
-# @CpuDefinitionInfo:
-#
-# Virtual CPU definition.
-#
-# @name: the name of the CPU definition
-#
-# @migration-safe: whether a CPU definition can be safely used for
-#     migration in combination with a QEMU compatibility machine when
-#     migrating between different QEMU versions and between hosts with
-#     different sets of (hardware or software) capabilities.  If not
-#     provided, information is not available and callers should not
-#     assume the CPU definition to be migration-safe.  (since 2.8)
-#
-# @static: whether a CPU definition is static and will not change
-#     depending on QEMU version, machine type, machine options and
-#     accelerator options.  A static model is always migration-safe.
-#     (since 2.8)
-#
-# @unavailable-features: List of properties that prevent the CPU model
-#     from running in the current host.  (since 2.8)
-#
-# @typename: Type name that can be used as argument to
-#     @device-list-properties, to introspect properties configurable
-#     using -cpu or -global.  (since 2.9)
-#
-# @alias-of: Name of CPU model this model is an alias for.  The target
-#     of the CPU model alias may change depending on the machine type.
-#     Management software is supposed to translate CPU model aliases
-#     in the VM configuration, because aliases may stop being
-#     migration-safe in the future (since 4.1)
-#
-# @deprecated: If true, this CPU model is deprecated and may be
-#     removed in in some future version of QEMU according to the QEMU
-#     deprecation policy.  (since 5.2)
-#
-# @unavailable-features is a list of QOM property names that represent
-# CPU model attributes that prevent the CPU from running.  If the QOM
-# property is read-only, that means there's no known way to make the
-# CPU model run in the current host.  Implementations that choose not
-# to provide specific information return the property name "type". If
-# the property is read-write, it means that it MAY be possible to run
-# the CPU model in the current host if that property is changed.
-# Management software can use it as hints to suggest or choose an
-# alternative for the user, or just to generate meaningful error
-# messages explaining why the CPU model can't be used.  If
-# @unavailable-features is an empty list, the CPU model is runnable
-# using the current host and machine-type.  If @unavailable-features
-# is not present, runnability information for the CPU is not
-# available.
-#
-# Since: 1.2
-##
-{ 'struct': 'CpuDefinitionInfo',
-  'data': { 'name': 'str',
-            '*migration-safe': 'bool',
-            'static': 'bool',
-            '*unavailable-features': [ 'str' ],
-            'typename': 'str',
-            '*alias-of' : 'str',
-            'deprecated' : 'bool' },
-  'if': { 'any': [ 'TARGET_PPC',
-                   'TARGET_ARM',
-                   'TARGET_I386',
-                   'TARGET_S390X',
-                   'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
-
 ##
 # @query-cpu-definitions:
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 65702c2c78..9c44b8fa82 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -10,6 +10,69 @@
 
 { 'include': 'common.json' }
 
+##
+# @CpuDefinitionInfo:
+#
+# Virtual CPU definition.
+#
+# @name: the name of the CPU definition
+#
+# @migration-safe: whether a CPU definition can be safely used for
+#     migration in combination with a QEMU compatibility machine when
+#     migrating between different QEMU versions and between hosts with
+#     different sets of (hardware or software) capabilities.  If not
+#     provided, information is not available and callers should not
+#     assume the CPU definition to be migration-safe.  (since 2.8)
+#
+# @static: whether a CPU definition is static and will not change
+#     depending on QEMU version, machine type, machine options and
+#     accelerator options.  A static model is always migration-safe.
+#     (since 2.8)
+#
+# @unavailable-features: List of properties that prevent the CPU model
+#     from running in the current host.  (since 2.8)
+#
+# @typename: Type name that can be used as argument to
+#     @device-list-properties, to introspect properties configurable
+#     using -cpu or -global.  (since 2.9)
+#
+# @alias-of: Name of CPU model this model is an alias for.  The target
+#     of the CPU model alias may change depending on the machine type.
+#     Management software is supposed to translate CPU model aliases
+#     in the VM configuration, because aliases may stop being
+#     migration-safe in the future (since 4.1)
+#
+# @deprecated: If true, this CPU model is deprecated and may be
+#     removed in in some future version of QEMU according to the QEMU
+#     deprecation policy.  (since 5.2)
+#
+# @unavailable-features is a list of QOM property names that represent
+# CPU model attributes that prevent the CPU from running.  If the QOM
+# property is read-only, that means there's no known way to make the
+# CPU model run in the current host.  Implementations that choose not
+# to provide specific information return the property name "type". If
+# the property is read-write, it means that it MAY be possible to run
+# the CPU model in the current host if that property is changed.
+# Management software can use it as hints to suggest or choose an
+# alternative for the user, or just to generate meaningful error
+# messages explaining why the CPU model can't be used.  If
+# @unavailable-features is an empty list, the CPU model is runnable
+# using the current host and machine-type.  If @unavailable-features
+# is not present, runnability information for the CPU is not
+# available.
+#
+# Since: 1.2
+##
+{ 'struct': 'CpuDefinitionInfo',
+  'data': { 'name': 'str',
+            '*migration-safe': 'bool',
+            'static': 'bool',
+            '*unavailable-features': [ 'str' ],
+            'typename': 'str',
+            '*alias-of' : 'str',
+            'deprecated' : 'bool' }
+}
+
 ##
 # @CpuModelInfo:
 #
-- 
2.41.0


