Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CC9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 02:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOnqT-0008Mr-VZ; Sun, 17 May 2026 22:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOnqE-0008Li-6F
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:36:35 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOnqC-0004vD-Ig
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:36:25 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso2048008eec.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 19:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779071782; cv=none;
 d=google.com; s=arc-20240605;
 b=akfppVRQFsUsF9o8jRlTS6jss0h8seMuGwnA0EaOhx7lAz054Wf/a36Q7CMNmUsfZw
 4YfdRza5znX7QQrhy/Gw4N24ypkZB8Q65gMIPzhOwP+Cmc7qYWDO3INR3vvSQlpp74ew
 pkT1agTltGrwi38WlyOF3cbEQ5Aqq4CK8ziV+LhCavUMsSRgADBvlfGxitu9Ts6bPDzD
 3TD9QAqiZAMA/8rQ1NEklT4Rm8xYQu6EIYIyVZ2mm2irgL7+NrJzyY/B3wktAyGLeLW8
 EpBYBxr5wfFz7E8HMD2n386aGC7lv4so6eDCvyrrUUpK0W1QCYljY/hcUsfU9r+XhwRW
 WwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s42/zxGXCkEBx+nPVVKUkfLeCli899it5B7CqeglHKU=;
 fh=5B7mkaEET076WYem2sxgV9NDr9+NwGVcOT5DkhO2s+4=;
 b=hlEzWk1y7z7QdcKe3mNASKOI6rmCLbVUslbZoYIJ4stThAtP4IEjui7TNE8WYI0Q0o
 UBJJzESv7gF+G5VGvjbo8dWL5/yUAling/3JV/xWTFd18Hh/3v2//q3C5DIyPzoMmmOh
 Pwza2xyCi8GXI2Or0fxTqkn3VDj6CraXqoXnr1m2k7uTgoE6ddKvJLwGGQdYUf+SbwV1
 DjbgljEzSwVQy5rE/f9qsjs2012d0FDB7y912QOqowKhr3kA6nHJKj8tUmp/4F9qRNkY
 yOOaGMDyHdj1uNxgenuZ+weUr+oQZOfyXUSaPqk4F+aATx3v1IpH01x6a5ISXZSDLcyu
 BNcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779071782; x=1779676582; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s42/zxGXCkEBx+nPVVKUkfLeCli899it5B7CqeglHKU=;
 b=PrVeFcsQJBrQv6X0RZpgDHRh9HlUeroHqKUyztumOuvveO12hfQEMnT44rqmP5M03V
 WFJ5Tksjhsr5uplOnEGY639aruSOSiTRfaBvTyFG7SH8HU1kl3XS/FjUUp9RlbnxENZN
 r6ptHRHCxKeZuiVsKbgZrFpd0FWM384isCmH+Ath8EfT7I50CiIUhOhl9WSbUueev7Nf
 kCCOUiWzkG7PgQ1nAQlFQUSpo+GnqR1mPcPqYjHTYNcG5gFd9nqe50LJxfIvk2vbdb5/
 FWCz3L4K7SrECTjOaOeSGma/YQKwTtTFCHrhzFPIaP4XcsW9DUetXFFoMTrLf5xbx7si
 UGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779071782; x=1779676582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s42/zxGXCkEBx+nPVVKUkfLeCli899it5B7CqeglHKU=;
 b=cY3c39ZeifQ9F2iXNcwkLYaOnDU8XS7xMH8AhAeEn5jMn25OYHvkTj+Nt/RIKVFPWd
 B6hBaUHBcMxVi3fBppOIhqvH3BCMtdPee0ByFbWUwk/rXxSI9y2v5Rx+1E67gTMRIMw/
 t22TLbGFJv3xdI2KaiuYS0O/sKNiUgDYUJgYvfZgRHhvJFcuEnOrdzRGCyNJ0yPJBtth
 8eQbQ35giCeSnHQCSQLi2DU8apkfIJaR2hOp/XDAYAhbpAGSzCLDVujsVuh9iIjt4T9X
 3hpXYOepvAX3VqXgRWf0sLQmOImnR5AYmuyNQWItiTnfGK1t7qbMhnIZJekmXUBFOc+n
 o9Lg==
X-Gm-Message-State: AOJu0Ywk1d6kMYBYTrNstrpfX5pSY2NWFnCIdsnhxieb81pyHAgyJiJb
 nYryg1VL1soJWQLlPrxf8p7tpw7bQjWMtX72syjuIrDFSHWMBCV1Hq7mWV7Llpo27DL9Rxc3geu
 1iXdDs3xlrejTxUSpR4H74uNzrAtIAzc0zwFAWd6/EfQDRXmG+r3bIyTXsw==
X-Gm-Gg: Acq92OFZEXmioQe19FN6jFmUzJ5TK7LDLPvDDAaPlXAeiTSaLRmitev/PxRoiADRG7v
 zhaJP44wxiVfCQP403q3q5UMjbE4BcIvYent/DjEVZxv0HvF8SJEFlDFTm2TNDC5pJt1Op5QOF9
 hOTcaxNHcleSPkT2I7xEc29EQPFqYEaYNUz9vwkTl2eVwklwyRnHyaewPYUW8/w5Cp7HkzW1vtv
 KgjWm/vX0+4BPE+4yK/OpV/MrOX2KMHKXuN2nGRY2KJVoHnq/h3aVCLJgaGYDKNxZdMueHMNkys
 hTZfCigZ2g==
X-Received: by 2002:a05:7022:790:b0:133:1c42:f5d6 with SMTP id
 a92af1059eb24-13504a4d7b8mr6382354c88.41.1779071781874; Sun, 17 May 2026
 19:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251211025611.99038-1-jay.chang@sifive.com>
In-Reply-To: <20251211025611.99038-1-jay.chang@sifive.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Mon, 18 May 2026 10:36:10 +0800
X-Gm-Features: AVHnY4Lqy9x1NaNMoBVYETIledRwQn7ho7QBYnX5rqDTpm7IJ9ub3Pn8gupFdLc
Message-ID: <CACNNAjNV-ffHE_Vs7BOkgC-ff+j4+uz8tX9Zi2xGfPuLfbKdpQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Don't insert DDT cache in Bare mode
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="00000000000096bf7e06520e6ddf"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=jay.chang@sifive.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000096bf7e06520e6ddf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch.

Thanks,
Jay Chang

On Thu, Dec 11, 2025 at 10:56=E2=80=AFAM Jay Chang <jay.chang@sifive.com> w=
rote:

> When IOMMU is in Bare mode, DDT (Device Directory Table) lookup is not
> performed. This series fixes two issues:
>
> 1. Avoid inserting unnecessary DDT cache entries in Bare mode
> 2. Properly free Bare mode contexts to prevent memory leaks
>
> Jay Chang (2):
>   hw/riscv: Don't insert DDT cache in Bare mode
>   hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling
>
>  hw/riscv/riscv-iommu.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> --
> 2.48.1
>
>

--00000000000096bf7e06520e6ddf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Gentle=C2=A0<span class=3D"gmail-il">ping</span=
>=C2=A0on this patch.<br><br>Thanks,<br>Jay Chang</div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On T=
hu, Dec 11, 2025 at 10:56=E2=80=AFAM Jay Chang &lt;<a href=3D"mailto:jay.ch=
ang@sifive.com">jay.chang@sifive.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">When IOMMU is in Bare mode, DDT (Device=
 Directory Table) lookup is not<br>
performed. This series fixes two issues:<br>
<br>
1. Avoid inserting unnecessary DDT cache entries in Bare mode<br>
2. Properly free Bare mode contexts to prevent memory leaks<br>
<br>
Jay Chang (2):<br>
=C2=A0 hw/riscv: Don&#39;t insert DDT cache in Bare mode<br>
=C2=A0 hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling<br>
<br>
=C2=A0hw/riscv/riscv-iommu.c | 34 +++++++++++++++++++++++++---------<br>
=C2=A01 file changed, 25 insertions(+), 9 deletions(-)<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--00000000000096bf7e06520e6ddf--

