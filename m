Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34EC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 14:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8SV-0003fo-9A; Thu, 22 Aug 2024 10:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sh8SS-0003ea-Ug
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:06:37 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sh8SR-0004ot-64
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:06:36 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5bec4fc82b0so3503111a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724335591; x=1724940391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5WuU7N6kTdeDYc3Ueq/WVoJTwZ9rengQJot1YtszAyU=;
 b=p7W6Q/Ny2UORuw2bY4bnyTsJ53GHZQKJ4hm/bFNtcyBOcbKVauVPPJTnKTjUh2SBXE
 tt9QCDvm/bco9qvFO36CHRBPzIIwkLUdVAGh0IJW3WRVed8qNiiWEKwKyM1PMEfqQScd
 eoTnwWM7KgIV+QNvFqMBK0SUmg4LAF0/zL5rcM9Bekeo9zt2r+MHcRfioKzaD5f/R/Xm
 lTOTS2qzoiM9pUNLE4O8ijt6x+UFKzI89AvKqiIzApsHuGwVilYMcv95zaUZRafMehK5
 ss9m3qt6biucgkd0ASjye2EEy0ij/RXNHkucG9ZzIt9SRFnHtmjGZzaF/UvcZZv17hPn
 G6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335591; x=1724940391;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5WuU7N6kTdeDYc3Ueq/WVoJTwZ9rengQJot1YtszAyU=;
 b=DsZioLv28EHlg68yug6KYsHq7WwSzGOkOQX3SRi1yvuMld0DyVvDKgSygnTiIKf7MB
 wZ6gJ7z8LYVOCjIuzz+u3tZUMB9ATHGHoXusa65vBO+kqlYhaPe6yX3tLAFkAFVpD6HI
 SUXGFcTIG3SKe5pdWRnvZUzcY7TJ+C5tLqGvP2gY3OxKamIls6/LZJooTJ70upF2E1uA
 oQqApvjrWMxObCibLm+edNt9Fl7LDa6S68bOmgcNiigqj+o26jx+CnoKiMuwG4Oa1wDZ
 XUoaZMtWlBus31TxnzK6lvFq9VMcBrNFHHQ80XwLMYpRe+dFllkZEBpuG7TClL5aXlbh
 PzSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCA766ZdrwFSfvLWYwuAB7Zi+0bGvBh++YN99CzqqT7a1Nwq58OFaMinVoHNouwCVMcxlZYp4gGdon@nongnu.org
X-Gm-Message-State: AOJu0YzMnqIqoAJME/GxWT/JdaB7Fz8e8fkAmitsXDJE++wOmi7nUjnD
 BijgVpSnQb5cBc39Khr0AaKaMgco0ywkHpjYm3hEa6kFBrxuLIMiZTaq7axWphg=
X-Google-Smtp-Source: AGHT+IECU6x7oLzeyVg1WH94nmecraXAvA0/Ye6BPlzQjGpFYZW5gTrQ0gw9OEl3RE5HnTSyOEeyfw==
X-Received: by 2002:a17:906:f596:b0:a7a:c7f3:580d with SMTP id
 a640c23a62f3a-a868a912650mr290515866b.25.1724335590455; 
 Thu, 22 Aug 2024 07:06:30 -0700 (PDT)
Received: from [192.168.200.25] (83.25.211.12.ipv4.supernova.orange.pl.
 [83.25.211.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f220ccbsm125683266b.36.2024.08.22.07.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 07:06:29 -0700 (PDT)
Message-ID: <d8c744cf-0da1-42fc-92cc-f8bec8ca00e1@linaro.org>
Date: Thu, 22 Aug 2024 16:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240822114146.86838-1-philmd@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20240822114146.86838-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22.08.2024 13:41, Philippe Mathieu-Daudé wrote:
>   # Timeouts for individual tests that can be slow e.g. with debugging enabled
>   test_timeouts = {
> +  'aarch64_sbsaref' : 180,

What kind of machine is able to run those tests in 180s? I bumped them 
to 2400s and got timeout (Macbook with M1 Pro).

"make check-avocado" (with some AVOCADO_* vars to limit list of tests) 
shown me which test is run and pass/fail for each.

"make check-functional-aarch64 V=1" shows me "1/4 
qemu:func-thorough+func-aarch64-thorough+thorough / 
func-aarch64-aarch64_sbsaref" and timeouts without information which 
tests pass, which fail.

Maybe for QEMU project this is a progress. For me it is moving tests 
from working ones to "sorry, timeout, find out why" ones.

