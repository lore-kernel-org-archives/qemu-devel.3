Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3245ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PRI-0008Us-Nw; Thu, 02 Oct 2025 15:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PRE-0008Tw-4e
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:58:05 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PR1-0008Bk-DA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:58:01 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-330631e534eso1585711a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435065; x=1760039865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rtxsr+O9mO1bjXZth9WOe84RGb9NDXeY+gJDuL1slKY=;
 b=tQsp8+42Cm+n5XEpCzDm3I2T96PJakQhhjBCWuahCK+sw7W4fH3g6spicbjPuaRZp2
 JklB/ovAF4+1X0i/UjzWxdl33+eTOH9jT41vz0to/9KjwkxFCPIHUKEYFiFBl7k26v/7
 1uo05BN/Z4Aq9sv++l7/pX0ewVfyUp9VXGLumyS1VG9Lx4+XA5RVbBB0fo49DNwltJcg
 GXUbpBqQBBbB4PoA7WY2uT/ldJCNa8ZBrOIgez+D9UJjdZraPzg/ChmOPFuZWoF5WEDM
 EpdQzazWb50LteaPknn8ZCOgULklWbhioP0clrc5jZSXUMX0ik6m6tOPzk4UtCNhamSH
 AgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435065; x=1760039865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rtxsr+O9mO1bjXZth9WOe84RGb9NDXeY+gJDuL1slKY=;
 b=e85wYYY9mR4IM18aFlHz0306QmjVb1HFYBwTbbszUVP/MWrFSK5UquFBhU2PovZV/T
 n0s4x4LU1dv722cG5boNvlf0O4cmcirvU7gacB64R2ZCLFwTSGEjS18w3CwfxdFdc8R0
 BNqRGGFPKfg5eQgoVTm1Ni3JhHMaJwJCnGVsoVlAroXwxeRLdTltC5HcZbytJfALWQNJ
 lDmwUxekEVkrAg37UPuFBG+hUC8LFB++u+AImHvFfo5vqYU4L4MjPQbgWgzZoT46/d+k
 WODOFeMqyWsGUB/2EdelZXOJoE5CU0ZwMAHCeQzFZatA+pMDdcNELWWnQRa5Nwisv0qw
 GlcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo4bmWAJwr/erSMKADoSfs+s4ywfaldoyFhCBvOPlqaZE5b6FO9LmLSbuKUlwixb5+O/xH9ItrZsm8@nongnu.org
X-Gm-Message-State: AOJu0YxXaAupSRrO65zKP0+FHCTZOuKap34t7hz0qm8Ez5+s/d0NYxPZ
 vIMAwxJO91MWYpXEe7BkkZx3Py8Mu0zWX9vRlu5wp5Z6iNfK0a5Uo+ng9lKijoboiYQ=
X-Gm-Gg: ASbGnctjqrulxz8e0zEHArNFcFhLlixKVoJ3UUol9hoyAvQlRuEFn9PJ8CPHTGSZVBj
 VnOU56si2kk6gFYb47vraujGGlEYphwsYFizoIfmaqT8wUkbvIt0HvY3ri1qvTURG+IebCAAiRg
 fHj+DU4bpnLCiXrdJgHJjbkgOgQmU2j0OTPyoOUj1N7g2ERVCLOreyRCXzJN2xwlB5nuKpgG+nF
 EFkKjacx3zp+7JA8ghbKpCv6EJoU0Ck2OrBWvfpaHeJ8b8YkgISXvxAz4vnn2Lw6dsmcglFGNMY
 29+hQN6TKpd2Nhak8zgqnNIdzFq8guABtHV1Fh1aglvHjCmnFcpyiTWhAEoYnPVVZRBRebo/OjO
 uudFOpAYhVFKFLVDn3HePM8EZE7ew6v2y08qpVQS2dkXMjp1GZrD36sPHIL9OD/s=
X-Google-Smtp-Source: AGHT+IEc7IN5/QFW+ZOzmfYXbOKkvCxKhXkeCpvQCDe2e2IAol6NYtfejpDpL3ZoBJfuYd2oTz9WbA==
X-Received: by 2002:a17:90b:1f89:b0:32e:d600:4fe9 with SMTP id
 98e67ed59e1d1-339c2724b61mr636362a91.4.1759435065493; 
 Thu, 02 Oct 2025 12:57:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3399c0b24eesm4128266a91.1.2025.10.02.12.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 12:57:45 -0700 (PDT)
Message-ID: <fed7dd69-3635-4ff9-b9da-309ce4bdcb47@linaro.org>
Date: Thu, 2 Oct 2025 12:57:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/33] target/riscv: Fix size of frm and fflags
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-13-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-13-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> According to version 20250508 of the unprivileged specification the frm
> field of fcsr is 3-bits in size, fix it to 8-bits.  Similarly fflags is
> 5 bits, fix to 8.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        | 6 +++---
>   target/riscv/csr.c        | 4 ++++
>   target/riscv/fpu_helper.c | 6 +++---
>   target/riscv/machine.c    | 2 +-
>   4 files changed, 11 insertions(+), 7 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


