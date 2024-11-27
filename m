Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0305AD66B9D
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 00:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG5im-0007RJ-HF; Tue, 26 Nov 2024 19:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG5ii-0007R0-Jr
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 19:15:52 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG5ig-0006WC-OC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 19:15:52 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-724fee568aaso3306018b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 16:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732666548; x=1733271348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uBLl+ao6k2E+6Rj7SgjrUVdq4+6MpdrhLD6Cd98n84Y=;
 b=AET6nHvWP51eWI8ZQWY5T6NgJBSOyag1PvFGTpLQlv2bekz5e379vNvpWo9yNDmJMZ
 ygofQarVnjYWFz0swM1z+eeMdigULbzTeBuWTZ/VuxdOD+dLfxXBbqvvmzcH7gVbQzj3
 QLG3F8iqe3z2YvUoFhw6J4Ns8b5riZkSc89KHQST+6w096J4B3+kj2k5mxD0mX+o9AAX
 b0IYtk1HYYi6ybsIqkuFJTNZl5HEsDOodGjF+HjEnwD2Nl1IyOnMQ0fvFp1mrqeNTdF8
 KJMfo+tW1ukno3YR8SfWipc/UOTnI/7OooGI93NFjULJLLdrC9MZ2v33AJJT9wQNjIMv
 GzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732666548; x=1733271348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBLl+ao6k2E+6Rj7SgjrUVdq4+6MpdrhLD6Cd98n84Y=;
 b=I441nUEarijA/7VOFiXoCnGgh9RGRPpTc1vaxrISazFIGFqzyDqBWraiYUYetl6sDp
 uC/vknPnyaBwweBGADh6VuRa4nyMCzXmWzGtnxAH6AuJpYIqIVtuzqJ0FEQZUBWhvYAv
 7hr3Ae7su44bR9PqJ4MV+ss8P8AYuHMNH1oLePKwzclhpRpSrO7qsXgGavLRDcBdye+Q
 iFSORTTg6nJqpF+cWThsiADOs/9ncQ6Un6Pa9eCcAf8bhPBVkTqYsT4MmF+LFuYiEEEZ
 7w87TzsDWg05TVf1S24QPpcDn8mu4//BfNoPLMwYasC0gEuW4MF1omxuawvwf8iHkZ32
 MBSQ==
X-Gm-Message-State: AOJu0YxIKXn6bT9uKb4xNH72vkViV6tvOFw7DtEQL1SQTQ5lE0oH8wLe
 vGGwZeig+DT2L4nj78Aap0PsXptfVJni78Yx+o1ZeQtrwh49tRt4bQGiiEXET+Y=
X-Gm-Gg: ASbGnctOVmvOaYAiE8F9a+rzZpFsZtfSuYnxnnD0AYJKpzoKgADYXqPGRCp4bnjMRen
 hwPCdgdFQlGRSp/G5Q/pQeYk/ooFx5ZQ9dcP8qGiUYNdZ2dwIPW3yDhNscXvG8lfa7tL8rttTW8
 SPOGqZl9LBOI2NIWj+El25qhbZpQjqzxKHW2m1388md/24/qt0AmzscUI3hNc9U9hqZirjni8CL
 NCc6tIVm9R4jBFuXeEUFQmCgwQ5uexNEhRYR4KaV7eXsHsbhIdAS+YusW3TRB5hf8ktTTXon1Hi
 6Dual5udSSj8p+mOqgKqRg==
X-Google-Smtp-Source: AGHT+IFkWoXx7OMpwZ2wPvazO5T9BvrRPRPxg+1szkzHtyLjffC7j/zVL7TYNG1NKUXr9iitFOQAxw==
X-Received: by 2002:a05:6a00:4f88:b0:71d:fb29:9f07 with SMTP id
 d2e1a72fcca58-725300cec87mr1315174b3a.15.1732666548414; 
 Tue, 26 Nov 2024 16:15:48 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de485c84sm9016917b3a.80.2024.11.26.16.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 16:15:47 -0800 (PST)
Message-ID: <e0c904f2-8620-4f6f-8392-75971529080e@linaro.org>
Date: Tue, 26 Nov 2024 16:15:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-3-pierrick.bouvier@linaro.org>
 <CAFEAcA9cbV4a8r=h4imdvyMV3P3B4mhgnWU-eobH4ESrsr0Uww@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9cbV4a8r=h4imdvyMV3P3B4mhgnWU-eobH4ESrsr0Uww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 11/26/24 13:28, Peter Maydell wrote:
> On Tue, 26 Nov 2024 at 21:18, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   docs/devel/style.rst | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
>> index 2f68b500798..13cb1ef626b 100644
>> --- a/docs/devel/style.rst
>> +++ b/docs/devel/style.rst
>> @@ -416,6 +416,16 @@ definitions instead of typedefs in headers and function prototypes; this
>>   avoids problems with duplicated typedefs and reduces the need to include
>>   headers from other headers.
>>
>> +Bitfields
>> +---------
>> +
>> +C bitfields can be a cause of non-portability issues, especially under windows
>> +where `MSVC has a different way to layout them than gcc
> 
> "to lay them out"
> 

Thanks for the language fix to a non-native speaker :).

>> +<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_.
> 
> We should mention also that the layout is different on big and
> little endian hosts.
> 
>> +For this reason, we disallow usage of bitfields in packed structures.
> 
> maybe add "and in any structures which are supposed to exactly
> match a specific layout in guest memory" ?
>

I'll add this.

>> +For general usage, using bitfields should be proven to add significant benefits
>> +regarding memory usage or usability.
> 
> Maybe phrase this as
> 
>   We also suggest avoiding bitfields even in structures where
>   the exact layout does not matter, unless you can show that
>   they provide a significant memory usage or usability benefit.
> 
> ?
> 

Ok!

Should we push further and try to convince people bitfields are not 
worth all the problem that come with them (except when really needed)?

Except for saving memory in *very* specific case (a structure allocated 
tens of millions times for example), I hardly see a benefit vs using 
integer types.

>> +
>>   Reserved namespaces in C and POSIX
>>   ----------------------------------
>>
>> --
>> 2.39.5
> 
> thanks
> -- PMM


