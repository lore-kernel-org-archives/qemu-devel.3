Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBECC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8wJ-0005EV-4S; Thu, 06 Mar 2025 05:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq8wH-0005EI-15
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq8wA-0002ac-Nl
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741258724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHU1RC1H5aOqoeAjuzFHwOG708l6UYAlQvDjjyhtomg=;
 b=Cxzv7hP6XZqjKhon5O1D5D+ljF1EzhuKB8OViuq6rT5COpYIZqiXzyJ2i6uycNXAolVlSa
 1tr5ChFexzw7B1HdkGP33YzgukRQikGENeDpWG3rCryCZ1hGdIPS70AJwmqZXKpK7mTT3b
 cbJkQv8HZjXTfXGVMa183u1YGIIbqbA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-eEMRNEVQO9ahpWfSCTtRuA-1; Thu,
 06 Mar 2025 05:58:40 -0500
X-MC-Unique: eEMRNEVQO9ahpWfSCTtRuA-1
X-Mimecast-MFC-AGG-ID: eEMRNEVQO9ahpWfSCTtRuA_1741258718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE0AC180AB19; Thu,  6 Mar 2025 10:58:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0762530001A1; Thu,  6 Mar 2025 10:58:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 716B421E675F; Thu, 06 Mar 2025 11:58:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 00/57] docs: Add new QAPI transmogrifier
In-Reply-To: <87jz93n281.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 05 Mar 2025 12:31:10 +0100")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <87jz93n281.fsf@pond.sub.org>
Date: Thu, 06 Mar 2025 11:58:35 +0100
Message-ID: <87zfhya0is.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> Hi! This series is based on armbru/pull-qapi-2025-02-26.
>>
>> This series is a "minimum viable" version of the new QAPI documentation
>> system. It does the bare minimum under the new framework, saving nice
>> features for later.
>
> Not saved for later: a massive improvement of the generated
> documentation's looks and usability.  Moreover, I hope the new generator
> will be easier to maintain than the old one, because its inner workings
> are closer to how Sphinx expects such things to work.  Fair?
>
>>
>> Patches 3-29 implement the qapi_domain extension.
>> Patches 30-57 implement the qapidoc "Transmogrifier".
>>
>> This series is still "RFC" quality, though it's quite nearly actually
>> ready for inclusion. The "add transmogrifier test document" patch is not
>> intended for actual merge, it's just there to demonstrate the new
>> document generator by producing output in docs/manual/qapi/index.html.
>>
>> Known shortcomings in this series:
>>
>> - Still no new QAPI unit tests. I'll add those for next go-around.
>
> Not a blocker as far as I'm concerned, because I feel you're unlikely to
> run away from this :)
>
>> - No new documentation. Also for next revision. I'll document the QAPI
>>   domain syntax and give a brief overview of how the transmogrifier
>>   functions, and a quick rundown of any new rST syntax that may be
>>   pertinent to QAPI documentation writers.
>
> Likewise.
>
>> - IFCOND information is still rendered in two places, we'll need to
>>   decide where and how we want to render it.
>
> I'll have a look, and then we'll talk.

Two shortcomings, actually:

  - IFCOND in definitions (enum, struct, union, alternate, command,
    event) are rendered in two places.

    Example: query-tpm has 'if': 'CONFIG_TPM'.  The rendered
    documentation looks like this:

        Command query-tpm ["#if" "CONFIG_TPM"] (Since: 1.5)
            *Availability*: "CONFIG_TPM"

           Return information about the TPM device

           Example::
              [...]

    With the old generator, it looks like

        "query-tpm" (Command)
        ---------------------

        Return information about the TPM device


        Since
        ~~~~~

        1.5

        Example::
           [...]

        If
        ~~

        "CONFIG_TPM"

    So, three ways to present the information, none of them immediately
    obvious to a casual reader.  The easiest to guess right is perhaps
    the "Availability" box.

    The two new ways are in more conspicious spots than the old one is.
    Not sure I like that; I believe ifconds are fairly uninteresting to
    users of QMP most of the time.  More on that below.

    The "Availability" box is even more conspicious than the [#if ...]
    bracket.  It also uses more space.

    For complex conditions, the [#if ...] bracket can make the first
    line less readable.  Example:

        Command query-cpu-definitions ["#if" "TARGET_PPC or TARGET_ARM or TARGET_I386 or TARGET_S390X or TARGET_MIPS or TARGET_LOONGARCH64 or TARGET_RISCV"] (Since: 1.2)
            *Availability*: "TARGET_PPC or TARGET_ARM or TARGET_I386 or
           TARGET_S390X or TARGET_MIPS or TARGET_LOONGARCH64 or TARGET_RISCV"

           Return a list of supported virtual CPU definitions

    The first line matters.  This tips the balance for me.  Let's go
    with the "Availability" box at least for now.

    There's a symbol before "Availability" in the generated HTML.  Its
    meaning is less than obvious.  I remember you explained it to me,
    but I forgot.  We can polish this later.

  - IFCOND elsewhere is not rendered at all.  This is a regression.  The
    old generator shows it like this:

        "mptcp": "boolean" (optional) (**If: **"HAVE_IPPROTO_MPTCP")
           enable multi-path TCP.  (Since 6.1)

    I believe the regression is tolerable for now, because the
    information lost is only modestly useful for users of QMP, and the
    massive improvements the new generator provides outweigh this small
    loss.

    Why only modestly useful?  It tells the reader the thing's
    availability depends on how QEMU was built.  It also provides a clue
    that should let a developer or sufficiently clever non-developer
    rebuild QEMU to provide the thing.  This would involve some code
    spelunking.

>> - No QAPI namespace support ... yet. So we can't enable it for QMP, QGA
>>   and QSD simultaneously just yet. I don't think it will be difficult.

[...]


