Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A6EEE645E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sof2q-0007BQ-36; Thu, 12 Sep 2024 04:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sof2k-0006oS-FT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sof2h-0005hF-K8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726129145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a6zpEcjZI9D0oME9ln+3X8iA6hTzuQBZ+WnGYnWpMnY=;
 b=EkkI3SCEWnUPxYHe5Rht4Vjo4T7ezf5nrva9LaiSy9NiTVgl9gGoEPobBf5H7cinl7jPK4
 jJEv6CpR99zvvy2lMUfUIanbX987oWLmhCzDtT+yARJSduiXXEyQC9scR+2z4WR3eacuVf
 PJFo6VGn0Iv/mnxHLlNrYMaAak1k0w8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-RKxsvEDJMpe-P748QhAuXg-1; Thu, 12 Sep 2024 04:19:04 -0400
X-MC-Unique: RKxsvEDJMpe-P748QhAuXg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb89fbb8cso4129435e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726129143; x=1726733943;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a6zpEcjZI9D0oME9ln+3X8iA6hTzuQBZ+WnGYnWpMnY=;
 b=WuqnB46nxQs0Us946nUpVz30eLM0wGLp49P6EVC/d0GiBWwEgsu5OfgBReK3L1wZpF
 5HylrJe9Myct/vXYq89/8508q8RPLZPgpxn9kIoCSbu8ks5N4mG0XkWK78Q5fKKhs07B
 Ng6p+KJl1fZWu0INAQq97bwsGdva+UO4taF9V2qs20N0KjOsf7PJTuN/uUgMH7nWhDQv
 26+HgfDx2fhYah3/R2KpnIGZ1HwR9Ehuj64Ku5N9VtWt+OofaOPj0IE1JjhVl4AK1HDF
 yjlP16mhcyw5K2mQ3VBVIG8QihPYO4eobP34PNz5vuNrVEvGj1VsIT9Krz8nNHq3GDP8
 P7Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJp6nOM3olTQLzqqXZo0B6LbH1p/rsaHNM17czriW9ZNdIrAnD2N/UO6uKaNf8aadclRzL545Slz4L@nongnu.org
X-Gm-Message-State: AOJu0Yzrwk49EF8hCVTTlV1Fm4FUz2r+xfLGxmWz5d4CsY9E7AtxB16e
 Naqjr9IK+hgxRvuMlu7JWPf0B8aow5X3XQtQc7sgCRhz7mcFejGygbxqXRIuCk17Pnkz2laOo6o
 3u5LOEeCEJOyuFnj/bnGapIsqwPeCHAT8InYBOMdVHo+tTDcipfKJ
X-Received: by 2002:a05:600c:3595:b0:425:7884:6b29 with SMTP id
 5b1f17b1804b1-42cdb53f541mr12928635e9.19.1726129142655; 
 Thu, 12 Sep 2024 01:19:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwE7/jszeDZt2/3ySaiqfhPft1FBORYa+TO8ywl1PmiVV+r4LPswMGZhFxjmSJQ90qRvIZNw==
X-Received: by 2002:a05:600c:3595:b0:425:7884:6b29 with SMTP id
 5b1f17b1804b1-42cdb53f541mr12928345e9.19.1726129142101; 
 Thu, 12 Sep 2024 01:19:02 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-122.web.vodafone.de.
 [109.43.178.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21b1bsm165613805e9.2.2024.09.12.01.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 01:19:01 -0700 (PDT)
Message-ID: <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
Date: Thu, 12 Sep 2024 10:19:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500
 STORAGE_LIMIT
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-8-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240910175809.2135596-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/09/2024 19.58, David Hildenbrand wrote:
> A guest OS that supports memory hotplug / memory devices must during
> boot be aware of the maximum possible physical memory address that it might
> have to handle at a later stage during its runtime
> 
> For example, the maximum possible memory address might be required to
> prepare the kernel virtual address space accordingly (e.g., select page
> table hierarchy depth).
> 
> On s390x there is currently no such mechanism that is compatible with
> paravirtualized memory devices, because the whole SCLP interface was
> designed around the idea of "storage increments" and "standby memory".
> Paravirtualized memory devices we want to support, such as virtio-mem, have
> no intersection with any of that, but could co-exist with them in the
> future if ever needed.
> 
> In particular, a guest OS must never detect and use device memory
> without the help of a proper device driver. Device memory must not be
> exposed in any firmware-provided memory map (SCLP or diag260 on s390x).
> For this reason, these memory devices will be places in memory *above*
> the "maximum storage increment" exposed via SCLP.
> 
> Let's provide a new diag500 subcode to query the memory limit determined in
> s390_memory_init().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-hypercall.c | 3 +++
>   hw/s390x/s390-hypercall.h | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
> index f09e8a1d81..ac48fc0961 100644
> --- a/hw/s390x/s390-hypercall.c
> +++ b/hw/s390x/s390-hypercall.c
> @@ -68,6 +68,9 @@ int handle_diag_500(CPUS390XState *env)
>       case DIAG500_VIRTIO_CCW_NOTIFY:
>           env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
>           return 0;
> +    case DIAG500_STORAGE_LIMIT:
> +        env->regs[2] = s390_get_memory_limit() - 1;
> +        return 0;
>       default:
>           return -EINVAL;
>       }
> diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
> index b7ac29f444..f0ca62bcbb 100644
> --- a/hw/s390x/s390-hypercall.h
> +++ b/hw/s390x/s390-hypercall.h
> @@ -18,6 +18,7 @@
>   #define DIAG500_VIRTIO_RESET            1 /* legacy */
>   #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
>   #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
> +#define DIAG500_STORAGE_LIMIT           4
>   
>   int handle_diag_500(CPUS390XState *env);

Reviewed-by: Thomas Huth <thuth@redhat.com>

Sounds very reasonable to me - but it would be good to get an 
Ack/Reviewed-by from IBM folks here (in case they prefer a different 
interface)... hope they'll join the discussion!

  Thomas


