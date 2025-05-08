Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AE5C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 04:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCt15-0003r1-DE; Thu, 08 May 2025 00:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCt13-0003li-Gt
 for qemu-devel@nongnu.org; Thu, 08 May 2025 00:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCt11-0005xw-Um
 for qemu-devel@nongnu.org; Thu, 08 May 2025 00:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746679064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a2zE8WOYtlxWat/l/sSRe4CJW/O0hEa8M+Wcws3pdEE=;
 b=LLHASCC6CiNcesuA1DH0bnXBMZG6NBoia6Xg5S1l1sGJ4HjrdL7xOEhtFA78rt+dDNX4cx
 cExJmTGi0CM6deEmZTOpMiOgOEj8+t5/ixW5l+No1HdXHt924ZN/6Lb6tE59vjHlQYexrs
 HXnTqdTXiDPbApcOk5RK2jT5fnkIDmg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-6I3v3KMEN8-DkLokNRZ6tg-1; Thu,
 08 May 2025 00:37:39 -0400
X-MC-Unique: 6I3v3KMEN8-DkLokNRZ6tg-1
X-Mimecast-MFC-AGG-ID: 6I3v3KMEN8-DkLokNRZ6tg_1746679058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2958F1955DC5; Thu,  8 May 2025 04:37:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EFF219560A7; Thu,  8 May 2025 04:37:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA7AE21E6768; Thu, 08 May 2025 06:37:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/2] block/null: Report DATA if not reading zeroes
In-Reply-To: <20250430203717.16359-2-nirsof@gmail.com> (Nir Soffer's message
 of "Wed, 30 Apr 2025 23:37:16 +0300")
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-2-nirsof@gmail.com>
Date: Thu, 08 May 2025 06:37:34 +0200
Message-ID: <87plgjg1kh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Nir Soffer <nirsof@gmail.com> writes:

> If read-zeroes is not set, we did not report BDRV_BLOCK_DATA or
> BDRV_BLOCK_ZERO. This is not consistent with other drivers and can
> confuse users or other programs:
>
>     % qemu-img map --output json "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}"
>     [{ "start": 0, "length": 1073741824, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false}]
>
>     % qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}" &
>
>     % nbdinfo --map nbd://127.0.0.1
>              0  1073741824    1  hole
>
> With this change we report DATA in this case:
>
>     % ./qemu-img map --output json "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}"
>     [{ "start": 0, "length": 1073741824, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0}]
>
>     % ./qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '1g'}}" &
>
>     % nbdinfo --map nbd://127.0.0.1
>              0  1073741824    0  data
>
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>  block/null.c         | 4 +---
>  qapi/block-core.json | 5 +++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/block/null.c b/block/null.c
> index dc0b1fdbd9..7ba87bd9a9 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -239,9 +239,7 @@ static int coroutine_fn null_co_block_status(BlockDriverState *bs,
>      *map = offset;
>      *file = bs;
>  
> -    if (s->read_zeroes) {
> -        ret |= BDRV_BLOCK_ZERO;
> -    }
> +    ret |= s->read_zeroes ? BDRV_BLOCK_ZERO : BDRV_BLOCK_DATA;
>      return ret;
>  }
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b1937780e1..7c95c9e36a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3293,8 +3293,9 @@
>  #     requests.  Default to zero which completes requests immediately.
>  #     (Since 2.4)
>  #
> -# @read-zeroes: if true, reads from the device produce zeroes; if
> -#     false, the buffer is left unchanged.
> +# @read-zeroes: if true, emulate a sparse image, and reads from the
> +#     device produce zeroes; if false, emulate an allocated image but
> +#     reads from the device leave the buffer unchanged.
>  #     (default: false; since: 4.1)
>  #
>  # Since: 2.9

Possibly dumb question: how is this doc change related to the code fix?

Suggest to split the sentence for easier reading:

   # @read-zeroes: If true, emulate a sparse image, and reads from the
   #     device produce zeroes.  If false, emulate an allocated image,
   #     but reads from the device leave the buffer unchanged.


