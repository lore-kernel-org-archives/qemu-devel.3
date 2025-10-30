Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144D2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVWm-00028V-KU; Thu, 30 Oct 2025 12:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVWh-00026H-SB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:29:29 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVWX-0001ce-31
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:29:24 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso2245184a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761841747; x=1762446547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HFTbOoI9Xnv5LChNA+MD38rRk2cmJFsYoBrs0kLFmz8=;
 b=x8wkzcCPAv+KvbcWEibYPKgwrkZ8N/jV/XuSFCQaToS26ZOTVzBMCmEotYTjXsN614
 wsNugnvdv5+miJQsvW65cVPWr40FvYuHk9HKZCA0LLxbONjCpgiMfn7sd0aDPvzid2UC
 jYUJawb5JjHFbswkFS4fQCZOzzfAYfgqikj6afV0nEcCSSTf29DwlDcBFm1/G0gYM1py
 64h/4kyxzKXJ3c6ztXUlxQulQYBGBg6jC6Uq+YLUb9zTSTqP3Bk1INituRaONw9mjxEH
 6jN+6e0tay9CQRbt+KB1vCHyr/WlaxpR6m3NrOe+qP8XmhQvMGg4JYGnSH0Mpc3nj8w8
 sPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761841747; x=1762446547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFTbOoI9Xnv5LChNA+MD38rRk2cmJFsYoBrs0kLFmz8=;
 b=VGm4w+pgvh57NpWaEaOmNqFSjKTUI33xkLxlGoHlNszi/ss0GGQG28l86Xz5Io4bWC
 lzsL77AMxQn4ATwws+kbU4AVPVtREH/Iw2CmdERfPvTcnrsT2+8bXdL63Ra8EBUW2RCE
 XB9Pl0QOjLJ7uWEpjXnTH0SR3c9EGNrvLQdfLg1RfIQVUWsJ044zyk42NIkR4NPa3HuN
 Fmq+zzzM+SCP13vPZ5+M7g8oM2nb6XeBA8t84PabNul1FmSdVrNRt+gbNHzYLPTaxun1
 Rz8xusDKZ+gXX56XOk+QCZ2JBzlDEGMSco7YGcvefKznjSkSg0m664Ok10f62rOSjieA
 4YMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN9MFnOQ8XI8vw/loX8x/mMDNkTlKsotTDqTKx29dxZtIUoRK37lH3GJAWMJX3Kxy7pLs8wXcSVZ8h@nongnu.org
X-Gm-Message-State: AOJu0Yx8U5Ro/nZY/i4Z1E1UU+os7Vdst7H+0RL9dvKM+XUQv2xtY/0e
 2WAcP/Nipzg91eDYxkZ8hLhdZ04ptIOnU4uVx4qu5c6wf3GKwqaitcK31BoRODRuJtVEsRLdKTc
 tKfCWV3q2Zg==
X-Gm-Gg: ASbGnct3G7rekPID6K5SbyWIfc8rpnONYWN6M8KFuEP8z/1KYwR2Ylt9ftnePOVLugG
 /tTLqRh+i8Kj2Q+kztrzJa84l/LoGDEWjnTSxFE1qrSiSs9HFSY/OPj8i4yg/9ydTvHKkbZMvBI
 Z2k79vPJaqFKh8kVwpQlhVVbYCid90V0nF6qDXPSt/H/ixASh7iBYtzq2n9Mr3DggCD7PGfakSM
 oloZFtL6eGdDl695X5PGuht1CFv/9+rmQlkc4nlL8gEkwVCEyij/H0lYCzRooQN179K2dU3FqzD
 p6Duxkm7Q/6W9ax1J1BN+Bkn4oajVXygZHb5tu/RlN3l83hnWeY75x5ytHGSs7FRJhtfs9snYlh
 yoRgxfFj+a7m4kPSwrUNkcIdL2BArP+TquKplWiZt3yKgBPScNLt5G0gHIoM9VQh2koDualVVvq
 k4aS4LUEqYk/87mCzsgWDIGIB9fU2anVd7j4xVQGddBg==
X-Google-Smtp-Source: AGHT+IG6Hs+1s0F2JfYyQIx1EDLmqaTQw0M5TYtQ4f4kPadXfoFKJtvDiXQwuuPAvTFROoCs9WwBzg==
X-Received: by 2002:a05:6402:a0c8:b0:61c:8efa:9c24 with SMTP id
 4fb4d7f45d1cf-64077049c32mr31411a12.37.1761841747508; 
 Thu, 30 Oct 2025 09:29:07 -0700 (PDT)
Received: from [10.180.230.213] (183.105.204.77.rev.sfr.net. [77.204.105.183])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efd0e23sm14951877a12.35.2025.10.30.09.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:29:06 -0700 (PDT)
Message-ID: <f7a0b613-8ee9-4df6-9cb8-f148b2010a40@linaro.org>
Date: Thu, 30 Oct 2025 17:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/microvm: Use fdt field from MachineState
To: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251030-fix_microvm-v1-1-f89544a04be3@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030-fix_microvm-v1-1-f89544a04be3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 30/10/25 15:32, Luigi Leonardi wrote:
> MachineState already provides an fdt field, remove it from
> MicrovmMachineState and use that instead.
> 
> This is useful when using the `dumpdtb` option, as QEMU expects the
> device tree to be stored in the MachineState struct, othwise it will

Typo "otherwise"

> return this error:
> 
> qemu-system-x86_64: This machine doesn't have an FDT
> 
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> `fdt` field is already available in `MachineState` but
> `MicrovmMachineState` uses its own.
> 
> This prevents the "dumpdtb" option from working.
> ---
>   hw/i386/microvm-dt.c      | 96 +++++++++++++++++++++++++----------------------
>   include/hw/i386/microvm.h |  2 -
>   2 files changed, 52 insertions(+), 46 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


