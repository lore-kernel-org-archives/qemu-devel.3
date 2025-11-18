Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623F3CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHOh-0003VW-QT; Tue, 18 Nov 2025 03:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLHOf-0003Ug-MM
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:49:09 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLHOd-0002FC-Qy
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:49:09 -0500
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-948fbdbc79fso60219739f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763455746; x=1764060546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mNjNbdrrzFou5StEM9SpfKZgIusGUo74wxT+5i+eQC8=;
 b=b58s4namYOu3SOM1Htk++0TsE9WCPBQbVHEXui7inM7RCMFRwTqbR84JBDzjHSje6S
 hQQY+4NQM2n6gbK8Tok8RdtVcrpO/Pwo6gN4EZyw7yngRIc0lueKJeW8Eh8k9p03brkv
 gLqjkbg9ETziXa9Zwn1qwMIeqWlUKAOHGL+p3zIeRvfDyf/7xbdTNo++lkDu6gHQPWkq
 S8vZEWHI17LB5FzutfAMo0TmNyzuhrrAef10Nv7cPUNSV9wEq/pgDB9yGvJC3tHTFrqc
 0DlbCfSzX3bxfeelt8W3GHfd3K2cOBVdGLYOLNcWwL0Mb4/ggaYqYvQBBnNYx5YDekMF
 AQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763455746; x=1764060546;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNjNbdrrzFou5StEM9SpfKZgIusGUo74wxT+5i+eQC8=;
 b=AEpriTHfB63ZVkG10ySmK/O05USYU6QG7HTYqdOl+231LjnE8HM2epAwN3OoJOQ0YQ
 8XeY/6hOG1/UYaUnlgZOdNMS6yyF6Yy+QiDnaml9WKBEvpAgrf9b5PGVFTxM83WDUc4+
 SLIzJqUGUcY4frMFE5+xPYLitQ5cvbBjc6tPi+tJ0QQoq1rMEyTHy+qLEFDERDuMa/7y
 XQ0dTw9/3mCUQ7HC0xDWw1vsjeMFk1dNorm7kFnOH+HmyrymcBOAOp93hx+Fs68ax/d2
 uyU1FdKVwT7EfexJYj3Ilf1Bs0KcRO5n9lN/smA+MTZ7IJsWT25ormoIqys1gE0T6Epk
 o6CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbcB5iNPaf5aBwpX8YkhW7E1KadUtc4+UeDt/2klGW8xYWTYjAMX0M932EyHL5pymeg5TFdn1ICaIZ@nongnu.org
X-Gm-Message-State: AOJu0YyaF4q8ec9XoDmJnmd07DvQ3aJ4w4duqsN0gscase4NrQypKllo
 DAcVJibkqwJ+IDlUk2b3WPxBg7wyBdy+rk6muYK5isxYXHbid2qKn7IDWe6CwFukNTk=
X-Gm-Gg: ASbGncu1AVUDnHwWrZeKJxr/DIuZrysEeuU1sKatOpr/X828YMPpdq59NOpXuFXKFzY
 hKaE71CYEqaXEfigiUJkt3a9gBSrcwqLSM43RgCaSHRbr+/eGCcOaOQvVklCf6f4YdWcWakj+Wa
 /ejMtiw7pASRbyKgAgDB7xNt0bw1VYD7P/Ekpt4KP3ad7CWbPLcNyi2j5XWXtSefliYXks0UqEv
 T7iJTuBRCZ9ICoFdItx7g9GXsSEr4dflOPjSgdygQNZ5VIYg5acTAztzPX+gya+L5EUbfV21ayy
 owVSKZ4AhhTt3WwQ/tQmhvRULB+0YAAft5ItbGrzxyAsTVBHrmYYN0vSNBczzqFSV/fblbWxwUb
 d2/HBH8UBwjO+aN8WxmtetxZeCudT0bKfngMPDG0d6JlB8ZcSJcM2drq3mp/C4dmZC2uZT/C5Df
 Lpv+Isv1oSWsPgFTU7+lDPHT/4+1zWwsZad2NYTpaAf/EkdqFbZsJBm7mhWh8HD8u7frwvlPpw6
 UBjxw==
X-Google-Smtp-Source: AGHT+IEr3YVKt1F5BnBA+NF19rMUQV9IkItWXrb1ae0Ga6Vy1wwelBPzxAS0nRPAqS7aLP8EwjTvBw==
X-Received: by 2002:a05:6638:aacb:20b0:5b7:c2fe:3d87 with SMTP id
 8926c6da1cb9f-5b7c9ecc915mr9120179173.18.1763455746406; 
 Tue, 18 Nov 2025 00:49:06 -0800 (PST)
Received: from [10.89.10.227] ([172.59.191.229])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7bd3301efsm5700105173.52.2025.11.18.00.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:49:06 -0800 (PST)
Message-ID: <f4931237-d274-4802-a167-92f807844830@linaro.org>
Date: Tue, 18 Nov 2025 09:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 2/3] migration/rdma: Check ntohll() availability
 with meson
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nick Briggs <nicholas.h.briggs@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Andrew Deason <adeason@sinenomine.net>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20251117203834.83713-1-philmd@linaro.org>
 <20251117203834.83713-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251117203834.83713-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd30.google.com
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

On 11/17/25 21:38, Philippe Mathieu-Daudé wrote:
> Commit 44ce1b5d2fc ("migration/rdma: define htonll/ntohll
> only if not predefined") tried to only include htonll/ntohll
> replacements when their symbol is *defined*, but this doesn't
> work, as they aren't:
> 
>    ../migration/rdma.c:242:17: error: static declaration of 'htonll' follows non-static declaration
>      242 | static uint64_t htonll(uint64_t v)
>          |                 ^~~~~~
>    In file included from /usr/include/netinet/in.h:73,
>                     from /usr/include/sys/socket.h:32,
>                     from /home/f4bug/qemu/include/system/os-posix.h:30,
>                     from /home/f4bug/qemu/include/qemu/osdep.h:176,
>                     from ../migration/rdma.c:17:
>    /usr/include/sys/byteorder.h:75:18: note: previous declaration of 'htonll' with type 'uint64_t(uint64_t)' {aka 'long unsigned int(long unsigned int)'}
>       75 | extern  uint64_t htonll(uint64_t);
>          |                  ^~~~~~
>    ../migration/rdma.c:252:17: error: static declaration of 'ntohll' follows non-static declaration
>      252 | static uint64_t ntohll(uint64_t v)
>          |                 ^~~~~~
>    /usr/include/sys/byteorder.h:76:18: note: previous declaration of 'ntohll' with type 'uint64_t(uint64_t)' {aka 'long unsigned int(long unsigned int)'}
>       76 | extern  uint64_t ntohll(uint64_t);
>          |                  ^~~~~~
> 
> Better to check the symbol availability with meson.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build      | 1 +
>   migration/rdma.c | 4 +---
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index df4460035c3..72edd6097a4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2663,6 +2663,7 @@ config_host_data.set('CONFIG_SYNCFS', cc.has_function('syncfs'))
>   config_host_data.set('CONFIG_SYNC_FILE_RANGE', cc.has_function('sync_file_range'))
>   config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
>   config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
> +config_host_data.set('CONFIG_ARPA_INET_64', cc.has_function('htonll'))
>   config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
>   config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
>   config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)

Should we bother with htonl{,l} at all, when we have <qemu/bswap.h>?

That said, this is the minimal patch for 10.2, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

