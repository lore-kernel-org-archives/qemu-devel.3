Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1940E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIkDm-00013Z-AW; Wed, 04 Dec 2024 02:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIkDh-0000uU-Qx
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:54:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIkDe-0002Ud-C7
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733298884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bapXZ7d3j5PvmLQR20ulpt7ZnCE088LkGy4W5u5RvDM=;
 b=No/HMI4o4EiI3/+IbFumd8L2pyXZyqMbXJD1fv4vkFIt9thdvr6zGQ660YTb5OoNYJrRwX
 QyVhDSOs9+wv6bRUlBBZsFiOMIJy1yZpGy/WufiG4D7y0j9B4QmEEsuAVscjGrgrjd7Vrk
 r2AMP4bFBSvdGpItDZx6PfRLVUSqdAY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-vArP0OrLPVek54JUCOk4sw-1; Wed, 04 Dec 2024 02:54:43 -0500
X-MC-Unique: vArP0OrLPVek54JUCOk4sw-1
X-Mimecast-MFC-AGG-ID: vArP0OrLPVek54JUCOk4sw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385de8e0416so2797745f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 23:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733298883; x=1733903683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bapXZ7d3j5PvmLQR20ulpt7ZnCE088LkGy4W5u5RvDM=;
 b=e+aifitdeUAYXj/gUU3hMz+vBeWOk0tR07Tp3sthDF69DYZasMnZjQoE/D16gHQeTt
 JDeAFhSuMGjRyc4NeWMIWTqU85ykhihZHBRRnbopR/tz8HaKWd4btb1qRR/BRi7nkPvs
 FjKDT0hHcOrfvqdfuAsU42IqeysDilIQMMI4RNHS+WeYxRBB0E2cQUxaiS5rAJK51iRg
 h6GuZ/OLKUidnKeYrS3AHVdGo4Jd2ghyhmF4+zrv0RjFNPrUJ1bvHKscTLF81X/WlxF1
 c41IuPhKMhPiAyQzYi0tacKVxPJXgXmCnrOAB9H22RE0T8NZVQ7OszD1fsLwbNQu0USg
 Q+2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOepggLAknKvaDLd/NhyPWTBdEXh/XPwGJfz+yPQJlcJIX7AxSiHHJKqu9pubKIFdcNl49g7aV/ETE@nongnu.org
X-Gm-Message-State: AOJu0Yx7e/aANeG3mZdbw0kcRuAsDyEZ3oooHQQGMD2stR20PdnynMQW
 1wMUefDbMCkyMizYnz/eV9+EYyx/86X7ZhcvckuROuGOzmHTCAVPKR5+MC7GuHaHYIkoT568Fvy
 Pdir3j2+Nkps6vB0D4LjI45e/UAd7GoP8SYoAyTifGbwuboc34+MP
X-Gm-Gg: ASbGncs+1aPZTWrkWXewytKBPnEN6T2S7r/QNpeq6Slw3FmnlPLWU0iP9kSoDt/I50e
 jK5OwN6xp92JK1tRTapUiTyrVouUtRvzTGl9xT65OEcSvvTBJZ0ZGDP/3XoFqR5b35hcct6IhTB
 G8vIt82St8YSFOQy2x8s485uwzNJxCty90s3vvwi4yC2O3fwFAwc0PgkCY9hluCVRlWXRGSn+7y
 VOqtt9IkEYwXWMjpbi/UBb61pWF6SZTTDBdjK5giRx1B8dqfwLsUBDrQ5qorDg9bT7R3PkhlkMF
 ptw3/wnFKw3eQaJ9PU4rOA==
X-Received: by 2002:a05:6000:1aca:b0:382:319f:3abd with SMTP id
 ffacd0b85a97d-385fd53ef48mr3821756f8f.36.1733298882625; 
 Tue, 03 Dec 2024 23:54:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExlC9aez6wOgXUHe7v4Tl9z03wmj1DfrNWHgzsP8H2nhXL372UgwE29wd7/FfES9t5ebV8Zg==
X-Received: by 2002:a05:6000:1aca:b0:382:319f:3abd with SMTP id
 ffacd0b85a97d-385fd53ef48mr3821741f8f.36.1733298882222; 
 Tue, 03 Dec 2024 23:54:42 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385f0056637sm8769421f8f.15.2024.12.03.23.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 23:54:41 -0800 (PST)
Date: Wed, 4 Dec 2024 08:54:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241204085440.4640a476@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241203144730.47b8ca86@foz.lan>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
 <20241203125143.7171892a@imammedo.users.ipa.redhat.com>
 <20241203144730.47b8ca86@foz.lan>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, 3 Dec 2024 14:47:30 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 3 Dec 2024 12:51:43 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 22 Nov 2024 10:11:30 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Currently, CPER address location is calculated as an offset of
> > > the hardware_errors table. It is also badly named, as the
> > > offset actually used is the address where the CPER data starts,
> > > and not the beginning of the error source.
> > > 
> > > Move the logic which calculates such offset to a separate
> > > function, in preparation for a patch that will be changing the
> > > logic to calculate it from the HEST table.
> > > 
> > > While here, properly name the variable which stores the cper
> > > address.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
> > >  1 file changed, 32 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index 87fd3feedd2a..d99697b20164 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > >      ags->present = true;
> > >  }
> > >  
> > > +static void get_hw_error_offsets(uint64_t ghes_addr,
> > > +                                 uint64_t *cper_addr,
> > > +                                 uint64_t *read_ack_register_addr)
> > > +{    
> > 
> >   
> > > +    if (!ghes_addr) {
> > > +        return;
> > > +    }    
> > 
> > why do we need this check?  
> 
> It is a safeguard measure to avoid crashes and OOM access. If fw_cfg 
> callback doesn't fill it properly, this will be zero.

shouldn't happen, but yeah it firmware job to write back addr
which might happen for whatever reason (a bug for example).

Perhaps push this up to the stack, so we don't have to deal
with scattered checks in ghes code.

kvm_arch_on_sigbus_vcpu() looks like a goo candidate for check
and warn_once if that ever happens.
It already calls acpi_ghes_present() which resolves GED device
and then later we duplicate this job in ghes_record_cper_errors()

so maybe rename acpi_ghes_present to something like AcpiGhesState* acpi_ghes_get_state()
and call it instead. And then move ghes_addr check/warn_once there.
This way the rest of ghes code won't have to deal handling practically
impossible error conditions that cause reader to wonder why it might happen.

> > > +
> > > +    /*
> > > +     * non-HEST version supports only one source, so no need to change
> > > +     * the start offset based on the source ID. Also, we can't validate
> > > +     * the source ID, as it is stored inside the HEST table.
> > > +     */
> > > +
> > > +    cpu_physical_memory_read(ghes_addr, cper_addr,
> > > +                             sizeof(*cper_addr));
> > > +
> > > +    *cper_addr = le64_to_cpu(*cper_addr);    
> >         1st bits flip, and then see later
> >   
> > > +
> > > +    /*
> > > +     * As the current version supports only one source, the ack offset is
> > > +     * just sizeof(uint64_t).
> > > +     */
> > > +    *read_ack_register_addr = ghes_addr +
> > > +			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> > > +}
> > > +
> > >  void ghes_record_cper_errors(const void *cper, size_t len,
> > >                               uint16_t source_id, Error **errp)
> > >  {
> > > -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > > +    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;    
> > 
> > if get_hw_error_offsets() isn't supposed to fail, then we do not need to initialize
> > above. So this hunk doesn't belong to this patch.  
> 
> It may fail due to:
> 
>     if (!ghes_addr) {
>         return;
>     }
> 
> >   
> > >      uint64_t start_addr;
> > >      AcpiGedState *acpi_ged_state;
> > >      AcpiGhesState *ags;
> > > @@ -389,18 +416,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >  
> > >      start_addr += source_id * sizeof(uint64_t);
> > >  
> > > -    cpu_physical_memory_read(start_addr, &error_block_addr,
> > > -                             sizeof(error_block_addr));
> > > +    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
> > >  
> > > -    error_block_addr = le64_to_cpu(error_block_addr);
> > > -    if (!error_block_addr) {
> > > +    cper_addr = le64_to_cpu(cper_addr);    
> >                    ^^^^ 2nd bits flip turning it back to guest byte order again
> > 
> > suggest to keep only one of them in get_hw_error_offsets()  
> 
> Ok, I'll drop this one.
> 
> > > +    if (!cper_addr) {
> > >          error_setg(errp, "can not find Generic Error Status Block");
> > >          return;
> > >      }
> > >  
> > > -    read_ack_register_addr = start_addr +
> > > -                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> > > -
> > >      cpu_physical_memory_read(read_ack_register_addr,
> > >                               &read_ack_register, sizeof(read_ack_register));
> > >  
> > > @@ -421,7 +444,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >          &read_ack_register, sizeof(uint64_t));
> > >  
> > >      /* Write the generic error data entry into guest memory */
> > > -    cpu_physical_memory_write(error_block_addr, cper, len);
> > > +    cpu_physical_memory_write(cper_addr, cper, len);
> > >  
> > >      return;
> > >  }    
> >   
> 
> Thanks,
> Mauro
> 


