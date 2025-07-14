Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43584C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMzz-0007Kv-UZ; Mon, 14 Jul 2025 13:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubLxm-0008Kp-Kq
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubLxg-0002u5-RW
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752510207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vsowap4mFhTCJb6iq6PQM6rBisQC+71dv9lkpYyETCY=;
 b=GfD1fKxxO7aCqzh/+1arbmKCa80KU6H1tMKoGBf/NmDHt5YjrbWQ72yl6KzrIkZBMEyDry
 oZY4/tuflPulhVS8UQpMozD8VgltB6f4d9BI2UsIByoW8iibFeXRmIDwG1hOh342VBglxi
 QTn7thlVwJu1/mTUzJRKdQqWKW88iM4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-ixGashENOm2p_CzwHhVAPg-1; Mon, 14 Jul 2025 12:23:24 -0400
X-MC-Unique: ixGashENOm2p_CzwHhVAPg-1
X-Mimecast-MFC-AGG-ID: ixGashENOm2p_CzwHhVAPg_1752510203
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so17001265e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 09:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752510203; x=1753115003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsowap4mFhTCJb6iq6PQM6rBisQC+71dv9lkpYyETCY=;
 b=Ic9RZhfokFSbgn7Absx7e21PHJLZtTcCciAPjthS78t9JFDsZodVkH7cTr6nh0UXlt
 Y9/DyeqWo7sXGhM9l5HuNHotUfjT0miDenb+CM5oJ46GdAqWdEwA22u8rJhr4Fn5ba2M
 m6u8nzRFEL/LG5ed8rqXsVR38Yqhflbft8PG7URNs2accyyMpeGH1gihI0ErLXrlvb+Y
 1Ky2F8mlG/neYAjT0nPS1OEkwiRKLNzUgAIBq13kpbHSjBon0UDwNj4Ez911AIgY2B15
 8LBSJZSgH/XgNXkjKVFSLxB6HNvov110izsY0zWWIKkpsyDzjcPagfJ0arVMnc+AIwIz
 ViBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPFalLcWFy93eAV1nqe7YfKW3Yh4/3HV1S3gxrsvLXio6xjM/CrermDa+QUSeY6Eq9sTibvS1k+9nk@nongnu.org
X-Gm-Message-State: AOJu0YyBGaeSl5ohZ/ESFLO2e7LEkVFoDSZ2zyjw6IkAF2VcwDnwMerU
 oosM4HS5e4g+HM06DJzAZx9j6L3Ot8+iaGuFpUT8fEaV6ck2POJqqR7Nau0+mlj82HTSLfbnKrO
 2kZUX3x/SpMDILBHqgNcOrDiP291CT6Pruh9hd7RTRocUBSSouS8X5ktb
X-Gm-Gg: ASbGncvLVYRIyl9i+QozFKh3mStwH7uXIN2e52CLcwKYIAct+3TioBu6OgZGDw84Fvk
 S5PUVz3jSD832bUt0LIcZkQAVGR5X/mWvHP4aYxyEZjv//Afni1d21ofbyexjgUXfep3x7ES0P5
 ADOOWDoquJrIUdBxe7WarZAZiII59UN3NCrsg/M09uHvCAiNSjnoCEwCfmV/M3XqM0tRcrtIgyb
 Rq8Xymjuwuiw31sDVsw4IOMPleEHQSIC1Dhv7hrB26d/xPaBk7HzEVdOXcyFmi70QfBVEEEDysT
 /2jKI+q+rdVJpWwGXGGv4XznNTXkDrs8
X-Received: by 2002:a5d:588e:0:b0:3a4:eec5:441c with SMTP id
 ffacd0b85a97d-3b5f2e26bbfmr10518959f8f.47.1752510203248; 
 Mon, 14 Jul 2025 09:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWlWTZp2ApLbp/DdfqeZSeH4WvjlP2OWLno7MFxfTJ4Hc05o0wchKt7jhe0NZZXJ52Mgf/QA==
X-Received: by 2002:a5d:588e:0:b0:3a4:eec5:441c with SMTP id
 ffacd0b85a97d-3b5f2e26bbfmr10518935f8f.47.1752510202769; 
 Mon, 14 Jul 2025 09:23:22 -0700 (PDT)
Received: from redhat.com ([2a02:14f:23:49e3:7a5d:209f:1dfc:d594])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1890sm12741740f8f.3.2025.07.14.09.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:23:22 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:23:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alireza Sanaee <alireza.sanaee@huawei.com>, anisinha@redhat.com,
 imammedo@redhat.com, linuxarm@huawei.com, peter.maydell@linaro.org,
 prime.zeng@hisilicon.com, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com, maobibo@loongson.cn, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com
Subject: Re: [PATCH v6 3/4] hw/acpi/aml-build: Build a root node in the PPTT
 table
Message-ID: <20250714122306-mutt-send-email-mst@kernel.org>
References: <20250604115233.1234-1-alireza.sanaee@huawei.com>
 <20250604115233.1234-4-alireza.sanaee@huawei.com>
 <20250714090807-mutt-send-email-mst@kernel.org>
 <20250714151041.0000599d.alireza.sanaee@huawei.com>
 <20250714115603-mutt-send-email-mst@kernel.org>
 <20250714170945.0000714f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714170945.0000714f@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 14, 2025 at 05:09:45PM +0100, Jonathan Cameron wrote:
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
> > > > > Currently we build the PPTT starting from the socket node and each
> > > > > socket will be a separate tree. For a multi-socket system it'll
> > > > > be hard for the OS to know the whole system is homogeneous or not
> > > > > (actually we're in the current implementation) since no parent node
> > > > > to telling the identical implementation informentation. Add a
> > > > > root node for indicating this.
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
> > > > > +     * building a multi-socket system each socket tree is separated
> > > > > +     * and will be hard for the OS like Linux to know whether the
> > > > > +     * system is homogeneous.
> > > > > +     */
> > > > > +    root_offset = table_data->len - pptt_start;
> > > > > +    build_processor_hierarchy_node(table_data,
> > > > > +        (1 << 0) | /* Physical package */
> > > > > +        (1 << 4), /* Identical Implementation */
> > > > > +        0, 0, NULL, 0);
> > > > > +
> > > > >      /*
> > > > >       * This works with the assumption that cpus[n].props.*_id has
> > > > > been
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
> > > > This function is also used by loongarch64, but you do not update the
> > > > loongarch64 expected files:
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
> 
> Hi Michael,
> 
> Which master do you mean? As far as I can tell the above commit isn't
> anywhere other than your gitlab and, in for failures that were
> triggering there earlier today, it was later in the tree than this
> series (so the problem didn't manifest in this series at all)
> That had Ali and I confused for a while as we couldn't replicate.

You are right, my mistake.

> Anyhow, someone had to do a rebase either way so not a problem.
> 
> Jonathan
> 
> 
> > Sounds good, pls do.
> > 
> > > >   
> > > > > -- 
> > > > > 2.43.0    
> > > > 
> > > >   
> > 
> > 


