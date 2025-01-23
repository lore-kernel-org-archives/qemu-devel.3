Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44243C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 17:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb0ar-0003kl-DM; Thu, 23 Jan 2025 12:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tb0aP-0003Yv-HN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 12:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tb0aN-0000ug-0A
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 12:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737651701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xSEVQjuB5qFSDSI+3BKxO2wE2xMzcAIDO59glC5e8k=;
 b=UYkCvxhCH4oNk9medq/esojH/bRJ9FIGEoVZeU+B8+uFC0EsbBUVuyZloe4qA0TdBnXDRn
 7V/PnWeM6SxLZ7sqkfYnCZGGtbN8/DmbFJhl+1NY7IzIkKSp5riJah7zQZR3xbs6Un7n+I
 F8iO7FEg6hFd7FHitV2y5Pl3uOAxfl0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-MyxXtRWnPQurlpcSCgVYng-1; Thu, 23 Jan 2025 12:01:39 -0500
X-MC-Unique: MyxXtRWnPQurlpcSCgVYng-1
X-Mimecast-MFC-AGG-ID: MyxXtRWnPQurlpcSCgVYng
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so6625875e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 09:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737651698; x=1738256498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xSEVQjuB5qFSDSI+3BKxO2wE2xMzcAIDO59glC5e8k=;
 b=pdF/SQC390gcFayPyfFsQFUB8RFQZe7VwYHJKdrgb84cHiZ3j7S33VYSkpByT7Kjay
 SO2w0PwjWV7lZrxGKO4lhr5Ul8AHBr57MybH0Cm8DGxa5T8anrpSmX1S4pcSzn0/y3KI
 w0Wco1Oa8wuZUm+fxulL594n9FDSCp3pqRXAAF7z2yEtcp5mobeOdoa3daBxjx0iakYc
 GOivBW5UJfh74UY84uQTlhLOvuZSoLoGu3adJwJUHrQUhGc3ZDf/LPNo2+KU9u8nBgNW
 5wRLqebdrwgrltnF4SpwdbiI8ZiLGTdNhwHqATb/8ApNB+lifCqwcQVfbk6jXCIZHUIA
 ci0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdIqi24eI2731yCPy9whTVaN9jwoH2Ill3gzjayP+KuyUo4J4Z9tGiMF5WzGWWGne0YeC79k7mNuS7@nongnu.org
X-Gm-Message-State: AOJu0YxOEs5CJ3y1/C0UBC9oGGa4afPCtcat9VBLXSc00myPJ+3wSxgW
 mOkAgtp4HAbr5pT6Lyx31yJqDDactXVHoP6jSotpdzqO7s1dE7Id3KMAR5pOR5K1oYPcJRe8/9a
 21c7zI1zyMOAlrfzRgIhieke18Hg6smOaETjmY6hI5geroQVqGIuy
X-Gm-Gg: ASbGncuvpq2yjxKojH1w5GTYD5p4fkY57fsx4xURQAlr5/9PjfsE8cN20QHaNAw78ef
 Cdyx9ln7tazOif62rBEj5PawODorXK8e13+9fPyBjr6t+KYPLItcPETkMIhox8iSw1sux9mkq5O
 cGfYWJ199fM6E9Edmx1JO4TuvrLx1a7RYtj0J9HPnI4873TS6YuJThcOTRA1ggfjCKoJ3HFwYKZ
 FSMb+J0Vanx/K36dcZyMnXTohEwtQVEKGfpf9oxTLPwnaywlttzHi7bkq8J9Kcp+uBAlFpF8CbB
 hg0yaV39CXs8jviiDWdnVUbQkiNg1wRfPQTuf0CBhQ==
X-Received: by 2002:a05:600c:218b:b0:436:e751:e417 with SMTP id
 5b1f17b1804b1-43891919404mr258599525e9.7.1737651697573; 
 Thu, 23 Jan 2025 09:01:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6yTA5xc+OvVDrqjMxcnIcrrTfweGD+yce69J/Wmhzb7KrBCff0ub55hZvOTPlJrll4YNB5g==
X-Received: by 2002:a05:600c:218b:b0:436:e751:e417 with SMTP id
 5b1f17b1804b1-43891919404mr258598655e9.7.1737651696843; 
 Thu, 23 Jan 2025 09:01:36 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b1ce51a6sm52744495e9.1.2025.01.23.09.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 09:01:36 -0800 (PST)
Date: Thu, 23 Jan 2025 18:01:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/11] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250123180135.4f86483f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250123100217.00007373@huawei.com>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <a3579f6c2c24e764e544f83b6e1b2dbef730e3e3.1737560101.git.mchehab+huawei@kernel.org>
 <20250123100217.00007373@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 23 Jan 2025 10:02:17 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 22 Jan 2025 16:46:19 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Store HEST table address at GPA, placing its content at
> > hest_addr_le variable.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> A few trivial things inline.
> 
> Jonathan
> 
> > ---
> > 
> > Change from v8:
> > - hest_addr_lr is now pointing to the error source size and data.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Bonus.  I guess you really like this patch :)
> > ---
> >  hw/acpi/ghes.c         | 17 ++++++++++++++++-
> >  include/hw/acpi/ghes.h |  1 +
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 3f519ccab90d..34e3364d3fd8 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -30,6 +30,7 @@
> >  
> >  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> >  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> > +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
> >  
> >  /* The max size in bytes for one error block */
> >  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> > @@ -261,7 +262,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
> >      }
> >  
> >      /*
> > -     * tell firmware to write hardware_errors GPA into
> > +     * Tell firmware to write hardware_errors GPA into  
> 
> Sneaky tidy up.  No problem with it in general but adding noise here, so if there
> are others in the series maybe gather them up in a cleanup patch.

+1

> 
> >       * hardware_errors_addr fw_cfg, once the former has been initialized.
> >       */
> >      bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> > @@ -355,6 +356,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> >  
> >      acpi_table_begin(&table, table_data);
> >  
> > +    int hest_offset = table_data->len;  
should be unsigned, and better uint32_t
but we have a zoo wrt type here all over the place.

  
> 
> Local style looks to be traditional C with definitions at top.  Maybe define
> hest_offset up a few lines and just set it here?

yep, it applies to whole QEMU (i.e. definitions only at the start of the block)

> 
> > +
> >      /* Error Source Count */
> >      build_append_int_noprefix(table_data, num_sources, 4);
> >      for (i = 0; i < num_sources; i++) {
> > @@ -362,6 +365,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> >      }
> >  
> >      acpi_table_end(linker, &table);
> > +
> > +    /*
> > +     * tell firmware to write into GPA the address of HEST via fw_cfg,  
> 
> Given the tidy up above, fix this one to have a capital T, or was this
> where you meant to change it?
> 
> > +     * once initialized.
> > +     */
> > +    bios_linker_loader_write_pointer(linker,
> > +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,  
> 
> Could wrap less and stay under 80 chars as both lines above add up to 70 something
> 
> > +                                     sizeof(uint64_t),
> > +                                     ACPI_BUILD_TABLE_FILE, hest_offset);
> >  }  
> 


