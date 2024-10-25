Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A5DD149C1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Msb-000373-NN; Fri, 25 Oct 2024 12:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t4MsP-0002qs-GD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t4MsN-0005PQ-Rv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3d3atI9RzcNoaopQtlnwLcsKduUq0PvI7XHn79LYRYQ=;
 b=TY5ARnNxSqpCvpsvYcxNXC5K2HsTgUpJIS64/dxHmfkbiGziabPA0cUJVAq0oBSoYb9o0i
 w5JaK2m9KTDIykHCAojYLmSAJOHPv00pJ7yG4E44Wb7n6Aey27wI6fliLeJI0VKKjBdBxX
 5FWvOB1/adTsQxeCd3idH9tlSODnXBA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-x0TVRa6lOlK_m0zVyzoh8A-1; Fri, 25 Oct 2024 12:09:20 -0400
X-MC-Unique: x0TVRa6lOlK_m0zVyzoh8A-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-710cbc3ddfcso2103142a34.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872560; x=1730477360;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3d3atI9RzcNoaopQtlnwLcsKduUq0PvI7XHn79LYRYQ=;
 b=PGC69uU65h3klttNZ3Cqb3viAZyX5FTRg7O7Kl2694kGE1+XJPrkhG084ePaRmRRer
 j/wtm1p2MI4fHq7Wt3NQhJ8CRjxeGYknTVIXlYlWAVni5MGa4GTrDLvFyPGH3GfSAexq
 nnF1AZd3TjOiEuUSY8KF6LLhDuMgNGzoeOPwcUAlpnGy2bmxq9vxBW22Wvb7/UlOv9Xc
 BRcZMyclxvJwp8rdcThxRGG6Busr19TbOt1wGqG9gUudWBy0UsGf6cc9PFYxvlKaJSch
 AKUWRWqA2aL/7kZIALREBVV/ZMqHXVUUVwJfDsBE8esOWH7Nj7d2Oc0UqIp36q4N17df
 +ztA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP6X/oFCV8OOAeJGk3ln7YDxlNs6rLbtjEZ4ul+PEM3uJVWi/jlydKh58rDJvTG+J+IzxiKEgtvH3g@nongnu.org
X-Gm-Message-State: AOJu0Yw07BESzNvScbeN0erNX3+sfgtefhK2wx7PxOeADOaRBmC3VZzS
 2PTPu13tUKC8yh9AoBJeYWVnxc0dFJfgYAXJp7CFFcgh+u605rz+83ZnvD9jp0c1GYey3amdh1+
 /g24u7CpdKN7y21p6PjUpHkjM/RXtZLZwQpMW9rpOY8T/SRVvX+N5
X-Received: by 2002:a05:6358:7188:b0:1b8:3242:3286 with SMTP id
 e5c5f4694b2df-1c3e4d1f22cmr374407455d.12.1729872560153; 
 Fri, 25 Oct 2024 09:09:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5jDJrABVIk2OkL6p2Z3VHnvswOp3lbDpK0JeTjasccK3NPSJ4zhz69YD//Piehav3NV/p7Q==
X-Received: by 2002:a05:6358:7188:b0:1b8:3242:3286 with SMTP id
 e5c5f4694b2df-1c3e4d1f22cmr374404155d.12.1729872559835; 
 Fri, 25 Oct 2024 09:09:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613211a109sm7185621cf.8.2024.10.25.09.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 09:09:19 -0700 (PDT)
Message-ID: <b04df140-4754-4ebf-b369-c7d42a69b2ab@redhat.com>
Date: Fri, 25 Oct 2024 18:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vfio/migration: Report only stop-copy size in
 vfio_state_pending_exact()
To: Michael Tokarev <mjt@tls.msk.ru>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-2-avihaih@nvidia.com>
 <0dc26cff-2e25-4b9e-9e38-8536aaadbe0f@tls.msk.ru>
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
In-Reply-To: <0dc26cff-2e25-4b9e-9e38-8536aaadbe0f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/25/24 17:18, Michael Tokarev wrote:
> 20.10.2024 16:01, Avihai Horon:
>> vfio_state_pending_exact() is used to update migration core how much
>> device data is left for the device migration. Currently, the sum of
>> pre-copy and stop-copy sizes of the VFIO device are reported.
>>
>> The pre-copy size is obtained via the VFIO_MIG_GET_PRECOPY_INFO ioctl,
>> which returns the amount of device data available to be transferred
>> while the device is in the PRE_COPY states.
>>
>> The stop-copy size is obtained via the VFIO_DEVICE_FEATURE_MIG_DATA_SIZE
>> ioctl, which returns the total amount of device data left to be
>> transferred in order to complete the device migration.
>>
>> According to the above, current implementation is wrong -- it reports
>> extra overlapping data because pre-copy size is already contained in
>> stop-copy size. Fix it by reporting only stop-copy size.
>>
>> Fixes: eda7362af959 ("vfio/migration: Add VFIO migration pre-copy support")
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> 
> This smells like a qemu-stable material (for 8.1+).

I am in favor.

Thanks,

C.



