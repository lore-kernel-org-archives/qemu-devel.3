Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AFFF9EDDB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFYhZ-0005XO-Ei; Wed, 22 Apr 2026 10:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFYhX-0005Ww-8I
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFYhV-0004gi-3s
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776868631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+y8dDOcL2TGY8RwRMF+ZJao4Mtt36PyCZPoOztGf8ZY=;
 b=TD0FB6yvSN/dySkuoGV2Jx3oMRCIBFM3JKgy0RlQ8qPZEMfbo0n46uKGPy9S3/3vNwdLaX
 yDiBNCbahmwqzelRRadDw5byIVyzxMVeOdhCk/oIDFfSrDwVbjCivnePVTqtlq5tGweZmp
 Lpy4QVNJe0LasZrehzh56mwOVUNaldA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-a2Op4qH0Pu6YkSBRkQejTA-1; Wed, 22 Apr 2026 10:37:08 -0400
X-MC-Unique: a2Op4qH0Pu6YkSBRkQejTA-1
X-Mimecast-MFC-AGG-ID: a2Op4qH0Pu6YkSBRkQejTA_1776868628
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eb04352924so637388585a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776868628; x=1777473428; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+y8dDOcL2TGY8RwRMF+ZJao4Mtt36PyCZPoOztGf8ZY=;
 b=Q/KYWUi9qCOziq3RcpkMzAB4xCxyvXEV3rFfe3Hu2cipJ8ZpgtEY+j3aC+219xbiNe
 +oTakTu726/I1+Yd/wcYFvE2UMsnecyXWxUOPq6G6Pm5hgUVPs6l+C8i3Mbn0BDw7qHx
 IVVlUqZ0aASBHOy3RqHdn26UcjZRL1JS/qDdxLFvglx3V5L61SPHqXOtUxnn+eHbq0Qi
 AC+IGVt9zoXvAZIiQzNjaK4Jcs9pLnK93OXh158kPBIbk6bgL75/3zMBLHsZcf+28J3p
 r8Yg8MNxeNyL7dKisa2kbZ4xsWQNI+GiAI2c64ILyL7uyG6OqsUfQ+mEvtHu2qiZzQjj
 gQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868628; x=1777473428;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+y8dDOcL2TGY8RwRMF+ZJao4Mtt36PyCZPoOztGf8ZY=;
 b=gexBL6rf0x5BrWOf+hIZ0uKUl6zhPdEMoLLzVnrELlGeAGjthnhH1c946gatUXfcEh
 kjHWj4OZSsbXG38X2D5W0LTaktsSSaHgabUdypWfxyIF9Le5Z5cUHW5ooOIsvOE3ocAb
 VKsTEC8bbErX4h7jgufECRkt2eWQkcXvp2AluvCnCrhn5IAxHdQ1qQTjJMDCtyS2V3Nu
 /5szmpJQIz8Ka7f2I0QRx2NV6Rt6i1yHlBgxdAykLcRRjKhCtS068LvgSsZLoSYWwVIn
 KvBREnPGSZlwo4nYrRzOJyMH0up9LAMskds3N4MpFSUaKOEge/ZqP6I6MPSiN1+i/boM
 iTMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2mviOpx4LYLSDJ7ACb8kcUbGtRn147HKuEUJHIxpYuRhiQ/krsFWMFzOOvoHGXO+3d+439+qkksxw@nongnu.org
X-Gm-Message-State: AOJu0YwzRvaCU+WQaxhMAHFkd/9mWZhIFEBS6b4K5P61ikg0zYuXKX4T
 X6Lwm1UwJTzh/S2YQ0jNQfdZmHAsc83sSIAmHUYc/3mbeNmt9BcsbZnRVN0CRBDYGNW+YAlD9I+
 DmVCIzpDUyLn0oMA0uiFdjybKU7lAeRHCKFY2wAu/95PuMa102PkMJy63
X-Gm-Gg: AeBDieuyzwp2kpwTMcQMWcxuFoCezHzlqDDvyQ2zXD/ZqiLJBmC421NYexxPOS/1Mot
 rqvNKIsy8LxySrEkibGzA6gcfOxQ7+zEmKxMgpH13nz9qLwGA+LSuPd5J8v1K1an8WNOfFWL1Ja
 fOf1KGGS4gue3iHpGazBuToaanUTnw/RZ9WFQi4ivh95TJV6e45Eo4xFTr1SHdVl9i2o74W6faE
 HASuGZqgL4/ise4EESzf/LdwGykUxKNZh53tdNQxVgBQfhT9pZTIaff+qD63FF1i8D/Q87PQZOP
 AkyR28Sy1cBN3U8UQghzJLvAzJt25S7MlJ3jpSXfFF/j0InTrf/NTHDxCTG69Uld7Kt+KdX7jqf
 iB1OoynKar65p8UpJ+D8H2XhaKlF7Fn14zB8IWdqw1ZRZ/gMTtyWe2JZNZA==
X-Received: by 2002:a05:620a:28d1:b0:8d7:3f45:b95f with SMTP id
 af79cd13be357-8e78fb18dc2mr3122869585a.16.1776868627322; 
 Wed, 22 Apr 2026 07:37:07 -0700 (PDT)
X-Received: by 2002:a05:620a:28d1:b0:8d7:3f45:b95f with SMTP id
 af79cd13be357-8e78fb18dc2mr3122858685a.16.1776868626332; 
 Wed, 22 Apr 2026 07:37:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d98c15a9sm1520123685a.43.2026.04.22.07.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:37:05 -0700 (PDT)
Date: Wed, 22 Apr 2026 10:37:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
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
Message-ID: <aejdEO2CXg-QuGcL@x1.local>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-7-jamin_lin@aspeedtech.com>
 <3ee36a34-573e-48aa-91e3-9140244717f0@kaod.org>
 <aeJNdLTRSZQiEiP_@x1.local>
 <TYPPR06MB8206C244CD249505E6B543F8FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <aeYrfQuAsEaOpH_O@x1.local>
 <TYPPR06MB82066A191FB2B0AD05F7C295FC2D2@TYPPR06MB8206.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYPPR06MB82066A191FB2B0AD05F7C295FC2D2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Wed, Apr 22, 2026 at 09:21:55AM +0000, Jamin Lin wrote:
> Hi Peter, Cédric and Philippe
> 
> > Subject: Re: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
> > 64-bit
> > 
> > On Mon, Apr 20, 2026 at 05:56:11AM +0000, Jamin Lin wrote:
> > > Hi Peter, Philippe, Cédric
> > 
> > Hi, Jamin,
> > 
> > [...]
> > 
> > > > > > @@ -2501,8 +2515,12 @@ const VMStateDescription vmstate_ehci = {
> > > > > >           /* schedule state */
> > > > > >           VMSTATE_UINT32(astate, EHCIState),
> > > > > >           VMSTATE_UINT32(pstate, EHCIState),
> > > > > > -        VMSTATE_UINT32(a_fetch_addr, EHCIState),
> > > > > > -        VMSTATE_UINT32(p_fetch_addr, EHCIState),
> > > > > > +        VMSTATE_UINT32_TEST(a_fetch_addr_pre_v3, EHCIState,
> > > > > > +                            ehci_core_is_before_version_3),
> > > > > > +        VMSTATE_UINT32_TEST(p_fetch_addr_pre_v3, EHCIState,
> > > > > > +                            ehci_core_is_before_version_3),
> > > > > > +        VMSTATE_UINT64_V(a_fetch_addr, EHCIState, 3),
> > > > > > +        VMSTATE_UINT64_V(p_fetch_addr, EHCIState, 3),
> > > >
> > > > TL;DR: I feel like we still need machine type compat properties.
> > > >
> > >
> > > I don't understand this: Could you please describe it in more detail?
> > 
> > See hw/core/machine.c and entries added into hw_compat_*[] arrays.  IIUC,
> > if this is an important device and if we want to guarantee bidirectional
> > migration (I'll explain later), then we should stick with machine compat
> > properties.
> > 
> > >
> > > > Details:
> > > >
> > > > When a v2 stream arrives, two _TEST()s will do the loading, then
> > > > post_load() extend it to 64bits, looks fine.
> > > >
> > > > When a v3 stream arrives, two _TEST()s got skipped then latter two take
> > effect.
> > > > post_load() skips.  Looks fine.
> > > >
> > > > When migrating to another QEMU, due to the fact saving vmstates
> > > > always take vmsd's version declared (3), I don't see how it can
> > > > migrate back to a v2 stream; it didn't know about v3.
> > > >
> > > > Jiamin, have you tested migrating from a new QEMU binary back to
> > > > another old one?  For upstream and serious devices, we need to
> > > > guarantee bi-directional migrations, back and forth.
> > > >
> > >
> > > Sorry, I am not familiar with the design of QEMU migration, and I don't know
> > how to test it.
> > > I added these hook functions based on Philippe's suggestion and review.
> > > Could you tell me how to test migration to ensure both version 3 and version
> > 2 are workable?
> > 
> > Since this patch already modified VMSDs, I believe migration test should have
> > been carried out at the very minimum..  Logically if vmsd versioning is used,
> > we should also have tested forward migrations, because that's only for that.
> > 
> > What I'm talking about is I think backward migration will fail.
> > 
> > Forward migration describes the case when a VM hosted by an old QEMU
> > binary (e.g. QEMU v10.2.0) is migrated to a new QEMU (e.g., after this patch
> > applied on top of master).
> > 
> > Backward migration describes the case when a VM hosted by a new QEMU
> > binary (e.g., after this patch applied on top of master) is migrated back to an
> > old QEMU binary (e.g. QEMU v10.2.0).
> > 
> > For different devices, we should allow different level of support on migration.
> > Any device that may be important to either upstream QEMU or downstreams
> > should better allow bi-directional migration.  In this case we need to use
> > machine compat properties I mentioned.  I'm not yet sure where EHCI
> > controller falls e.g. v.s. XHCI.. when not sure, we can also just stick with
> > machine compat properties to be on the safe side.
> > 
> > For more info, you can also refer to:
> > 
> > https://www.qemu.org/docs/master/devel/migration/compatibility.html
> > 
> > Thanks,
> > 
> > --
> > Peter Xu
> Thanks for your support and the detailed explanation.
> Following Cédric’s comments, I now understand how to properly test migration. With the changes below, both forward and backward migration tests pass.
> Could you please review these changes, or would you prefer that I resend them as v4?

Per what I read on Phil's reply on the cover letter, he prefers you to
resend anyway.  Better do it.  Comments inline.

> 
> Thanks again for your guidance and support.
> 
> Jamin
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 310183bbc4..bd165c793c 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -264,6 +264,7 @@ struct EHCIState {
>      uint32_t maxframes;
>      bool caps_64bit_addr;
>      uint32_t ctrldssegment_default;
> +    bool migrate_fetch_addr_64bit;
>  
>      /*
>       *  EHCI spec version 1.0 Section 2.3
> @@ -321,7 +322,9 @@ struct EHCIState {
>      DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \
>      DEFINE_PROP_BOOL("caps-64bit-addr", _state, ehci.caps_64bit_addr, false), \
>      DEFINE_PROP_UINT32("ctrldssegment-default", _state, \
> -                       ehci.ctrldssegment_default, 0)
> +                       ehci.ctrldssegment_default, 0), \
> +    DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
> +                     ehci.migrate_fetch_addr_64bit, true)

The diff looks a bit weird; this chunk is not present in hw/usb/hcd-ehci.h
in master branch, but maybe this series touched it.. in that case it's
fine.

>  
>  extern const VMStateDescription vmstate_ehci;
>  
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0aa77a57e9..e77400c7ab 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,8 @@
>  GlobalProperty hw_compat_10_2[] = {
>      { "scsi-block", "migrate-pr", "off" },
>      { "isa-cirrus-vga", "global-vmstate", "true" },
> +    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
> +    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },

I'm still looking at master branch, vmstate_ehci is referenced in both
"ehci-sysbus" (vmstate_ehci_sysbus) and "ehci" (vmstate_ehci_pci).  Here
you used different names, I'm not sure if it's relevant to your other
patches, please double check.

Also if there're two drivers involved, IIUC we should need to add two bool
properties.. I only saw one above.  Again, not sure if it's relevant to
what your prior patch did, but please double check.

>  };
>  const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
>  
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 983b1731f9..87528ddc02 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -2469,6 +2469,9 @@ static int usb_ehci_pre_save(void *opaque)
>      ehci->last_run_ns -= (ehci->frindex - new_frindex) * UFRAME_TIMER_NS;
>      ehci->frindex = new_frindex;
>  
> +    ehci->a_fetch_addr_pre_v3 = ehci->a_fetch_addr;
> +    ehci->p_fetch_addr_pre_v3 = ehci->p_fetch_addr;

This looks fine if you always prepare the 32bit versions of the addr, but
it can also be put under a "if (!ehci_fetch_addr_64_needed(...))".  Not a
big deal.

> +
>      return 0;
>  }
>  
> @@ -2489,10 +2492,8 @@ static int usb_ehci_post_load(void *opaque, int version_id)
>          }
>      }
>  
> -    if (version_id < 3) {
> -        s->a_fetch_addr = s->a_fetch_addr_pre_v3;
> -        s->p_fetch_addr = s->p_fetch_addr_pre_v3;
> -    }
> +    s->a_fetch_addr = s->a_fetch_addr_pre_v3;
> +    s->p_fetch_addr = s->p_fetch_addr_pre_v3;

This one looks risky, it will also run on new machine types, I think a "if
(!ehci_fetch_addr_64_needed(...))" is required here (unlike the pre_save),
otherwise I suspect you may overwrite the 64bits with 32bits after
migration.  It may explode when high 32bits have something nonzero?

>  
>      return 0;
>  }
> @@ -2523,14 +2524,29 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
>      }
>  }
>  
> -static bool ehci_core_is_before_version_3(void *opaque, int version_id)
> +static bool ehci_fetch_addr_64_needed(void *opaque)
>  {
> -    return version_id < 3;
> +    EHCIState *s = opaque;
> +
> +    return s->migrate_fetch_addr_64bit;
>  }

Yes this is the traditional way.

>  
> +static const VMStateDescription vmstate_ehci_fetch_addr_64 = {
> +    .name = "ehci-core/fetch-addr64",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = ehci_fetch_addr_64_needed,
> +    .fields = (const VMStateField[]) {
> +        /* mmio registers */
> +        VMSTATE_UINT64(a_fetch_addr, EHCIState),
> +        VMSTATE_UINT64(p_fetch_addr, EHCIState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_ehci = {
>      .name        = "ehci-core",
> -    .version_id  = 3,
> +    .version_id  = 2,
>      .minimum_version_id  = 1,
>      .pre_save    = usb_ehci_pre_save,
>      .post_load   = usb_ehci_post_load,
> @@ -2559,14 +2575,14 @@ const VMStateDescription vmstate_ehci = {
>          /* schedule state */
>          VMSTATE_UINT32(astate, EHCIState),
>          VMSTATE_UINT32(pstate, EHCIState),
> -        VMSTATE_UINT32_TEST(a_fetch_addr_pre_v3, EHCIState,
> -                            ehci_core_is_before_version_3),
> -        VMSTATE_UINT32_TEST(p_fetch_addr_pre_v3, EHCIState,
> -                            ehci_core_is_before_version_3),
> -        VMSTATE_UINT64_V(a_fetch_addr, EHCIState, 3),
> -        VMSTATE_UINT64_V(p_fetch_addr, EHCIState, 3),
> +        VMSTATE_UINT32(a_fetch_addr_pre_v3, EHCIState),
> +        VMSTATE_UINT32(p_fetch_addr_pre_v3, EHCIState),
>          VMSTATE_END_OF_LIST()
> -    }
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_ehci_fetch_addr_64,

IMHO you don't need to make it a subsection, you can use
VMSTATE_UINT64_TEST().

Similarly you can also use VMSTATE_UINT32_TEST() to only migrate 32bit
versions in old machine types.

With those you can keep them together and add a comment, may look better
than subsections where you split them apart, it'll be harder to follow in
the future.

Thanks,

> +        NULL,
> +    },
>  };
>  
>  void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)

-- 
Peter Xu


