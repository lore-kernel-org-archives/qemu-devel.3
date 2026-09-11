Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD50C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vUb-0006zK-OY; Fri, 11 Sep 2026 03:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4vUZ-0006yv-4f
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4vUW-0007RN-5V
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789110965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INckx3OwI8lE8tTok0gYVN3xQnfljz2rzNHdoEGIx24=;
 b=WfDu76ZYueyf1aMgLW5U2fT8NL6DmDUu3prVzXxPXut+d7+VMsGSWuThXQa6vKfWFYF/3F
 pLsRQ1DAcAUV+8ox1moo0BRIbD51J8Jthdk8F/Necib0p7zVywGQ+dBhwncOqKW4Q1qEag
 BiIGd3cSSF8o2KsxPTqmQtclA6bo2PM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-tRXhUDrGM-C9On4xyA8-Lw-1; Fri,
 11 Sep 2026 03:16:02 -0400
X-MC-Unique: tRXhUDrGM-C9On4xyA8-Lw-1
X-Mimecast-MFC-AGG-ID: tRXhUDrGM-C9On4xyA8-Lw_1789110961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AC3A195422A; Fri, 11 Sep 2026 07:16:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B73561955D84; Fri, 11 Sep 2026 07:16:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F39221E6A04; Fri, 11 Sep 2026 09:15:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 15/18] migration: Rewrite
 migrate_set_parameter_completion using QDict
In-Reply-To: <87tsnxtfrn.fsf@suse.de> (Fabiano Rosas's message of "Thu, 10 Sep
 2026 10:09:00 -0300")
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-16-farosas@suse.de>
 <878q59e4nt.fsf@pond.sub.org> <87tsnxtfrn.fsf@suse.de>
Date: Fri, 11 Sep 2026 09:15:58 +0200
Message-ID: <878q58b6mp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> The migrate_set_parameter_completion function is the last user of the
>>> MigrationParameter enum.
>>
>> Not true, there's still the assertion in
>> migrate_mark_all_params_present(), and hmp_completion_single() in
>> tests/qtest/migration/misc-tests.c.
>>
>> The assertion is unclean: it uses MIGRATION_PARAMETER__MAX for number of
>> MigrationParameters members, which tacitly assumes MigrationParameter
>> matches MigrationParameters.
>>
>
> I'm not sure I understand what you mean here. The usefulness of
> MigrationParameter is quite diminished if it doesn't always match the
> members of MigrationParameters.

What we want to assert is "has_fields[] covers all the optional members
of MigrationParameters *p.

That's hard, so we settle for "has_fields[] covers the exact right
number of bool pointers".  Works as long as all elements of has_fields[]
point into @p, and there are no duplicates.

Note that "exact right number" is necessary but not sufficient for the
"covers all".  In other words, we're settling for a weaker assertion we
can actually check.  That's okay.

But that's still hard, so we assert "has_fields[] covers as many bool
pointers as there are MigrationParameter values" instead.  Works as long
as MigrationParameter matches MigrationParameters.

This isn't settling for a weaker assertion, it's asserting something
else!  It tacitly relies on "MigrationParameter matches
MigrationParameters", which is not locally obvious, and not ensured by
code, only by patch review.  I consider that unclean.  Doesn't mean it's
worthless, does mean it needs a comment.

> In fact... could we code-generate the enum from MigrationParameters
> without the need for explicitly declaring MigrationParameter? That way
> we keep the usefulness of having a lookup function and a "max" and do
> away with the task of updating MigrationParameter to match
> MigrationParameters.

Yes, we could, but it would be too much QAPI generator and documentation
complexity for just one use case.

The existing tool to introspect QAPI types from C is visitors.  Could it
work?  A bit of a bother, I'm afraid, but less complex than messing with
the QAPI generator.

>>>                          Write the code using an output visitor and
>>> QDict instead so we can remove the enum in a future patch.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>


