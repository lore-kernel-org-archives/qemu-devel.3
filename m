Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBE1C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpih9-0003sS-OL; Wed, 05 Mar 2025 01:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpih7-0003px-Cs
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:57:29 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpih5-0006H2-M4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:57:29 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso12022983a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 22:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741157845; x=1741762645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xG/+rnnGjuO4E25qQMY9Z7bUYYakfC8Y9C5Ls7pO+s=;
 b=VmMWvyCktl7dJWvSuKQGgYd8eRKc4JLzQ1ULmYgfFhRk8cTQbiBrxvBvgnTzqDSgh7
 3GfGElrnx87FeM83t6VFUUiYq3ESzRLfmAFm7jeQA/bZFYmxuKAywmSRRZzAYQ0wOu4K
 N8fQBVux7g/29FkBz5UBQIlSwEmwlYC+AEdzt+j9dZ/5YHq40qESc3CaMlbw9HU2cQKF
 Fm4QD3GeXFrdodrJmWdVNQThc1d714vFkd+78nHjtHpfPH6gBIOzaG4H1plv9H2GEqdy
 8wwiPE5W9rCxx49xBtkZrakLHxJCCP4gnAY4p2sG2F7gQOMfrUalUm0FvjVOHGxf3tn/
 JQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741157845; x=1741762645;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/xG/+rnnGjuO4E25qQMY9Z7bUYYakfC8Y9C5Ls7pO+s=;
 b=a+i1jX+jceQbM/De/0GXRPktDJerHBdWaBrZO4VA37H7VAfIOC6ZWt6AKaharqhs1x
 Xrjf/mgDa00Lv3qFJXLml1tOH50nB5wRVJHTgHiNbk/sqM1pWWeBw+QGkPOol8UWsCxG
 RFjSfs3iqKu1YeMbqHg6M3y76XWu3+M69yoDo8QKvXr2653onLUcfcCYeazYfieNdoBB
 kFCHgGWuwQvTfKtcc+aT29ScVrOYBOFxSJpP6AREBjda3jxNk7nU5E2eXxLeEgrlxtmr
 +XvEUHWtyyCv1KUQUYtCbYBnPL4ub5IfuKOA6iW83iPFGwaFoh5kAzuTGWUc3OT9cmBo
 Dx+g==
X-Gm-Message-State: AOJu0YyljFF6+XYlkNAFXm2aOpDhE1TcAUOqfQbaCMNT7xKdLx9TChZ6
 UULT4VVx0/HJLH/VFyZKYQbs/87lMMUdPUcmUskimIN1GezlOFbefj8kIXCbM58=
X-Gm-Gg: ASbGnct78MDCcsN3kIqyMgWlmUOq6qUs41XKsvs3slAIxHkvOfxQpBjInlPuoJcyxXI
 +HIgF6425iZMdPj9DGpM99JdZKU5t9icYaZ5rbSY/cxyvyQo/aASToXDCQNTmlbTJerpQ/qXHM3
 iO2q6bIbKgxxkKYT4vxilUgiw0idczzInTNWTepOnRLHWLFMvU/vg5MbSdFUwYXOvDNsFKYfDv2
 0vGT14LMbcuJqv5tjUYipcxu58o6nSVsQxBrwXeiCuyoJFW9MlohpTBM4j2SZsl7sEGNDbbejF/
 H4+m1qP8PR3Fo9GV6edYmq35aPDeas2mf9R0w9z1TCuiKrg=
X-Google-Smtp-Source: AGHT+IG1igyyXdRoM5dt+EurMRT3F0KivqOcqAVAkNVVm3hzPIAkb+gf6r4bbpYu1G496VNabaGsxA==
X-Received: by 2002:a17:906:7308:b0:abf:489b:5c77 with SMTP id
 a640c23a62f3a-ac20db67a33mr198673966b.31.1741157844763; 
 Tue, 04 Mar 2025 22:57:24 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf75c6d4f3sm499091766b.184.2025.03.04.22.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 22:57:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F1E65F932;
 Wed,  5 Mar 2025 06:57:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Li-Wen
 Hsu <lwhsu@freebsd.org>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,  qemu-arm@nongnu.org,  Alexandre
 Iooss <erdnaxe@crans.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Riku Voipio
 <riku.voipio@iki.fi>,  Warner Losh <imp@bsdimp.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kyle Evans <kevans@freebsd.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Ed Maste <emaste@freebsd.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 21/32] plugins/loader: populate target_name with
 target_name()
In-Reply-To: <44f7f6d6-2c13-49a0-8775-40a9a12ba86b@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 5 Mar 2025 01:01:50
 +0100")
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-22-alex.bennee@linaro.org>
 <44f7f6d6-2c13-49a0-8775-40a9a12ba86b@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 05 Mar 2025 06:57:21 +0000
Message-ID: <87pliw3qy6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On 4/3/25 23:24, Alex Benn=C3=A9e wrote:
>> We have a function we can call for this, lets not rely on macros that
>> stop us building once.
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20250226140343.3907080-17-alex.bennee@linaro.org>
>> ---
>>   plugins/loader.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/plugins/loader.c b/plugins/loader.c
>> index 99686b5466..827473c8b6 100644
>> --- a/plugins/loader.c
>> +++ b/plugins/loader.c
>> @@ -297,7 +297,7 @@ int qemu_plugin_load_list(QemuPluginList *head, Erro=
r **errp)
>>       struct qemu_plugin_desc *desc, *next;
>>       g_autofree qemu_info_t *info =3D g_new0(qemu_info_t, 1);
>>   -    info->target_name =3D TARGET_NAME;
>> +    info->target_name =3D target_name();
>
> Unfortunately the declaration is in "hw/core/cpu.h".

I thought that was common. It didn't break anything.

>
>>       info->version.min =3D QEMU_PLUGIN_MIN_VERSION;
>>       info->version.cur =3D QEMU_PLUGIN_VERSION;
>>   #ifndef CONFIG_USER_ONLY

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

