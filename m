Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD1CC021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 18:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjMer-0001OG-Qn; Sat, 15 Feb 2025 13:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjMep-0001Nv-GD
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 13:12:51 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjMen-00011c-5H
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 13:12:51 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so64898335ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 10:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739643167; x=1740247967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F+8R124vy+uT/N0YDxuO2awLGx72Odioho5BgXGhMko=;
 b=bOYnPVjqvv0ffRBOPW4Ysy9ygQdrV9cIfT51LNtr25vqFXEhu65iGHLD5+yNylJfWs
 ufIbgXvewfZvPVYWLo87INb+1PWAYL4B2uDv8sKt277xZ8JwsPkP4UMiAJhJPFfZUUz3
 eqMq1N1yQxUWCo1MFAIv8UqWtJPqEkcZSNA9pzTqKfWtvcuRNCUMWc8EcRuoU3wGpbwm
 lbof+uRSPWnED+ByKPS1gKk1dZaetWgclTFhOGwk/FBOS1nkWW86azqAZFkQ+z1EK2YG
 ylhSZh9I7K/63Y4touRSgE4jw/KP3W0HCJ1Ymd7L17bvEbXJKjZWt4r5ZYTTnWpSxtco
 jyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739643167; x=1740247967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+8R124vy+uT/N0YDxuO2awLGx72Odioho5BgXGhMko=;
 b=tNlnqJfSHRWPg0iX6wi8AWVwUVpSoQlgONlKV+0ZxkD+Uj50e5HkiDCX9cGB67h03h
 AMCZOM64wjd9wf/qcgYpzQs1IG2AijhTuaMw0IxOGxzjZ03+vMaMJHSJcwpbFHpluNNv
 z9K5fiPUwaxo9wXvHSuPSckPK4uvT4brZHbOKuqnJmN9hIOQ+4Q/lsLW4vMyLNVRP3oI
 pMI2IbYxJaAvTPed/ArzWfxqlc1TiTNu5etaKVnuS4ShpUA03Z+0x1/vP4q9sibhjzHk
 DXZAKErK+2iA061aTKcupCoveT2SbgLDTNyun1EOFoQfhi2DZ7boLTa7haJxiVKGdh7s
 O67Q==
X-Gm-Message-State: AOJu0Yw5ceeMGvHgOhtrJvcyE6Q38gJ2fhtBZULsdTODeYwmgHDk2uF9
 o4AwPB9JZQqQO84eqaybApKT7y6GwGIMUoenAe2RuEqAYE2T6UI8MC4Gi+L3/FlBjO7TshymKbS
 2
X-Gm-Gg: ASbGnct6V6teN9Hk/INIy+nP2s9FMET2Q5554LvHTp25mnaWAdMg22klV6/3M4Ss9rn
 z11bED5BSgawjDuAl3I66zXfRjCsZBEXpfsX8c7hFEGeTqBSHS6MHJiaF+N+NFYVVzOBiiXP8PX
 9wuZGXCEpLL7nx1C42KaUg25b3JYCxXGRFzFybUMAUYhdWKORCwyVYo3NPtwZS4yFChVB47zonU
 w5Pdk+zNp2h8q7LExt6xfXN8y3aWg3RkDn6+e2rGUVyz1ivRqVwZMdoWxV2ZrF8NxpAKJZhUto0
 QAfGzWBQuGy9jkXF48eBxks6WlqKd7OkbLsGe/LoIW1e0HIoJT9K66w=
X-Google-Smtp-Source: AGHT+IF8obFBZcPdzXrR6IbFQdNe2bQ05U9q7W6eVGnmY1goNIYO6BsrE2TNXdtr+FNy5a4RuFcx+w==
X-Received: by 2002:a17:902:d502:b0:220:ff93:e12e with SMTP id
 d9443c01a7336-22103efc101mr59186275ad.1.1739643167591; 
 Sat, 15 Feb 2025 10:12:47 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d559600fsm46378545ad.248.2025.02.15.10.12.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 10:12:47 -0800 (PST)
Message-ID: <ab3f9d89-c21b-420d-9c81-6cb9dac70777@linaro.org>
Date: Sat, 15 Feb 2025 10:12:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/rx: Allow execution without either bios or kernel
To: qemu-devel@nongnu.org
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-2-keithp@keithp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250215021654.1786679-2-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/14/25 18:16, Keith Packard via wrote:
> Users can use -device loader to get an ELF file loaded to
> memory, so we don't need to require one of these options.
> 
> Signed-off-by: Keith Packard<keithp@keithp.com>
> ---
>   hw/rx/rx-gdbsim.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

