Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A3FC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAbb-0000jT-2H; Wed, 31 Jul 2024 10:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZAbX-0000Th-Cw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZAbW-00055z-2O
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722437221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6GlaCJTNbgegHkQELfABXN1LGC8BvE6m4JC+WeHQ6vs=;
 b=Snl2TdCOnyx7J//kkPps4pHKMUleNo9O5XCP/HKEJdx0WnM6mu88anVZZ/jt/jjMUVnedU
 vURTEZPL+U15KpwzCY5sTxDw0pkfyuo7EwtoWlhIKNoHuWR/Uw+nPsuLE5vbQR0XHwisbm
 b2+P0a3puFWkuNXFWO2Hdy95t5iaskM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-h1rTiUudPsKM2sutnUpfBQ-1; Wed,
 31 Jul 2024 10:46:55 -0400
X-MC-Unique: h1rTiUudPsKM2sutnUpfBQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D10B1944A82; Wed, 31 Jul 2024 14:46:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E57519560AA; Wed, 31 Jul 2024 14:46:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6B65D21E668F; Wed, 31 Jul 2024 16:46:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,  Stefan Weil <sw@weilnetz.de>,  "Richard
 W.M. Jones" <rjones@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH 4/7] hw/ide/atapi: Be explicit that assigning to s->lcyl
 truncates
In-Reply-To: <20240731143617.3391947-5-peter.maydell@linaro.org> (Peter
 Maydell's message of "Wed, 31 Jul 2024 15:36:14 +0100")
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-5-peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 16:46:50 +0200
Message-ID: <87bk2dliud.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In ide_atapi_cmd_reply_end() we calculate a 16-bit size, and then
> assign its two halves to s->lcyl and s->hcyl like this:
>
>            s->lcyl = size;
>            s->hcyl = size >> 8;
>
> Coverity warns that the first line here can overflow the
> 8-bit s->lcyl variable. This is true, and in this case we're
> deliberately only after the low 8 bits of the value. The
> code is clearer to both humans and Coverity if we're explicit
> that we only wanted the low 8 bits, though.
>

Resolves?

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/ide/atapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
> index fcb6cca1573..e82959dc2d3 100644
> --- a/hw/ide/atapi.c
> +++ b/hw/ide/atapi.c
> @@ -265,7 +265,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
               /* a new transfer is needed */
               s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
               ide_bus_set_irq(s->bus);
               byte_count_limit = atapi_byte_count_limit(s);
               trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
               size = s->packet_transfer_size;
               if (size > byte_count_limit) {
                   /* byte count limit must be even if this case */
                   if (byte_count_limit & 1)
>                      byte_count_limit--;
>                  size = byte_count_limit;
>              }
> -            s->lcyl = size;
> +            s->lcyl = size & 0xff;
>              s->hcyl = size >> 8;
>              s->elementary_transfer_size = size;
>              /* we cannot transmit more than one sector at a time */

@size is int.  I wonder why it's fine with size >> 8...  ah,
atapi_byte_count_limit() returns uint16_t, and Coverity is smart enough
to data-flow this via @byte_count_limit into @size.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


