Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E03DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 03:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whfNa-0007gk-W9; Wed, 08 Jul 2026 23:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whfNZ-0007g4-7G
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:24:49 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whfNX-0007PO-M8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:24:48 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso964715a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 20:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783567485; cv=none;
 d=google.com; s=arc-20260327;
 b=l6nQOc3aAWo2jQ23kMO7UXe7CjSdP3OY0Xa7unfZxU5kAWeAu0ALjCMGhEl3IZ39Xs
 8tZyP36FJjfJtHcnp4E43nXJ7OwBedtzi2pXK2Y01+yhkbg3pr1APMu8GqhYIaK931dv
 pSt8HEx7V9A9jG9SzRos337CFH574A0IMz2Tfm9h6EggVpjOzK5yx2iOfzmMgcxz2wKO
 e6gvI12YZYmqMeGduxsvw/qiT0+jIsM5yFGPT3o3SJR+tD01S+AdAH7/1vUfC4wdvjE2
 LhbJ1OH3lqewztriarARYikxnBUma48p5gkeLnFN4urlIWqS0hKP6lafEB6l3w+4NtnF
 FVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ng21UaoMrWYg72GHTzSnmQ+n9Ud5epwyJFjuyHbRGY0=;
 fh=XprlEOYSYHeyk23qNQeiXsKEF8nE10zAIzGAHnZo09s=;
 b=LyAkodTIy5p9RQSQ3DUVIZF28kRvcjorPFHqp8/zKpqscA7zCIViuGQLXAXHPdLx20
 ifsBZQXdjKf5YX+HkxN4xG2XXjnZg9x5hEMaVoYrat92YBAt03To3H7sidROdX0mAHeu
 KGtuhgAV1uFF8HdpySHBT9zyt57t++wFnNyEpIkW8BnOr/tmlIDZqUt3was56OkpCv6g
 7VbyTo32uow6O6OC//7vzd/hJH6ip7o1eP05nH/wIC2J+r0Cejk9ODqhZmKRsv0oeJUl
 7Z1Qfpgejo+/qdBU5y9IbHEN+cX6P+b078ntcDiVUT8EfslxlQRs7PjaQpNWwGfUqW5V
 WIIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783567485; x=1784172285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ng21UaoMrWYg72GHTzSnmQ+n9Ud5epwyJFjuyHbRGY0=;
 b=I1uJSoP1/x+BZ1S9OW5gFrd/MfM6L09acsZ8JWN+3FpT8fABDP0xvN/eQpyreG4jVX
 YkOPn6gsh+pq6VdGjOAkgy0H8hxH6MbSCMLqOJlfeKiptt+e7bFfAqq7qxor6T/JmbJw
 9A/hvka82Qdde+vypcz2ESXhIMUx0LaJULkroh9fIrUiyjMJpz2pB60/ELa+8yyu/5zn
 FfgXJNW0wLcbMcFN9B/jMlMG/GE6jB7wHxmqYdy1XS4YZv8pulu1zIpoPMYoLWvuBaM8
 5RnxNCcHRxDofBoK5jbNqQ+mgV6IOt55sZXhMBVqps9XvAiyp0NmERy3HINIOzuFrk0Q
 uFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783567485; x=1784172285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ng21UaoMrWYg72GHTzSnmQ+n9Ud5epwyJFjuyHbRGY0=;
 b=aa4bnjC2g0DgpkZWo/W3otlO1A922luwu8L1fsgYOTDA7fkwzFuf1SCC0iExKRx3qf
 hZYJHJqQ1IW/G6lZUnA6QZbrmmdcySM3jTSj36+1F1JYwWPTy6BB2Qw3UMAmmAQKDq9e
 8p8CGcjKsQOGNrX0Me5sTDGh4U6BcRyBZPsqecPzYf02UL3xjVhUiFmZmPqtGUSTfML/
 0IXG/Vxktxl8Ja/LXn3bnYgNJDkus2UPUBXeyM1GqlCW4MLlRGYTAIJ/06JEJbsV//8m
 lHXcwGWGwOa0ZyV7I3K6Zua8h3abSFVDwFvwm6jJpePj1S416k6mr4t/JTcOyx1xU5Fx
 HfJA==
X-Gm-Message-State: AOJu0YxswOtpvseBU3vn/UtmxJX69RoDMRGi7/xheP3fiD3Ya0QAlGuR
 /J3ln0PRxi5KcfnYAcK5qkhF6pS7xQ4pgEdeKnKErI+4XXHsWR2ORj5qSJwq5rMveQx1febmX5w
 ulwVVzx2qWoMhhqAwB8ISK8PqwyDcFXc=
X-Gm-Gg: AfdE7cnUyeG5pFCeF/cSFFtxnXbHmVNZW7eQ4Bk53/pkkdOH44zFoD3S71fOqsPaD9f
 +74iYCFYibbJys8ybbn3yym5ow9gv8JOEP++OJQWNw4oQxX66i3sCwO8/SECoNjrlnGVz7VmQ85
 5vMRiQxYUYG3aRQMtYRYN1Ydf4dudTbC6qlzvx1CZZmFCMrU9JplY3bOXImn7OFKocSrPeFxUip
 lAHCnh3dAoSOU/LNBgGR9gsgQhPEsRbXhIE3+391DvGEE+TmXd0u7HZlkW7UYobj+I4j2YwdrWc
 TMDtv1HSsuVOZklJ3gzjRLe2aj4=
X-Received: by 2002:a05:6402:4306:b0:697:eb97:a4ed with SMTP id
 4fb4d7f45d1cf-69c01b81c71mr375197a12.7.1783567485298; Wed, 08 Jul 2026
 20:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260707145407.70287-1-corvin.koehne@gmail.com>
In-Reply-To: <20260707145407.70287-1-corvin.koehne@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 13:24:18 +1000
X-Gm-Features: AUfX_mwZe-tlLQ94Prq2m4JmqQ2Enya9vPDfJcrHq2m698UQsAYK88z9CwwnNPE
Message-ID: <CAKmqyKO6bph9pnQM8pYD=_rPu+c6pn17HODDcJCfFH7WPZ9eHg@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/zynq_slcr.c: drop duplicate reset value for
 DDRIOB_DCI_CTRL
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 YannickV <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Wed, Jul 8, 2026 at 12:54=E2=80=AFAM Corvin K=C3=B6hne <corvin.koehne@gm=
ail.com> wrote:
>
> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>
> When adding a reset value for DDRIOB_DCI_CTRL in c8ba862dbfdc, we haven't
> noticed that a reset value already exists. DDRIOB is a 32 bit register, s=
o
> incrementing it by 12 will access the DDRIOB_DCI_CTRL register. According=
 to
> the manual [1] the correct reset value is 0x00000020. Additionally,
> c8ba862dbfdc won't work with a reset value of 0x00000021 because it tries=
 to
> detect a toggle of the reset bit (bit 0). Therefore, we drop the old rese=
t
> value and keep the new one introduced in c8ba862dbfdc.
>
> [1] https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Register-slcr-DD=
RIOB_DCI_CTRL
>
> Fixes: c8ba862dbfdc ("hw/misc/zynq_slcr: Add logic for DCI configuration"=
)
> Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/zynq_slcr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index 0ae5d607be9b..d0f899c3be4d 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -427,7 +427,6 @@ static void zynq_slcr_reset_init(Object *obj, ResetTy=
pe type)
>                            =3D s->regs[R_DDRIOB + 3] =3D 0x00000e00;
>      s->regs[R_DDRIOB + 4] =3D s->regs[R_DDRIOB + 5] =3D s->regs[R_DDRIOB=
 + 6]
>                            =3D 0x00000e00;
> -    s->regs[R_DDRIOB + 12] =3D 0x00000021;
>
>      s->regs[R_DDRIOB_DCI_CTRL] =3D 0x00000020;
>  }
> --
> 2.47.3
>
>

