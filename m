Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5FDC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 10:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSYnV-00030M-Rz; Fri, 20 Jun 2025 06:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSYnU-000301-3y
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 06:16:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSYnS-0005cM-AP
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 06:16:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a528243636so1044674f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750414592; x=1751019392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmMUq2T8ij8SVIaPXSPmqS+yLtQa8wjb1YzKfA7oT3Y=;
 b=FegtKFM2thCDOfO4H7x3t+Rh56+i0A9syzFanvmBNjM8IApYeu64t4Tq2uE2HstcLb
 C0L82Pgs/8Am8VZqhTo0ir6P1xP34A3wK/AU/S8e/kRSj09q69xE7p44KbLNgzpiv3Ys
 XTwWFsNWvChM89XKns8WbaOnTnxheZdFCZEKdCeKsPFA71ERF9q/l4cOjvpnZmWhd5vP
 erDXMwBYmCjYCpVYdpz7UJQ2eUcSr0XSV0QW1CEUJOVqQGQqYlGMjLuV7uH1iIP73saZ
 v1X4fq2EAlRz87GqqZAPhU2QhfFBUflW6WWZoo84gHAS9vxwfUK/s8n0weYcOXT6DjJo
 yyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750414592; x=1751019392;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmMUq2T8ij8SVIaPXSPmqS+yLtQa8wjb1YzKfA7oT3Y=;
 b=C+UbhlB6KcYpi75DL9ItkuzMDvXsVW5Ni3wSqGmCULqMcDIblTxcjXVPOPGfUwdAnb
 R6tXuHGttyn3w1wzgJQiNabZYcXijuBv2aYIVABK5izlHA3oMtiRjNSJy3ooXb+w5qw/
 Gy1EXKsgd9d+dIctd99xnKKeF5cpgHAiIDku0QruZsM7Yo7C/5WkJiVvL//JlnM7vsNh
 j/n1QvZDwpHE6Rc3CPJJChimNvjBcdCbt75go/C268i7Z+LRuIDd79eUkjenz9uKaLz6
 /Vvo4pEk97j1Mc1rMoXZW2o5bhdLZYyxnZGAK+OA/NT9od6R9GmlTlnXaxIXm38QU3O5
 l0XQ==
X-Gm-Message-State: AOJu0YxDxKHLZYKjnM0rZBO45zaBOjwMIN39pOe8QNBSk+I38hGqrM3S
 Q6MuGO1mQRkP17Jg5TrgnnsLl75wQoIEf9eBj3ww8aKVrkIkpTw9Up6a3qoUOp+RgKk=
X-Gm-Gg: ASbGncs7SiNCEvr4XowpcSEdBIMcnecdBzyKh2jeLreIrYmr4U080rUMh15HcDBym59
 aCgWtNC/td+PP5N9xd5JjdIUUILYAuu1aPrGId8RhYdG4dA3JO7md68szWFs5H0kWN9F6e2FgiN
 cuY8IWWQ3FmQ00AE4puz4T+lLgbb6ECXrDLfKx0Ze/2zdENjhqPqljElIfo1zLqy/T1Exgn63kH
 GHkKOQPtk2hR+Yhy5uslHuSt7Zr0i4Xnn8jjGtbW1IZZJtjhES3bKjSsvbJPL9cTv3/hq+iwIwH
 dlgrdrs4KdERC9scDjHfnMlEGjvkxg/AZlrpo1fzbViOWEOwYHZ+RAYShACVgr1NHdCuwQUsrw=
 =
X-Google-Smtp-Source: AGHT+IGBrSaRLSyi0kgcsnYKF7XefhXYzo1eGmEfdfHRFvD3Bc/myUsl+ddyLR/OZVKj1GSIaD4Row==
X-Received: by 2002:a05:6000:1883:b0:3a4:f918:9d4e with SMTP id
 ffacd0b85a97d-3a6d12e0c22mr1683765f8f.41.1750414592085; 
 Fri, 20 Jun 2025 03:16:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1190c9asm1653587f8f.93.2025.06.20.03.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 03:16:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C89885F876;
 Fri, 20 Jun 2025 11:16:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  "open list:ARM cores" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] target/arm: clamp value to account for RES0 fields
In-Reply-To: <CAFEAcA_TODi-ZAkA900eV02TyKKD+gib4YxscUomoDt=q+RT7g@mail.gmail.com>
 (Peter Maydell's message of "Fri, 20 Jun 2025 10:58:21 +0100")
References: <20250616201042.2196127-1-alex.bennee@linaro.org>
 <CAFEAcA_TODi-ZAkA900eV02TyKKD+gib4YxscUomoDt=q+RT7g@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 20 Jun 2025 11:16:30 +0100
Message-ID: <871preu39d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Mon, 16 Jun 2025 at 21:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> If the user writes a large value to the register but with the bottom
>> bits unset we could end up with something illegal. By clamping ahead
>> of the check we at least assure we won't assert(bpr > 0) later in the
>> GIC interface code.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  hw/intc/arm_gicv3_cpuif.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
>> index 4b4cf09157..165f7e9c2f 100644
>> --- a/hw/intc/arm_gicv3_cpuif.c
>> +++ b/hw/intc/arm_gicv3_cpuif.c
>> @@ -1797,6 +1797,9 @@ static void icc_bpr_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
>>      trace_gicv3_icc_bpr_write(ri->crm =3D=3D 8 ? 0 : 1,
>>                                gicv3_redist_affid(cs), value);
>>
>> +    /* clamp the value to 2:0, the rest os RES0 */
>> +    value =3D deposit64(0, 0, 3, value);
>
> Should be extract64(), as RTH notes (or just &=3D 7 if you like).
>
>> +
>>      if (grp =3D=3D GICV3_G1 && gicv3_use_ns_bank(env)) {
>>          grp =3D GICV3_G1NS;
>>      }
>> @@ -1820,7 +1823,7 @@ static void icc_bpr_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
>>          value =3D minval;
>>      }
>>
>> -    cs->icc_bpr[grp] =3D value & 7;
>> +    cs->icc_bpr[grp] =3D value;
>>      gicv3_cpuif_update(cs);
>
> Yes, I agree we should do the "work only on the 3 bit field"
> part before we do the "enforce the minimum value" logic.
>
> The handling in icv_bpr_write() has a similar issue.
>
> (Why was your guest writing garbage to this register?)

Heh, it was writing the SP instead of the XR, this is how I found out I
was getting it wrong ;-)

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

