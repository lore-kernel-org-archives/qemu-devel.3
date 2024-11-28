Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E24D6D24F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 00:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGSf4-00018O-T6; Wed, 27 Nov 2024 19:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGSf0-000183-DL; Wed, 27 Nov 2024 19:45:34 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGSey-0001pc-Pw; Wed, 27 Nov 2024 19:45:33 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5152e0a0ff5so87026e0c.3; 
 Wed, 27 Nov 2024 16:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732754731; x=1733359531; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fmqx3N2eXfYD+6YsH2tstNi1474OxtmQp5RTFijq1x4=;
 b=VrB7wY1S4hrKjukzFlWDdBH8uxKyitzQiaFmHnuf3fX4hciPnoe2laEJVT7POOSkdZ
 SYB/5yIM6mjk3zgT09rTIDJNfa04RrAa/6M/KEgY1qHPXHaWCnbLhV+Q/tv/GkbOc+Lh
 74g4/jaS/N7mKJFjYfHkkNft6CvdK4nQ+Wc8TK07Z/Mr3/FxYTlo3VAvPl+uBbCzjDXk
 0XX1BRa0LVuFwImzMEPazqOCyPoZ4W8j6deGlyvf7yn2468FX1o7c9Uj0mBpcSokHIyF
 7p3xHMztrzDadojxP4MgmDALFJRnhHP/jD21WsJfa+mceYzTxLRIVQn5DCIAA1vJ+1Ny
 Rx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732754731; x=1733359531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fmqx3N2eXfYD+6YsH2tstNi1474OxtmQp5RTFijq1x4=;
 b=UbTantFa8AM8GupxQVM/mF2wPTaDCVMYGwq8a99iNXXS1ZU3Nh5iL0b3SaUVNQkGom
 J/wj7ebuDoQ3kM2t1q1iPGAPTaAx06LfnRxdSzpxvVFrH+GvSnAGScc/VmvDUwv/4kZ1
 Z2V73a8QVnNkprSBnKFpufVmE/FcuHPv+hL0gawq0XNbaNivV9E9ktFJXerTLWuMfcfS
 +iN6Enb75Ti8rcXDExaOUY28BYvqjulrOGoCsG/oJDQvIUDUzK8Th9hcKasteTcIBe55
 F8cfDb0sZbm190bp6o2Jb4Dh9eGm5kP7Vnxnkgtd7NJ/DRPnFgRB/oKr7X2fkiz9RMhM
 eVOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSv33JG8cJ+TFRL6N5s81HhldV3tqpdGIyioKqQyYOh+C8S0kIwevhepKw9SJ01N9rs4g+LHBFFaid@nongnu.org,
 AJvYcCXJsWL5N0J8vczMj3c0zot5oPn7l/PQDjVQhuzcEsPWUU3E/8wj3oAjKAEQjRE50Sna2qcieKE0WTbWbA==@nongnu.org
X-Gm-Message-State: AOJu0YwCsu5JP8wLpbelpbP7YevH7YqF6W0gGn5MYm3a6W9K6TGZJn2T
 kzqW/WPWVYTTsyL6DRzCKvJ3pvy4OI7msM3bCOP3LD+GEZaF5jdHXjd573Kjic7GUhYJfRJNEIB
 VYTB+uMzFKU7OWkCseSRAFOMS7BE=
X-Gm-Gg: ASbGnctqm6pZUXiAAuckOjJeX2oUF0nlhOJINh7o2qS9tbb7nG5Kz++APQ/rKYGrvpY
 FrhL/ySWr+92fxqKWc64aLTJJJkth+KW/htSVp2iQNa73chmh0gM2DiSGe+YNLQ==
X-Google-Smtp-Source: AGHT+IF3nozWh6ybtCOfFO2w6BD4Ay/2xxGz7ZL1fal7/Bd5heF3Ds30X4LSYm5Irj3QziTgxmGj21yygizFvTF2bY0=
X-Received: by 2002:a05:6122:251b:b0:515:3bb5:50a9 with SMTP id
 71dfb90a1353d-51556818879mr6909354e0c.0.1732754731453; Wed, 27 Nov 2024
 16:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
 <f4aa9779-8d69-46ac-9923-3beecf760770@ventanamicro.com>
 <CAFukJ-Aa9q27qH0RxzP0QsCgRJE7FJ73GH5x1DMaLiB-NVH83g@mail.gmail.com>
In-Reply-To: <CAFukJ-Aa9q27qH0RxzP0QsCgRJE7FJ73GH5x1DMaLiB-NVH83g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 10:45:05 +1000
Message-ID: <CAKmqyKNgK+g_tE8XUeZBuCGWid0Fn77KEK4xj68EHFvw-ijpag@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Pointer Masking update for Zjpm v1.0
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 richard.henderson@linaro.org, 
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Wed, Nov 27, 2024 at 3:38=E2=80=AFPM Alexey Baturo <baturo.alexey@gmail.=
com> wrote:
>
> Hi Daniel,
>
> Thanks for the suggestion. I've resubmitted it with the v11 tag and put s=
ome reviewed-bys.

Thanks! It's a lot of time and effort to review code, so it's helpful
to keep existing tags. Note that it's fine (and you should) to remove
tags if the code has changed

Alistair

