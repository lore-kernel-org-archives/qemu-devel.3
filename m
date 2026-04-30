Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F301FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIT7Y-0005y7-Nd; Thu, 30 Apr 2026 11:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIT7V-0005s4-6i
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIT7T-0004U6-CG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777562162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbAZFrSelZh36u7cVMr0rb5mUMClEWvyRUSEplgrPRg=;
 b=KJ0MwecbwFuLFGfTsSmeCY4Xu0XreshlS4vN8BPxzMyYBFeYAkJbqCi6sGnV4n/8Nqior3
 7DpfZVmMJW4ZCcRKUPcegD51pT/t5fZtc4LO4HkkAnKk7cCL+CSdGSS6xCm0piZNWXFJg8
 +0TU9p3TZqEmeyZ944c88+mP8hTL0R4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-yB--GZkzMLavQxFZ8Wp-rA-1; Thu, 30 Apr 2026 11:16:00 -0400
X-MC-Unique: yB--GZkzMLavQxFZ8Wp-rA-1
X-Mimecast-MFC-AGG-ID: yB--GZkzMLavQxFZ8Wp-rA_1777562160
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fbc70cfbdso21977121cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777562160; x=1778166960; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wbAZFrSelZh36u7cVMr0rb5mUMClEWvyRUSEplgrPRg=;
 b=DtVEfBNptdxNSJF4VSEjmEVGfCueYV747uyoU79iCmFlUkMQ+MI821XB5xNkoxZb6Y
 RTwGxVQgVC3ngFuMc+aAEZjrPjdnq/ZUMa6mzlx8nh2Je/kEaKsHUUVDfJVAodEdMwmU
 1zT2EMEaP41LgxcrfWvZyXIE8rWhyNHjH0sjZIfEKl9kx8pK9u2WjE62SKmoZR3P35qA
 hW0kLJpYOPIo8mULbLKkvTSpEvS7L786uatcvDqjDuYn7kFENAWI8B/lUHVA+c6fx/Gv
 bG4sCdEC/LpZmVDg0jCiN4R7d1QmJMhkI/z4q1KP3+IXpLh+bIwPtAYb8xNFK8y5dhYo
 kofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777562160; x=1778166960;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wbAZFrSelZh36u7cVMr0rb5mUMClEWvyRUSEplgrPRg=;
 b=btScMlH4fu2TRBfxFDT72bML8iivLlvxTmChs+WtbUjJ4Et7vvBtTTzt8ziP+7I3XN
 lBJI7We0SkB0xYERTMHJ/ftBeCT9dHDw30uTv11nyufKiQRN5Df5GyOM4dooe6MMB5al
 Zxe/1lNOf/xgJ+syFR8XNaUwVAMLlGTSGem8UqPLSuSLseyRUtwoj9NzdZfV0O/0r+1/
 KCT2XZbMW2I1g+xvIAOGLXE2fK/l7y8HgeYILJMsqZ0akdmCz+IDwgfAaNAdnDNFYQPw
 2jhnZXewrancJ+Gk/lmdTOkUyyCipcL6oNAm16TFocFd+r4Vidt4fR3lPUY/uoyYBSz6
 9wpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/cShRAbHc8oBNLZwGnba45qWFOexajkkrKHsatUoXoNBEtgEUUJDI0Ur3mzKZo978IoYnyHdGjRmv@nongnu.org
X-Gm-Message-State: AOJu0Yy1WkHeAaN/e9Ezi7XemQR8YKeRWyWVeP4d2ycCxkplN5Cc6rJ4
 tVM3k0L3FZynVXKBE78cwjdpEDS44kcpAOthRWRGpx7u2k1D0+SISiAQov2RpLqvO2n8dh8/KiK
 9Z32sLtZxHf0e6J9tvlZdPO6grqfSk9j3AYdY/6w3ZebRgsgYiFXtLShQ
X-Gm-Gg: AeBDieuQkBBkJJC2hKYwVlBZiZ1ol8wP7z6DxBh4uiNyn7ktqFjvTOmm6Jql2y/Vh34
 nr2ZJJNGZ9Y5fnBeJEKbj7XWjsSf9UZiCzjeh56nnquSvivQicgqtba7EwMTeCvOX/yr003kizX
 23jf69rHxezuTpOtmqrCpmkz3L6rgLUFK/pkvu0rkIiUPHfmbtQhktMraI9zEMh1bAnibAlh/14
 6aK8oZ8x8PGx53j21cBl7fEqPmqo8zkTm16YOa6zIVi2vJZwaCBZ1+KTDJg5w8CXPysXLvosNuj
 w395TJz+QktAtTyDBDsFam9n1YBW7o7ZWbrNyHpGfojfeS5oxY51j5X74KRKd9CvnE0DutHbhqe
 4/gYyKNzpdfmNuFfm7dAm57l9NifpPq20Wz8qWpFlDp0/tOpguF95kHztiw==
X-Received: by 2002:a05:622a:1110:b0:50f:ad91:8902 with SMTP id
 d75a77b69052e-5102ad9b0abmr45963191cf.37.1777562159963; 
 Thu, 30 Apr 2026 08:15:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1110:b0:50f:ad91:8902 with SMTP id
 d75a77b69052e-5102ad9b0abmr45962641cf.37.1777562159336; 
 Thu, 30 Apr 2026 08:15:59 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103b3a1c4fsm565201cf.11.2026.04.30.08.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 08:15:58 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:15:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 2/4] hw/npcm7xx_fiu: Specify .impl for
 npcm7xx_fiu_flash_ops
Message-ID: <afNyLaTjM2uz_wX8@x1.local>
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
 <20260428093339.2087081-3-peter.maydell@linaro.org>
 <22ce7f65-39ee-45cb-a021-ac275d036f38@linaro.org>
 <CAFEAcA8SpD+X0kLg-6kQ+TR2VSJqhtMpzQrfsOqEZE_EzfkW3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8SpD+X0kLg-6kQ+TR2VSJqhtMpzQrfsOqEZE_EzfkW3Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 29, 2026 at 01:26:36PM +0100, Peter Maydell wrote:
> On Wed, 29 Apr 2026 at 08:38, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > On 28/4/26 11:33, Peter Maydell wrote:
> > > Currently npcm7xx_fiu_flash_ops provides no .impl substruct; this
> > > means that it gets the default of "implements 1, 2 and 4 byte aligned
> > > accesses".  This is more constrained than the device permits in its
> > > .valid substruct, and also narrower than the functions are written to
> > > handle.
> > >
> > > Add a .impl substruct matching the .valid substruct; this means that
> > > all guest accesses are handled directly by the read and write
> > > functions, and are never synthesized by the memory subsystem
> > > performing multiple accesses to the device (which would not behave
> > > correctly, as these read and write fucntions have side effects).
> >
> > Typo "functions".
> >
> > >
> > > Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >   hw/ssi/npcm7xx_fiu.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
> > > index 02707de350..2d5bed005a 100644
> > > --- a/hw/ssi/npcm7xx_fiu.c
> > > +++ b/hw/ssi/npcm7xx_fiu.c
> > > @@ -250,6 +250,11 @@ static const MemoryRegionOps npcm7xx_fiu_flash_ops = {
> > >       .read = npcm7xx_fiu_flash_read,
> > >       .write = npcm7xx_fiu_flash_write,
> > >       .endianness = DEVICE_LITTLE_ENDIAN,
> > > +    .impl = {
> > > +        .min_access_size = 1,
> > > +        .max_access_size = 8,
> >
> > IMO this device should be adapted to have byte granularity ops handlers,
> > thus .max_access_size = 1.
> 
> Looking at the implementation that doesn't look like it
> would be possible. The implementation does operations
> to start an SSI transfer, then transfers the number
> of bytes written. That makes "guest does an 8 byte
> write" different from "guest does 8 separate byte writes",
> and so the read/write fns need to really handle all
> the possible access sizes.

I tend to agree.

AFAIU, a split could cause non-atomic issues (even I'm not sure if there's
any need of it in reality..). Since the use of deposit64/extract64 should
mean they're ready for 8B accesses, then it sounds wise to support 8B.

-- 
Peter Xu


