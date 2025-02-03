Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F26C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 20:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf3BF-0000Ft-NX; Mon, 03 Feb 2025 15:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf3BE-0000Fl-H0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:36:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf3BC-0007WM-87
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738614984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cTPKBBtw22uGI5mxI8apUs1VAHDtFJDSQjarxuhlYoM=;
 b=QL2ckToR8r67cEt0yoHckBznE2xg3tAzJfTxxczv/wQJClbf1dRCAWYzQCejs0RY77FdfY
 w3o1eHPAGgzeVz6EEcGaMbGXQhNdWYbo9516NVp7eJSMu8M0CqcwXW1/YaNyikwTp9EITa
 0RR2We/+dqNcCvUooYnRnsWpbbPSDOQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-3aZUvap1MKCDpiC078dgDw-1; Mon, 03 Feb 2025 15:36:23 -0500
X-MC-Unique: 3aZUvap1MKCDpiC078dgDw-1
X-Mimecast-MFC-AGG-ID: 3aZUvap1MKCDpiC078dgDw
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e7f07332so814563085a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 12:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738614983; x=1739219783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTPKBBtw22uGI5mxI8apUs1VAHDtFJDSQjarxuhlYoM=;
 b=ekLLj87b/11/r6K9C0Mqdtv+gun5VRJ2v4+zBYEpZW3FDl9yuJKDqmW0aZ7jivLM/1
 e49HmOpeXJvTR9+DAPZW7xa6Nh6oFkfo4g9NIBPxczRzNfTaUyLIk8Yggf4N4tNlpYYv
 xbyZpzq4P2xUuBZb6vmWrmCiK6z0msJcfl111+Psx98LywVulntTyrrvCnwziH9xMLEJ
 HZNY764U0JoJw5fgcsYjzCliTLJM/icxnF52L8eqd7RDr1VGr41ATXWUqkbT+Fy+2hKa
 C++HMERB9pDGxEsl/KSYHlRGQUvJY2wKXZismO+zT5kDdlya20qq8tlubXei82LfFRxa
 BAiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRmVqLT4/hF/HEoICOu59bTnuaHTQvL1Sqj2VLKkBjYHvJxM9aykclf4iXM4OeFSxiZ/manpLesNag@nongnu.org
X-Gm-Message-State: AOJu0YzR2kUkUGS32/7BynvwxlzMPjXVWJbnRy3ckFTLBLibucHjMUUN
 Gr4SvB1TT/a4TkeDy+a6PUfhCO7C443MplKuT3yXhG3UOVh3ir25HTVi3yvl53JhElEhwIHjg9s
 anZ8rk3Gulmro84Uovhmp3E/8XkGbN4aa/07GcqZJ9KoQ1geeHiJR
X-Gm-Gg: ASbGncvKzRzvOrJwe1EOEVfnm/Ohqr6iSb7HgaOmveZAztpJrMSrhjNjW+V1xPp2+O+
 o1JY/ZDQYp/EdWjH/sQyDuAXynTQVjylScpjJGQwWdbFRE7LxgdKIaFtpklUASMuDDK22hpSUhG
 SbhQ5Qom5nQszgEZQLbB+FnbINaEerEGKJq7SfJPkgoFNhz8TUKyVt0r83Ph5tO9YU/yoGrGuLb
 8Vl0eb0edJkQ9lLfNVnYS+NJjQcyNZsLjA1IllszjnGJXuSrD1BTSDkMaL6XDvRPijj5tOx7E+f
 fxKBi1mixXGpGzqpLUTCxAMByQYD52Y53q3dB5SPPfXKMTSp
X-Received: by 2002:a05:620a:a54:b0:7b7:2de:6f83 with SMTP id
 af79cd13be357-7bffcda59cemr2809918285a.41.1738614982885; 
 Mon, 03 Feb 2025 12:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+j9Q/o6seAG5kTVyoq72NEGg9E5gtBDWoJDVSQ8KxXynfJT+Oz+EiuUZYij8SWRpI3W6x8A==
X-Received: by 2002:a05:620a:a54:b0:7b7:2de:6f83 with SMTP id
 af79cd13be357-7bffcda59cemr2809915385a.41.1738614982463; 
 Mon, 03 Feb 2025 12:36:22 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a9047eesm570456585a.72.2025.02.03.12.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:36:21 -0800 (PST)
Date: Mon, 3 Feb 2025 15:36:19 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/33] migration: postcopy_ram_listen_thread() needs
 to take BQL for some calls
Message-ID: <Z6Eow-Ei3CvLy1vG@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <139bf266dbd1e25a1e5a050ecb82e3e59120d705.1738171076.git.maciej.szmigiero@oracle.com>
 <Z57TPqhRYY4V14BE@gallifrey>
 <d3a27b10-a7a6-4aa6-97ad-9c39f49df4fc@maciej.szmigiero.name>
 <Z59o4u9zui3CPrkm@gallifrey>
 <fafbc505-acee-408e-a2ef-0a62bd30689b@maciej.szmigiero.name>
 <Z6Ef3iwQs7JSFY3c@x1.local>
 <afb27de1-d20a-4b0d-b271-ef6eef0e06ed@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afb27de1-d20a-4b0d-b271-ef6eef0e06ed@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Feb 03, 2025 at 09:15:52PM +0100, Maciej S. Szmigiero wrote:
> On 3.02.2025 20:58, Peter Xu wrote:
> > On Mon, Feb 03, 2025 at 02:57:36PM +0100, Maciej S. Szmigiero wrote:
> > > On 2.02.2025 13:45, Dr. David Alan Gilbert wrote:
> > > > * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> > > > > On 2.02.2025 03:06, Dr. David Alan Gilbert wrote:
> > > > > > * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > 
> > > > > > > postcopy_ram_listen_thread() is a free running thread, so it needs to
> > > > > > > take BQL around function calls to migration methods requiring BQL.
> > > > > > > 
> > > > > > > qemu_loadvm_state_main() needs BQL held since it ultimately calls
> > > > > > > "load_state" SaveVMHandlers.
> > > > > > > 
> > > > > > > migration_incoming_state_destroy() needs BQL held since it ultimately calls
> > > > > > > "load_cleanup" SaveVMHandlers.
> > > > > > > 
> > > > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > > > ---
> > > > > > >     migration/savevm.c | 4 ++++
> > > > > > >     1 file changed, 4 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > > > > > index b0b74140daea..0ceea9638cc1 100644
> > > > > > > --- a/migration/savevm.c
> > > > > > > +++ b/migration/savevm.c
> > > > > > > @@ -2013,7 +2013,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > > > > > >          * in qemu_file, and thus we must be blocking now.
> > > > > > >          */
> > > > > > >         qemu_file_set_blocking(f, true);
> > > > > > > +    bql_lock();
> > > > > > >         load_res = qemu_loadvm_state_main(f, mis);
> > > > > > > +    bql_unlock();
> > > > > > 
> > > > > > Doesn't that leave that held for a heck of a long time?
> > > > > 
> > > > > Yes, and it effectively broke "postcopy recover" test but I
> > > > > think the reason for that is qemu_loadvm_state_main() and
> > > > > its children don't drop BQL while waiting for I/O.
> > > > > 
> > > > > I've described this case in more detail in my reply to Fabiano here:
> > > > > https://lore.kernel.org/qemu-devel/0a09e627-955e-4f26-8d08-0192ecd250a8@maciej.szmigiero.name/
> > > > 
> > > > While it might be the cause in this case, my feeling is it's more fundamental
> > > > here - it's the whole reason that postcopy has a separate ram listen
> > > > thread.  As the destination is running, after it loads it's devices
> > > > and as it starts up the destination will be still loading RAM
> > > > (and other postcopiable devices) potentially for quite a while.
> > > > Holding the bql around the ram listen thread means that the
> > > > execution of the destination won't be able to take that lock
> > > > until the postcopy load has finished; so while that might apparently
> > > > complete, it'll lead to the destination stalling until that's finished
> > > > which defeats the whole point of postcopy.
> > > > That last one probably won't fail a test but it will lead to a long stall
> > > > if you give it a nice big guest with lots of RAM that it's rapidly
> > > > changing.
> > > 
> > > Okay, I understand the postcopy case/flow now.
> > > Thanks for explaining it clearly.
> > > 
> > > > > I still think that "load_state" SaveVMHandlers need to be called
> > > > > with BQL held since implementations apparently expect it that way:
> > > > > for example, I think PCI device configuration restore calls
> > > > > address space manipulation methods which abort() if called
> > > > > without BQL held.
> > > > 
> > > > However, the only devices that *should* be arriving on the channel
> > > > that the postcopy_ram_listen_thread is reading from are those
> > > > that are postcopiable (i.e. RAM and hmm block's dirty_bitmap).
> > > > Those load handlers are safe to be run while the other devices
> > > > are being changed.   Note the *should* - you could add a check
> > > > to fail if any other device arrives on that channel.
> > > 
> > > I think ultimately there should be either an explicit check, or,
> > > as you suggest in the paragraph below, a separate SaveVMHandler
> > > that runs without BQL held.
> > 
> > To me those are bugs happening during postcopy, so those abort()s in
> > memory.c are indeed for catching these issues too.
> > 
> > > Since the current state of just running these SaveVMHandlers
> > > without BQL in this case and hoping that nothing breaks is
> > > clearly sub-optimal.
> > > 
> > > > > I have previously even submitted a patch to explicitly document
> > > > > "load_state" SaveVMHandler as requiring BQL (which was also
> > > > > included in the previous version of this patch set) and it
> > > > > received a "Reviewed-by:" tag:
> > > > > https://lore.kernel.org/qemu-devel/6976f129df610c8207da4e531c8c0475ec204fa4.1730203967.git.maciej.szmigiero@oracle.com/
> > > > > https://lore.kernel.org/qemu-devel/e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com/
> > > > > https://lore.kernel.org/qemu-devel/87o732bti7.fsf@suse.de/
> > > > 
> > > > It happens!
> > > > You could make this safer by having a load_state and a load_state_postcopy
> > > > member, and only mark the load_state as requiring the lock.
> > > 
> > > To not digress too much from the subject of this patch set
> > > (multifd VFIO device state transfer) for now I've just updated the
> > > TODO comment around that qemu_loadvm_state_main(), so hopefully this
> > > discussion won't get forgotten:
> > > https://gitlab.com/maciejsszmigiero/qemu/-/commit/046e3deac5b1dbc406b3e9571f62468bd6743e79
> > 
> > The commit message may still need some touch ups, e.g.:
> > 
> >    postcopy_ram_listen_thread() is a free running thread, so it needs to
> >    take BQL around function calls to migration methods requiring BQL.
> > 
> > 
> > This sentence is still not correct, IMHO. As Dave explained, the ram load
> > thread is designed to run without BQL at least for the major workloads it
> > runs.
> 
> So what's your proposed wording of this commit then?

Perhaps dropping it? As either it implies qemu_loadvm_state_main() needs to
take bql (which could be wrong in case of postcopy at least from
design.. not sanity check pov), or it provides no real meaning to suggest
where to take it..

Personally I would put the comment as easy as possible - the large portion
isn't helping me to understand the code but only made it slightly more
confusing..

    /*
     * TODO: qemu_loadvm_state_main() could call "load_state" SaveVMHandlers
     * that are expecting BQL to be held, which isn't in this case.
     *
     * In principle, the only devices that should be arriving on this channel
     * now are those that are postcopiable and whose load handlers are safe
     * to be called without BQL being held.
     *
     * But nothing currently prevents the source from sending data for "unsafe"
     * devices which would cause trouble here.
     */

IMHO we could put it very simple if you think we need such sanity check
later:

    /* TODO: sanity check that only postcopiable data will be loaded here */

> 
> > I don't worry on src sending something that crashes the dest: if that
> > happens, that's a bug, we need to fix it..  In that case abort() either in
> > memory.c or migration/ would be the same.
> 
> Yeah, but it would be a bug in the source (or just bit stream corruption for
> any reason), yet it's the destination which would abort() or crash.
> 
> I think cases like that in principle should be handled more gracefully,
> like exiting the destination QEMU with an error.
> But that's something outside of the scope of this patch set.

Yes I agree.  It's just that postcopy normally cannot gracefully quits on
dest anyway.. as src QEMU cannot continue with a dead dest QEMU. For
obvious programming errors, I think abort() is still ok in this case, on
either src or dest if postcopy already started.

For this series, we could always stick with precopy, it could help converge
the series.

> 
> > We could add some explicit check
> > in migration code, but I don't expect it to catch anything real, at least
> > such never happened since postcopy introduced.. so it's roughly 10 years
> > without anything like that happens.
> > 
> > Taking BQL for migration_incoming_state_destroy() looks all safe.  There's
> > one qemu_ram_block_writeback() which made me a bit nervous initially, but
> > then looks like RAM backends should be almost noop (for shmem and
> > hugetlbfs) but except pmem.
> 
> That's the only part where taking BQL is actually necessary for the
> functionality of this patch set to work properly, so it's fine to leave
> that call to qemu_loadvm_state_main() as-is (without BQL) for time being.
> 
> > 
> > The other alternative is we define load_cleanup() to not rely on BQL (which
> > I believe is true before this series?), then take it only when VFIO's path
> > needs it.
> 
> I think other paths always call load_cleanup() with BQL so it's probably
> safer to have consistent semantics here.

IMHO we don't necessarily need to make it the default that vmstate handler
hooks will need BQL by default - we can always properly define them to best
suite our need.

For this case I think it's ok either way. But I'm assuming: (1) no serious
users run QEMU RAMs on normal file systems (or RAM's cleanup() can do
msync() on those, which can flush page caches for a long time to disks),
and (2) pmem isn't important.

Thanks,

-- 
Peter Xu


