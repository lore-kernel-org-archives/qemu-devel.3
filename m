Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B2CF53D98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ekq-0007al-2U; Mon, 16 Mar 2026 16:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2Eko-0007ad-7r
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 16:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2Ekl-0005Ss-5Z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 16:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773693689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZereZFaxS7XaTwmccY7iiNx82L4k73eZVyFSXSV/Bw=;
 b=iekaxjlRqCKqLJX6oLKByYOwvsv55JutGXE5U55sa7D7DOrGGtodGxAauRentfHqFOVw+w
 rAagdCd9OcyTG+ytjp59vZ8J66hOUrbJ4iSmXz1sYZozKmxjB7uYCtI7n3sw85tqctxsYj
 t/Oqidsd1aPjcQw7aT2Q4c1HB3nQCHc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-8Co3tsYxNYKwsRU4cHy36A-1; Mon, 16 Mar 2026 16:41:27 -0400
X-MC-Unique: 8Co3tsYxNYKwsRU4cHy36A-1
X-Mimecast-MFC-AGG-ID: 8Co3tsYxNYKwsRU4cHy36A_1773693687
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89c53a0264cso88664446d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773693687; x=1774298487; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uZereZFaxS7XaTwmccY7iiNx82L4k73eZVyFSXSV/Bw=;
 b=TcG/O/n99vXIunkF7OtHi3TXF+zBJgR6Ou/05Ep57X+n9Np2c03awWZkhJduo365Ky
 /RcsmUktuYxjV+VbyyLVBAbqQlBeX9OYhqzuJyxlwWRfa6Frk3V0716SJHEnYEssxT2j
 Pu3OMSuj3oS/iXsfprkuXid8gRXYempu1bZhLvLR++MZKsknIqmTaAOoEKrScGi9OC16
 6vWfDsh/FoDJCiKK1dRq1ClGtzb2tj0DRVvVr4wuQ7LHHPECtzVz+kh0fINzas27iky8
 bJ4mUsyicIJ+h8KdGDBa54mR88e4tkWV1Dpc8nptqEzl38XTXE6KN7qVC+omghLxTNQU
 CDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773693687; x=1774298487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZereZFaxS7XaTwmccY7iiNx82L4k73eZVyFSXSV/Bw=;
 b=bXXgMbtp+gxzFQ9LRwph/vwm6Zd/GKehJe4f+alDS7ZuMEKhsD08XXw+0byEZdVP5/
 /gTpvhnHNMK28+yZCfJ/3TiO8Q8NFIlZ7ll1F9kj+XfHkGWisp3BtNpIKxzMefgydhte
 T9Q1O+gF/sDOZLLAZ8GQpdPsBY+tFcLR5X4WDJHcxfvXXdgh9XWDMHcBiPrzLNSSIe32
 A5A80uNffFXLXjEbRANpB2lKJDuAMCZA8M6qA+4vtCaRxVB95l6ydyllX8yrX61P3gCR
 EU1QR/Ez6rNJy/MGWuqRLbfLvOPr3nXLd1AyOJOECbrSD9OVEZl+/Sz8+DyId4syU/yk
 8mpQ==
X-Gm-Message-State: AOJu0YzJY9zNxD8DXvNc7LUTlmcXE+XEZHsVK7SsurX636d3IejdSw7g
 891fPzHeH/1IcC0CYz4a9FLpIA7sltdm4sOCFiA04q765Orgr2fh5Egt4U8RqttL7+tsgvDCAYm
 7V35zkWQb97wvIVdNdWrk7hSGquJrwhbg/EeBuo/OSRQwZNZgucy6E+9T
X-Gm-Gg: ATEYQzyc1zUhKr3kcXvLxurhhwSvhNu78/DG/odLO4kEnuISZact0onhjSz7U80bnog
 Y5MKzEYZtyf1rmOFmkeVfBkkfpdcteAGw8TZQwG7qBkHwKY9aZ0CyuTjP9S1UbzcmOMvDH6Ij+N
 iiq/AXkIUcRxS4obdJwowIX7OCKZwaR7XKJHXrWKmeOpBaTINYOoqUxJvAyW9RJAzHP9MZQ/JN4
 CxzX97FYiJ6axBnPmqBYRg2P1KJ39Wp2W7oXl+wMHkOwXor+BM2ErLsZg3UPVPpV0SDIwAOtY5f
 LYV5+e0yGyaXUaArh6SNKVIJQBXQPfRzU6AF8DYDrpSbKt59gvFdObXVleY5IHBbrFAJrH09JGE
 whW08ZaigVQptXQ==
X-Received: by 2002:a05:6214:2525:b0:89c:53a0:1c97 with SMTP id
 6a1803df08f44-89c53a026f8mr65639466d6.11.1773693686786; 
 Mon, 16 Mar 2026 13:41:26 -0700 (PDT)
X-Received: by 2002:a05:6214:2525:b0:89c:53a0:1c97 with SMTP id
 6a1803df08f44-89c53a026f8mr65639096d6.11.1773693686266; 
 Mon, 16 Mar 2026 13:41:26 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a6e736043sm112836246d6.10.2026.03.16.13.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 13:41:25 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:41:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] migration/file: fix type mismatch and NULL deref in
 multifd_file_recv_data
Message-ID: <abhq9BzuP2bZPLBg@x1.local>
References: <20260316084618.52-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316084618.52-1-junjie.cao@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 16, 2026 at 04:46:18PM +0800, Junjie Cao wrote:
> multifd_file_recv_data() stores the return value of qio_channel_pread()
> (ssize_t) in a size_t variable.  On I/O error the -1 return value wraps
> to SIZE_MAX, producing a nonsensical read size in the error message.
> 
> More critically, a short read (0 <= ret < data->size) is possible when
> the migration file is truncated.  In that case qio_channel_pread()
> returns a non-negative value without setting *errp.  The function then
> calls error_prepend(errp, ...) which dereferences *errp -- a NULL
> pointer -- crashing QEMU.
> 
> Fix both issues by changing ret to ssize_t and splitting the error
> handling: use error_prepend() only when qio_channel_pread() itself
> has populated *errp (ret < 0), and error_setg() for the short-read
> case where *errp has not been set.  Add ERRP_GUARD() so that
> error_prepend() works correctly even when errp is &error_fatal or
> NULL.

Indeed, this seems problematic.

But is it possible to get partial reads?  I don't see why it won't happen..
do we need to fix it too (e.g. introduce qio_channel_pread_all_eof())?

CC Dan.

Thanks,

> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  migration/file.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 5618aced49..78b274dc32 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -254,15 +254,21 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
>  
>  int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
>  {
> +    ERRP_GUARD();
>      MultiFDRecvData *data = p->data;
> -    size_t ret;
> +    ssize_t ret;
>  
>      ret = qio_channel_pread(p->c, (char *) data->opaque,
>                              data->size, data->file_offset, errp);
> +    if (ret < 0) {
> +        error_prepend(errp, "multifd recv (%u): ", p->id);
> +        return -1;
> +    }
> +
>      if (ret != data->size) {
> -        error_prepend(errp,
> -                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
> -                      p->id, ret, data->size);
> +        error_setg(errp,
> +                   "multifd recv (%u): read 0x%zx, expected 0x%zx",
> +                   p->id, (size_t)ret, data->size);
>          return -1;
>      }
>  
> -- 
> 2.43.0
> 

-- 
Peter Xu


