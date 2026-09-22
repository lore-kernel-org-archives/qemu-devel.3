Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1BAC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x92LE-0003Ga-VV; Tue, 22 Sep 2026 11:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x92LD-0003G7-PI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 11:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x92LB-00027u-VQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 11:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790090609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQSiN/D/xbu+dbj6bOeUxMnWlllxhtIIptLUwWlFaqY=;
 b=W+dAIT4QMg3XNq4tEps5tKLNsM54ugZevfr+h+GUM8NM+EweVUxtFvXxh6bqD1DFnmkERQ
 L/Z8p/UuQtpEor005pPgGQ4GaHw18LExotKaEDoMnHHGtW8AmMoCd+h0c5WoOhO05C3r+Z
 65xEVdRCgCIWMsHFu7e4RFm9CB4gIIE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-jzJmo9aKNCKb5HvP9KQ1LQ-1; Tue,
 22 Sep 2026 11:23:24 -0400
X-MC-Unique: jzJmo9aKNCKb5HvP9KQ1LQ-1
X-Mimecast-MFC-AGG-ID: jzJmo9aKNCKb5HvP9KQ1LQ_1790090603
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F86B19792D1; Tue, 22 Sep 2026 15:23:23 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.148])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 800EE180034C; Tue, 22 Sep 2026 15:23:21 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:23:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [PATCH] block: fix bdrv_next() skipping monitor-owned nodes
Message-ID: <arKdZsLZE6oXkpeg@redhat.com>
References: <20260828222005.2888213-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828222005.2888213-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 29.08.2026 um 00:20 hat Denis V. Lunev geschrieben:
> From: Denis V. Lunev <den@openvz.org>
> 
> it->bs is the cursor into monitor_bdrv_states for the second phase of
> bdrv_next(), so it has to be NULL when that phase starts. Commit
> f6d38c9f6d made the first phase store the node it returns there, to
> unreference the right one when the graph changes underneath. The cursor
> is now left pointing at the last BlockBackend root, so the second phase
> resumes from there instead of from the head of the list and never
> returns a node added before it.
> 
> A skipped node drops out of the vm_stop and migration handover paths:
> not flushed, not inactivated, not snapshotted. bdrv_inactivate_all()
> still reports success, so the node keeps its image lock and the
> migration target cannot open the image. Only detached nodes are hit in
> practice, as these callers also recurse into children.
> 
> Reset the cursor when the second phase starts. old_bs is taken at the
> top of the function, so f6d38c9f6d keeps working.
> 
> Fixes: f6d38c9f6d ("block-backend: fix edge case in bdrv_next() where BDS associated to BB changes")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Fiona Ebner <f.ebner@proxmox.com>
> Cc: Kevin Wolf <kwolf@redhat.com>

Thanks, applied to the block branch.

Kevin


