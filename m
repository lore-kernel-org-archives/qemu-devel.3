Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BBAC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnWt-0003rA-Ia; Wed, 06 Mar 2024 04:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhnWo-0003qg-Bb
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhnWm-00064x-Ox
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709717132;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKphg01lTWlRZH23K5sQIL7CoOAMCBi2VcuV4zcTz5E=;
 b=jM5UCZj+B62tghsM8nwYifHWIjLKQZUCRhH7zHUhBFUP6uqBHPwbCN8+SKZ6LRzf/4fSY8
 k0F4BDDqDQ7PGrLCWVYV+dytsbClLKNIsfiLeUbaiEaskaI/vcf5JQnwyDroNowcj5P6PY
 Cc3Y1aHGiuQJFQ2LV3p4oU7j5Xu7dzE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-Rc-krxP2NDK1UhhTI2uAbQ-1; Wed, 06 Mar 2024 04:25:28 -0500
X-MC-Unique: Rc-krxP2NDK1UhhTI2uAbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 256A0800265;
 Wed,  6 Mar 2024 09:25:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 076E1111DCFF;
 Wed,  6 Mar 2024 09:25:26 +0000 (UTC)
Date: Wed, 6 Mar 2024 09:25:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/multifd: Don't fsync when closing QIOChannelFile
Message-ID: <Zeg2hN-mo53okbjL@redhat.com>
References: <20240305174332.2553-1-farosas@suse.de>
 <ZedbLT2pFNyRoX90@redhat.com> <Zee-WYQg9c19Up-T@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zee-WYQg9c19Up-T@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 06, 2024 at 08:52:41AM +0800, Peter Xu wrote:
> On Tue, Mar 05, 2024 at 05:49:33PM +0000, Daniel P. Berrangé wrote:
> > I don't think you should be removing this. Calling qio_channel_close()
> > remains recommended best practice, even with fdatasync() removed, as
> > it provides a strong guarantee that the FD is released which you don't
> > get if you rely on the ref count being correctly decremented in all
> > code paths.
> 
> Hmm, I have the confusion on why ioc->fd is more special than the ioc
> itself when leaked.  It'll be a bug anyway if we leak any of them?  Leaking
> fds may also help us to find such issue easier (e.g. by seeing stale fds
> under /proc).  From that POV I tend to agree on the original proposal.

Closing the FD would cause any registered I/O handlers callbacks to
get POLLNVAL and may well trigger cleanup that will prevent the leak.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


