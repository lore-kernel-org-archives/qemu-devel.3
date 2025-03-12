Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF9AC28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 11:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsK1X-0002LU-TF; Wed, 12 Mar 2025 07:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsK1W-0002JP-DN
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 07:13:18 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsK1U-0007dq-Dl
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 07:13:18 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so5889279276.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741777992; x=1742382792; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=216R3qeW4b5D9kzHf0a2eU4eLYUhDR+YtQz4Cr5GQKg=;
 b=aZljJoXJrAlU4gOHcrBmBGWbPdll4Vruah4brHiwgm5RTDeXL9HHQhmO6iPoP4/pwI
 dV71r6sS3v7+LTgxNtlMta8qcZHohp5F/AtP6yzvKdpnv0lcj60PKXQZFGjc+TBmtwG6
 lE4G48T28Hv1VI/KNHEdBWtHI1ImKMGJ5CZLEUoLZvFsdCuxNKHueHBMRQCBvbYOmlhJ
 l+f9y4FwUvLzyn8CdrmZHEBTT0d8JjB6oMAJ4GEfnFOryrA3pb13hIel5dXH+VhXzqB4
 A3S3l5zF8RVTMfjIMt+pAklZSC+f59+zGJ81VTJ55L+Y17cH59JhTEz/aJMVN4Mf+UPI
 AQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741777992; x=1742382792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=216R3qeW4b5D9kzHf0a2eU4eLYUhDR+YtQz4Cr5GQKg=;
 b=utEi9EIzB78zy5aXQ0V8AUjf2fq3cO9qecjvtVRA8tPAsmOiX7k16tpjhGF5XwUfjp
 TlID6oxtp3VliTfLwqO4UsvVbLvKEiwP61iVuLyxYdAzQm416I/YAotlphJEPwi8K91h
 D+x3MS7BUAayLig7OZQdDipWjlJ2K/Kv0IFHPpdJPpKrUDLHMipPcItwfEEzWv1Vwiyw
 kBtDeV8BZe5i6Ld6+FQRZLQtpzgqiX6/qAKExSlWVn0Ps4CtNlmkcerTDih6Gzt7NuTE
 oD6daNueHFT3b1/62hKsPTtwagSIpel5ZmWcqaAS3uzUeaPd+o1beCFpm2l/qKh28NNI
 mQCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZgkOGirbilhfz0gRoxkqDKMUc/RY/fAvohT8vSTVRm19k9eyHYIhAIZaSqTWdRRIz9u6YwmOs7Exx@nongnu.org
X-Gm-Message-State: AOJu0YxFeEac44dK0C4/dLuBFglUwWiL/oZATFVCsqI36fykaAEYAkgp
 wP/pQ6nNeaVQ3AvEzoZKp6cwcxnfibvyF0C2RwO57WXVpYDwyO4EFTHGnIfYT0j3qGZOoK08bGo
 62V1zeCJW3QJK+nAJH1GXnhDSCAn3hSdCekchlQ==
X-Gm-Gg: ASbGncu19LQFPGlXUP7ojfKluSfNAZ/bNRUg5O90pNwQ9Q4ZDD+wnuk5E5q9vYfaA1r
 eDbitYXq2EZWicYcr5dZR5laxiPbOYHkhtI6aNHOo5c858nCD7WrkmN45afxC72fnKhKCaP/R2d
 ywihAsQA7ML0WUerQe3wn6Dbijc1k=
X-Google-Smtp-Source: AGHT+IHrwuNbom//YqCUKIPRyMu1gpkUWwkNdAKOldTlWp2ciLUpGl4v1RYbHTi73WwFo2oI8/H82SHfgVjA1Lgyt50=
X-Received: by 2002:a05:6902:1886:b0:e5d:b88a:5536 with SMTP id
 3f1490d57ef6-e635c1f9fb3mr27291694276.44.1741777992600; Wed, 12 Mar 2025
 04:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
 <20250225180510.1318207-32-peter.maydell@linaro.org>
 <1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3@redhat.com>
 <CAFEAcA-JgjX2U3wQ47X5JQ2SU1yMpx=0rWkctbj40w0Xjufpmg@mail.gmail.com>
 <e7640bea-5bb7-4f4b-8614-ed8d521dd7a5@linaro.org>
 <0261bcf8-d01d-4f63-9edf-f572519dd8af@kaod.org>
In-Reply-To: <0261bcf8-d01d-4f63-9edf-f572519dd8af@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 11:13:01 +0000
X-Gm-Features: AQ5f1JoO_rOV7c1xonOdd5c8GntkXdCDb67tSaEWaZ5_LrYa2R_IcvDO9Tne5rA
Message-ID: <CAFEAcA9YvYCmbzJmzV60McWTBNWt-mgkpnOpBY1_VE6_S+9W=g@mail.gmail.com>
Subject: Re: [PULL 31/43] hw/arm: Add i.MX 8M Plus EVK board
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Wed, 12 Mar 2025 at 10:44, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 3/12/25 11:27, Philippe Mathieu-Daud=C3=A9 wrote:
> > + C=C3=A9dric for Aspeed
> >
> > On 12/3/25 11:20, Peter Maydell wrote:
> >> The bug is that this is directly inheriting from TYPE_DEVICE,
> >> not from TYPE_SYSBUS_DEVICE. Doing the former is almost always
> >> wrong, because it means the device is never reset.
> >>
> >> (It looks like we do this wrong for other fsl SoCs too,
> >> but they're marked user_creatable =3D false.)
> >
> > IIRC it is deliberately that way for the Aspeed SoCs, because
> > otherwise there were issue when building the multi-SoC fby35 machines

Multi-SoC shouldn't have a problem with sysbus devices existing.
They just mean that you can't use the convenient sysbus_mmio_map()
function but have to be more careful with managing MemoryRegions
in the different SoCs and using sysbus_mmio_get_region() to get
a sysbus device's MMIO regions so you can manually map them to
the right places.

> AspeedSoCState was introduced long ago (2016) and the fby35 is "recent",
> from 2022. I am not sure that's the reason.
>
> Regarding the reset, the SoC functions are sysbus devices and all have
> a reset. The SoC doesn't have any. Maybe that's why we are not seeing
> issues.

Yeah, it works out in this case. But I think it is in general
a bad idea to add new direct-inheritors from TYPE_DEVICE.
If anybody needs to add a reset method to the SoC container
object in future then they'll be confused about why it doesn't
work, for instance.

I think that in general people expect that TYPE_DEVICE is
"devices are like this" and TYPE_SYSBUS_DEVICE is "if you
also need the sysbus-specifics, most notably providing MMIO
regions for registers". That's a totally reasonable expectation
but unfortunately it's wrong, because a few key parts of
"this is an internal device that we don't need users to create"
are only in TYPE_SYSBUS_DEVICE.

thanks
-- PMM

