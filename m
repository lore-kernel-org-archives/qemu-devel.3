Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC96E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 13:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOcof-0005o7-IO; Fri, 20 Dec 2024 08:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOcod-0005nw-C8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 08:13:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOcoa-0005p9-0H
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 08:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734700389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EcyCliaO7n1Cixt+YIZ7buhmcZX/UbOBxD5Z4rCk7aw=;
 b=RozFXU1KeAqQdCA3NSjRqFt2BwpCnv336QC51P4PRpAegoscheo7fGPcGun0WYiyK3CIz0
 8xIST1ExZe4S7iEEqDW8CSShq570GvCQ78Xc4deMVe0lxdPr/k68defrYBBEkdw+RA4RBd
 nVbyemVccOxe/bQIbA8rGK1kp6P7bxI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-OUK_tKFZOk6b4XPfj3PJdw-1; Fri,
 20 Dec 2024 08:13:05 -0500
X-MC-Unique: OUK_tKFZOk6b4XPfj3PJdw-1
X-Mimecast-MFC-AGG-ID: OUK_tKFZOk6b4XPfj3PJdw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E062C19560B5; Fri, 20 Dec 2024 13:13:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F69019560A2; Fri, 20 Dec 2024 13:13:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD5AE21E66E2; Fri, 20 Dec 2024 14:13:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 04/23] qapi: expand tags to all doc sections
In-Reply-To: <20241213021827.2956769-5-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:07 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-5-jsnow@redhat.com>
Date: Fri, 20 Dec 2024 14:13:00 +0100
Message-ID: <87ldwa4hwj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

> This patch adds an explicit section tag to all QAPIDoc
> sections. Members/Features are now explicitly tagged as such, with the
> name now being stored in a dedicated "name" field (which qapidoc.py was
> not actually using anyway.)
>
> WIP: Yeah, the difference between "tagged" and "untagged" sections is
> now pretty poorly named, and explicitly giving "untagged" sections an
> "UNTAGGED" tag is ... well, worse. but mechanically, this accomplishes
> what I need for the series.
>
> Please suggest better naming conventions, keeping in mind that I
> currently have plans for a future patch that splits the "UNTAGGED" tag
> into "INTRO" and "DETAILS" tags. But, we still need a meta-name for the
> category of sections that are "formerly known as untagged" but cannot be
> called "freeform" because that name is used for the category of
> docblocks that are not attached to an entity (but happens to be
> comprised entirely of "formerly known as untagged" sections.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

A free-form doc comment consists of just one untagged section, actually.
I don't remember whether anything relies on "just one".

The term "tagged" is rooted in doc comment syntax.
docs/devel/qapi-code-gen.rst section "Definition documentation":

    Definition documentation starts with a line naming the definition,
    followed by an optional overview, a description of each argument (for
    commands and events), member (for structs and unions), branch (for
    alternates), or value (for enums), a description of each feature (if
    any), and finally optional tagged sections.

Sadly, this isn't fully accurate anymore.

    Descriptions start with '\@name:'.  The description text must be
    indented [...]

    A tagged section begins with a paragraph that starts with one of the
    following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends with
    the start of a new section.

    The second and subsequent lines of tagged sections must be indented
    [...]

Nothing about untagged sections.  These are sections that aren't
descriptions or tagged.  Example:

    # @Returns: Lorem ipsum dolor sit amet, consectetur adipiscing elit,
    #     sed do eiusmod tempor incididunt ut labore et dolore magna
    #     aliqua.
    #
    # Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
    # nisi ut aliquip ex ea commodo consequat.
    #
    # Duis aute irure dolor in reprehenderit in voluptate velit esse
    # cillum dolore eu fugiat nulla pariatur.
    ##

Here, the tagged "Returns" section ends after "aliqua."  Why?  Because
"Ut enim" isn't indented.  The untagged section ends after "pariatur."

We parse a definition doc comment as a sequence of sections.

The first one is the overview.

Member / argument descriptions, if any, are next.

Then we may have any number of tagged or untagged sections.  If I
remember correctly, you'd like to banish them.  Let's pretend they can't
exist here.

Then we may have a "Features:" line followed by feature descriptions.

Finally, we may have any number of tagged or untagged sections.

Each of these sections is represented as an instance of type Section,
and the entire definition doc as an instance of type QAPIDoc.

Section has a member @tag of type str.

For tagged sections, it's the tag, i.e "Since", "Returns", ...  Obvious
enough.

For overview and other untagged sections, it's None.  Still obvious.

For descriptions, it's the name of the thing being described.  Less than
obvious.  Note that descriptions are actually instances of ArgSection, a
subtype of Section, which prevents confusion with tagged sections.

QAPIDoc has the overview in member @body, member / argument descriptions
in @args, feature descriptions in @features, and the remaining sections
in @sections.

I'm in favor of cleaning this up some.

I think we can keep the Section name.

Moving the name of the thing being described from @tag to @name is good.
What value to put into @tag then?  Whatever suits you.

Perhaps we should rename @tag to avoid undue ties to tagged sections.
@kind would work for me.

Value None for untagged sections is fine with me.  If a string suits you
better, that's fine, too.  "untagged", "plain", I don't know, propose
something.

@body, @args, and so forth aren't exactly great names.  If they truly
annoy or confuse you, feel free to propose better ones.


