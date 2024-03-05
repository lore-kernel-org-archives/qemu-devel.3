Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48174C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXNJ-00085h-Of; Tue, 05 Mar 2024 11:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhXNB-0007wj-RS
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:10:37 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhXN7-0003Sl-Tj
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:10:33 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56657bcd555so7351667a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 08:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709655022; x=1710259822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITPbuyvZojASfMoINkZ6zQKEHusy65TEHK8RoXJYJwY=;
 b=BiVzL8v4ARQoTCzXfSYfvoZOUV2zTOf19K7u2TLSSkw8ODUhGTT/SxIw2RDvLUWyot
 7+P7amYi9GSUCMHx817iIHcTCYiuIpuI/rdfalZlXwtH+M9oXrrKLHL9Z3gLsT8jvXwb
 kc956RpKkUgk/F+Rk7922Tt8dG2kyHWyI1bgOttFEPbgX0RwFlP43diOTtvKZCwCRmeV
 XgjPrfEZ50yjdNn8VI2Cncmr0sU/fKqfnpgCLuxtncHvxmIHe8V1I9cFF/boLqbjBa9Y
 4h+mTVhI8nusdLVDBvyuijasjja760UvUe/FoI0dbuwWBHCuckRPI4qec/fcTPBpCa2p
 vXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709655022; x=1710259822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITPbuyvZojASfMoINkZ6zQKEHusy65TEHK8RoXJYJwY=;
 b=oKfAdd+VOjxPtzsCmPN0BHqauG50OkHLVYOi64ERDYqSqUclrP1Da0HIX6u5k0RSG0
 GEArReVCQRWkfyU663xcCHczcGWvnxDPjFHfyNr4Y3WWM1CrVN/nphE0f510hincUb4R
 WapX7VGXkbUQD5kclTrafPWQCmyG7ROkxNbI4xW0LTjVuvlcX9qwYRQG+gkH4oxRGe7b
 OPmRE0slWmv3eZPDeUzrqHz+sGWa54BUgqA+0o/qdnuDkUAdWgwe9nsg3RR/czgwxfpv
 1BbeydOjQeaLIRrHKLoa59fo06lcwvG3YqqTzE0mElmkSzNMcxb6a4fBbHJPPzQW6scw
 J56w==
X-Gm-Message-State: AOJu0Yx+aHDyiMSuEVRtwY/4r1jVFshHPXpFWOjx9kz5Sq4ebEdmyRIU
 C37z7xW/EHu79vFKfJhgZLfo5YutnXcV++5wpND0gTyErAfbKdO44ETy3FQ5QDtchLuOdLLh8ZY
 1FtiHg+hRBmMkE1lWU3K0+v8T/4aqyy5/Xtmysw==
X-Google-Smtp-Source: AGHT+IHm7Az3S8fUrapdnBxvN7RKfBJKUSYxlLRCg/LMcuv3YjBAsdernmfgNsKGwjOVfuFHkG5SpQLg0lJeMXh+rMs=
X-Received: by 2002:a05:6402:40cc:b0:567:1458:caa with SMTP id
 z12-20020a05640240cc00b0056714580caamr6589444edb.40.1709655022475; Tue, 05
 Mar 2024 08:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20240224105417.195674-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240224105417.195674-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 16:10:10 +0000
Message-ID: <CAFEAcA9cW0W8pcD6-HBrF2V9t1ewvAR+bB5+khSrWT5-gcxUcQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add device STM32L4x5 GPIO
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 24 Feb 2024 at 10:54, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> This patch adds a new device STM32L4x5 GPIO device and is part
> of a series implementing the STM32L4x5 with a few peripherals.

Hi -- I think this patchset is basically good to go, but it
didn't quite apply cleanly on top of the RCC v6 patchset.
If you could rebase it on current head-of-git (where the RCC
device has just landed) and send it out within the next few
days then we should be able to get it into the 9.0 release.
(Softfreeze is 12 Mar, and patches need to be in pullrequests
by then, so the patch needs to get on the list a little before
softfreeze.) Otherwise we'll be able to put it in for 9.1.

thanks
-- PMM

