Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503F5CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrVC-0006tN-AN; Wed, 17 Jun 2026 10:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrVA-0006t4-GN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:44:24 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrV7-0004o8-6g
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:44:24 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84532e3dbf7so225514b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781707459; x=1782312259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUWWs6kVCTOA687RB/+JMtppAOHIpPHd+AMyF9TBRM0=;
 b=zT+9soJ9K+HokGOA6IGD5iYZ1V8gyMPNdnEkd0AMfdMZ506gHOJ8Nu2wOdc8PiMc1u
 W5HBC3ugesCFIBTizvAVsSa2XH8UxAboZEoBEp1AH/mEEFEjyzxZyUU91CcpaD8oHdQI
 wS/LQ01mYFQZuzpA7YS1DPhhMcxfItCyl9kb3f4ZbXCCJt0VCeD0TbX9vG5qdWyOjCuL
 5r+lQfxfI7JxhB0zOM+fkVNbP91EkG6ZjJHHxPSuUwPAiIoDHA7WwZQgMFZA5uLQG6FV
 0p8mO4ag1ECuGpYmfnXvrrpdtHoyJCkZYqa4GTxY2FjtSlZWXOK90TdZoB1nlEI/9PU1
 y8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781707459; x=1782312259;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TUWWs6kVCTOA687RB/+JMtppAOHIpPHd+AMyF9TBRM0=;
 b=oVkpwS5wpLJ8tQSaTOgLFsuw5NVUFKG6yhW/5x03KmF+kEy71NjZH0qGdASTwYQRdt
 jYobVmiFJ1BlBd2mzV6j4gfAUAP5KRybKVcjjeUw2jQuFlmSRxjB3hBUDgA+1U7PBqaD
 Q+vB+JrU3oafJd+tHJQD2GMahnKRs7z7mmYSDaNuEdZT5KiqM/2T1wEy2rFI9Pp1VWxp
 rNejK1xWL+HZLwYb4i21Hr0qF3cp4afHSxtrBgMX9Q9m6Ico1je7XrSfzxuXiNacEyQ2
 gzLyrWw9+HHvttXfClTaiDLe8iejbKEGY+7Y4GGO4aqdoid9wUisEkcZ8Cn4W9mjU9wo
 l5lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HGYKAgzC1gIbeSjyhsdAys7MMQDmxLcgvtJpd3BgzP2ZkuAb2Jw1FSaKLfkvNQns/Xr6w4WghqKW7@nongnu.org
X-Gm-Message-State: AOJu0YwrHn2FAmBHRR+HFNFzQ2JFvSmykKhFIeMYwhnbhyzL9x7Q7bby
 FdN3xbLufmwtZPxRB52wJ3fZ9lBpvBjEws+/ik+H9vbDnvjagN79mODZVMQUVWVW4Mw=
X-Gm-Gg: Acq92OHcOan8GwAuIXqsVf3TxivFRINDJi23plBVWQCghgbgEOmEaeE7BazR1xRHsXY
 dUJLvP2VzaJYnpWq8j7j09fxbokd04YDAXWwE5vEtdxi995bdbQhPzqh3C+/U+mm+n6T77ZDfJb
 ztIDFVhAU/L7JrExNaOKOSYSh/kKct0xLra1yw3LlfQ5Z4XrYuVPZyctFwrLLJV2xBGNP0l7Jv5
 R3xL9Xhw3ZeXjqvARL5Aaim1S/3QGMPDaKa1VgK0S8ZsL+u/ugSsmIwOEUTzHSMPsJtRg2BxwRf
 i3MPWjJPs9oQwtg3wcR8d0MPtxyL6Y0m00mtXxilzVBYaGHwSq5NjbwwIF42q8x00eFSjYOLb21
 cPKQ17xnU7W8PUBUkSdLBQzNo4n2x0QZto9lI9W69izvVVOeD0DcB4FUWiq9lVNFEOTayHuTb5V
 qEYSg16AQB1I5vStqCDVQCsjoIAWwQej99ug52tbxGOYJZ9eSwgZw0jzOlOA==
X-Received: by 2002:a05:6a00:cc7:b0:842:1ffc:55b5 with SMTP id
 d2e1a72fcca58-84524550684mr4312659b3a.26.1781707459318; 
 Wed, 17 Jun 2026 07:44:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9cd8dsm15960645b3a.1.2026.06.17.07.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:44:18 -0700 (PDT)
Message-ID: <8633117c-e2e7-4e68-8684-6b7bb6b6fc20@linaro.org>
Date: Wed, 17 Jun 2026 07:44:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] accel/tcg: Have cpu_loop_exit_requested() take
 const cpu and un-inline
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-9-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
> Of the 5 calls in our codebase, 4 are unlikely(), so not worth
> inlining in header. Since the CPUState is simply read-only
> accessed, make the argument const.

Unlikely to trigger, but still called within inner loops.
Please keep this inline.


r~

