Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8005CCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQV8d-0004X4-Tp; Fri, 22 May 2026 15:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQV8c-0004WY-BC
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:02:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQV8Z-00043H-Kt
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:02:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso40491965e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779476541; x=1780081341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zmfuMLM/jv+2sAZAYdT/4UiMpv4lo9buBeRT97Ft5Q=;
 b=BbXqukMP7ji+ZOs4jZ2yKYYaR1Cwa05ad0ShBHoSlvtNe2kN6TwwMup7i/EXMX5+t7
 dVXOp5c62ACZU2QlbwmZdmAyrUmp44EuEQSc5eqxq23NFdedUt+KzQMhu/udFxjpvwiB
 mx/tsRdTdWCj3P/xuLTUJXeduQuf5LjxSwfu3OmhGo+GedtuBbTowXeYtYhIaOwWj4pZ
 3z4RsjG0BAShoT9CkxeWbcXrL4DAXwvR83ldjvx/jyztY73jZ+fldPHKLzaR4m3LJeQu
 VlL+fUtxUeWRGbqn2L+KmDjmJAKfR+AcnsnOYmn9PJ2Vquf0SMSr2cNkUOCjr3UCrD//
 MPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779476541; x=1780081341;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1zmfuMLM/jv+2sAZAYdT/4UiMpv4lo9buBeRT97Ft5Q=;
 b=CfTnAisLngQC7dPinLNWqD9onsu3+YeIEE2hy+hYArl3ZALUWuDEszH87k0YCfWtef
 De/2JRlr1ITS01DbiUIl8NikcKUhe2Lg6Q9O2Kc5qsXzaXv3Zu5Jo3gf9kVSzkGxM2bo
 aXFApm+ly1RZQR+ZZGSLKIY01Od4a0XB69jYCJ1mCO32JRhnQ0WcbRU8pNl2hMNAe/G5
 Kj9pisYB4cNhYuq4HRIK4+2kyEtCuRuDgLlQDpR7IX9iElJFa/HD1Ky4P4f40hYqwW6y
 c6nTruEiIKs9j+uPJ7EfJYJBNCctFGgDDW5TJj0QAYqE39tGtF0siQqN2MMU49+/T71a
 GRfA==
X-Gm-Message-State: AOJu0YwNELySXObvMf5RKyAm/+JrLNVA7pJhGJTqwfZSSJMhofriqTL7
 UAnYVU0Kmeea/njm1dkMhesAjtaN4j5uT3LaSvy7cIQf/4VxlboxZAoomPSiPxjdL4Y=
X-Gm-Gg: Acq92OFiMgzB4OPHHvYDmBG6MFhzYUS7jEsBBLwIz9gW7Dr/nO848yasIsLnaTgb8bu
 rPzjEyU8O4rAD/1gM5pW1IzyfBjehdxI5fM6U3zAEmRKiAMNZ8Ji/UrW8Y2ihHQgVNUM87yw1BQ
 XHCRQMEIC/mtTmSLaRKou4yRfnYSJms7lPHuIueFcL5qeMsCCYrOol+VVwUT52CyePnMgeVz2sB
 zjX7tI4ii7XRi6QBwML8w7J1kK6hTlWcEzzN2xr+p6FFGMgVwHflH1Q7uqmv1Wbgv0uKiGYRXMa
 W4QfNZs7TBehN0RrRTNUuZMdc3769BG3G9K/fDgEraX43NlJX8G5xPdPp8+1+hqsfiBsZAtL+lA
 ivuuUHB0un/l5rTtbQv5DB3Y8ObnWgdj5yF4tHwgzt5mcXnoJgACIkYqz6n+0A5Ek0DV7LHf/xh
 nrACa9gwY8Viyb7CUs5K4Sr40=
X-Received: by 2002:a05:600c:c4a3:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-490426ceed2mr72356495e9.21.1779476540911; 
 Fri, 22 May 2026 12:02:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49044f2bad3sm66644315e9.0.2026.05.22.12.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:02:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 490495F8BA;
 Fri, 22 May 2026 20:02:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,
 Song Gao <gaosong@loongson.cn>,  John Snow <jsnow@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Brad Smith
 <brad@comstyle.com>,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Max Filippov <jcmvbkbc@gmail.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 03/16] tests/Makefile.include: add binary dependency
 to run-tcg-tests-% rules
In-Reply-To: <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Fri, 22 May 2026 11:03:46 -0700")
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-4-alex.bennee@linaro.org>
 <74e8bc86-cd81-43f9-b5cb-7e3de3bcd3d0@oss.qualcomm.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 22 May 2026 20:02:19 +0100
Message-ID: <87tsrzl138.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 5/21/2026 6:17 AM, Alex Benn=C3=A9e wrote:
>> Explicitly set the appropriate QEMU binary as a dependency so we can
>> ensure they get built. This is especially important for MacOS which
>> otherwise only builds the unsigned binaries on a normal "make all"
>> run.
>>
>
> I'm not sure to see why it matters. tcg-tests don't make use of hvf, so
> unsigned binaries are plenty for it.
>
> Which other binary is this building that is not built by default?
>
> In general, if something is not included in "all" target, let's make
> sure it's included there (meson.build?) instead of adding a workaround
> here. Not only tests benefit this, but anyone doing a build on a
> platform that might have optional binaries not built by default.

If you have a suggestion on how to make that work I'm all ears.

>
> It's totally ok to build all binaries (even for other targets than one
> tested), people have configure --target-list to restrict what is
> globally built. Better to catch something broken elsewhere instead of
> "oh sorry, my custom test command didn't build this at the time".
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/Makefile.include | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index ce6a0dccaf4..cf6f9e68245 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -57,6 +57,12 @@ RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests-%, =
$(TCG_TESTS_TARGETS))
>>  $(foreach TARGET,$(TCG_TESTS_TARGETS), \
>>          $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host=
.mak))
>>=20=20
>> +# $1 =3D the stem (e.g., arm-softmmu or x86_64-linux-user)
>> +get-qemu-bin =3D $(if $(findstring softmmu,$1),qemu-system-$(subst -sof=
tmmu,,$1),qemu-$(subst -linux-user,,$1))
>> +
>> +$(foreach TARGET,$(TCG_TESTS_TARGETS), \
>> +        $(eval .ninja-goals.run-tcg-tests-$(TARGET) +=3D $(call get-qem=
u-bin,$(TARGET))))
>> +
>>  .PHONY: $(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%)
>>  $(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%): build-tcg-tests-%: $(BUILD_=
DIR)/tests/tcg/config-%.mak
>>  	$(call quiet-command, \
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

