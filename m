Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B79E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6Xx-0002uQ-OK; Fri, 13 Dec 2024 09:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6Xw-0002tz-96
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:21:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6Xt-00029T-FN
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:21:36 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43618283d48so13135035e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734099692; x=1734704492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rd2Q1V+KzbYu0703L0vevvYSqhm+/QO3ZBD28YeGU7M=;
 b=uaj7uU4bqB3q1sWTsxkQRCxekWrAOu4EXUy1dLFUawJ3yDJq9dr2g7ZvRLHvjU+Vv3
 zKub58cYUsxoWg7mF76ybXYJN1F1K2fge9huZHAgPUBz1DaIOXZfe5IhdgzxtxeKWJYA
 AaGnKsRUR2l5g0x5hzTddgdvRFdm3vItFCLN6bCYRFsUSfjGdcMPpboa8kd+RLV+Ocr4
 dUAC5fs1PdlItk5v287Fk1K4zOtYXPqdOwJP3OaftFP0plKkC0L8JnZ8CC8VB4+LApRs
 c17KHIG4UpSn4+ybB5g2s9WCZ57umdjmx9zFRvHRwWps+TOdwqauveCCgGXE5I2kxDOu
 lQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734099692; x=1734704492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rd2Q1V+KzbYu0703L0vevvYSqhm+/QO3ZBD28YeGU7M=;
 b=wMFolzETfNYg0LTknGITHH/712iRI1IOyPqfAQQ2EBiQCoTzLSwGDfaDL55d1IohLN
 mfoOpxnlGRjKcxkf7u+fAo3NzsOOuo0vEfHNw9XwoUpHIHKXIFHVsUoLG6NqAQRKDRMg
 bjL5BMb5x1YioGOwBy5epaqKHwAT3KPtB4itAwctTumspNwrBdnyKkmLe7Y/al0ZCrHx
 kJAgVaqzkuGPhNIIajLT340EV439SUPGcLwOzbkeIeBFx9F6L9mbNK6f9/dLJfLcBxqf
 v8p65n8jCsVvUubhVD0T/pBdho7oAwo+38je2QqkvjpqBo9GmKOYWDySiswkj8NBxjQv
 JQxg==
X-Gm-Message-State: AOJu0YxbR/GcOw0LV2tPiSEQ4NDE+mJyYvI4wZrcajZWx7veD+yTCcyo
 ShOl18mnTpAWWjTarDjt638cc/nHyUdGJSJMYe32GFRxbsXtEQyfERF890iXjqU=
X-Gm-Gg: ASbGncvPPfXFDHavXhkxMkr7yrEIh7RwFSSp4zbBwq9UI2zYnyk8UCD0jRHrBTBatCD
 63ICg4H8MkUVHv3AvXd+1DjjREP6gt5YSfuZ6uV0/f1aGwEHA7mOKBqGSKJz/aPxTUdiXbrhP/6
 nPQw9Fd/yADBAsIYxwi+SqJcozzceZlK0yA+StG6+MHiySujnzFPdrXD4vbpjOrzFsi0+l2J6Yk
 mC6TEoa4SVlYgWY09Mm3AU4Pd/bhZVatOu5z5XtFON6xSYT4vZO7hvZ8cEiYBcytHvxuPtT7a5f
 2O1N8+ePRZHpdxELgKg+S7u6MHcYsA==
X-Google-Smtp-Source: AGHT+IFQiV7XsTafkPmz8qbhoML1d1lJPwD/Ptgc9HNVWU6n1YPpkxJgFILjhNy6+USaVJTXKLqTLA==
X-Received: by 2002:a05:600c:450e:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-4362aa38680mr24750545e9.13.1734099691771; 
 Fri, 13 Dec 2024 06:21:31 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625716e5csm49855985e9.36.2024.12.13.06.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 06:21:30 -0800 (PST)
Message-ID: <ad581f8d-7370-4485-81d7-2d0d7b41811c@linaro.org>
Date: Fri, 13 Dec 2024 15:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] hw/nvram/fw_cfg: Skip FW_CFG_DATA_GENERATOR when
 no data to generate
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20241213133352.10915-1-philmd@linaro.org>
 <20241213133352.10915-4-philmd@linaro.org> <Z1w7EhdPij2fqM2F@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z1w7EhdPij2fqM2F@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/12/24 14:48, Daniel P. Berrangé wrote:
> On Fri, Dec 13, 2024 at 02:33:48PM +0100, Philippe Mathieu-Daudé wrote:
>> Allow the FW_CFG_DATA_GENERATOR interface get_data() handler to
>> return NULL when there is nothing to generate. In that case
>> fw_cfg_add_file_from_generator() will not add any item and
>> return %true.
>>
>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/nvram/fw_cfg.h | 13 ++++++++-----
>>   hw/nvram/fw_cfg.c         | 10 ++++++----
>>   2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index fcb06f18cc3..5211018fd8f 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -30,8 +30,9 @@ struct FWCfgDataGeneratorClass {
>>        * @obj: the object implementing this interface
>>        * @errp: pointer to a NULL-initialized error object
>>        *
>> -     * Returns: reference to a byte array containing the data on success,
>> -     *          or NULL on error.
>> +     * Returns: NULL on failure (errp set if not NULL).
>> +     *          A byte array containing the data (if any,
>> +     *          otherwise NULL) on success.
> 
> Bit confusing wording, lets say
> 
>    Returns: A byte array containing data to add, or NULL without
>             @errp set if no data is required, or NULL with @errp
> 	   set on failure.

Thank you!

> 
> With that change:
> 
>    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> With regards,
> Daniel


