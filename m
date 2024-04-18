Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEADC04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 13:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxSFH-0004Gt-Uj; Thu, 18 Apr 2024 09:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxSFF-0004Gc-9L
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxSFD-0005XC-10
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713448566;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oIMVB2EgJtHb5q2kvAdknac4ydI12OO/pao0nrK3gHE=;
 b=WMZXxcDOlgqhVf/9KW44bPZ0rjHVSHbW5Ks1ufA49w7yQ1A4w3axnmDPMnyseaWFcX+74Y
 +Hjnb/TIBtS/2HA/CPHbvhrFTEkysKYIeBs22DTlE4P4ZR4w3X3LecoKgALw4kDKQ99aTR
 0t5MAYqbfMqpJ+JvTdZzhekf0JA8VTo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-optJRG86NeizyD2ww5TuXA-1; Thu,
 18 Apr 2024 09:56:02 -0400
X-MC-Unique: optJRG86NeizyD2ww5TuXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C195282D3CD;
 Thu, 18 Apr 2024 13:56:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8F9535430;
 Thu, 18 Apr 2024 13:56:00 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:55:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Temir Zharaspayev <masscry@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 1/2] libvhost-user: Fix pointer arithmetic in indirect read
Message-ID: <ZiEmbvuzbpy-ERDh@redhat.com>
References: <20240113012741.54664-1-masscry@gmail.com>
 <20240113012741.54664-2-masscry@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240113012741.54664-2-masscry@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jan 13, 2024 at 04:27:40AM +0300, Temir Zharaspayev wrote:
> When zero-copy usage of indirect descriptors buffer table isn't
> possible, library gather scattered memory chunks in a local copy.
> This commit fixes the issue with pointer arithmetic for the local copy
> buffer.
> 
> Signed-off-by: Temir Zharaspayev <masscry@gmail.com>
> ---
>  subprojects/libvhost-user/libvhost-user.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 6684057370..e952c098a3 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -2307,7 +2307,7 @@ static int
>  virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
>                               uint64_t addr, size_t len)
>  {
> -    struct vring_desc *ori_desc;
> +    uint8_t *src_cursor, *dst_cursor;
>      uint64_t read_len;
>  
>      if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
> @@ -2318,17 +2318,18 @@ virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
>          return -1;
>      }
>  
> +    dst_cursor = (uint8_t *) desc;
>      while (len) {
>          read_len = len;
> -        ori_desc = vu_gpa_to_va(dev, &read_len, addr);
> -        if (!ori_desc) {
> +        src_cursor = vu_gpa_to_va(dev, &read_len, addr);
> +        if (!src_cursor) {
>              return -1;
>          }
>  
> -        memcpy(desc, ori_desc, read_len);
> +        memcpy(dst_cursor, src_cursor, read_len);
>          len -= read_len;
>          addr += read_len;
> -        desc += read_len;
> +        dst_cursor += read_len;

The ori_desc -> src_cursor changes don't look to have any functional
effect. Having that change present obscures the functional part of
the patch, which is this line. FWIW, it is generally preferrable to
not mix functional and non-functional changes in the same patch

It now interprets 'read_len' as the number of bytes to increment the
address by, rather than incrementing by the number of elements of
size 'sizeof(struct vring_desc)'.

I don't know enough about this area of QEMU code to say which
semantics were desired, so I'll defer to the Michael as maintainer
to give a formal review.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


