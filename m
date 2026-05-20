Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427B1CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkn8-0001E2-Mv; Wed, 20 May 2026 13:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkmy-0001DP-IN
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:33:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkmw-0006Je-PY
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:33:00 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so57353705e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779298375; x=1779903175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2NoS9s6sdPh7U1yDuUjUaHWiB1s4GMuflykDH1EecJs=;
 b=YHj0PXUfAo36waW685/ljyNshODLuy6xUKkTZ+XGNoGR6jSjqRlyvtUltv6rl7Jg6u
 Pds+wMWeWpbWLT+97RH/mRVNUM+OCbzo5yeg+p07RSow8+V9qhUNXimNqinR86p46QP7
 B5wooXeNDKx77K7mbsg13EhEgUuqfnt5w891Uy3MMdD6uV4Xvl5/97wkeDId048Zdata
 ZktIrbhQnyTofx8WGqPFc1Ub2o4bJpIJ1AG9QB/pV79QYIa8RkOCqsFwr/zSkLaorcGK
 H4HYC1pn4gkLz18uoluzXedOGFZC//FfDtA056fnn36kb//MG+92U5bgVP+MLYGUDye4
 J4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298375; x=1779903175;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2NoS9s6sdPh7U1yDuUjUaHWiB1s4GMuflykDH1EecJs=;
 b=YZo7KuIoyfuZNDkAHmnSRjFWfRu4B1Q9LwsGI6YkXYf3hk4APt7wKaVEf2TPBLWAxS
 FvRIaKOMIQZY95CAomFhtw7tFyFs+Q9uJLN5Qos0yFarKsxfzAHwWAzaqMG1k95h215+
 yumEZyKXphcw1hYg1+8uS9YkMSvPuvZwmV3JPD0jJObQJ/QNuW6H8xgIBVuK0X/z5KDb
 BhuEmYIp8QGWSvGCGsYFye43fPl/YoAokBes+wphz9MvsaZvfUbWgH/aomC6iE2qOm03
 WGavcTE3eB98HoXQnxzYTZYymHG+EWaWGnO+cVJXzoU4qI2uTDBfHHgNUCYAOjxCLylK
 Zvww==
X-Gm-Message-State: AOJu0YxakEQgaw2sPKjbIB0ogsTuqRmGiJPUukyKOr6G6iPfbe0fA9DX
 /8U69aq9EqXRt7s4c0DkH3pKP2anKlQrQo5dCacXCDlsN+VO8jlpm+7HmB6b+hESNPOVaRrpgge
 lQ53DNoM=
X-Gm-Gg: Acq92OGSbpz76bUA0LXR2Dj8FQ6NAOu3OJjAuikOnQDloFFxLwnAOPxQ/rQyvZHzRwP
 poStlDBiBh45RTIlrOe3pOWczU9Q0vFySxBgVrFud6pKyUWMyKYRcsnAbNaKZA4/795dq+DOxkr
 JQCAnBvdoZ26gPcIqr3qj6XPp65HSymbPC7/2W4J5qjSBjxHJOM94fnsn2peETL1YaV8qXV3yrL
 jTJMR5B8v+1NOG8LOkV7UZcmtPEMFRuj1te2FiJhJ7eTCDb+90ciQ76CXe2ggO1g4ExWXViaAJl
 LBvyvIn05FAJt5WQBjK955Y6KZDs9ZbxgxzO9arCHhjCcwMECdOVdKPMcoFdhwBVlpcd0CB8neO
 UysSVLrBBTlpTjTH1JkesRuzxklGB4Q7KzNGhPQuhn8GYeJKg7ETvDypOacO0Ia8FqdS52wPWHL
 ynJ4TuHLcFBtODTiZpxhM8yxYr0Z/hHG0ub06RUmwK3Ylzkeg/PxKwev5aRoHayzRLWg==
X-Received: by 2002:a05:600c:a293:b0:48f:e6de:1cc6 with SMTP id
 5b1f17b1804b1-48fe6de1e03mr245337015e9.32.1779298375102; 
 Wed, 20 May 2026 10:32:55 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d34fd4sm7222485e9.2.2026.05.20.10.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:32:54 -0700 (PDT)
Message-ID: <8122b83b-e8d1-4ef4-981f-bef024ec1a63@linaro.org>
Date: Wed, 20 May 2026 19:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/24] target/mips: add Octeon ZCB and ZCBT
 instructions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
 <20260520172313.23777-16-philmd@linaro.org>
In-Reply-To: <20260520172313.23777-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 20/5/26 19:23, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> ZCB zeros the 128-byte cache block containing the base address. ZCBT has
> the same user-mode-visible memory effect for QEMU purposes.
> 
> Model both forms with a single decodetree wildcard entry, align the
> address down to a 128-byte line, and store eight zero 128-bit chunks to
> guest memory.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      |  3 +++
>   target/mips/tcg/octeon_translate.c | 25 +++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

