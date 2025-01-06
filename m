Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADF2E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 18:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUs4f-0007e0-Pj; Mon, 06 Jan 2025 13:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tUs4d-0007dc-Lr
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 13:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tUs4b-0003lE-2n
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 13:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736189010;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8CUEWGfMWhswPp+8A7KBzJX5t8jJtjAdO9JGUMUfSQ=;
 b=DVyPZJbODRyoR/71/TXU9EO0Tgjf7TPa1QDH4mNm7Tp0ENw0XnJVRcqfXy5Klg3HA1z9Zn
 t+cxHzlInA18bwh/prc3be1exC20FKS/VKtmtBI0ikf/fOWJ2y/83z5rvJZIhsoWk2NI5I
 9lzmj5MNi0nOEbK9zqWcpdqSoLagvwM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-00Ajf755Nda8h86CdxubMw-1; Mon,
 06 Jan 2025 13:43:23 -0500
X-MC-Unique: 00Ajf755Nda8h86CdxubMw-1
X-Mimecast-MFC-AGG-ID: 00Ajf755Nda8h86CdxubMw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB53719772C9; Mon,  6 Jan 2025 18:43:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D20BB19560A2; Mon,  6 Jan 2025 18:43:11 +0000 (UTC)
Date: Mon, 6 Jan 2025 18:43:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] system: Try hardware accelerators (KVM, HVF) before
 software one (TCG)
Message-ID: <Z3wkO0GP-VxfEcc0@redhat.com>
References: <20250103150558.1473-1-philmd@linaro.org>
 <Z3f--qO8x45MpiXQ@redhat.com>
 <CAGCz3vtSUD-8pG7GVUAjx0ydOKAh-YxvWDUpcECef7ch7dbeGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGCz3vtSUD-8pG7GVUAjx0ydOKAh-YxvWDUpcECef7ch7dbeGg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jan 04, 2025 at 12:28:14PM +0100, Phil Dennis-Jordan wrote:
> On Fri, 3 Jan 2025 at 16:16, Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Fri, Jan 03, 2025 at 04:05:58PM +0100, Philippe Mathieu-Daudé wrote:
> > > As Daniel suggested [*]:
> > >
> > > > We should consider to rank HVF above TCG, on the basis
> > > > that HW acceleration is faster and should provide a
> > > > host<->guest security boundary that we don't claim for TCG
> > >
> > > [*] https://lore.kernel.org/qemu-devel/Z07YASl2Pd3CPtjE@redhat.com/
> >
> > Note, my statement above was on the basis that HVF passes all our
> > functional tests, thus indicating a decent level of confidence
> > in the correctness of the HVF impl.
> >
> > If anyone knows any show stopper problems with HVF that would
> > justify blocking its promotion ahead of TCG.... say now.
> >
> 
> I don't know about showstoppers, but:
> 
> 1. As far as I'm aware there are/were problems with the virtual IOMMU
> devices in HVF. It's been a while (~half a year?) since I tried them, but I
> had problems getting guests booted with intel_iommu etc.

I think that vIOMMU is niche enough that we can merely consider it
a nice-to-fix bug, and not block promoting HVF.

> 2. I think there might also be a few remaining edge cases where the x86
> instruction emulation on fault/trap is incomplete. Most notably, MMIO using
> SSE/AVX/etc. instructions will, I think, fail. In practice this is a fairly
> obscure use case - I'm not aware of any guest OS that actually performs
> MMIO using these instructions. I have a patch kicking around that adds
> support for missing 64-bit variants of common scalar arithmetic
> instructions with memory operands. I can dig that up and post it - do we
> have a good way of adding tests for this kind of thing?

Not sure how best to test this, other than finding a guest OS that
exhibits this ? Others probably have better suggestions...

> 3. As far as I'm aware, there's no CI happening on HVF? Or has that
> changed? macOS is notoriously a pain in the rear in terms of CI thanks to
> its licensing, and the big cloud CI platforms tend to run it in a VM which
> in turn typically doesn't support nested HVF. I've been working on an
> on-prem solution to provisioning bare-metal Macs to run clean-slate OS
> images for CI. This has been a side project though and I haven't had the
> resources to focus on that project to see it through. It might be possible
> to do this in the cloud on Amazon's EC2 Mac Minis as well, but those aren't
> exactly cheap.

The only CI we have is running under Cirrus CI which uses VMs on
real mac aarch64 hardware, but I don't think we can test HVF there.

Mostly we rely on regular contributors periodically running tests
and reporting on problems. This is not ideal, but also not a blocker
for enabling HVF - it just means macOS isn't a full tier 1 platform
for us.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


