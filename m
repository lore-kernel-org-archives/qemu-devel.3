Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A02606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JLQpu4gS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEVt-0007iR-S9; Tue, 03 Nov 2026 08:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOEVl-0007WA-Ox
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOEVj-00050K-JD
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793712310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+6GlfItYNmfDe4qehElRPiec38xM8BC+tE8cpLbEnY=;
 b=JLQpu4gSvAf0TcZiKJvkO4pP9T2zWEOcbDrDBXR9ncjDzdCl37w1AW7FKnBqCnLoclJB/k
 HmelaX4O0MRkXbEEZj2RgH4A0/8qZgob69zU/Y9LcOhM0xqdvG0KFrMWAc0/s0HAQoaZo1
 J73yGS2EDj6znswzR9wGgZn+0r0IIPY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-QzGnYlucOIaT0wU0GufW7w-1; Tue,
 03 Nov 2026 08:25:06 -0500
X-MC-Unique: QzGnYlucOIaT0wU0GufW7w-1
X-Mimecast-MFC-AGG-ID: QzGnYlucOIaT0wU0GufW7w_1793712305
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B7901956062; Tue,  3 Nov 2026 13:25:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFE84195608C; Tue,  3 Nov 2026 13:25:02 +0000 (UTC)
Date: Tue, 3 Nov 2026 14:25:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH 10/13] qemu-io: add -g to write past the end of the image
Message-ID: <aungrI5jwQtPSqzn@redhat.com>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-11-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930165000.303236-11-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 30.09.2026 um 18:49 hat Denis V. Lunev geschrieben:
> From: Denis V. Lunev <den@openvz.org>
> 
> The preallocate filter only does anything for a write that lands beyond
> the end of its file, and that is what a format driver above it produces.
> qemu-io could not produce it at all: the backend rejects such a request
> with EIO, and the write path asserts without the resize permission, so
> the filter could only be reached by stacking a real format on top and
> letting it choose the offsets.
> 
> Take the resize permission and allow writes beyond the end when -g is
> given, which leaves the tool free to address the filter directly.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

> @@ -310,6 +330,8 @@ static void usage(const char *name)
>  "                       specify tracing options\n"
>  "                       see qemu-img(1) man page for full description\n"
>  "  -U, --force-share    force shared permissions\n"
> +"  -g, --grow           let writes extend the image past its end,\n"
> +"                       as a format driver does to its file\n"
>  "  -h, --help           display this help and exit\n"
>  "  -V, --version        output version information and exit\n"
>  "\n"
> @@ -503,7 +525,7 @@ static QemuOptsList file_opts = {
>  int main(int argc, char **argv)
>  {
>      int readonly = 0;
> -    const char *sopt = "hVc:d:f:rsnCmki:t:T:U";
> +    const char *sopt = "hVc:d:f:grsnCmki:t:T:U";
>      const struct option lopt[] = {
>          { "help", no_argument, NULL, 'h' },
>          { "version", no_argument, NULL, 'V' },
> @@ -522,6 +544,7 @@ int main(int argc, char **argv)
>          { "object", required_argument, NULL, OPTION_OBJECT },
>          { "image-opts", no_argument, NULL, OPTION_IMAGE_OPTS },
>          { "force-share", no_argument, 0, 'U'},
> +        { "grow", no_argument, NULL, 'g' },
>          { NULL, 0, NULL, 0 }
>      };

--growable instead of just --grow would be more consistent with the
terminology we use elsewhere (e.g. block export interfaces).

Kevin


