Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFCBFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC8Z-0006EH-Qa; Wed, 29 Apr 2026 17:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIC8Y-0006Bp-Cb
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIC8W-00047S-PE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rV7ZLzegkXqvKhnvvzu9mD5WAFoLINY7tuaeteU9udo=;
 b=c5ICg506XghUlTlcmePd21205OXAwLghwsBd5C6hMVNIO/Bmw3D4TzT5q/NwWVmQx/VqKu
 EG8zmP32f6aa2nA8du2XgyoreZojlRoeCXzvk7BBrGgaB6a6k2KBp+s8w6/vB85ItXJQdn
 8TrlcIld319ZuBbH3KxfXNp6M6V/1c8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-GAOwhOszOOG4FKZsXc1loQ-1; Wed, 29 Apr 2026 17:07:58 -0400
X-MC-Unique: GAOwhOszOOG4FKZsXc1loQ-1
X-Mimecast-MFC-AGG-ID: GAOwhOszOOG4FKZsXc1loQ_1777496878
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8f461b583acso79401985a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777496878; x=1778101678; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rV7ZLzegkXqvKhnvvzu9mD5WAFoLINY7tuaeteU9udo=;
 b=UCd2IffLoAuyKfjRE6cIn7e8hktA0qJrf4qg009i86L19NSya/jH1yeOwoI5cd0jFw
 0ukQzO/jwb6Y0UuVX9K/sOMRJE7ejvyFC/Q0TXluxVKRJNUztuVCIEVBY7aiDEx3P27Q
 t+Far5a4D4a5Lyhacaqngc+BlLGPXFMLIOL8Hw9vh5xEBJ298AlCYMUXC7ZPTHefR9bI
 AKqvyN+hEW/IXmqR0iSQXw/Ks6eg5p+qfWFUPsqsHtNjc4gKfw1scIyZckDReY/hHXAD
 BfxHag88v7OJ+vW1uqOJs/jYFMcpL9KUBzq+UgW3PYWOqP35uOtxeDGjOjt8tb/o192B
 uYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777496878; x=1778101678;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rV7ZLzegkXqvKhnvvzu9mD5WAFoLINY7tuaeteU9udo=;
 b=OPsVuB7vk8D1ngTsTgAb56tADuDkPODdApo3jK79htCA004livOZKElvqSOz9fA56V
 GfIwcQcBgIoBDtqOn3Bcv6frvipjS0/HgkFK/CNFp/rp0g2i6DGg+C++BZb8YLHkKxhv
 RiFYPOGylgX8lfmHZOyy98SYhay6mOg4dnOU1UqRpKR9OZzrgLwgAdUMmH3/yccZYHXC
 bV7RV1HDb2j9yiEBpCrBZ5oL0AJL/NVCrJhpO+J53qkwKMoT1LAhpfk+SR9FkRl8qqQv
 Uun/zkA7G/Vnk7/jGREeZq/kMqYUBQBKI/LecyLhb8sQ9vzYVN2Bz902MJT6ll4610t3
 gu+g==
X-Gm-Message-State: AOJu0Yw0RcmkA8bnq3Cb0v+Y9XjOpmnWDCTslu52oqEOxdQYIplubgUK
 C7cMLiKMKom6gCVkJS2RXfgpsTa+HWiG/zYiKzS/DLs6xTxMFOxHnqGFH7QR05MD/ZCpDsz4nPn
 WDTB1Rbc1enm1ggBi9uoNTKceFoLMAy6c2Mpv5V6Oll+fFJBG11k8g+a0
X-Gm-Gg: AeBDiesU/59rsXvp9drfddG9NqXot3zE8CdXh/qLBk1VyScqfqW0pz0Maa3Z6s+Bbam
 0VwkZ5r2hcanGYZEhniAwmpmsgoVqSBSv5HStP3WU3EbfSlFbj//PhqW0NtCx+KWlzmeMWd6pdx
 fzR57vfkKkAi3axyYLE9qSdtfSgHIEU3Xb/t9ROM+DR8caxKBBjoHbdnwrYjHz48u+0PCqluH0Y
 hm9ds+TFBf5raDcnZ5x7GUVhIrgm4udoVJgOHZrBunRdZefSI7Tc2L4b/SmSyycurb0WTRLum/W
 iIeZTQIJZfXjggVhY/P3e5eeTIGJ/7+X7GxfzbG2gWqlRFnFS6LD68M/AiFAKQ2hUQO1CO4vkbM
 HNv75QsUZqphPlLunRHEHn/7rr/9ML3ZRwVbqUGOvJEQForMVMXrHvpngUA==
X-Received: by 2002:a05:620a:4081:b0:8f8:8860:fbad with SMTP id
 af79cd13be357-8fa8990b7c2mr70027485a.57.1777496877989; 
 Wed, 29 Apr 2026 14:07:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4081:b0:8f8:8860:fbad with SMTP id
 af79cd13be357-8fa8990b7c2mr70023185a.57.1777496877507; 
 Wed, 29 Apr 2026 14:07:57 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f93f58320bsm281104885a.24.2026.04.29.14.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:07:57 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:07:56 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 13/41] RFC system/ioport: move embedded memory region
 cleanup to portio_list_destroy
Message-ID: <afJzLNnljU4hvZuu@x1.local>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-13-c413f3605311@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427-qom-tests-v1-13-c413f3605311@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 27, 2026 at 11:42:12PM +0400, Marc-André Lureau wrote:
> memory_region_portio_list_finalize() unconditionally calls
> object_unref() on the embedded MemoryRegion, but when the object was
> created via bare object_new() the MemoryRegion was never initialized
> and has a refcount of 0, triggering an assertion failure.
> 
> The unref in finalize drops the keep-alive reference added during the
> reparenting in portio_list_add_1(). Move it to portio_list_destroy()
> where the cleanup belongs, and assert the refcount is zero in
> finalize.
> 
> This is an alternative to "system/ioport: Fix qom-list-properties crash
> on portio list obj" patch, hence the RFC.
> 
> Fixes: 690705ca0b0f ("softmmu/ioport.c: make MemoryRegionPortioList owner of portio_list MemoryRegions")
> Cc: peterx@redhat.com
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  system/ioport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/system/ioport.c b/system/ioport.c
> index 9209bff2eab..aa8f3229804 100644
> --- a/system/ioport.c
> +++ b/system/ioport.c
> @@ -145,6 +145,7 @@ void portio_list_destroy(PortioList *piolist)
>      for (i = 0; i < piolist->nr; ++i) {
>          mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
>          object_unparent(OBJECT(&mrpio->mr));
> +        object_unref(OBJECT(&mrpio->mr));
>          object_unref(mrpio);
>      }
>      g_free(piolist->regions);
> @@ -346,7 +347,8 @@ static void memory_region_portio_list_finalize(Object *obj)
>  {
>      MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
>  
> -    object_unref(&mrpio->mr);
> +    /* dropped by portio_list_destroy(), or never initialized */
> +    assert(!mrpio->mr.parent_obj.ref);

I'm not sure if it's worthwhile to just add such assert and violate the
layering here, by accessing mr's refcount. Shall we just drop this check?

OTOH, if we will move the unref to destroy, shall we move the ports below
over and just go ahead removing the whole finalize()?

>      g_free(mrpio->ports);
>  }
>  
> 
> -- 
> 2.53.0
> 

-- 
Peter Xu


