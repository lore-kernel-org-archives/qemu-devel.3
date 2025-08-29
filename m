Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3993BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNE3-0003dO-VK; Sat, 30 Aug 2025 11:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1urw0P-0003if-0o
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 06:06:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew.cooper@cloud.com>)
 id 1urw0M-0005hE-M2
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 06:06:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b7d497abaso9332775e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1756462002; x=1757066802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NnHst8fQ5mRv6zK7zD6Olwvh2vi7kOV/xIF1vaOH5VE=;
 b=eJHmcsNbJWL4H0jvW3gQda+T/dQbtBzclc7efDzvXO+iRl0Iu/8RP1VmPDHq4R8azy
 Yn6T5Kfq4qZSVati+LwFHla9U4KbnFUwj3+88mMOmBmW9XbLLA2K0LEHu21+VSyfekcK
 pQdmlfeDpIfqTMQrDoXOc4VlX07O4ZAwdGXoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756462002; x=1757066802;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnHst8fQ5mRv6zK7zD6Olwvh2vi7kOV/xIF1vaOH5VE=;
 b=VFPIaPd9Y1yhlEk3a5aL/uN6DdPj3ivwK9fJ2uEKByJiOxDTZtUf8nk6RhLsEwNf47
 dmg8i6UUtyBChlIvAbDfMA5SijjSDZLJLptr7SSrVqc7LfiHRFW8R+dQ5h4smhm4Y6IQ
 zY2sSR37DQPWDOs+oGqtZD8hBmghA+HFkoD9MdFnct7MRaAY9MrfolTk1JlN0PeaqvoS
 0MwfgywM95kIf8ASyp035JeKM8nfXAHbLzEzM955WfDqH/MTYKuhs60JinEto7/d35kj
 noPt3ck5eRF+0YKHZ8TkddcivFSxL4LhdKb10AuOBOi4jNkJPc4Zrr01vVgjFpXWOkgw
 oLWg==
X-Gm-Message-State: AOJu0YyOkR3Zwb+6ETQPtkoozq7HG+8LCCpVkcg7Zidp5gqRfKliQVSF
 Pwc4XtHT2sF3c2JlkqO3S31v0+RXkVhCB4nkXqxUXYlxXjfqcSQFLi7JC+5oQE+9NCnksSPKmXS
 BYCSb
X-Gm-Gg: ASbGnctBoXNJgksti2Sfez2iPpIwJatrPr4BPOi9RNfnYdxAPa70fwVk4AnAf4UkGt+
 Zs6hlRmHiX8q1gjfrWcmLTX6tjpKQ5XiZbrNHABweo+lYY6juJEJgI+vzUgPP6uTy+wPiSUFi9u
 4/7QOQtyomDKRXc+48jPKwdYAiq7GwA+LxqiZ4fFub+R5rcO04JvZ02xrlxaC+JzhaN1lSlr1O+
 jrzp9h7mviGoakmzaB6BMxsV4Azq6HpwpIx31ONNVdxVR61Uj5QB/Jr8WFcXmX/xek4SBS+ywNp
 jJz39O88ieehokQn/1sq+jpco6+YYxIdF5cETs0tAUyq8oBNMq4wvgyc8QtH3yxzAqhQBT2QkSS
 HlJfSRvFnVWsBKgtUPsUCPkocn/tuOdSYfe9Vr4yIInD9MSt59A9QtPW96scjSj6P2+YwcPXypi
 KBFdU=
X-Google-Smtp-Source: AGHT+IFaF3Fp1aTZ/GsrQhMLanNiao9KvZ+tiwb0q6lP/rvnopgS3uE5iyNsWeoMR2Si34FZ8ZlarA==
X-Received: by 2002:a05:600c:1e8a:b0:45b:47e1:ef74 with SMTP id
 5b1f17b1804b1-45b517df2f9mr224657515e9.35.1756462002161; 
 Fri, 29 Aug 2025 03:06:42 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net.
 [195.149.20.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d204asm2783653f8f.24.2025.08.29.03.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 03:06:41 -0700 (PDT)
Message-ID: <3ea1f256-4ac6-407c-9fc3-d5acfd517459@citrix.com>
Date: Fri, 29 Aug 2025 11:06:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PING ^ 2] Re: [PATCH] target/i386: Fix #GP error code for INT
 instructions
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>
References: <20250312000603.3666083-1-andrew.cooper3@citrix.com>
 <7d9801e5-5be1-42db-a6db-92e89ab11f1d@citrix.com>
 <2217b23a-1b99-4471-9983-74cee9ca09f7@citrix.com>
Content-Language: en-GB
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <2217b23a-1b99-4471-9983-74cee9ca09f7@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=andrew.cooper@cloud.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

Trying some other x86 maintainers this time...

~Andrew

On 25/07/2025 1:01 pm, Andrew Cooper wrote:
> Ping again?
>
> ~Andrew
>
> On 20/05/2025 5:32 pm, Andrew Cooper wrote:
>> Ping?
>>
>> On 12/03/2025 12:06 am, Andrew Cooper wrote:
>>> While the (intno << shift) expression is correct for indexing the IDT based on
>>> whether Long Mode is active, the error code itself was unchanged with AMD64,
>>> and is still the index with 3 bits of metadata in the bottom.
>>>
>>> Found when running a Xen unit test, all under QEMU.  The unit test objected to
>>> being told there was an error with IDT index 256 when INT $0x80 (128) was the
>>> problem instruction:
>>>
>>>   ...
>>>   Error: Unexpected fault 0x800d0802, #GP[IDT[256]]
>>>   ...
>>>
>>> Fixes: d2fd1af76777 ("x86_64 linux user emulation")
>>> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
>>> ---
>>> CC: Paolo Bonzini <pbonzini@redhat.com>
>>> CC: Richard Henderson <richard.henderson@linaro.org>
>>> CC: Eduardo Habkost <eduardo@habkost.net>
>>> ---
>>>  target/i386/tcg/user/seg_helper.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
>>> index c45f2ac2ba68..ff328b2a9522 100644
>>> --- a/target/i386/tcg/user/seg_helper.c
>>> +++ b/target/i386/tcg/user/seg_helper.c
>>> @@ -64,7 +64,7 @@ static void do_interrupt_user(CPUX86State *env, int intno, int is_int,
>>>          cpl = env->hflags & HF_CPL_MASK;
>>>          /* check privilege if software int */
>>>          if (dpl < cpl) {
>>> -            raise_exception_err(env, EXCP0D_GPF, (intno << shift) + 2);
>>> +            raise_exception_err(env, EXCP0D_GPF, intno * 8 + 2);
>>>          }
>>>      }
>>>  
>>>
>>> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32


