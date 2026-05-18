Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBE1CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOtDQ-0003Ff-QW; Mon, 18 May 2026 04:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wOtDN-0003F8-LA
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wOtDL-0004MP-H2
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779092437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2wixNXvBjVdKlMysFfA4PoWuMSl9Cmj5gJgPVScZPRo=;
 b=aI5J6CTUkvF1IHT6eGjH8Z1h1NxNgR1C6fliphN56RkfsBXPgeCVMdceZyWz6wP3cbEP8o
 tQEpK7qvWj95pQlFjhZprLfsZLsIOjMPvPJE/cpMoHua8RkCu1TI6BGYBRC0XKeNfGQ3HI
 cDUgnSYJCnrH6AfdJzaTD9YitSk7aFE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-MJW12RR4NWe3JtXo68AiCg-1; Mon,
 18 May 2026 04:20:32 -0400
X-MC-Unique: MJW12RR4NWe3JtXo68AiCg-1
X-Mimecast-MFC-AGG-ID: MJW12RR4NWe3JtXo68AiCg_1779092432
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCBA419560AA; Mon, 18 May 2026 08:20:31 +0000 (UTC)
Received: from redhat.com (stefkas-mbp.str.redhat.com [10.33.192.245])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E2801800352; Mon, 18 May 2026 08:20:30 +0000 (UTC)
Date: Mon, 18 May 2026 10:20:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Subject: Re: QEMU Storage Daemon: production-quality and secure?
Message-ID: <agrLzMGkB7-fN5ws@redhat.com>
References: <22967882-230a-4ebe-b947-da2566d11e33@gmail.com>
 <87pl2tjkwn.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl2tjkwn.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 18.05.2026 um 08:23 hat Markus Armbruster geschrieben:
> Cc: qemu-block and maintainer.
> 
> Demi Marie Obenour <demiobenour@gmail.com> writes:
> 
> > When used as a vhost-user server, is the QEMU Storage Daemon suitable
> > for production use with untrusted guests and images?  Does it have
> > decent performance?

I think this is actually two questions:

Is qemu-storage-daemon production quality and secure? It is really just
a very thin wrapper around the components that QEMU itself uses. The
part that is distinct is basically just parsing the command line, after
that it's exactly the same as QEMU itself (well, exactly the same as a
subset of QEMU, obviously). So I wouldn't worry about that part.

The other question is about the performance of the vhost-user-blk
export. It's been a while since I benchmarked exports, but when I
did for my KVM Forum 2024 talk [1], performance wasn't bad, though it
looked like it wasn't quite perfect either: vdpa-blk (VDUSE) performed
slightly better, so if you can use that instead, it's worth a look.

Kevin

[1] https://gitlab.com/qemu-project/kvm-forum/-/raw/main/_attachments/2024/slides_out_of_process_storage_backends_hGZBfpS.pdf


