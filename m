Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969ABC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 07:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u392R-0005dj-3A; Fri, 11 Apr 2025 03:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u392O-0005dM-DM
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:42:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u392M-0001kw-GV
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:42:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so1554300b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744357373; x=1744962173; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqWyP/DlyFHdwYtNbzChPqIfghcs4jki1lZ9UVpUQ5k=;
 b=O3CJqh+2za6o2CTSagC/9+v+0JSojTqd0YVULrf+BOvPBDbPsPLIAmqJinStPNKL82
 w00KCC+caZQFZSyYWtM1duOphSVBNJlAs22ZQUTsbpt+77g+a3qtEqk4ajUk/8SvIGci
 0R6tyoN2mVrsEE1JvZaUjJfmS1Azxl3NbwcLTZZ6Tm3Z+udCxomnSzobec+p9iNnOtUX
 55b3U7Pk46yY9td1++jiC+c2cncoq3UU06HbGvnvdSIP/FJ7LcyFlN7JMy7PqfISrPVQ
 G0xHX8fFlBMhaw8PKefykWL8lXukZdrlC6bYZlternZ5BmPRjBHsiVyA2Zb0vzWr3zj2
 fdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744357373; x=1744962173;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bqWyP/DlyFHdwYtNbzChPqIfghcs4jki1lZ9UVpUQ5k=;
 b=Q5NK+rHAKyht3kFCVo4NJRiGJvI4SYJyent/AZVoO3f91wYcyxZgAh9SvdZvGJHSKg
 f2sKquMq2gjOvWyiPIHhKNBxQNVphOvsjVa6x29d3HyZBTlQe5AmZVzf/CSJaZ2Cy+Fi
 Jpn7y/ojj1177rKZh6cx8qOLt2P4/l2vK/U6LzsxxLjECA65ml5LpF/eO9UDuh71pdno
 vrTqgYirD1yTOT9wFAHcOTuzMzIC5TtXMC2occrEbggFo7acnx3xJbGUFuUFLRrjChzw
 QePy472TbbZ6VxwaX4n6HTDesW62RFk5nGZr5B85imO6z4wgwh3KOJzKSucAjDyndwkh
 s45w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5zQsDnbJqojzk9CacPpZhZ3QTLgfpujg4tdHT5oC9XrmNvqONBRDOlZAYaYZc7nKGEQ5/RM07offM@nongnu.org
X-Gm-Message-State: AOJu0Yz8Tx4neidKorL4j0R/Ce6HZWSZYROTFh8fro6oK8jKy8b1OWXD
 +q6CwtiloFtMDoMofDo0TNLfG5aba7fji/Jfq3KuHAjy54coWr3m
X-Gm-Gg: ASbGncsIM2PUt06oKO4rIYdOGrqJKP8y6v5lPNmfXMMboLxfx1nxr1h3qZT71KyNy7H
 bl3kRjA+ijZi0po42sYE62XbVS2OVFw+vDsAsGviKcXPwJUrLdt+LwPebda6vp2yCpYhjSIMVrn
 4nhdbY/gyb4GfY/eK+cZloGHGm7Xu6FbxxkbURR8GYgreko3L8ZfTut4CiTVYGZgVGEq+XcSQ1+
 qCO6rwHmTnMMNTlmJTJJ9r6C65vEDjhbjNEEWOZN/uUdnwIJC/YE7+soc11b4FYVKXnR3fMRQUU
 rJ1FnOgtsuInDUbtE8D21RlZQSSkbsmN+g==
X-Google-Smtp-Source: AGHT+IE1FBZnaBcj1cbeo7Hos7kgQcOQTQ0faqJoL08lRBRJCSjixUwayu9kP7MeNMj49oV74TT1pQ==
X-Received: by 2002:a05:6a21:900f:b0:1f5:6a1a:329b with SMTP id
 adf61e73a8af0-2017996f519mr3475020637.32.1744357372941; 
 Fri, 11 Apr 2025 00:42:52 -0700 (PDT)
Received: from localhost ([220.253.99.94]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a12c9c05sm4169457a12.42.2025.04.11.00.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 00:42:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 17:42:48 +1000
Message-Id: <D93N2W5MI3CA.39IUVT8ENOJ74@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>, <qemu-devel@nongnu.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Bernhard Beschow" <shentey@gmail.com>,
 "Guenter Roeck" <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] hw/usb/hcd-dwc3: Set erstba-hi-lo property
X-Mailer: aerc 0.19.0
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <20250405140002.3537411-3-linux@roeck-us.net>
In-Reply-To: <20250405140002.3537411-3-linux@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun Apr 6, 2025 at 12:00 AM AEST, Guenter Roeck wrote:
> The dwc3 hardware requires the ERSTBA address to be written in
> high-low order.
>
> From information found in the Linux kernel:

In fact this info could be contained within this patch rather
than duplicated in both. This is the one for the particular
hardware.

>
> [Synopsys]- The host controller was design to support ERST setting
> during the RUN state. But since there is a limitation in controller
> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> It is supported when the ERSTBA is programmed in 64bit,
> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>
> [Synopsys]- The internal initialization of event ring fetches
> the "Event Ring Segment Table Entry" based on the indication of
> ERSTBA_LO written.
>
> Inform the XHCI core to expect ERSTBA to be written in high-low order.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Should this go to qemu-stable?

Thanks,
Nick

> ---
>  hw/usb/hcd-dwc3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
> index 0bceee2712..6783d55526 100644
> --- a/hw/usb/hcd-dwc3.c
> +++ b/hw/usb/hcd-dwc3.c
> @@ -603,6 +603,7 @@ static void usb_dwc3_realize(DeviceState *dev, Error =
**errp)
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      Error *err =3D NULL;
> =20
> +    qdev_prop_set_bit(DEVICE(&s->sysbus_xhci), "erstba-hi-lo", true);
>      sysbus_realize(SYS_BUS_DEVICE(&s->sysbus_xhci), &err);
>      if (err) {
>          error_propagate(errp, err);


