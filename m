Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA348C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpnEL-00065z-J5; Fri, 31 Jul 2026 09:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpnEJ-00065S-Py
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 09:24:51 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpnEH-0000vq-Vm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 09:24:51 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664a09bc459so1097872d50.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785504289; cv=none;
 d=google.com; s=arc-20260327;
 b=OvT4ozl6vVlrZQSwgU7Vw+apDl6APwce+uRXP97/1IhNyeZl49uxbrKEcLlzShBHDS
 SDpmuL58ICbdpv3G2mOHZIiqpmjxQzyztkWiVLrpCIHfs6mgnq08t54EESW3Atpnou6M
 CWtnyTzfKJQKhNyQa7dsI9qC03MQl7jtk5KzEVEEoNebQIo0v1qhFlj0PUQdQNlIxoai
 o7PVqKkSpPx0Qt+NWNjMP9zY9mPhkT1tEP+QyB+rfGgZfTu5dan04FTILnBKzyh250+d
 w8TZUny4bZLqWwTHNtWI6hPNZo/EcW97keiLlsCmvC1mAqhRzkRNdHCTNzsWaRh0Wj4G
 7Zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RIwZyCP/mE/e1SfSDyf6DvDnyg9wOVWFT2LiuHevcxk=;
 fh=rvq7wicofHrHdw82ahMhUx1Zt4prNdqUGGvGUBcQ66w=;
 b=qQs8ZGPLNGCh2rGNHVuxfbl9h1VVJz6GoKFW3fZKQBIOsXZ+fhyeOGgxmepOEOdzUM
 76erMZbp3c95RjJgj5OqEhN9wc3C6f8QzTJhshLSmcITCzvWMXj/2pdsROUSqu2lHfeK
 MCu0wF9LKVe+DrU5WLwHT7kVwglbw2UwgWAJUx/rk25BkWboV9yaq55oOldHU6YQJ+7k
 IUFsokZ7/XbzfjnQw1ziYZW04JSuDdDXo2tDrTUE5KRZBguuyYh000zB9mdWtYUcv6Zv
 7TR3SiY9pU2i6gTwZ/4qYgGiTkqm7mX3dBy0eMhYv9TdJnfHmdsepozja9/ADCoHvM78
 oSEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785504289; x=1786109089; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RIwZyCP/mE/e1SfSDyf6DvDnyg9wOVWFT2LiuHevcxk=;
 b=L/fw/6StT5qQEHJoumpQRQ5x+2UChPM6uLmI9bshCphjjTuMvNwBVW91vi7xZFkcw7
 2bcR0MlT2u2TDD8fg0JO+/fu44vTRjPVf2fvF/y7PznUUcfVsbzNqEMMuaB4XL6qSsj0
 LtZAFbRln6JkdmG280nr2vEbwKPIpAHgK8h0gUa9MB1iZbSCLLDgSTwKzQF1CfwIylQC
 sgLpD0l2W+w6Bsyx14pmQCxXOeapHjroTguWFcT2IYTrKchdF8hoJDhDp3OnAt9hXYYj
 bQ5Y8e3sU2DIYmjBnMzMeIfZcyqCf4gc3p1HbJxHvvQUx+nJ/KYhB9Cph3oejvHQ5RhY
 mT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785504289; x=1786109089;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RIwZyCP/mE/e1SfSDyf6DvDnyg9wOVWFT2LiuHevcxk=;
 b=BF0eZaLt1GqvRnDqvo1/VF7Q4ga+cFOa7M3u6r+PvKfTiSpefhWnSGJJQW5sZ5SUkx
 LgW2Lw5ASpBxuBYRxFuZnXfOcYxHCxbB2y7PLkXoEMhAjSlvR9BM1sjwDq4cIArrCzJs
 t8E1IJKN6Uync2CxADkf5zwdfHZkwut4knmFHBxvgd6tIJ2K9RnZAJYTwt6+Oyvo39xH
 rQq//FcRVggniaubniPYBG0uTp0FNl8xTczV8B1JCcfD1VH1GJITD9KaXJNrNuMPdDb6
 TbfrUA6E/8IylQdQt77V2kYHS57Wmhaz47YsQmMWkbd3c8SL2ItsizRgrwy+qXEgKQtD
 9REA==
X-Gm-Message-State: AOJu0YxW8369urSQqXuq/j18kmvRoMxo+rZ4CDMgkU3Nn6wS9w1kywH/
 dIEgTJfcS0BXbx1if3LKJUfO0hbdd2pVRoXTJMcoBH2zpFSc4SSE8pEUBli3eHLfTjetFjN3j2F
 RLmGze/WHPDHpFoaq3cjmvXEpHtKqRctuzbv1YyNnEkC2EvBcT+EB
X-Gm-Gg: AR+sD10X5j9gOd9OqvFQHuclyJW5Msusd7nhOtRvrDg9DUsONAzs6mZmStd8w/boUe5
 K7RC6KsR3aIyCQLwEI1aXiBrkBQTl69fwZhvqzsrHro6BcMKfoUWv8NbbYg8d2PPLOxpq3qnNZ1
 MHU42/pOKQs3A64bp7gAg1tMCDvA/EK8Omwkkj3cAEsJcwD0gQtsUSxbFu15e5e/lLOmRHl3g+2
 OG5QDsKxWUMFsfUbauQrfv+HjVcLlkBF3vvFsDCCv25DJx5ekM0JKDgTCeptv5c6ypxDz4+kpJd
 niChxKcFb2Axj2ocNwXrJfyPFtfRDX4JMOkpEL61TTI2FYCg16QK/rls8v6vmnr/AGZ5akKSL8Q
 LbWG50Nl0CV4Cs+hm+hn+XSx9sefI
X-Received: by 2002:a05:690e:1487:b0:669:3fb5:d084 with SMTP id
 956f58d0204a3-66945345d86mr1533845d50.24.1785504288579; Fri, 31 Jul 2026
 06:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260731093618.2961031-1-peter.maydell@linaro.org>
 <20260731093618.2961031-2-peter.maydell@linaro.org>
In-Reply-To: <20260731093618.2961031-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 14:24:36 +0100
X-Gm-Features: AUfX_mxmeaTJus6twosIMvpEGrxkNW20hf5zUDH2jp9DqssyEMmOKMXQyJ9GXvA
Message-ID: <CAFEAcA9Vj79K0-CDnamk-uvFD3e2DNQvKSp-SoTUoPGLZ-5EMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/rtl8139: Fix handling of VLAN tags on incoming
 short packets
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 31 Jul 2026 at 10:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The rtl8139 receive code handles VLAN tags in incoming packets by
> copying the VLAN tag to a special field in the receive descriptor,
> and copying only the actual payload data to the receive buffer.  This
> code tries to ensure that it pads out the payload to at least
> MIN_BUF_SIZE bytes.
>
> In commit 63b901bfd30 we removed the main "pad short frames" code
> from this device because we switched to requiring net backends to do
> the padding.  However we didn't notice that this broke the VLAN tag
> handling, which relied on the old code making the buffer at least
> MIN_BUF_SIZE + VLAN_HLEN bytes so that it could copy MIN_BUF_SIZE
> bytes into the receive buffer even after removing the VLAN tag.  The
> result is that the guest can make us read 4 bytes off the end of a
> buffer by feeding itself a suitable short packet in loopback mode.
>
> The old behaviour is actually not correct, because the IEEE802.1Q
> standard says that the minimum ethernet frame size remains 64 bytes
> including the 4 checksum bytes, and so when a tag is present the
> payload data only needs to be 56 bytes.  (A bridge implementation can
> choose to pad tagged frames out to 68 bytes, but it doesn't have to,
> and so all devices have to correctly handle incoming tagged frames
> that are 64 bytes long.)
>
> The RTL8139 datasheet isn't very communicative on this topic, but
> there's nothing that suggests it adds extra padding on receive that
> didn't exist in the incoming packet.
>
> Drop the last remnants of the padding handling from this device;
> this avoids overcopying into the guest when we receive a short
> VLAN tagged packet.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3518
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I had been looking at this from the POV of making the generic
> net code add extra padding when a VLAN tag is present, but I
> went and read the 802.1Q spec and I now think this is just a
> place where the rtl8139 code got it wrong.
> --

I forgot the
Cc: qemu-stable@nongnu.org

on this one.

-- PMM

