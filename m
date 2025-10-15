Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135BACCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8w0J-0007po-9T; Wed, 15 Oct 2025 03:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8w0F-0007oG-N5
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8w02-0002vh-QA
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 03:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760513556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=70hTOIeRjpAwkVONZ3uEgfzV1+pcXOwHMuO1qxxu1Q4=;
 b=KiQynibVxw418khspAL51q8ldvLZI6/BSTOI9JqlWuOKxbvdJ3n7hcz+0z7VhCCr4nT/tK
 Agm3U6l4raFx2sVPT5vfTYeWHr+VdUuqJ9WSMPCK6rovEY8bNnYkBW4mN5Obecq23XOUx6
 d3c8WTVccSdQr238pJsHmBD13RSEAzU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-qwdogm23NFCinJovblgoWA-1; Wed, 15 Oct 2025 03:32:34 -0400
X-MC-Unique: qwdogm23NFCinJovblgoWA-1
X-Mimecast-MFC-AGG-ID: qwdogm23NFCinJovblgoWA_1760513553
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-40fd1b17d2bso3675860f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 00:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760513553; x=1761118353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70hTOIeRjpAwkVONZ3uEgfzV1+pcXOwHMuO1qxxu1Q4=;
 b=h/Wc6iKo4txn05WZy2mUyyUvFdqalQjGMeZcHznz0W7WnRnfwmFAFaF1BYNMvCp8uT
 223xhpetM1fBHTW8nRA78OJvG9jcUgppZH2Zla+oAMT+3DQnnaCeg3CKUjFjVied2jEL
 ZrDqoElcfdt/QYb26gGw6jI8A8I5bcEEmJi3Nb+Zdc7JclOGSl3V2yBq9tj5WbhbPx+O
 tSXSYVhLVBGPAGFJrq2qshKCLpSlzdBXaniAsT59Icq3uSj4dnJbLu0gBBzuBeMd51eJ
 Wn/Uh3YnHOOewsnTplPQKzhJXpnD6zcItiyl5WPSgnDlqoWUMnmv76nMj7Cpxugu5+Rl
 QaFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8VPwMgJ0SsFwP8MOOuJCXEd3XdC8HTlpr3k+vhCB4G6IKgQ0Fcx7TLlgnltFCl5xIn4fdfZaOQW9r@nongnu.org
X-Gm-Message-State: AOJu0YxATq819ljbpbNEHtIVso0edLshelpS0uUaIbe0cCi52iQ1hbBW
 SBFaPOzySTof0y3VC1WrSvfXhyv6BQvKHm/JA4tskd4icp2Is+QfRxIuwfOvvh375n7N1AhEnvd
 D+BSqRnCxhcXtJKyrBeqDQEAO4SnbK2sAyOrVgO9b6BysPAVWI+5El/6j
X-Gm-Gg: ASbGnctmUuJXMAdG0bVhAv173hwyA6/vEZ3kXZb4//X4Dgbn8cxosiKLnmTg/Y7VazC
 r97ELC6uKBUqR0VCX3THcOcgZYZfGWPzpE5JTvBRSKDy/04ps3hBm8b1PP177arNBsrpsyW0Gws
 vPSADHvkam5W0xshA7yploatghG6urwzz0I9UDSI+O1OnaO7wgC9AEjZNucbrHQoc3j7B6LjvfK
 GDEy8LjMbOqLvVURFtzO74saFRgFUyd3LhEm8B2kIRIblclcoBVkNzKldVa5dxE0umM6N7+sdmo
 /Eu8Ky+NZiQiSoUOgtGXmYAlDBIRP97wpw==
X-Received: by 2002:a05:6000:2303:b0:3df:c5e3:55f8 with SMTP id
 ffacd0b85a97d-4266e7dfbeemr17659720f8f.54.1760513553434; 
 Wed, 15 Oct 2025 00:32:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh6+w1PykN6hpXnkRpvBsEorHcEf2Q2lklMTtbH+Omwyf5XhCAlqVh3zs2wJAC1e6aoGaoCA==
X-Received: by 2002:a05:6000:2303:b0:3df:c5e3:55f8 with SMTP id
 ffacd0b85a97d-4266e7dfbeemr17659693f8f.54.1760513552947; 
 Wed, 15 Oct 2025 00:32:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1284sm27180999f8f.45.2025.10.15.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 00:32:32 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:32:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, aik@amd.com
Subject: Re: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
Message-ID: <20251015032834-mutt-send-email-mst@kernel.org>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-2-sarunkod@amd.com>
 <20251013041059-mutt-send-email-mst@kernel.org>
 <6fa9b33c-31ff-43f6-8ab1-8d200c832c94@amd.com>
 <20251014050023-mutt-send-email-mst@kernel.org>
 <c585b4c2-5bde-4aff-a3b0-370bae5e9c0d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c585b4c2-5bde-4aff-a3b0-370bae5e9c0d@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 05:46:40PM -0400, Alejandro Jimenez wrote:
> 
> 
> On 10/14/25 5:02 AM, Michael S. Tsirkin wrote:
> > On Tue, Oct 14, 2025 at 11:13:51AM +0530, Sairaj Kodilkar wrote:
> > > 
> > > 
> > > On 10/13/2025 1:45 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Oct 13, 2025 at 10:30:45AM +0530, Sairaj Kodilkar wrote:
> > > > > The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
> > > > > for indexing into DTE. The problem is that before the guest started,
> > > > > all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
> > > > > kernel will do that later) so relying on the bus number is wrong.
> > > > > The immediate effect is emulated devices cannot do DMA when places on
> > > > > a bus other that 0.
> > > > > 
> > > > > Replace static array of address_space with hash table which uses devfn and
> > > > > PCIBus* for key as it is not going to change after the guest is booted.
> > > > I am curious whether this has any measureable impact on
> > > > performance.
> > > 
> > > I dont think it should have much performance impact, as guest usually has
> > > small number of devices attached to it and hash has O(1) average search cost
> > > when hash key function is good.
> > > 
> > > > 
> > > > > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > > > > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > > > > Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> > > > 
> > > > love the patch! yet something to improve:
> > > > 
> > > > > ---
> > > > >    hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
> > > > >    hw/i386/amd_iommu.h |   2 +-
> > > > >    2 files changed, 79 insertions(+), 57 deletions(-)
> > > > > 
> > > > > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > > > > index 378e0cb55eab..b194e3294dd7 100644
> > > > > --- a/hw/i386/amd_iommu.c
> > > > > +++ b/hw/i386/amd_iommu.c
> > > > > @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
> > > > >    };
> > > > >    struct AMDVIAddressSpace {
> > > > > -    uint8_t bus_num;            /* bus number                           */
> > > > > +    PCIBus *bus;                /* PCIBus (for bus number)              */
> > > > >        uint8_t devfn;              /* device function                      */
> > > > >        AMDVIState *iommu_state;    /* AMDVI - one per machine              */
> > > > >        MemoryRegion root;          /* AMDVI Root memory map region         */
> > > > > @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
> > > > >        AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
> > > > >    } AMDVIFaultReason;
> > > > > +typedef struct amdvi_as_key {
> > > > > +    PCIBus *bus;
> > > > > +    uint8_t devfn;
> > > > > +} amdvi_as_key;
> > > > > +
> > > > >    uint64_t amdvi_extended_feature_register(AMDVIState *s)
> > > > >    {
> > > > >        uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> > > > 
> > > > Pls fix structure and typedef names according to the QEMU
> > > > coding style. Thanks!
> > > > 
> > > 
> > > This is something I am struggling with, because the name
> > > `AMDVIASKey` does not offer readability.
> > 
> > AMDVIAsKey
> > 
> > 
> > Or you can update all code to use AmdVi and get AmdViAsKey if you prefer.
> > 
> > 
> > > Maybe we can come
> > > up with an alternate style which is readable and does not
> > > differ much from the current style.
> > > 
> > > @alejandro any suggestions ?
> > > 
> 
> I should have pointed out the CamelCase requirement for the typedef on v1.
> My initial reaction was: "do not use typedef" and go with the slightly
> longer 'struct amdvi_as_key' instead.

Sorry, that's a coding style violation too :)


	Typedefs
	--------

	Typedefs are used to eliminate the redundant 'struct' keyword, since type
	names have a different style than other identifiers ("CamelCase" versus
	"snake_case").  Each named struct type should have a CamelCase name and a
	corresponding typedef.

the only exceptions we make is when we import headers
from outside libraries to interface with them. 


> The style guide has a warning about
> typedefs (which doesn't necessarily apply here), but IMO still better to
> avoid it in this case were we are not really gaining much from it.

not sure which warning you mean, or why would not it apply.


> If I were to use a typedef I would use 'AMDViAsKey'. After all, the 'i' in
> AMD-Vi and 'd' in VT-d are lowercase ;)

Sounds good.

> But my opinion is to avoid the typedef altogether.


