Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C54AC4450F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk66v-000684-05; Wed, 15 Jul 2026 16:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wk66t-00067Y-0w
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:21:39 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wk66r-0002WK-BS
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:21:38 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2429187a91.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784146895; x=1784751695; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fBNMuYev9SK9XP/q4UAGz8mTO3r2lm4owsLqkSYGd/A=;
 b=BWOeShxokWOc5zOiD0n2rHHi3jsEFtDNfjCpUq4tE1z3wGwXG56xEHqU5muBg6WQuB
 SiUKf7jwX5HbvAHYNgrb3hL72HrE1EbSQNLL8fuPO087Xo7irEb4BMLe7T4m7DMgPQ7e
 Gj+cFwGK4I0IpQl4xWxp6OI8GuS2qxB18glm2k3MhVuQMsEyQqRjKVwADYttkGTzxHDx
 y69E7I3KNL89QqqnBJ33U7yNLanQe58N8JOTXy4gwKdue3ZcUHiNVapd+ui7mDXBbz9x
 fBoxyenUNq2avqPC3wD1BnlIjITPO6tFW9AlIPF7Th4Qg4cg66/WxrDoPtjus20xuf0p
 lPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784146895; x=1784751695;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fBNMuYev9SK9XP/q4UAGz8mTO3r2lm4owsLqkSYGd/A=;
 b=eOPp+dFZXXx/g9r2eNFzWQTVD/OAe1RLdJLqLEC3QjyrcHdDfOWgPzxBSbwKqg8UEH
 r17tW+yG1jMA0n5aDFWe+1ngXX/irOEnfD5Qwgn2qs1WCpiejQEuHye77b9NNVCb0EUH
 OPH1elEa+9fvO03hBvDUu5+cGZMNHPrr4Wwm/Ly3u92DTVASmesDByZqyTYBAinkN6k1
 fcTXQultcdXaBs2egb4dnQmbLxzLY3wTiCq36diDVjeWk142a2ok4G/x+7lbEX/klLji
 fVxJHDqp8CrmUgECULuTpgLouQiqYqFOy5rCe+k5SuqA5z+x9KQZ4dupL2Srm36IMYRf
 VgrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWU9JeZMHyA8sS2KAMhm6u4MLLKHrQ3KU6XL3jXk8EE+ESIt0XaMkIQVknuHMOv3OBeYkTYYGHteV4@nongnu.org
X-Gm-Message-State: AOJu0YxTHGqfgE+B8VL5JgSwoErJCjJOmW00Djn0wtDSRryEcmqi7ZWa
 gzfo7LLoVCQJgozR+yUwHYnoxK9jGEnE41+Lyd3LnrbtcbLJrzLcn2nYf01eirTu+Ss=
X-Gm-Gg: AfdE7ckJK5Z5qetMnTHrwQpu/Rrv31cQuzZ9xCZCENy5TASQteaiw+9gV23F/LzeGIp
 dAsShrVnbTr2Lxf1rlhmTrUJAwFCNT2tjqTKaMC9YNZkzXHwi5hxCykLScD50YHsb5swR55jCdS
 WSDvGbWeSjhxHZ6moi8VYz0jchxxaQd8bGRO3ojogXe5CapQZ9wZWQQUy5upsBAF6lZHq4RVxCU
 l8pALATnrOnTJ27EoKB+iaSQUaa7133zu4boKFNDQaXQw0iSXs+j2yYHmG3K1x5HMFXfg9yUmK+
 sOhbqKnZbrvJpVgCmZGrk7jPsosUZrZH9Cl57gUWKU2PCbqBxK2Sc7DTkgpny9sduvH73vb1x5A
 /GmpFOKseEH2Pl66yszmGCMifCVlPUZB0WJa6IUYPasauW9lPEbJ8nd3bBbIi5ZRCKgeqWhcvsJ
 RUA/FHeNWBWUCuxblQ
X-Received: by 2002:a17:90b:38c8:b0:38d:dbc7:5178 with SMTP id
 98e67ed59e1d1-38ddbc75254mr15794311a91.22.1784146895116; 
 Wed, 15 Jul 2026 13:21:35 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4f38:9a5e:fd18:7a9b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e39e74279sm134375a91.17.2026.07.15.13.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 13:21:34 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:21:31 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 04/25] target/arm/kvm-rme: Add mechanic to initialize
 realms
Message-ID: <alfry2MJwRFz2hPS@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-5-mathieu.poirier@linaro.org>
 <4ffc3787-a53e-4889-b245-458de4463cb9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffc3787-a53e-4889-b245-458de4463cb9@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jul 13, 2026 at 03:34:20PM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Initialise an @rme_guest object and install a handler to get notified
> > when the Realm is ready to start.  That way we can finish reading the
> > Realm once we know everything is in place.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm-rme.c  | 50 +++++++++++++++++++++++++++++++++++++++++++
> >   target/arm/kvm-stub.c |  5 +++++
> >   target/arm/kvm.c      |  7 +++++-
> >   target/arm/kvm_arm.h  |  9 ++++++++
> >   4 files changed, 70 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index 42e1d1e7b859..b86b9d6a25cb 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -13,6 +13,7 @@
> >   #include "kvm_arm.h"
> >   #include "migration/blocker.h"
> >   #include "qapi/error.h"
> > +#include "qemu/error-report.h"
> >   #include "qom/object_interfaces.h"
> >   #include "system/confidential-guest-support.h"
> >   #include "system/kvm.h"
> > @@ -29,14 +30,63 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> >                                             CONFIDENTIAL_GUEST_SUPPORT,
> >                                             { TYPE_USER_CREATABLE }, { })
> > +static RmeGuest *rme_guest;
> > +
> > +static void rme_vm_state_change(void *opaque, bool running, RunState state)
> > +{
> > +    if (!running) {
> > +        return;
> > +    }
> > +
> > +    kvm_mark_guest_state_protected();
> 
> This would be called in kvm_arm_rme_init(), why we can't call this to mark the
> KVM state as protected in kvm_arm_rme_init() ?
>

One of the very last things happening in qemu_init() is a call to
qmp_x_exit_preconfig(), which ultimately ends up calling qemu_system_reset().
If we mark the guest state as protected before qemu_system_reset() is called, as
it would be the case if we move kvm_mark_guest_state_protected() to
kvm_arm_rme_init(), general purposes and the program counter registers don't get
pushed down to KVM, resulting in a failure to start the Realm.
 
> > +}
> > +
> >   static void rme_guest_class_init(ObjectClass *oc, const void *data)
> >   {
> >   }
> >   static void rme_guest_init(Object *obj)
> >   {
> > +    if (rme_guest) {
> > +        error_report("a single instance of RmeGuest is supported");
> > +        exit(1);
> > +    }
> > +    rme_guest = RME_GUEST(obj);
> >   }
> >   static void rme_guest_finalize(Object *obj)
> >   {
> >   }
> > +
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> > +{
> > +    static Error *rme_mig_blocker;
> > +    ConfidentialGuestSupport *cgs = ms->cgs;
> > +
> > +    if (!rme_guest) {
> > +        return 0;
> > +    }
> > +
> > +    if (!cgs) {
> > +        error_report("missing -machine confidential-guest-support parameter");
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
> > +        error_report("KVM doesn't support Realms");
> > +        return -ENODEV;
> > +    }
> > +
> > +    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> > +    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> > +
> > +    /*
> > +     * The realm activation is done last, when the VM starts, after all images
> > +     * have been loaded and all vcpus finalized.
> > +     */
> > +    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
> > +
> > +    cgs->require_guest_memfd = true;
> > +    cgs->ready = true;
> > +    return 0;
> > +}
> > diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> > index 88cbe8d85c41..eec1ca3dd2e5 100644
> > --- a/target/arm/kvm-stub.c
> > +++ b/target/arm/kvm-stub.c
> > @@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
> >   {
> >       g_assert_not_reached();
> >   }
> > +
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> > +{
> > +    g_assert_not_reached();
> > +}
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index ed99be7fd80c..28d5643d6779 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -660,7 +660,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >       hw_breakpoints = g_array_sized_new(true, true,
> >                                          sizeof(HWBreakpoint), max_hw_bps);
> > -    return 0;
> > +    ret = kvm_arm_rme_init(ms, s);
> > +    if (ret) {
> > +        error_report("Failed to enable RME: %s", strerror(-ret));
> > +    }
> > +
> > +    return ret;
> >   }
> >   unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index e7c40fb003e4..6d058b0e08a2 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -240,4 +240,13 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
> >    */
> >   char *kvm_print_register_name(uint64_t regidx);
> > +/**
> > + * kvm_arm_rme_init
> > + * @ms: the machine state
> > + * @s: State of KVM
> > + *
> > + * Prepare the machine to be a Realm, if the user enabled it.
> > + */
> > +int kvm_arm_rme_init(MachineState *ms, KVMState *s);
> > +
> >   #endif
> 
> Thanks,
> Gavin
> 

