Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D31D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNuYP-0008R4-6w; Tue, 25 Nov 2025 10:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNuXW-00083H-L5
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:01:13 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNuXR-0000kR-RZ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:01:07 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-657a6028fbbso1126515eaf.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764082862; x=1764687662; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BFHaW2rScBDNKA/t+Sa8g7iZwgfCdGlUKLmQB90npI=;
 b=axdgBWucCdiMu1z9c6OCOXQpvHAt7zeJkHf2rfV1q0bJv8Fn92Ewniy4MxG0C79ydj
 wxYFu8kIFfLkD8t/7yxaUFf7Ox/b43LhvriJVBczQxfsgxU+sNOnPyalKP3dPxbU4Pw5
 vSOu/qfX5humG12kjDsOqQ2mtb2wzTanMKahf6yRNBOZPLRw+O5C7jfOKLLPadSYDc1P
 sUbnTzNd3iLP6xeQr8AUoHeYI//UGHNmltCFh2W4326gH+7BKILofjw+RfczhF0kjFx1
 Xr/Ci9mOs+F6P/wXlZVG/E/xBETzaI5p67TsVfMdfsvl+DS5gIhGDTJDreNpu7MZVAMt
 +wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764082862; x=1764687662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/BFHaW2rScBDNKA/t+Sa8g7iZwgfCdGlUKLmQB90npI=;
 b=kOl95lzPixbTXDBUI6aLmhI3okVmkTtBamjjsPZ+ldVGMrdwkMxz1g+w2HniHazbU0
 ph3MRD/0IVKcSTD+elvM7yKiYt/HS2v1V1Dgrb7CRTLKFjSFHl9Ht6exhJs+HbvO0Msn
 no6ir8HThiubiUXIqtLkpOfgFTxBgiLcco1lxnufQfOZR6ilMYCwgl8TUSP8c/Q9sMtf
 tLG0M9ef4sgDtwCNK485FNUnp2iv4QvhCZDXgQfUIiE+nGTnrLwHsjIFLhNBZwvewmY7
 XYifgs1LsizC5MT1qVCzB65Cueko4FJkvI6JSpphuRtuP8tq24OwL2rMULkaQh3+rrHu
 MKtA==
X-Gm-Message-State: AOJu0Yygz2BN0wlB5YBBDeIwCl6clP7Vjk/SRyf2XeMutRbrEbz8eZTa
 xky9N2lkrQQPnPDkTNtFUTj/X25CqaRH+8SCg0cK6rmVxZclhWqLIFKLM8Zntn+6RirkgbK+niV
 9tCoVNcxQ2OUW/C0HoymE8wGJ6S32FDK6+a9dCAhuyw==
X-Gm-Gg: ASbGnctEg25jp04Xqw4L25wgmkudvfphlh3ePsgsUdOJmI9/75NUhZfbuYO33dsRO+j
 DhDADa3SSCGhgJElGN1TVr/3tdsjHNZ7IFqFdem2KMOLJUfPK0Kf0QUIt5Kx1UtYMJjTwYTjNxh
 FfTHi5iDWX5FtMoH0Py/FFfPvU6NApwl8xz5I2p6qyLyivoEb4jgI/AUZbzEqn9zpFei+X2Ccmn
 S2FItr6NgQm5D5CwSXXYhCKHj7EgXhYWZ9CE++BtMGq/wUFL/ITO+Rgsg==
X-Google-Smtp-Source: AGHT+IHjgZttTFVs300Pc3EkNQ+lEBRoJRp5ps+U0bR/UXHWA5nzy8rwrFCqrokSbDLTCc8ydl+78WSaAq7a22o41rU=
X-Received: by 2002:a05:6808:3385:b0:44f:6a32:5364 with SMTP id
 5614622812f47-4514e66354cmr1357673b6e.24.1764082860719; Tue, 25 Nov 2025
 07:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20251125143141.216056-1-peter.maydell@linaro.org>
 <20251125143141.216056-3-peter.maydell@linaro.org>
 <87a50a6u02.fsf@draig.linaro.org>
In-Reply-To: <87a50a6u02.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Nov 2025 15:00:49 +0000
X-Gm-Features: AWmQ_bnQyVecPcV3_jsN9pzOQNBsP0StajBVvZFPZpvkaGpskSfKdoTKAmU6ndM
Message-ID: <CAFEAcA_uTWuRXyEvb4VxPgR+Hm+F5TzygWpRAopwE1Z0=KkN5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs/system/generic-loader: Don't mention QemuOpts
 implementation detail
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2d.google.com
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

On Tue, 25 Nov 2025 at 14:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > @@ -85,6 +84,10 @@ shown below:
> >    The memory address where the file should be loaded. This is required
> >    for raw images and ignored for non-raw files.
> >
> > +  Note that as usual with QEMU numeric option values, the default is t=
o
> > +  treat the argument as decimal.  To specify a value in hex, prefix it
> > +  with '0x'.
> > +
> >  ``<cpu-num>``
> >    This specifies the CPU that should be used. This is an
> >    optional argument with two effects:
> > @@ -104,10 +107,6 @@ shown below:
> >    This can be used to load supported executable formats as if they
> >    were raw.
> >
> > -All values are parsed using the standard QemuOpts parsing. This allows=
 the user
> > -to specify any values in any format supported. By default the values
> > -will be parsed as decimal. To use hex values the user should prefix th=
e number
> > -with a '0x'.
> >
> >  An example of loading an ELF file which CPU0 will boot is shown below:=
:
>
> This isn't wrong but I wonder if there is a way to avoid so much
> repetition? Is there a way to have common footnotes we could apply
> anywhere we are discussing QEMU's numeric parsing?

Mmm, I wasn't thrilled by the repetition, but at least this
way the info is in the user's face where they'll see it
when they're looking at how to set the address, rather than
tucked away at the bottom or behind a footnote link where
they might not read it.

In a lot of cases it's not something we need to mention at
all -- nobody expects the argument to "-smp" to be hex,
for instance :-)

-- PMM

