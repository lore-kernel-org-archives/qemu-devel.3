Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71564C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk00P-0002S2-Pl; Mon, 17 Feb 2025 07:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tk00I-0002PV-Qh
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:13:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tk00G-0004sL-Ce
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739794414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1HTqY70AIqIAzC+yh04iYM2Zqv0yTo+P+vnz0hUVaN8=;
 b=EufJ30MAF0+sEflryEnO0DcsVPx3l+Qgt/1TvZKH9qzQeTVG2BjGxa4ITl0Qt6ng2SuFTc
 eKgr1bV/+s104hF0Dn+uJZh99IgCuMceX3vNTvj6emZTJBcFxqcbwWEqIM8frefE2npYPh
 1a6GNzj/f6Zp6+lWFlaNbFs1qQYerfc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-dcHYXHp6OJ6yPR1D5GJbDw-1; Mon,
 17 Feb 2025 07:13:30 -0500
X-MC-Unique: dcHYXHp6OJ6yPR1D5GJbDw-1
X-Mimecast-MFC-AGG-ID: dcHYXHp6OJ6yPR1D5GJbDw_1739794408
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1346419039C2; Mon, 17 Feb 2025 12:13:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5671119560AA; Mon, 17 Feb 2025 12:13:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F71421E6A28; Mon, 17 Feb 2025 13:13:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Jason Wang
 <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
In-Reply-To: <20250205231208.1480762-30-jsnow@redhat.com> (John Snow's message
 of "Wed, 5 Feb 2025 18:11:55 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-30-jsnow@redhat.com>
Date: Mon, 17 Feb 2025 13:13:23 +0100
Message-ID: <87h64srcpo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

> This clarifies sections that are mistaken by the parser as "intro"
> sections to be "details" sections instead.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

This is rather terse.

Why does the boundary between "intro" (previously "body") and "details"
matter?  As far as I understand, it matters for inlining.

What is inlining?

The old doc generator emits "The members of T" into the argument
description in the following cases:

* When a command's arguments are given as a type T, the doc comment has
  no argument descriptions, and the generated argument description
  becomes "The members of T".

* When an object type has a base type T, "The members of T" is appended
  to the doc comment's (possibly empty) argument descriptions.

* For union types, "The members of T when TAG is VALUE" is appended to
  the doc comment's argument descriptions for every tag VALUE and
  associated type T.

We want a description of the members of T right there instead.  To get
it right there, we need to inline from T's documentation.

What exactly do we need to inline?  Turns out we don't want "intro", we
do want the argument descriptions and other stuff we can ignore here.

"intro" ends before the argument descriptions, features, or a tagged
section, whatever comes first.  Most of the time, this works fine.  But
there are a few troublesome cases.  Here's one:

    ##
    # @MemoryBackendShmProperties:
    #
    # Properties for memory-backend-shm objects.
    #
    # This memory backend supports only shared memory, which is the
    # default.
    #
    # Since: 9.1
    ##
    { 'struct': 'MemoryBackendShmProperties',
      'base': 'MemoryBackendProperties',
      'data': { },
      'if': 'CONFIG_POSIX' }

Everything up to "Since:" is "intro".  Consequently, the old doc
generator emits "The members of MemoryBackendProperties" right there:

    "MemoryBackendShmProperties" (Object)
    -------------------------------------

    Properties for memory-backend-shm objects.

    This memory backend supports only shared memory, which is the default.


    Members
    ~~~~~~~

    The members of "MemoryBackendProperties"

    Since
    ~~~~~

    9.1


    If
    ~~

    "CONFIG_POSIX"

That's also where the new one inlines.  Okay so far.

This gets in turn inlined into ObjectOptions for branch
memory-backend-shm.  Since we don't inline "intro", we don't inline
"This memory backend supports only shared memory, which is the default."
That's a problem.

This patch moves the boundary between "intro" and the remainder up that
paragraph, so we don't lose that line.  It accomplishes that by giving
us syntax to manually mark the end of "intro"

However, your solution is manual: it gives us the means[*] to mark the
boundary with "Details:" to avoid loss of text.  What if we don't
notice?  Should we tweak the syntax to force us to be explicit?  How
many doc comments would that affect?


[*] Actually, we have means even before this patch, they're just ugly.
See the TODO comment added in commit 14b48aaab92 (qapi: convert
"Example" sections without titles).


