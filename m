Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28463C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8rz-0003FK-Ct; Thu, 06 Feb 2025 15:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8rw-0003EU-B4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:53:04 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8ru-0005kV-CK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:53:04 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so2432014a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738875180; x=1739479980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QjZybIGWUdxYTEEIeCVgmr9uoXXBp7KTQl++Zjx4Zz8=;
 b=qvKfu6s5EpAW7pgFdJG2erSPsMzHtenunqesiaObxhbX1uO10KT9FiKdL/8A/PMxOX
 6AaoxC1TH8eQcplz7a+/xdUhkt2KRkcoHpRY4hUR1QtxgIGsyTBoQdC6BBdmGQHpQmfM
 /4Trvr20vzDMzsZtOqtLzcHGVYKMBrAkQGzTqiYZoqATgf3y6++pvkeo09ePAGDjaYCL
 RM+v1Qdw3CdTdFlop0m9LiwutzdPpzy1cKLMqpKeLGxukg8uikzmRSdA+2UmDqGlMgy+
 mLBliN8EYLMfhRhaF89E7kCpFlRLifDSVwUNypDYa2nJn23SBpUR9emCo6eplU73Yn59
 ff8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738875180; x=1739479980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjZybIGWUdxYTEEIeCVgmr9uoXXBp7KTQl++Zjx4Zz8=;
 b=exJ5nnfGQc5IoA+4qfxwRJqf/dSQ7/P065Suo7J21NZBTAU6UrBam18v4FjGKekAeq
 XLTV28OkqR20F9sUcwQvKEXqm7sBDvzOp36vCfdreG2quYmcgZXRpL6PA6Bk0+jMsf+c
 FmgtiVLa5cT+59jHzW+JkY4tKMnnk6up6ciHqvYYZhBUs8wL591bAa5HFhUBE744AtIC
 EPnbLRgvoISgDQm76ZYQ/zT2crO5ppbaONQkAEHPLxWj28qVUmWFFvFrd74z92lcggTl
 HbChgF8qn/7taK4dJyrQVtsWmaavhD5xxrJAPQLcj2K1CqftL6DQrawk6/84i7SIrg8C
 Q7Bw==
X-Gm-Message-State: AOJu0YwNb9wEs2VNksOLHfi0l+GDZ3+sKSNUBbcbtDlV7uYs7ylR7BBf
 sYtLxXK5IGkJ+Bf7EBVOp9p87CP1ls5GcuOUQoGKLSxJLx7P2LGOagNCGq9DE6G3TwHIRVguHDh
 m
X-Gm-Gg: ASbGncvWKNJf1l3kl+9lwnLGi686ld0QYwUiEICncj5sXM0BprZpQb2rheLzO1t6SlF
 n3BL1lZ8/JQVMrZAHk76mjzwObLBO6HtLNt9047sDqNkO6GrySrxTuvbNhrEo50Yuh6vPJIxI1h
 QXyEi/eA8X1FCe6RgqjhVqVAF6bbCWEjyHJb36IoJQ43v0Z+XcP08LofW5wciE7e+5KaoZsqWRl
 fNkfoGDrcEqjolvO5ZbuEt7L8tqojn8UWMWWvuUDed0YDDYbHyZJTDif9+ui7+qL5j92oQUNA+n
 xUdZ8ZqYie1/1cOEgtIzBSKF5vxl3gmAw9PyWCcAYlOp1Fy5WOKjO6k=
X-Google-Smtp-Source: AGHT+IFMFY1sjkyQiE2sjDlwZguwMCbfDd7Ivhf4+yf9fEZWzTYL9fycHOckXfQa8RGN7W17tSIU5A==
X-Received: by 2002:a17:90b:3596:b0:2ee:b2e6:4276 with SMTP id
 98e67ed59e1d1-2fa243e9aaamr732110a91.27.1738875180455; 
 Thu, 06 Feb 2025 12:53:00 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b5c757sm1842904a91.45.2025.02.06.12.52.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 12:53:00 -0800 (PST)
Message-ID: <b06df35e-412a-4b62-b73f-ce129a118b18@linaro.org>
Date: Thu, 6 Feb 2025 12:52:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/core/machine.c: Make -machine dumpdtb=file.dtb
 with no DTB an error
To: qemu-devel@nongnu.org
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206151214.2947842-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/6/25 07:12, Peter Maydell wrote:
> Currently if the user requests via -machine dumpdtb=file.dtb that we
> dump the DTB, but the machine doesn't have a DTB, we silently ignore
> the option.  This is confusing to users, and is a legacy of the old
> board-specific implementation of the option, where if the execution
> codepath didn't go via a call to qemu_fdt_dumpdtb() we would never
> handle the option.
> 
> Now we handle the option in one place in machine.c, we can provide
> the user with a useful message if they asked us to dump a DTB when
> none exists.  qmp_dumpdtb() already produces this error; remove the
> logic in handle_machine_dumpdtb() that was there specifically to
> avoid hitting it.
> 
> While we're here, beef up the error message a bit with a hint, and
> make it consistent about "an FDT" rather than "a FDT".  (In the
> qmp_dumpdtb() case this needs an ERRP_GUARD to make
> error_append_hint() work when the caller passes error_fatal.)
> 
> Note that the three places where we might report "doesn't have an
> FDT" are hit in different situations:
> 
> (1) in handle_machine_dumpdtb(), if CONFIG_FDT is not set: this is
> because the QEMU binary was built without libfdt at all. The
> build system will not let you build with a machine type that
> needs an FDT but no libfdt, so here we know both that the machine
> doesn't use FDT and that QEMU doesn't have the support:
> 
> (2) in the device_tree-stub.c qmp_dumpdtb(): this is used when
> we had libfdt at build time but the target architecture didn't
> enable any machines which did "select DEVICE_TREE", so here we
> know that the machine doesn't use FDT.
> 
> (3) in qmp_dumpdtb(), if current_machine->fdt is NULL all we know
> is that this machine never set it. That might be because it doesn't
> use FDT, or it might be because the user didn't pass an FDT
> on the command line and the machine doesn't autogenerate an FDT.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2733
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/core/machine.c         | 6 ++----
>   system/device_tree-stub.c | 5 ++++-
>   system/device_tree.c      | 7 ++++++-
>   3 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

