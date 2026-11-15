Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A8606A329
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+DpAJt9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSjxL-00064Z-Ix; Sun, 15 Nov 2026 18:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1xSjxH-00063r-89; Sun, 15 Nov 2026 18:48:15 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1xSjxE-0000tS-QZ; Sun, 15 Nov 2026 18:48:14 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 809FE6133E;
 Sun, 15 Nov 2026 23:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6321F000C4;
 Sun, 15 Nov 2026 23:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794786491;
 bh=7jwUo6SMm+qz7yHzkjSMzKGTJOOKV5bPyelRDmrvzFc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=e+DpAJt9lzWm06ySb8A1K3J6yjqbEI5Gd1/qedeOcqku9MSS4vcz/u/PRa3avXax9
 lUYpgtNtjK7w+W0o/Gjiu4Q+dlNeMnQ2NLPSa2GnazFse32vy5uaoxApNReEye9VwM
 Dmvc0fy8dVp9l/pw6MZs/xRpYLeIH+Ao62uOzXV+UW+Y9wBgqvIly27UABKzwvtj07
 Pf9FOcdTNKCZqW6rNPa32N9aN+cOns/WNox+YA8iotfAl/Yy5LULMTEWwf82/vqQ1H
 QI05xf6/aNEkUKYmlAaI7n+S9lK7wrur133aZkuWdBDAhE2TT2PJpEMcJ9cXvoDThz
 WqmF7P3WvOzpA==
Message-ID: <dd625bf6-977a-42f1-9789-730f2708919b@kernel.org>
Date: Sun, 15 Nov 2026 15:48:08 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 7/9] virtio-blk: report zone errors with their zone
 status codes
To: Niklas Cassel <cassel@kernel.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
References: <20261112114918.1269168-1-cassel@kernel.org>
 <20261112114918.1269168-8-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261112114918.1269168-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=dlemoal@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 03:49, Niklas Cassel wrote:
> virtio-blk completes a failed write with VIRTIO_BLK_S_IOERR, and a
> failed zone append or zone management request with
> VIRTIO_BLK_S_ZONE_INVALID_CMD. It never reports the zone status codes
> that virtio 1.4 (5.2.6.2) requires for a write off the write pointer
> or for a request that exceeds a zone resource limit.
> 
> When VIRTIO_BLK_F_ZONED is negotiated, map the zone errors of the block
> layer to them:
> 
>   BLK_ZE_UNALIGNED_WRITE  VIRTIO_BLK_S_ZONE_UNALIGNED_WP
>   BLK_ZE_BOUNDARY         VIRTIO_BLK_S_ZONE_INVALID_CMD
>   BLK_ZE_OPEN_RESOURCE    VIRTIO_BLK_S_ZONE_OPEN_RESOURCE
>   BLK_ZE_ACTIVE_RESOURCE  VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE
>   BLK_ZE_FULL             VIRTIO_BLK_S_ZONE_INVALID_CMD
> 
> Other errors keep their status code. A FINISH that exceeds a zone
> resource limit also gets a zone resource status code, which 5.2.6
> defines for any zone operation. Zone errors of writes are reported
> regardless of the rerror/werror policy, as they are the deterministic
> result of the request.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

