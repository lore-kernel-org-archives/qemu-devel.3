Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE1BC19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnE58-0007mt-TC; Wed, 26 Feb 2025 04:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnE55-0007m3-Ef
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnE52-0007HF-0R
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563508;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AkfsenqHtAfg76eGTQ19K945JjW1idDiUDs9jZqfWzM=;
 b=e2HKnkrfMfnhYwbd8kRzrm7I+uTDLtzaPvDeiSoTECfe6lJgaXDh6JsNE5kGnZzwrcPkpb
 il7BWw5+vl3AXlxjuBlm5BvVp7WHKdBJpuDyKq/JyUUE7/2RBNOQrmW9c4ogdMec/mTRUW
 DQKuGJESauoSMC0nnJujR7zLpZAOnt0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-GWgNt-3pMfC9r-FJE4Vf7g-1; Wed,
 26 Feb 2025 04:51:44 -0500
X-MC-Unique: GWgNt-3pMfC9r-FJE4Vf7g-1
X-Mimecast-MFC-AGG-ID: GWgNt-3pMfC9r-FJE4Vf7g_1740563504
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB9D2190FF83; Wed, 26 Feb 2025 09:51:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF7B31955BD4; Wed, 26 Feb 2025 09:51:39 +0000 (UTC)
Date: Wed, 26 Feb 2025 09:51:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] trace/simple: Fix hang when using simpletrace with fork()
Message-ID: <Z77kKA27N5oiMkI_@redhat.com>
References: <20250226085015.1143991-1-thuth@redhat.com>
 <Z77fF-7pdWTwRbt9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z77fF-7pdWTwRbt9@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 26, 2025 at 10:29:59AM +0100, Kevin Wolf wrote:
> Am 26.02.2025 um 09:50 hat Thomas Huth geschrieben:
> > When compiling QEMU with --enable-trace-backends=simple , the
> > iotest 233 is currently hanging. This happens because qemu-nbd
> > calls trace_init_backends() first - which causes simpletrace to
> > install its writer thread and the atexit() handler - before
> > calling fork(). But the simpletrace writer thread is then only
> > available in the parent process, not in the child process anymore.
> > Thus when the child process exits, its atexit handler waits forever
> > on the trace_empty_cond condition to be set by the non-existing
> > writer thread, so the process never finishes.
> > 
> > Fix it by installing a pthread_atfork() handler, too, which
> > makes sure that the trace_writeout_enabled variable gets set
> > to false again in the child process, so we can use it in the
> > atexit() handler to check whether we still need to wait on the
> > writer thread or not.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> I can see how this would fix the hang, but do we actually get the trace
> events written out somewhere then? Or do we need to make sure that the
> child process has a writer thread, too?
> 
> Of course, the question would then be how the two processes writing into
> the same trace file interact.

In st_set_trace_file, if no explicit filename is given by the user we
use a default filename "trace-$PID", so *if* the atfork handler in
the child were to reset its file after fork it'll get a distinct
filename. Happy days.

If the user provided an explicit filename though, we just use that as
is and would end up with dualling writers and likely data corruption.
While we could blindly append a pid to the user's filename it is 
somewhat unhelpful in the daemonize case to split it across files.

Whether we actually want tracing in a child also possibly depends on
the reason for fork.

If we're forking to daemonize, then we (mostly) want tracing in the
child and (mostly) no longer care about the parent.

If we're forking to exec another app, then we (mostly) want tracing in
the parent and (mostly) no longer care about the child.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


