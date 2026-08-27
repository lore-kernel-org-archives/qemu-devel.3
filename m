Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FF3C61DCB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXHG-0007c4-Tf; Thu, 27 Aug 2026 06:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzXHF-0007ba-Ha
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzXHD-0004gi-J2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787826246;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFG4une+pOjvmf8kvC8piq6u39t1e5EkqpJ+4mfgZOI=;
 b=RQh7DCLZfwR5ASge4ZVDK537wpsgtrgeIgmG7xbE3rkvQlXfiWkIE/F9syYTfvqJllHc3M
 1Wah2GOc/nDsDTdXLwOGINHEvKpOaPzvGqQhiEvPS0FAmCmupmhi9oWd6pMqnF1q8MgrEG
 cCMXdvXBCnMZoXg4ykOznNzDD1PScZk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-D8-y7MpaPd-oY3yG4MydeA-1; Thu,
 27 Aug 2026 06:22:57 -0400
X-MC-Unique: D8-y7MpaPd-oY3yG4MydeA-1
X-Mimecast-MFC-AGG-ID: D8-y7MpaPd-oY3yG4MydeA_1787826173
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF12A1954227; Thu, 27 Aug 2026 10:22:52 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62CFA18005BC; Thu, 27 Aug 2026 10:22:41 +0000 (UTC)
Date: Thu, 27 Aug 2026 11:22:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
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
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
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
Message-ID: <apAP7r--ejtgqwpy@redhat.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Wed, Aug 26, 2026 at 11:35:11AM -0700, Pierrick Bouvier wrote:
> On 8/26/2026 5:32 AM, Daniel P. Berrangé wrote:
> > I think this is probably also what leads to the increased RAM
> > usage in qemu-system-riscv64. Starting
> > 
> >   qemu-system-riscv64 -nodefaults -display none -M none
> > 
> > shows an increase in RAM usage from  17.3 to 20.7 MB which
> > is about 15% increase. NB this is dirty, private RAM per
> > process. The shared RAM pages also increase but that's not
> > a concern since they're common to all QEMU processes.
> > 
> > qemu-system-aarch64 shows a much smaller RAM increase, since
> > it only grew from 1430 classes to 1530 classes.
> > 
> > We have many more target though, so if we assume the end
> > point where every single target is unified, the the union
> > of all classes for all targets comes to approx 3600.
> > 
> > My guesstimate is that would mean a memory increase for
> > qemu-system-riscv64 from 17.3 to 39.9 MB, which is a
> > 72% increase.
> > 
> > In absolute terms this is still modest, but for deployments
> > with large VM counts  and small RAM sizes, that gets to be
> > significant.
> >
> 
> How surprising (:eye-roll:) it is that adding more code and more classes
> would result in a higher memory usage, or bigger binary size for
> qemu-system.

It is not a surprise, I'm just examining the effect.

> More seriously. If someone is concerned about it, the simple solution is
> to restrict list of targets and/or Kconfig to include less.

Building custom minimized QEMU is not a path that works for
distro vendors, as we can't tailor to distinct use cases,
so the footprint of the generic build and any impact on our
packaging is a factor I'm interested in.

The 'modules' feature came out of our work to lower the
footprint of a default "all features" QEMU build.

As long as qemu-system-$target stays around as its current
impl, it isn't a blocker. If qemu-system-$target were changed
into a symlink to qemu-system, then it becomes a critical path
problem for the distro packaging.

I think the solution long term is to further expand the use
of modules to more of the code.

> > IMHO we should make a clean break with the past. Leave
> > the existing qemu-system-$TARGET binaries being built
> > from the same pieces they are today, such that there
> > is better confidence that we are not making behavioural
> > changes to them.
> >
> 
> Funny enough, it reminded me word for word of a blog post from a
> Microsoft employee where he explained that powershell existed only
> because young developers were scared to modify original cmd shell.
> 
> Regression issues are solved with testing and good design, not by
> inventing new things.

We don't have sufficient testing, nor is the current QEMU
qemu-system-$target especially good from a design POV as
it has decades of historical baggage holding us back. The
introduction of a new binary is the ideal time to address
this long term problem. It frees us to do changes that are
otherwise impossible and to experiment with new ideas
without worrying about implications for the current binaries
and their users.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


