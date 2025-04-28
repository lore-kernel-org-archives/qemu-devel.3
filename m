Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E280C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9KHN-0006fA-Is; Mon, 28 Apr 2025 04:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1u9KHL-0006et-4J
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1u9KHI-0006em-Kf
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745830548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ELTooJnYU1l8h3nC4U6OkWGa+eIEAjZf374NjSPWjRQ=;
 b=PFT9xC9TB+Ts71W/SXlLFgY9MoxNv8Xw978vtfsGrFGcyXPpZZsE7+ArdxvoTWZxTMD6wF
 Z0gxX+oU/mJX2htid+1EtIxdNiMoXFUSCnxUWze3AQcAVANRBeKhNIOuIgK911Gb3rXqn5
 hK6FZvbNLbsJ5kc4JlBR6fwjjp44uSg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-vxdW9xFqPFimPwqkuGwy_w-1; Mon,
 28 Apr 2025 04:55:43 -0400
X-MC-Unique: vxdW9xFqPFimPwqkuGwy_w-1
X-Mimecast-MFC-AGG-ID: vxdW9xFqPFimPwqkuGwy_w_1745830542
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D17119560AA; Mon, 28 Apr 2025 08:55:42 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C4FC1800371; Mon, 28 Apr 2025 08:55:37 +0000 (UTC)
Date: Mon, 28 Apr 2025 10:55:34 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Message-ID: <aA9ChuXrkmx1Igy5@angien.pipo.sk>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a584b69n.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Apr 25, 2025 at 17:38:44 +0200, Markus Armbruster via Devel wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

[...]

> To be precise: conditionals that use macros restricted to
> target-specific code, i.e. the ones poisoned by exec/poison.h.  Let's
> call them target-specific QAPI conditionals.
> 
> The QAPI generator is blissfully unaware of all this.
> 
> The build system treats QAPI modules qapi/*-target.json as
> target-specific.  The .c files generated for them are compiled per
> target.  See qapi/meson.build.
> 
> Only such target-specific modules can can use target-specific QAPI
> conditionals.  Use in target-independent modules will generate C that
> won't compile.
> 
> Poisoned macros used in qapi/*-target.json:
> 
>     CONFIG_KVM
>     TARGET_ARM
>     TARGET_I386
>     TARGET_LOONGARCH64
>     TARGET_MIPS
>     TARGET_PPC
>     TARGET_RISCV
>     TARGET_S390X

I've had a look at what bits of the QMP schema are depending on the
above defines which libvirt uses.

In many cases libvirt could restrict the use of given command/property
to only supported architectures. We decided to simply probe the presence
of the command because it's convenient to not have to filter them any
more

- query-gic-capabilities
    - libvirt already calls this only for ARM guests based on the
      definition

- query-sev and friends
  - libvirt uses presence of 'query-sev' to decide if the binary
    supports it; patching in a platofrm check is possible although
    inconvenient

- query-sgx and friends
  - similar to sev

-query-cpu-definitions and friends
  - see below


> 
> >                            What we try to do here is to build them only once
>  instead.
>  
> You're trying to eliminate target-specific QAPI conditionals.  Correct?
> 
> > In the past, we identied that the best approach to solve this is to expose code
> > for all targets (thus removing all #if clauses), and stub missing
> > symbols for concerned targets.
> 
> This affects QAPI/QMP introspection, i.e. the value of query-qmp-schema.
> 
> Management applications can no longer use introspection to find out
> whether target-specific things are available.

Indeed and libvirt already uses this in few cases as noded above.

> 
> For instance, query-cpu-definitions is implemented for targets arm,
> i386, loongarch, mips, ppc, riscv, and s390x.  It initially was for
> fewer targets, and more targets followed one by one.  Still more may
> follow in the future.  Right now, management applications can use
> introspection to find out whether it is available.  That stops working
> when you make it available for all targets, stubbed out for the ones
> that don't (yet) implement it.
> 
> Management applications may have to be adjusted for this.
> 
> This is not an attempt to shoot down your approach.  I'm merely
> demonstrating limitations of your promise "if anyone notices a
> difference, it will be a bug."
> 
> Now, we could get really fancy and try to keep introspection the same by
> applying conditionals dynamically somehow.  I.e. have the single binary
> return different introspection values depending on the actual guest's
> target.

I wonder how this will work if libvirt is probing a binary. Libvirt does
not look at the filename. It can't because it can be a
user-specified/compiled binary, override script, or a distro that chose
to rename the binary.

The second thing that libvirt does after 'query-version' is
'query-target'.

So what should libvirt do once multiple targets are supported?

How do we query CPUs for each of the supported targets?

Will the result be the same if we query them one at a time or all at
once?

> This requires fixing the target before introspection.  Unless this is
> somehow completely transparent (wrapper scripts, or awful hacks based on
> the binary's filename, perhaps), management applications may have to be
> adjusted to actually do that.

As noted filename will not work. Users can specify any filename and
create override scripts or rename the binary.

> 
> Applies not just to introspection.  Consider query-cpu-definitions
> again.  It currently returns CPU definitions for *the* target.  What
> would a single binary's query-cpu-definitions return?  The CPU
> definitions for *all* its targets?  Management applications then receive
> CPUs that won't work, which may upset them.  To avoid noticable
> difference, we again have to fix the target before we look.

Ah I see you had a similar question :D

> 
> Of course, "fixing the target" stops making sense once we move to
> heterogeneous machines with multiple targets.
> 
> > This series build QAPI generated code once, by removing all TARGET_{arch} and
> > CONFIG_KVM clauses. What it does *not* at the moment is:
> > - prevent target specific commands to be visible for all targets
> >   (see TODO comment on patch 2 explaining how to address this)
> > - nothing was done to hide all this from generated documentation


