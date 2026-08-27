Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D48C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzX7S-0003Mk-SJ; Thu, 27 Aug 2026 06:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzX7R-0003Lp-ER
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzX7N-0002o4-Aw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787825636;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNqTnSzXjq1FFnhGJCIoqeClbAUQRviA1YvNpWOKzP4=;
 b=OoTP2cCz/rXDgB6KdHiVOhNqNu+iiLeAxjDdsLN08xuIS4PbaIWFku9hBqDOg79BQP8QZJ
 /pNlrehW+0beg5CwI9FK0KAq/Wa4lsxeqVNm41L9qnXfmWinGJKNHZJejA2QMjB2GySVIq
 rhXaPnuyTAnkDD9hozFVguVPAg0jX0U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-WJq6vs-7MUW811MQM2g7sg-1; Thu,
 27 Aug 2026 06:13:51 -0400
X-MC-Unique: WJq6vs-7MUW811MQM2g7sg-1
X-Mimecast-MFC-AGG-ID: WJq6vs-7MUW811MQM2g7sg_1787825625
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25F3A1802147; Thu, 27 Aug 2026 10:13:44 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AA8B1956044; Thu, 27 Aug 2026 10:13:33 +0000 (UTC)
Date: Thu, 27 Aug 2026 11:13:30 +0100
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
Subject: Re: [PATCH 10/12] target-info: add -target and program-name selection
Message-ID: <apANygsXLoXL96f6@redhat.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-11-luoyonggang@gmail.com>
 <ao7gGVuiDcVZSN6v@redhat.com>
 <0f3d8fe9-b3ad-40c5-9078-c13738997998@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f3d8fe9-b3ad-40c5-9078-c13738997998@oss.qualcomm.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 26, 2026 at 11:13:05AM -0700, Pierrick Bouvier wrote:
> On 8/26/2026 5:46 AM, Daniel P. Berrangé wrote:
> By implementing *strict* identical behavior with existing binaries, we
> indeed didn't add any new feature, but:
> - we reduced total number of compilation units by 30%
> - we cleaned up a lot of headers and did a lot of refactoring
> - we have a systematic approach to add new targets in single-binary
> while being able to reuse all existing tests without any change.
>
> From my point of view, what you see as a detour was precisely what made
> us progress so far in a year.

No, on the contrary, that's all good stuff.

What I'm considering here is the behaviour of the new proposed
qemu-system and what it needs to be able todo.

Some of this work only appears relevant to a scenario where
qemu-system-$target is dropped in favour of a symlink to the
new qemu-system. That forces qemu-system to be 100% compatible
with the existing binaries, which IMHO is an undesirable
constraint and creates extra work.

We can have the benefits of the compliation unit reduction,
cleaner headers, etc, while still having qemu-system be a
distinct break with the past in a number of areas.

> > If we ignore historical compat and treat qemu-system as a
> > clean break, then I'd suggest that 'target' is not a concept
> > to be exposed to the user at all.
> >
> 
> If your only problem is with having a new -target option, I would be
> happy to just keep the behavior to derive the target from current binary
> name. That's a very small compromise on my side, and -target is just
> here for convenience. It's not the end of the path.

It isn't about the syntax - whether it is implicit from the binary
name or explicit from -target, that's still producing a design
where the target is the top level concept, and machine is a second
level concept. I don't see how that makes sense given the longer
term intent to have machines with heterogeneous CPU targets.

The machine looks like it should be the top level concept, with
target(s) derived from that.

> > The user cares about the machine (and CPUs) they want to run,
> > and their choice in this respect is what should determine the
> > target(s) QEMU needs to enable. We should take
> > 
> >   qemu-system --machine vexpress-a15
> > 
> > that tells us we need the arm target. If we need to distinguish
> > arm7 vs aarch64, then the choice of -cpu should determine 32
> > bs 64 bit.
> > 
> > This extends better into the future world where we have
> > machine type that could involve CPUs from multiple targets.
> > 
> > IOW machine config option / QOM class is what we should pivot
> > off rather than a global target config option.
> > 
> > This likely implies that the MachineClass should gain a class
> > method to query the QEMU_ARCH_XXXX bitmask required. Initially
> > restricted to only a single target, so you can wire that through
> > to the current global target info at startup. Later expanded to
> > support multiple concurrent targets.
> >
> 
> While it sounds nice on paper, you will be doomed to ambiguity with this:
> 
> qemu-system -machine virt -cpu max
> 
> What is your next plan? add an environment variable to solve it?

The machine names need to be globally unique across all targets.
So the 'virt' naming clash needs a rename, such as is done in
an earlier patch in this series.

> Deriving target from argv(0) or -target is explicit, predictable, boring
> and reliable, and it's exactly what we need now.

With the requirement that machine names are globally unique, we can
determine the target(s) directly.

Relying on argv(0) does not appear to work in a heterogeneous future
as target is no longer unique per process, but the machine type would
be unique.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


