Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA0CD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 15:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSzQk-0006Ow-Fw; Tue, 09 Dec 2025 10:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSzQi-0006Ol-Cy
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:15:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSzQg-0006On-3I
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765293304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BugGfCnyLtxYAljDefcCsPsQKbnlSy5SGS67fqrnUnY=;
 b=EooFVsOexvHAHtUP0hnfiwyY170BrmZPo0R9+PqjiowQ1B+7urp6xsB5ZWCOGzF3kZjE6C
 xOQwfmwr0DKmjtSJpKzA6xs2xAsxVEjoRFdMbGCWIjt/5lOH7fxy/ubCwEU5uCUpgTXxYZ
 EqoNcxQpx1D8FHn6ygr0tEahOP5khHQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-I-m7aTP1MYmBCzNn-4Ua4g-1; Tue, 09 Dec 2025 10:15:02 -0500
X-MC-Unique: I-m7aTP1MYmBCzNn-4Ua4g-1
X-Mimecast-MFC-AGG-ID: I-m7aTP1MYmBCzNn-4Ua4g_1765293301
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42e2e3c3e1aso2840833f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765293301; x=1765898101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BugGfCnyLtxYAljDefcCsPsQKbnlSy5SGS67fqrnUnY=;
 b=k8Bs5RKUYtZH/ZrWx7qGdFUM/vNEBLRK3z2xQKRqDvzFuKL7eCV9eCt5oENpEfRx2q
 WUfLFNsDcVriVlXordrBZs84DC78KVov1R7b/ZUmQwZI46ppQ8eyoHkEKn3UacNx8bRT
 Rb+WGZeK5By2+S8FB5ZOOJQtHPYl+iln2nO6xqp5sgadap6xJFTrgSiqBLeTrI2KWQcC
 jEo9G8tDFC5SvBpMZ00GjE4hX+WKdUm81t4n7wmvdOc85nHt21FbyOUiy2TXVC8rsOsB
 yz8uESnSYVCGYxwag7FaZHUz+ilA+lJaDUns8YDPm/GMz+mCwy728k/UfpbYdkXaJhBz
 TXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765293301; x=1765898101;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BugGfCnyLtxYAljDefcCsPsQKbnlSy5SGS67fqrnUnY=;
 b=uLWfa4DSJF/Kqm/1gA+GetQG3TVm8bAZKD/ZxJywQH1SwRjf3xLqgBkC9jxGj+nlL7
 ccvlqn27Nemvcnm8CaPSTDOkUIkAeAX5WeNGTtrLtz3BjwVr6ipvU90XmgGP2vkQzS65
 FJXD1IsTSZ/Py/QnQqCIHBCOewFamcHYCeajqdWWiO5ZkaE7JXC8YZMzKZ3kLl9Y8cXv
 fPmrSxzTPEDjl9HuHNoFAY2Bv+g0vc0qqEoo6YhIkO4XdLuf9uigZEwuvATZnZ1AQ1Fl
 7+0k3hbC/ivq8wQaRRqpOhQ8o1y1CIO/AlutZPDGp/dx7W/6U+xEhzyVmnbzIeTNX2ia
 iY6Q==
X-Gm-Message-State: AOJu0Yz9/O7rDcueJc/2ScudtK/pEnFGkMoTyuzsotI/G0FIrFN9JmJ7
 GPuWQq2Mf3pcoYvTG1I0t3DGBWd5RD7gTVMWjXXFEun2b2BXriQr0Qk/EkIBdOAFGGOBKqN/LUO
 BGDetakNI9/NFsqNGMujleWO2diSdDgFB+70zcYvzgRM6Y3+t9cOZ18uM
X-Gm-Gg: AY/fxX55i1EzdSb3XxfRkRogfCCIYxq9p3El5gGg1DdQeixLXFKU0E0vWvmX64HN+m7
 a7fHDyiNH6vocry281Bnuu31SUjBTzkRfy2SSDzVjN0BLPojtxu2bFXX+KUmyQ7GDk763kiPfYO
 hN98i9lQgjHHURfBao8coxqCnlLuBhFtIHmxiUbdI6GHzClf2bM3q+y8yxVRURMn1cLAn0sgRaR
 6vo99YIICWEEIz0BjOU7JxB2zoFu/y97s56X9GY5dd5+tl7x9Q6gx1JbAnVUCcMQJUxt5Q8QFOL
 lKYwKB8vghHmtfsOo2N6p+gcmnS6VMF9dANcR61RD3zxLmd2vpWXpV0pdgxKZ6sXKBWZKcbyFOt
 TxrHNKJ9Dx9VvWDezbApJ7EH0l+wWR+BCYtTi5iIR7lpu6VTD
X-Received: by 2002:a05:6000:250a:b0:42b:3ad7:fdb3 with SMTP id
 ffacd0b85a97d-42f89f0f37amr12262378f8f.4.1765293300854; 
 Tue, 09 Dec 2025 07:15:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm3FPE9zWloEHI7NVbId+ZB4EtTS64clEYugajDf+6ZRewMV2NBWYJXVW5bMBU1KpoJehmiA==
X-Received: by 2002:a05:6000:250a:b0:42b:3ad7:fdb3 with SMTP id
 ffacd0b85a97d-42f89f0f37amr12262349f8f.4.1765293300378; 
 Tue, 09 Dec 2025 07:15:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331af5sm30862578f8f.31.2025.12.09.07.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:14:59 -0800 (PST)
Message-ID: <aff82e66-035d-4e53-962f-3bac9f160d90@redhat.com>
Date: Tue, 9 Dec 2025 16:14:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: Fix result of strstr to 'const char *'
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20251209150346.650473-1-clg@redhat.com>
 <CAFEAcA_q9LJAWu5wL4AosoHJqVLpnU6PDmJPj4U3Zfy1jh1F7w@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA_q9LJAWu5wL4AosoHJqVLpnU6PDmJPj4U3Zfy1jh1F7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/9/25 16:07, Peter Maydell wrote:
> On Tue, 9 Dec 2025 at 15:04, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> Assigning the result of strstr() to a 'char *' is unsafe since
>> strstr() returns a pointer into the original string which is a
>> read-only 'const char *' string. Newer compilers
> 
> Which ones? Or does this depend on how the libc headers have
> marked up the strstr() prototype?

Right. This is a new issue and I am not sure why.

It's showing on :

  gcc version 15.2.1 20251111 (Red Hat 15.2.1-4) (GCC)
  glibc-devel-2.42.9000-14.fc44.x86_64

and <string.h> doesn't seem to have change. Both strstr() prototypes
are available.

Let me check.

C.


> 
>> now complain when the
>> result of strstr() is not a 'const char *' :
>>
>> ../util/log.c:208:24: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>>    208 |         char *pidstr = strstr(filename, "%");
>>        |                        ^~~~~~
>>
>> Fix that.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   util/log.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/log.c b/util/log.c
>> index 41f78ce86b2522b8b7072c8b76d8e18603142db6..c44d66b5ce78338cf1b2cd26b7503cb94d4570cb 100644
>> --- a/util/log.c
>> +++ b/util/log.c
>> @@ -203,7 +203,7 @@ static ValidFilenameTemplateResult
>>   valid_filename_template(const char *filename, bool per_thread, Error **errp)
>>   {
>>       if (filename) {
>> -        char *pidstr = strstr(filename, "%");
>> +        const char *pidstr = strstr(filename, "%");
>>
>>           if (pidstr) {
>>               /* We only accept one %d, no other format strings */
>> --
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


