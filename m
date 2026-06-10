Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B10FCD8C90
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXMpl-0003Oj-J2; Wed, 10 Jun 2026 13:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMph-0003O6-AW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:35:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMpf-0008B3-Ph
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:35:16 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c0c379e8ffso48990875ad.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781112913; x=1781717713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oBbN4+7wQREzonIFOgmOf5G2ILDazGnEKOV/W8vP2O0=;
 b=uDaEuj4yr8oLGMdnSiO0vxPINWsR/JFtFMvQXjw20Jd4Uu0ToW/qaqR6AFf8yIOIkm
 nawXICHlReeo00XGQyrPIIFYbz771Eh1ArBB1IrjOt/Igh5tymOOYdlEAb0TkGzM7LqU
 OgBrD5lhI43X0ER0Fn+nb4mAXjmY0fjK9oKj9jhSpusex1qY7QhZ+E+uyXgYJ+u2Fatv
 7eEgIlpQwt+GPGZnOS6ovep9kUQOOiqPvwg2PKXvtyqzivw8b1jDhXgWHJMR9+KEdEHa
 H98+jMZbQfDioAlMzH13fhbnkuUxoqBDxp4u61YrFZekYnKR0gZQf9xdYH5mAMJsgQII
 dwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781112913; x=1781717713;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oBbN4+7wQREzonIFOgmOf5G2ILDazGnEKOV/W8vP2O0=;
 b=oq+F9mQWCDCxkBb/lP0CTTBRXCMe7pNjXw74h2lJwAFFQKs2plwaVvGRmOK/rocHek
 0ngkKirJqYv4kmfZjpqoDAhlpNn/bN0CgqQj+8T7X3oPXI5FIDsA1zh/wHEQGKr1xbLw
 qmz96A+YxkovHukmABL2QC/6UVDzxz0jCq0t2+zHAO9k6h4iX2Ic/DQgscijIPOP8qt/
 OcmjRho0dPZB2QeXV3a00paeRAsQTNZnp8aUoCmupEK93DmAuD8HHMdf8ML6Wz+HzonN
 7DmsbzAueb7MpkjNKQ+SzAxU0GkdNC1LYXt8eeQKmpRCEYPa5tZGGNhNeG4/lyUkMNpK
 l3gA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kSScswP35iNqHSK9K6lNpIISme4PVm7Hu8MZ4dGGysVkWp4Ddp/VQT3vtn4TTR42MGRf9pEEVY3Xd@nongnu.org
X-Gm-Message-State: AOJu0YyN2Oar1RJtzg7stkVGCH4bNKZxs0YAnewid5I5lXUGoaeeatLe
 RzAH7dJE6Kca8CEiQsYJnbIBPdzOCTRW0lAGdon03t+A4HTCljyrBqNrA2HgRsFZVaY=
X-Gm-Gg: Acq92OEW6EU4KkRp73AFIJcshG6TGv8/VXgeKA+R7fMGP2nlu9V7/rfMvdaljDtShAL
 YVVkjzW70IecHGRBEXCWHs+axNvq5PZ8PUtRDegkjxRtOlEuu8l1mFqfLFvAOjakQzaxK0bs+zK
 4JlaKPa1pS8aKeK+ojysuM5wWvOoWqP4SJ4AyQxZiIB6XNFChyTE/Zk2rnAgSzNepT8M9+G9LXT
 mqSyKgvmL7Ko515le+k5ZSjKzl7JmsJMFHtBI/IbyaHl+u2J3uuLZpqJuAPSbPoAKMOYSq/aj/E
 jPXjRCgqZlC526fN1CTlLGqsIFvLOTlgNfu4l8DFVa2+9fgdxfYUeDtvfvHGRjnZfqiU2QoG8zN
 RxkxluaZyNjuQLrOnHlvU2eGH9qPdTv0G0iuRK4gidt2zv5rjlNpRulxo02ViuHGtlwjUvUG0t2
 wwilKejuQIBCik0pBQzecmr0Cg7GuUL2/UOKK0DDVRPELHAygF1nJiDGCrrQ==
X-Received: by 2002:a17:902:c949:b0:2c0:cb90:1e08 with SMTP id
 d9443c01a7336-2c1e77754d7mr307383385ad.0.1781112913417; 
 Wed, 10 Jun 2026 10:35:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16629d042sm262482185ad.60.2026.06.10.10.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:35:12 -0700 (PDT)
Message-ID: <2c90991e-ade7-4b97-87cd-358ece0838ba@linaro.org>
Date: Wed, 10 Jun 2026 10:35:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/xtensa: add cpu_set_fcr/fsr helpers to sync
 fp_status
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260610152648.677463-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260610152648.677463-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/10/26 08:25, Matt Turner wrote:
> Factor FCR→fp_status and FSR→fp_status synchronisation out of the
> wur_fpu{2k,}_fcr/wur_fpu_fsr helpers into cpu_set_fcr(), cpu_set_fsr(),
> and cpu_get_fsr(). Signal delivery code needs to restore the FP rounding
> mode and exception flags without duplicating the flag-mapping tables.
> 
> cpu_set_fcr() applies the union mask 0xfffff07f (superset of the
> wur_fpu_fcr mask 0x0000007f and the wur_fpu2k_fcr mask 0xfffff07f) so
> that FCR bits valid only on fpu2k configs are preserved while MBZ bits
> 7-11 are always cleared.
> 
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
>   target/xtensa/cpu.h        |   4 ++
>   target/xtensa/fpu_helper.c | 111 ++++++++++++++++++++-----------------
>   2 files changed, 64 insertions(+), 51 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

