Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC8EC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 18:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueHoG-0005XE-01; Tue, 22 Jul 2025 14:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueHoD-0005VB-3A
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 14:33:49 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ueHoB-0008EB-AC
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 14:33:48 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso5240204b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753209225; x=1753814025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Af8w8gVpGTRFsWYjQ9qaY5yWO7L8dh6o2BcO+KrPJCY=;
 b=zRqP4yrtz34qoO5vTpLRMNDR8jiqDiq88ZuwhSILUhvLylRBOSTRTDFQYlnDZaXJiu
 ltH6i2HPobcU+VF1dsjcZ98XOEr7ZK7+A7SwOBAP2TCP6PvHJIMQSYsmyOFfY96/jIUG
 asz8fKSBA5q/LGt4WfoKgcEaQCKnhxwu6UVFvpDmOllMfh5wi35pqwsOl3UYbttPExnY
 TSh1RXRlk2sBzRiGapI5HEdSk/MlRpgp0QWi5Ua4wm/0ON625fK2ppFP7Ozy0oAqZErA
 gn0uZMfSx5DjjUMB8iwYqZiFETxKI4B1PBJFIonBpUE7M0CChXnV7o/PObeuijovf+Mn
 0fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753209225; x=1753814025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Af8w8gVpGTRFsWYjQ9qaY5yWO7L8dh6o2BcO+KrPJCY=;
 b=kmdiGtJZzoKN4DqdPsVE02PCda1ERTjIZUGySHrKnhx1951a026aC+a54XUaktl3L1
 rKoHsAsDxRfx2QSj3izHm0pTTFvRExqRGRGXFfm8NXXa5Nf44ZutcTyn6vZcKT5dOlGR
 3qQ8VxyYgqxSJB1WKNHTV748S1YfdvknKjTmJy+k0lCjDAlO9HfmDzh7tbbPeEBSrEm6
 GeEoYKl64fCONjHq5k4NmYN+gHKPmJw+SRKHYzIctAyyV6haBkXB/xS0JQ8K/VoTUkL9
 Z6W2a4OxrkkTGkiPTgghD1JWyfhkLsVEbADYuskTGlXq37g60HY+TiyTey3lc/p2xOX9
 KXeA==
X-Gm-Message-State: AOJu0YxOZBc6pRohcTgfEUTYSTCyops+bnOXKnMRt8VmDOLXJ0pVUP1L
 uczMGGRBwdv913etWAeiOQj3VFiOMt5cgBbnDlMTTYb4Samyqxq2jShsXEWaXb15L8J6JsM7iMx
 hnLer
X-Gm-Gg: ASbGncttz3nSklTNMwuwHJYGTxRPp6aM9JiQmHl351bQY1kuRfR9gdNZs8GriNUuiG7
 DCZysXt4X9YI11o8wTmjlbBGMTCoXVKcWWGiceLRwNOqc/v5kJXLts/2WIJnSYA62gbDWVm6w0u
 wA+0B7p+YmwVq721tysxyGumros17FtNv42rLz03vCfCmpi0M91gkOVVrE4KKvdjrtZ3SYcJW+K
 h1fgr9MPXZSspilrCbdsDgcGNDtnBqBJCplUBqoME/Rdy84CpvTLh9W6EoZy6MmHIEXT1CC0D/X
 0sAj6EIUtxd3cSellz1zMIg7+i0/nWmbO/0GQs9+vejLE9mGSnzL7aiqSeYfn0Q4tz+0gyf3LfV
 DzKZgDjEiKBjTrPs25Qj7XTDtwi54
X-Google-Smtp-Source: AGHT+IHANaMpF6E/OnHe+11Mwu+5hqh7ja+sM2fMslZpTHqQnnCxQaD501sWUsO1LOR+DtHada29OA==
X-Received: by 2002:a05:6a00:174a:b0:758:284a:9128 with SMTP id
 d2e1a72fcca58-760353f4306mr407733b3a.19.1753209224930; 
 Tue, 22 Jul 2025 11:33:44 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbc68095sm7976395b3a.139.2025.07.22.11.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 11:33:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH] decodetree: Infer argument set before inferring format
Date: Tue, 22 Jul 2025 11:33:43 -0700
Message-ID: <20250722183343.273533-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Failure to confirm an argument set first may result in
the selection of a format which leaves extra arguments
to be filled in by the pattern.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py           | 7 ++++---
 tests/decode/meson.build        | 1 +
 tests/decode/succ_infer1.decode | 4 ++++
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 tests/decode/succ_infer1.decode

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e8b72da3a9..f992472b73 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1016,9 +1016,12 @@ def infer_format(arg, fieldmask, flds, width):
         else:
             var_flds[n] = c
 
+    if not arg:
+        arg = infer_argument_set(flds)
+
     # Look for an existing format with the same argument set and fields
     for fmt in formats.values():
-        if arg and fmt.base != arg:
+        if fmt.base != arg:
             continue
         if fieldmask != fmt.fieldmask:
             continue
@@ -1029,8 +1032,6 @@ def infer_format(arg, fieldmask, flds, width):
         return (fmt, const_flds)
 
     name = decode_function + '_Fmt_' + str(len(formats))
-    if not arg:
-        arg = infer_argument_set(flds)
 
     fmt = Format(name, 0, arg, 0, 0, 0, fieldmask, var_flds, width)
     formats[name] = fmt
diff --git a/tests/decode/meson.build b/tests/decode/meson.build
index b13fada980..63405ca08f 100644
--- a/tests/decode/meson.build
+++ b/tests/decode/meson.build
@@ -41,6 +41,7 @@ succ_tests = [
     'succ_argset_type1.decode',
     'succ_function.decode',
     'succ_ident1.decode',
+    'succ_infer1.decode',
     'succ_named_field.decode',
     'succ_pattern_group_nest1.decode',
     'succ_pattern_group_nest2.decode',
diff --git a/tests/decode/succ_infer1.decode b/tests/decode/succ_infer1.decode
new file mode 100644
index 0000000000..6fa40bada5
--- /dev/null
+++ b/tests/decode/succ_infer1.decode
@@ -0,0 +1,4 @@
+&rprr_load      rd pg rn rm dtype nreg
+@rprr_load      .... .... ... rm:5 ... pg:3 rn:5 rd:5            &rprr_load
+
+LD1Q            1100 0100 000 rm:5 101 pg:3 rn:5 rd:5
-- 
2.43.0


