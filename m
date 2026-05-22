Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F7ECD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQW1V-00005H-Bp; Fri, 22 May 2026 15:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQW1T-0008WL-Ot
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:59:07 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQW1S-0007Hr-Cd
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:59:07 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3697f25d26eso4074055a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779479944; x=1780084744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6oMW9zb14EtLdW5uFRh0YvojS95OqvxMZ2hO2by1IQw=;
 b=lfQtAIsAcH0H9woWcUBLhc05QJgab9aQBaFasYkkhuW2qNnZjIvjIPOLuuhI/LFPsh
 6nbdUSCq08Xpi16iSUL/XHGvAL2sbq0ihHnFMgBbtvwa6ignrFq9UdVKenW8pCP/XyNX
 iHFMfrHPivBOFhnuokiE21XtE392Cm/zzAPFcmvQFyXDyNwi4XIm7RH2w3HZCvKImp3A
 1rAoodEF5T6gu5/Hqx88c88oKbdNsWyAyqtFeWBAPtG6MZHVTq8d8qswqo6CD64FQmAh
 Iz41zgjZFazkjAg6q/qCzxF5YT70298po56W6WCwfI1HKrQ4yFiVTtlp1Y0mj1nypBn3
 Ri7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779479944; x=1780084744;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oMW9zb14EtLdW5uFRh0YvojS95OqvxMZ2hO2by1IQw=;
 b=nQ67FpNEpmGL/vmDkb01TkSSNB479g+eiKRa/4ao6gl8xS3FArWAJbktXQp+WLd0S9
 FumqrcZU5Nnmrxg5GEgZy214/HT0/uFH6beqg5Yba9kaonf/2lPy3JjMoSFKFATnNZo9
 L+6yhBx2mX2M0bMIe9OAnScCNwSepa+cDSvk7fuMXEJF14s/mnoBJivyM1/Q968ilEOD
 vWux68ZdrtU5dkWQGJMgarsgeUboMrf3gNGU2cprg2YsHmnOPf3XGSp22mkPQbWWSzGs
 +RC1b6ta4Lkl2dUL3/inTvXW6kydyk8CM7y5VTOQPPd34XB9NAbNgKL3MFulFwxt4Jn8
 jTOg==
X-Gm-Message-State: AOJu0YxMxOciIbuz6WksscckuHMkE0kFhAEeXsd7ERMhsdpGcZwhS9Xx
 yZT/jLZO+M5iLA4HN9ofh7+F+5EkQAoDYkhRvHXSr7B1aJamxOJIG9vMfXqXhIMtDX8=
X-Gm-Gg: Acq92OF24Ql2br+AsGgTBo+EN2CYZeAUDCPChRqLDNYjfxpY3OTooLyU1ni2kb4R7f9
 w4myDUIASTwGTkB9OXmMqgGTq92dl8oim88jeX9BCdFfiSVy+UV6rPE5AhHQnG6RBHDvM6e4qKl
 cNQRnKacaMqGyDMc5Y2X8C0ntzUY3bn/fmUxHo3MqSdwxJjlElHqTyr98rzrAFxh0lS+yQi+/ON
 qPIDmMoyOCpaM4s8gurqX035TUSBsrvicg7jv+SwM0/7HKJg/8B4ZoIrV8CeA2jbYaJrllOQZ+N
 1CUoAxyLOArxgqp+kPQw+Cp7I2Ghd9HXrh0CeUAdTh1fixxT0GZjpEWlK8DziAYhP7RbvsfZ/Sm
 vy3FzBWm2FyAbZH0o8GUUFDkoBCE3lwMt+xzmkU4S/PE1LTWc38NkB13BdGv41h4Ci7ySPcWsdN
 lW5UoqiBDooARgF8Lkm6QX/sEr5L+w4akl7qugDdkyjbo6iUWi2/A=
X-Received: by 2002:a17:903:1a10:b0:2bd:2430:eb7b with SMTP id
 d9443c01a7336-2beb06cbf6cmr57131575ad.12.1779479944505; 
 Fri, 22 May 2026 12:59:04 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3c92sm26599795ad.42.2026.05.22.12.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 12:59:04 -0700 (PDT)
Message-ID: <14f3e7ba-1474-42e6-8407-552689f12969@linaro.org>
Date: Fri, 22 May 2026 12:59:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 31/64] target/arm: Implement BFCVTN for SVE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-32-richard.henderson@linaro.org>
 <CAFEAcA_DbZ3m+P6g=+uEvVJCSyUCuTdzDN26xwXLPTRrZLBOwQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_DbZ3m+P6g=+uEvVJCSyUCuTdzDN26xwXLPTRrZLBOwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 5/21/26 02:01, Peter Maydell wrote:
> Or we could shortcut the packing process and just return
> the right value:
> 
>              /* maximum or minimum normal value for E5M2 */
>              return 0x7b | (p->sign << 7);

Good idea, thanks.


r~

