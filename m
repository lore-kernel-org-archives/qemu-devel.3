Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ED2C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whLRe-0007tc-Q0; Wed, 08 Jul 2026 02:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1whLRd-0007tS-Fm
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:07:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1whLRb-000448-M1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 02:07:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so1565325e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 23:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783490857; x=1784095657; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3TisMpFl/Syl8+nN9N6owQzKy767dHehgqqcUfkCHiI=;
 b=eRN81zb9Iv/wUIn64AUufuelSxM2wa96X8qkedrn18Yqaml+XQch4+eedA5MUXvx03
 uWL3PuaRWgLFaKYR2WcDXgW+b/JNUFUF06lDNPRc2PmQ/AwZYzhPkvVEg4gJuoRQyQJ9
 nURpI0TJEAUlkBAjPZ5sUmxGZyilOXP7c3AIuI9KU52DjBcuwbVGKs/enzTqGqKCs01w
 8UCaDS+HIIcyLgO4Kaf9q/wPROgyPeIBERUV0fEjAeeGfS31P5d1mt4lXj//HegB+o9X
 JOVyp1UU7hbXh5LwwO0HIUxRmRrJJd9jCevvSE3Qr+jLF4YOh2CR4yfhNoTAzaXhiYmz
 wR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783490857; x=1784095657;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3TisMpFl/Syl8+nN9N6owQzKy767dHehgqqcUfkCHiI=;
 b=NS8X/7TNK0P5Z7gl86uQx/M7/Y7IeNyLR3D36w4dUkucdA4X46AsugSobtAdMVz/oy
 J2BSr2Jz5VWYdAupvvAjVsv3UXvoyIDVWDtXtDH/vTZyyYmWX353IfMMNS/N2mn8fAgZ
 WWAtw31f88mCnI/GMsrR7/mgay7Eqevikbg+ekxvhiWv6fVIOI9eo7nxyhZJE//kNObt
 4gt4M2YUS2kUJwqwIeeoLmXHeAxoV7oODXA8VXCsWkReEYTTtFMpobJo+c475KYA4l63
 +N0CFOJFrlveyLr//zImAhJWprTIYICkXxL6QBSSmWsnxpcOQAUOVGSOY733u7gtgrAf
 VznQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrflwOxy25do7h36CRvBE/Tf8EiOp9YPglfqF+ieOKJREenFIWdhxUYwo3MvqzYZLT/6XYeZe23dxm1@nongnu.org
X-Gm-Message-State: AOJu0YykEPW+njRSZmKTG7vvkuwW1pzjfLqsyihxEqe+VpbehDIO42CT
 stKX+fROEnazAcXSP80g5fNgkToJY1pTMhCwIf7enb0lvL78i16vCBJ72J/edEAsdl4=
X-Gm-Gg: AfdE7clcgkt4nWeCd2DYizqGon7ecBqzqMX3sRg0WnB6VWL97J1kw/NPHdEsZHwLgJZ
 sLq67jO03QeTwGSqFj9KHcBmc/Bgwp56e+EsEIYbJVpSzqWhj7/jsZ08kI+hgGXeJS/FOxCdPGt
 tFpTIYuItr/mwhigiXj/q45iMDbHJZZ3DStGWpHZrAQMWigjKmdEa3KCcHSfXuwA5bXk4nRJ35S
 q2JYMJGCXJUVWzWBtZWGt5oWIY1l0kJ1HoDXpugcvkwSQlxGneO6iZJfm3YcATsdM/QAiI4XLD8
 uPtJxFwdYa9DI+y37R62l+6BMzj1Ahaa6uC0tL8NJol1MlV+EzqldBL9vV4Vhv3tpr5iqxEfKni
 N4KG5VBalNLwK0Z2zJJQBDM2Ui3Atwi+d05MBWtSbANtDTm5ttShkhrQyiOnT7R5Ziso6G3iNtj
 Yzkd+5pm4hOi/cUks9WsyU06CyhmzE7WMqMsGsgMkXJJUrrvlam6Gqt9mUexWnA+2MUMIx1YSe7
 Z2XmBpTx2RbP+hMz1VytEL3PWn5jUUDKNOHYPnAvT12OvBgsPcjeY0/u25BJ4Qt2B8QNC5dmplw
 rU1YjyRNE0d/ecymOPi/FyvgiEaLXapRIe53dV7jN+ic1WNeL/7qFo8=
X-Received: by 2002:a05:600c:c3cd:10b0:493:e533:e220 with SMTP id
 5b1f17b1804b1-493e689c009mr6055765e9.9.1783490857193; 
 Tue, 07 Jul 2026 23:07:37 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e54a25cfsm43964315e9.0.2026.07.07.23.07.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2026 23:07:36 -0700 (PDT)
Date: Wed, 08 Jul 2026 09:07:23 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daud=?UTF-8?B?w6k=?= <philmd@oss.qualcomm.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Alex Benn=?UTF-8?B?w6ll?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 29/91] tests/tcg/meson.build: introduce depends
User-Agent: meli/0.8.13
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-30-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-30-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thuecn.j82o3lid8j7j@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

On Tue, 07 Jul 2026 01:32, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>This can be used to declare dependencies for a given test executable.
>Useful when generating headers (like x86_64 does).
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 16 +++++++++++-----
> 1 file changed, 11 insertions(+), 5 deletions(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 57e7c3f8801..1f553a0aa8d 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -41,6 +41,7 @@ tcg_tests = {}
> #           'exe_name': ['provide an alternative binary name'],
> #           'test_name': ['provide an alternative test name'],
> #           'cflags': ['additional cflags to compile test', ...],
>+#           'depends': [meson_dependency, ...],
> #           'cc_feat': 'feature name, must be present in cc_feat_cflags',
> #           'qemu_args': ['qemu command line flags', ...],
> #           'expected_output': 'file_to_compare_output',
>@@ -164,7 +165,7 @@ foreach target, plan: tcg_tests
>       # return a clear error if user misspell a setup entry
>       foreach key, _ : setup
>         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
>-                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
>+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
>                    'test_name', 'wrapper']
>         if key not in allowed
>           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
>@@ -262,6 +263,11 @@ foreach target, plan: tcg_tests
>         built_tests += {exe_name: exe_name}
>       endif
> 
>+      exe_depends = build_test_depends
>+      if 'depends' in setup
>+        exe_depends += setup['depends']
>+      endif
>+
>       # build executable if needed
>       if exe_name not in built_tests
>         exe = custom_target(exe_name,
>@@ -274,13 +280,13 @@ foreach target, plan: tcg_tests
>                                       cflags],
>                             depfile: exe_name + '.d',
>                             output: exe_name + '.test',
>-                            depends: build_test_depends,
>+                            depends: exe_depends,
>                             depend_files: build_test_depend_files,
>                             build_by_default: false)
>         built_tests += {exe_name: exe}
>       endif
> 
>-      depends = []
>+      test_depends = []
>       qemu_args = []
>       if 'qemu_args' in setup
>         qemu_args = setup['qemu_args']
>@@ -297,7 +303,7 @@ foreach target, plan: tcg_tests
>         plugin_args = ','.join(plugin_args)
> 
>         # since we turn plugin into a string, add dependency explicitly
>-        depends += plugin
>+        test_depends += plugin
>         qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
>       endif
> 
>@@ -352,7 +358,7 @@ foreach target, plan: tcg_tests
>       endif
> 
>       test(test_name, env, args: cmd,
>-           depends: depends,
>+           depends: test_depends,
>            suite: ['tcg', 'tcg-' + target])
>       added_tests += {test_name: true}
>     endforeach
>-- 
>2.47.3
>

