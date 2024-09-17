Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55524C3601A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXa2-0004GP-0J; Tue, 17 Sep 2024 08:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqXZz-0004EK-3E
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:45:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sqXZw-000314-AQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:45:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb7a2e4d6so46619955e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726577110; x=1727181910; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R2D8omB6AIs3LPmVIk9BObkgDL6uOtgEhSvvMBO53Ms=;
 b=DWNomanKdiO0KP6DC8ybSWmqdZbcWOSxL33UiDJyF1IAlL7aRGqhMP0G+3B1oIYfAk
 7xd5S7FomkITjy/m0kxAapXFsYKOXWUvIg8+DnsOk0FpPbm9fKAyDupf3+anDv5XSVVw
 XRc9ETBmquEIt0eoCce4kzP+kga1y3M7v/3eFokDXs8i4cwDQQ1DqQIc/iFxNde11p23
 CRxIZb12MotxYTvbBpBt7lixBQ765VOkJYxz5QUwKIhyjOzYeH0WyH4ROAnhdX9NiLMk
 4kEEgT9L2cCrAhREBL/z35EXeI4gU/wQyI7dpR7k7iv5rLxbsMZfAM/0QHDmvYyFMOaa
 dFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726577110; x=1727181910;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R2D8omB6AIs3LPmVIk9BObkgDL6uOtgEhSvvMBO53Ms=;
 b=qrVJ2RkbqraRej+HXXFBkmO6bt30Er0anHWSJhlEwuMR0sGopGR04CKG6cKEiBwlfO
 uJbmgZpzfO7SOwDiSMDn37lx4jjj4w5cCv77T9TZrxT3mQYqqlZ632blgaEXRgBieDcs
 UxpxWKAT0Wp/CKSQMS21sy1hJfNyb2P5/XB4ZZBFm0ROmv2uXqVDbYCu07xkU4WpebsC
 gikbLN9IJgkQWNIynK6Zwmlrh1LkEawGX93uK+v1FrtbdIiqXGqfIl8ByyYjVXSPuDGI
 AC+NTQBLRjJhabmXBVVyBXyeMGHcHh4/LKjbf7NWg6mpaP4816KuC1f6vHzsxIW2UORG
 5GWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/A3GMgKTgGCncG+TateoR6OsyCyCQttID+h2d7Mu5bRzWaTJgAHHyrA33mt4nyOidTQRfzOFsG89s@nongnu.org
X-Gm-Message-State: AOJu0YyuPIFUjZBNsFidDWm0yYeFXX4/AesZ/GMZtqhy20d+0Dyz2TWi
 dknItgcnSOFUz8uPovfZVHKzlHANKQE1bD0DUsfgzwI0sUiIWOd4MYicFQvE9xg=
X-Google-Smtp-Source: AGHT+IHL0gNK0X/v97KdZxKStrAktOesKMobua4sN8iN9MxPJ2nkMymPIjGDYd5+Pc9JCeRh1aH3lA==
X-Received: by 2002:adf:e552:0:b0:374:b6f3:728d with SMTP id
 ffacd0b85a97d-378c2d516c4mr10153515f8f.46.1726577110079; 
 Tue, 17 Sep 2024 05:45:10 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780519esm9436905f8f.103.2024.09.17.05.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:45:09 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:45:08 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Gregor Haas <gregorhaas1997@gmail.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, atishp@rivosinc.com, dbarboza@ventanamicro.com, 
 alistair.francis@wdc.com
Subject: Re: [PATCH v3 0/1] Add support for generating OpenSBI domains in the
 device tree
Message-ID: <20240917-2683603a6ea10148772d365e@orel>
References: <20240805210444.497723-1-gregorhaas1997@gmail.com>
 <CAKmqyKM_qgc+wwrDRzZM1yda=dZziM=1rGU2_SDeJU9PTnacVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKM_qgc+wwrDRzZM1yda=dZziM=1rGU2_SDeJU9PTnacVg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x335.google.com
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

On Mon, Sep 09, 2024 at 01:27:05PM GMT, Alistair Francis wrote:
> On Tue, Aug 6, 2024 at 7:05 AM Gregor Haas <gregorhaas1997@gmail.com> wrote:
> >
> > This patch series adds support for specifying OpenSBI domains on the QEMU
> > command line. A simple example of what this looks like is below, including
> > mapping the board's UART into the secondary domain:
> 
> Thanks for the patch, sorry it took me so long to look into this
> 
> >
> > qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m 4G -nographic \
> >         -device opensbi-memregion,id=mem,base=0xBC000000,order=26,mmio=false \
> >         -device opensbi-memregion,id=uart,base=0x10000000,order=12,mmio=true,device0="/soc/serial@10000000" \
> >         -device opensbi-domain,id=domain,possible-harts=0-1,boot-hart=0x0,next-addr=0xBC000000,next-mode=1,region0=mem,perms0=0x3f,region1=uart,perms1=0x3f
> 
> This will need documentation added under docs (probably under
> docs/system/riscv) of how this should be used.
> 
> I'm not convinced this is something we want though. A user can dump
> the QEMU DTB and edit it to support OpenSBI domains if they want.
>

I also feel like this is just pushing the population of device tree
nodes from an editor of a .dts file to the QEMU command line. If some
generation is needed, then maybe we need a script, possibly one which
has the same command line inputs as proposed here. afaik, we haven't
typically taken patches which help overlay the generated devicetree
with additional nodes. For example, see [1] for one such proposal
and rejection.

[1] https://lore.kernel.org/all/20210926183410.256484-1-sjg@chromium.org/

Thanks,
drew

