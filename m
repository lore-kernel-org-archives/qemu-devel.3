Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5118AD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQANG-00064p-Nn; Mon, 01 Dec 2025 15:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAN6-00060a-W2
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:19:46 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAN4-000158-A2
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:19:43 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6432842cafdso4200769d50.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764620381; x=1765225181; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=efnfXqO+iZnUYeX4fmRz/HKzTLNfWqIAz9K5dEZKoXg=;
 b=EQHh4agoRyN1yAydXqEDRqd/b8B09v3coPtQU4bWwYn5qnyYCI/ZJzOU1X2UhgOmlo
 BLUWgLGoA3KHfT1iNRaRH8nyKEx3es+C+bq2W3xeI8B9udrdhkDVofleQ5or2lkcWcZ7
 H9va2dxYn0a6OouYtt9j+Vjgo8oZK7hCTTODkYEtm5dIcJkHcIrmJFQODuTXJ6aIRF6n
 /VlThDn2ER1EhnQvGeZ6pIv/DOK1wplzpYM7XLIAF2ZJJgYaEm1mdFcw1i87+n/7SO1d
 OO+RpUh0MIa5tJyPbD6JIhfxQUQ9fxee46iy8wMWb8k66yC4QpNeq2wZv7knfLxAy9e6
 8Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764620381; x=1765225181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efnfXqO+iZnUYeX4fmRz/HKzTLNfWqIAz9K5dEZKoXg=;
 b=uAQ7Soc7Ik/MF0uDpxuHRmJ+0WwzZw1XwUviGbstod9HguxalKKLbBjX1e3tZqC+ad
 Ku6tgvafQobynQqkOooBOWRXQrhu3i1LEUT/PfoXkr13/TVFeRYXuUZTJKcZKgS4qhEI
 cp9C5VWNZiTTxkD0zyPs4aNr3a3WhFzJrBNiBQC38PMT2wdGK+AWvI7YpgGLZoN6RSky
 VyDlgJnhFqdO8Tmb4uC+0b2vNOKdRAFKRTyNwVP5Q4wUlskgTGXEbt4rRYExqB9TYjUF
 hlsB2JvZ9WMJrntVavDsPR+f4szX8TGjrtV9TPdZ4hRO2bso717KrgeqyGbTeFQjFlN/
 vJ0A==
X-Gm-Message-State: AOJu0Yzkgm+rOnStdPz+WOlljOGbu6bFI0qIbuoUgHaibbD7i/mwRLLV
 l4vShf1XYmgYRkyC5jyVQBbYS/XZM6v2eHfVWao0UkLB+5qWCCa+ZGxG9lscpO+2rYN4NAOw6XU
 uScFU+Bf8ltzoZ9gHA3Yd4mGeJ+cwuHQ0Ku0DjwbAqA==
X-Gm-Gg: ASbGncsV0LKwGJ+IE8OEkhZ8cxnDeSzLJ+3dKbAd11PrmpGsZ2IjREDEJbX0T+jXxGM
 gAOX71k0FK3KWDUPhTTsybd8O5cRPQqDydnAFAr4hWevyVd0g1/qpjrvGeHSBJU+lfdhcKfNSJ2
 3GBaVuZFATYZBnKDiVPvO6P6O+XvpcNqfL61+RqZ9tYfcit3scXxX1ojKSDyTmJPO3LQNlcmqZi
 Nr6xnwylqrAYRSrMajT0aoS0M8RixJ7gtxhjLW0k9+7PNjoB/Az+SjvfIwcYMNRPatJlGZR
X-Google-Smtp-Source: AGHT+IFkKgx6BhtfTZT/h99UcYvbZjKsfIVqMxEdnrQojlzdZrIBjThXPDOlnguwyj0gmhHwjprLTKHIdbOQV5e7kqI=
X-Received: by 2002:a05:690e:bcb:b0:644:2e5b:4124 with SMTP id
 956f58d0204a3-6442e5b4555mr456334d50.25.1764620380801; Mon, 01 Dec 2025
 12:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <AM9PR04MB8487540421160BCD438CFDA987D1A@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8487540421160BCD438CFDA987D1A@AM9PR04MB8487.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:19:29 +0000
X-Gm-Features: AWmQ_bme53rRZ-9dNk35G5JHec3cBHtEzxFWp0hjLIvLD16EamvTb6zsnv1bM7E
Message-ID: <CAFEAcA96wEquV-rWRU8x7DZBkNUOLYb_DVi80GRSZ_ekGGLUhw@mail.gmail.com>
Subject: Re: [PATCHv3 00/13] Adding comprehensive support for i.MX8MM EVK board
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 25 Nov 2025 at 05:22, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> ping
>
> -----Original Message-----
> From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Sent: 19 November 2025 18:30
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Subject: [PATCHv3 00/13] Adding comprehensive support for i.MX8MM EVK board
>
> Changes in v3:
> - Minor documentation change - Added KVM Acceleration section in docs/system/arm/imx8mm-evk.rst
>
> Changes in v2:
> - Fixed the DTB offset in functional testing script test_imx8mm_evk.py
>   and preserved alphabetical order of machine names in tests/functional/aarch64/meson.build
> - Fixed a typo and updated the documentation
> - Modified structures type to static const in fsl-imx8mm.c wherever
>   applicable.
> - Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk.c. This
>   is needed because the default DTB in the iMX LF BSP images have CSI
>   and DSI enabled. Developers/Hobbyists using these BSP images will
>   observe CSI and DSI crash logs on the console since these are unimplemented.
>   With this change, both debian and iMX LF images will boot up without any issues.

At least some of these patches were reviewed by Philippe in v1.
Did they all change?

The way this is supposed to work is that where a patch has been
reviewed and hasn't changed in a followup respin of a patchset,
you keep the reviewed-by tag, which tells us that we don't need
to repeat that bit of the review. More detail:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review

thanks
-- PMM

