Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74F5C83F09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 07:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZlSp-000635-P6; Thu, 10 Jul 2025 03:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZlSm-0005yW-Rd
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 03:13:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZlSf-0004sd-Fx
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 03:13:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-454cc6e987dso2469365e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752131571; x=1752736371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x0eWnfV6sYPOLfxt96yn/V9Wg7Zrw6XYA8BJHWIR4Is=;
 b=suUmkQMdZ7IrhMI9xSX4q3Hlr3pnd8TL6LQAj/Yw42epd8aFHJ4ZFavBZr2nUu93RR
 JWmiDp/HxWG1w9Q0mDDpSgFVyC65HMHBwoaDIe0ujpjMd7aVQ1DNgHLZFNS8AhlcZN4K
 quoK9l3Pg8HFt88H8rAep+JqKf6QNoGS9AfbkYVDWI1Xqpq60eg3AqmrCzvxQYLx/7SO
 pUmpzL4gIgkFdXgoOEvoiIwm+PRoTBVm0lWmRa07ODOwkIWx/Zwxwgb25eyRfJQ0JMTg
 wHfNuj/viHJ/T6cJIKmjWZlAXnPT+VhkMHkZW/cJ5mmZBv7E6u89IFYsxkEFB6FJIzob
 cjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752131571; x=1752736371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0eWnfV6sYPOLfxt96yn/V9Wg7Zrw6XYA8BJHWIR4Is=;
 b=nkxzSSv1EqBuzNLcRP0bxxRMddL3k1R3tVZWiqqaBeXDk7bYna6bGM7DCH2A+YImSs
 vr7uIg6KOmq4XDM45QCG64dFYeNwALF4qwtL5yneKBd1OORmNUMVY9b2NA+k/J9tAkUo
 NmBumkkxpi8BCB/FnG08T0qeSATC8xxjZXxvA4vJKya3YDImL6Kj2I4kG08MXQ+ot2wQ
 xrTl+47edLryAezu/pFa8yHDy4mrt4+WUIeTgzj6S0EVWfDojDNXniXQEfakSIggx/Fp
 Syfb2lioS9gdBkAz+66p0UtAkEjS9TLa3hpqpbt0RTjWACMDyy82YCSJScK0nosl48Sv
 vH/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaN1JHMZFbVrpt5o9CJNZ4ELRfOVX5vH3+j9pM7axg7Kp/UAKngnSgFp4BsvkSxAD6d38C1FSrCgSX@nongnu.org
X-Gm-Message-State: AOJu0YwsCxqt7SLlaKyINb7EIwEmuab3nUznAblpUmr4Yru55Ou1GUsR
 biDmhcZRKErJKoXYHnhAMXFf+vWEHC3K99sif1AXyPy6MjOOx74E45PxEWf9Q7ivSq8=
X-Gm-Gg: ASbGncv1rnk4CRgAoM3iAzEqcy5OdKX9vNmdp1xW2Eu7GfbRUyQo4oxy2MULkrOmJdr
 PztKaJCtwIrSkvAjgza3zYN9YbkujoW+ObArwbURfyX41UNrOs+FVWNx0iLyO8xHEzLW6BZ+2mF
 TwDmm6QQ5xaOzBqL9CoZ24QCBNHs4pEQM8TSzx1sDqiPn/L9fQPQSQWPE6OsY58lRaVHC8CAm+h
 yZhzlBGR7lOKaTNPb5Si4Gnuz+4VfIPQ5oPqvoTDIAAu6jl5zWCljroMNWGFxzLWibHlaCEqga5
 I/ERqm83Uxk+nn5wWLa/O/6CBboMzO63C6rouzoeIVA6d7W6NB3NWiE/5xSaajtYeUICBX+Q7qK
 kUm7xmlljXMx/o2n1L9PSEdZMyfWzEWngrN6EtnPe9kyE5Ck=
X-Google-Smtp-Source: AGHT+IH2a4TxLRURylwgFFY88kS4CQ9rmmsGK2hQLpxVNrxd9AkQPT9ov9l32JT7ae+zYMloJlzSkQ==
X-Received: by 2002:a05:600c:1e8a:b0:453:45f1:9c96 with SMTP id
 5b1f17b1804b1-454db8bf413mr23040765e9.14.1752131570736; 
 Thu, 10 Jul 2025 00:12:50 -0700 (PDT)
Received: from [10.132.103.213] (150.red-88-28-29.dynamicip.rima-tde.net.
 [88.28.29.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43915dsm10404335e9.7.2025.07.10.00.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 00:12:50 -0700 (PDT)
Message-ID: <7bdeaf63-23ef-4fa4-97a0-26c609a68dee@linaro.org>
Date: Thu, 10 Jul 2025 09:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] tests/qtest/qom-test: unit test for qom-list-getv
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-4-git-send-email-steven.sistare@oracle.com>
 <bdb92ceb-59d3-4e82-83f7-d4bde9b96583@linaro.org>
 <337e2790-195c-4852-8904-d421601f9011@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <337e2790-195c-4852-8904-d421601f9011@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 9/7/25 17:17, Steven Sistare wrote:
> On 7/8/2025 6:02 PM, Philippe Mathieu-Daudé wrote:
>> Hi Steve,
>>
>> On 8/7/25 19:24, Steve Sistare wrote:
>>> Add a unit test for qom-list-getv.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   tests/qtest/qom-test.c | 64 +++++++++++++++++++++++++++++++++++++++ 
>>> +++++++++++
>>>   1 file changed, 64 insertions(+)
>>>
>>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>>> index 27d70bc..4defff1 100644
>>> --- a/tests/qtest/qom-test.c
>>> +++ b/tests/qtest/qom-test.c
>>> @@ -11,11 +11,72 @@
>>>   #include "qobject/qdict.h"
>>>   #include "qobject/qlist.h"
>>> +#include "qobject/qstring.h"
>>>   #include "qemu/cutils.h"
>>>   #include "libqtest.h"
>>>   static int verbosity_level;
>>> +static void test_getv(QTestState *qts, QList *paths)
>>> +{
>>> +    QListEntry *entry, *prop_entry, *path_entry;
>>> +    g_autoptr(QDict) response = NULL;
>>> +    QDict *args = qdict_new();
>>> +    QDict *prop;
>>> +    QList *return_list;
>>> +
>>> +    if (verbosity_level >= 2) {
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> But I note this doesn't assert anything except if you use V=3 and
>> look at the output.
> 
> I don't follow.  It unconditionally traverses the whole tree and asserts
> that properties are present.  Plus, for V >= 2, it prints paths.
> It is patterned after test_properties() in the same file.

Indeed, sorry. Good enough for me then, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


