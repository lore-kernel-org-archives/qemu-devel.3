Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710D4CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Dps-0006Co-Nd; Fri, 10 Oct 2025 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Dpo-0006CO-4N
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Dpe-0001Dn-AT
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760105451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B+CLkYKfEpNHIfyLWBVgqsu3XBsqJ4jV5EBOB0jkO/w=;
 b=eL1FcjNXGavng9TxCzR6boBbpdI7z5u1J1HcP2Ui435ctWoHecks4zMHIgmnuKz1E3eKW6
 73z8QuZa+sf2QAhqNmMlx7J5UDq7rmP1tfEWVmxbhNiWvdx73DmCpSanw4jg53hnShvxQ4
 JCLMDhmZBA9j8kBs1jUU39dRAUzlySc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-4gETf5fFOiuPM9bFJQGu_w-1; Fri, 10 Oct 2025 10:10:47 -0400
X-MC-Unique: 4gETf5fFOiuPM9bFJQGu_w-1
X-Mimecast-MFC-AGG-ID: 4gETf5fFOiuPM9bFJQGu_w_1760105446
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b3d525fb67eso241889866b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 07:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760105446; x=1760710246;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+CLkYKfEpNHIfyLWBVgqsu3XBsqJ4jV5EBOB0jkO/w=;
 b=KmTiYzixNiOmMA5XViE2FfWYIa0rcBgfQd9yg5oQ6yNN0nu+g+zveSa68cuW8B3eLc
 8XQeyugx7/Vhz9MWEIAkTbxP6EgNeu5Xxo52utVtLtKln7sYyDtkPi6eZ7Zh2FFrfByH
 XmF3nwdz70o1h9oLQrLIV8F8c0LSjEttE1LwiLV/B8jYqGI/2p0woD3CXVl9rO7jiKeO
 qMU7SZujpctVQzAi5e3CaeEtyCKQVaolUXkhZ9cR8z3Ffd14nTN65wqA6orkqIJIEDBI
 vFZUxE9OazKVSZ1CSWezoc08L8gbMThh1c9uUcXnwSwtWeOh1rc3NzEXw3t+xNVCwIyt
 ODfg==
X-Gm-Message-State: AOJu0Yxeo1naRKyrivAqoonfYERUZVSoZDoHzC+kJ3m1FdFnTVmtqTbu
 C8jr8fnjQsqPHAWwmiq2ailAA3piAH+GK4W6xD3fmvqfL4daAMFlW2lixaUhD1oSW8a6rlyyXsf
 Hv5j+qhJQLWsC8/rGtg//SEpwGlLr4c2L3ZD6Zire9bfe92Uwh6x0hia5
X-Gm-Gg: ASbGncsm5F5pusGorW3DUD1tUsapf9y6WUHl/aHT+VItMM+4SPVrUIkH24YuZYn5Ez3
 KkjfO/6i7PNoP8fAcgE0dbUM5uf9fCM/Fa2oUj9iHrCJN/uCknx/Te2C5HSYc2NHaBNMVJLUtAp
 7XLlBxWA9WQ8LrdGlg/JxnYp5lyEk7kJVYfrsNo65Elyn3JIh+EazVAEGYBPclOsHttH8ZwuQL2
 YPpKZVQo0K9uJyllgJvw9ECfcFu9KRs1woCjRq7PY/KvvXk/024niR+HHIlO3nZ+GIC1f9p7m7u
 YtQuGz5SBKa9PXwr3nvN1MHbf2D6cMYdlTWhmk/HCldYWCR6o0ftXfplwBjg29WKJO9EnTMqyXH
 Wjy0WeV+85vQ5aZVXasQKvk5fGcHVTXCmts/PweQuQTu7
X-Received: by 2002:a17:906:6947:b0:b57:10da:e62 with SMTP id
 a640c23a62f3a-b5710da0eeamr20690066b.64.1760105446409; 
 Fri, 10 Oct 2025 07:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdE/wcwQx6Vw8ThJNFI+hk3gQWkjylZZQW0fOC0sBvN+MPenJK0WqR8sSUqANbWy88S2oEEA==
X-Received: by 2002:a17:906:6947:b0:b57:10da:e62 with SMTP id
 a640c23a62f3a-b5710da0eeamr20685766b.64.1760105446027; 
 Fri, 10 Oct 2025 07:10:46 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.231.162])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b71361sm2714321a12.28.2025.10.10.07.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 07:10:45 -0700 (PDT)
Message-ID: <e1424616-5bac-4809-a70c-63805b1db893@redhat.com>
Date: Fri, 10 Oct 2025 16:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/27] qapi/accel: Allow to query mshv capabilities
To: Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cameron Esfahani <dirty@apple.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-25-magnuskulke@linux.microsoft.com>
 <871pnahn2f.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <871pnahn2f.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/10/25 16:02, Markus Armbruster wrote:
>> +{ 'command': 'query-mshv', 'returns': 'MshvInfo' }
> 
> Mirrors query-kvm.  Okay apart from the Since: issues Daniel pointed
> out.

Which I swore I had fixed, but didn't.

> Should we have a generic query-accelerator instead of one query-FOO for
> every accelerator FOO?
If we want it, it should be query-accelerators with return value 
{"enabled": "Accelerator", "present": ["Accelerator"]}.

The patch is already merged, but it is pretty self-contained so I have 
no objection to reverting just this one.

Paolo


