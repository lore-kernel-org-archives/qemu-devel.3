Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F65C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUWsi-00075v-Oh; Mon, 29 Jan 2024 14:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUWsd-00075f-Km
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:01:18 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUWsa-0007Ld-S1
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:01:15 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51114557c77so1233866e87.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706554870; x=1707159670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+jrr6WJgKkQuiWa2dWelSTnj7NJ2iaAUdO/MDkffBg=;
 b=Iqld4sN6kRt1FlWC+qxhcEcC3d3PocZYQnwP2uL28ySAgzwwEab39dGnPu+Um6xHJX
 bVg1i29oiZ7FCB93GxYiGB5MaUM1EGSzQJWkuJZ2LhhYMjsvkiShPapDTkxdVMQYpZIa
 PkQuu2GFGK1g8KewZ+XlcouZVo+ipswpR8mYegTvkHehxiL1EE0g0FLgT5/y2st02/NO
 5JH4qyftwEWJYbXxhBiX+qkxRvbN5JJqtQvMt3V8fGEqEoA/RROeD0/V0L7Efk3qVbA7
 frsBOB7O6yKSL6iHiggCMHLy9ulKoEa95Ao2mP1BMkudTKqCTMv1a1I3I+7WR29taqwq
 UIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706554870; x=1707159670;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+jrr6WJgKkQuiWa2dWelSTnj7NJ2iaAUdO/MDkffBg=;
 b=a1HYGpN4W37Naa7m53fPhYszosr+zAynFKtKn4Du3RSU+/jh/9ZTWmk+yxEGEj7VZd
 yEK505cve0ABxX+QZEbX0+FJ5fr8UBgr1WbBZ5YA4yVFBPMG8vvKNr25zzX1xwoEaTC5
 h5+aDcmu7beSbPqzXguc4M3QTrCd7WRdBFw18S89n0KoqLQSRx9FKT2kZLkFeGLHRSBj
 HEGZXQ3efRV+TqW3UozTiUe8ARV1r8mehkgwmqhILYlKM/31o1xD3o1bpluSuLApuaQa
 IPmSqg0sX8jTqx2kXav7kFDne/1lXCBfI148Qt/lhj9A1zrjKNWBKUVI9PNPssNfomf1
 JOmw==
X-Gm-Message-State: AOJu0Yy+i2LI2AulUhGGKg/E0oahQOCLy/jc7ZFNBJmLRoAXdG7ntPTq
 7WAnG8q57ckJSsBQjtceBHcQN7tSBtsSW3XvivfSe+M5vdWWlsjj
X-Google-Smtp-Source: AGHT+IHlj2XHEl1HGIOF2iuIKuR7GUZRnIWT4rFasL0hEz/Aepwn0SqWPJG8R3LG4ljXVektWsejvQ==
X-Received: by 2002:a05:6512:124e:b0:50e:7e13:813a with SMTP id
 fb14-20020a056512124e00b0050e7e13813amr5447010lfb.61.1706554870206; 
 Mon, 29 Jan 2024 11:01:10 -0800 (PST)
Received: from [127.0.0.1] ([45.156.240.113]) by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c155300b0040e541ddcb1sm10964755wmg.33.2024.01.29.11.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 11:01:09 -0800 (PST)
Date: Mon, 29 Jan 2024 19:01:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH 0/4] mips: do not list individual devices from configs/
In-Reply-To: <CABgObfb9+6JeMnEDx8kQOnybiuhmQfc-PpgVpTxf=4C9VCCNbQ@mail.gmail.com>
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <03B07185-06C2-49E9-8E70-D2499D2238A7@gmail.com>
 <CABgObfb9+6JeMnEDx8kQOnybiuhmQfc-PpgVpTxf=4C9VCCNbQ@mail.gmail.com>
Message-ID: <DE0D7D28-4B6C-4129-B653-07C5B255162C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 29=2E Januar 2024 18:16:08 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>On Mon, Jan 29, 2024 at 6:48=E2=80=AFPM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>> Am 29=2E Januar 2024 13:37:44 UTC schrieb Paolo Bonzini <pbonzini@redha=
t=2Ecom>:
>> >Back when Kconfig was introduced, the individual dependencies for MIPS
>> >boards were never added to hw/mips/Kconfig=2E  Do it now=2E
>>
>> There is also: https://patchew=2Eorg/QEMU/20230109204124=2E102592-1-she=
ntey@gmail=2Ecom/
>
>Oh, that's a pity=2E Looks like your version doesn't apply anymore, but
>we can salvage "[PATCH 2/4] hw/mips/Kconfig: Remove ISA dependencies
>from MIPSsim board" which is slightly more complete than my version=2E

Sounds good to me!

Bernhard
>
>Paolo
>

