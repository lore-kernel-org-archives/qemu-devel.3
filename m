Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4344C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9gGD-0008Qm-UX; Tue, 29 Apr 2025 04:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9gGA-0008QP-IN
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9gG7-00057y-IU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745915044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OgYtKMXbx4Z+dO1+tpXRR5gV5Uix4DFdS3gI0Ps7Vw8=;
 b=VwieMMc7Zw8TwBjLIKnwPovtU2ZsrdFwpR51RNjJvbqTQNnC/F1OHO7SqRtl9mgYkDgYmO
 xZQzgLw58bDREvfhxSs5sGYzjP8w1hYGXmF2Xr7gcb+jodpk6LDTgDUaPJOhUTRSqZyF+Z
 93Yv+n82XddjkHab0iFvGuIxAZxCXqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-v8w7NI_qPs-WKbLvxK-pBA-1; Tue,
 29 Apr 2025 04:24:00 -0400
X-MC-Unique: v8w7NI_qPs-WKbLvxK-pBA-1
X-Mimecast-MFC-AGG-ID: v8w7NI_qPs-WKbLvxK-pBA_1745915038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 738F31956096; Tue, 29 Apr 2025 08:23:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E312180045C; Tue, 29 Apr 2025 08:23:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B63921E6768; Tue, 29 Apr 2025 10:23:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Krempa <pkrempa@redhat.com>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  stefanha@redhat.com,  Michael Roth
 <michael.roth@amd.com>,  pbonzini@redhat.com,  peter.maydell@linaro.org,
 thuth@redhat.com,  jsnow@redhat.com,  philmd@linaro.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  devel@lists.libvirt.org
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
In-Reply-To: <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org> (Pierrick
 Bouvier's message of "Mon, 28 Apr 2025 09:35:11 -0700")
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
Date: Tue, 29 Apr 2025 10:23:55 +0200
Message-ID: <875xinnzok.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 4/28/25 4:07 AM, Markus Armbruster wrote:
>> Peter Krempa <pkrempa@redhat.com> writes:
>> 
>>> So what should libvirt do once multiple targets are supported?
>>>
>>> How do we query CPUs for each of the supported targets?
>>>
>
> It's kind of a similar question we have to solve now with QEMU code.
> What happens when a symbol is duplicated, and available only for several 
> targets?
>
> In this case, we found various approaches to solve this:
> - unify this symbol for all targets (single implementation)
> - unify all targets to provide this symbol (multiple impl, all targets)
> - rename symbols adding {arch} suffix, so it's disambiguated by name
> - create a proper interface which an available function (multiple impl, 
> selective targets)
>
> In the case of query-cpu-definitions, my intuition is that we want to 
> have a single implementation, and that we return *all* the cpus, merging 
> all architectures. In the end, we (and libvirt also) should think out of 
> the "target" box. It's an implementation detail, based on the fact QEMU 
> had 'targets' associated to various binaries for a long time and not a 
> concept that should leak into all consumers.
>
>>> Will the result be the same if we query them one at a time or all at
>>> once?
>> 
>> Pierrick's stated goal is to have no noticable differences between the
>> single binary and the qemu-system-<target> it covers.  This is obviously
>> impossible if we can interact with the single binary before the target
>> is fixed.
>> 
>
> Right.
> At this point, we can guarantee the target will be fixed before anything 
> else, at the start of main(). It's obviously an implementation choice, 
> but to be honest, I don't see what we would gain from having a "null" 
> default QEMU target, unable to emulate anything.
>
>>>> This requires fixing the target before introspection.  Unless this is
>>>> somehow completely transparent (wrapper scripts, or awful hacks based on
>>>> the binary's filename, perhaps), management applications may have to be
>>>> adjusted to actually do that.
>>>
>>> As noted filename will not work. Users can specify any filename and
>>> create override scripts or rename the binary.
>> 
>> True.
>> 
>
> I would prefer to not open this pandora box on this thread, but don't 
> worry, the best will be done to support all those cases, including 
> renaming the binary, allowing any prefix, suffix, as long as name stays 
> unambiguous. If you rename it to qemu-ok, how can you expect anything?
>
> We can provide the possibility to have a "default" target set at compile 
> time, for distributors creating their own specific QEMU binaries. But in 
> the context of classical software distribution, it doesn't make any sense.

I don't wish to derail this thread, but we've been dancing around the
question of how to best fix the target for some time.  I think we should
talk about it for real.

Mind, this is not an objection to your larger "single binary" idea.  It
could be only if it was an intractable problem, but I don't think it is.

You want the single binary you're trying to create to be a drop-in
replacement for per-target binaries.

"Drop-in replacement" means existing usage continues to work.
Additional interfaces are not a problem.

To achieve "drop-in replacement", the target needs to be fixed
automatically, and before the management application can further
interact with it.

If I understand you correctly, you're proposing to use argv[0] for that,
roughly like this: assume it's qemu-system-<target>, extract <target>
first thing in main(), done.

What if it's not named that way?  If I understand you correctly, you're
proposing to fall back to a compiled-in default target.

I don't think this is going to fly.

Developers rename the binary all the time, and expect this not to change
behavior.  For instance, I routinely rename qemu-FOO to qemu-FOO.old or
qemu-FOO.COMMIT-HASH to let me compare behavior easily.

We could relax the assumption to support such renames.  Developers then
need to be aware of what renames are supported.  Meh.

The more we relax the pattern, the likelier surprising behavior becomes.

We could mitigate surprises by eliminating the built-in default target.

Users invoke their binaries with their own names, too.  If Joe R. User
finds qemu-system-<joe's-fav-target> too much to type, and creates a
symlink named q to it, more power to him!

Distributions have packaged renamed binaries.  qemu-kvm has been used
quite widely.

In neither of these cases, relaxing the pattern helps.

The least bad solution I can see so far is a new option -target.

Instead of turning the target-specific binaries into links to / copies
of the single binary, they become wrappers that pass -target as the
first option.  We need to make sure this option is honored in time then,
which should be easy enough.

If you invoke the single binary directly, you need to pass -target
yourself.  If you don't to pass it, or pass it late in the command line,
you open up a window for interaction with indeterminate target.
Target-specific interfaces could exhibit different behavior then, even
fail.  That's fine under "additional interfaces are not a problem".

Thoughts?


