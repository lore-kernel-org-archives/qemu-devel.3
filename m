Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93C8CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 05:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcq9-0005GH-3p; Fri, 21 Nov 2025 20:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vMblE-0000SD-4e
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vMbl1-0007qV-3x
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763772327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KNwqADQ7c5gLNnWKtnYOhbPe87aYSAg5tefP1TKcDuI=;
 b=Pqg44uFZ4u/F4j2vvVAmxgM7M3KdTqn9H86cv3vuPJdVbbtvRm22BIuDvoDhj3D9MzOd9N
 0RTTaIrHUdUbF6vrS/uZuzRxvofCLJQX+1xI7bcjjlS/QHYggDeUV5zukNZJV1HpBHb6tL
 kenC4w0BBWkG/lduwznzebfIypIzEH0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-FE-jvumuPV6bWVeK-DKZZA-1; Fri, 21 Nov 2025 07:26:07 -0500
X-MC-Unique: FE-jvumuPV6bWVeK-DKZZA-1
X-Mimecast-MFC-AGG-ID: FE-jvumuPV6bWVeK-DKZZA_1763727966
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so15126135e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763727966; x=1764332766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KNwqADQ7c5gLNnWKtnYOhbPe87aYSAg5tefP1TKcDuI=;
 b=TRW78mAXQ0nuXTW0o+q2c10rx5DXsc0Qs09TuAOXWYq3O68WBzt4uVpBB6A1bHqSWO
 mESWSfmQmZCta7upYO81N8e9xwu4n3PSRj+wbpUzF4UZMZrKFKSHdcwn9kgznUEJTNoO
 9/9nNnyEqRAGb8oFxMoGCo1x7d5zX9tQ7e10CBwXvVgTWZeY1FVZxhLecpB9f5KQB6by
 YKfvQMRH+z8Bf5I+3TN/BKpQtkfB+4qOaxYclTCP5GDo9y5VukELDZflBsUVkILT3zVh
 K1WKdYJBiU7iWXNG0Fhc6rhk3N5VULffJ51IpdzUfr9AQePl2IMOioQTUD3ZNqJbdxoU
 bcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763727966; x=1764332766;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNwqADQ7c5gLNnWKtnYOhbPe87aYSAg5tefP1TKcDuI=;
 b=jQkISqFLviNz82tGr14pEr1FLY6wQuIzawZ4ZeLgpIZxH2oG1JCtKqwFTL2DR+Dqdh
 JYRZzemonUBXZeHBKhoYmS0CE5+RKplKs6PhRqe+nG0+qNU8R/+PNThA8iqzJatynSr0
 hYDKg/xRv5ucbLH0pJqIlMl2ptfvqzLE/lK+Op5D1feGr9zEvyHbPjEghkpNsiK2e/JF
 WRRqlzL1esDkj/1ZmFQS1jzT1yRKIK2HZliC4rhfWuxaZcEo5iVxIK9lY+5yz8g1pzkL
 R89FBQKza9CKScxOeZIg6utd+Lq0TE5dwkgFWvW9dg/y6KWhQuWD1FJCrxPKs+rTpEEl
 abQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1tWcSh6l1xgZCepkmGKw5kMzASni0nihAzy6IQyjjtvvps4btIK326nfR10hpYbdHZI9n80N39hM0@nongnu.org
X-Gm-Message-State: AOJu0YxzjF2m9y89in7kqwabXoOUH/c6s6JIKbrGPmfuEoTzCso2REgu
 4SniG/NhbW1Jwr5MJgF+6HDRSe7KZOre3bYGww5KRdNhMTQKUK/lfybBI77DOvd6SnT5x28vvuC
 7zXMQq+WXADw3unZt+dbvUr/3wk6ZjsZsoslITQhu7/Z95el+0yZxlYCN
X-Gm-Gg: ASbGncvxojh6z3dUTbR9P5PK+Ur8xiHsT+kRdNyO0cnHT+HMZPQJ1M+wZQ4HxTy9X+b
 /CoHWMjhTNbwUapf1Ae5CFAoQNgQAqrjpuRaz2zxNWq92fQauXsSHAiD1NqNvKGW7t5FhhXpfam
 tIsR3UdtTf7SD5Na82wAIRry8PxcURhyToPoFbc3bHbjet1z4Y/pcJZWQ6dKlD78V63Kjl+dQyJ
 MU1ACHVc8oXDbCLrrQodiBbCqiYPuhQoJ9l4DhCck/18I1bmqYNrNs42BkTHzOskgVatKm9FRb+
 IWT+wpLJaoxXm+1zJETK9MD3w5vQIFLldIqab4cHEpd+Vi9/V0ou9qrZ1d7ijnjhsJi4P4a34ic
 /n8hAj0DKJJwht4HPtsBbpEAAWyXPiN3rvUU5QcMhO6wXEeIsObiMVnxpoEZjKr/CVxqgdElfI+
 Nv3UoLU0Q26X7hEhA=
X-Received: by 2002:a05:600c:529a:b0:477:8a2a:123e with SMTP id
 5b1f17b1804b1-477c1133932mr18801405e9.33.1763727965742; 
 Fri, 21 Nov 2025 04:26:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXudQA0R76iO1p6ZzxDT7toQuEez/ZmZrVHsjGj8yN9lUHFQY+LzwTHyNKM/PIGXjxkkE8og==
X-Received: by 2002:a05:600c:529a:b0:477:8a2a:123e with SMTP id
 5b1f17b1804b1-477c1133932mr18801175e9.33.1763727965367; 
 Fri, 21 Nov 2025 04:26:05 -0800 (PST)
Received: from [192.168.10.81] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-477bd1580cbsm25579085e9.2.2025.11.21.04.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 04:26:04 -0800 (PST)
Message-ID: <3a9faadd-165f-4d18-af04-211f9edab518@redhat.com>
Date: Fri, 21 Nov 2025 13:25:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts: Changed potential O(n) file size calculation
 to O(1)
To: konrad.schwarz@gmail.com, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Konrad Schwarz <konrad.schwarz@siemens.com>,
 jan.kiszka@siemens.com
References: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On 11/19/25 18:28, konrad.schwarz@gmail.com wrote:
> The mkemmc.sh script calculates file sizes via `wc -c'.  `wc'
> normally works by reading the entire file, resulting in O(n) performance.

Even something as mundane as 'wc' can surprise you!  Running "strace wc 
-c < somefile.txt" shows this:

fstat(0, {st_mode=S_IFREG|0644, st_size=6900, ...}) = 0
lseek(0, 0, SEEK_CUR)                   = 0
lseek(0, 6900, SEEK_CUR)                = 6900

So wc notices you don't need word or line counts, and takes a shortcut.

Paolo

> Unix file systems obviously know a file's size and POSIX `ls' reports this
> information unambiguously, so replacing `wc' with `ls' ensures O(1)
> performance.  The files in question tend to be large making this change
> worthwhile.
> 
> Signed-off-by: Konrad Schwarz <konrad.schwarz@siemens.com>
> ---
>   scripts/mkemmc.sh | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
> index 45dc3f08fa..d2c4e84b16 100755
> --- a/scripts/mkemmc.sh
> +++ b/scripts/mkemmc.sh
> @@ -37,13 +37,19 @@ usage() {
>       exit "$1"
>   }
> 
> +file_size() {
> +	ls_line=$(ls -Hdog "$1") || return
> +	printf %s\\n "$ls_line" | cut -d\  -f3
> +	unset ls_line
> +}
> +
>   process_size() {
>       name=$1
>       image_file=$2
>       alignment=$3
>       image_arg=$4
>       if [ "${image_arg#*:}" = "$image_arg"  ]; then
> -        if ! size=$(wc -c < "$image_file" 2>/dev/null); then
> +        if ! size=$(file_size "$image_file"); then
>               echo "Missing $name image '$image_file'." >&2
>               exit 1
>           fi
> @@ -105,7 +111,7 @@ check_truncation() {
>       if [ "$image_file" = "/dev/zero" ]; then
>           return
>       fi
> -    if ! actual_size=$(wc -c < "$image_file" 2>/dev/null); then
> +    if ! actual_size=$(file_size "$image_file"); then
>           echo "Missing image '$image_file'." >&2
>           exit 1
>       fi


