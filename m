Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFC9CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHegp-0007SZ-LF; Fri, 16 Oct 2026 05:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1xHegU-0007Ri-GC; Fri, 16 Oct 2026 05:57:08 -0400
Received: from sender6-of-o54.zoho.com ([165.173.180.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1xHegQ-0000Wf-Nk; Fri, 16 Oct 2026 05:57:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1792144576; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B6Eul7ZIGHe/GzN4pDyEj+HBZR2lWEqGz53THOKxS+hzjT4deYsT8xQjYMRjMA3KiphrrgNpmItBjtaWc26TgqYPP9IuQmh7iRKMYxW7MLO8o1snOB0XKMbJpDADL4yMzDdsxVDFuUygn8o9Qi1QfqF9duVvudpdq3RDQfrLDWM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792144576;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=c0WsNYJz56dq7mul1SOpEcLPMZo+1/7AwrdNNoV+PGc=; 
 b=CHQtfSG1EeofnCgRkdJ3C+aFfBJFPaq/PC3KGqQjrcmL+UVIei7s2Q3bT9zeho0ElYJVx1Lz2jpe0Y7MZMdaM1knFXenwceUdCs8xU3PdniQfPZirmhrgQr8sul8soeTB2+Y794BY3tyqPCLYeFyWDeNfoi7cieDHxvXkojubO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792144576; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=c0WsNYJz56dq7mul1SOpEcLPMZo+1/7AwrdNNoV+PGc=;
 b=l3e8jfwzPXdf2UX3CH82Q7TbXWX/VML/hHkDB0bqWXDWf9YaqWwHlloonEJZxXNw
 YPvyJ2S5M9lekKeSZ2LnuB2HBgxtieWWm9BkbtWnEuG6EnaTJFgPDFFcosLWIIYm/dK
 TY9AG5s9ZxeF+p6MLHBjA6nJH2tWvneBd3PF1nvI=
Received: by smtp.zohomail.com with SMTPS id 1792144572614344.79024324113675; 
 Fri, 16 Oct 2026 02:56:12 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:56:05 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-devel@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 11/14] target/arm/mshv: add vCPU run loop
Message-ID: <20261016-adamant-modest-caterpillar-4dadbb@anirudhrb>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-11-aefe5e76a0e3@linux.microsoft.com>
 <CAFEAcA9xPn2MRjC_d9Gdb=d4-GHmcXPpsLP+WUOgCUhaPbZ2BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9xPn2MRjC_d9Gdb=d4-GHmcXPpsLP+WUOgCUhaPbZ2BQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.122.61
X-ZohoMailClient: External
Received-SPF: pass client-ip=165.173.180.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender6-of-o54.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Oct 13, 2026 at 05:50:03PM +0100, Peter Maydell wrote:
> On Thu, 1 Oct 2026 at 11:52, Aastha Rawat
> <aastharawat@linux.microsoft.com> wrote:
> >
> > From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> >
> > Add the main vCPU run loop for MSHV using the MSHV_RUN_VP_IOCTL.
> >
> > Handle MMIO exits by emulating the instruction using the syndrome
> > information from ESR_EL2.
> >
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  include/hw/hyperv/hvgdk_mini.h |  44 +++++++++++++++++
> >  target/arm/mshv/mshv-all.c     | 107 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 151 insertions(+)
> >
> > diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> > index 33c9e4f3e0..53dc58813e 100644
> > --- a/include/hw/hyperv/hvgdk_mini.h
> > +++ b/include/hw/hyperv/hvgdk_mini.h
> > @@ -896,6 +896,50 @@ struct hv_x64_memory_intercept_message {
> >      uint8_t instruction_bytes[16];
> >  } QEMU_PACKED;
> >
> > +union hv_arm64_vp_execution_state {
> > +    uint16_t as_uint16;
> > +    struct {
> > +        uint16_t cpl:2;
> > +        uint16_t debug_active:1;
> > +        uint16_t interruption_pending:1;
> > +        uint16_t vtl:4;
> > +        uint16_t virtualization_fault_active:1;
> > +        uint16_t reserved:7;
> > +    };
> > +};
> 
> This is an mshv specific file, but I would still recommend against
> bitfields-in-a-union as generally bad style.

Hi Peter,

We source these definitions pretty much verbatim from the hypervisor
headers. Having them as close as possible to the hypervisor headers
would it make it easier to maintain. We do make some cosmetic changes
w.r.t naming style and QEMU_PACKED instead of __packed__ etc but that's
about it.

Alsoe, there are existing definitions in this file using the same style.

Thanks,
Anirudh.


