Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B0DC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 10:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFWUQ-0005CS-BL; Fri, 07 Jun 2024 06:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sFWUO-00057j-2Z
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sFWUK-0005SE-VY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717754783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0qoF5eokai1U462oX+PLiCyv4OC138X8qnNLFwoJ0KY=;
 b=TVIsevVgiJIXIh8uw1QRRbJA07kU1iQKWEQ1utY1VqUMgThPUJpQlaQXDjcTzRQ+Gv0PLU
 ZhIlhu9d6Jfa6v8aV6iz90ydwuMIQSu9lD2PBjRR1iQjq9ZCnCfT+vW0OXYjhuaSDIwbVw
 +zit+Ld+/o9ss+7BmsBosjsZKsUT69k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-rI0eGe8hNGizsUkGK8vZcg-1; Fri, 07 Jun 2024 06:06:20 -0400
X-MC-Unique: rI0eGe8hNGizsUkGK8vZcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DD40185A780;
 Fri,  7 Jun 2024 10:06:19 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1EFE1C1CFA2;
 Fri,  7 Jun 2024 10:06:14 +0000 (UTC)
Date: Fri, 7 Jun 2024 11:06:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org,
 yu.zhang@ionos.com, mgalaxy@akamai.com, elmar.gerdes@ionos.com,
 zhengchuan@huawei.com, armbru@redhat.com, lizhijian@fujitsu.com,
 pbonzini@redhat.com, mst@redhat.com, xiexiangyou@huawei.com,
 linux-rdma@vger.kernel.org, lixiao91@huawei.com,
 jinpu.wang@ionos.com, Jialin Wang <wangjialin23@huawei.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <ZmLbkz9DrH4AzJIo@redhat.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zl9rw3Q9Z9A0iMYV@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zl9rw3Q9Z9A0iMYV@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 04, 2024 at 03:32:19PM -0400, Peter Xu wrote:
> Hi, Lei, Jialin,
> 
> Thanks a lot for working on this!
> 
> I think we'll need to wait a bit on feedbacks from Jinpu and his team on
> RDMA side, also Daniel for iochannels.  Also, please remember to copy
> Fabiano Rosas in any relevant future posts.  We'd also like to know whether
> he has any comments too.  I have him copied in this reply.

I've not formally reviewed it, but I had a quick glance through the
I/O channel patches and they all look sensible. Pretty much  exactly
what I was hoping it would end up looking like.

> > In addition, the use of rsocket makes our programming more convenient,
> > but it must be noted that this method introduces multiple memory copies,
> > which can be imagined that there will be a certain performance degradation,
> > hoping that friends with RDMA network cards can help verify, thank you!
> 
> It'll be good to elaborate if you tested it in-house. What people should
> expect on the numbers exactly?  Is that okay from Huawei's POV?
> 
> Besides that, the code looks pretty good at a first glance to me.  Before

snip

> Personally I think even with the thread proposal it's better than the old
> rdma code, but I just still want to double check with you guys.  E.g.,
> maybe that just won't work at all?  Again, that'll also be based on the
> fact that we move migration incoming into a thread first to keep the dest
> QEMU main loop intact, I think, but I hope we will reach that irrelevant of
> rdma, IOW it'll be nice to happen even earlier if possible.

Yes, from the migration code POV, this is a massive step forward - the
RDMA integration is no completely trivial for migration code.

The $million question is what the performance of this new implmentation
looks like on real hardware. As mentioned above the extra memory copies
will probably hurt performance compared to the old version. We need the
performance of the new RDMA impl to still be better than the plain TCP
sockets backend to make it worthwhile having RDMA.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


