Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5051EE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIy3b-0001Jm-7J; Wed, 04 Dec 2024 17:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIy3Y-0001JV-35
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:41:16 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIy3W-0000vK-4z
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:41:15 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso201069a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733352072; x=1733956872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JTXlaCXNXxkbmkcqcalqylsdzpOZz+cu/IkaDF5tOFA=;
 b=n67zM+O3kf8AHbNSMwx6qgqGpN/v+3jY5B63QMHLiSFSiGT/kgjD8EkUuMzEutGguN
 NU2XUzIFiDzxonyATusD5k3gHrS4JAAuviOvt8LJ4hd4UnbCmw0v0pYLKtIxIgpim0SV
 J5tG0yHxaCtoVnr7NemzMio/SuwvS3HzHJHGy7iPa5kanVqt4QGrUivt2oJtlP8wyJ1w
 cgwDshigtMGXl8G85RNFnAfUenaVagxdn8muMyNxxTygtjQbQ50LP5QPN/OY9Pxcy8fR
 MYESHq16KIo4WtL3f37iJrnbNs7LBfwMAv8opJUYh14tEZl1UqqJmXvlyqa88lbf4Zqu
 DU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733352072; x=1733956872;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JTXlaCXNXxkbmkcqcalqylsdzpOZz+cu/IkaDF5tOFA=;
 b=qsmgW5FokPjUzHKaVkFCFgGSsnXPSXcGSNi8Q2lUZVL+qlO+jnU99iFhKHlPrU+4JW
 MyYlO070yE1/tY2+uYrzCp25KbnSRJwClO+VKmq5td8yUXSqjeeSbbLwLwCJkVbpmBdn
 2KMabqHqmw61+avxD2hWslxipDWuGb48wMsBPeVBw4NcCrVq+eC2lOBdEBFtbI9ZJTvY
 plDYXCzWGS4ln6MCWLoR7bflC//cE0M119tcwUYuSvpz0y5EY7bML6f/0Jd1ZVxgqLJB
 2/SInuJVsjobBEV3GnmOdMJHqTuSm3ltmvyiuXYcngwLrh+pBdogcssl9E3fXIGN7KJZ
 Zthw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPYzgdrKEO1waYwUevrZ6dI2eDzULOLuC3DnpVzBmu8QmXS4eLVLY+4idWYxElQOVmd7cysgE1ZILL@nongnu.org
X-Gm-Message-State: AOJu0YzI4mQgE5Kqdx4YCGfKPOWKbwqUi/SjBydoLAiUZjfM+FIBz/8G
 7Wd1eMF/mGRs8mmxFchsWm8tBtPDTS+HyENWrybzn8SlJZYZGMVtGVcuPVfF90TsIfTMPRUqqb5
 MXws=
X-Gm-Gg: ASbGnctVM6L1tZ0LVECMX2sJiareYEGtpQFHfOWvLjxH3touNWcboXoRB4TaHSV/vMw
 oz9ABV6u9ZpAg3FrfSBfIlCOwx1BJOJ36M1ohf4rCEaEPRv4CM/3fzGIuJc+1hqH6OMBH7GXPiV
 dEc67d5H/lTJXDSUbucZBin0TiYZmAlMpJ3o+ZtR+ppf4fKqMaXpaZKz4BNGGjs/nvXyVNRcT+w
 y96Eikwakt1bAjbG74RgccpWcBTjoB+qyQIzvA/J0pmDFUupMk296ZYO6cPoje+B70h3f6OxUOQ
 SzZZDfKE1NmEp6nXpmkmIg==
X-Google-Smtp-Source: AGHT+IGEhXAda8WFoHtO0vdLGD2GwNGg305C5d4bPor2FlC0ySyi5bHp8sHXHM/WqZOH41Zbou1dUg==
X-Received: by 2002:a17:90b:4b82:b0:2ee:7c22:6e7c with SMTP id
 98e67ed59e1d1-2ef41c73dffmr1619272a91.13.1733352071938; 
 Wed, 04 Dec 2024 14:41:11 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef45f7eaf8sm64477a91.11.2024.12.04.14.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 14:41:11 -0800 (PST)
Message-ID: <35529516-cc96-41de-8e0d-a7807ccc09cb@linaro.org>
Date: Wed, 4 Dec 2024 14:41:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <181b9b53a258257df1b24e7bfb8b0e6fc590c25f@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 12/3/24 00:45, Julian Ganz wrote:
> Hi,
> 
> December 2, 2024 at 8:26 PM, "Julian Ganz" wrote:
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index 0fba36ae02..9c67374b7e 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -154,6 +154,49 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
> <snip>
>> +/**
>> + * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
>> + * @vcpu_index: the current vcpu context
>> + * @type: the type of discontinuity
>> + * @from_pc: the source of the discontinuity, e.g. the PC before the
>> + * transition
>> + * @to_pc: the PC pointing to the next instruction to be executed
>> + *
>> + * The excact semantics of @from_pc depends on @the type of discontinuity. For
>> + * interrupts, @from_pc will point to the next instruction which would have
>> + * been executed. For exceptions and host calls, @from_pc will point to the
>> + * instruction that caused the exception or issued the host call. Note that
>> + * in the case of exceptions, the instruction is not retired and thus not
>> + * observable via general instruction exec callbacks. The same may be the case
>> + * for some host calls such as hypervisor call "exceptions".
> 
> Some more notes about this bit: I originally tried to make the from_pc
> semantics independent from the type of event, i.e. either of the two
> cases. I obviously did not succeed in doing so. As, in most cases, the
> instruction pointed to by from_pc is not observable via exec callbacks
> I could also not test this behaviour in the testing plugin (see patch
> 11). I am therefore in favor for dropping the from_pc for the next
> iteration of this patch series.
> 

Does it mean that information returned should be dependent of type of 
event, as we previously discussed on v1?

>> + */
>> +typedef void (*qemu_plugin_vcpu_discon_cb_t)(qemu_plugin_id_t id,
>> + unsigned int vcpu_index,
>> + enum qemu_plugin_discon_type type,
>> + uint64_t from_pc, uint64_t to_pc);
>> +
>>   /**
>>   * qemu_plugin_uninstall() - Uninstall a plugin
>>   * @id: this plugin's opaque ID
>> -- 
>> 2.45.2
>>
> 
> Regards,
> Julian
> 


