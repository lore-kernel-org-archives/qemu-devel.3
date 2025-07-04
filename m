Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1422C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 05:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXYgM-0005yj-5P; Fri, 04 Jul 2025 01:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXYgF-0005xY-Pj
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 01:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXYgD-0006px-Au
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 01:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751605783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4/l6gsT/tS/CFgqY1+Eyk9kD9q0wwxDlgiNI1vpBmc=;
 b=atUzjS/WXxgvflBUr4yYT9YzVHiC0m0jh3/MNOjKIrdvu5rIVy2KXhe4cBPFbquaEMVBIz
 JRQIAQQbd9Rf3w1JALp+LgsNjnGEVqYlHW6BIsRllet3ddLwtMjAzoiOjVJIzruVZPzA+u
 jPUsA6M7S1WLPs+r3maAiNR1CAvsGzU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-cZyU8heuP0m9SDT3rgS4xg-1; Fri,
 04 Jul 2025 01:09:39 -0400
X-MC-Unique: cZyU8heuP0m9SDT3rgS4xg-1
X-Mimecast-MFC-AGG-ID: cZyU8heuP0m9SDT3rgS4xg_1751605779
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A78E619560A6; Fri,  4 Jul 2025 05:09:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58299195608F; Fri,  4 Jul 2025 05:09:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A63B21E6A27; Fri, 04 Jul 2025 07:09:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,
 berrange@redhat.com
Subject: Re: [PATCH v2 01/24] migration: Fix leak of block_bitmap_mapping
In-Reply-To: <aGb2s6iySOJrEMx7@x1.local> (Peter Xu's message of "Thu, 3 Jul
 2025 17:31:31 -0400")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-2-farosas@suse.de> <87h5zw4eyc.fsf@pond.sub.org>
 <aGb2s6iySOJrEMx7@x1.local>
Date: Fri, 04 Jul 2025 07:09:35 +0200
Message-ID: <87v7o8sfsg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jul 01, 2025 at 08:12:27AM +0200, Markus Armbruster wrote:
>> Fabiano Rosas <farosas@suse.de> writes:
>> 
>> > Caught by inspection, but ASAN also reports:
>> >
>> > Direct leak of 16 byte(s) in 1 object(s) allocated from:
>> >  #0 in malloc
>> >  #1 in g_malloc
>> >  #2 in g_memdup
>> >  #3 in qapi_clone_start_struct ../qapi/qapi-clone-visitor.c:40:12
>> >  #4 in qapi_clone_start_list ../qapi/qapi-clone-visitor.c:59:12
>> >  #5 in visit_start_list ../qapi/qapi-visit-core.c:80:10
>> >  #6 in visit_type_BitmapMigrationNodeAliasList qapi/qapi-visit-migration.c:639:10
>> >  #7 in migrate_params_apply ../migration/options.c:1407:13
>> >  #8 in qmp_migrate_set_parameters ../migration/options.c:1463:5
>> >  #9 in qmp_marshal_migrate_set_parameters qapi/qapi-commands-migration.c:214:5
>> >  #10 in do_qmp_dispatch_bh ../qapi/qmp-dispatch.c:128:5
>> 
>> migration_instance_finalize() runs when a TYPE_MIGRATION object dies, we
>> have just one such object, pointed to by @current_migration, and it
>> lives until QEMU shuts down.
>> 
>> So this is as harmless as they get.  Please mentions this in the commit
>> message, to guide backporters.
>
> If we do not copy qemu-stable, and do not attach Fixes, logically it should
> imply no backport needed.  Not sure if it was intentional, though..

Yes, qemu-stable@ and Fixes: are how we indicate "consider backporting
this".  But since that's easily forgotten, absence doesn't imply "no
need to consider".

>                                                                      Agreed
> some enrichment in the log would always be nicer.

Spelling out the impact of the bug fixes is a good habit.  Or in this
case, the fact that it's not a bug.  No biggie here, just nice.  I like
nice commit messages :)

[...]


