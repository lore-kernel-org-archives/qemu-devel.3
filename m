Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FC3FEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzLv-0004rp-CS; Fri, 27 Feb 2026 10:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvzLc-0004mT-H7
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:01:47 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvzLa-0003VQ-4f
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:01:43 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64c9f7576d4so1524060d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:01:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772204501; cv=none;
 d=google.com; s=arc-20240605;
 b=j8fWrbgfJFrTQI37uXEoGoOcHfqOw5z1ewY4kfg70Zh3UZIXPqBLz0aWbgrxeaHzGA
 eFI8S8rflEK1Lvez7UrKQCnNmgCbcnIbj5/Rxd6Zslr5GRQcZorzeC2c4RzjTB5HwjIn
 unevGHlfg3jxogxmiQax42snuXkmOp20iIy0wYcNAF8pqNEQsGmjjaJuOEByre+UJsoG
 zddXtTHEOUV1VGvkvZ9vKBMgR5icUBPZvgVZd58tSzIi5sEP0B2iYM5y0VSWjmE7opQm
 xEj8s+8s2ErnAQnG9jucFDpcNB7GCxPK4HA1GdmgRg4vRUUd8nzxoXK6IU7rPJ6+gpAB
 jEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S6rnbHndetQR+wb4+fp/uZDeq8lU38zqO68Xn6aFqwI=;
 fh=1+ibO3AzaWfh/7pBS83/xlYjAi8aoCxULcJC0hOdjC4=;
 b=NtRYrU+/SJwMNoKpRm+qWogOiPexmYvaGpwHIMsV/zJNE/KWxykITRLEiiiCJaebTj
 DHVbEfJTJQBaGpimpAGAFcTAj6+5bARcH8G1gqsEofiWevRYLg+nVIeOM6ENoFiffvFK
 8CFpi9hXmhyEDOEPULA6pkTZQ7tyLN+Y0e9b9YqLvKu8MNAwXcSKZ2afG6Gr9Edg7Pv2
 6tG7tptp2jtsgyB+HuqnOYutXH7oB+o5NOV05hU7E2mDeujFmOikvGv9PDTd2d120I0o
 9MIgMSeBqZtOWFYowgpT9/ZXQUGIRKyppW94E6/lOc8S2QDo2haS1pn/YlAa5Tfu7dUT
 DrvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772204501; x=1772809301; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S6rnbHndetQR+wb4+fp/uZDeq8lU38zqO68Xn6aFqwI=;
 b=IDYzYkwVaCxo/mGGZPt9oUU+a2g/iyq6VEoMH15oLr1Pworsx2I/NwzjBgfsp+oL73
 6fYe+Hj9Knkz8hLNdSSKuXsvjNx6n6WNrKGVXAHiF4XRQjDZR5Heg8cW5dsX00Empq4J
 H0XGJgJO1upKKu6NcE+tewcl0GKrVY12J+WLPVqQfdE5JQlrGri2WVFsuYJnFBKeHK70
 vZjYK3imVUt6VdziQnY3ZqFdi/lcY5I53WwpEeuvANt4I9NHMf4oNATfDM/MbA6chVEf
 BZ1dIAeksp4zp0vdHdHdWRnQWm1BFaGWwghjhDjpIDdimJ/NB5e8D5F+wi2BBg3blnL/
 WKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772204501; x=1772809301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6rnbHndetQR+wb4+fp/uZDeq8lU38zqO68Xn6aFqwI=;
 b=VR7/MIsvUCtPqDBOLjWgMrmh0t9zo3/d6zDMizFXEKUhsBeS3DfrzUq8f9qpphqxkR
 Fy+gcf2yLZLWuBBTyMhZdbwhWAyFPprhNIHEX3RyuVJdl+y6HcEjmuvWdqMA4xHKXrrU
 PQgsT3zA0D/rtfDJANgC79VPId+yM40hisyV0hzaycH24LpwdX8P1dSxuxCnbA+IYlnG
 YwZ7itA79gZSYvpaTcq31xJSjApngOwQBA06jooP2ziMocbHgtYz36GncOny8qXFC+ZO
 WzS0CBud7rQPgxjl446/F1L1MuG5QGdpGtsm49JtDvxuD9IhQ6k4kBoPdNpyKgsu2/YJ
 BI7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkHE075+lNQGDueSw5MhizNALfjp6e0IrEIhfqdxw6zNiK2Zh4L0XhKPUZKrgIrrqL6dk6YkH3Yrf6@nongnu.org
X-Gm-Message-State: AOJu0YwncJRPelJmuiSaWYdM2H06yGj0IQ0x3c5gr26qbsjh11wQawQc
 eULJkZyOc1HVJ88Y6ptxVsMQdGPoS543oCA3vqAhbKe3DNkXGlJrg/aaNm+SROn6hpmSCKGAUNe
 xZBIIryfiSXuY3C9AXZP0vSwfzeFXpt4RErRiTjZmqQ==
X-Gm-Gg: ATEYQzy8YcRvjoCZUX0pRwGAx4rzdqgXJ+MQHdQbR5DiHeSWBCh+jtfWy53eooZE16i
 m3ro+95e/ADSrkUZ5Ve+rIEKiyGRuQ1zWhnYRe3dcbbKf12/NOL1EViT2IXwShy6OX3DdPf70xi
 3IrLra+Q3D3Pe2lHrnLe4H1EJCIK5JDKAYFeAfrRLv0KER0inTuLg2f6VdheURWuek+kv/xGwe+
 R8ejNYuxwVJZ+qt0A5iJ6Uut2ShDQdxaVpcHLp0G7fwAIlZQAMt9P5rKl+KiyEYUBKSFmGfYts4
 WS3+PTZmkuHgvanj6FtY4/3SDMASKilDNaoAi3ii7Adc4rjY0E0jGb53r/xg5IPMEHA=
X-Received: by 2002:a05:690e:4cd:b0:64a:e799:1d92 with SMTP id
 956f58d0204a3-64cc22f1122mr1910988d50.61.1772204500369; Fri, 27 Feb 2026
 07:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
 <20260227104227.3d84f0d7@imammedo> <87ikbi9yky.fsf@pond.sub.org>
 <CAFEAcA_dXNiXCeYdBimBMR-hWvt6+DB1FdJ9iZ5q8zoejyRWeA@mail.gmail.com>
 <87qzq68ck1.fsf@pond.sub.org>
In-Reply-To: <87qzq68ck1.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 15:01:28 +0000
X-Gm-Features: AaiRm50_XpiZ1q6sy2xD3AQcuhCtJ3e6npOCk6vlwh3uz6MpSUlqocJOy0MJRgA
Message-ID: <CAFEAcA-DtSE4MsN2XcBkOk5t3Xbe_Kz_MtUwfCkas4Q7R7CFnw@mail.gmail.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 27 Feb 2026 at 14:51, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 27 Feb 2026 at 12:10, Markus Armbruster <armbru@redhat.com> wrote:
> >> The larger problem is that we generally fail at documenting device and
> >> machine properties.  I'm not asking you to boil that ocean :)
> >>
> >> The narrow problem is providing guidance on watchdog configuration.
> >> What and where?
> >>
> >> Regarding where: you proposed to add a machine property of QAPI enum
> >> type.
> >>
> >> The property can have a description, and you give it one.  Sadly, it's
> >> basically invisible.  As far as I know, the only way you can get at it
> >> is qom-list-properties and such.  I doubt anybody is going to read the
> >> description there.
> >
> > I think it also will appear if you run e.g.
> >  qemu-system-arm -M virt,help
> >
> > (which produces a list of all properties with their short descriptions)
>
> You're right!
>
> > For board-specific properties, we should be documenting these in
> > the manual page for the board. For instance "virt" does that here:
> >  https://www.qemu.org/docs/master/system/arm/virt.html#machine-specific-options
>
> Every board should have such a page.  Even if it's just a placeholder.
> Placeholders would remind us where the gaps are.

I agree. For Arm I believe every board should already have a docs page,
even if a very minimal one. (Some closely related boards get
described on a single page that covers that whole family of boards.)
The full list of pages is here:
 https://www.qemu.org/docs/master/system/target-arm.html

We follow the same pattern (but not always with complete coverage)
in most but not all the other target architectures.

I don't think there's currently any automatic way to get a list
of undocumented boards, because there isn't any tagging of the
boards that are documented except in as much as the board names
are listed in the title of the relevant pages.

-- PMM

