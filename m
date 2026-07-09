Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912CDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whhjP-0003sy-TH; Thu, 09 Jul 2026 01:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whhjO-0003s5-3m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whhjM-0003Cz-H3
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783576527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6q/JfiVx37RI05jd5wlr+YLbTuEbvdb05ysw9TgDCw=;
 b=fiU+wnAkdAIvQXkhya4XgwizVa6EDrRvPpbCiI0dwH/FDAl9DJ+9hjXlRnGz1RoLhtJWjr
 9rv55qZ3uJvrZSbmF4/SRJqGUhz1w3GuSl5oZqFtb04vft+oZDV697/5WSVD1VIsRvUNOX
 Gvq+NnOKGwwihzFS1M2e/voxTjYDb/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-C3kKdAMkOOCPhunPx0g6ng-1; Thu, 09 Jul 2026 01:55:26 -0400
X-MC-Unique: C3kKdAMkOOCPhunPx0g6ng-1
X-Mimecast-MFC-AGG-ID: C3kKdAMkOOCPhunPx0g6ng_1783576525
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bdaf8549so12815165e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783576525; x=1784181325; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I6q/JfiVx37RI05jd5wlr+YLbTuEbvdb05ysw9TgDCw=;
 b=uJosWE+IvI/Dt6P81r0nsvvS2jmRSud6BI6+Zp07USRS3TiBRjcxjwGCFZ+7Sbudlc
 laNHpmQXOpcXCkQv9jK8UJWOGn1zwuIBTbosq2JJDqOGfy+bCjqVyx7q6yBVjeTx+4MG
 0T4Xiu785d8nrQ1U+9e6dqhX+iHufKnKFCrHq0X8NS9dow/AFoevyryom59VVMbkJQNZ
 GfOceOhiCTSSvQMI6s6K6vSbAceg7S3fU8TB/WVZ+h0MEL9xsSk8SNK94VDbvgEhebiw
 gEF4T1FEZjlQ85dyHvxGEetxkv2IZh2pP7gT1oBWyFrF3slOcmQtn+dhYPlvQfY5sFAK
 52Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783576525; x=1784181325;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I6q/JfiVx37RI05jd5wlr+YLbTuEbvdb05ysw9TgDCw=;
 b=Pv/4929ysfj9f3Cu/W0ZyOi6Koj0sfUaZ3mEafV/h7ISZTtQuAH0A0h8OHnv1/LVHS
 GHMNU5NfTllx4mYpYoxvlscoI1JjtlRfTZi4oO/ixrBTGpmjF0ueLO/gQdJ2YLOfjuqb
 KjCYFWgQk5D5XU+zT/QhvXyg6B0kv4yz5qFBM+lKtgbmClKrq7mcg7zIKgMHLJZvxm64
 zT0KCAeJfynDdDYd+QJBl4MdrElpUmoL/RPScJ6u9FHT21G6qDWFcL6mK+pyK9WGehJS
 RfS9/deXI34etwL+ZXiUyceKJkVa01XztFwnIaa+K8AxvaLd91eUiPF2Wz0UnNkFZXRR
 Ua1Q==
X-Gm-Message-State: AOJu0YwNw3K73mo8ZFxYMHk2Ou2HHAu1qKlj598ewYHSavkXCg97frkO
 4LKrdNrTtL2gJ3TX49GW3Ypw5YwUs2zXrjgZctWwzpVXziX3eeq7gYNjE94JARFzuP90Xb5GEKp
 C1pLwFOFuEa7BF6d0yBbCLGU2IdqsouU5ub7zbIyb/gxsEkLvuizZ1Zxq
X-Gm-Gg: AfdE7cljWIBevATgGl0SkwAfMwdZ8lVj+4nMkFHVcfAICeRUWUgz//b4hoU8SSfJMu7
 nYEkfCBYlJZ80uYWAFjVvMiu2b9uA9cJPg78ZkocZfJdh26cuxpxotSFyk8any60ZN8Lprs9ss+
 uU/jAT1BF0+HqeXe/z1La2MQj1ehleF+/EprM3jqx8clG4a4MY1EFG3mXvKtJ3YlYWYnepMTfHE
 mLu5xvt3/8wURQXahxb/NGP+e79Tvi2O4a7krlyQwR04ntuET5L+0DOA2KBN/whoBH+LMfseZRr
 bCdqdqovIL1R/673GUcp0iov16P6FOKOduG+uRHOUGF5Vd8qXQkKgo9SRNOU35nxSC7oTgmFAyN
 tCBONiXzLFab8u94om0TehZNSb/4KClu/
X-Received: by 2002:a05:600c:1391:b0:493:e508:1137 with SMTP id
 5b1f17b1804b1-493e68e0c1cmr48310085e9.39.1783576524588; 
 Wed, 08 Jul 2026 22:55:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1391:b0:493:e508:1137 with SMTP id
 5b1f17b1804b1-493e68e0c1cmr48309965e9.39.1783576524058; 
 Wed, 08 Jul 2026 22:55:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e736sm52034925f8f.7.2026.07.08.22.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 22:55:23 -0700 (PDT)
Date: Thu, 9 Jul 2026 01:55:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/virtio-serial-bus: validate nr_active_ports from
 migration stream
Message-ID: <20260709015451-mutt-send-email-mst@kernel.org>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Can you add a Fixes tag pls?

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3801
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

to make sure who is merging this me?

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


