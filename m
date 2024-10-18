Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF4FD3C53F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 02:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ccu-0000nb-JF; Thu, 17 Oct 2024 22:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1ccs-0000n0-0h; Thu, 17 Oct 2024 22:22:02 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1ccq-00053F-Ap; Thu, 17 Oct 2024 22:22:01 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4a46edda7d1so443526137.0; 
 Thu, 17 Oct 2024 19:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729218118; x=1729822918; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Erbc/yQK8eeFTHKGqvz0VdJrC5fN4cI/h28o7NKCm28=;
 b=Q2sBcBoNR8TB1IgXJ8yek73HVkPXfu8BRf5pIVjdxCC2oHwKeMhQqW0w8G0IWoPEF6
 nEOM/KZkqVFp26NOPnc8UdtIiGWp8rlZpeN//T/y3DawsAmqImzN3uaXrEUWIqgbQSCu
 VzZa80q43Vg4UVIOPB+eTTEk0fy75i+CXxHqrcSTXC3BTrFN4K7eHMuFpXdarFFzwb4m
 1wEHrW9HbCuIEhXwLDmGs/KeJmge812ux9dhO+jUJ/KnZA9InT1Qtbi9x+zuh3iDTmTm
 ZzaJmN1nL8ljFxtQzlZg95wSKg7kyQMXnjfxQnaTkj/ChCMh22HkaJktUK10kOVOW/kZ
 ikXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729218118; x=1729822918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Erbc/yQK8eeFTHKGqvz0VdJrC5fN4cI/h28o7NKCm28=;
 b=BS6MwdC1lmhS62WtvK37h+M73clFOzwr1GxAtSLy5bi85Pa/jY5CmeGj3Dl/M3LK1R
 ZnljArERQV/Av4UK45he4KHm23PdU1zQd7An2S+DTOM/1unIhctWXrtnYLmAg82eZMhr
 N8axeZeOEI0cFglWRvhUjONvswxYx5yY631EDda4jzg0YlWFqyF7j9oYF6xg61mUjyub
 GhMfxq+Br911pWbmTS6LlSwGYaiXXHOXBQHm0aRxkU1Wv0LrRPieAB+p+s4CZuK5rxLH
 LLd9FHR/wK20ZziUZOQ5z6DsCYkQYDeO5w9ls8HpXLWU2LtdY+q6H2f/WBQAwoAHtHs3
 zLzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3+0QSpR3gzlBGKymww2FD1y8aRB528dh/dskcrVuUDleF1xHWMK4CAr0PCIlgWEy+jMcvQ3iapkCvKw==@nongnu.org,
 AJvYcCWGgyYpP1Bk4UyVuFYn6wLgURXTfoJMJJ4JPzRKuEB3uTCbsYLRKebGAKbN+wY6+caayj907IegKybI@nongnu.org
X-Gm-Message-State: AOJu0YwVMmoqAow/PDPpOXxlQI2SBmpo8aU2CGJPcWrwmdrm2bgUJL/R
 KcSJl56bAcvl76xEeT43U0yEDZReXavC3owYSV1E4nYr85wWb+d3c/ff6rbhDIcyU2XaBPSfGhs
 CLmivG5XPMIIWES/iz9nOclyQ+yM=
X-Google-Smtp-Source: AGHT+IFMD+FXr/odK7f6AR6eERoPV9MdnmEY7A9e29af8i9Ahtbg90f9aablzTPg/GCgN5ZMz5heKVBc2T46HPxAww4=
X-Received: by 2002:a05:6102:c87:b0:4a3:b2d0:ac6a with SMTP id
 ada2fe7eead31-4a5d6a8d051mr996651137.5.1729218118478; Thu, 17 Oct 2024
 19:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-3-cleger@rivosinc.com>
 <CAKmqyKPrHtsjAnc8kX__BeHvxoMvm+MmYLWSgh5TKdx0FE8o9A@mail.gmail.com>
 <Zwlz8LUEGB4Fa611@ved-XPS-8940>
 <CAKmqyKMtJK_2yoUoudVoZorW=A5fX=m5RvG_vvHNHj45nQy_hw@mail.gmail.com>
 <20241017182710.GA403564@vedvyas-XPS-13-9310>
In-Reply-To: <20241017182710.GA403564@vedvyas-XPS-13-9310>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 18 Oct 2024 12:21:32 +1000
Message-ID: <CAKmqyKMir+rXf_ebU_XxkOk=5=v5tkT+g6j8Km_YGCjjX=cqUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] target/riscv: Implement Ssdbltrp sret, mret and
 mnret behavior
To: Ved Shanbhogue <ved@rivosinc.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Atish Patra <atishp@rivosinc.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Fri, Oct 18, 2024 at 4:27=E2=80=AFAM Ved Shanbhogue <ved@rivosinc.com> w=
rote:
>
> Alistair Francis wrote:
> >$ grep -r sstatus.SDT | grep SRET
> >src/hypervisor.adoc:if the new privilege mode is VU, the `SRET`
> >instruction sets `vsstatus.SDT`
> >
> >What am I missing here?
>
> https://github.com/riscv/riscv-isa-manual/blob/ef2ec9dc9afd003d0dab6d5ca3=
6db59864c8483c/src/machine.adoc?plain=3D1#L538

Ah, I thought you were quoting the spec directly.

Makes sense. This patch misses the MDT bit clearing though. I'm
guessing that's implemented in a different patch, but it should be
pulled in here instead

Alistair

>
>
> regards
> ved

