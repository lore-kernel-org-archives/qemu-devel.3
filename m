Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78710CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPycg-0000mW-0s; Thu, 21 May 2026 04:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPyce-0000mD-RX
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPycX-0004DR-W0
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779351549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Cs6nQ/kLNGu59KeqyKiDpXprztLUjKCGrWLBz7ePXvs=;
 b=bGGCGdavWS1HwD9ewIQNdm98L7RuvZIaqP8Lt8roSWtYMqI9WQ1fxrGdXTCndNXeOv09t9
 JBLGF9xVx5/SQ/TPNmzC+xcmEqXDUG/EMQwNzUd9Gt95/skKbXvzrOq3WQsLRUmU9g+hJN
 MHBRTzSEoyUwmcuq/OmP0alhifd8hYA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-83knrhtKPeKDwnll0rLwJw-1; Thu, 21 May 2026 04:19:07 -0400
X-MC-Unique: 83knrhtKPeKDwnll0rLwJw-1
X-Mimecast-MFC-AGG-ID: 83knrhtKPeKDwnll0rLwJw_1779351547
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44dad1b938fso3619251f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779351546; x=1779956346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Cs6nQ/kLNGu59KeqyKiDpXprztLUjKCGrWLBz7ePXvs=;
 b=iKZWw/2kcTJgTA8lcU2P1Z9Qpo4en2ARww8k5wBdKE+N+lnNzKYILKxaRvvSX+259l
 wud/dUNiU3VEVg84gfHSxbw2omp3QegQGl/kfpNdRYBzFHNUdXqCxbCSsYScfoYojX0m
 /oRbEb888ndKziNJo9hna1LWjoTs5IcvXA1zoMKez2ua/PUzrdI+6uj5JjqIuBOLGVDE
 i/g1GvAInx/NUXupxz0oB4jrH7+SzeZiWGWQEh5eLLFjfoti1wwKTpjigQmN4PfxMlr1
 jBPxo46OqwbOSB/Zl8Q+KHKUVIQh41tctQ7vfCQD4pnim3HsFGey+Qt4LWDRu7GOiehj
 n/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351546; x=1779956346;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cs6nQ/kLNGu59KeqyKiDpXprztLUjKCGrWLBz7ePXvs=;
 b=WArwifPajRYJz+Hibm5zZk/eA6XecpgS8CZa92tqQGm3J+tqZ1ykqkzoillhS2dOUg
 rFHpNp06W5wGfOadK2bOSQObU4o+Ubo2qfCwnYdRX+dS7MkI6NDV4EH1eqsjGBu1fvWv
 Qsgnpfx2Ex0BGfeU8T7vavpclyX27yZBsilM8QXaaTW6nmO7LjgH5euFrV+u0mOiU5+L
 eIaaX4jJ0keTY+czF2GimuZ1iNRIXxNwxFETXOC5CPg2UOj1iKPknC7AGjSFFWfKnskU
 OQ+ITuHaNCXNceAbIR2AbiG293YbqWn2qbLYcK+VLrLGI0GVAAYDFrW9Lzg0lP5PZjlU
 4cfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9t5g98tYv8He6N4pLNc+GeO68dJxjUMRKzOC5MV/MzZnxzWmxAy01TIwDDahcW+yu84uOR6RGS3S3T@nongnu.org
X-Gm-Message-State: AOJu0YxwjYyNHeh5glVZDFx6deat2C5H5Z+gFBMnF28UekcyRhE5/jV5
 8oCe3abgNip3tc6+4QGDEmMiKJ2uCx3Nie+jb+WbiA4oLQOwuKhvd0r4xk5QTXV6CotGIcyXm0m
 plxtb0OyaoTo5GnIdpvji+nsJ3+nOe96bO8+MKFCsjw/5ayzal+0aPhqX
X-Gm-Gg: Acq92OGwlJCqqgeYY5VPlQh6nDEgldz9tghYshmZRxKgbheTGj5JiNwN6tk5ANx3qX1
 MAb3/EPfM/HQYLU5FyngUipALm2UMOS4SvfPUmoGo4OK7tm+a96RxxetRJHVluIRebAGYcKkUo6
 Y/l9qOmrB/+nWM6lfwmXGWZLwemPNtm1xlYx1VxEe+lUHPeB4C93LMXvg3A9Q8kPlGzRPLS9kKh
 JZvPPkyMwFbz4gBdAnSu9rJX0NwI1twWpKhN4X9FTYTZq1HTadLSAw9ZnvHqCes740589cZ52jm
 0CB82Ki01jWbmvaGYbT8TsqBeQ9IE+CUiFvmlIEiohGmSJml8DLcFh74RYBtB3oO2cRM1ClA7vE
 +z7SJIEKRMY0Zx43kMIxYeEt5vAZdPI5GOhKN7YWQSq/LOFQVKCmHZEocj5n1
X-Received: by 2002:a05:600c:c086:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-4903605c9afmr17891585e9.13.1779351546409; 
 Thu, 21 May 2026 01:19:06 -0700 (PDT)
X-Received: by 2002:a05:600c:c086:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-4903605c9afmr17891065e9.13.1779351545889; 
 Thu, 21 May 2026 01:19:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035ea26b5sm10534785e9.22.2026.05.21.01.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:19:05 -0700 (PDT)
Message-ID: <e16976a6-1e46-4ed0-b1af-439c05abd9f5@redhat.com>
Date: Thu, 21 May 2026 10:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/39] MAINTAINERS: Fix F: in "VFIO-USER"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-37-armbru@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260521080511.999266-37-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/21/26 10:05, Markus Armbruster wrote:
> The commit adding the section added two bad F: lines:
> include/hw/vfio-user/ never existed, and subprojects/libvfio-user had
> long been replaced by subprojects/libvfio.wrap.  Drop the former, and
> correct the latter.
> 
> Fixes: 9fca2b7d70 (vfio-user: add vfio-user class and container, 2025-06-25)
> Cc: John Levon <john.levon@nutanix.com>
> Cc: Thanos Makatos <thanos.makatos@nutanix.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a1b1317cf..ca86e1410b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4468,8 +4468,7 @@ S: Supported
>   F: docs/interop/vfio-user.rst
>   F: docs/system/devices/vfio-user.rst
>   F: hw/vfio-user/*
> -F: include/hw/vfio-user/*
> -F: subprojects/libvfio-user
> +F: subprojects/libvfio-user.wrap
>   F: tests/functional/x86_64/test_vfio_user_client.py
>   
>   EBPF


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


