Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE3EE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 23:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPrUi-0004iW-I1; Mon, 23 Dec 2024 18:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPrUg-0004hY-Cj
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 18:05:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tPrUe-0003kt-H8
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 18:05:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso31970195e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 15:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734995143; x=1735599943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8wirB2oxzEwBCtv2tOsMsgvv/9t4T7GgUtSDc9qT4ag=;
 b=WVqNaScc5QLoVTQd56omK1D00jMBPVO+R8s4kDiTQJzteMxRT810kzyCjfTa5Sleu0
 w1/4D3+FE0Ts78TOJEJFE/zQxbLgeozjFDS3ZwdP0ldyYoLeOgtdp9vAA8tWzn1uiGG0
 sjYkwtMmrRbNX8yHwNI9NH4kfcT9S9SNJr1lX7rjwtzF0aFgGE4seZOf74OKsRWTdo1Y
 SDlcBgxJ9Wk4FAQavuZum02u76s0gxi6ziFYQFv7ZlEXHQXoVcEl+dhruRAUNxG6bJK6
 WqxfE6WwDELmMOU6zmTLzV9EPctWVsPrgqWQHsLbym56Eq57I1Hot9QcUHU2IDlz7Rtn
 8kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734995143; x=1735599943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wirB2oxzEwBCtv2tOsMsgvv/9t4T7GgUtSDc9qT4ag=;
 b=WLybS6Wdj8cPvLlWez6J9+T7j/3Zu8K4B2+FNACvCai2eKk3kvm+TifBztisFnQxI2
 wpgohs6NtPRvEeo7sjJNXUHLTuCQF20Nl2AZxDqDY+620TNYmz0bsALN8hQyNw4Xa+xP
 JHkrjOe9hhQP4iyW2KSitSf0YanGRYamyaCIZitVHzJ7JlSlSdS3IHEFAUEbLs/MtQh5
 HR5pg7G6WDEo2GVhJvHMhKXJfKwE/bLrIUaGkSpDlwAFhRW4D6PP33usSUuzgl8yTZ87
 QcOLnj3qJIrmJd9VR+Ey7ziimcHJF4U4BVEKw7LdtW0SG2BhT+VGfByrcqdcs3WlHuuU
 le0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5MPZVKRTRA5P0Cgh+bcJKg2A5piZfNfbCwXIB4iLlUNRZrMyVUShxx0kSBHqTrJgLFEkzJ4I5+Xga@nongnu.org
X-Gm-Message-State: AOJu0YwBlOtEXJ9g3Z3T5f9UJ3Q7YYlAF0e0yQSQmibQc4ZZP4qJfKME
 4+3ZVvKqXFIdcRgAEuOPc2UhLoBHzH9GDskAgkrR9GOnXPsldEXazVOP51pNe4M=
X-Gm-Gg: ASbGncusq3OyswO1pnxaaaf9S4ppnKC2dO7ADHt19DdoqQ/KoMn0pTIA+h8LqArf6Rj
 0MR1xLqjcrvobPqem83AHUy7p24VWb9LdWX+pV0H8FT2K5t2yJCt79q5xADmsmDtZTeMSW1q8I2
 SBZPrK72lxyr0jvydFVkLBXrTDWqyO4yID3isyevvdyifAsX5ibgAonCLh1S+8FnrAGnW1nJuKT
 aAfxlKj/FconGU9uQMYodshMEXFDwdziiNseKtc4HZ1wv7szt097/t9EadO3XMo3EY=
X-Google-Smtp-Source: AGHT+IEkpZKtff9otRKBBcG+TWXg2q7OtBuEOOpTO9uYLS2uupqsMwq1V0+NDgxCNOsq9NFrZ1xqcw==
X-Received: by 2002:a7b:cb93:0:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-43668b49981mr106293485e9.21.1734995142660; 
 Mon, 23 Dec 2024 15:05:42 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847dabsm12370921f8f.59.2024.12.23.15.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 15:05:41 -0800 (PST)
Message-ID: <cfe36783-9353-45c0-9f4c-6aa1879ffd70@linaro.org>
Date: Tue, 24 Dec 2024 00:05:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <167ca349-980c-43a7-82f2-264b2f7250cb@linaro.org>
 <50ABB5B0-4B7C-4F32-A956-82BD76C235E3@philjordan.eu>
 <CAAibmn1sJ8cCyExHaEw853bek1hUt8QrA4Lv5=1R=zX=v=51QQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAibmn1sJ8cCyExHaEw853bek1hUt8QrA4Lv5=1R=zX=v=51QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 23/12/24 23:17, Phil Dennis-Jordan wrote:

>      > Do you have other changes in your v16? I'm quite happy to
>     integrate this
>      > v15.
> 
>     The ones proposed by Akihiko are the only ones. I’ve already
>     implemented them, so I’m happy to post v16.
> 
> 
> OK, rebasing on the upstream master branch has revealed it's not quite 
> so simple: there are a bunch of clashes with the recent sysemu->system 
> rename and the removal of DEFINE_PROP_END_OF_LIST(). They amount to 

Yep :/

> pretty trivial changes, but almost all commits needed adjusting, so 
> pulling v15 would be painful. I've just posted my v16 (including all the 
> changes discussed here).
> 
> Thanks for taking an interest in this patch set!
> 
>      >> Adapting this giant macro for each machine type seems rather
>     error-prone and the kind of thing a computer does better than a
>     human writing the code. I can't help but wonder if we could define a
>     generic version in boards.h and only implement the
>     DEFINE_*_MACHINE{_LATEST,}() wrappers specifically for each machine
>     type. I've created an issue for this on GitLab: https://gitlab.com/
>     qemu-project/qemu/-/issues/2744 <https://gitlab.com/qemu-project/
>     qemu/-/issues/2744> <https:// gitlab.com/qemu-project/qemu/-/
>     issues/2744 <http://gitlab.com/qemu-project/qemu/-/issues/2744>> I
>     might attack that once I've cut down my backlog of unmerged patches.
>      >
>      > Do we really want the vmapple machines to be versioned? I see 3
>     options:
>      > 1/ No (simplest)
>      > 2/ Not yet, adding versioning when we see the needs
>      > 3/ Yes
>      >
>      > Personally I prefer/recommend 1/ or 2/ ;)
> 
>     I didn’t realise these were an option. :-) I was just inheriting
>     Alex’s code here and assumed it was the standard thing to do.
> 
>     I could imagine we might change a few things to get better guest
>     version support and perhaps the guest iCloud support that was added
>     to the Virtualization.framework in macOS 15. But yeah it seems
>     unlikely that any of this would cause regressions.
> 
>     What change would you propose to remove the versioning? Is there a
>     specific machine type I should use as reference? Or do you just want
>     to change that yourself, if I push my v16 code to a public repository?
> 
> 
> OK, grepping through the code base reveals there are quite a number of 
> the "smaller" machine types are unversioned. So I guess that's a no- 
> brainer then. I've worked out I essentially just need to move the compat 
> properties registration to the main init, the "desc" field on the 
> machine class needs to be set, and the type becomes non-abstract. 

Correct.

> Everything still appears to work when I add that back in after removing 
> all the macro definitions and instantiations. Change included in v16, 
> but I've still got the reverse of the removal commit around, so if 
> anyone has good arguments why we need it, I can easily add versioning 
> back in.

Great :)

Thanks,

Phil.

