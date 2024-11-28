Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0322D6D258
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 03:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGUsQ-0006EZ-8a; Wed, 27 Nov 2024 22:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGUsO-0006EJ-6r
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 22:07:32 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGUsM-0001Cs-Bx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 22:07:31 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea5e405870so202137b6e.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 19:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732763247; x=1733368047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IwevsB9FufyTmYs6TnyeEYng8eBccO8TnGOteYOeVZ8=;
 b=hlz2tGeYo85xngEI2vwSaXBXo2XrIyBEfv0s9MV9GzzsOoMmjqKm/Ld9zDPtyXVMtZ
 cXK/rEJShmCf8tkeFHejSBZVEb1uSz4I2CxcrIbF08OrdnuOKF+8Mgbn9Rfc2ahTq+79
 WMb1iwFuegsHNx/F42sS+Xqbc9/UZNOlYXYOEyP25wm1EwK82VoXY/Xw5LYDDrt1T0lk
 5bxyjgi/iMVWikT8ZB0N4VyvTK5icn9K1cKoYFJ6CWsIxP6kwGNPArRXW5Sho2ninTd1
 woNfjBzGR9A2oOFcMZYmIAjc4DOCshS7UqxRSjKs6nu2bs8hRRl/7ku9bruBgzKYnAtE
 22dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732763247; x=1733368047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IwevsB9FufyTmYs6TnyeEYng8eBccO8TnGOteYOeVZ8=;
 b=BbY6SQFzuhWLxnpczViGa/1CpYjH2iPu2rq0OjeuaZp6XD4UEQ3dxp2GzMCy38hcS/
 P6NsG6zPa9Hu6E02UTQqeu1xElP3rwQT3d88Aote/cWHy+82nT7K+yu8LvQlZ4qdbhFO
 d1pM6MsaNcmGAGzVBpiWdHjD7Tk6erTusae6lDmlaQBb2O/OTwIIdJgh/fnpErxic1Pe
 SJFElEL9L9hYdnKoVUX0+PCBXrK2+ZZ0gW2MBfZ5Zqcb0OLVtm8yjx+1jAcfz+3X9pxw
 tRGJIO8T2A76luj7u1e2mjYfUysk6Pma+8dNHgvhCq1k5lzpmdOdqQI1UdNOaYWoLHFe
 rh/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZvpC9mcHC69FvuRI8pZKfiv3ytCp2+nwkiJl2Zc0+4PhHOGfPgGdVliY4+Tl+wcRtKRY+AsbQjMew@nongnu.org
X-Gm-Message-State: AOJu0YxVtn49Dysj3DDGmgEZ/YgTSQ5D/F2a7ibNeLOhhVl6Y8JAhB96
 5oJsj6AdCtY0h8M/FrWIryNMF1YJG3yO4dLgGTi1f9EqskNXMmTLkmZDkTivK0HzkO0nm9yvivN
 Mvc4=
X-Gm-Gg: ASbGncvdVbgxDuwOjWUX07eCXK3q8zVCzkeQnxpo/q4RW6ecVmmOcvOkLJdhuOWiR1j
 bQY08sHGyQya4TPpFOkXBgsATdFqsz+38z45zBt9ccBgInYu3/WdDa1QTmXzwB9lXCn+RBPtXAe
 HgJS6p8QIrN5qGWmdSB1Sewh3EjoVQc+jQ38Y2d+4M/9WfRLdS3JJ9RG/atuJ09NjbJoU1eXPag
 Ir1QrUeFYRwhWgKj2MYlbSxlLi97xpA0B94C8JvXeq4TGYE2cCIJFLYhHe9ByhBDXGIzemjI7aC
 cMyiegULEKFVrGbeVfvdCNaftiIy
X-Google-Smtp-Source: AGHT+IEUMR7KQBF1rgsaD/Hr62USUVsBzlzv3R4eM9ZNQ0CO5OO5wINdleLLbiJtrFXlC17eQXnKgA==
X-Received: by 2002:a05:6830:2b1f:b0:71d:46c8:60cf with SMTP id
 46e09a7af769-71d65ca94bamr5910319a34.12.1732763247372; 
 Wed, 27 Nov 2024 19:07:27 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29de92c4564sm204946fac.26.2024.11.27.19.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 19:07:26 -0800 (PST)
Message-ID: <78c75efd-9096-4827-8426-b988abc815a5@linaro.org>
Date: Wed, 27 Nov 2024 21:07:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-3-pierrick.bouvier@linaro.org>
 <CAFEAcA9cbV4a8r=h4imdvyMV3P3B4mhgnWU-eobH4ESrsr0Uww@mail.gmail.com>
 <e0c904f2-8620-4f6f-8392-75971529080e@linaro.org>
 <044d72c7-c135-40d7-945a-7aa2c8e89965@linaro.org>
 <402b3bb4-f6b6-4d5f-a7ca-22e3caec62aa@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <402b3bb4-f6b6-4d5f-a7ca-22e3caec62aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 11/27/24 19:01, Pierrick Bouvier wrote:
> On 11/27/24 09:46, Richard Henderson wrote:
>> On 11/26/24 18:15, Pierrick Bouvier wrote:
>>> Except for saving memory in *very* specific case (a structure allocated tens of millions
>>> times for example), I hardly see a benefit vs using integer types.
>>
>> Even then, 'uint32_t flags' can be just as easy to use as unsigned foo:1, bar:1, etc:1.
>> Plus you get knowledge of the actual structure layout, which is presumably important
>> *because* it's allocated millions of times.
>>
>>
>> r~
>>
> 
> Do we have a specific API (or set of macros) in QEMU to help with this?
> If yes, maybe I could mention it in the doc ("we recommend using X instead of bitfields").

Yes, include/hw/registerfields.h.


r~

