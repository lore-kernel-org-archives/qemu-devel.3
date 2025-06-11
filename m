Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023EDC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 14:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPMUH-0002wf-LA; Wed, 11 Jun 2025 10:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPMUD-0002vr-69
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:31:29 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPMU6-00079B-W1
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:31:28 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5fff52493e0so8546219a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749652280; x=1750257080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kjWny/ZarmYI0bPOqNr70retowIZ6UUZ4+CbE7mlbCI=;
 b=i3GXoYk0xtxlsZFFiMUjS1xWuIjX242tQhoi6sqIVAISx4un6quVWNsHlbtvj08y4U
 n3pkq6v0aC05N6x2AQiqW7fmJxeTnDap8I6VfWS26nwsm5MnvSsj4GSsoeqeHmwG0/7Y
 WqB6SPr/n6UFXj888NURhk7NoThpllU8hckSJWZ5Rl2trEUXHqKUsKUfG+jwPcXWRnM9
 BHN59X0ECj7pCbzclN7KwOTKSgAg7B0CLs+PBH/V9e811TJAnakdWC32Y40gtEvMW/vE
 FlUZyNAtwHV+U7Gk8go4UlfMl+y4K/0brUdQpymbPhlVuRgQPukmnviF5NnHlFIccaQf
 ZSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749652280; x=1750257080;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kjWny/ZarmYI0bPOqNr70retowIZ6UUZ4+CbE7mlbCI=;
 b=Z3qtDUzLQoeuuMlgFTb8hwXYSTxS6jXu1bXxzL6rNfcYiiqyn5Klw00TonKUIjH/mZ
 RMye+KllHnSF3F4HCwCdwDb4HojJD/ffP5Piq95tejs/hVJhzR39E/1o3H7Chqsgds1p
 wgttIIm0839+TN2iSA2ZvYrreft4BrZWCPPnr+eKh+mRatVVRWlQMPH5iAfY6GC2oCga
 o3rYHrmsU0cgEetrR586TLBk+kcfxBqe3Jz/0HH2HueVe/nB08KeXhyOo/J0agF3yDaS
 phPyfv9ZYRh7OvqPCUt5TQwvkOSJg1lPwHU/XNlzjAOyAfVeE/G+T2x3V4Em8TuHu222
 cHgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqFUrgbshTh/4iyHBeQKpFmE/xozN7SV4PuN12vGoa3s8f2E4Ea1XxgEXZcqzQQXmpS6fRL+qBnt4Y@nongnu.org
X-Gm-Message-State: AOJu0Ywpgt3XJA+9R8RUoX0sby/Eh4+uWhbpKz0oDFGc70Gb4+Ffc106
 WlQk5fP4JnuN2l18x3UieaYH7/YhVVsCXIXZTvDF263G+Nt9JFjRdDsxYiq3XEnfUos=
X-Gm-Gg: ASbGncvUUkdnEsj4uo3JAFOR5veu99WpUebLCM5kOWEzroJDjfyzWL2+w75iqKcTigV
 sf48xtAr/Ez0oMZqP3WocmuqeRvUxt8NS23WXF+9TsvldS0Gf6roHuLxBASJDWTOBjYCpUCrJa7
 uXhHgmjiKGv7iFgVhUjd881S98tMLkv4lPXYG/N3CzRZiav584nNZ4z/ktWgTeytezvRjgojWev
 L4q0FDHmJdMVHks/AC9T/iJn2+CvsWxD2gGGhgmxbBPxcTr6LZjMKj2dc5qgzc3nSiLeHxTLD43
 ktHUJA5++EuSgJTPjMt7Xg9iSJrYykdhLXgj9JSrBwVrSaKFS0Vz0Aw2NZmm0KA=
X-Google-Smtp-Source: AGHT+IHoQbReQvwjlgkq28nHihskK3nwk9VXgCePdXLlR0njJq7kW2+DHGqUcy8BST7nIHInCvCkPQ==
X-Received: by 2002:a05:6402:5204:b0:607:1c07:727d with SMTP id
 4fb4d7f45d1cf-60846cef927mr2657308a12.23.1749652278629; 
 Wed, 11 Jun 2025 07:31:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607783e654asm7508213a12.69.2025.06.11.07.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 07:31:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A65B5F7CB;
 Wed, 11 Jun 2025 15:31:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 01/19] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
In-Reply-To: <EC334225-4D4D-4CBD-849D-86103C3D8BD8@oracle.com> (Miguel Luis's
 message of "Wed, 11 Jun 2025 13:45:20 +0000")
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-2-philmd@linaro.org>
 <EC334225-4D4D-4CBD-849D-86103C3D8BD8@oracle.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 11 Jun 2025 15:31:12 +0100
Message-ID: <87zfeeic3z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Miguel Luis <miguel.luis@oracle.com> writes:

> Hi Philippe,
>
>> On 6 Jun 2025, at 16:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>=
 wrote:
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>> hw/arm/virt.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 9a6cd085a37..d55ce2c0f4e 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2205,7 +2205,7 @@ static void machvirt_init(MachineState *machine)
>>         exit(1);
>>     }
>>=20
>> -    if (vms->virt && (kvm_enabled() || hvf_enabled())) {
>> +    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
>
> Does this means TCG won=E2=80=99t run aarch64 NV?

No - it just means we can't start in EL2 with anything but TCG (or
qtest). Currently we don't have NV support for KVM in QEMU.


BTW Philippe isn't the same test needed above for secure (which can't be
supported even with KVM NV support).

>
> Miguel
>
>>         error_report("mach-virt: %s does not support providing "
>>                      "Virtualization extensions to the guest CPU",
>>                      current_accel_name());
>> --=20
>> 2.49.0
>>=20
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

