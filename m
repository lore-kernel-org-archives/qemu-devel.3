Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC216EDF156
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 11:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqrl1-0005oY-4y; Fri, 13 Feb 2026 06:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqrkz-0005o2-38
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 06:54:45 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqrkx-0007Z5-Jp
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 06:54:44 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-649db2b6cdcso769674d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 03:54:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770983681; cv=none;
 d=google.com; s=arc-20240605;
 b=b8vTBDtLJJQjElME3JO/JS8/5zeTvaRK3WP00Q3DwX7jDosqfX1yj0UjqF+Ij+lDco
 TiaQ++4vLuRgvJQsa4lrQk8QRwtm8GgNLTeADwdoZRBsiV1v2gjV9p2UY9TE5NdysUwi
 V3vR6taYdNCao5f0/ZCqD0BurLkxbFdKJEYbouogpmmwY8KE95DxKbpoFdTus3iBkUz0
 JZKzl8+OJHczzBPjA2T5evgfDUc/quDX2OiyZzeRC+yGJfxV80k00K2LUYO8cDyaET9u
 28jVpw5dUtyO1wW1Im0dZBr28g+tWIc5UzEudyEJclmypZr/HjR2GtNSiOpxMvbNyZUD
 vIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gOXNYsqO2Y3rnMF4Dg3G2HaBHckOmO7Tk8MEofhaN4c=;
 fh=/rsxyTDSpt866qNqcM0/ZWSGoHjGqpg6EMpip/ZO9z8=;
 b=GW3GCoJUeOoE9bcd8Un1lG51+QCBiQWunpTroPyuSUdSanJ/y6r4Ey4kyvkUX4EbV9
 nk6njytZfk6jhbsvPjOuUndGrTJO0miUFZBNQkh9iSA6sObn/vF6jWV7+VILjaa5agAd
 Cfg71VkdGb2HX6XQq88UMoO90UU3s7wpHtQC480PPOH396eIHEDiuRt6arChi+fLXaUd
 odqBUj/1PtPXFmsuyRCatqZGv9fngixBv/6iexDqMZNkJWN5H05GoK7seeoVj9gTVoUD
 sVcuxjQaQR/K7r7Z+BcHmWwE4nO3utT2ws0U3m0kndvE/mzJj2oyW2hOKISqf9x5Gd7q
 nvXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770983681; x=1771588481; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOXNYsqO2Y3rnMF4Dg3G2HaBHckOmO7Tk8MEofhaN4c=;
 b=Z7itDmCE8VjXyWQIoeTwkKMEV273QFM3t9/KVn0NKTfu4qYInYLxdyHezMEObSn663
 TscRFN4Hs5UGpo2sFtcz9j+sMNw8sx4vDrwgCR8axgH795UkAfBbnjo/2J924B+cnLNn
 cGj5FjGP3Ql4D++lj8dXLCoc3TzAVeKKimyVaLdmbsRFtWb0XQ7XQtthGPTvPmdiVg4k
 fHu70UzYFmZ0arPKWV0LP2EkSXLYeIfbu5mVDXgbuOe4XAJEzksd1H/zOIUaIlzUgP7e
 HErdl7QaqZOvlPpzNM7VWUELwIdLLC9LKNRhXvMqVvpuS10QZwdLZawvGVbpKcgDpWAo
 /Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770983681; x=1771588481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gOXNYsqO2Y3rnMF4Dg3G2HaBHckOmO7Tk8MEofhaN4c=;
 b=Qdlndy5Wm7UQtwyWQzU3qSQcGH8rXX0TrjB6k8CrRyIudzJ50DAEHIA/4gro0BqCQQ
 lfVD4R4zb7LXAnI8uMWeflpfv6eXofmP41oZsuz60XPbHrdCiywCHivNwVkUnt8dn/Gg
 n05MLkEeUf+c34wvy5jpsPbQGC+nrDUfCzcJ20cTRqapYeCW1m/x0TqQ5Ze12gogX4xV
 4Cv8qWyybzNYeqsWuPqIWaskRsVvLqDYBp//3Va52KrcyBLRzY4DKomFNIg4zk+DKsnR
 i/1pAqn4/1W8sfSdumVUlvGUe4c3trA85BXlrLeD6U8zUPCJ9VvNAW3HPQWTTO2rgAr5
 jC+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBu/yrDupLsbSzyqVeauXOVaxAsQbDuhcFRjV4dTzjS8nYxSbxoLEjgllg908ugOTCDW2VfetqN3mW@nongnu.org
X-Gm-Message-State: AOJu0YwRoI+jVjeg0/LPr6dIeWVHW3tKdZ6W9lTro8n3S35yO4+LG9Fb
 fEqoWu//JyLtlL0XYZtYB+9RxbDatCg1uSjYKhAr8K4BhfF16NqbBURdYUs9bbjOYlj4giq5A6D
 rHehzHFBIKAM3paYDRqjoCdAFw84SxJ9PGN9ELrA+Gw==
X-Gm-Gg: AZuq6aLFLnDuQw8iIv7SQGleIVjUMQZokzkykfcFjBVNXdTyju5H/F5V8aReh4cQPgW
 XTerg/W9O4vIOObwk1/ccKJpTe3uP9b6EhUgbHoWoHOi35HgOz3V83m0eVY/Y3Iz4SMjDXGwc5u
 iGr0hSTb0Zyey4FDselnWKgCcD5PGyceO3rC9agJmZJGVq7V6Fl9a1ckcMkK6RaJ6pvtZLBBvdM
 OwAZtxLX25/chU6FxPURkBSW4RI4abKX0jHngPcNpmih3uzRTeFkWMNkIPHDhB80gQZIcqXzXjH
 S57Hndi2BIRVLhfLfhkPgJtKpJtVKrboAa1smIIsIY2Zk/dCS5/rRG1P7MSpsAaWnUJCt9o+7EK
 Pnw==
X-Received: by 2002:a53:dfcb:0:b0:649:b943:2cc6 with SMTP id
 956f58d0204a3-64c19b30f51mr928097d50.52.1770983681344; Fri, 13 Feb 2026
 03:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20260213102109.107491-1-pbonzini@redhat.com>
 <20260213102109.107491-2-pbonzini@redhat.com>
 <aY8GLhvyOLZgv7MF@redhat.com>
 <CAFEAcA_SWSO3cufc3MDv600Qc4nf7pipEhCyt8JLSG2rqQa3fA@mail.gmail.com>
 <aY8QdCBQFQAwMD04@redhat.com>
In-Reply-To: <aY8QdCBQFQAwMD04@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 11:54:29 +0000
X-Gm-Features: AZwV_QgtudkG9S-D-VZP8kjLmicxRBt8Y_GfAohHSJztNgSqvdrayRVcyv4lbNg
Message-ID: <CAFEAcA_TTrpDJD6J=w2SsbD11Ms8ZRt-jHVuZwHydsb84nVutA@mail.gmail.com>
Subject: Re: [PULL v2 29/41] i386/cpu: Fix incorrect initializer in Diamond
 Rapids definition
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Aidan Khoury <aidan@aktech.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 13 Feb 2026 at 11:52, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Feb 13, 2026 at 11:48:29AM +0000, Peter Maydell wrote:
> > On Fri, 13 Feb 2026 at 11:09, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > On Fri, Feb 13, 2026 at 11:21:09AM +0100, Paolo Bonzini wrote:
> > > > From: Aidan Khoury <aidan@aktech.ai>
> > > >
> > > > The new Diamond Rapids x86 cpu model definition that was added in 7=
a6dd8bde1
> > > > has an unexpected comma in the `.features[FEAT_VMX_EXIT_CTLS]` subo=
bject
> > > > initializer, causing the prior initialization to be overridden.  Fo=
r this
> > > > reason `VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPA=
CE_SIZE`
> > > > is not included.
> > > >
> > > > Fix this by replacing the comma with the missing bitwise OR to prop=
erly
> > > > combine all the flags into a single bitmask value.
> > > >
> > > > Fixes: 7a6dd8bde159 ("i386/cpu: Add CPU model for Diamond Rapids")
> > > > Signed-off-by: Aidan Khoury <aidan@aktech.ai>
> > >
> > > That's missing your S-o-B
> >
> >
> > I have this pullreq tested and ready to apply -- do you think this
> > is important enough to respin?
>
> I'm not that fussed if it is just 1 out of the 41 patches, but I've
> not received the other patches in this pull so haven't checked.

Looks like it was just this one patch.

-- PMM

