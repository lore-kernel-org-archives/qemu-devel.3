Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955D9CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX00-0008E4-6K; Mon, 11 May 2026 16:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMWzq-0008Df-Uy
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:12:59 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMWzp-00086w-A0
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:12:58 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-6312b8f8e47so1341925137.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530376; cv=none;
 d=google.com; s=arc-20240605;
 b=IetNU+GKMGsYkVbFQNWMPmBpu/0GNPqovuCEZLlrJpXej4Dpi7CyNsboK2H7//iRnF
 6NYA4HHZ/LTJ3ZdzMEi5dQmZHvds8PbsFaOO3gjFT5JPVIKOoLt9KG/hFBCS3f1Jukv/
 L3gCB7F4di2klV0KR+eJbR7ntdTA8cLTEF7Z6j508E2DMkOoyMLLDIKUobtabDluuJm2
 pAwYGivsPLOD/tcOS43zhEe64hv0yigU7dtTVwsf8V02ENIZHXxXlT1XMvEFaJwdR4c4
 5HnJ8vDomkbNG6VkvZ/QFK8hisKhtFeoSMtajxvgMJnsmKCNM7Ijm651e0XFGPHwVJj/
 KxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rhSPeK7NkKkfR0tTDs+smKdVXZf2lxYFlNNQ946fXsE=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=TdQCiFs4k9Qbazlz5pfJw6cewuiyZ4djWbPa2horCab0iJxNEDSbKMes8nqsbPxIcs
 YTCSNsDQSSMiP2KumvCmw64slqFHKj15we6IXxOBM9P7ysFaMHCKNGYC9CUBp4fJUmFC
 ioWcLlN3TSwE4GOLCbKD3EXcbbYuxwfYOngGvrFu4m62ypTd5EAsnCjKv2Rmv4X6qQg6
 oLAh0R874pkdsTI5ijrRK8zuO6oK0Ugn1DMYyVWvDZ7HHHR3/LmrsWgdkYsiarnWmVDm
 OejYvP8pnB6ZzEsp4dqOo7jTZ2zAjv/Set79LN/kfuFqLGJ/PlfiMx6ax+0WEv5FeZZq
 7zNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778530375; x=1779135175; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhSPeK7NkKkfR0tTDs+smKdVXZf2lxYFlNNQ946fXsE=;
 b=m1AACUMrmnV85L/72Y9rY/TQWyFDu84OUSzjhDUJbJODD/aiuN+/YR2mOg3QLV2R1M
 u+XdRVd2JjTF44FPYSR/T5wo6OurO4TMlszBtPrFBFtV3p0e1I64i2ltsrm5KEOXgJ5h
 u8uLzNR5WHsUoFn+VeoZ/7jVWZGTkzwooB4nkcQrS8u8SaupGfkD4U629kpFdXfQCVcX
 pp7z6UCwFJFPJGeyNbs5C7OKrGrQnH9xnurPsybmCPwJSKjzd4DIh9BfdJ5ARfPTmTKb
 svAfKYkjMdZtluzIiYGDyPF4GpuKFNyjIt0G0O5T4KWZK8X83zqpgj5z8tt4dd+UOWVL
 nbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530376; x=1779135176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rhSPeK7NkKkfR0tTDs+smKdVXZf2lxYFlNNQ946fXsE=;
 b=kTlgRYZcx+9D4/xCDhmoceyn0OJBlUM4WzXZ8TkwanFUxFQElWk2nVkb6dW1kmG++/
 JNDYJl9SyAAz53ZVgFqd3aV11ZlgEQpIVlyJypQfv54AyMRIXerK0wpyXOcSObik4I1O
 MitVPrJqRTSvA4PV+Xxua5YB0fbee0POIF4ZpgFKbWnZDeDnMQZgKw55M844U2AvTmT2
 nFPer5Nt/W4vDEJaB+8Sfgc1lGoITyzoIFct+K11PfQbVQn1hIy1QtjQDgy9BH3UY9r2
 wxG7s8o/VAFDTLCpHIvTtGYkYm7ywRoiIWX3ZvA7Za+QrKWbRs3O6uiaqYU+H9xapg98
 5aXA==
X-Gm-Message-State: AOJu0YxMSfZg0kthHFkW5VhGAzvmcxAyr0cEyfYLTnapDojaMjgFVfVF
 oC7j6Qa/7jiFBSb2D3ZgzfAG8NNLwJMkDRZVfOWC78jnxJthH2qf4oJhdYb0guksuyXVYI5CDKr
 dMKMWwE7T5FZQGEWDLMYtzCmvxgHPoRs=
X-Gm-Gg: Acq92OF9m6JcaVhuTJYZj9mgi4AXno+FogRSzyHy9lkg8x1iu8OVy72Cx9KBp0Ej9Wz
 6b9bIN0qA9GJY2/BhwZmjSCLW78kGGxwlN4Cfa1bN4pGc5n+apORosvE/nw8Xu7iQpWDAzK6rzF
 PvTZx3EvR7r6R7bMYrmo+5uBlHTiiRifir1lC6oAv5x/9QDwCzcBwpu2YaRtxZ5/lvdJOmMu9HM
 hY8YKhI0wjeRZdF3fJiajGi5uy1/0uzAzNSQyiyVIHX2UWn7PDnZUQnkwV1AX7Dr+7XpZf/ygqf
 F65XFlsYVYnMHfhTLmP0jj30YqXb0gNwyhAsEuD1m0ryPv2BpE1lam/ciDAduraB6Lf3
X-Received: by 2002:a05:6102:508e:b0:632:73ad:6c4 with SMTP id
 ada2fe7eead31-6361571abe8mr38747137.8.1778530375538; Mon, 11 May 2026
 13:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-15-5062889c4d3c@gmail.com>
 <39cfd3f5-0c20-4246-8fe6-a0242029d88a@linaro.org>
In-Reply-To: <39cfd3f5-0c20-4246-8fe6-a0242029d88a@linaro.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 14:12:44 -0600
X-Gm-Features: AVHnY4KG3v2OGWtAqSLiak14L8FAYpIpoP_pvSM3qZLr3Psw1CxjXmQpGwObdMA
Message-ID: <CADvTj4rOzkzHJ2BucwnnV3Pw=B+dtPuVFb3G+XXUg8jKhTeo5w@mail.gmail.com>
Subject: Re: [PATCH v6 15/35] target/mips: add Octeon MTM0 instruction
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, May 11, 2026 at 1:58=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/11/26 13:22, James Hilliard wrote:
> > +static void octeon_reset_mtm0_mpl_state(void)
> > +{
> > +    TCGv_i64 zero =3D tcg_constant_i64(0);
> > +
> > +    /*
> > +     * MTM0 defines MPL1 as zero; model the architecturally unpredicta=
ble
> > +     * MPL2/MPL4/MPL5 lanes as zero for deterministic emulation.
> > +     */
> > +    octeon_store_mpl(1, zero);
> > +    octeon_store_mpl(2, zero);
> > +    octeon_store_mpl(4, zero);
> > +    octeon_store_mpl(5, zero);
>
> Where do you get that from?
>
> The octeon2 documentation, which only has MPL[0-2], MTM0 does *not* modif=
y either MPL1 or
> MPL2.  While I don't know what changed with octeon3, I really doubt this =
statement is
> true.  It just doesn't make any sense.

CN50XX-HM-0.99E is OCTEON Plus documentation and covers the older
three-lane multiplier state. Its MTM0 definition is MPL0 =3D rs; P0, P1,
P2 =3D 0. It does not define the OCTEON III rt source or the high
multiplier lanes MPL3..MPL5.

The behavior modeled here is from CN71XX/OCTEON III. CN71XX defines
MTM0 as loading MPL0 from rs, loading MPL3 from rt, setting MPL1 to
zero, and zeroing P0..P5. It marks MPL2/MPL4/MPL5 architecturally
unpredictable; I modeled those lanes as zero for deterministic emulation.

The MPL1/MPL2/MPL4/MPL5 handling is therefore not from the
CN50XX/OCTEON Plus MTM0 definition. It follows the newer OCTEON III
multiplier-state definition.

The legacy form remains encoding-compatible because cnMIPS II MTM0 rs
maps to cnMIPS III MTM0 rs, $0, but the modeled state side effects follow
the OCTEON III definition.

>
>
> r~
>
>

