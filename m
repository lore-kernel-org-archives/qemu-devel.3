Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0497C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvIAE-0003a6-Nl; Fri, 12 Apr 2024 10:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvIAD-0003ZD-Mp
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvIAC-00074p-2w
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712933159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AqVq3ynROCE1RoKFfbPnLY6jMasMcotBF1NVSfMU3Tk=;
 b=QZuO8/09XHhrtn1oI/5JCXrQQiWCHLsmS2eM2nwftbRQkjsYXP+waA9DbYuUGq794nGQtO
 Sic4yQ2AjbqF93cjpznY33fXcgIfM2DRfuqAw0/jkGYNRz0FC8x6jyoCboEly2O06NpZxh
 BS+DbYQEFhoAHzB/BU8tsATSkEiorEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-o2PP6sw8OaS5z2XNsyg9TA-1; Fri, 12 Apr 2024 10:45:55 -0400
X-MC-Unique: o2PP6sw8OaS5z2XNsyg9TA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6187A881E64;
 Fri, 12 Apr 2024 14:45:55 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAE90C13FA5;
 Fri, 12 Apr 2024 14:45:53 +0000 (UTC)
Date: Fri, 12 Apr 2024 09:45:48 -0500
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 10/13] block/nbd: Use URI parsing code from glib
Message-ID: <24wmqsrvzxt2llup4hx4eti5i63ps36hbvub2s32t3zuyfyjgn@zwm3ndftj4tp>
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-11-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412132415.282354-11-thuth@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 12, 2024 at 03:24:12PM +0200, Thomas Huth wrote:
> Since version 2.66, glib has useful URI parsing functions, too.
> Use those instead of the QEMU-internal ones to be finally able
> to get rid of the latter. The g_uri_get_host() also takes care
> of removing the square brackets from IPv6 addresses, so we can
> drop that part of the QEMU code now, too.
> 
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/nbd.c | 76 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 39 deletions(-)
> 

>  
>      /* transport */
> -    if (!g_strcmp0(uri->scheme, "nbd")) {
> +    uri_scheme = g_uri_get_scheme(uri);
> +    if (!g_strcmp0(uri_scheme, "nbd")) {
>          is_unix = false;

As with gluster, we should probably be using g_ascii_strcasecmp() here
to match the RFC; again, worth a separate patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


