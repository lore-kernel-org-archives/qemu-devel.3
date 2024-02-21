Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8919C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoUT-0002j7-KF; Wed, 21 Feb 2024 10:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoNJ-0004a7-96
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcimJ-0002PX-H0
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708507233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbVA983qG5V0mhfN/x3Yqgmnz7pzu+jOg20vLG6y+h0=;
 b=VKY7yfX8QBb3++2gzITE/xkTHvIUlIIq0awJozGrVBYl6kZi2Q9CdlsAdil4robvqrU33X
 CYDmTJ0a1vw0/ak1Ng47jJox02H5sx7AjmNAvAHBBWRTLdkzNnzfVj/iCPLLsH5ThWr/KF
 19Y8NYsBdxeGgJDHz3W28MYrgLRLdGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-2ZxXltRtMBCmlfsrSMznEw-1; Wed, 21 Feb 2024 04:20:28 -0500
X-MC-Unique: 2ZxXltRtMBCmlfsrSMznEw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43FFE85A58B;
 Wed, 21 Feb 2024 09:20:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20E32492BD7;
 Wed, 21 Feb 2024 09:20:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B437221E6740; Wed, 21 Feb 2024 10:20:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 30/34] monitor: Honor QMP request for fd removal
 immediately
In-Reply-To: <20240220224138.24759-31-farosas@suse.de> (Fabiano Rosas's
 message of "Tue, 20 Feb 2024 19:41:34 -0300")
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-31-farosas@suse.de>
Date: Wed, 21 Feb 2024 10:20:26 +0100
Message-ID: <87cysqxjfp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> We're currently only removing an fd from the fdset if the VM is
> running. This causes a QMP call to "remove-fd" to not actually remove
> the fd if the VM happens to be stopped.
>
> While the fd would eventually be removed when monitor_fdset_cleanup()
> is called again, the user request should be honored and the fd
> actually removed. Calling remove-fd + query-fdset shows a recently
> removed fd still present.
>
> The runstate_is_running() check was introduced by commit ebe52b592d
> ("monitor: Prevent removing fd from set during init"), which by the
> shortlog indicates that they were trying to avoid removing an
> yet-unduplicated fd too early.
>
> I don't see why an fd explicitly removed with qmp_remove_fd() should
> be under runstate_is_running(). I'm assuming this was a mistake when
> adding the parenthesis around the expression.
>
> Move the runstate_is_running() check to apply only to the
> QLIST_EMPTY(dup_fds) side of the expression and ignore it when
> mon_fdset_fd->removed has been explicitly set.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Eric, Kevin, your fingerprints are on commit ebe52b592d.  Could you have
a look at this fix?

> ---
>  monitor/fds.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/monitor/fds.c b/monitor/fds.c
> index d86c2c674c..4ec3b7eea9 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -173,9 +173,9 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
>      MonFdsetFd *mon_fdset_fd_next;
>  
>      QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
> -        if ((mon_fdset_fd->removed ||
> -                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
> -                runstate_is_running()) {
> +        if (mon_fdset_fd->removed ||
> +            (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0 &&
> +             runstate_is_running())) {
>              close(mon_fdset_fd->fd);
>              g_free(mon_fdset_fd->opaque);
>              QLIST_REMOVE(mon_fdset_fd, next);


