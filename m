Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8DEC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTWk-0000Xs-A7; Thu, 17 Jul 2025 14:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucQpW-0004yF-HP
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:47:35 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucQpQ-0007rA-2R
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:47:28 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8d2c331bb5so619755276.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752767242; x=1753372042; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTf4QJyETBDFeIIbUs0tvAi/F1lfywz0zSllEIAn9/Q=;
 b=Nresjfts56Xp4roEoAmlk6bea55Kk3IiIZmznClkTr/ZHUXa2MrCXXpv9cet69Nqlm
 tu4iHeDZiTFbFxvXTXcGfTHgq6yoGmmhCOkwtVw1y/MFc2usv9xU9D0+tSfAzioEoqRj
 h1ZLnWgibMJQ2dmcThil4/Vp6cdKZpp15VD1CampizqA/MMpgasbJFZRSLEwvTVaO+Xo
 DruB5aviFsQYNXZh3o9cd+vVnj21Zo1dFLcaaTYG46tZaO9SXNQ0bhI+i87/KAWC+q5e
 xbA9id3yLscl49z17YneVsSLBNGuxDGsWHoRuiV1uvZ+3cl/Vs7cd0I7iy4+QFBBsytI
 2qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752767242; x=1753372042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTf4QJyETBDFeIIbUs0tvAi/F1lfywz0zSllEIAn9/Q=;
 b=hNg2S7+RcyYLLIgNBT2KaDnxIKG4+aUiZbhKS5pJHMve7BBRmOt6EYfKPWQjUmSYUM
 qL/QqbPXBYwYqT347+Z7o27UXPzPUDeHqLJlj0ZIdL2W6BXLsCBSf3PSurrt0XV2j7an
 YQmhiCc2duXwRNW/pfd2kxTqmb1IKwWtvZP4JLYZw9A/hCdE/pMxWD+s4tOG3CmHcnd+
 HKZatTdC5K/UDveVRxQfa6IQiLGNfYkciJQ7syeCHzuPtCs2fGanZUtgVARNx54mqL59
 fK7n+s+/74fAQfWN7lvf2LdTsOAp599XARYYcJhFzbNLncwVz6JZFExRqbaok3bzvcHH
 Fo7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD8gNw23wpTkUCiE+i2Jw/V0StngAU44WmEv0T6pN4fHTpLEIj+17Ixp4kpsjaXeMkwRfceSYbVTUP@nongnu.org
X-Gm-Message-State: AOJu0Ywo/biDSHWXprOUt46ENA2fmsMnsdL1DkcsLNJ8w4j3fjcL/cJ+
 xivTziHaX9BBoKxF+k7z+zTIDm/5izPtwTbYQLebuqQy2pmhNL4J9mQPK2S3dYCOroL9YnfZs4a
 HAC09oHi6EgBL/E5+gqi9AmC41+6UWg4cTKZRRaX1tYMsIX3emyMz
X-Gm-Gg: ASbGncvZ+fuslUcMLdqDg2QxzHtZcSjRp8r2aQQYVNa8Lrx0YLXZozGrA3hWWzTAfFS
 anayy2LqXMN5KAZIqwIDFs7drqly1Iy9xz3QyaDjysWjFZLP/LP6/yqW50E+V+O4xqgQ69vIup9
 dKfcu380G9vpUUnGF3sE38QCpgrkiZQp64rdasb5FFBzFDtoxf/x9z/RXPVzXUetNa8VT/4bL7i
 RhZGIDD
X-Google-Smtp-Source: AGHT+IECycG6jnttUfo8RPoH2Xla09m6DbjzFbnqRbbLP8Np8mGtYtDxXh4IRhe8lPsd6aOfmAd+qbSyBV7B1Hnj05Q=
X-Received: by 2002:a05:690c:6908:b0:703:b47a:7312 with SMTP id
 00721157ae682-7184f7f653cmr49530407b3.15.1752767242633; Thu, 17 Jul 2025
 08:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250714110406.117772-1-pbonzini@redhat.com>
 <20250714110406.117772-18-pbonzini@redhat.com>
 <aHeNnCnN2RGmbxWm@redhat.com>
 <CAGxU2F5VvrgCTzi1MXWqBA+G0hgi0xLf0mm7+v5==sDAVUKJpA@mail.gmail.com>
 <aHj7sd7l8DUbhM65@redhat.com>
In-Reply-To: <aHj7sd7l8DUbhM65@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 16:47:10 +0100
X-Gm-Features: Ac12FXwFDPV7i-gP4VR4uX0StcLqkF1tS8T6o60mKBs5N4hb245p6PuH9CmxUsA
Message-ID: <CAFEAcA_34dcrOmX13TPumQ18-V5jqra+2M75Cj_jFL8yKx=79w@mail.gmail.com>
Subject: Re: [PULL 17/77] meson: Add optional dependency on IGVM library
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 17 Jul 2025 at 16:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jul 17, 2025 at 03:30:06PM +0200, Stefano Garzarella wrote:
> > On Wed, 16 Jul 2025 at 13:31, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > We really need to get something into 'make check' that runs the
> > > generator and compares its output to 'meson-buildoptions.sh' as
> > > we have hit this problem over & over again.
> >
> > Do we already have something similar for other generated files to be
> > inspired by?
>
> Not that I'm aware of.

In particular, meson-buildoptions.sh is an oddball, because the
most common patterns we have are:
 (1) the generated file is not committed to version control
 (2) the generated file is committed, but doing an update
     requires an explicit manual action by somebody (examples
     include all the guest BIOS files, and the results of
     the update-linux-header.sh script)

The reason we keep hitting issues with meson-buildoptions.sh
is that it is both committed to version control *and* we
have meson build runes that will regenerate it automatically
when the input files are changed, which I think is a rare
combination.

thanks
-- PMM

