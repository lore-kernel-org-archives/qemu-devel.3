Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05079C5516F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 06:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqlo9-0006eh-1H; Mon, 03 Aug 2026 02:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqlo0-0006YU-0o
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 02:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqlny-0007Tb-Di
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 02:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785737140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjB9eQoDa7qOaNV1tFx9eIBTsZh/2RyZXpMuR6w5s88=;
 b=WwWsugM1S7nAKTsqEUtDmqYLGSPRcrNNCzoDwyiiSFEk65NkO2uJXlM9MikmJihc5Tegnc
 BxRjELwW4M7BdfWXAFFMaso5piTjbr0U9sL9uh3Gey4kZzeLP2EFQ52AovotGnUAAVDuG9
 xBTMTfia4eYMpFnjdRBET2EW91Qpo9w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-DQOEp1aAM6ecyDokVx6Wzg-1; Mon, 03 Aug 2026 02:05:38 -0400
X-MC-Unique: DQOEp1aAM6ecyDokVx6Wzg-1
X-Mimecast-MFC-AGG-ID: DQOEp1aAM6ecyDokVx6Wzg_1785737138
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-496bbcf7d1eso11318725e9.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 23:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785737138; x=1786341938; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kjB9eQoDa7qOaNV1tFx9eIBTsZh/2RyZXpMuR6w5s88=;
 b=SGrWx3R1K0B/RGcCSBXmMa4OjjTQwuMNyW3cG9Lok1HAh6BcrmBp5IryclXZ3HapPV
 jo4KnvzH9TKJ/C5qPO9WMwXCjhkGCcbNO+Xa3C7/QCLzEqzf45bg3zxFr4Y05UPeBSG4
 AdjzxA03HFfAuO0CpLAXOXMM4kqdd7p4msMX7ht2C27pghVZfudHJf9P4bS2GFmpvFDQ
 A4WjILnZBppFCxLonX7RPR0/eW58VHlQBK4Epv9FbxK9P0KfsvUgUE+9t8jHxJGaJDFD
 OcAU8w1cI42YZ22DFkFjM6itneC25Z/GMXr/vxr7LDFwABiDW5239m+KnEi1NSEWvRmr
 HGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785737138; x=1786341938;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kjB9eQoDa7qOaNV1tFx9eIBTsZh/2RyZXpMuR6w5s88=;
 b=MjdCsGJiX9Xs/N1FHsEQPEgi4WwL3Z5sWqRgTndoiyqiWfaOxlnjd8I3jojH5TfYED
 8TkXX/kh4gC5+yLawAlkpGpAC/j+knVFeYLcgMU7dlzx2z7s4ajrLP4jwrtVDI3jPxUW
 XwsLLZRjxvfYFkLijV+0GlZf6lETsqcfddp6u7yR7NveIFZVNaVgZ/3L04zkv0Xj5t2x
 Jd2tj11NDXcl82/si1kb2s12Uq2LXpnitfwk/HVzEQVTY+9/NDTv6vhN12qR27VGueob
 +eByOHzZV67U4mdGlY1Hxroz4lQlsWh8Sy5AjWSWwE3igeOLlSpkkapCZJ6DqFhjXfCb
 nuqQ==
X-Gm-Message-State: AOJu0Yxi8h5aLkVKnAIYHZmHUC0Tp6FCQW3Z2KSHafQ2hJQl4O9st4to
 WoafF50/OzmsZhjCzWP02TcslC0cLNIF2eYldGQgXu4gCrTQEpkKUpvonMiwnBCFjpeZ+JXcQMK
 k4fxw/W8Xs69cirebjKKbzepfJJ2Kaud9l32NO4bVdV7ykzo0RV7eGalX
X-Gm-Gg: AR+sD12OGc3DxczxMS1TIDiIlMjUzkHGoQOLczlY6OWhhk1rRmhYR6Eh2YJqRXkGej8
 4TiuNObjcJSSPw3QJAKD3eXptd/4rirYx1fdljR/10wMkqlpLPXZmru/PWIcggYjU/AM8x8BTDb
 JNZdbWm0VysEj6jGsCummeLtef2NREFVxF2N6GRYBXa5GywBOYw0jLRbW8kkpAntXfzmG/czhJB
 pdLN/R0QWqbvH3kaa3PrFW/+EeOu0k0uB3sv4lsNtgf/NnuAIWmpgDPlVtZBXXDNMHF1kUw9dJK
 348ozGY2MztQwOYhiL7zb3bSlE/MhOzgBLTdOxIhBIXMqJQJxWjCZSi9Qync37/Z++Ck3M38qxN
 RobRh0lJTju7KhReG8F2ZRQ==
X-Received: by 2002:a05:600c:8b08:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4980c694e4amr218425925e9.19.1785737137676; 
 Sun, 02 Aug 2026 23:05:37 -0700 (PDT)
X-Received: by 2002:a05:600c:8b08:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4980c694e4amr218425065e9.19.1785737137228; 
 Sun, 02 Aug 2026 23:05:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807bad893sm165566985e9.3.2026.08.02.23.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 23:05:36 -0700 (PDT)
Date: Mon, 3 Aug 2026 02:05:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Message-ID: <20260803020520-mutt-send-email-mst@kernel.org>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
 <20260802145308-mutt-send-email-mst@kernel.org>
 <36e03eda2384213c5766e5940e2376aa6c50e6e5.camel@bull.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36e03eda2384213c5766e5940e2376aa6c50e6e5.camel@bull.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Mon, Aug 03, 2026 at 05:40:06AM +0000, Clément MATHIEU--DRIF wrote:
> 
> 
> On Sun, 2026-08-02 at 14:53 -0400, Michael S. Tsirkin wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> > 
> > 
> > On Sun, Aug 02, 2026 at 04:05:08PM +0000, Clément MATHIEU--DRIF wrote:
> > 
> > > SVM in Linux requires SMPWC as of 780dfed68862.
> > 
> > 
> > And what is 780dfed68862?
> 
> A commit in the linux tree, is there a dedicated tag for that?
> 
> Maybe "Link: link_to_github"?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=780dfed68862


> > 
> > 
> > > This is free in the
> > > current implementation as it is already in line with the expected
> > > behaviour.
> > > 
> > > Signed-off-by: Clement Mathieu--Drif <[clement.mathieu--drif@bull.com](mailto:clement.mathieu--drif@bull.com)>
> > > ---
> > >  hw/i386/intel_iommu.c          | 3 ++-
> > >  hw/i386/intel_iommu_internal.h | 1 +
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index 8245452d89..9f21622a4f 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -5108,7 +5108,8 @@ static void vtd_init(IntelIOMMUState *s)
> > >      }
> > > 
> > >      if (s->svm) {
> > > -        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
> > > +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
> > > +                   VTD_ECAP_SMPWCS;
> > >      }
> > > 
> > >      vtd_reset_caches(s);
> > > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > > index 924e91cb8a..df7a0efa6e 100644
> > > --- a/hw/i386/intel_iommu_internal.h
> > > +++ b/hw/i386/intel_iommu_internal.h
> > > @@ -202,6 +202,7 @@
> > >  #define VTD_ECAP_SMTS               (1ULL << 43)
> > >  #define VTD_ECAP_SSTS               (1ULL << 46)
> > >  #define VTD_ECAP_FSTS               (1ULL << 47)
> > > +#define VTD_ECAP_SMPWCS             (1ULL << 48)
> > > 
> > >  /* CAP_REG */
> > >  /* (offset >> 4) << 24 */
> > > --
> > > 2.54.0
> > 
> > 


