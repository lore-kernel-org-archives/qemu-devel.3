Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2263C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 11:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCGE1-00025q-IK; Tue, 06 May 2025 07:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCGDy-000257-Jd
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCGDx-00081h-5W
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746529952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pcitEZccm1OdjF8D1Br6T8qqEBwds/7y7++4c5CW1hg=;
 b=G3gmi6prtpMpMcXgE4RlbFtEbp2uNiskqem2kGAMGs6HUoSOVfVwvvlMgEFnFkN+F5gxIy
 XPqEVlwqoFgDJ5PcSxiQrbMi6pL8vtd3LVJLDvSPbyVNTMNPvbyXcYFoVgCkFMOfviYva5
 2qN885qbZDQR/o5wTD0VyjVNxkYEQts=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-JNkvNQqZM0GU-5HoFXdWSA-1; Tue, 06 May 2025 07:12:30 -0400
X-MC-Unique: JNkvNQqZM0GU-5HoFXdWSA-1
X-Mimecast-MFC-AGG-ID: JNkvNQqZM0GU-5HoFXdWSA_1746529949
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43f405810b4so28306775e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 04:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746529948; x=1747134748;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pcitEZccm1OdjF8D1Br6T8qqEBwds/7y7++4c5CW1hg=;
 b=vUG5FNxz48/gAv5z3Ang4QcnY0GXwV6k6vAhzjlHXgAbvtxzvx6jO8pz/VUmuYrI3l
 iA+2EiFaU1stozV09vKQmkEyknqh1QzTNf8jrxFE92JHpAglWLDvNACJPBC8UZ6EiztG
 vXw6yCLUY0aP03Um/6Y8c8xGaf3CedTVLoJkomASz0ixH3C8ey2NyNd9z5yZJoK3vfYo
 kcGz0lmY4+xV9agQv1z2CIGcWPsd/5uPowo2dYz7EFWZEHPuDxCE6Q5xpWx5o1VT84cJ
 qLFlOApfhMOYp09n4BNSTCmJlDZlZ4rw7IZH9q7nJ227vmQyjlMJIwXOClIQm6MYLP4M
 KHqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe+jCn9DPpXmbz938vNWQWBqAyYR6DYP0rePOliQYEU6MFHo8ht+rCmfShqgOcVlb3DxEmvFmaMa5Z@nongnu.org
X-Gm-Message-State: AOJu0YxGsLd5UW1mgMonm43I2n9B2sM4+zA3d4NELSk3TvXNFCHckTwH
 ioq48Bgs2DRQDTXEBNNVeuAJmQgMoQ+3oifRPSstkVERRHbT+fLU5EMICXhLiLNRDj4+/x/7vtV
 H48M8Jzizeg3RrnLcq8MBwpYNpFrRjypF/hy1ZcF8NfiS6pV5L6AwtYmg1jaW
X-Gm-Gg: ASbGncso2K8rBPgYiP/0WhfPbxt13jXRsCPddxc63k/Vbgx71OZGScXzUeZcPgRPaXQ
 mhhAI7OMm0w16sZAj1yKFF76vZP5JBMnEmMhOA/4TbxpYSmg7zcP6ixXw9h/9RVLPnnc3ryrjzH
 j1RowZwBfUgfUV4zi5i4wNMcFlNSrn7GwFkM1nsu5dhnnsDZaLpkRPkPw/ZscBFasrqyDexQoHn
 PWhdCPJ/o/7AmkK5npKF5Yt/JrvyBhiBaXcguT3tLRHdPzuianSzRrYqDgbgCm1n9csrJXtCnA9
 jWzmaJwob1gUM+E=
X-Received: by 2002:a05:6000:1f09:b0:3a0:9dfb:b001 with SMTP id
 ffacd0b85a97d-3a0ac3ea61emr1607095f8f.58.1746529948563; 
 Tue, 06 May 2025 04:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcZWmA0YhP+saab9++//EMty3gyHlMUZ6yLqlEa40VxqoLXuF0jwQUNCsEoLModvATAoVGMA==
X-Received: by 2002:a05:6000:1f09:b0:3a0:9dfb:b001 with SMTP id
 ffacd0b85a97d-3a0ac3ea61emr1607074f8f.58.1746529948134; 
 Tue, 06 May 2025 04:12:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7cbbsm13547288f8f.53.2025.05.06.04.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 04:12:27 -0700 (PDT)
Message-ID: <6a880c79-f30e-4fe6-af98-1fccf334e2dd@redhat.com>
Date: Tue, 6 May 2025 13:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] tcg/optimize: Build and use z_bits and o_bits in
 fold_extract2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-16-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250505202751.3510517-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 5/5/25 22:27, Richard Henderson wrote:
> +    uint64_t v1 = ti_const_val(t1);
> +    uint64_t v2 = ti_const_val(t2);

Are v1 and v2 needed at all?

If starting from z1==o1 and z2==o2, you will always end up with z1|z2 == 
o1|o2 after these:

> +        z1 = (uint32_t)z1 >> shr;
> +        o1 = (uint32_t)o1 >> shr;
> +        z2 = (uint64_t)((int32_t)z2 << (32 - shr));
> +        o2 = (uint64_t)((int32_t)o2 << (32 - shr));

or these:

> +        z1 >>= shr;
> +        o1 >>= shr;
> +        z2 <<= 64 - shr;
> +        o2 <<= 64 - shr;

so fold_masks_zo would do the job.

Paolo


