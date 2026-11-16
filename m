Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015A606A335
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iOKPT7yf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT07p-0007Ce-VX; Mon, 16 Nov 2026 12:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xT07j-00073g-Ew
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xT07g-0006Xm-Rf
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794848643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x6u/Pxc8zPb8F5WjQRXOOe+DGfiS09o19Bj25yL+ckQ=;
 b=iOKPT7yfMaNRK8LKZCb/EJsBor/6ga0AjZTxSas83ak8EbBR6KfwuBLzoB9A+9o5/GwdKd
 e8MYCluPl8ajO6Yf/DeoYWbFHOUs4uJXusF2LNr8XYUVyeqx7VRfW/GlIHgdpqyfVag+0v
 r55DzALOvc/gLvghQ2AQmQUS6cGuTDg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-dfV_XEMSNKS0U0EM0uaKzQ-1; Mon,
 16 Nov 2026 12:04:00 -0500
X-MC-Unique: dfV_XEMSNKS0U0EM0uaKzQ-1
X-Mimecast-MFC-AGG-ID: dfV_XEMSNKS0U0EM0uaKzQ_1794848639
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FC01180047B; Mon, 16 Nov 2026 17:03:58 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF6E81956047; Mon, 16 Nov 2026 17:03:55 +0000 (UTC)
Date: Mon, 16 Nov 2026 18:03:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 oxsignal <awo@kakao.com>
Subject: Re: [PATCH 1/2] block/dmg-lzfse: reject short LZFSE decodes
Message-ID: <avs3eZhTRm-ItTZU@redhat.com>
References: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
 <20261112-dmg-short-decode-v1-1-f7f342097b60@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-dmg-short-decode-v1-1-f7f342097b60@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 12.11.2026 um 16:33 hat Julio Faracco geschrieben:
> dmg_uncompress_lzfse_do() treated any non-zero lzfse_decode_buffer()
> return as success. A crafted DMG can declare a larger chunk output size
> than its LZFSE stream decodes to, leaking the unzeroed tail of
> uncompressed_chunk to the guest as sector data -- a heap disclosure.

This paragraph talks about a too large destination, so it's a bit
confusing to read about "exact-size and a too-small destination" as if
this were related to solving the problem described here.

My understanding is that the next paragraph is talking about a case that
doesn't leak any information, but for which we still add validation
while we're touching the code so that invalid images that contain
"hidden" compressed data that would never be read are detected, too.

Maybe this can be made a bit clearer in the commit message.

> lzfse_decode_buffer() returns the destination capacity both for an
> exact-size and a too-small destination, so decode with one extra byte of
> capacity (allocated in dmg_open()): an exact stream returns avail_out, a
> short or oversized one does not. Require out_size == avail_out. Decoding
> in place also avoids a per-chunk g_malloc()/memcpy() of up to 64 MiB in
> the read path.
> 
> zlib and bzip2 chunk paths already enforce this; LZFSE did not.
> 
> Fixes: CVE-2026-116483
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4662
> Reported-by: oxsignal <awo@kakao.com>
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  block/dmg-lzfse.c | 27 +++++++++++++++++++--------
>  block/dmg.c       |  8 +++++++-
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/block/dmg-lzfse.c b/block/dmg-lzfse.c
> index 4ea0b9b20d..b1acd87135 100644
> --- a/block/dmg-lzfse.c
> +++ b/block/dmg-lzfse.c
> @@ -33,16 +33,27 @@
>  static int dmg_uncompress_lzfse_do(char *next_in, unsigned int avail_in,
>                                     char *next_out, unsigned int avail_out)
>  {
> -    size_t out_size = lzfse_decode_buffer((uint8_t *) next_out, avail_out,
> -                                          (uint8_t *) next_in, avail_in,
> -                                          NULL);
> +    size_t out_size;
>  
> -    /* We need to decode the single chunk only. */
> -    /* So, out_size == avail_out is not an error here. */
> -    if (out_size > 0) {
> -        return out_size;
> +    /*
> +     * lzfse_decode_buffer() returns the destination capacity both on an
> +     * exact decode and when the destination is too small, so on its own it
> +     * cannot tell a full chunk from a short one. The caller allocates

...from a too long one, no?

Well, depending if you're talking about the compressed or uncompressed
chunk. Maybe say "a truncated one" instead? "short" sounds like the
input side, i.e. the compressed stream, to me.

> +     * next_out one byte larger than avail_out (see dmg_open() in dmg.c);
> +     * decoding with that extra byte of capacity lets an exact decode
> +     * (out_size == avail_out) be distinguished from a short or oversized
> +     * stream, without a per-chunk scratch allocation or memcpy.
> +     *
> +     * next_out MUST have room for avail_out + 1 bytes.
> +     */
> +    out_size = lzfse_decode_buffer((uint8_t *) next_out, avail_out + 1,
> +                                   (uint8_t *) next_in, avail_in,
> +                                   NULL);
> +
> +    if (out_size != avail_out) {
> +        return -1;
>      }
> -    return -1;
> +    return out_size;
>  }

Kevin


