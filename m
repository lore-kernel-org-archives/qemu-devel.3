Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B706AD73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 18:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlWc4-0003br-8v; Thu, 29 Jan 2026 13:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlWc2-0003bd-Qm
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 13:19:26 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlWc1-0000d6-9L
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 13:19:26 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7944693b824so13912547b3.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 10:19:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769710764; cv=none;
 d=google.com; s=arc-20240605;
 b=QCHti7csdYxpKJNrrXsbNpGVJTVewzSv1q/tlDWaAFFUmpMDi3HF/jlNer3WkJdjNU
 ERnXCU2Vhz3Jh64/85FaZiZYC8/DUOkiSbhLBJtu8Obht8dDSK0txsuMey4syl0cMMN5
 y7gTGGYAH1TMj2ItM+jqO8lzbELC31P0RD8MxFYgKybeopLbdd6kf6LZE2nZmGILcC7n
 4j2hiq7QKp5osmPP/6ysI5u+B7uGtPSpbnwrtmDWkqhsaJ+sVKp3MoH+rFihj6rrEXFl
 kTUx3Fcjr28gf+qtCOY9sq1O9+gnZ5e1pEQA53uL7mS6pzRhAIKwNDwBXc+0uJIqitKW
 4u3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=16xekaT1qQR2Oa5cgHj6ACFm8BF+ewaOHFkmX1VYtA8=;
 fh=YL0NE4lWf04jcNGWdUc9cgi/Lvh5AUmBxwt6lA0XDZ4=;
 b=JDxcL01wnelYUm1rQumvfkKb55pdLNfbn2ba7S6U0hApE2t8P/nHALk2yGRY51AqNr
 gI07guzXt5FB1nz6J0xF7v0sJ3gblxDOEXjn0PGqPpL66GYlMLOio1c9BDlFsZKr19jM
 ld7MceJhMicgIhxoTkHssqgc8htkYx88AgpFvzSIIAha8o5E+6FUV/t9CD/2z18pQtBk
 V1aVOvgYKWGbETLfaFedxjlDUnEEJ4u4JucCaddMSYn4TkummPrLvUCnq2og7xVLvjBp
 ayQu6UdmI1KfNJ7GfKO7N8JVfHteYHtyZBiWe32qEoADfmrHi3r71eXppOpYZOtvLKAa
 4/gQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769710764; x=1770315564; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=16xekaT1qQR2Oa5cgHj6ACFm8BF+ewaOHFkmX1VYtA8=;
 b=r8d2zlJEWPu9YzwW6rxIPm4sFVcLlhq6Veuy/X1p1dq4Sg926WLxzbBnohOFKXoSz5
 akcsSEd/vi1HS8ugcLnYqZC3ucuOxUch8zZH+WtOu/lto6BwEUPQniHXTeYEHD6WTa+b
 i0xA5vNs+a7gp5O2o+TC4Xk60BlH3KTUvguTYb6mnJi66K7Grx4zp72aCNzrpOZop8tZ
 nx2JPS99WSHk7AvhXuax/t5IKBWat2/igalwmx2iN8xtionJecKrFiZaudIIX5zURpEg
 J4TK/Z9SZ30Mhek7gdbP2M1/UN1JA+Tury1+J9W7sFPyRhjbuWwT8ZGkbDWgZ0OE5tAy
 0lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769710764; x=1770315564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16xekaT1qQR2Oa5cgHj6ACFm8BF+ewaOHFkmX1VYtA8=;
 b=GjrbnPoiX50m5en1bLEibWt0ZDRj1aEDjdEA6/Nw2ZwQgxiiHoMDEVYt7FmxhXiDou
 d2enWdXXYx8HAFf/ZE0nM5Y8JBmgJsdyqSTxM90txmwJArGCUXoH0n6rd8daeoyGvxOV
 oWSre89jAosXKMedl9T9xwWwg7nSBz+rslRM6RMb43lsOyvR5GehiKeoCuXwOYa0cBTq
 ktonySI0xjZsUufRuhI3TwPAP+6LRkVO0m3I1zI5iVM0kIQlKOTezOd1wbqfh1PmlNcX
 uVxpEf7amA721LwndtA+egiFwI6sPPfZzfc3DkTxCBWQrXXhJeJQkr4s3bGxMJljN9MA
 V1qw==
X-Gm-Message-State: AOJu0Yz2lFN3S9FY0bJEFAjmIPILTpNt5y9Hbs+QvNAnJh1ypdnDP6Qx
 8vRFj55yidFq34GQBUr82IN5dXdamGIojsVhSdU73BFjqHdr5/Y2zC5yKdWBDAevrrSro9b3paf
 f1jzEP0irFovg58W+X+Pdx1IBC/7BkoIeZIgKHUG0QA==
X-Gm-Gg: AZuq6aKsXjRpazw+3LPEgdTTcVNJUjzMbhrXRci/XkFKNeRvZfD9MKXU64+u+VFFmkj
 Ext58dgPGB4bqVmlCcdB4YLOKdCy95F2moJI+WhIT+X3BhzaSvFxwnMEMkxLhfcJIca7y/Pll57
 pNAk8JODUG0pJ1nYc4ebB7cENOtBHdPyfYOzamyWQeXtA3/VlKpWhPz9q2oKugHRIB2gpSEuBl4
 lohTW2cf+h5miAWI0hH3nYoNiWQxprcbdu6ht1UU/Pvui/EtjifoKpuItwtV/W82jvgKQ==
X-Received: by 2002:a05:690c:c50e:b0:78c:11ae:1adc with SMTP id
 00721157ae682-7949de6cbd1mr4989257b3.9.1769710764039; Thu, 29 Jan 2026
 10:19:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769703287.git.balaton@eik.bme.hu>
 <b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu>
 <CAFEAcA9+sKLXmzXz98rfnEqVBE4WwVcFsMqiXSx6KfK1=PDfKA@mail.gmail.com>
 <31362eca-9cd5-8b6b-a3a1-4ddb8dc3e762@eik.bme.hu>
In-Reply-To: <31362eca-9cd5-8b6b-a3a1-4ddb8dc3e762@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 18:19:12 +0000
X-Gm-Features: AZwV_QjL_dvGQeAJPLTxngfDCZOxrLfv78s2d8F-NHrIUDzvBlv_6ebo53igERQ
Message-ID: <CAFEAcA9htbxy0fHZAvdX6Rneina-r_a1ajN3w3FHUL=hykcyug@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Thu, 29 Jan 2026 at 17:20, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 29 Jan 2026, Peter Maydell wrote:
> > On Thu, 29 Jan 2026 at 16:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > This is a migration compatibility break, because the
> > memory_region_init_rom() function registers the MR
> > for migration via vmstate_register_ram(), which picks
> > an ID string for the memory that includes the path
> > of the device, whereas vmstate_register_ram_global()
> > picks an ID string for the memory that does not include
> > the path of any device. It is this difference that is the
> > reason why they're still using the _nomigrate functions.
>
> I thought it might be the case but wasn't sure. How was this handled in
> all other machines where they were converted to not use _nomigrate? Only
> some Sun machines still seem to use this and this may be a good
> opportunity to bring them inline with all other machines.

If I remember correctly, we converted all the machines where
we were happy at the time to have a compat break. The remainder
are not only Sun machines -- you can see in your patch 4 that xtensa
and vga are also affected.

> > I think it's reasonable to accept a compat break for the purposes
> > of cleaning up the codebase, because these are used on sparc machine
> > types and we don't version those, but the commit message needs to
> > note that this is a compat break.
>
> If we accept that then the other memory_region_init_ram_nomigrate usages
> in Sun machines could also be converted. If Mark is not open to that I'm
> inclined to convert these two rom_nomigrate usages to
> memory_region_init_ram_flags_nomigrate + memory_region_set_readonly
> instead

My preference would be to convert all these Sun devices. I think
we're a bit more clear these days that migration compat matters
for versioned machine types but can be (cleanly) broken for
non-versioned machine types: back then it was a bit less of a
well-defined rule.

-- PMM

