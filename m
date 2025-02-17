Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC5FC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6xx-0003xz-71; Mon, 17 Feb 2025 14:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6xk-0003we-6a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:39:31 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6xd-00012g-QA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:39:24 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2210d92292eso55309985ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739821160; x=1740425960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wmyyHzonIQWNU+8zV6DtGwXD0gY5t70CQwjiQHybo/A=;
 b=IHv81o4iuqka6nXpCkkrkWBLYiUHfckezKkysiC6muhfAInSLsEhndZ8yBFGIwK9lN
 RX7/Xq/rWBVTCh1pS2fT0Q4IJceiWBOBA6QU/vpIX8J4KA1m0abdHO7R5+ZJtyXcQpI4
 4XnCJjdpUS7xKATT161ozb9TSnSFcvk2QFotvuMIJmJbcBIvSFc4QQdP0SWm+AsdLjrg
 manl68PcKQtB01/UPi+4uIGEYlvOkjtEswc8VN7HZulKXl+o8IQyuVg9S5KFDFuOdcZy
 dd2M74xjn9t5gdIkJrxOp3jhzn8fevW50QW2IBY7QbAadQPqB8Jz06hDwyimdzl1cyrX
 Ul3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739821160; x=1740425960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wmyyHzonIQWNU+8zV6DtGwXD0gY5t70CQwjiQHybo/A=;
 b=sBczwQsCspQ/PNiZvHN2HBGNv/3aFklUarU1o0FlZ6kq6VIKQK3MHJIxUYzBPa/k1E
 DaoiRJ8K9nvvtAJwZAaCVtHMbrAjUG2FKzHm8K5BnSvd8qIXvFWtlGcsAWHTbs9Vg3PP
 0wM6wb8FpwdKz7jUlo6jthoadqWGUjaaLY7u2uy8cAsOCybpK1opLwS1tDy7qOH1yOMQ
 w9RG/pfXRov3GXMWrsRwK+V8crIhdbu44u9DUf61jEVTU752zIJWRanYhhSEYhZrNrbW
 bjDGxtjGur1YgSBxnheyeUNvGVrQcugrSAosJaKIjsN7CZxB7baZLnv4cznxSnhI9m+g
 s8CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC8f1Tc1hFk69ZRmHhECCcqJrKvRAzV3OQdqYg8RVbfuGyhV+S8Ux0G1zwCurdeCUmn46DihR5IQbg@nongnu.org
X-Gm-Message-State: AOJu0Yyxh2py664w6otO9yDHDSDBCoFIEGi2DMsObl8VcTsxlNAVlwQU
 CZFIhRtg1gTLKtT+PQDt0B5sfYtJFenXxMGz9VxOKV/M1SWQ90ZAkxSA9Y95bIY=
X-Gm-Gg: ASbGncv6zCpFcXY9kixpcE4Si1uCuc82Tak42tpBfupB9IxfSokHkWR89HcVWI7Au/H
 kB65dRe8Evm24jpIqWTh2F+qf8xTc4znkB2Rm4TFv/rSUIrkAqccDLHCKcyRtGvfZNH8HMwsjXK
 8nc3ThJDFOIguvtcqEqgr6DO+020PNmVFnrje/QoDKzLEQwhI2acRn01QPkcF6D28pIvSzNMcsq
 Snw90p6Ab+HttW7bwl+aGhVlngQOfz5hxaBIxZ0w7RuSGTbx/98p15tGAqOpDD++u+zJr/mOfMV
 Ctwb7uLXyFjpvRGwjCUrvfiLGZBKmI6ABpaqT0KFRTowV1TGhV/Ksgo=
X-Google-Smtp-Source: AGHT+IHcShS7PD4nAbw/V1Gkem8XKu1yhEKnOCSRrJCzV5YYrO2X+NqtJsPejxe/lg1f6oO2FaEX8w==
X-Received: by 2002:a05:6a21:71c5:b0:1ee:ab1f:41a2 with SMTP id
 adf61e73a8af0-1eeab1f7a48mr9097729637.28.1739821160258; 
 Mon, 17 Feb 2025 11:39:20 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73268967f34sm4693993b3a.18.2025.02.17.11.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:39:19 -0800 (PST)
Message-ID: <fb7bdd55-acc4-49f6-8f06-1c8e8928a33c@linaro.org>
Date: Mon, 17 Feb 2025 11:39:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] accel/tcg: Avoid using lock_user() in
 cpu_memory_rw_debug()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250217130610.18313-1-philmd@linaro.org>
 <20250217130610.18313-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217130610.18313-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/17/25 05:06, Philippe Mathieu-Daudé wrote:
> We checked the page flags with page_get_flags(), so
> locking the page is superfluous. Remove the lock_user()
> calls and directly use g2h() in place.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   cpu-target.c | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

