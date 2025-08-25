Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC757CA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWiC-0007kK-MT; Mon, 25 Aug 2025 08:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqWhj-0007Y7-UT
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:53:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqWhb-0005wL-CM
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:53:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so34172215e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756126412; x=1756731212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FPp9O11Y3qhhLvaOJJ2IBuLmaOaIDBR6fcwlXUGD724=;
 b=vUsXkNtnzx7Uu69Pryoaof0uMR4YhA/wmrTKxKqqBc6jlGS/1ZdmPud+F6LRawnbdG
 h4ZnvM3CyZhvsywamUy4S+FGJpTl4/gVWAFFtL3SD+zB56Zw53SaLzmPHtHObEtMa9Ao
 MoKXtmq/x0uPFD96PKEE/92XplOXYvjNUf3dp7eAWcAzla1IJNiZ47ytA0ToX3fKhswS
 hnR0nr7l12k5DFKxnubg/QvqRmo8uFKwkyb1Qx7wDIE5Aw9t91I/6eKjv6ikUpgyeyBN
 xZ6GwmgGEyMCjF3UZKxL6Vr82zOLaKQjkvEHS84zB7BEuGBlsepZ9d6eN6fwseOJohkh
 +woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756126412; x=1756731212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPp9O11Y3qhhLvaOJJ2IBuLmaOaIDBR6fcwlXUGD724=;
 b=dnWHJFxKoF4pU5alw9n/OV6CsXsGfqXK0nYPEdxDglj6yrcvrBMo6upl8WHD18qm6H
 Boy5hEvTr4z70/csTCDW6l6p3GeYGRGw7qqA3jp/OZM6ho/hp2bqybUFCgJrusEe14DE
 juCBblJETziUtNZZ4iyrZSrrG43TKoYPBL4eO5oQB1Tw0CASVBgPOkfYWF6VPyu/K6+x
 I0Ul1D9JNbL7deHuf+NhpjYc4cM6z+fBAj/56LSXOPwDuaVcSXL4MX+Qi3hd5E0AdaM2
 TC0EwsxTEK9E4PnU5A1ThlP7uCir4cxKRNcAuJJ/UBhkETR8XI+GUtd+C+h8bLML3GIa
 JM5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvSFnfiX0NNq60q3WViNUAXuxqy53CoUjStumSdLh8fDmEB4YkN+qb91H/CVCwW1mGxWQ53rfG2+h1@nongnu.org
X-Gm-Message-State: AOJu0YxlXxJZBoBvW+sSaX7a/tVBdup4+w1P8d3zizlMr3K2BU7Zw4Mz
 HqmhcsF0v+KAhleN7wdaMAaStjDD9g72iKTj+oVQEM3XP36I+rgilFFWnMuECrW3RRI=
X-Gm-Gg: ASbGncsxmCt9PNAPRdmiok9gSsraC1Euuz2v65zqCfj1oxW1+dMfunGslfGx8T4FrGz
 RZtZqBLiSS1SPvs5ZMQm7Tv5aC5iMluIwvDeC3AclzAMRWEL3+3vEBiPrnhqIHZiFvw0Vw/5Yki
 wtrKhvRqMURC4ou8BlrESSL65bCem1zsjiqEPwaIImkS5MTmbc6trhoR5/S1QXDSKGcWIlPG6uj
 l+6Vtl64afFe+WslDgb8NCBdvlE6rUz4zGvsIrkYkGtzW94KeaBGpWXgyCzKJdm5/SP1prOpZZ5
 Nk3NQbQdQq3hmSHYpUQhRH0HqOSGS2leTTdakZGJIEjQleZqyyiyu5OUL5unFSEe1lOltRgo359
 jETG4FbznF/SO5rURnOc48I9PdKpIAlyauAwqj3OgLQrPA/mfd0/q6dAUze7gwfJODw==
X-Google-Smtp-Source: AGHT+IHwXyOyUllRvIsMJaLXEUCwlR0rkMgQ9/VDddxtgCG/OgcsrgBBzvZ9TgbWWIS58XN/x6PD0A==
X-Received: by 2002:a5d:640a:0:b0:3c6:5532:28e with SMTP id
 ffacd0b85a97d-3c655320f2cmr6418797f8f.13.1756126411820; 
 Mon, 25 Aug 2025 05:53:31 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57444963sm118147705e9.3.2025.08.25.05.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 05:53:31 -0700 (PDT)
Message-ID: <69226b06-8c4f-4efb-b4d7-281e7df428f5@linaro.org>
Date: Mon, 25 Aug 2025 14:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/microblaze: div: Break out raise_divzero()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, edgar.iglesias@amd.com
References: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
 <20250825112051.4155931-3-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250825112051.4155931-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 25/8/25 13:20, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Break out raise_divzero() and take the opportunity to rename
> and reorder function args to better match with spec and
> pseudo code.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/op_helper.c | 38 +++++++++++++++++------------------
>   target/microblaze/translate.c | 12 ++---------
>   2 files changed, 20 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

