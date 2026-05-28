Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840D3CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 12:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSZsw-0000O5-1N; Thu, 28 May 2026 08:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZsn-0000NR-9D
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:30:42 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSZsh-0004tP-Nm
 for qemu-devel@nongnu.org; Thu, 28 May 2026 08:30:39 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so325493d50.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779971434; cv=none;
 d=google.com; s=arc-20240605;
 b=bK5fhd2J3sPGZKghuIU6PRBnjwXQ9fBItmns49wlhTliTfq5Hc5ZLdumFSSasNiYOM
 uAuvSeMhcT92PHLnLYVpxMiBS7oZ3UKOYalCw/NFBdjvCMcLcgDmwAG90N5xt0oVDJfu
 4Oxr3xuGkc0YsmBDckX/mbwVYgBgMy6h0QggudI2r7FOm4gjDx754NjSjMjr1e5a9U5j
 Ag81CP+EP9WVkkqiNCFxchHTocRLEamvixkzVrVOZzgNDAP34Cdk470uVl4z7S+iVW+E
 l5OAeo0wQX7OHhtCOM1+VuT9JYKBrtbd7BZrDnK4HpPHAHct6RimZkhOvYNxxmwCL8F8
 l9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4pvj0dvBibQpvPV6F4+6ZWxhtEE49L4JLE26jtC8kfk=;
 fh=uCmUPCW8pkfAYUb2TNqBA1N8JsXLaq44DlF1L+QbvNc=;
 b=iUdNdFheJ4vvN28uNUCTPup2gb65WNg/zv5m7nNH9RoDDMQEUeKiM+OMhkO+8le4Cg
 qkIaydueTS821VG5qLgXfoLnUb9HTkBHNRXTyxiQaT3i0Cwq0sqWjwTSnML0qBVB1F6V
 NKE31J3pBGG0T/E+gc2BKBa5rPvOMOmEw5/IDEie6Eu2c5WW+b70QR/rtJPRc6PTpS2W
 KMIU3pkHq7Vc7F1iXO1ekIJYzqjs9B9VLP6MNKO6TAkwWtfYMtOMDLO/Lhmyz9WntrZA
 JicniMRfmO4+VU6q4ZMTuF+CsO1q2tWUN+kpAKmmdY6psy+5pCWrTUyhryLA9kZjsFh6
 mlmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779971434; x=1780576234; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pvj0dvBibQpvPV6F4+6ZWxhtEE49L4JLE26jtC8kfk=;
 b=UJIVF3pk7jnMPkCgjAGl7uHuR8ga1OebC2mnwVHeIwWFDKKh4EaDrHg+Lrh3vbQZKG
 KBr1YN9hwJ+9s04cx0VUvVrwoDiPbvGZpJa5Zl2Up+yoJiOctjLdyecvnsVR/DVQSmS9
 Fcc7E6O6PCQkzIw591KJZVNdMsBMVe5Ne5u7Tre2fo3QkpEwHZj1W2TkHXGQONrLFcrf
 Y6HD40mZjVotJ5L07y1M7iiH3CRfvm0Rncj0NYjcySjgFngLdHHK8rmbmHiplKvnDYEu
 HradqWHJRjuTVc9YFwB4rsJJP1kLVijtjtGneO+OtfPZB6knpL0fRnKGLntCb/Cyi92T
 a6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779971434; x=1780576234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4pvj0dvBibQpvPV6F4+6ZWxhtEE49L4JLE26jtC8kfk=;
 b=proDigqEjhifArZ5StZ9olpzIZDNbcWlOCRYa4DEBQNh+IZ4ydgAEaBmoQsA8EW3iL
 fx6kC1bFDKtAHtWAy55WKdq6W1QHPlv2HEI3NnNf/gRubgH5JHhyg+yHHJ/zTQrVYoca
 4x3renq8T3LwGk6xVYXSgia+XvP/ArKB630MYPTnHL3OxaxA661zxB2dv3+SQzz7paAB
 qdIopiqJ27jj1nbVBowVjud80jAsLpMBQ4fo0/Uvd05sB8pPeiiseFKRqpL0U8IcLVZF
 qEm/x1AU2rMzhzbL+8rNyWHtzCcDz2JTh41HKS47NWtE1MkOEmSj34I3JRTKrJZc7kM3
 mleQ==
X-Gm-Message-State: AOJu0YxnEAQkED6U8xfnuDxWkFjL72CfbSJ97/5qW6EsvAmpHlSEIhcW
 7KNjWCP6UkPTlTSXnOabEnfpAATqHLw366yXgofLWYv60YMkzbx3lndgtRuzKDXp//Q6j8yXhAg
 fwoNReuF0lqzEuLgYz0xlz7yivnPHnjF+ghFRDonVqA==
X-Gm-Gg: Acq92OG4aldEcxkcGAqpr+KvNVloWWQ8xCrXE2C8AgETxgk8TxqfN9HEtPUmy5yIhr8
 MZ9N5pKtdOn3lUn2lt7293IiMnYJ9VB3Fsd6CTL7hhoB/T8JCiPdElMPE3KSo27B6MEixvVF0jG
 evl7mdxsAz6C5XLHfLhVA3vt/fGRY7n2yIkr2jUuB9AU718h7McbPHGcSY6S6fO9sZzcsTkxN8o
 jedjEu6xPVpPP95VhZyoj9HgHdXlAviLzJLwS4QRJ7E5U2rT819g10w4GAAJFHPEtPvjiirhlx/
 wkvgVTHNMfAuOKaZkFwrauM6aYCC8MIGFu9BCtHG2+eQ5h3zspQhRysrvploaUegtxRO7Ds50tk
 Mug==
X-Received: by 2002:a53:d050:0:20b0:65c:7352:7afc with SMTP id
 956f58d0204a3-65ec98ea67bmr21313766d50.31.1779971433909; Thu, 28 May 2026
 05:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
 <20260518073401.11279-12-corvin.koehne@gmail.com>
In-Reply-To: <20260518073401.11279-12-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 13:30:21 +0100
X-Gm-Features: AVHnY4LS69lDHy96y5bDPvR7CE_spwANsS5WL3dXpgHusQ-W-NuvVVHpQkB1fnk
Message-ID: <CAFEAcA9s8ztFQY2pbpnx8f_EEQwNgKg_jSBxVjj0qqia8Omn7g@mail.gmail.com>
Subject: Re: [PATCH v7 11/16] hw/arm/xilinx_zynq: Add flash type as machine
 class property
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 18 May 2026 at 08:34, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Introduce ZynqMachineClass with qspi_flash_type field to allow
> different Zynq-based machines to specify their flash device
> type. The base Zynq machine defaults to n25q128.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

> @@ -152,7 +153,11 @@ static inline int zynq_init_spi_flashes(uint32_t bas=
e_addr, qemu_irq irq,
>
>          for (j =3D 0; j < num_ss; ++j) {
>              DriveInfo *dinfo =3D drive_get(IF_MTD, 0, unit++);
> -            flash_dev =3D qdev_new("n25q128");
> +
> +            if (!flash_type || !flash_type[0]) {
> +                flash_type =3D "n25q128";
> +            }

This seems a bit unnecessary -- we always pass in
zmc->qspi_flash_type at all the callsites, and that should
never be NULL or an empty string, because we've already done
the "what should the default type be?" handling in
zynq_machine_class_init().

If we do get NULL or an empty string here, that's a QEMU bug
in either this class or its subclasses, which will be fairly
quickly detected when we pass the bogus value to qdev_new().
I would just drop this if().

> +struct ZynqMachineClass {
> +    MachineClass parent_class;
> +    const char *qspi_flash_type;
> +};

Because we've now given this class its own class struct,
we need to add to the zynq_machine_type TypeInfo:

   .class_size =3D sizeof(ZynqMachineClass),

Otherwise the QOM machinery won't allocate enough space for it.

thanks
-- PMM

