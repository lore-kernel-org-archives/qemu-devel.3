Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3CBC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNoY-0005Wf-5b; Thu, 03 Jul 2025 13:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoT-0005W5-H6
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoR-0008BJ-6Y
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso39852f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564006; x=1752168806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZulNH5mkAwF/TzCScDw4HrR7IGxHx1ghZxE2rlPXYg=;
 b=SQ+edPPtYFTzZdiFudWCR1aWyUwlNWy0IOZzQUiKgBh/jmcOVsQug4mOmSiSRjLWl6
 ydkdseMgFt3WBn2cWmDIAkAtJrJvgvVLPkJIDYrDCqfaP+rV7k8i0H/7YI9K+h0R7cTE
 YiVMCf+esHSmPgnlX/qfkKmadTrM5GvIa2fjv2H7DfryDsWnY4+qGlzGGFqFn+fRftsO
 QbR5Nw6VqTeJICVFkuOFaPxgplgkakFPZMPEa09jihfruTUYDDsPdpWCUmgigZbd/bzY
 SZLTfV4Q26ptQPd1dcApqOO0e9/g2Mru228cKL2cW9jPlQpXu0i3q40iDY+IQUEhDIY0
 h8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564006; x=1752168806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZulNH5mkAwF/TzCScDw4HrR7IGxHx1ghZxE2rlPXYg=;
 b=gsW6S6FZf4zRJepLtTm4pZl4If/gFdIu8BrEd9mS+Y0VVq/wz3Az7F54NIH/ZvK0hv
 4OfXa4i191DkMZpyu97Zzdj2a+A2BC0+fIGT6TscyXPC+Lz0LcGNcP0ESo1I8e/YbCYM
 cnEXHN9qrj1uxqhj7ECXixwEunoJ+Sfvv8WFGjE+rfd7T1VycCPCt44E6S31uU53Sz1O
 FQCRIpfGHIlSBwSVh7TTfYtBVopV3wM51foBfOpl3dk6v+OLPBKjZP+5685/wQB4H1/u
 DMZv3R37nh3Xj6wmQ2omLvlDjmKJFpHJAQvpWEUUQl8dMJUD7yT6Y0gYmmfMSWSEJ/GQ
 pMcw==
X-Gm-Message-State: AOJu0Yxg5ZLkkolsu9bTeuJodO1ou+PNQr25RfxWJ7ZQk5tg2i5lOCQo
 k8XUBvL/h42p1rDTcy0XSHd+pQNLUcYRywTwJ+fULJGXaazt5P8pIhiwzTDR9N4jfBKQPbWj/9H
 sVjP8UtU=
X-Gm-Gg: ASbGncvKeVpm+U/0Y3p6RLwmJDGlnUTa5/8IhinFouKKurIyQEiPourO7q45uwhaZVO
 E5CndVIxV7r4ABdSDXyo/eU4JiFMqLnuQ4Nl2CoBlWgVBxt29y+EYncmhRsyAN9TUxZxRKCec7i
 HHRftcpTT5VbxxPapgCVRTobRuIZViggIa7FlzbkpyuhtvRj+5uqZSobW7Y9hSsT4Pq2rWPegs1
 82xZYziZEZfZXrxu/71RWJLIoSqjKUxeo506Oion1l2yqkNEKPjEpDmp0a+vX6yZiXip3mKCaZX
 GnQ2OlAOQA86h6Nc+x/Drivn3XDas6LjPSJIRAvthRKjQ7cjc9lvA0R1HYxGFQKZOxv9ouFaMve
 6KQaI2TIg38IYg/czUzIbvzMHQcpk3YFoxCBEUWOEUHAs8Ug=
X-Google-Smtp-Source: AGHT+IFJrXavrz4gcHEYbc6mLp3BMnIH4hlLyNy+5zffQ8hUE11DhK5AiKJrHVi2KGZKSRJD/i72dA==
X-Received: by 2002:a05:6000:230c:b0:3a5:8abe:a267 with SMTP id
 ffacd0b85a97d-3b32db890fdmr3631644f8f.29.1751564006205; 
 Thu, 03 Jul 2025 10:33:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030ba77sm342996f8f.17.2025.07.03.10.33.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v6 07/39] accel/tcg: Remove 'info opcount' and @x-query-opcount
Date: Thu,  3 Jul 2025 19:32:13 +0200
Message-ID: <20250703173248.44995-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


