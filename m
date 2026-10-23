Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66D606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eXFRVN1+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKCBq-0006ou-2y; Fri, 23 Oct 2026 06:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCBm-0006oU-5R
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:07:54 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCBi-0002a1-Lk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:07:53 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b0f59a5fdaso6044047b3.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792750069; cv=none;
 d=google.com; s=arc-20260327;
 b=IL7J2nfhtsLDov0+USImHojz7Xz236qy00ba/7zwvNRJzhAc/O8ZHq+saDVBr3EQri
 aVeDhpzIV+ZScoWfG8XK2eiNSn9KqqHtvrsXNkqKRRNxv6NKgsVkEL9HsFBLXfCU4cwq
 u1MxtFGMJpmnMNh8LWhviCxAp/puLlZK6hKrc7lBUOXzhDXg5F82RTIBVxLK6okn3/y+
 hHSBCV7EPFMT95QkIiudLCU5n6jisUdH8LtB2iN2V/z7oix/0je2Ruef/X669NtfsnFM
 6b+ti+erIZYt/WHYvKGN1YeB/N7eolNfjG6mA7vllAojXAA3oz50p9y5MDezf1J9vX6a
 Kr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eOq1pkkwksdTejfeGNzf9oIofIO9DU1Ho0yL/pATfEY=;
 fh=gREritCzZWvcfaWqpktBp3/OUmb0rOUSRfa2BWEvW68=;
 b=XwTBYd8RqTiIlI5gyeOKznP27A3Jm3DgGMMc9K8hjmXyuCd18VshwqPLGfubc9uTF9
 3m8m0/MJF/3qfxPeFPDnVIhFNPmO/w3GarmRSUksxE/7QWjJkh5FErbgwzJropBknKOY
 jACEZcPV4U3+cj264EgLxL7SjFhTffie/5IQ0xYBq31nuSxOblHNJvx3f7t3Ox7/X67/
 jYXrba3bCiJPRcyTfdS2jMJE5MQkqxQ2TXFzwIMF9P3ZZxTWglZSnQDIRYl2h1yzRgz7
 e0Rdr4JWRGgCs/H/21Vj9jenA/1dJQX8NS7+E/C/jj8Bs1QsCGWTj/19U3NBhPIQ2cu5
 h4jQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792750069; x=1793354869; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eOq1pkkwksdTejfeGNzf9oIofIO9DU1Ho0yL/pATfEY=;
 b=eXFRVN1+AWsdVw37nERT2LlNusDnl757KsJ7z/JesVdkroJR08JyJIwJJBD8SmC2kU
 4lNqtXDDXoRWrJz1TMwp7MEPNzYEqnmZwvNWtHDa3WUACeMgYSFVGxs2OhYDL9dGpgIG
 fuiiAmPsZT1O8h7/ElfIMo3lydI945Yi+h16nF2Z8A6Yyu2BxrAJCeeCg1vXQnzLP2hC
 fzO6sVj6hkIMXc6S9YUFjknKSj3NAIeEW5mWndDM0CskLKWX7KcM/0rV22VUX4Pt0cei
 fqHGDVK6qtgGxB43kdJwYR4tRnQP18iqL+3YcMYJ8Ji7RpmdkOWC/pikp7Ay5yNgLcnu
 fbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792750069; x=1793354869;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eOq1pkkwksdTejfeGNzf9oIofIO9DU1Ho0yL/pATfEY=;
 b=GuZBFsEuWjP7I3hgKvc1uZLkTGFq/UoZqPy+D8cW19KvzT8C4GpQRPTXXIKfY1v8Q4
 q1dY2ZVO6QFkrsVoinj8cGdtlaqYMa/yYBo66ebvMiRvaVxuxShHjOqqqVkVCT1wizTl
 Iece7dwV7QhZVgu4T/z90fpHumbF/p+4RypFJyyClIJVkTJENfJvpuIK/Jxyvryy1p/0
 UhRUhxQtYabmuxSARR3AERUrxSFZNpkreNiyXESVl9UxFtCE7Q/zrANwKA/cNle4Gplu
 tj8tb4yDvRYAceBYWFSd3MSZuUcq5tsoZZeH4qwDZ5pjzlqn3+zLpT+/eMXW48K07puF
 cMMw==
X-Gm-Message-State: AFq9FYIHVpQt3MCjRD3/KIIeCioqwNmIdeOg4sSnc90sba6bx2PVxysq
 Cx0ZbWP4Ja1RxfitT92bMCqtMkM5RAnxuhi2rrTtMSYo2pvwjFgMT6JK3aAkXiejwmY+NQRk0tM
 rXKj11ZydUsew+GGWcs+ssSxA8Ps45yEv7Ff22jC4vA==
X-Gm-Gg: AYBFou091R3aOjKmVO+NZVQIeAZphMYrez+/9dQGhOmk3H6p7UZjCWWZFoZ7zooJoQq
 BmjWTea7wV9flBo2ElmTccQVggmyOJxvtXuGKl1v/y0l+hLmNY0SRYm17MfMFMqLT5k0E5QFUA+
 y55+dDRi6VizVjKmeV2pCjZoPzzSY/PsnwvVHhVxZYSuvpb0ibZJf6Cqkm6kkc7hyEiBfrdWFcv
 PI7awVaMU/kNlu2gJHuSogh1SXmcZMRvlYT+yksK4ktksk+zlexERuKuOuyUJ/9gTZlxAnsoJ9C
 kOwqImiaVpy5yseWSkcMDpbiOfO7c+zlFsvCgPcflwmkxoPTaHFcYfkSxLtSK9xo/3OJqKuTaF9
 sO9dzJW11+uBi07qRvLzkdBbKmNJawJaC/IeOD0iizXZgjphxk6HkUuHni5prQzYZwaazEEDLEl
 UEOvXNqpsFn/zt21qaTHjk9PHKJu2Vv5gwaJEkCrnWWQ==
X-Received: by 2002:a05:690c:d87:b0:8b1:46a1:2893 with SMTP id
 00721157ae682-8b157ba30famr15713037b3.6.1792750069276; Fri, 23 Oct 2026
 03:07:49 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
 <20261018133603.64323-11-marcelomanzo@gmail.com>
In-Reply-To: <20261018133603.64323-11-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 11:07:37 +0100
X-Gm-Features: AclHuK_JgnPFrSO1ORdYazVwxzVgDw9tiN9AhF1TuB1Oh8OZtBAjv7TpCOLSJRY
Message-ID: <CAFEAcA9AZjSqUHFdSTsUuZ4bHwZH2DkbewmU0LP4zG96onHxAQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/17] hw/net/bcm2838_genet: implement GENET register
 ops
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 at 14:36, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Replace the stub MMIO read/write handlers with real dispatch over
> the register offsets from the previous patches: SYS revision
> control, INTRL0/1 status/mask registers, UMAC command/MAC-address/
> MDIO-command registers, and TDMA/RDMA ring configuration, wired up
> to the NIC's realize()/reset() and qdev NIC properties
> (DEFINE_NIC_PROPERTIES) so the device gets a MAC address and peer
> netdev from the command line.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo:
> adapted to the current Property/class_init/Resettable APIs.
>
> While carrying this forward, make these changes to the original code:
>
>  - Access registers as a host-order uint32_t at their byte offset
>    instead of memcpy()ing an arbitrary number of bytes in and out of
>    the register block, which gives the wrong result on big-endian hosts
>    for anything that is not a uint32_t. The HFB filter array becomes a
>    uint32_t array too, so that every register in the block is one.
>  - Do not call qemu_macaddr_default_if_unset() when the guest
>    programs a MAC address: it is for realize() to pick a default when
>    the user gave none. Only update the NIC info string.
>  - Accept an access that ends exactly at the end of the register block.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>



>  static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
> -                                unsigned size) {
> -    qemu_log_mask(
> -        LOG_GUEST_ERROR,
> -        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> -        __func__, size, offset);
> +                                unsigned size)
> +{
> +    BCM2838GenetState *s = opaque;
> +    MACAddr *mac = &s->nic_conf.macaddr;
> +    NetClientState *ncs = qemu_get_queue(s->nic);
> +
> +    trace_bcm2838_genet_write(size, offset, value);
> +
> +    if (offset + size <= sizeof(s->regs)) {

Better to flip this around to make the "bad offset/size" be an
early-return, so that we have
    if (out of range) {
       log guest error;
       return;
    }

    normal case code;

It saves a level of indent and I think is also easier to read.



> +/*
> + * Every field of BCM2838GenetRegs is a uint32_t and the MMIO ops only allow
> + * naturally aligned 4-byte accesses, so a register can be accessed as a
> + * host-order uint32_t at its byte offset; the memory API takes care of the
> + * guest/host byte order difference.
> + */
> +static inline uint32_t *bcm2838_genet_reg(BCM2838GenetState *s, hwaddr offset)
> +{
> +    QEMU_BUILD_BUG_ON(sizeof(BCM2838GenetRegs) % sizeof(uint32_t) != 0);

We should assert that offset is a multiple of 4 as well, I think.

> +
> +    return (uint32_t *)((uint8_t *)&s->regs + offset);
> +}

Other than those two minor things,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

