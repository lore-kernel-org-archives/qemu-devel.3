Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322FBEB106E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzysz-0006qQ-I6; Tue, 10 Mar 2026 11:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzysp-0006go-4q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:20:34 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzysj-0002N7-HQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:20:30 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad79df972so12687385d50.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773156020; cv=none;
 d=google.com; s=arc-20240605;
 b=fS/GdMG8nTMcup5+lq/JE50IrwBxYUWX2NryDcezdAkWta4Ba6lxdtYnTFJDb9f2Lo
 rj3hj37JW3HJOT5OC9nM0cs+BhjWOyGHMTFtTqFUSFDYoKLNYGHClBFY2kYh9gCjCiOf
 dElkQYK14uu1CbDl4XjSSY1V0yM0F0Ls7dXfNXi4w7q1lJNYoV3psZAYGW150jmEkePV
 5+yuDXOrnwR46TrBQxbROTKVdimgoS5W/qxSxMlJS7V1ZHXShO3/asxjEp+i3ie4XP3b
 u7P/gb4a03sNgqEQuyEzn196nqesiTs/DoNeJqyDC3GuLttjTLeb61Cc88s50Stq20Iq
 vddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jQyJcOZii5l8HMoqLCRx4Y2nQjDAIPcB39NMRnZu0Ag=;
 fh=1ZVhscQauNpVmzHXAxT+Avp6dsB07oJoHXEZ76kUnss=;
 b=VJ9xG5dH5jfzMVejLP203U5nuP5X7OWfqmIKUgiLuAXXAXosIBf37D6GVr76V0eExD
 8mca5WBGRacSQJI+lRa15lGDFNp5aMaE+XgVwODgk+MYdmpOtAOfJGFlgARRk6n8Ylfj
 g7DKxVTBTLxqkTgZCWHoYXPJXVCFoEofIwYLjX4D7xcuMO88jL4pxy7pi5gRAgFxBY93
 yFQrpsS0W+Ivt57N3oRJz1RoKkKBZEXfaX9SnQXhE80K7oIMw9IIAihriDduGST5A4hv
 bgN5qq1Qp0gJuIRxE81y66Qe5tszXRWgt/XfCpfj1jtncxix/gpm3WR69BcmmLyBkkZp
 +80A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773156020; x=1773760820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQyJcOZii5l8HMoqLCRx4Y2nQjDAIPcB39NMRnZu0Ag=;
 b=h9922JjF476O7dCTFt2flAYCJyNlnOeWm50TG0aFupekhqYm4UrW3X7RPIDEPAqSwR
 1PFfxi4K4+3BUhNAgAYQ1mUfskB5t8Bk2xG7+36QFaaLiUU2A0iZ7pqzTX7TWwMbCWs/
 w0Z6JqhL4HXWf7oIVtFXSZCPcOyQdf1995VsIsJ/fiNryAG6m3VgVRAg9POi0dhaXoKX
 yp/YOjMBxJXePXl6PAsRswvpa2pF5tqMmuFakbGq7PkKVGa1Ni72CtjiiAYuchcA4+Em
 891Ie/OqWQFxorOO3bzwTi8hXuv/C1tKdhEf3Zyy5cC4nZvLuiPiD8CMGOV2nzNdltzL
 xZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156020; x=1773760820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jQyJcOZii5l8HMoqLCRx4Y2nQjDAIPcB39NMRnZu0Ag=;
 b=kGRjrg7GZ7P+MlTKUh0svBVP+oJOIAk42xSBPTUBQyPV+3CsYF5MOJiQEkNgEhqQKs
 /ro0QdKpgBZd7U8yA7rk2TBZIPWIBEPh5mGJ3pd43pgtlGSnVJssF5hCKfUbBEV6BeJ1
 Qt7B3cbuYla30PJ+rtCxgT9k+QDSNnpL/PzPUjjLwD4LYb/h46buuhY2CF4X5sSCU8fP
 t9feCeGVZpmgbb5gIA8/bgo0OWJF8T5GeNXQILBMSJTeipM7GGpr5qNCqT9kmq62VkPv
 7rhTgdg3TyqvVJrjZ5L5ADM2lu0az1dxc5prRSksuT/LjBjjiqvl4qo+tUoze89qoVxp
 m3qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZSBwLr7x+IG/kez78KkHGmKccNgBp6heRxyGuFI6ZMlBrOgvMnMBGog7g4Xf1rIFi8Dl14Ac7ZhCg@nongnu.org
X-Gm-Message-State: AOJu0YxU4DHKH7PoQ9/6cw+ZffGurkcQP/089PJMn2L1M9OZIkrdJbiG
 bs49wuA/4BmaKi2FhrQkOjwJV0eFd4pIdHkIUYH7dL0iCe90eczvDExJcf5dnldf4lRdaga1zgT
 d7Yz2hGf3nztJ2RpJwDxAMAYQbhIlOyoCCwArMjp55Q==
X-Gm-Gg: ATEYQzzWwIQ6m0fLdCg0D96u1ReH1S/dOCMeGzn2QzuX0JZ+RaqUdzMgTl/H4UvM7g8
 Xihh2GJax0kp18RryT7BMkT5RSvddhD8e3cQfGCxSXNDMZqhXfqFham45nNfBZwQwRVlK2T8M5n
 eYJKrZCJI0/+4QqfBuldD++QxwI5iKTM9sEa1wrsStRqHP4j37vr67ARhg5R/mF16SIrw4IYDtb
 PveDWPeWpmf09gBcKU7ZIK6So4+xl4AwspdSaQRHVgRY7yAnAqKzC4UAeY0LYu3LvtvZpDjlulA
 F0g+7+8PPBbyIpSDQdw+2KoxEcRr50eNWyb7/iyYmVsE4iq66b67RRy+35M/9coi/aI=
X-Received: by 2002:a05:690e:6c6:b0:649:d59f:dccc with SMTP id
 956f58d0204a3-64d141285b8mr10588598d50.25.1773156020550; Tue, 10 Mar 2026
 08:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org>
 <87h5qn23v5.fsf@suse.de> <293fd9cc-5adb-4e14-8f92-37157888ca11@linaro.org>
In-Reply-To: <293fd9cc-5adb-4e14-8f92-37157888ca11@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 15:20:09 +0000
X-Gm-Features: AaiRm53jG-G2BDxVCVDWiqLBnUOe3FaXBp_vdSw48kEMQ1tysTb3U8S5ewNW5PE
Message-ID: <CAFEAcA-YDkp02wvKft6F-Y5xAm7nLySR34zL14q_Co6+xC3ovQ@mail.gmail.com>
Subject: Re: [PULL 27/49] meson: Add -Wformat-overflow=2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Yubin Zou <yubinz@google.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 10 Mar 2026 at 14:38, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Cc'ing more developers.
>
> On 10/3/26 14:47, Fabiano Rosas wrote:
> > ../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_output_p=
ins=E2=80=99:
> > ../tests/qtest/ast2700-sgpio-test.c:27:33: error: =E2=80=98sprintf=E2=
=80=99 may write a
> > terminating nul past the end of the destination
> > [-Werror=3Dformat-overflow=3D]
> >
> > ../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_irq_leve=
l_high=E2=80=99:
> > ../tests/qtest/ast2700-sgpio-test.c:85:33: error: =E2=80=98sprintf=E2=
=80=99 may write a
> > terminating nul past the end of the destination
> > [-Werror=3Dformat-overflow=3D]
> >
> > ../tests/qtest/arm-cpu-features.c: In function =E2=80=98test_query_cpu_=
model_expansion_kvm=E2=80=99:
> > ../tests/qtest/arm-cpu-features.c:578:35: error: =E2=80=98%u=E2=80=99 d=
irective writing
> > between 1 and 10 bytes into a region of size 5
> > [-Werror=3Dformat-overflow=3D]

I don't have this specific GCC version, but this series I just
sent should fix at least these three:

https://lore.kernel.org/qemu-devel/20260310151507.2973843-1-peter.maydell@l=
inaro.org/

-- PMM

