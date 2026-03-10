Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCF8FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzpV-0001QR-7W; Tue, 10 Mar 2026 12:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzzpT-0001Q9-St
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzzpP-00082s-NA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773159662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTysAR/VXgL6SoCyTs1ndXMSg+O/BgqPoTSHbFhXURU=;
 b=Z/UMqN4gmSB82LLd+XP+0AQzCvgiM9fu1L1Nv5j1ObnRrKOu2lMs+VRWJPB6XrnBUBu2Ya
 1QMfQE3mVU1Dv9YrC6eOtpGrxmbO+ydkR2j8WqgnGxFYvp3nwNvXLUdMAfGV/6WI8r5AB8
 w1Nd+bWi3vx8C3AIUpr15q/Ttoq4QA0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-wGRhJN6HMV-8LcuFyfNc0Q-1; Tue, 10 Mar 2026 12:21:00 -0400
X-MC-Unique: wGRhJN6HMV-8LcuFyfNc0Q-1
X-Mimecast-MFC-AGG-ID: wGRhJN6HMV-8LcuFyfNc0Q_1773159660
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd8b37d4b2so1420185285a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773159660; x=1773764460; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dTysAR/VXgL6SoCyTs1ndXMSg+O/BgqPoTSHbFhXURU=;
 b=VxDmNGHgpfXLyr3xiZg5B0yImNcSJgKT5OM6s8q+F9rhrUwjmjT6dRd5qoaGD1kFEo
 thdlMX3R68SR1yprcTTdgy42Rc8I3aAUh43QMKS/LznDzsN3XKnUzPCcVuUkwe1P1CZ+
 zNgZeLRgTw078YflFlHf2j5eCtybjcUucF3qTUf6/gIPK7EzSGHp4RxOCphLYKVSVOlX
 u5yWKV+bp3fCsZcLWrIPsBYLNOFaMb9Cs35uHHLr2OW2ER6nabHygkJ+1Tna4VGA30hc
 JjgY1/v2ISWKjNU2Bs+NfCUcrjQmUezUrjh7hzDEERkCFJbK0pOnw+iym2KpDoJ5VBPc
 00LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159660; x=1773764460;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dTysAR/VXgL6SoCyTs1ndXMSg+O/BgqPoTSHbFhXURU=;
 b=F3BL2Sq82a0Gxsq8u6EkAsAUlCjKF3/SU+Q1nmR6oI895EieJLEHz3OMGvLXfrOZpe
 Tt63Wv/FgYL0HIYYUV+r0fVEM4JB8w/vav3OKfhHBsv3o6HJ72IsBmvA7RkNNA7D17Ek
 Wt6cTq1szspAp03iGM1N4O4ed1uA5ebz04PHftnpeRW3xtYmKNhmd8+mnx7BDY07c2WA
 JLEcUisd14eqcSzhhBDzqQoh65aaVoIGAO/CDz9r6xWpzPw0nRs4aOnwIjpJ9DjokXA6
 hN/RNkv0x+EQN1U437lgtvZtfQPWL7k7C+zGXwphRK5Cg1lQMWgq0XZwFGi1Inz4OPvg
 EkYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEf0UTe7fDUoqJCFi1CAUlSLIYLnXPGjydbyysQOE1UNAb4NSdLSimMDgurxqcLLLi5cWcCDAt/YKR@nongnu.org
X-Gm-Message-State: AOJu0YxOxto6SYvhcA29qGdZS45eJbyJx+oyQpDNfy4LRq4RMyIPAHFa
 YXlYqOuA+K+6C+5m6GqTxxzc5mQ5zJeNzOQYmysE2+ByyMrQfVaSoymyr4OKdLkX+e2hy8tKe9R
 mTz6iNyiNFKzKnCv9sDJwBQDszJvk8aSbU1w50kJ3uj9HYxUAaUO4lJYK
X-Gm-Gg: ATEYQzyIIy9omzjvcgV/i535sdNBwbiER0ta9KIYuCZ594aqwYJpR4NjZ/lhOv8VyVx
 04sMtqnQXRaflVTxf1fb+TyuQU9eDSNg5E2aoDERlYPeSxUt33UFyAEzZ8zx6W6n/D07R2ZjDGd
 yhEEJIWMzSRJiTERlu8wTNs27Mvq71U32NFZ3CYhCtnf584wzL+e2zmsnj7L/Mj75JQXx13MH7g
 o4uxUHNRfeOnYdS+z+GPhd9/sxLbQ0JAi/9X2Rb4w9SEzWstn4SdQcGsDemu5uEqFwFgzwlgb2k
 +PFu/MpgTSArlfanFXGfCvOz9kPDzaf95jXUuSTekekLBEzexHOgTdXBl0WtGxfUAAl8mwSXcf8
 s2g62n93eKfPGbg==
X-Received: by 2002:a05:620a:2848:b0:8c7:fdc:e84f with SMTP id
 af79cd13be357-8cd6d40d237mr1909509285a.11.1773159660074; 
 Tue, 10 Mar 2026 09:21:00 -0700 (PDT)
X-Received: by 2002:a05:620a:2848:b0:8c7:fdc:e84f with SMTP id
 af79cd13be357-8cd6d40d237mr1909503885a.11.1773159659520; 
 Tue, 10 Mar 2026 09:20:59 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f56da77sm968196585a.44.2026.03.10.09.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:20:58 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:20:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v5 1/2] vmapple: apple-gfx: make it work on the latest
 macOS release
Message-ID: <abBE6NuYJIJgM0rj@x1.local>
References: <20260306145246.10274-1-mohamed@unpredictable.fr>
 <20260306145246.10274-2-mohamed@unpredictable.fr>
 <8908689a-f5c1-490e-925d-7a664093963f@rsg.ci.i.u-tokyo.ac.jp>
 <a24c76d0-4106-4d49-b032-35f7f6310e69@linaro.org>
 <f94bebf5-a452-46cf-ad46-acb71c619917@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f94bebf5-a452-46cf-ad46-acb71c619917@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 10, 2026 at 03:55:41PM +0900, Akihiko Odaki wrote:
> On 2026/03/10 7:21, Philippe Mathieu-Daudé wrote:
> > +Peter/Paolo
> > 
> > On 7/3/26 04:08, Akihiko Odaki wrote:
> > > On 2026/03/06 23:52, Mohamed Mediouni wrote:
> > > > Follow changes in memory management introduced on macOS 15.4.
> > > > 
> > > > The legacy memory management API has been removed for the
> > > > IOSurface mapper on that macOS version.
> > > > 
> > > > Also enable process isolation for a sandboxed GPU process when
> > > > on a new OS.
> > > > 
> > > > Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > > > ---
> > > >   hw/display/apple-gfx-mmio.m | 62 ++++++++++++++++++++++++++++---------
> > > >   hw/display/apple-gfx.h      | 18 +++++++++++
> > > >   hw/display/apple-gfx.m      | 43 ++++++++++++++++++++++++-
> > > >   3 files changed, 107 insertions(+), 16 deletions(-)
> > 
> > 
> > > > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> > > > index e0a765fcb1..92404d20bf 100644
> > > > --- a/hw/display/apple-gfx.m
> > > > +++ b/hw/display/apple-gfx.m
> > > > @@ -21,6 +21,7 @@
> > > >   #include "system/address-spaces.h"
> > > >   #include "system/dma.h"
> > > >   #include "migration/blocker.h"
> > > > +#include "system/memory.h"
> > > >   #include "ui/console.h"
> > > >   #include "apple-gfx.h"
> > > >   #include "trace.h"
> > > > @@ -596,6 +597,37 @@ void apple_gfx_common_init(Object *obj,
> > > > AppleGFXState *s, const char* obj_name)
> > > >       /* TODO: PVG framework supports serialising device state:
> > > > integrate it! */
> > > >   }
> > > > +@interface PGDeviceDescriptor (IOSurfaceMapper)
> > > > +@property (readwrite, nonatomic, copy, nullable)
> > > > PGMemoryMapDescriptor* memoryMapDescriptor;
> > > > +@end
> > > > +
> > > > +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
> > > > +                                  const MemoryRegion *mr_const,
> > > > +                                  hwaddr offset_in_region, void
> > > > *opaque) {
> > > > +    MemoryRegion *mr = (MemoryRegion *)mr_const;
> > > 
> > > flatview_for_each_range() should be changed to pass non-const
> > > pointers instead.
> > 
> > flatview_for_each_range() was added in commit fb5ef4eeecd ("memory: Add
> > FlatView foreach function") with memory fuzzing in mind, so const MR was
> > the correct choice then IMO.
> > 
> > FlatView is more of an internal memory API, I'm not sure it should be
> > used by hw/ layer.
> > 
> > $ git grep -w flatview_for_each_range
> > hw/core/loader.c:1656:    flatview_for_each_range(fv, find_rom_cb,
> > &cbdata);
> > semihosting/arm-compat-semi.c:158:    flatview_for_each_range(fv,
> > find_ram_cb, &info);
> > tests/qtest/fuzz/generic_fuzz.c:310: flatview_for_each_range(view,
> > get_io_address_cb , &cb_info);
> > 
> > Semihosting is special, as it the ROM loader helper, and fuzzing code.
> > 
> > 
> > We provide MemoryRegionSection, MemoryListener and RamDiscardListener
> > APIs. Maybe one of them is more appropriate here? See:
> > 
> >   * A #RamDiscardManager coordinates which parts of specific RAM
> >   * #MemoryRegion regions are currently populated to be used/accessed
> >   * by the VM, notifying after parts were discarded (freeing up memory)
> >   * and before parts will be populated (consuming memory), to be used/
> >   * accessed by the VM.
> > 
> > Could this be what this code needs to do?
> 
> The problem here is that the reverse-engineered interface is insufficient to
> keep the memory map synchronized so it can only populate the memory map
> during initialization. flatview_for_each_range() fits for this purpose.
> 
> Ideally the interface may be reverse-engineered more thoroughly to
> synchronize the memory map at runtime but that needs more work.

IIUC we could still use memory_listener_register(), and I agree with Phil
it might be good to avoid exporting flatview API further to hw/ if ever
possible.

memory_listener_register() will properly replay all the memory regions
similarly when adding the new listener, via region_add().

Thanks,

-- 
Peter Xu


