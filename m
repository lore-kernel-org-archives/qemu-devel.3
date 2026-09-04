Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77293C79F83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2SHa-0005zU-J5; Fri, 04 Sep 2026 07:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2SHZ-0005yq-4k
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2SHX-0008J4-AQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788522030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R38LyZZ4K3QaJ25ZD439ymOxvz60UecUM1qk9A8ZK7U=;
 b=AE7/zM+LwQKsUdschJiQY4BE6FHMPoO0sp+vhwrflu86KDFqmY1L3ip3gLQQWAnZObl9zo
 vXBJojfjk/Mnheg5E0JwecT4aXktr9WJ9N+h2Ru9gxrwPmrERAHbza2VTmjsqYw+tZp0p2
 rXWEI6u5hnpoyRs+dbkHEYLSNDug8AQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-SACnOwuKPjGbtx6UtIH1IA-1; Fri,
 04 Sep 2026 07:40:26 -0400
X-MC-Unique: SACnOwuKPjGbtx6UtIH1IA-1
X-Mimecast-MFC-AGG-ID: SACnOwuKPjGbtx6UtIH1IA_1788522024
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 961E518C0FC3; Fri,  4 Sep 2026 11:40:24 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A810E1955F70; Fri,  4 Sep 2026 11:40:21 +0000 (UTC)
Date: Fri, 4 Sep 2026 12:40:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
Message-ID: <apquInYkhrswaxHl@redhat.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-3-bin.meng@processmission.com>
 <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
 <CAEUhbmW4h_-az5iBsztzy8Yuu06+WMjOYcrL51sW8VEgyAaSMw@mail.gmail.com>
 <881be57e-5496-41f2-af0b-e21087fa5e54@oss.qualcomm.com>
 <apqcmqpJEEyc7wGx@redhat.com>
 <CAFEAcA-s+zsChqxYa258GOXdjniusdYeOCzGd6OiHWBQZV1Syg@mail.gmail.com>
 <apqfJ58nhZZIH8Su@redhat.com>
 <CAFEAcA_ZqLjPxo2GjW9vgvyVHw5iABphE91Dk7u+OAj3Ls3TMg@mail.gmail.com>
 <a8ced3da-7dfa-49c1-b65e-c2290e0f6ca7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8ced3da-7dfa-49c1-b65e-c2290e0f6ca7@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 04, 2026 at 01:24:35PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/9/26 12:47, Peter Maydell wrote:
> > On Fri, 4 Sept 2026 at 11:36, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > On Fri, Sep 04, 2026 at 11:28:35AM +0100, Peter Maydell wrote:
> > > > On Fri, 4 Sept 2026 at 11:25, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > We need to use QAPI MachineInfo / MachineClass to report to mgmt apps
> > > > > whether a machine is capable of using hardware acceleration or not in
> > > > > response to "query-machines".
> > > > > 
> > > > > Currently if a target supports HW accel, then apps assume that all
> > > > > machines in that target can use acceleration. This was a convenient
> > > > > short cut assumption, but this new machine suggests we can no make
> > > > > do with that assumption, and need to explicitly report it per-machine.
> > > > 
> > > > That assumption has never been true for Arm; this new machine
> > > > type is no different to any of our existing boards in that regard.
> > > > Support for KVM etc is only present for the 'virt' machine type and
> > > > one or two others. Most of the rest don't work with KVM because they
> > > > create a specific CPU type (not 'host' or 'max') and that won't work
> > > > with KVM, or (as with sbsa-ref) because they want EL3 support and
> > > > KVM doesn't provide that.
> > > 
> > > Oh, then the problem is already way worse than I realized which
> > > really makes we think we should consider exposing whether
> > > machines can use HW acceleration or not.
> > 
> > It also depends on the options to the machine, so for instance
> > this should always work with any of the hw accelerators:
> >   qemu-system-aarch64 -M virt -cpu host
> > but this wants nested virt, so only works with a hw accel
> > that supports that and a host kernel that has the KVM side support:
> >   qemu-system-aarch64 -M virt,virtualization=on -cpu host
> > and this wants EL3, which won't work in any hw accelerator
> >   qemu-system-aarch64 -M virt,secure=on -cpu host
> > 
> > Similarly the interrupt controller choice matters, so this:
> >   qemu-system-aarch64 -M virt,gic-version=2 -cpu host
> > may or may not work depending on whether the host CPU has the
> > GICv2 back-compat support; and this:
> >   qemu-system-aarch64 -M virt,gic-version=x-5 -cpu host
> > is currently TCG-only. (But also it's experimental so you kind
> > of know you're off-piste here ;-))
> > 
> > If you try the things that won't work with -enable-kvm then they
> > should wind up causing QEMU to exit with a hopefully more or less
> > informative error message, but I don't think we have any mechanism
> > for introspection of the form "if I try this particular set of
> > QEMU options is it going to work?" short of actually trying.
> 
> I recall some discussion with Markus / Paolo when brainstorming
> declarative dynamic machines, we'd need another MachinePhase
> iterating on all selected types to instantiate and check whether
> they can be instantiated, and returning impossible config error;
> way before a property is evaluated on an instance at Realize time.

Mmm, yes, that is getting into quite alot of work for probably not
enough benefit.

> Here IMO accelerators should report whether a CPU model class
> requested is accelerable or not (then later we can double check
> with features updated on the model instances).
> The machine deciding is a shortcut, not scalable and hard to maintain.

Yeah, I think you're right - the machine does look like a facade
around the CPU for accelerator runnability. So it probably better
fits the QMP commands for querying CPU runnability.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


