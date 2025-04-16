Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032D4C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4z9k-0004rm-8O; Wed, 16 Apr 2025 05:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4z8v-0004Zm-1D
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:33:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4z8r-0003Nc-Bz
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:33:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so3159285e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744795990; x=1745400790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=afPtcsGo0/7NpTM+oS8EQe7bVn98dwsMMIGtq+LmHK0=;
 b=irM7hy1ApsLADuWkdLlo53bLxvZUjFDAFKO2AX8nz8Hu+JvTzFjGUblvv3hjbCU+dG
 THXzfpENXgZ3yxpu7XCskWfmAxpIBLynZcFYOQwPE2l/jrWmQokKz6LZBR5zT47hJgPc
 X37HWMfHU8EGyh9/ynvbB+fsk1vs6Pfwojj7i6xr/Mr3k1QhZEHEynpNLkWBmh2ecOFK
 FOGk17vPOIj9tSmLk8XiFYXdOwWs2Yt6WYuBqrnZKQvccuaAwFKV22kGRQkB8jZn81/w
 6mwru7zdjWK6Yu8AW7lE0zRrxe9Vqbu4lisLMkmlH8yEkCI5kgs/Aa4a9x9ewTttR45U
 pCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744795990; x=1745400790;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=afPtcsGo0/7NpTM+oS8EQe7bVn98dwsMMIGtq+LmHK0=;
 b=tjaxh7iHvNVbFa1VBVY7OQmzA4FVBU8nRiwbZjIxzkeUbJBSxrzE/mfD7LRMrwnINP
 y1GYWFszz4ycbUXk1CVM41RkXDjf9apb7BP0Gv/I4itdUg4x2KwemCPlKv0RaRGtFjBO
 Fl5RXvoXEDYzsvzzpbhwh/J9yraoN9rM7rpDMr//7Sx1vR/rDf+JPnQ643+6eo6NgZUa
 3FJyE0RBCF3iOpIZQS/OvY5Wd0k1Eov4R0z8uMnihBFFJEFJZXA6nyQax1RNpBgRDczU
 HWjpJmn3yWJUI8a1+bPiG/BE47oy+5IJpDPgA0VhNbmb6hkTEq70oTMm/Detr5xE9xj8
 3idg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9DX3c+y4gWugU2sPJipJI3TMsq2/N/0heqKcN3um+KGXPYOA4D4bBgjQzHDR6nvlLm5/Z41f6F0xL@nongnu.org
X-Gm-Message-State: AOJu0Yys96sZeWVJKvSJRxNPFQ0oEgBtjqnkwYs656ihQmZZrmcA7h4l
 iHiY1wijVk09b+l/5TnPfsHS9uWWWoa1nmGhBOk98qOlSy0mluEaEzKKsDyDZ30=
X-Gm-Gg: ASbGncujkmu2zTWvMvrGvjV9H32Y5AlyMmfE2AeQKpks76WJwJcH6mh3JQlwEetNnfr
 PBN33YFNznBnfNScUmWCudeDwj5eR4IXJN8MBulkU+3JY80nHWWWj42Blk8/mc79nmFAFUk/B0j
 kQBqom5GWS5JuGnok6tjFGzsntCS/Mu2gxhEAtS8gNFDZP37ACPGSOMGyw8sHEsIdxUhqKUxJAk
 Xx28KvRBSfAlxYKNlfpacEMmwScWt/ZBHuwZb82EtudhcopY5lj5kTYSTvBZWLc3uxn3sMN/9ke
 w5GOwv8Q0TyecVb20dUX87Z+RbzrCU6xz8DaH7qxpq6WkbPSqJGsQQqFP+vVB7qIBQdf2RgYRqq
 NdgUuC1YRWHX/Tw==
X-Google-Smtp-Source: AGHT+IGsE+YM7/CjJzAZeTiKtyuERZ+66QMAZoCdiwf6nPB3lLer+ArlLHsqqSFfxnm9YRiyFGIx+g==
X-Received: by 2002:a05:600c:4593:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-4405d765ae9mr10364065e9.2.1744795990518; 
 Wed, 16 Apr 2025 02:33:10 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b54579fsm15743395e9.40.2025.04.16.02.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:33:09 -0700 (PDT)
Message-ID: <2d232dbc-4613-4352-8ede-3fd5dcefc32c@linaro.org>
Date: Wed, 16 Apr 2025 11:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] block: Update block to compile with Emscripten
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
 <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
Content-Language: en-US
In-Reply-To: <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/4/25 11:00, Philippe Mathieu-Daudé wrote:
> On 16/4/25 10:14, Kohei Tokunaga wrote:
>> emscripten exposes copy_file_range declaration but doesn't provide the
>> implementation in the final link. Define the emscripten-specific stub
>> function to avoid type conflict with the emscripten's header.
>>
>> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
>> ---
>>   block/file-posix.c |  6 ++++++
>>   stubs/emscripten.c | 13 +++++++++++++
>>   2 files changed, 19 insertions(+)
>>   create mode 100644 stubs/emscripten.c
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 56d1972d15..22e0ed5069 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -110,6 +110,10 @@
>>   #include <sys/diskslice.h>
>>   #endif
>> +#ifdef EMSCRIPTEN
>> +#include <sys/ioctl.h>
>> +#endif
>> +
>>   /* OS X does not have O_DSYNC */
>>   #ifndef O_DSYNC
>>   #ifdef O_SYNC
>> @@ -2010,6 +2014,7 @@ static int handle_aiocb_write_zeroes_unmap(void 
>> *opaque)
>>       return handle_aiocb_write_zeroes(aiocb);
>>   }
>> +#ifndef EMSCRIPTEN
>>   #ifndef HAVE_COPY_FILE_RANGE
>>   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>>                                off_t *out_off, size_t len, unsigned 
>> int flags)
>> @@ -2023,6 +2028,7 @@ static off_t copy_file_range(int in_fd, off_t 
>> *in_off, int out_fd,
>>   #endif
>>   }
>>   #endif
>> +#endif
>>   /*
>>    * parse_zone - Fill a zone descriptor
>> diff --git a/stubs/emscripten.c b/stubs/emscripten.c
>> new file mode 100644
>> index 0000000000..2157d6349b
>> --- /dev/null
>> +++ b/stubs/emscripten.c
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#include "qemu/osdep.h"
>> +/*
>> + * emscripten exposes copy_file_range declaration but doesn't provide 
>> the
>> + * implementation in the final link. Define the stub here but avoid type
>> + * conflict with the emscripten's header.
>> + */
>> +ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>> +                             off_t *out_off, size_t len, unsigned int 
>> flags)
>> +{
>> +    errno = ENOSYS;
>> +    return -1;
>> +}
> 
> I'd include in this patch this hunk from patch 17:
> 
> -- >8 --
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 63392f5e78..4fd4d362f9 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -89,3 +89,7 @@ if have_system or have_user
>     stub_ss.add(files('hotplug-stubs.c'))
>     stub_ss.add(files('sysbus.c'))
>   endif
> +
> +if host_os == 'emscripten'
> +  stub_ss.add(files('emscripten.c'))
> +endif
> ---

Actually what about checking the symbol presence in meson?
Something like (untested):

-- >8 --
diff --git a/meson.build b/meson.build
index b18c46d16a2..33185fdf315 100644
--- a/meson.build
+++ b/meson.build
@@ -2654,3 +2654,2 @@ config_host_data.set('CONFIG_TIMERFD', 
cc.has_function('timerfd_create'))
  config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
-config_host_data.set('HAVE_COPY_FILE_RANGE', 
cc.has_function('copy_file_range'))
  config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
@@ -2756,2 +2755,6 @@ config_host_data.set('HAVE_UTMPX',

+config_host_data.set('HAVE_COPY_FILE_RANGE', cc.links(gnu_source_prefix 
+ '''
+  #include <unistd.h>
+  int main(void) { return copy_file_range(-1, NULL, -1, NULL, 0, 0); }'''))
  config_host_data.set('CONFIG_EVENTFD', cc.links('''
---

