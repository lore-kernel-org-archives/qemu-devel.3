Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3810C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufGoi-0001Kq-8p; Fri, 25 Jul 2025 07:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoV-0004mo-U0
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoQ-0000Mq-J4
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so23062525e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 04:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753443725; x=1754048525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5hME3X1HHlYx7jug7j1WjMyRf8G3SfkM4to7g0GptTI=;
 b=FpxIpfKt4dCsG0VEDwklOYqHroYHBYXe0yB+yEdCwl30osdbrg0eaHYVqKhoScUM4b
 OipmZuaHE2Cd2m+wsRO2+2QnAb4ZPCf5EDJmriTzfwvakPU8KlWwflrvViiSMH0ZUfH0
 t4x65Qn8xPUOS2rT7sS1EsGubS45xowUHwetbc7sI304Qe2vI0zI78TdcFZk1RAWFOam
 vxooArpmurhxAj5fRWVH0R3U9AlwBbLil1mfVYHVWQ40ZmccbHnWG/vPgsXYckxRxCe8
 I0gyTMfS48bLNchEQzHECOdAe99JYEHu4goVFgjMBg/6EMJW7Ge6PPFjRQ6IJC9RXxDG
 LhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753443725; x=1754048525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hME3X1HHlYx7jug7j1WjMyRf8G3SfkM4to7g0GptTI=;
 b=OUL0wAHDE7rG7K4AgApwu6Q2hVyLd9wmvW2OCDoVKfiQjQz1cb4civvFGGyeEZA/73
 CnOVbl9UEpkEuvWo6dFB+FdiXNQMy6Wm3y7UeWBfpqDh1Vj4z0hJZYfFDhb6qD/AyquJ
 9fflO9bR87E3L3XSr9IsET4lSLFtrd767nB7lPVmTsuTon1NAPGSSctcXr5ZdabAyCHy
 HoONJVUczeyfsVOs9eSkoctJU6wxgqfJcwqiNZMbWUiDGi1tApKL5ecZF4cw9zyg8XGx
 ev33vCTwH2TeodRqvHV15hQeHzNNsKlDip7o5JvTDKLLjOOtJI6/cvZMAiEZDEERVL7k
 5Kzw==
X-Gm-Message-State: AOJu0YxSvDoZbxLKDF121EnolvI7dCnBpwOr4UESsTBFqjsWssfbb3PZ
 Sngfk5GYr0WdWKuZ7DKIY8hsBqb6tVe1DjYjH127zDhF31+6HFnnEW+6IOQxu4hI10ThzHzU/G8
 YT25T
X-Gm-Gg: ASbGnct4W+2Ue4y9UfDDmva6rAxzGF4NHdujwrt843ZHYRP1Uejlhf0Y4YXDOC+hXdw
 MuHNYOHxNdor9dFIOxnEeYIrKpnjlzdyk3DlrEkIGE4DYE58ydNqxnsRuUZKVwS0hfooM2E8zk1
 MiULKqxocVT431DWzvfTuKNLFBZTABHcO5UMLeQxyxnqm7fcohwFjREtKTK6OFz3I1ndeDccnZd
 1T3MSjOr4xlpHK1d7MGlbUs/WUzhY7QAAIneuZH6//Or3KJO2FO7an3G81WXuOTzmefg5WIeOMu
 P2Po+Dz2enOWL5bM1isedJmZAmoAiPG8PZMMNtH0hA3lHGAilnhTEUp7ty0fPZ6FFcu5BmCY2i+
 qbbykXFyNTNUmDBW0AuLO1a37WMd+9+2MG+4725E=
X-Google-Smtp-Source: AGHT+IHep78982ZC92XsGEr/9P8kxrC/DogZkAps0PGOHGCwlEqTMoAJ8BzzXj+yd/Xn2g/GA+Jd3w==
X-Received: by 2002:a05:600c:4444:b0:456:1611:cea5 with SMTP id
 5b1f17b1804b1-45876549d1amr16664485e9.18.1753443724537; 
 Fri, 25 Jul 2025 04:42:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870568fb1sm51230105e9.27.2025.07.25.04.42.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:42:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] decodetree: Infer argument set before inferring format
Date: Fri, 25 Jul 2025 12:41:53 +0100
Message-ID: <20250725114158.3703254-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725114158.3703254-1-peter.maydell@linaro.org>
References: <20250725114158.3703254-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Failure to confirm an argument set first may result in
the selection of a format which leaves extra arguments
to be filled in by the pattern.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250723165458.3509150-4-peter.maydell@linaro.org
Message-id: 20250722183343.273533-1-richard.henderson@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/decode/succ_infer1.decode | 4 ++++
 scripts/decodetree.py           | 7 ++++---
 tests/decode/meson.build        | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 tests/decode/succ_infer1.decode

diff --git a/tests/decode/succ_infer1.decode b/tests/decode/succ_infer1.decode
new file mode 100644
index 00000000000..6fa40bada5c
--- /dev/null
+++ b/tests/decode/succ_infer1.decode
@@ -0,0 +1,4 @@
+&rprr_load      rd pg rn rm dtype nreg
+@rprr_load      .... .... ... rm:5 ... pg:3 rn:5 rd:5            &rprr_load
+
+LD1Q            1100 0100 000 rm:5 101 pg:3 rn:5 rd:5
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e8b72da3a97..f992472b73e 100644
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
index b13fada9800..63405ca08fd 100644
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
-- 
2.43.0


