Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D18E63F1E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 05:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrrBZ-0000U3-6K; Mon, 16 Feb 2026 00:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrrBX-0000RY-Dq
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 00:30:15 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrrBV-0005AT-6B
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 00:30:15 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a9296b3926so18461365ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 21:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771219811; x=1771824611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3d/rXWsgpsuZJMZt91yHkZf8WsQ33cQUGR80S4NG4Ps=;
 b=WLKZ4A3AsENjC9fZamJpLjN5IEaESm9R66xpVFuvWy0FZ2TZy8e+2YIQD3VTjnWPLd
 0lpoSk+cfKahjkMe3jbid1OmZtp/nqar0GMtNyGUUibvTpHeOre9EtvUIlLJ9hVABEBf
 hy7kJIOXnb7Dnh6k4zt1m1JpHu8pouTiIrCPpHiNcQTr8JlE3S8JN22j/LnHyOgzqZRl
 AVJ+fkjVZihQsLKPs7l7KxOJAlievsy6dW2h9nY+WkQihYGeDTw5BXuedh1vSbBrmn4K
 NyOZYCKDsNki16rQmUt8lqM6JoS3V6w0J/n3Y01dj15c7w7l4g5RDyZ527/453CRNy86
 j+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771219811; x=1771824611;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3d/rXWsgpsuZJMZt91yHkZf8WsQ33cQUGR80S4NG4Ps=;
 b=Jt0Ry2rTvS5H6OhRyqKg+AzDWMldHHqZ7JY8OYsh16uUZPLUgZBrbTm5yopeVQ44Al
 aZPE0m0V+371ST1wpKUOHYfFLtEMYi16HRefx6U3SgXiZtOPGY/rpUzrnAHTbQ0K02q3
 O5GuBSUFvZzolDrVVlt6ALCwOBKzHgPxJiez0NXX+v1eERJNtKzjLGbIswWathGDmqXV
 jIR1RTvY29F4GoHAunoup0FNJmue3hvcHItrSH0yMP3GKtpuA5tIRmvx9qOVByAl5QzR
 JbJnPbTXKXVVeaQHR7FO35bFdEzhchJW+X5KUUDA7Ev4BupychA9EeZhmtQzfy3ZlPbW
 s2zw==
X-Gm-Message-State: AOJu0YyCe87jhHWwo8tp9OC/JdocC0DxKQGrXMyDaDMcXnoaOOE6gXyc
 qmfyEpbC/HQbeGVUgpPhfIEv7GsLhM/S85/oPLZe5lp4saWCSvzIMgGT97TGlw52EOY=
X-Gm-Gg: AZuq6aKeXxMIenJUf+USIL7F8NjX38/en1TfYvjsKE3hRyw3ZWSTTetfyQdorH67oc4
 K3B5mmFMLDPlV1QWV7NQr67N2flwNHVVwLnpN6JRafm4bc5F6hPyLtXyhuJ13CGygQQCXjgSdIm
 FkxFqBZ7Ma6uDPI42xjFynLo70rpAcpXMF4fJe6vsTKmekbMzfifJFC1SqxjPpbqd3Za7qgoeHc
 N1Q/gHSCzrk9DIXkyZ+eoV1OiJZGbJId1VNwGQyClNNcvOH3z1z9uyUCAW0FhgSwtCR4pu5LJ3T
 PznAtnc47x9HOb+uQwtlE1o9vGWkKnnMdjywmk3DRN9aheA3syByQ4I/mWCysica8jWlMJFZ/zp
 hsTQxWrGCJKfESOQQTAYF5qZ9Zf6yiDJWvJqyTeAUe5rM5Wa54Z5fNa5SJ1Wsnl6ZCaA2fOyZjd
 XTlRiKX+TqzSnvDDdVy3tArLkN0v8E3xQQCeJLyK5HGLIqbHlkRpP6RXkz8Ozs9J4sortg3cxlA
 HC+v95fnaoTjJq/GytdV8hTOipz+YsKxkyWvNehrHi9cgXHWYvD
X-Received: by 2002:a17:903:19cf:b0:2aa:f2f3:bcb0 with SMTP id
 d9443c01a7336-2ab505e6700mr88003025ad.47.1771219811327; 
 Sun, 15 Feb 2026 21:30:11 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:4a1:428a:70f2:5844?
 (bg30dhzm5ftjb9d57pjq.ip6.superloop.au.
 [2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aafc527sm55044865ad.89.2026.02.15.21.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Feb 2026 21:30:10 -0800 (PST)
Message-ID: <695ae1da-8ca6-4966-87fa-5cd712cda59a@linaro.org>
Date: Mon, 16 Feb 2026 15:30:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] fpu: Add conversion routines for OCP FP8 E4M3
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org
References: <20260205111622.461497-1-richard.henderson@linaro.org>
 <20260205111622.461497-9-richard.henderson@linaro.org>
 <aZKVxean7S9fkHHn@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aZKVxean7S9fkHHn@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/16/26 14:22, Max Chou wrote:
>> @@ -459,9 +489,18 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
>>               frac_clear(p);
>>               return;
>>           case float_class_inf:
>> -            assert(fmt->exp_max_kind == float_expmax_ieee);
>> -            p->exp = fmt->exp_max;
>> -            frac_clear(p);
>> +            switch (fmt->exp_max_kind) {
>> +            case float_expmax_ieee:
>> +                p->exp = fmt->exp_max;
>> +                frac_clear(p);
>> +                break;
> 
> Thanks for Chao's notification. Here I missed the saturate checking at v3.
> We need following checking flow for E5M2 when when float_expmax_ieee.
> +                if (saturate) {
> +                    p->exp = fmt->exp_max - 1;
> +                    frac_allones(p);
> +                } else {
> +                    p->exp = fmt->exp_max;
> +                    frac_clear(p);
> +                }

It doesn't feel right doing this here, because true overflow is handled elsewhere.  This 
is re-packing a FloatParts for a given FloatFmt.

Perhaps parts64_float_to_float() would be the proper place for this, as that's the 
conversion operation, and recognizing this overflow feels like part of a conversion.


r~

