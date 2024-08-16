Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD58C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesIV-0002DC-HN; Fri, 16 Aug 2024 04:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sesIU-0002AY-1t
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sesIS-0004no-IF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723796815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=usJ5KAmBvcrSjbqeBdMs+li8I0Pymi39evve0RsVTJk=;
 b=KgPDnkEVFPdfcFw5kZoa1ryy2e8wx1HMr1r1VBVxyTm/AYTPlhRWGiuz5Q0zBJwpXOncrG
 TaCm/RHXwW5QtU8k2+a0AVqHX3VC6iH7k9g0pFHOh4JIe8fBHa7hDIzIJ2LrIaUXJh1ACh
 +p/irEsg4JdJSOhm8hPVUbdYXXelwWI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-_DNdE77jOLCNdDX6LC8NWA-1; Fri, 16 Aug 2024 04:26:50 -0400
X-MC-Unique: _DNdE77jOLCNdDX6LC8NWA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3717c75b265so1004498f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723796809; x=1724401609;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usJ5KAmBvcrSjbqeBdMs+li8I0Pymi39evve0RsVTJk=;
 b=Kz1TpeGa62VyjTc+Vsv4XYaQTGuC3Hm5m20IFE16azUw2+9eTRZV10ZlA6L2mb5VKX
 +ikIyqVg281eubNdyt3roIWQ3nJI3o0UeHtMw/DKHM0TIvK/GIzfzqC0CXRX18qV42j4
 8LxFM7TpnxiYOiuDELDdnygFnC1XM1lKiQ4WjKx91Aql4j35vJVEYjrbA1s1QfwmXFvi
 pyuCpPv0oZrfnRPlG5dpA79HqpBPqaozd+lPckFa4aHhfMgRS7GEjrW3cnqtqXTWHRo9
 8wTIreh4z9jqlNPEQyw1F0U6geKDBcgg3tv0kSzdbBRdmqRcqHAq6vV7lohOu2RVsRdr
 v5Aw==
X-Gm-Message-State: AOJu0YwJos/vRKRB8FF//jsz4z1FxhM0hslQusFHhaMGpGdEvfPm8VwC
 5Ft0D3VM5rVZe4jIq5xlkFuoi/5aPMFsGa03/kZVbFGbITTrUdlErBED3Y6kF9l/DslhOoVy3K7
 AiNaQjH+Edw+uJsS8i1pttyICtDr4U/RqO+J02kWWL3HdyN/8X1VK
X-Received: by 2002:adf:f54e:0:b0:371:8a90:112f with SMTP id
 ffacd0b85a97d-371946a4f49mr1401915f8f.44.1723796808697; 
 Fri, 16 Aug 2024 01:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMVJ4F1SwDqmIP+yacicCb0h7tOmflHSCvw9XcTWO7Ydh+tmCRLCguNEwgn9/1qAxu32JFpQ==
X-Received: by 2002:adf:f54e:0:b0:371:8a90:112f with SMTP id
 ffacd0b85a97d-371946a4f49mr1401899f8f.44.1723796808231; 
 Fri, 16 Aug 2024 01:26:48 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189897008sm3106214f8f.84.2024.08.16.01.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:26:47 -0700 (PDT)
Message-ID: <dc969600-ad94-42a9-8c17-5dd849843b4a@redhat.com>
Date: Fri, 16 Aug 2024 10:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/5] target/s390x: fix build warning (gcc-12
 -fsanitize=thread)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240816072218.27125-1-thuth@redhat.com>
 <20240816072218.27125-2-thuth@redhat.com>
 <ddad1d38-2f4d-41b8-a7b5-69bec00ebe02@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ddad1d38-2f4d-41b8-a7b5-69bec00ebe02@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 16/08/2024 09.45, Philippe Mathieu-Daudé wrote:
> On 16/8/24 09:22, Thomas Huth wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Found on debian stable.
>>
>> ../target/s390x/tcg/translate.c: In function ‘get_mem_index’:
>> ../target/s390x/tcg/translate.c:398:1: error: control reaches end of 
>> non-void function [-Werror=return-type]
>>    398 | }
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Message-ID: <20240814224132.897098-4-pierrick.bouvier@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/s390x/tcg/translate.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
>> index c81e035dea..bcfff40b25 100644
>> --- a/target/s390x/tcg/translate.c
>> +++ b/target/s390x/tcg/translate.c
>> @@ -392,7 +392,6 @@ static int get_mem_index(DisasContext *s)
>>           return MMU_HOME_IDX;
>>       default:
>>           g_assert_not_reached();
>> -        break;
> 
> Why aren't the other cases problematic?

No clue, but I guess we can tackle them once anybody runs into a problem in 
one of these spots.

  Thomas



