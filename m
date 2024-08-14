Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2A0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 18:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seIXn-0006se-FU; Wed, 14 Aug 2024 14:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1seIXd-0006Gm-MJ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 14:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1seIXY-0000EK-LP
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 14:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723659365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vaFr2EQNxBRskF46e9cx1NE9UbZmtIyeInYR7Wdgxy4=;
 b=RPaSizX5fooHrLAw+X+hwVPi3AywJJijZV/SfUkzCifWyu+oxdTbkJMQmByUAPYPCiliVM
 BQUkvjo+lqPiyuu0LTYwMaNpZ04vFwPNErknOg5MZZaZ0c/iK4fCRCdXoq03cn86n9aiAd
 xRkEwtDE8PxDXSJuuce0I9JwdIOhi7E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-za0-Qb-0O9u92G25mgOv3A-1; Wed,
 14 Aug 2024 14:16:01 -0400
X-MC-Unique: za0-Qb-0O9u92G25mgOv3A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B3741925381; Wed, 14 Aug 2024 18:16:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D948F1955D87; Wed, 14 Aug 2024 18:15:57 +0000 (UTC)
Date: Wed, 14 Aug 2024 13:15:55 -0500
From: Eric Blake <eblake@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 edgar.iglesias@amd.com, qemu-block@nongnu.org
Subject: Re: [PATCH v1 1/1] block/file-posix: Avoid maybe-uninitialized warning
Message-ID: <xk2z73avp7eobweubmma4oefeo2siwm2zhzbpecl4y3qv2ohq5@j7oodpli5sij>
References: <20240812144324.116343-1-edgar.iglesias@gmail.com>
 <20240812144324.116343-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812144324.116343-2-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 12, 2024 at 04:43:23PM GMT, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Avoid a maybe-uninitialized warning in raw_refresh_zoned_limits()
> by initializing zoned.
> 
> With GCC 14.1.0:
> In function ‘raw_refresh_zoned_limits’,
>     inlined from ‘raw_refresh_limits’ at ../qemu/block/file-posix.c:1522:5:
> ../qemu/block/file-posix.c:1405:17: error: ‘zoned’ may be used uninitialized [-Werror=maybe-uninitialized]
>  1405 |     if (ret < 0 || zoned == BLK_Z_NONE) {
>       |         ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
> ../qemu/block/file-posix.c:1401:20: note: ‘zoned’ was declared here
>  1401 |     BlockZoneModel zoned;
>       |                    ^~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  block/file-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ff928b5e85..90fa54352c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1398,7 +1398,7 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
>                                       Error **errp)
>  {
>      BDRVRawState *s = bs->opaque;
> -    BlockZoneModel zoned;
> +    BlockZoneModel zoned = BLK_Z_NONE;
>      int ret;
>  
>      ret = get_sysfs_zoned_model(st, &zoned);
> -- 
> 2.43.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


