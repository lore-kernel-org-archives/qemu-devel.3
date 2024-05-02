Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CED1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 14:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2XPR-0007Ra-P0; Thu, 02 May 2024 10:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2XPQ-0007RC-E8
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2XPH-0001Ob-Ah
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714660050;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wWo+mPPLXAZI8UndIGNe9fLvcIwE0LSrdT83XB+WEWg=;
 b=SjWwHer0D5qCyC8cYj8FCkGQT2buo5XI/ptIUNX7YZHbzi6ZJmlfdBS1oY5gLsFlrJLGQC
 ScGyHncw/lsZFYmwJSe/QvwCNcV7UQjVr4g52I2sv2fRcxULdrQknYg1kO5+zxKXzJTPSs
 LBNGnnQoNJz+Y0G+zYdI5Jcti8YZ2z4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-AShA-dAeO6e6wSJrMMlxRg-1; Thu, 02 May 2024 10:27:27 -0400
X-MC-Unique: AShA-dAeO6e6wSJrMMlxRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A57818065AB;
 Thu,  2 May 2024 14:27:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21A1EC15771;
 Thu,  2 May 2024 14:27:24 +0000 (UTC)
Date: Thu, 2 May 2024 15:27:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Roman Kiryanov <rkir@google.com>
Subject: Re: [PATCH] bitmap: Use g_try_new0/g_renew
Message-ID: <ZjOiys7va7DQl7qZ@redhat.com>
References: <20240502142316.44012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240502142316.44012-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 02, 2024 at 04:23:16PM +0200, Paolo Bonzini wrote:
> Avoids an explicit use of sizeof().  The GLib allocation macros
> ensure that the multiplication by the size of the element
> uses the right type and does not overflow.
> 
> Cc: qemu-trivial@nongnu.org
> Cc: Roman Kiryanov <rkir@google.com>
> Cc: Daniel Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/bitmap.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index 97806811eeb..c4363b1d324 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -92,8 +92,8 @@ long slow_bitmap_count_one(const unsigned long *bitmap, long nbits);
>  
>  static inline unsigned long *bitmap_try_new(long nbits)
>  {
> -    long len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> -    return g_try_malloc0(len);
> +    long nelem = BITS_TO_LONGS(nbits);
> +    return g_try_new0(unsigned long, nelem);
>  }
>  
>  static inline unsigned long *bitmap_new(long nbits)

I'd suggest this method be changed to directly call
g_new0 too. Its current impl of calling bitmap_try_new()
followed by a plain abort() has worse diagnostics than
g_new0, which uses g_error to report the actual allocation
size that failed.

> @@ -265,10 +265,10 @@ unsigned long bitmap_find_next_zero_area(unsigned long *map,
>  static inline unsigned long *bitmap_zero_extend(unsigned long *old,
>                                                  long old_nbits, long new_nbits)
>  {
> -    long new_len = BITS_TO_LONGS(new_nbits) * sizeof(unsigned long);
> -    unsigned long *new = g_realloc(old, new_len);
> -    bitmap_clear(new, old_nbits, new_nbits - old_nbits);
> -    return new;
> +    long new_nelem = BITS_TO_LONGS(new_nbits);
> +    unsigned long *ptr = g_renew(unsigned long, old, new_nelem);
> +    bitmap_clear(ptr, old_nbits, new_nbits - old_nbits);
> +    return ptr;
>  }
>  
>  void bitmap_to_le(unsigned long *dst, const unsigned long *src,
> -- 
> 2.44.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


