Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873ACE7716C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIfOg-0001ul-K3; Tue, 03 Dec 2024 21:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIfOe-0001uU-LC; Tue, 03 Dec 2024 21:45:48 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIfOd-0000Hj-2p; Tue, 03 Dec 2024 21:45:48 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-85c15e283bfso62915241.2; 
 Tue, 03 Dec 2024 18:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733280345; x=1733885145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MP2YXRbO7uEB9HP9QNSpFqx0sQQaAUkY5EIn0EyJ8Ak=;
 b=Hf7J2ZiYnb9oTvkLBxDz5+2WPzzB2xMk1sq4DvnKpvAlE5OYoVwBijiQBSnt9tgWAP
 bW4123GBcer1fTL+dcMoNcL9l681pZ03l35diI8m5fj0rnYPkietJv036k+QRoo3dG8d
 nNLZeQCptqc+Oaiu/GF4CfAAikqUShqGD759dRnhPmy/uX8dhq4wtAq7/oAjDn4wguFo
 1dExshN12EkWdSKs4OjRGVAtNnAyGVV4N25z0Nos3kxt/uW1c7x/BkmDx8N4KtVtgCg7
 EXgaE4UO67UO0Z8taEd2MUGrt8uWnRM3OL5mz4oM5QaKeyAOYg/jGvuuJVl2WaQX+mPE
 38Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733280345; x=1733885145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MP2YXRbO7uEB9HP9QNSpFqx0sQQaAUkY5EIn0EyJ8Ak=;
 b=m15P17WiDbqB0Nxv+THKyjxx3fqRc01K5ZsmVpw90mWefat9+SrAJLqSskFZZ9eZCE
 iRoL2WFCaOUp5FqTsQpc3shGR2YUj9SM3zxYUK2NG48Pb0uW1W9uEZMYZq0kCVvFr0Ii
 Tr8/wZW/4oQyeNOprI75jHLycZd7WvVEP1dg4mv6ZTP7WFvwHmszpJdfDhk3w3khCF88
 5lZsNMPVkPn4semjN9OZ+nOo7vyAT17yG+rBtDdNyhqgVb+fkyj+tDiifHIRP1pdKtzL
 qK2OYcKUlZw9znYnrB/ASgtqIy45Ls14En/Q9eALL9B9ezA3c8keI/lawAvskuymcdjP
 GkGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvmBWkMQUeLauXBHg0eb02/Ja5BNE6icdBattxF63YwapQHz1PsnkzK4XDL1u+VuHGVFS7W875qP5Xyg==@nongnu.org,
 AJvYcCXm0gEPrVc62+avCk0NyGg2J7Q2NyICQDsC2sQTD8DVY/4T+oOa4op1+mR9F+s6eIFQ4xEHXM6+AvtV@nongnu.org
X-Gm-Message-State: AOJu0YzXoFdAX9z0NgRyxN91QzlQvNv+iS8/MC2xPNm38OK0HqWWM6G0
 XqYaKALIdEd7eRizh7Zp+AlNBWNsRF80MDOovECQX4r4JSNFWE8elnDbzCAq/7N5vv63pStDblb
 cHymfllnq26IMZQA1F+4wa3yjb60=
X-Gm-Gg: ASbGncspOsy3OleO3rhm4XjqCbxh2Qsgi7d1rZ7dLqBlYn3FXvQDEpY4EIL8AQrGg/E
 Gi69nGw+lUC75qDt29az+IUoaL2HEZM+g
X-Google-Smtp-Source: AGHT+IFqUgU+pRB4xo7sdPlUuoxbbxhSyGSdHMxJqJZ6EdFoYpfR/fuuGWnjn4hBlRTNNUSGTJ10Ai8BBqrFo3gGz0A=
X-Received: by 2002:a05:6102:50a4:b0:4af:58f6:4e8f with SMTP id
 ada2fe7eead31-4af971fd1e8mr5600363137.4.1733280345479; Tue, 03 Dec 2024
 18:45:45 -0800 (PST)
MIME-Version: 1.0
References: <95383723-cc27-4986-8dc3-827962120f8f@linaro.org>
 <da7690ea-a02c-4402-b798-fc29bd07451b@linux.alibaba.com>
 <8b1e3b44-1cd6-45a2-933c-a7a599598758@linaro.org>
 <d90a4d13-b356-4669-8e7d-e1409bb6fca0@linux.alibaba.com>
In-Reply-To: <d90a4d13-b356-4669-8e7d-e1409bb6fca0@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 11:45:19 +0900
Message-ID: <CAKmqyKN+gGMFxvbRwgq5oWs9=zuAmwpMY9nFtRbmuWVB3Fjrzg@mail.gmail.com>
Subject: Re: Host riscv disas is broken
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 liweiwei <liweiwei@iscas.ac.cn>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Thu, Oct 17, 2024 at 2:39=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
>
> On 2024/10/17 11:52, Richard Henderson wrote:
> > On 10/16/24 19:57, LIU Zhiwei wrote:
> >> Hi Richard,
> >>
> >> On 2024/10/17 02:38, Richard Henderson wrote:
> >>> 2595: if (dec->cfg->ext_zcmop) {
> >>> 2690:                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01))=
 {
> >>> 2716:                        if (!dec->cfg->ext_zcmt) {
> >>> 2726:                        if (!dec->cfg->ext_zcmp) {
> >>> 4028:                if (dec->cfg->ext_zimop) {
> >>> 5044:            if (dec->cfg->ext_zfinx) {
> >>> 5051:            if (dec->cfg->ext_zfinx) {
> >>> 5058:            if (dec->cfg->ext_zfinx) {
> >>> 5065:            if (dec->cfg->ext_zfinx) {
> >>> 5371:        if (guard_func(cfg)) {
> >>>
> >>> This structure comes from RISCVCPU, a target structure.
> >> Oops. We missed this.
> >>> There is no such structure for the host, causing null pointer
> >>> dereferences.
> >>>
> >>> The zfinx references can be changed to
> >>>
> >>>     dec->cfg && dec->cfg->ext_zfinx
> >>>
> >>> but some of them can simply be removed, e.g. zcmop and zimop, which
> >>> are otherwise reserved encodings.
> Yes. Maybe it is better to disassemble them as usual even when there are
> disabled or not supported.
> >>
> >> Should we probe the host feature like what we do in tcg backend
> >> support and then do the right disassemble according to the probe resul=
t?
> >
> > I don't think there's anything that is currently checked in
> > disas/riscv.c that needs to know about the host.  And, as I say above,
> > some of those checks can be eliminated.
> >
> > Host disassembly needs are limited to what tcg/riscv/ emits.
>
> Agree.

Hey Zhiwei,

Did you follow up on this?

Alistair

