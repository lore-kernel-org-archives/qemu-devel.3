Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105B1C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ssC-0007cX-Sk; Tue, 14 May 2024 10:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6srw-0007aY-Tk
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6srt-0006pQ-9r
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715695859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=47DoMr+g/obCtpIQcI+ds9vNVv9fcOxuUq0G+MZwn4w=;
 b=TOeZBMTPnfFziq7K1OAg599mjuM5gCYx2bq12UNQhAyEQgnE2fxYl3RlXzj4TPkj2wTBJT
 v9yWK+o8p64uVHzwtDJfshQYO1aLx0OaUZIsvaJKsRdG91ouOP4zhJkmjt7uNuKNID5uEG
 bKGn7nKsPjiJZzGRpYnAleok3GAskqU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-Ui8flEGjMA6KlAg0qYThwQ-1; Tue,
 14 May 2024 10:10:53 -0400
X-MC-Unique: Ui8flEGjMA6KlAg0qYThwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D26853827491;
 Tue, 14 May 2024 14:10:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E3414179E7F;
 Tue, 14 May 2024 14:10:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9656321E5E6B; Tue, 14 May 2024 16:10:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,
 berrange@redhat.com,  armbru@redhat.com,  Claudio Fontana
 <cfontana@suse.de>,  Jim Fehlig <jfehlig@suse.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 4/9] migration: Add direct-io parameter
In-Reply-To: <ZjVUKCafjreLtLmm@x1n> (Peter Xu's message of "Fri, 3 May 2024
 17:16:24 -0400")
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-5-farosas@suse.de> <ZjUnghSvdy-wWtnN@x1n>
 <871q6ioc2r.fsf@suse.de> <ZjVUKCafjreLtLmm@x1n>
Date: Tue, 14 May 2024 16:10:51 +0200
Message-ID: <87ttj0zdp0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, May 03, 2024 at 05:49:32PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Fri, Apr 26, 2024 at 11:20:37AM -0300, Fabiano Rosas wrote:
>> >> Add the direct-io migration parameter that tells the migration code to
>> >> use O_DIRECT when opening the migration stream file whenever possible.
>> >> 
>> >> This is currently only used with the mapped-ram migration that has a
>> >> clear window guaranteed to perform aligned writes.
>> >> 
>> >> Acked-by: Markus Armbruster <armbru@redhat.com>
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >>  include/qemu/osdep.h           |  2 ++
>> >>  migration/migration-hmp-cmds.c | 11 +++++++++++
>> >>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>> >>  migration/options.h            |  1 +
>> >>  qapi/migration.json            | 18 +++++++++++++++---
>> >>  util/osdep.c                   |  9 +++++++++
>> >>  6 files changed, 68 insertions(+), 3 deletions(-)
>> >> 
>> >> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> >> index c7053cdc2b..645c14a65d 100644
>> >> --- a/include/qemu/osdep.h
>> >> +++ b/include/qemu/osdep.h
>> >> @@ -612,6 +612,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
>> >>  bool qemu_has_ofd_lock(void);
>> >>  #endif
>> >>  
>> >> +bool qemu_has_direct_io(void);
>> >> +
>> >>  #if defined(__HAIKU__) && defined(__i386__)
>> >>  #define FMT_pid "%ld"
>> >>  #elif defined(WIN64)
>> >> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> >> index 7e96ae6ffd..8496a2b34e 100644
>> >> --- a/migration/migration-hmp-cmds.c
>> >> +++ b/migration/migration-hmp-cmds.c
>> >> @@ -397,6 +397,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>> >>          monitor_printf(mon, "%s: %s\n",
>> >>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>> >>              qapi_enum_lookup(&MigMode_lookup, params->mode));
>> >> +
>> >> +        if (params->has_direct_io) {
>> >> +            monitor_printf(mon, "%s: %s\n",
>> >> +                           MigrationParameter_str(
>> >> +                               MIGRATION_PARAMETER_DIRECT_IO),
>> >> +                           params->direct_io ? "on" : "off");
>> >> +        }
>> >
>> > This will be the first parameter to optionally display here.  I think it's
>> > a sign of misuse of has_direct_io field..

Yes.  For similar existing parameters, we do

               assert(params->has_FOO);
               monitor_printf(mon, "%s: '%s'\n",
                              MigrationParameter_str(MIGRATION_PARAMETER_FOO),
                              ... params->FOO as string ...)

>> > IMHO has_direct_io should be best to be kept as "whether direct_io field is
>> > valid" and that's all of it.  It hopefully shouldn't contain more
>> > information than that, or otherwise it'll be another small challenge we
>> > need to overcome when we can remove all these has_* fields, and can also be
>> > easily overlooked.
>> 
>> I don't think I understand why we have those has_* fields. I thought my
>> usage of 'params->has_direct_io = qemu_has_direct_io()' was the correct
>> one, i.e. checking whether QEMU has any support for that parameter. Can
>> you help me out here?
>
> Here params is the pointer to "struct MigrationParameters", which is
> defined in qapi/migration.json.  And we have had "has_*" only because we
> allow optional fields with asterisks:
>
>   { 'struct': 'MigrationParameters',
>     'data': { '*announce-initial': 'size',
>               ...
>               } }
>
> So that's why it better only means "whether this field existed", because
> it's how it is defined.
>
> IIRC we (or say, Markus) used to have some attempts deduplicates those
> *MigrationParameter* things, and if success we have chance to drop has_*
> fields (in which case we simply always have them; that "has_" makes more
> sense only if in a QMP session to allow user only specify one or more
> things if not all).

qapi/migration.json:

    ##
    # @MigrationParameters:
    #
--> # The optional members aren't actually optional.
    #

In other words, the has_FOO generated for the members of
MigrationParameters must all be true.

These members became optional when we attempted to de-duplicate
MigrationParameters and MigrateSetParameters, but failed (see commit
de63ab61241 "migrate: Share common MigrationParameters struct" and
commit 1bda8b3c695 "migration: Unshare MigrationParameters struct for
now").


