Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812A9EF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxm2f-0002iq-Jl; Wed, 04 Mar 2026 08:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm2X-0002fy-KE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm2T-00072f-Ap
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772629997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TfLr6N8jrBdOocfoLn4Ihz7O7b5/uipjMKTIQq78UI4=;
 b=X+JC5/lWplPz2tCB+aqdXkqJXpyLA0uOhv7V0Ow9b8gjRDiPwDkEhf/ZVA7s17yomRbtmW
 I75d9bAnrS2x1eD2bIsPlwIMPrUAEUNjNKI4v5kH/AyrVo67QGqE/7tf4zTfHIYjW5q3i+
 beftnVcqblQPAI2EQ4QLwVdelVDd9+c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-U7-9jM4xMeGauSrjpgaTTg-1; Wed, 04 Mar 2026 08:13:16 -0500
X-MC-Unique: U7-9jM4xMeGauSrjpgaTTg-1
X-Mimecast-MFC-AGG-ID: U7-9jM4xMeGauSrjpgaTTg_1772629995
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so3109922f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772629995; x=1773234795; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TfLr6N8jrBdOocfoLn4Ihz7O7b5/uipjMKTIQq78UI4=;
 b=VLssseKg2XhORgBl5BssKdLKc53ZNcikVI3UaBKWvcOZm6m020uK2cIy8vx6MovZHI
 FBOGY3aUG3IrWo9QhJLxCXkwKZSzr8P3qcWQIhFD2g3aenQR3qO//77Qq/vOSU7pMbIe
 Anpvzk/nloYmAgn2Gc5hoj0gRIVymXdYj9lJuRz1z4DxFKc+f3lWe9FUtMn4iAj5/dtD
 f8vwD72s5xTXHydd656+YOpsLsfOeKncEBhCQQCqpxOTtMtTYicFRbq2NSUQDT+bI0cY
 RUS3Reh5bP3D/Zj3R2T3hWv3U/3/Q0E4nq86HhmmuE8fI8Hy7L700qRwp7GxlIZq3sKe
 0LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772629995; x=1773234795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfLr6N8jrBdOocfoLn4Ihz7O7b5/uipjMKTIQq78UI4=;
 b=ryVK/bIteMl3jcrOQb8hNisnl2Wmh21P55BLSInEKsmGsNXosvTWu6XSj7ITxB4FKV
 6f5ERjABX3ZO/vo9aBJnxCQZsHP411qrWFd27kZebZknZabjjdIJfvZ3sjzynmcNs7BZ
 jvN5Xezo6TVWH5EqLakWhe/Ehs7eEURiEp4u05+rQh0yxMSZrY9+cnMGy2zQtW5dvuOQ
 ih8U9eN39ReANoJqvAXu+UqoLWN2L+0OwnbEEnaFM648XGmz26UIKVKUy8N5HMBEXv4l
 SXQcgSaPoZXSQNLpMSJXEuwXpuFAng7sFsJA3VAsokZybqNi+TVCx3PN0PeOObCkNAhR
 UC5g==
X-Gm-Message-State: AOJu0YwZ99cH/msfkEhe5ilYbBEWXIyHUWK1982HmH66SmEDimpwKzEM
 gL3XZf2JcbMxBlpZsatVGSTSFnTLAoimjEy1nJyp2JBGroTNwgH4JAcIbCk2ldB5q+mzfF+K5TY
 u2+6nOqjxjK2rpagja+hsSyzquWJsGgsh42KvQ5P9XvzK9t69w6cl4QZ3
X-Gm-Gg: ATEYQzwAMJuBo0oNjmIXgWcJFQ2YwPK/M97cTCLpagj1CxAxfd9kvHKrw0SMrYoSMl2
 yYeiQMQi770uXyiNZMRZvqsYHzBh9KWvyUiwDdmToo8akKYn+RtTkTK1OuJEU8u3tS81m3MjDjH
 5QJ3oWXaam7AIrjQQI5DlO0qNw4a/s8xVThyxIF8dP4sUnpfv50CQwDJ5CKI9BPK3b//Mjn7g+N
 bfPrWOsPDSoXs2g445yXiz9b8LKtbVOqQfRhl/uuSdTt8LdZWqnM41OR91Ozi3WelA+2wIg1Uti
 PCcPlvibMvkY7TQGFlmUofajSfqKQu9V6UtVIrj4Bl7LvshoySH83FxT6AUKvgafAokYcTQb5ga
 dN2BBJMeyjxdlXODU35RcHOkgEE6giYNWnctwDNewewMEx/CEIATB6IO1UfJPxdhqI+nYg8o=
X-Received: by 2002:a05:6000:4205:b0:439:a958:4342 with SMTP id
 ffacd0b85a97d-439c7fd3e11mr3793577f8f.34.1772629994794; 
 Wed, 04 Mar 2026 05:13:14 -0800 (PST)
X-Received: by 2002:a05:6000:4205:b0:439:a958:4342 with SMTP id
 ffacd0b85a97d-439c7fd3e11mr3793527f8f.34.1772629994313; 
 Wed, 04 Mar 2026 05:13:14 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b272sm41841114f8f.24.2026.03.04.05.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:13:13 -0800 (PST)
Date: Wed, 4 Mar 2026 14:13:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 slp@redhat.com, hi@alyssa.is, stevensd@chromium.org
Subject: Re: [PATCH v13 6/7] qmp: add shmem feature map
Message-ID: <aagv3p615IC17nHt@sgarzare-redhat>
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-7-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260219130334.787858-7-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Thu, Feb 19, 2026 at 02:03:33PM +0100, Albert Esteve wrote:
>Add new vhost-user protocol
>VHOST_USER_PROTOCOL_F_SHMEM feature to
>feature map.
>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> hw/virtio/virtio-qmp.c | 3 +++
> 1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>index 968299fda0..e3d0a10a59 100644
>--- a/hw/virtio/virtio-qmp.c
>+++ b/hw/virtio/virtio-qmp.c
>@@ -127,6 +127,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
>     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
>             "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
>             "supported"),
>+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHMEM, \
>+                "VHOST_USER_PROTOCOL_F_SHMEM: Backend shared memory mapping "
>+                "supported"),
>     { -1, "" }
> };
>
>-- 
>2.52.0
>


