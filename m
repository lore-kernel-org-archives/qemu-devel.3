Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4FDC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMy4-00053N-3q; Mon, 14 Jul 2025 13:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubLxR-00084T-4x
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubLxM-0002sJ-8C
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752510184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFgxmBBC3LqlMXfQKP9zVRgmN7W1zzegyUDp0wXIFOI=;
 b=SYvSxZ8Isxl8yonz783G9Fiu82X/Y1SHhYdP25bMyw9WM5P8bflm2M63OCpqLSjWqQQ9xc
 7YjYXeOy9pLIQjZNfI9mQHUHUUapqctp2Oq8VJjn6DXQTmRVgSqmQCkszOBaz8FjDtq7uW
 WIeB3pkHN8mVUCRJ8LKDoimIbeASC8g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-anlbSueeMmq6PbqaTi0UhQ-1; Mon, 14 Jul 2025 12:23:02 -0400
X-MC-Unique: anlbSueeMmq6PbqaTi0UhQ-1
X-Mimecast-MFC-AGG-ID: anlbSueeMmq6PbqaTi0UhQ_1752510182
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b39cc43f15so2499433f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 09:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752510181; x=1753114981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFgxmBBC3LqlMXfQKP9zVRgmN7W1zzegyUDp0wXIFOI=;
 b=Ke/6iNUztGn1iTDzxW/IC3YCZGrYn2WiaBAbEll9V/Hn1NNDVBXb85GMB84Mfb+yVX
 gEstQPXrH7UvOmfVelGxQhkiS83K3sNn/nB/1TrUd5k1jaPQUf+vITdguJbKLr+hWUuM
 o0j0xiqigA6Vz3MjY/kRyEr3QIN8QO0jsSoRHIORBW4vzulcpEyp0MWsqd8o//R8hd8t
 eK6Ix6gs/5lPjIMOUwrsjjIT5MbDkdisxbZ5zE5y61CKDD5aNhafIBtvKQaotvPUG90K
 Zm5U00f2E9GChyGngUw2w8VllokGZFguK/yfF0wHgpt+eVsAjE+9DHNp0cFQtQGJkilG
 RJBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXsbYs46VeDX4cS1z6bWLZlLm36+vBtDorHRmEI/IUmSWEZf266OsqHZXumoooyiRz+PtDWlrCfl7y@nongnu.org
X-Gm-Message-State: AOJu0YwX6qVQPLMI7YB+Xk4LQEz75WMhzuoPgA6eIjSW565YIEb90TXI
 nUSgclrqAIl3oemOiMntkXa3gno4WfLiLK0A1lqSqrdNG7TKO3FnUf9mU7uZByeTNs2PrDyXksF
 bQ22pdiMR5DhrkecWgviPCoAO8Edr6/ldcFDjzAnLDtJe60/BXCwcRbc2dtoSLetb
X-Gm-Gg: ASbGnctmFUEd35yVskk41LjzBWFkYOO1yB399G+RTyI8PfIAtw7M2n4BJUFZTJ2XCpM
 MoFJ7af0C0iULFx/YX4xCYr5l9jB7LLACHcAoF2JCqqEvm8k6FUxT0SMrQuKz6eR2DOQR6FNRuM
 RGKH1kMLZFH3pMVUwEiuvgq68kjYN+EwMS3ymUoaRj6034t24+fSlvvoQsaoeHOSq3uCEabXLnP
 +Xv/RyznJKW+QNGMcaTKq1raiFBFMvKxUM+Uk8whAOqS2fbkMnK7laFczyBbZlEKSiTozQLbCtz
 kQoXAqi5UkjeAMX/xvy0fogTHOYkkcPS
X-Received: by 2002:a05:6000:270d:b0:3b3:9cc4:21ce with SMTP id
 ffacd0b85a97d-3b5f18f6371mr7910660f8f.50.1752510181133; 
 Mon, 14 Jul 2025 09:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo0bc8OIdjzU5PGoWtnMI5FJDTrHo2xvHwOSwUa8YuFSMuUIIJkgSnpjE9Lj8gFx2Hyyfrxg==
X-Received: by 2002:a05:6000:270d:b0:3b3:9cc4:21ce with SMTP id
 ffacd0b85a97d-3b5f18f6371mr7910643f8f.50.1752510180697; 
 Mon, 14 Jul 2025 09:23:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:23:49e3:7a5d:209f:1dfc:d594])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1de0sm12688332f8f.24.2025.07.14.09.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:23:00 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:22:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: anisinha@redhat.com, imammedo@redhat.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, peter.maydell@linaro.org,
 prime.zeng@hisilicon.com, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com, maobibo@loongson.cn, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com
Subject: Re: [PATCH v6 3/4] hw/acpi/aml-build: Build a root node in the PPTT
 table
Message-ID: <20250714122132-mutt-send-email-mst@kernel.org>
References: <20250604115233.1234-1-alireza.sanaee@huawei.com>
 <20250604115233.1234-4-alireza.sanaee@huawei.com>
 <20250714090807-mutt-send-email-mst@kernel.org>
 <20250714151041.0000599d.alireza.sanaee@huawei.com>
 <20250714115603-mutt-send-email-mst@kernel.org>
 <20250714170605.00003cb5.alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714170605.00003cb5.alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 14, 2025 at 05:06:05PM +0100, Alireza Sanaee wrote:
> On Mon, 14 Jul 2025 11:57:19 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jul 14, 2025 at 03:10:41PM +0100, Alireza Sanaee wrote:
> > > On Mon, 14 Jul 2025 09:09:10 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Wed, Jun 04, 2025 at 12:52:32PM +0100, Alireza Sanaee wrote:  
> > > > > From: Yicong Yang <yangyicong@hisilicon.com>
> > > > > 
> > > > > Currently we build the PPTT starting from the socket node and
> > > > > each socket will be a separate tree. For a multi-socket system
> > > > > it'll be hard for the OS to know the whole system is
> > > > > homogeneous or not (actually we're in the current
> > > > > implementation) since no parent node to telling the identical
> > > > > implementation informentation. Add a root node for indicating
> > > > > this.
> > > > > 
> > > > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > > > > ---
> > > > >  hw/acpi/aml-build.c | 15 ++++++++++++++-
> > > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > > > index 560cee12a2..76a4157a18 100644
> > > > > --- a/hw/acpi/aml-build.c
> > > > > +++ b/hw/acpi/aml-build.c
> > > > > @@ -2153,12 +2153,25 @@ void build_pptt(GArray *table_data,
> > > > > BIOSLinker *linker, MachineState *ms, int64_t socket_id = -1,
> > > > > cluster_id = -1, core_id = -1; uint32_t socket_offset = 0,
> > > > > cluster_offset = 0, core_offset = 0; uint32_t pptt_start =
> > > > > table_data->len;
> > > > > +    uint32_t root_offset;
> > > > >      int n;
> > > > >      AcpiTable table = { .sig = "PPTT", .rev = 2,
> > > > >                          .oem_id = oem_id, .oem_table_id =
> > > > > oem_table_id }; 
> > > > >      acpi_table_begin(&table, table_data);
> > > > >  
> > > > > +    /*
> > > > > +     * Build a root node for all the processor nodes. Otherwise
> > > > > when
> > > > > +     * building a multi-socket system each socket tree is
> > > > > separated
> > > > > +     * and will be hard for the OS like Linux to know whether
> > > > > the
> > > > > +     * system is homogeneous.
> > > > > +     */
> > > > > +    root_offset = table_data->len - pptt_start;
> > > > > +    build_processor_hierarchy_node(table_data,
> > > > > +        (1 << 0) | /* Physical package */
> > > > > +        (1 << 4), /* Identical Implementation */
> > > > > +        0, 0, NULL, 0);
> > > > > +
> > > > >      /*
> > > > >       * This works with the assumption that cpus[n].props.*_id
> > > > > has been
> > > > >       * sorted from top to down levels in
> > > > > mc->possible_cpu_arch_ids(). @@ -2175,7 +2188,7 @@ void
> > > > > build_pptt(GArray *table_data, BIOSLinker *linker, MachineState
> > > > > *ms, build_processor_hierarchy_node(table_data, (1 << 0) | /*
> > > > > Physical package */ (1 << 4), /* Identical Implementation */
> > > > > -                0, socket_id, NULL, 0);
> > > > > +                root_offset, socket_id, NULL, 0);
> > > > >          }
> > > > >  
> > > > >          if (mc->smp_props.clusters_supported &&
> > > > > mc->smp_props.has_clusters) {    
> > > > 
> > > > 
> > > > This function is also used by loongarch64, but you do not update
> > > > the loongarch64 expected files:
> > > > https://gitlab.com/mstredhat/qemu/-/jobs/10672661860  
> > > 
> > > Hi Michael,
> > > 
> > > There are new tests you have brought in the
> > > tree after mine. 
> > > https://gitlab.com/mstredhat/qemu/-/commit/9e4f80654cefd051f8f5c220d5447201b6cf1810
> > > 
> > > I can try to fix this and resend with updated PPTT files for
> > > loongarch64. WDYT?  
> > 
> > That commit is in master though, right?
> > Sounds good, pls do.
> 
> I do NOT think it is on the master. It is on v11-14-07-2025
> 
> I am trying to work it out on the most recent branch now.

Donnu, I thought I checked but you are right.
If you can help post updated tables (can be a patch on top,
I will squash) would be great.

> > 
> > > >   
> > > > > -- 
> > > > > 2.43.0    
> > > > 
> > > >   
> > 
> > 


