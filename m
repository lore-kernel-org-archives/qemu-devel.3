Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB989D277C2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLY2-0006wf-Ug; Fri, 09 Jan 2026 18:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLXv-0006uw-NA
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:05:31 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLXt-0005ET-VE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:05:31 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0f3f74587so37884805ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767999928; x=1768604728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qCUv9czUeR2K8LhSuC6m4+aN4uDmKaMIb0urE5nsXmM=;
 b=H06Xc3T/wAwIQWcUjEjzykiUL1RfFxqRpyHeW+Jpz8aT8XGR3RTxejR01ODom7dTG5
 gDgx33FjDHwlfyxfz4+oj7yRXloHi+/4E9VXpcDktmYRUtkpwmAq/oxd9n0vU8brJBej
 HDWYvunRW4eCudXntD/pDbVZJ9tvPi3edwLVlzqVNQ7hR53gQPq/Cq9OBPb/IZgHYkac
 056c20wPkAgoUY3huY3+lqQZ/lTQ10/lLHZtW6LI6fUkoT8ZHHL12aN8MjOSuERDcsg8
 eXU3pwFzOqymYmSDEXl6Oi1hvY9LFvgFmdOq/nYaUcoFEworTSqsQTWvu0rmIPCHCSnH
 wCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767999928; x=1768604728;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qCUv9czUeR2K8LhSuC6m4+aN4uDmKaMIb0urE5nsXmM=;
 b=hgNT1Zg0kTpsZQ9JIFjJPO3alqn5BmtPOldvg3Fizh5Obmxf/o954f3WWvhepOfYOj
 pMtvpEIg7C09ExTNm83utxPwM1QxqvGVYUnk1HbHaZykUj9vLe78D+1WiXe+uy+YHxcI
 hX8EvcDaSza2sgvhPVQRK1hcNivCC+kqDEh1255aZ77fwP1fWAnsjMsHYeCehC/E5ogG
 xU+cjTpCX40rclP1EX5RcEB6VLweaxLWUlHkmoRJZp5EnpWKNZ366XD83tq7QZxcC8pY
 KT4NJalTX9703Avq2gENkRd3dwCWoJpXo+lwimQBQfkC2aK3nDwzB/v9MM08b/MnhQOE
 1kWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBgKbGt7G5tBNzcJ3i3WsaJE5xTREuqJFkFLZnhNbU5jqbV5NFj7JJbaCWxvkMRJ/vt9EzaW++mgQA@nongnu.org
X-Gm-Message-State: AOJu0Yw7Zle6+H4HzmXg0JXkgThkeRTLchiO4qOXBc24kHqRABHzshII
 bl11HRgoHFnK5u3DR9c4XWZYJMYTHdQuaJRDkE/wLcoWx9aPhIoeP1ytFjNk5/mY5WY=
X-Gm-Gg: AY/fxX4WfiY9mVj8+y9WJ92i6HTerx7LDbkUYgJarMz/19sG/+2LfFkD4oAfFyw4LhM
 O8Gc3qQ4R44ESaBb2sr2e+1HkZdPGSvNKkS4ZWyBzJuQgt+BfthblZso85z5vuSwoM3D0bd9zIl
 a2qdqtLOzp38tIZdNTTxvTxD1Gu5X1ZMPmUVc6aXmHizC2DN3ULYJLbdi3moEsnT9TDaSBUIuOj
 aa+FN7PQcytCdAH73Io+feczhuFR+267yiavrTsaVl8eA+ZBr4Has1fsZFn3kHHC/W7DV4oZ/Ae
 GXFU4SF6K4xyyWfH/Ijx0DvaB63am1amKqNsOFeOCRtmVTcxsKtwfI/aO0/a9y1BxAoqFDUjye6
 uadFlFCGWCN0KhtLu+WMr3eppCZ10LLP+LOpFZPBMoX+FjvJENPjQicxATqR9ow0sdCbixN2yHQ
 Tt3T63jxYnUujjRZpxzIC5rcmKXw==
X-Google-Smtp-Source: AGHT+IH6m/5dgo2bROo4XWfJE/iL2Z0Xs49Mv7tSp7vC3l3M1CBQod6STdf2CHVz/0JqGXUuK3CUHA==
X-Received: by 2002:a17:903:2a8c:b0:295:7b89:cb8f with SMTP id
 d9443c01a7336-2a3ee377cbcmr111297555ad.0.1767999928049; 
 Fri, 09 Jan 2026 15:05:28 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c4795fsm115658615ad.33.2026.01.09.15.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:05:27 -0800 (PST)
Message-ID: <37eb6530-3e2d-4455-9905-437753cf4e26@linaro.org>
Date: Sat, 10 Jan 2026 10:05:22 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] bswap: Consistently use builtin bswap() functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260109164742.58041-1-philmd@linaro.org>
 <20260109164742.58041-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109164742.58041-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/10/26 03:47, Philippe Mathieu-Daudé wrote:
> Since these headers use some __builtin_bswap*(), use it
> consistently in all the cases, allowing to remove the
> "qemu/bswap.h" inclusion (which only defines bswap* to
> the builtin equivalent).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/host-utils.h | 7 +++----
>   include/qemu/int128.h     | 7 +++----
>   2 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

