Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D466C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveWO-0003bC-8z; Fri, 21 Mar 2025 11:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tveWH-0003WT-4X
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:42:51 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tveWF-0007lD-Gb
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:42:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2241053582dso8525165ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742571765; x=1743176565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yPv0x3Z1/HPbUhKDoJiJ7eKUBEGCPwgiGSQ1X1h313g=;
 b=ymBPP5zQEx2MxCJFiTXSp4cmb6EP+xanp2QaWyGNPQx0l21hkKiFWy8N7AlTY/3Uue
 CslitI/TRCF8EomNs3AR7TEohgk9FkmdMvC/GS3QCOvlRfjStdig693a6Z5SUCz/PJDm
 TstdflCHRfnh2GooM5OYgjxrAdZdzbE5VgIBAec8axNolwEpl0p/N9OouABe2TU6iaST
 LI/KSQY55iW4p+odjRPssNftVRk6lLZkUa2C0HJGElTykPJMUB31SJyAe5Z8yff2wtPp
 CyOCFQE/GmgJUZY/8pTVXfefQ5bOSUdy6mnuwkkC7N/H8WJyoBVIOLkpSKdiyWBWnzct
 7mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742571765; x=1743176565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yPv0x3Z1/HPbUhKDoJiJ7eKUBEGCPwgiGSQ1X1h313g=;
 b=ZuVlu13z1mOFdpiaP1RHpZOg4GNx/gog1vJkp3p4VWTcMtjupvqkPdE4OsOzuuqfN2
 tEGriIQGH7t+1sayUqfqcIMbzSMnmo/vditaCG7kbvR2jG9tc0bfb/ASydnkzg1v206X
 fIO/zsCe8eHSCd/uUAodOBgDHh9Yaq9nZACI2GQ1wQFYm4fJrmC9U9Fpg8nblQ9IZB+8
 Ew8tADG4GbZiFq59xdgTuK+BACXrzmuc8JG38LQJJ8RFvwDbmMiRtNSScMsARWk7TCIF
 lBVDvpcWt6ks3D47JQQBxSj3ZuKVUOCL8QLGBxpnVjinteQyq1ZCLroZ4NMIsEgoY1Qv
 R8eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcrBfIFkfH2r1JdMHZyur2YpPL+FUTa4R2F9quR7kmKr2J1mkuN1q1p2ormMnGnmIR/z8+FW5BOSAv@nongnu.org
X-Gm-Message-State: AOJu0YzDRGKMfLx7197oAHvcb4bB0FNIAVwRxuDcah9MoSeNytCmOW0P
 trhHmLcJ+LLkBQ0IQpPv3PGuu0to9vhxj1jlUZ3uAXxk7FjvB/4hhygK2TT+eeA=
X-Gm-Gg: ASbGncuBA9cdrqx93Lfew6RJKe7wkqUltqtxQ+CaZZPgrP0MKehP5N1H3fzbIrIPbIm
 fUIa/Mr/e5VMmx7voG7NLDLD44oeywroY8pv916EOjhWnoaEML2uyTtmkVwfch630NX9lgggnnn
 FxA4kJZmZG5xST/Es2jdfk+7j+7rSSjIio0FLqdONOx4rh8opPyTgi1JJk3loa67uWaWqcRrj5T
 qkvfDw/7035RRmrNx8GLeHANX5wK8hXcp/wmvQhf9hj/5xw2LY+DbaLUnxu6Oq7Mpl4mN75WZCU
 s6Q+hUZQP6L2uEAHf0hxPPf34uXQAipDpI0FixQH6fYWultK4MYX4ujEbjrg319wPZ/J0ql32B8
 LGoyw+9Ydo68jFaMyVeQ=
X-Google-Smtp-Source: AGHT+IEJWPCbapPvGinlQxgYSSIe5Y2Y267EQ5fu6sUpIbsI0Qm2IeL2lKtJmthiaWExNJRDxAa+bw==
X-Received: by 2002:a17:903:2350:b0:21f:74ec:1ff0 with SMTP id
 d9443c01a7336-22780e14e77mr61853175ad.32.1742571765209; 
 Fri, 21 Mar 2025 08:42:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf63610asm6221455a91.44.2025.03.21.08.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 08:42:44 -0700 (PDT)
Message-ID: <dfd1d8d2-9d08-49aa-8f74-50394e20378f@linaro.org>
Date: Fri, 21 Mar 2025 08:42:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/30] include/exec/cpu-all: move compile time check
 for CPUArchState to cpu-target.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 4 ----
>   cpu-target.c           | 4 ++++
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

