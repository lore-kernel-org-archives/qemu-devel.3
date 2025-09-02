Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CBECA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLtc-00067W-4Y; Tue, 02 Sep 2025 03:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLtZ-00067E-MJ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:57:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLtX-0002XJ-0u
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:57:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ce772ce0dbso3422516f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799852; x=1757404652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0H/nU5oQw9mkQ3E7tv0e06Pzue129nTlkebdk/UkBhk=;
 b=HC/Jtfw1w743LJ/7UPdUKMeuyV2yTZipJr5N+2g7mJC3+60pRxFLjmsqHy71BOfTdi
 Fyw7rm4Np8Ng/ex/ZhLF7HRuxwSVhzIAtZbY1+uyQ+kBEQt1w2btjPhNBRPMAiIB5PdP
 nfFqw54XaD7VEKnbghQBMwdvoB0WWA9sS6PVJ/FweqjF809AJNIY5uS5BZlmI+dWLmKa
 qca94j+yF7WmtifmvMjyZK73PAtvWQ0wGeMmsfg/LdcMQrRy6oLmfCL5tMC/8dysLGGb
 VfvHDCVxm4Fdrn8cXtnU5vWEHW7mhHDPEAqmuf99nXod9AnkELlNSFhmzkEUERt1xx00
 X49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799852; x=1757404652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0H/nU5oQw9mkQ3E7tv0e06Pzue129nTlkebdk/UkBhk=;
 b=wtrFFQwoqLU0zzJXhOAuU/iFIMKbd/8TIY2W5ADRYNgn/fvXByb7+8aoj214D17AT3
 YfDJ7LmtBw5AYPyBMvGb9TB8ZpxtTdIYFuksX5fZ9iZG0nYXc46Cm+F/CyLZqJyHlLjD
 PTjDbI8DVQP0Hcr4SsX0shg3tq9XkoIMZvpmKTNUFwdCQkNUY5Ta1j/cNi9a+qNEC14i
 wVGeBWa3mmzvBqPvVzgXYSpOHtQ2OzE3Sa6um34jyMTE1/WvrqWfKiiaQu8pLFUPqmu0
 OafImAw80JGrPR62NoDQqFgJDSKUBlyXUMj9LvI+jOIO4ZhKr5nXFg5I3LSZLoa9uaJc
 G8pQ==
X-Gm-Message-State: AOJu0YwMEnJNDYgDL+r3QUTYc15GBapxnj2H2EuDWwLwbMLuDca/LNR8
 fuKWMEyGmuv85Dk20DnqaLMOmOy9wYG8Kh13a+JuUCnFksut942Nq7xXuMQqy6lD1E8=
X-Gm-Gg: ASbGncuU7K0ZiyehxKU1VZ/TRE4BQnUjYZYex01pe7KMyF861nfTcrb3MC5bHHU2rU6
 KPzYPR//KaHgMrwJwbh5wJA+/3bSi+Lf8uvek7PA8NK+LHlmVOML1byy/eGwEses14mWO0Q3P4R
 DhuK91MBVP4j1RQmBAFFTkPFzm4Fq3d3f0pg+Qo45LApf7PfbiuAVkwLUPRi8kjOte9HCHhNTaw
 WQA7jXtAEuYaz65yyg+6CTxGrDF6xBVOfO0qquSVpKPCzGaUbKDLEVzm4lRCnTxffonFo8syRsm
 LgyqRtZaIcaEJkFatlwEKtJrfdqW008lUX/ZGWZzyg+Unw1+lBOA/gzt/E4pHui8/VWkaftocK7
 q971t6YwKBBjw4aQSxKUxPOWVapAEuxGT4NaRoDik7BuAlrry
X-Google-Smtp-Source: AGHT+IH+xoPuRcE2RocnZHju493OogRDldqgNFhiri5kmjawY+Yf3OuOVvaLcVDVPIszqbmUrT8AeQ==
X-Received: by 2002:a05:6000:310f:b0:3cd:f441:9222 with SMTP id
 ffacd0b85a97d-3d1dea8caf8mr8158854f8f.35.1756799852136; 
 Tue, 02 Sep 2025 00:57:32 -0700 (PDT)
Received: from [192.168.23.199] ([193.33.57.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d7ac825b88sm5913131f8f.7.2025.09.02.00.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 00:57:31 -0700 (PDT)
Message-ID: <9b859c3f-0c9a-4c22-836f-ea69b38c5928@linaro.org>
Date: Tue, 2 Sep 2025 09:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] contrib/plugins: uftrace
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
 <a39236c9-d6e7-4ff3-81a0-bf83b579475d@linaro.org>
 <87y0qy14pi.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87y0qy14pi.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

On 2025-09-01 19:07, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 2025-08-08 13:41, Pierrick Bouvier wrote:
>>> This plugin generates a binary trace compatible with the excellent uftrace:
>>> https://github.com/namhyung/uftrace
>>> In short, it tracks all function calls performed during execution,
>>> based on
>>> frame pointer analysis. A big advantage over "uftrace record" is that it works
>>> in system mode, allowing to trace a full system execution, which was the
>>> original goal. It works as well in user mode, but uftrace itself already does
>>> this. It's implemented for aarch64 and x86_64.
>>> Let's start with concrete examples of the result.
>>> First, in system mode, booting a stack using TF-A + U-boot + Linux:
>>> - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
>>> https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
>>> - Stat and open syscalls in kernel
>>> https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
>>> - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
>>> https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
>>> Full trace is available here:
>>> https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
>>> You can download and open it on https://ui.perfetto.dev/ to explore it.
>>> Second, in user mode, tracing qemu-aarch64 (itself) running git
>>> --help:
>>> - Loading program and its interpreter
>>> https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
>>> - TB creation
>>> https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
>>> Full trace is available here:
>>> https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz
>>> If you had curiosity and now you're ready to give some attention,
>>> most of the
>>> details you want to read are included in the documentation patch (final one).
>>> Overhead is around x5-x15, and long traces can be directly filtered
>>> with uftrace
>>> if needed.
>>> I hope this plugin can help people trying to understand what happens
>>> out of the
>>> user space, and get a better grasp of how firmwares, bootloader, and kernel
>>> interact behind the curtain.
>>> v6
>>> --
>>> - fix types and spelling mistakes
>>> - use _MAX for privilege level enums
>>> - uftrace info file: use empty strings
>>> - trace flush: assert we wrote all data
>>> - doc: added style for keyboard keys
>>> - added URL to document uftrace entry format
>>> - updated comment in vcpu_tb_trans to explain why we always instrument the first
>>>     instruction in tb
>>> v5
>>> --
>>> - addressed Alex comments
>>> - split plugin implementation in several commits
>>> - removed instruction based timestamps (only use time based timestamps)
>>> - removed sampling implementation
>>> v4
>>> --
>>> - add support for x64
>>> v3
>>> --
>>> - fix missing include unistd.h (build failed on MacOS only)
>>> v2
>>> --
>>> - trace active stacks on exit
>>> - do not erase map generated in system_emulation
>>> - add documentation to generate restricted visual traces around specific events
>>>     of execution
>>> Pierrick Bouvier (9):
>>>     contrib/plugins/uftrace: skeleton file
>>>     contrib/plugins/uftrace: define cpu operations and implement aarch64
>>>     contrib/plugins/uftrace: track callstack
>>>     contrib/plugins/uftrace: implement tracing
>>>     contrib/plugins/uftrace: implement privilege level tracing
>>>     contrib/plugins/uftrace: generate additional files for uftrace
>>>     contrib/plugins/uftrace: implement x64 support
>>>     contrib/plugins/uftrace_symbols.py
>>>     contrib/plugins/uftrace: add documentation
>>>    docs/about/emulation.rst           | 199 +++++++
>>>    contrib/plugins/uftrace.c          | 876 +++++++++++++++++++++++++++++
>>>    contrib/plugins/meson.build        |   3 +-
>>>    contrib/plugins/uftrace_symbols.py | 152 +++++
>>>    4 files changed, 1229 insertions(+), 1 deletion(-)
>>>    create mode 100644 contrib/plugins/uftrace.c
>>>    create mode 100755 contrib/plugins/uftrace_symbols.py
>>>
>>
>> Ping on this series.
>> Comments from reviewers have been addressed.
>> Alex, are there other changes you would like before pulling this?
> 
> I thought there were the some changes Philippe asked for? I can pull v7
> once it is posted. There is no massive rush as the tree has just
> re-opened.
>

It was a polite way to ask if you had other comments to address before 
sending a v7, which is mostly about styling issues, so maybe not worth 
being sent as it is.
I just posted v7, let me know there if you need other changes before 
considering it as ready.

I don't mind if the series is pulled later, but I'm trying to address 
all comments as soon as possible and move forward on other topics, thus 
my previous ping.

Regards,
Pierrick

