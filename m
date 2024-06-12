Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70792C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 18:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHSVU-0002h1-5I; Wed, 12 Jun 2024 14:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHSVR-0002gV-Ty
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHSVP-0001Kd-4w
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718216129;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fzQo7eJ8uQLFWthTKKZJCpf0h56ooCQSV9EEP6//dJ4=;
 b=BBKs7O7VQjxjLe8VYBMmUOzuMTmPG5q3sCN0/WqjUDjt+r+yaP7nWtMeHxg66fOJStTWo1
 zFpBp89zVaFGIL0E0OOGx4scWrk+s3iBUJS3hytPNFuQMwNkwhP655mYcfCX5aWJlCWMMz
 ehmrCBulskkRJWH2AOUQAulAxnhj/JA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-AJzFutMDP5iz6Ar2LrUOoA-1; Wed,
 12 Jun 2024 14:15:27 -0400
X-MC-Unique: AJzFutMDP5iz6Ar2LrUOoA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6588219560B2; Wed, 12 Jun 2024 18:15:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4B511956050; Wed, 12 Jun 2024 18:15:22 +0000 (UTC)
Date: Wed, 12 Jun 2024 19:15:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to precopy
 file migration
Message-ID: <Zmnlt0jUx2o1MEgy@redhat.com>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de> <ZmclVQw0x7KKLxmF@x1n>
 <87r0d4wv1q.fsf@suse.de> <ZmdNstq2bONG-7M7@x1n>
 <87le3cwo9e.fsf@suse.de> <87ed92c9vh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ed92c9vh.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 12, 2024 at 03:08:02PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Mon, Jun 10, 2024 at 02:45:53PM -0300, Fabiano Rosas wrote:
> I looked into this and it's cumbersome:
> 
> - We'd need to check migrate_direct_io() several times, once to get the
>   second fd and during every IO to know to use the fd.
> 
> - Even getting the second fd is not straight forward, we need to create
>   a new ioc for it with qio_channel_new_path(). But QEMUFile is generic
>   code, so we'd probably need to call this channel-file specific
>   function from migration_channel_connect().
> 
> - With the new ioc, do we put it in QEMUFile, or do we take the fd only?
>   Or maybe an ioc with two fds? Or a new QIOChannelDirect? All options
>   look bad to me.
> 
> So I suggest we proceed proceed with the 1 multifd channel approach,
> passing 2 fds into QEMU just like we do for the n channels. Is that ok
> from libvirt's perspective? I assume libvirt users are mostly interested
> in _enabling_ parallelism with --parallel, instead of _avoiding_ it with
> the ommision of the option, so main thread + 1 channel should not be a
> bad thing.

IIUC, with the "fixed-ram" feature, the on-disk format of a saved VM
should end up the same whether we're using traditional migration, or
multifd migration. Use of multifd is simply an optimization that lets
us write RAM in parallel to the file, with direct-io further optimizing.

There's also a clear break with libvirt between the existing on-disk
format libvirt uses, and the new fixed-ram format. So we have no backwards
compatibilty concerns added from multifd, beyond what we already have to
figure out when deciding on use of 'fixed-ram'. 

Thus I believe there is no downside to always using multifd for save
images with fixed-ram, even if we only want nchannels=1.


> Choosing to use 1 multifd channel now is also a gentler introduction for
> when we finally move all of the vmstate migration into multifd (I've
> been looking into this, but don't hold your breaths).

Yes, future proofing is a good idea.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


