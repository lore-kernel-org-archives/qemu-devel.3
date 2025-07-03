Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D93C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHgd-0008Mf-NE; Thu, 03 Jul 2025 07:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdW-00056i-7P
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdU-0002A1-53
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso4653452f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540265; x=1752145065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFzHeo6jxPUlGKhVCEILVY0U1JHXp5cH2Es3I4orHXM=;
 b=s3mI1R8XsvaLyZWhnXoznScq2ULroLL30nVsSn94RDRLP36UROd1a82MZT5w+Ggg01
 8Gf7GZ6L7qomvW12ha3X35ajXfwxDpx6cVtjMvwzazBj3aVrWtnF8pJVmMpcaIiPkkVg
 dpc70hTZBNK1O1hBTu1TstqnWfuVU72mqPP9k8wuYSZZdGqxG67JWy7567wikrRc+cIF
 YuhaRN1efxlyEjdw7cvjO5+N/jGEW94oKiOkbIVXtvFWqGEplJLKb4NFfzKHcBXlu4ik
 g0iHSOWBu4p661pgzRcoxWAvdo8/49XZkNMvuRg1OaUcO0e82fGdGHg9vlKg0VJHAQRb
 j8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540265; x=1752145065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFzHeo6jxPUlGKhVCEILVY0U1JHXp5cH2Es3I4orHXM=;
 b=of5A8+PCDsGhRGO36RktUzD9O5BSQjnpf1QynphZf/nFgjkbO+gac5Yp2s0Hpj8lMX
 C1AKB+z+da2kN4NzM3CUhhLhvwyVzYj5OZhB/2muTWhiR0I65ro+/Ofii68KFVMEsvSa
 lrUXBX7BezpbSgvW6e/GgarkKJkreQHlYl942Xkiwx0sQQQHU4AmNakZYl9y2+39AJe0
 z/kvY0UcpgGfFHUQyaHDPGDaZVAbiGEwpi3hiACCSoglfU2uSRmzfVKtDuxbE34OwSlw
 gOjH1PIyrpmziXgX2egN+IRG6V8PsQnvhSNeMLVESXqKlzgIzHuzoSlY+vGYTNE8Tnbr
 zzdQ==
X-Gm-Message-State: AOJu0YyjLig1EMgcJx7/hbTBNTUylElqXSAXDIGLxNHYAMBWytx/9HW8
 ikME8ULhTLMsS0UYUPielbPXyta+8P3vtFaNaPkrVA/niZPsmYYTcDL+rvnqxYhGMKr3XBLdIbS
 mMPG05j8=
X-Gm-Gg: ASbGncvTKcTDfIei0WFxaQGIcXz/6urmn2Te7tQucxzxBfJzYvk3EAUVyb1be6nOAov
 JdwR0K3E1Gt+Zyaf8dnl1cKIWwGcemsIXD6Q+0YiNl4Mq6IhjuwV5dvGr0NMqlzz3U4k3Rmg0Yt
 QDEUNBWp7jiiX08EKqDXEzX4F7U6ddyXIzKar+OZO1CZ+E+6iZxFZhYD1MfKhpxmJr1tFCuPiDW
 fYwssvUV9/7SUyG2eABSvIFx/aYYzuodud/Y4x9mlFADbxNkXrG5MeVSamDNgwxTYCyn5o5qxKl
 yUamd7J38fatUh0bj/oSasVhsLcC749kRLx0k4K/7w4g30u/9SSWt0Yqi1uOhJNabSlA3zxnRF8
 YTbqOhRnuFSk=
X-Google-Smtp-Source: AGHT+IEAxgYkber2BoZbpxWHNYmrPhoKyyUHP0ytzfvoDQ3IUz0aX+omL8kQvDgtuCyaaQmE9nYalg==
X-Received: by 2002:a05:6000:1a8a:b0:3a6:e1e7:2a88 with SMTP id
 ffacd0b85a97d-3b2019b825dmr5635776f8f.57.1751540264834; 
 Thu, 03 Jul 2025 03:57:44 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b32fb30c05sm1788634f8f.44.2025.07.03.03.57.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v5 23/69] accel/tcg: Remove 'info opcount' and @x-query-opcount
Date: Thu,  3 Jul 2025 12:54:49 +0200
Message-ID: <20250703105540.67664-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Since commit 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER",
released with QEMU v8.1.0) we get pointless output:

  (qemu) info opcount
  [TCG profiler not compiled]

Remove that unstable and unuseful command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json          | 18 ------------------
 accel/tcg/monitor.c        | 21 ---------------------
 tests/qtest/qmp-cmd-test.c |  1 -
 hmp-commands-info.hx       | 14 --------------
 4 files changed, 54 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index d5bbb5e367e..acf6610efa5 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1764,24 +1764,6 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
-##
-# @x-query-opcount:
-#
-# Query TCG opcode counters
-#
-# Features:
-#
-# @unstable: This command is meant for debugging.
-#
-# Returns: TCG opcode counters
-#
-# Since: 6.2
-##
-{ 'command': 'x-query-opcount',
-  'returns': 'HumanReadableText',
-  'if': 'CONFIG_TCG',
-  'features': [ 'unstable' ] }
-
 ##
 # @x-query-ramblock:
 #
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 1c182b6bfb5..7c686226b21 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -215,30 +215,9 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
-static void tcg_dump_op_count(GString *buf)
-{
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
-}
-
-HumanReadableText *qmp_x_query_opcount(Error **errp)
-{
-    g_autoptr(GString) buf = g_string_new("");
-
-    if (!tcg_enabled()) {
-        error_setg(errp,
-                   "Opcode count information is only available with accel=tcg");
-        return NULL;
-    }
-
-    tcg_dump_op_count(buf);
-
-    return human_readable_text_from_str(buf);
-}
-
 static void hmp_tcg_register(void)
 {
     monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
-    monitor_register_hmp_info_hrt("opcount", qmp_x_query_opcount);
 }
 
 type_init(hmp_tcg_register);
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 040d042810b..cf718761861 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -51,7 +51,6 @@ static int query_error_class(const char *cmd)
         { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
         /* Only valid with accel=tcg */
         { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
-        { "x-query-opcount", ERROR_CLASS_GENERIC_ERROR },
         { "xen-event-list", ERROR_CLASS_GENERIC_ERROR },
         { NULL, -1 }
     };
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 639a450ee51..d7979222752 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -256,20 +256,6 @@ SRST
     Show dynamic compiler info.
 ERST
 
-#if defined(CONFIG_TCG)
-    {
-        .name       = "opcount",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show dynamic compiler opcode counters",
-    },
-#endif
-
-SRST
-  ``info opcount``
-    Show dynamic compiler opcode counters
-ERST
-
     {
         .name       = "sync-profile",
         .args_type  = "mean:-m,no_coalesce:-n,max:i?",
-- 
2.49.0


