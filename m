Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB35C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2tN-0003cE-2K; Mon, 05 May 2025 16:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uC2tG-0003Zb-EB
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uC2tD-0003QA-GP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746478694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8KrntjYaQaqrD6U/X5tQPbaF8+/udiebi34FpRJi7+4=;
 b=OGc7BZMmAbvfvJ3G/18ZFfFsiiywOrznGUQqcghmqbpfUYfWtl1BLKn54tp2xyDXSkUmgi
 BuJE8MFMveks2wiLxYtCYH+/uqC4jsT/f0ZExPZX96OSoeaZ2iRP4afHzBQ7Tq7Y0wseN4
 KzBiPhKdOPpT2mMwF2KjB3mbX+gHwYY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-loNN-3gbNrKrghLXiyhhYw-1; Mon, 05 May 2025 16:58:11 -0400
X-MC-Unique: loNN-3gbNrKrghLXiyhhYw-1
X-Mimecast-MFC-AGG-ID: loNN-3gbNrKrghLXiyhhYw_1746478690
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913b2d355fso1076100f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746478690; x=1747083490;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KrntjYaQaqrD6U/X5tQPbaF8+/udiebi34FpRJi7+4=;
 b=PXR7nh3UUXSlDJagy+K3REwo3wOZGsDjSAK9qBs2v9dRzNw8VXyltMuHrsPewAGxWv
 5hAwJJdAT72IqLHaCp0lJy7bpDF2JPuQg1K1mnRQnArUjH1MaZA1hXu7dI+xYqUCfxxX
 2+64AJXReAZ+8YirZIo6UQceaxOz+ObIlfh/oJbdk/ODmcowsnZRx2b5R3ZZNdoTqZkB
 1jVM94toB43YuyDFZ+bvruiaiX/Rg4HzPu1QqeEcT5PqlKnS6+8B2HHcYzkQ+EiBmtj/
 I+aGq9DMmezTi1X+TkA3bUcRVAcHufVrJdOPNOFrVlecGlrOQUEsBDYqPVdavv4m2mec
 cr0w==
X-Gm-Message-State: AOJu0YxUHzjgmo4S8utDY3MXemRL8u+n57WAskE/FlnEOSigm1vpwwJV
 oY717YPMrBJpAs6duBm0VGgLw28VdBdVm10rRhJXQi0Foygkj5XKR5uLN7NW3B3z7CHuYokXphi
 p1ox2g9ISKUpYK+KqV7wE9MZjVJoYkBEHiOyeGEKlTLhtdaOy8CJb
X-Gm-Gg: ASbGnct2kPN9uiELD3+pfxwOg5sLmB0Bim8QEQpUgcgUHIO4IX7OvHS4GUUQ979Bjlb
 6Zlk4ImR9d2mxnTDr4WkVR27ZNAsBCSMXvXL9a8hXHB5h0QOLoqGE+3lGuCfAqVODTdp4tRvy69
 lDif2RSQDS5KbihgS1zrLQEWeYWSyp8lvOgboLdU6ymvcOub1/CRNcpA2N9092HxnoZ47eXxw60
 nSJkURQ2TK/jwQ6r4Dkv8h6NXelLP2MfAhiQpIfZ1g4pda+yM34GnxWxG6vakYtv+c+nEHKsTDm
 c51Y+DPqbshV5IZ/sLe7e8cdgnoWjpwgzBLdNnurygj1w4byMg==
X-Received: by 2002:a5d:47a6:0:b0:391:4559:8761 with SMTP id
 ffacd0b85a97d-3a09fdd4dc1mr8348905f8f.36.1746478689912; 
 Mon, 05 May 2025 13:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbkfubHQOimKcW0VLQZgAqapXRTk7V786tI4FddxLVMH1sasmbNYVEngjwtZs4kyHSrwNLkw==
X-Received: by 2002:a5d:47a6:0:b0:391:4559:8761 with SMTP id
 ffacd0b85a97d-3a09fdd4dc1mr8348891f8f.36.1746478689537; 
 Mon, 05 May 2025 13:58:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3528sm11659298f8f.30.2025.05.05.13.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 13:58:09 -0700 (PDT)
Message-ID: <eb894117-98d4-45e5-a960-68f53ad9406a@redhat.com>
Date: Mon, 5 May 2025 22:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] vfio/igd: Detect IGD by OpRegion and enable
 OpRegion automatically
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <c.koehne@beckhoff.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
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
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/5/25 19:02, Tomita Moeko wrote:
> As proposed in a previous discussion [1], detect IGD devices based on
> whether it has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION exposed by kernel
> and enables OpRegion access by default. This enables out-of-the-box
> display output support for IGD passthrough without having to manually
> set x-igd-opregion=on, which probably saves effort for libvirt users.
> 
> This patchset also limits legacy mode to Gen6-9 devices, as Intel no
> longer provides CSM support and VBIOS on newer IGD, and Seabios does not
> support setting up the 64 bit BDSM register on Gen 11+ devices. Exposing
> VGA ranges to guests by default on platforms without VGA mode support is
> undesirable.
> 
> Additionally, as we enables OpRegion on IGD devices by default, and
> Intel removes the BDSM register from Meteor Lake [2]. There seems to be
> no extra register quirks rather than OpRegion required on newer devices.
> To support them (and probably future devices), the generation limit is
> removed, with BDSM quirk only applied to known Gen 6-12 devices.
> 
> Note: I have not been able to test this on Meteor Lake or newer
> platforms due to lack of hardware.
> 
> 
> [1] https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com
> [2] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/
> 
> 
> Changelog:
> v3:
> * Addressed a nit in patch #8
> Link: https://lore.kernel.org/qemu-devel/20250428161004.35613-1-tomitamoeko@gmail.com
> v2:
> * Removed "Allow hotplugging with OpRegion enabled", hotplugging is
>    always forbidden.
> * Test device is not hotplugged and get opregion in a single function.
> * Update documentation along with code changes.
> * Minor code style fixes.
> Link: https://lore.kernel.org/qemu-devel/20250421163112.21316-1-tomitamoeko@gmail.com
> 
> 
> Tomita Moeko (9):
>    vfio/igd: Restrict legacy mode to Gen6-9 devices
>    vfio/igd: Always emulate ASLS (OpRegion) register
>    vfio/igd: Detect IGD device by OpRegion
>    vfio/igd: Check vendor and device ID on GVT-g mdev
>    vfio/igd: Check OpRegion support on GVT-g mdev
>    vfio/igd: Enable OpRegion by default
>    vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
>    vfio/igd: Only emulate GGC register when x-igd-gms is set
>    vfio/igd: Remove generation limitation for IGD passthrough
> 
>   docs/igd-assign.txt |  11 ++-
>   hw/vfio/igd.c       | 220 ++++++++++++++++++++++++++------------------
>   hw/vfio/pci.c       |   2 +-
>   3 files changed, 138 insertions(+), 95 deletions(-)
> 
.
Since Corvin and Alex had reviewed and tested the previous spin :

   https://lore.kernel.org/qemu-devel/20250428161004.35613-1-tomitamoeko@gmail.com/

let's add the trailers to v3 :

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>

Moeko,

Please use b4 or equivalent to collect the trailers.

Thanks,

C.



