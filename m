Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D69CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIOOS-0006cJ-1p; Sun, 18 Oct 2026 06:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOOO-0006ax-Dg
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:45:28 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOOL-0002A3-L1
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:45:28 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8ab432273c5so8952357b3.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 03:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792320324; cv=none;
 d=google.com; s=arc-20260327;
 b=iQZ54B1jqBMLsQj6ik3GI7kxWzFxI+SJyo4q71F7aZcTeWcjhlBy+KRREg/95lBtwC
 eiJVubm5dyI02B3VTCgNBtT7aOTftMtC2rZEmIeF7tOO/LLBN9Wp6cNyACrEJOZQ/VLr
 doccV1VLsl69YqCbQuZKxzG0vo0jonwoC002PEeMEzdbRRNetCmFvd5xqKGrEJEpErGM
 x6Ocvci92M82U90+Wc2Vh7NryLydYkBL1LWI6PIeC5DBFGNg0L0K41PAxSaRcr+FWwXi
 TnKIQBnfKcI/NaQhCj88Toz68XHIk1f2fJ7u+cW9xfLC5y1lQPYo7XJtnDtjvxV6ZM6A
 sjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DDZwfz0oJ9cj7LCVcAOnZSAtyuxKGOxCV5kvOoYqfW4=;
 fh=dHN1FZJpb1BHRtRBDcpEyrvNB3hUuCjyQs5YK6bCL1Q=;
 b=SnbCPxiset2eDPhpodbe0F4OdmS5yhWZdj+O1Xe1dvGab6Dn4faBW2ZfsrmXLyfx0Z
 u5/3pJ0G7HM9f5gmZXPKYnr9m9P64k4Cfft4WSvBs3AcEH5tvKs3QR6Ck5UN64vqJSlL
 tAB2CrPHkeP9r52kNqWyfmuv/BrvbR+cuo/SDhonbCFT4VlWoDKVaIQTcSgkjH2tMia2
 it/gqYq06gVIJY1NHoxc6Fo/F3E333oT+LW/EhtJ4gq8CMHmTG0shbwmibnww3ACILR0
 jsJfMtn0MFokt+uWl1ySSL6ZJnrjabWCeCW+85Ssd9xsd8ve4aaCHZ6dHIJ5nlulRb/m
 gDkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792320324; x=1792925124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DDZwfz0oJ9cj7LCVcAOnZSAtyuxKGOxCV5kvOoYqfW4=;
 b=IVUGKFL82j5y2Y3OR6ofj2G/R9ERtR8KwYCFOtpjTT4jTPGQ+S82lM3bxGaXKvL+Ks
 BzDah3a8g+C7RhyD3NA7uWTKzoJE23BKCXQ4FSo5+v2QC1W+nuBX5hJWp2SBZFoOheu/
 RvijUHwudw3PDo3dGnLCmHuqCXXS585MKsBOOaeTeyQ+6vJlNNuFGUHyq7EJvZTMtuwl
 6zsNK096g4FMtRAUIEQzbONVE59B9KSGS3HEROWnDf+wmzdfmRZKOvWKxl8YJGI+TdI3
 EMiiucgvFdci8KqR1ZcRPntIcVUvA5EN2xvgjYlGIXj2SitWTeCcKO25xJsxM0X0iVqr
 D8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792320324; x=1792925124;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DDZwfz0oJ9cj7LCVcAOnZSAtyuxKGOxCV5kvOoYqfW4=;
 b=pZm2d2wXYY7z/YvO1EbKr2DvhJS3EtmMNmkzUoUhPknQssDVX84z/0cJqa6g9tS+os
 oZjlpG6qgTjPJpvxmoXUBKdV6C+2LlPVMaeawS8np6vzYmOkIkcRHRUiGCkX5/z5mjbK
 eWyFJPTiNQ+WGX3uh3v4FCMCDFU0vFOg/v2ZBlUUjabgvvQubzlEdAJXaaPf+5saDy1/
 oy8mUGXnixXbtAN76mcLl6BP48uJQ9NDSPYosHGaH0KtMqV9lL62v8ghCflMu+JBv74K
 6AGC5H/UXJwLvb7wJJqgoBJExPtmvQku+PyEOrn4dA0b/D55VZcc2ahm/I47/vxS6VQ+
 6DEg==
X-Gm-Message-State: AFq9FYIGNOtDn37tN/iOx51fNjc33q+BLTn4gHoCZXb74OCD6LKHCPzg
 jZaUkwccBTgBehRPkuF2OLiTmbywtxrrZV8CR6dxqu9Urs+HohGukEfm0lsRoHXSYXIaLaD/fV6
 2XccnKSJX956SDYoO7is07znvX+9E+yvjfXRWtOUxxg==
X-Gm-Gg: AYBFou0mKLN6SvSOI2Z3SoTN8yEWztUN3Ue5v/5ELkz0Zsk/eh8mrNJnBlEy5SmcKt6
 hnfWQHz4Poda9dyvf1fX0ZKrZceJH1ySqWddMtcmJsLPCbIYyNy21W3a7SLU/vTcF14pz0m4ex8
 9rSC0rcKe5v4QG8SdrmwYW9SgVwGfmmqBUMjFFb28AkEXGtbNieHR1cyNnf4UpaXbtOnF/R3orZ
 hS+T4QcAR2/VAKbOLK8cHL6KRQbTQw/A6nV0rXxwlD31scBjmRvElEsitdn3RvH4FC9r4Ls3++6
 2UVzCTvrlyysJK5cc/qV8W9EkHgWjgkN47BuFsQc+t+9z5WdCbv2Anvw9KvE0Jj0td//K5LNoS7
 wf/RvX6FcWyEmkayoOuCJvXqgoY2k19b6xb3nnag=
X-Received: by 2002:a05:690c:dd5:b0:87d:b776:c659 with SMTP id
 00721157ae682-8b0f214022emr14634037b3.11.1792320324161; Sun, 18 Oct 2026
 03:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
 <20260918101158.42101-2-corvin.koehne@gmail.com>
In-Reply-To: <20260918101158.42101-2-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Oct 2026 11:45:12 +0100
X-Gm-Features: AclHuK8tuzheOpj_BLQlx4udrGn780m2i4dg_04pgAOQKjT5w-HjW_ngWY39jdU
Message-ID: <CAFEAcA8jwp0OJO_8v_06hBm0nsWydxt1NuQ6b_0csKL4UkLf5Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] hw/misc: Add Beckhoff CCAT device
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin Koehne <C.Koehne@beckhoff.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 18 Sept 2026 at 11:12, Corvin K=C3=B6hne <corvin.koehne@gmail.com> =
wrote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> This adds the Beckhoff Communication Controller (CCAT). The information
> block, EEPROM interface and DMA controller are currently  implemented.
>
> The EEPROM provides production information for Beckhoff Devices.
> An EEPORM binary must therefor be handed over. It should be aligned to

"EEPROM"

> a power of two. If no EEPROM binary is handed over an empty EEPROM of
> size 4096 is initialized.
>
> This device is needed for the Beckhoff CX7200 board emulation.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

Any progress on availability of a manual/datasheet for this device?


> +static void beckhoff_ccat_dma_write(void *opaque, hwaddr addr, uint64_t =
val,
> +                           unsigned size)
> +{
> +    BeckhoffCcat *s =3D opaque;
> +    dma_addr_t dma_addr;
> +    uint8_t len;
> +    uint8_t *mem_buf;
> +
> +    switch (addr) {
> +    case DMA_TRANSFER_OFFSET:
> +        len =3D s->mem[DMA_TRANSFER_LENGTH_OFFSET];
> +        mem_buf =3D &s->mem[DMA_BUFFER_OFFSET];
> +        dma_addr =3D ldl_le_p(&s->mem[DMA_HOST_ADR_OFFSET]);

If I'm reading the code correctly, the dma_memory_read/write
accesses to mem_buf can't overflow the s->mem array because
len is at most 255 and mem_buf isn't close enough to the end
of s->mem for a 255 * 8 transfer to be able to overrun.
But I think it would be helpful to add an assert() here for the
benefit of readers and static analysers alike, e.g:

    /*
     * The DMA buffer is placed such that the worst case transfer
     * cannot run off the end of the mem buffer.
     */
    assert((mem_buf + len * 8) <=3D (s->mem + sizeof(s->mem));

> +        if (s->mem[DMA_DIRECTION_OFFSET] & DMA_DIRECTION_MASK) {
> +            dma_memory_read(&address_space_memory, dma_addr,
> +                            mem_buf, len * 8, MEMTXATTRS_UNSPECIFIED);
> +        } else {
> +            /*
> +             * The write transfer uses Host DMA Address + 8 as the targe=
t
> +             * offset, as described in the CCAT manual Version 0.0.41
> +             * section 20.2.
> +             */
> +            dma_memory_write(&address_space_memory, dma_addr + 8,
> +                                mem_buf, len * 8, MEMTXATTRS_UNSPECIFIED=
);
> +        }
> +        break;
> +    }
> +    stn_le_p(&s->mem[addr], size, val);
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

