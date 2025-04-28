Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC62C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9RS1-0000sO-5G; Mon, 28 Apr 2025 12:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9RRv-0000jo-4o
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:35:20 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9RRr-0005AN-TZ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:35:18 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso4376857b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745858113; x=1746462913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hAdjt1tdJ7Dho/Onvtu/H1kypBhA3JR5OeXo5daA080=;
 b=Pz3vb9Ek+PUjzoTX4K6cznN0qkWePgS9XXyIQNZpOwmWqmz22cQVrO4jNFTw0wx775
 rhD9Ba0q6ZAvb/YGGgPhtEavDBRu9bhhJP+upm3z2aUYs0EqOM8SQLzh6cEhFZnWrBQ9
 TlvXc0Ajr8A+Lqw2IQSOYxtOygJ1iGSRcf/d9nW1WzhfZFwrveVcPYA9lzNmeo27HgT3
 UaIahqRHqS90RTfGDMBJF4KXq/fXeVR3KnsvNWSumtrCUFqzee4HxmrFMST5TvQl0Xlr
 a1JYpsyuljzO4BnbocS2awRnjtpQ5i5j29bl+owshDCV9FBqHLHTpnOi6JFwVy0VEWDv
 Shag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745858113; x=1746462913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hAdjt1tdJ7Dho/Onvtu/H1kypBhA3JR5OeXo5daA080=;
 b=upC6H/1Rrzo+SnK796UJbLqVE/3dVOsQ+TyC1NeE2iHCBH7rxNy2lZARh5MIKgezl8
 r05F+I/cr4GvXKLNHPjSRi3139nVLFs0AYhFhZpWIXdEcUoDbRwSD2BnDayWchRtzwUs
 vYAygEPw0FVGZ9y2PiG1Ti/AHkROfAlSUEjbstfaGY04pBTpc073W+rnI8gij8o6R4dt
 26isi/fO4Wv9EfZqP+qkwQIhYOUfWdb0cjNt/ksthnV/136PyiKc4XeaoMqvVt75MhGT
 8S7iG5QjtgAndpLxw1NgwQA06YPDWaGS2XfMApPFb9eAML65LlAtnuE7EBqmXYqJnKe2
 lCag==
X-Gm-Message-State: AOJu0Yy/TepUsuJ2ikn6iuiulJy/2FEyDvnQ0v9hU5uxhN6IYhLj5Xue
 wfLU3VxWfmn1ZsarQ7kHteUshZ+1LKlggjo8dJR8k9YaZI3uWDyQ0tBUk95GVys=
X-Gm-Gg: ASbGncstClWyNxSdOfrJRn+n7+gCWCOZBbE3JNXFciBmOBJow8QZDLRyfsfVTr0DDhV
 GSjmLeidOUnZm7nvaPSspuS1lC3Wj+57RlE0M1dysPr51KlO69WWv2/QHNcZghSLzKf/xPPp8Tz
 qXt1qOV+JuUdmWq4XB/Q5OEmK2hqPGPZF0pHbiJHBd8azBX4fwqytoByCqWbh/ltYIlrPP4kyYb
 h8SY5T5zyKcXqvTcA4xIOmt7Ocqin/L9VJA6PEqljkh8+1BT43Jh+gE7MhLWr/M6bWGg31ZQI/z
 WDCfhgsoGkEe2MEUHj02c8eUDDYuzlPt2wj2OzqrYj8/bX97qWNfPg==
X-Google-Smtp-Source: AGHT+IHl1TCjwelpI+QPtQMggOZNGjLgw8eI4LPb0fJAAL39w58ZhLy0wJaI1AleCG4JmZWzgEdSVQ==
X-Received: by 2002:a05:6a21:600b:b0:1f5:83da:2f9f with SMTP id
 adf61e73a8af0-2046a43086fmr12710332637.12.1745858112676; 
 Mon, 28 Apr 2025 09:35:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15faded629sm7473932a12.63.2025.04.28.09.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:35:12 -0700 (PDT)
Message-ID: <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
Date: Mon, 28 Apr 2025 09:35:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8734dswnm3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/28/25 4:07 AM, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:
> 
>> So what should libvirt do once multiple targets are supported?
>>
>> How do we query CPUs for each of the supported targets?
>>

It's kind of a similar question we have to solve now with QEMU code.
What happens when a symbol is duplicated, and available only for several 
targets?

In this case, we found various approaches to solve this:
- unify this symbol for all targets (single implementation)
- unify all targets to provide this symbol (multiple impl, all targets)
- rename symbols adding {arch} suffix, so it's disambiguated by name
- create a proper interface which an available function (multiple impl, 
selective targets)

In the case of query-cpu-definitions, my intuition is that we want to 
have a single implementation, and that we return *all* the cpus, merging 
all architectures. In the end, we (and libvirt also) should think out of 
the "target" box. It's an implementation detail, based on the fact QEMU 
had 'targets' associated to various binaries for a long time and not a 
concept that should leak into all consumers.

>> Will the result be the same if we query them one at a time or all at
>> once?
> 
> Pierrick's stated goal is to have no noticable differences between the
> single binary and the qemu-system-<target> it covers.  This is obviously
> impossible if we can interact with the single binary before the target
> is fixed.
> 

Right.
At this point, we can guarantee the target will be fixed before anything 
else, at the start of main(). It's obviously an implementation choice, 
but to be honest, I don't see what we would gain from having a "null" 
default QEMU target, unable to emulate anything.

>>> This requires fixing the target before introspection.  Unless this is
>>> somehow completely transparent (wrapper scripts, or awful hacks based on
>>> the binary's filename, perhaps), management applications may have to be
>>> adjusted to actually do that.
>>
>> As noted filename will not work. Users can specify any filename and
>> create override scripts or rename the binary.
> 
> True.
> 

I would prefer to not open this pandora box on this thread, but don't 
worry, the best will be done to support all those cases, including 
renaming the binary, allowing any prefix, suffix, as long as name stays 
unambiguous. If you rename it to qemu-ok, how can you expect anything?

We can provide the possibility to have a "default" target set at compile 
time, for distributors creating their own specific QEMU binaries. But in 
the context of classical software distribution, it doesn't make any sense.

