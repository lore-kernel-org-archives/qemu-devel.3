Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC909CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElwR-0008BY-Kt; Fri, 31 Oct 2025 06:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vElwO-0008At-4m
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vElwC-0001Ro-Ub
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761904843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5zOrXvUrfbV3AXHGQCa365Z7NnC0AXMMEwZa22z75t0=;
 b=JQ6rBrO89YLC+vnvnBkW71h1r68RIjgc3PputO3wnNIEnSDnjTwEf0rRz7CYmkIse0/rfK
 rufoez+Bbl0TT4IAEsZ7KvuThOGALOkh+/uPHEwyHYDQuM2RcpF5ZpRksNBt48kfP19lYM
 ukFheJQOwj4ehE+qPYMQUvOKwJncWlY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-q5iFIqJrNmud1F80KFYo_A-1; Fri,
 31 Oct 2025 06:00:40 -0400
X-MC-Unique: q5iFIqJrNmud1F80KFYo_A-1
X-Mimecast-MFC-AGG-ID: q5iFIqJrNmud1F80KFYo_A_1761904839
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 499D6195DE4B; Fri, 31 Oct 2025 10:00:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78FE51955BE3; Fri, 31 Oct 2025 10:00:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C81E521E6A27; Fri, 31 Oct 2025 11:00:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: michael.roth@amd.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3] qapi: Add documentation format validation
In-Reply-To: <87ms58fpyn.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 30 Oct 2025 15:01:52 +0100")
References: <20251029173059.378607-1-vsementsov@yandex-team.ru>
 <87ms58fpyn.fsf@pond.sub.org>
Date: Fri, 31 Oct 2025 11:00:35 +0100
Message-ID: <87y0or9yrg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>
>> Add explicit validation for QAPI documentation formatting rules:
>>
>> 1. Lines must not exceed 70 columns in width (including '# ' prefix)
>> 2. Sentences must be separated by two spaces
>>
>> Example sections are excluded, we don't require them to be <= 70,
>> that would be too restrictive.
>>
>> Example sections share common 80-columns recommendations (not
>> requirements).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Hi all!
>>
>> This substitutes my previous attempt
>>   "[PATCH v2 00/33] qapi: docs: width=70 and two spaces between sentences"
>> Supersedes: <20251011140441.297246-1-vsementsov@yandex-team.ru>
>>
>> v3:
>> 01: ignore example sections
>> other commits: dropped :)
>>
>> Of course, this _does not_ build on top of current master. v3 is
>> to be based on top of coming soon doc-cleanup series by Markus.

[...]

>> +        single_space_pattern = r'[.!?] [A-Z0-9]'
>
> This pattern matches possible sentence ends that lack a second space:
> sentence-ending punctuation, single space, capital letter or digit.
>
> The pattern avoids common false positives in the middle of a sentence,
> such as "i.e." here:
>
>     # Describes a block export, i.e. how single node should be exported on
>                                 ~~~~~
>
> Good.  There's still a risk of false positives, though: a capital letter
> need not be the start of a sentence, it could also be a proper noun, or
> the pronoun "I".  I figure the latter is vanishingly unlikely to occur
> in technical documentation.  Example of the former:
>
>     # @format: Extent type (e.g. FLAT or SPARSE)
>
> You filter these out below.
>
> Digits are even more ambiguous than capital letters: they can occur in
> the middle of a sentence as much as at the beginning.  Do they occur?
>
>     $ git-grep '\. [0-9]' \*.json
>     docs/interop/firmware.json:#                of SMRAM. 48MB should suffice for 4TB of guest-phys
>
> Yes, but only in a QAPI schema we don't actually parse.  We should
> probably update these to conform to conventions.  Not today.

Actually, we do parse it, but only in "make check".  See
docs/meson.build.  The cleanup series I just sent covers it.

Unfortunately, this adds another case for you.  In master:

    # @executable: Identifies the firmware executable. The @mode
    #              indicates whether there will be an associated
    #              NVRAM template present. The preferred
    #              corresponding QEMU command line options are
    #                  -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
    #                  -machine pflash0=pflash0
    #              or equivalent -blockdev instead of -drive. When
    #              @mode is @combined the executable must be
    #              cloned before use and configured with readonly=off.
    #              With QEMU versions older than 4.0, you have to use
    #                  -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format

My series cleans this up to

    # @executable: Identifies the firmware executable.  The @mode
    #     indicates whether there will be an associated NVRAM template
    #     present.  The preferred corresponding QEMU command line options
    #     are
    #
    #     ::
    #
    #         -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
    #         -machine pflash0=pflash0
    #
    #     or equivalent -blockdev instead of -drive.  When @mode is
    #     @combined the executable must be cloned before use and
    #     configured with readonly=off.  With QEMU versions older than
    #     4.0, you have to use
    #
    #     ::
    #
    #         -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format

This uses ReST markup for literal blocks.  There are two forms.

1. A paragraph containing just "::" starts a literal block.

2. A paragraph ending with "::" also starts one.

In either case, the block's contents is indented.

See https://docutils.sourceforge.io/docs/user/rst/quickref.html#literal-blocks
for more.

I think you need to switch literal mode on when you detect a qmp-example
directive or a literal block, and record the line's indentation.  switch
it off at the first line that is no more indented than the recorded
indentation.

[...]


