Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2ABC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI2xT-0007um-Jf; Thu, 22 May 2025 06:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uI2xS-0007uM-1T
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:15:26 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uI2xN-0003yD-I5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:15:25 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b26f5eb16a5so5151931a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747908919; x=1748513719;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nE79lOCjGyV1qdnP886Di7odOMDmNNG0tEBkSKelc/s=;
 b=QWaBMxAQLqnI1ZruHFDCl1cvt0KL7GXtBQ41bnxi8K/47MNVDQS/AEh3W6ppNm4glX
 zf43LcNwAc+YqmiiN3pGZwEQB2P1Apd1JKJZthAzjqVu/x37RQnQTg6jEJKTQt59TuDb
 1o47E+I2iyugKRAi7wSJ7lOvXYNhSriZHcExKTEdHptApGjrG9ab8ms5qrYJJne+8WJ3
 +YgoX/wHW5RIlnR72wvFAlBNfPnDE47eQojVaSvxumMg4QXS5qcVGdtK537wown+I1M4
 USm229B+CBpeod4mS2AJa8EM9Xr/YoUrNXXHtP7DJGiUF3dnFMLiHv3cMPHdoafEuhsS
 tXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747908919; x=1748513719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nE79lOCjGyV1qdnP886Di7odOMDmNNG0tEBkSKelc/s=;
 b=fYfVLJeyjjb4soDGKTPapP/lFGowbvl7+Z5WfIO2XCRR7DvTKkprS0krUF35UURv8Y
 I4e6Rh8rmkP8oBsJif8ZnbIpuSiEU9mxYy3r34pyrfFdZT0yyixwfcRy9d1hHCvPNGOE
 of9aeG57yPOWEWHroOCTmsSsjqO8CP76VWuhZlE4bVOP/F3t5s+xnudIFxlz1crwn1FN
 yRLUnkqpFwsUob4zxyFeG+6HLSJ6IG9vwVSAHlSGAB3E5bTUcQEIRRXIHBUocZv8TdpQ
 kKxbdJ9TqudJCfiX1MdTTOi9wZWo6HejYlOhMi2qLaNE7Xqk1IPv/xhEtRANn4Af/xvZ
 iX4w==
X-Gm-Message-State: AOJu0YzHqaL4ZaPA6Uo6JBxDVtWmC9NdpvbeByMkgvftR+2MnnLXK5jH
 CS4zQ/+ywoeAB2Qkrg8nHgQ+A07SV+vDEC7r48R/0tG30iLEYFRQ5k1AWVo2HYfqiJ8=
X-Gm-Gg: ASbGnctKAxi+7xcZxOVUSm8AQQhRR856fX5tNW0clfYCO89XsLOwOC9CBJhm21oePv8
 Uv5b5aBYoQCJMeIdWaBnCGZiTT88v+XQsYvAnby8ASdGT5pwExZ4/cO0+qrUpqMrJKEFItZFFsT
 VdC+QBiVmeKIGGFJnXuLTOjmtdhIocr4d7p0tINBUaqegUlj43I/3CJoV98QKpXIZYOTRnE1SzF
 /dQCmuFI9rG1FCkl3V4TVg/+iZTGcoN/sC0FkPWcQkDI+T3ofUFbqQMJrynzaUk24bCtJ78DCyh
 jWgbc8/KgYMBPYhS62B+xyGjm2P3IPnliVpIapdkEb0Kn6dKlUdQQgONQMNJjg==
X-Google-Smtp-Source: AGHT+IF4s9YI5DvyQgh6tB3Yvz2Hcyrl7FSFcLoAYNFBWcUFkAmi4CYHEsufvajmACRCJVDiKFmIdQ==
X-Received: by 2002:a17:902:f707:b0:232:11dc:d95f with SMTP id
 d9443c01a7336-23211dce734mr249639045ad.4.1747908918689; 
 Thu, 22 May 2025 03:15:18 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ed57adsm105901965ad.240.2025.05.22.03.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 03:15:18 -0700 (PDT)
Message-ID: <f01e6f6a-23c7-4f85-a981-62313d5f73ac@daynix.com>
Date: Thu, 22 May 2025 19:15:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] gdbstub: Implement qGDBServerVersion packet
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-20-alex.bennee@linaro.org>
 <0e6cb7af-37eb-4e8d-b342-ecfcdb639f10@daynix.com>
 <87zff56juo.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87zff56juo.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/22 19:05, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/05/22 1:42, Alex Bennée wrote:
>>> From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
>>> This commit adds support for the `qGDBServerVersion` packet to the
>>> qemu
>>> gdbstub  which could be used by clients to detect the QEMU version
>>> (and, e.g., use a workaround for known bugs).
>>> This packet is not documented/standarized by GDB but it was
>>> implemented
>>> by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].
>>> This has been implemented by Patryk, who I included in
>>> Co-authored-by
>>> and who asked me to send the patch.
>>> [0]
>>> https://lldb.llvm.org/resources/lldbgdbremote.html#qgdbserverversion
>>> [1] https://github.com/pwndbg/pwndbg/issues/2648
>>> Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
>>> Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
>>> Message-Id: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
>>> [AJB: fix include, checkpatch linewrap]
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>    gdbstub/gdbstub.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>>> index 6023c80d25..def0b7e877 100644
>>> --- a/gdbstub/gdbstub.c
>>> +++ b/gdbstub/gdbstub.c
>>> @@ -28,6 +28,7 @@
>>>    #include "qemu/cutils.h"
>>>    #include "qemu/module.h"
>>>    #include "qemu/error-report.h"
>>> +#include "qemu/target-info.h"
>>>    #include "trace.h"
>>>    #include "exec/gdbstub.h"
>>>    #include "gdbstub/commands.h"
>>> @@ -1597,6 +1598,18 @@ static void handle_query_threads(GArray *params, void *user_ctx)
>>>        gdbserver_state.query_cpu = gdb_next_attached_cpu(gdbserver_state.query_cpu);
>>>    }
>>>    +static void handle_query_gdb_server_version(GArray *params, void
>>> *user_ctx)
>>> +{
>>> +#if defined(CONFIG_USER_ONLY)
>>> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:%s;",
>>> +                    target_name(), QEMU_VERSION);
>>> +#else
>>> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-system-%s;version:%s;",
>>> +                    target_name(), QEMU_VERSION);
>>> +#endif
>>
>> I sugguest passing "qemu" as the name property.
>>
>> I guess LLDB developers chose to explicitly have the key-value pair
>> syntax so that users can have one unified logic for parsing and avoid
>> the mess of HTTP's User-Agent; there is a proposal for Web that
>> introduces key-value pairs in a similar manner:
>> https://developer.chrome.com/docs/privacy-security/user-agent-client-hints
>>
>> If we embed more information like to the name property, users will
>> need to have an additional logic to know if it's QEMU or to know other
>> information. Instead, we can emit:
>> name:qemu;version:10.0.50;
>>
>> and we can use something like follows if we want to tell more:
>> name:qemu;version:10.0.50;qemu-mode:system;qemu-target:hexagon;
> 
> I think we are getting into bike shedding territory here. GDB does need
> a decent way to communicate about supported targets and when it comes up
> with one we shall implement it. But I don't think we need to give too
> much thought to this custom response for now.
> 

My suggestion is to pass just "qemu" as the name. The example with 
"qemu-mode" and "qemu-target" is a demonstration of how additional 
information should be provided, and I don't think we need to provide the 
mode and target information now. We can think of details when adding 
such information.

Regards,
Akihiko Odaki

