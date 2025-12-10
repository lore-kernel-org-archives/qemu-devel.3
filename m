Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7106BD3B9A9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 10:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTHlx-0007PT-Tg; Wed, 10 Dec 2025 05:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTHlw-0007PC-4O
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 05:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTHlt-0000nB-VG
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 05:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765363811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cm5e9L8jfs0+zznrXUClQm8sh0FjWpkzMH4cJLDJqRI=;
 b=VzXL5UhDrIVaSRRIpW42OkSboVFUoOTH/+KKS1ghsEzmmaOmgOxlBQPE6eCPTLyehwGRU5
 0b8MweqRTInFS65+Q8nXxdZYpysu5tz5vsTYe2G001GD0/vwIphNolNx1MTQDDWpKnePj9
 xehlBYBv1regCbdqJtiEt4AJGOYaLSk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-2-qSqkWtOB-SFfM046I4hQ-1; Wed, 10 Dec 2025 05:50:10 -0500
X-MC-Unique: 2-qSqkWtOB-SFfM046I4hQ-1
X-Mimecast-MFC-AGG-ID: 2-qSqkWtOB-SFfM046I4hQ_1765363809
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779b432aecso41333735e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 02:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765363809; x=1765968609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cm5e9L8jfs0+zznrXUClQm8sh0FjWpkzMH4cJLDJqRI=;
 b=fw6f+e9sEEeyPMjupVkz3RxnxjqtKVYg9+dUhO6BThi00jamnA94oWQcOEPi3/y5mW
 qMoC7a7nyPHN4Jv/uDMuXU1jNF1CrLxHpInDjWon5Xw8xDz1Oxtlvu1bVPODN8YAkOV3
 4Abx3UIS9MMIHP3vnhTRbPnPZqjURv0JCKFs/DOudcCuARWwjX6yZYwfa71S4CSkAiOS
 PbXQupZD93zbGbivTomt5W+coUXHnTVyILkz/CPyEEEX1el37Jt1irJzTB0erUB1weRj
 yqrydPcT0C+5mNoIRfMXqu1C4WwHcVPlHuKOHJhI5V8XHG8AZNQh67DrQFEa/bfBkVnG
 9twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765363809; x=1765968609;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cm5e9L8jfs0+zznrXUClQm8sh0FjWpkzMH4cJLDJqRI=;
 b=jG5tWz1ZGtVbiihyx9N1K2iKeO7vS6yncP38ONNpdFNHSGabcW3vybMiGP9y8ctQo+
 T71BHFYX7IRjbpAu7euw+h84YE1qiEYHSkPPfk9kuPDEbpVul2hP4viepNlYuTELFsd0
 vWrxD2c2/Dl9sJ28UCrOKqT0f16f8VSdSgNA1NBmrn9zEuS0Q9NMFiMT+gX6GWFXufpu
 iQltP7NCGtBccK5BaiQeN9wktiqS+opcufTxJJH1WcRvMudIekjdK6ttROW4vHrQ1mlZ
 7k+4GbubN/ZSyYaDlwsU2uuQ5HVeyZFVP4U5jPjDuna2hxteJeXnw6HMW2iGxY/6oHBz
 8uXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ30zlTQA2R72p1uDoTJ8jjA3n7yzykn5GnYy16Vwet4drzvcHwTS7qo1/VcUv+tIQ6HDf7i/REbBR@nongnu.org
X-Gm-Message-State: AOJu0YzxV6RlOkK2HecfKCkVrXXTl0VRkdxgqX0RJl3a50mjd/1Cd2BW
 aopU2c1k5M5c/4lyMVWBhWxqQf5dUjQyy+8GOb9kq7qDIWgX5jopyNK6fwUXl8aULmcbvMgdUl5
 vY7A0oLjfuuMgoJX07+uXPSgPGVTjUspIIqu/8o2lldDZijvvQtTme1XI
X-Gm-Gg: ASbGncvv7X+Y+vbi7NYvQ+PWXeSYEbXN42yBLcHZ9WC1TYcpQ8EXv3IV0Xr7syE4ABP
 LOvfzOwufmhHEahQjYRmCVaPmMXh2CtCCWLcnie11jf38yMX2RAdsHqjvDzWnT4urzdZirmW8Go
 nrIkxID03xcZC4svryvNmnaGH1oDBmysAztej6/YWfRTRA3Eg4VCbLh4Kl0fVeBiMlCj7UOdb1u
 ozNXyNfg+Ilje/VXG3gSXDfK3LFYe6sVo9zrjBKF7pK/Ivkh0XMIxln/NIPdYIhMj5U7R5XXCr6
 UO2HnufYwTEZiz9WIU7MySiUWhE9NbM3aRrwhyFo+1UiutqjQizf3e3lNBE42ZDJYYR2JtZJA/b
 oe+knvtMnsVgQKQ1qngVYxDcyHppAIgCCps5friKXwGVx9+0q
X-Received: by 2002:a05:600c:b8a:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-47a83847b05mr19716535e9.30.1765363808726; 
 Wed, 10 Dec 2025 02:50:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ50h6jSlpMQayX0MKulpBP8USZPpzggP3LoFid9fMF7tIZcdd9s+pgg95u0qCcYtNiBaAmw==
X-Received: by 2002:a05:600c:b8a:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-47a83847b05mr19716225e9.30.1765363808232; 
 Wed, 10 Dec 2025 02:50:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d4a995sm38343175e9.13.2025.12.10.02.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 02:50:07 -0800 (PST)
Message-ID: <d57fe2bb-7e54-4c6c-beab-303eae81001c@redhat.com>
Date: Wed, 10 Dec 2025 11:50:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fix const qualifier build errors with recent glibc
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable <qemu-stable@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
References: <20251209174328.698774-1-clg@redhat.com>
 <31843643-a22d-4634-9eb7-868376e57635@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <31843643-a22d-4634-9eb7-868376e57635@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/10/25 11:35, Michael Tokarev wrote:
> On 12/9/25 20:43, Cédric Le Goater wrote:
>> A recent change in glibc 2.42.9000 [1] changes the return type of
>> strstr() and other string functions to be 'const char *' when the
>> input is a 'const char *'.
>>
>> This breaks the build in various files with errors such as :
>>
>>    error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>>      208 |         char *pidstr = strstr(filename, "%");
>>          |                        ^~~~~~
>>
>> Fix this by changing the type of the variables that store the result
>> of these functions to 'const char *'.
>>
>> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> I'm picking this up for qemu-stable (10.0 & 10.1 series)
> (together with 83f6dceb8f5c "qga: Fix ubsan warning").
> Please let me know if I shouldn't.

This is a partial fix for the recent glibc update. We need at least
two other patches. One rewriting vubr_parse_host_port() as Peter
proposed and another for :

../hw/i386/x86-common.c:827:11: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   827 |     vmode = strstr(kernel_cmdline, "vga=");

which is missing in v3.

Anyhow, there is no harm in taking this first part. Future backports
should be simple enough.

Thanks,

C.


