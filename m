Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CDEC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 14:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNeV-0001KD-69; Fri, 08 Aug 2025 10:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNeK-0001F0-Tj
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:00:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNeI-0004fW-Mk
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:00:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b8de193b60so1270107f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754661644; x=1755266444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hfS5Hmt57Z+KzcDQPGb3wcfopvdyDu9bCffSUpn1V1g=;
 b=nUjqdGcjq9+PvJdFfH6TsJjimR6YGs/QjRjHenhe1T/yxXAAvIHBIbQFFNTMs96LjZ
 IliHtVntQUXyMB+nudxk8thavnlCUcGcGs5lRf4n7d4XKGFFGROUEMoDgnRwbftUQKRI
 hrQeRQQ0oCj4/99aqAxUQqxBIMHPN6e+ereGv5CYcwq8d5AaQJwZhIYooCGtkZ8Jn0EL
 2uzpGAssY5wxqyasU9TJ+aUNaHvjkcToWYfytALn7KPvqSMMHhU5aVoE7wiI6SohBVDH
 Eb91aI9TskbssQ6jJB7yv0EC3Zf9LAiZxngkFR9WT1jXxDE5DVyZMQJ0mCjNNwt3R8JK
 0SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754661644; x=1755266444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hfS5Hmt57Z+KzcDQPGb3wcfopvdyDu9bCffSUpn1V1g=;
 b=OSZW1i1DlBuoX9EzHBtVw1PHqvJh7Z6Db3qlEUO5sn+OsUEH4uGk3BbgxiZrt+qv8s
 6C8V98YFKhRVfLtj2gLOmjUjRSg3778zxk1nAZJeu6KL5XtzdDmdU+nMjxj3c8SLcJdw
 K5aZUe/zDi8RsZyLc88tMuwvAnbw5nmZdrexiPfYfYOHaMKZ4+CFag8aAjq7YVwmEClu
 itLo0pb96Mnw/m8jr2VncGDXmspPpHOLGh2mIvjBdBiPZu+SCFSbjzBHKl6TW93z+Agh
 XXUMAyG337CA1peoH7/B3XhfToUhKLV5h7ugX2ArcGTr9tDgTJalwNEjoCjC5hlJjK/N
 hEaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAiVH8hV0d4RPyk7crPQRCe3nd1U7XxoVr9fQ29FQYIc4pgBzxMo3tSuxuO2aTFFlFHwwgytQop3u8@nongnu.org
X-Gm-Message-State: AOJu0YxGM6dSHhqUfVXnJM/z+YwCP8yXLCRjR7NixB4KxBYsuPODw1AI
 PDGvowwyS43BS2Uw3NY00xfUo560nRCnOXGsuooMvWekH6zFy/Qc9+QwjqbKCJgOal68g5sP2N7
 QFpRi
X-Gm-Gg: ASbGnctQyCD6dIbTA5IF5yC6hMsiZKgzWSHFo5WMgvbYA3jZTOIunYjNXVY+tKkE/u8
 7ZOWczGaKMHmf0PFlxZ3rdfmAACCnvqiCQXtsRgabkCNwxzXSEx2mctvEemIX/TgvSHQT/bWU13
 j9uFekmBFoyu9vkIiQWu8oLSQ8mfZT3BuUYp/BxLRT/YVohbAdqWjybt4SJZtCsZPrPMBe8B0di
 y7z2+rYRrKMwu83KMFHbMZyRy+9LKC5heGy2DRANHrRp918pSNHl46nQ90miKK9B5QdfnMVp7yV
 nhaBftMTZDAjua/guIGghbdTjIXN6tyTfiUHcB/6E/58+kvfTBQnEABN9GrBZqeCphj3Ku/T2bx
 JirR31DFH5L93zEI9m0Q5FEOUGwsA3AIPWp7PypXB8XQeHt/IUPNKgyc5T/Ac+qGlYA==
X-Google-Smtp-Source: AGHT+IG2b3Kxt/joA4u8FEcci7eWsNgm7My+hNWadSXLGaQNjlB9N08Dh3Dsvd8VJE/5Zbd4Qpq8zw==
X-Received: by 2002:a05:6000:144f:b0:3b7:8984:5134 with SMTP id
 ffacd0b85a97d-3b900940321mr2233478f8f.16.1754661644186; 
 Fri, 08 Aug 2025 07:00:44 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458bd5a11d3sm137004285e9.0.2025.08.08.07.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 07:00:43 -0700 (PDT)
Message-ID: <e864d8f9-505c-41d0-90a2-5a6d040caacf@linaro.org>
Date: Fri, 8 Aug 2025 16:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] tcg: Fix error reporting on mprotect() failure in
 tcg_region_init()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-3-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808080823.2638861-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Markus,

On 8/8/25 10:08, Markus Armbruster wrote:
> tcg_region_init() calls one of qemu_mprotect_rwx(),
> qemu_mprotect_rw(), and mprotect(), then reports failure with
> error_setg_errno(&error_fatal, errno, ...).
> 
> The use of &error_fatal is undesirable.  qapi/error.h advises:
> 
>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>   * exit(), because that's more obvious.
> 
> The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
> wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
> mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
> with error_report().  VirtualProtect() doesn't set errno.  mprotect()
> does, but error_report() may clobber it.
> 
> Fix tcg_region_init() to report errors only when it calls mprotect(),
> and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
> reporting otherwise.  Use error_report(), not error_setg().
> 
> Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
> Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tcg/region.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/region.c b/tcg/region.c
> index 7ea0b37a84..74e3b4b774 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -832,13 +832,17 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
>               } else {
>   #ifdef CONFIG_POSIX
>                   rc = mprotect(start, end - start, need_prot);
> +                if (rc) {
> +                    error_report("mprotect of jit buffer: %s",
> +                                 strerror(errno));
> +                }
> +
>   #else
>                   g_assert_not_reached();
>   #endif
>               }
>               if (rc) {
> -                error_setg_errno(&error_fatal, errno,
> -                                 "mprotect of jit buffer");
> +                exit(1);

- Before:

Error displayed when qemu_mprotect_rwx/qemu_mprotect_rw/mprotect fail,
then exit.

- After:

Error only displayed when mprotect() fails, then exit.
Nothing displayed when qemu_mprotect_rwx() or qemu_mprotect_rw() failed,
and exit.

Can we keep the "mprotect of jit buffer" string displayed before
exiting, but using error_report()?

>               }
>           }
>           if (have_prot != 0) {


