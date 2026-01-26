Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF702D13C2D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOBj-0007Ve-No; Mon, 26 Jan 2026 10:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vkOBc-0007V2-W2
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vkOBX-0004RI-NZ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769440041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzF30LqMjmjkwQgFJzaV/fhHegBqs3vq8YW299x8FEM=;
 b=QN+N1Ivop9qttWeGImw2vxnzhzcZx7GKzOox3SrLq7emvor1a+QlrpWLXs9lM7xVnKgkGr
 IvbHCsuSXnV+AkM2t/EXDITsBAbbQceCTEE9AsO0iO6ulFfGnFa/Yk2xbjgZ6AvcXldvf0
 eSGay+RMaQ9FKLR5hc7iY7mQzPzXs5o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-TJTu7GewMRmIPT9Celcjcw-1; Mon, 26 Jan 2026 10:07:19 -0500
X-MC-Unique: TJTu7GewMRmIPT9Celcjcw-1
X-Mimecast-MFC-AGG-ID: TJTu7GewMRmIPT9Celcjcw_1769440039
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4801d21c280so30252395e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769440038; x=1770044838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzF30LqMjmjkwQgFJzaV/fhHegBqs3vq8YW299x8FEM=;
 b=tlrx+u37rEwIbzYLkIRGQOOMvpl2Lf4Z9oQRRDuyZmj8kouve56tvuElhKEW3auB2p
 F9q59EhF586tFsr6oJHtA4ciebodEMU25wDi8y2m7PnRCXEYWa4kSycrUS7G/bgnChTq
 +l3nfg/dRlMA8TbbjD+OzrwLtaXWv3a5JGJRm4B4rhUEwvcP0RjVqlRE1S04jpAFtleX
 RsUpBbH9AI8WMaiUr2XjKf2qM8/I47nj9zSbZeB0U5D40vqxh4rcMSODlj69MnFJToBe
 EnxXuCLcSZpYG2TAJQI/fXHuC1jTVk897mKm/jMTimaV4IkBxUdzNdQSuLmomN+SWXha
 OlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440038; x=1770044838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SzF30LqMjmjkwQgFJzaV/fhHegBqs3vq8YW299x8FEM=;
 b=N59VIYBEelENW3z7L9NpsGgAMp2KX1Ra5xLQTP4fM/7lTKA6YIArOHIG7IExvPSEiM
 RVYinV7o80gI7GmKedjjR3/0xHCcrMw9lOUQKLvBBUcpKFSQcZr0HcgAZ3fLmKOUVpFY
 YhXUcU8qOSd1rGOkbwyGCwl+fwZdfS6XGIv/5ZbUDP+nLx8Wo7klSACjLGQkbTvSNbx3
 E0/GudYR6tqYF9qrl2sB5PaEeSBHDxiKP4E0VbsWZOaQqWJz/DZmkse0/y0UX99ZUOcs
 AHzZREdJVVyyanPtnuKPdHVJqP+4KVYUHjwAuV5sF3MeyTWZ6GaWKLR6Bfle4bIocsGU
 Ecqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXin2QGHaIfvIvHjFmq1vzsJ87D/FWutVS2Nnb8taEPHYn3G3vhGfqcX4i+DKIlH+dZZbcISUVVuonR@nongnu.org
X-Gm-Message-State: AOJu0YyJ5pS3KuAa29jnWSyrKocKnkwx2sXiNJJNMogUbu9/L8iGhIn8
 zgk8q/XlEUlHftbyA177wZfLCuQneDDGtyulEC6dxfxqFzT4MBIAzK8A1luGqHsWx3YsvlhqP8g
 hlR3NBxHDZwsc/Ri7e1IeKs4+B7owyEjRbadtkTrGpHe9h4jiYdFvuATW
X-Gm-Gg: AZuq6aJ3eAZ4X3TMHtt+bUofyumPKRc1GwhPSt3fTTVmWy1Ew8CbVJk+rDCvQHLy8kQ
 mpiYvoTxNle+1+OoxVmO10rvSwR9Ky+0dsreGe9QS3L1vW4exE+kk9tKqWGZdRcPRCYL9+p21no
 LaMNReFHY25RsaAwx5T3z0hCoBzoZnZYxUQDIQN5ZN9ub60RAp94P+hEyv4ZkK+jszW3B9/9Frt
 v3h+nRV1+Wzg5EV9toaOvzuXThHR90DRUWUZOk8rdUBssEQgRcyGoY7metljM7N2D/Zv/8iJiJt
 LTPC72hUAVb9VU0xip+JBSt7/5UYSFF7/YQTMQ/qsGtZTuoZUU047QJ5xN6TwkyfZbN9IuyjhCN
 4DYyXCMp+QSGJASc8VB4v04XNM5P7B9aHKfPplUIREgbL3cO3djnJOHfWm4deRVJpBalt6sioXQ
 /DMNqM88zprN84sz0F4dcJQIuwxUB1orM5xP9NCrY=
X-Received: by 2002:a05:600c:6290:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-4805ce3f888mr71361375e9.14.1769440038458; 
 Mon, 26 Jan 2026 07:07:18 -0800 (PST)
X-Received: by 2002:a05:600c:6290:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-4805ce3f888mr71361035e9.14.1769440038014; 
 Mon, 26 Jan 2026 07:07:18 -0800 (PST)
Received: from ?IPV6:2003:cf:d737:d0a2:11c1:c888:c8a3:a8c7?
 (p200300cfd737d0a211c1c888c8a3a8c7.dip0.t-ipconnect.de.
 [2003:cf:d737:d0a2:11c1:c888:c8a3:a8c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8c0aebsm278984125e9.15.2026.01.26.07.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 07:07:16 -0800 (PST)
Message-ID: <f3736856-2dc8-45b0-9c20-b49799aa8d35@redhat.com>
Date: Mon, 26 Jan 2026 16:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: move bdrv_advance_flush_gen() earlier from
 bdrv_co_write_req_finish
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20251229161740.758800-1-den@openvz.org>
 <20251229161740.758800-3-den@openvz.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20251229161740.758800-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29.12.25 17:07, Denis V. Lunev wrote:
> This helper is mandatory to be called before bdrv_co_flush(). In the
> other case bdrv_co_flush() will be noop. This helper should be called
> after actual write is completed for subsequent flush to perform some
> work.
>
> Actually this change is important, without it BDRV_REQ_FUA semantics is
> broken completely. flush() is not called. This smells like potential
> data loss if somebody relies on BDRV_REQ_FUA.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>   block/io.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)

Definitely an improvement, but if possible, I would still prefer keeping 
the increment it in bdrv_co_write_req_finish(), because that is where 
all write requests eventually end up in, and that’s also where dirty 
bitmaps are handled.  It seems slightly error-prone to manually have to 
call this every time the BDS data is modified.

Can we maybe instead pull the FUA emulation out into 
bdrv_aligned_pwritev(), after bdrv_co_write_req_finish()?

I think we can only pull out the flush, not the FUA emulation detection 
because for write-zeroes, we have to check either supported_zero_flags 
or supported_write_flags, depending on whether we fall back or not.  But 
bdrv_driver_pwritev() and bdrv_co_do_pwrite_zeroes() could return an 
need_emulate_fua flag via pointer parameter, and if set, 
bdrv_aligned_pwritev() can then do the flush after 
bdrv_co_write_req_finish().  (This would also allow dropping both “only 
flush once at the end” blocks.)

Maybe it would then also make sense to move the bdrv_co_flush() into 
bdrv_co_write_req_finish(), and add a need_flush parameter to it, so 
that it can see whether the whole request (write + flush) was successful.

Hanna


