Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EF1C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlOP-0000k3-LC; Tue, 30 Jan 2024 05:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rUlON-0000hH-VK
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rUlOL-000760-OU
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706610655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcLzAwD8SxSEqGahPUy+AgGEYfy72o5uXjl4gwdJtUU=;
 b=PrXhlkWL7Wq2UIbukGVAfq5Wi27wPsoJQu8Bs7K/QW5PAQqLwhmLdUnIP+ZCoWaB+IErdB
 R+Qtjq6gvEX5BokP52xSx149tr80Y8s1HBSfiFEhG1d6PMq7hDFDDGHHGlT/vcvVcGDGZ2
 8B48umkEWxFW4Yj3g2xxg7aR1U/4o5M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-6u2qyHc2Mhued2iPfmGWOQ-1; Tue,
 30 Jan 2024 05:30:51 -0500
X-MC-Unique: 6u2qyHc2Mhued2iPfmGWOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B78A38143A9;
 Tue, 30 Jan 2024 10:30:51 +0000 (UTC)
Received: from localhost (unknown [10.42.28.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D352B107BD;
 Tue, 30 Jan 2024 10:30:50 +0000 (UTC)
Date: Tue, 30 Jan 2024 10:30:50 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 hreitz@redhat.com
Subject: Re: [PATCH [repost]] block/blkio: Don't assume size_t is 64 bit
Message-ID: <20240130103050.GJ7636@redhat.com>
References: <20240129185427.2952727-1-rjones@redhat.com>
 <20240129185427.2952727-2-rjones@redhat.com>
 <Zbi4r90M8K3o6EgZ@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0cIwUVkPINaeW+5C"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbi4r90M8K3o6EgZ@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--0cIwUVkPINaeW+5C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 30, 2024 at 09:51:59AM +0100, Kevin Wolf wrote:
> Am 29.01.2024 um 19:53 hat Richard W.M. Jones geschrieben:
> > With GCC 14 the code failed to compile on i686 (and was wrong for any
> > version of GCC):
> > 
> > ../block/blkio.c: In function ‘blkio_file_open’:
> > ../block/blkio.c:857:28: error: passing argument 3 of ‘blkio_get_uint64’ from incompatible pointer type [-Wincompatible-pointer-types]
> >   857 |                            &s->mem_region_alignment);
> >       |                            ^~~~~~~~~~~~~~~~~~~~~~~~
> >       |                            |
> >       |                            size_t * {aka unsigned int *}
> > In file included from ../block/blkio.c:12:
> > /usr/include/blkio.h:49:67: note: expected ‘uint64_t *’ {aka ‘long long unsigned int *’} but argument is of type ‘size_t *’ {aka ‘unsigned int *’}
> >    49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t *value);
> >       |                                                         ~~~~~~~~~~^~~~~
> > 
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> 
> Why not simply make BDRVBlkioState.mem_region_alignment a uint64_t
> instead of keeping it size_t and doing an additional conversion with
> a check that requires an #if (probably to avoid a warning on 64 bit
> hosts because the condition is never true)?

The smaller change (attached) does work on i686, but this worries me a
little (although it doesn't give any error or warning):

    if (((uintptr_t)host | size) % s->mem_region_alignment) {
    error_setg(errp, "unaligned buf %p with size %zu", host, size);
        return BMRR_FAIL;
    }

Rich.

> Kevin
> 
> >  block/blkio.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blkio.c b/block/blkio.c
> > index 0a0a6c0f5fd..52d78935147 100644
> > --- a/block/blkio.c
> > +++ b/block/blkio.c
> > @@ -794,6 +794,7 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
> >      const char *blkio_driver = bs->drv->protocol_name;
> >      BDRVBlkioState *s = bs->opaque;
> >      int ret;
> > +    uint64_t val;
> >  
> >      ret = blkio_create(blkio_driver, &s->blkio);
> >      if (ret < 0) {
> > @@ -854,7 +855,7 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
> >  
> >      ret = blkio_get_uint64(s->blkio,
> >                             "mem-region-alignment",
> > -                           &s->mem_region_alignment);
> > +                           &val);
> >      if (ret < 0) {
> >          error_setg_errno(errp, -ret,
> >                           "failed to get mem-region-alignment: %s",
> > @@ -862,6 +863,15 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
> >          blkio_destroy(&s->blkio);
> >          return ret;
> >      }
> > +#if HOST_LONG_BITS == 32
> > +    if (val > SIZE_MAX) {
> > +        error_setg_errno(errp, ERANGE,
> > +                         "mem-region-alignment too large for size_t");
> > +        blkio_destroy(&s->blkio);
> > +        return -ERANGE;
> > +    }
> > +#endif
> > +    s->mem_region_alignment = (size_t)val;
> >  
> >      ret = blkio_get_bool(s->blkio,
> >                           "may-pin-mem-regions",
> > -- 
> > 2.43.0
> > 

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

--0cIwUVkPINaeW+5C
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0001-block-blkio-Make-s-mem_region_alignment-be-64-bits.patch"
Content-Transfer-Encoding: 8bit

From 500f3a81652dcefa79a4864c1f3fa6747c16952e Mon Sep 17 00:00:00 2001
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Mon, 29 Jan 2024 18:20:46 +0000
Subject: [PATCH] block/blkio: Make s->mem_region_alignment be 64 bits
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With GCC 14 the code failed to compile on i686 (and was wrong for any
version of GCC):

../block/blkio.c: In function ‘blkio_file_open’:
../block/blkio.c:857:28: error: passing argument 3 of ‘blkio_get_uint64’ from incompatible pointer type [-Wincompatible-pointer-types]
  857 |                            &s->mem_region_alignment);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~
      |                            |
      |                            size_t * {aka unsigned int *}
In file included from ../block/blkio.c:12:
/usr/include/blkio.h:49:67: note: expected ‘uint64_t *’ {aka ‘long long unsigned int *’} but argument is of type ‘size_t *’ {aka ‘unsigned int *’}
   49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t *value);
      |                                                         ~~~~~~~~~~^~~~~

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/blkio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blkio.c b/block/blkio.c
index 0a0a6c0f5fd..bc2f21784c7 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -68,7 +68,7 @@ typedef struct {
     CoQueue bounce_available;
 
     /* The value of the "mem-region-alignment" property */
-    size_t mem_region_alignment;
+    uint64_t mem_region_alignment;
 
     /* Can we skip adding/deleting blkio_mem_regions? */
     bool needs_mem_regions;
-- 
2.43.0


--0cIwUVkPINaeW+5C--


