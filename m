Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8CF606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgEJLJ5S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSjy0-0006Uc-Jy; Sun, 15 Nov 2026 18:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1xSjxt-0006TT-Sa; Sun, 15 Nov 2026 18:48:54 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1xSjxs-0002ek-90; Sun, 15 Nov 2026 18:48:53 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2785416BD;
 Sun, 15 Nov 2026 23:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99531F000C4;
 Sun, 15 Nov 2026 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794786530;
 bh=yXmnkhhCAx1XdFvw4w4lZjMZPlQ1eGS5MC7nyRNcLl0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OgEJLJ5S11yf7u3ZLcOVUOJnOQxuCcIsyCsdtJ7qT7I9Z+Qd+4h51p/YshDO/lq1h
 2RUkwEaca81J9uVDJiY9VzylQbVZLEv6TpN2IZdfICgAJc9TyHbPtNaFipNJxO1ThI
 EtRt0X9EfY07oB/cHzzVoKHrMB4W9Lb91fuBTBp9M91CU5TVLcHLIW2Uxql8JFDZv8
 xkTTKRU7wZxMkUiNhjT5VVPrF5FZ0P1xAC+6gcYFJ0QyaiS2NSlRQzGp67AQSPBfQN
 +Z3Lub4ir14JZMrrkVB1Q30WJ/iyuNPyHYbXaPmz2fc51rmbr4l+SlWydABKTORPB0
 XF71aoJPdMDpw==
Message-ID: <de26df08-ddb7-4b0f-8218-cc08a87d635a@kernel.org>
Date: Sun, 15 Nov 2026 15:48:47 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 8/9] block: add accessors for the zone model, capacity
 and open zone limit
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
 <20261112114918.1269168-9-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261112114918.1269168-9-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=dlemoal@kernel.org;
 helo=sea.source.kernel.org
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
> Add the block-backend accessors blk_get_zone_model(),
> blk_get_zone_capacity() and blk_get_max_open_zones(), which report the
> zoned model, the zone capacity and the maximum number of open zones of
> the backing device, mirroring the existing blk_get_zone_size(). This
> lets device models query the zoned geometry without dereferencing
> BlockDriverState internals.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

