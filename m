Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D88C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 07:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7s6R-00038R-8U; Fri, 17 May 2024 03:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7s6O-00038D-RJ
 for qemu-devel@nongnu.org; Fri, 17 May 2024 03:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7s6M-00015X-I9
 for qemu-devel@nongnu.org; Fri, 17 May 2024 03:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715931241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXZDRTCvrl/7GFLi+5mIeiLHLrEDKtRg+dCy7zABPF8=;
 b=glJWKL+EXRr8+w3jiLAtKtfmZNhNomLWXSMtXwtpgu746rm5Ub/zaljz36g+vEaxh4cIHm
 Iei5kvABhVjtgYVJx7eV1khOSx5vbHi2KYzcYLuBTqBw6axxOSGWIZK+fBzztT9Hk1KgXj
 qVCViZpVjEE02szvzKGh7pZzGt+av9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-2WhhvqRGMt2AzWX2dZHMbQ-1; Fri, 17 May 2024 03:33:58 -0400
X-MC-Unique: 2WhhvqRGMt2AzWX2dZHMbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90E5F101A525;
 Fri, 17 May 2024 07:33:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 470F740C6EB7;
 Fri, 17 May 2024 07:33:56 +0000 (UTC)
Date: Fri, 17 May 2024 08:33:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 1/9] monitor: Honor QMP request for fd removal immediately
Message-ID: <ZkcIYjSXYI4MGfN4@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-2-farosas@suse.de>
 <ZjsnJj0mxW-rdAg_@redhat.com> <87ttixto2c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttixto2c.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 16, 2024 at 07:00:11PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:20:34AM -0300, Fabiano Rosas wrote:
> >> We're enabling using the fdset interface to pass file descriptors for
> >> use in the migration code. Since migrations can happen more than once
> >> during the VMs lifetime, we need a way to remove an fd from the fdset
> >> at the end of migration.
> >> 
> >> The current code only removes an fd from the fdset if the VM is
> >> running. This causes a QMP call to "remove-fd" to not actually remove
> >> the fd if the VM happens to be stopped.
> >> 
> >> While the fd would eventually be removed when monitor_fdset_cleanup()
> >> is called again, the user request should be honored and the fd
> >> actually removed. Calling remove-fd + query-fdset shows a recently
> >> removed fd still present.
> >> 
> >> The runstate_is_running() check was introduced by commit ebe52b592d
> >> ("monitor: Prevent removing fd from set during init"), which by the
> >> shortlog indicates that they were trying to avoid removing an
> >> yet-unduplicated fd too early.
> >
> > IMHO that should be reverted. The justification says
> >
> >   "If an fd is added to an fd set via the command line, and it is not
> >    referenced by another command line option (ie. -drive), then clean
> >    it up after QEMU initialization is complete"
> >
> > which I think is pretty weak. Why should QEMU forceably stop an app
> > from passing in an FD to be used by a QMP command issued just after
> > the VM starts running ?  While it could just use QMP to pass in the
> > FD set, the mgmt app might have its own reason for wanting QEMU to
> > own the passed FD from the very start of the process execve().
> 
> I don't think that's what that patch does. That description is
> misleading. I read it as:
> 
>    "If an fd is added to an fd set via the command line, and it is not
>     referenced by another command line option (ie. -drive), then clean
>     it up ONLY after QEMU initialization is complete"
>           ^
> 
> By the subject ("monitor: Prevent removing fd from set during init") and
> the fact that this function is only called when the monitor connection
> closes, I believe the idea was to *save* the fds until after the VM
> starts running, i.e. some fd was being lost because
> monitor_fdset_cleanup() was being called before the dup().

I know that, but I'm saying QEMU should not be doing *any* generic cleanup
of passed in FDs at any point. 

A passed in FD should be taken by whatever part of the QEMU configuration
is told to use it when needed, and this takes responsibility for closing
it. If nothing is told to use the fdset /yet/, then it should stay in the
fdset untouched for later use.

If an application accidentally passes in a FD that it doesn't reference
in any configuration, that's simply a application bug to fix. QEMU does
not need to secondguess the app's intent and decide to arbitrarily close
it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


