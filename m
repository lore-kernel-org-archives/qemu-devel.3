Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38DAF433DC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDeLN-0004ZT-LC; Fri, 17 Apr 2026 04:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wDeLH-0004Z4-Of
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wDeLG-0005yA-B8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776413661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t2L7fM45cmdhZpcOe/BsAcSivnWyvm2yZInHqH1FRjA=;
 b=OqZ5XKX7lJnF02QGHhHNAQfN2LE4xSCtLvJVyRwtNnjayIhFgMVUvRVqsfHeXadauQdi+P
 qcUG2Y+mTP7CneWQ10No4n0aSSZX35nSu/MzJrt9FRWJT0FfJSx5X51JbgMQfdW2HYAuqE
 1JXpXTaq/P6aRQkf682XaHqmCZsOn/M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-kzKQEtYrMrKDJoNMygyqRg-1; Fri, 17 Apr 2026 04:14:19 -0400
X-MC-Unique: kzKQEtYrMrKDJoNMygyqRg-1
X-Mimecast-MFC-AGG-ID: kzKQEtYrMrKDJoNMygyqRg_1776413658
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d7a5b9678so322941f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776413658; x=1777018458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=t2L7fM45cmdhZpcOe/BsAcSivnWyvm2yZInHqH1FRjA=;
 b=mXvinpWvEuPZLZyT4eatRFi8zyV1FIlqxgWkW9wr4uETiaDH2vjIGM6/N0xOoyxV6X
 Qc+BO4McCGExUaSFPLEBBPbslnUo2AZx/QhFXf95a0aA4ryHPZ72M2HNkz4mczszptFq
 poc3UFQY+xMMAXup8lHp0al7t5lvlCP++gq0mAxh7wRdLzu7J50qZtqv0q11nL/2PX0m
 8M88woeb8ePZB6iVLB1KrlW79/DqfWe3+FSBq9WoBtLfxLnQAlWc5wo2SVX1heHBHiXY
 ifZTTLDwT4zVjaZ3D7XaMbufONA5O9Ktm2D4WqNwyOG/+XZlcwJZJLKCK40n9orriSFd
 In3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413658; x=1777018458;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2L7fM45cmdhZpcOe/BsAcSivnWyvm2yZInHqH1FRjA=;
 b=Y2DZxBVeRNnALKWkuoaj19KHL6OuWiK6GmR+LRX/LICwc4tuDkVjPyhwxdJ26vKi4Z
 dZ+glFwKYxFIL13SMwYjGgkPUEgH7TjaBZN34u4k3zXmDPrdWkxYccI6FW+MY3sdwwJ5
 Yg2LKh2rsHnl3UJs4KOYHBanO7+en0C4lKXfCMK2t6gT8H/6tWrxJsvwDL5hVcV++GnN
 MW6m6xFKXugMj+Hm1ki7LoutBxquHWg9KCG2T1l9jsUChwP6/6LpUWWK85wz08rRVx7G
 1naqBLgNI1E4wKYdlSZGaRYDC2Bs/GkHHKb+baA0bw9RkFrpux8h48VIbj3mUTfAu2CA
 tXxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FSIGUTSQc5t14226MNrndALYq9g5kiCfCBhRNmsGtALP+Wbt1oz3v0CYGWymH4a7MdLAwbU/RKOFm@nongnu.org
X-Gm-Message-State: AOJu0YwZ5YrhLuUQojp1ydf+Y7I8gTxuMyQj8s47X9L4B2dcy96DOKVr
 xyJXdYmXPSwNrWYnBXCbtUqP9QglRVUrftJwL2cNNm0cXjX0tEgHSEU2AHCiFWLunBIFeOh2nQJ
 0H8EU7o0+LhOi9o916HFQTzjlr6cC/5k6qV5pVBJnck8mVfA8iJ1kfiMm
X-Gm-Gg: AeBDiesWI5U8O798XDOtoxRN/BX22QhYABrU1+svD7ansGzOPpzETmmi9fPhAKCzR9g
 +ZW/nJk64mJkKqR9aNPZq9edLfQ6oJMLkV5uNyQ07JnY9Po+VkKb4hAKgnaWt79Ra5QZgUGIlPk
 F/s53pTl/tvH871hdOgTLSYMHP16r+CBRzIw0GCfi5EWnXN9fwY/nIwPoERrRHMYJJWXam8pTdD
 xo/3x9Z6Tvte3zm8Bei2R2ihzGQehc4OdLrAjgXXn6vLH4AuyZ5ArdRKqwmiRXxrQwX7r+c2aRo
 Rkz3LNjJxLxUDf9sb3B7LBCrRO3T1AbjIAoSfV7RdEExzhLnV1ZPTCWhNsxS/Or7KjzwLD95TIP
 CmJp4D7D3SZV5lSprZ0fb9fuQ2CNV
X-Received: by 2002:a5d:5f43:0:b0:43d:6f4c:383e with SMTP id
 ffacd0b85a97d-43fe3e14349mr2518107f8f.43.1776413657930; 
 Fri, 17 Apr 2026 01:14:17 -0700 (PDT)
X-Received: by 2002:a5d:5f43:0:b0:43d:6f4c:383e with SMTP id
 ffacd0b85a97d-43fe3e14349mr2518074f8f.43.1776413657496; 
 Fri, 17 Apr 2026 01:14:17 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.24]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm2532220f8f.22.2026.04.17.01.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 01:14:16 -0700 (PDT)
Message-ID: <9cd1c037-1e47-47a9-b147-1a28c74077fa@redhat.com>
Date: Fri, 17 Apr 2026 10:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/28] MAINTAINERS: Remove Yanan Wang
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-26-peter.maydell@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260416091654.316158-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 16/04/2026 11.16, Peter Maydell wrote:
> Yanan Wang has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 043d26b0c4..ca64361b24 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2006,7 +2006,6 @@ F: docs/system/i386/nitro-enclave.rst
>   
>   Machine core
>   R: Philippe Mathieu-Daudé <philmd@linaro.org>
> -R: Yanan Wang <wangyanan55@huawei.com>
>   R: Zhao Liu <zhao1.liu@intel.com>
>   S: Supported
>   F: hw/core/cpu-common.c

For the patch:
Reviewed-by: Thomas Huth <thuth@redhat.com>

... but I wonder why we marked this as "Supported" if there is no maintainer 
for this section?


