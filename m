Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277C606D802
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E26kgrL2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOYiC-0002PD-2k; Wed, 04 Nov 2026 05:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOYi1-0002Kw-S8
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:59:15 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOYi0-0001EU-7v
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:59:13 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b300713befso4671487b3.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 02:59:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793789951; cv=none;
 d=google.com; s=arc-20260327;
 b=rkIqZISSAD6znvbjUqpzd0jTL2mYC4KJZMQo52MS65BOFJ0/NfKMOmdwib4niIPr11
 HozlcZ3vBPzO8NNj6A8PQWihgHl0dSzilNroqxhnEBBdqu5kTFrZ5E3CwPJVj6QoUJQS
 DBNQ8uFs3z2nbpaSfijTXYZkfCTWMrDux/HytcFGq2pjFjUZXt7K9/ZwCMDDjSLf/yVK
 CiYo7N+0JTJNsbNKNi/XQuruv7MeQus1OM8kAf1w2RS1MT0Ql2bUVMpxMbcbSafYkNPf
 0VltXZ2SPxDmWc7WGATLq+Ks2slsJgk2asz1HUBtmkLwnP5xYLXfXNVd9PMGzmYf7HnT
 0leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8EjsKO4Ys6eTIUKW8O0PUeaW0sPxiklv4q9geffP00E=;
 fh=X7nx6OBeDN05stjY6agV/NGfx/8K/NQXVEOUG5l9CK4=;
 b=mbMY0DEUCqBDyGAKs9mzXAWACB1TUV0H0nUCQsUyF1jqIXsBtmM4Q3UfGwN5Aq/R/7
 LulPzAg7UDD2Hrxg5ggiLwpG4RMvtU5PtNrqShT2w97nfIuOMQaRPeKY6sDcn5THz2/B
 QceGHIgJ1Bl28XdzakcvAT7mEfEB25sXBt/IoV89NXoBUfaiCwJ0XDfcGFxKfzgaRIqy
 ZamH6T+3wAWQMDJStDuCL8zEmKtmE3ynsv+kZWEwGO8LmLLrQxOTOauwn3onWwV8Yk/u
 WOL2XtfAz8FCndBl4IFJitasH2QkoHMn43N/1FLTMDuosIv1DBzOwu9ac5YMZSCsMQmz
 //vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793789951; x=1794394751; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8EjsKO4Ys6eTIUKW8O0PUeaW0sPxiklv4q9geffP00E=;
 b=E26kgrL2/br03+rPh9fw7iWpOxmDygReYjeVyxYpQD8ybk0a0PBsKVu8umrAnlP51P
 4HOc10gxLi+suASNy9Y3JYcnJ3fYnXpOdzfGQF+e7RO9GEvH87f1kkcYyKK55ssNnsgc
 +4TYkuFGFoNhZn1YRIERQAI/T8YoV/HfVKn3kJYaRfYuXGn5Z7lSDQQwSJA8MpocjHtO
 8XQoMTLN2f62fS2oJvZvhfKVFdgOvwr/5FJg6jFMt7Vo8ekjGSiUR7CJV9Yh4hLtyRpM
 srEUzQKbBMynJfTdO3qJz+wSJ0Z2FH7nEB5BZ3bffxyPJfHppaS4BC4FGu1am4hR6YE0
 gnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793789951; x=1794394751;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8EjsKO4Ys6eTIUKW8O0PUeaW0sPxiklv4q9geffP00E=;
 b=TF6JCK4wVB5CkGA/J0xXefhYQAsAXBhb6CpyoIPKg6kDJhYJoTvGtMGFq7J1oMxXIv
 asphwdwQVbscpfwpALF9rnahb8pbmeTITrFPva8Z1iu+r8LXpnDw7MaEKYoqlR8ku2hL
 VXViyJBQD/UuLGIWPRTm4VRjBo8nazsRCyIqYfi2xkbjo8U56SsLyP/LR6Y8uzl+WRO2
 pSwhll653YLtWAYsPuo3RmbN9dyyaicubJF8k7Sm1Awf5i6OTL+s+lUqYRPPfnbgvMU2
 gw0JaERWjFjGe/02i6lL0CsNuc0bz4uiXC8vuIBMsDbKBAfanPMsjJX6h3JTntFHJaec
 2yag==
X-Gm-Message-State: APuU4Z/VixgGy1yrrVLnQTLyTHPrKc5vaW8Di3gYZsToWSihtgnjE4aG
 xNRGbyTXFtp/rcukVN8kGV7AAdccpprS5FImohXndmxwPWWAa5GY6ZQKNuk28ZYqCzG4poCZzAs
 1l1IKwxwLFadAp1XeSMi2cKFKXD56famS+gy079/3EuZaY89FKgFeHNI=
X-Gm-Gg: AYBFou0By9Njm3MlYeHTT92qi+APfeqVyxnT9D7qx14FmELTiKG4fL/4Kb6IPsB1G/y
 O2G7u0jWU+itUQ5MD3JN0qnOzsOOKUOho2rtTPkR+rf/FeZnJg6VwELqIc31qLL1L9MNC0v6DAK
 wnUejiaegeLP5uku1hlPsSHhCVA4WigTDfgGsPrmJoSd2zXinJPTgiHKl5vXcO6OF4XEK+wyNek
 toAlqP0FhyHZLWWMvftUGexXnNBJGnb0YgG1rkfmyWFDFTVNoS0+hz+YGL5r1GHrdXA1SOIvk4B
 Y4nv7O+4kNZ2ptt77KumfwW0re43OogaSMF+ycOrSV6wHNE8vD0PiEeaC6n3lfmBzbNmywzmfPA
 GVhdV7sIgTJB4pGvzlTYv/13cFFJrOAtgC/XdF3D24vf1jgXU9A/5hKF9mlqt4CWWzWXqGK/HU+
 bvYZlGf+vawtMMfG8z09YG
X-Received: by 2002:a05:690c:385:b0:87e:2404:6b45 with SMTP id
 00721157ae682-8b2b6782d57mr115110937b3.53.1793789950717; Wed, 04 Nov 2026
 02:59:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
 <20261102133547.1375701-14-peter.maydell@linaro.org>
In-Reply-To: <20261102133547.1375701-14-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2026 10:58:58 +0000
X-Gm-Features: AclHuK-KzRBdwYKJcXaPhEGolTH5T6TnXezXLT4bhSxwLcDo3hcj2NQMjYJGw_c
Message-ID: <CAFEAcA8qH8gda9K6OyCz99D-SHTp7n4rK9QnoyeWHwsicTcLyw@mail.gmail.com>
Subject: Re: [PULL 13/47] hw/net/bcm2838_genet: implement GENET RX path
To: qemu-devel@nongnu.org
Cc: Marcelo Manzo <marcelomanzo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 13:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Implement the receive DMA ring handling: qemu_can_receive()/
> receive() callbacks for the NIC's netdev peer, copying incoming
> frame data into descriptor buffers on the active RX ring,
> classifying broadcast/multicast, and raising the RXDMA_MBDONE
> interrupt as descriptors complete.

Coverity suggests that the handling of lengths in the receive
code here may not be right (CID 1690161); Marcelo, could you
have a look, please?

> +    while (len < size) {
> +        size_t l = size - len;
> +        size_t buf_size = MIN(ring->ring_buf_size & 0xffff,
> +                              sizeof(s->rx_packet));
> +        uint8_t *dma_buf = s->rx_packet;
> +        hwaddr dma_buf_addr =
> +            bcm2838_genet_make_u64(desc->address_hi, desc->address_lo);
> +        MemTxResult mem_tx_result = MEMTX_OK;
> +        const size_t frame_off = sizeof(BCM2838GenetXmitStatus) + 2;

Here we calculate a frame_off assuming we have the xmit status
struct and another 2 bytes as well as the payload...

> +        uint8_t *frame_buf = dma_buf + frame_off;
> +
> +        bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
> +        size_t buflength;
> +        uint32_t prod_index;
> +
> +        if (l > ring->ring_buf_size) {
> +            l = ring->ring_buf_size;
> +        }
> +        /* Never copy more than fits in rx_packet after the status block */
> +        if (l > sizeof(s->rx_packet) - frame_off) {
> +            l = sizeof(s->rx_packet) - frame_off;
> +        }

...and here we drop the amount of payload to allow for that...

> +
> +        memcpy(frame_buf, buf + len, l);
> +
> +        len += l;
> +
> +        desc->length_status = FIELD_DP32(desc->length_status,
> +                                         GENET_RDMA_LENGTH_STATUS,
> +                                         EOP, !!(len >= size));
> +
> +        buflength = l + sizeof(BCM2838GenetXmitStatus) + 2;
> +        if (crc_fwd) {
> +            buflength += 4;
> +        }

...but here we calculate buflen with payload + struct + 2 +
also potentially an extra 4 for the CRC. Shouldn't we have
allowed for the CRC in the earlier calculations somehow too?

> +
> +        desc->length_status = FIELD_DP32(desc->length_status,
> +                                         GENET_RDMA_LENGTH_STATUS,
> +                                         BUFLENGTH, buflength);

The thing Coverity thinks happens is that buflength might not
fit in the 12 bit descriptor field.

thanks
-- PMM

