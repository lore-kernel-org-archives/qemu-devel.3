Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8683ECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru91Y-00079q-SL; Tue, 09 Apr 2024 06:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ru91W-00075S-OL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ru91V-0001pZ-ER
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712659696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzYRQIc3co/gG7XXFWnX4DEGjBWcrxnZquufV1VYqSc=;
 b=C4RuZFRMMv6uI6TRdvCd2B/hPHYEXelZnMfKM/1pS04D4Dm7axkXbfinXmWXw8CBtGi4Kq
 mcbb0Vt/ra7EbUs/JNi2de/8ns15Qe6JlUEXmcyHU9JpSEXHjW6gSonNKBNu4k8HfH66pH
 HHQAQxkejn01gK/azX3YUhaVGyabzlE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Hpl_TguwOtGxHon_76lrxg-1; Tue, 09 Apr 2024 06:48:11 -0400
X-MC-Unique: Hpl_TguwOtGxHon_76lrxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62C1488AA24;
 Tue,  9 Apr 2024 10:48:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 422F617B36;
 Tue,  9 Apr 2024 10:48:08 +0000 (UTC)
Date: Tue, 9 Apr 2024 12:48:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH-for-9.0? 1/3] hw/block/nand: Factor nand_load_iolen()
 method out
Message-ID: <ZhUc47XdQXFvTMEz@redhat.com>
References: <20240408083605.55238-1-philmd@linaro.org>
 <20240408083605.55238-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408083605.55238-2-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

Am 08.04.2024 um 10:36 hat Philippe Mathieu-Daudé geschrieben:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/block/nand.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/block/nand.c b/hw/block/nand.c
> index d1435f2207..6fa9038bb5 100644
> --- a/hw/block/nand.c
> +++ b/hw/block/nand.c
> @@ -243,9 +243,25 @@ static inline void nand_pushio_byte(NANDFlashState *s, uint8_t value)
>      }
>  }
>  
> +/*
> + * nand_load_block: Load block containing (s->addr + @offset).
> + * Returns length of data available at @offset in this block.
> + */
> +static int nand_load_block(NANDFlashState *s, int offset)
> +{
> +    int iolen;
> +
> +    s->blk_load(s, s->addr, offset);

Wouldn't it make more sense for @offset to be unsigned, like in
nand_command() before this patch?

I think the values are guaranteed to be small enough to fit in either
signed or unsigned, but we never check for < 0 (maybe that should be
done in your patch to s->blk_load() anyway).

> +    iolen = (1 << s->page_shift) - offset;

This is not new, but I'm confused. Can this legitimately be negative?
offset seems to be limited to (1 << s->addr_shift) + s->offset in
practice, but addr_shift > page_shift for NAND_PAGE_SIZE == 2048.

After patch 3, offset is implicitly limited to NAND_PAGE_SIZE + OOB_SIZE
because we return early if s->blk_load() fails. I wonder if it wouldn't
be better to catch this in the callers already and only assert in
s->blk_load().

Anyway, after patch 3 iolen can only temporarily become negative here...

> +    if (s->gnd) {
> +        iolen += 1 << s->oob_shift;

...before it becomes non-negative again here.

> +    }
> +    return iolen;
> +}

So none of this makes the code technically incorrect after applying the
full series, but let someone modify it who doesn't understand these
intricacies and I think chances are that it will fall apart.

Kevin


