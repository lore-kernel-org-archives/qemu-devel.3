Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78549CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 23:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9tkv-0004UO-Ry; Fri, 17 Oct 2025 19:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9tkt-0004Sc-2H
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 19:21:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9tkq-0004Nb-Py
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 19:21:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-290aaff555eso22952125ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760743258; x=1761348058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UGV1heWYP2fm9OrVWLRnCrVCO18BSnNRfRyu/awDpA8=;
 b=UPktqW+POzUN9/12RtUH6saiU19hUDYocc9yX3OoTWyCqdhHzaiIGCqhMwH/d/pvR/
 UAmHq8Qbim6ERLIb0hewSR7YUC5JQN0HPGx1XsRdW95yop02GtRVIPhqctt7Z7n4JRO7
 AqoRk7XDA36tNGA62cbPXk8D45enVmR7tFVnmylNnvXPTR8vhxyU4vhB3jqmQQA2SdFY
 AD7aK7VspGi4mkK9Jqvs8E0TFMmQDNy/OIWgvp0J5CMxa2CCQk4YEcE/K9fwCpL67EJX
 y4HMY4UzU/xpxZMJ1A6FcNIQ7OjsbTQuPuAX/0PWFSgJhrZY0Bncs6qvKEK2VJl1Hha/
 j6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760743258; x=1761348058;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UGV1heWYP2fm9OrVWLRnCrVCO18BSnNRfRyu/awDpA8=;
 b=a50rJkuSYN9OuZd6Jg/l5mNcBdD599pHkDDj0KmWa2u2XLfb8ISFvjs+CLXrFqq5iZ
 1fZ7wm4A+3rlEgTYILRFpyBCczXodCzrlBp4E2PyZKwAZkMljkYUu6gRM9LbdldgBLrT
 +Qip9Q845W7aXtoz+j5Oa/8bkWamhl5RIW3fFath7sEuOv50J8gY2+EBGB5KYDeRDQmx
 VwwJFAuOkO1buxWoGisjgYZkjNgip8kqbDb+QTIzqV1Ei/PCPq7A/uERyasKAJ93ljie
 EssLv/MzFj+2hDqFmkSXYuD9dRmRQNjCPAnmFFDTD+JsX0hxv4u9Id/r7umIrLnsdoun
 vo1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRLllObxrIBaRESlTiqvl+p9HzOR9DAh/JynY0RycW1H/eZwCb3r/0wb+w1mU/xB5v1zKu8Rmj2ro2@nongnu.org
X-Gm-Message-State: AOJu0Yzyen81Iz+byAqDq3R64FgJWASTsYlShenlSLfW3hmyVy+HLpSK
 CJX/x42dGp/MMNBHCF6HCLmA6T4Y97w0CF/tp1SfZAOXhNguahUCyWzndPKi3u2qJwoj26psDz6
 4QDmldqo=
X-Gm-Gg: ASbGnctjcJ1O9aHVx95HDpPrwgXufVPBscXh/5XxVgRU1JoXSMlA+6rh4pLKxPdbLxm
 RcvnIhtv8fJYUiwSbG/LeJEumpnzkBx8wVdZdiEO7yA4sqmr8DtqFAXG2AQ53d9Ca3g6suUmbD0
 4Y+5sMel57MyBqc8LRgBIh6wF8xOErNARyzvVxrCEe3kfeQhBTupKyIyaIbkcLm64SWr2iaWMbN
 pKcibQtxkv9EDIYeIiIJUL/PgphcdEL2PRgMXj7SqmHHvsyxStYlAfs8RbsSO/PF4Uznm9OHw+8
 YnVP5X8myqMKOa7/oF/jxsCbNa9jG6IUmwM7/CN5zwpWeBDOeIk/xeaAdzaZ2Enp/ZLlFLAQdui
 T93EpwtdseBxf4KstkxudNN1mPQU5wvoyul7e3vegJCfRrglxQzxFEKIUX+sy+N92xWEo5yFWoY
 b4SZhQjLmS+oAcfACf8nQpxFG5
X-Google-Smtp-Source: AGHT+IHzmzI4SAN88ZgRfS6MkYQCKg2NejDce1WNLtBWepdIek2Qt+ymGOy2hzb8KAtTxmvvXx+a8w==
X-Received: by 2002:a17:903:230a:b0:27e:f018:d2fb with SMTP id
 d9443c01a7336-290c9cf37d3mr65373775ad.6.1760743257848; 
 Fri, 17 Oct 2025 16:20:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a7664a8b0sm887019a12.6.2025.10.17.16.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 16:20:57 -0700 (PDT)
Message-ID: <fa8f5f99-c17a-4cef-a828-9d7489666add@linaro.org>
Date: Fri, 17 Oct 2025 16:20:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017205028.1105595-1-brian.cain@oss.qualcomm.com>
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

On 10/17/25 13:50, Brian Cain wrote:
> The following changes since commit 18f6f30b0089b470f3e737637a86dfb81ebd6eae:
> 
>    Merge tag 'pull-request-2025-10-16' ofhttps://gitlab.com/thuth/qemu into staging (2025-10-16 12:27:12 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/quic/qemu tags/pull-hex-20251017
> 
> for you to fetch changes up to f97700e0752753e294db11de8462aef5d8009a89:
> 
>    target/hexagon: Only indent on linux (2025-10-17 13:45:46 -0700)
> 
> ----------------------------------------------------------------
> Fixes for linux-user sigcontext save/restore, etc.
> 
> misc: avoid inconsistencies w/indent on macOS
> fix hexagon linux-user sigcontext discrepancy, found by Alex @ Zig


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

