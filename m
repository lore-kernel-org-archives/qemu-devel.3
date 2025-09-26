Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D228CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24X7-0006i4-F3; Fri, 26 Sep 2025 05:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v24X4-0006gD-Mz
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v24Wu-0004j9-DS
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758878053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d66a8EHFYXGJOOAeoUwT0gni7Is0pod/W57UOPyGSRM=;
 b=Z//XA1n41aJ3/ElAuZke7zydjVq1zxrcT3gaJ/7RVT2RjJwqDFvSXp87hWIQyLfMiMpAdD
 1ZhRBNsYLPZaOXCcEywz8VeX4I0iRawDK9HgNxFI/Ul5Jscf9l7qNS3yqtgismUcXFPrUG
 x0rDbGQwoOwjkeDv+tKvDCLwqJcOC/k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-cs_MET9FPRqBcZ1Y3SOuQA-1; Fri, 26 Sep 2025 05:14:09 -0400
X-MC-Unique: cs_MET9FPRqBcZ1Y3SOuQA-1
X-Mimecast-MFC-AGG-ID: cs_MET9FPRqBcZ1Y3SOuQA_1758878049
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e2d845ebeso10270975e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 02:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758878048; x=1759482848;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d66a8EHFYXGJOOAeoUwT0gni7Is0pod/W57UOPyGSRM=;
 b=p5rJrQvxzH91BSJJ7CgDmKVD4q+7VoS3CkPHuKfzgbFN2G/s8P/19NzAfO8qBwYEdp
 Ye6UOF9D4r6gx/lYOnHJYA56CrMwHuZENZyZ1q2GJZUuWSpbqFwW152LQamDxdTOv3b3
 7Mv0V7pJ4bAQxsbM23M+9g7Ok83pyGPzaUYD2UjJHUf+PY+RYNRVgUwcZFnzuSNogX9a
 rQwS/xtQGCWN+k85BgIONQVpU/NKunsaRxSoZdC0fSEnogptSfYuIxtOqiSaqy90mBew
 tM4vnzhpLlf9290F6/RquMkmJbaEQ5ASNjuFi3x/74pumILzjtwRXgUjBgNr5lTP1b3A
 +2bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+YYFMBHWF5uA6TWvKMHCAMeAPeWoHfveCAjMf0LQymJkQrol/tQ0eXQSEBwHvRC/+I1J+Ju+6AxU/@nongnu.org
X-Gm-Message-State: AOJu0YxomLkg3ZdCtEBgeN7a1t9uN9uvMNF4pMKn7q5iKuwGwEEvO1W6
 y/7FmXl18E1i7c9hdXju+YRxc8lvliy01V15o+lz0xBCNPi8oyVcXKeXQNTyNzBMH+lJ3zo8lRv
 D+TFoz1rtaEHsaXDeXQxb+1vIXYVFJNlBtV5z0YecLxaC+/lV5skOWeAM
X-Gm-Gg: ASbGnctFUvgpeAaLL1NH66AJ2wiEO6LezyMaRFTSYUA7/qVqZl126OBDvhLQ74rWZj7
 ffFZUFVzT5pKM/Ru3MiIavNXS5xwki4fFfh8S64RgSZeCGPDNaIMJjEl8weDOBkXOPwXQdSjqPr
 1Av8A5QrnfLVylN7fxvj9Uu4ZClE8axS9QTQzuWbRGKHywPwTDwwTp1YcYabc07T99+AyjWjCET
 YW0KljyLqoxXUMDs0SCotQ1YuysMUx7rhsHia76jkuGMAFxj2BVvBe/dzeAejTin/8iON1jxq82
 5o98mbJ55OHraKkoXKB0wAwNRYmHvvPuWizmcfEt+0jOabM5G3RoO2Ro4B+bEHjbZhw5TGZOIEl
 GXcpjjg==
X-Received: by 2002:a05:600c:4f4c:b0:46e:324b:fc70 with SMTP id
 5b1f17b1804b1-46e329b258emr72306735e9.9.1758878048627; 
 Fri, 26 Sep 2025 02:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGtfE37lu9gETlQzNRK/v1TLZcfdOYIProMEeOD9mAPkLaeG4gZj3//+dTjEayfPnmq9tkyw==
X-Received: by 2002:a05:600c:4f4c:b0:46e:324b:fc70 with SMTP id
 5b1f17b1804b1-46e329b258emr72306385e9.9.1758878048217; 
 Fri, 26 Sep 2025 02:14:08 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb1a3sm6278286f8f.10.2025.09.26.02.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 02:14:07 -0700 (PDT)
Message-ID: <1d096685-ada0-4c8a-b16a-ed8a5df7b90d@redhat.com>
Date: Fri, 26 Sep 2025 11:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <f94da379-eee1-4375-95e6-7349c3c188ee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <f94da379-eee1-4375-95e6-7349c3c188ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 26/09/2025 08.49, Philippe Mathieu-Daudé wrote:
> Hi Gustavo,
> 
> On 26/9/25 07:15, Gustavo Romero wrote:
>> tests/functional: Adapt reverse_debugging to run w/o Avocado
>>
>> The goal of this series is to remove Avocado as a dependency for running
>> the reverse_debugging functional test.
> 
> 
>> Daniel P. Berrangé (2):
>>    tests/functional: replace avocado process with subprocess
>>    tests/functional: drop datadrainer class in reverse debugging
>>
>> Gustavo Romero (7):
>>    tests/functional: Re-activate the check-venv target
>>    python: Install pygdbmi in meson's venv
>>    tests/functional: Provide GDB to the functional tests
>>    tests/functional: Add GDB class
>>    tests/functional: Add decorator to skip test on missing env vars
>>    tests/functional: Adapt reverse_debugging to run w/o Avocado
>>    tests/functional: Adapt arches to reverse_debugging w/o Avocado
> 
> Out of curiosity, do you plan to post the final patch removing Avocado
> use / dependency?

Which other uses of Avocado are you thinking about? AFAIK, this test here is 
the last one that used Avocado.

  Thomas


