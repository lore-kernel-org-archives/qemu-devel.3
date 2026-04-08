Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9247310F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXx6-0006IA-E6; Wed, 08 Apr 2026 14:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAXx3-00065M-PE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wANYb-0002SZ-OP
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 03:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775634155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bF8H26On2tRleZefFZKJnag9r+H1LfR2omg73Fk6z54=;
 b=dVal13D0EBXuCoErTIKVsesWBwTSpyOMnyzuuQBoUbBz/TIYEUnctCISeWQaIdDnfjLgYs
 dfPCZndZwwIxLTnaQWrsY+93SGMrT5BlzWta8OTNV72Q6Y+uqSjfHueDefPm8yD+Rq9iZH
 /dkk15GwfLr0ai262/OVtqmQfBl+sfE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-nbMPVS7bM6m3ClQcF7NakQ-1; Wed, 08 Apr 2026 03:42:34 -0400
X-MC-Unique: nbMPVS7bM6m3ClQcF7NakQ-1
X-Mimecast-MFC-AGG-ID: nbMPVS7bM6m3ClQcF7NakQ_1775634153
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so5705565e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775634153; x=1776238953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bF8H26On2tRleZefFZKJnag9r+H1LfR2omg73Fk6z54=;
 b=oWGvORn58g3OAqQIY6LAA/HahEhQtyY/Sw2z1iA14iYnYhv9ruxJ1HoySFHekkmHMw
 m5/QJa96LbeIprAGPtwuRjnyElCdvwb7wPkw0/jzT0bNPZ7fBchv4LNSdgBBEOKfdKDA
 oUvy5YaY0yAzWsoqTAKCn5NJhxgh6ua2hdkknxj2GYATHzyZNy/77PfouXe8CXFl/kOn
 KS0D5m2VvrlOSr2w/q/dqFdgps3o9sl1yMp3YIGmldD3kn7loJjqcvqMQB3pn+cmRUIb
 5AZYS8Z6Z2PfmB5pXDUVCQZbucpCgtLk8NG6iARRKl3u/ekWSVv1Vb4eoceH3o+FL5mz
 SsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775634153; x=1776238953;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bF8H26On2tRleZefFZKJnag9r+H1LfR2omg73Fk6z54=;
 b=rn4+pmHNGWFW9Bl/x7ct0qoQtzdIOkkiPQZtZNGUBPkPSb4PChrJsAxfm4i2Rsqugy
 PRtKdz0fIZUpjWOZcvuI+HhtXVObFu9DE1ZntnLgixQgT4KElhB8z6j2BOSJnUWBYsfY
 xr5tTPBlY3YTTYBpKJvm+TubGf+/L4OX+/s2cqDk60L5hSqdXc+PySjSp2DiS9imnnyi
 6H5a0LU9NY2DnydqPWkxt5BIWzamIsM13zllbX1NcI2Ug/jojlxxPG0VRclVfNtv2gTz
 f1WYD1PXCkRGd2A8Yg67kgXizrzW6ocbsoiosbHeq5khg8TOTqbr9BNRP/LGIS/3lzOn
 krzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMg9AOh3ak9wMpcveR0LmcALo5wbYf0IY+fxzW+Keye31Tgqu5oAWtvmx3wgkTTiJE11vjOIOjUW6g@nongnu.org
X-Gm-Message-State: AOJu0Yx+6T28uap6BgeQ49hgT8+npy0yNgE/3LFbbv9XdZAziB/iE6vp
 D9pdjDuZY+Rag41Kz03yVcfA+EBQFxgbJ18E6JdWFJ3dV9DrfDaRXUFChAVFo/MEsrSP08FmrET
 qSbBztHexK1cO3nfRCb2B94j3vnz/lU0/3E/uwhitV43BvhJJ1jeI+bML
X-Gm-Gg: AeBDiesI0RPKo4+eTQwhsW3EVET73qXk26vKUHppRqRWy4XIYShQIJLXaBh2/oXu/rE
 XVloiOihceuFtKb79AXVFbGVkbxetynEMyb6mcyYqb23TMi4kbHsWyVhYxLo/L84+XOSSp1Ez4a
 Bdb0RsCoyFA1lEEtTVnnUVRQIUccSHMYF7xlFEFTgHCrojnWz53M9TAHg+8rTxKLuJLKLXPedIE
 /4A3bpFn2WIYSz+/zSSJl6bZi2QbSuS3geP1kXqCU4kDrdYnKLl/PRW8Hu8L9pTHGlJtIrr1n8m
 rKPpyOB1KiPaoUnRaRrjJnxUmxiWwXUeN4nvCG6q2CbCdnqNTQBO7lmUjGppTVdSZXX+3HQv978
 5tRprVo8LfKysW54NTL9yyT4htnF5mxpOX0kUHyGVjkneECkrGiIbGQn2+w==
X-Received: by 2002:a05:600c:c16f:b0:488:c239:d498 with SMTP id
 5b1f17b1804b1-488c239d786mr42656855e9.8.1775634152616; 
 Wed, 08 Apr 2026 00:42:32 -0700 (PDT)
X-Received: by 2002:a05:600c:c16f:b0:488:c239:d498 with SMTP id
 5b1f17b1804b1-488c239d786mr42656575e9.8.1775634152120; 
 Wed, 08 Apr 2026 00:42:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a65635fsm506081245e9.6.2026.04.08.00.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 00:42:31 -0700 (PDT)
Message-ID: <7493bf1e-7e85-454c-9a17-55febee66e58@redhat.com>
Date: Wed, 8 Apr 2026 09:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio-user: support VFIO_USER_DEVICE_FEATURE
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20260317195323.776669-1-john.levon@nutanix.com>
 <20260317195323.776669-2-john.levon@nutanix.com>
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
In-Reply-To: <20260317195323.776669-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/17/26 20:53, John Levon wrote:
> Plumb through vfio_device_get_feature to the vfio-user server. Note that
> we translate EINVAL into ENOTTY, as the existing generic vfio code is
> expecting the latter to mean "unsupported".
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/protocol.h | 12 ++++++++++++
>   hw/vfio-user/device.c   | 39 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> index 3249a4a6b6..2a0c31e7c5 100644
> --- a/hw/vfio-user/protocol.h
> +++ b/hw/vfio-user/protocol.h
> @@ -40,6 +40,7 @@ enum vfio_user_command {
>       VFIO_USER_DEVICE_RESET              = 13,
>       VFIO_USER_DIRTY_PAGES               = 14,
>       VFIO_USER_REGION_WRITE_MULTI        = 15,
> +    VFIO_USER_DEVICE_FEATURE            = 16,
>       VFIO_USER_MAX,
>   };
>   
> @@ -239,4 +240,15 @@ typedef struct {
>       VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
>   } VFIOUserWRMulti;
>   
> +/*
> + * VFIO_USER_DEVICE_FEATURE
> + * imported from struct vfio_device_feature
> + */
> +typedef struct {
> +    VFIOUserHdr hdr;
> +    uint32_t argsz;
> +    uint32_t flags;
> +    char data[];
> +} VFIOUserDeviceFeature;
> +
>   #endif /* VFIO_USER_PROTOCOL_H */
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 64ef35b320..6910d183d7 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -74,6 +74,44 @@ void vfio_user_device_reset(VFIOUserProxy *proxy)
>       }
>   }
>   
> +static int
> +vfio_user_device_io_device_feature(VFIODevice *vbasedev,
> +                                   struct vfio_device_feature *feature)
> +{
> +    g_autofree VFIOUserDeviceFeature *msgp = NULL;
> +    int size = sizeof(VFIOUserHdr) + feature->argsz;
> +    VFIOUserProxy *proxy = vbasedev->proxy;
> +    Error *local_err = NULL;
> +
> +    msgp = g_malloc0(size);
> +
> +    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_FEATURE, size, 0);
> +
> +    memcpy(&msgp->argsz, &feature->argsz, feature->argsz);
> +
> +    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, size, &local_err)) {
> +        error_prepend(&local_err, "%s: ", __func__);
> +        error_report_err(local_err);
> +        return -EFAULT;
> +    }
> +
> +    if (msgp->hdr.flags & VFIO_USER_ERROR) {
> +        /*
> +         * Client expects ENOTTY for "not supported", but the protocol may
> +         * return EINVAL.
> +         */

Is this errno tanslation due to the call in vfio_region_create_dma_buf() ?

EINVAL could indicate other issues. Is is safe to mask it ?


> +        if (msgp->hdr.error_reply == EINVAL) {
> +            return -ENOTTY;
> +        }
> +
> +        return -msgp->hdr.error_reply;
> +    }


We could add a trace event here ?

Thanks,

C.

> +    memcpy(feature, &msgp->argsz, feature->argsz);
> +
> +    return 0;
> +}
> +
>   static int vfio_user_get_region_info(VFIOUserProxy *proxy,
>                                        struct vfio_region_info *info,
>                                        VFIOUserFDs *fds)
> @@ -432,6 +470,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
>    * Socket-based io_ops
>    */
>   VFIODeviceIOOps vfio_user_device_io_ops_sock = {
> +    .device_feature = vfio_user_device_io_device_feature,
>       .get_region_info = vfio_user_device_io_get_region_info,
>       .get_irq_info = vfio_user_device_io_get_irq_info,
>       .set_irqs = vfio_user_device_io_set_irqs,


