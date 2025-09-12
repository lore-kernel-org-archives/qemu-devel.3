Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1228CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0kK-0004a3-RQ; Fri, 12 Sep 2025 06:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux0k0-0004TA-Ty
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux0jy-0002ig-Fw
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757671848;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=to9v2ZA3kQRjCHWG8k9qSMGHadRH2iiKOZegBXoRvrk=;
 b=BvZYbK545GbWZvVXQV70VuYoFSQb9vetgdhBWLU5kFLLvnVB2Bis3tIHrj5+3K8gLbXGIU
 2DeRQiMLL33y3UvYm8fILtSfH+3JuHHLqQ9ENAJF4BFk8b50SiJdYi9s3C8w8jjYfytHFG
 9UA9IphZ7NtRT7dXoVFhZ/mz5ZC9J0c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-c2adE55dNKqtKN3ZM-byEQ-1; Fri,
 12 Sep 2025 06:10:46 -0400
X-MC-Unique: c2adE55dNKqtKN3ZM-byEQ-1
X-Mimecast-MFC-AGG-ID: c2adE55dNKqtKN3ZM-byEQ_1757671845
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F6E91956058; Fri, 12 Sep 2025 10:10:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E88F1954126; Fri, 12 Sep 2025 10:10:43 +0000 (UTC)
Date: Fri, 12 Sep 2025 11:10:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 07/12] ui/spice-core: Clean up error reporting
Message-ID: <aMPxnwt-lBA3CXVC@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-8-armbru@redhat.com>
 <aKRc1B-4wf_n2s14@redhat.com> <87y0qnyhs0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0qnyhs0.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 09, 2025 at 01:41:51PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Aug 08, 2025 at 10:08:18AM +0200, Markus Armbruster wrote:
> >> watch_add() reports _open_osfhandle() failure with
> >> error_setg(&error_warn, ...).
> >> 
> >> I'm not familiar with Spice, so I can't say whether it will work after
> >> such a failure.  If it doesn't, then this should be an error.  If it
> >> does, then why bother the user with a warning that isn't actionable,
> >> and likely confusing?
> >
> > If watch_add fails, spice is dead. Eventually the NULL returned from
> > watch_add will bubble up to the spice_server_init function which will
> > return non-zero and QEMU will do
> >
> >         error_report("failed to initialize spice server");
> >         exit(1);
> >
> > The warning in watch_add gives a better chance of understanding
> > what failed than this generic error_report() does.
> 
> Would you like me to work this into the commit message?

Yes, if you're re-spinning might as well add the context info.

> 
> >> Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
> >> just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
> >> ...) are.  Replace by warn_report().
> >> 
> >> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  ui/spice-core.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Thanks!
> 
> [...]
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


