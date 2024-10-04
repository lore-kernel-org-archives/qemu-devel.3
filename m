Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BD2CFA74D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 07:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swcLU-0003tM-VE; Fri, 04 Oct 2024 03:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1swcLR-0003sw-8g
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 03:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1swcLJ-0006TE-Ot
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 03:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728025391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1qAuTlvRADrHjVzx7ryFC+9Zs4UiNbLvUu5vKbhWMRs=;
 b=AXBUvEvzF1ZHI1ngO/8Wf6wYhIe79GU4oKyO9zhZ1duB8woft4y6QZH9qjVS7ZQ/P4k5mE
 AfSeUMv9/u5L1QvHSo4Aa+RC0ZdNs0UGBzv5B2xamm+KtHTuIVULIndCFug297u21dNm1J
 Kn1VPp0iNPi9wn5OO5XmxShYKmGSSYI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-lm0GkTwaNoymyWBd16r54w-1; Fri, 04 Oct 2024 03:03:08 -0400
X-MC-Unique: lm0GkTwaNoymyWBd16r54w-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c8adadc575so3253203a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 00:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728025387; x=1728630187;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1qAuTlvRADrHjVzx7ryFC+9Zs4UiNbLvUu5vKbhWMRs=;
 b=fshrGHSV96HFc+Y1ufDw/csGND02L7VgYFuRgy65nB92osUg4nri/xMzUmFQ9LXDyg
 FzbTizPnGftG3STeOLxd9nswDgs2m3AQNbJzf+kK3+qM3GDeepzyZ7Ixmb8w4yPb5+1b
 ec2d2hDoI4a2fTPKsAisLOzbgIXwccIFx0nEuWIwGNFVFE/3mcc519fH1wtVU5hQ6ENt
 /poSR1gdT+aneMHkTCXmRBPrqnNyi5xh+BpQNjIiWbCukWLCf2mE3xdqa/UbnuahNy7+
 xmheRM09jXnWFcFu4sfb4JctSly3iUQic71wV/ghMncUsuWB/1fe5If9sXscUYntskww
 bAow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh2Zs9BoGjxA3mNzGsnIzmy9COzTmjO0r63rf9WavINgaXi5hIVg9YPkFl4r8DrXdV+4dBSEKAK9eQ@nongnu.org
X-Gm-Message-State: AOJu0YxG3cQbG5RgJO675cxyW0rhw39QDd4+mZhZc3X6+taztdvOdrje
 5Itzs1rnW71KNzs8SgatWYYGW7uzAT0EwbAxnNlBbpZL4pCuDF7ucj5X0ZARoJAA/3SC0C0AbBu
 qazfyY6MGUKQ3t6S3iY6emVQGCbC9dVu/1p3Q9bqPxB638F3sGKAF
X-Received: by 2002:a05:6402:2710:b0:5c8:78dd:8027 with SMTP id
 4fb4d7f45d1cf-5c8d2f7d634mr1583682a12.12.1728025386795; 
 Fri, 04 Oct 2024 00:03:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbRglHKlDAfu//PR4QoDJWpwvgEinLZyJ2qIo1UC5CCcPWZujLHI3WJf/MswxQJgh++sDUCA==
X-Received: by 2002:a05:6402:2710:b0:5c8:78dd:8027 with SMTP id
 4fb4d7f45d1cf-5c8d2f7d634mr1583644a12.12.1728025386354; 
 Fri, 04 Oct 2024 00:03:06 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8ca3dfe2csm1531939a12.34.2024.10.04.00.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 00:03:05 -0700 (PDT)
Message-ID: <c6b188c1-bfba-417c-bf6f-5dc943a1e130@redhat.com>
Date: Fri, 4 Oct 2024 09:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] gitlab-ci/build-oss-fuzz: print FAILED marker in
 case the test failed and run all tests
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241003121656.1173612-1-mjt@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241003121656.1173612-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 03/10/2024 14.16, Michael Tokarev wrote:
> currently, if an oss-fuzz fails, the script does just `exit 1`
> without any additional output, and looking at the build log in
> the gitlab ci it is not clear what actually failed, without
> looking at build-oss-fuzz script and seeing this `exit 1`.
> 
> Print easily recognizable error message about test failure, so
> it becomes obvious what exactly has failed.
> 
> While at it, continue running other tests even in case of
> failure, and exit non-zero if at least one test failed.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   .gitlab-ci.d/buildtest.yml | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 87848c2ffe..25c481e43a 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -628,12 +628,15 @@ build-oss-fuzz:
>       - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
>         ./scripts/oss-fuzz/build.sh
>       - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
> +    - failures=0
>       - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f
>                         | grep -v slirp); do
>           grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
>           echo Testing ${fuzzer} ... ;
> -        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
> +        "${fuzzer}" -runs=1 -seed=1 || { echo "FAILED:"" ${fuzzer} exit code is $?"; failures=$(($failures+1)); };
>         done
> +    - echo "Number of failures:"" $failures"
> +    - test $failures = 0
>   
>   build-tci:
>     extends: .native_build_job_template

Reviewed-by: Thomas Huth <thuth@redhat.com>


