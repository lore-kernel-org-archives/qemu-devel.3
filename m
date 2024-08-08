Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E98C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 05:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbvoM-0006YB-1s; Thu, 08 Aug 2024 01:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbvoG-0006WW-Vf
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:35:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbvoC-0004vC-82
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723095331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MY2pU3AGTr/0JOkEMSITZyyh8YPC7QV3jBbsYOFDizY=;
 b=QAAdbPAUSjYQP2hLR5oc9fcGs0rtxP52XUoD7/qlD1QDrVzHzvU/Kw9ytYV6bRMxqHv3CI
 jsj43nhFV807pk0q/We642+h2OuhsLNFq/LQJhmSCjDe6VhcCx40CutE+WQK+UGnHk6Pv+
 YVpCFuB9p1CIgqKFvYubJm+7QDbB9ug=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-VXTVfnJvP4uQOqmpWl-XYA-1; Thu,
 08 Aug 2024 01:35:27 -0400
X-MC-Unique: VXTVfnJvP4uQOqmpWl-XYA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D577419560A6; Thu,  8 Aug 2024 05:35:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59FA219560A3; Thu,  8 Aug 2024 05:35:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 191AA21E66E5; Thu,  8 Aug 2024 07:35:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>,  qemu-arm@nongnu.org,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1? 2/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
In-Reply-To: <CAFEAcA_2pJA47K72qJQX9bc8sBcA+0wJGaf3KAaYJaRurjQD7w@mail.gmail.com>
 (Peter Maydell's message of "Wed, 7 Aug 2024 17:30:50 +0100")
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-3-philmd@linaro.org>
 <87o764yce3.fsf@pond.sub.org>
 <a8eb43d8-3714-447b-ab1b-c96ff05cf14a@linaro.org>
 <87h6bwwpu4.fsf@pond.sub.org>
 <CAFEAcA_2pJA47K72qJQX9bc8sBcA+0wJGaf3KAaYJaRurjQD7w@mail.gmail.com>
Date: Thu, 08 Aug 2024 07:35:21 +0200
Message-ID: <871q2zshk6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 7 Aug 2024 at 12:10, Markus Armbruster <armbru@redhat.com> wrote:
>> Having to manually include a configuration header like CONFIG_DEVICES
>> wherever you use configuration symbols strikes me as unadvisable when
>> uses include checking for definedness, such as #ifdef: silent miscompile
>> when you forget to include.
>>
>> This is why Autoconf wants you to include config.h first in any .c: it
>> makes #ifdef & friends safe.
>>
>> qemu/osdep.h does include some configuration headers:
>>
>>     #include "config-host.h"
>>     #ifdef COMPILING_PER_TARGET
>>     #include CONFIG_TARGET
>>     #else
>>     #include "exec/poison.h"
>>     #endif
>>
>> Why not CONFIG_DEVICES?
>
> The stuff in CONFIG_DEVICES is target-specific, so wanting
> to include it should be rare (currently we include it in
> only about 25 files). Any file that includes it has to be
> a compile-per-target file, and generally we'd rather avoid that.

Since all the macros defined in CONFIG_DEVICES are poisoned by
exec/poison.h, which *is* included by qemu/osdep.h, target-independent
files never need to include CONFIG_DEVICES.  My question was strictly
about target-dependent files, i.e. exactly the ones that include
CONFIG_TARGET.

> Plus it's a bit odd to need to change code based on whether
> some other device was configured into the system,

I agree it's a bit odd for device code to check whether some other
device is also selected for the current target.

But is it odd for the QAPI schema to define a device-specific command
only when the device is selected?

>                                                   so I think
> that's something worth restricting to only files that effectively
> opt in to it.

Is accidental use of a macro from CONFIG_DEVICES a risk?  Is the risk
mitigated to some useful degree by having to include CONFIG_DEVICES?

I consider the combination of testing configuration symbols with #ifdef
and requiring a manual #include to actually get the symbols (and make
the #ifdef work) bad practice.

Options:

1. Approximate symbols from CONFIG_DEVICES with symbols from
   CONFIG_TARGET.  This is what we do now.

2. Use symbols from CONFIG_DEVICES.  Generated headers are no longer
   self-contained.  Strong dislike.

3. Define device-specific stuff unconditionally.  We get to fool around
   with stubs, binaries carry more useless code, and introspection
   becomes less useful.  Meh.

Thoughts?


