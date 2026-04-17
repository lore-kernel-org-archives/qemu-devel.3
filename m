Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EA5F436B2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkqR-00060u-MP; Fri, 17 Apr 2026 11:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDkqQ-00060e-GO
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDkqO-0007Rb-DD
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776438654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s92uyUk+uNDIf6n63xBX8YC66tbvXrwMqpU+Qn6/kNw=;
 b=JBVdcMXgMa7iOcC8KCPBcK3dJ6cbvVtDIzfdzakGYGqJZEqBG/CXE2iCfF0sZmKYZYcJMZ
 TqrgySv1AU4VKC10Ur9bBobURfbVGpHqQaN7U4fJMyf1viG7bmEW2gMwqhK/bN9tmCQRqq
 xrjp3F0zpoFUrPWFW2dzQT+VrfQ8P4w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ss7H3vKENhysPa6mDfevEw-1; Fri, 17 Apr 2026 11:10:52 -0400
X-MC-Unique: ss7H3vKENhysPa6mDfevEw-1
X-Mimecast-MFC-AGG-ID: ss7H3vKENhysPa6mDfevEw_1776438651
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d70e3e4e7so872325f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776438651; x=1777043451; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s92uyUk+uNDIf6n63xBX8YC66tbvXrwMqpU+Qn6/kNw=;
 b=C8kbQ02TX5ho5LF3mUI1yslsd7ihqO5MEEeigs3RdbXBP+zTRC9ID46Hb7DOXKXdlB
 h+mQcHBxY4bYxVR4WkGdbRpKJLxrQf9Eif5Bk7iF470ba8ZNheIboyNygYrZLBI+DiQx
 W2CabHII5NiiJIbBhkIpRqA1sHbv0aoYFeRv/WllK3UAtOJ3Iakhgrr+8GWl5VaPwZz1
 kQoHYhEcw0dpoEVHwbc2h9ZHJ60A6qNSjp5B0+ibFtWNDE8s8RW114gGwkiQPhX/Ecwp
 C/kWUpQDXKDjLYb9Pvn3qZ63FQPm7SSzmb3uCFZvuquXOef4Acmll8drbcveRTm4ypir
 zJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776438651; x=1777043451;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s92uyUk+uNDIf6n63xBX8YC66tbvXrwMqpU+Qn6/kNw=;
 b=Klm+c9BU2Pf/Bs50CN2cc1/3dTGdHD8TocVRTv26Pt6GQ5Z1fJDKvmUcv9brv6VaWA
 tlM+KKinkaVbIQii2+pQ4g9GDaL8YFStH7snRLJKtQcxaPGFouB5sdrpPv3dE6n/jFkB
 ozTGkk86qylC2iPMinaaR/WUo5eWFuBMUTActJa21vfNzhILrc8MXURnh1bpwsPZW1AH
 rx03I+PkYkdpV5HL+db+vkz1XAbdrS5cr++vt/FQP7V4Nt2EIszHfwZ0/RTRynCP27mH
 68UX8Ahlm5L0SUJCpvdQsvVyZCMNhnoGu3xITU+u9i25tVqobjIJQ7N6xaZaoxRBmP9K
 jK3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+1JKPydwAZyiOSH8JUyAHLguJ29ghh43yUdXW+UZqWRfLXnVr+qWRstKBzRcjHGzO9sgbU7V5Srx4@nongnu.org
X-Gm-Message-State: AOJu0Yzg93nrKDk43oKQmT3g5CP2DsaNlYrmO5chq/2rdqvUsS0dsM9C
 C3KFpq9lB1I7p75b3yYDSKhT7QbuUKt2PvYdx1bKXtCcXCsAz9fdclLxGpfsE5lNJ52/lkOhJx2
 XB/P9DHpY0NNqGJSl0HOCD+TRQLyz1iXAr7QNSriqzuLBuRljTBz31/2K
X-Gm-Gg: AeBDieuhyd7jb/+uc1bUzFFqwrgGzbmWv2J9z1LpK4tddUptapS7Zj3E74i20vaEqtJ
 ESsikpCvDjfD1yN81qBRE+Fue+I43MvLV26zEXsuH02vPn+dIEzMqqL+2ktUwrGKcOUW3bXJK7a
 c/EynOQoV65zwA6RjaLzEQ8GD0Jdi7HCbwr2se/sQZthHORXu4lkbi5B4++AGT7qH8YWDdErz/e
 39xUHVCDu5BmgTRL41OGjiUG0LUjUS3spqaH5Zl/L0jABfebYnDeGi5JSQjhvSc12insLx5/9tB
 4EAoOt5bVe0rYCI884Wd5W8mF9boKi9TY2ZWaot2q5Mtkwb6XvsEGX0mdcs2oInzR3dCB5dZl7U
 6hH2IFythqexqW5b+qprJVBWyD9Sb7YUC/Hpv0IwLkp9xch5vgkz6LTRH1Q==
X-Received: by 2002:a05:6000:2902:b0:43d:77a8:3baa with SMTP id
 ffacd0b85a97d-43fe3dc551dmr5099579f8f.3.1776438650768; 
 Fri, 17 Apr 2026 08:10:50 -0700 (PDT)
X-Received: by 2002:a05:6000:2902:b0:43d:77a8:3baa with SMTP id
 ffacd0b85a97d-43fe3dc551dmr5099379f8f.3.1776438648677; 
 Fri, 17 Apr 2026 08:10:48 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4633bsm5228592f8f.26.2026.04.17.08.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:10:48 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:10:44 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
Message-ID: <aeJNdLTRSZQiEiP_@x1.local>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-7-jamin_lin@aspeedtech.com>
 <3ee36a34-573e-48aa-91e3-9140244717f0@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ee36a34-573e-48aa-91e3-9140244717f0@kaod.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Apr 17, 2026 at 09:01:34AM +0200, Cédric Le Goater wrote:
> + Peter, Fabiano,
> 
> On 4/16/26 03:49, Jamin Lin wrote:
> > Change internal EHCI descriptor addresses from uint32_t to uint64_t.
> > 
> > The following fields are updated:
> > - EHCIPacket::qtdaddr
> > - EHCIQueue::{qhaddr, qtdaddr}
> > - EHCIState::{a_fetch_addr, p_fetch_addr}
> > 
> > Update get_dwords() and put_dwords() to take 64-bit addresses and
> > propagate the type change through the descriptor traversal paths.
> > 
> > Adjust NLPTR_GET() to operate on 64-bit values:
> > 
> >      #define NLPTR_GET(x) ((x) & ~0x1fULL)
> > 
> > so that link pointer masking works correctly when descriptor
> > addresses exceed 32-bit space. The previous mask (0xffffffe0)
> > implicitly truncated addresses to 32 bits.
> > 
> > This patch does not change the on-wire descriptor layout yet.
> > It only removes the internal 32-bit address limit and prepares
> > for later patches that will add full 64-bit QH/qTD/iTD/siTD support.
> > 
> > Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to
> > use uint64_t for the address argument and print it with PRIx64. This
> > ensures full 64-bit addresses are shown in trace output and improves
> > debugging of queue heads and transfer descriptors.
> > 
> > Migration compatibility:
> > 
> > The fetch address fields in EHCIState are extended from 32-bit to
> > 64-bit, requiring a VMState version bump (v2 -> v3).
> > 
> > Backward compatibility is preserved by keeping the legacy 32-bit
> > fields (a_fetch_addr_pre_v3, p_fetch_addr_pre_v3) for pre-v3
> > migration streams via VMSTATE_UINT32_TEST(), and introducing new
> > 64-bit fields for v3+.
> > 
> > In post_load, pre-v3 state is promoted to the 64-bit fields.
> 
> Since ehci is supported by downstream, I'd prefer that the
> migration maintainers also verify the implementation.

Thanks, I'll only look at the migration bits.

[...]

> > @@ -2441,6 +2445,11 @@ static int usb_ehci_post_load(void *opaque, int version_id)
> >           }
> >       }
> > +    if (version_id < 3) {
> > +        s->a_fetch_addr = s->a_fetch_addr_pre_v3;
> > +        s->p_fetch_addr = s->p_fetch_addr_pre_v3;
> > +    }
> > +
> >       return 0;
> >   }
> > @@ -2470,9 +2479,14 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
> >       }
> >   }
> > +static bool ehci_core_is_before_version_3(void *opaque, int version_id)
> > +{
> > +    return version_id < 3;
> > +}
> > +
> >   const VMStateDescription vmstate_ehci = {
> >       .name        = "ehci-core",
> > -    .version_id  = 2,
> > +    .version_id  = 3,
> >       .minimum_version_id  = 1,
> >       .pre_save    = usb_ehci_pre_save,
> >       .post_load   = usb_ehci_post_load,
> > @@ -2501,8 +2515,12 @@ const VMStateDescription vmstate_ehci = {
> >           /* schedule state */
> >           VMSTATE_UINT32(astate, EHCIState),
> >           VMSTATE_UINT32(pstate, EHCIState),
> > -        VMSTATE_UINT32(a_fetch_addr, EHCIState),
> > -        VMSTATE_UINT32(p_fetch_addr, EHCIState),
> > +        VMSTATE_UINT32_TEST(a_fetch_addr_pre_v3, EHCIState,
> > +                            ehci_core_is_before_version_3),
> > +        VMSTATE_UINT32_TEST(p_fetch_addr_pre_v3, EHCIState,
> > +                            ehci_core_is_before_version_3),
> > +        VMSTATE_UINT64_V(a_fetch_addr, EHCIState, 3),
> > +        VMSTATE_UINT64_V(p_fetch_addr, EHCIState, 3),

TL;DR: I feel like we still need machine type compat properties.

Details:

When a v2 stream arrives, two _TEST()s will do the loading, then
post_load() extend it to 64bits, looks fine.

When a v3 stream arrives, two _TEST()s got skipped then latter two take
effect.  post_load() skips.  Looks fine.

When migrating to another QEMU, due to the fact saving vmstates always take
vmsd's version declared (3), I don't see how it can migrate back to a v2
stream; it didn't know about v3.

Jiamin, have you tested migrating from a new QEMU binary back to another
old one?  For upstream and serious devices, we need to guarantee
bi-directional migrations, back and forth.

Thanks,

> >           VMSTATE_END_OF_LIST()
> >       }
> >   };

-- 
Peter Xu


