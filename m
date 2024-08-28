Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA686C54FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIQq-0007cO-0I; Wed, 28 Aug 2024 09:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sjIQn-0007Ww-Rx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:09:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sjIQl-000758-Id
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:09:49 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37198a6da58so4667738f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724850585; x=1725455385;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VyB7KCHCM66q0D2pmUfZa1YDm80YM7w1Sh9cP8B1Ths=;
 b=gDjVulgi8wu7sqs7E2cWChOae5jqcz3DS9SBLXRnpsqFJO0mp9AXcU7uY/JpjptIt3
 rKbSRnguztus8ODEpbz+3dxOur/fXQ6Olze5iUIG7tiwaPpBdZo+3uVS+5Txx87AKXom
 EzaTv4l+V8r10XDE1fKSHVM9UYUF5uWEE8Wyhat95o9LE+gldyhzZd1hKUxQkt/fsLvm
 8nJi8qFj9a79NVyQkc6SCEWmu0qzhSYY735rO2vmQEZD9JWWEhBvTC7io9H39QhHdHfV
 TfV5pu3HINphkqBS5Ruza4mJxe/cV75uEPEcKMY5KE/sNS/p7PpaYMEx9zazGYN7FFOa
 ReDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724850585; x=1725455385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VyB7KCHCM66q0D2pmUfZa1YDm80YM7w1Sh9cP8B1Ths=;
 b=mEs3XEmjORgq5G0Ut4eq/QkUF3kDlYywm6v30rB06HjpR2HTSbciBhthfPHwcb64Uf
 7rQ9KvCe16ZooX+r/s+YUBJ6Fwa2egaLKcUWe/Zqz5jH0m6/t7qU8I7T0n7PA/dIkzd5
 o6IkYv2ILWrtvmb+ALXUsz0NPcZ6oDDeTOV25vocsQxcWg2IvZIATz13zg1L/gpt2uLS
 9Ns8qVdJ8croAump6vab4MMf6yUMxIn5TxzWwV56iuNCuTp3674y6L1iVV8lcS+5uvOR
 ILkFILgf/e+kY3xCqJfRDMSSl7ECqV65TOH0o5QsEDEXa+5yP5F1Q3YkUGj8drzlxtqd
 ZYuA==
X-Gm-Message-State: AOJu0YxHd/bATguDvUACzmU432ivPCarTa0FDoFkI0E2v4oJ+/Fi7qhA
 oAhavr3fsXyOxNCHu0oaGuSyRRRig74PVAqPN5qPzHsVlZHupOtXYN7WKUgM8/M=
X-Google-Smtp-Source: AGHT+IFxZ24WOR2/T7pSh3pfXQXmeB5KsWr94TGKwdrKtVBaoHE//OI1Vy7eyT6WdkE/uN0Dzt3Bgw==
X-Received: by 2002:a5d:4592:0:b0:367:9903:a91 with SMTP id
 ffacd0b85a97d-37311840258mr12506799f8f.11.1724850584762; 
 Wed, 28 Aug 2024 06:09:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308110603sm15613971f8f.2.2024.08.28.06.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 06:09:44 -0700 (PDT)
Message-ID: <1beddaa1-1075-4204-be77-8c5c66df8ceb@rivosinc.com>
Date: Wed, 28 Aug 2024 15:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/6] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
 <20240805003130.1421051-5-richard.henderson@linaro.org>
 <Zs8ctyVxQz3iLDmM@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <Zs8ctyVxQz3iLDmM@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 28/08/2024 14:48, Daniel P. Berrangé wrote:
> This is already merged, but I have two comments - one improvement
> and one bug which we should probably fix before release.
> 
> On Mon, Aug 05, 2024 at 10:31:26AM +1000, Richard Henderson wrote:
>> From: Clément Léger <cleger@rivosinc.com>
>>
>> In order to make it cleaner, split qemu_close_all_open_fd() logic into
>> multiple subfunctions (close with close_range(), with /proc/self/fd and
>> fallback).
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20240802145423.3232974-3-cleger@rivosinc.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  util/oslib-posix.c | 50 ++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 37 insertions(+), 13 deletions(-)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 1e867efa47..9b79fc7cff 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -808,27 +808,16 @@ int qemu_msync(void *addr, size_t length, int fd)
>>      return msync(addr, length, MS_SYNC);
>>  }
>>  
>> -/*
>> - * Close all open file descriptors.
>> - */
>> -void qemu_close_all_open_fd(void)
>> +static bool qemu_close_all_open_fd_proc(void)
>>  {
>>      struct dirent *de;
>>      int fd, dfd;
>>      DIR *dir;
>>  
>> -#ifdef CONFIG_CLOSE_RANGE
>> -    int r = close_range(0, ~0U, 0);
>> -    if (!r) {
>> -        /* Success, no need to try other ways. */
>> -        return;
>> -    }
>> -#endif
>> -
>>      dir = opendir("/proc/self/fd");
> 
> IIUC from previous threads this is valid on Linux and on Solaris.
> 
> On FreeBSD & macOS, you need /dev/fd though.

Acked.

> 
>>      if (!dir) {
>>          /* If /proc is not mounted, there is nothing that can be done. */
>> -        return;
>> +        return false;
>>      }
>>      /* Avoid closing the directory. */
>>      dfd = dirfd(dir);
>> @@ -840,4 +829,39 @@ void qemu_close_all_open_fd(void)
>>          }
>>      }
>>      closedir(dir);
>> +
>> +    return true;
>> +}
>> +
>> +static bool qemu_close_all_open_fd_close_range(void)
>> +{
>> +#ifdef CONFIG_CLOSE_RANGE
>> +    int r = close_range(0, ~0U, 0);
>> +    if (!r) {
>> +        /* Success, no need to try other ways. */
>> +        return true;
>> +    }
>> +#endif
>> +    return false;
>> +}
>> +
>> +static void qemu_close_all_open_fd_fallback(void)
>> +{
>> +    int open_max = sysconf(_SC_OPEN_MAX), i;
>> +
>> +    /* Fallback */
>> +    for (i = 0; i < open_max; i++) {
>> +        close(i);
>> +    }
> 
> I'm told that sysconf(_SC_OPEN_MAX) returns -1 on some versions of
> macOS. "Luckily" since we assigned to 'int' rather than 'unsigned int'
> this will result in us not closing any FDs in this fallback path,
> rather than trying to close several billion FDs (an effective hang).
> 
> If _SC_OPEN_MAX returns -1, we should fallback to the OPEN_MAX
> constant on macOS (see commit de448e0f26e710e9d2b7fc91393c40ac24b75847
> which tackled a similar issue wrt getrlimit), and fallback to perhaps
> a hardcoded 1024 on non-macOS.

Thanks for catching this, I can submit these fixes except if you already
prepared something though.

Clément

> 
> 
>> +}
>> +
>> +/*
>> + * Close all open file descriptors.
>> + */
>> +void qemu_close_all_open_fd(void)
>> +{
>> +    if (!qemu_close_all_open_fd_close_range() &&
>> +        !qemu_close_all_open_fd_proc()) {
>> +        qemu_close_all_open_fd_fallback();
>> +    }
>>  }
>> -- 
>> 2.43.0
>>
>>
> 
> With regards,
> Daniel
> 
> [1] https://github.com/open-mpi/ompi/issues/10358


