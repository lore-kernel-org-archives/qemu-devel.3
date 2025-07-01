Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49CEC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdIT-0003Ey-BM; Tue, 01 Jul 2025 11:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWdIR-0003Cm-Ej
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWdIP-00039t-55
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751385199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QXwFjRIHs0pUvwU7CzS2qXsyJk4zCyLuvRLWkWxqIw=;
 b=FCKaEo12b+Gq2YO6VByIep2TTxfE70rzUJJJapZPictji0IIRgfvnR19NW0f1U5Kga6ACm
 FjgCq5/Ox2/y8Mxr0wP67AFcj9OakeFC/Jm2sHv48kxeS6BxQhx9D9EMLlYXg3mWG1R/io
 sxdt70AAWj2AcmYBcq/sW+50dEbt4MY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-8dFdZcrZPzO_YEYiDvduzg-1; Tue,
 01 Jul 2025 11:53:16 -0400
X-MC-Unique: 8dFdZcrZPzO_YEYiDvduzg-1
X-Mimecast-MFC-AGG-ID: 8dFdZcrZPzO_YEYiDvduzg_1751385195
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CB1F19560AE; Tue,  1 Jul 2025 15:53:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.118])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE7121944CE7; Tue,  1 Jul 2025 15:53:12 +0000 (UTC)
Date: Tue, 1 Jul 2025 17:53:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH] block: include 'file' child node name in block device info
Message-ID: <aGQEZiOSyQLMMEW7@redhat.com>
References: <20250630141421.1558724-1-f.ebner@proxmox.com>
 <81cb7080-cf5e-4049-82f8-e009aac93cdc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81cb7080-cf5e-4049-82f8-e009aac93cdc@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 01.07.2025 um 15:04 hat Hanna Czenczek geschrieben:
> On 30.06.25 16:06, Fiona Ebner wrote:
> > In combination with using a throttle filter to enforce IO limits for
> > a guest device, knowing the 'file' child of a block device can be
> > useful. If the throttle filter is only intended for guest IO, block
> > jobs should not also be limited by the throttle filter, so the
> > block operations need to be done with the 'file' child of the top
> > throttle node as the target. In combination with mirroring, the name
> > of that child is not fixed.
> > 
> > Another scenario is when unplugging a guest device after mirroring
> > below a top throttle node, where the mirror target is added explicitly
> > via blockdev-add. After mirroring, the target becomes the new 'file'
> > child of the throttle node. For unplugging, both the top throttle node
> > and the mirror target need to be deleted, because only implicitly
> > added child nodes are deleted automatically, and the current 'file'
> > child of the throttle node was explicitly added (as the mirror
> > target).
> 
> Why not return a map of all children?

I had the same thought, just didn't get around to actually replying. I
think "a map" in this context will be a list of objects, like this:

    "children": [
        { "child": "file", "node-name": "foo" },
        { "child": "backing", "node-name": "bar" }
    ]

Which as a side effect automatically gives us extensibility if we ever
want to expose more details of BdrvChild.

Kevin


