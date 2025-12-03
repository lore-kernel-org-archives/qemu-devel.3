Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B86FD15DB7
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqdc-0002ZU-EE; Wed, 03 Dec 2025 12:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vQqdZ-0002Yl-4c
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vQqdX-0005Yj-8m
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764782847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xr5sbwxr9WEwzjjryVDwzcn9IndycFHvAwe1xYJeXec=;
 b=Uz3t6Gi4UiSLexv+iWA89gB99I8L8/qgZ0hzr/m3kyBVXuaVO9T3kMaLNbPdalJtXY9fh+
 JjFNprOLEFWWkUQ8+3gmdCvfSZIcRPf37MX2tudvaK1EjqtFbuYDU6ouEllv5SlbY4lQ8L
 ve36nlHEi70dfVMfKABlKIhy3Savp7M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-kVhK7wpIOLieM6JlvFU-fw-1; Wed, 03 Dec 2025 12:27:26 -0500
X-MC-Unique: kVhK7wpIOLieM6JlvFU-fw-1
X-Mimecast-MFC-AGG-ID: kVhK7wpIOLieM6JlvFU-fw_1764782845
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47799717212so15615e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764782845; x=1765387645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xr5sbwxr9WEwzjjryVDwzcn9IndycFHvAwe1xYJeXec=;
 b=H3UTnKCXv+eBv52aTWKc7LD6IQncyH61hPN5VTQdMwfxGp0qIFW5EB0YMlXvUvySex
 DkaU7z1tmjbTl3ZL2QpZZAQBbf86fcqmghheMlYSiDbWWWWDahdPPuu2BCC7UoFpubEE
 vtM7mQvfZ2dmfzMkSfiF8gWGtkAJi17rjikoRtoYvoW0KxUPVGoEvzPQuU6OTYG8Ky5B
 ZnGXQSHKjQP8IOJOd3KjMIO+ilfCyun89FUdA2apoUs+fBRw6Y7sDlBWBUfE8cDCgq11
 JbzQ+I8/Vp7oST9tk6Fgl0trTjndz+H4DmjzpgEBpcKQDSDmGSX/rEXAVm8UU1ohcD4s
 IH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782845; x=1765387645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xr5sbwxr9WEwzjjryVDwzcn9IndycFHvAwe1xYJeXec=;
 b=VXytyeSrM32K8rezJDxbuA767NAPu6YwQTu7FRE58VTgOVS81OaHN8HWoHZg0Hx5AC
 OaBrpr1ZPuT2niI/sF/3XEspL/X6P6uN0Yn5u40Ei0p4tRF/HjBomKToAJCfFVbIfCX9
 RAukRZPCdK7ddb5V8z9l0GImT63wtdRgj4tEVEjtjnHYuY/VKxqU7IKAjNpf+wfY80IG
 tM6VadEs1SEyooFIA1q7d63+XxZIyf36GO1V102KXkFALATPmnLx63FaMYAtPn2XC7IH
 OWjke9ZD8TfALTNr51oLcibL/alutrhVvfwswNrh2XL3r9is+W2667FrlpSuSAUZF1vj
 FQTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhsYaxSHrhjOTTMObDiqX+BhyOqeZ8UH1JD9Ba5TgYZzLQc+J0B70SxdLCXDr8UaXntnpdb6tuf3s+@nongnu.org
X-Gm-Message-State: AOJu0Yx9SzpWB14lgFqO2JOEscRgafGqP7xFE8+7p1+qSfYJmCrRrjKH
 1cgu1M+d34Te5k2XJH3+1DI6teCKb5YC5rZRUVwmyJEMeeMSfQRJiwS+Fuf5h2Ri1xkDN/g+PUI
 Aknev9CTed+lKyTYqdS7GizaTUrx4T+57ilQjNRJzhWvNequanlG7wRmU
X-Gm-Gg: ASbGncuu/r9B9+Rf8V7rMm07zPfAL2moyfQoYSKamBTQ8cxRZ1gmgL9Ccpar6+11C9v
 o07uimgdT5/exHlrBiKlEePCU4d0QP3fAHIfQIRZ9gQbiJjrIcq41dEL9TRLw9RfYRPKM6Kagwe
 gjcV5Za9EXBEKjK1Ijydq7CLNQZKuK2nvlnSVHeeeM/eZHh/igjX8VLbBlZBefkqJKM5X2tiG8P
 XrrDOBXEdICx+PcdLLDEPvjgvfbstW94qVDiyL0jPE0Nc+chTvPhivnxRqyLqJ2z7LHyEZEh74D
 Tw8llIb4t8bRoPpzvLaQ7eq1csqKrw9F7v8npxmmdQFH8GcpHnEnN7qvJmwQ6f1bj2UsiRJNDm5
 OV+StwGnR+Fm/MkqajbMliNCNq8zB4GjqAdWo+xUd2yjH72mD6VrwCXt3oKVg+Yb06O/t/DG2MJ
 rJctBD1KU4C5kqvEQ0Bfkcpq/TB5tGYbGSi4hmdZ8=
X-Received: by 2002:a05:600c:1c05:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-4792aef18fdmr43633055e9.15.1764782845228; 
 Wed, 03 Dec 2025 09:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHymQrAI0gsqrPNe1CFK5hGxEa+kD+DOw4eSwdaGt26NRnwIn5eztxG4DDFZ1UFzw+FXyxC3Q==
X-Received: by 2002:a05:600c:1c05:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-4792aef18fdmr43632755e9.15.1764782844747; 
 Wed, 03 Dec 2025 09:27:24 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1f06:69f0:3fbf:8d35:43f5?
 (p200300cfd7171f0669f03fbf8d3543f5.dip0.t-ipconnect.de.
 [2003:cf:d717:1f06:69f0:3fbf:8d35:43f5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca40945sm41535959f8f.30.2025.12.03.09.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:27:23 -0800 (PST)
Message-ID: <1c7784d0-8952-4b4f-9a5e-923bdaef9f2f@redhat.com>
Date: Wed, 3 Dec 2025 18:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2] file-posix: Handle suspended dm-multipath better
 for SG_IO
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qinwang@redhat.com, bmarzins@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20251128221440.89125-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20251128221440.89125-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28.11.25 23:14, Kevin Wolf wrote:
> When introducing DM_MPATH_PROBE_PATHS, we already anticipated that
> dm-multipath devices might be suspended for a short time when the DM
> tables are reloaded and that they return -EAGAIN in this case. The
> behaviour promised in the comment wasn't actually implemented, though:
> We don't get SG_IO_MAX_RETRIES in practice, because after the first
> 1ms sleep, DM_MPATH_PROBE_PATHS is called and if that still fails with
> -EAGAIN, we error out immediately without any retry.

How so?  `hdev_co_ioctl_sgio_retry()` is what issues 
`DM_MPATH_PROBE_PATHS`, and if it gets `-EAGAIN` it will return `true`, 
requesting a retry.

> However, meanwhile it has also turned out that libmpathpersist (which is
> used by qemu-pr-helper) may need to perform more complex recovery
> operations to get reservations back to expected state if a path failure
> happened in the middle of a PR operation. In this case, the device is
> suspended for a longer time compared to the case we originally expected.

In any case, this does warrant the change.

> This patch changes hdev_co_ioctl() to treat -EAGAIN separately so that
> it doesn't result in an immediate failure if the device is suspended for
> more than 1ms, and moves to incremental backoff to cover both quick and
> slow cases without excessive delays.
>
> Buglink: https://issues.redhat.com/browse/RHEL-121543
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/file-posix.c | 56 ++++++++++++++++++++++++++++------------------
>   1 file changed, 34 insertions(+), 22 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> diff --git a/block/file-posix.c b/block/file-posix.c
> index c9e367a222..6265d2e248 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -4288,25 +4288,8 @@ hdev_open_Mac_error:
>   static bool coroutine_fn sgio_path_error(int ret, sg_io_hdr_t *io_hdr)
>   {
>       if (ret < 0) {
> -        switch (ret) {
> -        case -ENODEV:
> -            return true;
> -        case -EAGAIN:
> -            /*
> -             * The device is probably suspended. This happens while the dm table
> -             * is reloaded, e.g. because a path is added or removed. This is an
> -             * operation that should complete within 1ms, so just wait a bit and
> -             * retry.
> -             *
> -             * If the device was suspended for another reason, we'll wait and
> -             * retry SG_IO_MAX_RETRIES times. This is a tolerable delay before
> -             * we return an error and potentially stop the VM.
> -             */
> -            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
> -            return true;
> -        default:
> -            return false;
> -        }
> +        /* Path errors sometimes result in -ENODEV */
> +        return ret == -ENODEV;
>       }
>   
>       if (io_hdr->host_status != SCSI_HOST_OK) {
> @@ -4375,6 +4358,7 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
>   {
>       BDRVRawState *s = bs->opaque;
>       RawPosixAIOData acb;
> +    uint64_t eagain_sleep_ns = 1 * SCALE_MS;
>       int retries = SG_IO_MAX_RETRIES;
>       int ret;
>   
> @@ -4403,9 +4387,37 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
>           },
>       };
>   
> -    do {
> -        ret = raw_thread_pool_submit(handle_aiocb_ioctl, &acb);
> -    } while (req == SG_IO && retries-- && hdev_co_ioctl_sgio_retry(&acb, ret));
> +retry:
> +    ret = raw_thread_pool_submit(handle_aiocb_ioctl, &acb);
> +    if (req == SG_IO && s->use_mpath) {
> +        if (ret == -EAGAIN && eagain_sleep_ns < NANOSECONDS_PER_SECOND) {
> +            /*
> +             * If this is a multipath device, it is probably suspended.
> +             *
> +             * This can happen while the dm table is reloaded, e.g. because a
> +             * path is added or removed. This is an operation that should
> +             * complete within 1ms, so just wait a bit and retry.
> +             *
> +             * There are also some cases in which libmpathpersist must recover
> +             * from path failure during its operation, which can leave the
> +             * device suspended for a bit longer while the library brings back
> +             * reservations into the expected state.
> +             *
> +             * Use increasing delays to cover both cases without waiting
> +             * excessively, and stop after a bit more than a second (1023 ms).
> +             * This is a tolerable delay before we return an error and
> +             * potentially stop the VM.
> +             */
> +            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, eagain_sleep_ns);
> +            eagain_sleep_ns *= 2;
> +            goto retry;
> +        }
> +
> +        /* Even for ret == 0, the SG_IO header can contain an error */
> +        if (retries-- && hdev_co_ioctl_sgio_retry(&acb, ret)) {
> +            goto retry;
> +        }
> +    }
>   
>       return ret;
>   }


