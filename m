Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AC1CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xImOe-0005um-1z; Mon, 19 Oct 2026 08:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliveriandrea@gmail.com>)
 id 1xImOW-0005te-8d
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:23:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oliveriandrea@gmail.com>)
 id 1xImOR-0006en-Fa
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:23:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso22010045e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792412585; cv=none;
 d=google.com; s=arc-20260327;
 b=iYQ/ltcHifM8rCz+DO1jpLG9xopGs+V8GZHWhVawR1QTNqgF30Ct3XPwb9T2XRcSAE
 RCXgTfIGmKlCOo2/outfp5QjauCeLjm5AtADlBqEl2XiRXl+zWpNe2//u9eojZqsRMQD
 kQT0WVujgd5NmJC++Zs2ohv1kTby4FsAUr1bCCNeR0arcnBdK0FWR9g+Z/gfru+DGcU4
 bRDjUP4bAj2KnnXA6rGnLEBNej3ffDrYQ0GGe3qu5cgI51+AYtYeY8D+Kqy3sJ+ZmjBS
 L0bayeUrJGB3DqTCZqhI81GHRLiDsECa1xcR17ffNhlcRlX05sNXHFhzgbzO2hWv39Ee
 KBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VA0EaIAkAmiZf6ZT8orDontSqBSCrvS6TUwqvQWmRwY=;
 fh=tvxSDFqjF2zpV4b/YzbzCnqE+k/OBXv9RUajQ4/xqiY=;
 b=IKz3k3NDsats3zGB3Ike4C1Dd1PiJAJA9jwbBzA1jljsHWNNrwGt6XtG40lcQA2AHe
 sxtFecFA3nw1Ls6JnjNbTPp8vGCRnKJL2IhmHMP6qqUNBfZ9EU7t2cY6fgChSGXrWg8r
 +IexsY3KL4Pp4QjhgAWFSXRJYaSMy5r3ITvHdbhEab7b5mehMSeX8LV6J80jrnZHPZnO
 hcfOemI1M5CDa5TtOgE/2Eryz7agpdgQIFu0CIGuXnvm1gokRWS19GvfZub5fJehgaOB
 LCE/hd/cbb1vEeHl6YvBmR9dz8gsxfiXsJ4yiKkIUHP0CYVcJ0Boux+U4+w8lVDhc8qF
 p+ag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792412585; x=1793017385; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VA0EaIAkAmiZf6ZT8orDontSqBSCrvS6TUwqvQWmRwY=;
 b=POyebW3ImJNGxhYk5bTWX0QIIP/cgZ0EHkx4HRnw5grmy+Pb4O8zHxyQjNfYbIbdlP
 iqYR55EF+Ha0HiBATMVyxSo6uSahadnf7MVSTLOFWysu3Tey8J79hNBs+VQwcStXz8FA
 e4Pk8vKZfLxRGbFtgEZUpwaZx6OwqQGsLrnrjrCjruqwJ2RRQGjxerPbYRijcd7zv3Kw
 p9WAUhVV6kOeie36GZOL6ENaXTpS2ckiivNt8R8ud35yu0WY+iGsA3BzkovkXAQ6q+L2
 bmVbZhHy1PPNdwetVKUFLI9i2AgC4bZdQN3Qhm2nHMIKVm2Slu8AshrHguudHj8USsQ0
 RrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792412585; x=1793017385;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VA0EaIAkAmiZf6ZT8orDontSqBSCrvS6TUwqvQWmRwY=;
 b=e0jjPSHXXvQZfn7mORBBiqk2jJA2cm6xBRXGwcUTvG0xEGNZOAmRFDlZora0SML5Kh
 KkNENQOt3W0+JOavFFPHgumDRnuUJFQopoJQ9Wxxyroe3rM2hnHS1nlgI7YQeHDKGxZ6
 5JLqRbaXZnKErwtjlRi1FnZ4Kme+xOmIol5ZZD+1JYI1pbhk9S75mh6XRXxr0W2oi+bH
 nrtjTUq0ayNHHNTa0lK8CUD2PEXlOiPDrUaJT7s0raniQtsST5ySD+JAGJUA2g/Z8fZW
 xq+e8vX+GtwhBBUHcY/PUS62oK1lNnDtPGDix8uJ+bC4wIVwmOcOdn9b9sTpF4RZpJTS
 vtlQ==
X-Gm-Message-State: AFq9FYJFeqjDrk0VJ8MlLN9cdOT0qJhl+mLF209BtgBx7s3a/zK8DJol
 4firVDOzFvMFRsVZkZ+ienooJwIkiksoSlaiXilq82BEaoezZ5hYpZD4NHOQhK7if951uqCLAjl
 YQovo0i5GadlrorEk85DEL+epE/0cmoY=
X-Gm-Gg: AYBFou0T0cy82B0Xc0nFD6g6+ffnBGtVj34jF1fYcf1M5Ku3DVOdikdsJ0dDROnsDTa
 9Gnk7C0dB4N76qoNIVlRYUQoDhO33EFlGWN5R2tnVv3TQiW7XMueIGZwV82DQLv54luzrZnjvVJ
 86yT5cvUz/gxnNReWlWGElMwnI83CEd/IK58Q08Dr202/rYnbzR0R69rTvFkKL/va4HYs4u2hf/
 B3lO/uYafXEwmfMGkN3zDTPbzg9lA1svx1FJ8jJshn12WIC4x7EY8tOCz+eqRRum52FzSATk/ax
 vjaxQTUi/oQ3BSDNcajzhbYdn1zgQDbsgTeU697FdDniwxtRnKPi0JFxE+BXDQAG
X-Received: by 2002:a05:600c:3e0a:b0:4a1:ef9d:1b68 with SMTP id
 5b1f17b1804b1-4a1ef9d1bcemr16345515e9.10.1792412584996; Mon, 19 Oct 2026
 05:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20261016234027.1002275-1-oliveriandrea@gmail.com>
 <kupbj8qt5pi.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
In-Reply-To: <kupbj8qt5pi.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
From: Andrea Oliveri <oliveriandrea@gmail.com>
Date: Mon, 19 Oct 2026 14:22:52 +0200
X-Gm-Features: AclHuK-8Uy5ANTpIKNhgJxOtHM4Dy6KGtcg5EkQBm7luqUiMMNutoR1waQmVy54
Message-ID: <CAN2kSaqJMAvYi6rw3YC46d=SzKBFopjdRkv7GQX8K=3w6DOL9g@mail.gmail.com>
Subject: Re: [PATCH] i386: Hyper-V nested sleep states enlightenment
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=oliveriandrea@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Oh, I didn't see these two patches. They patch exact the same bug as mine.
Sorry, please retire mine and continue with the existing ones
(that patches also KVM hypercall side).
Sorry again

Andrea

Il giorno lun 19 ott 2026 alle ore 11:11 Vitaly Kuznetsov
<vkuznets@redhat.com> ha scritto:
>
> Andrea Oliveri <oliveriandrea@gmail.com> writes:
>
> > Hyper-V running nested on KVM (e.g. Windows with Virtualization-Based
> > Security) allows hibernation of its root partition only if the parent
> > hypervisor sets bit 20 of HV_CPUID_ENLIGHTMENT_INFO.EAX. KVM never sets
> > it, so such guests report "The hypervisor does not support hibernation".
> >
> > Add a "hv-nested-sleep" property that sets the bit. It is a hint
> > only and needs no KVM support. With it, Windows 11 26H2 with VBS,
> > HVCI and Credential Guard hibernates and resumes.
> >
> > The nested hypervisor uses the bit for one more thing, on resume:
> > instead of writing IA32_TSC itself, it issues hypercall 0x103 with the
> > TSC and the parent reference time saved at suspend, asking the parent
> > to restore its TSC. KVM returns HV_STATUS_INVALID_HYPERCALL_CODE;
> > the nested hypervisor ignores the status and already compensates the
> > TSC jump in software, so the guest clock stays correct.
> >
> > Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>
>
> Please take a look at the competing proposal:
>
> QEMU:
> https://lore.kernel.org/qemu-devel/20261005194057.10910-1-hmushi@amazon.co.uk/
> KVM: https://lore.kernel.org/kvm/20261005192431.87317-4-hmushi@amazon.co.uk/
>
> > ---
> >  docs/system/i386/hyperv.rst    | 10 ++++++++++
> >  target/i386/cpu.c              |  1 +
> >  target/i386/cpu.h              |  1 +
> >  target/i386/kvm/hyperv-proto.h |  1 +
> >  target/i386/kvm/kvm.c          |  5 +++++
> >  5 files changed, 18 insertions(+)
> >
> > diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> > index e1babffb0f..4b37d5536b 100644
> > --- a/docs/system/i386/hyperv.rst
> > +++ b/docs/system/i386/hyperv.rst
> > @@ -187,6 +187,16 @@ Existing enlightenments
> >    Note: enabling this feature on old hardware (without APICv/AVIC support) may
> >    have negative effect on guest's performance.
> >
> > +``hv-nested-sleep``
> > +  Tells a guest that runs its own Hyper-V (Windows with Virtualization-Based
> > +  Security, or with the Hyper-V role) that sleep states are supported for a
> > +  nested hypervisor (CPUID 0x40000004.EAX bit 20). Without it, Hyper-V running
> > +  on top of KVM disables hibernation (S4) for its root partition: Windows
> > +  reports "The hypervisor does not support hibernation", and an S4 attempt
> > +  makes the nested hypervisor reset the machine. No KVM support is needed: the
> > +  bit is a hint only. On resume the nested hypervisor issues a hypercall that
> > +  KVM does not implement; the nested hypervisor ignores the failure.
> > +
> >  ``hv-no-nonarch-coresharing`` = on/off/auto
> >    This enlightenment tells guest OS that virtual processors will never share a
> >    physical core unless they are reported as sibling SMT threads. This information
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 5da80ade70..9df628ed2a 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -10797,6 +10797,7 @@ static const Property x86_cpu_properties[] = {
> >                        HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
> >      DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
> >                              hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
> > +    DEFINE_PROP_BOOL("hv-nested-sleep", X86CPU, hyperv_nested_sleep, false),
> >  #ifdef CONFIG_SYNDBG
> >      DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
> >                        HYPERV_FEAT_SYNDBG, 0),
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index e7a88074c0..bff8b1d192 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2374,6 +2374,7 @@ struct ArchCPU {
> >      uint64_t hyperv_features;
> >      bool hyperv_passthrough;
> >      OnOffAuto hyperv_no_nonarch_cs;
> > +    bool hyperv_nested_sleep;
> >      uint32_t hyperv_vendor_id[3];
> >      uint32_t hyperv_interface_id[4];
> >      uint32_t hyperv_limits[3];
> > diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
> > index a9f056f2f3..df6ce6ae42 100644
> > --- a/target/i386/kvm/hyperv-proto.h
> > +++ b/target/i386/kvm/hyperv-proto.h
> > @@ -81,6 +81,7 @@
> >  #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
> >  #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
> >  #define HV_NO_NONARCH_CORESHARING           (1u << 18)
> > +#define HV_NESTED_SLEEP_SUPPORTED           (1u << 20)
> >
> >  /*
> >   * HV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX bits
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index da922f72d7..76f1a37ea5 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -1630,6 +1630,11 @@ static int hyperv_fill_cpuids(CPUState *cs,
> >              HV_NO_NONARCH_CORESHARING;
> >      }
> >
> > +    /* Only a hint for a nested Hyper-V: no KVM support is needed */
> > +    if (cpu->hyperv_nested_sleep) {
> > +        c->eax |= HV_NESTED_SLEEP_SUPPORTED;
> > +    }
> > +
> >      c = &cpuid_ent[cpuid_i++];
> >      c->function = HV_CPUID_IMPLEMENT_LIMITS;
> >      c->eax = cpu->hv_max_vps;
>
> --
> Vitaly
>

