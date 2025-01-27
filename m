Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E0FC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQe7-0005Ho-9J; Mon, 27 Jan 2025 10:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tcQdx-0005DM-KQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:03:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tcQdv-0000MT-B9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737990192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjUC0lh4lW8oacLiMc3Ity9vakxsKwgKmhp2R5NIb4w=;
 b=XtYa9pCMiCSnw5qTWVEEKk0HoF/Bybt9A5HaSTiKZwPi7lv+EigEW3RToZkJ7acLr+XSWQ
 bZqGeD6rIVGahXeOFQ4VPwft3Ff8QDKGxQ/Zu8hQUHnRwW45citVTSR3eBYJDBoZ9CbzrB
 lIpt3ArWmylzSsNc9OB68BkS2xrZdwg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-p58Qrp8_O_GIBxMeWhp8Ig-1; Mon,
 27 Jan 2025 10:03:11 -0500
X-MC-Unique: p58Qrp8_O_GIBxMeWhp8Ig-1
X-Mimecast-MFC-AGG-ID: p58Qrp8_O_GIBxMeWhp8Ig
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09A861800A0D; Mon, 27 Jan 2025 15:03:09 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.225])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42CF519560AD; Mon, 27 Jan 2025 15:03:07 +0000 (UTC)
Date: Mon, 27 Jan 2025 16:03:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] block-backend: Fix argument order when calling
 'qapi_event_send_block_io_error()'
Message-ID: <Z5egKZ6AAXomuRZe@redhat.com>
References: <09728d784888b38d7a8f09ee5e9e9c542c875e1e.1737973614.git.pkrempa@redhat.com>
 <Z5dlnHdG_mWS5InU@redhat.com> <Z5do3aP6rGbXV_Mw@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5do3aP6rGbXV_Mw@angien.pipo.sk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 27.01.2025 um 12:07 hat Peter Krempa geschrieben:
> On Mon, Jan 27, 2025 at 10:53:16 +0000, Daniel P. Berrangé wrote:
> > On Mon, Jan 27, 2025 at 11:29:24AM +0100, Peter Krempa wrote:
> > > Commit 7452162adec25c10 introduced 'qom-path' argument to BLOCK_IO_ERROR
> > > event but when the event is instantiated in 'send_qmp_error_event()' the
> > > arguments for 'device' and 'qom_path' in
> > > qapi_event_send_block_io_error() were reversed :
> > > 
> > > Generated code for sending event:
> > > 
> > >   void qapi_event_send_block_io_error(const char *qom_path,
> > >                                       const char *device,
> > >                                       const char *node_name,
> > >                                       IoOperationType operation,
> > >                                       [...]
> > > 
> > > Call inside send_qmp_error_event():
> > > 
> > >      qapi_event_send_block_io_error(blk_name(blk),
> > >                                     blk_get_attached_dev_path(blk),
> > >                                     bs ? bdrv_get_node_name(bs) : NULL, optype,
> > >                                     [...]
> > > 
> > > This results into reporting the QOM path as the device alias and vice
> > > versa which in turn breaks libvirt, which expects the device alias being
> > > either a valid alias or empty (which would make libvirt do the lookup by
> > > node-name instead).
> > > 
> > > Fixes: 7452162adec25c1003d5bf0079aca52913a80e0c
> > > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> > 
> > Hmm, luckily that was only introduced in 9.2.0, so we can probably just
> > fix it in stable, and not worry about libvirt needs to add back compat
> > to workaround the initially broken 9.2.0 release events.
> 
> Indeed, there's no need for a specific libvirt workaround. Although I
> still plan to modify the libvirt code to prefer node-name if present due
> to other reasons (to have the correct path of the image if the error
> happened in a backing image), which will also workaround this issue in
> the end.

Currently, QEMU always puts the node name of the root node there, so for
now you won't see backing file nodes in these events. But it's probably
a good idea to prepare libvirt for it anyway, maybe we can find a way to
have better error events later. The challenge in doing that is that the
error events are sent by the devices, not by the block node that
actually first encountered the error.

Kevin


