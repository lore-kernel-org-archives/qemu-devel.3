Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D661FCC063
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyaLr-0002NJ-Ft; Fri, 06 Mar 2026 13:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyaLp-0002N5-Ln
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:56:41 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyaLo-0000n5-7b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:56:41 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64937edbc9eso9122202d50.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 10:56:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772823399; cv=none;
 d=google.com; s=arc-20240605;
 b=H4vz78cb6Eu6JddG78tMbkFkb587QQrPu6eGRVDMquqCJba0h2vrUzhnkjATVzSOVL
 QoZ34DL+9M0KIHqwMOUET4jVUJU4tfEdoYQBd/0ZYLLlXvjle1jPELGLO6sr4rlVM5Fc
 BPrHMsvs0B5/Tur3vRDGHHNX+zqIPwkI7FNWxK9+4EHekNfXh54Wtxd1iYXs0dfHRhy9
 cckkughVF/ZVAl7208RVTGW1jMX01ghl4ViFyRbFoiSyqnAiwkkd/Kl5S057usim9K69
 R9yZQpJdQyetygZYm9t/EZvIdIx4JU7kxLhSYXTgkoyJot+HreuljLRYxleku4P0OSUZ
 ipzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GMd0bAU475cICXObPQniWwAoEGHrY5SmerX5uGpjrv4=;
 fh=F6bOIkOA5aBYREcZAmFgJCjXkzyN1AsEyw/DQQWelOI=;
 b=M6HVh+nlUAXO4kOOYMfS3+GjxcVAXJdfRBir9VUiR8+7cDvaEJCH0EjBFQ/7ctxlaE
 thjH/bKX+tTleBRxnKI8TeQvOh2ooGy7Jovf+8SpGvJTaTqchY2SNs+mh5y3T0Igm9YY
 mgL2Ge0/HVBbYdqnX5JLRjgY3zMMPXnDsG3mUUBpnPxWh4oVYfb53vSfi1abEX3ELKjL
 EBQpzBSsrWkMas6HmUMbLrFVtvkLMlUx3HqIvzzKXakBfXSW6/TwID46L8/1oghnao2q
 fINc0Ie0Ao3+8e/umwWu/UJQz2ZtMuHvW+TVFf3DoOh8GPfwuqQMNXX6D/Ht+3qn4rPb
 uHlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772823399; x=1773428199; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GMd0bAU475cICXObPQniWwAoEGHrY5SmerX5uGpjrv4=;
 b=T0TvSZQUW9h3eeq3/+Dj0Emnpq+BxG/L9nvyaHZjiuqCZ0SPBRkVapJ9ybDpYWOJDy
 0f8FUbVGb+JZ3e/kxoBwqywnaIc4LRcUPPeuM2JVUfU0KSk7OelFmkqcdmwCIEh1XAr1
 Fu8pixTBREmM7khmxalAdA1bOS+mb7Du84kMszbQnVUcghQHlWTObtW9RzNikxoFoO/O
 9A6QxrX8Kg1MLZkUGMPxk8KfCrLGIx0YfvXE+6fRBl003VITYpyZ5VLrFOaIq4K/O4Ao
 P4UnOSIvvSuUV1027Di8sKpaFmdGXIkV7Odqx+0eeEhDq6bj+2TjpX8xcy/oSYXyMlzf
 MWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772823399; x=1773428199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMd0bAU475cICXObPQniWwAoEGHrY5SmerX5uGpjrv4=;
 b=c0lo6vzCsmkkii7QX8SXY7xRbQWLK0CLGk0rw56iriZgHIrEflgzXUhdu8xdvKDIra
 1dDQEph2CYiVtn9kZKHzGGeC61NP1/mD6LQ2t4xDfNjTa+yGSK9+PsD3g3kCgaZ9/9WG
 sFCF3t28nEEitrMsDNsDBiykLS3lJfJOVRHIc3vAbe+V8TI0zWquOdbPyN4S8DA8SrFZ
 LkRanZcu8G9awOIXQEIEBOOd0yNu2uAbNzbQ70qGMYLEr6mXo3cPGkleVa+/LVbZ6s6X
 Rwyx47kACrKBTkDvYixSbh1gejLgMjYx38DSE3m9ySknhMmjDiKbBE0FHXpS6tGlqPsM
 VK9A==
X-Gm-Message-State: AOJu0YwYkXaezBhwqSMOV2NHDwXee/FqzwhLK1gi3EMSWHZN3yw3BS/Q
 cCxlk86Qu/vj/AXjfInLsWIlkCme4aR6dmxzMjscTcRB6hMKazBKBhO1pRTL4r8nGywku2FCM5T
 Z5dvXPZQ2mgPY5Z1GRTjFf/9vWAEi1auM2eJB/I1S/Q==
X-Gm-Gg: ATEYQzw6kk4bxPEN7zawZ3ITvJhAialehfVh02yHJpuESQrh5SFT+y7fixsgfDdsbys
 DthqqaZAM5rqJv5VKpmBs1kMcMHcCRLFoaWsOyrKrBUjNiaVpwq2P0mBqcoDA0cOJHwt3OvG3IQ
 rD6Bca6tTf0lku2wbSNrdG9Ib28euckV9ms+4+LvR4zP/CKNl+mdf7lV9WDfCJzVyNQ1jjWDZxf
 vrhNqbpNfnZc3y+JHKBWjUULD64jzbsQud0Jcmp4bKDTPXmEweXPGeKsKCCcCpiJOmTqseNVztM
 hmRrCKmglQVlesQhgcC62WnXC5GlwBrGQ3qYT838YZ3bIRL9uwjqO6I5iRpx7NkqBrY=
X-Received: by 2002:a05:690e:12c6:b0:63f:9fcb:2050 with SMTP id
 956f58d0204a3-64d142c4da1mr2840171d50.50.1772823398896; Fri, 06 Mar 2026
 10:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
 <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
 <aaseBa-3GVyjKGXh@p100>
In-Reply-To: <aaseBa-3GVyjKGXh@p100>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 18:56:27 +0000
X-Gm-Features: AaiRm51ajFoRQ-kk5fkpR2GlH5Q4kKA6CGQBVBoYXFPn2RKFSgXYrDfLAnjJ0uU
Message-ID: <CAFEAcA_g4tT2dTyWHoTn0hVZ_Soy7W_exh2JEE-C9U+PN4LGPg@mail.gmail.com>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 6 Mar 2026 at 18:33, Helge Deller <deller@kernel.org> wrote:
>
> * Peter Maydell <peter.maydell@linaro.org>:
> > On Fri, 6 Mar 2026 at 18:13, Helge Deller <deller@kernel.org> wrote:
> > > Background: During development of the various machines it was
> > > easier for me to just disable/enable the Diva card from the command
> > > line via the "disable" property.
> > ...
> > I think we can also now delete the "disable" propertyi
> > in the diva-gsp device itself, right?
>
> True.
> Patch is below.
> Ok?
>
> Helge
>
> From: Helge Deller <deller@gmx.de>
> Subject: [PATCH] hw/char: Drop disable property of Diva GSP card
>
> The "disable" property is not used, so drop it.
>
> Noticed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
> index 280d0413c6..b945dab37d 100644
> --- a/hw/char/diva-gsp.c
> +++ b/hw/char/diva-gsp.c
> @@ -51,7 +51,6 @@ typedef struct PCIDivaSerialState {
>      SerialState  state[PCI_SERIAL_MAX_PORTS];
>      uint32_t     level[PCI_SERIAL_MAX_PORTS];
>      qemu_irq     *irqs;
> -    bool         disable;
>  } PCIDivaSerialState;
>
>  static void diva_pci_exit(PCIDevice *dev)
> @@ -166,13 +165,11 @@ static const VMStateDescription vmstate_pci_diva = {
>          VMSTATE_STRUCT_ARRAY(state, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS,
>                               0, vmstate_serial, SerialState),
>          VMSTATE_UINT32_ARRAY(level, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS),
> -        VMSTATE_BOOL(disable, PCIDivaSerialState),

You need to increment the version_id and minimum_version_id
to change the vmstate. Or you could instead replace the line with
           VMSTATE_UNUSED(1), /* was "disable" */
(which keeps the migration data structure the same, so no
version bump needed).

I have no strong preference; I would probably just bump
the version numbers personally.

FWIW it was a mistake to put the "disable" field into the vmstate
in the first place -- properties are set on device creation and
don't change at runtime, so there is no need to migrate them,
as the destination machine will have the same configuration.

thanks
-- PMM

