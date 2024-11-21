Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24E8D6ED26
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 13:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE6pP-0006Yh-QD; Thu, 21 Nov 2024 08:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE6ok-0006UN-A8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:01:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE6oi-0001WD-A1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:01:53 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso7438455e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732194110; x=1732798910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/EWWzNd/N7/Y8cs6cE5VU774LtYV+lQRVp3uTqgURig=;
 b=uscZsNmZZNXbgBWpvreJXasKRVuj2UUsG6eX5GoJC8+wJqs8WwqX7dciKTUyxz0OnP
 TOUcbp/66b26RXBfOKftHDnsjbJoKywLx8K7LQj55ZHXQjbH0syoAuIL8pdAFnzw6ERE
 yxcrBlw+PMQYDUTVJk/lfLj6WtTqGGVmtFBi+9PEInJfGva03fs0ZcRxMV9YrF8wJpYR
 tC80qFpT3W2W02oYfIFEAk0wAphuu0+rjq2XfOewD7f1HX5aj6bfMDTpwBLI+n/QrVaZ
 70JwNyjcASwbjmhw2DzV/LYBjh6KDANqyh8Voel+9/tVMj/9PpxzkfBYCoxJ9ir/RzEU
 Z6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732194110; x=1732798910;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/EWWzNd/N7/Y8cs6cE5VU774LtYV+lQRVp3uTqgURig=;
 b=rGMRx9BmEBKpn8XiIVPGoeCa+FaJ7rXeJSp35hzcYwo38RKbPBw2csI5pkb5vhgBBp
 SlJ6zJA+VV2qdfRnB8wsXjPIkkHlI72/OSJr4S7s4DeAzZh162Ev8YbPooq3H0i9LoOa
 DB3nLqNfB84saNv2opgtDi1YybbTH9EFq4u6JZb1eqBMQXjrQBe8v/XG0XoQxa6vjAYK
 MUy4WswJRdXD4fSP7d751N/yakLYqer+scgmVnAHH5BENqGopU7Cgr+HFB44zE/0v7dI
 gaZSLSzP1qBDl3M1RVWeRUlirF45TBX/z7AIhA95pUrKHcLBGML+YF57ROimRS7jfzjG
 iJbQ==
X-Gm-Message-State: AOJu0YxF8DcgZUr2TcEQMtXvs99lAf9ubtnIPlsPecuW2gtkWs2rruo5
 DU7A8DnIe0WlORtH+o8fMrwhe6eSdTJC4M9GYGPH2XqrtYPvg/VVEa+CRQwjjvyGBT109aJSldr
 +
X-Gm-Gg: ASbGncvVQ0yIvC1uubjFKfJKk9d4ZIujzCeJ6qrrtwtW1UeO7bF5PQZwo1u8lICT6+8
 sxY5YNaY00kZaJL/pbrKH7KZmntKQ5SF0E7x2PQ5xMuuqA7NxcfSrNI6lVd5Qc9kje65feWAOKp
 WjsdPVHAPhsb/HwoafXB2A7FrgfaNBgoiaYC2AuPNes+LxHhCtPHE3taZJY4KoH3pA9Uy6CFyUA
 BAlodDDCR84WVlDNKLgDjR0aiICoFly39ifoGYvd2zcwJOy/D02JdBjJ60kzAIjeRGZtg==
X-Google-Smtp-Source: AGHT+IGQqizhgi8SEhhrqmOAoGFCqV6I0bT1NSQgIhzM89BrzY8efRxhjEWyeY6/U7odvWw+av65pw==
X-Received: by 2002:a05:600c:5491:b0:430:5846:7582 with SMTP id
 5b1f17b1804b1-433489814bamr56459925e9.7.1732194108098; 
 Thu, 21 Nov 2024 05:01:48 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bd7d7sm57387375e9.13.2024.11.21.05.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 05:01:47 -0800 (PST)
Message-ID: <64d02784-adde-459a-a019-10cdca93734f@linaro.org>
Date: Thu, 21 Nov 2024 14:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com> <Zz8LwhXsa6ail5qo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zz8LwhXsa6ail5qo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 21/11/24 11:30, Daniel P. Berrangé wrote:
> On Wed, Nov 20, 2024 at 04:57:01PM -0500, Peter Xu wrote:
>> Always explicitly create QEMU system containers upfront.
>>
>> Root containers will be created when trying to fetch the root object the
>> 1st time.  Machine sub-containers will be created only until machine is
>> being initialized.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>   hw/core/machine.c | 19 ++++++++++++++++---
>>   qom/object.c      | 16 +++++++++++++++-
>>   2 files changed, 31 insertions(+), 4 deletions(-)
> 
> 
>> diff --git a/qom/object.c b/qom/object.c
>> index 214d6eb4c1..810e6f2bd9 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -1734,12 +1734,26 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
>>       return prop->type;
>>   }
>>   
>> +static Object *object_root_initialize(void)
>> +{
>> +    Object *root = object_new(TYPE_CONTAINER);
>> +
>> +    /*
>> +     * Create all QEMU system containers.  "machine" and its sub-containers
>> +     * are only created when machine initializes (qemu_create_machine()).
>> +     */
>> +    container_create(root, "chardevs");
>> +    container_create(root, "objects");
> 
> This is where I would expect 'backend' to have been created
> rather than ui/console.c, though you could potentially make
> a case to create it from the machine function, snice console
> stuff can't be used outside of the machine context, while
> chardevs/objects can be used in qemu-img/qemu-nbd, etc

What about creating "backend" container in qemu_create_machine()?


