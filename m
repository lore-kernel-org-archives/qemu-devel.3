Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB8EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hZ1-0004ZZ-Ul; Tue, 29 Apr 2025 05:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9hYg-0004Y7-CR
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9hYa-0000Sb-Et
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745920034;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jB5eFbll/Khl+Lgmfw43vh49MnZI34gBcb3UpqqxXQ=;
 b=P3N4MbGoGt2o0cp9AuDB1ayyFTlmRPrAcwcJeG130Es1T57MHdPgZ+dPgvRA2XuFJZcinP
 t3u7HKSFHF4gXlsQfsdJzF0xklZTATtIHZJ9m6jmAu9zcX1aLd/a5tJ7qJewI0wmqY3xAn
 sjWUi187KXX41Rt+2gmbG3I44h/cTcg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-cIsCznpDPH-vUtp7lq4HPw-1; Tue,
 29 Apr 2025 05:47:10 -0400
X-MC-Unique: cIsCznpDPH-vUtp7lq4HPw-1
X-Mimecast-MFC-AGG-ID: cIsCznpDPH-vUtp7lq4HPw_1745920029
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65BBB1800EC8; Tue, 29 Apr 2025 09:47:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02CCA195608D; Tue, 29 Apr 2025 09:47:05 +0000 (UTC)
Date: Tue, 29 Apr 2025 10:47:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Message-ID: <aBCgFCckl6C6gvp7@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
 <ae321f41-9405-4a6a-915e-969303c08d9b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae321f41-9405-4a6a-915e-969303c08d9b@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 29, 2025 at 11:35:52AM +0200, Philippe Mathieu-Daudé wrote:
> On 29/4/25 10:23, Markus Armbruster wrote:
> > Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> > 
> > > On 4/28/25 4:07 AM, Markus Armbruster wrote:
> > > > Peter Krempa <pkrempa@redhat.com> writes:
> > > > 
> > > > > So what should libvirt do once multiple targets are supported?
> > > > > 
> > > > > How do we query CPUs for each of the supported targets?
> > > > > 
> > > 
> > > It's kind of a similar question we have to solve now with QEMU code.
> > > What happens when a symbol is duplicated, and available only for several
> > > targets?
> > > 
> > > In this case, we found various approaches to solve this:
> > > - unify this symbol for all targets (single implementation)
> > > - unify all targets to provide this symbol (multiple impl, all targets)
> > > - rename symbols adding {arch} suffix, so it's disambiguated by name
> > > - create a proper interface which an available function (multiple impl,
> > > selective targets)
> > > 
> > > In the case of query-cpu-definitions, my intuition is that we want to
> > > have a single implementation, and that we return *all* the cpus, merging
> > > all architectures. In the end, we (and libvirt also) should think out of
> > > the "target" box. It's an implementation detail, based on the fact QEMU
> > > had 'targets' associated to various binaries for a long time and not a
> > > concept that should leak into all consumers.
> > > 
> > > > > Will the result be the same if we query them one at a time or all at
> > > > > once?
> > > > 
> > > > Pierrick's stated goal is to have no noticable differences between the
> > > > single binary and the qemu-system-<target> it covers.  This is obviously
> > > > impossible if we can interact with the single binary before the target
> > > > is fixed.
> > > > 
> > > 
> > > Right.
> > > At this point, we can guarantee the target will be fixed before anything
> > > else, at the start of main(). It's obviously an implementation choice,
> > > but to be honest, I don't see what we would gain from having a "null"
> > > default QEMU target, unable to emulate anything.
> > > 
> > > > > > This requires fixing the target before introspection.  Unless this is
> > > > > > somehow completely transparent (wrapper scripts, or awful hacks based on
> > > > > > the binary's filename, perhaps), management applications may have to be
> > > > > > adjusted to actually do that.
> > > > > 
> > > > > As noted filename will not work. Users can specify any filename and
> > > > > create override scripts or rename the binary.
> > > > 
> > > > True.
> > > > 
> > > 
> > > I would prefer to not open this pandora box on this thread, but don't
> > > worry, the best will be done to support all those cases, including
> > > renaming the binary, allowing any prefix, suffix, as long as name stays
> > > unambiguous. If you rename it to qemu-ok, how can you expect anything?
> > > 
> > > We can provide the possibility to have a "default" target set at compile
> > > time, for distributors creating their own specific QEMU binaries. But in
> > > the context of classical software distribution, it doesn't make any sense.
> > 
> > I don't wish to derail this thread, but we've been dancing around the
> > question of how to best fix the target for some time.  I think we should
> > talk about it for real.
> > 
> > Mind, this is not an objection to your larger "single binary" idea.  It
> > could be only if it was an intractable problem, but I don't think it is.
> > 
> > You want the single binary you're trying to create to be a drop-in
> > replacement for per-target binaries.
> > 
> > "Drop-in replacement" means existing usage continues to work.
> > Additional interfaces are not a problem.
> > 
> > To achieve "drop-in replacement", the target needs to be fixed
> > automatically, and before the management application can further
> > interact with it.
> > 
> > If I understand you correctly, you're proposing to use argv[0] for that,
> > roughly like this: assume it's qemu-system-<target>, extract <target>
> > first thing in main(), done.
> > 
> > What if it's not named that way?  If I understand you correctly, you're
> > proposing to fall back to a compiled-in default target.
> > 
> > I don't think this is going to fly.
> 
> Rather than using non-constant argv[0] Pierrick suggested to add a
> single CLI option '-target' which selects the corresponding TargetInfo
> structure to use at runtime. I.e. for ARM:
> 
> https://lore.kernel.org/qemu-devel/20250424222112.36194-12-philmd@linaro.org/
> 
> For distros qemu-system-arm could be a shell script prepending
> '-target arm' while passing the arguments calling qemu-system.
> 
> If a distro wants to name a binary 'qemu-kvm' it can drop the
> -target option and hard-wire its target_info() to a distro-specific
> TargetInfo implementation, or &target_info_x86_64_system.

IMHO QEMU ought to just "do the right thing" with a qemu-kvm
binary out of the box.

If we define a clear naming scheme of 'qemu-system-$TARGET"  for picking
a non-default target, then we can declare anything not following that
scheme should assume native build target and thus 'just work'.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


