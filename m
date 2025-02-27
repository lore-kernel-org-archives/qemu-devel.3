Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E135C19F38
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXsH-0007VL-2r; Thu, 27 Feb 2025 02:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnXsF-0007V6-9V
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:59:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnXsC-0005zF-8B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740639595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2Ol04XdPLYTu+M/MIevYfieAvRIG/NSgxdMi0WH3eQ0=;
 b=fN/YTSe1nLevg5C5+rwaOEtuJ/a4Q/B+hXXI5ULv9ciV5AtdES6OKQ9jpvkxttLxD/hqYJ
 /aw2gPYj0CKtw8IaujSda4CKHjM8IaT8FiTAKCnMjOJexnLkutox7EONyWEp6Vs/zQMx2k
 /YUFZQz0KoJrI69ohVz6T1ZOuiPv/vw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-5AwaRw9FMO-6wxjnwKA8QQ-1; Thu, 27 Feb 2025 01:59:49 -0500
X-MC-Unique: 5AwaRw9FMO-6wxjnwKA8QQ-1
X-Mimecast-MFC-AGG-ID: 5AwaRw9FMO-6wxjnwKA8QQ_1740639588
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394c747c72so2260065e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 22:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740639588; x=1741244388;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ol04XdPLYTu+M/MIevYfieAvRIG/NSgxdMi0WH3eQ0=;
 b=BuMLpfV0M2PnKmWcOo5AZlmhbppR952i+WGp1b/KJFr+a4Sbny9DzADgFP883AzaKx
 iAhisMH0nKr021BMrYwGTk7M5cGdNZTVqsDO20eAFKQ8ybFV10CUebEqxGDRjbdIzR6Q
 B2CC1LAo8r4b8VUu4xlbUsiCZPgD3Nq1SYXFpOPU6Krk0O/R1Z41AK7ZCiqBhQRJWUNy
 RgXXG9zCso04Q0CFm83ABuOJass8UlLCI5v1rxdDfhzhLDQXb59e4oThgJSAWR53Dkvt
 pbs+R49TgsGu7i2aDmUgUzkGb+GDhNdzlAwwAEu2gDr+2g0z0BpVvsK4Kwp5IcsIiPXc
 t+Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiv9UTW8Xp0Y8E3IhvynidEs1TaZz0zxkKRCPNOI3m8P+Zf9NzPJ1lK/JTZb3+lJIdC6Yt3d3wrmXg@nongnu.org
X-Gm-Message-State: AOJu0YxpZ2M/SoqhdQC13XTEfchppzK2O4DsEo02A/XYUoThiiNNiA+c
 kMeTcgj8y4jF8/NG+D4QgBpDdMYoW7mmWUUsnRKRBb4Ojr01FJDFb4THNhvlPPOXehn9upUnCaE
 LBT/kfC7Wkn0xSGLG8EBr4KD6Q0fOF03u3Dw8yTZpqRS3X6FdNNV7
X-Gm-Gg: ASbGncubafm+1RG73LmgWlzPRKdt5OiuQ6zA1ZSs7K9pVWbr+Cq58y6tvTtYzjuWBdF
 0ScBjLvSiWS9jZhCW6NSHC141N68FSpZoXVY0+Y01epNWrwagSe39+x4+cESDkOHCKvd+VPjkRv
 nKntiiqS/tmB2IcVkLii51oVlWC5kFMPiBpP9zRfzj/t7nqW3ItXZsy52/r8RjaYcV+1gGrxSIH
 ApLS55/zM0pC6AOzFZ5XIEno6essgXe6kAYrT4T3h8XWcI9Dx56424s7uYQOjv3WwMc7s7U2i6+
 DoaRtvrHeDmy3uaJvH/X34DpCuLi1stcxjMBXhvfaEWTJhnaiq/xFMUlRFg=
X-Received: by 2002:a05:600c:190b:b0:439:5747:7f2d with SMTP id
 5b1f17b1804b1-439ae21cdeemr172894565e9.21.1740639588349; 
 Wed, 26 Feb 2025 22:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuvNqGx0KzeWj6Y3KM6ng9j2wPrA9o4XfvHRPiVp1rtFalh/YYnxc7moZC5wecV+xqy9E5Fg==
X-Received: by 2002:a05:600c:190b:b0:439:5747:7f2d with SMTP id
 5b1f17b1804b1-439ae21cdeemr172894395e9.21.1740639587925; 
 Wed, 26 Feb 2025 22:59:47 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b88asm44619525e9.4.2025.02.26.22.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 22:59:47 -0800 (PST)
Message-ID: <cbebee68-f891-4946-885d-01a8ed24e6c1@redhat.com>
Date: Thu, 27 Feb 2025 07:59:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 36/36] vfio/migration: Update VFIO migration
 documentation
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <2031790b755aa95b61470b286fa787b78be08107.1739994627.git.maciej.szmigiero@oracle.com>
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
In-Reply-To: <2031790b755aa95b61470b286fa787b78be08107.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Update the VFIO documentation at docs/devel/migration describing the
> changes brought by the multifd device state transfer.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   docs/devel/migration/vfio.rst | 80 +++++++++++++++++++++++++++++++----
>   1 file changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index c49482eab66d..d9b169d29921 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -16,6 +16,37 @@ helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
>   support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>   VFIO_DEVICE_FEATURE_MIGRATION ioctl.

Please add a new "multifd" documentation subsection at the end of the file
with this part :

> +Starting from QEMU version 10.0 there's a possibility to transfer VFIO device
> +_STOP_COPY state via multifd channels. This helps reduce downtime - especially
> +with multiple VFIO devices or with devices having a large migration state.
> +As an additional benefit, setting the VFIO device to _STOP_COPY state and
> +saving its config space is also parallelized (run in a separate thread) in
> +such migration mode.
> +
> +The multifd VFIO device state transfer is controlled by
> +"x-migration-multifd-transfer" VFIO device property. This property defaults to
> +AUTO, which means that VFIO device state transfer via multifd channels is
> +attempted in configurations that otherwise support it.
> +

I was expecting a much more detailed explanation on the design too  :

  * in the cover letter
  * in the hw/vfio/migration-multifd.c
  * in some new file under docs/devel/migration/



This section :

> +Since the target QEMU needs to load device state buffers in-order it needs to
> +queue incoming buffers until they can be loaded into the device.
> +This means that a malicious QEMU source could theoretically cause the target
> +QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
> +
> +The "x-migration-max-queued-buffers" property allows capping the maximum count
> +of these VFIO device state buffers queued at the destination.
> +
> +Because a malicious QEMU source causing OOM on the target is not expected to be
> +a realistic threat in most of VFIO live migration use cases and the right value
> +depends on the particular setup by default this queued buffers limit is
> +disabled by setting it to UINT64_MAX.

should be in patch 34. It is not obvious it will be merged.


This section :

> +Some host platforms (like ARM64) require that VFIO device config is loaded only
> +after all iterables were loaded.
> +Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
> +device property, which in its default setting (AUTO) does so only on platforms
> +that actually require it.

Should be in 35. Same reason.


>   When pre-copy is supported, it's possible to further reduce downtime by
>   enabling "switchover-ack" migration capability.
>   VFIO migration uAPI defines "initial bytes" as part of its pre-copy data stream
> @@ -67,14 +98,39 @@ VFIO implements the device hooks for the iterative approach as follows:
>   * A ``switchover_ack_needed`` function that checks if the VFIO device uses
>     "switchover-ack" migration capability when this capability is enabled.
>   
> -* A ``save_state`` function to save the device config space if it is present.
> -
> -* A ``save_live_complete_precopy`` function that sets the VFIO device in
> -  _STOP_COPY state and iteratively copies the data for the VFIO device until
> -  the vendor driver indicates that no data remains.
> -
> -* A ``load_state`` function that loads the config section and the data
> -  sections that are generated by the save functions above.
> +* A ``switchover_start`` function that in the multifd mode starts a thread that
> +  reassembles the multifd received data and loads it in-order into the device.
> +  In the non-multifd mode this function is a NOP.
> +
> +* A ``save_state`` function to save the device config space if it is present
> +  in the non-multifd mode.
> +  In the multifd mode it just emits either a dummy EOS marker or
> +  "all iterables were loaded" flag for configurations that need to defer
> +  loading device config space after them.
> +
> +* A ``save_live_complete_precopy`` function that in the non-multifd mode sets
> +  the VFIO device in _STOP_COPY state and iteratively copies the data for the
> +  VFIO device until the vendor driver indicates that no data remains.
> +  In the multifd mode it just emits a dummy EOS marker.
> +
> +* A ``save_live_complete_precopy_thread`` function that in the multifd mode
> +  provides thread handler performing multifd device state transfer.
> +  It sets the VFIO device to _STOP_COPY state, iteratively reads the data
> +  from the VFIO device and queues it for multifd transmission until the vendor
> +  driver indicates that no data remains.
> +  After that, it saves the device config space and queues it for multifd
> +  transfer too.
> +  In the non-multifd mode this thread is a NOP.
> +
> +* A ``load_state`` function that loads the data sections that are generated
> +  by the main migration channel save functions above.
> +  In the non-multifd mode it also loads the config section, while in the
> +  multifd mode it handles the optional "all iterables were loaded" flag if
> +  it is in use.
> +
> +* A ``load_state_buffer`` function that loads the device state and the device
> +  config that arrived via multifd channels.
> +  It's used only in the multifd mode.

Please move the documentation of the new migration handlers in the
patch introducing them.


Thanks,

C.



>   
>   * ``cleanup`` functions for both save and load that perform any migration
>     related cleanup.
> @@ -176,8 +232,11 @@ Live migration save path
>                   Then the VFIO device is put in _STOP_COPY state
>                        (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
>            .save_live_complete_precopy() is called for each active device
> -      For the VFIO device, iterate in .save_live_complete_precopy() until
> +              For the VFIO device: in the non-multifd mode iterate in
> +                        .save_live_complete_precopy() until
>                                  pending data is 0
> +	          In the multifd mode this iteration is done in
> +	          .save_live_complete_precopy_thread() instead.
>                                         |
>                        (POSTMIGRATE, _COMPLETED, _STOP_COPY)
>               Migraton thread schedules cleanup bottom half and exits
> @@ -194,6 +253,9 @@ Live migration resume path
>                             (RESTORE_VM, _ACTIVE, _STOP)
>                                         |
>        For each device, .load_state() is called for that device section data
> +                 transmitted via the main migration channel.
> +     For data transmitted via multifd channels .load_state_buffer() is called
> +                                   instead.
>                           (RESTORE_VM, _ACTIVE, _RESUMING)
>                                         |
>     At the end, .load_cleanup() is called for each device and vCPUs are started
> 


