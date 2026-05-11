Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69BECD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMO83-0007s5-LN; Mon, 11 May 2026 06:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMO7s-0007eQ-Lh
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMO7p-00023C-VL
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778496276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRO0/xXovozy2bJyUzcw0BF4BzhTiebwxW9tvP7m+kw=;
 b=RcPcSkwV9yQxvcqkHTS6ni9Tr0wTyBnoUxtMqhRjZEql6hcg6KSbx8/js7MKT1hZW2LxMh
 Iq03Tg8zfwabd/HvW40/v6V2THWx7AkGi8ZWs9SgMAzkzHOdxzakysa3xFoH/DuPnRG2om
 tnk+l+pbH61VTuQQ3GeLQGZbVX/gOx4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-ObdGKsgROIWy_kI2y5OVNw-1; Mon,
 11 May 2026 06:44:34 -0400
X-MC-Unique: ObdGKsgROIWy_kI2y5OVNw-1
X-Mimecast-MFC-AGG-ID: ObdGKsgROIWy_kI2y5OVNw_1778496273
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E29D7195608B; Mon, 11 May 2026 10:44:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A06D18004A3; Mon, 11 May 2026 10:44:29 +0000 (UTC)
Date: Mon, 11 May 2026 11:44:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Xie Yongji <xieyongji@bytedance.com>,
 qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 DARKNAVY <vr@darknavy.com>
Subject: Re: [PATCH 2/2] libvduse: fix buffer overflow in
 vduse_queue_read_indirect_desc()
Message-ID: <agGzCQ64ed1-Qwwt@redhat.com>
References: <20260417132645.121192-1-sgarzare@redhat.com>
 <20260417132645.121192-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417132645.121192-3-sgarzare@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 17, 2026 at 03:26:45PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> vduse_queue_read_indirect_desc() copies an indirect descriptor table
> into a buffer in chunks when the table crosses a memory region
> boundary. The destination is a struct vring_desc pointer but is
> advanced by a byte count, so each increment moves the pointer by
> read_len elements instead of read_len bytes, writing beyond the
> buffer.
> 
> Use a char pointer for the destination so that the arithmetic
> advances correctly.
> 
> While at it, change the source from a struct vring_desc pointer
> to a void pointer: when the table is split across regions,
> iova_to_va() can return a pointer into the middle of a descriptor,
> so casting it to a struct vring_desc pointer is wrong. The pointer is
> only used as a memcpy() source, so a void pointer is fine.
> 
> Fixes: CVE-2026-6425
> Fixes: a6caeee811 ("libvduse: Add VDUSE (vDPA Device in Userspace) library")
> Cc: qemu-stable@nongnu.org
> Reported-by: DARKNAVY <vr@darknavy.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  subprojects/libvduse/libvduse.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


