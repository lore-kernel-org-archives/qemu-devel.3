Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4569CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJPL-0000h6-IR; Thu, 06 Mar 2025 17:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJPK-0000gx-Nt
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:09:34 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJPJ-0005PW-4g
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:09:34 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso1893602a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741298971; x=1741903771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cP2wjtrpOqZKtnXqRlV1nduIN9lXjZAAE6SeyIRV+ZY=;
 b=B9ME5/ynozfxHcxmRjKvoetOBOxtugX65DjGFBjKMbxclHov9qfmsEpLOhYx/1PhDu
 8/BTrmk3thZG2YeXKIGtH8UypihEFa0SWKahVV6C6rtCgQ6JpppM0OeKCmPrqvHiM5uE
 F3cAoLi3H3bZ9a1kwbNoraXTZsw41qwCrcEm1JY7v6qt1UdS6jaLi6XUNxQvZhx9d4lE
 8FpURm3+OL1+GBCV1ZygtxgNP41exoR49K8FOyB/33JE20gWoSQE/ID2kPNt/AN5UfpZ
 efbgjiCnojTkkASG/nneD2rw54DJghbUQFGxRBIgVPwi7n3h33GGL6DFhnmmDltLDuJ7
 V23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741298971; x=1741903771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cP2wjtrpOqZKtnXqRlV1nduIN9lXjZAAE6SeyIRV+ZY=;
 b=pz/55LnU5Bl7IJOd5087ZDrd1opnutPHAjqTcQ796vfpZQgxQf/SiGJwHltBzPlzAZ
 6yLe3TyiBKoKRcm5iNSBo1NWLx0bURJSLL47Ko4WPfTgP8OsSuoMhwMeqqbk2dQj+QJ1
 slV5K2MKbBTfadCOnJxnJsl77qgBqfBxwGy6PkKraIAcuGsUqcUfBvoW/AOa0WJGDG/l
 4hwJEBMY1njuZ+hHJuZLSWpC4VQCT4XJJyQCF+yFHWADorL4kMPYrPG15cK95IbYzblq
 WYxdbcof2L9vZzKHRJziY1xnCZLWud56xyEff7R3b71M97VUjsur89VNH3Z2DkCdbrgV
 kk5A==
X-Gm-Message-State: AOJu0Yx2cQfo9c+5pqY/ijsDwMjG6kQqYVAEQxJYKwIYggOi69V11jMy
 Ybzioa8jFWyoBGZWL50XcquZIIANSOhAyh+1b/TU97FxsYxYc+v8jVzFql7PLdvitWjGXUHK5fL
 k
X-Gm-Gg: ASbGnctpnH6WvHGDe/v8oHsbSNeBPGMW4Cp6h7M9JIws3E1JsOjl9nZtrziy+uR/Ou3
 A2BxPkW/TbXGIAjk4lvzvyebxLcThobnwfeDwG2N9qY8S5nPZzCBC2jTb+rnaXDIUgwLFif6Qaz
 x9GCjoMAIwBFZr39tl05N9X5YwSjKVUL0qXj5QIom84ulH9hxSTPjiZFnYu85ifmXRGYeGhvkmL
 LBbelbQ5A2ScKbgp04bkd0yvLmJyKiCjj9Ao8mDM2fcM5e6Io6d5HSh+7Q9Y1X3UgIn1TlrxXrn
 bpawptYCYieeM3vDOXIL1IgFbml5MkIQq6HPmQ7C+UJ6NAy8Axs01vCqHRllt5/dHuhfBRD4n8f
 JMp8TD51Q
X-Google-Smtp-Source: AGHT+IGPJNJMWoMaoUrTC3ptajRLRJN9VkKccn+q32hv6tc5L5bSWmdWGZE62FHJtKlASxN/9LIv8Q==
X-Received: by 2002:a17:90a:ec87:b0:2f5:88bb:118 with SMTP id
 98e67ed59e1d1-2ff7cef6771mr1234553a91.22.1741298971349; 
 Thu, 06 Mar 2025 14:09:31 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff69353383sm1775166a91.14.2025.03.06.14.09.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:09:30 -0800 (PST)
Message-ID: <bbb69106-0829-4606-8057-a3640293efab@linaro.org>
Date: Thu, 6 Mar 2025 14:09:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/arm: Un-inline access_secure_reg()
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/6/25 08:39, Peter Maydell wrote:
> We would like to move arm_el_is_aa64() to internals.h; however, it is
> used by access_secure_reg().  Make that function not be inline, so
> that it can stay in cpu.h.
> 
> access_secure_reg() is used only in two places:
>   * in hflags.c
>   * in the user-mode arm emulators, to decide whether to store
>     the TLS value in the secure or non-secure banked field
> 
> The second of these is not on a super-hot path that would care about
> the inlining (and incidentally will always use the NS banked field
> because our user-mode CPUs never set ARM_FEATURE_EL3); put the
> definition of access_secure_reg() in hflags.c, near its only use
> inside target/arm.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h        | 12 +++---------
>   target/arm/tcg/hflags.c |  9 +++++++++
>   2 files changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

