Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7F4C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treJA-0004ze-Tp; Mon, 10 Mar 2025 10:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1treJ9-0004zJ-2B
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1treJ6-0002Gd-Gy
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741617637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SWAZuKA4AAIqHX90wZfxoV6sqAJnQIa00a8T5CG96o=;
 b=Wj2GMB+pugPAjx6Jx9n48ZMMYQAuuRlvONWNkwWDmM4kGmo6HfgsFVbaoHOXGWsDtV8qeK
 m4gvwb3aFC54rugTrFT32LD/dE4SKfRVPpYPQwOJ7zahV4gX0Rr4LmaTCyTBnbx7tlXPan
 wxxKBSc4WizM7bmj3dsB7QQfb9zUakQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-_7z_7YcLMKWiE5zgg-wGXA-1; Mon,
 10 Mar 2025 10:40:36 -0400
X-MC-Unique: _7z_7YcLMKWiE5zgg-wGXA-1
X-Mimecast-MFC-AGG-ID: _7z_7YcLMKWiE5zgg-wGXA_1741617635
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAC0619560B2; Mon, 10 Mar 2025 14:40:34 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.224.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2390919560AB; Mon, 10 Mar 2025 14:40:28 +0000 (UTC)
Date: Mon, 10 Mar 2025 15:37:44 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 11/12] virtio-scsi: add iothread-vq-mapping parameter
Message-ID: <Z8744QIGJUEykuDd@angien.pipo.sk>
References: <20250213180043.713434-1-stefanha@redhat.com>
 <20250213180043.713434-12-stefanha@redhat.com>
 <Z874HlqTKgI5aiBW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z874HlqTKgI5aiBW@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 10, 2025 at 15:33:02 +0100, Kevin Wolf wrote:
> Am 13.02.2025 um 19:00 hat Stefan Hajnoczi geschrieben:
> > Allow virtio-scsi virtqueues to be assigned to different IOThreads. This
> > makes it possible to take advantage of host multi-queue block layer
> > scalability by assigning virtqueues that have affinity with vCPUs to
> > different IOThreads that have affinity with host CPUs. The same feature
> > was introduced for virtio-blk in the past:
> > https://developers.redhat.com/articles/2024/09/05/scaling-virtio-blk-disk-io-iothread-virtqueue-mapping
> > 
> > Here are fio randread 4k iodepth=64 results from a 4 vCPU guest with an
> > Intel P4800X SSD:
> > iothreads IOPS
> > ------------------------------
> > 1         189576
> > 2         312698
> > 4         346744
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> As Peter already noted, the interface is a bit confusing in that it
> considers the control and event queue just normal queues like any other
> and you need to specify a mapping for them, too (even though you
> probably don't care about them).
> 
> I wonder if it wouldn't be better to use the iothread-vq-mapping
> property only for command queues and to have separate properties for the
> event and control queue. I think this would be less surprising to users.

In the v2 of libvirt's patches I've proposed:

        <driver queues='3'>
          <iothreads>
            <iothread id='2'>
              <queue id='ctrl'/>
              <queue id='event'/>
              <queue id='1'/>
            </iothread>
            <iothread id='3'>
              <queue id='0'/>
              <queue id='2'/>
            </iothread>
          </iothreads>
        </driver>

To map the queues by name explicitly so that it's clear what's
happening.

In my proposed it auto-translates ctrl and event into 0 and 1 and the
command queues into N+2.

> It would also allow you to use the round robin allocation for command
> queues while using a different setting for the special queues - in
> particular, the event queue is currently no_poll, which disables polling
> for the whole AioContext, so you probably want to have it just anywhere
> else, but not in the iothreads you use for command queues. This should
> probably also be the default.

This sounds like an important bit of information. If that stays like
this I think libvirt should also document this.

The proposed libvirt patch also words the recommendation to use the
round-robin approach unless specific needs arise so if qemu did the
correct thing here it would be great.


