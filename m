Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F3FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 11:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tObZM-0003Xc-9m; Fri, 20 Dec 2024 06:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tObZD-0003X0-Gw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:53:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tObZ9-0003jM-Il
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734695588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clN8kK20t9Q1ruCWzq9rltbPgJklSBXSxOLMJ45bOAQ=;
 b=G+BA4OWnbu1pTVfHk7Us6NWqiW+CLTZng9QBE1QSCutfjbt3lAf1W3bPX92E8OsuLoYVkF
 OuyA/G+VeleeValAXNGvKlWPbTUYl1Y98gMm5rXSYqGxJoFHAbFdSUi0fnhNmWlcF+ao89
 xontv6ztY2HENrnOkqMimsMQXdpStOI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-CuI-lu2IMO2s2CBXok8YyA-1; Fri,
 20 Dec 2024 06:53:04 -0500
X-MC-Unique: CuI-lu2IMO2s2CBXok8YyA-1
X-Mimecast-MFC-AGG-ID: CuI-lu2IMO2s2CBXok8YyA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 756281955F42; Fri, 20 Dec 2024 11:53:02 +0000 (UTC)
Received: from gezellig (unknown [10.39.194.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E096619560A2; Fri, 20 Dec 2024 11:52:54 +0000 (UTC)
Date: Fri, 20 Dec 2024 12:52:51 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel =?iso-8859-1?B?IlAuIEJlcnJhbmfpIg==?= <berrange@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64
 KVM host model
Message-ID: <Z2Vak-hbCMaxm-JJ@gezellig>
References: <20241206112213.88394-1-cohuck@redhat.com>
 <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
 <Z1qoa8yXscTSAJ9e@redhat.com> <8734it1bv6.fsf@redhat.com>
 <1fea79e4-7a31-4592-8495-7b18cd82d02b@redhat.com>
 <Z2QE9AqZnpGM5sWD@gezellig> <8634ijrh8q.wl-maz@kernel.org>
 <Z2Q2rWj9cV0W_XVq@gezellig> <86zfkrptmj.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86zfkrptmj.wl-maz@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

On Thu, Dec 19, 2024 at 03:41:56PM +0000, Marc Zyngier wrote:
> On Thu, 19 Dec 2024 15:07:25 +0000,
> Kashyap Chamarthy <kchamart@redhat.com> wrote:
> > 
> > On Thu, Dec 19, 2024 at 12:26:29PM +0000, Marc Zyngier wrote:
> > > On Thu, 19 Dec 2024 11:35:16 +0000,
> > > Kashyap Chamarthy <kchamart@redhat.com> wrote:

[...]

> > > You can't rely on userspace for security, that'd be completely
> > > ludicrous.
> > 
> > As Dan Berrangé points out, it's the bog-standard way QEMU deals with
> > some of the CPU-related issues on x86 today.  See this "important CPU
> > flags"[2] section in the QEMU docs.
> 
> I had a look, and we do things quite differently. For example, the
> spec-ctrl equivalent in implemented in FW and in KVM, and is exposed
> by default if the HW is vulnerable. Userspace could hide that the
> mitigation is there, but that's the extent of the configurability.

Noted.  As Dan says, as long as QEMU can toggle the feature on/off, then
that might be sufficient in the context of migratability.

[...]

> > To reply to your other question on this thread[3] about "which ABI?"  I
> > think Dan is talking about the *guest* ABI: the virtual "chipset" that
> > is exposed to a guest (e.g. PCI(e) topology, ACPI tables, CPU model,
> > etc).  As I understand it, this "guest ABI" should remain predictable,
> > regardless of:
> > 
> >   - whether you're updating KVM, QEMU, or the underlying physical
> >     hardware itself; or
> >   - if the guest is migrated, live or offline
> > 
> > (As you might know, QEMU's "machine types" concept allows to create a
> > stable guest ABI.)
> 
> All of this is under control of QEMU, *except* for the "maximum" of
> the architectural features exposed to the guest. All you can do is
> *downgrade* from there, and only to a limited extent.
> 
> That, in turn has a direct impact on what you call the "CPU model",
> which for the ARM architecture really doesn't exist. All we have is a
> bag of discrete features, with intricate dependencies between them.

I see; thanks for this explanation.  Your last sentence above is the
shortest summary of the CPU features situation on ARM I've ever read so
far. 

So, I infer this from what you're saying (do correct if it's wrong):

  • Currently it is impractical (not feasible?) to pull together a
    minimal-and-usable set of CPU features + their dependencies on ARM
    to come up with a "CPU model" that can work across a reasonable set
    of hardware.

  • If the above is true, then the ability to toggle CPU features on and
    off might become even more important for QEMU — if it wants to be
    able to support live migration across mixed set of hardware on ARM.  

    NB: by "mixed set of hardware", I mean hardware that is *close
    enough* (e.g. among the "Ampere Altra Family" - BTW, this "family"
    seems to be only 2 systems far).  Not arbitrarily mixed.  I did read
    your response in this thread about "who in their right mind" would
    want to migrate from Nvidia "Grace" to "AmpereOne".

      https://lore.kernel.org/linux-arm-kernel/86y10ytpo6.wl-maz@kernel.org/
      — KVM: arm64: Make the exposed feature bits in AA64DFR0_EL1
      writable from userspace

> Even ignoring virtualisation: you can readily find two machines using
> the same CPUs (let's say Neoverse-N1), integrated by the same vendor
> (let's say, Ampere), in SoCs that bear the same name (Altra), and
> realise that they have a different feature set. Fun, isn't it?

Yikes!  I would use a different word, that starts with "m" and ends with
"s" (the resulting word rhymes with the latter) ;-)

    * * *

Related tangent on CPU feature discoverability on ARM:

Speaking of "Neoverse-N1", looking at a system that I have access to,
the `lscpu` output does not say anything about who the integrator is; it
only says:

    ...
    Vendor ID:                ARM
    Model name:             Neoverse-N1
    ...

I realize, `lscpu` displays only whatever the kernel knows.  Nothing in
`dmidecode` either.

Also, it looks like there's no equivalent of a "CPUID" instruction (I
realize it is x86-specific) on ARM.  Although, I came across a Google
Git repo that seems to implement a bespoke, "aarch64_cpuid".  From a
what I see, it seems to fetch the "Main ID Register" (MIDR_EL1) - I
don't know enough about it to understand its implications:

    https://github.com/google/cpu_features/blob/main/src/impl_aarch64_cpuid.c

> That's why I don't see CPU models as a viable thing in terms of ABI.
> They are an approximation of what you could have, but the ABI is
> elsewhere.

Hmm, this is "significant new information" for me.  If CPU models can't
be part of the guest ABI on ARM, then the whole "migratability across
heterogenous hardware" on QEMU requires deeper thinking.

Thanks for this discussion.

-- 
/kashyap


