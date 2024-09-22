Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CD1CF9C69
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 06:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssGFq-0002mK-Ta; Sun, 22 Sep 2024 02:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ssGFq-0002lr-8f
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 02:39:34 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ssGFo-0002pt-I6
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 02:39:34 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a90188ae58eso405746566b.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 23:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726987170; x=1727591970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79n7kveZZIqqn/1F1fJDvqL+MsGmMNFcq5p+bLEl3Lg=;
 b=kHRxfHk56lyQJxrHZyIZmesqEB5ghLPQiO9XR6Lm1JUUl2uohI5lkPljDsxk5wnGbx
 t3si0wS/PMDs7wfvS/SNNuysKYCSo+Ey8GPl+VYgB1ymQMXd81VdmzSxDfu+zEeVhVSh
 1am1K5aSPD+gAD3T8TvpsVJTSKphfGGmmbxnzTROmKxoOShLHJWn9cSLg1UNRGePkowW
 WyEJDaXYTmnMsrKw4RDqDYiIbe9+ZZeGBGNxTZa3D+FHO6dQzTaQNUJNWp0NLHvgBSfc
 9cKT0fl06EYOZP8H63cwhnx07vpoIshIQpGBaiUboplm8Ic3hqzDy7tJvtDMGjd9qUPp
 faFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726987170; x=1727591970;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79n7kveZZIqqn/1F1fJDvqL+MsGmMNFcq5p+bLEl3Lg=;
 b=IyE9iBpSqkkS4f9rOAvd9ohQrcb3fT5qNAoHU1Npg0X88lYPPMzTBKn96RsWKQ+zsb
 PB8rTUwG2p1Yn65Ngl+8szRqXQBB++6TvpTgs4D8YmBoaKfzdTlokzYogZx8i/hmAgJ2
 cTAlQeFOErB1LUip+VRYXo2BTFzZK+LY23zqVeDe5Bw0InMpzz1IR4NaSVoSkAksZHjR
 YR9LvLSJhB6ZxQJv1hamL47oEKktOOhRh2SFdlb7LKUyv3VNrZ/GiT6FcANVbdKaWp06
 NgQJwiT2s8GXjUbVE6jDY8TTbhDicL5u7x3uK9TiHYvc++NH+ZNazDoirQwdSMXIQr1t
 d4/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW12Bo3mDCyd3vqK8TAKlclpRiPsgPxReiTGSPrH6wztfsYXBeL09X/tZIDN0vr+n+SXMnoiXuWEoJz@nongnu.org
X-Gm-Message-State: AOJu0Yw2hFtd2jc2uvKNXJefOQ+1hBYiuTeTkg4OpNE42hhO8JzTnGtN
 l+LvjEposj2rdQx8e1YnPdx08TNrbo5LxposVwlL+QMoyYiL/3wifRGDrRqGLlI=
X-Google-Smtp-Source: AGHT+IFAO45T0b6sTYjYva/y2xwNtHpXPzVnDYVn1TE9OHqJzF9jbJfKwHdx5Ex3LPmJk61xX0Jjzw==
X-Received: by 2002:a17:907:c89d:b0:a8b:154b:7640 with SMTP id
 a640c23a62f3a-a90d573ab00mr656888266b.37.1726987170011; 
 Sat, 21 Sep 2024 23:39:30 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061331bc8sm1043339466b.221.2024.09.21.23.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 23:39:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC8B85F892;
 Sun, 22 Sep 2024 07:39:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brad Smith <brad@comstyle.com>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] contrib/plugins: ensure build does not pick up a system
 copy of plugin header
In-Reply-To: <58b41976-15aa-401d-9935-2ea5bb911e78@comstyle.com> (Brad Smith's
 message of "Sat, 21 Sep 2024 18:48:34 -0400")
References: <Zu4063fjfHC5hHUl@humpty.home.comstyle.com>
 <87msk1dv45.fsf@draig.linaro.org>
 <58b41976-15aa-401d-9935-2ea5bb911e78@comstyle.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Sun, 22 Sep 2024 07:39:27 +0100
Message-ID: <87ikuodwf4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Brad Smith <brad@comstyle.com> writes:

> On 2024-09-21 8:55 a.m., Alex Benn=C3=A9e wrote:
>> Brad Smith <brad@comstyle.com> writes:
>>
>>> contrib/plugins: ensure build does not pick up a system copy of plugin
>>> header
>> I'm confused because this changes the ordering of the GLIB inclusion. We
>> shouldn't be including the whole QEMU include path.
>
> That's intentional. The GLIB header paths cannot come before the header p=
ath
> for the plugin header otherwise it pulls in the older plugin header from =
the
> installed copy of QEMU and breaks. The QEMU include path is necessary
> for the plugin header.
>
>
> cc=C2=A0 -O2 -g=C2=A0 -I/usr/local/include/glib-2.0
> -I/usr/local/lib/glib-2.0/include -I/usr/local/include -fPIC -Wall
> -I/home/brad/tmp/qemu/contrib/plugins/../../include/qemu -c -o
> execlog.o /home/brad/tmp/qemu/contrib/plugins/execlog.c
> /home/brad/tmp/qemu/contrib/plugins/execlog.c:262:41: error: too many
> arguments to function call, expected single argument 'insn', have 3
> arguments
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_p=
lugin_insn_data(insn, &insn_opcode, sizeof(insn_opcode));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~=
~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/local/include/qemu-plugin.h:407:13: note: 'qemu_plugin_insn_data'
> declared here
> const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> 1 error generated.

Ahh gotcha, I confused myself thinking this was QEMU's internal API header.

Queued to plugins/next, thanks.

>
>> How does this fail?
>>
>>> With the ordering of the header path if a copy of QEMU is installed it
>>> will pickup the system copy of the header before the build paths copy
>>> and the build will fail.
>>>
>>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>> ---
>>>   contrib/plugins/Makefile | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
>>> index 05a2a45c5c..52fc390376 100644
>>> --- a/contrib/plugins/Makefile
>>> +++ b/contrib/plugins/Makefile
>>> @@ -41,9 +41,10 @@ SONAMES :=3D $(addsuffix $(SO_SUFFIX),$(addprefix li=
b,$(NAMES)))
>>>     # The main QEMU uses Glib extensively so it is perfectly fine
>>> to use it
>>>   # in plugins (which many example do).
>>> -PLUGIN_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags glib-2.0)
>>> -PLUGIN_CFLAGS +=3D -fPIC -Wall
>>> +GLIB_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags glib-2.0)
>>>   PLUGIN_CFLAGS +=3D -I$(TOP_SRC_PATH)/include/qemu
>> Not withstanding the fact I've just borrowed bswap.h for a test plugin
>> maybe we should actually copy qemu-plugin.h to an entirely new location
>> during the build and then include from there to avoid any other
>> potential pollutions?
>
> I don't see how that would make any difference, but either way as long
> as the header
> path ordering is corrected so this new path is not passed last on the
> command line
> getting the ordering wrong.
>
>>
>>> +PLUGIN_CFLAGS +=3D $(GLIB_CFLAGS)
>>> +PLUGIN_CFLAGS +=3D -fPIC -Wall
>>>     # Helper that honours V=3D1 so we get some output when compiling
>>>   quiet-@ =3D $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "$=
(strip $2)" && ))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

