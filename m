Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2334BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTmc-0008Lg-M6; Wed, 08 Jul 2026 11:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whTma-0008LJ-GB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whTmT-0003eH-5b
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783522902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1elI55cQ5u7wcTcBd1ly6oAW+0ZBzX1DFQjrnaxuOc=;
 b=QWE6ygoQv1ajgFPlkmGPZXWWEyANRNXNxcUpWcja9TG5joZJjx/bXadYeDU/j4Q5cJLgcQ
 a3i98ntqCBh9PaVcYKOliOunP9BRvX6zHDV53E9gTsVCxFqdEAnDkn0ZTixwQrikzjdt6v
 Oq42G/wczg1t0xjfJGC+7KDNS3/4tzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-rlrvTd9BMpClrnqj3OJLUQ-1; Wed, 08 Jul 2026 11:01:39 -0400
X-MC-Unique: rlrvTd9BMpClrnqj3OJLUQ-1
X-Mimecast-MFC-AGG-ID: rlrvTd9BMpClrnqj3OJLUQ_1783522899
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49244130073so6388345e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783522898; x=1784127698; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A1elI55cQ5u7wcTcBd1ly6oAW+0ZBzX1DFQjrnaxuOc=;
 b=U/3rAJ71FpR2HX1iG7CiDNLsqorvrI/92MP7zHa2vDSIxylYHkRYKR1j3VgL8ok/kF
 yfSH84ggVks3W9Bl4Zkei45S5dP+jfhhcdFsGUM+5Nq1Mr+Qo05EZH1P4R72JEyo/CIw
 jDooDqvWSPsGARyHzbsDYC2FSsQoJiYBdVILNkcDMUCrEOYtq0fH4GJ27HWGmMy8TI8a
 O40BgDM0hvERfc3vcbGkiqNLqGJBfQ9M+WlBGYk18DZRFgXKWKdcFDAXEMSY8eX4rx6C
 dxowx7iRv81RXFSTLI2rlS5y/+AlDlqXACFHqIg985V69vMwQwDmXKO5sZosr9/8EQxd
 K//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522898; x=1784127698;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A1elI55cQ5u7wcTcBd1ly6oAW+0ZBzX1DFQjrnaxuOc=;
 b=nT3GRw8iF3bv/ZdZUfefcDgGDFPwNzNA9T7aLvsYRb+G8X+lHOPQdFU6amX45RwUYN
 1+NfB08JcqKCfGA7wnwHjW5jFPxqLzd0Lz3zcmC6SXuZPWZNtgJihUH7FlbJoiHRauKl
 cd/w78oO7R1E2Az9uxxnIS9l7xlujIiKhzjhM38qTK8DfFV/KuSeFEdmCaA2F7fhoMPg
 lNfHKJNZSYEghd9qbLArsDPYp584GchJKOGxDYwWWcs+AgwfQ2vg0IRQL4R1M+ipjKtm
 xvagaTn0jEHVX5YSYu9Q0kOz9Mi1vpWYFN2Wxpfm24rh181dAnXHjMP8K8YugJlMGpD/
 GXJw==
X-Gm-Message-State: AOJu0YzcoECBEPFYlMyBobXFNHW7RlEPOuit19eSTBdoJkWo3NHT3V/H
 svbY7lCCZu6UdaQgN6MpfVOBOxjOlsRDpufV1BlFn8MfZo6tGJGNCTf4MQDYYUZIfcDZB3WIYwx
 11b7lbhtUXLMC5w1etd5kkPm5b47yHy6cbTwuKdYbaJ5QT2xMD98lazuP
X-Gm-Gg: AfdE7cnJocOo7k+U0A2HDl8WCwqqPrGf5mHa2/C+U7XK9td4yNRnrLN7CJ9GLEmpbO2
 8iKvPaRwjqTvoXHZb5r+RGn1KyXLNxBynpf6OloVFvAaQeaziaFcQ/jaK4iunhO+gGO0PDf9atV
 EFCosHhMEWQ6gbeU5hv39WbXoZPYuQBJ/bEA6+9B2anYuW3Y9+0cgFM3bbqSzbdgvYKmVwpXbuf
 GQqx6FtHHHGpkIFa+1QEvNdRHFyoaUpMswiFjEVsBo5HFJFrnI6bGSW/z2GjJ5k0zZCvelV9QE0
 y5C/3w9gAXQFW8b4wUSFH3ZgVfWYUN96CB6OqULIOQOFOaJBrYSNoSjDadHC8EdyjIfVNXYzUSv
 x978V2ZjamyTSj5jFoXBX5MkUHA5mPmi8
X-Received: by 2002:a05:600c:8b72:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-493e69b0dc8mr28019885e9.7.1783522898460; 
 Wed, 08 Jul 2026 08:01:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8b72:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-493e69b0dc8mr28019155e9.7.1783522897830; 
 Wed, 08 Jul 2026 08:01:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0faed92sm134203565e9.9.2026.07.08.08.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:01:36 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:01:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/virtio-serial-bus: validate nr_active_ports from
 migration stream
Message-ID: <20260708110124-mutt-send-email-mst@kernel.org>
References: <20260708144112.1830881-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708144112.1830881-1-lvivier@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, Jul 08, 2026 at 04:41:12PM +0200, Laurent Vivier wrote:
> The migration restore path reads nr_active_ports from the incoming
> stream and passes it directly to fetch_active_ports_list(), which
> uses it to size a heap allocation. A crafted migration stream can set
> this field to a very large value, causing QEMU to attempt a
> multi-gigabyte allocation and abort.
> 
> Fix this by checking nr_active_ports against the configured
> max_virtserial_ports before calling fetch_active_ports_list().
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3801
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/char/virtio-serial-bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index c1973f0248fc..80f1b308aa53 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -804,6 +804,10 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
>  
>      qemu_get_be32s(f, &nr_active_ports);
>  
> +    if (nr_active_ports > max_nr_ports) {
> +        return -EINVAL;
> +    }
> +
>      if (nr_active_ports) {
>          ret = fetch_active_ports_list(f, s, nr_active_ports);
>          if (ret) {
> -- 
> 2.54.0


