Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE26C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 11:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taYn1-0004Bx-Dv; Wed, 22 Jan 2025 06:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taYn0-0004Bf-1W
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:20:54 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taYmp-0006Nb-J7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:20:53 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso27248475e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 03:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737544839; x=1738149639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QocBT1S8occoxAmaOg1GsN/khxZxiUL4njVzKD1pHKI=;
 b=ZRFdAeC3fBNiKXBLe6VGLOU+SqFfz9Pl5ZSKWPhAP1NHX/18PUh4K7YmH8muZ2BagA
 abNI4EUDEJNFhQjeQUoaGJxKTNxz6hCabyUdLZ2h1FHW+yMyWJpWgFMyifr5suvh7sQc
 XRAKZApc2t+8UE9ny6aby2PeY2Qxd1jt0GpSBGkh3GiI2L3APhcDeRgfoJwGK1Tt7kPL
 TU4lJlpAbybqDCxnp2zM3NLjCCwyjH2RLw68W3hTz1so1yLJJW7lCgqglvgTXDpvtaKu
 4hAyjzqAsBrMD+6ReKQk18Dw8i/ggUNZwKtrVeFsSfTkcsXIwSbCZG52t7SeJeYFUnKq
 sSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737544839; x=1738149639;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QocBT1S8occoxAmaOg1GsN/khxZxiUL4njVzKD1pHKI=;
 b=rNEns4HCiWqbcjtJyTREY/hRwb3MentiwLNQaRaxITwWShQd72iXgqNSutZFLSc7rT
 6PwvRjVWnVjC7gcVitiDi1+wH0V+2m7HWPZXDU8kjRLIbj9u6UIxRilGxqjy5XzcJ0IM
 eAX05WPPiSLum3UJuevlbQSnK566139FIyDY4JVA1WLuW9qPFJoO4vPl3g19+azsdL9N
 4lVRai+9EET6WOzyv4T+rDz8F1r7m21DW/b6jd1MFtRs2plcPtIMlfJE9ejCDFU7o+/D
 fZ4FARa72wI/rdLXo3CFtmmpt7FgzEr7w9Z7xjtpH67iis9wy+mW1bvVXyJOTU7kNF3a
 Uxeg==
X-Gm-Message-State: AOJu0Yz6gaene+4+TCD8OsYvX7dnal8fMP5idA3CpRLoF0van1JTmwiN
 hwi6LSQx19tkIz09P3XJJzuqZVWXIWB6cr+MeFc0dI5JMreeNROk5FbDr56pVzw=
X-Gm-Gg: ASbGncvYh9yJMyKb6kDucLoYlOAKblMEaRtqX0F8s9zL1V2krJ7nzmZBzdcoo9YSdi4
 GlxJuzJW/lvhJ8Y1tWx0DkigDlMhpAcMvmDX2fXT0j8M4IjIf86/por3Ui+n7GZBY83ZbuZpDGE
 1jGM5UX6UFJYLQf1eIhtsDJ5C+OdOj4A+plApI8Z/yKboyU8DlE4xsimqPoS2D7W79ZZCk7lowo
 RSNwCgM4gAtDE+P0TQTxCLay8sSGlYs/vyEz1J/8saL3m/ESGcGMWEwORDUvj3V9Mf5
X-Google-Smtp-Source: AGHT+IGbQ3IDO64pan9vd0dNrUtAMchD1UtI7yDOZoTsv0c7R6ZY6xN9vW2tBGTVEqUvfn8mX9dnfg==
X-Received: by 2002:a05:600c:1908:b0:434:9c1b:b36a with SMTP id
 5b1f17b1804b1-438913dbf63mr189318905e9.13.1737544839305; 
 Wed, 22 Jan 2025 03:20:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31a21adsm20673715e9.12.2025.01.22.03.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 03:20:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55BE05F9F8;
 Wed, 22 Jan 2025 11:20:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Leif Lindholm <quic_llindhol@quicinc.com>,  Leif
 Lindholm <leif.lindholm@oss.qualcomm.com>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH v2 4/5] hw/arm: enable secure EL2 timers for virt machine
In-Reply-To: <CAFEAcA_yqw2DJ_iPpwYXjsR_h1gAZdOs29b-2ar0QOg4k4D0hQ@mail.gmail.com>
 (Peter Maydell's message of "Fri, 10 Jan 2025 12:53:18 +0000")
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
 <20241218181511.3575613-5-alex.bennee@linaro.org>
 <CAFEAcA_yqw2DJ_iPpwYXjsR_h1gAZdOs29b-2ar0QOg4k4D0hQ@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 22 Jan 2025 11:20:37 +0000
Message-ID: <87frlbnlh6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 18 Dec 2024 at 18:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: qemu-stable@nongnu.org
>> ---
>>  hw/arm/virt.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 333eaf67ea..5e3589dc6a 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -873,6 +873,8 @@ static void create_gic(VirtMachineState *vms, Memory=
Region *mem)
>>              [GTIMER_HYP]  =3D ARCH_TIMER_NS_EL2_IRQ,
>>              [GTIMER_SEC]  =3D ARCH_TIMER_S_EL1_IRQ,
>>              [GTIMER_HYPVIRT] =3D ARCH_TIMER_NS_EL2_VIRT_IRQ,
>> +            [GTIMER_SEC_PEL2] =3D ARCH_TIMER_S_EL2_IRQ,
>> +            [GTIMER_SEC_VEL2] =3D ARCH_TIMER_S_EL2_VIRT_IRQ,
>>          };
>>
>>          for (unsigned irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {
>
> Do these timer interrupts have a defined devicetree binding that
> we need to set up in fdt_add_timer_nodes()? How about ACPI?

The DT in the kernel doesn't care (why would it, it never sees the SEL2
timers). The hafnium test case works without it.

I'm not sure where there is a DT specification that describes what
should be there for SEL2.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

