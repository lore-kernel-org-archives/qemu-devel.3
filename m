Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55601C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsEs-0006QA-9I; Wed, 05 Jun 2024 11:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sEsEr-0006Pt-BM
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sEsEm-0002Mo-Dc
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717600059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e35qjsyccZfefOnL0gdhf9y4wVpfLI/EMgKoYs72SN4=;
 b=PxoNY6sKnAAaJSFLFhTaUA4zfYWhADG/bSegwwpDKHwvlW2xtfh+8XC6xnZvZbqmxWvfzq
 /VoBJ3pnZcJEtwl8lTYC5ntGj1rGiAIIqcBB6pRSQfuPMhVOqDrzgvgvbCtXdj/SZSXVH6
 KiggqKvr1El6qO5wd/HGYSm10smIIm4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-mH8c9pXLNVmFidNu_FMNSA-1; Wed, 05 Jun 2024 11:07:37 -0400
X-MC-Unique: mH8c9pXLNVmFidNu_FMNSA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35dced40d17so1655549f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 08:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717600056; x=1718204856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e35qjsyccZfefOnL0gdhf9y4wVpfLI/EMgKoYs72SN4=;
 b=vKEkl8PpPYqp9myQQVCl+POHMCP7iqOCTLDqcz+TWoD5/YtHf7DsQKcNtbBeTR3hz6
 bM//ludvVkB3WNgc8RZ0Wkel0si8LleJ/v1eGsCdRHE1LbzlBxCoCmerhU8qyOslJaAT
 Yf4fh0wdASnK3WhFj6VvbJTlS8jVGaSxDprBlHS1n/Mlppo7Ws264blezIQtCHvazRz2
 lu0mVDKVqfyM9T3vy4keXBix2rL9jNL8/aoKs2c9gFkDnX230ql8/F+75riLYoH2PKg2
 3JWlZ6nrB0beldL1V28Gmyt5vW6ppZgC/+dCmlxz7sEdrlhssZEsZW1K49v79n1FEz7m
 85DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWch7PDARA7gP+rIjreMW7kgJkw4raXMC5aXseGxZ0Hd691oS4aNogEMUqfFLLjqQRufkxWvlZ3jmsOMMpTrOjfcQ9FiWE=
X-Gm-Message-State: AOJu0YwDn4dZLrJDD4WmShEWFpbe40A7a1xtmkxpsziW9Hrq+se8vGuW
 rrsAhFb/hkJuS9a08/mxUPwo9C+2+QH+Y+EfUttPLtAik3Kg4GRnVAeOf8qCWUsQxg86HZSTcsR
 eqnOtOtQxQVZnrIA759egOpte2UY8MhsN/o6v6a2Cpcc7ixDkJUg4
X-Received: by 2002:a5d:424f:0:b0:35e:5189:2d73 with SMTP id
 ffacd0b85a97d-35e8ef9a012mr1982485f8f.63.1717600056649; 
 Wed, 05 Jun 2024 08:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVEJXbzgrZPUtNGH9RV7+CPBZCPJUJxMLO/iCzkbBoRf7T2ChZCVasHcy740OOQ0VmfGAlJg==
X-Received: by 2002:a5d:424f:0:b0:35e:5189:2d73 with SMTP id
 ffacd0b85a97d-35e8ef9a012mr1982459f8f.63.1717600056157; 
 Wed, 05 Jun 2024 08:07:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bbb1sm14781718f8f.101.2024.06.05.08.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 08:07:35 -0700 (PDT)
Date: Wed, 5 Jun 2024 17:07:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org, Sean Christopherson
 <seanjc@google.com>
Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
 x86_cpu_filter_features
Message-ID: <20240605170735.5a3924cd@imammedo.users.ipa.redhat.com>
In-Reply-To: <dcd913cd-10ce-45c9-9ed8-79b9c42c234b@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240524200017.150339-3-zide.chen@intel.com>
 <ZlluoKXUF6ctecVt@intel.com>
 <04d3dfd8-93d2-493d-82d1-8fbcad6ecd22@intel.com>
 <Zls9v9mg17SXZhO7@intel.com>
 <20240603113022.6569043b@imammedo.users.ipa.redhat.com>
 <dcd913cd-10ce-45c9-9ed8-79b9c42c234b@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 3 Jun 2024 14:29:50 -0700
"Chen, Zide" <zide.chen@intel.com> wrote:

> On 6/3/2024 2:30 AM, Igor Mammedov wrote:
> > On Sat, 1 Jun 2024 23:26:55 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> >   
> >> On Fri, May 31, 2024 at 10:13:47AM -0700, Chen, Zide wrote:  
> >>> Date: Fri, 31 May 2024 10:13:47 -0700
> >>> From: "Chen, Zide" <zide.chen@intel.com>
> >>> Subject: Re: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
> >>>  x86_cpu_filter_features
> >>>
> >>> On 5/30/2024 11:30 PM, Zhao Liu wrote:    
> >>>> Hi Zide,
> >>>>
> >>>> On Fri, May 24, 2024 at 01:00:16PM -0700, Zide Chen wrote:    
> >>>>> Date: Fri, 24 May 2024 13:00:16 -0700
> >>>>> From: Zide Chen <zide.chen@intel.com>
> >>>>> Subject: [PATCH V2 2/3] target/i386: call cpu_exec_realizefn before
> >>>>>  x86_cpu_filter_features
> >>>>> X-Mailer: git-send-email 2.34.1
> >>>>>
> >>>>> cpu_exec_realizefn which calls the accel-specific realizefn may expand
> >>>>> features.  e.g., some accel-specific options may require extra features
> >>>>> to be enabled, and it's appropriate to expand these features in accel-
> >>>>> specific realizefn.
> >>>>>
> >>>>> One such example is the cpu-pm option, which may add CPUID_EXT_MONITOR.
> >>>>>
> >>>>> Thus, call cpu_exec_realizefn before x86_cpu_filter_features to ensure
> >>>>> that it won't expose features not supported by the host.
> >>>>>
> >>>>> Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
> >>>>> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> >>>>> ---
> >>>>>  target/i386/cpu.c         | 24 ++++++++++++------------
> >>>>>  target/i386/kvm/kvm-cpu.c |  1 -
> >>>>>  2 files changed, 12 insertions(+), 13 deletions(-)
> >>>>>
> >>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >>>>> index bc2dceb647fa..a1c1c785bd2f 100644
> >>>>> --- a/target/i386/cpu.c
> >>>>> +++ b/target/i386/cpu.c
> >>>>> @@ -7604,6 +7604,18 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> >>>>>          }
> >>>>>      }
> >>>>>  
> >>>>> +    /*
> >>>>> +     * note: the call to the framework needs to happen after feature expansion,
> >>>>> +     * but before the checks/modifications to ucode_rev, mwait, phys_bits.
> >>>>> +     * These may be set by the accel-specific code,
> >>>>> +     * and the results are subsequently checked / assumed in this function.
> >>>>> +     */
> >>>>> +    cpu_exec_realizefn(cs, &local_err);
> >>>>> +    if (local_err != NULL) {
> >>>>> +        error_propagate(errp, local_err);
> >>>>> +        return;
> >>>>> +    }
> >>>>> +
> >>>>>      x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);    
> >>>>
> >>>> For your case, which sets cpu-pm=on via overcommit, then
> >>>> x86_cpu_filter_features() will complain that mwait is not supported.
> >>>>
> >>>> Such warning is not necessary, because the purpose of overcommit (from
> >>>> code) is only to support mwait when possible, not to commit to support
> >>>> mwait in Guest.
> >>>>
> >>>> Additionally, I understand x86_cpu_filter_features() is primarily
> >>>> intended to filter features configured by the user,     
> >>>
> >>> Yes, that's why this patches intends to let x86_cpu_filter_features()
> >>> filter out the MWAIT bit which is set from the overcommit option.    
> >>
> >> HMM, but in fact x86_cpu_filter_features() has already checked the MWAIT
> >> bit set by "-overcommit cpu-pm=on". ;-)
> >>
> >> (Pls correct me if I'm wrong) Revisiting what cpu-pm did to MWAIT:
> >> * Firstly, it set MWAIT bit in x86_cpu_expand_features():
> >>   x86_cpu_expand_features()  
> >>      -> x86_cpu_get_supported_feature_word()
> >>         -> kvm_arch_get_supported_cpuid()    
> >>  This MWAIT is based on Host's MWAIT capability. This MWAIT enablement
> >>  is fine for next x86_cpu_filter_features() and x86_cpu_filter_features()
> >>  is working correctly here!
> >>
> >> * Then, MWAIT was secondly set in host_cpu_enable_cpu_pm() regardless
> >>   neither Host's support or previous MWAIT enablement result. This is
> >>   the root cause of your issue.
> >>
> >> Therefore, we should make cpu-pm honor his first MWAIT enablement result
> >> instead of repeatly and unconditionally setting the MWAIT bit again in
> >> host_cpu_enable_cpu_pm().
> >>
> >> Additionally, I think the code in x86_cpu_realizefn():
> >>   cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
> >> has the similar issue because it also should check MWAIT feature bit.
> >>
> >> Further, it may be possible to remove cpu->mwait: just check the MWAIT
> >> bit in leaf 5 of cpu_x86_cpuid(), and if MWAIT is present, use host's
> >> mwait info plus CPUID_MWAIT_EMX | CPUID_MWAIT_IBE.  
> > 
> > Agreed with above analysis,
> > we shouldn't have host_cpu_enable_cpu_pm() as kvm_arch_get_supported_cpuid
> > gets us MWAIT already.  
> 
> Yes, I agree don't need to set CPUID_EXT_MONITOR besides
> kvm_arch_get_supported_cpuid().
> 
> > 
> > filling in cpu->mwait.ecx is benign mistake which likely doesn't
> > trigger anything if CPUID_EXT_MONITOR is not present.
> > But for clarity it's better to add an explicit check there as well.  
> 
> Yes, I agree without MWAIT available and advertised, it's meaningless to
> set the EMX and IBE bits. Seems to me it's cleaner to remove cpu->mwait
> all together, and in cpu_x86_cpuid(), just read from host_cpuid(5) if
> MWAIT is available to the guest. But I don't understand the history of
> why QEMU unconditionally advertises these two bits, and don't know it it
> could break some thing if these two bits are removed.
> 
> Even if we want to fix these two bits, we can do it in another separate
> patch.
> 
> e737b32a36 (" Core 2 Duo specification (Alexander Graf).")
> unconditionally adds "CPUID_MWAIT_EMX | CPUID_MWAIT_IBE" to CPUID.5.ECX
> with further explanation.
> 
> 2266d44311 ("i386/cpu: make -cpu host support monitor/mwait") adds
> comment "We always wake on interrupt even if host does not have the
> capability" to CPUID_MWAIT_IBE.
> 
> 
> >   
> >>  
> >>>> and the changes of
> >>>> CPUID after x86_cpu_filter_features() should by default be regarded like
> >>>> "QEMU knows what it is doing".    
> >>>
> >>> Sure, we can add feature bits after x86_cpu_filter_features(), but I
> >>> think moving cpu_exec_realizefn() before x86_cpu_filter_features() is
> >>> more generic, and actually this is what QEMU did before commit 662175b91ff2.
> >>>
> >>> - Less redundant code. Specifically, no need to call
> >>> x86_cpu_get_supported_feature_word() again.
> >>> - Potentially there could be other features could be added from the
> >>> accel-specific realizefn, kvm_cpu_realizefn() for example.  And these
> >>> features need to be checked against the host availability.    
> >>
> >> Mainly I don't think this reorder is a direct fix for the problem (I
> >> just analyse it above), also in your case x86_cpu_filter_features() will
> >> print a WARNING when QEMU boots, which I don't think is cpu-pm's intention.  
> > 
> > There is no problem with warning, I'd even say it's a good thing.  
> 
> I agree it's good to have the warning as well.
> 
> > But you are right reordering just masks the issue.
> > 
> > As for expected behavior, if user asked for "-overcommit cpu-pm=on"
> > there are 2 options:
> >    * it's working as expected (mwait exiting is enabled successfully with CPUID MONITOR bit set)
> >    * QEMU shall fail to start.  
> 
> I like the idea that QEMU refuses to launch the guest if the asked CPU
> features are not available, which is more user friendly.  But the
> problem is, "-overcommit cpu-pm=on" is an umbrella which intends to
> enable all the following CPUIDs and KVM features if it's possible.  So,
> if QEMU fails the guest in this case, then it needs to fail the WAITPKG
> feature as well. Additionally, it may need to provide individual options
> to enable these individual features, which I doubt could be too complicated.

how about

kvm_arch_init()
    ...
    if (enable_cpu_pm) {                                                         
        int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);   

/* Work around for kernel header with a typo. TODO: fix header and drop. */      
#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)    
#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL                      
#endif                                   
                                        
above comment probably needs to be cleaned up

        if (disable_exits) {                                                     
            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |                      
                              KVM_X86_DISABLE_EXITS_HLT |                        
                              KVM_X86_DISABLE_EXITS_PAUSE |                      
                              KVM_X86_DISABLE_EXITS_CSTATE);                     
        }  

fail here if filtered disable_exits is an empty set?                                                                
                                                                                 
        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,                 
                                disable_exits);                                  
        if (ret < 0) {                                                           
            error_report("kvm: guest stopping CPU not supported: %s",            
                         strerror(-ret));                                        
        }                                                                        
    }                                                                            
      


> KVM_X86_DISABLE_EXITS_MWAI
> KVM_X86_DISABLE_EXITS_HLTKVM_X86_DISABLE_EXITS_PAUSE
> KVM_X86_DISABLE_EXITS_CSTATE
> CPUID.7.0:ECX.WAITPKG
> CPUID.1.ECX.MWAIT
> 


