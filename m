Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4AFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgv32-000654-6H; Mon, 06 Jul 2026 21:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgv31-00064h-1g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 21:56:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgv2z-0007r4-Bu
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 21:56:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69a50189d25so2984495a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 18:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783389387; cv=none;
 d=google.com; s=arc-20260327;
 b=I0XIDaQCsiqXrqMz3ou/zqxE78Alk+bk6ieWDnlOOS0kllzoK8kFyYz41UL1jTWqeA
 No0goJQnHR1eE84v+5ObqpzlplWXICGW7hsEsOimU0NHumJDHORMwx5ukgxUZ1Xj3Van
 RHb3IshZsL2zr9cGhet8jE446PDBZVGRfWFp/LvdbKlQDPy6A9uUgrYaMWtLMyjIhNyv
 stWNnjd8bdNLp6JabZKBbj+ZAKHZgeAVqG82YwTIShRSJYoZybA6anyptdAGOsczRVPA
 HWziA5Gc6+9hKk2Ji3lsH+0lO+0gN6TERyoNr1NRpne01nVmsAZ0eRz4sMTh/EYI1s9q
 H6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4GTQHmDh8FTZKwZ6WAnugH/Vw4sEKCvN0o3tiiJUIOM=;
 fh=Jbjp4DdiSy1YPjoOIxZiyexhq8tH2egVvk5qr8zQCSI=;
 b=eMEn4zQZ+KkSIOgYSg7KAFYiGdO6rV6C+wcfKmaruFJogXC8KoLQEDSfT23qwJmvb9
 oz8OuGxmnZpJa1+GrSWLzH6R1OvjlKZTQmbbozeRyF9tNdwqRtILBlD4pcZliIzjmmef
 LVE6rYwe/YzMUCawKYZF7WBOgw/xcpDmUaYVs/bXHsIVOgctW2dP1mIT4YCkQos6/7db
 lcJ46Sxs1IvDrv1dZuuWuD5+nLoHyAHSZvzeXn0s3SJS3FsBQUwSS8s+SswkwA7TdHqK
 JMaUXXl4zmuc9xPGon5DEwiEFdTXXBsKTbcwE09160JvJxmAuB0PKJHoOucYeIdAwS5U
 i2bw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783389387; x=1783994187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4GTQHmDh8FTZKwZ6WAnugH/Vw4sEKCvN0o3tiiJUIOM=;
 b=D6o+9JjvrOzo4asr15TPaY1AHXef7pMNEzfk2zC5w+t0jQxIwOA+5NN6QeuSghkpme
 yrftVOUA2LHvkFVCd1ymeuj5BDuqg0cacdDNcTMr1y3hwLVgn99z0dEzCPoWmKmDnX3+
 rVw26/SDX2ksrUNArPwKjAW5nCRBgqqr5WURzz8jchCfV6EvAO6vVhnKcoBUoiFqyMmD
 PbQ9o3dZbAjp6DOZx1ZHGSXKWjv5bM5SqzLqYvnsosB65ABz24g69LDhwv2XLSOKrYcL
 KSUs5OEJTNgaQdKx+sUMkahk+FPdYmotlN+URVmh/hseEbCm2OzWcoThqfDzYAqblUYS
 oRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783389387; x=1783994187;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4GTQHmDh8FTZKwZ6WAnugH/Vw4sEKCvN0o3tiiJUIOM=;
 b=aBLZ47l8WOQSbEfVndfbbHdnNHb7rtW66k4boIvW40LgtZ8inWXjz8FVwcd7H/tKJf
 9QZ7fOUHsiYWjzBQHPcefkvLnm6RZHRIP4PY60MeDgt6DxdIclO50DSB5Cizy08ki9nt
 cUL1H+SgSLIkLC7O02BaKxagIHX29dpr/bArNj1MNkg7P5pzRKmNcak+c7KDxUZfttJz
 XngAPZowhBqa1lZ+0I4XKWJN/Q4X0buRup0g5tAp18AaFX1VbZikXdIfDGP7mbQ2V9aT
 cfwtkoXAV1YX7ae96uyi6CYrRmOFHJVSNGQZyusete65MzLi7nzNpc+FBYsIiLxy8xbY
 y05A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/FsLZZ4h/huNbEqgZiogjhICG/h8LMjuGL8Lb00i+qFz3ZhHgYUpCXi03u/2AveDIhI+biEA88MWn@nongnu.org
X-Gm-Message-State: AOJu0YxWJZLxm6SZUemVeUVQiVH5UA8L0B2CLbzvpCnA8o4+0akPki0W
 HE18MHNDiqZxx2oT8sWmHn1tGzJsjjl+N39HO6aC526VlAESSuEof6zEMutsEANLEtqFmVliOYQ
 Y5GLgSpxFITBc+l7dO3MwUeD/cPQoSKc=
X-Gm-Gg: AfdE7cnWM/TuCP5QCcZBHRJdHc2SB6u/Wq9cMFSqX7uUjMFPmZYg4jJojPqQOP4t8al
 xCoYf4CsLq92D4GkD8SFnxX1Ktqw6Trsv1Qls2mdgSwupn/+Qwkt/liXpnXpvFRdym1sbEgvCBs
 egZ9X8z0z36zl5IQsbriyCk6uyrz67JDmwAihUb1+/a53NbCuEU8ypc5PwvsCOlmpk6bjZpcu9w
 nQbnvbQu93qXgdVZhLE8TliGB7xNZYJJuxpcc/qE+9r7eydQd0hukA8VAurtrjVxftQHzZh2pQ4
 vo6scSqz6wVqipnK+NNB2jxJKIk=
X-Received: by 2002:aa7:cd4c:0:b0:698:5610:76de with SMTP id
 4fb4d7f45d1cf-69a8569f665mr1099988a12.4.1783389387223; Mon, 06 Jul 2026
 18:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260706003647.75945-1-alistair.francis@wdc.com>
 <2241dd72-e7b7-40da-b557-8ec5988523e0@oss.qualcomm.com>
In-Reply-To: <2241dd72-e7b7-40da-b557-8ec5988523e0@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jul 2026 11:56:00 +1000
X-Gm-Features: AVVi8Cfv2b8VoNwlHMHNWsYyXUnSZDRgptnMJqWy6fsXxmped9E8HmRSCJePPv4
Message-ID: <CAKmqyKPxy6CY57FabWa9wATxaXbWyCjoB=LUvk=2VVw8bYHqfA@mail.gmail.com>
Subject: Re: [PATCH] hw/pci/pcie_doe: Check mailbox length for overflows
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: alistair.francis@wdc.com, tangtao1634@phytium.com.cn, mst@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 6, 2026 at 6:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Alistair,
>
> On 6/7/26 02:36, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > It was possible that a guest could overflow the `doe_cap->write_mbox`
> > buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
> > `doe_cap->write_mbox_len` would continue to increment and there were no
> > bounds checks on the length when offsetting into doe_cap->write_mbox.
> >
> > This patch adds a check and reports a guest error if we would overflow.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   hw/pci/pcie_doe.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
> > index 2210f86968..765ebea42c 100644
> > --- a/hw/pci/pcie_doe.c
> > +++ b/hw/pci/pcie_doe.c
> > @@ -356,8 +356,14 @@ void pcie_doe_write_config(DOECap *doe_cap,
> >           if (size !=3D DWORD_BYTE) {
> >               return;
> >           }
> > -        doe_cap->write_mbox[doe_cap->write_mbox_len] =3D val;
> > -        doe_cap->write_mbox_len++;
> > +        if (doe_cap->write_mbox_len < PCI_DOE_DW_SIZE_MAX) {
> > +            doe_cap->write_mbox[doe_cap->write_mbox_len] =3D val;
> > +            doe_cap->write_mbox_len++;
> > +        } else {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "Mailbox write length (%d) is overflowing\n"=
,
> > +                          doe_cap->write_mbox_len);
>
>
> Do you know how real hardware behaves? I'd expect it to wrap, not
> discard.

Good question.

Real hardware requires a length for a message to be valid. So a valid
message can't be longer then PCI_DOE_DW_SIZE_MAX.

The PCIe spec states: "If the number of DW transferred does not match
the Length indicated in DOE Data Object Header 2 for a data object,
then the entire data object must be silently discarded." So we
actually should drop the entire message, not just the overflow. I'll
fixup in v2.

Alistair

>
> > +        }
> >           break;
> >       case PCI_EXP_DOE_CAP:
> >           /* fallthrough */
>

