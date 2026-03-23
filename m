Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80B8EC01A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bCQ-0000d3-9G; Mon, 23 Mar 2026 05:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bCE-0000cV-Vl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:03:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bCD-0004Bi-By
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:03:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso1598824f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774256616; x=1774861416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hJJ2BG25aSCsijLM3VL6ECCYkYrFRzIPlvsGNm/7Xy0=;
 b=z8xQZL1JOXP89qWljoZGAjziT86Em4Hezf66oHo7uJScWjcBDKfc8IDrPEC7mhuLoT
 INCMLKFPyzpEZLNJdaxI+JxdI5wzRWMYHGt1jHIoRgtXvjcqFf8SJNKcF4J7uWFKZDFm
 Ps9ZXmSGMAHUklmEWTt9FlUJT/fC3G/cpjicKGEMm3PryZaxC3bOQF7WGY+xM/He2wk5
 0nQR5V0Y/CfCL44dDXX0agu65UQxv7DbTNItSvhJmH6cXjrDJxPk1B+6WKAUbcUEiplb
 cYOOlkBUw3/OH8idf7c0/Zp8l4j2852E2VUz0+fdmZ9ZXhu9GfJS40n5DapZCdbV0ry9
 xybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774256616; x=1774861416;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hJJ2BG25aSCsijLM3VL6ECCYkYrFRzIPlvsGNm/7Xy0=;
 b=p0s+CRlRLQg5jLd7+EpOxVW18yxLorGktaS2QzzfieiY2WaLk4z2VT0EXH5szY0iHG
 QSHguyj0KNsLPUqI56sBmxpUuxEOCnm3MS4hgAJ8uEo++dDyAkWfLMu+9QDlrYrHIKvO
 FRnyScr68suOcRQm6P7tMRSzXDiJ8d/sVYKjdE4wgnuy7+Tj76PRt11SiqQHHK89tA0H
 m+ssGuxIkjZgoylY955hVjqWz4DmgwbrLpmeTR/P9MLMe7NAqEsfCxFcQYmlr1ZmFOkp
 ScAAKBU6GjQujAye6tymFke/GQudnRKUvHujXQAhzOkNF2Ca/ZlDTtPLyvWvcaQjN2iU
 P8sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy16MUkEtTHoUYAZw/JeyvXG9vRFRmlEqW6UEKF6tHvvFecZDZGFFUKC7db8+HZitgbq3W9MCOC20C@nongnu.org
X-Gm-Message-State: AOJu0Yx+m8zdetMON2/bdqK6wTEzZYGqWWsRZNJPc5Ks64g8sSm+R6af
 7nUvlzvcVxIYF3BAgvVAsRQDSs7Vf/cSsizM1o5dxnd/zFXKQgSZ6L9T8BAzvzboaYM=
X-Gm-Gg: ATEYQzwMV0ejm8IGpFDrAZjaYbxkORuBD4fV7YpMrqB36lwrvnJwB3wFoJw6VFVEpt4
 lFwfQM+IQEE/E02c0L42oAgMSOEcfSXE575IUmHSFevfEGgv0+PzS3UqfZMZSwdX/c2UVK/Z85K
 Am9Ge94858X/xHbkGRoFDXmckGS2kmtni6BFBZe7gB5/FR0M91XWMHnhvafYjSmKDSUdP32Qhq6
 6iZJiNN3tQXxmPPaeLqsVYaPH4FCaIOM7Fpq1RRsKMMCog40UKfPVclh5lsTCgZTRwNQo9FDBSz
 zPKLjoFI+/5qwQwMEE1L8YMkTkHurnBjcXbR85DxHPgEZDvgWrrFZPtAYxuXED4YBWKWbO/TV3Q
 bnUd939+g2TCzgz7zS+4iaF+6lZLYiuWjZi25admgN5d/YlxNtcE9ALnMEfeajU3qRu8omcbiQF
 mFak7AptpfnQV/DqjWvn6HnMNKxEElXcWP0HkFR5o2Giyazr7tx7Ie2WKKNsBojh6vnA==
X-Received: by 2002:a05:6000:2dc7:b0:439:b811:11de with SMTP id
 ffacd0b85a97d-43b6424312cmr17158357f8f.7.1774256615721; 
 Mon, 23 Mar 2026 02:03:35 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6471a297sm28311905f8f.37.2026.03.23.02.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:03:34 -0700 (PDT)
Message-ID: <dd44fd32-09b6-4c88-ab55-4472d5c4366b@linaro.org>
Date: Mon, 23 Mar 2026 10:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>
References: <20251112134143.27194-1-philmd@linaro.org>
 <0faef1dc-6fde-41b1-bf1e-8ecfe49033f7@tls.msk.ru>
 <a50b8ccb-4d13-431b-836e-b08e5add71bd@linaro.org>
 <95e61064-c8e8-4c36-9371-cbd28ab737c8@tls.msk.ru>
 <17f7b53d-dbb7-4090-a6ac-671c85dd611d@linaro.org>
 <8ca786b1-765b-4dc4-92fd-6ba6aeedf098@tls.msk.ru>
 <c8536f00-efbc-441a-8725-bfe80aa8666c@linaro.org>
 <CAJ+F1CKkpcYCAnv1YACrnySodumarEQy0Ff-UedWY_Q4u3C7vg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1CKkpcYCAnv1YACrnySodumarEQy0Ff-UedWY_Q4u3C7vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 23/3/26 09:45, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Mar 23, 2026 at 6:05 AM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 3/21/26 11:15 PM, Michael Tokarev wrote:
>>> On 12.02.2026 23:13, Philippe Mathieu-Daudé wrote:
>>>
>>>>>>>    From this patchset, 1 change has now found its way to the master
>>>>>>> branch:
>>>>>>>
>>>>>>>     chardev/char-pty: Do not ignore chr_write() failures
>>>>>>>
>>>>>>> Besides it, the following 2 changes were marked for-stable:
>>>>>>>
>>>>>>>     chardev/char: Allow partial writes in qemu_chr_write()
>>>>>>>     chardev/char: Preserve %errno in qemu_chr_write()
>>>>>>>
>>>>>>> Are other changes (including the above 2) not needed anymore?
>>>>>>
>>>>>> They are, I need to reply to Marc-André and respin a v4...
> 
> What was that for?

On patch #6:

   > the final return value that should be changed?
   > "offset && !write_all ? offset : res" ?

> 
>>>>>>
>>>>>> Old bugs so can wait 11.0 :S
>>>>>
>>>>> Found an old(ish) thread...  ping? :))
>>>>
>>>> Cc'ing new docs/ maintainer :P
>>>
>>> Ping *N?  11.0 is almost out already..
>>>
>>> /mjt
>>
>> I didn't answer previously, since it was touching code in addition to
>> docs, and was expecting this to be picked up by chardev maintainer
>> (Marc-André in this case if I'm right). So I assumed it fell back to a
>> subsystem documentation change and not a general one I was supposed to take.
>>
> 
> I think we missed the boat for 11.0.
> 
> Philippe, maybe you can rebase, and I will queue for 11.1?

Maybe, no promise.

