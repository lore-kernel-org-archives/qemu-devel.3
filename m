Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EB4C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3vT-0007rt-4d; Tue, 11 Mar 2025 14:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts3ul-0007oO-Lz
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts3ud-0003ZI-B0
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VW1CL9frrarvoxdOl5XMBB7PwrG1iWuIVjndMNqrPqg=;
 b=bC/hFiAGxWze1gacvssR0UvrmfhP7V4RCpr8X3j2RTYOUu1aog2KvmdqjRIm7gP8ZqI8Er
 jDHqjwv9VJoZOIyXqvdzFtNWMOqTGIhDc9MBzFgi1d/k25HLabf0rQwwVfRRhmaiXFeZGv
 PGcpCNjct2lAlMcQG5NuCVa15aFTkB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-EEH7eTEXMQGGNYtakObihg-1; Tue, 11 Mar 2025 14:00:56 -0400
X-MC-Unique: EEH7eTEXMQGGNYtakObihg-1
X-Mimecast-MFC-AGG-ID: EEH7eTEXMQGGNYtakObihg_1741716055
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ceed237efso23102475e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741716055; x=1742320855;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VW1CL9frrarvoxdOl5XMBB7PwrG1iWuIVjndMNqrPqg=;
 b=Sx0s1C7emdTDnuBPQn7fijtPeBfrYTVsvZQKtpn5+RAZCrYspnkpxgbG3Tv4xZZ8Oc
 M1u3S3GGEk4g0/RhNnzIBrPum1G4Pl+CFF8ABi4V6b/2qmkS9WtCTkGo2H2j/B2ffkI4
 ND/Z8+CvZAAqJbMEOXBlIIKXQA+1/03HXoAiflV1/+zBO9h3egpxxUIa5BfrBuYpYu1d
 gR7R+DKY78Fqgk3LLD0AeN3XlL338Krspfr6hbbhAwX7+8fzEr+7rjhTIC3t9FyIjKnH
 iaKZrdWrOMKt92BTRDL5JF56kwbPMtrj2x24IFM63JyHdKA9wpyCc1WGbKOmi9LTGb+A
 3stg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1wfAi+eP/9gpHJkk+eRIlVSQiKYbo0SD2wcdo3bNpMhFiZBZxeTRm1VIXtUjnz5gvL0c0QPOi4smG@nongnu.org
X-Gm-Message-State: AOJu0YzXVwv7A2qlEDxKHcxLCck/P4HYl0XeDDADr5+lhhokSHlFNoH2
 MZ/eNVLO319/vwwzyHd3zW0wq7pq1K/5dBxsMwCoyL/X1xqf3uPtwtZaa0fhIYIkTsYe+kcI4gU
 ClxuEy4Ads7kuTESiJIIZCYPWqzSqPRn5ctO/UP+gLpG0zfzL8+wM
X-Gm-Gg: ASbGncsbIFlbSncmjSvg2C5PxBrkEYWmjJ4N8fS+r4CB3RBU9XzykYWG0uyOIWpuKTl
 IaPi6jfZWI3I83HHAET7CO8yjS9pomIxZ3Yk4nEBHNgrRwtiR6nkJWMnMkTCIQw55ksRMwfbdiT
 1lauD18MRKOrQC9ku3dxrIswd39Ek8lIRpoX+Yn4Rk+BpSnueTUq0HFBbszbHAKFmWoKYunXT5w
 9kM2yjpng/mtl3TVdRO7qbwChVDIrX7qlp8+U/e0fFESKbqJhxJZUo3YfpMjIkACf/Dy5P3NzgP
 cV8mtTkVUTnkmSMxiPj8yxaSqRgUSEJCWcCmU1KjRtV3uzoHOMXa/w==
X-Received: by 2002:a05:600c:4f14:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-43d01be7e4bmr61478125e9.18.1741716054816; 
 Tue, 11 Mar 2025 11:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsu9/3LoX6tgO2LoxDP2UuVRJBPMU3at7IvwLOra5GVS3gJZhAXgehALgBv3fK3r7bI8DT0g==
X-Received: by 2002:a05:600c:4f14:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-43d01be7e4bmr61475915e9.18.1741716052956; 
 Tue, 11 Mar 2025 11:00:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c28f5sm188138005e9.9.2025.03.11.11.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 11:00:52 -0700 (PDT)
Message-ID: <54e1e265-6c18-4ad5-a2e0-384e35965b49@redhat.com>
Date: Tue, 11 Mar 2025 19:00:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Drop debug comentary from
 x-device-dirty-page-tracking
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250311174807.79825-1-joao.m.martins@oracle.com>
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
In-Reply-To: <20250311174807.79825-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/11/25 18:48, Joao Martins wrote:
> The intent behind the x-device-dirty-page-tracking option is twofold:
> 
> 1) development/testing in the presence of VFs with VF dirty page tracking
> 
> 2) deliberately choosing platform dirty tracker over the VF one.
> 
> Item 2) scenario is useful when VF dirty tracker is not as fast as
> IOMMU, or there's some limitations around it (e.g. number of them is
> limited; aggregated address space under tracking is limited),
> efficiency/scalability (e.g. 1 pagetable in IOMMU dirty tracker to scan
> vs N VFs) or just troubleshooting. Given item 2 it is not restricted to
> debugging, hence drop the debug parenthesis from the option description.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64629c13b6fb..3496a0b6b099 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3531,7 +3531,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>       object_class_property_set_description(klass, /* 9.1 */
>                                             "x-device-dirty-page-tracking",
>                                             "Disable device dirty page tracking and use "
> -                                          "container-based dirty page tracking (DEBUG)");
> +                                          "container-based dirty page tracking");
>       object_class_property_set_description(klass, /* 9.1 */
>                                             "migration-events",
>                                             "Emit VFIO migration QAPI event when a VFIO device "


