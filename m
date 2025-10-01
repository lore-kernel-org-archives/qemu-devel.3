Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD17CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zcT-0000nR-8V; Wed, 01 Oct 2025 12:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zcN-0000ll-5Z
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:23:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zcB-0005kC-2g
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:23:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso46676435e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759335811; x=1759940611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VsyErOj0C4qTR0dhaSEh2ia15dVXw2WZRvV5/OWw62I=;
 b=Rp2+eXDETiO4RXtuEAbadvQ3UXRjyTJFfKQVPCNChl14wpSgpURAoRyz+XvOdk5lng
 8/UY0wy1fUA12ILNY9K3ZD8KC6N+83VeANd7CYUNLqc63I2X3VuuOPJEIyodq8XcAIGB
 sn/FHvWLTiUoGcIjE8lQVmZZ8TRGC6GQEV+1u55fxq2X7m5XlZhMn7Y5tGvdzqQQSKYU
 pJzXHllHcnTw/wyT2cYo0HBXxBCj2UGsXtLqkTbV2AMLf3l2Foa26ATIrxlqeRYrdH8X
 zA3Z4mkrzmIG02eP8IZjjpkBH5GGYChMZTrFsuQDC84YAlN1EiKhgpTEy+RO7dofHm04
 5o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759335811; x=1759940611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VsyErOj0C4qTR0dhaSEh2ia15dVXw2WZRvV5/OWw62I=;
 b=cq8pvdhYacyrNGZ6cx0ucPEba9If3hVDKEZksMAVUpHTtpPBH46zArSap5eygSXT8f
 Nf2BeK6X7tVIvN9vwb9f3JPTF9D0SzI6Wo7OTDZCpkfq8jozoJwRLkJXXkLJnpp6oVa0
 t2w9DSqNBCE7rcVUNgObuyiFkbZdtC5V1tHjhBG2N7GoiZjSZEEWocaAKdIeZOYmiaKA
 WJM6P3woqjF0ofFpYjcYO/lVqZyreRbXBc9RUe5H3ST0G4KtBXurJuExh7FWDhn3h0lN
 YmluT8ZZKmDahcCun8hrYk9xH9xYnOuz4W3N6puM+HS1yRsuOBcgaszdW7BvjXgp96Sw
 3BLQ==
X-Gm-Message-State: AOJu0YywNeOZIlpvRi4nMvpwpfHPeBdjH8sVRgdz12UfHIoNDv7+HuZM
 U4Y/yGqzhR56SzwtfOpzB4v7qr2CNeBIMY4Cx1iO3hpllIhcQPvc2BINV197AsKJ1Dc=
X-Gm-Gg: ASbGnctDwaTFDrZ+dna4IvUjbeKTMpVSaEJHLD6SpKlZ5fGZDZKhWJ1KYsNlmRp+9BZ
 SlJ0AVJbOuYVoKgUJ1r+f2V2til9Jd6sRfZVJSsB1YaKlS8U20Q3xkCfzjUWjRi5+tLMuY5KwcH
 zAqBfvffuhwC8Fn0QkBcY7HoLuijoP08fHVv8qPbiEW2DIdJ/glKeSg6Fm1Bt4smYG/HRU/SWYJ
 LipVhFCM9CyYYzyACoxr7gZEJoWJc2SxMnxdWot4YrYRry/zago5RpSzAO/6qCUNxhdQvX/Hh8v
 v0ScIkyOkx5JHTiWOsh5R4V6CmACrgq/P/ftmuVf2hlvNhOJGeLEZX95Njxh+GWy1wZsjvWfSQW
 LwSHE1ArSOKVwSz1izg68KxM0WeoYmRpY5E4m8xZzWPL+QNawSJUdSwTv5yLQe8z29Ljvv2Jn28
 31gSSvjrEFxUwOJg==
X-Google-Smtp-Source: AGHT+IHeoZu0ymi8Pfk0X0YHUUowtYfUT6O7ZFYxwRepAEs318Ow0exFrX3Q4sJq+PIpUItFz2JAAg==
X-Received: by 2002:a05:600c:c4a4:b0:46d:996b:826f with SMTP id
 5b1f17b1804b1-46e612dcfd0mr38375745e9.25.1759335811038; 
 Wed, 01 Oct 2025 09:23:31 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b86e1sm44201225e9.5.2025.10.01.09.23.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 09:23:30 -0700 (PDT)
Message-ID: <0c60b6e7-9e87-49aa-b00b-751c038ab8fa@linaro.org>
Date: Wed, 1 Oct 2025 18:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] monitor/hmp-cmds: Get cpu first addr space with
 cpu_get_address_space()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20251001150529.14122-1-philmd@linaro.org>
 <20251001150529.14122-4-philmd@linaro.org>
 <2b87c3ee-2b25-bea5-3f73-bd089848d19e@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2b87c3ee-2b25-bea5-3f73-bd089848d19e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/10/25 17:35, BALATON Zoltan wrote:
> On Wed, 1 Oct 2025, Philippe Mathieu-Daudé wrote:
>> In order to remove the convenient CPUState::as field, access
>> the vcpu first address space using the cpu_get_address_space()
>> helper.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> monitor/hmp-cmds-target.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
>> index e9820611466..602af851328 100644
>> --- a/monitor/hmp-cmds-target.c
>> +++ b/monitor/hmp-cmds-target.c
>> @@ -128,6 +128,8 @@ static void memory_dump(Monitor *mon, int count, 
>> int format, int wsize,
>>     uint8_t buf[16];
>>     uint64_t v;
>>     CPUState *cs = mon_get_cpu(mon);
>> +    AddressSpace *as = cs ? cpu_get_address_space(cs, 0)
>> +                          : &address_space_memory;
> 
> Why move from local scope to an upper level?

Out of the while() loop to call it once only.

> 
> Regards,
> BALATON Zoltan
> 
>>     if (!cs && (format == 'i' || !is_physical)) {
>>         monitor_printf(mon, "Can not dump without CPU\n");
>> @@ -174,7 +176,6 @@ static void memory_dump(Monitor *mon, int count, 
>> int format, int wsize,
>>         if (l > line_size)
>>             l = line_size;
>>         if (is_physical) {
>> -            AddressSpace *as = cs ? cs->as : &address_space_memory;
>>             MemTxResult r = address_space_read(as, addr,
>>                                                MEMTXATTRS_UNSPECIFIED, 
>> buf, l);
>>             if (r != MEMTX_OK) {
>>


