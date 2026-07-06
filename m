Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26AEC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgff5-0002Kw-O2; Mon, 06 Jul 2026 05:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgfel-0002EH-IE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:30:27 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgfej-0008BB-CO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:30:26 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664d35b4777so3948133d50.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783330223; cv=none;
 d=google.com; s=arc-20260327;
 b=a70zKIqtueek3lMOkA/x6c+KzZxu/uwBC1VpYw0uoCyo7/6t+m20ph6sgkk7fN0myB
 Hu36qqeQpGB9L6o6pLpaQJXW5GhVRiZa4FMoJWja376kNJ6QK+X9r3CWoII9xFglTW1T
 UaNyUUo15QVL34Xkh7yr+3IMhMkTDOeqt/Plwktdpmf1hZfgpY3MKtSH2DawdsB1SQMg
 QifWxJEL/Uc6SYIk2RVpXtD93V0e+qed27W0ELR1Ac0CNEM/cepeo9zOtUy0vX74l9Og
 HjlEuJHmUzF1udB0mDBZz4NvBUDm3jmomnS6JyoR3Cp+011u0XKX41xRblISfsGCtMj4
 5ELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1laCnAkCmus+RdL3WBsb/PkScrDxrayjVQoHHNn4lhM=;
 fh=Rqj0BkhYVitrTp0C4VYnwdrjvLJ1P7MFwU8PrOExr5w=;
 b=V95jNCxFfz9PqrhcqxfjWQ8Fza932rtT5DlASQKYj5RiJuFieCLN2qCT0YSJwXrETN
 AUXHYyQXiP+v+6bALNXFZh8pBCrTMIYl0pt6Whuwz6UZC/29/uf/jx1qflf4XVKe1mGj
 z8RbcgF/LzqEwp7oQ9/UG/8Yw3VanCNTJI8kyQVL+PIHb6A6tabj1LCuGIXaC4zlvzEI
 XFnAqU1hz2Tw0DdNAfH6uI2Qw+a5QFtlCWtGvdDF8LQbmPg5i3V7kI8up2mS1PHfymc+
 ZodzCdNyjsfRbm4YJgy5dkDvSNSiwFz8Q4ce1mZbdnxrSJcTjolDM9f17t31m8H/iBFV
 BHYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783330223; x=1783935023; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1laCnAkCmus+RdL3WBsb/PkScrDxrayjVQoHHNn4lhM=;
 b=rN2Xr0EF6pApaaCCdUZvoWig40H87hgumFqA5blBfEklaJ7h3iylzP6NYioz0zOQ1Z
 F80soNo2ydRHvfnSA3wmE4HsxFsb1F/BewCCVUSvNySAJ6yfeRHtBk2GZmc53PVXSrls
 i5BKGP6fnkyRfMWV6tFlyE56Z+iTabWbaTUiHf4nysAM8h/HxL8gYn5y0U+Jc0LZ/315
 BL7pgTifOzlynnrjrdSllVIK9PDhbwiuidXh42/X2j6Qb1dHZF4l9y+yaaDe6VXbnXgs
 oyHlBlxe3zW37/e1M3mB842jX8RkbjPV2gjDJ7xa8O76BN2qy1Os6UykhUSqWMRxfSDk
 xE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783330223; x=1783935023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1laCnAkCmus+RdL3WBsb/PkScrDxrayjVQoHHNn4lhM=;
 b=bnef02uWM8o97Zxs5ynuIDl6XZWm18uEuCtx6xydb6hdnhQXPwBMNEMs9maX9Aql1H
 6b4Gk5Txyns0sJv6V+F/SBzJ9Zhu56tvsaC5AyjenLap/67r5rzFx3gEm0ZE/i1RPdQi
 ThJHfSn418hZYppExgKQ4whYBWomlWtsbSyp9MSPMoSq8MBoSxgyF0tjkxBjYdZUsw/S
 Sp3y9lnxJNy9gDI0Nimw4x496Ar9FNMlieW2rc4ICJRLAbdbUoEkt34UkQQk8wBy4hK1
 LrPG3eXhwc+57ti12Nq/Z1jyFYfY87mJEokIgZRtqygONxhZKqs/ruV/9OdcQodSz2u/
 1KuQ==
X-Gm-Message-State: AOJu0Yy2IunsoWMQjyvbtJrAReI/EC1lF0Dn5sjO90Nbw/A2l/4jwIeX
 vpm2TQm0odImrh3IeO4zLe+o1gBBq2Um+oEnScpmd6ETucmp0Jihvj+EsY52CWAKOCQwvGLHNd0
 KQ/ejkykHxUDK/utwxG597U6jPsccA36LFwql7fPq0Q==
X-Gm-Gg: AfdE7cm7AO+2Y3rR8IUMvwGOV4fQlI1O4RU+mJMogfcmkkpBtleHFOt8wCsoGeVpZGY
 2rRekBO+qQ+noR8C9CjYkxyEJo+9aDJtj0u4C6lLik/jf9jwz+PUl0RAuV7pj61Po0xl2caEAZt
 N6LTwhTfLsGnAhAVpJSTp3bO6xQ97gEWUoHYr23rOFkmhuoaSG/jV4BZhpmYi58unXiJEj0K3aL
 NFgUnyQlm5tctjLULjib+ojuSw4Q2FGThnXOex9RJfRf/2JT+WjHvCVvEqaqzQ9KNC3Ype5VB0w
 D4EZGN5DYFA6NUVP/x8Q5zh8Zzp5aVg+9kYteBLidxdu42/LcQXx/UpFuSYTYL8O3mA=
X-Received: by 2002:a05:690e:4594:20b0:665:9b8:5511 with SMTP id
 956f58d0204a3-66652f12b8cmr7455519d50.55.1783330221096; Mon, 06 Jul 2026
 02:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260614222131.5795-1-imaginos32@gmail.com>
 <CAFEAcA-GGP6aALn4Az5By31q1R3d75Mm+p_YXN0y=tO3GxDYrg@mail.gmail.com>
In-Reply-To: <CAFEAcA-GGP6aALn4Az5By31q1R3d75Mm+p_YXN0y=tO3GxDYrg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 10:30:09 +0100
X-Gm-Features: AVVi8CcnHyWnWA_521BYg5tnYcX-wz5ImmOdHDjWlLfTsHur1pAt6keYnGyTYZU
Message-ID: <CAFEAcA8zLzVLzTq-EJQ9+OpxytMdPuFkUbOF7xjmY0JrhPhYhA@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: pmbus: NUL-terminate strings received via block
 write
To: imaginos <imaginos32@gmail.com>
Cc: qemu-devel@nongnu.org, Titus Rwantare <titusr@google.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping: Titus, could you review this patch, please? It would be
good to get a fix into the upcoming release.

I think on another thread you said also you had some patches
to upstream to fix the "guest asks for data multiple times
but never actually reads it" potential issue ?


thanks
-- PMM


On Mon, 22 Jun 2026 at 11:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 14 Jun 2026 at 23:22, imaginos <imaginos32@gmail.com> wrote:
> >
> > The PMBus string registers (e.g. MFR_MODEL on the ADM1266) are writable
> > by the guest. pmbus_receive_block() can fill the destination field
> > completely, leaving no NUL terminator. When the value is later read back,
> > pmbus_send_string() calls strlen() on it, which reads past the end of the
> > array and returns a length that trips
> >
> >     g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);
> >
> > aborting QEMU. This is guest-triggerable.
> >
> > Add pmbus_receive_string(), the write-side mirror of pmbus_send_string(),
> > which reserves the last byte of the destination so the stored value is
> > always NUL-terminated, and use it for the ADM1266 MFR string registers.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3388
> > Signed-off-by: imaginos <imaginos32@gmail.com>
>
> Thanks for looking at this. Notably, the bug report in #3388 makes
> a completely incorrect claim about what its repro case is actually
> doing. The repro case does the "write 32 bytes to trash the NUL
> terminator, then try to read back", which is what this patch addresses.
>
> I'll let the pmbus maintainers review the patch from a technical
> point of view.
>
> -- PMM

