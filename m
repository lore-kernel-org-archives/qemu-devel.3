Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1855BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 16:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEsdB-0006dd-9y; Tue, 13 May 2025 12:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEsd9-0006dG-Fz
 for qemu-devel@nongnu.org; Tue, 13 May 2025 12:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEsd5-0005Su-DM
 for qemu-devel@nongnu.org; Tue, 13 May 2025 12:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747154237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLPOiUalenJPLluX017kUz9hlQxMAYOPmpecdB7zaKY=;
 b=I7fkb8yNof2R7nZosLLhOW7cisqzFzvINWIsMDNtdCBfRqkdFFimd1ZyIPJIZtf+DdEU4J
 U+6mVh5MHgskr7hIjFd4aDHV5I0O9jnMoMecrI4RnIyO75UloDgtl8mYiYeGOf1POwHmCZ
 NmOtoddjXLUHo2xbFjfl8F3S01CzFG8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-K1ceKDkYNPK27Ql7BuJRdw-1; Tue,
 13 May 2025 12:37:13 -0400
X-MC-Unique: K1ceKDkYNPK27Ql7BuJRdw-1
X-Mimecast-MFC-AGG-ID: K1ceKDkYNPK27Ql7BuJRdw_1747154232
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FD4A19560A0; Tue, 13 May 2025 16:37:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96EE41953B82; Tue, 13 May 2025 16:37:10 +0000 (UTC)
Date: Tue, 13 May 2025 17:37:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 09/10] qapi: make most CPU  commands unconditionally
 available
Message-ID: <aCN1M11bqOY0c7Fn@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-10-berrange@redhat.com>
 <87jz6kd6iv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jz6kd6iv.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 13, 2025 at 02:44:40PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This removes the TARGET_* conditions from all the CPU commands
> > that are conceptually target independent. Top level stubs are
> > provided to cope with targets which do not currently implement
> > all of the commands.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  qapi/machine-target.json              | 397 --------------------------
> >  qapi/machine.json                     | 363 +++++++++++++++++++++++
> >  stubs/meson.build                     |   2 +
> >  stubs/monitor-cpu-s390x.c             |  23 ++
> >  stubs/monitor-cpu.c                   |  21 ++
> >  target/arm/arm-qmp-cmds.c             |   2 +-
> >  target/i386/cpu-system.c              |   2 +-
> >  target/i386/cpu.c                     |   2 +-
> >  target/loongarch/loongarch-qmp-cmds.c |   2 +-
> >  target/mips/system/mips-qmp-cmds.c    |  12 +-
> >  target/ppc/ppc-qmp-cmds.c             |  12 +-
> >  target/riscv/riscv-qmp-cmds.c         |   2 +-
> >  target/s390x/cpu_models_system.c      |   2 +-
> >  13 files changed, 437 insertions(+), 405 deletions(-)
> >  create mode 100644 stubs/monitor-cpu-s390x.c
> >  create mode 100644 stubs/monitor-cpu.c

snip

> > +##
> > +# @query-cpu-model-comparison:
> > +#
> > +# Compares two CPU models, @modela and @modelb, returning how they
> > +# compare in a specific configuration.  The results indicates how
> > +# both models compare regarding runnability.  This result can be
> > +# used by tooling to make decisions if a certain CPU model will
> > +# run in a certain configuration or if a compatible CPU model has
> > +# to be created by baselining.
> > +#
> > +# Usually, a CPU model is compared against the maximum possible CPU
> > +# model of a certain configuration (e.g. the "host" model for KVM).
> > +# If that CPU model is identical or a subset, it will run in that
> > +# configuration.
> > +#
> > +# The result returned by this command may be affected by:
> > +#
> > +# * QEMU version: CPU models may look different depending on the QEMU
> > +#   version.  (Except for CPU models reported as "static" in
> > +#   query-cpu-definitions.)
> > +# * machine-type: CPU model may look different depending on the
> > +#   machine-type.  (Except for CPU models reported as "static" in
> > +#   query-cpu-definitions.)
> > +# * machine options (including accelerator): in some architectures,
> > +#   CPU models may look different depending on machine and accelerator
> > +#   options.  (Except for CPU models reported as "static" in
> > +#   query-cpu-definitions.)
> > +# * "-cpu" arguments and global properties: arguments to the -cpu
> > +#   option and global properties may affect expansion of CPU models.
> > +#   Using query-cpu-model-expansion while using these is not advised.
> > +#
> > +# Some architectures may not support comparing CPU models.  s390x
> > +# supports comparing CPU models.
> > +#
> > +# @modela: description of the first CPU model to compare, referred to
> > +#     as "model A" in CpuModelCompareResult
> > +#
> > +# @modelb: description of the second CPU model to compare, referred to
> > +#     as "model B" in CpuModelCompareResult
> > +#
> > +# Returns: a CpuModelCompareInfo describing how both CPU models
> > +#     compare
> > +#
> > +# Errors:
> > +#     - if comparing CPU models is not supported by the target
> 
> You add "by the target", and ...
> 
> > +#     - if a model cannot be used
> > +#     - if a model contains an unknown cpu definition name, unknown
> > +#       properties or properties with wrong types.
> 
> delete this note:
> 
>    # .. note:: This command isn't specific to s390x, but is only
>    #    implemented on this architecture currently.
> 
> Lost: command currently works just for s390x targets.  Intentional?

Kind of.

Previously, the whole command would be tagged for TARGET_S390X
so the command was not available at all.

Now its always  available, but may return an error at runtime
for some targets.

Since we're not providing any mechanism for apps to detect
which targets will work and which won't, the implication
is that apps are expected to try it if they need it, and
cope with any error.

From that POV I thought it might be better not to call
out a point-in-time limitation of the impl. I'm not too
fussed either way though, so we could re-instate the
note.

> Same for query-cpu-model-baseline below.

Likewise


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


