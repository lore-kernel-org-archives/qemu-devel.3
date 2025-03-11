Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF3CC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1ow-0006Pd-RA; Tue, 11 Mar 2025 11:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts1o1-0006Dd-Uw
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts1nw-00038y-Vn
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741707964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xs0ERJe9F2swJdSHC5Oe6CDdXEyucMb2Pg0H3anx9NA=;
 b=XW1imT6Zm6/78QQVLHAIauBTmbh71fw1RFEO7bP15exYYxa0Hpk2K8UU/EY1jbZqr8KsTi
 PZ/D8EYVzS5NQGJVtiu3E1sGzrSnhtIkVhBeEObq9pSkRE499yKpT6H3g8rVT6pelT5h7F
 v4cB0jKp8MvEZ83BlEKu5D4H+QavNuU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-p2RNi9Z6OKq-WrxAc-Joew-1; Tue, 11 Mar 2025 11:46:01 -0400
X-MC-Unique: p2RNi9Z6OKq-WrxAc-Joew-1
X-Mimecast-MFC-AGG-ID: p2RNi9Z6OKq-WrxAc-Joew_1741707960
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so12831735e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741707959; x=1742312759;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xs0ERJe9F2swJdSHC5Oe6CDdXEyucMb2Pg0H3anx9NA=;
 b=esS4B06zY9g0sDg96XQlAmKdvRiK0YRSgj3wSHi54T3OGwaTDm4TzHn+Mu2ImwdvH9
 y4g6djwnefnVXHrJDfrm8P4eT/ge6yfx60/8fDdsnsi/UMLv56sCAPRjMiSHfvsWaLpW
 ZQRH5Rhfk3gbHgzoxjHlY+t88dIoirrViUPxq+oEiJpWMFilwFmVJjzFs0YdfKm6DSKW
 TJypEA5DV3KXLFj4QjUL1NesC+5Y/MkPHqeLZ/VnIp/uU0wCWe47hGnPC+7EpTVx/uAJ
 F52kiVrOjkBfJPgVvTYoPPF1HqbNK7RGI1t5euIrDMm++wxs/7I7c20+lrXE97X6SkBl
 +lVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWozmNTdF3xFqN4EQL4MzD1GiM57FyTfC2JpE++uw/Fb4659+hjCdE9h0B/K7EED6wtTA1z+PE+DusA@nongnu.org
X-Gm-Message-State: AOJu0YyxX0O23iApDA0zw2LmJyqtUF2c/k5U5JXOX4pP7FNDjU5duq88
 O2YcrRrVts+5c54Bcslj/nAZKEBxALoewnuaO/doOdjdkllqwAChm/yIf77DF0QHGAI8Wd9JPPs
 LuZISriMvG1hmk4FMeuHleKONvpK5vDIl70nhfH0RF5J7IkwOQdoeWmRqBvQ6wr4=
X-Gm-Gg: ASbGncsEVqix22PgexmgrvUdl8+13MWUr5OK32s7pUGtvBf/koBmNajHRkXDy3UnXHd
 qKtIn134a9ZaKMfoNDMiR0+3gYqYey/la9fbVcrAdT7Wapa+FtRg4MovhEEWr9jUiceCqf2fH7J
 bafBn8swLfnhtmFfrR/GUQH51rvbnFugk3QHL3p7xnWhwmX2OOrCIcM8KkMPDERXYivneZ3XpDt
 2AxWLgYqH+bnP1hdfGENA2O+AwAZlWhERfzRSI/EKxd6GRmvL/Ff3+GmT2f9uSurB32M6M8Jua4
 oOww4sTtipA2ZmHI43Qk5BGGLdkmUITjySawixJCht2xLo7QqslMGg==
X-Received: by 2002:a05:600c:5493:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-43d01be65ebmr56805995e9.13.1741707959314; 
 Tue, 11 Mar 2025 08:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBEkwpy9qi9Gh7JgPXl7TdjVa12F+PVQKB4OwAXwtwgz4iTuEps2mnlWdSkuYV97WU0Dao+A==
X-Received: by 2002:a05:600c:5493:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-43d01be65ebmr56805825e9.13.1741707958979; 
 Tue, 11 Mar 2025 08:45:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d03fd715csm13709265e9.1.2025.03.11.08.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:45:58 -0700 (PDT)
Message-ID: <29b9c917-8a3f-4d09-a5cc-2ede94856ebd@redhat.com>
Date: Tue, 11 Mar 2025 16:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vfio/pci-quirks: Exclude non-ioport BAR from ATI quirk
To: Vasilis Liaskovitis <vliaskovitis@suse.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com
References: <20250310235833.41026-1-vliaskovitis@suse.com>
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
In-Reply-To: <20250310235833.41026-1-vliaskovitis@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/11/25 00:58, Vasilis Liaskovitis wrote:
> The ATI BAR4 quirk is targeting an ioport BAR. Older devices may
> have a BAR4 which is not an ioport, causing a segfault here. Test
> the BAR type to skip these devices.
> 
> Similar to
> "8f419c5b: vfio/pci-quirks: Exclude non-ioport BAR from NVIDIA quirk"
> 
> Untested, as I don't have the card to test.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2856
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> ---
>   hw/vfio/pci-quirks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index c53591fe2b..15598bbaf4 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -403,7 +403,7 @@ static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>   
>       /* This windows doesn't seem to be used except by legacy VGA code */
>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_ATI, PCI_ANY_ID) ||
> -        !vdev->vga || nr != 4) {
> +        !vdev->vga || nr != 4 || !vdev->bars[4].ioport) {
>           return;
>       }
>   



Applied to vfio-next.

Thanks,

C.



