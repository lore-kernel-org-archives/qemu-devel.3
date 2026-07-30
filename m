Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85286C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKjd-0005V9-Fe; Thu, 30 Jul 2026 02:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wpKjM-0005U3-7n
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 02:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wpKjG-0006FC-VX
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 02:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785394733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bVqW3OqF7gXpmAZXUgLLKd95bHCHuApXJJdj9byykOE=;
 b=bi4DwlzaGsTFMaGbwo/L6fC4fDTQtniroNbkUcqVmZSSKaWYP544a8viBiMY5j8vss3hGD
 2gqutuuAkh1Atk+BqQwhog0lYSq04SR+FPErSG4vLx6ZyDQcl+ImTtrleyNzcpB8XYfIBU
 8ELo5wy/oMkJbPEnJ69fD8S4EE5hm+A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-pNyZPPHRNJWJ5hoSCOtVbA-1; Thu, 30 Jul 2026 02:58:52 -0400
X-MC-Unique: pNyZPPHRNJWJ5hoSCOtVbA-1
X-Mimecast-MFC-AGG-ID: pNyZPPHRNJWJ5hoSCOtVbA_1785394731
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-698c181a258so2036358a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785394731; x=1785999531; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bVqW3OqF7gXpmAZXUgLLKd95bHCHuApXJJdj9byykOE=;
 b=rck42TfCqJah7MCHMvYfmXuztwFHGLMqzqyCt+KVnu01LMSWRcziz9/bMn4Ftk7u3d
 G8RV1q7hIM56BHCZ87e7s9xHXHxV0VuXZ8PkBeTtt3hXqYmfO8oZDlarYAXq7mnrG/Qs
 TsKnfrriCxKqgP2i8P0zlOLgaK70Xqtp3eGy2GmoW6yVdwrvsQ7Nc+pByn6EXFJjanNQ
 oHBxXkAEEbx68d0/PlF//KvW2aQ840es2P2Ac57b8DDTubu5etFXsKIcOsZm3dSEUlyy
 iC+S0tsaoPEwaSF4Au0okdJ1WVXpqk4o5iRE0zh59LbLZY/EMKtor1FOKL/3OMwV79fB
 5mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785394731; x=1785999531;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bVqW3OqF7gXpmAZXUgLLKd95bHCHuApXJJdj9byykOE=;
 b=Lgql/aTU/aGTyxtHYukSnFFrMkbRrjaClizDPmw7Ng9K3CQTez5z2Bo1yugXTHO1U+
 8Yd7md776TERRL4iTnKf0zbwOt96Xkrim7aaVhsMOdKeIW3oF4WK8Jgf4o2wuRPHnGGa
 fXQ7/CNiAaBezMuV6o0ZG7rpha8IiVq1R/bUGMe5YozHPM6G6SbheuPciz8v9W++tdCT
 qUYBZClZOoBVeGfE5xvmK1BAoj7HjBuYnSeoucQfjg5r2+e/PBcjoW2ZNdfWPsrrnjHX
 y9dktqMorta6YLYrQDuAmDcHemLc4kbRaeuP9e1RJhNsV64DMzKyUcYJRb/ZKgI0s5KL
 EUyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXwiwKlSAR3twkSL6UerpGHIU0kwwDDc0nVbfznrEuWury7aB9tJuTLlfv0ScsX3P2ZGTKSfMD8f3V@nongnu.org
X-Gm-Message-State: AOJu0Yzhcu6S4Et6ItQvbYTSN6HYlXzVnU5zH+W/Fub+ApsBD1pp9ypX
 00z0qDEPReEWI1LEgN99GAd8QIMcfgtY7RSIjgrx5uKCsTUf2F7SoIB309Fw14uoxnOcR16AHXv
 HVJgYNa5/WAgYfXFTmWfaVvwHp+W+AN7bSis8snnB9RjKNZcm5d88cg3M
X-Gm-Gg: AR+sD11j5xlSdPredLTsHojY4hanIf90zvhHBtkUCSknO36i2hgpIkiUVUbY72VCwit
 3+WichgvmAG8tWaq2bEeZIMPV1KkmgjmS2y0FjBxLfHTVhSvgBVLUtp8bECoFrtLui1UEEWbCF4
 W71ikp6np4fgwr6lpFDYVBBJiCMC3gQEl/O8+5PHDgYOAAPpNYu5aBx2qPbTKJEspsi8WU+5jD6
 B0KfDl11RxRmHJpSc2SYfZdsocJO+zyRhrC4Qlr/L94UetI1TEZgpeolelctzq6F96uTbHmgQ74
 qQpH1oIL+yk0IKhWrOYpny/Zjmk85v77ow7jfCzxYJgA8V+gUmTfpRTEspPSRqq8KWUbD6I=
X-Received: by 2002:a05:6402:40c5:b0:698:4a62:a297 with SMTP id
 4fb4d7f45d1cf-6a07b80eda2mr648173a12.17.1785394731006; 
 Wed, 29 Jul 2026 23:58:51 -0700 (PDT)
X-Received: by 2002:a05:6402:40c5:b0:698:4a62:a297 with SMTP id
 4fb4d7f45d1cf-6a07b80eda2mr648154a12.17.1785394730608; 
 Wed, 29 Jul 2026 23:58:50 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.51.53]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a07c768d9esm251113a12.3.2026.07.29.23.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 23:58:49 -0700 (PDT)
Message-ID: <a155a5de-6459-4055-a1ec-699c4e5d5d4f@redhat.com>
Date: Thu, 30 Jul 2026 08:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] hw/char/virtio-serial-bus: validate
 nr_active_ports from migration stream
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260729231904.775331-1-lvivier@redhat.com>
 <20260729231904.775331-3-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260729231904.775331-3-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/07/2026 01.18, Laurent Vivier wrote:
> The migration restore path reads nr_active_ports from the incoming
> stream and passes it directly to fetch_active_ports_list(), which
> uses it to size a heap allocation. A crafted migration stream can set
> this field to a very large value, causing QEMU to attempt a
> multi-gigabyte allocation and abort.
> 
> Fix this by checking nr_active_ports against the configured
> max_virtserial_ports before calling fetch_active_ports_list().
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 6663a1956eb6 ("virtio-serial-bus: Maintain guest and host port open/close state")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3801
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Notes:
>      v2: add error_setg() call with descriptive error message
> 
>   hw/char/virtio-serial-bus.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 87bfe51b6e93..4a5507e2f755 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -803,6 +803,12 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
>   
>       qemu_get_be32s(f, &nr_active_ports);
>   
> +    if (nr_active_ports > max_nr_ports) {
> +        error_setg(errp, "Invalid number of active ports %u > %u", nr_active_ports,
> +                   max_nr_ports);
> +        return -EINVAL;
> +    }
> +
>       if (nr_active_ports) {
>           Error *local_err = NULL;
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


