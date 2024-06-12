Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA13C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHP2M-0004o6-Le; Wed, 12 Jun 2024 10:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHP2K-0004nU-Pm
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:33:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHP2I-00019i-UW
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:33:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4217990f997so37790655e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718202792; x=1718807592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n2qVdms+e50cnyPcFlCget/utC54t8n1u5in1FJt0Qw=;
 b=AJ7wtM13mzbP5TCm9CXd/aHnN/cCQ3QPDLyifAs1zLkmUEqQNsJN6c16m/2ha9OWyO
 /XZLalKPMY3Bg1JI7HYCvtL7bskWSxD4tFLxbO29SCmEVJbuV0T3OkSVjJlVgL5F0Cml
 +iOxGecDHLBILEgo8dfCAFwn5rL7Ak5pjwLFExPettUT19jzZIOldblmWx13y/rqp+KC
 kqSjpW4qIejcAUbt8DIts93TvxVWn0bZcvWh72522GHp0iran3Yepa0tArV0lGI0gWQH
 DvW4nIHIw5MXICFIPdtuxBw/T88rMHLq/B97/kS6TcnPDxydQHOHqUmpFJti5ZWgiSe0
 TXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718202792; x=1718807592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2qVdms+e50cnyPcFlCget/utC54t8n1u5in1FJt0Qw=;
 b=nBruA2GbcGFlUX/4LB/IC1KsnT7niyZW/KB/9wkbflATdNZxXiKklGLSOinpMx82Ko
 roDXGPyF8ghFpKscGxluX7uSVzRawKUEIL3M5av6G2ruY9hwTbKEhgNEj2CZRQIP73cu
 JT95SFcLdXHINSEQF03xT6jdT3v5iARYVUG0OpDfl5PFEyT7FS10eliOT4ZWXJ1LvUyO
 LrjGklMGWPDSgDRLXBat5oMGf1AuVPbMJra32qSr0zAXpp3aK5nIRYqbgHCItIUBGl4T
 buNv6e3T7fwOOUjhceqT2YMmMDpcDTzEug8kve1vGkk5LN53iKkV0djeybbtVgnoRBQ/
 kqGA==
X-Gm-Message-State: AOJu0Ywq8scR9FxKVXQb1oS7S51yhD2simM/FeIMtlObypYy5+u8N67q
 BbRhgClQqSubjUmV5N1bwF4ftnSZhB4Tarb5WYIl5bxn6AAHM/lfPA0NAuwAP0c=
X-Google-Smtp-Source: AGHT+IHpBWYaZK6ZegVqEicuQ/JRC13HEHOFRCWtX78EM/s+SKmWbenY1gdcp/MPa5ycDiJNSOXRFg==
X-Received: by 2002:a05:600c:46c6:b0:421:de31:8b with SMTP id
 5b1f17b1804b1-422866c5968mr14956185e9.27.1718202792420; 
 Wed, 12 Jun 2024 07:33:12 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422871eb9ecsm28880515e9.35.2024.06.12.07.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 07:33:11 -0700 (PDT)
Message-ID: <a5cabbae-20f1-47ce-a46f-30ad3b1d9d78@linaro.org>
Date: Wed, 12 Jun 2024 16:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: assert fails in s390x TCG
To: Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
 <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
 <6a3e8443-2d0a-451e-a481-cc26575d8211@linaro.org>
 <14787dc3-66ae-e15e-0bdf-14ca53bff17d@linaro.org>
 <b0b49b1b-6877-487c-9f4d-b29ae54c5ab0@linaro.org>
 <1a8cd52a-6c3e-47b4-89c8-d0254ba452e7@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1a8cd52a-6c3e-47b4-89c8-d0254ba452e7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/6/24 15:08, Claudio Fontana wrote:
> On 6/12/24 14:41, Philippe Mathieu-Daudé wrote:
>> On 28/7/23 18:43, Richard Henderson wrote:
>>> On 7/28/23 09:05, Richard Henderson wrote:
>>>> It's the page containing both code and a page table entry that
>>>> concerns me.  It seems like a kernel bug, though obviously we
>>>> shouldn't crash.  I'm not sure what to do about it.
>>>
>>> Bah.  Of course it's not a kernel bug, since the store is to LowCore.
>>> And of course LowCore is part of a larger page, which easily has other
>>> stuff.
>>
>> Maybe related to
>> https://lore.kernel.org/qemu-devel/20240611215814.32752-1-anjo@rev.ng/
>>
> 
> Hi philippe,
> 
> this was already fixed by Ilya's commit:
> 
> commit 791b2b6a930273db694b9ba48bbb406e78715927
> Author: Ilya Leoshkevich <iii@linux.ibm.com>
> Date:   Sat Aug 5 01:03:18 2023 +0200
> 
>      target/s390x: Fix the "ignored match" case in VSTRS
>      
>      Currently the emulation of VSTRS recognizes partial matches in presence
>      of \0 in the haystack, which, according to PoP, is not correct:
>      
>          If the ZS flag is one and a zero byte was detected
>          in the second operand, then there can not be a
>          partial match ...
>      
>      Add a check for this. While at it, fold a number of explicitly handled
>      special cases into the generic logic.
>      
>      Cc: qemu-stable@nongnu.org
>      Reported-by: Claudio Fontana <cfontana@suse.de>
>      Closes: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00633.html
>      Fixes: 1d706f314191 ("target/s390x: vxeh2: vector string search")
>      Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>      Message-Id: <20230804233748.218935-3-iii@linux.ibm.com>
>      Tested-by: Claudio Fontana <cfontana@suse.de>
>      Acked-by: David Hildenbrand <david@redhat.com>
>      Signed-off-by: Thomas Huth <thuth@redhat.com>

Ah great, thanks Ilya ;)

