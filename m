Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDA2D29C40
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhsAW-0003VF-RE; Mon, 19 Jan 2026 11:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhs9u-0003DP-59
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:31:18 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhs9r-0007xH-Vg
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 11:31:17 -0500
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-b87693c981fso760970866b.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768840274; x=1769445074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KTmJXA9xFq8T8mG6uHTynW56j8YB6+/K0jxdHeoPP+g=;
 b=CajLqZFkuAgULfvAmjihyEHX5THJwXc4Uy32Vyd2gBAzWlGXnLdut4jBMShuZHe9sl
 hkXvGfYyzW5ekWpOwuzxMJvp1pHc+5w0345YeLrCTKeHunFkgkJKePt8jdhJbvKeO9ZE
 gojpdMDOsRuUHnXcSRYzpqQPAxnZfKNviiJMyz3fN01xNcsFaTT0FNReh0eBMggKPAVW
 ufVqRZATq3rurhGSh5sybJDCJVMs1reAFk5XRFAlmJGMmYx5ooRbZzMWWOVAvsYcUQhV
 J0eVkLZKhb/boZbSSH3reP1mBDhPla60xJ5Hdct+/bFGt0FXqQU1SSap5dfs1lT82JVG
 YCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768840274; x=1769445074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KTmJXA9xFq8T8mG6uHTynW56j8YB6+/K0jxdHeoPP+g=;
 b=etek0v3TTf1wLvqp4gH6tRkxUYtH3jfRTW7/IbkP1211059OfJj485zuC+1zf+eSvr
 F6/waX20otmOocwlexB0KStkM+EduzQIy9s4IQoMkEtXZIXLCptnWznQYQDJwLaiMFK/
 WchhU8GtWwromEqqIte0TeoksoXdHuGAWGHCJDFRQMTjdtf3nk0la5OGwRSde3E/vasM
 Ybf+P4r3KzuQIzGF3RfHBs6aBqFh86N98SWpuTALaLI3YO97YrPpu+aLtaUnzL6grrxf
 idGrcvVYXWz5r0BgscnN6hZKVN7hDEMGlwAEO3QneLjV7+RUmPmOxEV473O+MtXD/zmA
 Z2uA==
X-Gm-Message-State: AOJu0Ywwwn0fRkY6hdbL0x2JCoJyDfg1IzoWYz4cEnyNoNa6t7wNytFr
 rwwgGztBzYETRxvK7Nz0ilZDfKE4/BnIUmaOy/6JYImmv/p0RFGpqeS2+pAbe18xcwM=
X-Gm-Gg: AY/fxX76LXY0YbDltOY7OnlYGdWcKorJ24LzpcgVpIhvvx3Pw7ZwGshCYVdQV/XKw3M
 bAGTk11Q4j4SCZ1zI7vR/Tk+ZjCdAX594WYuLa3svgR+43wbslEuEag2lysjEOAxazRpDMYuQUW
 F9ENHPiea0Ht+yPD8A1fwIUurAU5PjQIY1yxNeRAgIQgl8I47Q2zFf6HAaLqz+cz8v7mu2cf/AO
 KNXbRao+wwEZt8/LydFBUOvMVQWoMWFHSU4a6xHfuJmvAbuus7Q2DaUAWzQR8B/FSt1XyP1rsIx
 PKAknL0WF5fZQLh9D1P5qZo1l5ACX1N0X+4BtABFMZ1jVK1t6V1/LuTKZuKiTsuLSwQixdjfxzL
 DIv1rMdef2xmkmJ/a5i6jktbHwJyAW3jkS5wggT6ztx02SFOmqjnMwZPrvR+t/JzjCnfwBYvlCK
 ygcFXTrMTZetc2eVKkSl8RkWyzEESzpCi3ahtMKqDtxC3eoPA7mne85g==
X-Received: by 2002:a17:907:7b99:b0:b84:2fe8:b5d8 with SMTP id
 a640c23a62f3a-b8792d594e8mr1003269766b.14.1768840273643; 
 Mon, 19 Jan 2026 08:31:13 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168c7bsm1204886666b.20.2026.01.19.08.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 08:31:13 -0800 (PST)
Message-ID: <05340117-a75b-4d64-98fe-8868b7bfb5c5@linaro.org>
Date: Mon, 19 Jan 2026 17:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <a40731d0-7add-4d09-9a89-902f75e2eede@linaro.org>
 <8259d920-32bc-41a7-94b9-cd1af9783b6e@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8259d920-32bc-41a7-94b9-cd1af9783b6e@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x641.google.com
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

On 19/1/26 16:42, Vladimir Sementsov-Ogievskiy wrote:
> Hi! Isn't this patch lost?
> 
> On 14.11.25 00:01, Philippe Mathieu-Daudé wrote:
>> On 13/11/25 07:49, Vladimir Sementsov-Ogievskiy wrote:
>>> Test, that fix in previous commit make sense.
>>>
>>> To not break compilation when we build without
>>> 'block', move hexdump.c out of "if have_block"
>>> in meson.build.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>
>>> v3: change meson.build to compile hexdump.c always
>>>
>>>   tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
>>>   util/meson.build         |  2 +-
>>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
>>> index 227acc5995..24fef16a7f 100644
>>> --- a/tests/unit/test-cutils.c
>>> +++ b/tests/unit/test-cutils.c
>>> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>>>       g_assert_cmpstr(si_prefix(18), ==, "E");
>>>   }
>>> +static void test_qemu_hexdump_alignment(void)
>>> +{
>>> +    /*
>>> +     * Test that ASCII part is properly aligned for incomplete lines.
>>> +     * This test catches the bug that was fixed in previous commit
>>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
>>> +     *
>>> +     * We use data that is not aligned to 16 bytes, so last line
>>> +     * is incomplete.
>>> +     */
>>> +    const uint8_t data[] = {
>>> +        /* First line: 16 bytes */
>>> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello 
>>> Wo" */
>>> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! 
>>> Thi" */
>>> +        /* Second line: 5 bytes (incomplete) */
>>> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
>>> +    };
>>> +    char *output = NULL;
>>> +    size_t size;
>>> +    FILE *stream = open_memstream(&output, &size);
>>> +
>>> +    g_assert_nonnull(stream);
>>> +
>>> +    qemu_hexdump(stream, "test", data, sizeof(data));
>>> +    fclose(stream);
>>> +
>>> +    g_assert_nonnull(output);
>>> +
>>> +    /* We expect proper alignment of "s is" part on the second line */
>>> +    const char *expected =
>>> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 
>>> 69   Hello World! Thi\n"
>>> +        "test: 0010: 73 20 69 73  
>>> 20                                      s is \n";
>>
>> Thanks, queued wrapping the long lines to pass checkpatch.pl,
>> as in:
>> https://lore.kernel.org/qemu-devel/20251031211518.38503-9- 
>> philmd@linaro.org/

I have it tagged but there is still a meson issue. I should revisit
but it is low in my priority queue.

