Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FAEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1Fo-00012d-Ra; Mon, 05 May 2025 15:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1Fm-00011Z-VO
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:13:27 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1Fl-0001Aw-3I
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:13:26 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso5449233b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746472403; x=1747077203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YGdq//m3INcuig8p/gmK1g6h5JnGNEj9ap9ZqVsU1Fk=;
 b=zwGdNB08qYxNfHVvdAk1jwSUG4cNbBojzNSBY3uQhOJv6xU3KbWJTvXfeoJggpk7cW
 0L/pc4CQN4qvFJ2yXSYU78u7x8dcBJ3uB9tZ+PVvZQD4qpc9Vtb6RrKRtBZFCEHiLJik
 /vykMbXmRufxAzOZvivtj8/pLUWdWAKIzAgm6df4StqTlkNpVeiqDuYE8knd/iHvzE5G
 SFkUQk/jA3kKm+38Y4RBB4zqCTXO7lhwUR7ZioTUq9t0yJ/zy5JoRHH4eHPESYvgzF8N
 0v2h2N2MT6fWoG1Gtu9hTHDbx4qFCpToetr69TM3YB2O7y/V3owUoyExY7o4hO97Ge39
 leAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746472403; x=1747077203;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YGdq//m3INcuig8p/gmK1g6h5JnGNEj9ap9ZqVsU1Fk=;
 b=ckgDLNPdCpepiFHyhyvY2+QB0weboUBJ2IzwDfpTJAwIDslZ4tko7EelW43TMmHgAp
 sFw/CdBR3A4qsw7xNkMrM0yTF37RhzUfYDuu++u65WuGO02bavzOyE4uEhdFD23bhXrZ
 NG+IT0kkwnRmqo004dAu34ZEpd6/ExzOC3XfPYQIh0oNfW2dTI2IL3Qkb/5B4w+PNOkY
 fwJ89fPD5ScQUTtbEpJ4h5n4SsZ+S+nBLt0KUMsVbvzk3cyf53whdgGkaxgFc1SCbI6V
 FKD0ExsbC5YDPOiuavwwXEg0y5EO549FhOzBC41z5lUxgRL16UG6xpFyhgs6Xg5/gplZ
 slDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPq0yh632k0yNMJl/rchvi4QQcutL/VkCM/P5aocPzo6G+Y+zQ/7y/iWielSdsaEr0EYRo76urETdO@nongnu.org
X-Gm-Message-State: AOJu0YyYgcBbBw0c4CE2L9oG8FszgwpwXdHm7o2Vo+pmZ2nA5q3qCN/D
 MOINsPUPQU58QU66pJZD1J/smm4f6LcN6EW/z0gcgTwIXAsYYzrpQkLP32Bn5ZQ=
X-Gm-Gg: ASbGncswj46BmEwonJi339lzzbuTbOEj1MzxzoTnJVf8tx1Ffsqey/MYQlSJU+lqEv/
 bPDVAIDEaAWLQcjTMtv8vU9a4YDg0jmP7L6flUNH+q93kUW/75vhco6dQpk4sAhoPvgrt5OiFNS
 4RDPBMR3J6uBjHsf5SO2B3hmJ5ab923aozB8AQCRbo5A+oP53vEkI8YkzmiUf/8NGMghidIPtXh
 /VWVquaib6xGcq14NsP3q8ajXZy/8QLuNyTF8qvchlyBuj6+zygL35QTJF+Un0/cFNKUMFCYsIC
 +Q6ceLvWRm6F7wLX0uIZntoGPGPzBfrbPsa8U8cXGjL45Hjb1gzOrw==
X-Google-Smtp-Source: AGHT+IFrsurwljHDZHCpmvGiUBCgCCpFC0W9PM1+jeUQ8VrUG3LmACvTGpfj3L80UXzMSnp3716x4g==
X-Received: by 2002:a17:90b:3c0b:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-30a61a6f700mr11094160a91.32.1746472402932; 
 Mon, 05 May 2025 12:13:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47476120sm9404635a91.13.2025.05.05.12.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:13:22 -0700 (PDT)
Message-ID: <e35b14cf-b16b-4d33-a82a-4dca8f94fa82@linaro.org>
Date: Mon, 5 May 2025 12:13:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/48] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-2-pierrick.bouvier@linaro.org>
 <dc27e3f6-ceac-4e05-9652-28634d4fe73c@linaro.org>
 <a365d727-8bdd-4b27-a763-08c5b3384040@linaro.org>
In-Reply-To: <a365d727-8bdd-4b27-a763-08c5b3384040@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/5/25 11:39 AM, Pierrick Bouvier wrote:
> On 5/5/25 3:44 AM, Philippe Mathieu-Daudé wrote:
>> On 5/5/25 03:51, Pierrick Bouvier wrote:
>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> CPUARMState::pc is of type uint64_t.
>>
>> Richard made a comment on this description:
>> https://lore.kernel.org/qemu-devel/655c920b-8204-456f-91a3-85129c5e3b06@linaro.org/
>>
> 
> Thanks!
> Once your updated commit is upstream, I can rebase the series on top of it.
> 

I'll just update this commit here, so the series is not blocked meanwhile.

>>>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>     target/arm/internals.h   | 6 +++---
>>>     target/arm/hyp_gdbstub.c | 6 +++---
>>>     2 files changed, 6 insertions(+), 6 deletions(-)
>>
> 


