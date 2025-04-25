Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D1AC369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L8o-0001Xd-KQ; Fri, 25 Apr 2025 11:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8L8k-0001AB-1b
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8L8h-00054F-7Z
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745595533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0FskcGIWSxkj7w01b9Qqnff6G+zI1qtuJblZAs+kRg=;
 b=Je/PJXUbCODcZIVe+OaJ/vfHU9y3DL5OfAwOC/mwp6jS1H8fwJ1WtuQlIQSeaJdC8sQB2p
 kFRBzsF6xudEDy65fYZy0CVkg26ouiwylcCWAKPClLkMeo9jOOQsXm6aWnmH30vRKtHTuy
 ruJLt8cZYKQmbceFYOkUGVznBeidY4o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-RFLaFB4uNTmIUVmnqZtgBw-1; Fri,
 25 Apr 2025 11:38:50 -0400
X-MC-Unique: RFLaFB4uNTmIUVmnqZtgBw-1
X-Mimecast-MFC-AGG-ID: RFLaFB4uNTmIUVmnqZtgBw_1745595528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F400B1956096; Fri, 25 Apr 2025 15:38:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 303E3180045C; Fri, 25 Apr 2025 15:38:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA48821E66C3; Fri, 25 Apr 2025 17:38:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 stefanha@redhat.com,  Michael Roth <michael.roth@amd.com>,
 pbonzini@redhat.com,  berrange@redhat.com,  peter.maydell@linaro.org,
 thuth@redhat.com,  jsnow@redhat.com,  philmd@linaro.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, devel@lists.libvirt.org
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 24 Apr 2025 11:33:47 -0700")
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
Date: Fri, 25 Apr 2025 17:38:44 +0200
Message-ID: <87a584b69n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

> Note: This RFC was posted to trigger a discussion around this topic, and it's
> not expected to merge it as it is.
>
> Context
> =======
>
> Linaro is working towards heterogeneous emulation, mixing several architectures
> in a single QEMU process. The first prerequisite is to be able to build such a
> binary, which we commonly name "single-binary" in our various series.
> An (incomplete) list of series is available here:
> https://patchew.org/search?q=project%3AQEMU+single-binary
>
> We don't expect to change existing command line interface or any observable
> behaviour, it should be identical to existing binaries. If anyone notices a
> difference, it will be a bug.

Define "notice a difference" :)  More on that below.

> The first objective we target is to combine qemu-system-arm and
> qemu-system-aarch64 in a single binary, showing that we can build and link such
> a thing. While being useless from a feature point of view, it allows us to make
> good progress towards the goal, and unify two "distinct" architectures, and gain
> experience on problems met.

Makes sense to me.

> Our current approach is to remove compilation units duplication to be able to
> link all object files together. One of the concerned subsystem is QAPI.
>
> QAPI
> ====
>
> QAPI generated files contain conditional clauses to define various structures,
> enums, and commands only for specific targets. This forces files to be
> compiled for every target.

To be precise: conditionals that use macros restricted to
target-specific code, i.e. the ones poisoned by exec/poison.h.  Let's
call them target-specific QAPI conditionals.

The QAPI generator is blissfully unaware of all this.

The build system treats QAPI modules qapi/*-target.json as
target-specific.  The .c files generated for them are compiled per
target.  See qapi/meson.build.

Only such target-specific modules can can use target-specific QAPI
conditionals.  Use in target-independent modules will generate C that
won't compile.

Poisoned macros used in qapi/*-target.json:

    CONFIG_KVM
    TARGET_ARM
    TARGET_I386
    TARGET_LOONGARCH64
    TARGET_MIPS
    TARGET_PPC
    TARGET_RISCV
    TARGET_S390X

>                            What we try to do here is to build them only once
> instead.

You're trying to eliminate target-specific QAPI conditionals.  Correct?

> In the past, we identied that the best approach to solve this is to expose code
> for all targets (thus removing all #if clauses), and stub missing
> symbols for concerned targets.

This affects QAPI/QMP introspection, i.e. the value of query-qmp-schema.

Management applications can no longer use introspection to find out
whether target-specific things are available.

For instance, query-cpu-definitions is implemented for targets arm,
i386, loongarch, mips, ppc, riscv, and s390x.  It initially was for
fewer targets, and more targets followed one by one.  Still more may
follow in the future.  Right now, management applications can use
introspection to find out whether it is available.  That stops working
when you make it available for all targets, stubbed out for the ones
that don't (yet) implement it.

Management applications may have to be adjusted for this.

This is not an attempt to shoot down your approach.  I'm merely
demonstrating limitations of your promise "if anyone notices a
difference, it will be a bug."

Now, we could get really fancy and try to keep introspection the same by
applying conditionals dynamically somehow.  I.e. have the single binary
return different introspection values depending on the actual guest's
target.

This requires fixing the target before introspection.  Unless this is
somehow completely transparent (wrapper scripts, or awful hacks based on
the binary's filename, perhaps), management applications may have to be
adjusted to actually do that.

Applies not just to introspection.  Consider query-cpu-definitions
again.  It currently returns CPU definitions for *the* target.  What
would a single binary's query-cpu-definitions return?  The CPU
definitions for *all* its targets?  Management applications then receive
CPUs that won't work, which may upset them.  To avoid noticable
difference, we again have to fix the target before we look.

Of course, "fixing the target" stops making sense once we move to
heterogeneous machines with multiple targets.

> This series build QAPI generated code once, by removing all TARGET_{arch} and
> CONFIG_KVM clauses. What it does *not* at the moment is:
> - prevent target specific commands to be visible for all targets
>   (see TODO comment on patch 2 explaining how to address this)
> - nothing was done to hide all this from generated documentation

For better or worse, generated documentation always contains everything.

An argument could be made for stripping out documentation for the stuff
that isn't included in this build.

> From what I understood, the only thing that matters is to limit qmp commands
> visible. Exposing enums, structure, or events is not a problem, since they
> won't be used/triggered for non concerned targets. Please correct me if this is
> wrong, and if there are unexpected consequences for libvirt or other consumers.

I'm not sure what you mean by "to limit qmp commands visible".

QAPI/QMP introspection has all commands and events, and all types
reachable from them.  query-qmp-schema returns an array, where each
array element describes one command, event, or type.  When a command,
event, or type is conditional in the schema, the element is wrapped in
the #if generated for the condition.

>
> Impact on code size
> ===================
>
> There is a strong focus on keeping QEMU fast and small. Concerning performance,
> there is no impact, as the only thing that would change is to conditionally
> check current target to register some commands.
> Concerning code size, you can find the impact on various qemu-system binaries
> with optimized and stripped build.
>
> upstream:
> 12588   ./build/qemu-system-s390x
> 83992   ./build/qemu-system-x86_64
> 31884   ./build/qemu-system-aarch64
> upstream + this series:
> 12644   ./build/qemu-system-s390x (+56kB, +0.004%)
> 84076   ./build/qemu-system-x86_64 (+84kB, +0.001%)
> 31944   ./build/qemu-system-aarch64 (+60kB, +0.001%)
>
> Feedback
> ========
>
> The goal of this series is to be spark a conversation around following topics:
>
> - Would you be open to such an approach? (expose all code, and restrict commands
>   registered at runtime only for specific targets)

Yes, if we can find acceptable solutions for the problems that come with
it.

> - Are there unexpected consequences for libvirt or other consumers to expose
>   more definitions than what we have now?

Maybe.

> - Would you recommend another approach instead? I experimented with having per
>   target generated files, but we still need to expose quite a lot in headers, so
>   my opinion is that it's much more complicated for zero benefit. As well, the
>   code size impact is more than negligible, so the simpler, the better.
>
> Feel free to add anyone I could have missed in CC.

I'm throwing in devel@lists.libvirt.org.

> Regards,
> Pierrick
>
> Pierrick Bouvier (3):
>   qapi: add weak stubs for target specific commands
>   qapi: always expose TARGET_* or CONFIG_KVM code
>   qapi: make all generated files common
>
>  qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build           |  5 ++++-
>  scripts/qapi/commands.py   |  4 ++++
>  scripts/qapi/common.py     |  4 +++-
>  4 files changed, 49 insertions(+), 2 deletions(-)
>  create mode 100644 qapi/commands-weak-stubs.c


