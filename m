Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940DDCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ZUM-0004kl-AI; Wed, 24 Sep 2025 20:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZUI-0004kJ-Nr
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:05:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZUE-0008DY-21
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:05:30 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso2003305e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758758720; x=1759363520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iCbXPK49QYPBaVXqzz5tmTopI8NvmqXydGgceWT03fQ=;
 b=EE+M+4pZG7Cwof7tBIeeNjffEGcdSHrn0EybCQmXpB2hPbTzEhD1iX3eVvDnTF6gLZ
 Pa+D03siryD/a6s7DXtbk7/iq+7WXvl5W2n69g3VhPqQQGHJjGIljGyd2ewOk5H2cxWY
 WxF1XLRIF+oFZIkawHVStQVlxRbZ04exWKENNMJ9c+L15y+XuxcMh4cu8thivmeHfnSh
 f5DIynVFnjPrlY6HzFLSvaGKtRqRxEyeXt90tlYR+9rlv7p8/fEiWLjLHBnjaJIdbelE
 Y/Us8rfk9sccV8Qtc0cFH1aXkUK5FyCrT25BHnURy81s54yhVO/saz15V5kwaaRxyjXo
 PI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758758720; x=1759363520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iCbXPK49QYPBaVXqzz5tmTopI8NvmqXydGgceWT03fQ=;
 b=dJoEPX/HL01bsx/P9smKqR6us3Mzy5MT133Dl07W9EoTJnXiqSDEfvqV/YmxKwnF+2
 2RRjJYM2CWPN932jJo8XeC7yNCeyGbgHo+UsavTq5myjlNE5sRVYQ3m4Naj+m5VNd4B+
 NUq3rFVmh+idZy+f38sOIebf84bfZ3VCYk7EXr5FL1HRdRfoXqvuTzNDwJJKXHoXSqhr
 0csNMwkeji4Jo1al0eDK6tTsYFZuZLSu9ZetNXxbzk6loe7urbzdsFay6JLDtzepWAFc
 Xx9Yo6ZaxTq1gJKLEFpuuEjS0ZWf7GUSvqfczlqhTXKSs5XI3FKD2VlFN8ZalhgX29F6
 054g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+z2Aj0NH+HdVqodsEf6xUsihvps5yy7IdKr0AXUkIoTJ0dc9FEkSCHY2sMS5RdknZ5rdykVWsO29/@nongnu.org
X-Gm-Message-State: AOJu0Yx4kwGX5CC3H565X/WU+V5PhKiTkmBkHL2Piz6svtIhuqa6vKRv
 JD3NFlmyWB48BLTkPBb0NReWo4jLKtnab0aB9RvsAOhjaTaMDnhypkASx6zDJM5qhDA=
X-Gm-Gg: ASbGncvcubTzfVjX48s7i2GzFGITIrJXpkQwZI23b0uSgUekt7GAVnmqe6FlApkjw6J
 ep2zlFtX7rJGhdU2q92oLIztUKNZcu89S55v6vmDnsytGDNmMB4d1t75+fGXjmIG3iOYt7d1Zpc
 2GSp0/IvZZrV9oMVDVg2BswEp0b+1EndOgYhtWBYNbmeeThlJLGjstSyBZWw137Of2cRbIovyip
 ckr2+vJPS6uQNMQAZU1hZD9wMx2RGCjkFftJRY9uDej83nIha9COhA86V+3HjQ2CMYKlZEcOJl8
 6W/oa+Gxw6uOhZ597KKPJ9m6lu4G3zLVl+uT7phzOfFfhoU41MbA2bUMibBxKGxyClsDrWfpfbV
 vCkBZSl3Ytpr1Y/phgTNf2JtgPph6ElC5geEWMzabJaSU8QoeMuWfnhtqHgywzoc0aA==
X-Google-Smtp-Source: AGHT+IEalGrWN9JasKzIjkA9EfHCFanqLjPDhUWhWV7LsktYW7L8LFBUrGrwynw3MeFHdD9lcbS1ww==
X-Received: by 2002:a05:600c:8711:b0:46e:1ae7:dc1a with SMTP id
 5b1f17b1804b1-46e32a1a40amr14288685e9.35.1758758720454; 
 Wed, 24 Sep 2025 17:05:20 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb2eesm530524f8f.12.2025.09.24.17.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 17:05:19 -0700 (PDT)
Message-ID: <9b91b4f3-2b26-4008-a783-ec1d30030389@linaro.org>
Date: Thu, 25 Sep 2025 02:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 P J P <pjp@fedoraproject.org>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org> <aL7zAV3xh-idgX8P@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aL7zAV3xh-idgX8P@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 8/9/25 17:15, Daniel P. Berrangé wrote:
> On Mon, Sep 08, 2025 at 10:45:40AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
>>> Currently our security policy defines a "virtualization use case"
>>> where we consider bugs to be security issues, and a
>>> "non-virtualization use case" where we do not make any security
>>> guarantees and don't consider bugs to be security issues.
>>>
>>> The rationale for this split is that much code in QEMU is older and
>>> was not written with malicious guests in mind, and we don't have the
>>> resources to audit, fix and defend it.  So instead we inform users
>>> about what the can in practice rely on as a security barrier, and
>>> what they can't.
>>>
>>> We don't currently restrict the "virtualization use case" to any
>>> particular set of machine types.  This means that we have effectively
>>> barred ourselves from adding KVM support to any machine type that we
>>> don't want to put into the "bugs are security issues" category, even
>>> if it would be useful for users to be able to get better performance
>>> with a trusted guest by enabling KVM. This seems an unnecessary
>>> restriction, and in practice the set of machine types it makes
>>> sense to use for untrusted-guest virtualization is quite small.
>>>
>>> Specifically, we would like to be able to enable the use of
>>> KVM with the imx8 development board machine types, but we don't
>>> want to commit ourselves to having to support those SoC models
>>> and device models as part of QEMU's security boundary:
>>> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
>>>
>>> This patch updates the security policy to explicitly list the
>>> machine types we consider to be useful for the "virtualization
>>> use case".
>>
>> This use-case sounds reasonable to me. I also imagine that
>> some machines can get fixed down the road perhaps to
>> the point where they enter the "virtualization use case".
>>
>> However, since we are
>> getting this elaborate, would my old idea of a runtime flag
>> make sense now?
>>
>> To recap, the idea was to add a "-virt" flag that will
>> block any machines, devices and so on not considered
>> part of the "virtualization use case".
>>
>> We could also create a mechanism for downstreams to
>> tweak this as they see fit.
> 
> I would not consider "virtualization use case" to be something we
> want to represent in code. It was just a crude hack for the docs
> to approximate what we wanted to /initially/ aim to support.
> 
> The ideal theoretical end state would be for everything to be
> in scope for security fixes, but we'll probably never get that
> far. The reality is that we have a granular decision likely at
> the level of individaul QOM/QDev types.
> 
> If we wanted any flag it would be better expressed as something
> like "security-boundary=yes|no', and then each object would need
> to have a tri-state property "security-boundary=undefined|yes|no".
> 
> Initially everything would be in the 'undefined' category and
> over a long series of patches we would then reclassify as much
> as possible to "yes" or "no".

I find "yes" to give too much trust and fragile, since it is easy
to introduce (security) bug and discover them later, usually too late.

FTR our previous discussion about taintable runtime API:
https://lore.kernel.org/qemu-devel/YVWRw0ZKq3G6P5YP@redhat.com/

> .... a mere matter of someone having time to actually do the
> work, which is how we ended up with our current fuzzy doc
> rather than anything expressed in code.
> 
> With regards,
> Daniel


