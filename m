Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3054F3C26D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbUQ-0003al-TW; Mon, 09 Mar 2026 10:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbUN-0003aX-0I
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:21:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbUL-0001vO-Az
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:21:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48534e9076fso9985665e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773066100; x=1773670900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oUsckXTZd4tTP9r6HpuHkfoacQ9KKPwkN9twd81ncxM=;
 b=FSav4OfjRgfNw8KIqtry+AMOcoGjPDK9IYX1PN9c8cTBRrI/UG0ivmXruwMehXjnMN
 Jk3OA08ZOI+dO0nAMVaZGH+djrDUFC+crdAxprl6o6bhZbna30VA5ea61mKSXYqIzg2W
 cEosNwwBMpCisx8+5SLdEU3nQz4VLj2UtAlKDenpU6QTDhgUmO2cwE9wQwaUAB+oETm7
 HjDKYjYvRSxeguA3VTT8h3u8S7U6yTil6zal1RF+vDf+g0uCdsI/vVNEeyDcjP4kI9PX
 oj4sNeZJv7M08+Vdk5aGMM67w6DAVq9bZvmi/oWYrcZKVPJo0/CNB/q2VZebmei8PHFe
 1jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773066100; x=1773670900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUsckXTZd4tTP9r6HpuHkfoacQ9KKPwkN9twd81ncxM=;
 b=d4EaW4FT/pzdzN8rdoKgUP+GZBhfxrTKmfsLpP3kHn0sOtRe33HtRgAQdUxeAWMtBT
 HAP/TX5gqapTQIr4frPT1WeYZBjzlVajuRK/uYGtBWQnQV4JWyBZlJrVanhdn2gHcxGe
 JqJDDBIvhYQf5T8N4FroJlw7RRK8e4nLQoHYtxKQIM4OXuUcw8fqXHXIIQEK8YMD3kPA
 1/tIN4X1GmaRWbEGfySnOJmjKPqBqmScKYxoJtpBjMJA/3xiTIzmradUPEt6zJ2e0vVN
 PbT6mZbgUEU46oz0cfIKg6xG34TeDIwkab3WrBJ5qGNGwNy5Ia1MYbzZ3Z+2g0xwQz+8
 8MqA==
X-Gm-Message-State: AOJu0Yyh3K2Gvm9R3AMIz5BCZNmupTuZ0Xn6YvZnkcUESaY0dZuUNMv5
 5cGs/lYETIziyEl8AhV6Csq7ogaHDnrLAk5bcAnUPohxCj2xylpcZnyreZr73rViTVw=
X-Gm-Gg: ATEYQzxeyq9y/O9pkVWcmjrQB7PDmfHEEz4Gw+CT359Jp11/3+mm9q7T68CLEZYCJYV
 Dmb9YX9dncep5SCttjEVUzTnUCE8ucqICzR1GqoAVZbzDfevCOtnO/vvgLzXeNJUhhRmTQazL4P
 mTlvCv6UfJBlSL6lpht22/7rNxMXq8pM0BHwbWX0zYDb1o7j3OhuI5i7yxf6nnEVkfx016HTG0y
 1sR4ycb56k6D3Ok8naf546yPv5EfWMKuZFPnhEclFwHpqnFKz21UWx7ETU99SCIoINy88/rEKmz
 0RN5nvNJFQWGRtJEkK/+LdDzcR46XbRkkEnJURz6xGseP9GCZKpG5mqCzxtR+fSl7mZk+tEvIVY
 hcUrHnB10tZymbhf3t+ODTKfSYmeO+NDlLHxOMW4xzkYz2gAhiYESSMpS7jyU59Ocq43bbqKVng
 Tmtx1LNffF8GqN7SRUJZ+gJ2tBUsgnQ9iINBYxiaoRYfcQZCvlYIvu9TMLyp/PMUVnzus/r4s15
 IFqzstFIA==
X-Received: by 2002:a05:600c:8708:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-4853c8fe526mr35849315e9.17.1773066099570; 
 Mon, 09 Mar 2026 07:21:39 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853c784813sm61463275e9.5.2026.03.09.07.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 07:21:38 -0700 (PDT)
Message-ID: <d884b7c9-5bc6-4b5f-a45b-43716fdb2268@linaro.org>
Date: Mon, 9 Mar 2026 15:21:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ui: fix small leaks in -display dbus
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
 <CAFEAcA8PwXsmYGsPDyctxm7Ud78VYB_3nFazxvTXpu=HsGTnzw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8PwXsmYGsPDyctxm7Ud78VYB_3nFazxvTXpu=HsGTnzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 8/3/26 14:25, Peter Maydell wrote:
> On Thu, 22 Jan 2026 at 11:33, <marcandre.lureau@redhat.com> wrote:
>>
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>>
>>
>> Marc-André Lureau (4):
>>    tests: fix leaks in dbus-display-test
>>    ui/dbus: fix leak regression
>>    ui/dbus: fix Unix.Map proxy leak
>>    ui/dbus: fix pixman cleanup
>>
>>   tests/qtest/dbus-display-test.c |  9 +++++++++
>>   ui/dbus-listener.c              | 11 +++++------
>>   2 files changed, 14 insertions(+), 6 deletions(-)
> 
> I don't know the code well enough to review more than the
> two really obvious ones, but this series fixes all the leaks I
> see in the dbus-display-test test.

Is this statement equivalent to:

Tested-by: Peter Maydell <peter.maydell@linaro.org>

?

