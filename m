Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFC8C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojEx-0007x8-7a; Tue, 28 Jul 2026 10:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wojEv-0007vi-DL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wojEt-0003tm-TK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785250622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wkkWRTTQ/DTzQqnCISaBF+YJM9i5iGdp1nyZ4oXKZns=;
 b=GdXQ7rnnlhWga5sQAmWfyG0O8rUXx6+jHvGoxoD2985dpfcroOd/hu1dwO4dlWxGPW+y0K
 FsCgiWlcT+2qCLvT+eUg4iq0AQrvvSPVueYtC4su+tqw9Pq/kdroLxg5JO2Xy4IDFnQx/g
 jR3x1EMeBYUKFQlftIr5r1vPzZnUPwQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-r2HOhhItMtiXNLXPMTZoVw-1; Tue,
 28 Jul 2026 10:56:59 -0400
X-MC-Unique: r2HOhhItMtiXNLXPMTZoVw-1
X-Mimecast-MFC-AGG-ID: r2HOhhItMtiXNLXPMTZoVw_1785250618
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9D611800350; Tue, 28 Jul 2026 14:56:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C908B180044F; Tue, 28 Jul 2026 14:56:55 +0000 (UTC)
Date: Tue, 28 Jul 2026 16:56:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 0/2] block/export/fuse: fix regression with O_TRUNC when
 export is not growable
Message-ID: <amjDNVXdEuD-cgsp@redhat.com>
References: <20260702132256.661429-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702132256.661429-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 02.07.2026 um 15:22 hat Fiona Ebner geschrieben:
> Before commit a94a1d7699 ("fuse: Manually process requests (without
> libfuse)"), the O_TRUNC flag when open()-ing an export would be
> ignored. This is because libfuse sets FUSE_CAP_ATOMIC_O_TRUNC, so the
> kernel lets user space handle the O_TRUNC flag, which is ignored by
> the fuse code for export. After the commit, FUSE_CAP_ATOMIC_O_TRUNC is
> not set anymore, so the O_TRUNC flag is handled by the kernel, which
> executes a truncate.
> 
> For blockdev-based exports, this causes a regression, because opening
> with O_TRUNC would previously work, but results in an ENOTSUP after
> commit a94a1d7699. For file-based exports, the fact that truncate is
> executed can be considered an improvement in general. However, in
> combination with growable=off, this still results in a practical
> regression in combination with virt-fw-vars, which opens its output
> file with O_TRUNC and previously worked with a file-based export with
> growable=off. After commit a94a1d7699, the file is truncated upon open
> and then cannot grow, meaning virt-fw-vars won't be able to write the
> output.
> 
> To fix these regressions, while keeping the improved behavior for
> file-based exports with growable=on, set the FUSE_CAP_ATOMIC_O_TRUNC
> flag again if growable=off.

Thanks, applied to the block branch.

Kevin


