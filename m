Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD60C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc2H2-0004xm-Cz; Wed, 16 Jul 2025 09:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uc2Cb-00024h-TC
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uc2CZ-00087w-1Z
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752672577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YipYrYYvZ7mwDxMeTCXCFPfBlcFx/++daPFAeztCEPI=;
 b=Gr2o9kh/4HozngW+gAi1bcMTDSp5Cuqo7kC7mANz+AV3aScVr2pfsmVyvwVV1NjHSvvZ8x
 +3Ge3iMVBs9Ju01S6SBq+8SGd38tRI0jfiP5mjedx+ZVSx6PKcKcxROvQK+uiebSnsRBGP
 ZcYyHdKa76W7xhAQqpuEoMdPN7J7X8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-xy79ObSJPVm-aUYQYXtQIQ-1; Wed, 16 Jul 2025 09:29:33 -0400
X-MC-Unique: xy79ObSJPVm-aUYQYXtQIQ-1
X-Mimecast-MFC-AGG-ID: xy79ObSJPVm-aUYQYXtQIQ_1752672572
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4560b81ff9eso27036945e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 06:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752672572; x=1753277372;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YipYrYYvZ7mwDxMeTCXCFPfBlcFx/++daPFAeztCEPI=;
 b=pfoFaNfoiKe64XiJj85NUP2tYLaNgX3ZC3S1DFyKu2UEzd6XYjHdNtkJB1KC+1DK5s
 LiNeG9EJP+Ygf51Hho0pIZsyR5q3BM2gwyJGV96oZ4B5Ed6Jg3U8qpdy55OE4PS25j8Q
 hnJ93Ce6f9kSPC8pHCX7YvIFIqBqGXIsswI2mp0iSodEGVuTLgHiBefdzOIoFshCUUR/
 XsRGj1A9GSwAbV7JRme7AnF8uRmWdH+vaLcbJvXMmSR99h7tqt70+vdZAp0LHpb2zdIE
 HzTjEtN0uRYgeIwOV32SX0dyHnSyMdyQ/AYIriuEDHTWdxjhAJwQSPUSkS9avQV/Rdzc
 nBTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWBvQaGmEYXu0D+vdW0x7HY+JmlS8aA8iKF20z3jrtmKcwZBIp48ci/IPIKW0c7nV+bHInk/RAuCqy@nongnu.org
X-Gm-Message-State: AOJu0YzQPBD8MZC7niJXslSQ+u21/asIY/fHI+QPxMwcQG72Qhs/dgOa
 C7W0B/Mmde1ejiFQ2kvmasFlCH/V+D0+QwpWkVLJAyIjNXdG8gvAkJXpNeulM18rj5AcDaR8X8M
 6ucCJVlOg6GZbZaMoXCWNrnFsuq9J5WHWA2eLESvlEDWgvb0UOAYVuNot
X-Gm-Gg: ASbGncsvB1eimWC4fqjyN8/73XDJLJ6nfFZuPEn8VBTVmYZqqmgaKdUgvX9vY3b408T
 8SDQNrWn9fxZdlrO/exwWh86IZyPPfJ6ujpCkv91iP8nPMBn9nA99Lp2vv1uVR6iY7EigcWGBL5
 aA8qrrjg0YriObBkGAHyALv7CvJ56CFwnvbXXI3QIN20im+MT6RV1OL/1b4NTosFHV+RivWgBRS
 RnJcXKTfiIGtuhkcWSTfOrjJvvRiPudEx5KvpbKquIVSRBrSwk4A3e9/Fd8Lc3ArRpbUpDDNRUJ
 BI/ZvUYsNi+87GXUBtKrldCfBt/tJafk
X-Received: by 2002:a05:600c:1906:b0:455:e858:cd04 with SMTP id
 5b1f17b1804b1-4562e037499mr27211825e9.25.1752672572117; 
 Wed, 16 Jul 2025 06:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgAv2xF1oTX9GmVsWJ1L6cPR4Fl51c7da2yUglIZjs7GsD6v7pq3tXNP0XGkeqy7HJYD75wA==
X-Received: by 2002:a05:600c:1906:b0:455:e858:cd04 with SMTP id
 5b1f17b1804b1-4562e037499mr27211485e9.25.1752672571711; 
 Wed, 16 Jul 2025 06:29:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5f16a6016sm15992193f8f.69.2025.07.16.06.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 06:29:31 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:29:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, eduardo@habkost.net,
 richard.henderson@linaro.org, alejandro.j.jimenez@oracle.com,
 Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
Message-ID: <20250716092916-mutt-send-email-mst@kernel.org>
References: <20250716073145.915-1-sarunkod@amd.com>
 <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
 <a184b8d5-4620-4b21-99c4-0fc859647d14@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a184b8d5-4620-4b21-99c4-0fc859647d14@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 16, 2025 at 06:26:37PM +0530, Sairaj Kodilkar wrote:
> 
> 
> On 7/16/2025 6:07 PM, Philippe Mathieu-Daudé wrote:
> > On 16/7/25 09:31, Sairaj Kodilkar wrote:
> > > This series provides few cleanups and fixes for the amd iommu
> > > 
> > > The patches are based on top of 56c6e249b698 (v10.0.0-rc3) and
> > > Alejandro's
> > > DMA remapping series [1].
> > 
> > 56c6e249b698 is 4 months old, we are about to release v10.1.0-rc0.
> > 
> > What is the point of posting obsolete code?
> > 
> > I'm not going to review further.
> 
> Hey Philippe,
> 
> sorry. I missed to add it in cover letter. Intention is to get feedback
> on this series. Since this is on top of Alejandro's series, I will
> rebase it once his series gets merged.
> 
> Regards
> Sairaj

Merged now, go ahead and rebase.

> > 
> > Regards,
> > 
> > Phil.
> > 
> > > [1] https://lore.kernel.org/all/20250502021605.1795985-1-
> > > alejandro.j.jimenez@oracle.com/
> > > 
> > > The series is uploaded on github:
> > > https://github.com/AMDESE/qemu-iommu/tree/sarunkod/alej%2Bcleanup-v1
> > > 
> > > Sairaj Kodilkar (7):
> > >    hw/i386/amd_iommu: Fix MMIO register write tracing
> > >    hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
> > >    hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
> > >    hw/i386/amd_iommu: Support MMIO writes to the status register
> > >    hw/i386/amd_iommu: Fix event log generation
> > >    hw/i386/amd_iommu: Fix handling device on buses != 0
> > >    hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
> > > 
> > >   hw/i386/amd_iommu.c | 217 ++++++++++++++++++++++++++++----------------
> > >   hw/i386/amd_iommu.h |   9 +-
> > >   2 files changed, 146 insertions(+), 80 deletions(-)
> > > 
> > 


