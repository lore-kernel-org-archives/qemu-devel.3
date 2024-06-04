Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783CCC27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUvR-0007JX-90; Tue, 04 Jun 2024 10:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUvP-0007IT-Ac
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:14:07 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUvN-0004cn-NC
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:14:07 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6f9415b5e8dso137074a34.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717510444; x=1718115244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u4I2jI3skLqdAHJv2/DYas8VxTh3Bt9qot4hvrYdWk0=;
 b=CwO1fIABfKMwj+BzfLI/8r0BV2OHoBXRvxhZcZfLPXp/5z6GUT8tbn4NtuOAIX1sDy
 eBPNPfyiVNulXbn0kqXu4W8L/78CcOw6lYD/plYEvl7rEmEMg2jEQRtAJ1fDB+A78Krq
 jBSUol/0tlkpfVuT48AM3Cmexbqprd2G+n6g60b05ps5pMBoo8yeYQqagyIo/VBogELj
 Wglh/QU3fgYwymEIFSCeqo3k0ygdG8e4vZq+qMV8Y9pKTxfqm93TZAOyOqOJA+fr0S3j
 DAUR5+d+qCeKFKcnSCQofNRSXRakje0QQY24mLU9uAl/j5sFn88X1kshGKotQpc3bMIv
 nO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717510444; x=1718115244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u4I2jI3skLqdAHJv2/DYas8VxTh3Bt9qot4hvrYdWk0=;
 b=Rm5tRRgcZhNIDfdlC+VgjJfq6gpF+fCPgggx9v38n8zRj/c5mLXuicvAOdXKA1lzS+
 G+Yhk5EeJ9jrgDGeCF2NXF8GWsxlxJi9LQi93FdFwge1RF/VYKbPkdwtNI4/3InXc8nj
 5l+dFvmN19hCBAru3eHzfFLBQFtF9/7mx7VgP/zB4dccy7euOg4/TsuUP4+OsJG4jiHP
 Ya6AUpSqBMxCLjW+y1ckZ9DKmGF4zvzUjwNeptMG1sr24w+T9rGbTzWOTxcBT9IbosGp
 0ONL6ytUWl86NIc5YrBj/+GIDU4xSysZWpJSaZZtqYp3TBQRmj9Qyiu72gJ++hOFHef2
 xUUw==
X-Gm-Message-State: AOJu0YzUtMl7brqitVMFKYuuISy1Lw7lRt/VJM1BgukEeB3o6BRjf61g
 tsEnTyF1HydHenyu7n4qyIlYr9muKs+67NmFqOglqjpQzsWqNl/chlFOna1myfTuhv/igXwb3Ex
 4
X-Google-Smtp-Source: AGHT+IEMtTUWddAnyoi62KWUOeTdJZjvzQ9PaqUxTii3ZtcBbWTTQVu/LmanIXBvIkdW5PQ7/gQX9w==
X-Received: by 2002:a9d:6755:0:b0:6f8:d23e:78e0 with SMTP id
 46e09a7af769-6f911fc9917mr11780869a34.38.1717510444089; 
 Tue, 04 Jun 2024 07:14:04 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f938b44e77sm415912a34.55.2024.06.04.07.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 07:14:03 -0700 (PDT)
Message-ID: <78de6c80-2d40-49e8-b118-9fa7e364573c@linaro.org>
Date: Tue, 4 Jun 2024 09:14:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/i386: fix INHIBIT_IRQ/TF/RF handling for
 PAUSE
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-9-pbonzini@redhat.com>
 <0dc2521f-7d7c-48c1-943e-b71566284450@linaro.org>
 <8855bd45-9b9c-485d-b737-2f23f0da6406@linaro.org>
 <CABgObfak+jqkr=wQvxfz9D9CHt3fgRzu4L5tcZbmOJabtEBTxg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfak+jqkr=wQvxfz9D9CHt3fgRzu4L5tcZbmOJabtEBTxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 6/4/24 09:10, Paolo Bonzini wrote:
> On Tue, Jun 4, 2024 at 3:49 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Oh, based on the next patch, it would appear that PAUSE does not single-step properly
>> because it sets EXCP_INTERRUPT, and end-of-insn single-step depends on exception_index ==
>> -1.  I'm thinking of the bottom of cpu_tb_exec().
> 
> I'm not sure we're talking of the same thing, but that's why I'm
> calling helper_rechecking_single_step() before setting EXCP_INTERRUPT.

Oh yes, that does it.


r~

