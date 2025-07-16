Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC37C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1o0-0008J1-4r; Wed, 16 Jul 2025 09:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uc1gX-0003Bz-EE
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uc1gS-0002gZ-1w
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752670586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BXrNxjvyFHpViQBxomm0h75tvWZer25+/DefY724f9I=;
 b=bF4uBwKRdln7kbEqmF42ret4akaPmcN1skqKl9X6AowQd4kYYkJi5o9Wji2lhWcSZxXkNz
 nT1PNRbWOuaSkN0jUo8TVHrY1lfSHKQhikJOLW03K+5SG6f8xwvhLZ3StS52jTKR0imxTK
 pR1L3Xhf8Hxy9hRJxkzLvTmBse9SJj8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-qmlZzlDMM_edRwdWWZLqXQ-1; Wed, 16 Jul 2025 08:56:25 -0400
X-MC-Unique: qmlZzlDMM_edRwdWWZLqXQ-1
X-Mimecast-MFC-AGG-ID: qmlZzlDMM_edRwdWWZLqXQ_1752670584
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso4980530f8f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752670584; x=1753275384;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXrNxjvyFHpViQBxomm0h75tvWZer25+/DefY724f9I=;
 b=h1V1vPEVVKrFuuyOYgyZ1iTtOfxz1b7tIGvzJoOL3OE5wdCg2N+SpAoxylVf7iEGap
 YXpG4rGmqjUgi217OuvE5gFWt0UIwkbW1BatKTMA5YMXfI+XdODAC8mFDATqYfkJUhLc
 6NHVh3qnp4RLxt3YiDHpyY2CJca9ndOAqkQAUiStiRgrqcK3VOiH62z1LRC12/NFW65G
 48i3HIGTYEHqbV1btG3zN0Y/nIJgOFXMMwzHiZ+EuJ6hXiZgyWVIi1h5Wd2Wbnw/CU+/
 mJvRYSCDU51gip7HL8Hn4EwhXF/VnsCNFCjhSQGp8Ey3AOzY5pbE3AG78W/ifUGmkDIg
 dToQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkRE6W0piPGBLw4xPLYGMXAKRKmg6Q8EZjGXaRTfALGC3SCyh6rbfW8QxHe/VQo68tdmRCINeG4rs8@nongnu.org
X-Gm-Message-State: AOJu0Yx4sI2OBbX1GUFjN6uCMvmbEOr5vLdN3bp8uMYl1YjXqEOhzehX
 hHPJJ0ZcqxnS2oa6mVBJDpWsQot8SWhbWmIci+59vhNlEZI/kHMEHudecV106a6ePE69XvMh283
 PnYSSuhrU/lBadcirNerv5oTFWK+LYFmX9zuJwPEVCrPYguVBm44Jdnlg
X-Gm-Gg: ASbGnctQnnklP4l5TE+1PxPXUU+XquDLjkgCuzwBfpiX6oXdmTFw6MPICRFcQtJSjJz
 Oi5ZgbkJb3rmyas62u6QtEibGJnu51ve60rf2njK5C/abEuBQdGMye+78UmFWlRSqnPkwtb3MeB
 HxWXDAKq3EF4xKIlv5GzSopX1G0nD4ftBJTLWUPvQ7ZWEaVGC9UMPY5EsiQlQk8yl+/n2Y4Mp5v
 Z5x1J9bqG0qeYXSXvFGcflC68RbJAY2/hg/eA52zvApq+DxJRi4apUHxLaHNpjuL5vyUUF6i3iW
 g/iCZu46rJgR7R/cSpri+zFyvQOcVm5y+7U9cHqwy+i6xZWWGxkWAHBerKGaakpJOmHGGlxNDCw
 =
X-Received: by 2002:a05:6000:4311:b0:3a5:25e4:264f with SMTP id
 ffacd0b85a97d-3b60e51caa8mr2158777f8f.31.1752670583710; 
 Wed, 16 Jul 2025 05:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu9Qmupd0FoCZmGg0/HMdoFn5qoYKv7e2foN+FBmd68CYJoI9ZFk7v1L7TKVvONLJvaRK2hg==
X-Received: by 2002:a05:6000:4311:b0:3a5:25e4:264f with SMTP id
 ffacd0b85a97d-3b60e51caa8mr2158750f8f.31.1752670583265; 
 Wed, 16 Jul 2025 05:56:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d719sm17967265f8f.54.2025.07.16.05.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 05:56:22 -0700 (PDT)
Message-ID: <d6ec47f3-2884-4d4b-83dd-94008a24b6b2@redhat.com>
Date: Wed, 16 Jul 2025 14:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Recover sub-page BAR size when base address is
 not aligned
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com
References: <20250715065952.213057-1-zhenzhong.duan@intel.com>
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
In-Reply-To: <20250715065952.213057-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/15/25 08:59, Zhenzhong Duan wrote:
> Currently region_mr and mmap_mr size are recovered to original size when
> base address is updated to non-PAGE_SIZE aligned, but still leave base_mr
> with PAGE_SIZE size. This is harmless as base_mr is a only container but
> still a bit confusing when executing hmp command mtree.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1093b28df7..0455e6ce30 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1348,9 +1348,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   
>       memory_region_transaction_begin();
>   
> -    if (vdev->bars[bar].size < size) {
> -        memory_region_set_size(base_mr, size);
> -    }
> +    memory_region_set_size(base_mr, size);
>       memory_region_set_size(region_mr, size);
>       memory_region_set_size(mmap_mr, size);
>       if (size != vdev->bars[bar].size && memory_region_is_mapped(base_mr)) {

Looks ok to me. I'll queue it for 10.2 though.

Thanks,

C.


