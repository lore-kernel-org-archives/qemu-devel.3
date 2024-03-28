Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85356CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rplrr-0006ta-0E; Thu, 28 Mar 2024 05:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rplrn-0006sr-1I
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rplrl-0003a4-8Q
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711617368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yq2i/K2LiF/ykgoBLDPcN7eHXg5EiMhq8Vl342Tw7EQ=;
 b=LpTaCW6iKfXn7ac2Aj2A0jewdEu0Q0Ldh5tNaLas5hg98RcgWVaYoza5lahmkCs2a0C6ee
 cTioCCNl1dUbEV5S9dlepXFFN4bL66gV5ys0YRjS0c3V7u49lBZxEKrlvN1hIXK2h10XSt
 pGsVi30UWzf9zsb9+yhIveywfIROOIE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Df-Qft4FOOODuEP_NbKIMA-1; Thu, 28 Mar 2024 05:16:02 -0400
X-MC-Unique: Df-Qft4FOOODuEP_NbKIMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F7A08B5AE8;
 Thu, 28 Mar 2024 09:16:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86CE91121312;
 Thu, 28 Mar 2024 09:16:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F3C921E669D; Thu, 28 Mar 2024 10:15:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  jsnow@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  devel@lists.libvirt.org,
 eblake@redhat.com,  michael.roth@amd.com,  pbonzini@redhat.com,
 pkrempa@redhat.com,  f.ebner@proxmox.com
Subject: Re: [RFC 01/15] scripts/qapi: support type-based unions
In-Reply-To: <20240313150907.623462-2-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 13 Mar 2024 18:08:53 +0300")
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
 <20240313150907.623462-2-vsementsov@yandex-team.ru>
Date: Thu, 28 Mar 2024 10:15:55 +0100
Message-ID: <87frwaemyc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Look at block-job-change command: we have to specify both 'id' to chose
> the job to operate on and 'type' for QAPI union be parsed. But for user
> this looks redundant: when we specify 'id', QEMU should be able to get
> corresponding job's type.
>
> This commit brings such a possibility: just specify some Enum type as
> 'discriminator', and define a function somewhere with prototype
>
> bool YourUnionType_mapper(YourUnionType *, EnumType *out, Error **errp)
>
> Further commits will use this functionality to upgrade block-job-change
> interface and introduce some new interfaces.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  scripts/qapi/introspect.py |  5 +++-
>  scripts/qapi/schema.py     | 50 +++++++++++++++++++++++---------------
>  scripts/qapi/types.py      |  3 ++-
>  scripts/qapi/visit.py      | 43 ++++++++++++++++++++++++++------
>  4 files changed, 73 insertions(+), 28 deletions(-)

I believe you need to update docs/devel/qapi-code-gen.rst.

Current text:

    Union types
    -----------

    Syntax::

        UNION = { 'union': STRING,
                  'base': ( MEMBERS | STRING ),
                  'discriminator': STRING,
                  'data': BRANCHES,
                  '*if': COND,
                  '*features': FEATURES }
        BRANCHES = { BRANCH, ... }
        BRANCH = STRING : TYPE-REF
               | STRING : { 'type': TYPE-REF, '*if': COND }

    Member 'union' names the union type.

    The 'base' member defines the common members.  If it is a MEMBERS_
    object, it defines common members just like a struct type's 'data'
    member defines struct type members.  If it is a STRING, it names a
    struct type whose members are the common members.

    Member 'discriminator' must name a non-optional enum-typed member of
    the base struct.  That member's value selects a branch by its name.
    If no such branch exists, an empty branch is assumed.

If I understand your commit message correctly, this paragraph is no
longer true.

    Each BRANCH of the 'data' object defines a branch of the union.  A
    union must have at least one branch.

    The BRANCH's STRING name is the branch name.  It must be a value of
    the discriminator enum type.

    The BRANCH's value defines the branch's properties, in particular its
    type.  The type must a struct type.  The form TYPE-REF_ is shorthand
    for :code:`{ 'type': TYPE-REF }`.

    In the Client JSON Protocol, a union is represented by an object with
    the common members (from the base type) and the selected branch's
    members.  The two sets of member names must be disjoint.

    Example::

     { 'enum': 'BlockdevDriver', 'data': [ 'file', 'qcow2' ] }
     { 'union': 'BlockdevOptions',
       'base': { 'driver': 'BlockdevDriver', '*read-only': 'bool' },
       'discriminator': 'driver',
       'data': { 'file': 'BlockdevOptionsFile',
                 'qcow2': 'BlockdevOptionsQcow2' } }

    Resulting in these JSON objects::

     { "driver": "file", "read-only": true,
       "filename": "/some/place/my-image" }
     { "driver": "qcow2", "read-only": false,
       "backing": "/some/place/my-image", "lazy-refcounts": true }

    The order of branches need not match the order of the enum values.
    The branches need not cover all possible enum values.  In the
    resulting generated C data types, a union is represented as a struct
    with the base members in QAPI schema order, and then a union of
    structures for each branch of the struct.

    The optional 'if' member specifies a conditional.  See `Configuring
    the schema`_ below for more on this.

    The optional 'features' member specifies features.  See Features_
    below for more on this.


