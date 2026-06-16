Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918B5CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZWYP-0004WL-4y; Tue, 16 Jun 2026 12:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZWYN-0004W6-Mi
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:22:19 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZWYM-0003bR-31
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:22:19 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66061993121so4903021d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 09:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626936; cv=none;
 d=google.com; s=arc-20240605;
 b=THo96ZNzt5XsaXvuLiER6gL1ZWx4LVEnY4ZtGle64YELjic1GrHZpIvkIlormlpd4T
 NZmgruBrkI5XMoLoLMQ7duQX9N1xC67vYd7U86rlH6xWTPW+oKOJVeHm4OGgg00vxDo6
 NZ64v1QwYnAY5Z7+sx9YTcUDOOeKv1RVcQ41Zil65EF6/tIE3PYc3HXtrKRNKONil+Bo
 PBfJEjF2vz6JBJEoihjA6yX6F0sqkJzjaTGlTrAnwCsW3WnTmpY5LxwRPb+usYWEQNll
 MRyAdtg4Ca/RNo9er5gCIfboacSkeTlctFl9qzItnTzZGptYnK+Mz1YRmmR3ypAqubz9
 3lNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FIjdOTaegoMEB2kcxyFLs68eeTm4sJ1pchbOHvbEd04=;
 fh=XkDcxgI35ocrFMcNShv78moWJRjgxn1fBL8CPzXhL5I=;
 b=VOvAK1Pd/QoD1fSqf6U5Bk7tDin1faP13ksKo4g1g7xSH8Ba3ewjePOS72rUJZ7xxI
 gC6tRk/uDToWc5m4dGj1zRq4LyqIxgWX1nCs8bZixXHlCGTPQIkEBtgrjR+bWRVNlBRT
 wh+kQOc4DJLYJ/Mit0WLHgY0N/ve8Nq2acsMe+M12gBMtw1hUKADNq+8zjL4OfJoVat1
 vJ0/0U1UAVGuWW8ZqVNq9NlyT9xK+5bbfoh4Nii99XgtI0lu+CJGHJnKgSPQ0RBiblok
 Md62IzpiyNf/9QF50YZ+ETtKWZRS9FEFdjKUsr3rSCp+5FgZkNOkqwPXOG3dbdvQVuO6
 qjDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781626936; x=1782231736; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIjdOTaegoMEB2kcxyFLs68eeTm4sJ1pchbOHvbEd04=;
 b=Oo5VP5UsURVV6CZgs83mB+xZ0UE6NjUll52fJ6X1yrHE7JgxaePR4Y9Ni7GWtriBLs
 7wVEkZcJ0+PSsyS/kKZX2CYhHGYVUVQSDbbUp0LNpO+vARez9nSIh0DUV44Qvcp35EXj
 0LbjO0HQ+UDv7PNRt+fQLBu+JjHXuP1O07/7Yg6EbyHVhuvfiuEVkHvKSxHG02Yr06UD
 f3VICDi9SqGL+EckwfWUz+qv6WcLQFditZ6nuLSM1uu/XCOIgwSyZDum2QDpXl8+wsD9
 iPv9wX80FuEAwR9JAes90mM28LQEgeJt8Y0qjjCtdEKsaLnb2zLDwsblPqRyIkXqW1QQ
 98Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781626936; x=1782231736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FIjdOTaegoMEB2kcxyFLs68eeTm4sJ1pchbOHvbEd04=;
 b=C21tL4c9LOfi0BPjbJRO/xpiq0JANdPviIccb3XKy6oumy9X8le0SVyOaWrFruyIuJ
 GTUyDbgvuUVMVEf47yLJJzDuHus4Eq17ObRPI1UX4SSZujOVYdOfZlYI60011KtI9CfG
 XViFw4XMADjO+dfDPOD63ChOa3IED2xaBrFnndES++l6NqyCwtd35pSbC6HveGPm3izk
 h3hsETggPzSLa+FIoD8gfh8qxnGFvfL4by+TzRaTjGqPGDyThxHtu3htC1qs7NzPcr3b
 Je7qS7iUbMCuMrAfUb1eoV4b9vjlJiDcOvy4kivPTDfLbfICFhzreD4zLe351VngoVhq
 AXKg==
X-Gm-Message-State: AOJu0YyqeVxJtivi8cWp8SSyiOFt6IJtqUa6kCpZXClR1qckGgerk6TW
 1yfTmxKNnHj91bH4Ewjx8fIL75icPViUw+mXY10ArOh2yFF+pOETtzSZpnvAf3BI97lQ9mYjhfq
 8OYvl0uEBbQmCb7Hs840qPRqnaf3GrDUdhUwqmqYr8g==
X-Gm-Gg: AfdE7ckKFs7gxH06h+9++yFJaEFWDClGQgnNP4W49c0qDKucbyyoW0b2Ud/MtZPH6m9
 uNGjsajGn+VGiMJrPQHp1OcmRf6TcVVKAOqP4pTYPPgZ/8y17rV559JIqr3PyOIoWfVHsl6DYTL
 kDaAPyDYMWScfm9NmuRALOTMwTt1xVtYGFgqGEQLlIa2x1VqC4jjHXfCFxyi6/p3Yr6xQboBLdG
 caHovxxbkK55Etg2U+E5h78ij4HvwWmETnm2UlYvumv/V+XXR6B/+s+JD8CppqnqQTjlVD9WWHw
 WQtlPk7uzMJ8ez3Cma6GQX1sCgRgJRcAOBQJE5KMs2XqwdcQQUo1cP7oUri6rHMNVNo=
X-Received: by 2002:a05:690e:43d7:b0:661:4f99:5830 with SMTP id
 956f58d0204a3-662cb862b1fmr46620d50.3.1781626936558; Tue, 16 Jun 2026
 09:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-6-berrange@redhat.com>
In-Reply-To: <20260616155554.264412-6-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 17:22:05 +0100
X-Gm-Features: AVVi8CfMmQh_AZbelZn8iDbhPKu9JfVx8jJTe1w2CkBa2UWoccXmvw-rLGo1zcY
Message-ID: <CAFEAcA9QUMgAz894D-jEx-Q8=Esi8fnhivAyKtekqHukEcuibQ@mail.gmail.com>
Subject: Re: [RFC 5/7] system: add qemu_irq_new / qemu_irq_new_child /
 qemu_irq_new_array
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 16 Jun 2026 at 16:57, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Prepare for the move to dynamically allocated IRQ objects by
> introducing qemu_irq_new / qemu_irq_new_child / qemu_irq_new_array
> functions which call through to object_new instead of object_initialize.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/core/irq.c         | 35 ++++++++++++++++++++
>  include/hw/core/irq.h | 75 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 106 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index 106805e241..e943c87b81 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -49,6 +49,13 @@ void qemu_init_irq(IRQState *irq, qemu_irq_handler han=
dler, void *opaque,
>      init_irq_fields(irq, handler, opaque, n);
>  }
>
> +IRQState *qemu_irq_new(qemu_irq_handler handler, void *opaque, int n)
> +{
> +    IRQState *irq =3D IRQ(object_new(TYPE_IRQ));
> +    init_irq_fields(irq, handler, opaque, n);
> +    return irq;
> +}

Isn't this the same as the existing qemu_allocate_irq() ?

(I have over the past few years occasionally been trying to get rid
of existing uses of qemu_allocate_irq() and its cousin
qemu_allocate_irqs(), because they are persistent sources of memory
leaks. The function returns a pointer that the caller has to deal
with and remember to free, whereas using e.g. qdev_init_gpio_*()
makes the new irq objects children of the device they belong to,
so they're automatically freed when the device is destroyed.
qemu_init_irq_child() similarly.)

-- PMM

