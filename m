Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D7EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 06:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seq3r-0002tv-Si; Fri, 16 Aug 2024 02:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seq3q-0002sr-4D
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seq3n-0001o4-0v
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723788217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mXZ8blkWa4VY892jdfLM88sQkt9exDuGigRQvWH6ZYw=;
 b=Ba4VT5F8UnCbghCWbadARgcrjIy9wR7ClnteT5arnO91rT+Uu17GCScE/VlFQa+kRkGGTi
 egzong6Ez9eulMHRIos0G8bzmqAuuxXuCeCgmdncM55y7iLTka5rnC9rSv70Rg+QVg+9mi
 v/+RRViDaGI1Orpbpyuy+OaPkHyV3Aw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-tPLveLCWPTKAoaV8xPGKZA-1; Fri, 16 Aug 2024 02:03:34 -0400
X-MC-Unique: tPLveLCWPTKAoaV8xPGKZA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3718bf7d54aso676544f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 23:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723788213; x=1724393013;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mXZ8blkWa4VY892jdfLM88sQkt9exDuGigRQvWH6ZYw=;
 b=AeZJNGT5yzmw056tHrAjlClePOBnfAB77R1QfFS1XA8ow2djetrA02O5q982FRSl4c
 9cjx1GNU2lvI/2GLLrFUAxVivaBX4zActbxZK2/ROgt3po/9xweEwa+40g7OXzNv14VX
 4gVRaQPPgB54Qje9LDaJpcG88Iy/ludKAvksx0ciObQCarKU7nyHc/u09ASJ41/pvquu
 EumDYaLHLfgOvlOexPKNdSu3H1A8g7Y8DmJhI3zYy20x0KHf5MxSUcVb0ODmVR52Fefu
 AFJdvdwb2luitVRzkyZjdJWnVuC8YtwBHhx2lvjBGogCRXug/iyeA4SPT5aQa8fRzJU4
 ApeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzDBUxPz4g+vmsK1A35oiMUQnAWCrPOYCFR6ZciQ+8uiZd6SXpoUJJVQEG/8w3/B44lmY+BsSItfmL@nongnu.org
X-Gm-Message-State: AOJu0YwKR8K8L4a8iDOHfs9zsKoefH4B+ou1xvcygXyw2fbzzkak8KCX
 7tOSgyG7E9rafe/9/VLPUoeENqReGEMVcOC8/ub40G6JB251MfWNMd5mZyiCYUReW/CHt01O0RT
 Cujg7IdTDB6dfcZYx7Kmgw/K4DP60FgfK/OSC0VWkiffa7BNM8Yi9
X-Received: by 2002:adf:9bc3:0:b0:367:35d7:bf11 with SMTP id
 ffacd0b85a97d-37194455af1mr934270f8f.25.1723788213524; 
 Thu, 15 Aug 2024 23:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkzEOOzuQbQ6stsvFKLKV0TfM86rAjD1NTah4g63wtntyFgHQCb+J+OXnzvksx0tAHYDniFg==
X-Received: by 2002:adf:9bc3:0:b0:367:35d7:bf11 with SMTP id
 ffacd0b85a97d-37194455af1mr934247f8f.25.1723788212783; 
 Thu, 15 Aug 2024 23:03:32 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718984993fsm2871482f8f.31.2024.08.15.23.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 23:03:32 -0700 (PDT)
Message-ID: <b777c2ac-a65d-41a4-936f-f2dbe7f0a1ca@redhat.com>
Date: Fri, 16 Aug 2024 08:03:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson: Use -fno-sanitize=function when available
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240729-function-v2-1-2401ab18b30b@daynix.com>
 <904ecb53-afdf-4818-88c8-8036366e3d62@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <904ecb53-afdf-4818-88c8-8036366e3d62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/07/2024 01.54, Richard Henderson wrote:
> On 7/29/24 01:44, Akihiko Odaki wrote:
>> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
>> -fno-sanitize=function in the clang-system job") adds
>> -fno-sanitize=function for the CI but doesn't add the flag in the
>> other context. Add it to meson.build for such. It is not removed from
>> .gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
>> does not affect --extra-cflags due to argument ordering.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> Changes in v2:
>> - Dropped the change of: .gitlab-ci.d/buildtest.yml
>> - Link to v1: 
>> https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
>> ---
>>   meson.build                | 1 +
>>   .gitlab-ci.d/buildtest.yml | 1 -
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 5613b62a4f42..a4169c572ba9 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>>   endif
>>   qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>> +qemu_common_flags += cc.get_supported_arguments('-fno-sanitize=function')
>>   add_global_arguments(qemu_common_flags, native: false, language: 
>> all_languages)
>>   add_global_link_arguments(qemu_ldflags, native: false, language: 
>> all_languages)
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index aa327824052d..d83e50abd933 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -430,7 +430,6 @@ clang-system:
>>       IMAGE: fedora
>>       CONFIGURE_ARGS: --cc=clang --cxx=clang++
>>         --extra-cflags=-fsanitize=undefined 
>> --extra-cflags=-fno-sanitize-recover=undefined
>> -      --extra-cflags=-fno-sanitize=function
>>       TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu 
>> s390x-softmmu
>>       MAKE_CHECK_ARGS: check-qtest check-tcg
>>
>> ---
>> base-commit: 93b799fafd9170da3a79a533ea6f73a18de82e22
>> change-id: 20240714-function-7d32c723abbc
>>
>> Best regards,
> 
> Doesn't work, because --extra-cflags comes last and overrides it.
> 
> I think we need to drop -fsanitize=undefined from --extra-cflags as well, 
> and use --enable-sanitizers.  I think it should be ok to leave 
> -fno-sanitize-recover=undefined in extra.

That could be a solution, too, but I think the change in meson.build should 
then also be moved to the spot where -fsanitize=undefined is added.

  Thomas



