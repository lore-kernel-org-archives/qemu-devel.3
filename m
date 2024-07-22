Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAEEC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW29s-0005mr-NK; Mon, 22 Jul 2024 19:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sW29q-0005lT-Gu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:09:30 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sW29o-0003M0-1x
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:09:30 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso8391666b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721689766; x=1722294566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1uCBwmAE32BBiIryDoORuW/rqabmNMWVyXJAFDKWKOo=;
 b=bYsbm0bLOJXKwClAL2rHQiDZwXuFQ1BK2Tn3X9EOdFar9Txv1FR/Xp41amcQaCgI3w
 LPzRUGTeJc95+wMskwjqkI9vb2lSQJmSa6jj9vslAF7C8BzM7M4I2bwgmDjUKyE1VPz9
 SxJdnbYT/lEOJIX88Ah+t6a18vNn6VP80m/zsynDYGbmDpiI6GzN2h+7bBPshwow78+3
 njUoSlxadYJYeU+Ok6lRMbXkRP1mVWBTzZRyt9ONtgJ0foVgSFrgvSWsUW9os4pKdDc9
 45sgQqKTqabaVU6BB+ns/cGW58dwrqazyr6l8ZLN67VTbHy1Ow0P67apt12qU75iVXfV
 QP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721689766; x=1722294566;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uCBwmAE32BBiIryDoORuW/rqabmNMWVyXJAFDKWKOo=;
 b=HuGb3dTuO2B0sw01G3YszM+NuUPExAGkbkEqn73/9drBxO91k8OINeFFq1/V4jqS4y
 7yJfgOAUPg9l8UGh4YZe2OJnpaUcSCe2/uy67JzbE9m3FEIg93ankFot79+h8zHU0kld
 V+x5gjg3MPQmyW04Gom1EkyWmXXy/LATtrC+f1rbnLkpwxJ4YqMDFzDoC2Tj7xCIRMcC
 EXHjkUhfiTduiwnVci7y6b7/OWJPwXgAsIx1ndpPiCFfYXPOkboBvtNWEupQJAH4NBJi
 89HMaWDOSXhff6Q4vQrhnkjEuYD5x4NdB7mKE+IL+HULFiyRz/UyDNQrLSf38VrBlZ0m
 d5oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU13FMj03GhvPOIY8dymydVFPks8EfYbf8wgIhwkEQ7HEsGJr6nBzumr6QEAsT0H1QpQzMh4agAOFM3eh/6H0Yfx/oFcRg=
X-Gm-Message-State: AOJu0Yx8lYMFDpphzVAdUnfj2q1Q4N99SDhzBaXWBTeWKm35wPKzO46O
 N0DZtky+llz9B5spwLeTGmXjjDZFK3tPmzvm/w0UWSC+DY55ry1AqtN0crERAZM=
X-Google-Smtp-Source: AGHT+IH1KuwmJ4VfDMuLPuFxLqotwfT+uRrREhPsIYDP+BT0Qk7bLa+6qY62oZXnepSBkV/Y8NaBng==
X-Received: by 2002:a17:907:3f2a:b0:a7a:3998:dc76 with SMTP id
 a640c23a62f3a-a7a4c22646cmr570775866b.52.1721689766006; 
 Mon, 22 Jul 2024 16:09:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c8be6fesm468592666b.100.2024.07.22.16.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 16:09:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D6BBB5F8B0;
 Tue, 23 Jul 2024 00:09:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  Warner Losh
 <imp@bsdimp.com>,  qemu-devel@nongnu.org,  Kyle Evans
 <kevans@freebsd.org>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 13/14] bsd-user: Make compile for non-linux user-mode stuff
In-Reply-To: <97219e8c-e210-4108-9873-abe2a933a3f1@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 23 Jul 2024 00:01:13
 +0200")
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-14-imp@bsdimp.com>
 <97219e8c-e210-4108-9873-abe2a933a3f1@linaro.org>
Date: Tue, 23 Jul 2024 00:09:23 +0100
Message-ID: <87jzhdxbvg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Warner,
>
> On 22/7/24 23:43, Warner Losh wrote:
>> We include the files that define PR_MTE_TCF_SHIFT only on Linux, but use
>> them unconditionally. Restrict its use to Linux-only.
>
> We should check that in meson, i.e.:
>
> config_host_data.set('CONFIG_PRCTL_PR_MTE_TCF_SHIFT',
>                      cc.has_header_symbol('sys/prctl.h',
>                      'PR_MTE_TCF_SHIFT'))

Surely this fails for non-aarch64 hosts?

> (like we do for CONFIG_PRCTL_PR_SET_TIMERSLACK), then rework
> linux-user/aarch64/mte_user_helper.h (and possibly
> tests/tcg/aarch64/mte.h), moving in a common directory.
>
> That said, your patch matches this file header:
>
>   #if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
>   #include <sys/prctl.h>
>   #include "mte_user_helper.h"
>   #endif
>
> Even if this #ifdef'ry is ugly, it isn't wrong, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> =C2=AF\_(=E3=83=84)_/=C2=AF
>
>> Signed-off-by: Warner Losh <imp@bsdimp.com>
>> ---
>>   target/arm/gdbstub64.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
>> index 2e2bc2700b8..6dc81aecb2a 100644
>> --- a/target/arm/gdbstub64.c
>> +++ b/target/arm/gdbstub64.c
>> @@ -404,6 +404,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteA=
rray *buf, int reg)
>>     int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int
>> reg)
>>   {
>> +#if defined(CONFIG_LINUX)
>>       ARMCPU *cpu =3D ARM_CPU(cs);
>>       CPUARMState *env =3D &cpu->env;
>>   @@ -425,6 +426,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs,
>> uint8_t *buf, int reg)
>>       arm_set_mte_tcf0(env, tcf);
>>         return 1;
>> +#else
>> +    return 0;
>> +#endif
>>   }
>>     static void handle_q_memtag(GArray *params, void *user_ctx)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

