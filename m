Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AB7C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 21:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyH9D-0001B1-Vw; Fri, 28 Mar 2025 17:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyH9C-0001Ah-Rm
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 17:21:50 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyH9A-0001NS-VD
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 17:21:50 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c7f876b321so767651fac.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743196907; x=1743801707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FbWTsB38cC3vbScN7xJ8p0MSXi5Hk7sju0R2GzgMBew=;
 b=I3qbtb7+JZFYnZxh1ZV2pOHdfAt5MAbP/IylzJWs+Oh+DbxAdswsDDggQLJmXM7d09
 4ISAv5rxw7jXb2Ub9FKPeZtliPtH9Ix4hRKyQOY5YuqvXNWREhUUZPcBh+hryPGMgeKw
 V0drk+v/3P3ILT+Vn2kezZ0VV50C9ochq4FO6B97qMIbaZKImyDnvzqsd0TFcCCWotUS
 Rx3Zi4jzUsacj8TIhOmWbnfuY3Rolxo/p6kGY7WNpbhXWxCo1D6yKv4vF7fJ9q+x3vG7
 wqSKLzt0/DqCiLqiOlzQ47DBTCWR1smmSvWTGeWMGEOLqoBUwTWsx4TAxbdhEo6GH4wO
 pQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743196907; x=1743801707;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FbWTsB38cC3vbScN7xJ8p0MSXi5Hk7sju0R2GzgMBew=;
 b=r1+CW/GTUSNrHe5/c9RpAhimUODpD0x7WHhRhueH/n7ujOfZ0FrWybY2myRHUQutNh
 Dh/W62//gSPsGnOrRWA67sjxWjPZsjh6jR6YTmKHQX9MxfCeAyvJXSJJTXqdZnVPFSRw
 j5yge4T2KSFFRUagjN2NKP90hbFhD+obrYMyEJSQyzYYhpnqoRUO1yRASJzyX/A2uAFo
 r2ozaSJG+JQTcf60XYkPf/57H8cGmEmNtLDZUqp9VJFBMHS54eXwGYeYa/R91DP1FAPw
 MSyuk+qAUp2M2VzhkE6/qL/TyxP+fj2CsKBJKTdJ9Y1ndAL6SgPdHfiPPvDzSGxLWxQR
 qSZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtLXGhJlljR2jJn7JlZnFax8MiH6spSdrompZm90rPO4CEjuIztEqiAltFd1rce43JMkLcSYMOlsK6@nongnu.org
X-Gm-Message-State: AOJu0YwfpvnSFK6jOLh3h+DTBKyTSusZ+K8rdDPaWwd11PPGnPB+pc0T
 N4CoOH/DRO8zuAdnDP8HAztZHKlioaZIUU7W1A6PyoxUPakxEwXpWWOSt/9Doms=
X-Gm-Gg: ASbGnctNVFb6rc+v+mXDqZlpxgQxfapkpQlmWAJto+k6j0E5rMUuKJJdk4Tbu9ytim4
 FFLk3CPYICKELrs+kJfgtmwQBQ6SUBRkOazLjGD/q1ygssaIkQCiV3rv1c2VJ0Ou7GGInk/tRNw
 x2UAprGMNkjg+0strF+nQZ6xZ8t1lYliNQS19uCAzDF8PR+BVxhQD8eQBZsuLf67qm5+jgIqa67
 PzzubnUFGOOpBl2haYwQeOEdf6NkwoHECIxacVrIlKmQyYxGXvNQvkqAIRbdR01+qunZVFShvWC
 yZxK/QQBdRkxKackF/dpyq+gGBYFEgufKz3st6J/moV7l6LJWieME6QX1By54+M77o0DuQZZR+0
 /H0ixOjRK3Ym4hbWUWuDBoQ==
X-Google-Smtp-Source: AGHT+IGUKtVD+RpF4qqxsCVCJCNB/nWOy/I6q8J+Yi3XzOq6RRJCQKn4OUMaAfUjY5qWsTE4HL1M1g==
X-Received: by 2002:a05:6870:3314:b0:2c7:b970:34d0 with SMTP id
 586e51a60fabf-2cbcf501aa8mr592215fac.9.1743196906869; 
 Fri, 28 Mar 2025 14:21:46 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a51d871sm605181fac.23.2025.03.28.14.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 14:21:46 -0700 (PDT)
Message-ID: <f08c868d-3313-4f67-b362-7be4b40a545c@linaro.org>
Date: Fri, 28 Mar 2025 16:21:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] page-vary: Restrict scope of TARGET_PAGE_BITS_MIN
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-10-richard.henderson@linaro.org>
 <4c16b4e5-c5b1-4c1e-9d5b-c94bafd0a6c9@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4c16b4e5-c5b1-4c1e-9d5b-c94bafd0a6c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 3/28/25 15:38, Pierrick Bouvier wrote:
> Any chance we would rename TARGET_PAGE_BITS__MIN? (MIN_ALL? ALL_MIN? ARCH_MIN? any other 
> idea)
> I know it's restricted to this file only, but the __ is surprising.

I could drop the poisoning.  Since there have only ever been two targets using 
TARGET_PAGE_BITS_VARY, it's unlikely creep back in unawares.


r~

