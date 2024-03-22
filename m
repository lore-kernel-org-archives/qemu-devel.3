Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE964C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnakk-0001EU-2N; Fri, 22 Mar 2024 04:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnaki-0001Du-E7
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:59:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnakg-0001sl-SA
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:59:52 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso1062775a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711097989; x=1711702789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a1vfWWq402ODKpgAEOpkY7cqpUKTrQvZscMmfpRFR7Q=;
 b=DPP4zEMGxRU6GDfWJRAh0helSVoHzDPhmlrhYJZ0niN2U4p6TMpmeFNEUKhXeoUJN/
 wd+Z19aIrUq5+reRKokjMzaj07ZOyKj/bbiIRGtiCzipLj51XaIuC6pUctL4bAWAtPxq
 1TmJnNG8CpV3AMTVSQTFbnSjFMj7K+NSEJptDGMGHQsMr8z1Bu330DZvL99EwKX5GEMV
 +xPFgnq42rG+RVMjphQmU3j5OBDD5VGtPhGCh4Ge4adRbZGStMhQU6sSRWpsdomXrNwc
 40gggHhwuLoLD1rbaJ3of6c92VBvp7+hdDVtbkiW7WwO4m1CUkHxa09s5MKXXlIlfpBn
 7rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097989; x=1711702789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a1vfWWq402ODKpgAEOpkY7cqpUKTrQvZscMmfpRFR7Q=;
 b=Avn1PTsmusityPpvmCdJsfi3LbnPgE0s3yHJOFij4ruGKjS+DypYmXhgx3mMfIvGxs
 5WmUklqcgKdHasGP7H0WQGApZ3tmnNCo5Om9oGfQZ6Hijexab3unqQEO8+Hhj5za+AWw
 Iehg3OGWz6hN6WHYkpVFYlDy7h7QGWnw29mKt9KbMzC0QkhwOEAXEauEi8hm5C/pMOOO
 U7KddGn00CmR8r+8uM2p1hQWkOuLV7JCg1FaIgP0T7RAWEAey8IExf3y9/n/GLqXI/+M
 hU6VbIygQ6on2jVRNdLBaJeUTzMhNVeFwWkv5maTEMRmV4snw2c9ilifle3xN1UR6BhE
 fmxw==
X-Gm-Message-State: AOJu0YxWv5SNHQpK4kihNmda4P03txBjv7OHxARZeDue0ySBG5yZ+15m
 Ma9iAZ7MTxYSE4HAsVDldMm0iWJ4dUSfinGMOCcngSf9gafBKDonm+eyUMV+qCM=
X-Google-Smtp-Source: AGHT+IF92LtyhLQu6LpObI4fvutoSbNTFhB4dvmwyPKHerXCsoLoomwrACyFPevb6bKn82G9dNyamQ==
X-Received: by 2002:a17:902:f544:b0:1de:e47e:116c with SMTP id
 h4-20020a170902f54400b001dee47e116cmr2494974plf.39.1711097989319; 
 Fri, 22 Mar 2024 01:59:49 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a170902d35500b001dc9422891esm1360749plk.30.2024.03.22.01.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 01:59:49 -0700 (PDT)
Message-ID: <699485f0-4c96-4d63-ad09-276e22c65c02@sifive.com>
Date: Fri, 22 Mar 2024 16:59:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix fp16 checking in vector fp widen/narrow instructions
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240320072709.1043227-1-max.chou@sifive.com>
 <CAKmqyKNN_BbxV-Qh=8gOCpb6z6RS2qmGajj--XU7XgnZ3ks10g@mail.gmail.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <CAKmqyKNN_BbxV-Qh=8gOCpb6z6RS2qmGajj--XU7XgnZ3ks10g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52f.google.com
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

Thanks for the notification.
I'll resend this series and rebase on the riscv-to-apply.next branch.

Max

On 2024/3/22 12:12 PM, Alistair Francis wrote:
> On Wed, Mar 20, 2024 at 5:28 PM Max Chou <max.chou@sifive.com> wrote:
>> When SEW is 16, we need to check whether the Zvfhmin is enabled for the
>> single width operator for vector floating point widen/narrow
>> instructions.
>>
>> The commits in this patchset fix the single width operator checking and
>> remove the redudant SEW checking for vector floating point widen/narrow
>> instructions.
>>
>> Max Chou (4):
>>    target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and
>>      vfncvt.f.f.w instructions
>>    target/riscv: rvv: Check single width operator for vector fp widen
>>      instructions
>>    target/riscv: rvv: Check single width operator for vfncvt.rod.f.f.w
>>    target/riscv: rvv: Remove redudant SEW checking for vector fp
>>      narrow/widen instructions
> I think something went wrong here. It looks like you meant to send
> this as a series, but somehow that information was lost in the subject
>
> Alistair
>
>>   target/riscv/insn_trans/trans_rvv.c.inc | 42 ++++++++++++++++---------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> --
>> 2.31.1
>>
>>

