Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8F0D7495A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 04:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5zz1-0008ID-VU; Wed, 30 Oct 2024 00:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5zys-0008Hm-ID
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 00:06:54 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5zyr-0006uH-4z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 00:06:50 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4a46d662fccso2061026137.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 21:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730261207; x=1730866007; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKNag8kvCVAwcSFrD5wZs2oqPhzGbSq/NfVP+BmorYo=;
 b=Y9q4Q4edydFw1maHSnFlJspRr+j4phKkUKxxsKhzq3mLscMNPwXJbDHrYoy8q9oxNy
 IE5Bx2cGS1HIXnKhNyWWtqk2Y9OZ1/5aXSZIfuU/QSF91sbPwqwgfTwZWGBk+ioml3LC
 3TmJmJn/7A9fmVNgwPirDbkvelmPxz/cfZR7rUHJHqiSRg2v9Kf7aopQqhQKzlDQUHqJ
 n/9KdUji1t0Pv7tKkQjIqoygsuthSZKRbez7oTledPxRMk9orc697UgQ2OeGGJd8WgBi
 S48JIugXpcaHabl06F5YcEtlogork/3uaBA4srQqQ8+ESHys3TJH6TbCeZ1Le3BSL+dA
 S4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730261207; x=1730866007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKNag8kvCVAwcSFrD5wZs2oqPhzGbSq/NfVP+BmorYo=;
 b=Lya8IyfIszIKNf2fRnVPf6n06qTiJgFWwwX4QQYgarhRu3MUMKqtOudz0z/L7Ww0xA
 xLPfqc4oGTr9PQFDdJ0OlM3TddMMiT7ebXV9b7XFRJEQY5jEnb70eJYoimPuCL4fjyCm
 6j/W1aRLixuXb381MqqDvT4i3sg9eTphpFZFyR7brmwUNzTtukmGp70iPgssDw+HLYrj
 EgucTuiWKQ+IHlFQ9WQY7KUzl5x2y72HsiDRJ0/vmItoBlcHH2FySn99y35Es0s6KjE6
 NGfnqufMch0VEVbIN4XO9I2J0c2lfGT/CHbJlWfpsOgTlWkOyqmLkGBF39eNpMl9m1cT
 g2Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3b0uO6vqznkpaDyGNWGHJl8agAYR9HNBjSi0/MSYKtZBG9VNRzO3MJhUCOKbxEPNsL86YV9KFtPjl@nongnu.org
X-Gm-Message-State: AOJu0YzxHGZds1dcAXs7vbQvAhbq9FZHJp8HeXMZonCx6uL0HPODiiOY
 zflchcoHOCsI+wjtw+g3HDerLp1qcsBeMsA/wMpco+19zoLYxpB7dLEGSjWRuvPXPwZ/Mp7Rrz9
 ldenfy7bDIUKaIohpklNJN/BdxnY=
X-Google-Smtp-Source: AGHT+IESIki4URh1tyrqlvYWsOUWqoV4EL82z199gSIWFBO1H1UgDaGfZbX3YEhkyuQt2a4QEK1i1joSDZTDG4XeHF0=
X-Received: by 2002:a05:6102:418a:b0:4a4:8d6d:a37d with SMTP id
 ada2fe7eead31-4a8cfd888a5mr14038027137.28.1730261207295; Tue, 29 Oct 2024
 21:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241028023809.1554405-1-maobibo@loongson.cn>
 <20241028023809.1554405-2-maobibo@loongson.cn>
 <b5f4a39a-278a-1918-29f2-b9da197ce055@loongson.cn>
 <08fa5950-8ca4-b6fc-fac7-77bc5c16893a@loongson.cn>
 <8b7dfe0f-f4cd-d61a-c850-d92b5aec39e8@loongson.cn>
In-Reply-To: <8b7dfe0f-f4cd-d61a-c850-d92b5aec39e8@loongson.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2024 14:06:21 +1000
Message-ID: <CAKmqyKOGcjOFqUMiySYxtCyx-5_Rbx3=w9BYeUuS8mSrQ0bhxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] linux-headers: Add unistd_64.h
To: gaosong <gaosong@loongson.cn>
Cc: maobibo <maobibo@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Oct 30, 2024 at 11:47=E2=80=AFAM gaosong <gaosong@loongson.cn> wrot=
e:
>
> =E5=9C=A8 2024/10/28 =E4=B8=8B=E5=8D=885:55, maobibo =E5=86=99=E9=81=93:
> >
> >
> > On 2024/10/28 =E4=B8=8B=E5=8D=883:39, gaosong wrote:
> >> =E5=9C=A8 2024/10/28 =E4=B8=8A=E5=8D=8810:38, Bibo Mao =E5=86=99=E9=81=
=93:
> >>> since 6.11, unistd.h includes header file unistd_64.h directly on
> >>> some platforms, here add unistd_64.h on these platforms. Affected
> >>> platforms are ARM64, LoongArch64 and Riscv. Otherwise there will
> >>> be compiling error such as:
> >>>
> >>> linux-headers/asm/unistd.h:3:10: fatal error: asm/unistd_64.h: No
> >>> such file or directory
> >>>   #include <asm/unistd_64.h>
> >> Hi,  Bibo
> >>
> >> Could you help tested this patch on ARM machine? I don't have an ARM
> >> machine.
> > yeap, I test on arm64 machine, it passes to compile with header files
> > updated. However there is no riscv machine by hand.
> >
> Thank you,
>
> @Peter and  @Alistair Francis Could you help tested this patch on RISCV
> machine?

I don't have a RISC-V machine either unfortunately.

You can test it with QEMU though

Alistair

