Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C05CA0EED
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 23:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqJhH-0006xB-1y; Sun, 24 Aug 2025 19:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1uqJhF-0006wo-P5; Sun, 24 Aug 2025 19:00:21 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1uqJhE-0004r7-6o; Sun, 24 Aug 2025 19:00:21 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so525611266b.3; 
 Sun, 24 Aug 2025 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756076418; x=1756681218; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zh2mOIzTyGmYIWY2saj6vgpTnQnQqNJ5gaTXcaHYWW8=;
 b=BtYj1oPR1FfaF37B6TKhF6gWxFtDLPAl610LA2MPMog1Dy+LKd/KNYpPlOm0ueXpx2
 DCVsPESQEXKyxZt/o2mQRizdNtGMc+XNRZDBgjx+IDmo76T/VQtFIHhvzkHz5aVz1S0C
 QMB3G99e2Uati23F+CGzvfEa6wyzZn31syyXlyUeaM3ZQPnHjyUyt7A6EkKo9v4UON5i
 P8+q6IPVDpdviiG0sXAywVIsd40PhxryDIUFVPdv1tpZfOEo5RKkUcL9+2WDDphGvWWb
 MxtPXVvpLB2K3pzRVe1b61EjdsC8CwKi64JkLaMYD7RiNzDwNTkWPXXzdHnkzcVCbAB5
 E5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756076418; x=1756681218;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zh2mOIzTyGmYIWY2saj6vgpTnQnQqNJ5gaTXcaHYWW8=;
 b=YK8o1lGumfvTqL+2jVDRLmUt4zDScMgsAJzg5i9F/K0BXop8SSpeIalobuESfUH/qX
 UZpjZZLWPFsNKwb2INQkOGGm7FRRg7GNYeaWFb8iKfrgz1HnsU8yuL/9Gwmw6liXABTx
 VjZaAbq6fBZPWEvI/JR1du5EKQOQ3Pv/4xttqzuIhL1br8ea7OBv4fAUlQ6WchT3S5ve
 B2ajhLK3IvwPt7SFd8Hr5QqnWkCJOJNGhcTVuMzWuPFrUgarJcHiVscv2U7OatAcs5ie
 UzawkYkKpQC+IZHywz2EXrfAuvvWj8C1JcKtXXEUcfz86fG6PhuPll/UEXV4kb1PhQGz
 xQMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Fx0O4BUjl1A4GoO5Qbc+B0zYnuRcxLYwQR6tJR9atShPb5prBvIkmsTvT/T07+DwW9V+TPzc1A==@nongnu.org
X-Gm-Message-State: AOJu0Ywpu+EIfFZYIWmqfz1Sf4HDOSTgB2ra6LY9NVFobfnS5BKzJSwn
 OS+/xb0r/8VeMJiwo3T81ZqZRrt+NKP92JRMrdho4tLiHi4JUjKcoJEu
X-Gm-Gg: ASbGncvOOgRRcufV6vS4CN4keNsc6SXkFCOmifzGGq0Cpwu8nsXO2VK9i5TToe1eHhe
 6bp4Seu1/dZu4irwlVSK0wP94WCjWsxcwlfgn4boTURUKd0gceXaJedXtNUglz7QZlpk8TzhRl/
 gPvfpwec+uc273TC3ejU8ghotJqKjWuVm2tOSPk3en8DXM6rBTKySH1X9q53wWgHQTYJKKjX9En
 Y+RC5Fwa7a/ozz81tyb8ar/sn/Yl9GrgN18HE50nQaRSK9eDbfNJSKRfIIXaLgT8kXCz8vb4z51
 dC77YqZ+KEpoen8BJH5JIewv32i+wUBpLDBSU8LBgHvGrgSvOMg+eM2evvBKtPW1lqCH+wyZcVr
 w18zcnrIFOt5i5wTtSPPOXvtTjkMkinVtiHO8HtonMw==
X-Google-Smtp-Source: AGHT+IHROHEhzLgp6MCVDN/eWH06s6wsbVBT+GG8PIq5HjI7sdpYODNPea//DqSkf/SM8buFFqAvzw==
X-Received: by 2002:a17:906:478f:b0:ae3:5e70:32fb with SMTP id
 a640c23a62f3a-afe28ec36ebmr1045880966b.4.1756076417691; 
 Sun, 24 Aug 2025 16:00:17 -0700 (PDT)
Received: from smtpclient.apple ([87.251.30.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afe598a3fafsm373917766b.37.2025.08.24.16.00.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Aug 2025 16:00:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 0/3] hw: acpi: add UART clock freq to AArch64 SPCR
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
In-Reply-To: <CAFEAcA-NwTDQUJAerkX2O88_3Mgprh3A7GqaEAFdM4mpN3s05Q@mail.gmail.com>
Date: Mon, 25 Aug 2025 02:00:05 +0300
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B0D958D-67D8-4036-A6BD-75CBD7DC636C@gmail.com>
References: <20250809211051.68824-1-chichikalyuk@gmail.com>
 <CAFEAcA-NwTDQUJAerkX2O88_3Mgprh3A7GqaEAFdM4mpN3s05Q@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=chichikalyuk@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


> On 18 Aug 2025, at 18:26, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> So, what's the rationale here? QEMU's UART doesn't care about
> clocks at all. We provide a clock in the DTB because the kernel
> refuses to boot if you don't, but if the ACPI spec didn't even
> have a way to pass the clock frequency until rev 4 this obviously
> isn't a problem on that side.

The rationale is the same =E2=80=93 just as the (Linux?) kernel expects=20=

a clock frequency if a UART is present in the DTB, guests using=20
ACPI may expect a valid value for the clock frequency in the
SPCR record when one is present.

Since we already have to have a notional value in the DTB, it
makes sense to expose the same value via ACPI, too, for=20
consistency. The RISC-V virt machine, for example, has it both
in its DTB and ACPI DSDT.

I=E2=80=99ll fix the other patches per your comments if you think this
is worth adding.

Thanks,
Vadim


