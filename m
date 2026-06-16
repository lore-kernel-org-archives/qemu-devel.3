Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FF5CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZRge-00080i-W1; Tue, 16 Jun 2026 07:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZRgd-00080X-HY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 07:10:31 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZRgb-0003yk-UP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 07:10:31 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7fdeab38240so633487b3.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 04:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781608228; cv=none;
 d=google.com; s=arc-20240605;
 b=HjnLbBwyhdf33n//4yBB5py3xRbi/syJ20KpkKPQk7GUN1a2cW4z9NYgJOilbaeLKc
 dHK9EV+XSjqOW3FHDJxEOgXBB/CJoWeb9qRpfAyxSYu/H2rlfjm+XD5n63wHQkiGELCR
 Dug7wJgLjL37oJj9QtDCh5N0ryqvJNpiUeAcAXgNbwAzPRGghgwSiLe9E7pVU6e9b5Cs
 9t5RKNZQgz8Cy1Szi8d44qqBzERK9vwL2FCYPDL/uZmDYeY0iJFgFa9wBee2RZ7tyIC1
 7A9o/kKDJT95dMGHcS4iirbomMZ9shTAFaPJre2jl60/LwY+SaByZQ+3FWbL24OpObOw
 pNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LfmaREOcJDzgMsSIFDgR/NYonjDVCQaU2EYRmKb6zjg=;
 fh=RPKO1iUAgsTBAdByAVOEKOJn2T8aN0M3baUzK6Xn8qY=;
 b=XkbzPx+DKcvsUuj8gQau4EKxJiqpNzTTK4NXbGz4ykEnPYR8xHjCWwI4YdUZ6b1pv4
 HR0BtS3h4JzygkYDqdpBbSvOMUC0wQCnlttAvaz2YiHc7HKbaVOoU2QW8uGdKFK4Vcf8
 fqXACSkaCiufd6Nk/gl4jTXGR81UXbygEWGZunQvqg0+vol40uysd1lORX4Tb5olACB6
 48w9FUuzw0xhOXQwDuJwMZUeEfgj5XlqLt6l/jsrSFu13jr+R4daHgsroGHfF7MlTV9y
 kNUjTWOrPyDeboZtdoqaIoFf6m7HnSJ6x502Rivoe+un+rxKx1jb+bChx4/kzCbJhodm
 yb1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781608228; x=1782213028; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LfmaREOcJDzgMsSIFDgR/NYonjDVCQaU2EYRmKb6zjg=;
 b=LeihutxhIzCv/0syDRzenVmHJEWpUNy9jhL/0yqzcpoibBTDPmHrYgXzs5yx2TVPUK
 OTZm8WeqHtcBTm5MRfoiRaokGVURfibCEXDXQzZjRa5XF3InTenyAXw3osaMFISBnIhv
 iGCqXqNtHPRgchTv/Qqd6EHMdK1eekMD0SXnwFZhChMLsQTeVFYL+wMVwTOrpM6qxNPZ
 oZmQh6hdgWkxwDVQTR5lHMaym/w4TkCyK75Wt5Z2jHXrF2aOAGipKIoDfpWjrMxhM04M
 dKpoY+Q7FgDM8iVe43Z7thp7qisnYQVrUw/LZdqE+6VVls/wUatHjQgBKXJ6L7phgPTo
 V8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781608228; x=1782213028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfmaREOcJDzgMsSIFDgR/NYonjDVCQaU2EYRmKb6zjg=;
 b=QuclxoFME4gOMf2QI8IOxg1K9f+cvHux04HiGtMCTinu3Ju5NfaKx1UnJyTdRgOUqB
 yrsP9LmVnYo7BcASK8goYeqo70Ngh0IiIJvWMfeumyAvAND+y8OOusajKJV8VWLW66zu
 bm9OfepqvVsdyanFlPyHG2S783dM/gtRr9Fg1Buy7S2UjAHrA9eO60Vnrfdef9Wejtk3
 rXpumSS5+uxDqysuMQBcw3BSqv8iKu/4aWTzwq5BVfCJPPfElG54uWlV54mjJxQOpgmD
 gez8ZbwMpmgczqGz1ti2eJPRgNc2aIv7bHNj9neZEnUSRJd/EgmRxz/4NGk2LypPkjrq
 5rQA==
X-Gm-Message-State: AOJu0YyxYWspUliVqep1me5PBe4+td0eBRAdvpNInDMP3pI1vCjbl2OD
 n/Ul02FE60k+PLyEGQDcivXbs7yhqHCtU37Ge2a3KnWe4GMUn0Hk93cu9MiLKRQtQjhzjKEsTvX
 YLDeMpFlsY72SiIOaFUy0//X6HJI5+1hxXxHIw/iSzQ==
X-Gm-Gg: Acq92OEjCsrpKYdByxrWawqA3M/3Ivqp9oqQxzVpKq+1LfYRxVy13M5x4zOnLoXaju7
 tF655hm5PnwPTP6WN7HDEKMS9tz38lZHjMTF/BFvaFFHybZbgBw/lJ2gZKpDw7/a6qzkegZc195
 Zl9cNaeJFdf3iGKCvjX5Sv7y9dRV0jhCC8zPd/aaBS2J18VkyGRwVnKKZMYZoBo5LfKppMmORfl
 qiIFM2wxTdUC2dWrVrTvreCqLD76cThV7ShfKlqY1lVBonMUoaE88ToB7X2MHvdKt8gEVyct8Mk
 zF3ogffbps/LCo3een7AMTMnuhFHBS0h7RzU7vxkbwmsNM9PKa/ulYXQZOpsTXK0bew=
X-Received: by 2002:a53:d005:0:b0:660:77f0:2cd3 with SMTP id
 956f58d0204a3-662b616b697mr2165457d50.45.1781608228320; Tue, 16 Jun 2026
 04:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260609024027.22140-1-nicholasrighi@gmail.com>
In-Reply-To: <20260609024027.22140-1-nicholasrighi@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 12:10:16 +0100
X-Gm-Features: AVVi8CdY7HGDqivTxLqhyYJR2iuAaqPLO7GUdLCoYO9DFmsuDmv-dS_kOPlKJLA
Message-ID: <CAFEAcA-YSacshreh4z0Ld7pYdqjECsGxHmkfBrKgQdVPqHVPXg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/bcm2838: Route I2C interrupts to GIC
To: Nicholas Righi <nicholasrighi@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 9 Jun 2026 at 03:40, Nicholas Righi <nicholasrighi@gmail.com> wrote:
>
> The I2C interrupts are only routed to the legacy interrupt controller. This means
> that for modern device trees that use the GIC, the interrupts don't work. This patch
> adds a splitter to route the I2C interrupt to both the legacy interrupt controller and the GIC.
>
> Testing
>
> Add these lines to QEMU invocation
>
> -drive if=none,id=i2c_storage,format=raw,file=eeprom.bin \
> -device at24c-eeprom,bus=i2c-bus.1,address=0x50,drive=i2c_storage,rom-size=4096 \
>
> note: eeprom.bin is all zeros
>
> Before this change, running i2c get to read from EEPROM would result in this
>
> i2cget -y 1 0x50
> Error: Read failed
>
> After this change, running i2c to read from EEPROM results in this
>
> i2cget -y 1 0x50
> 0x00
>
> The eeprom can now also be enabled in the device tree. Before the
> eeprom driver load would fail due to the read failing
>
> ls -l /sys/bus/i2c/devices/i2c-1/1-0050/ | grep -i eeprom
> -rw------- 1 root root 4096 May 17 16:57 eeprom
>
> Signed-off-by: Nicholas Righi <nicholasrighi@gmail.com>
> ---
> Changes v1 -> v2:
>     - Use a splitter to route the OR gated i2c interrupt to both the
>       legacy interrupt controller and the GIC, instead of just replacing
>       the legacy routing with the GIC routing
> ---
>  hw/arm/bcm2835_peripherals.c         | 9 +++++++++
>  hw/arm/bcm2838.c                     | 4 ++++
>  include/hw/arm/bcm2835_peripherals.h | 2 ++
>  include/hw/arm/bcm2838_peripherals.h | 1 +
>  4 files changed, 16 insertions(+)



Applied to target-arm.next, thanks.

-- PMM

