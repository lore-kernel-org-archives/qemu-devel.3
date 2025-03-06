Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A624DC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCxO-0008Qu-Hv; Thu, 06 Mar 2025 10:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqCx7-00087y-U8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqCx5-0002LY-Rk
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741274157;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqKAAwXyMRTqVfEUAbuCN38aI16lO0p7fi6yeDuU3Os=;
 b=eHcH0GJbduAKd6NOnJ/1V1kdKll2lz2fNyjkMVimpQvDZ4bX88Lo6m3i1KhAlYWc2KM27i
 lGpavkZMAriAtHkPU/bF9AZjUgwaApf1hPE5iP4eSBD023oKFVFMCTJahIVhxQ9O0gvd0R
 AuSm01JkejsHiuAqJGvG2y6XhkWjgzs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-iTEfLHcMP1eXvJ5ilyKQrw-1; Thu,
 06 Mar 2025 10:15:47 -0500
X-MC-Unique: iTEfLHcMP1eXvJ5ilyKQrw-1
X-Mimecast-MFC-AGG-ID: iTEfLHcMP1eXvJ5ilyKQrw_1741274146
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12386195605E; Thu,  6 Mar 2025 15:15:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 290AB1954B32; Thu,  6 Mar 2025 15:15:42 +0000 (UTC)
Date: Thu, 6 Mar 2025 15:15:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
Message-ID: <Z8m8GmPzTum7qEcS@redhat.com>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <35177cd6-0741-4c28-a5d5-3529208a31dc@linaro.org>
 <dd0336c2-c2ed-477c-8f40-eaee2f110238@redhat.com>
 <21a34cac-855b-4628-a154-e708ea85df59@linaro.org>
 <CABgObfaKQLizim36Lzqzn+brc5d7m10eKbZV59ZK9+03Kt7eTg@mail.gmail.com>
 <Z8mMhjwiYCY7Pq4H@redhat.com>
 <c6953b69-a54d-6d42-343e-dae07266306f@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6953b69-a54d-6d42-343e-dae07266306f@eik.bme.hu>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Mar 06, 2025 at 02:45:52PM +0100, BALATON Zoltan wrote:
> On Thu, 6 Mar 2025, Daniel P. Berrangé wrote:
> > On Thu, Mar 06, 2025 at 12:34:13PM +0100, Paolo Bonzini wrote:
> > > Il gio 6 mar 2025, 10:27 Philippe Mathieu-Daudé <philmd@linaro.org> ha
> > > scritto:
> > > 
> > > > This API is to allow refactoring code for heterogeneous emulation,
> > > > without changing user-facing behavior of current qemu-system binaries,
> > > > which I now consider as 'legacy'.
> > > > 
> > > > Once all current restrictions removed, the new qemu-system-heterogeneous
> > > > binary is expected to run any combination of targets.
> > > > 
> > > > qemu-system-$target will be a call to qemu-system-heterogeneous with
> > > > a restricted subset, possibly in the form of:
> > > > 
> > > >   $ qemu-system-heterogeneous --target aarch64-softmmu
> > > > 
> > > 
> > > Or just qemu-system I guess.
> > > 
> > >     ^ equivalent of today's qemu-system-aarch64
> > > > 
> > > > If you don't like 'qemu_legacy_binary_' prefix, I can use
> > > > 'qemu_single_binary_' instead.
> > > > 
> > > 
> > > Still there is a problem with renaming binaries (both the "qemu-kvm" case
> > > and the good/bad case that Richard pointed out).
> > 
> > We could special case the '-kvm' suffix, because by its nature it
> > implies the current binary build target.
> > 
> > > 
> > > I think you should try creating two versions of system/arch_init.c, so that
> > > it has a separate implementation for heterogeneous vs. single-target
> > > binaries. Then you can keep separate linking steps for single-target
> > > binaries and you naturally get the right target info from either the
> > > target-specific arch_init-single.c, or the --target option for
> > > arch_init-multi.c.
> > > 
> > > (Is --target even necessary? As long as you have a way disambiguate
> > > same-named machines like -M virt, and have no default machine in the
> > > multi-target binary, you shouldn't need it).
> > 
> > If we did 'query-machines' on qemu-system-heterogeneous, it would
> > return all machines from all targets. To disambiguate naming there
> > are various options
> > 
> >  * The query-machines command would have to gain a new 'target'
> >    field and we would have to document that uniqness is across
> >    the tuple (name, target), not merely name. That's a semantic
> >    change.
> > 
> >    We would still need a way to express the 'target' when asking
> >    to instantiate a machine
> > 
> >  * The query-machines command would have to gain a new 'target'
> >    paramter so callers can restrict the data they receive back
> > 
> >    We would still need a way to express the 'target' when asking
> >    to instantiate a machine
> > 
> >  * Rename all machine types so they are '<target>-<machine>'
> >    The query-machines command doesn't change. Apps would have
> >    to "parse" the machine name to see what 'target' each is
> >    associated with, or we include an explicit 'target' field
> >    in the returned data. Instianting a machine would not need
> >    changing
> 
> I think -machine m68k:virt could work, -M help would list machines like:
> 
> arm:raspi
> i386:pc
> etc.
> 
> Management apps could easily find : to separate arch but those that don't
> care about arch would just work and list more possible machines. Some
> machines like pc or mac99 that may appear differently in different single
> arch binary might need to get resolved first. Maybe need a way to search
> machine list by pattern e.g. as -machine x86_64:help.

...except that custom structures/formats in command line args is
something we've tried very hard to eliminate in Qemu, and instead
model everything as a distinct fields, using QAPI, so...

.. if you're meaning "arm:raspi" as a short hand for "target:machine"
   that would be a design anti-pattern, b

...if you're meaning that "arm:raspi" is the full machine name, to be
   strictly treated as an opaque string that would be acceptable.

I rather think the latter would not end up being treated as an opaque
string though - the tempetation to parse it & assign semantics to the
pieces is just too great. So I'm not a fan of that approach.

From a QAPI design best pratice POV, the requirement would be for

 -machine target=arm,name=raspi


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


