Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BCCE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 09:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ847-0005gQ-MH; Thu, 05 Dec 2024 04:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tJ842-0005fx-OZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 04:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tJ840-00035x-Vs
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 04:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733390543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGhsvxIAa/RUDZNcykbYv+PGXT3hSqjfx5KJygYAroU=;
 b=N0zyIGzh6Bv10cMKqFb58RKAbYcnQXJItTMwmk1kFGnFKRoyreXjoqgkAoN9uF8/JJrlrr
 2z+gxP/tvT/B1g7mbjvPW+t7HdHUReUbjal01TadyiAfBonVm+XRVxyo17FWu94rUeuiSO
 qike88VaX44PI5pSSEEJO4opBubj9V8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-of-6we2HNtuVbbKgpbrrbA-1; Thu, 05 Dec 2024 04:22:22 -0500
X-MC-Unique: of-6we2HNtuVbbKgpbrrbA-1
X-Mimecast-MFC-AGG-ID: of-6we2HNtuVbbKgpbrrbA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4349c5e58a3so6131455e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 01:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733390541; x=1733995341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGhsvxIAa/RUDZNcykbYv+PGXT3hSqjfx5KJygYAroU=;
 b=PtkjncwtImvLK8KaNS7rIzofy1B7jJ5HhbBQZxhK5HqxqANNEOEm6CmUUENaLilbzy
 H/ucXR/8OI2lgiAr6jWAjVtaL1YqDhuD4W2vwOUJtfG8d7w7V4D/PLc1OkIF7PMOT5ap
 3xVUCnZt84nopPBRxgBS6ed5/15ZhUhiGA6M9rGXlw9Vsh+0NIpaJuL5NaRsMFCbo2tq
 ZkrlZUZY4Md75BGPudGD0D+60bLV78kOznsRBCc4mSkdgUHQw6h0BK+YswaRfilhTEEB
 VbatFbxU+STCJGmjs++i+Z9jA2YGPjQJyGqY55FL1KUBgRVO5cpsbRl5u9/3DD1/mC8v
 BOSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIAhKiODdurVNCNqTG0e0j2m73ff5zsSgdJhFLYEdc+QZc6cUPf6OiifDP/sCePCkKQ76R9NfLBLnH@nongnu.org
X-Gm-Message-State: AOJu0Ywi3ZGYRDRLWsxuAXBoC4KBHc+xFCPfDigjmQTXBSflDhyBu0i0
 NTRAGXUPQ8burgAxwapBi2d43SbiKuTsBjjuZ/p+yONW4bCBH6TRSCz1GQacxe2vs/fwu1RgAGL
 OlPvM7zuXsM1GAZW4RGIy1jWSKTf/bIEinOjp7IhJIKqVFdbvtscG
X-Gm-Gg: ASbGncuv1lcp/u/0gojgQ1w3KV3ahLdCy+f1rlGegGcuNJP1uBxTQlaDwiAa34fC/zd
 5xJ6jctdjMZfGuQWMKjEJrGSJTxpRChxwZr5CUpFoLQ/5TfoB38X2L3vzWxCa0eSy3xYKIAMyNx
 71rnqCURz3kExIq+GskDOWxQjhnOEetTJj3hO/vTIC7vW874BCrCl5s1qYX8LziSanYpO4QuGWQ
 tg/cIFvURnjfDxgR3qry4bDOwFuOlBlrN63n2Sm2VbBw1TwK+SCohjbkhUXpNr63advH4h5Z9Pl
 RMXCRfQ8bzvAxT60H2uP+A==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-434d0a14eb7mr95742335e9.30.1733390541399; 
 Thu, 05 Dec 2024 01:22:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT4EGxhQ2he7SyDsdfd8Wk6mjcV8wUeXsFxJYCRu67z9LwO9sq7p4sNrm4N4vKaCBEjHCYOQ==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-434d0a14eb7mr95742175e9.30.1733390541030; 
 Thu, 05 Dec 2024 01:22:21 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52723fasm53651195e9.10.2024.12.05.01.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 01:22:20 -0800 (PST)
Date: Thu, 5 Dec 2024 10:22:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 13/16] acpi/ghes: better name the offset of the
 hardware error firmware
Message-ID: <20241205102219.274e3d27@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241205085959.2223d079@foz.lan>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
 <20b003136d8c008fd54e8d40c806f13867336e13.1733297707.git.mchehab+huawei@kernel.org>
 <20241204173759.6f02561a@imammedo.users.ipa.redhat.com>
 <20241205085959.2223d079@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 5 Dec 2024 08:59:59 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 4 Dec 2024 17:37:59 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Wed,  4 Dec 2024 08:41:21 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > The hardware error firmware is where HEST error structures are    
> >       ^^^^^^^^^^^^^^^^^^^^^^^ I can't parse this, suspect you've meant something else here
> >   
> > > stored. Those can be GHESv2, but they can also be other types.
> > > 
> > > Better name the location of the hardware error.
> > > 
> > > No functional changes.  
> 
> I meant this fw_cfg file:
> #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> 
> What about changing description to:
> 
> 	The etc/hardware_errors fw_cfg file is where the HEST error
> 	source structures are stored. Those can be GHESv2, but they can also
> 	be other types.

As I understand it, etc/hardware_errors is a blob
for '18.3.2.7.1. Generic Error Data' with some extra fields
to accommodate GHESv2 handling (i.e. err addr indirection and ack reg).

While error sources are described in HEST (and only GHES ones would
reference  etc/hardware_errors via error status addr/read ack register addr)

> 
> 	For more details about error source structure, see:
> 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source
> 
> 	Better name the address variable from ghes_error_le to hw_error_le
> 	to better reflect that.
> 
> 	No functional changes.
> 
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  hw/acpi/generic_event_device.c | 4 ++--
> > >  hw/acpi/ghes.c                 | 4 ++--
> > >  include/hw/acpi/ghes.h         | 2 +-
> > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > index 663d9cb09380..17baf36132a8 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -364,7 +364,7 @@ static const VMStateDescription vmstate_ghes = {
> > >      .version_id = 1,
> > >      .minimum_version_id = 1,
> > >      .fields = (const VMStateField[]) {
> > > -        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> > > +        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
> > >          VMSTATE_END_OF_LIST()
> > >      },
> > >  };
> > > @@ -372,7 +372,7 @@ static const VMStateDescription vmstate_ghes = {
> > >  static bool ghes_needed(void *opaque)
> > >  {
> > >      AcpiGedState *s = opaque;
> > > -    return s->ghes_state.ghes_addr_le;
> > > +    return s->ghes_state.hw_error_le;
> > >  }
> > >  
> > >  static const VMStateDescription vmstate_ghes_state = {
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index 52c2b69d3664..90d76b9c2d8c 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > >  
> > >      /* Create a read-write fw_cfg file for Address */
> > >      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> > > -        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> > > +        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> > >  
> > >      ags->present = true;
> > >  }
> > > @@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >      }
> > >      ags = &acpi_ged_state->ghes_state;
> > >  
> > > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > > +    start_addr = le64_to_cpu(ags->hw_error_le);
> > >  
> > >      start_addr += source_id * sizeof(uint64_t);
> > >  
> > > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > > index 21666a4bcc8b..39619a2457cb 100644
> > > --- a/include/hw/acpi/ghes.h
> > > +++ b/include/hw/acpi/ghes.h
> > > @@ -65,7 +65,7 @@ enum {
> > >  };
> > >  
> > >  typedef struct AcpiGhesState {
> > > -    uint64_t ghes_addr_le;
> > > +    uint64_t hw_error_le;
> > >      bool present; /* True if GHES is present at all on this board */
> > >  } AcpiGhesState;
> > >      
> >   
> 
> 
> 
> Thanks,
> Mauro
> 


