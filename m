Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DBDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 13:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxo0m-0006BM-Vc; Fri, 19 Apr 2024 09:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rxo0k-0006Aj-Ru
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 09:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rxo0f-0000G6-Qn
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 09:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713532232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hk5zEvzjjVi/smQ2Cn5TsDYDubmhevLtJkVQaWXnHbk=;
 b=gczLZ+oFR+vRH30nrolLyMp4n3TbUxNWc0fRf3QBABtEarFbo3MmpQIGnRqDoxhNQ6o8JM
 FaQ7TyweDnMJTWXg3rAZ6RC2On2W7ka6AakBaKTNfuTN+2TS5B8cGeJS5PQhkd+zRh3AMw
 z4i+l4A9Y4FrT6xfC0E40l/PBiF32Bs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-CUjNIEQaOcOwPQyG3JHKJg-1; Fri, 19 Apr 2024 09:10:28 -0400
X-MC-Unique: CUjNIEQaOcOwPQyG3JHKJg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E02C1049C9C;
 Fri, 19 Apr 2024 13:10:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F417492BC7;
 Fri, 19 Apr 2024 13:10:27 +0000 (UTC)
Date: Fri, 19 Apr 2024 08:10:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Peter Lieven <pl@dlhnet.de>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 09/13] block/gluster: Use URI parsing code from glib
Message-ID: <dyeahh2v42dpdqdiqrzubjdxpw536iw74pdbh2gllqp2cbwlka@ufq7op2gzvqp>
References: <20240418101056.302103-1-thuth@redhat.com>
 <20240418101056.302103-10-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418101056.302103-10-thuth@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 18, 2024 at 12:10:52PM +0200, Thomas Huth wrote:
> Since version 2.66, glib has useful URI parsing functions, too.
> Use those instead of the QEMU-internal ones to be finally able
> to get rid of the latter.
> 
> Since g_uri_get_path() returns a const pointer, we also need to
> tweak the parameter of parse_volume_options() (where we use the
> result of g_uri_get_path() as input).
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/gluster.c | 71 ++++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)
> 

> @@ -364,57 +363,57 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
>      QAPI_LIST_PREPEND(gconf->server, gsconf);
>  
>      /* transport */
> -    if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
> +    uri_scheme = g_uri_get_scheme(uri);
> +    if (!uri_scheme || !strcmp(uri_scheme, "gluster")) {
>          gsconf->type = SOCKET_ADDRESS_TYPE_INET;

It may be worth a mention in the commit message that we are aware that
this provides a positive user-visible change as a side-effect: namely,
by virtue of using glib's parser (which normalizes the scheme to
lowercase) instead of our own (which did not), we now accept
GLUSTER:// URIs in addition to the usual gluster:// spelling.  Similar
comments to all the other affected patches in the series.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


