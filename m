Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE81C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdrKS-0004LT-22; Tue, 13 Aug 2024 09:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdrKP-0004Jb-VU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:12:46 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdrKN-0001Mu-Tt
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:12:45 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso7548458e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723554760; x=1724159560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Rxgp76S6WgbPZSowGwbDkPUGyA3wMXIrA7HO/gfH0E=;
 b=kE354UI7FmNld8EQrL1dyWn8chaHXnjJenMrjknrOsEnKFXr0uSog4VrsH7Z9+J35T
 PyCXZ+WKzHzAR+wzZYcGDiMC/1ZBcnwB22GuQ/lJa+0L3QzYV1kXsVWdGq4NPRCwqm9W
 YbivZJA8EUdxXSAk0oc+AoSTu7Bgkx4LVTdieIEdXivpcf98QpfmAFGwTOwhy85YwRdZ
 XyzBVd1lV4b+NRnNG2LTp47w5kdaIv4/4VvF09C9Bh4nurD3iamtpZNe0OQvCPI57484
 SmD823Gf7DlwTB/1i3lG+9e9C+dSdu6QV1tUjJGo60ARAVREQiP+fAPN7mfRcYBbRPAp
 AmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723554760; x=1724159560;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Rxgp76S6WgbPZSowGwbDkPUGyA3wMXIrA7HO/gfH0E=;
 b=iZYi8FjLG6ph0ypd5yNtWOVaklus72OaHc7QvXGfd+I2iuibAd+sZOBKO19IghZS8i
 AdR09+Tg/R2ke44NLJ4Az4ZIbLaMI5rbIb1jqbUYVJlti3xrXm64wTohBENg2xYzyqcZ
 LMxS8q8nYkVr+XWzXL0f66TBapC7rMG4WY35wQSrkwPAGeOfUU2rI2w3Xy0yHezvoaiA
 rrHXNFhqJFZe+rKzGMxXzSzW68gQSFtGNFz/zls0P9pXKlQifjNGpYeRpXijZFIhX9kS
 E8Pr+3euXEJSGe420JP7+9FSwDyJOLhGnY18YBUygo2gY1S1pQH5cxvACra1BZtstQxX
 /HaA==
X-Gm-Message-State: AOJu0YxcsQw6JHzJnY4fDl/ZQiUcHykpmmP61kenmXhJfRiorgsvtWf1
 Oeypwj5HScDXqcpI7KH/QKJSSovvqz+rXtaaHcLLzk9ySfp84/dHLacLud0C5PI=
X-Google-Smtp-Source: AGHT+IGV/YGVIvygAX9dEKfhPPzd422FCyBABAC25Lka1t+4UW/yZ6woijiZySVMTCeO03FFG64eFg==
X-Received: by 2002:a05:6512:239e:b0:52b:c27c:ea1f with SMTP id
 2adb3069b0e04-532136a47b2mr2776695e87.55.1723554759889; 
 Tue, 13 Aug 2024 06:12:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411bd72sm68932466b.140.2024.08.13.06.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 06:12:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 879755F792;
 Tue, 13 Aug 2024 14:12:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH] target/i386: allow access_ptr to force slow path on
 failed probe
In-Reply-To: <3fb9f760-4eaa-4a81-a500-89d340fc1376@linaro.org> (Richard
 Henderson's message of "Thu, 8 Aug 2024 09:10:09 +1000")
References: <20240807160236.2478459-1-alex.bennee@linaro.org>
 <3fb9f760-4eaa-4a81-a500-89d340fc1376@linaro.org>
Date: Tue, 13 Aug 2024 14:12:38 +0100
Message-ID: <87sev8a7nd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/8/24 02:02, Alex Benn=C3=A9e wrote:
>> When we are using TCG plugin memory callbacks probe_access_internal
>> will return TLB_MMIO to force the slow path for memory access. This
>> results in probe_access returning NULL but the x86 access_ptr function
>> happily accepts an empty haddr resulting in segfault hilarity.
>> Check for an empty haddr to prevent the segfault and enable plugins
>> to
>> track all the memory operations for the x86 save/restore helpers.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2489
>> Fixes: 6d03226b42 (plugins: force slow path when plugins instrument memo=
ry ops)
>> ---
>>   target/i386/tcg/access.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
>> index 56a1181ea5..8ea5c453a0 100644
>> --- a/target/i386/tcg/access.c
>> +++ b/target/i386/tcg/access.c
>> @@ -58,6 +58,10 @@ static void *access_ptr(X86Access *ac, vaddr addr, un=
signed len)
>>         assert(addr >=3D ac->vaddr);
>>   +    if (!ac->haddr1) {
>> +        return NULL;
>> +    }
>> +
>>   #ifdef CONFIG_USER_ONLY
>>       assert(offset <=3D ac->size1 - len);
>>       return ac->haddr1 + offset;
>
> You need to remove the test_ptr macro below as well.

So we fall-back to the slow path for linux-user as well?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

