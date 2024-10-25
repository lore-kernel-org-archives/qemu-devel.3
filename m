Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5764CD0C5EA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 08:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Fxs-0004kD-MJ; Fri, 25 Oct 2024 04:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Fxq-0004k4-MT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Fxp-0005M6-5r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729845992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=f8dnebKVTqkXFPoRyag1ix0sbBYJpPHWgX7NyMmYtB8=;
 b=OuLVX4yydE1mL3iY5dRP/hW47cydIEPp12v4DPlcVciETkWZV18/n/YyIobIZWMCI3IuqC
 EMnl3a0bv1NX7JgUTOU05VuXzYUhnW8Zqy+C8TPh0CR+PgFqWEn+S3E5rXXF7YaQPmJn/J
 ow3Lw/69PPp6pll1nShaBpfFu4/9098=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-qpF6_z8lMOyYhHdh9Ahcgg-1; Fri,
 25 Oct 2024 04:46:28 -0400
X-MC-Unique: qpF6_z8lMOyYhHdh9Ahcgg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D53D195608A; Fri, 25 Oct 2024 08:46:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07D901955F43; Fri, 25 Oct 2024 08:46:22 +0000 (UTC)
Date: Fri, 25 Oct 2024 09:46:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 00/14] precreate phase
Message-ID: <Zxta2w6iu2n_5YBa@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
 <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 24, 2024 at 05:16:14PM -0400, Steven Sistare wrote:
> 
> Regarding: "what you want is effectively to execute monitor commands
> from the migration stream"
> 
> That is not the goal of this series.  It could be someone else's goal, when
> fully developing a precreate phase, and in that context I understand and
> agree with your comments.  I have a narrower immediate problem to solve,
> however.
> 
> For CPR, src qemu sends file descriptors to dst qemu using SCM_RIGHTS over
> a dedicated channel, then src qemu sends migration state over the normal
> migration channel.
> 
> Dst qemu reads the fds early, then calls the backend and device creation
> functions which use them.  Dst qemu then accepts and reads the migration
> channel.
> 
> We need a way to send monitor commands that set dst migration capabilities,
> before src qemu starts the migration.  Hence the dst cannot proceed to
> backend and device creation because the src has not sent fd's yet.  Hence
> we need a dst monitor before device creation.  The precreate phase does that.

Sigh, what we obviously need here, is what we've always talked about as our
long term design goal:

A way to launch QEMU with the CLI only specifying the QMP socket, and every
other config aspect done by issuing QMP commands, which are processed in the
order the mgmt app sends them, so QEMU hasn't have to hardcode processing
of different pieces in different phases.

Anything that isn't that, is piling more hacks on top of our existing
mountain of hacks. That's OK if it does something useful as a side effect
that moves us incrementally closer towards that desired end goal.

> Regarding: "This series makes this much more complex."
> 
> I could simplify it if I abandon CPR for chardevs.  Then qemu_create_early_backends
> and other early dependencies can remain as is.  I would drop the notion of
> a precreate phase, and instead leverage the preconfig phase.  I would move
> qemu_create_late_backends, and a small part at the end of qemu_init, to
> qmp_x_exit_preconfig.

Is CPR still going to useful enough in the real world if you drop chardev
support ? Every VM has at least one chardev for a serial device doesn't
it, and often more since we wire chardevs into all kinds of places.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


