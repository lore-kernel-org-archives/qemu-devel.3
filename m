Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49812CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxOM-0007WJ-47; Thu, 06 Nov 2025 05:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxOJ-0007Vw-NX
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:38:55 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxOI-0000zj-63
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:38:55 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63f95dc176fso811184d50.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 02:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762425533; x=1763030333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwC2dWXcTxhZrNSOLpzTJBNZaRPCPAyRlfqAdHB/TYE=;
 b=Aadtuw0DXkFR50RYXzeYm0UTc2d5c02LmV8SNLRZxEY94zEdViJANVyu1ulaSQhVjw
 +icN8+vO31YwGzeEs/9F4DNuDMuAH4mO4AavP2yubj8bHjeSkMu59Un8kmWZBWinrtYQ
 BUsGv3AF2GNgW9ck6hrm1i0H75leoCr9wN1Y+LQ5Ax5zpcnPwy5OLNx3V+Hdkvm+74IM
 uaxxeBweQzXUeEG9q+Z/GnH/mrF4cylYEFGjxEi03KuFCwhZFw3ZC9Gmgn3OW4Xa2h/p
 MDViVsnghSHfUsj44lVKkjawVZbxCOczSd0nwaucqPAMYUm21QtBMa4Jk56XOpTYTevS
 dVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762425533; x=1763030333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZwC2dWXcTxhZrNSOLpzTJBNZaRPCPAyRlfqAdHB/TYE=;
 b=NFDbn7p/qWuQR3ggK/slVmkS5IxJKSAQz5hIhA6P9rQXK343EwsfuaUR5XmjXiShVk
 ohVU11MGZUuBaXnQ3qzsKSUIaa9GzgeSFTpmZ8yoxuCdcod6214UREVoMQsRy88ZuKlR
 3GjcVPKNtOE3/N7HYWzKtfG6O8nXZZkKVjCDWtMT4EwBUV2uF2fgugAtKTicb9ajnMxS
 H/fsrbz7W7Z1AFB6INys09fPyn46LmiS/3IEUJP10DVrodR7hQ8CHZCp8BVCXKnSido6
 6bw7J16pnTCJzp8NVoLcLJcs/NRwb231Nyyu4W0s+z238oZOdhUDJpTVao3b5YQYCLcA
 V9EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlxEoAWiAzeO2//W05Uetmz38BGfU72NyG+SHGVK62vBbadqT8YOCnR10nfrQTt4LSW9nGxZNScXdD@nongnu.org
X-Gm-Message-State: AOJu0YxOz8lJN3qIOdpP2Hv+yjribMOZoQxsJwU0oblfnx6KN0tB6bsi
 9aDoUWWFPOBRCugq5HvRId87g0vnAKaqkq6AicD/rOIV9V9oyoRp4i/86dizpwH1I6fXN9ORpMp
 rs9MxWaG2aatpM4GAoO9CO2fa/cq4HidukM4S1VSwIg==
X-Gm-Gg: ASbGncuwXkEpR7Zi9DrmF0bjwtuSU1zRoQFImlrVbqGNb9nbin4sRt/wJidEWALhdM4
 FA3lAwItmifWrmXdrWw1wTxMfQTKV95lcye9B+zB9D3lvPQm+w7BTy5XXjI/9Eki+FQhYhYAy9W
 GScLdcZrATMsnAdqqSLPvEmjAPZpwu3yRtnTkYMioxUEuP9AMNgFHMjZMtPBJsLKVjaUpW1gfgZ
 MqBOS61utlH6W5ui0xFa8HqWGDgVXyApy+/2aKFGakFkKhDBQppbKZzZZABnQ==
X-Google-Smtp-Source: AGHT+IFZ66nP6/N71Z2rWsODgOH8hmz4QnwtIwxpQ7fMVWNjttuFSOxr1qLnLTEJNvs9o3HaMjdZr2tgqvcJDIXnc/8=
X-Received: by 2002:a05:690e:d45:b0:63f:bb86:1dd with SMTP id
 956f58d0204a3-63fd3571628mr4981473d50.39.1762425532714; Thu, 06 Nov 2025
 02:38:52 -0800 (PST)
MIME-Version: 1.0
References: <aQtAotYvzFY0Vpft@tcarey.uk>
 <5c356c12-55b8-4d01-bc0f-025d3a3b9293@suse.cz>
In-Reply-To: <5c356c12-55b8-4d01-bc0f-025d3a3b9293@suse.cz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Nov 2025 10:38:40 +0000
X-Gm-Features: AWmQ_bmbaPII8B3gKarAwaiddzDYrV3AVnbqPSSo9aafcp-D-1CE-8sMWTm2yC0
Message-ID: <CAFEAcA9c0Y=ndvd-yV5tTr_+nbBO7W-TDcF4+=qCoknzyGPxAg@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/edu: restrict dma access to dma buffer
To: Jiri Slaby <jslaby@suse.cz>
Cc: Torin Carey <torin@tcarey.uk>, qemu-devel@nongnu.org, 
 Chris Friedt <chrisfriedt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 6 Nov 2025 at 06:29, Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 05. 11. 25, 13:18, Torin Carey wrote:
> > The EDU device doesn't enforce any bound checks on the addresses provided,
> > allowing users of the device to perform arbitrary reads and writes to QEMU's
> > address space.
>
> Hmm, it was the intention to crash qemu before:
> commit 7b608e5d6c1d61430e81cd5c71b0277b99b03f3a
> Author: Chris Friedt <chrisfriedt@gmail.com>
> Date:   Tue Oct 18 08:25:51 2022 -0400
>
>      hw: misc: edu: use qemu_log_mask instead of hw_error
>
>      Log a guest error instead of a hardware error when
>      the guest tries to DMA to / from an invalid address.
>
>
>
> As with a standard device when you program it badly. I don't understand
> why the commit changed it to log only and let the code to corrupt the
> memory?

It's a PCI device. Unless something in the spec of
the device says "if you try to DMA outside this range
it will be ignored", then typically devices will let you
DMA anywhere in the address space. If the guest chooses
to program the device to DMA somewhere silly, that's its choice.

Is there a spec for this device anywhere? If so, we should
follow that. If not, then it's a "make a best guess", and
"don't arbitrarily constrain DMA" is a reasonable guess.

The reason for the commit above is that devices should
not call hw_error() as that crashes QEMU itself.

-- PMM

