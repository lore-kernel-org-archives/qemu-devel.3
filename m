Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AF5CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ1g8-0000ZT-93; Mon, 15 Jun 2026 03:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZ1g6-0000Z4-Oy
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZ1g5-0002LV-9d
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 03:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781508252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQJxSgMlGu17ON/GlwS1pzPWXIU9Y1/o+lMyuG1HutU=;
 b=OtNd4fRZG//sSjHlTAPk4pz5wX+VbVBK1Hy4+0xB8zjBa/2sc/ENkZX8+EVHvYgnuHS7c5
 Ap9KIHTW5lbEUx2UggphtCT9PgRncet4aeKLHmHUDl1kqb6cx/8TKZAmuZnkcRnjRgaoC0
 CZDon875ybplVp3Diy2iAQGQR9vp5WE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Um10jYxcOd2-hvfd_HXF1Q-1; Mon, 15 Jun 2026 03:24:09 -0400
X-MC-Unique: Um10jYxcOd2-hvfd_HXF1Q-1
X-Mimecast-MFC-AGG-ID: Um10jYxcOd2-hvfd_HXF1Q_1781508248
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eec2badc4so1646904f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781508248; x=1782113048; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EQJxSgMlGu17ON/GlwS1pzPWXIU9Y1/o+lMyuG1HutU=;
 b=fN+Kx9gBzz61DsUAg/dW9eahMIbL845Q/FU6r0mL7rTZw+f4QnN3e0JmEuwUtqUTAR
 V7hDkM4eQ2l/7clrNrt7o5RZ+EnYellb7wsfoMHwbEgVE3kPdJlQGPEAlnL+Mv7x647G
 lnv8Mkjk6Kr1CYm4wevUdRQlMu4w7jPhDCrHV6pXKX+/+iz4vXFE1flWm7909872C+70
 FpJ96UvezqwNRQCtTgD0le2pugIGxlFmCDuMKqHmDm6YL+lX5Md6SjBvVUrC9QaOh6Wa
 6Sq+6qi01D2LbEv8fiH3Wr0ZAOa/PqokXbZJTREA30Pt/A3y1IFquDXe/qFlggsxlCnv
 FfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781508248; x=1782113048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQJxSgMlGu17ON/GlwS1pzPWXIU9Y1/o+lMyuG1HutU=;
 b=WYCClUpFlO2Qdd3uXWnpFTEtLzTaOywnsiS7lRh5YQm1GWiRTHKqYwBv+LCoE12csP
 iP6AaqhAZclyEC1AKhU+PCVoUeykWCA4B/TOl4f//VDs6goWGbDt6EzLigzz8jCdpsPY
 IVZRchr+6ktZ0hgAYK9IjGiRVGD42eAdzuOzAq/3+JKv5xZvGFfn28RTnXdsxIo4SI/D
 0Jf8ZnLSaGnDfKsZg6mV0e73Yo4f3dFOnQpvxt6Ptx+QGj/S15wmjRcWAdkLUIRz2ki5
 QXraQ6CdBfheAFWwz2U0WRpLzoPPQ31ivKt3VZ3PcmUsvnkeGgS5OpRWyjp+zKoJ3wV3
 HAsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zYjfugKpMHgDVF+LPu+HjfFKRYQanfyBDKXdl1L7hKguAGuf15SfA+RbpSeqHWWAl63+F/mB1OkVN@nongnu.org
X-Gm-Message-State: AOJu0YzRSwg3Zy2BfvbelCkfot4Oo//cvlBPTiz3ucTi1EiFra4EdP+q
 MRLM+e6xF8uDx1UgZPEuzTFvZqd5Cuy8xEjDnkMARqkIyofGy5/C9WGKW7oklIZ1OMx59xq8x5G
 m5NTzZWMttZHJXhTAXZSlhmJhTBgvGGsCjbJ2Mi5Ge7QOIXlfI/JmxpOe
X-Gm-Gg: Acq92OEMZXYpW384GT0HwRBSTMiV1baJoA6p37Lu/beXt3Zoq1B5J1YIzwctvxxyqTd
 Rh4nSS0yeygTbYEgzlxw3M+wxSsJ/F32LJzXdUc6Psnrd0kjcE/6qw65VSUN/B4yqaQppZy02BB
 CMVdJXsekK21BIRAoBXxOY3GTmPPSb0jD7fkS++kCZ7W/AW6dceFcFFFx+fpAkWlnjH4XFrhOBj
 lZ8Rnj5grdLoejBr6tXwRp4MyyVs5Ma2xWpT22cR+SaW8L48MW4N9bvMKB8QeOZKospaw4RTeFY
 uK+ve5ICLYGiZ4sLaNIO51P9rn9RWfN4c7bbF3/CY2DRVa77k4GmW7eW+7sDIeW3jOFOeJ6L+Kp
 hECIBAEmMnAk0T21ttCTU+6k0j02mtsZWKzFNyAlyTKY=
X-Received: by 2002:a05:6000:2684:b0:45e:ea3a:47e8 with SMTP id
 ffacd0b85a97d-460769303aemr12818186f8f.24.1781508247886; 
 Mon, 15 Jun 2026 00:24:07 -0700 (PDT)
X-Received: by 2002:a05:6000:2684:b0:45e:ea3a:47e8 with SMTP id
 ffacd0b85a97d-460769303aemr12818127f8f.24.1781508247369; 
 Mon, 15 Jun 2026 00:24:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm33609422f8f.5.2026.06.15.00.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:24:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 03:24:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 berrange@redhat.com, david@kernel.org, alex@shazbot.org,
 clg@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 phrdina@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
Message-ID: <20260615025222-mutt-send-email-mst@kernel.org>
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
 <CAFEAcA-TgP_BM0WQo3rysZmvhNN17Gc_nrSYB6pXn-mvs5w13g@mail.gmail.com>
 <123d9e80-d731-42c7-81cc-71de47bb13d3@linaro.org>
 <20260614084004-mutt-send-email-mst@kernel.org>
 <02d809b0-6396-40dd-a2c5-866028b7cc4d@linaro.org>
 <20260614131704-mutt-send-email-mst@kernel.org>
 <52c2af6c-f494-4e30-bac6-bde2aaf48931@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c2af6c-f494-4e30-bac6-bde2aaf48931@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Jun 14, 2026 at 06:41:57PM -0700, Richard Henderson wrote:
> On 6/14/26 10:22, Michael S. Tsirkin wrote:
> > On Sun, Jun 14, 2026 at 09:45:51AM -0700, Richard Henderson wrote:
> > > On 6/14/26 08:13, Michael S. Tsirkin wrote:
> > > > Yes, I think it does work because we use -fno-strict-aliasing.
> > > > For bigger sizes we'll need packed because the addresses
> > > > could be unaligned.
> > > ...
> > > > For most host/guest pairs things simply work even for unaligned.
> > > > 
> > > > And yes, guest drivers do do this.
> > > > 
> > > > On classical pci, there are no transactions as such and
> > > > an unaligned access will be split anyway.
> > > 
> > > I'm saying, if you're talking about pass-through to real devices, that won't
> > > work. For instance, AArch64 will trap unaligned accesses to Device memory.
> > 
> > Presumably, AArch64 drivers don't do unaligned at all then?
> 
> Yes.
> 
> > > You need to actually handle unaligned.  Perhaps something like
> > > 
> > >      /* Find unit to fit size and alignment of dst */
> > >      uintptr_t test = (uintptr_t)dst | size;
> > >      uintptr_t lsb = test & -test;
> > > 
> > >      switch (lsb) {
> > >      case 1:   // loop over uint8_t
> > >      case 2:   // loop over uint16_t
> > >      case 4:   // loop over uint32_t
> > >      default:  // loop over uint64_t
> > >      }
> > > 
> > > with the expectation that normally we'll have aligned addresses and size
> > > such that the loop will iterate once.

OK though it is worth looking at assembly and checking how to make it ooptimal.

I don't get why we have default here either, for that
we really should use memcpy for a better perf,
I think VCPUs can't initiate MMIO transactions >8 bytes.


> > > 
> > > 
> > > r~
> > 
> > And ifdef for arches without unaligned support?
> 
> No ifdef.  All accesses produced by the above are aligned.
> 
> 
> r~

but I don't think it's a good idea to have this on x86.

x86 does not need this pile of branches, has a popular closed
source guest we are all familiar with, famous for
it's rich ecosystem of drivers) and it's just
barely possible that an x86 guest on x86 host could
work as long as we do not break transaction boundaries.

Is 

#ifdef HOST_X86_64
#define QEMU_UNALIGNED 1
#else
#define QEMU_UNALIGNED 0
#endif

And then if (QEMU_UNALIGNED) a big deal really?





-- 
MST


