Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA15BC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2W59-0000kE-Jv; Fri, 04 Sep 2026 11:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2W58-0000jw-6U
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:43:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2W56-0002hp-AC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:43:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso9724305e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788536634; x=1789141434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ea9l8vCw3+MyUHczI6di830buXi9mqJ03YPN+mVWElU=;
 b=GodTKf0V02Qy4oulJU4W7yY0mSCPeg/WEoHWI/+wdYfz5umoCnmYhztjF0QfsvYTsX
 ZLuN65+UMpcmLICvFnAPWCRBy/mu0uCNZmvSyfCJEQ8jKFK3wr2qvlOg+ZCKrECvpdAh
 uwZJsPIyVhS4BTaBV4kv0ogGuH0uCLww4lPqEjoIh+bEXH+IjjsG3VGQFUBJz4r6hRmb
 0J9IHoAovtfXKVGNP6asknb1uyFEPT6Hu5wAqD6Wcs6sziAdg/VjXn1pYNih9WaMSwFI
 d6MtqEfFLbTZ6eI1YjTZLBEEEFB4cjXgOnZkEB5DfOkd3vfFZwLzDtBoP2ZCM3JaHRj8
 1lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788536634; x=1789141434;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ea9l8vCw3+MyUHczI6di830buXi9mqJ03YPN+mVWElU=;
 b=UBZqjIy5cQxRGtxZMKK8EZEHrxTm9zHMrRQEJDVkxStq0jN8AS7i+TK08Ev0sY6A20
 P9kx+r6yJAbTb793vhBpZgHp/1QLNXb7RBTnmND2GBjpt4XN6WAtZAT5JQOyJ/lFzPdm
 0TBUBlcEj9eTZ/iEbSBIvPjTIoI2TeLLGCJJdmGwILVeiKbhS1XGrS8f+sEinuUun4YE
 ETOB/idRQX3qq6MhAQNSAgE0sKsnR0BCXHP19lNvrFUbem70XHD9oFBZXv0Fy8aN9ccE
 Pp10fyvW+6dyroCnRRj3aXJvz5s3z9tUG1fesnyG3LF8xDaM7ecyMCR13xonL2sMQtnY
 BKKA==
X-Gm-Message-State: AFuF++lPG73oiozaGMBykWw2ABMjY6A4KOuYe5kYbsSRl/ZilIXl50cZ
 jhLEmujp9GpyNvezXpBBy8j4ji3bKa6fo4nkWbSRBjC2UNtFPGRPFntr37qY4IvjbfQ=
X-Gm-Gg: AYBFou021JZBtslRwJBYnFt5Jj/KKN5dx5cgx7S4ZEu7G2qyMDiBSOjOgN+nbwYjN9p
 tJBxhdQJYZs/z/bvvXKI6D/GXzW9X62swDkVgfjabdq02t522G6byNNiwWFLcDv91uDvgBqvgq9
 rQTVhKdJUBKARklk+U3ULFLizYA+mdYP0CSo9ytbFE7SzRrvA5EgS19eiDKRiptgvUbbxd5mkef
 S/Pq+wQyaB83NCxHv/df7O7vnrr+V24E1FKZi7i8I+t8NwS27mjo3OYRpFebLqvkqcPdR4Zccb4
 ZtqJgJDzTHvdNOKBNHfudgMD4EQWrcqNrVwIPy3S0x02BA0vbFzrl+iIfptheBAtn5KIvYDpex3
 vqW8u+Z8hppJRVPYI5yZvw+Vbvq4zYvCHrip/n+uYHZFoBEmqbEHNmJt7e5X/o1qArmU7iofdOq
 /cWYiB2+i8r45ONLcUT84IDpEEWpiSty6Zji+EsoJdZXfUbv/oy4yW3JNbrOjn
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-49cf8244878mr72180385e9.11.1788536634421; 
 Fri, 04 Sep 2026 08:43:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm105587085e9.5.2026.09.04.08.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 08:43:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 007B35F954;
 Fri, 04 Sep 2026 16:43:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [PULL 000/105] move check-tcg into the meson build
In-Reply-To: <18f4fdf4-1e8a-449f-a003-3bff20499a29@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 4 Sep 2026
 15:46:43 +0200")
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <18f4fdf4-1e8a-449f-a003-3bff20499a29@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Fri, 04 Sep 2026 16:43:51 +0100
Message-ID: <87h5k5owco.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 4/9/26 14:44, Alex Benn=C3=83=C2=A9e wrote:
>> The following changes since commit 99e54ab5e7a6efc945af6d5661842155d1f3f=
c7a:
>>    Merge tag 'hw-misc-20260903' of https://github.com/philmd/qemu
>> into staging (2026-09-03 16:43:24 +0100)
>> are available in the Git repository at:
>>    https://gitlab.com/stsquad/qemu.git
>> tags/pull-11.1-check-tcg-meson-040926-1
>> for you to fetch changes up to
>> 26395b536c3ec0a857dffd6548d8ef49479dedad:
>>    MAINTAINERS: add maintainer for tcg/tests meson infrastructure
>> (2026-09-04 11:38:01 +0100)
>> ----------------------------------------------------------------
>> tests/tcg: conversion to meson
>>    - remove unused variable from multiarch/memory
>>    - standardise checking plugin output
>>    - bump minimal meson to 1.6.0
>>    - introduce meson plumbing for check-tcg
>>    - return error code if docker probe fails
>>    - add CI/self/mem test to gdbstub prot-none tests
>>    - use raw opcode for fprcvt test in arm
>>    - remove unused variables from gpc-test
>>    - teach probe-gdb-support about mips
>>    - identify or1k pc register
>>    - port check-tcg logic to meson (all targets)
>>    - update documentation
>>    - add Pierrick as a maintainer for tests/tcg
>> ----------------------------------------------------------------
>> Pierrick Bouvier (105):
>
>>        tests/tcg/riscv64: add float reference files
>>        tests/tcg/riscv64: user tests
>>        tests/tcg/riscv64: system tests
>
> Some of these likely need to be updated for the latest RISCV merge:
>
> $ git diff --stat 99e54ab5e7a..d2843fbf802 tests/ | fgrep Makefile
>  tests/tcg/riscv64/Makefile.softmmu-target |  14 ++++
>
> $ git log --oneline 99e54ab5e7a..d2843fbf802
> tests/tcg/riscv64/Makefile.softmmu-target
> 883a4d4da4d target/riscv: preserve vl on element-zero fault
> bbdccc84fc3 tests/tcg/riscv64: Add tests for rv128 [ms]status
>
> (not sure if this can be done on top although)

Merged inline, see v2:

  Message-ID: <20260904150826.2331577-1-alex.bennee@linaro.org>
  Date: Fri,  4 Sep 2026 16:08:26 +0100
  Subject: [PULL v2 000/105] move check-tcg into the meson build
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

