Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102F9CEE344
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLPcL-0006UO-40; Tue, 18 Nov 2025 12:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLPcJ-0006Ty-C8
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:35:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLPcG-00026q-Gn
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763487339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4J+Jxqe282jLvzRDyyfM8ByyrEjq0IFON4VBKCTZvbI=;
 b=eW2IslvtLrSHy9XJpxEadZro6iLEt+cRHcu4YCRVp2qfBANhbG3Ce8mVxopBOzCmsPiGv8
 H7e+PWxRSaC9j+SBKrZC3/1yIZ/q3bNY947McAmpF0g7kflBRCvFR72yDk1Vz0jrSq378y
 Dp0wYxG6Di4DhAtzZl9LJJqimEvbd0s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-YrUcEaByMpS9hwkMDpbHdA-1; Tue, 18 Nov 2025 12:35:37 -0500
X-MC-Unique: YrUcEaByMpS9hwkMDpbHdA-1
X-Mimecast-MFC-AGG-ID: YrUcEaByMpS9hwkMDpbHdA_1763487337
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2f0be2cf0so1077522985a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 09:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763487337; x=1764092137; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4J+Jxqe282jLvzRDyyfM8ByyrEjq0IFON4VBKCTZvbI=;
 b=h1mYTpkvcEQVjUA53yVcOnge1o5bq0ixbUbM4ca5uJg8gCVEg++eVAohv2Ri+V6r0Z
 YqbWtdEzKJzgWkJUoPiOGtHz+R4IBbjtDCoqbpFksM1L9YhLtilXEC7AcHYCcNzi4EwN
 cjD5PHI9Qd5P5g4RrGIJcws2r5eX5XIZaUcQ8qWPANE5IGVGpyK4as7sxZqJNe+Xe8xn
 3Ta70FzpVXZuF63JJkRzqR8VZSNwbqYFSEaB/viddPP4+bGXVQAIGYCI8uHMr8tranZ+
 Jyxuqeov6xktCJBht+Mai4ukjzOeZoksH3UWQi7nNuqiP+xQD1W2ZFHz1QznhLi75d5U
 X4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763487337; x=1764092137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4J+Jxqe282jLvzRDyyfM8ByyrEjq0IFON4VBKCTZvbI=;
 b=BPbEPI31h/6VlTL4zo2m6hTRYHlzc8ktJV5fPAvGrsXCR5IXGBLhCGgBQdlm6D1XHr
 8wBQq1lYGD2lFyfHv5eJ2McEH0IQg8EpKA1eYQgqEgJ9Bpp0+jqTPbSptiay7kmwUTJn
 xxEWvvR33LfQRr5XWhocHh93pn2sIicDN7xDgP68OypQ3iq5b2xwzNZ/NC0zJGL100PI
 RBvplC1LkPTaaPshVPXXu1RllTLgA1zUQGTqeTonQlQc+Ce5zEt3qxJf4Z+fADAWtHdO
 PDihnDVuub3rZDuwPf7+O1uPndOvatuIFYFrB5zW8a6rs10USDAWAR9hUkOQaBrvvjm9
 aCTg==
X-Gm-Message-State: AOJu0Yz8AWOyPRlSISAaQNjVB8vVWnoxuRhG84nyZT9daMssR2OcASyc
 MWGPUe3+yYG8KB/JJZVMg3Y4Q4dSkXDyl8EzO/YWq+36bc6ob8iiBdI/Wf1TJSjfWvh9O2pXvEy
 pK37XkHAgie+faHnBRx6ShRVdbbVjMcTXfTQW/izUDzpp8W31T2HPScsO
X-Gm-Gg: ASbGnctKpuXO9MsFLPrqvAXEgVILpz+vk/ZHcVVVJNe52HisbaymSbjidcvKSZZLJh5
 d/b+raN4daJjO/3roG6ST7IlBfUIi3uFf8LRyzooc3YPBerJimrt7olE1SKgTbWvPM4X5Nw6C1V
 fORnHWd9zqPGCJfMiW/zmfdVZUn3kTNnDUYNaD5msQn32m45x8Q4BzV3eoP0RH/OijsvJyQ+vtx
 VIplfTvtcU9IN6eUB8U2h/dXROc66NLJN0Hj6Bwy7R5eJU5ZGJZJ+oVpni9S0zo/UVKoXy7IEIW
 DWVIpF9QLl1LwHD2bZGp9HpSwl8WbaiVZzfW8IYyLOEmaXaqMNwj81YFgd4N025Ut+7UzUk9O79
 lFg==
X-Received: by 2002:ad4:4ea5:0:b0:882:4632:cf7e with SMTP id
 6a1803df08f44-882925bdb7amr238080906d6.12.1763487336538; 
 Tue, 18 Nov 2025 09:35:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6MII2xHxSuEGYU45NQq2/nHdJvdl7TC1nvrSLQJUAWdfkQtB5UeGRGmS3ttk6Kflsu2lZkg==
X-Received: by 2002:ad4:4ea5:0:b0:882:4632:cf7e with SMTP id
 6a1803df08f44-882925bdb7amr238080346d6.12.1763487336017; 
 Tue, 18 Nov 2025 09:35:36 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8828638e2a2sm117529846d6.26.2025.11.18.09.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 09:35:35 -0800 (PST)
Date: Tue, 18 Nov 2025 12:35:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
Message-ID: <aRyuZbS7iALvx-BT@x1.local>
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a50jlr8f.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Nov 18, 2025 at 08:44:32AM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Sat, Nov 15, 2025 at 09:34:57AM +0100, Markus Armbruster wrote:
> >> Maintainers decide what to take for 10.2, if anything.
> >> 
> >> Let me know if you'd prefer the "perhaps should take ownership" idea
> >> in PATCH 1's commit message.
> >
> > I recall I had such patch previously, so I digged it out:
> >
> > https://lore.kernel.org/all/20230705163502.331007-3-peterx@redhat.com/
> >
> > I found that I dropped it in v3's post of that series, where I mentioned in
> > the change log that either way is not clean, so I dropped that until I
> > could have a better understanding:
> >
> > https://lore.kernel.org/all/20231004220240.167175-1-peterx@redhat.com/
> >
> > I think at that time I should have hit an use case where the caller forgot
> > to error_copy(), hence passing it in causing an UAF.
> 
> Use-after-free can happen if the caller holds on to its reference until
> after the stored Error is freed.  In other words, holding on to the
> reference is safe only until the stored Error is freed, and any safety
> argument will have to reason about the stored Error's lifetime.  No idea
> how difficult or brittle such an argument would be.
> 
> >                                                       Then I thought memory
> > leak was better in error path comparing to UAF if the API was used wrong
> > either way.
> 
> Fair point.
> 
> > But feel free to share your thoughts.  We can definitely revisit this.
> 
> migrate_set_error(s, err) stores a copy of @err in @s unless @s already
> has an Error stored.
> 
> I see 26 calls of migrate_set_error().
> 
> * 11 call error_free() immediately, and 2 call it via g_autoptr().  3
>   neglect to call it.  My patch fixes them.  Total is 16 out of 26.

Yes, I appreciate that!

> 
> * 6 report and free with error_report_err(), i.e. we store the error for
>   later *and* report it now.  Gives me an uneasy feeling.  How is the
>   stored error handled?  Will it be reported again?  That would likely
>   be wrong.

Migration as a module outlives me working as a developer on QEMU.. so I can
only share my two cents that still resides in my memory, which may or may
not always be the truth..

I think one issue is migration used to error_report() things all over the
places, but then we thought it a good idea to try remember the error so
that libvirt can query at any time if necessary.  With that, starting from
QEMU 2.7 we introduced error-desc into query-migrate results.  That's what
s->error was about.

But then, could we drop the error_report() / error_report_err()s?  Likely
not, because there might be user relying on the printed errors to see what
happened..  Making query-migrate the only source of error report adds
complexity to those users and may cause confusions..  Hence the extra
references sometimes needed after migrate_set_error(), almost for keeping
behaviors to print it out as the old times (I didn't check each of them,
though).

> 
> * 3 wrap migrate_set_error():
> 
>   - multifd_send_set_error()
> 
>     Its callers both call error_free() immediately.
> 
>   - migration_connect_set_error()
> 
>     3 callers.
> 
>     qmp_migrate() and qmp_migrate_finish() propagate to their callers,
>     i.e. we store the error for later *and* have callers handle it now.
>     Same uneasy feeling as above.
> 
>     One of migration_connect()'s callers passes NULL, the other calls
>     error_free() immediately.
> 
>   - multifd_recv_terminate_threads()
> 
>     Two callers pass NULL, one calls error_free() immediately, and
>     multifd_recv_new_channel() propagates.  Uneasy feeling again.
> 
> * qemu_savevm_state_setup() confuses me.  It sets @errp on failure, and
>   stores some (uneasy feeling), but not all of these errors with
>   migrate_set_error().  See below.

Yes, I also agree qemu_savevm_state_setup() is confusing on error
handlings.  I'll comment below.

> 
> Summary:
> 
> * We're prone to leaking the Error passed to migrate_set_error().
> 
> * If we replaced it by a function that takes ownership, we may become
>   prone to use-after-free.  I write "may" because I'm unsure when
>   exactly a use after calling this ownership-taking function would be
>   unsafe.
> 
> * The "forked" Error handling makes me uneasy.  I'm sure we do it for
>   reasons.  Can you help me understand them?

Hope above would provide some context.  In short, IMHO it's a mixture
demand of "print the error immediately like the old behavior" and "remember
the error too when query".

> 
> > I queued the series for this release, thanks Markus.
> 
> Thanks!
> 
> 
> Bonus content:
> 
>     int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>     {
>         ERRP_GUARD();
>         MigrationState *ms = migrate_get_current();
>         JSONWriter *vmdesc = ms->vmdesc;
>         SaveStateEntry *se;
>         int ret = 0;
> 
>         if (vmdesc) {
>             json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
>             json_writer_start_array(vmdesc, "devices");
>         }
> 
>         trace_savevm_state_setup();
>         QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> 
> The function does work in a loop.
> 
> This work can fail in two places, setting @errp.  When it does, we
> return.
> 
>             if (se->vmsd && se->vmsd->early_setup) {
> 
> First one:
> 
>                 ret = vmstate_save(f, se, vmdesc, errp);
>                 if (ret) {
> 
> vmstate_save() set @errp and returned an error code.
> 
>                     migrate_set_error(ms, *errp);
>                     qemu_file_set_error(f, ret);
> 
> Store @errp in @ms, and the error code in @f.
> 
> Aside: storing error state in two places feels like one too many.

Correct.  It's once again legacy of migration code where it used to set
error onto fds (e.g. that'll start to fail all qemufile APIs on this fd,
and qemufile API is not well designed IMHO.. which is another story), but
then we start to have string-based Errors and I guess we didn't try harder
to unify both.

> 
>                     break;
> 
> This break jumps to if (ret) { return ret; }, so it's a roundabout way
> to return ret.  Meh.

IIUC some people prefer such way so the function returns at a single point
(easier to add common cleanup codes, for example).  But I'd confess I also
prefer a direct return. :)

> 
>                 }
>                 continue;
>             }
> 
>             if (!se->ops || !se->ops->save_setup) {
>                 continue;
>             }
>             if (se->ops->is_active) {
>                 if (!se->ops->is_active(se->opaque)) {
>                     continue;
>                 }
>             }
>             save_section_header(f, se, QEMU_VM_SECTION_START);
> 
> Second one:
> 
>             ret = se->ops->save_setup(f, se->opaque, errp);
>             save_section_footer(f, se);
>             if (ret < 0) {
> 
> ->save_setup() set @errp and returned an error code.
> 
>                 qemu_file_set_error(f, ret);
> 
> This time we store only the error code.  Why not @errp?

IIUC migrate_set_error() above was redundant instead, because
qemu_savevm_state_setup()'s caller will do migrate_set_error().

Said that, we shouldn't need to randomly call qemu_file_set_error() either
deep in this function.. may need some cleanups.

> 
>                 break;
> 
> Again, a roundabout way to return ret.
> 
>             }
> 
> Obviously ret >= 0 here.  I believe @errp is not set.

I don't think in this path ret can be >0..  but yeah this is pretty
unobvious even if true.  That's also why I liked QEMU's current preferences
of "bool fn(..., Error **errp)".. at least in new codes.  Maybe I should
ping Vladimir on his recent work here?

https://lore.kernel.org/r/20251028231347.194844-1-vsementsov@yandex-team.ru

That'll be part of such cleanup effort (and yes unfortunately many
migration related cleanups will need a lot of code churns...).

> 
>         }
> 
> We get here either via break or normal loop termination.
> 
> If via break, ret != 0 and @errp set.
> 
> If via normal loop termination, ret >= 0 and @errp not set.
> 
>         if (ret) {
>             return ret;
> 
> If via normal loop termination, and ret > 0, we return failure (I think)
> without setting @errp.  I hope this can't happen, because ->save_setup()
> never returns > 0.  But it's unclean even then.
> 
>         }
> 
> I trust @errp is still unset here.  This is the case if we take the
> return right above when @errp has been set.
> 
>         /* TODO: Should we check that errp is set in case of failure ? */
>         return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
> 
> This time we store nothing.  Why?

I think the clean way is we do not store anything when this function
provided Error**.

> 
>     }
> 
> I think this function would be easier to understand if we replaced break
> by return.

I'll see what I can do with this function.

Thanks!

-- 
Peter Xu


