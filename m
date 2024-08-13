Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9E0C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdspR-00064P-OG; Tue, 13 Aug 2024 10:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdspQ-00063v-Bo
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:48:52 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdspO-0008Lc-Ha
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 10:48:52 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d396f891c4so609095a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723560529; x=1724165329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iIfn1PUGLWHZ41vvQ20DL6OO3Q7Zwf+LfbVCdqoPBec=;
 b=FtR3xrgMu+YPZQdJ74PsGXt7Q9ymIr5j8Zgs7l6HTNjey/JAabXHUbiT70cgibhNAs
 CI3jG1Wol0y4Ps0UMmKPNo5EWkFsxvvUOSyfC7yTbQJNuPz205ivBf9A0TONU7xF1xyn
 /SMqv7jnQ0fmELNmDOK/f/NH+Nrjzu+HXm8fgte/sf3nDTfiopVonaSfv/GpZYTFio1s
 ezo2nPcA87bGVZPrqcoW2i8OqhSosk8vEeB3vKiLAby2IP1PvKf+Q0u0sp3cblv9pJAF
 Hrfvzv3GooMnjT9hdSbmi7hsjzjQknDxS3j9IqZZ0UjLq9jNoGzVEAXAb0FEzbpN0nkA
 MdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723560529; x=1724165329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iIfn1PUGLWHZ41vvQ20DL6OO3Q7Zwf+LfbVCdqoPBec=;
 b=HdPJVnHw/pt+BE4cAtoGIO5dwJml/HhQvxGA7gFd42XrLsxQz5ilTDitcwGjb4v1R9
 VBjOAHBMsxCNIydqLgxzsOZbz/1YnjCyfHZjizwfEMW8PT4GrLFpgzrf9pYidoTqMGMI
 wcogJ4io1Djn8LDPK2KR6bcY5llodL2LQElTHHk114VuA6CKfadz+F76//7wc3mMjWfI
 EO7lq3eHokgWBo6f/IGPO5sZ1Lcs8mdXSzZjt8EfWEdiOGtWW8SsKsPgEfSrHAN8hK2q
 qnK2v5LlS0aRSQkL7XdtVsealstvdNekI/iUrU4oP/T7vo1ZRUfSlofUEiCJSbm3X3CG
 QSVw==
X-Gm-Message-State: AOJu0YzLlPBNBwUHQBiwEGUWR0oAeJBtojy+PfcYabEIGxgXFs9vtEOM
 0DS3hVGvOo4rWixolkdAX2x6UbEOAx+4RNslfmzxko3KhwNjz4XgYKB1mV/EWqY=
X-Google-Smtp-Source: AGHT+IFxVUCYtVZ5xuG5DQL+B7S4R2Jnk0sr0IA5ARqgwz9CBeYCfRroi7/CIwm4/OWLSw8ozAZorA==
X-Received: by 2002:a17:90a:9f85:b0:2cb:f9e:3bfb with SMTP id
 98e67ed59e1d1-2d3926236e2mr3905689a91.32.1723560528746; 
 Tue, 13 Aug 2024 07:48:48 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9c7ad59sm10677962a91.13.2024.08.13.07.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 07:48:48 -0700 (PDT)
Message-ID: <21732587-6fc8-4161-aead-c2ef579be486@linaro.org>
Date: Wed, 14 Aug 2024 00:48:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: allow access_ptr to force slow path on
 failed probe
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240807160236.2478459-1-alex.bennee@linaro.org>
 <3fb9f760-4eaa-4a81-a500-89d340fc1376@linaro.org>
 <87sev8a7nd.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87sev8a7nd.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/13/24 23:12, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 8/8/24 02:02, Alex Bennée wrote:
>>> When we are using TCG plugin memory callbacks probe_access_internal
>>> will return TLB_MMIO to force the slow path for memory access. This
>>> results in probe_access returning NULL but the x86 access_ptr function
>>> happily accepts an empty haddr resulting in segfault hilarity.
>>> Check for an empty haddr to prevent the segfault and enable plugins
>>> to
>>> track all the memory operations for the x86 save/restore helpers.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2489
>>> Fixes: 6d03226b42 (plugins: force slow path when plugins instrument memory ops)
>>> ---
>>>    target/i386/tcg/access.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>> diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
>>> index 56a1181ea5..8ea5c453a0 100644
>>> --- a/target/i386/tcg/access.c
>>> +++ b/target/i386/tcg/access.c
>>> @@ -58,6 +58,10 @@ static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
>>>          assert(addr >= ac->vaddr);
>>>    +    if (!ac->haddr1) {
>>> +        return NULL;
>>> +    }
>>> +
>>>    #ifdef CONFIG_USER_ONLY
>>>        assert(offset <= ac->size1 - len);
>>>        return ac->haddr1 + offset;
>>
>> You need to remove the test_ptr macro below as well.
> 
> So we fall-back to the slow path for linux-user as well?

So we don't ignore the null, and dereference it anyway.

r~

