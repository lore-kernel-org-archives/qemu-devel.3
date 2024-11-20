Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A619D44171
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 09:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDgu4-0005Sn-Ee; Wed, 20 Nov 2024 04:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDgu1-0005Ol-Jk
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:21:38 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDgtz-0006zq-Tz
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 04:21:37 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so2310437a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 01:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732094494; x=1732699294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oum+sd/6X3GD5axRrx9WNHXoGD6W///ubAsVBe+Sg3o=;
 b=CSRsMqLj8jRbfkgoC4XYzTmK1e3x0kqhu7hZrbIL8/bOCB4FlEg948nWndwkfBW+m1
 ozY9q64Wsc5BL5d4VX4Cr0Uokd+0ynq+FpuswVWs+iPjawBb+pk68lZUQrh1Ucelz21H
 6heo2sU4xzLwBNZ0zFYVB4WWJJU6Cc+dMBIThsLjD1eb6Un3mZ9T+yKdop+AZYABxZsk
 p5uuO4QeKiuQ8WQQtW0bFu1v6zohbLbvBf6xD//csTt57q9NL6mipoMJrRtp2LaMP0UU
 KmhJiPe7tj1JUWb+MCa/N27+TdU1KmWNTuz1MI9BpjzH4kH9N4AKcigK/ZjtR560DmMQ
 vdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732094494; x=1732699294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oum+sd/6X3GD5axRrx9WNHXoGD6W///ubAsVBe+Sg3o=;
 b=ep9cbenW6Q3L7gooetAl3ZoUgyh3PAudK0Q+qoxC7ceCyC4rhsX7RTYadJd7cwn2Yk
 M2pgfjxHAjwDcjKk7Hi/pLMy4ykIL9OUj1dSIAU4HrAJ26o47X5rttu5cFDqLWzRRnJK
 i7irJffZptdpB4cZdhbfMCA/v37MiR2TWgJux+PJohDJpkGH3bxmJjHXN4zfmEwqOu5B
 DjF9hzp5QCMN5wTB1mSNbhlT8Qec0EgrQQDoIyfgTXKb+ceD+71n1jSijuHuuGGqJjwj
 /4fcnidNWHSlY3Pxn3iNnoZKQzYNiXCCo+Qq09kO2kTgytqbpOy9nKgd0p+ToIURYdOK
 BTUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV04XHddjj9d5RPDZcaqSdFKaMIjcjA1Rxh593UoQUgtek4I4RwYnRJQsMwNGnzdvysKckRBJxzUl9t@nongnu.org
X-Gm-Message-State: AOJu0YzxK2afLQrbrne28ZO9UYyi8hPOTAms07gwDfJmxsG7NWs6fAEd
 hg+IF2KB7aP7pFEP1b4CYUI/iLYEaQ0kxdt5vUiLOdpRCLPaLTtP4bYC+cR8H9Q=
X-Gm-Gg: ASbGncszpcFCcm3PQlNK0dQcEAEVL+aEMKWvoaoGZ6BkmH0MQWYes6hAB6mzBQpyGcD
 tQQIZ2nfcBDBEI9PLhEIfJY0FsIgFi9lXbZ1ScEWBFky3x+Z4pCSakZ7ApedjBINHmNr4+QJNJ/
 pZL2ICqnRkpVgRkHz9GDEvqfSeZixjXHTHcJ71NVodAw2/BKPZbu93tvO2AFTLYw1GRf6bMq2fI
 39euz3kECW2pIb7c/EB4ddpClgkeR0HhMGgEMVtFzL5uhlBi2MPXOy+wEw2d9cp
X-Google-Smtp-Source: AGHT+IGSPFklgiQ57YNbh0kiVHv8XVkv5OPXgrFCAWrCIpgF/71D+lxuGq3wOCY0GUq6snv3fj/cIA==
X-Received: by 2002:a17:907:320c:b0:a9a:2afc:e4e3 with SMTP id
 a640c23a62f3a-aa4dd7386d3mr164108966b.50.1732094493953; 
 Wed, 20 Nov 2024 01:21:33 -0800 (PST)
Received: from [192.168.69.146] ([176.187.208.27])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cff44eff15sm596006a12.35.2024.11.20.01.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 01:21:33 -0800 (PST)
Message-ID: <e8a3d37e-508e-45f1-99bf-b5ed14f5981f@linaro.org>
Date: Wed, 20 Nov 2024 10:21:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/scsi/scsi-disk: Avoid buffer overrun parsing
 'loadparam'
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
References: <20241120085300.49866-1-philmd@linaro.org>
 <20241120085300.49866-3-philmd@linaro.org>
 <64087716-e9f8-4016-859d-974173d21dbd@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <64087716-e9f8-4016-859d-974173d21dbd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 20/11/24 10:10, Paolo Bonzini wrote:
> On 11/20/24 09:53, Philippe Mathieu-Daudé wrote:
>> @@ -112,7 +113,7 @@ struct SCSIDiskState {
>>       char *vendor;
>>       char *product;
>>       char *device_id;
>> -    char *loadparm;     /* only for s390x */
>> +    char loadparm[LOADPARM_LEN]; /* only for s390x */
> 
> You would need a +1 here because of
> 
> static char *scsi_property_get_loadparm(Object *obj, Error **errp)
> {
>      return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
> }
> 
> expecting NUL-termination as well.
> 
>> -    lp_str = g_malloc0(strlen(value));
> 
> I have sent a pull request that simply adds the +1 here, also because...
> 
>> -    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
>> -        g_free(lp_str);
>> -        return;
>> -    }
>> -    SCSI_DISK_BASE(obj)->loadparm = lp_str;
>> +    qdev_prop_sanitize_s390x_loadparm(SCSI_DISK_BASE(obj)->loadparm, 
>> value, errp);
> 
> ... this would overwrite SCSI_DISK_BASE(obj)->loadparm in case of error. 
>   Note how the code is setting loadparm only after a successful 
> qdev_prop_sanitize_s390x_loadparm.  That's not a problem in practice, 
> because failing to set a property is usually fatal, but not good style 
> either.

I guess I was not well awake :) Please disregard this patch.


