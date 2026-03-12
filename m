Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B534AFED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 06:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ZwO-00080F-TQ; Thu, 12 Mar 2026 02:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0ZwN-0007x7-Eh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0ZwK-0008KL-Uh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 02:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773298474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bl4aPjMBT/LCrmxSG5XgnhFqLq9MaVfjitb8zz715wI=;
 b=OVdBiJRHj4o3aGHC9SQWF+eUcfMpDRAu0f9ei3WpmWNUsCD0PoYvP+XRtVx2r/c3asEI8m
 TKAaKg8mS50iNQcqjnqyEKJawz/HSm8evluERHXmOFATMRwQ5QdDe+RvcKArdD2Q/8RFp+
 +YwdZ6iYH+V/dc6yUdiSkajfaAuNW4E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-vY1eM2ZZP0ijmIx9fnTzvA-1; Thu, 12 Mar 2026 02:54:33 -0400
X-MC-Unique: vY1eM2ZZP0ijmIx9fnTzvA-1
X-Mimecast-MFC-AGG-ID: vY1eM2ZZP0ijmIx9fnTzvA_1773298472
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b484ee04so1605637f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773298472; x=1773903272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bl4aPjMBT/LCrmxSG5XgnhFqLq9MaVfjitb8zz715wI=;
 b=OLQsO6gOpmtDqu4XcxhJrjt5bERShSluLxCARBmI3DaJRJOgNHlZTIQIDAmZVN7fpq
 tvSUlRb/u5IZpxVeebaMEhYhtJNWldE48AtFGv3AUfrQUEZv6RiM9xquUgpjBrv+sNsJ
 AWIS5Bpq+q7ManZatlyC8rSJ4KPYoquT7C6G44O1IZq/3NoLqDAFWlfTlybCsvMJSz9K
 O4pWrZgX9629PLe+l/zVlO6KoWOBrJHL0iGaK+LQ+Uqmtp3x3OomvnoqvcL+NFYFrZDm
 lykIbbT0sU7Ok75daJm1co929Hf/v4ughofxn4H+9yQceL69xf2/B9qADut2hUyijz/w
 gZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773298472; x=1773903272;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bl4aPjMBT/LCrmxSG5XgnhFqLq9MaVfjitb8zz715wI=;
 b=pizOZuDj6Qu88WkoZXMOMJR+DeTvR+W7guXAKOB0yuElaHcIDtKfqeoEZLwiOCAYpz
 iF3Z3R2qtEINm7pf7+GOX0GKIYcIX9rpt2sbKmpmmMj5LLVagiLZ41/NIpC7UDwfCrZT
 fEDQAHUwLojLyoY//HySbQZMtjPa7DS4YQlhIpHAYVTSy3t12zJzaqHk+86bFjDe3d0K
 L6xBPdjhd3P5238ZXMUE0ZhC6CzUV3yedZ1PBMuNPqKwMq+l61zvmY/sF2b/dF9OHGkX
 /JX2KC4wAlAcKP0dr6ziBgHw5POFOL0Uh6GLcPgQeJ4rp1L7lT9x1tSVnjTgC4px9wfG
 dkoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXHh2p0oSU2nDuL+W2BsyKNrdxwLFImiSk/BSiA+/HQUryI6AZ9R8kdPPGocsbCX9TukTKantt3C8x@nongnu.org
X-Gm-Message-State: AOJu0Yx2a0+XPqeLt/IqDWHviCGGhLRyAVS73EDvFgdWhaRu9rrhkYd/
 J27CVsKlfi4PuYLmOSEtG2Iet7del1t2JB2oDKIkUqhlT7veIh7V8Z5MCfSOhkrTbWqMFOtrf4m
 8eKGZuUcuA1LKztpza2YHuP+82EFxIn7hnY1dUQtwqmL+9EvoXOhr7xQo
X-Gm-Gg: ATEYQzxNLT7QpNesTPH3YzWT7XTDwfOlNTeLu7LezmoqhTzCHM37OIJUwCgCAq2YNDR
 YgCEEswaP71jqaGC2j9M0FgA0ZphVRbtx9Chyb8HncMHzh5B71ncWfhZpqR5WEXdKGWI5ik99U5
 gxwTnmKkaHDeFA6mWqq9EqfB/xZIFF/k66a0kSRRBgnQOBnq8UjZ2MpXfwcSCO+T0tt2nmIP7W0
 ogD/mAAeIB06yZYnmh+7yvW8Zl9TNE2nJaTKd/jMci+wfxZmbDkVfsbUbcgAs1L4xDoEUNUjgZJ
 2s/kGR3XK9mxz5iVuag39yYUxAay+udTTlKXeuviMviZI7BaUcSkNIMt4y/XVLNLTcnzEr4+dF+
 B5DWht2RdjEi61y/FFbUMRwZoxN9+iKX5A96XQWncG5Xmfqiqcj8OQ+w78Kko
X-Received: by 2002:a05:6000:2403:b0:439:c1b2:e99d with SMTP id
 ffacd0b85a97d-439fdf4246emr4235385f8f.8.1773298471635; 
 Wed, 11 Mar 2026 23:54:31 -0700 (PDT)
X-Received: by 2002:a05:6000:2403:b0:439:c1b2:e99d with SMTP id
 ffacd0b85a97d-439fdf4246emr4235350f8f.8.1773298471200; 
 Wed, 11 Mar 2026 23:54:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1b22e7sm6030906f8f.16.2026.03.11.23.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 23:54:30 -0700 (PDT)
Message-ID: <11bcfedf-92d5-480d-975f-2ef83f9ba86b@redhat.com>
Date: Thu, 12 Mar 2026 07:54:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20260311183432.214960-1-viking4@gmail.com>
 <20260311183432.214960-4-viking4@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260311183432.214960-4-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 3/11/26 19:34, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> Check return value of event_notifier_init() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - No functional changes.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>   hw/hyperv/hyperv.c     |  4 ++--
>   hw/hyperv/vmbus.c      |  4 ++--
>   hw/remote/proxy.c      | 15 +++++++++++++--
>   hw/vfio/ap.c           |  2 +-
>   hw/vfio/ccw.c          |  2 +-
>   hw/vfio/pci-quirks.c   |  2 +-
>   hw/vfio/pci.c          |  2 +-
>   hw/virtio/vhost-vdpa.c |  4 ++--
>   8 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 27e323a819..aa278b179e 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -439,7 +439,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
>           sint_route->staged_msg->cb_data = cb_data;
>   
>           r = event_notifier_init(ack_notifier, false);
> -        if (r) {
> +        if (r < 0) {
>               goto cleanup_err_sint;
>           }
>           event_notifier_set_handler(ack_notifier, sint_ack_handler);
> @@ -453,7 +453,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
>   
>       /* We need to setup a GSI for this SintRoute */
>       r = event_notifier_init(&sint_route->sint_set_notifier, false);
> -    if (r) {
> +    if (r < 0) {
>           goto cleanup_err_sint;
>       }
>   
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 64abe4c4c1..5388f4277f 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -1432,7 +1432,7 @@ static void open_channel(VMBusChannel *chan)
>           goto put_gpadl;
>       }
>   
> -    if (event_notifier_init(&chan->notifier, 0)) {
> +    if (event_notifier_init(&chan->notifier, 0) < 0) {
>           goto put_gpadl;
>       }
>   
> @@ -2450,7 +2450,7 @@ static void vmbus_realize(BusState *bus, Error **errp)
>       }
>   
>       ret = event_notifier_init(&vmbus->notifier, 0);
> -    if (ret != 0) {
> +    if (ret < 0) {
>           error_setg(errp, "event notifier failed to init with %d", ret);
>           goto remove_msg_handler;
>       }
> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
> index 5081d67e7f..e91566509f 100644
> --- a/hw/remote/proxy.c
> +++ b/hw/remote/proxy.c
> @@ -52,9 +52,20 @@ static void setup_irqfd(PCIProxyDev *dev)
>       PCIDevice *pci_dev = PCI_DEVICE(dev);
>       MPQemuMsg msg;
>       Error *local_err = NULL;
> +    int ret = 0;
>   
> -    event_notifier_init(&dev->intr, 0);
> -    event_notifier_init(&dev->resample, 0);
> +    ret = event_notifier_init(&dev->intr, 0);
> +    if (ret < 0) {
> +        error_report("Failed to init intr notifier: %s", strerror(-ret));
> +        return;
> +    }
> +
> +    ret = event_notifier_init(&dev->resample, 0);
> +    if (ret < 0) {
> +        error_report("Failed to init resample notifier: %s", strerror(-ret));
> +        event_notifier_cleanup(&dev->intr);
> +        return;
> +    }
>   
>       memset(&msg, 0, sizeof(MPQemuMsg));
>       msg.cmd = MPQEMU_CMD_SET_IRQFD;
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index e58a0169af..5c8f305653 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -180,7 +180,7 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           return false;
>       }
>   
> -    if (event_notifier_init(notifier, 0)) {
> +    if (event_notifier_init(notifier, 0) < 0) {
>           error_setg_errno(errp, errno,
>                            "vfio: Unable to init event notifier for irq (%d)",
>                            irq);
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 2251facb35..ce9c014e6a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -418,7 +418,7 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>           return false;
>       }
>   
> -    if (event_notifier_init(notifier, 0)) {
> +    if (event_notifier_init(notifier, 0) < 0) {
>           error_setg_errno(errp, errno,
>                            "vfio: Unable to init event notifier for irq (%d)",
>                            irq);
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 7b907b9360..66e02b15a4 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -318,7 +318,7 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
>   
>       ioeventfd = g_malloc0(sizeof(*ioeventfd));
>   
> -    if (event_notifier_init(&ioeventfd->e, 0)) {
> +    if (event_notifier_init(&ioeventfd->e, 0) < 0) {
>           g_free(ioeventfd);
>           return NULL;
>       }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 94c174a773..1945751ffd 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -70,7 +70,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>       }
>   
>       ret = event_notifier_init(e, 0);
> -    if (ret) {
> +    if (ret < 0) {
>           error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
>           return false;
>       }
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 2f8f11df86..9c7634e243 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1075,13 +1075,13 @@ static int vhost_vdpa_svq_set_fds(struct vhost_dev *dev,
>       int r;
>   
>       r = event_notifier_init(&svq->hdev_kick, 0);
> -    if (r != 0) {
> +    if (r < 0) {
>           error_setg_errno(errp, -r, "Couldn't create kick event notifier");
>           goto err_init_hdev_kick;
>       }
>   
>       r = event_notifier_init(&svq->hdev_call, 0);
> -    if (r != 0) {
> +    if (r < 0) {
>           error_setg_errno(errp, -r, "Couldn't create call event notifier");
>           goto err_init_hdev_call;
>       }

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


