Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97521CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNi2-0001nh-En; Sat, 30 Aug 2025 11:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6im-0003KX-Ce
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:33:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6ii-0007C9-Ap
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:33:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24457fe9704so27411395ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503190; x=1757107990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ljdq/JjKe9p30gbosm28GZDsEGlqMQ6LE3KgsHqQF4k=;
 b=whVdGAYRvpOMV0P/k8mfO6bIaG8SFEN0tOc1QO/O7ydB91wFhMBWhCIpOs3VjT24a+
 ECEYlqJyuxYfK4Kcx1gvoQs3DHEIoqLoNFQwXeuIquRMUykJoPv/48ILyKfRPJgK2TXU
 JpAP5nOHIPcF1Jz0LBHql7JVBSYEpMkG1FbOcHLtOSFWvDIbLZp4YRM6m9ZuixMYxG4f
 S4EvBJwYpgueS/nJXHcRMF8LDbXTjAkCCg4k4Jr55HJHhBFpI8VZWL97Potjdftn3Jh/
 Bd4AR7Rs/3Zq8su9bavPQjECqvcs8voel6ChcDEvqqNaJNN85ueS+peWELIHyMHbBm18
 aPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503190; x=1757107990;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ljdq/JjKe9p30gbosm28GZDsEGlqMQ6LE3KgsHqQF4k=;
 b=iF/qCrcdSzsCGVG7ZJ+5zD8H3jzILtJ+MCuajYMpT8rcSn+kVwHdgJbzDdc1iTep5T
 2m/Crk9BCd4ZaNbvv41BMATn22apq8fEZ5BdcUILHSnoexUSYaNWg29I0Z2lCXKjWpei
 EgItgGlfcn0WSsS30rTLk7dkt1Sk2U2np2GORaIxmtCJ8J8pzsyKWemyI1hD/CfgBEn6
 HVlQNQAGV2jxyrovlg57t00EjJ0cH0kr2432/KBbSCcZtAPoYYORAHqqeygJhhFLcT1f
 eQkDk4TR4yuRfppb1uiueWlqGrg6zpUDKGB9c2zk+4/KhwtXbJSa2Ko8TDG+xEa/QEd8
 J9pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8i73bkGtmr4pGd6kESQUBYPFGtJ2x6uH4Sih09fCrUfUgmiAHqMMo8AVzDmDNRXq8VV6iGoWql99g@nongnu.org
X-Gm-Message-State: AOJu0YxmPuwLe3Hyh7jN9GsY9Rew6x601ME1NFxMTTrvPnkMK3pxt+9N
 KirBxA2pjxUP577YV/I3Gst/zoh7fZoMGyQ2OQ1UmOb4ziM8po3Jg2Cb+LXYUVcTduU=
X-Gm-Gg: ASbGnctAPLD6eS74NWhoErFzd29XMfvbQPp4f7CYQ9KXVM9lGaOcloxrui4RCA5BK4x
 tOl6a+fDjqAB53+trIh5mSQAkz4OK793L/pTqvSIPK//KF2plkgyRZKd+z0UVSWzIoTpOUrGXtl
 aSn5VzoSnlyovbolBJ1qduGzN5Hd/RDp7oT8t8HY39VKRnJlnd1WCGeIh4oyeSO99HFCHqs7Tt+
 /31XDydGTrjXRpJA0T0rDO35T0MXSBtl6A1dHuTwUP8PKEeeFDCqwSrRSYEg2l7oxAGpDA1IML5
 oDhf+LHspNFTFM3yyuMzaGV1aOaIxkC6pIxn1+/lsgb9Gp3kaep4MildaPGT8uZv94Qy8LqzBZK
 9C/6jxNMkpNkUIkJ0D+cjn5zYo0ITqOK/bClmR98QJNs2OBiceZR/orD1aocm6OFbzGObAQ==
X-Google-Smtp-Source: AGHT+IG4oRB+4XSWrkLYUa8ZDsyO74eiMBXLOxVHOg16ltZkMs4deHcUD+cahj1oGknLYbhIvGUdFg==
X-Received: by 2002:a17:903:28c:b0:246:4077:4563 with SMTP id
 d9443c01a7336-24944ab8dc3mr926565ad.34.1756503190553; 
 Fri, 29 Aug 2025 14:33:10 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490372ddb6sm34697325ad.48.2025.08.29.14.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:33:10 -0700 (PDT)
Message-ID: <ad18ca33-c1e0-4a87-8649-f90e39f48c3a@linaro.org>
Date: Sat, 30 Aug 2025 07:33:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] user-exec: remove cpu_interrupt() stub
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/tcg/user-exec.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 748bfab04a7..66c25fba7dd 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -46,11 +46,6 @@ __thread uintptr_t helper_retaddr;
>   
>   //#define DEBUG_SIGNAL
>   
> -void cpu_interrupt(CPUState *cpu, int mask)
> -{
> -    g_assert_not_reached();
> -}
> -
>   /*
>    * Adjust the pc to pass to cpu_restore_state; return the memop type.
>    */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

