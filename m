Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CB1CA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 15:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD1OL-0006xQ-6z; Sat, 03 Oct 2026 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xD1OJ-0006x5-Tt
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 11:11:12 -0400
Received: from mail-yx2-x2b.google.com ([2607:f8b0:4864:41::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xD1OI-0002TF-GU
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 11:11:11 -0400
Received: by mail-yx2-x2b.google.com with SMTP id
 00721157ae682-8ac8c533385so2356887b3.0
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 08:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791040269; cv=none;
 d=google.com; s=arc-20260327;
 b=CnAKJueU5IfRoHc0do8WUp4GQfJOrMK/cOW30xwVcMzhU9m8apEa3lnZHKWeQdki+U
 lvqIPbUflJEjqviHEkR7X7U+5+UuMpJSubMg/X2kUpMir7sXs/3GfvTsxL+gAufdigx6
 DwFYvPnYJOYcnOUx0F/6ReUYk/VgRQkdCPDmG5znMmOqSywA0yW9qBQl3swgzWFkLIg0
 +T1wrUAL6WqUW7R1V3YszFV83jCyKz5Jq6e8HlRUN5uqc2d9YkXbLEVXt/X+In1rMMx4
 IQkc4w5/CbG62yX7FTxUxCqeoq/NiSWzPwflWdERIbHm0Yb68JIccwcPi2FP75Uf9njL
 6K1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pgZic5wRNJzwWhfBBT7pKQjY+WX1ujt++/6Zl5k789Y=;
 fh=Q6L85dOhkwfl+e2ztB8T/ucQCNY/HOl3mDqPVenLPCA=;
 b=cyoEHbRwZSUAEgroAufVgS/UXG15jWxc/+n00hvW08v6NxaL0lv7ncx/95SQkggTW6
 DNo89U7Hdi2qOLUZM+4Y7NpAFeYj0OZrObBjEmaqzMelYYl7E6ROdktDXr/0AyAXU2Js
 XCxzCwBVvGWbc9uE82xXVKXWD6DAGMCzgKQrNyMjBlqyyZ/fkeOPqpLq5Esyw+TbLJaV
 ERy64EIK+z5ufRsLQJ1rQrVp/aI1WaPBUYy80RyNyw3msLIVUHZzP7UC5JtEeXKJy1H/
 cpoA/b8E7oC7vqRPyzGskclBvuMz1pd74uA8FfnFgNXMF1/9qf9bBG6PVlqHDOcxz8l7
 G0ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791040269; x=1791645069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pgZic5wRNJzwWhfBBT7pKQjY+WX1ujt++/6Zl5k789Y=;
 b=nr8YfvZ5C5PUtAOGZI5XEOMCmobMBNNyCbeIbnLwQRLeaX39reHORxUF6MGEOpFGt8
 MxQSyUADvmu5EDBcPmGLlODPxwOG43QqJrGxBx+bFEBcizPz4Ko6xo0p4bmwEUWfxZh+
 7eDK0qxMmH03A24ZCe13RhOta4Dl5QiPpIXrofzQwtwAVUBmvO7f9Wj7s9fhbFSZdJj+
 xe7XwyB0MuCRFXLJy+zXsLpVkDglcvqXCdR0XLLHmXUXaKYhAIKUqtrXiEbeDZyIcJKj
 hHcom5+yYHkHWkkDNceVwybQPkxHRh3Zj+NFw5v3u0qw5Qmh+nQ1cJ0/u8u6Ovp97oEo
 sJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791040269; x=1791645069;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgZic5wRNJzwWhfBBT7pKQjY+WX1ujt++/6Zl5k789Y=;
 b=us8x4DTmxq+Ki+xhlaeN42nBmkVJtFIjiLvtrXyhW0Vhh1T71kz+Hlj6IZ+gdhdzej
 dMPvPfJv1QgytY8G6pQsVvaQ1z5kP+bhrnHfVvymOiQP1PdC0hZLq9AUJa/1tpFzI6n8
 SrkNVZ8TikrCWeiyZOcoXzJ73yPLGls11uKmIISXNX1jHiP8tQ5gVo3ycdyNOrQFqmjs
 ukR3eOLS/sOve97++j+TVfRsl7mW/+3vnqXkm0yhC7kXEfiAVZ2baZzaWHK3X3O6vHYN
 WHgV5XwXpVeuKLAadt+ko8bnoJd2vAl4yO6r3cbesYZpVCK6G57KuZeGbWBlFZiyeAoI
 q3yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWBgb0yM1laotWRa8NMoGooRWWxvfVg8rN8ngLH2rji8KtwksL6yBbdwjUefNDjz2ZHVxk5IIFQdjl@nongnu.org
X-Gm-Message-State: AFq9FYI6LGXmBgkOn7YY+uax7xoyyp/x2s+yI4WgjAQ0vb4ORbYBjU8B
 4veddofFm2U3dkX3YEAQdaB04tp/GtWqODRD1Zacd9qr26ki0b+Hy3JH3EVK1LK+G2SvFUJhkwu
 2j91c1dGoDkcK2y6ffjwXwugoyV3UP6U=
X-Gm-Gg: AYBFou2rJVzNeTDSSzWUYvWhi4HfeGlwkNg+QvDeROljaWpWZYEGAn754Jz0O4DzOlh
 5xVmwQjFFCvciOvOAzwd4nfKylVj17iN5yoXTMsMehOxpokwsM1B4KciBwWFpEMrUM17CD0+O+A
 X5NSxLUcRsErRA6kMNQbOsIl8bU5xfbXYvDNqhjPXTde7XXVoH9H/XuU72sPVx8okjyahbCgyll
 qEdoiDTL+P+jPfGHAVWP6OtSnKxJDXzn7LDaq93niHtcz35XV+o8DS1MoanLM/3oC6d/GzOxaZu
 aPiK2JZn7dFU5LWoEOfP9oz/NLAJpW1JE6Ajwgv7eJYOuU7DZsZdIiTWDrzyVUN5pgkrg/Oynyc
 a8YeWP95I+PPzVg==
X-Received: by 2002:a05:690c:f04:b0:8ae:8d28:77df with SMTP id
 00721157ae682-8ae8d2881c1mr17682077b3.9.1791040269239; Sat, 03 Oct 2026
 08:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-20-bin.meng@processmission.com>
 <20260930-livestock-stylist-cedacf269035@wendy>
In-Reply-To: <20260930-livestock-stylist-cedacf269035@wendy>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 3 Oct 2026 23:10:55 +0800
X-Gm-Features: AclHuK8HvGpKKWBC8opOUTDxa0ddWckjUda70l_nHNNDD0yYIPCBaYJxLyr7PRk
Message-ID: <CAEUhbmVDNceBq0qBAbcyQPv1LuxL0=4MUpU5PcBmyXwtHm+j=A@mail.gmail.com>
Subject: Re: [PATCH v2 19/24] hw/riscv: pfsoc: Fix Icicle Kit hart count at
 five
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2b;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2b.google.com
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

On Wed, Sep 30, 2026 at 5:35=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, Sep 04, 2026 at 11:57:38PM +0800, Bin Meng wrote:
> > The Icicle Kit always contains one E51 management hart and four U54
> > application harts. The model currently accepts two to five harts and
> > defaults to two, allowing configurations that cannot match the board.
>
> Updating the default to 5 makes sense, stops accidentally trying to boot
> something expecting 5 CPUs and getting only 2. But why the change to the
> minimum? If someone intentionally wants to have only 1 u54, why prevent
> that?
>

Will drop the minimum change in v3.

> >
> > Set the minimum and default CPU counts to the five-hart maximum.
> > Update the documentation to state that other hart counts are rejected.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> > ---
> >
> > (no changes since v1)
> >
> >  docs/system/riscv/microchip-icicle-kit.rst | 1 +
> >  hw/riscv/microchip_pfsoc.c                 | 4 ++--
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >

Regards,
Bin

