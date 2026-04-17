Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0A9F8E4B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDeHx-0003pD-Lg; Fri, 17 Apr 2026 04:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wDeHw-0003p1-9a
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wDeHu-0005VF-8s
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776413452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jPvhT4N4SzhTB0EvW2ERaSf0pJPzaH7qhDdSwEGr+sY=;
 b=QtyIphSnMwis1d3JIkqhUGeMV8u/byKJlp+lzsgmwrK+onqLlijVX5mdDAJeLQUvoMXEFf
 YFwSVb76J2NXdtSf4c4wfDWWs0revtjigndIM6llMGa2CNmQBjK4fbTHTBa7MIv5SdCgTQ
 5RzV3I8evqLolZ77Tm3ZcBL6+DfthDw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-Q-kg4DIdPrCB6Re54AMhUw-1; Fri, 17 Apr 2026 04:10:50 -0400
X-MC-Unique: Q-kg4DIdPrCB6Re54AMhUw-1
X-Mimecast-MFC-AGG-ID: Q-kg4DIdPrCB6Re54AMhUw_1776413449
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cff5ef652so246789f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776413449; x=1777018249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jPvhT4N4SzhTB0EvW2ERaSf0pJPzaH7qhDdSwEGr+sY=;
 b=iHsU6juKNnQInfZBvkLVvpf5iXdaTyWB6jonNyTI8KttaAvXnxXRMc4iyedvj6iK8B
 S+8aELIw199Go9Z+Smhz0y+njqFl1JRBiAiHKPyxzN2O8yoAJStq5mcE8pl8wu9zzB4K
 15hU2NHH/ZhdpiI7g2Oze8rTDX5IhMEJWadq8lxRaQGr1aalkywGvaZAqvxOV01ADluf
 x1IDUVNsX2hQDQanK+jheeWhpp2/O0j4zp1UppxKNum+ksn/YZS6+3pgXAMuclN2pe8t
 tIatTrunU4QFF6WZtR+468vrSjks/+Wn9PUZscaRfsutUBm4gr+7rJNCA64fMyJ16wbt
 WGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413449; x=1777018249;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPvhT4N4SzhTB0EvW2ERaSf0pJPzaH7qhDdSwEGr+sY=;
 b=DIFl4bqSjQrRj3di9ofchEUHMZnoeHZZhNjYBNIveyVLq56vCeLHJpXibDqA0anWN7
 MLrhkBe7tiUnnRjpLVnqkw2F30Or5/S9idfAoUwxfvnCvHSULo4XNHOLdDM96c2duVak
 ZKeTr3y8cP7tshG3oDpDf32ufFCFyyx+x9UALWZbiHeyqVzg1Zvfo/na+t7YuWee3dOI
 jNWqMdPtmWv/We7vZ3ZstLNUmPJQyrzs4+WJA37g2uZSA0II/tJ5q277E1wBCEEfeafX
 VWbvemv/2cJgyrBUxGnr2W/UoLAqK/9RbH0o8CDYz3KkRfAHJbT2KtawonXOc/ypPM+l
 lkhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RsmjfuHxKLOo63GN1dggUtckKuDc+M++mQ6gWhFpcOKLqCsCJXQ3WKuijuutrmNdAC7vkCyEgsKcj@nongnu.org
X-Gm-Message-State: AOJu0YxDP4cNocGQOvAXe5BfiZwC6ctgHKGsYZHlbpiFXcFIIztxO5xI
 Gs1lMZ3t1apPzKA0lB5vLgEzYzZ2ZwsK0fMocp2aO/eaHhDsMjcQaPNONKQasf+Ako51+N8THjp
 zS5TCqwn+3MupYw+UICrWylGzxN/EiC5pzTIRD9OQ4rPr+MY5ffczxl1u
X-Gm-Gg: AeBDiesIcWGzotZRt4Xg5DDjmazJK4ZegjkOD1RbL6AS274tXHgBfIdoxUkrI9z+aeA
 S0OAoVvQjgw0jKeQlWElq03bC18Np8mH8ztp57Lm/pMXcziOO/OfsnDyIkaq1Ka913q4Lu9vSxK
 O8lLTEhKdYbQhaYMM93EipldovNzxHaJmdGAtkC6Rw2X9ptljzZkOlXeE/ZqIbqJo2/WMhF5M8X
 D4nOh79d0kPPvqMzpSPHK+1kZAxZrQQW2kQnz+ic322mw+nYuo4K5pbrOPwjO/1auPGEMUEUyEq
 rTa+wTNvRVu9CfH4scWwZWfrF1JcBEvC5dOsMFqPcdtkLvMPU2CwujigmMaw93dRk9s6lK2pcag
 i34tnRMPuV/RDRVZHSmqHuk1AlVaE
X-Received: by 2002:a05:6000:184e:b0:43b:9a9f:8956 with SMTP id
 ffacd0b85a97d-43fe3e0715dmr2426933f8f.22.1776413449113; 
 Fri, 17 Apr 2026 01:10:49 -0700 (PDT)
X-Received: by 2002:a05:6000:184e:b0:43b:9a9f:8956 with SMTP id
 ffacd0b85a97d-43fe3e0715dmr2426898f8f.22.1776413448687; 
 Fri, 17 Apr 2026 01:10:48 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.24]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4c221cdsm2765284f8f.0.2026.04.17.01.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 01:10:48 -0700 (PDT)
Message-ID: <2d316b10-e6cc-401a-bceb-47777c3e6205@redhat.com>
Date: Fri, 17 Apr 2026 10:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/28] MAINTAINERS: Remove Paul Burton
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-17-peter.maydell@linaro.org>
Content-Language: en-US
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260416091654.316158-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Paul Burton has not posted to qemu-devel in some years and did not
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
> index 6cbb1e049a..a7a345c514 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1486,7 +1486,6 @@ F: include/hw/intc/loongson_liointc.h
>   F: tests/functional/mips64el/test_loongson3v.py
>   
>   Boston
> -M: Paul Burton <paulburton@kernel.org>
>   R: Aleksandar Rikalo <arikalo@gmail.com>
>   S: Odd Fixes
>   F: hw/core/loader-fit.c

Aleksandar is only listed as Reviewer ... so should the status rather be 
changed to "Orphan" now? Or maybe Aleksandar wants to step up as a 
maintainer for this file?

  Thomas


