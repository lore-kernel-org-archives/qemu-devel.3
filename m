Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DD5109B474
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ZyQ-0006Nl-Fu; Tue, 31 Mar 2026 10:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ZyP-0006NY-1E
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:21:41 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ZyN-0005E5-Fc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:21:40 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64937edbc9eso7394786d50.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 07:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774966898; cv=none;
 d=google.com; s=arc-20240605;
 b=Grc1ieLmMfdmCzwezwMKrUhjTWuCuaE7bLyciCgTClTPwgj5hOm0YqRJNdMlMKnXOA
 HNL9dw0Xqhpio5+v5dZbUNzPtAsL1LKOsXjpGRGiJY5bCc36ukrocsDjt5zIRSvKeSuj
 Mx3HPOT+cEjuYMt+YRuxX0Z5KzsFRFtAUaaEu/fyIeu4y4aru3rbfu3NvojiP/FbVhu2
 uX/dlHuhoBFk26JC9TWl/LNA8oH5XP2pYiipFyZrui1Z8A3FCp/E74ZRmlyM+PvXrFEP
 rQUImYakMQBdzS9mP94aKcM6hAKVpJp4EBNYwfHzJQn8l5v1ejmVpiZIV2Y8R9PA2NY/
 eY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TlXRt4P9aFKCll38DCz8SpNHaqk3yn9evuVjyjpx1Gk=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=aDqMKCSR6kGIbhdTEmbOi5iBT3kybGXiQXZU6Fq8PSORetDPZGnGtlBiNpQ7y5IM7o
 0U1RU8o0HiEcW0pd5Nb06CXF87QSgYX4P4GyIV9Ovb9PZCwI7l7rbpc6WgOwUlB6061J
 f4dlqN95zwM1T1V0Jd3mRcz+AYGgkFrlXVzyPWbZcZreWD3lNIo90kNHVp/70oZ01c0Z
 TU+DUieAbDErsP1oKASUqdV4a7T4OfY35g6/VwBKN2ipeuQs5J89u/pQDeurPNWOfnqQ
 tmngeLYAK2gwyVRmAa8Eh8SZisX33GPsi1KL0PkVRPXFmIxCTtYHvYjxRn+YZHjR1/Nx
 k+3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774966898; x=1775571698; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlXRt4P9aFKCll38DCz8SpNHaqk3yn9evuVjyjpx1Gk=;
 b=NO/mdOnTFHAkpJs3P3JQ0+qNe4Tpu5h7ORotj50qq9pgDtz2I9wLxEa4fFrq7n5q9N
 En0FowKxbUlatMvEpRvY/ERbx7HL7Ouc1U0DhPLAYlg5/15CLV9Ls+TZX0X+Wp7WjADv
 yuk6kAInAypfB1CRzvYD/GyZr/hxYofgA8IuVFRHX88WYgq3WvdQF+IrgaTTna0dMfpm
 mXlrQ/rcHueraD+drRfpUVwdUbOGEWpvAZBqP4I2D05Tlrh954QxyLxg7t6Pk0fNKbO3
 Ni8bZU/7pPTRdSVIo9eRPGRY31S7zLeHTLzDPDCSEAGD299mKqFX9XfyHaLnEoT+FsEO
 QH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774966898; x=1775571698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TlXRt4P9aFKCll38DCz8SpNHaqk3yn9evuVjyjpx1Gk=;
 b=rxVGokBt8ji+nUDQydvJOD5IQjDjOsPPTcE6a8d/L0iDi3bcKlkLQqpoZWR8P9urUZ
 4ZNRELCQ5BNyVJ2TXR13cTUFPz7lqqB+IkjFY6l/4bdPK9oN9Mw0bHThAqhGzfZiLHK3
 zLjvAzTSjsOcvs4yoMRhajlaiFpTSI+z4tgSFPBhi0t6YbG32v2mqa09zg+oyNqMNV47
 3h4zx5UcDzDv1/V5DAxdHzuQe0gKZ79auJ6VevGYB+eTNui9Ctm4qhCrPZCLXZ2PDJia
 nzbrO2y7MTuizZTZz+0NmDSC3kv1v+mm+MFmhZoUMl+3AfSGizEiSuKb2NT/QDcbx5A5
 0uzw==
X-Gm-Message-State: AOJu0YzelJLkgnN66KP8KJYF7elsLebJiHgWYY6kPuRvm7LYtoj2NkJX
 VFtkW4MoqN3tUwM1RQsTJe3kRa1xhivr3dDTOSiQjh5+7YB7LK7Ffkgu/mYCPJGKyhqd/DVsL/f
 cDdfA3Tb0jEUcqJ1YlM56Tcax6pFZ6FaV80gGbbiPv6T0Xcj0skXxDuM=
X-Gm-Gg: ATEYQzzfhd8bSHr34Fngz8ZV3Lcw6iTr0PrC/abruL1fmc/v4JiXqABrriG24AObllE
 u/Rtkejlr7Z5v4pBMpq3qzJEqwjsfLSsHCCb2esUMD+OqbtKaa9iFypORhrt5y3QNWjxc9Ub9gX
 fafT4tiDQnW9CHXMEa1DOCpgF5rjPCF13jxzca/dVDZlUrByZdV1JH9+cX0R/hRNjemQ9C9EBSF
 Y5qGpJ94zXZ2ekvp9jKdAhLuE3hK4+lkpHWAV5aWfeHXIpDg0TrVK+3ASd1HoFvqImFrJB4wMTQ
 1iuH4o4uKhRHohQ7V+Uwc9sVPNPCeAmbRr/RPQS7BPbYzAyfqbxXCVtvN9W/DTTdVSI=
X-Received: by 2002:a05:690e:c45:b0:650:1af1:6a56 with SMTP id
 956f58d0204a3-6501af1729emr7748032d50.51.1774966897851; Tue, 31 Mar 2026
 07:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260331095302.644608-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260331095302.644608-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 15:21:26 +0100
X-Gm-Features: AQROBzBTd1p7kQiVnYWflOw9-My2W0D4chK4RDv2UAqlUQxToXgFGqVZsKAnm7E
Message-ID: <CAFEAcA_GCq63K4EGf29HGSLf0EoFWCZuQy_Yp5UJqH=CYhz=hQ@mail.gmail.com>
Subject: Re: [PULL 0/6] For 11.0 rc patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
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

On Tue, 31 Mar 2026 at 10:53, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 91f6a9cb1b0f11afa74ef7fb20d5579d9dfbe0=
20:
>
>   Merge tag 'qga-pull-2026-03-27' of https://github.com/kostyanf14/qemu i=
nto staging (2026-03-27 18:41:05 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/for-11.0-rc-pull-requ=
est
>
> for you to fetch changes up to 425f084fd2dc9838c82eebbfdb88eab5a545ec97:
>
>   tests: don't build audio tests when no audio drivers are enabled (2026-=
03-31 13:48:42 +0400)
>
> ----------------------------------------------------------------
> Various UI & audio fixes for 11.0-rc
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

