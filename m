Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22DFEA71A3
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEUjw-0006mj-VC; Sun, 19 Apr 2026 12:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEUjq-0006ja-6s
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 12:11:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEUjo-0008Ei-4G
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 12:11:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so1355086f8f.3
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776615070; x=1777219870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xPkmu94sCymbMXXa0bHCC/HhTEmKswW/grC4BA01Idw=;
 b=SCvb9RgKUEQpYOQTF1olZDTsav/Ne4TkrieZS715tWfu57nqilJ8HuGFvEwQXcM1l3
 Uc+LPTmIOq5TCSReNLuk8+vww91mejS80GWTN4+qj76ogtMKmqPRnxQQ3i308/Wk1mdr
 ImtsDqZZ0qn3WHkmYQROAwbVL1rHOQzQnHONAg2IWqBnyBQDReY+9L6wtLrn+DjnkFPA
 oQi2iBtQrzF9vizfrF8CwG0zAxhsB+3k6ekIC9qSeVGjmFAbt4jBujZQqX7GiFiBaX/F
 pMDnljZi+yDNgCKmkeV682L9qXWjuk5he0VP6DvNabfVAiwgcywMjCcK/FPzpaFEQ2Zv
 AkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615070; x=1777219870;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xPkmu94sCymbMXXa0bHCC/HhTEmKswW/grC4BA01Idw=;
 b=A0DsCvt86GiaMWh1eQ3O7/Q+fAyxw+3FznKrTXb+OOnYI+E8Qvp2sb42+o/Ud+yGEw
 20qLPNXPsoYdN3AFvWI1IPMXNKM7/rHu7tVoeMqrnQQtkiAHO0UgP/TY0dHPv0FOLMHO
 BHXjzY/n8IoFUgOOV5PAGcdiVOfuyVb0D9b0pd93eTtDQb26SusEiYZOPN6JzET9TNQg
 zi4c4+FyuAKcyZUqK9LszzTvqQwanGETlfLjoUi7qUPZPgVl/GOjdbV6AvoPlIIavoom
 gGJb27EhAUYVpXsrlVeiuOsOVp2qxB6vmJ9wsPJGxQRKgRVdLeKMI+tr7q0m3XRtF5mO
 CzPw==
X-Gm-Message-State: AOJu0Yx92sHxegvLZ7C/4KoU5faGN0dwxc+K6T29RFTGnsz7icXuUOhN
 Z8UYVco9tSd/eFZ0C83cwxyvUZcvYL+4dFZchKPhgGDXqyMwfyKRfJU3/ZHYWBlAmESElW5UtU2
 6el+Dglw=
X-Gm-Gg: AeBDiev8IzYCNdjsI/yNigKPmYSR6zig0vzwyGJMXQQA4DgYCUlH+SKK3l+O+6Zu4Rz
 qzdo/b6RNACEx7zXnDAYW0sm+X+lPVErVFKrl7OR0jXIqNAAkeD3S5sQlnddPf8yYcyY5Jabr/3
 o2DLt2U9n3YfOQoIzb4aYmJUb8HIg22tzFHQ5TVamcVKlF3XWQjOEXip02tR8ZpDEeqiMC6j6Ag
 cpMQnp2/FQbdNYfOr1H/S63wSAVheNVIgfE4wYAUEJosQvw9hTWS8Phe7EtBlFziDxbybOY07fc
 kOcLak8vHSB3j8+AmtOmY+G6pDkO/BsBvFISaza517dDB4egjNMniCN5Z6xlM7/jGviEj9uyv/g
 59gSNdJqq7nQawGCB+Yk2wVBnW7ncHAUZdCAW9U/kRHi0nZduvXSqGUktkm1av9w/1roNwp/6YP
 kJHUYNMkJSqrHIyXJghIPUMA+97WuCfjrWBZDE0NfHN14UCmg1TI5yf7nye+cNK6len6guAFGJp
 GY4
X-Received: by 2002:a5d:46ce:0:b0:43f:dd40:bbc8 with SMTP id
 ffacd0b85a97d-43fe3dfbd25mr10949699f8f.24.1776615069798; 
 Sun, 19 Apr 2026 09:11:09 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm24738249f8f.37.2026.04.19.09.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 09:11:09 -0700 (PDT)
Message-ID: <edd3754c-c70b-4ad4-adae-c685dd6a9e56@linaro.org>
Date: Sun, 19 Apr 2026 18:11:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] target/ppc: Forbid to use legacy ldst_phys() API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260319111936.68041-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping?

On 19/3/26 12:19, Philippe Mathieu-Daudé wrote:
> Replace legacy ld/st_phys() by address_space_ld/st()
> then lock the target again further legacy API uses.
> 
> Philippe Mathieu-Daudé (8):
>    hw/ppc/spapr: Un-inline rtas_load/store() helpers
>    target/ppc: Factor common ppc_load_epr() helper out
>    target/ppc/mmu: Remove unused hash32_store_hpte() helpers
>    target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
>    target/ppc/mmu: Replace legacy ld/st_phys() -> address_space_ld/st()
>    hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
>    hw/ppc/pegasos: Replace legacy ld/st_phys() -> address_space_ld/st()
>    configs/targets: Restrict the legacy ldst_phys() API on PPC


