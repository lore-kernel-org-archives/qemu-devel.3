Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9033BE98FDD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAlwD-0004zL-D2; Thu, 09 Apr 2026 05:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAlwB-0004yY-RF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:44:35 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAlw9-00048E-Kc
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:44:34 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-650775f427eso681783d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775727872; cv=none;
 d=google.com; s=arc-20240605;
 b=BoS12hM1oObOn9Bl62E9joeWSqLBF+mXq3kaYQAceqMJxeagwbTfCq8/9qgMZGQIoy
 LQBwNZLD5zegOPDvW8mp1LNqPqZBk+Ivo9mES5mVFYNoo8UYI7FDn/NymCW7+HuUcXQD
 F7UoyfXKbAyEuYk54ChmRtuJQLuP4tVllsFhM7/tnPtN/gntzlN/cm/ABCNQEjBoJRuO
 65/vZizVc7iAlf4ljWW+QpRYpG+j6N+qmEzkLoLHeF0NTGuwa7YCfqdSJOWJ9r3vrogx
 Bdgy6Yi85qf5cKJ3jSI3QH6WVp+0Qypm73n4DWFwYRErl0noLtrUyFiVhHXXEY/JJOex
 PNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/ZrhiVxhtFL1+xKh4MJYNZXqBpbuwHp8gFELgiy658E=;
 fh=PijJ7Z88w7YsiOVm9RiLAS31W5H4oQhvkga0H5hRzCg=;
 b=Hp2tG9xclzVCM6RaU0CbRmXfaYk4Ld98Bi0rw17gzZo6AyPbzXVB6jub8AzZeOOK0P
 sh2lOvoQ07nm22BzVyBa+NWyraX96xoxGrZScFKxQF9Yr3BEyb0MdhfWAnQJHdY5Jh3W
 1JeIQ26/lPO3gKCIQJ+fRRgjwfASEpBaUSsCWwaXrGdKJTJ8PKaSKo9/svFvQzULdC6p
 zD8TMhgsqfGq70RDjKu2jBe+bO3sNaSG5AoSpkAw6ulwxsXnsuVCkVVQfhrKd2MCiBId
 BdfEIV/U1YkTQtTVgJttKRwsYXaxxV9sNXg8N7m9WhabYuNu0s/a1NI2lPjDaSne/5gu
 6LAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775727872; x=1776332672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZrhiVxhtFL1+xKh4MJYNZXqBpbuwHp8gFELgiy658E=;
 b=l7L1sSWm5wpTQ+znLllPZGiiFnP0UslqxIYrPMZukLAe+aXgw72Dpojv5ZWwenNC/E
 eGw+WTC+GY//i/DwAUMFgakHvWu3SSJC4tg1mv/H5AoZtwAKuxcmF3Yl081TbZg8s2xt
 xL7WvxJAQh/QA+I1BFGagAwWapao2JvsCE7XA/OE0Bv3rqC6ZIqBBjNxXKiNzDXpLaHJ
 a/rZ3UFiSgZNk9eE5fiNJ2DR31wgeVGZ0HO/+fsXSrrJr2LzoVBayk2kX0GkfD7YegNS
 uGveZJ5mHBlPBRI3eM1ElYOX3grDpWEjpkBPThRGg6kVW4/CphcCEa3NvheN/VVQ2LyR
 5U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775727872; x=1776332672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ZrhiVxhtFL1+xKh4MJYNZXqBpbuwHp8gFELgiy658E=;
 b=fVlg3WO2nT4CY5Rf1kr1Ugciusk47dTY6wCoj3AO3Y+R6AfzRHqmZiq57g6FBd/bA2
 Bg3xEPUF2MICex1BeSDtcDXYWgTQ006cnxVSivGHKbhGkjTg7/APNot4WeE5Q1WAyQrn
 a4Tvx2Ia5+nBZSwgpzNhtDvWbpo65cN0qdN5ePfYD0673umUXj8g4/6G4P/C+LOr5Op5
 prUtNd3KsvlACy8hlo1M08guYyl0vEYjKORb5Y8vCUUWpfGFaQdjl47JRGLrtvA1s02U
 cn+r2UDqXkQtm1q3uE+jk2qgnnQEzFeTmBKCQ5EZHVwcVYgZ75kaq0XK0w8EIGdnSN9+
 bNDA==
X-Gm-Message-State: AOJu0YyXwzi5tIwrxQVc1bGkE695x6mNU5XLGBpU7z4o/I+ZlDTJMFTg
 S8CQ1iYMsbsm993UcPdgakKE6LlrGb7/zBhODbmy1h1Xl0G951SHTi3k2SgTg5Ymob+PciNyNWj
 jWvulXM20e0FJB/Ae7rI8enS+bP3ZFIqLMOqYZbg2Hw==
X-Gm-Gg: AeBDietnj8e67ICWVDcd7OLZbA8C2OD45/tOSxjd+qOPMAPgrrAIfsGSqGeBaNfCoa8
 DjP/360i0screYLC1NR9tmdpJEg3V+u3l/KWetN4B94Cew2hj3H+xzIfvEpSVD00fpvcaBZFsN0
 zeX/quDSFvWXE/iEZrXbOJBPceQ1snSeB6h4r/GnIL+xLC5AI2/jJT91Er2rMrWCz5p7ZaktHfD
 4NfE8L2c2xAwuMhk70336D5H0m6Y5YUrjXuADABKsshXnNaKMc6UiO/PR7DEFWBnqvTiKUCXmbM
 0Lq5+rePiF84ZaVpHwJKaEVZfKqQLpxivzfP8uo/SyorTK/yTSBPLQIKyN2BwMtga1I=
X-Received: by 2002:a05:690e:440d:b0:649:bbf4:121b with SMTP id
 956f58d0204a3-650486bf82emr18444755d50.2.1775727872243; Thu, 09 Apr 2026
 02:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260407215900.63390-1-philmd@linaro.org>
In-Reply-To: <20260407215900.63390-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 10:44:19 +0100
X-Gm-Features: AQROBzAoPYMVeaUCNkcuRz_C8IkXdpEPTDJ3dVrp79FE99DaX8cqeQJ8Fl7jPpU
Message-ID: <CAFEAcA9gbZ+UDJpgZcy-g0afADRTS1xti8-9TAmZxoX22xB+3w@mail.gmail.com>
Subject: Re: [PATCH-for-11.0 0/6] Misc patches for 2026-04-07
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 8 Apr 2026 at 19:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b=
82:
>
>   Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260407
>
> for you to fetch changes up to 992e01e838733c8063f8a17e92034c5f35e34963:
>
>   ati-vga: Do not crash on 24 bits per pixel (2026-04-07 22:40:29 +0200)
>
> ----------------------------------------------------------------
> Misc HW patches
>
> Few fixes, mostly for VGA display models.
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

