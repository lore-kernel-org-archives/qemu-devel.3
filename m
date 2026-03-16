Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA94AF53D9D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2FBF-0003Yg-Et; Mon, 16 Mar 2026 17:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2FB7-0003YI-UA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:08:46 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2FAx-0000rl-Vt
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:08:40 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso219182d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 14:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773695311; cv=none;
 d=google.com; s=arc-20240605;
 b=ZV6CyxhbV0jkig9aARIdr1zBweUZBIwVXM3zL/07eY1A+JrFqxXPijQQfOMJ9/OfiS
 vA/IDh7xjL4UcJ5vAqKm3ImZ/KHgL9uHC6wbqk8BkYCfAzWqbUSd4AiXGjfIdhOGwbIi
 dtJDVepRg0ttzgI5FrdBBocg07hC3Ehgjz558Sn3emSClbExOpJew0NN3nhBiKyPHowW
 6De1OV1UbWkoafiD7sI/1xXx+xQYCOWUU1vxB/+6vdoYg8ga09rIqXpCsPamO6A7xOMW
 1ML/frh6XaUydwCYzvui8KbMNIW6KoQ5wxohMF6bZWGOr6o3VMKqiGxbZP0I7ZcBlhUr
 PiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jt+D67OKl3aNupTTSyxxKDp80cYavgzRPqQK8MrA29I=;
 fh=hDb7LEefQ45QrkvsMxBgSYWuhg/JvRX4y4A3ifYbgwY=;
 b=RWm2KNz/LfL/1LgJ/efW8JWrbY30tcu0fFcjMwu1t1Dx9oXa2bFweCFWZB+D2BXbgA
 PUpst5LvU8V3CIxe2QxIqUyVWJ9jC6nzLqHiAHihNQK1lJ/IKz7oozEb3htMNBwgIj/0
 Wfhy/qvcKB8goUx7POtHRvst5/SD9d1m5ZJBep1lBcyVAihiPqeHT+Mj424cEMz54e66
 SQe/IslEess7f6d/1o/5SljgSyS3PhwKQC8Mp0EAQGgi3xJS/oiohy9wGnbOS2B+CHWi
 5XbN5zZYDUZtKeBBmnhOIb60ZG/9eRoDo0REAuw37QiQqKVVievaucKi9jYavnTs+4lC
 mATw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773695311; x=1774300111; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jt+D67OKl3aNupTTSyxxKDp80cYavgzRPqQK8MrA29I=;
 b=nX/oTRIyLiYUxWb38kJuPnSlta7gEDUd72X1Mrs9RYxbr1mYM3ojwPiwXr3ONjelCw
 unacCSs9Q/+G5arwz8Yv6xHctc2KedS3vCE8fQBsS6sq8L/aqG5ToneYRNS7Wnz2CxcL
 yQ1P0FlEiOZrvXzGeOFfvTgdTx+hDHK1u9r60CuELhgx96b+wkNXFg/aJSlRF3Uaq49i
 ywt7f3ak4RKhd9M99fkF3iLycPv8G7A3Ukuf9KPzmt5vNEAxjCn9kAjoeq+Gw41UlHWc
 NBZZvESKL2yFURXFGOIhVooy9bV3H2hKKblj/2YHpv2PY6IpoTt5ZlVk5boNeik54OwZ
 WbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773695311; x=1774300111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jt+D67OKl3aNupTTSyxxKDp80cYavgzRPqQK8MrA29I=;
 b=Kd2hbLLJlo6V5MzQ0BPtezvJc3KZeMrlIWbt211zOI46qtryiAZyoeAIkDLm9kVhZy
 LLyWgqhHUIWwkCP43teOYFtJkbRAG8fiy+1pgg6A4yqoQyCV1NTGuoKtT25I3zJS6pGj
 KAQCDIeH6WFC1HiTeWwwCF+2w0kQtvKI71w+KzuzLKld5iMtng8YSduk4kKRn9oCitXC
 mDhgveoPyzzL5DQktLQTVsGXEiAs+hn2J4xgTPWeq5bI8Ub6LjDWwXg0ccKKOXIV5GFF
 KBZoS2TSK2tBh9pPCtjouv0N6RK50B/+7xmP80qKw/VAk9S9e9b2pgM7N+ALpMGSGD7V
 ivUA==
X-Gm-Message-State: AOJu0YzA4karBfA76eKxdyxwgm/HFEd25/lD+wyJ6s5tSkzSqVlvokV4
 aUxOjde9eXgXKpsqoblmoqQe6KG9bwcc/yJPPm15GxV1PpAQ+kOSCpLyLd/dobVx9uqG9i1bQEt
 MJnQrIU2+ni2PYggjDx2SCfzYZPe5aBIGcdg4vvDsoQ==
X-Gm-Gg: ATEYQzw5krWoTyMDXUDwSi5BSpzNNMC7fV3ceQRVC5Y82ZdWa1eoSDiyvcZtPLkHOaK
 c/+CJy9JbXvTnhrXkoY8hWrijPc2mcRMosNfaQO7DJiuRr0lKsN8VmDilk8O33h3cc8XL0lgZJk
 6Vhm3AJs6bUijYU3cXtnGUa1cYPQ6756SgJ95Dus9erUeX7PZhFHq7hTeLUc4IuJ2IzgtEgxYex
 67PNWQ5Ai8ThOhxPoDOtLjI/e1MyHtJcRjp/1UjoXoos+7SrCp3QWHdAg4ZLM2FT+yOJGQaFBXK
 1NvxBgmBm+guMRl1nVxESH8RtWN6ZDUW3kj2a/yd6OCQGlY7MHOLMsojLSJQEJtIWp8=
X-Received: by 2002:a05:690e:2490:b0:64d:60f2:81a7 with SMTP id
 956f58d0204a3-64e88a50423mr744952d50.20.1773695310806; Mon, 16 Mar 2026
 14:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260316194759.22672-1-farosas@suse.de>
In-Reply-To: <20260316194759.22672-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 21:08:19 +0000
X-Gm-Features: AaiRm50zEpUFAqRwwVG4GS71gs7hM-5D5Xm0JbVJgeyyaVc-RPVi750lJUDfsfg
Message-ID: <CAFEAcA-P9Uxc6HY6-3_xT8BfTnJb-DQBGp_DJtPHvWZJatEXfQ@mail.gmail.com>
Subject: Re: [PATCH v1] migration/savevm: Allow stub VMSDs
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Kiryanov <rkir@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 16 Mar 2026 at 19:48, Fabiano Rosas <farosas@suse.de> wrote:
>
> After the referenced commit, empty VMStateDescription objects declared
> as part of stubs have started reaching the vmstate code.
>
> A valid VMStateDescription must at minimum have a name and either the
> .fields or .unmigratable fields set. Stubs, being empty, have
> none. Code that assumes a non-NULL name field will now cause a
> crash. E.g.
>
> $ ./build/mips/qemu-system-mipsel -nographic -drive if=none,format=qcow2,file=dummy.qcow2
>     [Type "C-a c" to get the "(qemu)" monitor prompt)]
>     (qemu) savevm foo
>
>     Backtrace from doing this under gdb:
>
>       #0  0x0000555555df7d4d in vmsd_can_compress (field=0x5555564f78a0
>       <__compound_literal.3>) at ../../migration/vmstate.c:339
>       #1  0x0000555555df7dbb in vmsd_desc_field_start
>           (vmsd=0x555556431ba0 <vmstate_cpuhp_state>, vmdesc=0x555556918690,
>       field=0x5555564f78a0 <__compound_literal.3>, i=0, max=1) at
>       ../../migration/vmstate.c:362
>       #2  0x0000555555df85a7 in vmstate_save_state_v
>           (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
>       opaque=0x555556c9aac0, vmdesc=0x555556918690, version_id=1,
>       errp=0x7fffffffc948) at ../../migration/vmstate.c:528
>       #3  0x0000555555df8032 in vmstate_save_state
>           (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
>       opaque=0x555556c9aac0, vmdesc_id=0x555556918690, errp=0x7fffffffc948)
>       at ../../migration/vmstate.c:427
>       #4  0x0000555555df8f83 in vmstate_subsection_save
>           (f=0x555556b5a0c0, vmsd=0x555556431c40 <vmstate_acpi>,
>       opaque=0x555556c9aac0, vmdesc=0x555556918690, errp=0x7fffffffc948)
>           at ../../migration/vmstate.c:695
>
> Due to their very nature, it's better to allow stubs to be
> completely empty instead of forcing any rules. Teach the code to skip
> them.

I'm not sure about this. I think if we're hitting a stub
then something has gone wrong -- presumably the code author
intended something to get migrated but it has not been.
I think that any stub should ideally never be registered,
or failing that at least should never get used (i.e. it
should be guarded by a "needed" function that returns false).
Allowing stubs to silently "work" seems to me like it's
going to be an easy way for bugs to get in where some
builds of QEMU happen to pull in the stub but we never notice
it because the "all targets" build happens to compile the
non-stub version of the code (in which case either we
fail to migrate data we should, or the migration data on
the wire has different formats depending on the build config
of the QEMU binary, which is going to be a pain to debug).

For commit 7aa563630b I feel like the problem is "author of
the code didn't realise that there was the MIPS malta case
where this code can be used but CONFIG_ACPI_CPU_HOTPLUG
is not selected", and the right answer is "look at that
case and update the piix4 code so it's handled right".

thanks
-- PMM

