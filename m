Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6010C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zep-0001vx-6y; Tue, 22 Sep 2026 08:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8zeY-0001sq-Im
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8zeW-0008FL-FF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790080275;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PH5vtgIh37Wa7fFhdm58aPskyPc8KZk5qP2x5oAt4j4=;
 b=GfI4X1E7QAjQesBxFxK+MGKdVaSTM15Uqpj298PdUplWtHefzWxznWyIUO6G/hkKRl5ReS
 9YZnt16ziDDPxTfJl/I5b0IwEl8ypmJExVXzvy24DM6Ptsk9/Qnd2jXjc42raLKwDa0XwH
 /1SkKimlzqoQb22ew/wIh0sYGM8tFzU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-qiqXj8imNkWWxEavYOKaaA-1; Tue,
 22 Sep 2026 08:31:11 -0400
X-MC-Unique: qiqXj8imNkWWxEavYOKaaA-1
X-Mimecast-MFC-AGG-ID: qiqXj8imNkWWxEavYOKaaA_1790080270
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6180418A5C53; Tue, 22 Sep 2026 12:30:58 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E96701800348; Tue, 22 Sep 2026 12:30:56 +0000 (UTC)
Date: Tue, 22 Sep 2026 13:30:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/9pfs: mutate FID path from main thread only
 (CVE-2026-93834)
Message-ID: <arJ0_dq0W1Ah7NV_@redhat.com>
References: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com>
 <20260922081301.244e5524@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922081301.244e5524@bahia>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Sep 22, 2026 at 08:13:01AM +0200, Greg Kurz wrote:
> On Mon, 21 Sep 2026 14:18:58 +0200
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > v9fs_co_open2() is the only code that mutates a FID path from a worker
> > thread: inside its v9fs_co_run_in_worker() block it frees fidp->path
> > and copies in the new path under the held FID path write lock.
> > 
> > Every other FID path mutation in the 9p codebase happens on the main
> > thread, so main thread readers (v9fs_walk(), v9fs_xattrwalk(),
> > v9fs_stat(), v9fs_co_name_to_path()) rely on the same (main) thread
> > atomicity and don't take the path read lock themselves on main thread.
> > 
> > Fix this by making the worker thread block in v9fs_co_open2() read-only
> > with respect to the FID: render the new path into the local 'path'
> > variable only and copy it to fidp->path after the worker block returned
> > back to the main thread and still under the held write lock of the FID,
> > like every other FID path mutation does.
> > 
> > Fixes: 02cb7f3a25 ("hw/9pfs: Use read-write lock for protecting fid path.")
> 
> Wow, it's a long standing issue ! ;-)
> 
> > Fixes: CVE-2026-93834
> 
> Cannot find it... embargoed ?
> 
> > Reported-by: Milad Nasr <https://gitlab.com/sirkhezr>
> > Suggested-by: Milad Nasr <https://gitlab.com/sirkhezr>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4491
> 
> Cannot find that either...

Initially confidential, so only visible to maintainers with acccounts
added to the gitlab project. Bugs should be made public when their
patch is posted for review, so I've turned off the confidential flag
now.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


