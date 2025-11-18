Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBD5CEDD98
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLMV9-0001Im-Gk; Tue, 18 Nov 2025 09:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLMUp-0001Gg-LT
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLMUo-0005Ln-9C
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763475344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=68RqYC/ed89RF9Eukjrx/fh3DZTcdRI5hnsv3QG9Mf0=;
 b=U7EmVuliJs62c/dq+PLubORhFmoWBnlgH8dZpePhuM8JScbHsN6EBT+CG1xU531KCq+4FG
 xiJoJ0EDM1iPORvNx/OljG3i9Yb7JFUhUA5seh3U4LKe6+Q8vuSinE6N9XxHaSofL5l6KU
 QoTjuFKG0qf4/XRwSbmcI5pvAPC/ylI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-t26uFMfpPFGmYnqRZONa1A-1; Tue, 18 Nov 2025 09:15:30 -0500
X-MC-Unique: t26uFMfpPFGmYnqRZONa1A-1
X-Mimecast-MFC-AGG-ID: t26uFMfpPFGmYnqRZONa1A_1763475329
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b478551a6so707391f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763475329; x=1764080129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=68RqYC/ed89RF9Eukjrx/fh3DZTcdRI5hnsv3QG9Mf0=;
 b=LDf5DcnO0gosfxSg7Yfy1fY1s4IeF+JE0e3mVDP91ZNzl8VceWIz1dQBlII7WIp+B9
 4SVIcdMAKytSDtvCdlZvfc1QbwcwEjHBgsKDCr3rd497tv3K6NdzW28uvk0U7Kc+CxSG
 EbzKQqsm6hRFrkrQRtmOeQLusyKami0o/WIHAK/iJkhfkvCajDwfXofw5McKfST5wDI2
 NPn1AIDbAMUaK3DHwCF2QOw8gdEVKALAJhupw4HAbb1jaq04FBGhIDf0cSByrsSy0ur+
 MY2tjuex46oBTJts4zRcQw83TwGdR76pzs4KhWxNW6M0Ytj93nmiIIRJ9TbbKdFMww0o
 XVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763475329; x=1764080129;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68RqYC/ed89RF9Eukjrx/fh3DZTcdRI5hnsv3QG9Mf0=;
 b=upWwf3drgq89Gf4H3ORxesQ/Xre2OmdiKdiUSnZP845UawwjT6Y6IfQPyj++XFftND
 H7AwO9r/+ysjThj2i+UrjxHN5f0R4CpFNhKcs8X32+hoWA2i3y5/v2yRNRWwZfoVH9TD
 EiyA/3kXLCVs04GsTA8z0K3CDoEorM2sG3Ly4BY8tD8z4w/tPqGNOKHqP52SJsTEF9R4
 TnKqy/h8WXTvMQ3kbghVGKO6mwm89hBqW3glkjkG4ubIbHNhnHKgkxGV/GT7GZJUh0Dk
 m3TtiYZW7/PsPSho4nyYSV8/c25eHFxf9Fddrf0faxz1hSukU1S2e5Lh/MLzfyYW/L+S
 OX8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdUUTCpg5KXhxMemn9c17Erx3qkcNeC/4+FIFQiwl+KVsXdtPG14y/NOx54i5QeaXGHn45dawlP5eP@nongnu.org
X-Gm-Message-State: AOJu0YyUlODFZ52pjq38cAtAC/g8N2ZvkSIFRd8+v68bCkvhBXbj3wRL
 AUkLnB3uTomWt5nExytmcT6xrDN+5FMOTFdO9tf40jp2BkVcLKR/AEJknzep8LWWMErwGRumv+q
 hjN4XDsgILQ9KsZYOwLAJ4rBJsHVYTx0Uk19yMRH+wY7dXO2sV8sJj9xjeel8yLMb
X-Gm-Gg: ASbGncvGTbXSwiceXAcaFDf1zrP0AIsM7s5x332pF+txOCe2K3cxZu+5Z2IkpSAZNgF
 koibekRnx7Era0ZXv+gDhi/939gQbIZYMyA1hRKba0foJthkcI7VnOYMqi9JJZEWvSUY5Mttd9r
 BaAl3VyfWxRA22c2ZViwnxSFuXHK5/jNKKAqd1KpIAxPnGG918u7HiOl5JIICnH7AIZ1uMw92UB
 qOP0425n4y9QvXBeAEy54m8zMRl/BCDG850rMm+UZLdF7GtkAqU9Ci2/TGXQwAvFzv9aXRe0p1S
 hSXU7n/F+Tj9Qig7vVSYuASDIgrXgDzKY1MXMWTsR4As3iVPmRBm7TuCNy2COfde/EG7ZWKGxzS
 CtXpFqDbBt23KXOOOV8vRMRp8zdpHCnWRdj0hGg==
X-Received: by 2002:a05:6000:1845:b0:42b:3aee:429e with SMTP id
 ffacd0b85a97d-42b5938a9d7mr15167195f8f.56.1763475328665; 
 Tue, 18 Nov 2025 06:15:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDPYfUBUKWzfqduz50rUrjYPcBilb5cFRtxKgcQRg3FHLatyJ/fRJO4kf8OVRdx6SVjEN3PQ==
X-Received: by 2002:a05:6000:1845:b0:42b:3aee:429e with SMTP id
 ffacd0b85a97d-42b5938a9d7mr15167164f8f.56.1763475328212; 
 Tue, 18 Nov 2025 06:15:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae16sm32820021f8f.3.2025.11.18.06.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 06:15:27 -0800 (PST)
Message-ID: <62a61f6c-4383-463a-91fe-53dd456c4e3b@redhat.com>
Date: Tue, 18 Nov 2025 15:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] vfio-user: simplify vfio_user_process()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-2-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
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
In-Reply-To: <20251117155656.2060336-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/17/25 16:56, John Levon wrote:
> It can figure out if it's a reply by itself, rather than passing that
> information in.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index bbd7ec243d..75845d7c89 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -147,8 +147,7 @@ VFIOUserFDs *vfio_user_getfds(int numfds)
>   /*
>    * Process a received message.
>    */
> -static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
> -                              bool isreply)
> +static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg)
>   {
>   
>       /*
> @@ -157,7 +156,7 @@ static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
>        *
>        * Requests get queued for the BH.
>        */
> -    if (isreply) {
> +    if ((msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY) {
>           msg->complete = true;
>           if (msg->type == VFIO_MSG_WAIT) {
>               qemu_cond_signal(&msg->cv);
> @@ -187,7 +186,6 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
>   {
>       VFIOUserMsg *msg = proxy->part_recv;
>       size_t msgleft = proxy->recv_left;
> -    bool isreply;
>       char *data;
>       int ret;
>   
> @@ -214,8 +212,7 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
>        */
>       proxy->part_recv = NULL;
>       proxy->recv_left = 0;
> -    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
> -    vfio_user_process(proxy, msg, isreply);
> +    vfio_user_process(proxy, msg);
>   
>       /* return positive value */
>       return 1;
> @@ -381,7 +378,7 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>           data += ret;
>       }
>   
> -    vfio_user_process(proxy, msg, isreply);
> +    vfio_user_process(proxy, msg);
>       return 0;
>   
>       /*


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



