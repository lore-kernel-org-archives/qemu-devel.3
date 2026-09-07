Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7971EC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Ued-0008Nu-IX; Mon, 07 Sep 2026 04:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x3Ueb-0008N3-H8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 04:24:37 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x3UeZ-0007ru-83
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 04:24:37 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c259e5c22ffso153482966b.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 01:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788769473; cv=none;
 d=google.com; s=arc-20260327;
 b=PFMRswSlmfLc5osbdoQ+DW1LBBX4fwgMoA+Bk0nl1/Wu8GMQ4MWGmm0p7TpuqNy35L
 0i/T4bQPgoQPXUzef30g7QLTyoue1hsdnMjnesHMahHjafHqdL2gYRIGjI7KhRJEtJ9m
 a7OCpudYNYbEJT6y3YHWJzWbTIml2tuqphjUObCC1VWbI2Hz8gJBu6DdU5wcETj2AgoQ
 4FlzL0Gcek8gKW9kBs/pK3ET0DQZJCkO77whZto7tIqbI/5TtNZ3julxfd1kfTGj5S4n
 qW4h+qldKdSD7KTQogIUN5P6sbGP277ZgekVoivgJov2cA0Y4c68vm8OpsnHgFhxfniz
 ycDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qRjZJCM9zwLsFrdT8yXK7VMKS4/pDOSHT8Zo0pIJN5U=;
 fh=6uVfJwzmfrZLdXBSV5iI6x6Nc2wlt6gd+Fo5tHMz9Uo=;
 b=kmAjx/KycZodO1MfgnWpPsO8Ogv5RyJydwMzx7oykmr1y0yIlo9kxHHFmuWsA9kpoF
 /R34FU0C2cV4KeyrriMlDgaudJ3yk3Oub3BCPsro/0nrDhrQeYafFLG4twnO5S4oeuyh
 QRzqh23Z3up0EEhFwi79DHnT8c9cbOjQd8XdvsOkpdRpLf536DYKbYyWXUv0zRO04ZBA
 xy+2h60jaW7W+xfxCdhRb7MKJlCloOdyLfFqJaDrocERLQC8hFFwzByjPZgIwuU/T0cf
 gaxNzrMfj7OoluRDXQOpG5KupkaiNelmve+whKO1YY3Wov6YYWw7drH+qcsVYjs7Qfjx
 tSWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1788769473; x=1789374273; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qRjZJCM9zwLsFrdT8yXK7VMKS4/pDOSHT8Zo0pIJN5U=;
 b=SZBbGZ1U5O1Y+sAYrotjsUTrxQdE/QigXbEvGW6i7aXoOj5HyXxqestIe1nOV1Hd+X
 rGbbk+0nlxwgAwDblBg1cAvfrJBh1g7ZOUWkzyawCmAaCaN+H6aSEqhFoo4GlQrn7AV0
 6fnWuZFKow/BZbxjSE0qXDn3cSwDgSvjhOjdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788769473; x=1789374273;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qRjZJCM9zwLsFrdT8yXK7VMKS4/pDOSHT8Zo0pIJN5U=;
 b=VGI7KzPIV/x2Lej06wF8EYHmMIRiCkiq221yyth/RfN12FqaAyb4R7iKgsyGXNh9UR
 MSESQozyTWvY1iEwG1xGckGcS3VStcQ0TCs9nnKdPPcL+rlvQDiNaLeA/2oAdjSPGEVf
 4wO2v5/zx3sD3QhC0mqljvFJ7HTpTXTIwqJSVOjhLNyvdeMHu73LByVo7+z90nKJAZF5
 wBxvZjGxPH4jKq+uqpES+Y9smWebOlulOf7GYabg2+ga+xgKU8bt/7aCRD/ELAGn7061
 4ing1GcbhVXxHD15BhZjFIzvKyvc8GPaxvgPmz0dt4b0akVQ2vmFK3RCwvv8hkwULrs7
 JGBA==
X-Gm-Message-State: AFuF++lv42vzmv7aaYIbOEYu10d83LM5sO26k5ideBpXI6p92g0Pw8kk
 RffMlwoaBUmesGYb7YfiCEb8HhpVWOK8ODHSNEy/chCc+8awujBDk+3EYn5xYO8rAR3HgaYKllO
 Z/QOMYgvuJwudvgUB814VS/Dhg0XuzesmNZwcbnxQqA==
X-Gm-Gg: AYBFou0r9aL7ev+bV7ZGEkC+qDcyb+HIYXw03Yn1IR+CjqEFAObsEeoN4+TQ+r8OGWN
 QjTFqbahK3SvnPvgUJPPYZLITOZ1xUaXRccICq8a6FrhbkZoI/Wq2DNGokvm3WhQgtigh4ISCn8
 zRFHNRVROAMzOX3z+5zXwGw7BoG+8sb2rK/zMCM8e8TDaDvuhf6/hsQDP1ryVcBzzzBIiDAXAzf
 uDd2AaOxvQVroweX5G5/SU+NYBkpgS5KgB51W7FrdDw5zwlag9lVSywaqitLMv3haiyyZzcu65U
 KnmACREVqkak+63LgBrG5lbYDXoMSX1cVx+oQ/HpERywZ9LY1vY8bAuPsJiTJUjO7mCVjLKVBew
 =
X-Received: by 2002:a17:907:1c9f:b0:c26:1691:b374 with SMTP id
 a640c23a62f3a-c261691ba04mr798550266b.45.1788769472157; Mon, 07 Sep 2026
 01:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260803083046.110121-1-alexander@mihalicyn.com>
 <anCasYYUJBhDqOKS@AALNPWKJENSEN.aal.scsc.local>
 <CAJqdLroHb7mwMx57zEpfhPcXsHwL0jCeEawCL1_f_ZYOytofRQ@mail.gmail.com>
 <ap5qLvPWxSXcJv2Y@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <ap5qLvPWxSXcJv2Y@AALNPWKJENSEN.aal.scsc.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Sep 2026 10:24:19 +0200
X-Gm-Features: AcwNN1UiyYyxht08qMrSil8MFUKTZu1JS-hK8nA7uaQHOsK5lTnoyKdAV_s23r8
Message-ID: <CAJqdLroB1-GTEGRuiiPVJ3xQiMhQ4cmgDjvxvdhWOhqB823_qQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] hw/nvme: support online resize
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org, 
 Jesper Devantier <foss@defmacro.it>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x633.google.com
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

Am Mo., 7. Sept. 2026 um 09:39 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
>
> On Aug 31 09:04, Alexander Mikhalitsyn wrote:
> > Am Mo., 3. Aug. 2026 um 15:42 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
> > >
> > > On Aug  3 10:30, Alexander Mikhalitsyn wrote:
> > > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > >
> > > > Dear friends,
> > > >
> > > > This patchset is aimed to support online resize for NVMe emulated
> > > > device. My approach is simple - I just implement (BlockDevOps *)->resize_cb()
> > > > callback and ensure that AER notification is fired to all controllers using
> > > > a namespace that is being resized.
> > > >
> > > > Testing.
> > > >
> > > > I manually validated this with Debian 13 VM (a resized disk was a root disk) and
> > > > Windows Server 2022 (a resized disk was a secondary one).
> > > >
> > > > Git tree:
> > > > https://gitlab.com/mihalicyn/qemu/-/commits/nvme-resize
> > > >
> > > > Changelog for version 3:
> > > > - rebased
> > > >
> > > > Changelog for version 2:
> > > > - checkpatch fixes
> > > > - rebased
> > > > - CI is green (https://gitlab.com/mihalicyn/qemu/-/pipelines/2602102750)
> > > >
> > > > Kind regards,
> > > > Alex
> > > >
> > > > Alexander Mikhalitsyn (2):
> > > >   hw/nvme: initialize ns->subsys for n->namespace
> > > >   hw/nvme: support online resize
> > > >
> > > >  hw/nvme/ctrl.c | 10 ++++++++
> > > >  hw/nvme/ns.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  hw/nvme/nvme.h |  2 ++
> > > >  3 files changed, 79 insertions(+), 1 deletion(-)
> > > >
> > > > --
> > > > 2.47.3
> > > >
> > > >
> >
> > Hi Klaus,
> >
> > >
> > > LGTM.
> > >
> > > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> >
> > Thank you, I wonder if you have a plan to take this into nvme.next soon?
> >
> > Kind regards,
> > Alex
> >
>
> Hi Alex,

Hi Klaus,

>
> Applied to nvme.next. Thanks!
>
> I dropped the assert on ctrls (always true).

Thank you ;-)

Kind regards,
Alex

>
>
> Thanks,
> Klaus

