Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F68D1BDC0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 18:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81rC-0002Wd-0u; Mon, 04 Nov 2024 13:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t81r3-0002W7-9l
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 13:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t81r1-0006f7-DU
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 13:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730745066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OYto5rqKW3sM9ejpxTSGMhesPPyoIvCV2mw4Uvgchp8=;
 b=DDFTeaTfXyut2aGPWl2Xmf2hHikcpY1Jh3g7t7KPYEv5qMGwnkDa9EDSOE0QpJS8McfipX
 XoqfmZ45n2SOx3GwRJyrNCtRiJyq5tT0YxgEzGUTmFlo1ckJIRaN2xbq3QBBVWUm9aJjaO
 VpaYR/4vDY5nluSxQu3MCHc0qoHXnus=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-BBXE1a0FNBO3OlLhon1YrA-1; Mon, 04 Nov 2024 13:31:04 -0500
X-MC-Unique: BBXE1a0FNBO3OlLhon1YrA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539f7abe2e6so3193771e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 10:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730745062; x=1731349862;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OYto5rqKW3sM9ejpxTSGMhesPPyoIvCV2mw4Uvgchp8=;
 b=r3EG2mmmQ3zIgAVqLTX9wzMdy35k6pcCjEm5NeufJdc7efed2Cf5gaCxqpgbaCkYrD
 IQCmAdEFJ/pikWT/Ka0UgTZMtg9vbCHr0l0tj/dNYbpB1U24IU8hszUX90I6nDiHG0Am
 m5kY2D+mjIoX7L3zCiAeqxf0DmH8C/wiYqc+67mWdR1Uyh/pHGy+css/2NMVYAUUSsaf
 42Q9XcBpC4o+BDe2w860j+HXojm/nckeg1ymhu9DzSRsvaUm8ozSlOSj5GDtFRJ/iv7Y
 fJkimylyqSoHGsWbPxR8t1JIyXbDjy/vxS9N7hXdIU1ZyUWeuqz5QqRHRi0Ls18BOjp4
 u9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQVDvDXwZu4qtniIGRe1X8GuC1NGWziA+cyZFu4GvRKh+oJNbsBmuDZgLEbGimBMyUmNTGgLhbTU3h@nongnu.org
X-Gm-Message-State: AOJu0Yzi2/GlfjX1yFsFmMeESvvkkiGWZCSrdPhdm2riq2EW3ETuU//f
 DEYY3HVIjmfBQVb9qBld2DAjz+VduSYYX1SkDQr2JJXgo9zrPDuuMyTNGmx76qiI+ODpNlvqk9z
 bXUfYjCq++2AAgc6tHLcfCsXBr6PHDY4AzDRCZWrjrpnMHVGgnuSY
X-Received: by 2002:a05:6512:1090:b0:539:f13c:e5d1 with SMTP id
 2adb3069b0e04-53b7ed18ccemr10354457e87.38.1730745062521; 
 Mon, 04 Nov 2024 10:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlyeZn2dGzpA8uHXM+UzNzenRO6HRPz8Ey2ZYZi1EWcCPKL3Q0j5/A+GoEASpHLxCToAa88Q==
X-Received: by 2002:a05:6512:1090:b0:539:f13c:e5d1 with SMTP id
 2adb3069b0e04-53b7ed18ccemr10354435e87.38.1730745062078; 
 Mon, 04 Nov 2024 10:31:02 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983b7sm159264605e9.43.2024.11.04.10.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 10:31:01 -0800 (PST)
Message-ID: <2e8ad7dd-5a94-44ab-bcff-0526a48654bb@redhat.com>
Date: Mon, 4 Nov 2024 19:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/49] target/i386: fix CPUID check for LFENCE and SFENCE
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-stable@nongnu.org
References: <20241031175214.214455-1-pbonzini@redhat.com>
 <20241031175214.214455-5-pbonzini@redhat.com>
 <53877fb9-9261-4f65-bb60-9e2c49f572ef@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <53877fb9-9261-4f65-bb60-9e2c49f572ef@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/4/24 19:17, Michael Tokarev wrote:
> 31.10.2024 20:51, Paolo Bonzini wrote:
>> LFENCE and SFENCE were introduced with the original SSE instruction set;
>> marking them incorrectly as cpuid(SSE2) causes failures for CPU models
>> that lack SSE2, for example pentium3.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/tcg/decode-new.c.inc | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/ 
>> decode-new.c.inc
>> index 1f193716468..48bf730cd3e 100644
>> --- a/target/i386/tcg/decode-new.c.inc
>> +++ b/target/i386/tcg/decode-new.c.inc
>> @@ -345,9 +345,9 @@ static void decode_group15(DisasContext *s, 
>> CPUX86State *env, X86OpEntry *entry,
>>           [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) 
>> chk(o64) p_f3),
>>           [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) 
>> chk(o64) p_f3 zextT0),
>>           [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) 
>> chk(o64) p_f3 zextT0),
>> -        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE2) p_00),
>> +        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE) p_00),
>>           [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
>> -        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE2) p_00),
>> +        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE) p_00),
>>       };
> 
> Should tests/tcg/i386/x86.csv be modified for LFENCE too?
> (it already specifies SSE for SFENCE).

Gah.  Looking at other sources, it seems that LFENCE is actually in SSE2 
together with MFENCE. :(  I'll send a patch to clean up.

Thanks for pointing out x86.csv!  That one is built from Intel sources 
and generally more authoritative that QEMU source code, so it's very 
good for code review.

Paolo


