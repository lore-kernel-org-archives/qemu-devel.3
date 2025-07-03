Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCE8C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJz4-0003F3-IC; Thu, 03 Jul 2025 09:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXJyr-0003B5-OK
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:28:07 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXJym-0006IL-FP
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:28:00 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40af40aee93so5131974b6e.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751549274; x=1752154074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQvSaujiB706Ut32uaeqXGB5yxfA5mLNCs2OYM6GRmU=;
 b=WKSS/VKS5G6WiMbRlbVU+ki3bPFUjB197FxDYxLWnDvNGshpfk6cWrK5Myi20vm1kx
 xvmHIgSJ1AesAE86xXrFijFaUNOx1lDq17xbvm6wkJN/a7JaFzA9gg5lmWewpr5xZPqb
 nuSXumUtPAERFLoiOvIWz/0Ech4gJ6gGOnOgA5WXmBaKcRoWqFk8AamTlnv3Cn2TLmUz
 uJKckLRV1Jj0BR0QkNN8H1TWYvTgt5TIOCpPa7bkoao0q7tm9UwyrrDEamofakVQZDIV
 DLFjxV2mbSlCNZvx/Qo5L2XiQULAKCm2GVdHgSFbKV+dqvx5RNwHreajpzjNKHSbnspM
 mEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751549274; x=1752154074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQvSaujiB706Ut32uaeqXGB5yxfA5mLNCs2OYM6GRmU=;
 b=wXFonk2FdBmJHTYhjEBG6SBxPZPiSh7JATbNajRXgsL/t9C0j6RZzr3cLeuIN+r37g
 n592BjdV6TIwHv4vSLc65KFalmaQ/s5ZuY45+QLfcKgENrkfU62zkUDfMiJF85nBFeMi
 XteSLgtdRkqTTfm2CSa0MzmD57MN0e2jrjVyH/gjqth23KUnUu9LiCRVDhqlGF9uFKhA
 SoNGcCpy+BrfPUq84ex0PKlHEHY9V+LMONkOnkO7Bw8oavARi0J5bzDXkl0ge5WOPzrD
 59B/jetCfloZFDim99AOfc+lD1ejYJlxRoPLkbLoCokGZ7hZH2T69ViI8Ycoh78CldoY
 S+HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSCfdspaelqv5nQCYuEWSS6RdON7eQkm0EAYL75R+Te+H7mRyt0CwMf1jMF5M9CN9jGzTJgnCObOUG@nongnu.org
X-Gm-Message-State: AOJu0YzC7Xoed8qqFRSPeaRqkuBIOiY1/XMjLvGH2pr7IroWWD5x4pQ8
 TUx28neilt7oKZetrpoWyX8cMmJib10J/EEEGH68Hw0ZGCirhByNHxODqTgQyN5sQIA=
X-Gm-Gg: ASbGncsxRhIK7lN4eUt7UgK0SrEmz+L9fdJrWK+cnFJl7MvhRSSodWZLNITANiTCUGe
 hIbEK4smUqUcKLThWHkmzy/XwvgOB1uv0Cmmu54ODpS4M631YOr+0WR6is5EEyddHpr7c5RrTy6
 4UMxzbgirDwkxUin0cFLT6XmCGuTizgR/G9cLY80mKZapYfMLlsADU0h9UpC5ZQIZ065G/KaioZ
 SYaSGplSbNWw8nO5cQSKh1OUNCgcmANvt94unqEZ0Ohw5v1/lE3oIgFi6NbSZsYtsPgA7oCCIDz
 jgDeZRCy8nrs6/sMzJMwkTfSmH7UX83JKK1XQT4ZBX2s2yF8XqeOwjd2rhA6u88czvRPhykgOu8
 EyQ==
X-Google-Smtp-Source: AGHT+IGuQGD0oy88vidmcdrLDkzkQq//TpwWvCWWdN0k4AsMQeLJnENv0b91OdUC9o0YMTB1NmIv6w==
X-Received: by 2002:a05:6808:81d3:b0:40c:f644:8abc with SMTP id
 5614622812f47-40cf64490c2mr1152705b6e.13.1751549274096; 
 Thu, 03 Jul 2025 06:27:54 -0700 (PDT)
Received: from [10.25.7.115] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322c1e25sm2984697b6e.20.2025.07.03.06.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 06:27:53 -0700 (PDT)
Message-ID: <fd9d56b0-ff6f-4427-927e-c502bca523f4@linaro.org>
Date: Thu, 3 Jul 2025 07:27:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 57/68] accel/tcg: Expose vcpu_[un]register() for MTTCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-58-philmd@linaro.org>
 <89ceef1e-c4c1-45eb-a369-a17f711ef4ad@linaro.org>
 <72e2855d-4ba0-4933-826e-d38100e9a46f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <72e2855d-4ba0-4933-826e-d38100e9a46f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 7/2/25 12:25, Philippe Mathieu-Daudé wrote:
> On 2/7/25 17:19, Richard Henderson wrote:
>> On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
>>> Allocate ForceRcuNotifier on the Heap.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   accel/tcg/tcg-accel-ops-mttcg.c | 30 ++++++++++++++++++++++++------
>>>   1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> Please document the motivation.
> 
>  > [...] the structure is still not accessible from anywhere outside
>  > of the function, and has the same lifetime as the function.
> 
> We need this to register the MTTCG thread in split_cpu_thread_routine():
> https://lore.kernel.org/qemu-devel/20250620172751.94231-12-philmd@linaro.org/
> 
> Better to have AccelOpsClass::[un]register_thread_rcu() hooks?

I think this is more complex than it needs to be.  I think we don't actually need 
different implementations between mttcg and rr: we just need to make use of current_cpu.

I'll experiment with this.


r~

