Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37825CD128D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 15:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrJbH-0001Ix-7E; Mon, 01 Apr 2024 11:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuba@kernel.org>) id 1rrJTE-0008Nf-BI
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:21:12 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuba@kernel.org>) id 1rrJTC-0001rm-Gm
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 11:21:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C654F60B65;
 Mon,  1 Apr 2024 15:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED925C433F1;
 Mon,  1 Apr 2024 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711984860;
 bh=ZBiBE3qZkHMm5Z23/govMm0X9TLV1iM7mEWgmk1P+oU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fg5ZiGTnwlWG59PKdduv+jm4pSBi8QM4G2Ox8yiViz/oWewJH5UFDzxvoxjcsmEYD
 pfUV3qkXIQW2Wgmb4vUz4L9E+SbduzgENEqefxfLzhRiTFXMsVSvYVmHsECK8jm3td
 nY5Ot3wf05bG59/VOI8568Rk3RPD309vB8RcTtEBhMJIwYdmbvwUnZUqQP/96ojCOz
 xi+zHt9sEuuwr8ZT/uTO/xh5J+84+71XEjmwhf7pVtxkPqMZIzFijlgVFLfyJ5TVyR
 JZHNlktj75gRwnYciOqFeq6WvxOkHX3cHX6TxpAtDTl+Hl1C6I/MWyx8hb302+tmqf
 spggwy8/Rj3MQ==
Date: Mon, 1 Apr 2024 08:20:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, hengqi@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, Jason Wang <jasowang@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
 qemu-devel@nongnu.org, "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux.dev>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <20240401082059.77df2ff0@kernel.org>
In-Reply-To: <20240331160618-mutt-send-email-mst@kernel.org>
References: <20240329171641.366520-1-leitao@debian.org>
 <20240331160618-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=kuba@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Apr 2024 11:29:29 -0400
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

On Sun, 31 Mar 2024 16:20:30 -0400 Michael S. Tsirkin wrote:
> > Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> > Cc: stable@vger.kernel.org  
> 
> net has its own stable process, don't CC stable on net patches.

Not any more, FWIW:

  1.5.7. Stable tree

  While it used to be the case that netdev submissions were not
  supposed to carry explicit CC: stable@vger.kernel.org tags that is no
  longer the case today. Please follow the standard stable rules in
  Documentation/process/stable-kernel-rules.rst, and make sure you
  include appropriate Fixes tags!

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#stable-tree

