Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19D5CDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMQl-0003na-3C; Mon, 30 Sep 2024 15:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMQf-0003dq-Ep
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svMQd-0003Bx-Sl
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727725890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gCh/BGuMjOhsh5W2nIhqu09MTRzcH1GEj53zggpXxc=;
 b=Avqt3xisYHovN9p/rxBe98QwDi185GZkGXnGQJtpUeB4IjdkfLSLmq28MA78SaYvmAGCTN
 RQh5rfWfkLKf8Ait6q5neG4uGSuIig5mAZdX/N8YvL/MRWEBeiaFSuv3+URbQjbO1dthg2
 9hj70QksV0wQCLhHBfR1dGv9kG+Gzeg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Lyn_YjznOwG5zdcIR8wNTQ-1; Mon, 30 Sep 2024 15:51:28 -0400
X-MC-Unique: Lyn_YjznOwG5zdcIR8wNTQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cb314380aeso91884826d6.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 12:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727725888; x=1728330688;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/gCh/BGuMjOhsh5W2nIhqu09MTRzcH1GEj53zggpXxc=;
 b=SiF72vSXuLEkwHe1tN4B0dJSmA5Ve7/4VL1Dwh1lVvkNPlURhfQtgJPOOUDWRm7FTp
 /j3cJnJ05K6tEOnJU+qygb0psicIbAEDDWee/qffnJ8nl5O1dbuDYRYXoVtH1B9J4Zve
 fflSV3jV1LLcmH3ufUM1edFuKMxCHSmBm4o/ATBVRb84f8x2Ks3YF7LCMxaH6c6K1ME5
 XTo2OlQfJ/9Srtmj/wHKq8yB5n2rBwN1OYP5gbtMCThJJFDc8Xikae0YAwoqdIXSDlN8
 eoIz2/x6YyvKzeb9E+dFGjxybM1pUFN6PJ/ph5nhcoGKjuIjF8ecmwRAexXxQFGzLtfU
 fxvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7+2/t/yMVqCaqX7S4v2mh2vXnTrkHSzlRIczzU/Io2pl6GIlS14YK516cxNClam93MbWMcZCUMcR+@nongnu.org
X-Gm-Message-State: AOJu0Yxl/nq5FA3VEip8OsWbjaVAEsPRWt98RcN5uVzs991WuGIasoJz
 9UlZQMHMcZIrSP7WlvGNaTTCq/2OoY9DnnlfljsHLYoPlqsDbLi7xhe7ZXbvoQ0liWvgkloXO/e
 ojCJlqgiQCw9grBBmsth7d6iipHRkz5MxRz2h7SPQUeD2m+4leHm5
X-Received: by 2002:a05:6214:2ae:b0:6cb:458d:6525 with SMTP id
 6a1803df08f44-6cb458d66c8mr157855586d6.26.1727725888092; 
 Mon, 30 Sep 2024 12:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Uc7ATcIQG4CL/C/F+9cvkKEVdLKFfCXEjLbKc3WVlFxKMM8Fw69TotS5VPk3sdUMuQZOiA==
X-Received: by 2002:a05:6214:2ae:b0:6cb:458d:6525 with SMTP id
 6a1803df08f44-6cb458d66c8mr157855276d6.26.1727725887681; 
 Mon, 30 Sep 2024 12:51:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66b811sm42629046d6.78.2024.09.30.12.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 12:51:27 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:51:25 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/7] migration/postcopy: Use uffd helpers
Message-ID: <ZvsBPQzODYXJQ52L@x1n>
References: <20240919134626.166183-1-dave@treblig.org>
 <20240919134626.166183-7-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240919134626.166183-7-dave@treblig.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 19, 2024 at 02:46:25PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> Use the uffd_copy_page, uffd_zero_page and uffd_wakeup helpers
> rather than calling ioctl ourselves.
> 
> They return -errno on error, and print an error_report themselves.
> I think this actually makes postcopy_place_page actually more
> consistent in it's callers.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  migration/postcopy-ram.c | 47 +++++++++++-----------------------------
>  1 file changed, 13 insertions(+), 34 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 1c374b7ea1..e2b318d3da 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -746,18 +746,9 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
>                           RAMBlock *rb)
>  {
>      size_t pagesize = qemu_ram_pagesize(rb);
> -    struct uffdio_range range;
> -    int ret;
>      trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
> -    range.start = ROUND_DOWN(client_addr, pagesize);
> -    range.len = pagesize;
> -    ret = ioctl(pcfd->fd, UFFDIO_WAKE, &range);
> -    if (ret) {
> -        error_report("%s: Failed to wake: %zx in %s (%s)",
> -                     __func__, (size_t)client_addr, qemu_ram_get_idstr(rb),
> -                     strerror(errno));
> -    }
> -    return ret;
> +    return uffd_wakeup(pcfd->fd, (void *)ROUND_DOWN(client_addr, pagesize),
> +                       pagesize);
>  }

There's a build issue on i386:

../migration/postcopy-ram.c: In function ‘postcopy_wake_shared’:
../migration/postcopy-ram.c:750:34: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  750 |     return uffd_wakeup(pcfd->fd, (void *)ROUND_DOWN(client_addr, pagesize),
      |                                  ^

The plan is to squash below fix:

=========8<===========
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 03a63ef5cd..83f6160a36 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
-@@ -747,7 +747,8 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
 {
     size_t pagesize = qemu_ram_pagesize(rb);
     trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
-    return uffd_wakeup(pcfd->fd, (void *)ROUND_DOWN(client_addr, pagesize),
+    return uffd_wakeup(pcfd->fd,
+                       (void *)(uintptr_t)ROUND_DOWN(client_addr, pagesize),
                        pagesize);
 }
=========8<===========

Thanks,

-- 
Peter Xu


