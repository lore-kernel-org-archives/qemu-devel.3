Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DD8C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOCs-0002M4-9S; Thu, 16 Jul 2026 11:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wkOCq-0002Lq-Q2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wkOCm-0001LJ-Dx
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784216455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0HwOx7t7LtBBp2NDZL0d7YMNK7hXUEhn5q8DJR3X+I=;
 b=dT7n4vQO2+etCafP525phG925HL83G7JDFxSYs4rntd7ha6UwkLqhACs+1zASqMMI79Wj3
 heHokVkVKtkGCZ53SLl/Sr0tktVPebDR79gWzhC1OlVTpFo0WF+JknrDBC4KOGjyGwLaok
 SEKFcKXzF4Iu4lVPtMXnn6YTUNte4MQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-4XU_0PAQNS6Of2WQeMUHXw-1; Thu, 16 Jul 2026 11:40:54 -0400
X-MC-Unique: 4XU_0PAQNS6Of2WQeMUHXw-1
X-Mimecast-MFC-AGG-ID: 4XU_0PAQNS6Of2WQeMUHXw_1784216453
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso64242081cf.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784216453; x=1784821253; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B0HwOx7t7LtBBp2NDZL0d7YMNK7hXUEhn5q8DJR3X+I=;
 b=Y8cwLQixbpMnboCZPM/gjkAn2JGEnd5aE/DISulIEjdxkHE1R0TZMhDoWCjL8rk5JF
 qx910io2mT5mvMM/ZosUJCfbV/Wn0Y/4JB8nT1I4NqkonLbCl45MBC3799GBrFhkeACb
 Q85IN2iSFPqmq9ZkfBrzM+/Csu+Q7l4D5stXbD0ecoX1LAbXfyej24X9FhGKkXJCTqU+
 kQdpFNidWeWyvd9Lv6EHKtMoXv4CjJcUvgzauj0uJ5+0cdyU7deh13XM+ygfn1ZJwtZL
 PXA/qP8FUjeTobN2tZd7ioFOofYQpqV69FRPzx8QrkT7xi5rBj7ZbS3jsr40M/8bvWbh
 3yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784216453; x=1784821253;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B0HwOx7t7LtBBp2NDZL0d7YMNK7hXUEhn5q8DJR3X+I=;
 b=hW9CM/2morn5RIUZi5A14dM5TE10PnAX3KNgaKZa0jvZA7gYae+MN7lFXk5Sr17Zkk
 4PokpPBW97fB2oNHxaUqR5u1Y3o5Gd/E3fuhjDUNHaDxWhcxTnd8WmKgbo1nxqEE9oPO
 Y7Uj/rkznmI1RNcvx5h3f7WdWQ4zLc7xaRlzR1WsyeMa5RG6sFtpeJFhQKiSHXB5wEQ9
 nBUoYlMKlXHNA4htCVDoj++y2LY+uWKVjor0WM4Ja39WnL7WLtwmtTWUzxyFrSy4gKPM
 8B6q+MSRuhS086vsdHIipHjIJHp/UeXXw3N84u0nl+/8oGNTtNJjuxqPsavcdNusBIKL
 zy6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/bLhePgGmtlC8ai8oe31FbQ0Rep8DlNVXmWNxKt2MsqP0f4pdYeX2cogY3Y6GzgZR3+XKsxBLidsE@nongnu.org
X-Gm-Message-State: AOJu0YytxN7zz4pGl2skwAyG2kNum2iXHubjiGO02iMjmCwIZ/hpq3sI
 NrMsYzPtU70PWRZHckN8e6juCeBr6yUEtVrR/fHxmuI9X9JnTxdVGTJFAGbsCrrDpACi10QQkNG
 Lm5pwlCguDwC3mHwNmueqrYGtYmGdI7z3AMAPKq7QAd234XyhdmhVpeEL
X-Gm-Gg: AfdE7cnn/55lEgEjDyGYdrVcToay+lcPED/retLKsfso++U4rKoIHfCq+VJ9i7igIB5
 3ms+KCid4aMCHJu17qUW0b116DlGr7enoXODvQbvyk8ai4xR6tFfU4BaTOfPVEiQSKNpVcKyvv/
 Zm/ZCgG0/dB/NEyUhIjtsJjS2bRMKYdC8PaYUpIQ9GZdjG3YlTlW/tmnPtb47QhhpzFyAQrBqz5
 aAKJY8gZuw+PUGhpr24eJ9XxnX8lKMxQ5rvfmioLVfYTUwJ0SvY3IisqLGQ9Orvi2kwGtVXFWI/
 NWslAx2jukkfk5qevSlN7Msft9f+zfB832iyXHTEtzX+YrWjnbsQEkFbJiBQErhyvEsq
X-Received: by 2002:ac8:7e8d:0:b0:51b:feee:b08b with SMTP id
 d75a77b69052e-520be690507mr702471cf.45.1784216453319; 
 Thu, 16 Jul 2026 08:40:53 -0700 (PDT)
X-Received: by 2002:ac8:7e8d:0:b0:51b:feee:b08b with SMTP id
 d75a77b69052e-520be690507mr701851cf.45.1784216452577; 
 Thu, 16 Jul 2026 08:40:52 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd81f43e6sm222378556d6.39.2026.07.16.08.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 08:40:52 -0700 (PDT)
Date: Thu, 16 Jul 2026 11:40:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <alj7gF_ayHO7Dvb7@x1.local>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyqv3u32.fsf@suse.de>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 11:08:49AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Jul 07, 2026 at 04:43:43PM +0400, Marc-André Lureau wrote:
> >> Hi
> >> 
> >> On Tue, Jul 7, 2026 at 2:59 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> >
> >> > Beyond the overall virt/non-virt use case classification, there are
> >> > a number of scenarios which we have decided will not be treated as
> >> > security issues. Start to document some of these to give consistency
> >> > in our treatemnt of incoming disclosures.
> >> >
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > ---
> >> >
> >> > Mauro / Michael: please suggest any other rules which we have applied
> >> > historically on qemu-security disclosures that we should capture here.
> >> >
> >> > The vfio-user/vhost-user addition is a new one based on discussions
> >> > in some GitLab issues today/yesterday
> >> >
> >> >  docs/system/security.rst | 63 ++++++++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 63 insertions(+)
> >> >
> >> > diff --git a/docs/system/security.rst b/docs/system/security.rst
> >> > index 53992048e6..fbbca50f95 100644
> >> > --- a/docs/system/security.rst
> >> > +++ b/docs/system/security.rst
> >> > @@ -75,6 +75,69 @@ Bugs affecting the non-virtualization use case are not considered security
> >> >  bugs at this time.  Users with non-virtualization use cases must not rely on
> >> >  QEMU to provide guest isolation or any security guarantees.
> >> >
> >> > +Security boundary scope
> >> > +'''''''''''''''''''''''
> >> > +
> >> > +Even where a flaw affects the virtualization use case described above,
> >> > +not all scenarios will be considered in scope. The following guidelines
> >> > +are used to evaluate whether to apply the full security process, or treat
> >> > +an issue as a normal bug.
> >> > +
> >> > +* **assert** / **abort**. If triggering the code path requires kernel
> >> > +  privileges (or root account access) in the guest, asserts/aborts in
> >> > +  QEMU are a self inflicted denial of service. These will **not** be
> >> > +  treated as security flaws, at most hardening bugs. If triggering the
> >> > +  code path can be done by an unprivileged guest OS account, this
> >> > +  **may** justify handling as a security bug.
> >> > +
> >> > +* **vhost-user/vfio-user backends**. The backend processes have
> >> > +  shared memory regions co-mapped with the QEMU process. The intent
> >> > +  of the process separation is operational resilience & flexibility
> >> > +  and allowing for independent software suppliers. There is not
> >> > +  considered to be security boundary between QEMU and the vhost-user
> >> > +  & vfio-user backends. Thus flaws in the backends which can cause
> >> > +  crashes / undesirable behaviour in QEMU will **not** be treated as
> >> > +  security flaws, but should be fixed as hardening bugs.
> >> > +
> >> > +* **memory allocation bounds**. There are many ways in which a QEMU
> >> > +  process can legitimately consume an amount of memory that is
> >> > +  significantly larger than the assigned guest RAM. QEMU's worst
> >> > +  case memory usage should be considered effectively unbounded. As
> >> > +  such the QEMU deployment on the host should account for the
> >> > +  possibility of large memory peaks and apply countermeasures to
> >> > +  provide continuity of host operations. It is typical for the Linux
> >> > +  OOM killer to reap the process triggering host memory overcommit
> >> > +  in the case of exccessive usage, offering a degree of protection.
> >> > +  As such, bugs which can lead to excessive/unbounded memory allocations
> >> > +  will usually not be classified as security flaws, but should be
> >> > +  fixed as hardening bugs.
> >> > +
> >> > +* **degraded guest behaviour**. There are a set of bugs which can
> >> > +  lead guest hardware devices to misbehave. For example, a flawed
> >> > +  virtual IOMMU operation may not offer the guest device isolation
> >> > +  that would otherwise be expected. If a guest triggered exploit
> >> > +  requires kernel privileges (or root account access), and leads
> >> > +  to sub-optimal behaviour of the virtual device this is considered
> >> > +  a self inflicted service degradation. These will **not** be
> >> > +  treated as security flaws, at most hardening bugs. If triggernig
> >> > +  the code path can be done by an unprivileged guest OS account,
> >> > +  this may justify handling as a security bug.
> >> > +
> >> > +* **nested virtualization**. The scope for nested virtualization
> >> > +  is to prevent a level 2 guest from breaking out into a level
> >> > +  1 guest. As noted above, a number of scenarios exclude security
> >> > +  handling for flaws only exploitable by the guest kernel / root
> >> > +  account with affect the guest's own service/availability. In the
> >> > +  context of nested virtualization with PCI device assignment, it
> >> > +  may may be possible for a level 2 guest kernel to trigger flaws
> >> > +  that affect the level 0 QEMU process. While these bugs should be
> >> > +  fixed, they will not be triaged as security flaws at this time.
> >> > +
> >> > +* **low severity impact**. As a catch all rule, issues which
> >> > +  are judged to have a "low" severity impact on the system will
> >> > +  usually not justify handling as security bugs, nor assignment
> >> > +  of CVEs. They will be fixed as routine bugs when time allows.
> >> 
> >> Should we have a section about management-plane protocols? (migration,
> >> QMP, monitor), since they already require trusted network access?
> >
> > There is a section later about QMP/monitor
> >
> >   https://www.qemu.org/docs/master/system/security.html#sensitive-configurations
> >
> > For migration we do need to think of something to explain our approach
> > more clearly, and indeed document our expectations for configuration
> > for migration (trusted LAN vs TLS + certs).
> >
> 
> +CC peterx
> 
> Hi, I put together a draft so we can discuss, let me know what you
> think.

Below looks good in general, some trivial comments inline.

> 
> Assumptions:
> 
> A) The migration stream is assumed to be secured by TLS on a per-host
> basis.
> 
> B) For migration streams stored to file, including snapshots, it is
> assumed that the storage file is authentic, i.e. the files are owned by
> the party performing the live migration and have not been tampered with.
> 
> C) The network ports used for migration are expected to be available
> only during migration. No long-standing listening destination QEMU
> process.
> 
> D) The network used for migration is expected to be adequately isolated.
> 
> E) The migration source QEMU process is assumed to be secure. Compromise
> of the source QEMU process is nonetheless possible but exploiting the
> migration process is expected to grant no further privileges.

Yes, having this whole section should help clarify things a lot.

> 
> For security consideration, the following are considered:
> 
> OUT OF SCOPE:
> 
> 1) Abort of destination QEMU process while migration is still in course.
> Rationale: the source virtual machine is not affected.
> 
> 2) Migration failure.
> Rationale: eventual failed migrations are part of normal operation.
> 
> 3) Memory over-allocation issues in the destination QEMU process.
> Rationale: the destination host's operating system is expected to
> constrain resource usage. Process termination due to OOM falls under
> point 1 above.

This whole section is good too.

Though for 3), I'd not say the dest host is expected to constrain resouce
usage.  For example, if there is way to cause over-allocate in a daemon it
should still be treated a real host mem DoS, and we may or may not always
assume the guest processes are protected by memcg or something alike.

However, I still agree with the conclusion: it's out of scope of migration
not because #1, but because dest QEMU process is in the "secure zone" and
it's not a generic daemon, hence ASSUMPTION A)+C)+D).  If the attacker can
reach it and talk to it, something has already been breached.

> 
> IN SCOPE:

It's harder to follow for what are described as IN SCOPE below.. except..

> 
> 1) Privilege escalation from the guest operating system into the
> destination QEMU process or host.
> 
> 2) Tampering or exfiltration of migration stream data by a third party
> at a lower privilege level than either QEMU processes involved in the
> migration.
> 
> 3) Termination of the source QEMU process by source virtual machine
> guest userspace, including by forcing host OS resource constraints to
> be reached.
> 
> 4) Other tampering or exfiltration of data from the source QEMU process
> if reached from migration code or migration stream manipulation.
> 
> 5) Causing source QEMU process to enter a state from which migration is
> not possible permanently.
> 
> The overall effect of this policy is that only legitimately produced
> migration data is considered for security implications, whether that
> data is malicious or buggy.

.. I kind of get what you wanted to say. The only legit way to interact
with migration module that I can think of, is either from guest access
(manipulation of guest device registers etc. iow, malicious drivers),
causing migration misbehave / disfunction, or via host side interfacing
like QMP/HMP causing source host / guest damage, this time memory DoS
could be a bigger problem for sure comparing to a dest QEMU DoS, but this
then also depends on how we want to define the scope for monitors in
general.

I wonder if we can simply above 5 points into something simpler, or skip
for now?  To me, what is out of scope is more valuable to be put into doc,
because I bet 99% if not all of existing "security issues" on migration in
past few months fall into it.. so it saves huge time already for triaging.

-- 
Peter Xu


