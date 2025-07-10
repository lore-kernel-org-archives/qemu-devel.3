Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD79FC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqEY-0007lT-Sz; Thu, 10 Jul 2025 08:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZqEM-0007U3-7k
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZqEB-0003lN-7j
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752149892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oZcdTKwr5VGZtAgmNu8ai1lKcazl2PBX3e6N7JXe32M=;
 b=cIiJXomeMYMLjNtkeKXHFgiL7Bi/Y+pKzSkq+qi0T1jk+FSErAggDHPIxaGa59sGBZBUtg
 uzaM7u73uCsX7zPdFLf1G8q+6JWemsDeu1U3JsiC8tGcK2mDhdmXj13Li2SvD7n1nDGxNZ
 53Nds3T3YU1RM4KwzMXB6R7osJ2GPfE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Mkd6H-BqMvWNuzr92L38tg-1; Thu, 10 Jul 2025 08:18:11 -0400
X-MC-Unique: Mkd6H-BqMvWNuzr92L38tg-1
X-Mimecast-MFC-AGG-ID: Mkd6H-BqMvWNuzr92L38tg_1752149890
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4530c186394so3232035e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752149890; x=1752754690;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZcdTKwr5VGZtAgmNu8ai1lKcazl2PBX3e6N7JXe32M=;
 b=d59BTCB4FfvpfP3tVRffTYzWdybINJ2S3xrj1wiOwanxq+8f/Ir2e5UsS5JsdtpKsu
 L/cCjM9vnMF3IR2xpHIMOamljiUkT65j7wpR6nQ22nHKTDeUSJl0GfzT9t7b4uDlIoiI
 NujW2a272GYh8tHDS48sRdgGZ+2vLBk9PkBTXu0ukduJpbdyrTb3ZtbmFRvbVANeECQo
 cfGYS2AFWuehYtW9HgRY2Uu5P1WnFuTI2WmXBkPpeFazoUfAKIVBl8VgG5ehYDYqm6xn
 dx395kVrgxagrp20G8HnlMV3z+YBpN0GiH0N3hDJtE4RDB3CUW3RRE2AvAg6gw2z1x74
 VEKA==
X-Gm-Message-State: AOJu0YyEtjXFu+QaaMTdnYA1taBmufIDwh2JwNOFg6lb5T2bVR7Qj3be
 9z2v/uNCP8uKvv4Go9ki5DcRsu0MNU7DhZIDbCaUCpFRLTDbFiBxGJj1Mz7wCdODYxX+oIrCOWU
 vEH/E99f8Jqn8G+gpLEC0tpF0wqVCckXUNTTZV8sCuDlQqBITQW+Ov9HW
X-Gm-Gg: ASbGncvNauJ35bX9ijjHKOJpH3+PFuN4u/yVZy9hK4qjLDfvYeiLB2Xu/KLaL+ckZl2
 8ugNRStR1sbPbCB+O+QplEauFcJNPqwGoy9RANMxifGvYo/nNRShte4AFlFg+elxSzNchQ7qDYg
 7g6yszMmhCnhFQK0eVduJahwBRc9OfTLcm2rvTzACNSsmM2y7gKdXhqCTQ3JvWyWuvc4KE7FXDi
 ytOCwVcwDt06gchPaw0veGwdxv2qrZEu7SiI6Nx58MfANhlXKDhPoWC4cTYGmJDm3wEK/nHzMp5
 ku8JfyDvJqKl/GLzv0CuxmKcPSjvRVt7gsvKiWwT0OUXkLX4teHaxSpy7TGOnP4=
X-Received: by 2002:a05:600c:1381:b0:453:6f1:bdba with SMTP id
 5b1f17b1804b1-454e146b67bmr4375205e9.20.1752149889868; 
 Thu, 10 Jul 2025 05:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMjQy8WsxdZS7+lhMyd7amgOkqcPwlFevggNA3gq8sHSr099uC0kRgVnY4uFwCXEjQE6pENA==
X-Received: by 2002:a05:600c:1381:b0:453:6f1:bdba with SMTP id
 5b1f17b1804b1-454e146b67bmr4374515e9.20.1752149889059; 
 Thu, 10 Jul 2025 05:18:09 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net.
 [47.64.115.149]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d575cbbfsm53755995e9.32.2025.07.10.05.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 05:18:08 -0700 (PDT)
Message-ID: <2f45bae7-cee8-40f0-9627-bd47621c69b2@redhat.com>
Date: Thu, 10 Jul 2025 14:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: Move tests into architecture
 specific folders
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250710094251.139514-1-thuth@redhat.com>
 <CAAjaMXaZEWBtQ6kV2zZEj=uzvnPnOMYPV7HgW4n0yBF=TLsRJA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAAjaMXaZEWBtQ6kV2zZEj=uzvnPnOMYPV7HgW4n0yBF=TLsRJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/07/2025 11.59, Manos Pitsidianakis wrote:
> On Thu, Jul 10, 2025 at 12:51 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> This patch tackles two issues. First, the tests/functional folder has
>> become quite crowded already, some restructuring would be helpful here.
>> Second, we currently encode the target architecture twice in the test
>> names since a lot of the test file names contain the target, too.
>> This contributes to the very long output lines when running "make
>> check-functional".
>>
>> So let's move the individual test files to target specific folders now.
>> Then we can drop the target from the file name (and thus from the test
>> name).
>>
>> Before the change, the output looked like this:
>>
>>   ...
>>   195/236 qemu:func-thorough+func-microblazeel-thorough+thorough / func-microblazeel-microblazeel_s3adsp1800          OK                2.00s   2 subtests passed
>>   196/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-microblaze_replay                    OK                2.78s   1 subtests passed
>>   197/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-microblaze_s3adsp1800                OK                2.02s   2 subtests passed
>>   198/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_fuloong2e                       OK                1.95s   1 subtests passed
>>   199/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_loongson3v                      SKIP              0.07s   0 subtests passed
>>   200/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_tuxrun                          OK                8.52s   1 subtests passed
>>   ...
>>
>> After this change, it gets a little bit shorter:
>>
>>   ...
>>   195/236 qemu:func-thorough+func-microblazeel-thorough+thorough / func-microblazeel-s3adsp1800          OK                2.12s   2 subtests passed
>>   196/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-replay                  OK                2.90s   1 subtests passed
>>   197/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-s3adsp1800              OK                2.07s   2 subtests passed
>>   198/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-fuloong2e                   OK                2.05s   1 subtests passed
>>   199/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-loongson3v                  SKIP              0.07s   0 subtests passed
>>   200/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-tuxrun                      OK                8.84s   1 subtests passed
>>   ...
>>
>> Tests that can be used for multiple but not all targets (like the "migration"
>> test) are now handled via symlinks in the target folders.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Note: Marked as RFC since I'm not that happy about the symlinks yet ...
>>         if someone has a better idea, please let me know!
> 
> How about making those tests utility functions that each target arch
> imports and calls? It feels cleaner than symlinks, I think.

That sounds better, indeed. I'll give it a try...

  Thanks,
   Thomas


