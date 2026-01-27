Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA903D2FEDF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 20:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkpQd-0002oU-Cf; Tue, 27 Jan 2026 15:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkpQc-0002nM-1H
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:12:46 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkpQa-0002M1-Hy
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:12:45 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6581234d208so11362076a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 12:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769544763; cv=none;
 d=google.com; s=arc-20240605;
 b=ks1QyUmLMs8VojaqTaNtCOGoY3X8Tx+OWgL8wzrOD8+LrkgF+699Q+0TLBDQA013RF
 rVwP3WFCwfvLFDDmpTE4kCMBHUQYnzYrKrKQ4OQHMF7QCtrbBwF82Lcl0PiMBEyShMFd
 M2ZgSUBYTJImUbY+DEL/v8DpwCNuLiNfe8k/eyOx4ulWns4QL0VeR8468OWontyiO/Bw
 X+cI7ShSHwktxVqo7e1bMuAqD3V0dLAOZ9M8NEiJgw21GzvkV7op+XnF9XqFQzVqXutp
 2SrEbq0U2PQg5QVLow95MhWChI4+eo8ETyi4tXk30AtxjBiERHSkiGdZPFYqJPXcTq9u
 r8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l9nsUQCCxtXPjWMaUQ/jE36jnFYIUiXbfc2AIR5QMbI=;
 fh=hmSkkd53fsegiHXUS9hyi8heToHF8NxBjn4DjKBdjH8=;
 b=h+puy7gUU5bcHGlG6wjW+2FFjDvpyb0IJBwDjQUHrHlm48PMka1uL5em/fBAo8JK5O
 XRtJCiI0OGk9Wt9FP2KiBgvafuE/1k5s+/n4ZM7cP0+M9OTKUZCQTm78kCy2lMG2hv46
 LoHQrVJQEXFk3g1XY5Gn0me+1gtUVhLollYLu86SpjwZNQtAYfzWtmCSJRRimj7ZL4vN
 JsUx7GeIyiHKTwup5Mjmc4jR7is8vlgu9ZuSTjYmPYN9geOsAuIO/TmbXVR1k/VtwI90
 +JeweiK+2oa69XD3iUGj4OC5hujNERvUUnix7j12ZBs1Gk5ut/4xk9imYqVd7EBrb5gi
 nC0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769544763; x=1770149563; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9nsUQCCxtXPjWMaUQ/jE36jnFYIUiXbfc2AIR5QMbI=;
 b=CLqFMMxJL8oI9sHh4eBetwOhmFulXmmCpxf3H8/6fG540kjxb+16SOwKlmYCzNBUg/
 QmY4ZD9X6KbM1LZbExreigfaYf5Yp2tLsQ4zoU92U+toWO+2wAq9aQWZFAmLXHxa3Wh5
 qE8FszktUUDA644JFPK5GnLle8sS4bEBm3411Ky1SGuJl457SBzHZWqxat7YgcX8zpx9
 t91hkk18X/hXhjMh2d146+Optdau1d8oJqCQTjw9czAeL7jsXv3EUySfvsj8lPvIiopL
 Gz3JXVB//LgqP5HF9irlLKVSNjiEkpjLRDJd3RgtteRCEf9gL62cwI6cniR4Kki7eyzt
 z8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769544763; x=1770149563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l9nsUQCCxtXPjWMaUQ/jE36jnFYIUiXbfc2AIR5QMbI=;
 b=S3Tz+O2aDZ9fWiDDOeuQCNc3iSVORLmfkLIlvuw+bo0CyPBIJoHJSVxzZDsyk+Q4xA
 5WN5fi+NQTfnwjdTF/JP0NWSwHJbhNHUdrcpKg8fdMAuYMTRxbIBUE/7OgVrQ7/oAYu6
 bYaDq0oraSdQzEg9935aKlTjjERhX/fssevwpoBQZxOoGrbxp2oZIxzSFcPFa21X1DHR
 zM5PX21TAWFFZVkavYRf1GHayHn+A4g2/3PUvQfJ58Atzn2BVZLrHTRcHHPpPS/V1tvj
 1eX68GPXvicCBy9vuCyAaa+cHU8TVadWQYx35aDD2Yz0W1nln7Xi0guip2mp9KbOyEfr
 6FjA==
X-Gm-Message-State: AOJu0Yy51n0bvxoZl0ydysaA+7WENrQgG9JWswet5UEqKDFcR0k1b9o7
 hj8Yh2SpMsCzExsFAkZxEjFLU7gA+vG0oN7aU88EyFV9JfACu0g/n6pppSfMKIoE0+DZm7YPFLN
 iwP3sC7P76Y544OFLjR+RBvmc2CbFY78=
X-Gm-Gg: AZuq6aJczi5LeHp9DkjuHbfGkC2JZkZ6pWHrEV9r85alte2iwtUqrKrJtgosY9OxF+C
 D02ddEieUT/0sqFctPadTGMjLOyS0l1Hcq7fdldN3ygvxMlReXhOjVqvgaeZz7fKo0GUrc004bI
 gynkACgzJgZ73QU4UcFgBhiRIIGedgpUrHQgiUWL89zXNYWyjEssv2R/W59MDq5nhohG7fJeZoj
 dLvgTKBBdKpFn3pke5sC/kuegvHNsJeOgR4OWgmJcBXLN4WtzIxuzWyd1A4q+dbf7e4SIeM
X-Received: by 2002:a17:907:7241:b0:b88:7568:26dc with SMTP id
 a640c23a62f3a-b8dab37cea1mr224738266b.43.1769544762658; Tue, 27 Jan 2026
 12:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <20260126174313.1418150-19-ruslichenko.r@gmail.com>
 <aXh6EHwejpTVoYXY@intel.com>
In-Reply-To: <aXh6EHwejpTVoYXY@intel.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Tue, 27 Jan 2026 21:12:31 +0100
X-Gm-Features: AZwV_Qjfe6_K5XUhLvsLSkcj398HeAEjicx-Qx1OM4PrBczfuAreCohiL8yXer4
Message-ID: <CAN-aV1H1a6moy103JDAJ-1RYVQDpjYL3Ug6oFY0q4ZtRoC--yg@mail.gmail.com>
Subject: Re: [PATCH 18/27] hw/core/machine: add '-hw-dtb' option for machine
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 takahiro.nakata.wr@renesas.com, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Ruslan_Ruslichenko@epam.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52f.google.com
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

On Tue, Jan 27, 2026 at 9:15=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> >  static char *machine_get_dumpdtb(Object *obj, Error **errp)
> >  {
> >      MachineState *ms =3D MACHINE(obj);
> > @@ -1287,6 +1301,11 @@ static void machine_initfn(Object *obj)
> >      ms->ram_size =3D mc->default_ram_size;
> >      ms->maxram_size =3D mc->default_ram_size;
> >
> > +    object_property_add_str(obj, "hw-dtb",
> > +                            machine_get_hw_dtb, machine_set_hw_dtb);
>
> What about object_class_property_add_str()? It seems this property
> doesn't depend on any other state, so I think it could be at class
> level, just like "dtb" did.
>
Yes, it could be done by machine_class_init() indeed.

> > +    object_property_set_description(obj, "hw-dtb",
> > +                    "A device tree used to describe the hardware to QE=
MU.");
>
> maybe "A device tree binary used to describe the hardware to QEMU"?
>
> and none of the other machine property descriptions have 'periods'.
>
Thanks, I will update it in the v2 patch series.

> > +
> >      if (mc->nvdimm_supported) {
> >          ms->nvdimms_state =3D g_new0(NVDIMMState, 1);
> >          object_property_add_bool(obj, "nvdimm",

