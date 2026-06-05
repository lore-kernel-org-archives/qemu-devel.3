Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06528CD6E74
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPOI-0008PU-LB; Fri, 05 Jun 2026 03:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wVPOA-0008Oy-6w
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 03:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wVPO1-0002SN-F9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 03:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780646075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JfLRY27a2cmHmbLtBh4UyU6UMKFBFfdtUJjQulwl0Gg=;
 b=AAdEy0R2NqGC+Ipp263xT+fQu5bL7xUWmKLbhEFMpjuExwgKupeLuvSzdaqz6DbVBtFH0i
 WtvEjg8BYdgebh+1/TEPHzEYDdeoMQJuz/M4W45+gc519ohGnvF/GOhMOICAxidCYj+A45
 v8MkpFjsFsMffYumlC+7pGUbepHrwrY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-hYY4zGBqOEK0-8zlsrzqQw-1; Fri, 05 Jun 2026 03:54:33 -0400
X-MC-Unique: hYY4zGBqOEK0-8zlsrzqQw-1
X-Mimecast-MFC-AGG-ID: hYY4zGBqOEK0-8zlsrzqQw_1780646072
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490bde3d239so12572185e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780646072; x=1781250872; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JfLRY27a2cmHmbLtBh4UyU6UMKFBFfdtUJjQulwl0Gg=;
 b=EnBswqGxgxWEM8ypQdSVgUEGryup2U9jqsnaetyN36h9/ey6dqzb+P1i2Tmf0b3fe4
 ztWLmEUvcfeYNNpvhRy4AcnZV64I3EJWwS7rKzDKhKIXdsuWgfPe8IS9CN3MUvrn7OsJ
 MDtWEFzSfzVP4u3TUuI85dor+IO4G7rbgnLw6OAsukqmEuk1X6btbG7AZKK/cLfViWnQ
 7dCsjqRUIiwKvvfJwFfCsgyHMrErrUkjQYAyv/R3DAO6mSUhww0y4jsMZvFP/mkBKpU1
 y0bKdKiT7SPLh7XrcT7eG4MsuCDJSepIIkzE9/yv+zllH9MF17DYiaVnYovK2SLbvn9D
 Q3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780646072; x=1781250872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfLRY27a2cmHmbLtBh4UyU6UMKFBFfdtUJjQulwl0Gg=;
 b=ihO01wf0VPB9SjF851x/OUE4M7RnwOOOZef0jnzgjMiKZ5XnvzT80sZGxGcnxzPswJ
 p4LK7S2KWYyM8PoICrkVeT8CwmzhEt9fpoba8CZx2n1V0HtxprzjD6Hv+VF0cMWjFf8F
 Ay5YyYpAMMwWtJC3HeRiqYyqmJImgEbiSFmBX/oU8gMJ7TkLWEbR75B2H0l4DktQUgSC
 c5H/a1kaf2l/LwwGeg21UTUh9x0FCoRX36nhc8f4fA2ILFdQwXaI8U9m4G+wWfCGyWwV
 DSxjF/lVOfX5AZ/p6g9Viziz1z6eS+1+ODPGI6aQhLV1y5SQ9RfLwwGFscUY0XtTqYzx
 hd5w==
X-Gm-Message-State: AOJu0YyV2ho4GwDVoc9wm/awpWsCa0BWb9c8d4i8tTDoOYkqWPQw5px3
 vKf3Rz/ZDvYz0Wsd71Raggr+tFWoSr9F4ZJ12uMJLr+3GZIcMwMvedgPii6zEmYQjtJWUb2D4G7
 ws8NNsERU76BCN2dreI+Ug7cMoiipN53/NpRPVL8OoUKym3PHx/iBpris
X-Gm-Gg: Acq92OEgP6QcCfsC6EQeBMIFeNSMTTgc5X+jNjSxlR+2+2gSxyrUiFdyJBdBehkorX7
 DMlgm5+F35qO223sbIzirP4C53dkUmqXL1jkBSZwpaYZz4ZwRR9IvqV0H6CYxG7sdb0C6Z8KXvA
 3HPf4RfD57Skq6Dfb3SxuDLJZARMAQKQVBLjVUWuqgCSyN3w9AlCfHOK2b82baSL2HBmTM9Yf99
 XzFre3Cx0OeM0cbFPt9Zdxmdm+YhHmJrXknivHAUuOlHeO/04raSpW7c9GEr8+W+bhW8HapXJPc
 sb7CNF0iNVbm2bSYpOLzucb9CECFhvTKgMrKL6l+O7MSEMn7blQGL6Chw8a0TsXLAbeyq3b1JY8
 aMqxlQ0AefgpY/izQLdutJ/EKxcWeYBGSbZIdMvPKDFe455nBEuq0VaQ7cleX+hvYPnLKrsxoM4
 Ldzop7Aw==
X-Received: by 2002:a05:600c:6387:b0:490:b26f:a512 with SMTP id
 5b1f17b1804b1-490c251d015mr37480705e9.0.1780646072515; 
 Fri, 05 Jun 2026 00:54:32 -0700 (PDT)
X-Received: by 2002:a05:600c:6387:b0:490:b26f:a512 with SMTP id
 5b1f17b1804b1-490c251d015mr37480245e9.0.1780646072012; 
 Fri, 05 Jun 2026 00:54:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d37edbsm29916855e9.2.2026.06.05.00.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 00:54:31 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:54:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, gmaglione@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, hreitz@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] libvhost-user: look for available vq buffers upon
 SET_VRING_KICK
Message-ID: <aiKAm6O7LKwRmiSf@sgarzare-redhat>
References: <20260604201029.250450-1-stefanha@redhat.com>
 <20260604201029.250450-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604201029.250450-3-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 04:10:28PM -0400, Stefan Hajnoczi wrote:
>When a vring is started the back-end must look for available vq buffers
>and process them. This scenario can happen if the back-end is stopped
>with unprocessed available buffers and then started again.
>
>The inflight I/O tracking code already did this, but it should also be
>done when inflight I/O tracking is not enabled.
>
>Move the code and make it robust in case of EINTR or EAGAIN.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> subprojects/libvhost-user/libvhost-user.c | 19 ++++++++++++++-----
> 1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


