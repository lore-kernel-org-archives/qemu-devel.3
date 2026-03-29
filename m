Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AFDF3D5FF
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 12:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6pJ9-0002IU-Ga; Sun, 29 Mar 2026 08:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6pJ5-0002Fj-Gs
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 08:31:57 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6pIz-0005fK-UX
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 08:31:53 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64eb84d1e37so3529304d50.2
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 05:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774787506; cv=none;
 d=google.com; s=arc-20240605;
 b=HehwSYYTyoR5JjtBwfFJ9fBR+3fo1TrAt8HmxVKljjCm+/lF9ce6zWY625sE5Is6Og
 ivFpPRmR9n1okW09KVQSCpfH5YC3+VlJHqVDjht1BURpWV/IzHC87+QbI8xEsckwzTem
 d4OLXAUQU80uzkO/apiEfH1w7qYZa88JxQz85Vjn5c/kusbvgPzV34g9U9aotwphH6os
 or2F2lKs0+yvS9CnsKuT9xAeYcc13iSYtObMwO1N/iFxUQNDwx/JxfHV5+6d/5mVlKpR
 +k2w5t/u4w7s0I7gXmMwjnXQP1Ijtb+nLCEtnWndiLQIgoPKiplbjziqdtL8k3ffRQG3
 Ursw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1rWMNyoQX185/O7+8B4Vni2X1mwsO0ZJ9a8xAUmEwgM=;
 fh=uDzmcLAbvfWtywDp4MVTsSs2VJ1wqKml9VWFlJfEz/4=;
 b=c4yKr/dt3oeOONDpuNvqCtDokKXR3zaCo87eLlNW+MEuH0CPr+B3IWOBsLgVT9rZVM
 Ph+V6TX+Nf4KIHcBNtg/nPp4thNysTCp/5Ee2BND5FODHA+cBjLpuQnoX7egZVNH+2Bp
 Y2V2v4RmnRc/Sv3g8H8sohITAGxk8WT/NmMeDgZQVi/BgP5gJzIid+n3VPw7v5N3RlsU
 6AVCXKNWaG2XvLVOpOASrUjFfddxQS2gZm+eUPAL2j2dhgtcYN3wvcrEYov9HniQvwlB
 SHPZ9dLpd8m9mWBbc7w9PoxXa68a9HoEoDxR5svj9tYTO8tk8l2SWVa+MyUH+v6vPNz5
 70xw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774787506; x=1775392306; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1rWMNyoQX185/O7+8B4Vni2X1mwsO0ZJ9a8xAUmEwgM=;
 b=Ij7JhiH+7c5Zypw2p/hxkh/xK1VvbMSNY7liQlMUHpiooceKuhqg2aeL8aeQYfqpnd
 no2Rz2zurFI5eoaHZS6bb+3oIyGfV2L/N8yY+KKe0zVWlG831j+rov0/E8w6TnrCiYRD
 Bgse/LQg/RMOxpn+zTiqyGMf2zZWbi6Chzly9dDOLchOnbGlQbDQR9l6E/SJ5mlu0p0i
 /hiV+SaQJ8agm9M+vMdlb+0IASSqmz0IiTeoucEEsEFwBAIMqFftp4Gfk/pb/SyoDT1N
 roLhBv5FSn1qGDjk+1LrhX6Jiu1zmrHi5uTiIavKUFItateBHjCwopxVKQTPDK4IhZug
 uZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774787506; x=1775392306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rWMNyoQX185/O7+8B4Vni2X1mwsO0ZJ9a8xAUmEwgM=;
 b=rAW8WdrOT/TE4v0G/3Zvtwbr0to9s2dYZRwPRDMH+PPy+6bJ41pTkvD92gg88T4rCg
 hR2u77ZAU1ZmLukUK/3M/7bqs0ElIwR0s9v2XZWEvW30OOLCfTl4607XKxilx9rJE7/A
 rnr7dtYxZ1Kzn36GtHhISTjfy6QpBiDHyY8OgNu6l6zcvLsUC1/LlSOQdT/LIdjqi/A9
 Sw3Og7f+E8vSSDHPRPlnpQfQcToeXeeLGa3o5RNPGWspmBk4/40pJM6ejYRNkhsRSI28
 T3dsS/esI/lIIeOJhVpuQB6158vO4+cY93HNQ/WAkbw0lsYhTYCEu9A8xCGpzK2dj/mF
 aQyA==
X-Gm-Message-State: AOJu0Yxp4T4ErQa+l5G4uHy/CREidByx6x4hrh7VENi3lJPVyskNu/AL
 KcCRICsxwcrA24tcDVfeY8/NX0xWa3BL3l+Zls/0zTy6aLMr/++5PeFIZeeHqtGjWz1eHFW77vw
 Opp1QQ7FvfD246jO8Hcr0BRyEERu0gNHQUSuKx2tIng==
X-Gm-Gg: ATEYQzyUsmxDrOO1oKvLDwq2616tSUjOdgOtjYc/TtQg9Ot6TK7mZKlRAzCzYvp9pzb
 tAZhcj5ccrzrdxl/d3dd4NUd4zt5GUvC8U/dawfEjfjhFciPGBBzs5JB9DrNh8QE1IRpXYe+b5K
 RCcrRXMs0IQKPESU2/BwvzEJ4lqz2n6RO63eYux2WeEhpCzHfHvDbV1EdG1ZpRQO5girOg9f9/O
 cidwgm2FusJjaOKcrlztePzXhTRv6TOs6ZCrvYwVlKK2o4mDNUzwNplB1ink41Pqq7xyrlhN8cv
 VPaBJWRXKDAi6p9w5oGEv5dGOLDyALnyzUCKGRylSdPNY/LImYxC6wlXO8jEjqnTUec=
X-Received: by 2002:a05:690e:dc6:b0:650:18fc:f557 with SMTP id
 956f58d0204a3-65018fcff27mr1097161d50.56.1774787506533; Sun, 29 Mar 2026
 05:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260327180905.378560-1-kkostiuk@redhat.com>
In-Reply-To: <20260327180905.378560-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Mar 2026 13:31:35 +0100
X-Gm-Features: AQROBzAX_TKrjKTTDU-2K82C_PCGEpe9B8xzCuptEsyNYQKBToXpfzRvNr16eF4
Message-ID: <CAFEAcA-hEUSwwvRASSUFDNhYi8=Te32j=k0+AJFHWBagjMKcRQ@mail.gmail.com>
Subject: Re: [PULL 0/3] QEMU Guest Agent: Fix fsfreeze-hook script
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 27 Mar 2026 at 18:09, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> The following changes since commit 770f50c14f098717fd40ae6e826a495681152447:
>
>   Merge tag 'pull-nvme-20260326' of https://gitlab.com/birkelund/qemu into staging (2026-03-26 10:26:39 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-03-27
>
> for you to fetch changes up to 08497afcb2a737794991f17a37f0a0971fca411e:
>
>   scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic (2026-03-27 19:55:01 +0200)
>
> ----------------------------------------------------------------
> qga-pull-2026-03-27
>
> ----------------------------------------------------------------
> Peter Maydell (3):
>       scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
>       scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of PIPESTATUS
>       scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

