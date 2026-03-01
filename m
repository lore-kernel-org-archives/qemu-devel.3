Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C18FD005C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 11:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vweqO-0001XQ-Sx; Sun, 01 Mar 2026 06:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vweqM-0001Wh-7V
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 06:20:14 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vweqK-0006i6-HW
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 06:20:13 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64cb577e79cso3540014d50.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 03:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772364011; cv=none;
 d=google.com; s=arc-20240605;
 b=NhiGQtJTroNunvO/DA/vmRSdDVfgC7l5gogVVZ0wHpr6E0j2TnN0jy12p61wvjeAjx
 IRGSFUpFuqf9NmQbRZXzUoOgyJVhaYFGDoUZyYjrITu+NXRpzltyfQl77yV4B8jYasRn
 6iaIXg38x64K5XVrMtaAeJr60eeKJiHBwVJXc0UpN5JuKfRns+fTrZV8pf3otgItmsG7
 8M9FtGfi5+PE8BFqUaSR1iPx77B+6TCd1+t7jdGdqi/cZnNIh7I0QQPnaRy46upy6DIF
 pFTbBw8pntL8f6tDM8/9kIhGxI7S9qbAfN8mBN03byHbPdmH7TRuyL8M5zYyBeWuVKk3
 zLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w4qm1OfWTHMdqvoVaSdZq4+KjUdjZjFh5b9wBq4LGd4=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=HM8MHe7w/z4k3yoFcZhXTgy/8jBuuU/V3vfBfwPoPF6I8DJY4eBT9tTq4ocVo7U+YW
 jEP32m96YtRr7mT/m0PUARVoAsccZ7phnm3Gz5Oy2ds4EjDOnLpEExuTXwWoPGBhsxLd
 1h9Ze8yt0WAGnUGlU1/OhLvLlkFO3wHFvkHf2FGpC+aJK5uGP4k/Ni4Xje6u9evLRQ0l
 6Q2wXAKUine39pK76UXW9MXAMyDomoWYlhRFanZPsTgi1bNK0ExD1KQgoH8AZhWlEPWE
 LPA++U/SQoqVHXsc8F+nJYHNn3iOcGyyac/VcwNFevWcz64TKQBvLVSZgAyKkSgfH07R
 tybA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772364011; x=1772968811; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4qm1OfWTHMdqvoVaSdZq4+KjUdjZjFh5b9wBq4LGd4=;
 b=lrJpyBvx1ks79jNdx+7Hjx2QHRgjUU82+0EAUlnDHiPyIOnJFROWscGddBHA0AsJCl
 d8qQWVm1rz7gMAiyfr/jyDK3wqaaE6bK385AmHufPCb84NjFyvtJJu4t+hh16YbdcJNG
 ZrM85e8eRaqZM2VtlKU1RW5zK39tIuSQ4PwjN+7SKcQKRP02Rcv0h7s+urwQRDGD5Zy1
 43d7v0KJMaG6n/XYBLcDtoqgp+5i+WCUxH8m0PXwlYPEIybNnhEzdacmE/9sU+Horlvi
 428+pW8WBoVzkE2TWNm9iOTkl/nKUK0IqJoPqF6BNYgCT60lqwAzwnPnbpOT+B6Knmbe
 KgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772364011; x=1772968811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w4qm1OfWTHMdqvoVaSdZq4+KjUdjZjFh5b9wBq4LGd4=;
 b=XARnpWq2bHt9dkQZlpvm4lWr/pGjafXLc/dPv7mB9XEQpxLoPYmsZ1/X5ZgE0o7rci
 H4mC3erJ5IwnWQmYljyDzuUVUIewPM2z/dCOq0+y6luIILA4Pa4YCL757I6AyXriVzcR
 mgyiL1F/dHRTb0A4LE6QUHFpS/avPNf5kdbTYQ4DI4QqcSEd8OKa6BDqlnBsdv+pCA96
 L3WLhnIsZ5ZgtznJuG5oBXn+HPVG3NSBv8iG7yCuqfSHVnMNhp6NiFDKr9eOgXexVknP
 RVXIOBBvs+A4YhCX5uZq6QellcfKgIjTpsHdfTAKLJe6XmoDXWYtpwanvPlyOJVHpbFL
 HQXA==
X-Gm-Message-State: AOJu0YxO13vTWg5ToZJub/tXOo4xcSwcJ2YBmW42n6l3/MOQnEtMrUHM
 DTV22mYH0O1G7cczGYP4964xskCJFDhpBDvuVS3y0gg4EzP5fDCcBPoZhpnJV0LfFu3M9ibLkOA
 C4f+Tj5IkEnYz4y7vX1WWdBTuyR+aV8be0wt0dPo9mg==
X-Gm-Gg: ATEYQzzOs2Pvq3E/PSoLlpBXaQCoWGNcxyatF4HHqIlrIWqo5jboz1sHUyPtvqaeXbB
 U7DdaxGKm8y/J4247lt9+X/iL37TxqUyUuvMz0KkIftduaJ2yThCKtId42mdbairbmJqiq0rONU
 moqYmbvUzxz2XmZ46724Uog5p36kxI8HLFd/8Au31uSdn1tkdUtpHo1srGqUvY6q0CYWcQu3ErG
 SFxEDImmm3WzyMhIoc+WPVGclW8jB+6xl1lRYi3iXPABL646npX/7IHVhe1KEf0sPgb/8ci5ebF
 5rq96i/2M1RiStow+H+AI0xxp6pPVxQDWTWqIP6nrLnQ0nPEhnAQsffUNXBnncd06t4=
X-Received: by 2002:a05:690e:1902:b0:64c:20f7:b018 with SMTP id
 956f58d0204a3-64cc22a40e3mr7448673d50.62.1772364010957; Sun, 01 Mar 2026
 03:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20260227151805.2335641-1-alex.bennee@linaro.org>
In-Reply-To: <20260227151805.2335641-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Mar 2026 11:19:59 +0000
X-Gm-Features: AaiRm53JT1GVFod-UtxVYK_1ongAZWYHkAbNzE39IfRuVqZ6OfharWPeUmkdHgQ
Message-ID: <CAFEAcA-FSKw7yW1+aMGE46wFgV7xGrE+fNTQRAAoJfpWLWJrLQ@mail.gmail.com>
Subject: Re: [PULL 0/7] testing updates (vm, docker, arm functional)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 27 Feb 2026 at 15:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit d8a9d97317d03190b34498741f98f22e2a9afe=
3e:
>
>   Merge tag 'pull-target-arm-20260226' of https://gitlab.com/pm215/qemu i=
nto staging (2026-02-26 16:00:07 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-11.0-testing-updates-2702=
26-2
>
> for you to fetch changes up to 49105fa01059c100332a583816ba97562e181586:
>
>   tests/functional: add Arm VBSA uefi conformance test (2026-02-27 12:54:=
17 +0000)
>
> ----------------------------------------------------------------
> testing updates (vm, docker, arm functional)
>
>   - migrate non-lcitool Debian containers to Trixie (13)
>   - remove legacy-test-cross hacks
>   - fix some minor make vm- Makefile issues
>   - bump OpenBSD to 7.8
>   - add VBSA EFI functional test for Arm
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

