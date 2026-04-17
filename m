Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D8FF4368D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh5t-0003Iy-Gx; Fri, 17 Apr 2026 07:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDh5r-0003Im-NH
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:10:39 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDh5q-000596-6W
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:10:39 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64e87a81639so544666d50.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776424237; cv=none;
 d=google.com; s=arc-20240605;
 b=V6CPleK5tIFoLydLZ4lKSjrLirJM3cf55g56oI9OKkiiEBg413nZrHhFYy87n5jBjT
 DQTuJTojqFXrTKTEIHeqbNUXAmZA63Z5zJxrUpzcV7yQ8OIknOn0wcAbjkuQLqz6ww8E
 2hAMQpP9G25ES0tousQy2eQMxXfS0V6zY9xU0V+Ua0XIZpNGXTkmFwBfEKbYQcpaUyVY
 1zn4Hig2BpOX3v426QphbRW06unR6bYFSEwdK7aN43/lWsalwqG1+nkT9D2s5sqgu+86
 aHB5CW+9GCFaD7Ce1TCiN7pIQkJVcG8A4mQEEVV8+C6jNH0l+5emdpi7BNX9HMQAPArY
 pNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cij6y007mDu+PmjEqlZipzmcf7SbTqqcemD0dmQoJaY=;
 fh=we6erNTLm1HCUnqNhKVhSBfAycLgCNsGPlCyTs2iRXU=;
 b=QpLfQnB8gHZwY5vRMIb2EanozxQ8G059rP4OQWKBy/bnLuAy8Jk8NzbV/Q8b7B/cdj
 3JiBN1usKwpttS3yKWK0gA59LLGieQ9mDvVKcLUXrAwI+Nn3e9PrU6ryCHjyESUdiQQz
 aKbPyJUDmuZ5A7upL0e3oNYYXkifiauGsLzrGnvN27F5x+ut5YOm4sx6wsZC3MDy4OPf
 13mWnm7tTHnKhj8ej4T73NEndQ9fAxKJAminnVu/WBBsVWopI/C4bVp1aJJ60UR9+xgB
 ninv3qvk5FTMTHvii4uJp31SRFbJE68mIBgkyY5aPqccmYLbXgLrnENwvWWT7Wi08HZ3
 MlxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776424237; x=1777029037; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cij6y007mDu+PmjEqlZipzmcf7SbTqqcemD0dmQoJaY=;
 b=oXIz26xf4XpyFiOPjmBTLDA1W8VqNCB7DBgZGiauUsq7WDsUF2VSKHVnbQMwvLmy0g
 XTudhvZtGDsJM7fHouaBsCKy90MyzU6HuwPFLC7LkTyuqgrW73tE2HqVJVUC58ILGKJ7
 QTEuWS16c20iERbo5aPShFyWj5MeogTylREK/p0A2r+nJf9nFnWHbMHfGdw1ab3m6ZWh
 qJVdtFz2DeotE2rSFjf8gfgU5SrWuK1qgABFMwtcITtZyfjUsTp4Q8cJNqzmWAwlRhas
 7D1m7Nnv4pNN501WUJIIV7uA9RwiR7jmhyZLiDNQbJ08aWB4l3FZnoI1JxYMbIt0lM01
 0Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776424237; x=1777029037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cij6y007mDu+PmjEqlZipzmcf7SbTqqcemD0dmQoJaY=;
 b=sb26Yj0cBNf1shzsJloDW7cfgg/sN2ZX6fb2Gg2tbRKz9fm/dGO4jlQCm6lD5dKbyW
 2gWGjgYWw648hsn2a3lNo0mTOiynSdvStG3NiW02a/Wdt55RXoRmtRHoxksDL8eJOj/X
 cDzOLzCME3V80PP/hDzKQCjwZl19NiIP/DQvibT256N/5ZyzIAmelSyl36jigCPEONBM
 vpBw7YuPawCKUzLJEFq4b53ev+h6KHw2KIdSWM7SL3W8RsCFB6I9gzlGXZFJQE3q5W2g
 jyvm1RruVTXo9QnF1jY3jAoJxFOz+x/Pp5mms3xPMjs/KC6wJemZf+XmdV8jQFEMVkCG
 h0Fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/V5Ij2OO/aDV19MS3lpu6oAxfH+rWKDxeJAVHeyGl73PxXAhz8v5cTdfbFw+gau0EnYfdOyvMPzHnC@nongnu.org
X-Gm-Message-State: AOJu0YxjAnednpOu8uCv5RE7xuv2N+Xz/U2Vew6xKQ8EJDWFrKuMyoyT
 fjodn+O5txJulO1wP/qtNuag2KPQmZCw80xsbHU+85OcE+0OLHbVuqOuNF4LD5Rs8ImizKM/MJm
 5b2L2LZt4N4AA7n9OKR0WHpsPiEFHaAYZTdinbFau4w==
X-Gm-Gg: AeBDieupA/eYtSmWalDpGYpQ5jwk6PTphO2fZLi6Mib56JVSpPQnKDATa4IcVBVhkPd
 NxSqQfct/IrTlQe7yivFlN3W8ZIwWPoUm5EcSvWaU4/LG7YFo3BM2wFHI/KBlZso6AN4BnOi0Tj
 UBmbnamuIUeX5LWqwcSsb3xmwBPw/EMftmZn5M86NDnyjH3wB0ahXTmhFxD9FJrez3CDH7ksOlw
 hOfgzTinNFEYDFPfblila8nE1w8xrOXGCb2PfGKODDL/gcNM+D+wtJPowOIaLphTjZJ91L0GYA1
 KexTr0hJMgd6L0ji6agaT8lNZw+cljwsXIZrxfkadgGKn/4DpbBruQRqSjdRt2sqbQmfoDvfp3z
 X+moYco5K02mh
X-Received: by 2002:a53:ac8a:0:b0:651:d383:3f13 with SMTP id
 956f58d0204a3-65310a0aa98mr2293164d50.39.1776424237012; Fri, 17 Apr 2026
 04:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-11-peter.maydell@linaro.org>
 <58a32864-6c05-432c-bdc2-5763e32cda99@linaro.org>
 <02e21af2-d6e8-4418-9cab-af56c81afc27@phytium.com.cn>
 <a75dcca3-9cab-49e3-818c-4d52c2a1bdd6@linaro.org>
 <CAKmqyKMf+RhUb_jzOfTVCiQV7EW25e5z3C1fjdarcWVS3V3-7g@mail.gmail.com>
In-Reply-To: <CAKmqyKMf+RhUb_jzOfTVCiQV7EW25e5z3C1fjdarcWVS3V3-7g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2026 12:10:25 +0100
X-Gm-Features: AQROBzDElH1LL0QhQTP9anOTeyhJzsK2A4_eZx7ppOHTfqXXJdA9rB4aefIqeQ8
Message-ID: <CAFEAcA-P1aw7+pwVCrbCqBtypGUM+KTNoZTErXXLW+cKdKa7vA@mail.gmail.com>
Subject: Re: [PATCH 10/28] MAINTAINERS: Remove Huai-Cheng Kuo
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, qemu-devel@nongnu.org, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Klaus Jensen <k.jensen@samsung.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 17 Apr 2026 at 10:58, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Fri, Apr 17, 2026 at 6:59=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > On 16/4/26 18:07, Tao Tang wrote:
> > >
> > > On 2026/4/16 19:28, Philippe Mathieu-Daud=C3=A9 wrote:
> > >> On 16/4/26 11:16, Peter Maydell wrote:
> > >>> Huai-Cheng Kuo has not posted to qemu-devel in some years and did n=
ot
> > >>> respond to a query about whether they still wished to be listed in
> > >>> our MAINTAINERS file.  Remove them, on the assumption that they are
> > >>> no longer active in QEMU.
> > >>>
> > >>> This makes "PCIE DOE" orphan.
> > >>
> > >> Cc'ing Tao & Gustavo who are working on Security Protocol and Data M=
odel
> > >> (SPDM) which IIUC use DOE.
> > >
> > >
> > > Thanks Philippe. DOE is indeed relevant to SPDM and RME-DA work we ha=
ve
> > > been looking at.
> >
> > Commit 4f947b10d52 ("hw/nvme: Add SPDM over DOE support"), described as=
:
> >
> >      Setup Data Object Exchange (DOE) as an extended capability for
> >      the NVME controller and connect SPDM to it (CMA) to it.
> >
> > introduced the docs/specs/spdm.rst file which isn't maintained:
>
> Urgh, I can fix that.
>
> >
> > $ ./scripts/get_maintainer.pl -f docs/specs/spdm.rst
> > get_maintainer.pl: No maintainers found, printing recent contributors.
> > get_maintainer.pl: Do not blindly cc: them on patches!  Use common sens=
e.
> >
> > Would it make sense to move hw/pci/pcie_doe.* to the SPDM section
> > instead of orphanize them?
>
> Yeah, I think it would make sense under the SPDM section. DOE can be
> used for other things, but right now SPDM seems to be the major use
> case.
>
> Would you like me to send it Peter? I can apply it after this seris if yo=
u want

Thanks; yes, I think my preference with this series is to apply it
as-is and then let people send in patches on top that take
ownership / readjust the arrangement of / etc the now-orphaned
sections.

-- PMM

