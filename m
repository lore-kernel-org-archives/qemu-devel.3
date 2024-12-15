Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87FEE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMq0K-0002He-Fk; Sun, 15 Dec 2024 09:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMq0D-0002H4-Rt
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:53:50 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMq0B-0001Uj-F2
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:53:48 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e173ed85bso1551951a34.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734274423; x=1734879223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UsnM0JRnC0P4kaeVL3x+zS951wOKBC914tiNbZYfu40=;
 b=hGTZR031L8VVjKVmvmCOPfvzf/NfeOc485gCCcLlzcgJfDMsVlWu+R2fOzM2+W0fMw
 r3y7LhKoWIz0rga6M3gmLM6H2c9B4Q5DQd7DveBtH/zrOMaAe1x8/P0xQfRg0cxrk0Ta
 hA1z3/meJExX2RCrF8BM0a5pK4MTJNuYkDtEG0ZAuQu3/EpOsiK1b9WUYCSHLk2hIPFC
 C1oqGlpwO7qRPFKH9ZksSBQsbzbbfjfYqk18RLAPWwbFFzOjNMLbAYvQCRwDtDgTGtAP
 xRvSaObVFUB5hyoeLJ+ofYQV2h/rhGFtDedqLUkNjUTrogasJmD8PGKEEDo9oQmeb4A1
 qWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734274423; x=1734879223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UsnM0JRnC0P4kaeVL3x+zS951wOKBC914tiNbZYfu40=;
 b=v8Yfr6jRerprkeUkVNr8QLK8uibb8xCkVAjTT9rZcMhzZQz/KFpfWISwwyGqVvXill
 ZmfJNOnlUfzUCQFQGyrH++JPnPLN1BpE011+Fa/7IEhn1q9hvSz6pEspgbd8g5CqxE9l
 zLrPXiyCWEpjX32giHME65n7RA/65v3cesBzCE/E8J/ReAuXNzO+2jStgqfuZtAQSRqM
 ifVTnmr2dU6rSFqKovEvZ73TPK5TIy+OVNX5A6pvrp6K+HbLk1ebum6Ahk0pnWdb2E0V
 jxn39Gcu/pn5L+QGGDV2EXZfpNARcVRBNUv3IWuZGSnLTWesx4aLlQ8PxOgRbt9zyZFn
 i95A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXQi3YjldjyQcjxygsRrphvG38YJ2pMV2NGS+xGwejQVOApXgd37KI+N2XUfeP1sqwPa1IuV9A2bB/@nongnu.org
X-Gm-Message-State: AOJu0Ywi8UWvg7jR5hI2PuDXKjz3GAuzobapQHrjkKBv13u6MEHDPJRe
 GSrKZGT2qOQ1fFScEl3ejD9R9zA0E8hV7xUbPR1ChNzXBgkwNGMMZxAfgJXg49E=
X-Gm-Gg: ASbGncseQxwlDYaVw7KOgRImuoZbV4YLrhOZkd9G5/065g45+r++H97z3yWq6OhmFHX
 gBq3Uf4o+eQKzDOY4TyQEwtvG3aU38KpWe6KzufbQ9gKt3JbMQdAKTowAsrHl0w4PSMS3V3wdpG
 IM7xHofTviM9/wPY9pCJluzXlTlBlpeJEHqRB7MFw6Ht+XIgfo8MBJ4Gd0YxratKKQyUKQbeDia
 f2sYqDBKARXlAH5ft88W9AEta6/ygtOQNofiQRZi+2+2ZKJRdKiS+GHfNGQvZETPpEtzdNtCloS
 cJe3WGU7VIH/vtC3VSS6ZjTF84JbAedEFAE=
X-Google-Smtp-Source: AGHT+IHZHI8c0VM7+YqIaiZhvLTw23A+B/7xAVK/1Jdkn4hIW/S8O8v7H1h44f25cv3cNp4aF1TiBg==
X-Received: by 2002:a05:6870:7810:b0:2a3:8331:717c with SMTP id
 586e51a60fabf-2a3ac5a438amr4742245fac.10.1734274423284; 
 Sun, 15 Dec 2024 06:53:43 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2913d16sm1214890fac.35.2024.12.15.06.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:53:42 -0800 (PST)
Message-ID: <0d59211f-1433-494c-b3a4-f871484b271b@linaro.org>
Date: Sun, 15 Dec 2024 08:53:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] target/i386: optimize CX handling in repeated
 string operations
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> In a repeated string operation, CX/ECX will be decremented until it
> is 0 but never underflow.  Use this observation to avoid a deposit or
> zero-extend operation if the address size of the operation is smaller
> than MO_TL.
> 
> As in the previous patch, the patch is structured to include some
> preparatory work for subsequent changes.  In particular, introducing
> cx_next prepares for when ECX will be decremented*before* calling
> fn(s, ot), and therefore cannot yet be written back to cpu_regs.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

