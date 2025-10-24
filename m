Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F321ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKhy-00021z-8z; Fri, 24 Oct 2025 12:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCKhv-00021O-4J
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCKhr-0002JF-Et
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761323518;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRDfpQC8E0oCBtb7MzCfUYS5XgPIdeEk1gIm1GeFACM=;
 b=NMAhgIHJ41XGN8nt9yF5TmbrTNP7XGbtJEQEHm1vx4OWYQWAy9pr3rdrzNPuiaP2wMiDDT
 y1qb77f68yx7WlIgklpRZxXdYGhs95gGg5S51oLromAxmQeEsJCEKAU8NKe2ZCFjA0qTUW
 9xZfAOA8jIdN2KuCu5FO8FSUTSwYtCk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-Fpo0g9rJNhS9ccL37bmwfw-1; Fri,
 24 Oct 2025 12:31:54 -0400
X-MC-Unique: Fpo0g9rJNhS9ccL37bmwfw-1
X-Mimecast-MFC-AGG-ID: Fpo0g9rJNhS9ccL37bmwfw_1761323514
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA6491800C36; Fri, 24 Oct 2025 16:31:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF88F19560B8; Fri, 24 Oct 2025 16:31:51 +0000 (UTC)
Date: Fri, 24 Oct 2025 17:31:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
Message-ID: <aPup9BzTf-uk8cUf@redhat.com>
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org> <aPtim8ZACUWyje2o@redhat.com>
 <874irozabw.fsf@pond.sub.org> <87v7k4xuhk.fsf@pond.sub.org>
 <aPumkKBx4PoGSwNv@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPumkKBx4PoGSwNv@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 24, 2025 at 12:17:20PM -0400, Peter Xu wrote:
> On Fri, Oct 24, 2025 at 04:08:39PM +0200, Markus Armbruster wrote:
> > Markus Armbruster <armbru@redhat.com> writes:
> > 
> > > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > [...]
> > 
> > >> But wow, the migrate_add_blocker API design is unpleasant with its
> > >> pair of "Error **" parameters - it is practically designed to
> > >> maximise confusion & surprise.
> > >
> > > It's quite a sight, isn't it?
> > >
> > > I'll give it a quick Friday afternoon try.
> > 
> > Alright, my confusion has been maximised.  Giving up on this.
> 
> Besides the use of two Error** that might be confusing, what is more
> confusing (if not wrong..): migrate_add_blocker() will take ownership of
> the 1st Error**, no matter whether the helper succeeded or not. However, it
> only resets the first Error** if failed.
> 
> I think it means if migrate_add_blocker() succeeded, the caller will have a
> non-NULL pointer, even if it has lost the ownership of that pointer.
> 
> I'm guessing it never caused issue only because we don't usually
> error_free() the migration blocker anywhere.. but I think maybe we should
> at least do an error_copy() in add_blockers()..

IMHO we should not even be using an Error object for the the blocker.
AFAICT, internally all we care about is the formatted string. The main
reason for using an Error object appears to be to have a convenient
pointer to use as an identifier to later pass to del_blocker.

I'd be inclined to just have passed in a fixed string, and return an
integer identifier for the blocker. eg

    int64 migrate_add_blocker(const char *reason, Error **errp);

    void migrate_del_blocker(int64 blockerid);

The migrate_add_blocker method would strdup(reason) to keep its own
copy.

The usage would thus be clear & simple:

    int64 blockerid = migrate_add_blocker("cannot migrate vfio", errp);
    if (!blockerid) {
         return;
    }

    ... some time later...

    migrate_del_blocker(blockerid);


In some cases we needed dynamically formatted strings, which could have
been achieved thus:

    g_autofree char *msg = g_strdup_printf("cannot migrate vfio %d", blah);
    int64 blockerid = migrate_add_blocker(msg, errp);
    ...the rest as above...

yes, this costs an extra strdup(), but that is an acceptable & negligible
overhead in the context in which we're doing this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


