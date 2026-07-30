Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6B3C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpPtR-0006WY-8H; Thu, 30 Jul 2026 08:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpPtM-0006UT-S7
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:29:40 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpPtL-0001wI-5M
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:29:40 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-66899c7b57bso2847070d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 05:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785414578; cv=none;
 d=google.com; s=arc-20260327;
 b=SI61PmaXjALYb4Zkb8Ecnj37dms/aFAjuEnolfbaJtRYyDY6cvO28SNkmiQ6u7YUm9
 yJPUlhR38CfGLqSmC6jZ2QzUkDR1mtA6z+LgQUy3vgbbtAB/f7qZLy8CzcJmXtqF4bAu
 p2Prc7zArmWpOV5gl08CIFLYZhrdg1JMy4hVtxrbJ/JKnWVeiydDcNDNK29RSpOEPj6e
 0wq+5MUabat7xZuzgZZOjU2705tBjj0snqGCcXh3ZDTx1YoQ4v29YHj882EMpH+gjOBi
 Lb9WpUWVfEgllNOVVMlEwJauJhBbsLrKTWigugkZI/Va9Ejr+c5d9tF+FZwDBWZUTnxg
 eHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h83qJRCbPi9Q/QwFzKfiuFaidosc70DcXYKbE7sjQQw=;
 fh=/uX6n4ooPnSj4yw+YE2y9MXSxeiFvjRHwZj6Q+mP2z8=;
 b=K/h5YjG21HV7BmKHrSxgozHNj46/weL8HuDmrKySX7N24uxj3MmC4VrB91K7R1PyFJ
 dWUQh9Pwteq4kU8ZmnfPm5RzEQI2HphkrlvaH9HE3eiVKnxjVqXqXIqlgfbtAI33eZc1
 uJpARhFfjFZJOTlzoovQDOLOIzu73HdD1zI3lz0tMblUxWyaqMZJ1qdebH1DMwfVFa+8
 OlJLisAYNZoFksDKL9/qp0u04IzRjO3WLGZUzY5BN0/KYIynefg3b/ua6+ZXi5wf3xyt
 4vhsSJ5n9VuEaLQgYQthogOHj7OmyscFx+LDZU/j8BM/F9YoCnSQSJHxbKxcV/NEhCx9
 Bgzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785414578; x=1786019378; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h83qJRCbPi9Q/QwFzKfiuFaidosc70DcXYKbE7sjQQw=;
 b=EDtBduHcpQbJphVTKc/6TCJ3O8M9tF5iJGIDDISmeqaCjr4tORFhINioU1TVeTxM8m
 5nu7eWkl9f1UnZb/8DqY1jzuPX7BEvZ4dmZwbnFKFLjWZZiQ+xpYo5CbhbLgq3MLCNxJ
 JAD25XbYmLRZKML/w85f+FG+gTWNYiSzUqjRSeJ2eRDPDY//7927IzfEOngVXhtyM1sM
 0edsxWWgOBi/1xemuOunvSObVI4mz7l4yAxzRSmnlaGEdw6AtKG+tbzQHvDYspRCqjx6
 WOUN/yVEdqYVRxvUJW6fFx0bMF72tTMpcg6HcUQi/A5CCHThLyO5aZ+7/NVQT9M0V3KW
 yn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785414578; x=1786019378;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h83qJRCbPi9Q/QwFzKfiuFaidosc70DcXYKbE7sjQQw=;
 b=VAzR/7+bj7v3c/tCJi9JU66kSwkBnAFAe8o56I2+jDiETs2npaUAUd7+zNvuPcjRQI
 HeKXUe5JXTopRr5BZtzFqaDyI26W0OHzmoAsXLC0zXRcoJUv6BgMwAbLtbNGCR6Tl+h5
 6UvP4IZBepLd9mY86O+/JAZtTTaqpvAdQhcZ17E3CRW/xvUExoxtqi0stzhfMX3olUkw
 xcVuaUDJvDk5JjIaiE9v8XF2BG633NxZ9wYMsWulSmd0lgwr+k/P46HIf0UKNZzn28Ax
 O4gO3HtaomhCJJAAMlbhfiXQJJvZ/XgArFIAjpU0xQLXaJiPkEY2rJRasnA/PuTHx9ch
 c1cA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGf7IRkkXxQBvgxy8R9XeAv5EDR3ojqDwrz8H+AZ5MkyMSkWCzMUeijCiegD6x4fWAkD8TzIKMDdKe@nongnu.org
X-Gm-Message-State: AOJu0YzXhKa+TANDMbB7oIp2E+v8uls2mA8dlunnP9FG++Vbr3ag3oSJ
 IMcS31d6ugUGrgsThJ2ddlEdbFlEhByjy8aRkGVtQbSpoR+8dlUqEfdXTit9sobfKmokFRRGoYF
 uHS+EMxun7ZoHyAi9FUikYT0tQD2I7y6f0E4QqMqGIg==
X-Gm-Gg: AR+sD12cn2SieCDRCyAIATUWPk8BeIOhBZkM/IPTrRBKjFpXXdyWtTaugGookEofJ4y
 335Jap6FtPaX5wtZzLj05aJG3lOEVoeKvW9LhGvdDHN/obIyKt21D0ZGyvFWZx9FfSTNKat1II/
 7pBMgwPTjj58hnylglyOOKIQQl8/pV3OIRq0qYc7wqsfSXaOCdnrdbGIuYYTJ9uVBMkQnd+JR0O
 RB3bsulIeAH338zea+6JvObXkBcwda506GBSJjugtA4g4AY61k1puKMt+BHzSMbOZqQXSDgCniv
 07lpgY/9NPRadWVS//E7ae6DwdAOd2isf/iYJiSxUR8dwUMakZhVVWSKHlMkwUBBdsu68xWzllc
 /IXqmg6OtHg6eVdvQZvGL0xXnGUON
X-Received: by 2002:a53:a6c9:0:b0:668:9b6a:652d with SMTP id
 956f58d0204a3-6693a329ea5mr21489d50.3.1785414577810; Thu, 30 Jul 2026
 05:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
 <20260729231325.3808993-4-titusr@google.com>
In-Reply-To: <20260729231325.3808993-4-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 13:29:26 +0100
X-Gm-Features: AUfX_mxM6cOYRMi3l6xyZZeoTcA0Okydka2OwzWlafMGaSytHFDJbUbQfDAbUcw
Message-ID: <CAFEAcA_RjDnLufCgRxFhbPQv9SrfLxC8RvY5-SKzVWpJ17P7Gw@mail.gmail.com>
Subject: Re: [PATCH 3/8] hw/i2c: smbus: increase MAX_DATA_LEN
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 30 Jul 2026 at 00:13, Titus Rwantare <titusr@google.com> wrote:
>
> The 32 byte payload was raised to 255 for block reads in the SMBus 3.0
> specification. SMBus does not provide a way for devices to declare which
> version of the spec they are designed to so we must allow newer devices
> to return as much data as they allow.
>
> vsmstate_smbus_extended_data is added to avoid breaking migration.
>
> Specification: https://smbus.org/specs/SMBus_3_3_20240512.pdf
>
> > 6.5.7 Block Write/Read
> The Block Write begins with a slave address and a write condition. After =
the command code the host issues a byte count which describes how many more=
 bytes will follow in the message. If a slave has 20 bytes to send, the byt=
e count field will have the value 20 (14h), followed by the 20 bytes of dat=
a. The byte count does not include the PEC byte. The byte count may be 0. A=
 Block Read or Block Write is allowed to transfer a maximum of 255 data byt=
es.

You could line wrap this quote so it isn't one super long line.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

