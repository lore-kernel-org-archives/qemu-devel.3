Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A270BE69EAF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUrA-0002kR-0z; Tue, 03 Dec 2024 10:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIUr7-0002d6-RN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:30:29 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIUr5-000053-Uu
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:30:29 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0be79e7e7so5176925a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733239826; x=1733844626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWteDjj9QqTDYXFz6/A9/2hEs29v2M4SP6xbIk1eVv4=;
 b=Di003KAhmvQwLLktRwn4MWwBjsLaqlm3W66jYL5Lu8pxkgvVNjAQkc4K91zKhvu+ly
 q741OH2nwBly5GhHOvv2uIOCvegXt42X4yRrnE7CtJmfCFpfJtBHvCXXeTPJA4BkPLrC
 rUnW1D++ervuzmw6Hqjy0jfO/vI0xBM0SzFFJ2Vwi5JwPbZOUGmhvhIHps6gEFbfqetW
 IBp5B47PshI1MbG7sR6lFUhrwCINDG4JuavCafxp85F2OLTVK3W8nqcsToBiLSKT6pgr
 2IzTA833M0Yu2Est1VeGrDurRKBY6UUHUJYQNTp6r5FTJimLTKTDgHxUXmQyn0hneX5I
 OZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733239826; x=1733844626;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CWteDjj9QqTDYXFz6/A9/2hEs29v2M4SP6xbIk1eVv4=;
 b=MxKx1ixFW1KpaPOVMwuzxU3ifvUKlSzJEeZNEkjfj38iiEJ6OkU7EdKG/c1HqXgfUR
 qWjsQI2s9EybKQMyTUALJqzooayhoeSgCr9Web/0jGYZAty+URyfbq0t16gNghO13GjW
 +JxBQYAJjukaxm43xQ1XGDR2Hq7TMQEdskCMNjo6Qu7ROJQz57cG2vWlgVfaPMbBlPkX
 bLnvvfPrlijuBG6b3pPFNINg0v7ArCBkVHYnHj9xiedVcjYmlrO1uz8J+MEr6v/+ZJVy
 lRboBFDaXyrXlSapIJpB44dKNuYjBHDt7eVEiFWWWpLuGvm4Y/QYhfxxNrhKuWWgOD6z
 GcFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi4zRmH2Rp5L8eHGryJcvVtbFo+DJX/d2VWwNLo5HpQvkVRAe2NJXZVY3ZrPhXB7koo1itgipqvPZ8@nongnu.org
X-Gm-Message-State: AOJu0YxPU40+YiLL6+P8o1YPOGJiss1bhIYQfP88fxcbOgBvouWTFy+n
 HFdqdLm4/iQsAnWVZsshOc/VoCJVefRn3VAvI3Pty02zF8ujO06VJOE1mXkkt7s=
X-Gm-Gg: ASbGnctvcYiVzn8fRd92BPEVZ+McxnsOXOAO0KXbTEcwxuL0q5gE7/7UIsO3lvl/MXF
 SYCUmdPPPzPMBTOhC42LqqVqCOyxhrPen6Ds1QBO6xp1ZZ24Ph/WguHoLFuwrj9xuND2Qbo7gcM
 7hkvdk4OG3pgqClR2khhoXncn0ElPzRCR3geFBfqKkR1NVyP5+TPO61TjUYkUGBLjLFZXbJ5vEH
 5enDmNxZcl5i8GLS+FNxg5SoG5D6JIBCL1u73WIYF0Vuh0i
X-Google-Smtp-Source: AGHT+IG7w0iQqGnEN6AM/0cgCbjcPMlXILQG/3bbAmEpIbH0B/qJBCfrs/TXLpzER3fCSD9lBZjIcg==
X-Received: by 2002:a05:6402:2743:b0:5d0:efaf:fb73 with SMTP id
 4fb4d7f45d1cf-5d10cb5b970mr2399214a12.15.1733239826203; 
 Tue, 03 Dec 2024 07:30:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d097db0a6esm6204395a12.27.2024.12.03.07.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 07:30:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26A745F89C;
 Tue,  3 Dec 2024 15:30:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  qemu-devel@nongnu.org,  =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Troy Lee <leetroy@gmail.com>,  Alistair Francis
 <alistair@alistair23.me>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  qemu-arm@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,  Joel Stanley
 <joel@jms.id.au>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
In-Reply-To: <f043b94a-278f-4009-87b9-9b2ba4b80c42@linaro.org> (Gustavo
 Romero's message of "Tue, 3 Dec 2024 11:55:59 -0300")
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <21d8399a-91bf-4599-a73d-351f9f0c147c@linaro.org>
 <CAFEAcA-4_tnm9iPCf_3E4HKKXJ9h6w9oMiYaN0Y4s9wmpji3Jg@mail.gmail.com>
 <6cd6b3fd-8362-4fa8-b6e5-e0e3aded3215@linaro.org>
 <f043b94a-278f-4009-87b9-9b2ba4b80c42@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 03 Dec 2024 15:30:23 +0000
Message-ID: <87h67kdbsg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Hi Pierrick,
>
> On 12/2/24 14:33, Pierrick Bouvier wrote:
>> On 12/2/24 03:04, Peter Maydell wrote:
>>> On Mon, 2 Dec 2024 at 10:58, Marcin Juszkiewicz
>>> <marcin.juszkiewicz@linaro.org> wrote:
>>>>
>>>> W dniu 1.12.2024 o 19:09, Pierrick Bouvier pisze:
>>>>> Hi Marcin,
>>>>>
>>>>> On 12/1/24 05:34, Marcin Juszkiewicz wrote:
>>>>
>>>>>> So RME tests probably need longer timeouts or would not run at all.
>>>>>>
>>>>>
>>>>> By any chance, are you running those tests in debug mode?
>>>>
>>>> zOMG, thanks! Turned out that I left "--enable-debug" in my local build
>>>> and forgot to remove it.
>>>>
>>>> 90s vs 2974s is a difference ;D
>>>
>>> That is a particularly awful debug-to-non-debug performance
>>> difference; it might be worth looking into what exactly
>>> is causing it.
>>>
>> Indeed.
>> This test boots a nested VM (using kvm, not tcg), do you any idea
>> why such use case could be so slow with QEMU?
>
> It's not "really" using kvm acceleration right?
>
> It's using kvm but the kvm module in the host kernel is actually running
> fully emulated in QEMU system mode (-accel tcg is being passed to it).
>
> So I understand it's "all TCG" in the end and no HW acceleration is
> ever used in the tests.

Right, but from the internal QEMU's point of view its just real hardware
so we don't have nested translation. All the overhead of that is in the
"host" QEMU.

In theory we could also use kvmtool to launch a realm but I doubt in
this case the internal QEMU is actually taking up that much of the
runtime.

>
>
> Cheers,
> Gustavo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

