Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FFDCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvdDx-000427-00; Mon, 08 Sep 2025 10:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvdDu-00041E-0e
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvdDj-00057K-W7
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757343101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=O0ngLqogNMieDoTkLdKc0D0UcbNsV16ZS0mTeRcfF10=;
 b=EAMx/93OWpRhOGYA645GoGO9ZXjj5obhp94O7nw8yZfvay1oA/I6fQoWeq1GXsGdZH5pzL
 b2F/SfiSFyXLhvdWlH6ml7Kuf41cxsQY3MA1LzRD/mCsjidTISDOMapwq98CIXYHAYsnqw
 KsLOnmyoMR6SVMvA+9yFBMi6mhjL2Xw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-YJfFhik8P0iAwcRvzav6mg-1; Mon,
 08 Sep 2025 10:51:40 -0400
X-MC-Unique: YJfFhik8P0iAwcRvzav6mg-1
X-Mimecast-MFC-AGG-ID: YJfFhik8P0iAwcRvzav6mg_1757343099
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EEBE19560A1; Mon,  8 Sep 2025 14:51:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54A5518003FC; Mon,  8 Sep 2025 14:51:37 +0000 (UTC)
Date: Mon, 8 Sep 2025 15:51:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Message-ID: <aL7tdmmT0ZEVZ1qb@redhat.com>
References: <20250905142006.2230345-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905142006.2230345-1-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 05, 2025 at 05:20:06PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> QEMU_HEXDUMP_LINE_WIDTH calculation doesn't correspond to
> qemu_hexdump_line(). This leads to last line of the dump (when
> length is not multiply of 16) has badly aligned ASCII part.
> 
> Let's calculate length the same way.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  util/hexdump.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)

Would you mind also adding a test to tests/unit/test-cutils.c
to show the correctness, as this is a nice standalone func
we ought to be unit testing.

> 
> diff --git a/util/hexdump.c b/util/hexdump.c
> index f29ffceb74..7cfc547261 100644
> --- a/util/hexdump.c
> +++ b/util/hexdump.c
> @@ -22,6 +22,19 @@ static inline char hexdump_nibble(unsigned x)
>      return (x < 10 ? '0' : 'a' - 10) + x;
>  }
>  
> +static size_t hexdump_line_length(size_t buf_len, size_t unit_len,
> +                                  size_t block_len)
> +{
> +    size_t est = buf_len * 2;
> +    if (unit_len) {
> +        est += buf_len / unit_len;
> +    }
> +    if (block_len) {
> +        est += buf_len / block_len;
> +    }
> +    return est;
> +}
> +
>  GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
>                             size_t unit_len, size_t block_len)
>  {
> @@ -30,14 +43,8 @@ GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
>  
>      if (str == NULL) {
>          /* Estimate the length of the output to avoid reallocs. */
> -        size_t est = len * 2;
> -        if (unit_len) {
> -            est += len / unit_len;
> -        }
> -        if (block_len) {
> -            est += len / block_len;
> -        }
> -        str = g_string_sized_new(est + 1);
> +        str = g_string_sized_new(hexdump_line_length(len, unit_len, block_len)
> +                                 + 1);
>      }
>  
>      for (u = 0, b = 0; len; u++, b++, len--, buf++) {
> @@ -76,13 +83,16 @@ static void asciidump_line(char *line, const void *bufptr, size_t len)
>  }
>  
>  #define QEMU_HEXDUMP_LINE_BYTES 16
> -#define QEMU_HEXDUMP_LINE_WIDTH \
> -    (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
> +#define QEMU_HEXDUMP_UNIT 1
> +#define QEMU_HEXDUMP_BLOCK 4
>  
>  void qemu_hexdump(FILE *fp, const char *prefix,
>                    const void *bufptr, size_t size)
>  {
> -    g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
> +    int width = hexdump_line_length(QEMU_HEXDUMP_LINE_BYTES,
> +                                    QEMU_HEXDUMP_UNIT,
> +                                    QEMU_HEXDUMP_BLOCK);
> +    g_autoptr(GString) str = g_string_sized_new(width + 1);
>      char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
>      size_t b, len;
>  
> @@ -90,11 +100,11 @@ void qemu_hexdump(FILE *fp, const char *prefix,
>          len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
>  
>          g_string_truncate(str, 0);
> -        qemu_hexdump_line(str, bufptr + b, len, 1, 4);
> +        qemu_hexdump_line(str, bufptr + b, len,
> +                          QEMU_HEXDUMP_UNIT, QEMU_HEXDUMP_BLOCK);
>          asciidump_line(ascii, bufptr + b, len);
>  
> -        fprintf(fp, "%s: %04zx: %-*s %s\n",
> -                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, str->str, ascii);
> +        fprintf(fp, "%s: %04zx: %-*s %s\n", prefix, b, width, str->str, ascii);
>      }
>  
>  }
> -- 
> 2.48.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


