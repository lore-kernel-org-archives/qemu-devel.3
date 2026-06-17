Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5D4CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZriZ-0004Ir-Lu; Wed, 17 Jun 2026 10:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZriY-0004I1-28
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:58:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZriW-0001sz-Hw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:58:13 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36baeec21dcso3820655a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708290; x=1782313090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrCXtNSHo1UdGRZ1mF7UJcsvFcGgty/ywb+o6wTrkOw=;
 b=S23M1Phgz5Wjxr5/khqFx6M37plOLQOcnEQm1q/EdirLK2rAxUbXekO6RWoG6LNTPo
 BvmngHWkEYW75fD2MKBoZbfQHywLfl2JrMUGMQEYqONZJNa5C3NcParvAQKMrMxYsnJ6
 RcV8nbgW34hJFlWCpnqRvuyLoGTdvcrQIzMK2J61ahtKs7Pm0KOi90t0xagONJl8e8C+
 sn1jWObvOts7pkn7u1Wi8gqGhqkvvu5W8PYyoHqEWG286veTKsZfI/1YzUxFsSbxuXeW
 326J8j768D20AErKoI0e0HZM7iC9kSo5MiAWuxbJfsbbZjQsMxSoVJK0WoD4cvzfmPww
 qNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708290; x=1782313090;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrCXtNSHo1UdGRZ1mF7UJcsvFcGgty/ywb+o6wTrkOw=;
 b=XiegUCq85/8bz2K7blvX/ofM8FFA+zNbxCjKVqETSgEf1YXyR9sZ66/1qrT7iElbte
 Q0bgles0qN7kcuU8OYoafPHKGdVw8zIzUAM3Rx4DR9Op8v+Uba8lYpRVro4ohDcLbnuc
 8Vy5D/orLBYL3aboZgCGBEZEThJ+hDLptWRiHd1zHPtrYRCYTZNuUU0c9/1YwsCGMmhq
 fKyjQBetMKEmPabnDe/ari5A3oDwRl4la6UXVmVpsIzGnX0WXErecr/DFtGnQtjexwBQ
 J2gDUgAzFJ0LNn+3nRW2v3lYxfg6izAxAVeXk5ycabjS3V0n8CcvYnDukAfPUpn12J6L
 JcPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Joz7IwtW4Q1Px6suwK8cgSrKT8Pdl+wvh4OWRghQD7hV7qM5EO16vm+YpTgJO2gls8ab+xEqSLLe2@nongnu.org
X-Gm-Message-State: AOJu0Yysxp6WvPX7Ika105OinXwKOIvw+KUhAvjbiUYV6lq6tFBVmd9n
 JvKpmazN3nbID9/DvsXkZChxLb4cP0uqkDCw/h9eMkiR2aP1JQSo5NmFnY1JDq/hP6M=
X-Gm-Gg: AfdE7cmHO7MAHLx8bJjcohtrKApip2OvA8vnJcRorxF06xdbmcTj2oSiA70Mnb8gyZs
 s+l06uM43yYmRtJxwTL+QH6wtZXJqimfCsBlPc9lqK/d44tjJ3Isnuvyq2sMxi9J1SJkfvl7VHv
 FCjj3npgCDmMG0jdiBLTC2UB4f1zqBHV6l4e2gPWYyfgzorS3hB9hMOjSfbOVTbRfLZNdSK+Hv+
 1XEksGqZN/Q81OLQ34OFwHNYZeNaSIXpReSARZ0YIZkD4IXtGLzt3zLAcHdPApWF6P2RI99LIi3
 Lo9NfVS+SoqNIfV2MBX67lKHDhY9yAdPJfnDtaOnf8Z5laiWIOUk1Min/DgZMVEB3toAagP41ru
 1CU8ABvWHqmxZxpszK3f8PeJjFkdZKCccflJnlzVITzmXqAAMjnLX1SXG0jd9OL2xNy8QdkVVdU
 qxe7pejjA5RE5pyH9E1qTaAxPNgtFdfVg5MKKLHXpgcK/eg3fgY1CL9F6PQQ==
X-Received: by 2002:a17:90b:3850:b0:36d:cc9b:2f67 with SMTP id
 98e67ed59e1d1-37c9e9d413cmr3850306a91.19.1781708290271; 
 Wed, 17 Jun 2026 07:58:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5228ebadsm6179917a91.10.2026.06.17.07.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:58:08 -0700 (PDT)
Message-ID: <f2b83acb-79f4-44c0-bb83-0b833c91c48b@linaro.org>
Date: Wed, 17 Jun 2026 07:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] accel/tcg: Move cpu_loop_exit_*() out of
 'exec/cpu-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
> Move the following TCG-specific cpu_loop_exit_*() declarations
> out of the generic "exec/cpu-common.h" header, to the recently
> created "accel/tcg/cpu-loop.h" one, documenting them:
> 
>   - cpu_loop_exit_requested()
>   - cpu_loop_exit_noexc()
>   - cpu_loop_exit_atomic()
>   - cpu_loop_exit_restore()
>   - cpu_loop_exit()
> 
> Include "accel/tcg/cpu-loop.h" where appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

