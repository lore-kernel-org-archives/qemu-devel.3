Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E36DE7E35C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8auR-0008HU-0B; Fri, 03 Apr 2026 05:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1w8auP-0008HM-JT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1w8auN-0000xB-Tp
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775208822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEFXrVUNMg8ZSU164ne0dwaqiBwhCanYoj2Ad331+HY=;
 b=hUjUN4Fk6TWJ640Mz4MWCQYPD9GntJpQkxVaR+MICJpRwX2LLSjP1rX0OM8M+vzFsc7XRI
 5HBPAKdkifGvVv4lcDjel0tHXBrTwWWPsvz/PU8RAwYb9bByArXcI55YfJFzdADGoZSilH
 yCeygA4epY9GWy6VyyEDT36BWrFsNcc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-CgmDVyuJPtCPnEPlGsKH-Q-1; Fri, 03 Apr 2026 05:33:40 -0400
X-MC-Unique: CgmDVyuJPtCPnEPlGsKH-Q-1
X-Mimecast-MFC-AGG-ID: CgmDVyuJPtCPnEPlGsKH-Q_1775208819
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d03bad787so1994271f8f.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 02:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775208819; x=1775813619; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EEFXrVUNMg8ZSU164ne0dwaqiBwhCanYoj2Ad331+HY=;
 b=Y03V49QUk/K4C5hiNVO+yi+aCP0v55XxvU7zY/J5Nobydz+wFYUjUq+HCJNRtvo0fL
 r+7/kOjrTk3FR+kfO1L2PI4Xh3mIryVZ3/sv2MQY1bbzH7pMgfgiNzV722zDXyOj2cIc
 hpyeDZ+QWkILwr5U4wbZu+qVJJRf32D4/nP5EdEkMvEuKkEThXhAHqqdfvrCcPSVCCvd
 K4m7qCpndcvqat4Rd0b1XaAHrebRrwS1Q99bOh6OcGGMzZ9o7omy8jrI8qRbnbNcz392
 jbKt0o3m2MvRMsThHonuLDoXWcoZYLbg06wrEtDgdYuUq9uIZXusa6PodMVKrXP/GiB9
 tY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775208819; x=1775813619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEFXrVUNMg8ZSU164ne0dwaqiBwhCanYoj2Ad331+HY=;
 b=gbFW+4VE0Q3FJvHXtdvymYizSJ049RhLdupobyv3ZgN5epU62PoWOJOoKKsYvnRBvu
 IoI8OxOOSyR35Ujmpo1hKBJCxUAZMvFJmJW5Pr/tSgqM2rFbv4X0eQ4B2s9feWYg4Ia7
 PKXeKCYmO3sPIKGEfrvkvmougTDMQx0HG8tFWt+A7UgJqLdEaPc8G6qawEY37Yfu+la+
 1gtX+B+FKreYgQ9JEj5znXuDFA2KyWjBGCU6czFeqMOgbbY9pPELtOjmR3vZP5xLVJdt
 0h2og3QXJWT8sIsC1iq2Lhy7rlfxtgd6CVJ8Gck0edZo2dEkf50rYH+SIWl/26+Ju2Rp
 1png==
X-Gm-Message-State: AOJu0YwwN/IajkrFYf4hhydR+WckgGyixvr/jUPT5ZsTy6zW8YjJVRts
 QwuPxbu+vvZohaSsojHXuBuHgGijNqnYmG6lXGOjBl6pCUmbYPC14MS1Z31t5zxl2wDXA3znqTV
 T8U4EGCBlZh2K1yUCqqvAJKrgNot17BgO1OaUwV+XsCAlkOQH5dXPnZ4h
X-Gm-Gg: ATEYQzwIdsbo1Ki3sky6GzS5Q0rUi9bQuvK+d5JgWEKPrKopMkEqEC0KCAOET2bgd0t
 XQfW0fEQKZ4hrZK4xOyfvkitMu49frGMEHKW+P0jXDiEqximwZle5hcRqAFsjj2JbCIQIyeKZ4h
 /o7k88lpw5a6X5d/ONGpISjlkg3gOuhaYzO5jqpka4XkJUj6swQlxN7c4W7LEgndYogatOiUpjI
 3Bh36nyjQanyfgZdWlhwFdU8STSPMuPQFbrfiUqWn9IhOO0EL3HB7wme5QtxzGfZD5t+RNehrVl
 RnMTj/9moir/xMHjg90XbJ+VyRXzMP8MkVA4cqNqvNWqSen+FopRvnddrrsI/UvcN0y3GFNQ8Zr
 JJl34fZ4ioa33CmIQ
X-Received: by 2002:a05:600c:3acf:b0:488:95d0:ee46 with SMTP id
 5b1f17b1804b1-488997d1588mr35764135e9.19.1775208819298; 
 Fri, 03 Apr 2026 02:33:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3acf:b0:488:95d0:ee46 with SMTP id
 5b1f17b1804b1-488997d1588mr35763725e9.19.1775208818734; 
 Fri, 03 Apr 2026 02:33:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48899c00098sm22312015e9.3.2026.04.03.02.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 02:33:38 -0700 (PDT)
Date: Fri, 3 Apr 2026 05:33:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org
Subject: Re: [PATCH] hw/virtio/vhost: simplify ring mapping verification with
 loop
Message-ID: <20260403053055-mutt-send-email-mst@kernel.org>
References: <20260403091621.88914-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403091621.88914-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Apr 03, 2026 at 05:16:21PM +0800, Bin Guo wrote:
> Replace the three nearly-identical vhost_verify_ring_part_mapping() calls
> with a simple loop over arrays. This eliminates code duplication while
> maintaining identical behavior and error reporting.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  hw/virtio/vhost.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index b9dc4ed13b..7b5bfc86e6 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -525,31 +525,21 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
>              continue;
>          }
>  
> -        j = 0;
> -        r = vhost_verify_ring_part_mapping(
> -                vq->desc, vq->desc_phys, vq->desc_size,
> -                reg_hva, reg_gpa, reg_size);
> -        if (r) {
> -            break;
> -        }
> -
> -        j++;
> -        r = vhost_verify_ring_part_mapping(
> -                vq->avail, vq->avail_phys, vq->avail_size,
> -                reg_hva, reg_gpa, reg_size);
> -        if (r) {
> -            break;
> -        }
> -
> -        j++;
> -        r = vhost_verify_ring_part_mapping(
> -                vq->used, vq->used_phys, vq->used_size,
> -                reg_hva, reg_gpa, reg_size);
> -        if (r) {
> -            break;
> +        void *ring_addrs[] = {vq->desc, vq->avail, vq->used};
> +        uint64_t ring_phys[] = {vq->desc_phys, vq->avail_phys, vq->used_phys};
> +        uint64_t ring_sizes[] = {vq->desc_size, vq->avail_size, vq->used_size};
> +
> +        for (j = 0; j < 3; j++) {
> +            r = vhost_verify_ring_part_mapping(
> +                    ring_addrs[j], ring_phys[j], ring_sizes[j],
> +                    reg_hva, reg_gpa, reg_size);
> +            if (r) {
> +                goto out;
> +            }
>          }
>      }
>  
> +out:
>      if (r == -ENOMEM) {
>          error_report("Unable to map %s for ring %d", part_name[j], i);


I don't see the point, sorry. Maybe if it was a single array,
and we used ARRAY_SIZE ... Even then, I am not sure.

As it is, we are replacing straight forward linear code with
tricky arrays.

>      } else if (r == -EBUSY) {
> -- 
> 2.50.1 (Apple Git-155)


