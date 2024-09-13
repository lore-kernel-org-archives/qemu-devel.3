Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF22FA3753
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6Ii-0005Kf-S6; Fri, 13 Sep 2024 09:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp6Ih-0005IW-3M
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp6Ie-00045k-Sc
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726233923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPe0SUBJEdHvLb4sF5N4GC0rJ9nP/aoSGOggzvDbl8g=;
 b=ItC7gH58h/jTitrvUBFp17o/zpmwoC7k6Gev6sQvx5fnXEbyE08bTrGMh8vTyiMRx4H+QH
 jHDPLhUSbFa5sE8JQiNN89ZZS15UHsAil5ZTpRzM9aAzqzSQ0LSqyA4HoLzEiAyzQY5OzR
 bIzUuLeMMzQhDD9oCILplcLnNrXxHek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-PTUkDXjmNWGWjKbquZ-h_Q-1; Fri, 13 Sep 2024 09:25:21 -0400
X-MC-Unique: PTUkDXjmNWGWjKbquZ-h_Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cacba219cso6818755e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 06:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726233920; x=1726838720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPe0SUBJEdHvLb4sF5N4GC0rJ9nP/aoSGOggzvDbl8g=;
 b=qWfHcMS7t7vcyqSVdNJla3ymRYQHclbHfHfOL3NPNheWL5qQxHEX/BMqO/TeZV67AD
 WZefD06zLrk8bLVP8VzHnrR3XXAyDeMdrjReI/4BkIMetrebhifXzEJ2LaX15thTauQM
 7fsja7VlgbAiaI6YYePTL9Wbfb4aRGpMiUT7bOqF1psfAXvECjofc8PfKeyjvxxnuJ+B
 1udjgFF74QRyUUXhyQry6qIEtjH0heubNiawQAAAwrkmhpMh+cmu9mlp6SdSPOGVQPXD
 RtU+Ie84+qHLRXep5g41CmAuMe2SDme4+SW38wniO1rV0tYRWtjJXE40M1X3YluZDmv3
 B5rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3xCkr7fLMOG8e9eHT2/aUy8QQxXnak3SDfq60Ru1GIDtKK9uaZekHc1tXYKd1YAQPA2XeBSSEVst8@nongnu.org
X-Gm-Message-State: AOJu0Yz+gvDHevU1K5ePklMpy9ldsSQufVkjGUxS8rx8gUD+n7zFYUkN
 5ARs4MrO+Y5r9ofnRH6USAYLEcb+wuB2ya+vGUvBNe/7hIbOBVe0lRNxFc6hrWaVo2PGPiy+Crl
 dIr0B31zG9fu+5+zKMelWHYJt0253942siirYGmlvnkV1rwdZZfo4
X-Received: by 2002:a5d:4cc6:0:b0:368:5a8c:580b with SMTP id
 ffacd0b85a97d-378d61e2b19mr1816923f8f.19.1726233919950; 
 Fri, 13 Sep 2024 06:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0CWqp6VUNlYFtn66EgOGFI6WMHtPVYF+6fIDqre+6lLpa6ilT1SI2rwIcw8Qy8bM+8GJkNg==
X-Received: by 2002:a5d:4cc6:0:b0:368:5a8c:580b with SMTP id
 ffacd0b85a97d-378d61e2b19mr1816895f8f.19.1726233919319; 
 Fri, 13 Sep 2024 06:25:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d35e5sm17032360f8f.76.2024.09.13.06.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 06:25:18 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:25:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST address
Message-ID: <20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240913074435.0eea2552@foz.lan>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
 <20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
 <20240913074435.0eea2552@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 13 Sep 2024 07:44:35 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 11 Sep 2024 15:51:08 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Sun, 25 Aug 2024 05:45:56 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Store HEST table address at GPA, placing its content at
> > > hest_addr_le variable.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > 
> > This looks good to me.
> > 
> > in addition to this, it needs a patch on top to make sure
> > that we migrate hest_addr_le.
> > See a08a64627b6b 'ACPI: Record the Generic Error Status Block address'
> > and fixes on top of that for an example.  
> 
> Hmm... If I understood such change well, vmstate_ghes_state() will
> use this structure as basis to do migration:
> 
> 	/* ghes.h */
> 	typedef struct AcpiGhesState {
> 	    uint64_t hest_addr_le;
> 	    uint64_t ghes_addr_le;
> 	    bool present; /* True if GHES is present at all on this board */
> 	} AcpiGhesState;
> 
> 	/* generic_event_device.c */
> 	static const VMStateDescription vmstate_ghes_state = {
> 	    .name = "acpi-ged/ghes",
> 	    .version_id = 1,
> 	    .minimum_version_id = 1,
> 	    .needed = ghes_needed,
> 	    .fields      = (VMStateField[]) {
> 	        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> 	                       vmstate_ghes_state, AcpiGhesState),
> 	        VMSTATE_END_OF_LIST()
> 	    }
> 	};

current code looks like that:
                                                                                 
static const VMStateDescription vmstate_ghes = {                                 
    .name = "acpi-ghes",                                                         
    .version_id = 1,                                                             
    .minimum_version_id = 1,                                                     
    .fields = (const VMStateField[]) {                                           
        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),   <<===                         
        VMSTATE_END_OF_LIST()                                                    
    },                                                                           
};                                                                               
                                                                                 
static bool ghes_needed(void *opaque)                                            
{                                                                                
    AcpiGedState *s = opaque;                                                    
    return s->ghes_state.ghes_addr_le;                                           
}                                                                                
                                                                                 
static const VMStateDescription vmstate_ghes_state = {                           
    .name = "acpi-ged/ghes",                                                     
    .version_id = 1,                                                             
    .minimum_version_id = 1,                                                     
    .needed = ghes_needed,                                                       
    .fields = (const VMStateField[]) {                                           
        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,                              
                       vmstate_ghes, AcpiGhesState),                             
        VMSTATE_END_OF_LIST()                                                    
    }                                                                            
};  

where 
    VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
explicitly defines field(s) within structure to be sent over wire.

we need to add a conditional field for ghes_addr_le
which will be sent only with new machine types, but not with old ones
to avoid migration breakage.

I don't know much about migration, but maybe we can get away with
similar condition as in ghes_needed(), or enabling QMP error injection
based on machine type version.

Or maybe adding a CLI option to enable QMP error injection in which
case the explicit option would serve as a trigger enable QMP command and
to migrate hest_addr_le.
It might be even better this way, since machine wouldn't need to
carry extra error source that will be used only for testing
and practically never in production VMs (aka reduced attack surface).

You can easily test it locally:
  new-qemu: with your patches
  old-qemu: qemu-9.1

and then try to do forth & back migration for following cases:
  1. (ping-pong case with OLD firmware/ACPI tables)
     start old-qemu with 9.1 machine type ->
       migrate to file ->
       start new-qemu with 9.1 machine type -> restore from file ->
       migrate to file ->
       start old-qemu with 9.1 machine type ->restore from file ->
       
  2.  (ping-pong case with NEW firmware/ACPI tables)
      do the same as #1 but starting with new-qemu binary

(from upstream pov #2 is optional, but not implementing it
is pain for downstream so it's better to have it if it's not
too much work)

> 	/* hw/arm/virt-acpi-build.c */
> 	void virt_acpi_setup(VirtMachineState *vms)
> 	{
> 	    ...
> 	    if (vms->ras) {
> 	        assert(vms->acpi_dev);
> 	        acpi_ged_state = ACPI_GED(vms->acpi_dev);
> 	        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
> 	                             vms->fw_cfg, tables.hardware_errors);
> 	    }
> 
> Which relies on acpi_ghes_add_fw_cfg() function to setup callbacks for
> the migration:
> 
> 	/* ghes.c */
> 	void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> 	                          GArray *hardware_error)
> 	{
> 	    /* Create a read-only fw_cfg file for GHES */
> 	    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
> 	                    hardware_error->len);
> 
> 	    /* Create a read-write fw_cfg file for Address */
> 	    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> 	        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> 
> 	    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> 	        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> 
> 	    ags->present = true;
> 	}
> 
> It sounds to me that both ghes_addr_le and hest_addr_le will be migrated
> altogether.

fwcfg callbacks are irrelevant to migration, they tell firmware what to do
with specified addresses (in our case, write into ags->hest_addr_le address
of HEST), so that HW (qemu) would know where firmware placed the table.
But that's about all it does.

> 
> Did I miss something?
> 
> Thanks,
> Mauro
> 


