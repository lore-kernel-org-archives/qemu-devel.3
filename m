Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABE4C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmGf-0001GQ-QV; Wed, 19 Aug 2026 15:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGe-0001FK-5g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:08 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGc-0000FX-OD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:07 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso1798766a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787168885; x=1787773685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i3/w2MX/IqT/kDvDyQRAdTncv3Vcxp0L+ecIvqIc1QI=;
 b=RKHac7kTJOpqePLWOYwWsD9uHOcSAyERZR+0FErf3g57MV2rvFVKFKgNXEYPpnPpPd
 JliMnGpGlvDSKH/ygO1DodoGeb+d216Rr2J/ezc8NM+nopPoVz2ILg7BxLNdfx5VfxOQ
 egeRbYg01M8LLK6tMp/yM5DPtwlWRtsufk3KvTDAog7n85G/IvwHHh7lxmPDU84drMCJ
 A1vknXLascH0umBonvIK/dkdxqhT6VkRu8cV33Owu3h1QK4+ovLm11gQGtx+tpBDm0li
 Npwm2oRKgG6caXkvrjcFfWF74Xq+YVE7zZqosIZxy8ad1DPslYKhiN+qo1A/mw6KIbsu
 /egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787168885; x=1787773685;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i3/w2MX/IqT/kDvDyQRAdTncv3Vcxp0L+ecIvqIc1QI=;
 b=K35jVZYHz+MS71ZnvHpyPegM6MwimbLyP91i8HpKLM407TLA7MVrouXLCIwJ0vWu1p
 MgGwoJJ67/mbB7gmo5iF3fa7Kmgun9InDIewEtRjWH/vdbcPq9OhXI55HEQQCDmZfd/5
 HmKqTeodBZK+UYaGXS+mxf/++AM+vdfNsx6KlwSH5gSUzTIRMefYCoU/1KBnIYc5DudT
 GJMSqLLp8GgTf4QELijj7lfJlaYd5PKz4d0yOcrJLUF2TTvmUCaRtSrl1yrCgFI86K63
 Q63bS14XcMeqDN+yTprA50spJJZDlgdD5wmm7Fg5/6Tsc1Jj1TI3XycmvA437O9LxnZA
 oEKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqk621w45/P6OZcWrMwEj5qZ+NMlDyQOWPZ9JkwoCCmtgL/GPWCZbrlwNGKA2CHYrIrbwYdUZnf5AlJ@nongnu.org
X-Gm-Message-State: AFuF++nI5nMIFwCQN7e1WfS5yahjhradWYF4wo+J/ojRCOvuW5aUebE+
 b3GhCKaPWazvuv2dZ5K/03gSV+LeYnuWRUPfKSMNYAUajen/66CQ02pyx+fVu6oMgZI=
X-Gm-Gg: AR+sD12pzL7nQyqoS0Vwg14OKRq4bDgyB259NxLBQJEKd1EW8YdZUYmKSSqoMHtaIB5
 CYzX00rfgZEXfrYSBPJmJWcxQnCrPceTOn6vzNPSLvyIjH8eSIertk+Tr4nbAgBn7WjFuNXqEtX
 mJP5Lz3DJVlVDL95FXtkDGdtHxuMK4N8ciWqAucTGjOs3Yc8+dsuP3bQuiz0HxJyH9TeG3RQp7T
 5bLeUy0pwOVPe1QZUW3k0W/aUddbnvndWkF0mAI2Ueolxi/HIMZR+o9Bjj1M3fVIbtLxAwritPs
 elTnReB1H0bsYSRWbMZBn7BVoctc24/aSBzy/oD7zsIceXAaUF5kz43U9OegvYbh/Wid2+vGA9Q
 Gu6mhghIxz28m8hwByJ+Dmog/TDEq7UDSeV04LuvEP1cQZdcutcTD4CzDs0JNZXcw+EcY3is1XZ
 hz27wPuM6QYZH+wwwIZHtaovlvof7/Dib7Bpzbk6hEOErp6hCa3lqIta4yMqqVjRfr0e2XFRntJ
 hwmb0Vmn/2ibxlBCTo=
X-Received: by 2002:a17:90b:268b:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-395810b3250mr12987118a91.10.1787168885326; 
 Wed, 19 Aug 2026 12:48:05 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb51271sm4055310a91.7.2026.08.19.12.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:48:04 -0700 (PDT)
Message-ID: <50d978ae-485b-4790-a2b0-fc78051de565@linaro.org>
Date: Wed, 19 Aug 2026 12:44:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] bsd-user: Remove 32bit host support in
 thunk_convert|print()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-6-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818172012.3052821-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 8/18/26 10:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system/user emulations.
> 
> Signed-off-by: Peter Xu<peterx@redhat.com>
> ---
>   bsd-user/thunk.c | 47 +++--------------------------------------------
>   1 file changed, 3 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

