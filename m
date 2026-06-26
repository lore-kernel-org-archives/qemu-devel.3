Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD758C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6m4-00064B-Kd; Fri, 26 Jun 2026 09:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd6lv-00063L-RG; Fri, 26 Jun 2026 09:39:08 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd6lu-0008H4-CD; Fri, 26 Jun 2026 09:39:07 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD6C1600C8;
 Fri, 26 Jun 2026 13:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5248A1F000E9;
 Fri, 26 Jun 2026 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782481144;
 bh=IM0wyjgxirhlIUp9ukLrBcj+QOsI08JiFKa72GH7xdI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CVUDSNIq3WXHkt1xK5DYE4ZdomA7TsxaOAGb+3ABB0s+Wkl6lYKqK9DkNO7qCWnpK
 0+pyXPWBKNZpgm3FQtKkqkl87YB/JSQOXL63GHDros1cmZCt4kF4l5+5WmhFtsy6x0
 gExs9fV67SvcH3Wnh4cQyJDfc02EZi5WPifJFzkbHfYTX3M2uUdW8ahBfKPoxD6EaX
 MTYJ+sGpf1Nz0Y93M0lMLmg59EWVMRGv7T5OfOTrNJHqmT3myHi6m3rYUHsMZn3pUI
 axgGvYahdSqF94E+3NLTcXn4il/fjuQ5uwTtD70vxu29Iq2Y7nORV5g7EhKfOiElIQ
 NMXEPHlLI9L8g==
Date: Fri, 26 Jun 2026 15:38:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v13 4/6] virtio-blk: do not merge writes across a zone
 boundary
Message-ID: <aj6A86GgoeOePQGW@ryzen>
References: <20260626131555.459792-1-faithilikerun@gmail.com>
 <20260626131555.459792-5-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626131555.459792-5-faithilikerun@gmail.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 26, 2026 at 03:15:53PM +0200, Sam Li wrote:
> virtio_blk_submit_multireq() fuses adjacent in-zone requests into a
> single request. On a zoned backend, a merged zone append request
> that straddles a zone boundary is rejected by the device because
> each write must stay within a single zone.
> 
> Add a bail condition to the merge coalescer: if combining the
> candidate request into the current batch would cross a zone
> boundary, flush the current batch and start a new one.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

