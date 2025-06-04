Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C148BC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnLt-00078y-Ac; Wed, 04 Jun 2025 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uMnLo-00072J-M0
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uMnLl-0006Oq-3U
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749040567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V7C5kjSSLR6kXHw8Neep/dRsgyz0D4mmfyIVXbIvnZE=;
 b=XJqrXnPdsz0/jFOufYNtkFgLDr3u/hM1nKvE3Tfefiiw23NFmgk4qwejqYorDup3JqAtTN
 OpfNEjaMrZb9wZfluqQCx9kW8iZmzT0iknVxlbmDvPaiPnjKrb2WWM/TxxpS/OkJHFKHn3
 ecB0Sbf3/kBbai91efiG8VWYA+YuniI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-77akjX-INpioeYjyf73qAw-1; Wed,
 04 Jun 2025 08:36:04 -0400
X-MC-Unique: 77akjX-INpioeYjyf73qAw-1
X-Mimecast-MFC-AGG-ID: 77akjX-INpioeYjyf73qAw_1749040562
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB5E01801A22; Wed,  4 Jun 2025 12:36:01 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5684719560AD; Wed,  4 Jun 2025 12:35:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>, "jdenemar@redhat.com"
 <jdenemar@redhat.com>
Cc: "agraf@csgraf.de" <agraf@csgraf.de>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
In-Reply-To: <f11e5fbddf634bbc88ba4c07bafe3f26@huawei.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <de7db6bc22ad4f0a8ac1fac718c810a1@huawei.com> <87bjrfbkyz.fsf@redhat.com>
 <878qmibc5a.fsf@redhat.com> <87tt4wamcp.fsf@redhat.com>
 <f11e5fbddf634bbc88ba4c07bafe3f26@huawei.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 04 Jun 2025 14:35:57 +0200
Message-ID: <87o6v3adle.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 04 2025, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

>> -----Original Message-----
>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Tuesday, June 3, 2025 4:15 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; eric.auger.pro@gmail.com;
>> eric.auger@redhat.com; qemu-devel@nongnu.org; qemu-arm@nongnu.org;
>> kvmarm@lists.linux.dev; peter.maydell@linaro.org;
>> richard.henderson@linaro.org; alex.bennee@linaro.org; maz@kernel.org;
>> oliver.upton@linux.dev; sebott@redhat.com; armbru@redhat.com;
>> berrange@redhat.com; abologna@redhat.com; jdenemar@redhat.com
>> Cc: agraf@csgraf.de; shahuang@redhat.com; mark.rutland@arm.com;
>> philmd@linaro.org; pbonzini@redhat.com
>> Subject: RE: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64
>> KVM host model
>> 
>> On Tue, May 27 2025, Cornelia Huck <cohuck@redhat.com> wrote:
>> > The conversion functions are not at fault here, but we're missing
>> > registers. If we have MIDR and friends writable, they show up in the
>> > masks returned by the kernel, but they are not present in the kernel's
>> > sysreg file where we generate our definitions from, and
>> > kvm_idx_to_idregs_idx() asserts instead of returning an error, which
>> > is kind of suboptimal...
>> >
>> > So I see two possible ways to fix this:
>> > - add MIDR and friends to the kernel's sysreg file
>> > - add MIDR and friends in QEMU's cpu-sysregs.h.inc file, and only append
>> >   generated definitions there
>> >
>> > First option means one more round trip, second options has more
>> > potential for messing things up if we keep stuff local to QEMU.
>> 
>> With the patch below, things work for me with a 6.15+ kernel. It's a bit
>
> Yes works for me too now. Thanks.

Thanks for checking.

>
>> messy, though, and raises questions (how do we want to handle those regs
>> across accelerators, for example, or how we can make sure that the code is
>> more robust when registers are added.)
>> 
>> My biggest question, however, is how this interacts with the framework to
>> provide lists of MIDR/REVIDR/AIDR for errata management. The hack below
>> adds properties to configure those regs, I guess we'd want to suppress
>> adding the props in order to avoid conflicts.
>
> Not sure how this impacts the errata management though. My initial take on
> this was, user will provide a list of target CPU ids through command line and
> that will be used to set the target CPUs for errata management(if kernel
> supports it).
>
> Eg:
> -machine virt,.., x-target-impl-cpus=0xMIDR1:0xREVIDR1-0xMIDR2:REVIDR2

I'm a bit confused by the range, I'd rather expect a list of tuples,
e.g. <midr>:<revidr>,<midr>:<revidr>, ...

>
> And these will be stored in,
>
> #define MAX_TARGET_IMPL_CPUS    4
> typedef struct TargetImplCpu {
>      uint32_t midr;
>      uint32_t revidr;

Isn't revidr a 64 bit value?

> } TargetImplCpu;
>
>
> Please see the initial (a hack for testing kernel) implementation here,
> https://github.com/hisilicon/qemu/commit/a393c1180274c73d34f32eaab66764a874a9ad31
>
> Please let me know if there is a better/preferred way of obtaining this
> target CPU list from user.

I'm mostly wondering about conflicting values between "we make MIDR et
al. writable, so we have a value different from what the host sees" and
"we provide a list of possible values to the guest, so it can prepare
for running on those hosts". Do we want to be able to provide a common
set to the guest, and then enlighten it with the list of systems that it
actually *might* run on? A benefit would be that it could always observe
the same (configured) register entries, regardless where it runs (needs
more plumbing in QEMU, I think.) We'd also need to be clear about what
we'd require (i.e. do we expect that both the real host values and the
configured values are present in the list?)

Not sure if the machine level is the right place to configure this, or
if it needs to go to the cpu options. While it is a machine-wide
configuration, it also means that we configure some cpu features in two
different places (even if they serve a different purpose.)

We could also choose to not expose properties for MIDR and friends at
all, even if they are writable.


