Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3B4C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJJQ-0007t1-3C; Fri, 24 Jan 2025 08:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbJJ5-0007qJ-0P
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbJJ2-00070G-3H
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737723662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhEWVaxKeikmxtBJ5SO9zg19epngSbsvs/Gow7w7f8I=;
 b=fSnsobmy4R73lVkxQpjd1mADYxJQ7xWH/2di6LPHhpgza3dnoRIlUGzp7rGMGAMczL/P3+
 2lndRSLjOlSEXvTtkcpTIxm2YZOLLsbhNYMGandDyalxB6tSCvyv423Bjd7m5V3VoU2i2J
 YURTDzls8zooY3hWsq+8ip8Axfod9T0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-30D0MaJ_OwSwRk9_0h-NUw-1; Fri, 24 Jan 2025 08:01:00 -0500
X-MC-Unique: 30D0MaJ_OwSwRk9_0h-NUw-1
X-Mimecast-MFC-AGG-ID: 30D0MaJ_OwSwRk9_0h-NUw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4359eb032c9so14644605e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 05:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737723659; x=1738328459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhEWVaxKeikmxtBJ5SO9zg19epngSbsvs/Gow7w7f8I=;
 b=SYq2UzltPHzVd7m9aji3EsVkEP5PrKflbaXU2mzJ2Tc5uExulyC41DZkKIaP2pi6BO
 dL1KxGXvsr3Nwy6bt/YWbYLkw1ACPsFoYOfjlNxxkH+zXZ4HrO7kWL7oZMfeqEq2eQHJ
 9LF70tsZUT2vWtVKce70bZxGFIrhhAKQuxzApKRxL7owk/h+BV/Fi+cozKyrw9koav93
 75naxk+8+jwowT8C8q377hFna9LtYI91l2IHmX5fahghjHgYyf8i7fh/uJf3XSoFWsKo
 Bs/mxPv2dLT8Yj7MrUBgSp0fXtlVJEONKnwEhGOpIyALBo69/IX3SkC3rpcLFjRq5FFe
 gpPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUMZUABIlaQKn8Gc7SQaeFCDOJ31Xr46Xtu4AHHhoS5urMHL/tJOAuvbT0BiIHpTGMjnmveZqniUor@nongnu.org
X-Gm-Message-State: AOJu0YyFeA8uSxpHxLqjDTOc56vMp3SpxbfWA36PwaiuxiPD0rF1s2B3
 X815QVgdevGJil4Le871fPVHlPH8cZw8OCu3/gwlemAEuuaFo/tUIt8PjVEWl4dhoFzVQ1kWhKB
 Z01IdtUgTFJyVikdcEj8eLTtkp1/COWHuJwouQyO0CAFbZ6pdbRwl
X-Gm-Gg: ASbGnctw+RHrt5c1Afd5Ipp2lVhPWMTqD/kcVg/80Xj91cgcaveSrlQozxzqxNx0AMo
 2cIc0nBay/sAYZG2r6ouakiEroKFDw7HNWfpwnaEMyoBSjaiJFDBLqIhZsy4pXQ33TRW6LhXKxM
 ALez7P8TJPKXY04G3RWjMnbN3kaXqm4ipCnnw3NEYBqECvjy4wxuNbuBhiSQ3J2K4lwyj+rdCD0
 xMSrYpHsz8JrbFhe0TOEobb7lRrtq93EsRpBSPfasAcT6XN0jnuNkpm0cNkYXuhzeorFRcBdWKt
 5Ru6DPv8GB7Jp1Q4OpKQMiqdLeMlTQxoJ0Ntxph+vg==
X-Received: by 2002:a05:6000:1f85:b0:385:e374:be1 with SMTP id
 ffacd0b85a97d-38bf5662b18mr28603911f8f.13.1737723659232; 
 Fri, 24 Jan 2025 05:00:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNdnSYVkLN0W7EV86sq4qrC5JldVfmcOMcj0YhiKmcOETN+KR3k8MwLJ3VyzAMUkpiTfPPDw==
X-Received: by 2002:a05:6000:1f85:b0:385:e374:be1 with SMTP id
 ffacd0b85a97d-38bf5662b18mr28603828f8f.13.1737723658728; 
 Fri, 24 Jan 2025 05:00:58 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4161sm2566964f8f.88.2025.01.24.05.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 05:00:58 -0800 (PST)
Date: Fri, 24 Jan 2025 14:00:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, rick.p.edgecombe@intel.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 40/60] hw/i386: add eoi_intercept_unsupported member
 to X86MachineState
Message-ID: <20250124140057.2f2bb674@imammedo.users.ipa.redhat.com>
In-Reply-To: <00ecb103-2f0b-479d-bae8-cb3f7bace3be@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-41-xiaoyao.li@intel.com>
 <20250123134148.036d52b0@imammedo.users.ipa.redhat.com>
 <00ecb103-2f0b-479d-bae8-cb3f7bace3be@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 24 Jan 2025 00:45:50 +0800
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> On 1/23/2025 8:41 PM, Igor Mammedov wrote:
> > On Tue,  5 Nov 2024 01:23:48 -0500
> > Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> >   
> >> Add a new bool member, eoi_intercept_unsupported, to X86MachineState
> >> with default value false. Set true for TDX VM.  
> > 
> > I'd rename it to enable_eoi_intercept, by default set to true for evrything
> > and make TDX override this to false.  
> >>
> >> Inability to intercept eoi causes impossibility to emulate level
> >> triggered interrupt to be re-injected when level is still kept active.
> >> which affects interrupt controller emulation.
> >>
> >> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >>   hw/i386/x86.c         | 1 +
> >>   include/hw/i386/x86.h | 1 +
> >>   target/i386/kvm/tdx.c | 2 ++
> >>   3 files changed, 4 insertions(+)
> >>
> >> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> >> index 01fc5e656272..82faeed24ff9 100644
> >> --- a/hw/i386/x86.c
> >> +++ b/hw/i386/x86.c
> >> @@ -370,6 +370,7 @@ static void x86_machine_initfn(Object *obj)
> >>       x86ms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
> >>       x86ms->bus_lock_ratelimit = 0;
> >>       x86ms->above_4g_mem_start = 4 * GiB;
> >> +    x86ms->eoi_intercept_unsupported = false;
> >>   }
> >>   
> >>   static void x86_machine_class_init(ObjectClass *oc, void *data)
> >> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> >> index d43cb3908e65..fd9a30391755 100644
> >> --- a/include/hw/i386/x86.h
> >> +++ b/include/hw/i386/x86.h
> >> @@ -73,6 +73,7 @@ struct X86MachineState {
> >>       uint64_t above_4g_mem_start;
> >>   
> >>       /* CPU and apic information: */
> >> +    bool eoi_intercept_unsupported;
> >>       unsigned pci_irq_mask;
> >>       unsigned apic_id_limit;
> >>       uint16_t boot_cpus;
> >> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> >> index 9ab4e911f78a..9dcb77e011bd 100644
> >> --- a/target/i386/kvm/tdx.c
> >> +++ b/target/i386/kvm/tdx.c
> >> @@ -388,6 +388,8 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> >>           return -EOPNOTSUPP;
> >>       }
> >>   
> >> +    x86ms->eoi_intercept_unsupported = true;  
> > 
> > I don't particulary like accel go to its parent (machine) object and override things there
> > and that being buried deep inside.  
> 
> I would suggest don't see TDX as accel but see it as a special type of 
> x86 machine.
> 
> > How do you start TDX guest?
> > Is there a machine property or something like it to enable TDX?  
> 
> via the "confidential-guest-support" property.
> This series introduces tdx-guest object and we start a TDX guest by:
> 
> $qemu-system-x86_64 -object tdx-guest,id=tdx0 \
>      -machine ...,confidential-guest-support=tdx0

then the property setter would be a logical place to set
 eoi_intercept_unsupported = false
when its value is tdx0

> 
> >> +
> >>       /*
> >>        * Set kvm_readonly_mem_allowed to false, because TDX only supports readonly
> >>        * memory for shared memory but not for private memory. Besides, whether a  
> >   
> 


