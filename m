Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239FAC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBse-00050X-CZ; Thu, 06 Jun 2024 08:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFBsc-00050D-Ic
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:06:06 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFBsa-0004Bg-U2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:06:06 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a683868f463so94888866b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717675563; x=1718280363; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxXgPziTQpLFtp9Vru6V5/hkWgIzMI58uy6QN1sgnEk=;
 b=jBJnoPfFjIw279H3+5FXqGxOI90Su5Pqgd3iwk/GoJXQrhIkmwcMIi0evSd3OUIMCp
 MeC/01Ykw00ovpkjt5k3XiKn4BF5WaST/EVAhxZdeFYPtov7Pnvmb48yvKRO3Buvk5yM
 svITG2sNHFS+X8O233GHrqD3Y63QCGkc6C6542s+HIOT0m/1pxAzxcV0r2ponNgESnfa
 sCgvldBJpYY+xHxQ7fHzVwwfpANCTtV/JGfyOO+gqfVgXO4Lyq2rvPKpvRdEc5hBFA1E
 HOoxBnqC4OWnwhOfXJZVqHgTKh66PqkMO2tsMCvGycqsDoz79mw/bba10QDJIrf0tVFD
 dFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717675563; x=1718280363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxXgPziTQpLFtp9Vru6V5/hkWgIzMI58uy6QN1sgnEk=;
 b=ACt3tzuwSyNWsliOriYcoSd54O5t4Pz1++hq+CrICQQj73bQ0J3wRdVARNAeDR/BNL
 fXVTeiTKEONhKns/0SgaeRCheFw40H00q8pfttlQYOkwn2AzU/JDO9WDB2c5HWHad9MD
 jUdJ0WpMKRnr2mOHjvlfQC0y3BvtlBM768pufvwkTe2rlChE+Rm6DKT2xZObtAJbmpQa
 6DXMp/fvyvyfM9ISchG5JFskRw7pLse+cJIwDXNa30u/fIF7AIGjHG2aYxpxyv1RH9Ve
 mpypygM8I33+JwTo43qVqSVQ1oTWOT6SVFRIkUydT1jN1CzBkhykeUvCNXZP9a6xrqMS
 dP+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzqmdCKhmw5OhuOCom54nriSBz93Z75b2G42YtWxXYpD2AV5P/eFv1GkPUYCCRVScgiu7JvSarGpYoAui0I5ljLijEg3s=
X-Gm-Message-State: AOJu0YxFa6yJe3SwLZju1SbXQDZN9qomPjDefx4K4Adw8rzlrmRMPAK5
 QsPNhKqEkkmvNDPgXM3u6F5b5c0b0Hdvo+YQWG0fflU4qAOpz4x0/JMa171dkL6JajR5Ybjgcdb
 HEl8Hlc/LUnTqw4Quex5Buvfp/iuykHHIekb06Q==
X-Google-Smtp-Source: AGHT+IHiR6w+jlIDB6acmb7JvPHL+OAQ2yg0LcxT2COgQSE1/J69z1Py6Zwfa/L/CYU/DylDbrCMQ+OAcu0TddZSxfc=
X-Received: by 2002:a17:906:f213:b0:a69:180e:9dde with SMTP id
 a640c23a62f3a-a699fa98534mr359430466b.26.1717675563100; Thu, 06 Jun 2024
 05:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240606095952.2133-1-andrew.yuan@jaguarmicro.com>
 <CAJy5ezqq51bJG4O9HA-Pv4sw9rYqGdFW-EezCRPfDbTx=9SwyQ@mail.gmail.com>
In-Reply-To: <CAJy5ezqq51bJG4O9HA-Pv4sw9rYqGdFW-EezCRPfDbTx=9SwyQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2024 13:05:51 +0100
Message-ID: <CAFEAcA8fSS-qt6KmN_06uEMXddjbqjATh-FkUJVSrPuiu50+PQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net: cadence_gem: fix: type2_compare_x_word_0 error
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, luc.michel@amd.com,
 alistair@alistair23.me, 
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 6 Jun 2024 at 12:04, Edgar E. Iglesias <edgar.iglesias@gmail.com> w=
rote:
>
> On Thu, Jun 6, 2024 at 12:00=E2=80=AFPM Andrew.Yuan <andrew.yuan@jaguarmi=
cro.com> wrote:
>>
>>         In the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 I=
P Rev: R1p12 - Doc Rev: 1.3 User Guide, the specification for the type2_com=
pare_x_word_0 register is as follows:
>>         The byte stored in bits [23:16] is compared against the byte in =
the received frame from the selected offset+0, and the byte stored in bits =
[31:24] is compared against the byte in
>>         the received frame from the selected offset+1.
>>
>>         However, there is an implementation error in the cadence_gem mod=
el in qemu=EF=BC=9A
>>         the byte stored in bits [31:24] is compared against the byte in =
the received frame from the selected offset+0
>>
>>         Now, the error code is as follows:
>>         rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
>>
>>         and needs to be corrected to=EF=BC=9A
>>         rx_cmp =3D rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
>>
>> Signed-off-by: Andrew.Yuan <andrew.yuan@jaguarmicro.com>
>
>
>
> LGTM:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>
> At some point it would be nice to add the missing logic for the DISABLE_M=
ASK bit that
> extends the compare range from 16 to 32-bits.

I had a look at this device's code, and I'm trying to
figure out how we know at this point that there really are
two bytes pointed to by rxbuf_ptr.
 * The get_queue_from_screen() function takes a rxbufsize
   argument, but it never uses it...
 * the callsite in gem_receive() will (in the "strip FCS" case)
   pass its buf argument as rxbuf_ptr, but it will use a
   rxbufsize argument which has been raised to at least
   GEM_DMACFG_RBUFSZ_MUL, even if the input size argument
   is smaller, so even if get_queue_from_screen() honoured
   its rxbufsize argument it wouldn't help

Would somebody who understands the device like to have a look ?

This is a separate issue from the incorrect array offset
argument this patch fixes, though.

thanks
-- PMM

