Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292D3E65D3F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 09:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEQDn-0002Mc-Cn; Fri, 22 Nov 2024 04:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tEQDk-0002Lq-6l
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 04:45:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tEQDi-0007B0-BW
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 04:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732268694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=atUblKQ6134bW2313peIcsQxWNUpRbi5EdTLwzcIJds=;
 b=HxqDnKfloP0Hn+Ky0wKxH1jQ6kNzF1TcU/L6EABiGYMS1uk2lQnJXuWKTwJE71XBwr/c5A
 j0F7X9zmpXNPWZdTx5O3cn0VpjTD0TvNjh195zUNDja6jEGbVflLcoDo+VbhpwZnSHQRn7
 gjKJWxTNf7X1E7xQizuFpKF3LT0w8NA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-9ynP9Hz2MuK6XJL9ztRIgA-1; Fri, 22 Nov 2024 04:44:51 -0500
X-MC-Unique: 9ynP9Hz2MuK6XJL9ztRIgA-1
X-Mimecast-MFC-AGG-ID: 9ynP9Hz2MuK6XJL9ztRIgA
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-53da09b1ca1so1417366e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 01:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732268690; x=1732873490;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=atUblKQ6134bW2313peIcsQxWNUpRbi5EdTLwzcIJds=;
 b=Y9NNaV7YALIyakUzKQItXwPlQg1Bry4fNfCDQdkhc4UW01AmIPSN2M0Skbbvvp9Q0y
 Q7VM1Cb7X8RgwzIX23rd+N8Wc74OrOgsMWURvmBX9aMoKiwOx9q8aHY+nibecpc1Dl/z
 Ehx1uYFcfr86MpusUmWq/JFVxHjYHnL5iYWrUdIXcaiaN9nScLhN7Cm2/vbT8YLkOTM2
 neUjE3aeRx8XPKw11YDob+PcEZ65Sec3JX3wjBDUVt6TqT4Llpnbsqn5sR7QBrKHcQzc
 +nr+tMUDsjscaWk95Bmh7jKZ2OX+7jJui3D0OyTiTzOa1dxId2zV0Nvpq3ZM5qnV8UXP
 ahNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6qAhEN7gvX4neUEA+w6DYAE2E04SzLTvJs7PnivdSrHNLoSldn035KnHahjRpXEBzYWiACu2n2o4U@nongnu.org
X-Gm-Message-State: AOJu0Yzew8c9Y98LFk0yOKCvgFR7v8ccALsCwlsNBP3cynkUKuU9hIAF
 8XXNYx+peQdVYNpLGfehg6lhLHap5LoGT1rosIJSNF5wF5ZsSKUlzhOaMXw3G+BU0vQk/4zqllc
 rUsueFzci6g+n0R3bM7IPp7mMM6NAnQazrW2KfogWEucmFcazlmAd
X-Gm-Gg: ASbGncu0thomMo0cQLPw6A/KCGf1NUpX08/V7k4ycmKqNBCvF7nnEXL5cNZ9n6JAfTl
 HcJ9B1yvPaPhhnZT7YFvCQaAesDxga8cvjuX0as5PNFd4vSTrUBJYlYyYhzEmg1WY/dgeEonQCP
 79+mhIhstmS0Xf+v81lIlSJqQfWQ5g2jC5UCH1XbKzXYuUiIwg+Ryewd5RgwH+6Yn3RuAUpxta7
 SEuLGkkyAE1bDv2M/ukcIY45+ZY6+GD1J4f13oXkk0+nsmkOfGCNgVa7tu6mWAhcqy3ICpeu778
 xSInwSmMwtvZeW5y8PSNJxDHN8CGUuBMZCLkXytQjLnjcyD5AUPGG71TWRJq/MfCOZnlJnQ1EBU
 =
X-Received: by 2002:a05:6512:3988:b0:539:96a1:e4cf with SMTP id
 2adb3069b0e04-53dd39962bcmr981793e87.32.1732268690095; 
 Fri, 22 Nov 2024 01:44:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFeki/oIUYTbcflL8ZIiMwZgTMmasABgSv0aQlfCJdGETGdoRhG6Q4/TKrrLuaBHauzf6TGA==
X-Received: by 2002:a05:6512:3988:b0:539:96a1:e4cf with SMTP id
 2adb3069b0e04-53dd39962bcmr981773e87.32.1732268689657; 
 Fri, 22 Nov 2024 01:44:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8?
 (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de.
 [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bd7d7sm87651405e9.13.2024.11.22.01.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 01:44:48 -0800 (PST)
Message-ID: <3af19d21-2f18-4890-9a23-8e24a503cc33@redhat.com>
Date: Fri, 22 Nov 2024 10:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Initialize nr_cores and nr_threads early and
 related clearup
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Brian Cain <bcain@quicinc.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20241108070609.3653085-1-xiaoyao.li@intel.com>
 <5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com>
 <1e210331-e458-4709-9506-b83abf89ebed@intel.com>
 <af349a3a-8a15-4263-9a93-180320daaca7@redhat.com>
 <db7f2f59-6cfe-4e90-ae63-1faeb870726b@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <db7f2f59-6cfe-4e90-ae63-1faeb870726b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22.11.24 03:40, Xiaoyao Li wrote:
> On 11/22/2024 2:52 AM, Paolo Bonzini wrote:
>> On 11/21/24 17:24, Xiaoyao Li wrote:
>>>> Could it go into cpu_common_initfn()?
>>>
>>> It can, I think.
>>>
>>> I'll move them into cpu_common_initfn() in v2 to avoid touching all
>>> the ARCHes.
>>
>> It does look better than the alternative of duplicating code.
>>
>> On the other hand qemu_init_vcpu is already duplicated and I'm not sure
>> I like relying on qdev_get_machine() inside the instance_init function...
> 

Good point.

> I had the same concern.
> 
> But it seems all the ARCHes should create MACHINE before VCPUs. So it
> seems OK to qdev_get_machine() inside the instance_init function. But
> I'm not sure if there is any case to create VCPU standalone.

There are, for example on s390x in create_cpu_model_list(). I recall 
there are ways to start QEMU without any machine and trigger that code. 
(or maybe this was just for the test environment with a special test 
machine ...)

> 
> I think we can check if qdev_get_machine() gets a valid result. If not,
> fall back to assign nr_cores and nr_threads to 1.

That sounds reasonable to me.

-- 
Cheers,

David / dhildenb


