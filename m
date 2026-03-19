Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADF9FB5EAA
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w345b-0003B9-Or; Wed, 18 Mar 2026 23:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w345a-00039v-M6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:30:26 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w345Y-0002aL-Rb
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:30:26 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b061b6cf36so3726585ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773891022; x=1774495822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DZc2ChIXc8q9z7Fj4uHRAPAWn+sl4dum2FV6pn0DdXQ=;
 b=jHfoAPM+6KG3JzWzqE4jj4Vq1IaG6EoElbdgNkjTz1Uird/LMNTzgpCjcQndE5FW/V
 do/rZ8b/RPQ6RnKmRtH7UgH1vwbIUwDJ1TOg9Q0N4K/u3qwPX4/EsL5ahAQN5hDxiWjW
 k9mMQ5E+w7B4xD7PUaKMpFK2UXwLxAHz1oLxr5RmDyZCq+lnbe6OoL8L4p7HQjVbINC4
 Igx/RmYy0CP3uGSCXkJMjHX5cngOxhojbPqcOJnuEPb69z0YFZ9PktJNy+5s4juY1I/N
 efNPlnkDXYrT4nghWPPNQVn7GKoreKVnvrb+zP+5ER+EBdBD5cmNdEfLJFBeAfY7NoiI
 LkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773891022; x=1774495822;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DZc2ChIXc8q9z7Fj4uHRAPAWn+sl4dum2FV6pn0DdXQ=;
 b=GWOlGkXF7oTamSe+e/yzPqbSOmKjOjFbOLuw0pZqHH8su2bXT3KdmGw5j/P+fklCM9
 4VhZm3P9ZbnK15+VSijIccvhL96WEAlpMP+8iFqFFj92cN8tykVysLoJvdT3lSiw7bX2
 luZoEZwlzDBaQLD8dK+yoTHPbv3pCPCWi+q6MIPCGIk81SBNOVKIJwAvUeUVTegv+ZOi
 l7B2vwjdvxAXhcgRc9pXypz9WFUHYRYcHQO1zugBUXjvr1kQ2nnTMTAlWU2jVvnX8kJ5
 EdSzM1E/zrhalE4ZP7RGxdb2ysx06QAOjn1pw+FIbGJFlmAvPjEJIJEni9Axy2p3H0t4
 975w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6YznDcFwxEfG1Ra4A+BCb/gzRAQgDOUOyLvO/P54iSVGiofcL2WzmY6aV0/qvZ2vvxvMg8dxLCtK1@nongnu.org
X-Gm-Message-State: AOJu0YwJSUkr52INwsW4ZITkq+CrjxwI2kL+t6V44xrmOtNWt+34sOrW
 9oCZinWpV4YhUp5XkkIh2sUPyaDZVPew6mp/rJV1gbZlNE0ZKx4xKgQm9qcQTHOxtuY=
X-Gm-Gg: ATEYQzw7QQucuUWEXyhzfzH238KwIjdcEiwMyqhDyEZZib6zq7jWaF0iaETqK9Qwmuv
 BajslsincruzLROZSv33z1rnvx2h//bPn4i7Bu9KQ4RSraJgM5qYhu4lnZUOP5M8vvOWfY8vCo2
 QAGsF1nlDsXeqPOrZtMZjb7VxLynoHnniCb5th3wcZAi3JxzRJhXx3zjA2nKloX5oXBaIbciWRO
 gya/51d/To2dTLroqstOeoe47A0A1JISAT8okCDigX4STB0QbSYajLv1B/G4RmlCwFKGzKwkrqH
 FURPWjbCBI9Zcch7HTvT5pjG8jnbbjhU9nyS3YV8er8R+IR0y82SuxRz4COlOawXX6Mo6ESJ3wK
 KFrKBOsxR9/pYcWjnhyFC/M6YRCOM+AFDqRfI9qCcMyDWy86I3PsVVn99PwKq7BBFV6L15sbtMs
 HY3tqJ6blPHpYI1konZXJqV6sxI1fE2pjhn9+wGf7NG66jGQ==
X-Received: by 2002:a17:903:1986:b0:2b0:4579:adc with SMTP id
 d9443c01a7336-2b06e3c5e85mr58459885ad.33.1773891017589; 
 Wed, 18 Mar 2026 20:30:17 -0700 (PDT)
Received: from [10.5.0.209] ([114.23.167.13]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5ef3c6sm44066615ad.43.2026.03.18.20.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 20:30:17 -0700 (PDT)
Message-ID: <8d76a679-4d7c-4c3b-80d2-11799dc98fdc@linaro.org>
Date: Thu, 19 Mar 2026 16:30:11 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/i386/signal.c: Correct definition of
 target_fpstate_32
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260305161739.1775232-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260305161739.1775232-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/6/26 05:17, Peter Maydell wrote:
> Our definition of the target_fpstate_32 struct doesn't match the
> kernel's version.  We only use this struct definition in the
> definition of 'struct sigframe', where it is used in a field that is
> present only for legacy reasons to retain the offset of the following
> 'extramask' field.  So really all that matters is its length, and we
> do get that right; but our previous definition using
> X86LegacySaveArea implicitly added an extra alignment constraint
> (because X86LegacySaveArea is tagged as 16-aligned) which the real
> target_fpstate_32 does not have.  Because we allocate and use a
> 'struct sigframe' on the guest's stack with the guest's alignment
> requirements, this resulted in the undefined-behaviour sanitizer
> complaining during 'make check-tcg' for i386-linux-user:
> 
> ../../linux-user/i386/signal.c:471:35: runtime error: member access within misaligned address 0x1000c07f75ec for type 'struct sigframe', which requires 16 byte alignment
> 0x1000c07f75ec: note: pointer points here
>    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>                ^
> 
> ../../linux-user/i386/signal.c:808:5: runtime error: member access within misaligned address 0x1000c07f75f4 for type 'struct target_sigcontext_32', which requires 8 byte alignment
> 0x1000c07f75f4: note: pointer points here
>    0a 00 00 00 33 00 00 00  00 00 00 00 2b 00 00 00  2b 00 00 00 40 05 80 40  f4 7f 10 08 58 05 80 40
>                ^
> 
> and various similar errors.
> 
> Replace the use of X86LegacyXSaveArea with a set of fields that match
> the kernel _fpstate_32 struct, and assert that the length is correct.
> We could equally have used
>     uint8_t legacy_area[512];
> but following the kernel is probably less confusing overall.
> 
> Since in target/i386/cpu.h we assert that X86LegacySaveArea is 512
> bytes, and in linux-user/i386/signal.c we assert that
> target_fregs_state is (32 + 80) bytes, the new assertion confirms
> that we didn't change the size of target_fpstate_32 here, only its
> alignment requirements.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/i386/signal.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)

I think it's more complicated than that.  I think this is indicative of the alignment 
being wrong.  In fact, I have a vague memory that we have an Issue outstanding for this, 
which I looked into once upon a time, and I think we're well out of spec.

There are two parts: fpregs, which should be 64-byte aligned (for xsave/xrestore), and the 
main signal frame, which must be x % 16 == 16 - sizeof(void *), so that SP, after pushing 
the return address, is 16-byte aligned.

I can't immediately find the issue.  I'll see about writing a test case.


r~

