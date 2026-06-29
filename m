Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886FFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDIK-0002HO-GZ; Mon, 29 Jun 2026 10:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weDIF-0002Ga-Or
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:49:03 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weDID-0005Va-6C
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:49:03 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-664cdeab266so1212401d50.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782744539; cv=none;
 d=google.com; s=arc-20260327;
 b=SaElvyWAIjwuTOqdEm6DC2vqsR3EVVskuS4hfIo4AaAID0buk9DTL01cFAORbCtYr7
 OQdXxOqJwnhTkx5WEbdo9GyeNvP6nNshJptef3a8wrOcP8hBFNZmYcIAJH15vMvXnmfL
 DjiSqn9UfSO8va+UKKdW9jGAiKf7z+W8teovcy44N+LzwDxlRzdBWJmpBatMKrnyzB+0
 BH3hHX6jtcP3xzIg0LYbp1qAvdeK+StfAiYq9x1QuP6XiKKX6sWpq28qVF+EUe5q7env
 qGXEGlO08klSWWYabbKisQi99/iimJbMuucRFcXjPbwXTivavSGh3waIujjzIpWwdiWc
 pC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P4gHZRLMYoVfRXE0W8917mGTZhjFwVe6JasfCV503g8=;
 fh=veedc57u4K6/11cE7NZuRLfy/OlNqq0+rv4lUD8EkAs=;
 b=lrKyEB72nUH2VY8+3h/oaHdpqI/Y6yXfIuQ80cTqxeDbaEU4nSz/ElNsF4Ed9bF32q
 mkyjXwUn93kvx1jS4W6CWK4R+G6XtVVBYZLne0sDjSfU9k8G8MNS8dOE/B+EY91HfGlc
 A3+y90ODCg76FCxQeG4ZIdyejwrakocN3rog2UMihAp5OX6d4ADqW9dKNkvIG/pjdPNO
 2xCDlzbIoSwHIdRvTA8ATQ6JlfN/EjEW6uqSJJk3rPFIV7Ppq+NLZQWJ4C0ddctarCgy
 9NQwsuSbBXULZRnR74JAhZdLkPhrW1GWpi9I2Tsi7IsLaOKaFIteGOKQngJ1V1qMwuYm
 B+Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782744539; x=1783349339; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4gHZRLMYoVfRXE0W8917mGTZhjFwVe6JasfCV503g8=;
 b=RE1Hz53zOEO8sikV138fjo6dghlU0X7AL+g66XnS/lsHHaIupHN7FknUkxPLOLEK/1
 p3q+D12LSpF5pNp1FB2MQUpMWDYryPlbHK4qHQ+pO9TOL6eqm5FuvT5/LJUCW4AQELzR
 b+WU1APu/a+t8huFK+X+5M6aDM8e0loIgsy/HxH5kpLMKkpZB1URv63CH7V6VlEP2QYI
 ZrdCFiuoI9R8Q/l8EuHHp7xYZVSJYJgQor9//Tze/GzSf0PoUuFKjnPvS5N7w/hXiQLs
 gtOhyQdlL+6nX4TAHufLE9/iwpz8km5sZluuqEjjT/UHtsI1AN+Z5rnQinhPcrU3bORP
 NXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744539; x=1783349339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P4gHZRLMYoVfRXE0W8917mGTZhjFwVe6JasfCV503g8=;
 b=lW1hgX9FgjwhtoYh3Z3/l3XRXXAhP/3NO71c/kIdEBDAj9ElML0UVPC9FVRpZ+X55O
 dqKMjvsCFfdKrPCpLBxwswL58lFNSqGja9pn6YzNpuz2Lpb/fijMbxSBeywAqj+xrb3T
 jD4i/wt7gCF/QuC9dxC6Bi8WIlIA9agwPW2KwShPDGfDoZZwVkSD61n+gu+iX9MYKt4G
 jvbsx8g4ba72cCjV0BKrnJxV55STy9/G1YUKfPYkfQHmbgCJQU5hsRsk1BitTar2j4VM
 6COpI0bQjm8l84LGEesMqabBXhVHUZYEdzkSLjkilar2r0qFz0s1gLCm/zO20W2h3axN
 aGKA==
X-Gm-Message-State: AOJu0YxH8tUOh5nWEcnCTPX/0npFPTswOBotGZKZzBFT8bTefkoxNbEP
 FQ+8IOYAjgXRRjNqRQwG49O12YLdk0mPoOWzuXKz1iIKxyvhQMPFYOh6Aq/KGepnduhWqE3ril8
 pdeOEh7v0KggQNZ3/UdLGT7b+VyLe8IfIlNvSfMXWIA==
X-Gm-Gg: AfdE7cnNb2WbVgwTzOtgw64RA+rTF5VHeiEta0Cj330NtRvFeUH1ZdFnp3/koxIA7iM
 ujTgTkTOYhxhNuQoNiriFFz2aA/GwqXRlrHYPJ4IY+NfDNNZY7OBDdkps13ozxel3pXG5dz8eXr
 9aQhHWg9nXMSSaOStI2QerY+L7wFDSIR0NHQNWF0OAiJfNpfVKiDrlc+BoSDEjo0E2BmSDFlPLM
 K3juY1cP5rGiMuUKKIM8heRyWERG6zhARV30A4aMCDI41SSRsyO0qZfBirjZJJOt+Jdeemepftz
 PvU3jC24b+y2NvBD7h+5RzGMOdxRrXgidilGXEfGkNYtMmB7SXN7oz49
X-Received: by 2002:a05:690e:12c2:b0:664:c9f5:37de with SMTP id
 956f58d0204a3-664c9f54c85mr4394801d50.43.1782744539434; Mon, 29 Jun 2026
 07:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-18-imammedo@redhat.com>
In-Reply-To: <20260624102830.1355552-18-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 15:48:48 +0100
X-Gm-Features: AVVi8CeViQkOQyshL8nhzqOJNbXoEA3KY_zPfw092Hdo0gljkwUqhHhoNps0oP0
Message-ID: <CAFEAcA8DzTCP_z9mkHK7QHwMvk8bVb1z7mtN80MsYOZ49ZPx3w@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] sbsa-gwdt: limit compare_value to INT64_MAX
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eauger@redhat.com, 
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 24 Jun 2026 at 11:29, Igor Mammedov <imammedo@redhat.com> wrote:
>
> QEMU timer subsystem uses int64_t, so WCV values with bit 63 set
> overflow and cause the timer to fire immediately. The SBSA spec
> defines WCV as an unsigned 64-bit compare value, so such values
> are valid per spec and represent far-future deadlines (however
> unpractical).
>
> Windows in GTDT mode writes WCV in two 32-bit halves while the
> watchdog is running:
>
>  sbsa-gwdt_control_write [0x8]  <- 0xffffffff    # WOR (~4 sec)
>  sbsa-gwdt_control_write [0x0]  <- 0x1           # WCS enable
>  sbsa-gwdt_control_write [0x14] <- 0xffffffff    # WCVU (intermediate)
>  sbsa-gwdt_control_write [0x10] <- 0xa906ca28    # WCVL
>  sbsa-gwdt_control_write [0x14] <- 0xecb1        # WCVU (final)
>
> The intermediate WCVU write (0xffffffff) creates a WCV above
> INT64_MAX, which overflows QEMU's signed timer and fires
> immediately =E2=80=94 triggering WS0 =3D> WS1 =3D> reboot before the fina=
l
> WCVU write lands.
>
> Clamp WCV to INT64_MAX to avoid timer API overflow.

This bug doesn't exist as described in the current upstream
version of this device, because we don't use WCVU/WCVL in
calculating the timeout (only WORU/WORL, which are forced to
48 bits wide on write). This suggests that either you have
introduced it in this series, in which case it would be better
to not do that, or else that it exists in a different form
in current upstream, in which case it would be better to
fix it first in the patchset, so it can be cc:stable for
backports.

thanks
-- PMM

