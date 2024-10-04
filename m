Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6F0CFA749
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 06:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swc3H-0001ZV-0Z; Fri, 04 Oct 2024 02:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1swc3F-0001ZM-LH
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 02:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1swc3D-0003Mm-Rx
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 02:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728024269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=veCQknW8c7X9RGou6gaB6C4La2rZyiyIy66HwbF0seM=;
 b=MZkMSHJgzIZjtsjLW6b97KughZ4E/vlE1YBNKUQR7i03quQjPeINkjyi2vb5pmwXLuwO5V
 ByIRR0bESJgDzcc2vEkkZSqQJf+GzE9uh+PMRgS1pNjMh/Lpn1Jpa9w4R5X403GHAVgYS+
 CtUHUeKANyT+VIChzbMvLTqT+9v2GkE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-2EMRwyDYNL6sW8WwOIVLGw-1; Fri, 04 Oct 2024 02:44:28 -0400
X-MC-Unique: 2EMRwyDYNL6sW8WwOIVLGw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a8a92ab4cdbso127407966b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 23:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728024267; x=1728629067;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=veCQknW8c7X9RGou6gaB6C4La2rZyiyIy66HwbF0seM=;
 b=ItDbPsT6EeRccZ2CCwQfV0muGD6O1MewG8j7YiYqZiX7EOWZV/G+VfqM/aoRc2IMK4
 lOLq5o36906nXQWRYCSFA4WIhwc29fOg0zKccMMSmANxoPILrjFbZPVJK4F2rxKE8mAH
 Y2y2xH7rHBhWWIqECf7JPunBwuDIG2+6OkHpwcOyZyHUdgeKKfAXfpp3QLydzSF7VK2N
 NgAgpxNINt7BCvt9pCQPYTYxrU6JR0INEJscgw3Vkjwu+LmFiPJCQnDt0Yftuo9flKNj
 FfHImKLvLX3/HOwitl4hpoDfPi3gNI5jVpOSZyWz32qdDAap49yJ2BMD0gN12QFEy+I3
 zIqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5dy5d3frrP4NGIPqDP61r8sO/Gq5kYWddyi0YbZG2V8nXV84Md5rz2CODx2vwGKLSlH9zNA5khPop@nongnu.org
X-Gm-Message-State: AOJu0YxutNIGTh7XxL17ev5qDKbcDp0FExMSKYcfBw4YAswdlpW+YRhi
 T/Y3eXlM6UnNLZNiaCssXA83w2WNeJJR3+CT+C9tJxtVl1mY4UiAERmn76iCZBoiMiQUFOrVaD+
 Jq2yNmN2HN9OF14tSkOZQxZgq8nZKldcSecOTqZW59WtkQN/6oRWg
X-Received: by 2002:a17:906:ee87:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a991bce6124mr178706366b.3.1728024266937; 
 Thu, 03 Oct 2024 23:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+AetUe+KR8fROGCL+kVoI8pY8eVBohhnsuAf97wGpJbUVemskk2KRt9s5nBY6zaBCZn3N/A==
X-Received: by 2002:a17:906:ee87:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a991bce6124mr178703766b.3.1728024266456; 
 Thu, 03 Oct 2024 23:44:26 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9910287283sm180763866b.32.2024.10.03.23.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 23:44:25 -0700 (PDT)
Message-ID: <448beb47-c05f-40aa-a1a0-87ef27bfb494@redhat.com>
Date: Fri, 4 Oct 2024 08:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-9-philmd@linaro.org>
 <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
 <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
 <a14cd43c-087b-4a5d-b036-39aa6a80e691@linaro.org>
 <f20cebfe-027a-4664-82f0-3769c7047e38@linaro.org>
 <aeb88605-989b-4c26-9371-15fbe44a9e3a@linaro.org>
 <46ea20fd-c6bc-411a-b8e2-ab7179c00185@linaro.org>
 <a1a67f7c-553c-42d4-b852-2cc26e7181a0@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a1a67f7c-553c-42d4-b852-2cc26e7181a0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/10/2024 23.40, Philippe Mathieu-Daudé wrote:
> On 3/10/24 23:34, Pierrick Bouvier wrote:
>> On 10/3/24 14:31, Pierrick Bouvier wrote:
>>> On 10/3/24 13:48, Philippe Mathieu-Daudé wrote:
>>>> On 3/10/24 18:04, Pierrick Bouvier wrote:
>>>>> On 10/3/24 09:02, Philippe Mathieu-Daudé wrote:
>>>>>> On 30/9/24 16:32, Thomas Huth wrote:
>>>>>>> On 30/09/2024 09.34, Philippe Mathieu-Daudé wrote:
>>>>>>>> Replace a pair of memcpy() + tswap32() by stl_endian_p(),
>>>>>>>> which also swap the value using target endianness.
>>>>>>>>
>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>> ---
>>>>>>>>      hw/xtensa/xtfpga.c | 6 ++----
>>>>>>>>      1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>>>>>>>> index 228f00b045..521fe84b01 100644
>>>>>>>> --- a/hw/xtensa/xtfpga.c
>>>>>>>> +++ b/hw/xtensa/xtfpga.c
>>>>>>>> @@ -438,11 +438,9 @@ static void xtfpga_init(const XtfpgaBoardDesc
>>>>>>>> *board, MachineState *machine)
>>>>>>>>                  const size_t boot_sz = TARGET_BIG_ENDIAN ?
>>>>>>>> sizeof(boot_be)
>>>>>>>>                                                           :
>>>>>>>> sizeof(boot_le);
>>>>>>>>                  uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : boot_le;
>>>>>>>> -            uint32_t entry_pc = tswap32(entry_point);
>>>>>>>> -            uint32_t entry_a2 = tswap32(tagptr);
>>>>>>>> -            memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
>>>>>>>> -            memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
>>>>>>>> +            stl_endian_p(TARGET_BIG_ENDIAN, boot + 4, entry_point);
>>>>>>>> +            stl_endian_p(TARGET_BIG_ENDIAN, boot + 8, tagptr);
>>>>>>>
>>>>>>> Why don't you simply use stl_p() here?
>>>>>>
>>>>>> We want to remove the tswap32() calls...
>>>>>>
>>>>>
>>>>> I think is point is that you could directly use stl_be_p, instead of
>>>>> stl_endian_p(TARGET_BIT_ENDIAN, ...).
>>>>
>>>> TARGET_BIG_ENDIAN is defined as 0 on little endian, and 1 on big one.
>>>>
>>>> The following change isn't worth it:
>>>>
>>>>      if (TARGET_BIG_ENDIAN) {
>>>>        stl_be_p(boot + 8, tagptr);
>>>>      } else {
>>>>        stl_le_p(boot + 8, tagptr);
>>>>      }
>>>>
>>>> Maybe I'm missing Thomas point, as the xtfpga machines are available
>>>> for both xtensa-softmmu (LE) and xtensaeb-softmmu (BE).
>>>>
>>>>> I don't know if your intent is to make be/le variant "private" and
>>>>> relies only on endian_p though.
>>>>
>>>> My intent is to enforce endian agnostic API uses when possible, and
>>>> use LE/BE specific variant when it is known at build time.
>>>
>>> Oh ok, it's me who missed your point then.
>>> For some reason, I thought we were always calling big endian variant.
>>>
>>> Thus, your implementation makes totally sense.
>>>
>>> Let's see if Thomas meant something different.
>>> Else,
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Looking more closely,
>> stl_p is already correctly defined when you know at compile time your 
>> target endianness. So Thomas was referring to this.
>>
>> https://gitlab.com/qemu-project/qemu/-/blame/master/include/exec/cpu- 
>> all.h?ref_type=heads#L49
> 
> OK I guess I'm seeing Thomas point now; this series cover was not clear
> enough. The goal is to remove TARGET_BIG_ENDIAN so we can build half
> objects and do a little step toward the single binary.

Ok, that piece of information was missing in the patch description, indeed.
But the tswap function should already work with common code, see the 
target_needs_bswap() stuff in include/exec/tswap.h, so maybe this change 
here even is not needed at all?

  Thomas


