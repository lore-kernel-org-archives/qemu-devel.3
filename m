Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C147606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hIkP3KSN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKCSf-0001jd-NJ; Fri, 23 Oct 2026 06:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCSc-0001iu-NW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:25:18 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCSZ-000587-JV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:25:18 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8ae8607e8afso5467447b3.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792751113; cv=none;
 d=google.com; s=arc-20260327;
 b=DKt/Rg9baMXqm0VtPasJArhWJ3NHiNpuTxGShpIfwtxhlnDpt+O7xQFlABkXh1psuk
 KWoG+wcgavFiVXps76sb0/jVZKb41/7TO0EGSZvCPgUoqrMjb6CE5BAHqMCirFmsUbYj
 ZL5BLc7o8SKUhQI1LOKYQn8t/RpKg+AqumMNKiILMj4e1q+dBPDkscadm46DPk7aAIht
 P6nLOYQaKMTnU4pcdDuIip3PGTEgMn5OEINSu1iX+fxO/gsiJXyImMP4ze3R2q3rGvmV
 lcH6B0hvci5KASmqukS6lCg7rq1wMz4LwQTzB0Btz78ibGMfc+6Xat32qO8lQj+AKPLM
 Uhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L+EW9eOKSKxO+de8ddVznNBy7QGtDkeAxVvnBQdsJ6Y=;
 fh=gREritCzZWvcfaWqpktBp3/OUmb0rOUSRfa2BWEvW68=;
 b=jo282wZWYKFqt1Gt7VFErxELWNTPxmUXleTtSPytQLqbsSpIuWgZSW+hYxkWxhkV6P
 5TaC0K6msBbk92dcSK1yXkUeovnEwHMAAfv2yb1xsCW4VIjggiMvIw0tL5VuYJoJexrC
 yLahPxVQSUtn7tplhWuhwOIb2sJRUQe90iHsc8o/qe4lkSuKP9579La7TRKIsRKjWk2T
 w9gxW0mX08EW8F9xprjYzmYJzY+B3jbfw8/X3kWWvFvLG//EktxFHEHo/XXdU6Kx0lzO
 Jzm/3whdH0ZSpvoiafuoO/pDy9k2rR5rp7zHWgBE9L/l4jbTlj1aCg3CMc+fFuFtXTsy
 2p/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792751113; x=1793355913; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L+EW9eOKSKxO+de8ddVznNBy7QGtDkeAxVvnBQdsJ6Y=;
 b=hIkP3KSNR3hUyGzU5Y97EOtd6KBs5wRaHca3+PBmXhpzR7aXxZlWK4Oa+jFw/XNVJp
 7iKj0znFl7vmvqYCY0Vn/JBEdrsBAZCgSqpOuAd8D4e/O0UPwjEtc590Aw4YYxqhOlTq
 GKLKwpK9EuxYY1FmqxKNKc1ig/nrJgp+dbLJtdESu4xCwMJedBqf1az10mUQqkgUEJLe
 W9yrBxk6ECBIs9vn2E7KGMYMYU5WpKvFtM95weIHOLWC/9cAyFCooaxqPnWrxkEYMWoc
 sC8VYqkP+4DUVAgKbDKkjirCjEn4fhd+M8vLA+BaK1sbAIispPdloMniKrTxQ9d0Cutu
 ogQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792751113; x=1793355913;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L+EW9eOKSKxO+de8ddVznNBy7QGtDkeAxVvnBQdsJ6Y=;
 b=cpqF9vNVJW5ZUvayN9rURoNkp5XOReDvAop4mT4F3SodJvo+1GWie1tx3IgzCq+e6l
 72omMF6zObUBVLAx0jfZMXftxZgqrmFukF5/d/xn1lmMZMwE4yEwV/d/zn2RQ7U9aNTX
 OWv8M22+A5c9j9G7XpPmMM6YP6rj9jupJiy1V7dvt+DlupxxeJ/sAW49rr4S/4d/Vo1+
 nzcYzLRbGiHgvtGG/3xbY3VZ5dw6AdE1R4e4nqYsj31r+KrhuRIEw1nAv1Wfchy3QUBM
 LTyUId4J3mtt2XFpDidmxio8w/jhwJRhe19eAEKizT8/0I+cB3+aoFsZI6u9Ew1aNEd0
 HVfg==
X-Gm-Message-State: AFq9FYKyGFopkBoFNxSnWPpnRqRIJ/qpdgw5csM3YRqC8uy7jrCg4hti
 ZbKgfTjhDp/pwhXQ8Mv9T7EOuRYbr9Vptp0rMg1O4Ez/mSAa+T7fC2Al4ZtLCQUc4uI+rtAxtGu
 t+2yz+e4f8CEWHFP2i2QOY48fyW0NdGH2fDsZ+95sRQ==
X-Gm-Gg: AYBFou1uvXpOQSdlIsS+zaUrVSLjgHRYQwPVt2btHAjpSggtvZ54gZC+KIbudQcBW5Q
 rRtUG1O+KANpDPSXiX9wboHDdku+4wyGZKxSyK/tCqkFlODd7TGpxVeezxiPgVzc/hmA+gTIWDo
 ekOWeWUtZcLUcoDtCBSZkjTeMTobLkRBLPoaKdmIrsvBfcSNZCOgxYgIYFYWxeytPQFQv/VAUpO
 VPFpfggQFBXimzxMqDk0gAa2Y/DNKTK7JhUb6Ca2tpW8rS1T/8PHRVVOrd8T72TGIYnYp+ciIBt
 IteJ+fWvn9oBZP16qwSoEOHybTE86ui42/PPIG68aDKtMYiNSyVHeUSwMI7Ts0dSeLp7/ka4/Vl
 RZFBVAT2kHdIxhs16GhLi1S0/foM94BHzSJqWKQeYD6/WfC3W0B/Q4x4zZGMGrNsQoi1T7YDxFK
 4D6v8xYJy02Q1T8RLXo2su
X-Received: by 2002:a05:690c:458a:b0:8b0:a352:f979 with SMTP id
 00721157ae682-8b157dfbee0mr8997407b3.29.1792751113580; Fri, 23 Oct 2026
 03:25:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
 <20261018133603.64323-13-marcelomanzo@gmail.com>
In-Reply-To: <20261018133603.64323-13-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 11:25:02 +0100
X-Gm-Features: AclHuK8nL322sUl5LA1kxy152bAuiATgkLLk82L-a-Udgxkx4KTUW5dfKUHF1_A
Message-ID: <CAFEAcA-skfiVQAPKceMeSBBrQo_BRf_Ls4aH0Jiu51sh_YjMsw@mail.gmail.com>
Subject: Re: [PATCH v4 12/17] hw/net/bcm2838_genet: implement GENET TX path
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 at 14:36, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Implement the transmit DMA ring handling: walk TX descriptors
> between the consumer and producer index for a ring, pull frame data
> out of guest memory, and hand completed frames to the netdev peer
> via qemu_send_packet(), advancing the consumer index and raising the
> TXDMA_MBDONE interrupt as descriptors complete.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> While carrying this forward, fix bcm2838_genet_tdma_ring_active():
> it extracted the per-ring enable bit using the DMA_CTRL register's
> 1-bit EN field definition instead of DMA_RING_CFG's 17-bit EN field
> (one bit per ring), so only ring 0 ever appeared active and TX
> traffic hashed onto any other queue was silently dropped, eventually
> tripping the guest's qdisc watchdog ("NETDEV WATCHDOG: transmit
> queue N timed out") and breaking DHCP.
>
> While carrying this forward, also:
>
>  - Check that a frame is at least a status block plus an Ethernet
>    header before looking at it, and that the descriptors of a frame
>    don't add up to more than the TX buffer, so a guest can't make us
>    read or write outside it.
>  - Check that reading the frame data from guest memory succeeded.
>  - Use lduw_be_p()/stw_be_p() for the length/type field.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

