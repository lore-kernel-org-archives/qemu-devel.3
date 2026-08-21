Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441DDC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 05:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxHsf-0004BI-BZ; Fri, 21 Aug 2026 01:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wxHsc-0004AX-Hm
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 01:33:26 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wxHsb-0001fa-1K
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 01:33:26 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66c7a743cf8so782862d50.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787290404; cv=none;
 d=google.com; s=arc-20260327;
 b=ZGRy8KYl8k4eLjIA29d3+qTS6LJoggMTPrN/AWBpyu0dGAu0sDjevKXrFNphtlayfd
 IfOYtCn3zaOhBKAUfFaXG3ggRW1CnlppB4nyz4G80KoFFcLMON1DE7GSatp5rCCl7AJ0
 Nvjx9wD+kfrSYIzM8QS453eR8gvWtmibQiMs+nVKV9F5vLQXptQsO38z2ia8w8npGRkI
 XMmXhY7MK8X4s36ZIdEjC98WDq06dMmtasTt5UMZfjRZETsogMsEDiF374kXtDdhD217
 tqDn7pKfIGK3koMhxnu/6pc0UW2cqBrP3bLAwSqHKSpVDHVQdZK2oiSC05Q0fIkS5jDS
 DibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hbn6DbDQGksNHikGVpR+3UUDGmghf0y1+rLu5GxTDKA=;
 fh=Wj0rygHhueyLjVs4Ur34oY4LujiunqdvnSElvB6Rr7g=;
 b=MrmojdEl/x/fc05FZKtqUm62R0Cc1JUEe5/QNM9E+UrO+L8sOEH6m56WfRBM+dsTbU
 6W+WLHxk2pNqAJbqG72A0N5hcGMbvrJRJqCP7HdMCFbwZ1akMmJgjS35dugvAPIqghYu
 ohjP480mu+nXEeHjXfThmtmMRAYhim+IyUPEFwaIKiMx63My4rfRyjiHtVLdsWjbJiyq
 you5goPjr0cgDOax5265VyhFuXfv8WoeOhw+YQVFtdXsOFDFfhalgP3bPmU2b3ddaHoZ
 HSIfQKVH0Hg4z/Y6as+sqnNWqpMpqEdM+6NXTFH5LIdPMt/sAaT2CSWOWx1R5U9m+HAK
 vsng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787290404; x=1787895204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hbn6DbDQGksNHikGVpR+3UUDGmghf0y1+rLu5GxTDKA=;
 b=Hethdn2jMEcMa0uB2KiOgZZX1ufx+2meW0dI4y6KS2FmlVO8nFbNsapLVjBYRoZKfT
 rRhQS1yoLsh/obj7h5jptLmUDjuYxmhNMKDZh7GE0Yg7qUkO8egj8teYn8akGGEc/mK9
 6BvQ0kHlch2x6ZtsWwjXq9mjrhUc0+Km0Hv2TIqPEtriOcJrFrKYJwuXJkPcom76fm3j
 1yviI0doB4Pt+Hvxb1LTNcQx8CJWaltJzWpSonRmZpRjSeoXMoOsneZHpsf9JSlco5t8
 j/BxhSs0YgiEaJQJ/vJAqWDqJQpZd0Tn4XzFxTJPpuhhhMlmAsIGAILTyhWA542230sV
 DkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787290404; x=1787895204;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hbn6DbDQGksNHikGVpR+3UUDGmghf0y1+rLu5GxTDKA=;
 b=rj1fJX5OomN+bmcxkD6F8Pkhg4ztnVybTbGXZAnkoEAYlHxxm+R5erLknvJwwQtAhI
 hACIdhd3vtbkDj74VxCPLoYPt2zgvZXQ+IL/AFPPpt+gJkIf+YeP03q+ZiNGCwRts0JO
 MxnZxV7Zc4th9WLQbfBU86WqfTl7o6UfmgNwzY8TM2d+R4HH6hO/VZublW9l0bgw8tnX
 W4QjPwzyVqmLw7xeMOawbYKWQvk1JDIOvUVrPKHplfgFc/bHImrWC+htKhRZVFYOBngq
 0VlyXlWfQADa+f4gGTInq/T38pww2gBzQV4s40Ghn2/mtFLH7YNilhmpu8E2gC4MjMRS
 ASEQ==
X-Gm-Message-State: AFuF++lSXdJ0WjLq4dxXbBfVjNTtN8yK5TKNLnLGc0TyqecqIv7LD9lq
 a5pfXJid61togxBQPw5WKVr89aqrjePeWnYHacQyOgKeTS+jTQhv8vntGy4Fjp5HkN0HV+8deJa
 8BSWgIxuTvA3JGWfnSb/Hy4Z3DFNZE7Q=
X-Gm-Gg: AR+sD13GhW4sulUC0cxc9Qih2bUJbAjdMUdTnqZW56nureafEJiIFAKK+DpvN25g8qn
 labXp3Dnzq7u1Nw9LocslbXEUYnqHGgU9SAG3HNANtPM34LPpraKxTfxJ+4kT4zGDcxKAowJmb0
 DmyAn/6fNBxIZ8rAOo1zCmrems6eyzBEPlWeH2hX+TQ2QbIjCBC5uzZs04BdSu/4zqWx67OMkAA
 891I38p62Wjz0Xultuv5apfefS3b1rK3zMgzZ6qMeYjXeEbywONmzR1pIkrmiiEKp1vSOzFvlvz
 IL+F64BptRhWMp4agwQA/QrXKZcwKa+1GLzkk5r8CUKiAw2UEJFFTff+pKDkjkhf736GWbNkBQC
 qacQ=
X-Received: by 2002:a53:bd41:0:b0:668:894e:4bf with SMTP id
 956f58d0204a3-66cd69a2a2bmr3183044d50.13.1787290403849; Thu, 20 Aug 2026
 22:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <20260808182956.290561-2-flamboyant.h.01@gmail.com>
 <3ed04624-9d4c-4c11-9d7b-4bb6568b2590@oss.tenstorrent.com>
 <CAAW0U4Z4hSpbC62xE78PJjJPQKNh+7XxF3-Q14QzymELedxhSg@mail.gmail.com>
 <7f691e05-7512-4982-a4e9-a1ba5f5bf823@oss.tenstorrent.com>
In-Reply-To: <7f691e05-7512-4982-a4e9-a1ba5f5bf823@oss.tenstorrent.com>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Fri, 21 Aug 2026 13:33:11 +0800
X-Gm-Features: AcwNN1WEoi5Ej1uZ6hPdurQqz3aOtAqNmg5ZjQcp_LX5XTFpBP7uIUXd7vCqEsA
Message-ID: <CAAW0U4YzxrDA7ukyaSzPFuAW+Bv3NPNA8hD7ApjC=mr=7S8PLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] hw/ssi: Add Synopsys DWC SSI standard PIO
 controller
To: Portia Stephens <portias@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yx1-xb130.google.com
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

Portia Stephens <portias@oss.tenstorrent.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=BA=94 12:53=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 21/8/2026 1:56 PM, Kangjie Huang wrote:
> > Portia Stephens <portias@oss.tenstorrent.com> =E4=BA=8E2026=E5=B9=B48=
=E6=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 09:11=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> I don't think this will work for frame !=3D  8-bit with the m25p80 fla=
sh
> >> model used by k230. ssi_transfer() takes a 32-bit value but it then
> >> calls m25p80_transfer8() which will just transfer the bottom 8-bits an=
d
> >> drop the rest.
> >>
> >> I don't know if this is an issue with your code or with the ssi_transf=
er
> >> function though. It seems like ssi_transfer intends to accept 32-bit
> >> values.
> >>
> > Hi Portia,
> >
> > Thanks for the review.
> >
> > On SPI_FRF: you are right, the explicit clearing in dw_ssi_write() is
> > redundant because dw_ssi_write_masked() already drops the bits that are
> > not in the writable mask. I will remove it and add a LOG_UNIMP warning
> > when a non-zero SPI_FRF value is written.
> >
> > On the frame width: ssi_transfer() takes a uint32_t word. The issue is
> > that the DWC model uses CTRLR0.DFS (4..32 bits) to define each
> > transmitted frame, while SPI NOR is an 8-bit consumer, so the two are
> > aligned only when DFS is 8. The K230 SDK SPI-NOR paths use 8-bit
> > frames, so this case is not exposed by the current K230 use case.
> > Maybe either add a DFS !=3D 8 restriction with a LOG_UNIMP warning, or
> > have the DWC model split byte-aligned 16/24/32-bit frames into
> > multiple 8-bit ssi_transfer() calls=EF=BC=9F
>
>
> I think either option is fine. If there isn't anything testing the
> variable frame width it might make sense to just restrict the width to
> what is tested.
> >
> > Thanks,
> > Kangjie
HI Portia
     ok ,thanks a lot
Thanks,
Kangjie

