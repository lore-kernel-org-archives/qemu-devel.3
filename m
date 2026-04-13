Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93218E93805
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 03:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC7hJ-0002YS-Ih; Sun, 12 Apr 2026 23:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7hB-0002Ue-14
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:10:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7h8-0000sx-QY
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:10:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b2494440f3so12941195ad.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776049837; x=1776654637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdhSIse2soKursAdJjmWecwFzqSOmdWCQ6ry2TyOSSY=;
 b=LV4+jHvLmSarQprs0NTcDs3awGTAdTXptjIBxpJXLdRwXbysfPIMC+iqYMCrbqLQAH
 OFQqv9DAtAqWVPYltmOHWThpklyCfahw2Tb8cLdwic5t6c1DIT+GjtF2bGwElQ1pwzyu
 brBOdHFAyFAzlHlHoKzd848YTjR+UmxKoQBWSY7lin7viAKqLuZwfQ42aI/uLCXFM4NY
 V0lqt56F49gkgGETcFc57ZIWUk5V8j+v75gKW0Z65jKTVTScqQSe1n5lma3LBD0r/8AY
 voIBdz+IpfPVKwDyI3pWpe5Ddbc0lrd2rFAm3NPW9vQgdpQlpACg/BU2OJREoEMHIcyB
 pNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776049837; x=1776654637;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdhSIse2soKursAdJjmWecwFzqSOmdWCQ6ry2TyOSSY=;
 b=EsdUUzXbLKPCSdoXPkeeFKz9THmX98CkPzEmqcRZ4+nmUWWJJBJXXM3v7ubUTr07i4
 /851njO0P1m/uAAxbbEWHnCmbPRoz02nquF46KIsODEagiTFGaHRWuQpCnsW5KxafwKn
 YQnKLdUrcCosrvlTnv18lILRXCZsgFcTpRMGqu+XNLciqHltnyJdKSBYLLhR9+WD64au
 Wlb7mlcS7wlXML9IBN9+9rl5zYAg9P04LTLSKaXov3iZ+A1oPuXDD05RGntPexcES9QQ
 /9D7JFG5x6Z8edVyrTr6f7lY5h147vo4u8yKuVoRP7sL1w8aP4+LZOnr0/o40q7LxE5Z
 fByQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9U0Mvb1pjEPjez4BOZU9JciLe8n1bgOmioiny7tmpLZ2WnxPOYNuLBwA7qBvx0H2n3AQ/W8EMeIAwf@nongnu.org
X-Gm-Message-State: AOJu0Yw96RO29eVM8CZCBO50HPxRUiYcAJKu7fI7W4xLozLN/Lb38IE8
 xp3AVxsaxbeb899SaXeJdQ3Dz7er+Un/UIjgrXeCrQxL9hqaIKmDBKEh3Xwc/xxZrFc=
X-Gm-Gg: AeBDievUCYwmfWaF6aVJX9nfSXWaeYmFjrylq5OPlbXrw3Zr1YhxioTY8VLWt9MhDc8
 DSiU818zyUDU9zTgymz3bIvDaM/yhn9HrGGBOBt225Cs4PHgpYec/2c2o16W6mF+NDCgEWwphcN
 uUtSUPyL1ma6V8x7qYpexPzDiwlnUXNvzMEq/m/Pu29gVWR/V2Vg41DvlwqBaPmBWUaniphbNgp
 FNXrBQkMoZIJcLbs4j3eylkDFkcZ5YuK6yDySTtmbmXhPfMWXNH9aqviWtQrjp6GoSpEDt0aHAg
 QjZOdbelwawoKgv+8ONWRNlWyTElk+4JyjVA/pSIBVd1zGgTytYAbMytX4y7+EcGU9wvOZVe+O6
 YoVqD7QAZ17w1VIAHc/NtbN44NtcbS/jTrJp8QtxZZ7jaH3WD5PCvorkWnpIYcPjicb2E126yXz
 wA6ttw2Zopt5aw8SOLf4lxO8RRLt+JVkTLEM7ajC8/jlkaWmG0dkzglG3piboFJWVvPjn1JvzLA
 h+fRoQI2pyPVw==
X-Received: by 2002:a17:903:3c2f:b0:2b2:90f3:d774 with SMTP id
 d9443c01a7336-2b2d5938b4fmr114072035ad.2.1776049837082; 
 Sun, 12 Apr 2026 20:10:37 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f3ab3dsm103442415ad.74.2026.04.12.20.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 20:10:36 -0700 (PDT)
Message-ID: <8f06d37b-111e-4255-8830-b63e5c8b143b@linaro.org>
Date: Mon, 13 Apr 2026 13:10:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/27] monitor: Forward-declare the MonitorDef type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> Rather than having core header forced to include "monitor/hmp.h"
> to get the MonitorDef type declaration, forward-declare it in
> "qemu/typedefs.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/monitor/hmp.h   | 6 +++---
>   include/qemu/typedefs.h | 1 +
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

