Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6851AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3sz-00033Y-I2; Tue, 26 Mar 2024 06:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp3sy-00032h-Bi
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp3sw-0002uE-JU
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711448305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEQJETNEk4wTxAbmDE7IF8Ho8ryXep/KGcVsctLsOm8=;
 b=BwK5RaxKkIVDmeNUGElP3RFoSgnxsHXQhtHtSaBmDNTh9Zaap3iEhXSzPJ/BLh5YzO7Q86
 rwE8wq9tBEv0bCuBl649Yg9sS/R6UDZA8f1QvUqFdTtAPn/wlhybx6SO6rokdYGq1wNuX3
 UPdSqyDc7vW+8HlM2nLOGA0eOa1qggs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-pL4SSwWZOeS0ZogMZwZJZQ-1; Tue,
 26 Mar 2024 06:18:20 -0400
X-MC-Unique: pL4SSwWZOeS0ZogMZwZJZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5BEB3C0008C;
 Tue, 26 Mar 2024 10:18:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BEF62166B33;
 Tue, 26 Mar 2024 10:18:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 54BA321E668C; Tue, 26 Mar 2024 11:18:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  Anton Johansson
 <anjo@rev.ng>,  qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Claudio Fontana
 <cfontana@suse.de>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1 00/21] qapi: Make @query-cpu-definitions
 command target-agnostic
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 15 Mar 2024 14:08:48
 +0100")
References: <20240315130910.15750-1-philmd@linaro.org>
Date: Tue, 26 Mar 2024 11:18:14 +0100
Message-ID: <878r25qot5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Alex, Markus,
>
> Markus mentioned QAPI problems with the heterogeneous emulation
> binary. My understanding is, while QAPI can use host-specific
> conditional (OS, library available, configure option), it
> shouldn't use target-specific ones.

"Shouldn't" is too strong in the current state of things.  It can be
awkward, though.

Target-specific macros may be used only in target-specific code,
i.e. code that is compiled per target.  To catch uses in
target-independent code, we poison them there; see exec/poison.h.

QAPI-generated .c are not normally compiled per target.  To enable use
of target-specific macros in conditionals, we compile .c generated QAPI
submodules named *-target.json per target.  This is a bit of a hack.

Since the same conditionals will also appear in the .h generated from
them, these headers can only be used in target-specific code.

Sometimes, these headers "infect" target-independent code: we need to
compile per target just for the headers.  Awkward.  I can dig out an
example if there's interest.

But what about possible future state of things?

The QAPI schema is compile-time static by design.  QAPI conditionals
permit adjusting the schema for build configuration.  Target-specific
conditionals adjust it for the build configuration of the
target-specific part.  Each QEMU binary contains just one target's
target-specific part.

However, a single QEMU binary will contain several target-specific
parts, one per target it supports.  The targets' QAPI schema adjustments
may conflict.

For a single binary, we need to resolve these conflicts.

Special case: QAPI definitions that exist only for some targets.

Example: command query-sev exists only for TARGET_I386.  It's actually a
stub when CONFIG_SEV is off.

Obvious solution: make it exist if it needs to exist for any target
compiled into the binary.  Requires command stubs for the other targets.

Example: query-sev now exists when the single binary supports x86.  It's
a stub when CONFIG_SEV is off.  It behaves like a stub when CONFIG_SEV
is on, but the machine isn't x86.

Drawback: introspection with query-qmp-schema becomes less precise.
When the binary supports just one target, introspection can answer
target-specific questions like "does this target support SEV?"  With a
single binary, that's no longer possible.

Harmless enough for SEV, but consider query-cpu-model-expansion.  The
command may support expansion types "full" and "static".  Currently,
s390x supports both, ARM supports only "full", Loongarch only "static",
RISC-V only "full", and x86 supports both.

(I think.  The documentation is incomplete:

    # Some architectures may not support all expansion types.  s390x
    # supports "full" and "static". Arm only supports "full".
)

A management application may want to find out which expansion type is
supported.  Right now, it can't.  But we could improve the schema so it
can find out via introspection: define the expansion types only when
they're actually supported.

With a single binary, that's no longer possible: we have to define an
expansion type when *any* target supports it.

Such loss of introspection power is not a show-stopper, just something
we need to keep in mind.

> This series is an example on how to remove target specific
> bits from the @query-cpu-definitions command.

This is an instance of the special case with an additional twist: each
target defines its own QMP command handler.

>                                               Target specific
> code is registered as CPUClass handlers, then a generic method
> is used, iterating over all targets built in.
>
> The first set of patches were already posted / reviewed last
> year.
>
> The PPC and S390X targets still need work (help welcomed),
> however the code is useful enough to be tested and see if this
> is a good approach.
>
> The only drawback is a change in QAPI introspection, because
> targets not implementing @query-cpu-definitions were returning
> "CommandNotFound".

The change is introspection is actually something else.  Before the
series, query-qmp-schema returns a description of command
query-cpu-definitions exactly when the (single) target supports it.
Afterwards, it always returns one (I think).

The CommandNotFound change is a change in behavior when you try to
execute query-cpu-definitions, but the target doesn't support it.
Before, the command doesn't exist, and the QMP core duly replies
CommandNotFound.  Afterwards, it does exist, but the target doesn't
implement the call back, so the command fails.  I guess it fails with
GenericError.  We could make it fail with CommandNotFound if we care.

>                    My view is this was an incomplete
> implementation, rather than a feature.

Feels fair (but I'm not an expert in this area).


