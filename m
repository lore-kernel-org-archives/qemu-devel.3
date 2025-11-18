Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D02CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLGOP-0005hW-FT; Tue, 18 Nov 2025 02:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLGOL-0005gy-MZ
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:44:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLGOI-0000Qe-VF
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763451880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KISTLibgHZeTXOLAPLe9Dn2u/AbQzEH5U4uDeyJsLH0=;
 b=Mr85CfiwEENtR7TlwI+Gr+K107MAyekkAMAwqib2c8ySG87KBvLA7ytix0uPFoHggfP6jD
 gcFfsFd7eTXBz1I5oZrmvwvlupau3oct/DB0OP7XpYPNtVM8b0MGEFIa9dtz+n5ZcSO2CY
 n7edh9DPUznmzuXZevHjQZx6zr7jz1k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-QiGRLvyXNam-4-S8LRAQrQ-1; Tue,
 18 Nov 2025 02:44:37 -0500
X-MC-Unique: QiGRLvyXNam-4-S8LRAQrQ-1
X-Mimecast-MFC-AGG-ID: QiGRLvyXNam-4-S8LRAQrQ_1763451876
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F9621800370; Tue, 18 Nov 2025 07:44:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0D86180049F; Tue, 18 Nov 2025 07:44:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F2CC721E6A27; Tue, 18 Nov 2025 08:44:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  farosas@suse.de
Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
In-Reply-To: <aRtHWbWcTh3OF2wY@x1.local> (Peter Xu's message of "Mon, 17 Nov
 2025 11:03:37 -0500")
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local>
Date: Tue, 18 Nov 2025 08:44:32 +0100
Message-ID: <87a50jlr8f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Sat, Nov 15, 2025 at 09:34:57AM +0100, Markus Armbruster wrote:
>> Maintainers decide what to take for 10.2, if anything.
>> 
>> Let me know if you'd prefer the "perhaps should take ownership" idea
>> in PATCH 1's commit message.
>
> I recall I had such patch previously, so I digged it out:
>
> https://lore.kernel.org/all/20230705163502.331007-3-peterx@redhat.com/
>
> I found that I dropped it in v3's post of that series, where I mentioned in
> the change log that either way is not clean, so I dropped that until I
> could have a better understanding:
>
> https://lore.kernel.org/all/20231004220240.167175-1-peterx@redhat.com/
>
> I think at that time I should have hit an use case where the caller forgot
> to error_copy(), hence passing it in causing an UAF.

Use-after-free can happen if the caller holds on to its reference until
after the stored Error is freed.  In other words, holding on to the
reference is safe only until the stored Error is freed, and any safety
argument will have to reason about the stored Error's lifetime.  No idea
how difficult or brittle such an argument would be.

>                                                       Then I thought memory
> leak was better in error path comparing to UAF if the API was used wrong
> either way.

Fair point.

> But feel free to share your thoughts.  We can definitely revisit this.

migrate_set_error(s, err) stores a copy of @err in @s unless @s already
has an Error stored.

I see 26 calls of migrate_set_error().

* 11 call error_free() immediately, and 2 call it via g_autoptr().  3
  neglect to call it.  My patch fixes them.  Total is 16 out of 26.

* 6 report and free with error_report_err(), i.e. we store the error for
  later *and* report it now.  Gives me an uneasy feeling.  How is the
  stored error handled?  Will it be reported again?  That would likely
  be wrong.

* 3 wrap migrate_set_error():

  - multifd_send_set_error()

    Its callers both call error_free() immediately.

  - migration_connect_set_error()

    3 callers.

    qmp_migrate() and qmp_migrate_finish() propagate to their callers,
    i.e. we store the error for later *and* have callers handle it now.
    Same uneasy feeling as above.

    One of migration_connect()'s callers passes NULL, the other calls
    error_free() immediately.

  - multifd_recv_terminate_threads()

    Two callers pass NULL, one calls error_free() immediately, and
    multifd_recv_new_channel() propagates.  Uneasy feeling again.

* qemu_savevm_state_setup() confuses me.  It sets @errp on failure, and
  stores some (uneasy feeling), but not all of these errors with
  migrate_set_error().  See below.

Summary:

* We're prone to leaking the Error passed to migrate_set_error().

* If we replaced it by a function that takes ownership, we may become
  prone to use-after-free.  I write "may" because I'm unsure when
  exactly a use after calling this ownership-taking function would be
  unsafe.

* The "forked" Error handling makes me uneasy.  I'm sure we do it for
  reasons.  Can you help me understand them?

> I queued the series for this release, thanks Markus.

Thanks!


Bonus content:

    int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
    {
        ERRP_GUARD();
        MigrationState *ms = migrate_get_current();
        JSONWriter *vmdesc = ms->vmdesc;
        SaveStateEntry *se;
        int ret = 0;

        if (vmdesc) {
            json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
            json_writer_start_array(vmdesc, "devices");
        }

        trace_savevm_state_setup();
        QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {

The function does work in a loop.

This work can fail in two places, setting @errp.  When it does, we
return.

            if (se->vmsd && se->vmsd->early_setup) {

First one:

                ret = vmstate_save(f, se, vmdesc, errp);
                if (ret) {

vmstate_save() set @errp and returned an error code.

                    migrate_set_error(ms, *errp);
                    qemu_file_set_error(f, ret);

Store @errp in @ms, and the error code in @f.

Aside: storing error state in two places feels like one too many.

                    break;

This break jumps to if (ret) { return ret; }, so it's a roundabout way
to return ret.  Meh.

                }
                continue;
            }

            if (!se->ops || !se->ops->save_setup) {
                continue;
            }
            if (se->ops->is_active) {
                if (!se->ops->is_active(se->opaque)) {
                    continue;
                }
            }
            save_section_header(f, se, QEMU_VM_SECTION_START);

Second one:

            ret = se->ops->save_setup(f, se->opaque, errp);
            save_section_footer(f, se);
            if (ret < 0) {

->save_setup() set @errp and returned an error code.

                qemu_file_set_error(f, ret);

This time we store only the error code.  Why not @errp?

                break;

Again, a roundabout way to return ret.

            }

Obviously ret >= 0 here.  I believe @errp is not set.

        }

We get here either via break or normal loop termination.

If via break, ret != 0 and @errp set.

If via normal loop termination, ret >= 0 and @errp not set.

        if (ret) {
            return ret;

If via normal loop termination, and ret > 0, we return failure (I think)
without setting @errp.  I hope this can't happen, because ->save_setup()
never returns > 0.  But it's unclean even then.

        }

I trust @errp is still unset here.  This is the case if we take the
return right above when @errp has been set.

        /* TODO: Should we check that errp is set in case of failure ? */
        return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);

This time we store nothing.  Why?

    }

I think this function would be easier to understand if we replaced break
by return.


