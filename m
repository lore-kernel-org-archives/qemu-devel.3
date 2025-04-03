Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E18DC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OV5-0002LC-3n; Thu, 03 Apr 2025 13:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OUb-0001uD-73
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:36:42 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OUY-0000Zs-JJ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:36:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so1444432b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743701797; x=1744306597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nkmIbvR42ogv/r7XYwhe/QIpus4FDXCzdMRMUhgzI40=;
 b=RWed2FKUGEamU8KiW5Rn/Ui5AEtYxVCAAJ5Js2IOk0KpkdUKbT/RW5bnvv+Zxe8UfY
 Q2EJz/CH2UfQWMBHw7SBZhMMfCxyMlRlvfDi/INCqqlTAynCmWATLA6FPuZdxQpQ/KEL
 xOj8+59neJFe27Dg3RKoctgNS9leHZQqs5IfROGQ4kthFgdrW/Wn9q2cEsNIz9CbRmLZ
 wVa9lhm+8Ofs+gLd9BFrfJd8mxTnF6fLOUEMqh2h9DtLgRuzN2aYXJ8d1Uk8i1Rii9kU
 xD7XZrvVZLCn6xdecFBylMSL599ERiz2VMpvqMSbFYQhZ0RK+2Bf2BNDUKwmZ1mWYxga
 Hcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743701797; x=1744306597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nkmIbvR42ogv/r7XYwhe/QIpus4FDXCzdMRMUhgzI40=;
 b=ttD9ONKCIIWKrTprCzwtj8C7bJeaFHySajORD1pobvQ98XilTjT+pkb0Ayp53H/HRZ
 yH2rVP4VxmMWDj/WjHSy0j6GmdSE/FREJ7tuu1YmJzh7QSMMq8YtjV3WVOZZnwr2551J
 Cc/0wEwnwda0hg4AQExG2ZayzVeR9dOoCJIGH45SKCQd0bS1pwqEyOVkIUF8YaczMBAY
 MTJAGb3Dz61H2FCTjrjNUB0k05UgOsxuJSUuPpRJjUSPV2DEBdd/LQZtlHBv8ewufEXf
 HYORKhztIveXJusJ6KiCrMSwL9KvCImh8DCMoexb3Hnm5wwohGvdCQFqKtrpZjH5d8sU
 vm7Q==
X-Gm-Message-State: AOJu0Yysyq8LJoh+/j78iWHGdiG3fozOdpsMSoOgLE/nTsKUje2dGkV8
 IgvbCMs3zeaCidm7i6PynXPKNYvXo6frGw/h5s4rrasFEr42Jb+KtOHAs3SW46lOEE1YjtPRvaW
 k
X-Gm-Gg: ASbGncu1twu5Xzkd5T2a6eih++y0F1SsWs6o2WbXai8bGhOduUk1dBUDL8ip4oI6+Wy
 Fx9Ardsh/S8Gt7CjZDtSpwUNBGgCCDlB/ItaFI3KDacThwGU9bb+DqOYlKoqwNE7i25MEzL4kJv
 nA2IK+kSKu69W7+cA2BWP/56YNRs4ZEJw+kx92Cl8+vDWhLKVASmJxEKnmF59mtOuK0IwPCadlU
 +dYikIZMpz/14clSIAsHQBhf2g8OnlYikD4cSljGbim6LCG0zR6v/7PgGAy+5jjF5s+CkF2dSMc
 cmRICI13OjxxQeERPcTRELESTUYDtyDhpzSwQ4MPIRXRqUDA3fUw0xyMVSBKcLNo1rNC1yyTFRk
 cs+QW3M8E
X-Google-Smtp-Source: AGHT+IEqQ4D1KvheGBMDFVr9ZldZBQXEH6+aSje79RukGu1hZyLh33fEAafA/yHm/7o9Baq9xr7z8g==
X-Received: by 2002:a05:6a00:aca:b0:736:34a2:8a18 with SMTP id
 d2e1a72fcca58-739e4f7a0a5mr425852b3a.24.1743701796704; 
 Thu, 03 Apr 2025 10:36:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9ea152fsm1784314b3a.116.2025.04.03.10.36.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:36:36 -0700 (PDT)
Message-ID: <291a5458-4859-47f1-a9f1-c0daf8205784@linaro.org>
Date: Thu, 3 Apr 2025 10:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2 06/14] hw/arm/virt: Remove pointless
 VirtMachineState::tcg_its field
To: qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403151829.44858-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
> VirtMachineState::tcg_its has the same value of
> VirtMachineClass::no_tcg_its. Directly use the latter,
> removing the former.

No it doesn't.

> -        if (vmc->no_tcg_its) {
> -            vms->tcg_its = false;
> -        } else {
> -            vms->tcg_its = true;
> -        }

This is a stupidly verbose not.
But at least the names had correct logic.
Therefore all of the uses you replace need inversion.


r~

