Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67004C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzqX-0006ck-OH; Wed, 17 Jul 2024 04:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTzqT-0006Yz-4O
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sTzqP-0007Uy-Uv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721204219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HokNU7iO+JoJlHD2ZhinggIbD8n4vs5W9VLQmU3RogA=;
 b=d7E/DhWSIOVz80Y4pMTGhaVlL0q+Q9/Uj5PySGXJpTEOSPX8H7uysPago9VCzgCbTF+sg5
 YoNrYy8aGUjWrQgDVOClMmv2rMNpJS+rhVCWLT/jrwt20MCfXCVCp7QVdeAKeBJM6/+lvH
 QNpjU+1PL8Dt+1M5aMVjpke9TYEwn9I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-4gCI8MZPNwmOJWcfCFuOqQ-1; Wed,
 17 Jul 2024 04:16:57 -0400
X-MC-Unique: 4gCI8MZPNwmOJWcfCFuOqQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CDDE19560B0; Wed, 17 Jul 2024 08:16:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93468300018E; Wed, 17 Jul 2024 08:16:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4789121E668E; Wed, 17 Jul 2024 10:16:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  jsnow@redhat.com,  Elena Ufimtseva
 <elena.ufimtseva@oracle.com>,  John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH] qapi/qom: Document feature unstable of @x-vfio-user-server
In-Reply-To: <20240703095310.1242102-1-armbru@redhat.com> (Markus Armbruster's
 message of "Wed, 3 Jul 2024 11:53:10 +0200")
References: <20240703095310.1242102-1-armbru@redhat.com>
Date: Wed, 17 Jul 2024 10:16:52 +0200
Message-ID: <87frs8h1qj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Commit 8f9a9259d32c added ObjectType member @x-vfio-user-server with
> feature unstable, but neglected to explain why it is unstable.  Do
> that now.
>
> Fixes: 8f9a9259d32c (vfio-user: define vfio-user-server object)
> Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Cc: John G Johnson <john.g.johnson@oracle.com>
> Cc: Jagannathan Raman <jag.raman@oracle.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qom.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e..3c0f8c633d 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1012,7 +1012,8 @@
>  #
>  # Features:
>  #
> -# @unstable: Member @x-remote-object is experimental.
> +# @unstable: Members @x-remote-object and @x-vfio-user-server are
> +# experimental.

Second line needs to be indented.  Fixed in my tree.

>  #
>  # Since: 6.0
>  ##

Queued.


