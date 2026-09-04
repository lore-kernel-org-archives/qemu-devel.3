Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8156FC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJQ-0006DF-7Z; Fri, 04 Sep 2026 08:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJE-00067l-FM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJA-0006pC-5i
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-495590dde14so13332625e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525974; x=1789130774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ur+ntwxX3eXj7Zio7Z0Blbehu4cxmDZiiM7xTvB3xTU=;
 b=RxoIPPFIpuo33h6edNTvC4vyhUr4EdGs1dRYQm7upL6fvK2VwhyWI8v9NdnxLXdMWq
 DqD2Iu7yUecbe2KG7+HLBCHtWth73T0UXUFyS0QVXswGCB1i0qIYwZWigEoD0d11AO5R
 AQye3kGasxAwl8Np2i52qevUnvyAo1u1jNrB5BE+yQ9d74mjBWqCLabbfi6waePZQ/wr
 zwrj/yjaEz85iMoiwHCNGhl7HRKLV4LBTEaTm2Y/nmsda2yAI5Bobvaib0VAg4QVhG2H
 ooyjaZLfhnYVa1HVvUegJDNdy2aYS+iX/PxWV0/O0xfYABB5OoV4w/VKi7bjrH0wnm9f
 ABuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525974; x=1789130774;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ur+ntwxX3eXj7Zio7Z0Blbehu4cxmDZiiM7xTvB3xTU=;
 b=IsE9b5VMzqG7ClZjodZiuQg9pH/k5b8hTBeJlhUfTi6mycxr45TbtjyJ2/IC5IwOpy
 0JcVkeVTZFwzjDv9Ls7FZfHAczPXDDLPTk751YQnUB0cGeHsmie3nL5IOmkjNw2+ZUJw
 vavnqFiIRdIcpMl1/H2Sk5F2QxxfTXmv9FUTddvvCmrP4rsgCSiBrPoSwOEBydir012D
 p5DB72konjSL/E/jUeS/NCQBErDeQIQHjkfUsowrA0dho7aqaciEATfPnP5KMeBWR0hZ
 FL1J3Q4B8cct/fa23vDqyP4Uk2SNYSczbg08zd4Y4px5oqYT7GthJaZTJZKYa//dm8Sr
 7eLQ==
X-Gm-Message-State: AFuF++k9XjVvbQFo3NAQdMNivn+08z0ghuamp5ioDtLYouWcF9vmy1+R
 aRCsxEs1fLqzT6qeTofSrMY7jLtuMHuwQKinEWMly9g8k1lfE2R8GIhgKUEszbniCL0=
X-Gm-Gg: AYBFou07hhwGAGeocGNzIj+aKZxVwCGcXDydKrOS44gNs/zRZfElHC9jQh7ruQA/yu9
 e0mARpOPqEHj5iBE+05W6C5E7voA/KCwlPY64Cp6+Dzx5tezkJi514rZeQkaLbNp+g6ATqYH8kF
 dyH8jkopfxWYTDzkhSEDF9K0CmTYog2we3/wVAN433NPYa3Gs6OBd5N7ZiSIyWnWMuUE/MItuw5
 hOgSfjceY4syAdMj/kzlHxOSx5/JN5CrnxjOxdzBOLhdnOPsM/F4Tg2gK2yIQreHTQ+SJFQeX6u
 Uld0019rmd7sGnIfWBQN08SMMrGwL914CnYZ9UBdJku9W0tH5QlZfriQqZz6uJyieTZWmnhhzHl
 9KPopkXSFX9DcG0R32teD3CQsRIhiFRCeOkiyU273pCxSvlCgAQmvG/dbGJcyOv2My+0REAwZPe
 FQ9D084oa6kuC7bigQzoIBPTt2XL5Qj0t60q4qbKce1TulnbkYXqnTCp1+g3Uv
X-Received: by 2002:a05:600c:3496:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49cf7fe62admr94138225e9.2.1788525972143; 
 Fri, 04 Sep 2026 05:46:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7736132sm66126895e9.12.2026.09.04.05.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 562AE613A9;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 010/105] tests/tcg/meson.build: introduce env_var
Date: Fri,  4 Sep 2026 13:44:24 +0100
Message-ID: <20260904124604.2207440-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We add possibility to set an environment variable when running a test.
An example of a test requiring this is
tests/tcg/multiarch/linux/linux-sigrtminmax.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-11-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a7699b7f62d..fbee86e6b4b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -15,6 +15,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'env_var': ['VAR=value', ...],
 #         }
 #       },
 #       ...
@@ -57,7 +58,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -122,6 +123,10 @@ foreach target, plan: tcg_tests
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
+      if 'env_var' in setup
+        cmd = [setup['env_var'], cmd]
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.47.3


