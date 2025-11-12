Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BF2CD484C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 21:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJIqw-0000rM-SG; Wed, 12 Nov 2025 16:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJIV8-0007IF-1m
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 16:35:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJIV3-0007Ve-IQ
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 16:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762983327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTSehRErhLMOA9MoDWbzfcAnJKtIJf9Vjb2V1RgZ6sQ=;
 b=XPZjUEm0yDr1Jzj8AZ1rbM1dTIOYwDFhM6wG3c3JmFjGvD3dVm6aoqTbZN0UoCHwryF/MU
 BslDwLQ0YkbtekbdFNqBBMtrPTLm2+yNCHHaZXiG+/TAKPBg7e2P47ZK7kpT12dy6ns7ty
 c4Q26rzODFo5J3gUSxrMg8RuEgNBOQI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99--yE39p9YMNatoqIER4UkKw-1; Wed,
 12 Nov 2025 16:35:26 -0500
X-MC-Unique: -yE39p9YMNatoqIER4UkKw-1
X-Mimecast-MFC-AGG-ID: -yE39p9YMNatoqIER4UkKw_1762983325
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D79DB18001D1; Wed, 12 Nov 2025 21:35:24 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE7E2180049F; Wed, 12 Nov 2025 21:35:22 +0000 (UTC)
Date: Wed, 12 Nov 2025 15:35:19 -0600
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] tests/qemu-iotest: fix iotest 024 with qed images
Message-ID: <w34rha4veeu7tfa35f45zcjc7w3xkjoidqxnjmpcuda3hkrd2l@5zrw42autilu>
References: <20251112170959.700840-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112170959.700840-1-berto@igalia.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 12, 2025 at 06:09:57PM +0100, Alberto Garcia wrote:
> Use 'qemu-io -c map' instead of 'qemu-img map' to get an output that
> works with both image types.
> 
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Fixes: 909852ba6b4a ("qemu-img rebase: don't exceed IO_BUF_SIZE in one operation")
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/024     | 2 +-
>  tests/qemu-iotests/024.out | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


