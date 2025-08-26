Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73136CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 10:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqqsC-0004oe-EH; Tue, 26 Aug 2025 06:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqqs9-0004nh-RU
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 06:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqqs5-0006wd-E5
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 06:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756203940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5p8Pl/rlLwKkYrlPxvshgh3AGUv1NAra7NN+Z9dYCo=;
 b=a4xa/rwMbEBz7SnDxua1ymw+2R7agZepLRA4sk/nr3JNM4kbONanhKcQVS/0+8BBtuPwPq
 ehAoP3IBu8MPeI6Buz7vuM0aDdWtBOFT8D/PtYWnCmuk+EWorW4aZ7izrQ4LuHLtFkbvTJ
 03HLKJSc0MAmmz2Ht/fYNIIradxmrLc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-vHd5-6OyM0WrxVbX8sr3EA-1; Tue,
 26 Aug 2025 06:25:39 -0400
X-MC-Unique: vHd5-6OyM0WrxVbX8sr3EA-1
X-Mimecast-MFC-AGG-ID: vHd5-6OyM0WrxVbX8sr3EA_1756203938
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4B2E180036E; Tue, 26 Aug 2025 10:25:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9975A1955F24; Tue, 26 Aug 2025 10:25:34 +0000 (UTC)
Date: Tue, 26 Aug 2025 11:25:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, qemu-stable@qemu.org
Subject: Re: [PATCH] block/curl: fix curl internal handles handling
Message-ID: <aK2Lmz6A36ea9lKc@redhat.com>
References: <20250824001144.2001882-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250824001144.2001882-1-mjt@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 24, 2025 at 03:11:42AM +0300, Michael Tokarev wrote:
> block/curl.c uses CURLMOPT_SOCKETFUNCTION to register a socket callback.
> According to the documentation, this callback is called not just with
> application-created sockets but also with internal curl sockets, - and
> for such sockets, user data pointer is not set by the application, so
> the result qemu crashing.
> 
> Pass BDRVCURLState directly to the callback function as user pointer,
> instead of relying on CURLINFO_PRIVATE.
> 
> This problem started happening with update of libcurl from 8.9 to 8.10 --
> apparently with this change curl started using private handles more.
> 
> (CURLINFO_PRIVATE is used in one more place, in curl_multi_check_completion() -
> it might need a similar fix too)
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3081
> Cc: qemu-stable@qemu.org
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  block/curl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


