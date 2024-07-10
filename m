Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FFEC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 13:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRWvb-0004WG-9R; Wed, 10 Jul 2024 09:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRWvY-0004Mn-EZ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 09:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRWvW-0006gX-Sf
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 09:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720616406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Du3Or/ZVnc+iBOB6ZOr6H7VDhpS2uXNBdWrPo9+n1dE=;
 b=B9/mRetDnUbbIPfGs49FqPba7y7TPzXPyv1fXAfyu7PiQAN4fovYkm117S7gKYCUMTXXCp
 +mY6r3sYhS5ZUSV6/58+KBPOUUHieoTJYp/Amn4gIQnWDgaY9FuLkU9JV8MCYtJufpzB5l
 odtaDQp1b+qgLzLZdC3WZsd7PW/nt6Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-_T6GAmUMPWWF9s4iNIQB4Q-1; Wed, 10 Jul 2024 09:00:04 -0400
X-MC-Unique: _T6GAmUMPWWF9s4iNIQB4Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52eaef92c91so4295326e87.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 06:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720616403; x=1721221203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Du3Or/ZVnc+iBOB6ZOr6H7VDhpS2uXNBdWrPo9+n1dE=;
 b=gCp3mzyT73pxxuCiYaNEkczHrXZtVD9fdcvtfLlWJ9BZ9H5vHVsg7l+rP5VrNBFhyh
 xV+I016l2dMObUkdhHTHYIj8HDHFdChx1/pkoQlLumtyaZ7ozHKnulim88sznXAD6zCt
 FkwT6+30JxkIMMhz6EjqwYNDf7ZaCtvPO85yzm2scBvenfrmlXLXQ8m4NkO/o8nFNqdD
 h2sxr4ER6EmqKK6oagLtd8UBjNVB4cTN3JEcIdjRIBK/DX/V3vbIhKC796XXfHuFnXuH
 gGHbleOsemrKpb6AflVyV8JmF397ppH/dudKpELCJPIZLcQzUSn/zOMq5/LZkEMue7vH
 h0BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjHaIOClQCOOdlNPTKgz5JcGFD/HomcfkasFHn02dsiZsSdiFF01a8EheTK9l4vnEq9Hfd9OuKWJTWUsY4/oLzcEbVPsM=
X-Gm-Message-State: AOJu0YzaXysXpXZOI2ICpjlGwfcxJrelcfBMJtEtBmChxZXPZNwdfqzs
 +0OsXdWVEOjL5zK0fGc021FYitA+2zRMtxLTqNjIRn4EaCS4DRBc/Qhv/zE28OaDLucshUI+QEo
 uTa5c5HKDh1lynSGgMuyWJnEBUBFS5t5uJkYauNQVffY8JawOjMxB
X-Received: by 2002:a05:6512:e92:b0:52c:dfa0:dca0 with SMTP id
 2adb3069b0e04-52eb99d323bmr4326075e87.43.1720616403470; 
 Wed, 10 Jul 2024 06:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp8IitqhaytvjADjDHJRsRq2vnAGTU8BbBQSdXzMiv0Ew3nxrlhDXEort6JdNFlg7IfD13DQ==
X-Received: by 2002:a05:6512:e92:b0:52c:dfa0:dca0 with SMTP id
 2adb3069b0e04-52eb99d323bmr4326046e87.43.1720616402806; 
 Wed, 10 Jul 2024 06:00:02 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1ce0:c033:e72e:9d5f:f8c4?
 (p200300cfd74b1ce0c033e72e9d5ff8c4.dip0.t-ipconnect.de.
 [2003:cf:d74b:1ce0:c033:e72e:9d5f:f8c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6e097bsm82546575e9.6.2024.07.10.06.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 06:00:01 -0700 (PDT)
Message-ID: <5c991b76-dfae-46d2-b896-8e8dafcfd368@redhat.com>
Date: Wed, 10 Jul 2024 15:00:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] qcow2: don't allow discard-no-unref when discard
 is not enabled
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com, andrey.drobyshev@virtuozzo.com
References: <20240605132539.3668497-2-jean-louis@dupond.be>
 <20240605132539.3668497-3-jean-louis@dupond.be>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240605132539.3668497-3-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 05.06.24 15:25, Jean-Louis Dupond wrote:
> When discard is not set to unmap/on, we should not allow setting
> discard-no-unref.

Is this important?  Technically, it’s an incompatible change, and would 
require a deprecation warning first.

(I can imagine people setting this option indiscriminately on all image, 
whether discard actually plays a role or not.  It may make sense for them.)

Hanna

> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 50354e5b98..cead5479e4 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1156,6 +1156,12 @@ qcow2_update_options_prepare(BlockDriverState *bs, Qcow2ReopenState *r,
>           ret = -EINVAL;
>           goto fail;
>       }
> +    if (r->discard_no_unref && !(flags & BDRV_O_UNMAP)) {
> +        error_setg(errp,
> +                   "discard-no-unref is only valid with discard=unmap/on");
> +        ret = -EINVAL;
> +        goto fail;
> +    }
>   
>       switch (s->crypt_method_header) {
>       case QCOW_CRYPT_NONE:


