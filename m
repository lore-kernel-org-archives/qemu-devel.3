Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50B0C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 22:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2HR3-0003Ir-UP; Tue, 08 Apr 2025 18:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2HR0-0003Ig-G1
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 18:28:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2HQy-0003A9-7s
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 18:28:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3386122f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744151322; x=1744756122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FigNQri1F3pPdX1w63q6FumAX/u368o6auyRy2jVS+8=;
 b=HWevKVb8L8LP6s/A2YMZS7+O4PbsnsUsW9P5j8hKr9bVUyG3yxbXFFGhEnVl4UoLc5
 M9Dg0LKamPKEs5BBuJkIX4VQakU6htsEmArokEstfqdG0g63oh78w65PJNpXOZW54dvd
 QrKqh4irksxjaj/lsqSqNjGIhV74qeURjyXj4ATBVC7GewLchRnPtfcEdOISYPy3Dod9
 kdyMwhCMjEQqQouocCaXu5OcfHHkawCtGd2n3bTWIbUbeAR1FW72xjjqhLlqjtO/zqgf
 ZVsNSvRmizgabntTfAAitiScyjM2iEzfzzIpaRbDSQ0pKQ/tFvWiL2f1MI/1f0XobfMy
 tmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744151322; x=1744756122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FigNQri1F3pPdX1w63q6FumAX/u368o6auyRy2jVS+8=;
 b=qTKHYvTeoRZyz73YJlB9Vhu/6F8CH1VksqCbO3erKyXQWU0hBkKWx+k4uHuhLQD1rC
 PDtNfl1m4GVVN+qGNtTT9Ktj2fONJhSs2K+1Ew0yFDpuuYb6GswZPlwIqnakqgOFjQNF
 w0qjP8cVcWT00LFreCoN1Iw7XhYKxz/zc8T9oXMhX0GehInHfCh20eTBM1fHAzRVpUdP
 /vMZVXZBVp32QF1oXdvi40pSDJ284V85W0OaVkIE8umRxkxtqZVUq6JaXiUn51atM46l
 BisOaNi1zk2bEYR2lNefME/PaI9igkAFIkzZke4ovQ0/SZmSZTDg76Ag2VLFaueI7nO/
 vz1Q==
X-Gm-Message-State: AOJu0Yxn/mGfs+p2Pm6Hu4ARFamrm7ONo4RXvKyLHwcnuCpfbJm6Adze
 NAUuSc7U+WwaO5h2aiG8rt+lVstrEwqwa0xDOwcSUjzBpi4NRRJvHXhyS3inCzE=
X-Gm-Gg: ASbGncvKz1d7fZixKDr1WuUS4Y57Rfo6yFWyhnZWSwaeW0viCOdBDc+vn4+Mhu7dPzF
 J5ep4syT3kDt/nYVIcaOoE+kVeSoY36vBouEnELwWk4g0PJIxocb1fz7knW28z9xcwtI/L0FdlS
 i477OenTuBSlL1KSq7F/BB7Xx4MT8mL9bnD8Jv1v2ClosS06nrTfXFwRvdVoizbbGCSrFuHBvjr
 lRDSbnF2/AAImVq2dsNe0qZ6hXdlv03bKTcz+cfXCGPGkma27Yu1R0wFQtT4kgugSok8eQxu2/2
 W2SMxn1ysHaqXT/hioIxT4hD/JLgJl989ou3EjaSdLecifF0naRZ9FlQ2ggfcTrvcR1hNeOC+TI
 XM8gYH7drl0Fd
X-Google-Smtp-Source: AGHT+IEmsTOD7538wFvsJGdGQesLlE0c/8fMPlHNAWnkD5yC7/9uHaX4GWesbZLxanbHhMB2AmignQ==
X-Received: by 2002:a05:6000:2585:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-39d87cd329fmr731449f8f.45.1744151321986; 
 Tue, 08 Apr 2025 15:28:41 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b8161sm16340542f8f.50.2025.04.08.15.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 15:28:41 -0700 (PDT)
Message-ID: <ab3c7bc1-850a-4d58-bc2b-263b9a559d1e@linaro.org>
Date: Wed, 9 Apr 2025 00:28:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/curses: Fix infinite loop on windows
To: Stefan Hajnoczi <stefanha@redhat.com>,
 William Hu <purplearmadillo77@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, kraxel@redhat.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbeNpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=@proton.me>
 <20250408140821.GA548630@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250408140821.GA548630@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 8/4/25 16:08, Stefan Hajnoczi wrote:
> On Thu, Apr 03, 2025 at 01:07:56AM +0000, William Hu via wrote:
>> >From a42046272f0544dd18ed58661e53ea17d1584c2c Mon Sep 17 00:00:00 2001
>> From: William Hu <purplearmadillo77@proton.me>
>> Date: Wed, 2 Apr 2025 12:00:00 -0400
>> Subject: [PATCH] ui/curses: Fix infinite loop on windows
>>
>> Replace -1 comparisons for wint_t with WEOF to fix infinite loop caused by a
>> 65535 == -1 comparison.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2905
>> Signed-off-by: William Hu <purplearmadillo77@proton.me>
>> ---
>>   ui/curses.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> I have CCed Gerd Hoffmann (git-shortlog(1) shows he is the most frequent
> committer to this source file) and Marc-André Lureau (ui/ maintainer
> according to the ./MAINTAINERS file) so they can also review your patch.
> 
>>
>> diff --git a/ui/curses.c b/ui/curses.c
>> index a39aee8762..3f5c5adf78 100644
>> --- a/ui/curses.c
>> +++ b/ui/curses.c
>> @@ -265,7 +265,12 @@ static int curses2foo(const int _curses2foo[], const int _curseskey2foo[],
>>   
>>   static void curses_refresh(DisplayChangeListener *dcl)
>>   {
>> -    int chr, keysym, keycode, keycode_alt;
>> +    /*
>> +     * DO NOT MAKE chr AN INT:
>> +     * Causes silent conversion errors on Windows where wint_t is unsigned short.
>> +     */
>> +    wint_t chr = 0;
>> +    int keysym, keycode, keycode_alt;
>>       enum maybe_keycode maybe_keycode = CURSES_KEYCODE;
>>   
>>       curses_winch_check();
>> @@ -284,8 +289,9 @@ static void curses_refresh(DisplayChangeListener *dcl)
>>           /* while there are any pending key strokes to process */
>>           chr = console_getch(&maybe_keycode);
>>   
>> -        if (chr == -1)
>> +        if (chr == WEOF) {
>>               break;
>> +        }
> 
> Further below there appears to be another instance of the same bug:
> 
>    /* alt or esc key */
>    if (keycode == 1) {
>        enum maybe_keycode next_maybe_keycode = CURSES_KEYCODE;
>        int nextchr = console_getch(&next_maybe_keycode);
> 
>        if (nextchr != -1) {
>            ^^^^^^^^^^^^^

Indeed.

The changes comes from commit 459a707eccc ("curses: support wide input")
from 2019. This isn't a blocker for the next release IMHO.

