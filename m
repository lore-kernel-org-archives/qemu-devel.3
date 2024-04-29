Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64210C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OoB-0004rr-2L; Mon, 29 Apr 2024 07:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1s1Oo3-0004pK-NB
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:04:24 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1s1Onv-0007sG-6e
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:04:18 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9E508CE0B08;
 Mon, 29 Apr 2024 11:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62B7C113CD;
 Mon, 29 Apr 2024 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1714388646;
 bh=dDZJAokPlyONfexGRVyPKTvl3211jYrI0Yo63JDuVng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zVjs+rUUwlAowsvyfotajioUzGuQjJ1x+vDst0SWfPtkT743FKpbTB1f3KG38CH8D
 +VydJU1w2HE2f9H3FxZxeFxSVK1vtyMwxP0IbLExB9CH9AUngCLJSyvJabSBvkOsza
 26qu+YoKtHKLvpsoxbK32JwSYcwIcJjUUQCM19HY=
Date: Mon, 29 Apr 2024 13:04:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Konstantin Ovsepian <ovs@ovs.to>
Cc: stable@vger.kernel.org, davem@davemloft.net, hengqi@linux.alibaba.com,
 leitao@debian.org, xuanzhuo@linux.alibaba.com, ovs@meta.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 6.1.y] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <2024042953-husked-nurture-4641@gregkh>
References: <2024041414-humming-alarm-eb41@gregkh>
 <20240424105704.182708-1-ovs@ovs.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424105704.182708-1-ovs@ovs.to>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=gregkh@linuxfoundation.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 24, 2024 at 03:57:04AM -0700, Konstantin Ovsepian wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47 upstream
> 
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
> 
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
> 
>     # ethtool -X eth0  hfunc toeplitz
> 
> This is how the problem happens:
> 
> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
> 
> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
> 
> 3) virtnet_commit_rss_command() populates 4 entries for the rss
> scatter-gather
> 
> 4) Since the command above does not have a key, then the last
> scatter-gatter entry will be zeroed, since rss_key_size == 0.
> sg_buf_size = vi->rss_key_size;
> 
> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
> with zero length, and do the following in virtqueue_map_desc() (QEMU
> function):
> 
>   if (!sz) {
>       virtio_error(vdev, "virtio: zero sized buffers are not allowed");
> 
> 6) virtio_error() (also QEMU function) set the device as broken
> 
>     vdev->broken = true;
> 
> 7) Qemu bails out, and do not repond this crazy kernel.
> 
> 8) The kernel is waiting for the response to come back (function
> virtnet_send_command())
> 
> 9) The kernel is waiting doing the following :
> 
>       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> 	     !virtqueue_is_broken(vi->cvq))
> 	      cpu_relax();
> 
> 10) None of the following functions above is true, thus, the kernel
> loops here forever. Keeping in mind that virtqueue_is_broken() does
> not look at the qemu `vdev->broken`, so, it never realizes that the
> vitio is broken at QEMU side.
> 
> Fix it by not sending RSS commands if the feature is not available in
> the device.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Cc: stable@vger.kernel.org
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> (cherry picked from commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47)
> Signed-off-by: Konstantin Ovsepian <ovs@ovs.to>
> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Now queued up,t hanks.

greg k-h

