Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E880C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2P97-0005wh-K2; Fri, 04 Sep 2026 04:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2P95-0005wG-JL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2P93-0001g4-KP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788509972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=spxozVQA6iSz1FLZsD/Ul/7ecf3JuPqoCoxd76szXFE=;
 b=YNqTokBw5o7rOGDF2sbW5ZEEWxmda47vtqZ08cSSJqN/lklhBElu++YxXa4IU8YkPOyQ+V
 l1iqN7ir7uhXDJQuPe/I8LC34ca5RLVVjmt12nqGX+vH/esNqiD2FRjVHz+aqGxMzOOFSL
 p4oRk9HsGFJeuKM3TVYxBLz08Yr8j7Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-p1hUJDl3MOCeXBzBjNfHZA-1; Fri,
 04 Sep 2026 04:19:28 -0400
X-MC-Unique: p1hUJDl3MOCeXBzBjNfHZA-1
X-Mimecast-MFC-AGG-ID: p1hUJDl3MOCeXBzBjNfHZA_1788509967
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51D35195399B; Fri,  4 Sep 2026 08:19:27 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F30D71955F70; Fri,  4 Sep 2026 08:19:24 +0000 (UTC)
Date: Fri, 4 Sep 2026 09:19:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
Message-ID: <app_CnHimOrOymMH@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Aug 28, 2026 at 04:13:32PM -0700, Pierrick Bouvier wrote:
> On 8/28/2026 3:58 PM, Pierrick Bouvier wrote:
> > Now that we can link a single-binary with at least two targets (arm, aarch64),
> > we want to make sure that we expose the same set of machines (later devices and
> > cpus) than target binaries. For that, we implemented a static filtering based on
> > target interfaces that each machine will implement to declare which targets have
> > this machine.
> > 
> > However, we discovered that this static filtering is not enough. Indeed, some
> > machines and devices do not depend only on target, and their presence can depend
> > on Kconfig or host/target combination. Thus, our static approach can't work, and
> > we need something more flexible.
> > 
> > The goal of this series is to focus on the filtering mechanism, not on the
> > qemu-system binary itself, even though it's included here to give a full picture
> > of what we are building.
> > 
> > v3
> > --
> > 
> > Suggested by Richard, we simply use a callback added to TypeInfo.
> > Added full example with a single binary for arm+aarch64, and then
> > arm+aarch64+microblaze.
> > Also, added scripts/single-binary-compare-cmdline.sh, which compares list of
> > cpus, devices and machines between single-binary and original binaries.
> > This is what we can use in CI to ensure we correctly tagged all QOM types.
> >
> 
> After applying this series, and running
> scripts/single-binary-compare-cmdline.sh, you'll see than many devices
> are visible for microblaze, and should not.
> 
> microblaze+arm is a more interesting combination than riscv+arm because
> riscv has a lot of devices in common with arm. On the opposite,
> microblaze has a very reduced set (no virtio, no pci, etc).
> 
> I would like to focus the conversation on how to filter the remaining
> types. We could maybe generate something directly from Kconfig output,
> so we don't need boilerplate for each CONFIG_X entry.

I'm still not clear on why we need to filter the devices at all for
a new "qemu-system" binary ?

Looking at the device delta listed in your other mail, a large number
of those are PCI based. The microblaze machine types don't expose a
PCI controller, so those PCI devices are redundant / won't be used
with microblaze machines, which is why existing qemu-system-microblaze
doesn't link to those devices.

The same is true of many of the arm machines too though. Only a subset
of arm machines have PCI, but the qemu-system-arm binary still includes
and lists all these PCI devices. Users simply can't create a PCI device
for the arm machines that lack a PCI controller, or they'll receive an
error.

Why doesn't this approach extend into the future qemu-system binary ?
List everything, and if the user tries to add a device that's not
compatible with a machine, then it will simply result in an error.

It seems like much less work overall to do no filtering at all, than
trying to do per-target filtering which is the wrong granularity to
begin with, since the device usability contraints come from the
machine rather than the target.
 
With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


