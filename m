Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E76CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 20:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v19Bi-0001ib-4N; Tue, 23 Sep 2025 16:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v19Bg-0001iI-GD
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:00:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v19Be-0004xr-Vp
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:00:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-62fc28843ecso6146831a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758657629; x=1759262429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3G3c0nkQKew2ntKNWNXsbgvqlpxLiAsf/W1nzKD3Qg=;
 b=biXzOXzS1yIkRs7ClnoU7DTqnymis2yao7hN68zrrnhGAjuXg0bDhCfQS2S29lsJC+
 /Qq8ez6jy5xr2sW7KFqn5HiVTwRPXpd6jI0/b13xY/gOCACI5evmN2X4frA+wfvqYyiR
 srzI4LETI+G72ulq856Wv5lRX1/jTT8B5x/J3qEy6/r+rbXDKrIGYi+Q4qZkIyxBmC/b
 PD0u6XaznmkTj+aDg2y81RZmMZOT+s+qJNcb0YTjK4X6xRhGUpsck9e54cEr96wSho8o
 CQh/1oQgoIbtUQq20U5E46SFKLEJnL6xuRx1QdbCkaO7/yVr65toJ1lyguTJMfZpJKJj
 LUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758657629; x=1759262429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3G3c0nkQKew2ntKNWNXsbgvqlpxLiAsf/W1nzKD3Qg=;
 b=Xa2DtbLTOtf71GkOnTxq96ZeNzEVmnj4XvS0kLmN7aJjecVLTpoxMu1ZjHmZzV2NbP
 0qY2E4sg6T2uMT0+3RHJLZlZ3iC7UkzO97t7HPiIdJKuTDxlvZ2uMT98Jox5VkL6Iyl5
 yUMPOL4Ec/RlKIl3xBIQWBPHBkCqyMgdE1Mr869CN9zDdmvA3MiklGPdl41k64EjeVPk
 6ghnVvsBGcsaSqPXNSPipUY36nrQlwFMY65gLU7iR8gbbQiMP+ByRwkbbplOnN9xEDE+
 ajallS9LJW1bC9BrVSDlYuS1bkWcVCXyPSaYIlbmenpvpaOHTDmI9FWrhjnTfAqSExVI
 Bckg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3PVk3TOJSVqwqu4sq3AvlVmEc5xHHZURZM5NyCRkDQZjQt5y73jjhTucXXe0fWGnE8w85VC9LbbSh@nongnu.org
X-Gm-Message-State: AOJu0YwL0bBte5e1T/xEFWuGQ758fQ8u0DkOxbB0dPrecYl3Cx+j+duR
 wJrt+Cstp9Ui/Y/GNLjLCypA3UXRuTj/KqKnXYxdLMYM2QNJQ1Lxtac9ciOk53QmxkMUC4qIxzS
 vy7rgr0AAvlzTxgnghBrRVOv/Dt9j0zw=
X-Gm-Gg: ASbGnctgLjygpqGY1mbZ+D1E4wK0+14mJvEseI0WLpPMDRT+aO4kbkfMoLYP/4rLbes
 Mf328myWeiFWHbsvGIlpeLKwW+6pQ2QYCZpdHGqrF1gzPr3oe/tnRm58/OHb6k9hy5ICcxT3Pr/
 pdeTH45THH5RiucXFywb/M/ls9e0TrcIO8NtouDJ2vLbstC3xbBLd2Wx5fj6SgGQcu9fchDD8j2
 1Euig==
X-Google-Smtp-Source: AGHT+IEcL7c1IEeRuS5h0kyHLtQYmSQ1NYbsID6OQOAiOzBd6mrQwIGDCe612IbSQxEufbPO8HzLhgGvk/C9AL18YzA=
X-Received: by 2002:a05:6402:24d5:b0:634:4e56:ba02 with SMTP id
 4fb4d7f45d1cf-634677ed06dmr3042412a12.23.1758657628466; Tue, 23 Sep 2025
 13:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-3-pbonzini@redhat.com>
 <20250923175826.GB509965@fedora>
 <3232b3d4-a298-42d0-9756-0556f9edc241@redhat.com>
In-Reply-To: <3232b3d4-a298-42d0-9756-0556f9edc241@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 23 Sep 2025 16:00:15 -0400
X-Gm-Features: AS18NWCrFyNJBfj53i4ODrD8P2nxLSoaXzAsqjGeWIUXVJt00D-wHzuHqy_WZJo
Message-ID: <CAJSP0QVmYUCvz_LAnMEXFEOiYvTS6E-YmCeVTpF0S52H3-=bFQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs/code-provenance: make the exception process more
 prominent
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

On Tue, Sep 23, 2025 at 3:20=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 9/23/25 19:58, Stefan Hajnoczi wrote:
> >> +The QEMU project welcomes discussion on any exceptions to this policy=
,
> >> +or more general revisions. This can be done by contacting the qemu-de=
vel
> >> +mailing list with details of a proposed tool, model, usage scenario, =
etc.
> >> +that is beneficial to QEMU, while still mitigating the legal risks to=
 the
> >> +project.  After discussion, any exception will be listed below.
> >
> > "Legal risks to the project" is all-encompassing and vague. People may
> > not know how to start addressing the topic and might therefore not
> > attempt to request an exception.
> >
> > I suggest replacing "legal risks to the project" with something more
> > concrete like "issues around license and copyright status required to
> > satisfy the Developer Certificate of Origin (DCO) requirements".
>
> It's already a long sentence.  Would "while still mitigating issues aroun=
d
> compliance with the DCO" be enough?

Yes.

Thanks,
Stefan

