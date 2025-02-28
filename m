Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65414C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxmX-0006BT-3r; Fri, 28 Feb 2025 05:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnxmU-000695-7a
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:39:47 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnxmR-0004Vc-Or
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:39:45 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390ddf037ffso941073f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740739181; x=1741343981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+f3JGsV+c3RYwo3hOIGszkkx7abKXzDqOZbBvQjAkc=;
 b=cSjw524To0AkVBmGGtuvPVGO4ynvTz7eZmft2LUiWtC41/qKkdOf7GmHnREX70w0TE
 iZQvqnkkghaVa2v4r0O9jVaE2RNyBJDDveBrRwR7nYhY+RE4TS6EK0UgTV9IliN0UyuG
 mM+TFlpXYCHy67rpnU+Va2+LeN3RN4mN9uQe7IcmlyNRaUunfZPq17aMcTgWzH8JsEfF
 Da/VT+KU+B7VABwp1kYb0G9y7ia+HvCN9dZhFG0ofUE1AYxV3KbjDKLsaDEbUuZBFwqO
 Tbm8vMS3Pxo8XTrCLLnwqsenUzykyFR0y9TpnZbs19xflSk9hH3ab+h+4+AS2HIBRkeq
 fGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740739181; x=1741343981;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u+f3JGsV+c3RYwo3hOIGszkkx7abKXzDqOZbBvQjAkc=;
 b=CZ9FmOa2wLTm/gXcJEDNChqAcUfcNo3DpVlF5lPu9cJhp2CnK6T9kxULUZv2xqf5qd
 5hiy3R+kLXlY7biqnsP1QQwQLjrQelzu9It3QMMVocacN1x5iMm+Kfk9yqv40BD1lO6v
 zaF9uruYmLJiImPIkXpNuCUGa/A2vX+Z2oC1dSKDiEDyM6qkC/4+plpuVZy+pPs8AMSc
 kawVN3tQ+diWcWsiPVi2bRYtWDjYFwY7XR/IOEkCXTJ1aGJb8YUbI26OGyRmg/XVDPbg
 Nk2SJ/GaC9ONPGJtlTXdkpSHBp97QZGIvSV3Lp2ybhNyW3HRIymxWkOKdeQAkSerupZO
 SiPQ==
X-Gm-Message-State: AOJu0YyQerOSG3iZf+W77FPAtG530rEEhi446RDjmwUrx6aUPuEs9nMl
 IgOBMibCEwRGpGjP0SeP7KIJ4yCyCto2RfULx4eAxFxdZJviQWjBcvCOaO9usaE=
X-Gm-Gg: ASbGnctFMhrxGj7Kp/VqZDWtRfdBKcYmK9Coq3TS8ohd6ICVQAaFXKIxylYPjfKalg/
 V/zL/2YXSY1XrFdhv0L7+m7yojxuj5lrn2FkHNjcWZLN+Re+T/qwV9N9P9CTUIbkuOaQDffz4nH
 hPVhv/5FXdDi/b35yOP5xmksstc2+9f7lW95kFTdoqVjyBOcNQqfnbuE+vLmdWuT7qurNXPtWTy
 mgkmrE/KOxYpJ9D9f+AcQ87E1GVcXsqZLKOKH2xsiwuQUwQOG2H7ft75j2vERvPBmW78ZUg9ygr
 0363ZNMCx74tjsaEHthka2OWUcng
X-Google-Smtp-Source: AGHT+IH/CCTIYKrz2n/bq8OF2DXJjZq3UkeB9HZHk0HigC7tvMKdWGMfJ59bA6/bIRNI0fio5XbJnw==
X-Received: by 2002:a05:6000:2c6:b0:38f:3888:339a with SMTP id
 ffacd0b85a97d-390ec7cc689mr2650091f8f.21.1740739181612; 
 Fri, 28 Feb 2025 02:39:41 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844c0dsm4694225f8f.80.2025.02.28.02.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:39:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D1A45F7DE;
 Fri, 28 Feb 2025 10:39:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Kyle
 Evans <kevans@freebsd.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Li-Wen Hsu <lwhsu@freebsd.org>,  Riku Voipio
 <riku.voipio@iki.fi>,  Warner Losh <imp@bsdimp.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>,  Thomas Huth <thuth@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 25/25] MAINTAINERS: remove widely sanctioned entities
In-Reply-To: <a069dbfb-c0bf-417d-9925-e419c071eb4c@ventanamicro.com> (Daniel
 Henrique Barboza's message of "Thu, 27 Feb 2025 12:45:27 -0300")
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-26-alex.bennee@linaro.org>
 <a069dbfb-c0bf-417d-9925-e419c071eb4c@ventanamicro.com>
User-Agent: mu4e 1.12.9; emacs 29.4
Date: Fri, 28 Feb 2025 10:39:40 +0000
Message-ID: <874j0ewdxv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> Hi,
>
> A bit offtopic: we just received patches from Syntacore [1]. Syntacore
> does not appear in the US sanction list website, but in a Google search
> I found out that Syntacore was acquired by Yadro in 2019, i.e. Yadro is
> its parent organization. And Yadro has been sanctioned.
>
> Does anybody know the rule in this case? If a parent company is sanctioned
> does that cascade to all its subsidiaries? I have no idea whether we can =
engage
> with these patches or not.

I don't think anyone here can offer any legal advice. We did reach out
to the SFC they never replied directly. They did however publish the
following blog post:

  https://sfconservancy.org/blog/2024/dec/12/linux-banned-russian-contribut=
ors-do-i-need-to/

but you should probably check with your own orgs lawyers about what you
should do. We have additional email domains blocked from our mail
servers to avoid accidental interaction but they don't interact with
MAINTAINERS which was the motivating factor for this patch (because of
processing PRs and automatic cc's from get_maintainers.pl).

>
>
> Thanks,
>
> Daniel
>
>
> [1] https://lore.kernel.org/qemu-riscv/20250227144200.69270-1-saveliy.mot=
ov@syntacore.com/
>
>
>
> On 2/26/25 11:03 AM, Alex Benn=C3=A9e wrote:
>> The following organisations appear on the US sanctions list:
>>    Yadro:
>> https://sanctionssearch.ofac.treas.gov/Details.aspx?id=3D41125
>>    ISPRAS: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=3D50890
>> As a result maintainers interacting with such entities would face
>> legal risk in a number of jurisdictions. To reduce the risk of
>> inadvertent non-compliance remove entries from these organisations
>> from the MAINTAINERS file.
>> Mark the pcf8574 system as orphaned until someone volunteers to step
>> up as a maintainer. Add myself as a second reviewer to record/replay
>> so I can help with what odd fixes I can.
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20250221161443.2321327-1-alex.bennee@linaro.org>
>> ---
>>   MAINTAINERS | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1911949526..9cdfe19115 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2529,8 +2529,7 @@ F: hw/i2c/i2c_mux_pca954x.c
>>   F: include/hw/i2c/i2c_mux_pca954x.h
>>     pcf8574
>> -M: Dmitrii Sharikhin <d.sharikhin@yadro.com>
>> -S: Maintained
>> +S: Orphaned
>>   F: hw/gpio/pcf8574.c
>>   F: include/gpio/pcf8574.h
>>   @@ -3627,10 +3626,10 @@ F: net/filter-mirror.c
>>   F: tests/qtest/test-filter*
>>     Record/replay
>> -M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>   R: Paolo Bonzini <pbonzini@redhat.com>
>> +R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>   W: https://wiki.qemu.org/Features/record-replay
>> -S: Supported
>> +S: Odd Fixes
>>   F: replay/*
>>   F: block/blkreplay.c
>>   F: net/filter-replay.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

