Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E607ED15DBA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vPa-0000W9-0X; Mon, 21 Oct 2024 12:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2vPK-0000HN-8B
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2vPE-0006NZ-Uv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIUIkSVX+gU5mlKC88MEopmwsb83KYoFgO7E9RKZIRo=;
 b=cSkuHI7r913A9rUEU5OxQmKuFaPQqaSbJapjrLFTJzb7EtfkGizKBKKZzXoqDNo5lBE0ii
 h7mBBrZ33UI17xOLD3yEWjX9no+nTYJv3bqmlnK2NNvN3mXagxCMz2BTPQtDw4ylbPkW3J
 GQd0L/RQkeAdvnVrb5+pOwqBWkKOaRk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-ytNQ0cCCMzub-RYPOPkA8g-1; Mon,
 21 Oct 2024 12:37:18 -0400
X-MC-Unique: ytNQ0cCCMzub-RYPOPkA8g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7628B1956077; Mon, 21 Oct 2024 16:37:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3959619560A2; Mon, 21 Oct 2024 16:37:15 +0000 (UTC)
Date: Mon, 21 Oct 2024 17:37:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 5/5] guestperf: Introduce multifd compression option
Message-ID: <ZxaDN7m89N-YaA6r@redhat.com>
References: <cover.1729275266.git.yong.huang@smartx.com>
 <da2ae99301e701b1c6fff3e9df3ddfbf62d240f8.1729275266.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da2ae99301e701b1c6fff3e9df3ddfbf62d240f8.1729275266.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 19, 2024 at 02:25:07AM +0800, Hyman Huang wrote:
> Guestperf tool does not cover the multifd compression option
> currently, it is worth supporting so that developers can
> analysis the migration performance with different
> compression algorithms.
> 
> Multifd support 4 compression algorithms currently:
> zlib, zstd, qpl, uadk
> 
> To request that multifd with the specified compression
> algorithm such as zlib:
> $ ./scripts/migration/guestperf.py \
>     --multifd --multifd-channels 4 --multifd-compression zlib \
>     --output output.json
> 
> To run the entire standardized set of multifd compression
> comparisons, with unix migration:
> $ ./scripts/migration/guestperf-batch.py \
>     --dst-host localhost --transport unix \
>     --filter compr-multifd-compression* --output outputdir
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  scripts/migration/guestperf/comparison.py | 13 +++++++++++++
>  scripts/migration/guestperf/engine.py     | 14 ++++++++++++++
>  scripts/migration/guestperf/scenario.py   |  7 +++++--
>  scripts/migration/guestperf/shell.py      |  3 +++
>  4 files changed, 35 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


