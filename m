Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1448BCCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 15:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5ui-00077s-Tj; Sat, 17 Oct 2026 11:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI5uf-00077a-RJ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:01:34 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI5ud-0007Sn-3L
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:01:33 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ab3d3c5761so6314517b3.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 08:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792249289; cv=none;
 d=google.com; s=arc-20260327;
 b=VmotoQGcxc7RkzgeBlsyd5rpBvps2e4Y8I5OROxssSuaFZH+dY9WM6WPOz61xz+JdK
 ry8tqYtpXgtBqNlhedOPHzhN4U27i0sSg93QeAxEdmmjd4oRWqS9ZCKNN4Ve+pedZ9AC
 GURS1tw/iCvEaoNEEXu7VdhZSCjouU9YpG101/6MmFpLbosD7f7ktduTfC6JsfAt/Z6+
 ElFre2LTScEitn2FiixmydHX7/BpLikstyeXxdYK1/aG62bIA5+wbiqHw+aQbNjzS8JZ
 wcGQCnLDK92Y+j34pUu/5oq2T1CWy4De8eDvlAY+j3lfVrR/Jl8eKwpKgvKrXV9ETpu0
 26ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SLBCU2hF9JhXZVyaz8NCtFu3yStGcGQNfZsb5pFrDMk=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=RfaCLUGDoh1NmtYpyuJ8VLdCrzPTcHdJhCAC/qdBmo6TNdhQZYJ+RLB73DnirXqpBh
 U5MkAZu1nNj/dLbRJfcfasqlnxTHguRHAtW2U0lOazHrrvlxC17sZiBXevXi96PSmyJ/
 iaKfYqep0ixgay8pBVQW+lFTTNLDH41QkAEo5vfmpoXStSKzLeshwdLrGFFhmBIybRXx
 PJIVcc3eANwNEyq1Bj2R3/dynW5B57CneAiW8GKz67SZ6c1C11KxoFIUEvg/3gLv696H
 chBRJC7pVpWtqEruxl2zg/xZglh0ZCuCY/KgHlNDB3XnoO7JrcZpvzBaLNKt7A0WLbJ8
 Mg0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792249289; x=1792854089; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SLBCU2hF9JhXZVyaz8NCtFu3yStGcGQNfZsb5pFrDMk=;
 b=xSNUo3tIyDdE5HlEY3IgTQGOjxiBBcAJtZQEFGDSohWkL1IT+q/qKTR8akHMVreb7Q
 fCOnW79+ju3jMJ5brkTgORYHk2aqFyZTI8RnjY2cOF1jS4PveBBZe+WgdKUur/c9fiUj
 BoIsJvydeorjspQa+NtOD7mdmjWDfiOkFl6AS0Hztm3gElB4eN7vMT5GH+SPD5Hz4gxK
 YQs8DuaG/obsc1NjHSqwVgEyC9Hv/aRU5iMP6kALrcz2XuZRHmIMExy4oe6b3IjE+rVV
 bIaSnQ34RqJNp/VW3T5kH3QbWYGKgb7qeQXKEDGMETOnqZ27QL4cssHd6fCd6vy3zjtp
 guyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792249289; x=1792854089;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SLBCU2hF9JhXZVyaz8NCtFu3yStGcGQNfZsb5pFrDMk=;
 b=iV5reqraMZ5NEaEVeRQtsz6qJ8tCvxEXRI+XYMrpFvLK16o6/YSuJw2H/pGSId3SHQ
 jWq2upLWbEwXCBIa6jW3XRmWXipo/NmqimiUw9bfaISmpzLljCqsdlpHs4V0fEYSxCR3
 iVFM9qALMI9k5HjNWKIb+57srijq8fNYo7vQIRzWd3kZkTXrctL5IjUE8jqcit5p4TIe
 8bhNHeRtsbTjDd452ucqdn5bIlC89nx/z5gZO8tIRwxZkD7b7nOfmjpEXUzRWZz71WoC
 KsPjitZokWBRk0jQy74doQ+H4Xt/KSj1Y0t9vrPGucDIdceI22TT1vXQIQ3zkNl/w7mk
 8vSQ==
X-Gm-Message-State: AFq9FYK2GBbE9zizCN6viq3owVNx8gHSrP0PhQtSN7+i4+PZhfTS9Phi
 4sOBwoYeTf3Fz2edA1t4K3jA7dbkhl9/GPBJnnak/AFRVn0bh3yoUBgZE4PRR3uhZAivUSrdbTJ
 cQYtx6tJCVv0SfMEUqDeK7hD8RWHIxAFD2XCrekLVTg==
X-Gm-Gg: AYBFou3bZ5t1jv0MWhE82y3UmSHWqvQhP2fviJvwSBI9HoU/5gOgH9pL6Acpt2d4/1l
 7FwYay+4+lDZocTK3orQil/mjrTAPdlrpr+TppgaXz8AfBhmcz0AupllQFm/qW+6i7tbTugUcIW
 b1g8fJXnRIIwPmM9dQF3h+5X+bcedBtZjpepMV1yirnEHxQvWqau9+nhUnG7ZfWc4SuiE25DLqI
 oiMbrPzJI8qUBwGMwgXl9Aghi7CyRs+iBB5czzvKgZ302d+vUxQZ5joXBowCA6ab7RXBpMgCD1g
 y9VAXdQAl+L98UB82KYb0gVvwLWmEMNWncVDOCgisD5UUyxsO166sf6n7/tp4NCWeZjNl8ci5Yt
 SIUKbRR4y7pG/4RMPVX+SwgmHpyPndtEfb3e0TOM=
X-Received: by 2002:a05:690c:6d01:b0:8b0:88b7:cfe3 with SMTP id
 00721157ae682-8b0f21cbcc0mr11285387b3.40.1792249288457; Sat, 17 Oct 2026
 08:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-11-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-11-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 16:01:16 +0100
X-Gm-Features: AclHuK_4-b3qdQL9B1fS1k4p-xIQ0f17XwkLcfHkQc4F88A-Vr9d1dO4Z3aTAno
Message-ID: <CAFEAcA_dVK5kr3bBcDvYCJaWL19qBh-W+H3anKqP4dio-j+NQQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] hw/net/bcm2838_genet: implement GENET register
 ops
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
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
> adapted to the current Property/class_init/Resettable APIs, with no
> functional change to the register dispatch logic itself.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>



>  static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      uint64_t value = ~0;
> +    BCM2838GenetState *s = opaque;
>
> -    qemu_log_mask(
> -        LOG_GUEST_ERROR,
> -        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> -        __func__, size, offset);
> +    if (offset + size < sizeof(s->regs)) {
> +        memcpy(&value, (uint8_t *)&s->regs + offset, size);

This has endianness problems, because not everything in s->regs
is a host uint32_t. It works for the uint32_t fields because we
force that only 4-byte accesses are valid and 'value' here is
in host order, but in e.g. BCM2838GenetRegsHfb the flt[] array
is uint8_t. (Plus it looks on the face of it like it will handle
an arbitrary offset/size but it won't work on big-endian hosts
for anything except 4/4.) Similarly for the write memcpy.

This kind of thing is why devices tend to either
(a) have a uint32_t regs[] array, and use "s->regs[offset >> 2] = value"
as their default "set the register", or
(b) have structs where the fields are named after the registers, and
have switch(offset) statements which handle each register case
separately with "s->myfield = value", and don't try to have a default
case that handles most registers.


> +    } else {
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> +            __func__, size, offset);
> +    }
>
>      trace_bcm2838_genet_read(size, offset, value);
>      return value;
>  }
>
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
> +    if (offset + size < sizeof(s->regs)) {
> +        switch (offset) {
> +        case BCM2838_GENET_INTRL0_SET:
> +            s->regs.intrl0.stat |= value;
> +            break;
> +        case BCM2838_GENET_INTRL0_CLEAR:
> +            s->regs.intrl0.stat &= ~value;
> +            break;
> +        case BCM2838_GENET_INTRL0_MASK_SET:
> +            s->regs.intrl0.mask_status |= value;
> +            break;
> +        case BCM2838_GENET_INTRL0_MASK_CLEAR:
> +            s->regs.intrl0.mask_status &= ~value;
> +            break;
> +        case BCM2838_GENET_INTRL1_SET:
> +            s->regs.intrl1.stat |= value;
> +            break;
> +        case BCM2838_GENET_INTRL1_CLEAR:
> +            s->regs.intrl1.stat &= ~value;
> +            break;
> +        case BCM2838_GENET_INTRL1_MASK_SET:
> +            s->regs.intrl1.mask_status |= value;
> +            break;
> +        case BCM2838_GENET_INTRL1_MASK_CLEAR:
> +            s->regs.intrl1.mask_status &= ~value;
> +            break;
> +        case BCM2838_GENET_UMAC_CMD:
> +            /* Complete SW reset as soon as it has been requested */
> +            if (FIELD_EX32(value, GENET_UMAC_CMD, SW_RESET) == 1) {
> +                device_cold_reset(DEVICE(s));
> +                value = FIELD_DP32(value, GENET_UMAC_CMD, SW_RESET, 0);
> +            }
> +            break;
> +        /*
> +         * TODO: before changing MAC address we'd better inform QEMU
> +         * network subsystem about freeing previously used one, but
> +         * qemu_macaddr_set_free function isn't accessible for us (marked
> +         * as static in net/net.c), see also https://lists.nongnu.org/
> +         * archive/html/qemu-devel/2022-07/msg02123.html
> +         */
> +        case BCM2838_GENET_UMAC_MAC0:
> +            mac->a[0] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_0);
> +            mac->a[1] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_1);
> +            mac->a[2] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_2);
> +            mac->a[3] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_3);
> +            qemu_macaddr_default_if_unset(mac);

No other network device uses this function like this. This is the
function for "in your realize method, if the user didn't specify
a MAC address via config, let the net code pick one for them".

Maybe (as per the linked email thread) the APIs here could be
improved, but a new device model isn't the place to start doing
something that no other device is doing. The standard thing seems
to be that we call qemu_format_nic_info_str() with the new MAC and
call that good enough.

If we want to fix bugs in the MAC address APIs we should do that
as a separate patchset that proposes its change and implements it
in the existing device models.

> +            qemu_format_nic_info_str(ncs, mac->a);
> +            trace_bcm2838_genet_mac_address(ncs->info_str);
> +            break;
> +        case BCM2838_GENET_UMAC_MAC1:
> +            mac->a[4] = FIELD_EX32(value, GENET_UMAC_MAC_1, ADDR_4);
> +            mac->a[5] = FIELD_EX32(value, GENET_UMAC_MAC_1, ADDR_5);
> +            qemu_macaddr_default_if_unset(mac);
> +            qemu_format_nic_info_str(ncs, mac->a);
> +            trace_bcm2838_genet_mac_address(ncs->info_str);
> +            break;

thanks
-- PMM

