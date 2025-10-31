Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD73CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfKG-0006t9-1b; Thu, 30 Oct 2025 22:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfKB-0006qq-MC
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:57:12 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfK3-0003sE-CQ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:57:11 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so2971381a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761879415; x=1762484215; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLCVyFebGB3VVELRjgo/101ee4yNENm8DxiWhtPTw8U=;
 b=Fmk3c2OJidF7VHEVyx6Nk7mP1EUbuKZyN1qDUcvggWcvbpj+8SbzvQNcZOv/wmEc58
 siT8Oko6Op6Hh6Quc0YSXUcLv2TaLlEVb4WFK+gt5sTGe1m5ddMYLI0trrDrh+CrL6d0
 va0uNM08IlRLs4F4F2l27/eerhgQaJACSmJ4OSiiEOJaIOAs5bnP4r7lqOodLUCARr5I
 DXWDbLP6eE4aMoTZCyWpQTJV4/SRvbsKxwhSq6AA7BXZ1u0+2VxmRwBbBnHLPg3loJfs
 KoBMpEN68on0zCGpCcFjPXwjouR9CUSI3hhyMKY01a6GxGiCI8jugzbY3eQ2cuJ1iVOl
 UiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761879415; x=1762484215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLCVyFebGB3VVELRjgo/101ee4yNENm8DxiWhtPTw8U=;
 b=KJhZexoAG1d7E8k5ERZOXZQCdgFpo4YCdrRdEL8IOqthDzWcN8J/DHcc80NeVJUFAY
 ynVSNxos5+1bAgeuqjXlMUVLZYgg+xT+aoA7b+x3BC5lQIiL1vlurA0dziLq6t7ps9R3
 fbdEtMWgVivIzelPPxH+C1P34wrLA9Zo3L/OKfhsx07cbOKU06CbErkHcnqP2Rs7aSDF
 4/RvRV0aKpRobQamVReS4yrr2ublAu1KR15zZCntXZrAzwpHcqku3ErSepMqvppC+xoI
 CYIFfBMuMI4CmOhXQHPAkyIgikFBepJKIvmT9/8H5os53He6adogERROD5CLgagR1Z0e
 UTIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDP9EgOZywqqKbogPScbEhzsKJrm/ND2Wj7V6HQFs/Sj21Vqsz4jXSz0KitLHn8Z7ZKy85/XukQeEL@nongnu.org
X-Gm-Message-State: AOJu0Yy5xtxFQOEyq+RylUZRhO6xqmxm1XHZRSsmMqZrzr19stdEnwsB
 o+wWjaS6mLPC/Fr1Hp/L28Uby0bMDXf7in4BJhfdDRhmxD3+oqgxL/H+Wjb5etOkwN2pjRwAey/
 6SJDKELHTH8LCx1B72DhSZu0nG7HwPVY=
X-Gm-Gg: ASbGncvW7mFo+9kkUfpIsM754vMtn2lW8IvRe8L3pgLo2iQShoUqZE8R9cZKirZ8xJt
 kHKX07zZewE7DkVAM7tl/+wAAhSZAcwFcXIq/dyEuAUd4k/FtpVh5kqC087A4OGv3SnoL/x5g5Z
 YyKwKYy6UwfNZljYB5s/3/xOI8LSAIHKxc+/grNL1HAuYRKAp7g++T18khBXFhcPrbh66k7Pm0s
 jlWOa6ZnQ+Frxwifd5rUfCT7VAnEmruuOGVYz8yVh/HSXc9cteSpOjvdkUBQwUEOgGryL3eQSzu
 0K+sbY25yVFw4tk=
X-Google-Smtp-Source: AGHT+IFKhLGoYqQfu0E23jjsz0Kx17Ekitl6Ao53u1kk4PrTxvrrgEF1+6v+KvDpLXgDaI7vATcFngk9axZZy3FbD1I=
X-Received: by 2002:a05:6402:2714:b0:640:7402:477b with SMTP id
 4fb4d7f45d1cf-64077024adbmr1534092a12.26.1761879415059; Thu, 30 Oct 2025
 19:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
 <38528707-3d28-4be8-8b58-60269cb1db1b@roeck-us.net>
 <788527663.312.1759727663914.JavaMail.zimbra@embedded-brains.de>
 <67097d9c-ec3c-420c-b5b3-e2f3595a0612@roeck-us.net>
In-Reply-To: <67097d9c-ec3c-420c-b5b3-e2f3595a0612@roeck-us.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 12:56:28 +1000
X-Gm-Features: AWmQ_bnIRC7weJDQY4HzQtkxDehE7QhEdMzxAQZug_kN4eI6g5zaWaXC8LJxARY
Message-ID: <CAKmqyKNkJiK_8UkJ6AqvmCbtkj=amzJvrV1CUx2EXCdUvD_jCw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] hw/riscv: Make FDT optional for MPFS
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Huber <sebastian.huber@embedded-brains.de>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 7, 2025 at 6:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 10/5/25 22:14, Sebastian Huber wrote:
> > Hello Guenter,
> >
> > thanks for the report. Do you have a Linux image and a Qemu command lin=
e so that I can test this?
> >
> See http://server.roeck-us.net/qemu/riscv64/
>
> run.sh executed with qemu 10.1 or later should trigger the problem
> (the command line is not passed to the kernel).

Any updates here?

Alistair

>
> Guenter
>
>

