Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AA2C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZBR-0007i5-EQ; Mon, 12 Feb 2024 11:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZZBP-0007hs-J8
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:29:27 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZZBO-0004KF-5f
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:29:27 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5601eb97b29so6120691a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707755364; x=1708360164; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWClLr2SewbSpVpXdizo7GzyTs4wmKSrdbEFm/iOTIQ=;
 b=ScxGsuyETOMDVzYnBgGCYIGiTMR/A++oy7QgYJ5czHDjl7DcTZaFm8mVbX7AT5Ew7Z
 bQO4HJCy/rpQQ5iznevxOFqiLuSB+gb9HNRo+ICZBogcfV7zb9/KIC3wK/jsNojjRH60
 jcM5M274lQMpWYA5GaAI00iQUWvi7bN6tswtpZdlCs9/lmXeD+EpZNyUhDhDOnuBqgkm
 2cnEAHN1j3p3Od+5X9170gFFpput+ueGvyvRm82JdIBdy+aKWe2oMZor43uJ/RbYeE8V
 Ig+YMrLhQYBVRoPa5QVsEbzTCaNo61tH+S/p6FVFDFNErKQ5W801DNU2/QuTOkB3GKFz
 HhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707755364; x=1708360164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWClLr2SewbSpVpXdizo7GzyTs4wmKSrdbEFm/iOTIQ=;
 b=wRLD7wxKD/l5rP3aY2uokIDNO3lHfVlxdrnhtK54TpeTLGo3XL/hcdjpDLdlGz9PwM
 Qe5j0eL4C2IJPZDnSaYmu7+UjR4OpyVO6Dre2cI/f4xZp1d/R6OBjZ5WyYMwAhJ4YzQD
 MRlNvqM5xSIPxAJH1xra8hXb7AZ973bwXsfYZyKT9l+3PU6ABmGNRhEz/P5UFux8wKFY
 dXYJ3E/VARoc3/ZlDtGR12uzTIup6iAPxCU9pk5JIWGCBSfY4V7xpvAXNduDg7m/OTo3
 z6KTFmuVsP8nLz/5nEdNuClGE2Ju0VusPTbl/djFrI9kqETYkOS4kZ4YQ7nMtExW5Npc
 Oaag==
X-Gm-Message-State: AOJu0YwPFPeFRXEUCj2u2VbRXQ7cJX5gKdq/uC2t0+B/H3TzIdbEkWbe
 A+stOQnuabmXb2zwqa7t2n34z/ADu3ct3YDkazTiDsIZFy6rNBphPBPYg/qeEP2Z+QjeeJfBYa6
 jFosfJtNnjNErFpKteGDxhGH+JxSp9lC0YUxSyQ==
X-Google-Smtp-Source: AGHT+IGzCvUhTmJd1j7Da+s77pud0AnMEgXE3epMyEUI4VCqtpcE8/p6HUSwIvEkoIh9GkEFXTGx+/l/NtBq9k8qJo4=
X-Received: by 2002:a05:6402:5298:b0:55f:e2ee:6bba with SMTP id
 en24-20020a056402529800b0055fe2ee6bbamr9569edb.5.1707755364416; Mon, 12 Feb
 2024 08:29:24 -0800 (PST)
MIME-Version: 1.0
References: <LV2PR12MB598943FA3FC5605955DCF2A0D8482@LV2PR12MB5989.namprd12.prod.outlook.com>
In-Reply-To: <LV2PR12MB598943FA3FC5605955DCF2A0D8482@LV2PR12MB5989.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2024 16:29:13 +0000
Message-ID: <CAFEAcA-VLEm5BYptxQ+hsQKz7ARC+xAbRqdqZViAmi_g7=btfA@mail.gmail.com>
Subject: Re: Requesting suggestions on how to access I2C Bus of the Guest OS
To: Harshit Aghera <haghera@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Shakeeb Pasha <spasha@nvidia.com>, 
 Arun D Patil <arundp@nvidia.com>, Raghul Rajakumar <rrajakumar@nvidia.com>
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

On Mon, 12 Feb 2024 at 16:01, Harshit Aghera <haghera@nvidia.com> wrote:
>
> We have a Linux image targeted for architecture Cortex A7, that we are ru=
nning inside QEMU on x86 machine.
>
>
>
> Our Linux image has I2C slave with EEPROM backend, instantiated from user=
-space. Reference - Linux I2C slave EEPROM backend =E2=80=94 The Linux Kern=
el documentation.
>
> Commands used from user-space to instantiate these I2C slaves =E2=80=93
>
> echo slave-24c512ro 0x1054 > /sys/bus/i2c/devices/i2c-0/new_device
>
> echo slave-24c02 0x1054 > /sys/bus/i2c/devices/i2c-1/new_device
>
>
>
> Is there a way to send I2C messages to these I2C buses (bus 0 and bus 1) =
on the Guest OS, as a I2C Master from the Host OS?
>
> Is there a way to send I2C messages to these I2C buses from a separate QE=
MU Instance=E2=80=99s Guest OS acting as a I2C Master?

No; our i2c bus framework does not currently support either of those
things.

thanks
-- PMM

