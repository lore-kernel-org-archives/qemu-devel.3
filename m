Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F18C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrTd-00062i-Ih; Tue, 25 Feb 2025 04:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmrTZ-000625-T4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:43:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmrTX-0005a8-25
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740476618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5IuXbVC/fE2fpy28ItJZlJGmOxKbKIqaMashXqUdLM=;
 b=SuNd7HXwb9uB4tKxBtvEOpytK98icETlugv17YdDBCxICRf3wuKmIZOxJmZ4xNchKsm7cC
 I/OzdL0aXavlFSNnLJ8BusMh5MTM7wLlzy6+mk9O174j/goMw4+2qYwaoLKJgtdI0eH7sN
 z0YAbspNuMMuvD5SVxP51aAbvfyu7vw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-GE3fEY75PTKv3E_ZnmPXdA-1; Tue, 25 Feb 2025 04:43:34 -0500
X-MC-Unique: GE3fEY75PTKv3E_ZnmPXdA-1
X-Mimecast-MFC-AGG-ID: GE3fEY75PTKv3E_ZnmPXdA_1740476613
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4399c5ba9e4so29690845e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 01:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740476610; x=1741081410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5IuXbVC/fE2fpy28ItJZlJGmOxKbKIqaMashXqUdLM=;
 b=DYouGG9fK4JQBrNzplD4O25OKpYfsKTJ+9qbW0+gtVopBhRadHapzRddfMO5x+aaaj
 R+hbQrmGWBh0y9xTBTuVQHFLrhoZ+Aaos4Fbg2iCwVYK//tNxc/1Y2kdvRvR7JOKA/RM
 L83PQ2/N0Wl9fRcm/vChQ1DMd6pYAGjDYGjygWG2qcXHzYkUJfu6VjwyKD/o7/7N+aJD
 2G+l47PkGbCGd9vFcAU0T/LaISqdAedoWRouMMAiCjGSHASvfFB4JGyjt9XprnNBs1Hd
 Aownh/nf11Hgi8Q6qvK508KuIk9ixXMbckPDdwSOl+0zb/P8Kch342WMPYyw0771psdh
 ySrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUukDllqWwmAiu/oiLiplD6RjFPman8/UsrXG3Pp2xIpOcu3nTMZge0XWhzai5MEGIwmXNnG5DztMK2@nongnu.org
X-Gm-Message-State: AOJu0YyWTsRwSTrAwq+gZY4wb8DdKoM9wzJZLHYNcb3z8eUzsvxmrBmG
 ZXDOTzvX8p89eCtj5uyBSEA771Vr1QmjWqWsj4jP7zp3CEWIQoYlsIT0htVDcDDw/+wr2PSCLxt
 0XZq6SQv0bggbp51iOf/NTRVm+QAnnjnzmKoctgo13PzvDdAkdPRoneIIAo0N
X-Gm-Gg: ASbGncvcMGqVbC3EXOhmHWfdBvxLoEtFNswjpZjoKCMH9mGEfJMCx592EPYGyv7mPzY
 ot2INVeiK6wT/y5kcy7JcP03Cv+1k6GTHd1Bdh7fx01HhsyJsenc8Xf6Y7kEbDzdA9Obuhjrt5d
 4tjoAu5p0+9KJxpdSI0gTEJ120PcfvNMYwIf2wIfu5GI+dbf4qIL/g2ttXTX89xWw/imi8GGkCY
 7qc5hSL1MUUIJAfAADBAnQViPhspg+zWsNUsEXT20VpqiUXBYGvflQXxjg+ntE2+LfwAeJ4g+nF
 f+TYfz/Y1Xt571x/St7pfJTOAOtgPPPXVGFDnihhXHZTogPQ7t6YrAmoqBMIqo0=
X-Received: by 2002:a05:600c:3c87:b0:439:930a:58aa with SMTP id
 5b1f17b1804b1-43ab0ecc2f2mr24089245e9.0.1740476610521; 
 Tue, 25 Feb 2025 01:43:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7SWWZtXumX0waBhzuzJJUOBFPNpCyr81evlpTXBUdvLowN5fEohw657IpPbZDbBNIzb4b3A==
X-Received: by 2002:a05:600c:3c87:b0:439:930a:58aa with SMTP id
 5b1f17b1804b1-43ab0ecc2f2mr24088975e9.0.1740476610069; 
 Tue, 25 Feb 2025 01:43:30 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce615sm134946725e9.5.2025.02.25.01.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 01:43:29 -0800 (PST)
Date: Tue, 25 Feb 2025 10:43:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250225104327.0a2d1cb4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250221070221.329bdfb0@foz.lan>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <9610ff88cf6fdc59cbfc8871d653fd890391be1e.1738345063.git.mchehab+huawei@kernel.org>
 <20250203153423.3e4de17c@imammedo.users.ipa.redhat.com>
 <20250221070221.329bdfb0@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 21 Feb 2025 07:02:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 3 Feb 2025 15:34:23 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 31 Jan 2025 18:42:44 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > There are two pointers that are needed during error injection:
> > > 
> > > 1. The start address of the CPER block to be stored;
> > > 2. The address of the ack.
> > > 
> > > It is preferable to calculate them from the HEST table.  This allows
> > > checking the source ID, the size of the table and the type of the
> > > HEST error block structures.
> > > 
> > > Yet, keep the old code, as this is needed for migration purposes.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  hw/acpi/ghes.c         | 132 ++++++++++++++++++++++++++++++++++++-----
> > >  include/hw/acpi/ghes.h |   1 +
> > >  2 files changed, 119 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index 27478f2d5674..8f284fd191a6 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -41,6 +41,12 @@
> > >  /* Address offset in Generic Address Structure(GAS) */
> > >  #define GAS_ADDR_OFFSET 4
> > >  
> > > +/*
> > > + * ACPI spec 1.0b
> > > + * 5.2.3 System Description Table Header
> > > + */
> > > +#define ACPI_DESC_HEADER_OFFSET     36
> > > +
> > >  /*
> > >   * The total size of Generic Error Data Entry
> > >   * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> > > @@ -61,6 +67,25 @@
> > >   */
> > >  #define ACPI_GHES_GESB_SIZE                 20
> > >  
> > > +/*
> > > + * Offsets with regards to the start of the HEST table stored at
> > > + * ags->hest_addr_le,    
> > 
> > If I read this literary, then offsets above are not what
> > declared later in this patch.
> > I'd really drop this comment altogether as it's confusing,
> > and rather get variables/macro naming right
> >   
> > > according with the memory layout map at
> > > + * docs/specs/acpi_hest_ghes.rst.
> > > + */    
> > 
> > what we need is update to above doc, describing new and old ways.
> > a separate patch.  
> 
> I can't see anything that should be changed at
> docs/specs/acpi_hest_ghes.rst, as this series doesn't change the
> firmware layout: we're still using two firmware tables:
> 
> - etc/acpi/tables, with HEST on it;
> - etc/hardware_errors, with:
> 	- error block addresses;
> 	- read_ack registers;
> 	- CPER records.
> 
> The only changes that this series introduce are related to how
> the error generation logic navigates between HEST and hw_errors
> firmware. This is not described at acpi_hest_ghes.rst, and both
> ways follow ACPI specs to the letter.
> 
> The only difference is that the code which populates the CPER
> record and the error/read offsets doesn't require to know how
> the HEST table generation placed offsets, as it will basically
> reproduce what OSPM firmware does when handling	HEST events.

section 8 describes old way to get to address to record old CPER,
so it needs to amended to also describe a new approach and say
which way is used for which version.

possibly section 11 might need some messaging as well.


> 
> Thanks,
> Mauro
> 


