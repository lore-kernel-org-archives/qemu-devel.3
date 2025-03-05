Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC96C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpmyE-00027U-01; Wed, 05 Mar 2025 06:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpmyC-00026i-Cc
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpmy6-0007bn-Bu
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741174276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/yeH4A1dmT3cNLgkx7UkeHBDzQwWa80r1JkbQCE3c14=;
 b=FJ4M6ypqY06c6Cs8S3E9kv3EIlXngMTa5HmkP1e4QVxjgTzFJDI2MMFhitXsII+jZcbDrM
 B86/EF6dzly9SA6JxQ9hMvLtmXwcGqGptLx36WhqOZYZBHhzV3DeMMkm1hUrzilaGQv1WO
 /8ouahy1JE08i89J+BHt5kOc4MwdUqI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-QQgsirr0O-mx_EG2l8CshA-1; Wed,
 05 Mar 2025 06:31:14 -0500
X-MC-Unique: QQgsirr0O-mx_EG2l8CshA-1
X-Mimecast-MFC-AGG-ID: QQgsirr0O-mx_EG2l8CshA_1741174273
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F9441800349; Wed,  5 Mar 2025 11:31:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B05BC1956095; Wed,  5 Mar 2025 11:31:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21BCA21E66C1; Wed, 05 Mar 2025 12:31:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 00/57] docs: Add new QAPI transmogrifier
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:09 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
Date: Wed, 05 Mar 2025 12:31:10 +0100
Message-ID: <87jz93n281.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> Hi! This series is based on armbru/pull-qapi-2025-02-26.
>
> This series is a "minimum viable" version of the new QAPI documentation
> system. It does the bare minimum under the new framework, saving nice
> features for later.

Not saved for later: a massive improvement of the generated
documentation's looks and usability.  Moreover, I hope the new generator
will be easier to maintain than the old one, because its inner workings
are closer to how Sphinx expects such things to work.  Fair?

>
> Patches 3-29 implement the qapi_domain extension.
> Patches 30-57 implement the qapidoc "Transmogrifier".
>
> This series is still "RFC" quality, though it's quite nearly actually
> ready for inclusion. The "add transmogrifier test document" patch is not
> intended for actual merge, it's just there to demonstrate the new
> document generator by producing output in docs/manual/qapi/index.html.
>
> Known shortcomings in this series:
>
> - Still no new QAPI unit tests. I'll add those for next go-around.

Not a blocker as far as I'm concerned, because I feel you're unlikely to
run away from this :)

> - No new documentation. Also for next revision. I'll document the QAPI
>   domain syntax and give a brief overview of how the transmogrifier
>   functions, and a quick rundown of any new rST syntax that may be
>   pertinent to QAPI documentation writers.

Likewise.

> - IFCOND information is still rendered in two places, we'll need to
>   decide where and how we want to render it.

I'll have a look, and then we'll talk.

> - No QAPI namespace support ... yet. So we can't enable it for QMP, QGA
>   and QSD simultaneously just yet. I don't think it will be difficult.
>
> Unknown shortcomings in this series:
>
> - ???

I'll try to find some, but I'm not overly optimistic ;)

> New stuff overall from the last iteration of this series:
>
> - @foo is processed into ``foo`
> - "The members of ..." messages have been temporarily re-added until we
>   can smooth over the inliner.
> - This series runs under Sphinx 3.4.3 to Sphinx 8.2.0 inclusive. It
>   truly is a Christmas miracle. (please clap)

*clap* clap* clap*

This is waaaay harder than it has any right to be.

> - This series now fully type checks and lint checks under Sphinx 8.2.0,
>   but may not type check under earlier Sphinx versions. Achieving this
>   alone, nevermind in conjunction with the above, was a literal
>   herculean labor.

scripts/qapi/ remains clean for me.  docs/sphinx/ improves from no type
checking to type checking with a version newer than the one I have on my
development box right now, which I count as an improvement.

> I really must stress again how frustratingly difficult it was to achieve
> the prior two bullet points. I *do* in fact want a cookie and/or an
> award ribbon.

We owe you an entire layer cake, with a marzipan figurine of your
conquering self on top.  Seriously, I could not have done this.


