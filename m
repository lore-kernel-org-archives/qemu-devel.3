Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247A9C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdf1c-0008Ql-Ei; Thu, 30 Jan 2025 19:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdf1U-0008PX-QM; Thu, 30 Jan 2025 19:36:41 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdf1T-0005Z9-6j; Thu, 30 Jan 2025 19:36:40 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-85ba8b1c7b9so796180241.1; 
 Thu, 30 Jan 2025 16:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738283793; x=1738888593; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgtCGlb/iwQxJYti9sl6eHiYHuN4/qB8Ea1ajpJSCX4=;
 b=lDpzChWteHrwxDDqrJSnmu/yqSPl0OCFG5PlXvaWz5Gy581ZQsdNeN0783ACk+MRfD
 lRdXKKsdovkn+aSZhWVlIe28sEertGve9TOACm4syhFjwUl5y8BAbEGAvWWhtEtrTvjT
 KFXOozBKbXOtBlS/6UTeLX+Dshq0hPML7Sqxj0eXltZnAH/VY5E683O4t6EV29spRNHF
 qS7lWGJKqOR6nVUZ2/yeGFCCt9BGkdWv4cncvEXfheIXYvkGZlgIUqPaTwNN14BWl2c1
 djqfe6hVywQnMZJvOKHlf5HQRaV5/U0Yh6/dZlK1hn9NEJvxoPyKK2YaWoaTn8QNBgQK
 fJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738283793; x=1738888593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgtCGlb/iwQxJYti9sl6eHiYHuN4/qB8Ea1ajpJSCX4=;
 b=IjSlFH81zCVmM4xCBw3Pya14+fRRWC9u4uuPnp+rjUaSt8q7y3gJxm3Ltr32eQoa2G
 AO29rL7UFdqXRFlU8ZzwODzlYsbSrWrCMRGy6tGOZ3cnCCXyeDjTyG++rv1J8XhK2iiB
 AmuRebeCIIxQ7CQptnQZdRKqLknUQ0LCaal6G3aj1iXiFrnygHHRsZXHDt87VDsYwEZA
 RjG+E4EuE5WwAHxVkyiPZ9AiuMQvF+tyBtNz/5t6TpzmbeqQLxfHMSFkYwaXdsc3cBHH
 Taa/8CC0ohK0kyfQhiFti58TC1tgLMz6uZHjXb0fk/HP/AVt+U5DeBPlzsIzk2fr7mWP
 k3ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEvXZh32wUn+SlfwYPm4lG83ckmm5BeTfMJCmxbHJ9k+tfDU56kZFXa3tlRiNv5ofeZWuo0j6WKv7r@nongnu.org
X-Gm-Message-State: AOJu0YyZm8HxSumvnwW+oK74BjsE5py65+RIbVvSYpm+yAnjN+qaXora
 7GdZReuR5gr7YgTSEb4E4rfm10A7QBlCX6DxZw8Uwb4huXfY3lQ9dP6rw+RlRV4zmKLgPBbwToU
 HdqT+0PrjOFrvf6OKnz+jnt3+qA8=
X-Gm-Gg: ASbGnctl/KgCq3YZLDmRUehEFAEMWmV0bUao5P0GzmtA0y9qunPGWfs8q1g1PqjHh+8
 96cXM2km8w/bIlz6rxGTnab5UAZRZEBlwZ3EtwHEoFvEZkIet9VyTann322iT9EL7iD8FnC3J2t
 KUlVOGGhGtnCpXw/SiR/Zw5SMGmCc=
X-Google-Smtp-Source: AGHT+IGJ8YI4xdxM+UXw53fySnvGNKLOgxWy5DquVHuzIbwUcisiT/ORNowwcH44D8M9h7VcdtXUoQj5SN5UEflEBKg=
X-Received: by 2002:a67:e311:0:b0:4b2:bcae:a721 with SMTP id
 ada2fe7eead31-4b9c8b6aa52mr1379496137.11.1738283793164; Thu, 30 Jan 2025
 16:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20250109091044.32723-1-ivan.klokov@syntacore.com>
In-Reply-To: <20250109091044.32723-1-ivan.klokov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:36:07 +1000
X-Gm-Features: AWEUYZnUcWAQgsXPdBaUYllHy_HM0oqACfGb3qTL1fN4WlqlxNBu8yLPOqlfhy4
Message-ID: <CAKmqyKNgPj+o3X6rN5-ru2jMfH3VHPLP094CAhbDA8_JJEE+gA@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Support RISC-V CSR read/write in Qtest environment
To: Ivan Klokov <ivan.klokov@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Thu, Jan 9, 2025 at 7:13=E2=80=AFPM Ivan Klokov <ivan.klokov@syntacore.c=
om> wrote:
>
> These patches add functionality for unit testing RISC-V-specific register=
s.
> The first patch adds a Qtest backend, and the second implements a simple =
test.
>
> ---
> v9:
>    - Fix build errors.
> v8:
>    - Delete RFC label.
> v7:
>    - Fix build errors, add Reviewed-by, Acked-by.
> ---
>
> Ivan Klokov (2):
>   target/riscv: Add RISC-V CSR qtest support
>   tests/qtest: QTest example for RISC-V CSR register

Do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

Alistair

>
>  hw/riscv/riscv_hart.c        | 55 +++++++++++++++++++++++++++++++++++
>  tests/qtest/libqtest.c       | 27 +++++++++++++++++
>  tests/qtest/libqtest.h       | 14 +++++++++
>  tests/qtest/meson.build      |  2 +-
>  tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 153 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/riscv-csr-test.c
>
> --
> 2.34.1
>
>
>

