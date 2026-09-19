Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6223C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 21:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x82cE-00011A-Lb; Sat, 19 Sep 2026 17:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82cD-000112-7R
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:28:57 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82cB-0008HB-Nm
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:28:56 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8c7a1aeecso844820e87.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 14:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789853333; cv=none;
 d=google.com; s=arc-20260327;
 b=e228XhfR88LhYWe1M1ixE2BSrJhipvn6KoVLesY4Xr8gj9sNRmId5YFxZaBZCH42PO
 tYzH69tTWqKlA5Y9ljZHhvchg4MmtqJA/Mpzdx2hTS9XFdlU0POtEFQoiOzk6Za+mMWA
 vaiGRX4eRYGk8lVxV2Xw2Zs+FD7i1AGUYjmrta5VxUK6YV4tdwcOqkwi+q5Vaz+RhRIm
 cvHM49KJjzJ8w0Cto2e2tot4ZD7G0zVHvkFasf2COG2PQHSxHUPEe68P0auzonztX65B
 gClUkhv2ya/qQJMeIT4jZsbjiF+xmgrZkRn/f8vz36sukN/CoCLi4fDM1o+8tsGeYzTo
 2Jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AoJb59swFyrwZvvUPhYOcfc+MhSM0ELMzM6zvuwGCFs=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=SbNan3hbG3bg3MXdeOuSbUQ2ofR9iBOGR8uWggwQupcI6ZxK0xxoAnCGaV82E4nq9S
 E6ER1q5e7PUtm+lTAXBleg5n0J/0ImuXLopQupdlBJ5pyyUCtQte6GnrwTwNdTslovm4
 H6OPnpWFP2d36fkcsrJsh7+1UHr/SdiWqSk70hBLijPv/mj7ZrMO4ePP1DYVJ26iY0Ep
 ly8JLc5IzTeG700AzcpMzsfz/K+LuNLsoCdOBHf6AY4YXUHIrRLvzQPYrBAIqQS/sgdX
 92ZndyhOj1RcUqXPaCCby19WxmUQKgstdVVtcrypHKM067iIF9PN7mbR4OFl5RQN/9K2
 plvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789853333; x=1790458133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AoJb59swFyrwZvvUPhYOcfc+MhSM0ELMzM6zvuwGCFs=;
 b=sOKJBi/TXQywmLcSntGoygefYnwx8e4s9p/UICaWwS6slMt7flWfY+8jOq/9FwqbAh
 B07N7C6tDgGVzkVe10SyIIY1vAvcDmlIk4nE3JyhufxMIxYir6E22I+YX3tjlUbOTaHH
 mt8C80bsBY5UVFP0bAntn+8dv4ntbNwzylKkCpRp6Xeyz0bqCX/LupDDQUwMX2j8s+Us
 fpN9i1blsihJeatsRtqjYx4Odfg+9yguWkNUc29CbKJmjLWI5d/dSR4QI6/J5PtDmP9d
 1QVTlSIfz0zTZutjPL3jpfCThQtgVVv2i3Kbmcadcses4tx1S2RNySSfWpM4siGu96eM
 1+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789853333; x=1790458133;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AoJb59swFyrwZvvUPhYOcfc+MhSM0ELMzM6zvuwGCFs=;
 b=aZ18xJEG96DJeQ7WhJU/bVqYTOWFWpVnOO5Dwbx+ZZWmeIL04ccQVjYHbplyHiduG8
 ICmECIc6OxIJJI1XQIExEszTfQH1X8/geb9Wz3gM+PDV1QcL5nAxuKombcL18xzKGcFV
 Ue5exLXdzA74RAlZTBn4AC4PSfDDbqSrHuxCtKt+ULSuRaScKxkutUp0WT9kJBcOp/S/
 dbG21gq2lEQrkDq0gLGkg3c2XfOG8PIg1FfJIy9ETK3N4kO5Re4IyA3CNN3H09vv8Vde
 em/eUAUIAFC1bpjIJ42vVT8JqgDJLY07iypBKNj/SAE3QydIksnvf1SFzSJSDlG89cyM
 9UJQ==
X-Gm-Message-State: AFuF++llsbIEA4WLEon3Mo7L/0b/R04QfAJ+W9pVd02N/ndvIyUn7Bsq
 9Cd+NbV1nLqltNy4jKce8LgVrN2eYlIeUJzq/bPBROpmLHUfpbzRtkmgDttqc2V91Rq19PP6ve9
 sTBlX8UwkOk8afTCuAB2ZooCCnAljAVCSxApXuA8=
X-Gm-Gg: AYBFou0Uspg/VuumOS1d5AmyI0sS2G8FA9fYgE67JekxzUNGosQjen2hP6fDozy+H2e
 R14k9w80CyMBLwCdEh2inE0thrvSuhBhXxpG0A4o3RpAIu/7dvWGFrWj5GUpo7pBBiWCyz0jyOZ
 MTwsuLYE5pBzJdMJiZmkWg9FDd3kvUqxkOuO1o5eJfreTz3otyBvXI7pH0T4PVpjLzUfa4TKrkk
 GoF7qKnmvDEFZWOnr2pMgu/AH8USckQjjajD8a0FfZeXfwiptZ5XPwVnXu2qJyW5U+jqF/3EhNs
 n5Y8JCzBRH00fJp74NVsoKhuNcpHSLOxpVw8U8/9NI++knAiI+AtuD0TC+ukF6F03sKc8KzPA65
 YKECJq5AiVNwJCw==
X-Received: by 2002:a05:6512:3d0e:b0:5b8:bc5e:b56b with SMTP id
 2adb3069b0e04-5b8c18458bamr1861610e87.35.1789853332653; Sat, 19 Sep 2026
 14:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
 <20260917093307.1092084-12-richard.henderson@linaro.org>
In-Reply-To: <20260917093307.1092084-12-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 17:28:40 -0400
X-Gm-Features: AcwNN1WDyvW8O7jCh_CJ71EF-VumlvnXfwzQ3dv-eevOneKmKfq0ihYlm9jq-7M
Message-ID: <CAEdQ38F1h0S+boP1j4Y4umjS2iE-joe8xHzsvscNjfdmH-JWwA@mail.gmail.com>
Subject: Re: [PATCH v6 11/13] tcg/x86_64: Implement INDEX_op_goto_jc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 17, 2026 at 5:33=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use comparisons vs memory, short branches, and
> an indirect memory jump.

Not in the posted patch, but in the version now on your tcg-matt
branch (a4f48ea23a):

    unsigned free =3D (ALL_GENERAL_REGS & ~s->reserved_regs & ~(1 << ptr)
                     & ~(const_fl ? 0 : fl));
    TCGReg scratch =3D ctz32(free);

fl is a register number there, not a mask, so this clears bits by
value instead of excluding the register. With fl in %rbp (5) it clears
bits 0 and 2 and leaves bit 5 set, and scratch can then be allocated
on top of a live fl. Wants ~(1u << fl), same as ptr above.

