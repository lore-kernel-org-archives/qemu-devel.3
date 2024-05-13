Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E92EC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 09:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Rwf-0005Fp-Vk; Mon, 13 May 2024 05:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Rwc-0005FW-Lo
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:26:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Rwb-0005vz-2u
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:26:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34d9c9f2cf0so3559730f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 02:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715592363; x=1716197163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D4S2KsWxSErnOpuVQ/EYceGF6qfYr+VesO4C5cYf19E=;
 b=OoSNjcu5/sOHC/rJwfcBI+MW5cxpQfzAPJpnNkTouXalRunA87p/YzqmtHe7qmkfLS
 IAs7sFQWTk1mEsdumcusR+6Nnk1i696CX751maYF6Jp8kqmmpnytJhym0Fk/8XbGw63W
 V4ujCu74nYkP9rck0cenV5ar3yYZ9n2NTdeJhxrf4Hbl3J+9zpDtr70pI5UYRYiUixFw
 euWxkL/yVtlVu2JJt8Q0sHoUdrO00VGA3OKMUhGDKK14ah90csNmcjHUmsu8dCaqpdPC
 8UhJ9BJ2IEmsoTgDTxsa5HV2v+uRanWpBJ/GyFg6ADz2+z022MRkSsZ+B/Q3Vhheldrj
 wK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715592363; x=1716197163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D4S2KsWxSErnOpuVQ/EYceGF6qfYr+VesO4C5cYf19E=;
 b=DCZU9kc+PuJ9VoW8p3EIZ/Mw1qsFfK0a9nvsxVnKU+7wjQDaIazy8x2brMd4PIx63q
 2ATSbiJfOVxDY87YPKroxvCtqJhLxRSQ/eB/pAxnxHsexjYxh654jXbC73tyXmC7NQ1M
 l1Jsu+lUruzBOp9R1ZFTpCwJdLpa/rNFZY5cQaZuEwESincLvlLsmaRuyEpgm3nuuBlv
 /hUYOVzrp8gqLCJoE8ujF1udZfGiQgkqy9AotMyMZSeZ/E386T5C88fOelvDmLAAdi13
 A3xJbEDQLb8Ur23RQQpkdtmuQXuh/QoQL9phpcIlz8xWtSjMXT4ux5rYUT2lsFCok2FR
 g9Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi8Wky8lVFph8Y6eqivjJauIukhGSNjPWTGGkvHz0U5H3I9GvnnNWz1b2H2Qr8bfTn+46gjBd4+y3ZnkM84NH9EjF+vZA=
X-Gm-Message-State: AOJu0YwjbO3H1uNP6mDfMnxb71GyCrfzXJ5IdGDLjJ4lgL3g85y+QQWX
 eEuYBbVSunCZahPSscHu7R8OMtqZOSAralB2bWplLcqPevSQWlg1na4ohFf+Hk0=
X-Google-Smtp-Source: AGHT+IHK085Jnrk6UuqH0H5pSXNa6CCwSQJeMmN+UD3ECv3qXrl+LPviPHSdYas9/uZ9yb1nc/FysA==
X-Received: by 2002:adf:c701:0:b0:351:b7fa:ccc7 with SMTP id
 ffacd0b85a97d-351b7face09mr4048665f8f.54.1715592363178; 
 Mon, 13 May 2024 02:26:03 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a7826sm10574976f8f.52.2024.05.13.02.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 02:26:02 -0700 (PDT)
Message-ID: <d77b53d4-c693-447b-824d-e244b1e257ee@linaro.org>
Date: Mon, 13 May 2024 11:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/45] target/hppa: Drop tlb_entry return from
 hppa_get_physical_address
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-40-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 13/5/24 09:47, Richard Henderson wrote:
> The return-by-reference is never used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/cpu.h        |  3 +--
>   target/hppa/int_helper.c |  2 +-
>   target/hppa/mem_helper.c | 19 ++++---------------
>   target/hppa/op_helper.c  |  3 +--
>   4 files changed, 7 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


