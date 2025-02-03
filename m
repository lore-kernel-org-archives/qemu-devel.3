Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81966C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 12:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teveK-0001hr-Qt; Mon, 03 Feb 2025 07:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teveJ-0001dm-0C
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:33:59 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teveH-0004gt-51
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:33:58 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab2aea81cd8so777415066b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738586035; x=1739190835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSxfNYRCW1IeAzWNHTGOeCdcvCKKn40kG8ZK7fghQN4=;
 b=M+Xd3U7HK+aTda+MWJEVWx1KihEEUW4Mgfyldld0+dQxQUPK2FEh6IUIiXJHZfVWnX
 OWvedR/fZ1Ziady/kq5XdIyMz2xaUCT0KTBB7Eku/Uft5vuOA6FFA4e7s9Ph8P601dCe
 bzLF3IR1mpFRRiiVUGRIvJm4pO+O5QcaFvBsvaMppqbbCnPP6q0ZWU+BENYsXALH7BDF
 pII9mLEfHGGIxeo595RpjMLn9655yiBCgQEkdyOK6qJyhTabDuUumcXkPMqceunqiOj5
 dkglbElCzl8jcxGMSzTyPQzFhYtNYSiNMT7am9EgCGfSxf7UWwttWLE1e6OFRvxPwIm7
 CqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738586035; x=1739190835;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSxfNYRCW1IeAzWNHTGOeCdcvCKKn40kG8ZK7fghQN4=;
 b=X43Tf4yrunABrY8p74k57M3hkKWvNapk/0hpMi+M/jfeo+wopNTeMy2sEXwclqmKSz
 TEmr7zvyptz/QTpVgzkUoU7KJG1uByBoUsOsQBSKYA6kZ78Sm5ed1MJ+QlaoaEYA1f2H
 Y6DvOyc+pUceUsQaS3ZwPlm3OZ/z+r8k9aNLzYcIUpN3vz4ekPvEm8pdFT1QLBcIMPFc
 7GBos6xmzN91E5pr3z8CbQ+0F1SRnFcJxY79LaBYxFhXJjaRtuA6Wl7LmWAdU/GDXC+w
 rVE+wOQfFLPEWvxNq+W7IxjatI1768uMmexk5E+Ew9uv7YxuqxFH1Qnv+y40uzdRp8RQ
 TSDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj+kpDjJz3RC2F93Oy8WmXxetslx6Avq12wKoAZlm1QM/2+OxWCotJjWsTOAymovwD1nIOGm+vFKyx@nongnu.org
X-Gm-Message-State: AOJu0YxDYgbPpoFl7n5C5CM+qekwAhalqEZiNUAbjOSZYcHkX8kExoU+
 0Wc8E6FikNuAhZZ/GvnaZ3i4Z8seKGZpPwny3NB+whafRnzERQB4CZmmjk79BzE=
X-Gm-Gg: ASbGncsIz7YEqG7oFQzbkQb86JI+k4atsRrd3mb7aBw8g7iQkNA/ZlJhfzle6uIAw6I
 WE4RvbjJS6FOpjLPdRyapJ3HmaI3xtnM+2uo19qTp7XpjAGvvps5iYScSxGnHIa51vC0wm8SdqX
 0dI/auigxQBdGPaPpNbegXW5+pBj0kouG+izeEtPGZccokXp8At9qKLc+iQMOlcVvv8ixbbdF2F
 qdCUllYS18gzsJeHG9nB46+772MXxyS8+f8RSaKJPLn8e1fcQI1+R8c6ky5Ku0eCtWbAiEKrUTh
 Jy60Ax2A/odp3nsMFA==
X-Google-Smtp-Source: AGHT+IHrUFXmI8DHah539R1IZ9DCWcN5XsT5C76g5nHAAPywD0FcJkIMSWeDz0p4ICD/+luJmEv+pw==
X-Received: by 2002:a17:907:2cc5:b0:aaf:74d6:6467 with SMTP id
 a640c23a62f3a-ab6cfe11f0cmr2371012066b.42.1738586035303; 
 Mon, 03 Feb 2025 04:33:55 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a5ccc1sm737184866b.182.2025.02.03.04.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 04:33:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 240405F8BF;
 Mon,  3 Feb 2025 12:33:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v2 10/14] configure: Define TARGET_LONG_BITS in
 configs/targets/*.mak
In-Reply-To: <47d703f2-bee2-4ee1-af13-624f6f0e7ee1@redhat.com> (Thomas Huth's
 message of "Mon, 3 Feb 2025 11:39:44 +0100")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-11-richard.henderson@linaro.org>
 <47d703f2-bee2-4ee1-af13-624f6f0e7ee1@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 12:33:54 +0000
Message-ID: <8734gvdx71.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 03/02/2025 04.18, Richard Henderson wrote:
>> Define TARGET_LONG_BITS in each target's configure fragment.
>> Do this without removing the define in target/*/cpu-param.h
>> so that errors are caught like so:
>> In file included from .../src/include/exec/cpu-defs.h:26,
>>                   from ../src/target/hppa/cpu.h:24,
>>                   from ../src/linux-user/qemu.h:4,
>>                   from ../src/linux-user/hppa/cpu_loop.c:21:
>> ../src/target/hppa/cpu-param.h:11: error: "TARGET_LONG_BITS" redefined [=
-Werror]
>>     11 | #define TARGET_LONG_BITS              64
>>        |
>> In file included from .../src/include/qemu/osdep.h:36,
>>                   from ../src/linux-user/hppa/cpu_loop.c:20:
>> ./hppa-linux-user-config-target.h:32: note: this is the location of the =
previous definition
>>     32 | #define TARGET_LONG_BITS 32
>>        |
>> cc1: all warnings being treated as errors
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> [...]> diff --git a/configs/targets/hppa-linux-user.mak
> b/configs/targets/hppa-linux-user.mak
>> index 8e0a80492f..4295cf384e 100644
>> --- a/configs/targets/hppa-linux-user.mak
>> +++ b/configs/targets/hppa-linux-user.mak
>> @@ -3,3 +3,5 @@ TARGET_ABI32=3Dy
>>   TARGET_SYSTBL_ABI=3Dcommon,32
>>   TARGET_SYSTBL=3Dsyscall.tbl
>>   TARGET_BIG_ENDIAN=3Dy
>> +# Compromise to ease maintainence vs system mode
>
> s/maintainence/maintenance/
>
>> diff --git a/configs/targets/mipsn32-linux-user.mak b/configs/targets/mi=
psn32-linux-user.mak
>> index 206095da64..39ae214633 100644
>> --- a/configs/targets/mipsn32-linux-user.mak
>> +++ b/configs/targets/mipsn32-linux-user.mak
>> @@ -5,3 +5,4 @@ TARGET_BASE_ARCH=3Dmips
>>   TARGET_SYSTBL_ABI=3Dn32
>>   TARGET_SYSTBL=3Dsyscall_n32.tbl
>>   TARGET_BIG_ENDIAN=3Dy
>> +TARGET_LONG_BITS=3D64
>
> Why is this 64 ?
>
>> diff --git a/configs/targets/mipsn32el-linux-user.mak b/configs/targets/=
mipsn32el-linux-user.mak
>> index ca2a3ed753..d9b61d6990 100644
>> --- a/configs/targets/mipsn32el-linux-user.mak
>> +++ b/configs/targets/mipsn32el-linux-user.mak
>> @@ -4,3 +4,4 @@ TARGET_ABI32=3Dy
>>   TARGET_BASE_ARCH=3Dmips
>>   TARGET_SYSTBL_ABI=3Dn32
>>   TARGET_SYSTBL=3Dsyscall_n32.tbl
>> +TARGET_LONG_BITS=3D64
>
> dito?

Are these 64 bit linux-user with 32 bit ABIs like x32?

>
>> diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/target=
s/sparc32plus-linux-user.mak
>> index 6cc8fa516b..7a16934fd1 100644
>> --- a/configs/targets/sparc32plus-linux-user.mak
>> +++ b/configs/targets/sparc32plus-linux-user.mak
>> @@ -5,3 +5,4 @@ TARGET_ABI_DIR=3Dsparc
>>   TARGET_SYSTBL_ABI=3Dcommon,32
>>   TARGET_SYSTBL=3Dsyscall.tbl
>>   TARGET_BIG_ENDIAN=3Dy
>> +TARGET_LONG_BITS=3D64
>
> Same question here: Why 64? If this isn't a mistake, could you maybe
> add a comment?

This is definitely one of those weird 32bit ABI on 64 host.

>
>  Thanks,
>   Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

