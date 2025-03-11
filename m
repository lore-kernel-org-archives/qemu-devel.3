Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9571AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 10:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trwvl-0003yM-Vo; Tue, 11 Mar 2025 06:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trwvj-0003x4-Su
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:33:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trwvd-0000wP-Kz
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:33:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso1030943f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741689219; x=1742294019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2QFtVKFksrTIIW7ncRbooBuWmo0GjKVw9rVLv+Zl9VY=;
 b=o0IRh85wXPwXp42V2eIstzsWMjyc5RKctlX6aXTRNXA32GBr3wrR48v1RofzVGakN/
 Ldw9x/nc7ma0lqyg4CcI5wH6NLt4Gc0QL2utjqwBdUnJJugMj3s5p8RUf3Um01ZYgN/t
 EMDW0aSg4HuvhJvLwCX3+aFMc7zt1cvv9Z74N+iwMET3tSwHan6mx8HRKfHALG7oUB/m
 +XEO3SeNxZvU8m3seWBQh324+N6UZ9hwrbdMIfMMDzuV6VDnQ3pFLCfyyALSV+K8iWtg
 kaZd6BzNv7AzoJLK5k1WT/7AVhCwp2aynda/x9tTT1JyrU/QfWzOjBIYok0oRO2M72IT
 1NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689219; x=1742294019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2QFtVKFksrTIIW7ncRbooBuWmo0GjKVw9rVLv+Zl9VY=;
 b=QPTrADguT4/5jNj0ZSHN0dbthWJUP9isxQVN9PcTnFG27efQX7yU82jsKV+dnQt6uS
 QnxKdEXFDh8RsfxJcst3aU1Vtm2qahIS8Igpdw8kTsIO7ZzsqMKYfEA8ENUxeeDSPZ60
 nlSz7OzgmeQBpcvY+nksDXeSogNbdlg2d2GwjdHpxDI4YHhloibnGWkXBeebzcx05Zsy
 fsSUb7pgY4GQrq05Iy5LhfXrXkuvHEMyc4snSgbDeT4YAUqjSUGI6aYla9urQNG0Lnn7
 vVhA6T7JxjRrTXgTq55tyAn0+ckVXHSAuYN0zlfSJoTGXhHBLKtNA95on2Gc08Dom6cd
 NN1w==
X-Gm-Message-State: AOJu0YyoI1t0SQT68gEviRQb9IizOt0MsWGifWKsHqtda7ZDzMNYCd/i
 nap6BSIw54/KT5bJ7zitJ1l9ZzSnyU9byfJEQob8SCba9ugK0E5HwU+QwFYV6P+miA3cYUGs+uR
 iIR0=
X-Gm-Gg: ASbGncuFzJs9P4Wtb1G4SB45zQV0mRaYvrbA0bf1wDrfmS6CWdjXNmKLnQDLUhJThnt
 0YUFgFnxOywZgKdDP22Me9z3+XNImmG6QlzhEHNoZYhNM3KRdRu5i7j048m/Fqg0B7l73ZSwpvi
 WgArwjpjwetjSEHoW/FKg40YcOuHKxCN1NtyiNyvhROGi0A9SFQQ72baoW/6sLZn29ZbavYRlFU
 rkz9JoYdNpbbHV7WPLIUDCFRmYzocs8Ls9VLCU4iUnJHZmXg9OnUWTiR3N9GgRtTFURVJ/rYyrQ
 FhCwdtsdctYfXvQ/eYVJt3E/K04rGtttR+syAAYdO5KIL57lRuhuUMMYgFDEnxFpgnzjc6ZAHO2
 fLw+4L4FDTCZO
X-Google-Smtp-Source: AGHT+IGlJpmdAOdxvpIbYtu9RKe8uiKUc0CzNCRKFtZKVm8z6ag72Sb69Sf/uVgQF1yu3AieIp23KA==
X-Received: by 2002:a05:6000:1845:b0:391:2dea:c984 with SMTP id
 ffacd0b85a97d-39132d063f2mr12953094f8f.11.1741689218851; 
 Tue, 11 Mar 2025 03:33:38 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031e3sm17454870f8f.82.2025.03.11.03.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 03:33:38 -0700 (PDT)
Message-ID: <6f4a3582-f3e2-4f0c-8ab6-eeddd1064793@linaro.org>
Date: Tue, 11 Mar 2025 11:33:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-arm@nongnu.org
References: <20250310012825.79614-1-philmd@linaro.org>
 <CAFEAcA_fRWgntwbiFiDJqAkthR8vBzrkLOLkp5GeHD9O8xTMCA@mail.gmail.com>
 <CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Peter,

On 10/3/25 18:28, Peter Maydell wrote:
> On Mon, 10 Mar 2025 at 14:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 10 Mar 2025 at 01:28, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> This series add support for (async) FIFO on the transmit path
>>> of the PL011 UART.
>>
>> This hasn't made the last pre-softfreeze arm pullreq, but
>> I think we can reasonably call "don't do blocking I/O"
>> enough of a bugfix for it to be ok to go in early in the
>> freeze cycle for rc0.
>>
>> I've applied it to target-arm.next.
> 
> ...but it still fails 'make check-functional', though in a
> less easy-to-reproduce way than it did. The problem turns out
> to be that when the guest kernel is doing its earlycon
> output (which is by polling, not interrupt driven) the output
> can be corrupted, which makes the aarch64/test_arm_virt test
> fail to find the "Kernel command line:" output it is looking for.

Thanks for keeping investigating...

> This seems to be because the pl011 code and the chardev
> code disagree about how "couldn't write anything" is
> reported. pl011 here is looking for "0 means wrote nothing",
> but the chardev code reports it as "-1 and errno is EAGAIN".
> 
> I think the chardev code is actually what we need to fix here,
> because it makes basically no effort to guarantee that the
> errno from the underlying write is still in 'errno' by the
> time qemu_chr_fe_write() returns. In particular it may
> call qemu_chr_write_log() or replay_char_write_event_save(),
> both of which will happily trash errno if something fails
> during their execution.

IIUC when retrying qemu_chr_write_buffer(s, buf, len, ofs) could
write less than @len (but still writing few bytes, that information
is stored in @offset) and return -errno, discarding @offset partial
write len.

> So my long-term preference for fixing this is:
>   * fix up any callsites that can't handle a 0 return for
>     "wrote no bytes"
>   * make (and document) qemu_chr_fe_write()'s return value be
>      - 0 == wrote no bytes
>      - >0 == wrote some bytes
>      - <0 == a negative-errno indicating a definite error

This would be an improvement, but not fixing ignored partial
writes mentioned, is that right?

> I had planned in the meantime that we could deal with
> this by squashing in this change to the last patch in
> this series:
> 
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -275,6 +275,9 @@ static gboolean pl011_xmit_cb(void *do_not_use,
> GIOCondition cond, void *opaque)
>       /* Transmit as much data as we can. */
>       bytes_consumed = qemu_chr_fe_write(&s->chr, buf, count);
>       trace_pl011_fifo_tx_xmit_consumed(bytes_consumed);
> +    if (bytes_consumed < 0 && errno == EAGAIN) {
> +        bytes_consumed = 0;
> +    }
>       if (bytes_consumed < 0) {
>           /* Error in back-end: drain the fifo. */
>           printf("oops, bytes_consumed = %d errno = %d\n",
> bytes_consumed, errno);
> 
> 
> which makes the code handle both "returns 0" and "returns -1
> with errno=EAGAIN" as "try again later".
> 
> But even with that I still see the check-functional
> test failing on a clang sanitizer build, though without
> any clear reason why. It's intermittent; running the
> test like this:
> 
> (cd build/arm-clang/ ; PYTHONPATH=../../python:../../tests/functional
> QEMU_TEST_QEMU_BINARY=./qemu-system-aarch64 ./pyvenv/bin/python3
> ../../tests/functional/test_arm_virt.py)
> 
> I got one pass once but mostly it hangs after printing
> some of the early console output. A debug build seems
> more reliable, oddly.
> 
> I'll try to continue investigating this this week, but
> in the meantime I'm going to have to drop this series
> from target-arm.next again, I'm afraid :-(

No worry, I was prepared for another issue :)

Regards,

Phil.

