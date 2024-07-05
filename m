Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB85EC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 17:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPmQo-0005sd-S4; Fri, 05 Jul 2024 13:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPmQn-0005sC-8f
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 13:09:09 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPmQl-0006gd-G9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 13:09:09 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38028so2465650a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720199343; x=1720804143; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8XwHrnmX2/76QaJ4ERsHEHiXnf9ZiKxXKmCkXATcrI=;
 b=LPYwyy42c/kEo8s2jW+ilD25O7MQdCaOxAKLCfxUB3CUu/q01Rqw3JyTR0P8SIdfcu
 BlHCq9YBLrBfDxjd2rsk+K+xK8E0t8BMc2PSE++WRR6iZgO6Cloz3vE1CEPpxDulzjQD
 wUAASaekqaf+z5Omn9K7RtKNFf78qFWfK7plDd1nRyb2I27zL5XHK1xp3ojlvIzWfFIV
 kDKhfCXxKDANa5g9hplIhFVnfYTq1psMHwRjmaSHQDs2FA5R+iTwmms91zNyda+Q4SzU
 czYdy0p3nPieqclvWCTMWrkGtdsAYavvFmVkPZw+s8Q41GSEP8qArJVFUIcCuDnps5Y0
 VaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720199343; x=1720804143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8XwHrnmX2/76QaJ4ERsHEHiXnf9ZiKxXKmCkXATcrI=;
 b=GpTZF/7/30h5ZWMdEFKgyqxRE6NNPls9iDRJY5PJtBDRpr380tlEFkUJrL5wojNfa/
 b0vfvdfg7XgBwpPvtH8sPYhg25ob7wRpZbmHTF7GzSY0RUSnEzNBZOyVswL4J8DecyTK
 1wvCOQ3et0ckCHC1jtCmlHYkMjAwUbVjFrEbvwQnU5hdVc0JPS8SaYvMsRnFOv5FEcrz
 CBvgOOOYjdFSSyhV/EZ7yoBi2kD4qXb0Y+cQ6gH7HAppfkDu+y2PoNK3Iaq7wU1GFiqt
 WF40qUmKEGq8d3AUYaBljGtaIPjyB3Fq7ib3VJ4GpVP3q823Xw6GBpV1aMoJoajTCTY8
 KBYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo7ZeUil0pk2TTmEkmiMdrsnpiFF/ZcAxSwPvN2E79MAjglI8LaZ3S9aBKOBA4h/N8YqHgx4k/s44VKyag383/mmq8gxo=
X-Gm-Message-State: AOJu0YyRNSB0J43mCZqCNpDo7bceKEoquyzfrc/E7+pd/GTbkm88+G8E
 jS0fBjBsvVjRie5fBfk+f0Peu8aCZ9K7VvBcjvLgnrGB8WsROttr7J2XO7X6ii8bXmKYXUmTwY7
 2plDHlkRZTPClPFXaGYXzYUi280EWjrmrdnsmgA==
X-Google-Smtp-Source: AGHT+IGKdzO416owUrpAWTyoEEkvRISO7l+VLL80akCuIivEim5TVeQu5cqjm6V8neHu3yBkIXY2+K1RZjZgaQiTI8Y=
X-Received: by 2002:a05:6402:274c:b0:57c:6d9a:9149 with SMTP id
 4fb4d7f45d1cf-58e5adce5efmr3266250a12.15.1720199342889; Fri, 05 Jul 2024
 10:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
 <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
 <f6976b40-e3d5-4157-8597-ce7db6ceb068@linaro.org>
 <CAFEAcA-BD1TmaBB_5ephnRoNsOCWsS4w3C_oj0P_182+fOLPUQ@mail.gmail.com>
 <C27AC9E0-AB61-483E-BF07-B435AABE3D13@gmail.com>
 <b871bf81-ed1a-4720-ae70-9dbc517f155e@linaro.org>
 <5E575AFE-7E8F-4CEA-999E-30D9881104A8@gmail.com>
 <FC32203C-AD71-4032-9219-9CACB8AB36FE@gmail.com>
In-Reply-To: <FC32203C-AD71-4032-9219-9CACB8AB36FE@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2024 18:08:51 +0100
Message-ID: <CAFEAcA-fO8snCF-kQ4YpQ1=5HuATV4yO9wk5Od7gxuOFA8Hd-A@mail.gmail.com>
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Bernhard Beschow <shentey@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 5 Jul 2024 at 12:46, Bernhard Beschow <shentey@gmail.com> wrote:
> Am 27. Mai 2024 17:49:26 UTC schrieb Bernhard Beschow <shentey@gmail.com>=
:
> >Am 27. Mai 2024 16:20:44 UTC schrieb Richard Henderson <richard.henderso=
n@linaro.org>:
> >>On 5/27/24 08:29, Bernhard Beschow wrote:
> >>> I think the kernel's output indicates that the MMU is active:
> >>>
> >>>    [7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f
> >>>
> >>> AFAIU, the value in brackets is a virtual address while the pte's are=
 physical ones. Furthermore, the `info mtree` QMP command tells that the ph=
ysical addresses are RAM addresses:
> >>>
> >>>    0000000010000000-000000002fffffff (prio 0, ram): sabrelite.ram
> >>>
> >>> So I think we can conclude this to be "normal memory" to speak in ARM=
 terms.
> >>
> >>Normal and Device are attributes on the page table entry.
> >>See section G5.7 Memory region attributes in the Arm ARM.
> >>
> >>But it's unlikely that the Linux kernel has messed this up, even back i=
n 4.x days.
> >>
> >>If you want to make any progress, you'll have to share a test case.
> >
> >It's a proprietary guest, so I need to strip it down first. This may tak=
e some time. Thanks for yor feedbak so far!
>
> I finally had some time to look deeper into it. While this patch triggere=
d alignment issues, it is not the culprit. The culprit is that the sabrelit=
e board sets arm_boot_info::secure_boot =3D true which causes the Linux ker=
nel to run in EL3 mode where hardware alignment fixing is apparently not pe=
rformed. Setting it to false fixes all problems and the guest boots just fi=
ne.
>
> Question: Does it make sense to ignore the secure_boot flag on direct ker=
nel boot? If not, what do you suggest?

The secure_boot flag specifically means "when direct booting
a kernel, do it in Secure SVC, not NonSecure Hyp or NonSecure SVC";
it has no effect on the boot of bios/baremetal images.

It's only supposed to be set on the (very few) boards where that's
how kernels are booted, and kernels that boot on those boards are
supposed to be able to handle being booted that way...

thanks
-- PMM

