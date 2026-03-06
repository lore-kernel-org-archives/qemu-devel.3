Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8D6FCC048
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYsw-0008UC-B0; Fri, 06 Mar 2026 12:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyYsu-0008Rt-Nz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:22:44 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyYss-00079J-NK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:22:44 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64caaacb9bcso9108700d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772817761; cv=none;
 d=google.com; s=arc-20240605;
 b=NIXAvxjBWSAy/vWqCsLE6WUoUhmb/kM5MIem15/j2JNsAwyYKGQhtNWFVPN/C6SidN
 cmE61Nz7H4q9MOEamEoq711ngvo/0lmKEm3K7dxJofgKmxug7ojaApDtJoplJ9cjtDpw
 n0IwpX48VF7D28lqIjol507piddVb6/4zvDupl6PONPcbRCOR5IjTIK0GMn+BUIB41eB
 oEuyao0OmWoKYzTaGDz0iMZ3DLsA/PUZZJQz6VT4QRJ+HBkiIDSM3gx37BjRWSeJz33E
 Nwz3zWp/3yofncQf86wxcBeJhIUZYYXFRZxZnQ5NXwlJ7MPo7TqcKDQUVVi9DTAG77l0
 Jvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZWK+Oi2SB+dKt/7WNqcqHT43A55Cqh0FWmCJPTZcPMo=;
 fh=4IMcUSoVPkhEBD2ayzMorTw2TPIvObuhQUFUXysmGXo=;
 b=DmQ3Dx5acmUFAiNiIVKgPurw7SwYBTWmC/xqwfYmkk/ob8DyhnS9oBXsGZJut9u4x2
 yfzME5m8tV6dQSGpOg+tt3oHlphSH7EkgewX2YZf/3v+HJEm8Bbgi/n2hM20ocArddHM
 VQPKqEtFxltBneIFbZMvSZD0XwhJcObWw4kMzdL0BgvDkhHeI1YlE4SQmH13Y+TO81Pq
 8MfGMsDZWomkhsCgDkPLdlBfy6eosNfSA7LY/dESqrjBR9vxq3bIXK4a8pt3WZ3wjKca
 p9ZVuSUdfw4/aZKSkxYp0vCDmTxQOR5gvbfL3XuAzJMifAW7Kz0JMhLMdVG4r690Q7aG
 FvGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772817761; x=1773422561; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWK+Oi2SB+dKt/7WNqcqHT43A55Cqh0FWmCJPTZcPMo=;
 b=Iu64kiCOJLFx/ZJqbtXcT+pkvhYP9sgXbOoygqyh3g1/AhlDxOvjqIA17KPf3UyRVH
 Ap59aRKBk1G0tztYlXrbKIsKqUzeDhaBol8xEA1kEzc5w0IfWZrPYf42gp8aQmyGA3xX
 PMOzgnVJFQmSnM9jL5GZr7tf9B/oYSgS4LbriDVxLp3wtvF38RpAGlEDkzOaNe1VnEq6
 OdQnFDlRV42CrT6t/t5qWJ0BSeiY9PFilK/wI9NfikffgSvyANMuBk/EZJYgkH2oFYcO
 CSJ4Epb2lAZZM2Jrwtw78hS6INyXWXKHvIKCSdfr2LCek0uKtFqHpvYUISjHwbYazlrH
 5Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772817761; x=1773422561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWK+Oi2SB+dKt/7WNqcqHT43A55Cqh0FWmCJPTZcPMo=;
 b=igv5RujWnNvNgXLlkK1imRM4rnYDGf+SZIDqsxuBrgRNbwVxMnUbe0HaXKYm0rVOUV
 RZ4IhnrK6b0Hd8q6GVYRwn10nCuH5G0THgLZmgbajBb8J0t1xqLqkm//jobLqW+e8rWZ
 PRCxsXnJYDui3Qcu9yUp4eedPNZ/E7/v2TwUPvcJYRHoOnEiyeNbTp9MKDTAHmpPkzaA
 DTWe0yfnhlWc/zvY/JczAEojlVVuqQYIL7xnvz+7PNgtDQu7BbA0uB4XU04Wn4T22yrX
 menCJH5vjjbDDKJwTwwog3To27cX2olt9CIirJxQdrE3KSvnuz5ZKKDGmahNmQuLdfAB
 Pm1w==
X-Gm-Message-State: AOJu0YxkvWRl6vkc02wqHaK1nS9TKppP91C7hfjup1Ek63ffVrxUOA/H
 CRfsukhyyBCdP4SaVoUFxKaJ1umRMkoI6RL5AoM3IbktgrDhXno3ZVXmKinYlvKbnE3zMWgMBgp
 pcjhhU56n8dtVBlY/EinA+Njc1MxsDnQkcu1m1rRfbQ==
X-Gm-Gg: ATEYQzwvdAK+a3InqHuLy9nAiLj12RgbcqC9Wc1mi/qrDaeSMcyAUI19I3JpFlcvHWJ
 UdZcJr8MuyVAgH4z9ZFaRmXKDSDqRereLRzJ3n3JpnyEm336UASanlQ+3eep0oijsrSLq1sK+XD
 V26988Il0lLj0YWkz2o0Tv8QozVIl0+qLznM3umGa5nXaYtwYXIZeC08IVyOgLqMQvC5jmcmCIH
 +nHejYU4LafnMUgdeI2heP7I7U1vWWBBE+Td0pNtFmctbxLTVgsiAWh8uZwvW367j6JuOadtN7d
 ZvNoPhrKdciUFFaDMKGAJSWnR630T6uYRI0lSLynQ/ek70Yt+s/c3UTzbeQi2uoDkEk=
X-Received: by 2002:a05:690e:4086:b0:64c:9ac2:581 with SMTP id
 956f58d0204a3-64d1410095amr2580866d50.19.1772817760786; Fri, 06 Mar 2026
 09:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
In-Reply-To: <20250207210540.24594-3-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 17:22:29 +0000
X-Gm-Features: AaiRm51E-PkJxBdQt-Ux4mdNwXeBWsV3vsAD8cA4J_04m6RE6gb0g-euM3WYH1I
Message-ID: <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 7 Feb 2025 at 21:08, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> Until now we used a standard serial-pci device to emulate a HP serial
> console.  This worked nicely with 32-bit Linux and 32-bit HP-UX, but
> 64-bit HP-UX crashes with it and expects either a Diva GSP card, or a real
> 64-bit capable PCI graphic card (which we don't have yet).
> In order to continue with 64-bit HP-UX, switch over to the recently
> added Diva GSP card emulation.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

Hi; I've been looking at memory leaks reported by the clang
address-sanitizer, and it flags one up introduced by this change
from last year:


> @@ -383,26 +383,17 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,

> +    /* BMC board: HP Diva GSP */
> +    dev = qdev_new("diva-gsp");

Here we create a new diva-gsp device...

> +    if (!object_property_get_bool(OBJECT(dev), "disable", NULL)) {

...but then after looking at the "disable" property on it we
do nothing else with it, and instead...

> +        pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");

...create a second instance of it via pci_new_multifunction().
So now there are two copies of this device, one half-initialized
and leaked, and the second one which we actually use.

What is the intention here? The value of the "disable" property
on the device is presumably just going to be its default "false"
value all the time, so can we drop that check entirely and
create the device via pci_new_multifunction() unconditionally?

> +        if (!lasi_dev) {
> +            /* bind default keyboard/serial to Diva card */
> +            qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
> +            qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
> +            qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
> +            qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
> +        }
>          pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
>      }

thanks
-- PMM

