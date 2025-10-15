Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42089CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95q0-0004J2-IF; Wed, 15 Oct 2025 14:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v95pu-0004CN-4O
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:02:57 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v95pk-0006NF-OT
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:02:52 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b62e7221351so5661259a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551358; x=1761156158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pJ+tS88P2l7ubRoTtwd6S4wb7ZljHAgI2KerAXQQKmU=;
 b=igQrr5A7KAl46uy/Xj6kZqjB0My3rHR4FtNcUkHolBW6j2RHxBg8qbODKyHc1WV1yB
 prafqtmbrSwgq3q+SIobEu27VJjQOu8A+YjH1TD8BC3Vf3+pLmN6ub/vZ73DGpKwjvSi
 mr/63ILF6XaM8hyOZaLJQNot1KD4jxg/1xk3M4dyrVUkE+ehCBy+4s7vBawYW22jLInQ
 gUr112a+78OyIV3iARqqV+86+0hgl8MMTOavPhO+R2DgCHo+7RnjXYoaJwq+A4uqzUMv
 rdcwSEji+j1LT1u9KOYdQZl5bFATfIIF3/+4UO8ur2mYpANSsrk7j9mObQFCzB765OFO
 gxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551358; x=1761156158;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pJ+tS88P2l7ubRoTtwd6S4wb7ZljHAgI2KerAXQQKmU=;
 b=Tee+mB9rddH01FGHnbF3qFoDCWeA7uUepwK38UqGGw3QOelsEDA0l/DXHgZbVDNeS2
 cWj3AMnKFB49nqM8MiHTYaVh593JCr7AgE+AL11iV/+FEp4co8MOjdzTQRoututPy4VV
 HDX5gWlmEYnyx9+dToLIU0Z+3HUeggteIiziBmYToD48HHGJdCBMT0HB9VMUheKhL9JS
 dPC2REBbgPyaB7JfAzadkFluYf1+j4AA/tKd/cgZLNFQd7aTx/bQb5d4benUjoEKqGfX
 tWw/9xDRGIm/8nzWxgqPmLsdYKbyNkHHuxrgwtsAq4CjC4RUzZgSPsBAAGquzUFxY9W5
 vHAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxijYptwh5vHryQoK/5+p7XvJJ2tvRuHpxrbwuZ28xlcKj2d6YSdeHCvGMeVLTJRdHmzUPuCvG4Mgx@nongnu.org
X-Gm-Message-State: AOJu0YwC6bHB7kvpsPgpw+lEvCOzH4zeQ+onMV+BU10lKILY6MC+CClB
 64AQZdDYn1wPoo42QN5PZkgKM8HP2xRYxJmtUVBWEuASuyfmOjkUhGpe1wyqk2rnm50=
X-Gm-Gg: ASbGnctaSpHdlXF6FsOVljdNSNPF2ypTENq09TUH9rOnOqbFInYVPG6LoNgxd9nnqtg
 jfOGXc/mmag27KZNvqKooSrgjyTPtIUdA9bvQhQEtBKxp4/iDxwxGnquyJ0GCthdQMRTB9W5Be2
 WGmln7LUh/N7BWdv9ZI03VssbZbo+jCb+IedkK5IH/ThiMfm5s6s85c35mk5Qhr92MH2h8fDKX/
 XVIT7FfjCi9GENcQWhIOIfd5bhBuFaaSifgR+q/niQyp16TzwH7mJoRmP6+64XwltlM0ttCxCeH
 GQpiFk5efHwGNqWPmalH2l3ZjYIRZaGIqEm9LFB8ORMoqErA38eMTnBQa3ItVMEDUP/fEmkgCm6
 ZWcJVBEAj7alm3vXEhDH3Xk5qNUrThB9pTr84wCrt4tQAyci/WSevZAWmy3xdPZnOT8Dl
X-Google-Smtp-Source: AGHT+IG3vov5Pk48z4nkef16B9sj3W9nBgUcHGklkw3Zp9xoJmxml2nRYwbS+3PcXvF/FmZKor9QkQ==
X-Received: by 2002:a17:903:4b46:b0:27d:6f49:febc with SMTP id
 d9443c01a7336-290272159d1mr387377575ad.1.1760551358041; 
 Wed, 15 Oct 2025 11:02:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099310a6csm2967015ad.8.2025.10.15.11.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:02:37 -0700 (PDT)
Message-ID: <0493418f-6d47-4142-b169-fe4075c6932b@linaro.org>
Date: Wed, 15 Oct 2025 11:02:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] target/microblaze: Have compute_ldst_addr_type[ab]
 return TCG_i32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015180115.97493-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/15/25 11:01 AM, Philippe Mathieu-Daudé wrote:
> Both compute_ldst_addr_typea() and compute_ldst_addr_typeb()
> bodies use a TCG_i32, so return the same type.
> 
> Suggested-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 48 +++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


