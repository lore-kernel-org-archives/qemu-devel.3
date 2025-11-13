Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDC6CD98E4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 21:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJeon-0004HH-11; Thu, 13 Nov 2025 16:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJeRs-00075c-Ks
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:01:44 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJeRq-0004No-Qk
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:01:44 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47777000dadso9634325e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763067700; x=1763672500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bcXZxED5oaI5ZZ1ixxonT+EJs/qv1pAynNJUmT7AXNI=;
 b=FQDmF81x75C8ufPCLsFVuYrjir2csouu833RiUtUZoPdFocKOeIbd6+LoCj/Aw/CyP
 R053Ea2IiVXjAFQFmNBUBtHAjpP77VohrUSCg5XNCxtLIK12jDUt4PvqIck7WBiukJ1l
 mNUf1DrV7chV3gtZhP97Lw3LXS/gaLZ6/CfOP81rvGuJNDgOjo1qgDcHhFq7bkyi7bqy
 JS7WI4O5Vr6XzEuXOhGFh9eQ0I0Qsk7ZyKWnBbVGC8gq6C6oNO19rRt5nqOz0oAeRVUP
 AKL1YWVsHNLFeycunEAN6XxAIakMtX/Y/sRpxU2xj8MJghEcrKEzCog3gXnBEsEfhTZe
 dLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763067700; x=1763672500;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bcXZxED5oaI5ZZ1ixxonT+EJs/qv1pAynNJUmT7AXNI=;
 b=gq1o4Mb/+YqZiYyMk96LE6pjEHBZBnDX9KfgrwpC5PU6qIo3YvvntPlfA8NqeWnS5N
 lnQ/bqjxmekvNp99LQPgzmTKTkj5ribewjKYjMPOh4/5H3e5YVt/gOsj+l7xIWLk47ug
 5XtXm8JtB/c4Riifve7OiOmjphLHq3IhAHsuy3n0qwuYhLjH/HzK6YrZ70zr4lRT+vt+
 uWzCePa1pUN5O+6LgNTDGJ16nRxciIXXABZ8Ul5ZKgkHAoAES51jYBoWxpABQvkwh9T7
 qR5aW4uGfxsplGCJus7hkTaxqA9/vNwFFRGzQkInZ9Yf9ZuwsePOs2scxulX5akni0eg
 rCpw==
X-Gm-Message-State: AOJu0YyC728ZTc+yDQKH7/SJzI37aBZDDma2wjkitV0C4ifFeAncqHOv
 +8VAdE1FoV2DdyDxBmkaPPl+Kzxmo4cTk8hl34fB3nv6ipAg9/1ImVJqGr2Prmyj35Q=
X-Gm-Gg: ASbGncs3k/4FUgrPAVBkmtjaj15KwYS756vhTQVCXjcsMIiBWfgmLZt/xuJOrVFqSQs
 gnOvozO4GPyvb5N+r/jCEy/xQcmeyTzGzJzdWDGZNvTvZ+CHYxzZcFSvJOGfIdN1vsGCSo6JPqb
 ET8GKQy6o8DPCyPT0fh/JDjz+txeLOGUmLm4pYwyXIpwZy5mTYLfhFENYZvbIPikAyazJw9NGVt
 BIcYCOuMQMK5paj+6zIwkxn0gC56ep3b8D33QL9p1VRqtuskL3/vLY7XDkVYbdV+smS7Fqh5yi1
 kqHWPQUMvfyKlSvroBWQ3POgXrNOD/BrT+QHDUDvnPIHyKRY+LSbU3qHatqYkHNWCAzphKg6uO1
 0hP+XYe6NCkmj5v0aau0js/ApDI/ayg6R2AUg7lI9cqfup+EyS8viZ8qyt4Z8d86ik0oyUsgZDe
 RgzKctE/T6IrtQ5vuBh8YoqDuj6p74sqNRNdphvqQObVo9dVTO1zZ4vw==
X-Google-Smtp-Source: AGHT+IGqAMPOSqw7mOTw5aC+vFnMhd3sFLTg/pCY4PAnSs9//2LImu3kaVtizxhCLWucWiQyQeWp3Q==
X-Received: by 2002:a05:600c:4714:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-4778feaa8ffmr6800795e9.24.1763067699828; 
 Thu, 13 Nov 2025 13:01:39 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f17291sm5899184f8f.32.2025.11.13.13.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 13:01:39 -0800 (PST)
Message-ID: <a40731d0-7add-4d09-9a89-902f75e2eede@linaro.org>
Date: Thu, 13 Nov 2025 22:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251113064935.342018-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 13/11/25 07:49, Vladimir Sementsov-Ogievskiy wrote:
> Test, that fix in previous commit make sense.
> 
> To not break compilation when we build without
> 'block', move hexdump.c out of "if have_block"
> in meson.build.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> v3: change meson.build to compile hexdump.c always
> 
>   tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
>   util/meson.build         |  2 +-
>   2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> index 227acc5995..24fef16a7f 100644
> --- a/tests/unit/test-cutils.c
> +++ b/tests/unit/test-cutils.c
> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>       g_assert_cmpstr(si_prefix(18), ==, "E");
>   }
>   
> +static void test_qemu_hexdump_alignment(void)
> +{
> +    /*
> +     * Test that ASCII part is properly aligned for incomplete lines.
> +     * This test catches the bug that was fixed in previous commit
> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
> +     *
> +     * We use data that is not aligned to 16 bytes, so last line
> +     * is incomplete.
> +     */
> +    const uint8_t data[] = {
> +        /* First line: 16 bytes */
> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
> +        /* Second line: 5 bytes (incomplete) */
> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
> +    };
> +    char *output = NULL;
> +    size_t size;
> +    FILE *stream = open_memstream(&output, &size);
> +
> +    g_assert_nonnull(stream);
> +
> +    qemu_hexdump(stream, "test", data, sizeof(data));
> +    fclose(stream);
> +
> +    g_assert_nonnull(output);
> +
> +    /* We expect proper alignment of "s is" part on the second line */
> +    const char *expected =
> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   Hello World! Thi\n"
> +        "test: 0010: 73 20 69 73  20                                      s is \n";

Thanks, queued wrapping the long lines to pass checkpatch.pl,
as in:
https://lore.kernel.org/qemu-devel/20251031211518.38503-9-philmd@linaro.org/

