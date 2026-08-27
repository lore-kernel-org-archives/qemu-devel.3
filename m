Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46032C61DC7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzWty-0000HJ-Sd; Thu, 27 Aug 2026 06:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzWtx-0000GZ-Kr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzWtu-00084H-Vk
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787824802;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+4pZWx3NugtOS6fR3PbIv1beFy0znaJNkgwfzU0W6g=;
 b=P3pKiKgHMxmsX3364VPGUANrS5hGw8bPnWMocRciICiRUa04AjMdeA/k/pVt6QcChLPAMq
 mehj9HHmruY3WwiRZ34V5W/KcdjNlF9hYZhFw1CRMGhHYamnbLGdwK0IS7+G4says8SXKk
 MLYhJFPScjTtwk32LM/CyzDV4J+R3xs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-Heyc38tiOWuxNt3mcFuN8w-1; Thu,
 27 Aug 2026 05:58:48 -0400
X-MC-Unique: Heyc38tiOWuxNt3mcFuN8w-1
X-Mimecast-MFC-AGG-ID: Heyc38tiOWuxNt3mcFuN8w_1787824723
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF06195398E; Thu, 27 Aug 2026 09:58:42 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CED29180059E; Thu, 27 Aug 2026 09:58:31 +0000 (UTC)
Date: Thu, 27 Aug 2026 10:58:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
Message-ID: <apAKRZtz9xsB1U9s@redhat.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <392d0652-2d06-4889-8b67-c199e59bd314@nutanix.com>
 <7f865144-dc5e-4eaa-9704-8cb3cc6a1158@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f865144-dc5e-4eaa-9704-8cb3cc6a1158@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Aug 26, 2026 at 05:41:30PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 8/26/2026 10:40 AM, Mark Cave-Ayland wrote:
> > On 26/08/2026 13:32, Daniel P. Berrangé wrote:
> > 
> > > On Sun, Aug 23, 2026 at 11:07:18PM +0800, Yonggang Luo wrote:
> > > 
> > > snip,
> > > 
> > > ..to comment just on the end result for now..
> > > 
> > > > The last patch builds qemu-system (and qemu-systemw on Windows) from
> > > > aarch64 common/system objects plus RISC-V arch objects, and installs
> > > > qemu-system-{arm,aarch64,riscv32,riscv64} as symlinks so argv[0] still
> > > > selects TargetInfo.
> > > > 
> > > > Examples:
> > > > 
> > > >    qemu-system -target aarch64 -M virt ...
> > > >    qemu-system-riscv64 -M virt ...
> > > > 
> > > > A basename that matches no registered token falls through to the unique
> > > > default. A combined binary with no suffix requires -target when more
> > > > than one default TargetInfo is registered.
> > > 
> > > In testing and comparing  the new qemu-system-riscv64 symlink
> > > to qemu-system vs the current standalone qemu-system-riscv64
> > > binary there are some significant user visible changes.
> > > 
> > > The simplest is 'qom-list-types' went from reporting approx
> > > 770 classes, to reporting approx 1530 classes. IOW, the
> > > qemu-system-riscv64 binary is now reporting supporting for
> > > all the classes that were unique to arm.
> > > 
> > > The '-device help' output similarly shows a great many more
> > > devices
> > > 
> > > TL;DR introspecting qemu-system-riscv64 is no longer accurate
> > > wrt riscv64 capabilities.
> > > 
> > > This is not suprising, since we register all TypeInfo meaning
> > > we get all QOM classes present. Some of Pierricks patches try
> > > to filter places which iterate over classes, but this does not
> > > have full coverage.
> > > 
> > > 
> > > I think this is probably also what leads to the increased RAM
> > > usage in qemu-system-riscv64. Starting
> > > 
> > >    qemu-system-riscv64 -nodefaults -display none -M none
> > > 
> > > shows an increase in RAM usage from  17.3 to 20.7 MB which
> > > is about 15% increase. NB this is dirty, private RAM per
> > > process. The shared RAM pages also increase but that's not
> > > a concern since they're common to all QEMU processes.
> > > 
> > > qemu-system-aarch64 shows a much smaller RAM increase, since
> > > it only grew from 1430 classes to 1530 classes.
> > > 
> > > We have many more target though, so if we assume the end
> > > point where every single target is unified, the the union
> > > of all classes for all targets comes to approx 3600.
> > > 
> > > My guesstimate is that would mean a memory increase for
> > > qemu-system-riscv64 from 17.3 to 39.9 MB, which is a
> > > 72% increase.
> > > 
> > > In absolute terms this is still modest, but for deployments
> > > with large VM counts  and small RAM sizes, that gets to be
> > > significant.
> > > 
> > > 
> > > None of this means single binary is a bad idea.
> > > 
> > > 
> > > My main takeaway is that we're creating uneccessary work
> > > for ourselves by trying to make 'qemu-sytem' identical
> > > in behaviour to qemu-system-$TARGET.
> > > 
> > > The complex filtering patches / QOM interfaces that I
> > > found uncomfortable in Pierrick's base series are largely
> > > around the filtering needed to simulate qemu-system-$TARGET,
> > > and they're still incomplete. I don't have high confidence
> > > in our ability to avoid regressions if we go route this
> > > route.
> > > 
> > > 
> > > IMHO we should make a clean break with the past. Leave
> > > the existing qemu-system-$TARGET binaries being built
> > > from the same pieces they are today, such that there
> > > is better confidence that we are not making behavioural
> > > changes to them.
> > > 
> > > 
> > > qemu-system should be built alongside qemu-system-$TARGET
> > > and offer new semantics where it is documented as exposing
> > > everything from all targets whenever introspected and does
> > > not apply target type or target Kconfig filtering to inputs/
> > > outputs.
> > > 
> > > We still get the benefit of only building most  .o files
> > > once, so keeping qemu-system-$TARGET is only a small
> > > overhead in the final step of linking everything together.
> > > 
> > > 
> > > qemu-system will still have the increased memory overhead
> > > but that's fine as qemu-system-$TARGET will be unaffected.
> > > We can tackle the memory overhead of qemu-system at our
> > > leisure through use of loadable modules, and thus not have
> > > that as a task to think about today.
> > > 
> > > 
> > > With the clean break with the past, we also have the
> > > ability to tackle various long standing design mistakes
> > > present in qemu-system-$TARGET instead of carrying them
> > > over into the new binary.
> > > 
> > > Specifically
> > > 
> > >   * -nodefaults should become the default
> > >   * All CLI args should be processed in order from
> > >     the command line, so we eliminate the nonsense
> > >     where we process some -object, then -chardev,
> > >     then more -object through hand crafted deps
> > > 
> > >   * No default machine type
> > 
> > I would even go as far as to suggest that we should make modules mandatory for qemu-system, so that devices can be loaded upon demand during machine construction to help keep the size down.
> > 
> > I'll leave whether that is through dependency tracking or via an explicit load directive for someone else to decide :)
> > >   * Drop all legacy syntax so we only have a single
> > >     QAPI based way of configuring.
> > >     eg drop -hda, -hdb, -cdrom, -drive, etc
> > >        only keeping -blockdev
> > >     eg drop -mon, -monitor, -qmp, etc only
> > >        keeping -object
> > 
> > The only problem with this is that I often get a lot of complaints that QEMU command lines are complicated from retro folks who just want to run their favourite old games. Why would they want to come up with a long-winded -drive command line when they can just use -hda instead?
> > 
> > > We don't have to do all that straightaway. If we declare
> > > qemu-system "experimental" initially we can iterate on
> > > that intentionally breaking compat in releases, without
> > > any impact on qemu-system-$TARGET.
> > > 
> > > Avoiding the back compat task will give us more flexibility
> > > with the follow on work when people come to create new
> > > machine types with heterogenous CPU targets.
> > I agree that this is a good opportunity to explore new things without being tied to past decisions.
> 
> To be fair I don't think Phil and Pierrick are basing their design solely
> on "we must comply to what qemu-system-$target does and has".  From what I
> understood they're trying to get the prototype out of the door to prove that
> it works, i.e. "this is clearest and most viable path we're seeing to make it
> happen". This would naturally adhere to what is already available because,
> well, it's already a proven base to build on top of.

In looking at these patches my impression is introducing "qemu-system"
as its own thing is simpler than trying to make 'qemu-system' be able
to replace & simulate qemu-system-$target, which this does.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


