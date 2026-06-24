Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6BACDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPrs-0004Zs-1T; Wed, 24 Jun 2026 11:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcPrq-0004Ye-G3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:50:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcPro-0000EY-Nr
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:50:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4926046fbc5so91175e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782316218; x=1782921018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2H2ri/oSMaHNxjWTJsX+4cgbNnxXsBrVDobbD4DnQA=;
 b=tahuueV5ki2r/IN0F5+01gcNsBWXCq0KKJYhS27WLRQsIQNfL1Bl8VvkmI25OUowP8
 KxK4NmQw7hT0VW3/SXVI2+bePibSusTqo4MaMSpICrKXQi83CjfKbt/3WqJxF+GeDFn4
 P116NzrswJFlBpVaLOH9XoHY2EPdkel2la5VG37KPECes9tYX3bD0z/nYINsXJ7thNvs
 oTZvo7TThrTyqcKRW4RTnZjeICHMMsJjdECUh9WQKlvZnHORgbAEwiHPK3PS69Usx8aH
 C9ThJqd95ZFqxJNYeR7REtocCjwC3T5YJ2IEfC79LPYU6T/AcYecwCRmBT6buMYbiJ6X
 VYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782316218; x=1782921018;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2H2ri/oSMaHNxjWTJsX+4cgbNnxXsBrVDobbD4DnQA=;
 b=bWT1QlHdZSHJ9nxVVLenABOgVqRAiPLiy3X30MU3sD0yoDoanAjUAjoAn/8DKAEeHP
 JST79NhFckaxxUKvAqhYxEtflZ55y70gvqiBWxT94yzx/EPECygwPz//qSFiHGFgOzAr
 zDn2d2yjh0R3wTEmch3Wab5r90alj+KxZqU7aNW6Bld7y/8mz6zMIBxvpUPbYGlHGrw0
 pFeaV/TZzg76xdwsxDJx5a9rALu+cdU+RR3IqAD59w8x0BR03vjei014jYPV4vBivJQ8
 KBU3qRVIJGDnbjUUbaW49mr6aciAKNEQhgsRwbAtwIT2ADyuwLpIiX9H2rf59AV0ldjq
 WS9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UbAxNIFegmSJujC9BDJYUp8PVbbT5ncb3XMWE++WmhmZJ3dG9VW5FOTdlxJ/aKuEQ3sYWICfZRqUa@nongnu.org
X-Gm-Message-State: AOJu0YybKg2ufZOXYu4u82kIq2Ph8JSvT/HGluGq+S2N1xlyqIfoUu1B
 O4445uNMIZw3/FePBxdeMAPtBP9JuIMTkGkY+DIZBjkyQCGDwgER7OCOQnxP11hH2RY=
X-Gm-Gg: AfdE7clxpZNk2IfaWh/b6zPKJ7dAr1kUCEuHzzjc5KssXhOmbRr2bTlwtOnt/MYr5WW
 nlaslbHq5yg4gYj4H/qZYUOM0pwWruWooea4E1+VOtNq4Z0dTGyrOkEx0U0F0sw94sQPJERgnMj
 bxkhTQAkdKjr2tTmrvjbT5Th01BPQOrXiRpCDgvBdWd19twH18Bnt/7m9SiVjrIu4cJ3/+SGTha
 rBmEK1LrsI7SC82TSgXmMhS8zr3TkUtYYSyUZYBJjDAIkzmyAk64169l8mKxaZWm5GZp0y0xssD
 8UGgLyZfmuqoHz4zXLWp4PRAoL8q84lS5tIhatXmZ2mMZiFLHylr0x0AkxKkNStbxCBncx6ysKf
 Azc5OsIl9Aj4OZ9AG+6gNb/b/eMIX3LZG+25Eo2GNsht7F+MUCqXoL3J1by87457+9F8at1hhj8
 n/Vtt0oPItPPgi
X-Received: by 2002:a05:600c:4f82:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-492632b6eccmr14212025e9.16.1782316218457; 
 Wed, 24 Jun 2026 08:50:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49264023b18sm1547555e9.4.2026.06.24.08.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:50:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB2905F807;
 Wed, 24 Jun 2026 16:50:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Peter Maydell <peter.maydell@linaro.org>,  Gustavo
 Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 06/27] tests/tcg/meson.build: introduce test_name
In-Reply-To: <tgemmc.ymcxyhiodn9w@linaro.org> (Manos Pitsidianakis's message
 of "Wed, 10 Jun 2026 10:08:21 +0300")
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-7-pierrick.bouvier@oss.qualcomm.com>
 <tgemmc.ymcxyhiodn9w@linaro.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 16:50:16 +0100
Message-ID: <87jyroj5tz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Wed, 10 Jun 2026 00:47, Pierrick Bouvier <pierrick.bouvier@oss.qualcom=
m.com> wrote:
>>We add possibility to duplicate a test for a given src. This allows to
>>declare several tests that still share the same executable, thus saving
>>space and compile time.
>>
>>A side note to mention that meson perfectly supports declaring several
>>tests with the same name. However, we prevent that to force dev to
>>clarify what is the intent of each individual test.
>>
>>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>---
>> tests/tcg/meson.build | 14 ++++++++++----
>> 1 file changed, 10 insertions(+), 4 deletions(-)
>>
>>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>>index 2c6d85c586a..bb0184732fd 100644
>>--- a/tests/tcg/meson.build
>>+++ b/tests/tcg/meson.build
>>@@ -12,6 +12,7 @@ tcg_tests =3D {}
>> #       {
>> #         'src_file': {
>> #           'exe_name': ['provide an alternative binary name'],
>>+#           'test_name': ['provide an alternative test name'],
>> #         }
>> #       },
>> #       ...
>>@@ -21,8 +22,8 @@ tcg_tests =3D {}
>> #
>> # Every test executable, identified by 'exe_name' is built only once.
>> # Tests for a given src use the same executable by default, and their de=
finition
>>-# is guaranteed to be unique also.
>>-# Default name is derived from src if 'exe_name' is omitted.
>>+# is guaranteed to be unique also. They can be duplicated by setting 'te=
st_name'.
>
> While it's clear in the patch description, it might be a good idea to
> explain that "duplication" means using the same executable here, for
> clarity, if you respin this series.

additional versions of the test can be added by setting 'test_name'?

>
>>+# Default name is derived from src if 'exe_name' and 'test_name' are omi=
tted.
>> # plugins come first, as we need to build the list
>> subdir('plugins')
>>@@ -51,7 +52,7 @@ foreach target, plan: tcg_tests
>>       # return a clear error if user mispell a setup entry
>>       foreach key, _ : setup
>>         if key not in [
>>-                       'exe_name',
>>+                       'exe_name', 'test_name',
>>                        ]
>>           error('unknown tcg setup entry \'' + key + '\' for test ' + sr=
c)
>
>
> Unrelated to this patch, but you could refactor the ['exe_name',
> 'test_name'] etc key set outside and print the list of valid keys in
> the error message as well for UX.
>
>>         endif
>>@@ -66,8 +67,13 @@ foreach target, plan: tcg_tests
>>         exe_name =3D setup['exe_name']
>>       endif
>> -      exe_name =3D target + '-' + exe_name
>>       test_name =3D exe_name
>>+      if 'test_name' in setup
>>+        test_name =3D setup['test_name']
>>+      endif
>>+
>>+      exe_name =3D target + '-' + exe_name
>>+      test_name =3D target + '-' + test_name
>>       if test_name in added_tests
>>         error('test ' + test_name + ' was already added: ' +
>> -- 2.43.0
>>
>
>
> LGTM (feel free to ignore the comments)
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

