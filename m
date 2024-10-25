Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571BCD149C7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4NS3-0002pq-53; Fri, 25 Oct 2024 12:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1t4NS1-0002pH-D9; Fri, 25 Oct 2024 12:46:13 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1t4NRz-0001Wx-K7; Fri, 25 Oct 2024 12:46:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B8DFEA42EE5;
 Fri, 25 Oct 2024 16:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E298C4CEC3;
 Fri, 25 Oct 2024 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729874758;
 bh=U906ien2EMPmTWatB2bu+wjqopVQdTO+Rt2YDztEHG4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kj2wgO9Mas/izDU7bVaTQkXB8NZcxYznD1bKKETKxHp85qB8MDcRopO88FooCxU4d
 xoVlmy4AGAx5oyKZiY22AxwbuC3iOKpYi+Hr41QmCNOkUGNU44xEylkQ4NW5RUn0Ka
 p7uJhEC9FzxNKBLoN1I7aWolMzC8P9tAYhFU0wSrBXyqsVVjVvvPyiR6EXOm6LVqJr
 IhPK/87p4zEYIARCCF7da4Dg6TLGLPMHTppngkL5LP+NWJ0c5ZeMzU7bShk1w2CW76
 RVrmi6vWKhwllhZ7yF9HuudpuvoVP2aw9Pn/19xq3tvTxTzkERUyc7s6Qll970eCqg
 DRdyZeBdXm4dw==
Date: Fri, 25 Oct 2024 10:45:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Subject: Re: [PATCH] hw/nvme: fix handling of over-committed queues
Message-ID: <ZxvLQ5rSQtDAfE-H@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025-issue-2388-v1-1-16707e0d3342@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-issue-2388-v1-1-16707e0d3342@samsung.com>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=kbusch@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Oct 25, 2024 at 12:50:45PM +0200, Klaus Jensen wrote:
> @@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)
>          nvme_inc_cq_tail(cq);
>          nvme_sg_unmap(&req->sg);
> +
> +        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
> +            qemu_bh_schedule(sq->bh);
> +        }
> +
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }

Shouldn't we schedule the bottom half after the req has been added to
the list? I think everything the callback needs to be written prior to
calling qemu_bh_schedule().

