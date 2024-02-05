Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54616C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWwC3-0005bE-Oy; Mon, 05 Feb 2024 05:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rWwC2-0005b6-Oc
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:27:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rWwC1-00057m-3e
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707128832;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=e7P8t8sjIYRWa9hoqjvEOhN5cYQsy2c7tiYjNh9O814=;
 b=f9zLwNXYsAlnQVYIEEkPpkyUDugsheUbEuNzAtajFGInntYXzMExofzC1Sm06um2HIvH+Y
 hzSVCj4bX6ewQ7YwBLzu3tbTtzUkC3kVPb0P/iREJK6SpBxK+6FR2KHhodH/8j1mF1BAyS
 grQqKc2v5+SLN+TQ896yRvQ9GHb3W+o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-e2ttwJnBNvu2cjS21SDCSw-1; Mon,
 05 Feb 2024 05:27:08 -0500
X-MC-Unique: e2ttwJnBNvu2cjS21SDCSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9B8B38562C3;
 Mon,  5 Feb 2024 10:27:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D89D91121313;
 Mon,  5 Feb 2024 10:27:06 +0000 (UTC)
Date: Mon, 5 Feb 2024 10:27:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, sw@weilnetz.de,
 t.lamprecht@proxmox.com
Subject: Re: [PATCH v2] qemu_init: increase NOFILE soft limit on POSIX
Message-ID: <ZcC3-G_COqbk8SxX@redhat.com>
References: <20231218101340.35053-1-f.ebner@proxmox.com>
 <a912519d-e83c-460b-ab89-931e83e2ee44@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a912519d-e83c-460b-ab89-931e83e2ee44@proxmox.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 09:35:19AM +0100, Fiona Ebner wrote:
> Am 18.12.23 um 11:13 schrieb Fiona Ebner:
> > In many configurations, e.g. multiple vNICs with multiple queues or
> > with many Ceph OSDs, the default soft limit of 1024 is not enough.
> > QEMU is supposed to work fine with file descriptors >= 1024 and does
> > not use select() on POSIX. Bump the soft limit to the allowed hard
> > limit to avoid issues with the aforementioned configurations.
> > 
> > Of course the limit could be raised from the outside, but the man page
> > of systemd.exec states about 'LimitNOFILE=':
> > 
> >> Don't use.
> >> [...]
> >> Typically applications should increase their soft limit to the hard
> >> limit on their own, if they are OK with working with file
> >> descriptors above 1023,
> > 
> > If the soft limit is already the same as the hard limit, avoid the
> > superfluous setrlimit call. This can avoid a warning with a strict
> > seccomp filter blocking setrlimit if NOFILE was already raised before
> > executing QEMU.
> > 
> > Buglink: https://bugzilla.proxmox.com/show_bug.cgi?id=4507
> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> > ---
> > 
> 
> Ping

I have this queued already for my next pull request

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


